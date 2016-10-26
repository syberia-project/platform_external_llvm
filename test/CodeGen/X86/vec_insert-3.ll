; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown -mattr=+sse2,-sse4.1 | FileCheck %s --check-prefix=X32
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+sse2,-sse4.1 | FileCheck %s --check-prefix=X64

define <2 x i64> @t1(i64 %s, <2 x i64> %tmp) nounwind {
; X32-LABEL: t1:
; X32:       # BB#0:
; X32-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; X32-NEXT:    shufps {{.*#+}} xmm1 = xmm1[0,0],xmm0[3,0]
; X32-NEXT:    shufps {{.*#+}} xmm0 = xmm0[0,1],xmm1[0,2]
; X32-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; X32-NEXT:    shufps {{.*#+}} xmm1 = xmm1[0,0],xmm0[2,0]
; X32-NEXT:    shufps {{.*#+}} xmm0 = xmm0[0,1],xmm1[2,0]
; X32-NEXT:    retl
;
; X64-LABEL: t1:
; X64:       # BB#0:
; X64-NEXT:    movd %rdi, %xmm1
; X64-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; X64-NEXT:    retq
  %tmp1 = insertelement <2 x i64> %tmp, i64 %s, i32 1
  ret <2 x i64> %tmp1
}
