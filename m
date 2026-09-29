Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E74FD289
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681170; cv=none; b=ixumrEW3pHFUgyVTCzuCVBTaD59FQfV/vepuyRGlA0dy1z6c4bRc6IiQfCbLroO+ghRlUeOZwZeVHfKCIGvUHb6ZZeKJCybc/Gh7/vDUczkRfrykYT5urAtpyOf3VYcRSx2ijzF0rakDUa5aBea+HMmXJEu4/u9VZBjJYKFoEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681170; c=relaxed/simple;
	bh=T900O0o0n6lh1UWV2UVXzKWnP9hR+BAvTnM2kBOuR/w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icKhE69vzSM0rxw+qtCyiYkT7eHCe50mITMjzpPgwCwGtQ/+S+GFbJ/9zOwsxjng7BzCYv1FD6S3yQJRtw8LhEdET0twNC+s3a188UcCQJUG7zlK2FKknBd+MLXbALBJIfp1r5DEJrZBGHFRMGiiRgdM5WVNQvCbPkL9uJORVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net; spf=pass smtp.mailfrom=gitbutler.net; dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b=pAUsLIsn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E8v4nKM8; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b="pAUsLIsn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E8v4nKM8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D6B231D000FA
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 07:26:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 29 Sep 2026 07:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gitbutler.net;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790681167; x=
	1790767567; bh=TbQVnQ0G73JGbbG+YQEBUT88uIniwt/ONvt55x86shs=; b=p
	AUsLIsnvr5HNR5EmVZ6wO4ByoRviVc0zTeU+MaLDUdbDdfX3bxoINeWkZNimpaow
	h0dMZhpNQ/g7/OAj42lC9ggXVcloLelzosAO3rZoAPaok4ojqKR/RCWJ1F1CJII8
	MX98jbidwf9LprIlNnnPMhdrIQLwq5HtGBC3fQIfZPujTjOYpoF3MD+0AVMhbtch
	ZDOgiKyAtPymXkMKnWbG8VqoeQl6iYAM13jLZW1abjWzemThoUakcbfmvn2ucFnQ
	9+6GiQG950l0J0u0vUuouQOiMIm7AP5/WH2XHGOw36PQluKzfFaZ3sRdQnYGqPAU
	vpnRAutg6uZ8es6TUq5Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790681167; x=1790767567; bh=TbQVnQ0G73JGbbG+YQEBUT88uIni
	wt/ONvt55x86shs=; b=E8v4nKM8vStvU3rpZyMm/QeCd/ByQFarNc70WgQ2g/tG
	2e0MiS56cXE0UYeOxrAdDSJHqkn++a318kUKj08OcpSwH3BchHDew+Au/njfw+qI
	p6a5aBQ7AO3Cguxtu2igt6Fbs3sjukRhaWpGDSPElHYguWz3UYLdvhDFYKTpMBEc
	sq2Pmeb8nP7osWP/idIQWV/+maw3DDi4XTucsUPU5hSLfsUt05N4sLXLXJo9gxUP
	GNAYBLy7vD7F42p7tUnzVDp9U/emR+8rRRs3LZZvwrdKDK9js222DsgBEyN13+Xw
	ZDDWybl/VdgbSX69/6rPBura9/8ySUrEoucNMaTNcw==
X-ME-Sender: <xms:T6C7almXzyRDEDz2oFvA4vWHCIDqRM6xAs9amNCkF7__a4wNPoYSTA>
    <xme:T6C7anx7CYnIky1ovtcrOk8taLg5rKQuqFYUu7jkShnIvqTp66Pd0c22Thpr2dcpC
    Osdt6LSQcZ-ReaiJiD6hwH25oqqgjRKoUda9x21d_tDd5v8ZW5uhPbw>
X-ME-Received: <xmr:T6C7ahRnbbipF1JM3JniifOmz0RppJ31n3RAgdkcJh_zALeP4y_phbs8NLSuCAu7mu-bPg>
X-ME-Proxy-Cause: dmFkZTGab3AY+9SPB1P2lqt8Is1pW81NkovnKn2Fq8SD4TuwT8o3kSDEh/4bPYMYZbuYYa
    /Lnzn1DPpWUGVxE/UXh66uVAVY6rVwHZXn9RuV+YEk7SYoCRVfSie+fjwy2I3/cRVEdL1l
    JbzM3swi1/Zg/QA68AcoIULuMFkn0Yz0zi/wR6t4dQShu5ZvlKlFZmUBcgXo2bsfwIQZ9t
    syzNYA4mVufVB7MHxrE8kRcLiDqZnUkzBB6SEm4Qsw2QJ70tgrkKQ2a8gwqPkTUZ1uLahY
    VcQSLG1OJ/NS31QpPA75PI0i2p0jU3KiFSpku82r5m3POV6SuFl+mVrKBv0OAUyW+ZJuYP
    kWYiS6Afz6qaE2xpz3Rntu3HBfEfvQug+pbvB6FFoskXkakzQpaBA7TZhLsox9GR/5P70H
    SoEuS0hgf52j8CmM91WsEpUYDEx8YnP+jZm+DlZU5YuUJ+0OZ4wpR4GRddj4bFNgsqPo3/
    pZLQidt6iZW6+KyBJKTLAoOXDIV5oIwGX/yM5HWddUidf9M6PNoWDmj3Q73OVTTZhAH3LP
    r4WimXYB2mGcFS1Fqz2eOi1wHOehhrr88x+NhgcYyPiL013NqbVQ1cLWD59mNxZPtXDVaF
    yk5Sfd6NLMGo/EIHycQSrykjzlrsbsQR+FZXndEb6v5YsQ8YxmAc6f5a098g
X-ME-Proxy: <xmx:T6C7aqtcFphP7ulHX8m7E811rJU50IIgFUKdjoD4tnoduv5TVN3WUw>
    <xmx:T6C7ajsMkDEHxeMvIr3mWel30DL5Vhz-Dt48i-_I6ajFVaS-aoJuKQ>
    <xmx:T6C7agwkYbfE7xmRIaafyEKx7q5c7l-5_9tkyfwNhLE10qS2Bio3IA>
    <xmx:T6C7apgqzgxTDMAchAL-x46yX7mu2gaJfBuYUnpDEhhY-bcNjQzaYA>
    <xmx:T6C7at0s10kaUPOkwzfERECgU_Ko7X0VsyHCP6CkygCqUjc4WhCuPqHs>
Feedback-ID: iecfe4abb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 29 Sep 2026 07:26:04 -0400 (EDT)
From: Scott Chacon <scott@gitbutler.net>
To: git@vger.kernel.org
Subject: [PATCH 4/4] sha1dc-accel: compress with the ARMv8 SHA-1 instructions
Date: Tue, 29 Sep 2026 13:25:44 +0200
Message-ID: <20260929112544.86511-5-scott@gitbutler.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929112544.86511-1-scott@gitbutler.net>
References: <20260929112544.86511-1-scott@gitbutler.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most arm64 CPUs, including Apple's and the Graviton line, have SHA-1
instructions, too, and we can use them the same way as SHA-NI in the
previous patch. It's a little simpler here: the instructions keep the
working state in the natural order, and vsha1h gives us the fifth word
directly, so there's no shuffling to be done.

Knowing whether we can use them is a little trickier:

  - If the compiler targets them already (__ARM_FEATURE_SHA2 or
    __ARM_FEATURE_CRYPTO, which is the case with Apple's clang on
    macOS), we just use them.

  - Otherwise we build the two functions that need them with a target
    attribute, and check at run time. On Linux that's getauxval(); on
    other platforms we don't know how to ask yet, and so don't use them.

  - Older compilers only declare the intrinsics when the whole file
    targets the instructions, so a target attribute doesn't help there.
    We only try the attribute with GCC 9+ and clang 17+.

The one new backend, armv8+neon, goes to the front of the list.

On an Apple M5 Max (macOS, Apple clang), which picks armv8+neon, hashing
1GiB of random data with "test-tool sha1" (median of 9 runs) goes:

  sha1dc, before this series        1.46s   (~700 MiB/s)
  block loop, after 1/4             1.55s
  portable+neon, after 2/4          1.22s
  armv8+neon, this patch            0.51s   (~2 GiB/s)

which is 2.85x overall. For index-pack of the 319MB pack of a clone of
git.git, it goes from 16.1s to 8.7s single-threaded (1.86x), and from
6.7s to 5.9s with all 18 threads. The full test suite passes there, too.
For comparison, the crate reports 81% of plain SHA-1's throughput on an
Apple M4 and 80% on a Graviton4, up from 29% [1].

The run-time check on Linux is only tested under qemu-user so far,
built with GCC 13 and clang 18, in a harness that compares every backend
and UBC form against sha1dc/ (the same comparisons as the unit tests).
I'd be happy to see numbers from anybody with a Graviton or similar
machine.

[1] https://sam.dev/blog/faster-sha1-collision-detection

Signed-off-by: Scott Chacon <scott@gitbutler.net>
Assisted-by: Claude Opus 5.5 <noreply@anthropic.com>
---
 Makefile                            |   1 +
 contrib/buildsystems/CMakeLists.txt |   2 +-
 meson.build                         |   1 +
 sha1dc-accel/arm.c                  | 274 ++++++++++++++++++++++++++++
 sha1dc-accel/internal.h             |  28 ++-
 sha1dc-accel/sha1.c                 |   6 +-
 t/unit-tests/u-sha1dc.c             |   9 +-
 7 files changed, 316 insertions(+), 5 deletions(-)
 create mode 100644 sha1dc-accel/arm.c

diff --git a/Makefile b/Makefile
index 8181ea5692..731a5f60e8 100644
--- a/Makefile
+++ b/Makefile
@@ -2177,6 +2177,7 @@ endif
 ifdef DC_SHA1_NO_ACCEL
 	BASIC_CFLAGS += -DDC_SHA1_NO_ACCEL
 else
+	LIB_OBJS += sha1dc-accel/arm.o
 	LIB_OBJS += sha1dc-accel/sha1.o
 	LIB_OBJS += sha1dc-accel/ubc_check.o
 	LIB_OBJS += sha1dc-accel/x86.o
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 67b96d601b..37ebb67a8d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -218,7 +218,7 @@ add_compile_definitions(NO_OPENSSL SHA1_DC SHA1DC_NO_STANDARD_INCLUDES
 			SHA1DC_INIT_SAFE_HASH_DEFAULT=0
 			SHA1DC_CUSTOM_INCLUDE_SHA1_C="git-compat-util.h"
 			SHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="git-compat-util.h" )
-list(APPEND compat_SOURCES sha1dc_git.c sha1dc/sha1.c sha1dc/ubc_check.c sha1dc-accel/sha1.c sha1dc-accel/ubc_check.c sha1dc-accel/x86.c block-sha1/sha1.c sha256/block/sha256.c compat/qsort_s.c)
+list(APPEND compat_SOURCES sha1dc_git.c sha1dc/sha1.c sha1dc/ubc_check.c sha1dc-accel/arm.c sha1dc-accel/sha1.c sha1dc-accel/ubc_check.c sha1dc-accel/x86.c block-sha1/sha1.c sha256/block/sha256.c compat/qsort_s.c)
 
 
 add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
diff --git a/meson.build b/meson.build
index 47a60526e9..7aed4db1ba 100644
--- a/meson.build
+++ b/meson.build
@@ -1631,6 +1631,7 @@ if sha1_backend == 'sha1dc'
     'sha1dc_git.c',
     'sha1dc/sha1.c',
     'sha1dc/ubc_check.c',
+    'sha1dc-accel/arm.c',
     'sha1dc-accel/sha1.c',
     'sha1dc-accel/ubc_check.c',
     'sha1dc-accel/x86.c',
diff --git a/sha1dc-accel/arm.c b/sha1dc-accel/arm.c
new file mode 100644
index 0000000000..0d18354e56
--- /dev/null
+++ b/sha1dc-accel/arm.c
@@ -0,0 +1,274 @@
+/*
+ * The SHA-1 compression and recompression on the ARMv8 SHA-1 instructions,
+ * for sha1.c. `vsha1{c,p,m}q_u32` do four steps at a time on `abcd`, with
+ * the fifth working word carried apart and derived by `vsha1h_u32`.
+ */
+
+#include "../git-compat-util.h"
+#include "internal.h"
+
+#ifdef SHA1DC_HAVE_ARMV8
+
+#if !defined(__ARM_FEATURE_SHA2) && !defined(__ARM_FEATURE_CRYPTO) && \
+	defined(__linux__)
+#include <sys/auxv.h>
+#ifndef HWCAP_SHA1
+#define HWCAP_SHA1 (1 << 5)
+#endif
+#endif
+
+int sha1dc_armv8_available(void)
+{
+#if defined(__ARM_FEATURE_SHA2) || defined(__ARM_FEATURE_CRYPTO) || \
+	defined(__APPLE__)
+	return 1;
+#elif defined(__linux__)
+	return !!(getauxval(AT_HWCAP) & HWCAP_SHA1);
+#else
+	return 0;
+#endif
+}
+
+#define K0 0x5A827999
+#define K1 0x6ED9EBA1
+#define K2 0x8F1BBCDC
+#define K3 0xCA62C1D6
+
+/* Big-endian message words t..t+3. */
+#define MSG(t) vreinterpretq_u32_u8(vrev32q_u8(vld1q_u8(block + 4 * (t))))
+
+/*
+ * Four steps of a compression that keeps the schedule four groups ahead:
+ * `f` the round instruction, `e` the fifth word in, `next` where the one
+ * for the next group goes, `wk` the schedule words plus the constant.
+ */
+#define QUAD(f, e, next, wk) \
+	do { \
+		next = vsha1h_u32(vgetq_lane_u32(abcd, 0)); \
+		abcd = f(abcd, e, wk); \
+	} while (0)
+
+SHA1DC_TARGET_ARMV8
+void sha1dc_compress_armv8(uint32_t ihv[5], const unsigned char *block,
+			   uint32_t w[80], uint32_t at_60[5], uint32_t at_64[5])
+{
+	uint32x4_t abcd = vld1q_u32(ihv);
+	const uint32x4_t abcd_in = abcd;
+	uint32_t e0 = ihv[4], e1;
+	const uint32_t e_in = e0;
+	const uint32x4_t k0 = vdupq_n_u32(K0), k1 = vdupq_n_u32(K1);
+	const uint32x4_t k2 = vdupq_n_u32(K2), k3 = vdupq_n_u32(K3);
+	uint32x4_t msg0 = MSG(0), msg1 = MSG(4), msg2 = MSG(8), msg3 = MSG(12);
+	uint32x4_t tmp0, tmp1;
+
+	vst1q_u32(w + 0, msg0);
+	vst1q_u32(w + 4, msg1);
+	vst1q_u32(w + 8, msg2);
+	vst1q_u32(w + 12, msg3);
+
+	tmp0 = vaddq_u32(msg0, k0);
+	tmp1 = vaddq_u32(msg1, k0);
+
+	/* Steps 0-3 */
+	QUAD(vsha1cq_u32, e0, e1, tmp0);
+	tmp0 = vaddq_u32(msg2, k0);
+	msg0 = vsha1su0q_u32(msg0, msg1, msg2);
+
+	/* Steps 4-7 */
+	QUAD(vsha1cq_u32, e1, e0, tmp1);
+	tmp1 = vaddq_u32(msg3, k0);
+	msg0 = vsha1su1q_u32(msg0, msg3);
+	vst1q_u32(w + 16, msg0);
+	msg1 = vsha1su0q_u32(msg1, msg2, msg3);
+
+	/* Steps 8-11 */
+	QUAD(vsha1cq_u32, e0, e1, tmp0);
+	tmp0 = vaddq_u32(msg0, k0);
+	msg1 = vsha1su1q_u32(msg1, msg0);
+	vst1q_u32(w + 20, msg1);
+	msg2 = vsha1su0q_u32(msg2, msg3, msg0);
+
+	/* Steps 12-15 */
+	QUAD(vsha1cq_u32, e1, e0, tmp1);
+	tmp1 = vaddq_u32(msg1, k1);
+	msg2 = vsha1su1q_u32(msg2, msg1);
+	vst1q_u32(w + 24, msg2);
+	msg3 = vsha1su0q_u32(msg3, msg0, msg1);
+
+	/* Steps 16-19 */
+	QUAD(vsha1cq_u32, e0, e1, tmp0);
+	tmp0 = vaddq_u32(msg2, k1);
+	msg3 = vsha1su1q_u32(msg3, msg2);
+	vst1q_u32(w + 28, msg3);
+	msg0 = vsha1su0q_u32(msg0, msg1, msg2);
+
+	/* Steps 20-23 */
+	QUAD(vsha1pq_u32, e1, e0, tmp1);
+	tmp1 = vaddq_u32(msg3, k1);
+	msg0 = vsha1su1q_u32(msg0, msg3);
+	vst1q_u32(w + 32, msg0);
+	msg1 = vsha1su0q_u32(msg1, msg2, msg3);
+
+	/* Steps 24-27 */
+	QUAD(vsha1pq_u32, e0, e1, tmp0);
+	tmp0 = vaddq_u32(msg0, k1);
+	msg1 = vsha1su1q_u32(msg1, msg0);
+	vst1q_u32(w + 36, msg1);
+	msg2 = vsha1su0q_u32(msg2, msg3, msg0);
+
+	/* Steps 28-31 */
+	QUAD(vsha1pq_u32, e1, e0, tmp1);
+	tmp1 = vaddq_u32(msg1, k1);
+	msg2 = vsha1su1q_u32(msg2, msg1);
+	vst1q_u32(w + 40, msg2);
+	msg3 = vsha1su0q_u32(msg3, msg0, msg1);
+
+	/* Steps 32-35 */
+	QUAD(vsha1pq_u32, e0, e1, tmp0);
+	tmp0 = vaddq_u32(msg2, k2);
+	msg3 = vsha1su1q_u32(msg3, msg2);
+	vst1q_u32(w + 44, msg3);
+	msg0 = vsha1su0q_u32(msg0, msg1, msg2);
+
+	/* Steps 36-39 */
+	QUAD(vsha1pq_u32, e1, e0, tmp1);
+	tmp1 = vaddq_u32(msg3, k2);
+	msg0 = vsha1su1q_u32(msg0, msg3);
+	vst1q_u32(w + 48, msg0);
+	msg1 = vsha1su0q_u32(msg1, msg2, msg3);
+
+	/* Steps 40-43 */
+	QUAD(vsha1mq_u32, e0, e1, tmp0);
+	tmp0 = vaddq_u32(msg0, k2);
+	msg1 = vsha1su1q_u32(msg1, msg0);
+	vst1q_u32(w + 52, msg1);
+	msg2 = vsha1su0q_u32(msg2, msg3, msg0);
+
+	/* Steps 44-47 */
+	QUAD(vsha1mq_u32, e1, e0, tmp1);
+	tmp1 = vaddq_u32(msg1, k2);
+	msg2 = vsha1su1q_u32(msg2, msg1);
+	vst1q_u32(w + 56, msg2);
+	msg3 = vsha1su0q_u32(msg3, msg0, msg1);
+
+	/* Steps 48-51 */
+	QUAD(vsha1mq_u32, e0, e1, tmp0);
+	tmp0 = vaddq_u32(msg2, k2);
+	msg3 = vsha1su1q_u32(msg3, msg2);
+	vst1q_u32(w + 60, msg3);
+	msg0 = vsha1su0q_u32(msg0, msg1, msg2);
+
+	/* Steps 52-55 */
+	QUAD(vsha1mq_u32, e1, e0, tmp1);
+	tmp1 = vaddq_u32(msg3, k3);
+	msg0 = vsha1su1q_u32(msg0, msg3);
+	vst1q_u32(w + 64, msg0);
+	msg1 = vsha1su0q_u32(msg1, msg2, msg3);
+
+	/* Steps 56-59 */
+	QUAD(vsha1mq_u32, e0, e1, tmp0);
+	tmp0 = vaddq_u32(msg0, k3);
+	msg1 = vsha1su1q_u32(msg1, msg0);
+	vst1q_u32(w + 68, msg1);
+	msg2 = vsha1su0q_u32(msg2, msg3, msg0);
+
+	/* The state at step 60, for recompression to start from. */
+	vst1q_u32(at_60, abcd);
+	at_60[4] = e1;
+
+	/* Steps 60-63 */
+	QUAD(vsha1pq_u32, e1, e0, tmp1);
+	tmp1 = vaddq_u32(msg1, k3);
+	msg2 = vsha1su1q_u32(msg2, msg1);
+	vst1q_u32(w + 72, msg2);
+	msg3 = vsha1su0q_u32(msg3, msg0, msg1);
+
+	/* And at step 64. */
+	vst1q_u32(at_64, abcd);
+	at_64[4] = e0;
+
+	/* Steps 64-67 */
+	QUAD(vsha1pq_u32, e0, e1, tmp0);
+	tmp0 = vaddq_u32(msg2, k3);
+	msg3 = vsha1su1q_u32(msg3, msg2);
+	vst1q_u32(w + 76, msg3);
+
+	/* Steps 68-71 */
+	QUAD(vsha1pq_u32, e1, e0, tmp1);
+	tmp1 = vaddq_u32(msg3, k3);
+
+	/* Steps 72-75 */
+	QUAD(vsha1pq_u32, e0, e1, tmp0);
+
+	/* Steps 76-79 */
+	QUAD(vsha1pq_u32, e1, e0, tmp1);
+
+	vst1q_u32(ihv, vaddq_u32(abcd_in, abcd));
+	ihv[4] = e0 + e_in;
+}
+
+/* Four steps of the partner block, on schedule group `g`. */
+#define GROUP(f, k, g) \
+	do { \
+		uint32x4_t wk_ = vaddq_u32(veorq_u32(vld1q_u32(m1 + 4 * (g)), \
+						     vld1q_u32(dm + 4 * (g))), \
+					   vdupq_n_u32(k)); \
+		uint32_t next_ = vsha1h_u32(vgetq_lane_u32(abcd, 0)); \
+		abcd = f(abcd, e, wk_); \
+		e = next_; \
+	} while (0)
+
+/*
+ * Whether the partner block, whose state at `from` is `state`, ends on
+ * `ihv_out`: out from its state at step 60 or 64 to step 80, then in from
+ * the chaining value that implies, which must arrive back at that state.
+ */
+SHA1DC_TARGET_ARMV8
+int sha1dc_recompress_armv8(enum sha1dc_from from, const uint32_t m1[80],
+			    const uint32_t dm[80], const uint32_t state[5],
+			    const uint32_t ihv_out[5])
+{
+	uint32_t at[5], reached[5], e;
+	uint32x4_t abcd;
+
+	sha1dc_partner_boundary(from, m1, dm, state, at);
+	abcd = vld1q_u32(at);
+	e = at[4];
+
+	/* Out to step 80, from 60 or from 64. */
+	if (from == SHA1DC_FROM_58)
+		GROUP(vsha1pq_u32, K3, 15);
+	GROUP(vsha1pq_u32, K3, 16);
+	GROUP(vsha1pq_u32, K3, 17);
+	GROUP(vsha1pq_u32, K3, 18);
+	GROUP(vsha1pq_u32, K3, 19);
+
+	/* The only input that gives this output is the output less the state. */
+	abcd = vsubq_u32(vld1q_u32(ihv_out), abcd);
+	e = ihv_out[4] - e;
+
+	/* In from there, as far as the state the way out started from. */
+	GROUP(vsha1cq_u32, K0, 0);
+	GROUP(vsha1cq_u32, K0, 1);
+	GROUP(vsha1cq_u32, K0, 2);
+	GROUP(vsha1cq_u32, K0, 3);
+	GROUP(vsha1cq_u32, K0, 4);
+	GROUP(vsha1pq_u32, K1, 5);
+	GROUP(vsha1pq_u32, K1, 6);
+	GROUP(vsha1pq_u32, K1, 7);
+	GROUP(vsha1pq_u32, K1, 8);
+	GROUP(vsha1pq_u32, K1, 9);
+	GROUP(vsha1mq_u32, K2, 10);
+	GROUP(vsha1mq_u32, K2, 11);
+	GROUP(vsha1mq_u32, K2, 12);
+	GROUP(vsha1mq_u32, K2, 13);
+	GROUP(vsha1mq_u32, K2, 14);
+	if (from == SHA1DC_FROM_65)
+		GROUP(vsha1pq_u32, K3, 15);
+
+	vst1q_u32(reached, abcd);
+	reached[4] = e;
+	return !memcmp(reached, at, sizeof(at));
+}
+
+#endif /* SHA1DC_HAVE_ARMV8 */
diff --git a/sha1dc-accel/internal.h b/sha1dc-accel/internal.h
index a27fda19d1..a50b294b96 100644
--- a/sha1dc-accel/internal.h
+++ b/sha1dc-accel/internal.h
@@ -27,6 +27,21 @@
 # elif defined(__aarch64__) && defined(__ARM_NEON)
 #  define SHA1DC_HAVE_NEON 1
 #  include <arm_neon.h>
+/*
+ * The SHA-1 instructions, where the compiler targets them already or can
+ * enable them for one function: older compilers declare their intrinsics
+ * only when the whole file targets them.
+ */
+#  if defined(__ARM_FEATURE_SHA2) || defined(__ARM_FEATURE_CRYPTO)
+#   define SHA1DC_HAVE_ARMV8 1
+#   define SHA1DC_TARGET_ARMV8
+#  elif defined(__clang__) && __clang_major__ >= 17
+#   define SHA1DC_HAVE_ARMV8 1
+#   define SHA1DC_TARGET_ARMV8 __attribute__((target("sha2")))
+#  elif !defined(__clang__) && __GNUC__ >= 9
+#   define SHA1DC_HAVE_ARMV8 1
+#   define SHA1DC_TARGET_ARMV8 __attribute__((target("+crypto")))
+#  endif
 # endif
 #endif
 
@@ -83,11 +98,11 @@ void sha1dc_partner_boundary(enum sha1dc_from from, const uint32_t m1[80],
 			     uint32_t out[5]);
 
 /*
- * The hardware compression. It compresses one 64-byte block into `ihv`,
+ * The hardware compressions. Each compresses one 64-byte block into `ihv`,
  * writes the expanded schedule to `w`, and this block's own states at
  * steps 60 and 64 to `at_60` and `at_64`.
  *
- * Its recompression answers whether a DV candidate is really an attack,
+ * Their recompressions answer whether a DV candidate is really an attack,
  * running the partner block forwards from `state` (this block's state at
  * `from`) with the SHA-1 instructions.
  */
@@ -99,4 +114,13 @@ int sha1dc_recompress_shani(enum sha1dc_from from, const uint32_t m1[80],
 			    const uint32_t dm[80], const uint32_t state[5],
 			    const uint32_t ihv_out[5]);
 #endif
+#ifdef SHA1DC_HAVE_ARMV8
+int sha1dc_armv8_available(void);
+void sha1dc_compress_armv8(uint32_t ihv[5], const unsigned char *block,
+			   uint32_t w[80], uint32_t at_60[5], uint32_t at_64[5]);
+int sha1dc_recompress_armv8(enum sha1dc_from from, const uint32_t m1[80],
+			    const uint32_t dm[80], const uint32_t state[5],
+			    const uint32_t ihv_out[5]);
+#endif
+
 #endif /* SHA1DC_ACCEL_INTERNAL_H */
diff --git a/sha1dc-accel/sha1.c b/sha1dc-accel/sha1.c
index 2f30b207db..1f1133169b 100644
--- a/sha1dc-accel/sha1.c
+++ b/sha1dc-accel/sha1.c
@@ -8,7 +8,7 @@
  * Sam Reis (https://github.com/srijs/sha1dc), which gitoxide uses:
  *
  *  - The compression runs on the CPU's SHA-1 instructions where it has them
- *    (SHA-NI on x86-64), and
+ *    (SHA-NI on x86-64, the ARMv8 cryptography extension on arm64), and
  *    spills the expanded message schedule as it goes, which is all that
  *    detection needs from an ordinary block. The hardware keeps no
  *    intermediate states around, so the two states that recompression
@@ -264,6 +264,10 @@ static const struct backend backends[] = {
 	{ "shani+sse2", sha1dc_compress_shani, 1, sha1dc_ubc_check_sse2,
 	  sha1dc_recompress_shani, sha1dc_shani_available },
 #endif
+#ifdef SHA1DC_HAVE_ARMV8
+	{ "armv8+neon", sha1dc_compress_armv8, 1, sha1dc_ubc_check_neon,
+	  sha1dc_recompress_armv8, sha1dc_armv8_available },
+#endif
 #ifdef SHA1DC_HAVE_AVX2
 	{ "portable+avx2", compress_portable, 0, sha1dc_ubc_check_avx2, NULL,
 	  sha1dc_avx2_available },
diff --git a/t/unit-tests/u-sha1dc.c b/t/unit-tests/u-sha1dc.c
index 5948466cb9..f629f59d1d 100644
--- a/t/unit-tests/u-sha1dc.c
+++ b/t/unit-tests/u-sha1dc.c
@@ -197,7 +197,7 @@ static void ubc_forms_agree_with_sha1dc(void)
 	}
 }
 
-#ifdef SHA1DC_HAVE_SHANI
+#if defined(SHA1DC_HAVE_SHANI) || defined(SHA1DC_HAVE_ARMV8)
 
 static uint32_t rol(uint32_t x, int n)
 {
@@ -325,6 +325,13 @@ static void hardware_compression(void)
 		check_recompress(sha1dc_recompress_shani);
 		tested = 1;
 	}
+#endif
+#ifdef SHA1DC_HAVE_ARMV8
+	if (sha1dc_armv8_available()) {
+		check_compress(sha1dc_compress_armv8);
+		check_recompress(sha1dc_recompress_armv8);
+		tested = 1;
+	}
 #endif
 	if (!tested)
 		cl_skip();
-- 
2.50.1 (Apple Git-155)


