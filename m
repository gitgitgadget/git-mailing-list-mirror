Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD1515881
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681163; cv=none; b=NBjRhSPzyx4n57C5kqpaEWQgXRg6TX2ATQJGMeD8wdCFTHem99fJ6QqarTQgUFkDeXEoWI1+XYFco92VbpusWlNRxmeMGFMzL1Sbcn4RIqrCalGVqkHEGG6DkZ0Lg8KpC40X2ve1dWVX/r32ZcmBWUPFdvReKIJwNcWleR7A7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681163; c=relaxed/simple;
	bh=1+hcbpUK/MONngbdgBBqcD4eJXeAseZghc36wIMCquc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eojjFWW2P03QKRtKKxrZVVwRNEQJqtiMHgd218+YzL7Q5pK7+CY01ujLOdp1waNsMCtB9Iql4PszuEILlgOWzOTGTKrlXpi0t9wJKBs6OEe64/GoZNJ1ze7D6faCGs+ugU9sGhLl4bgDmbxyN5KO4xTa5Rf1OBOHrVPjS5AHbQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net; spf=pass smtp.mailfrom=gitbutler.net; dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b=BYz85Yao; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frLIVzPF; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b="BYz85Yao";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frLIVzPF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 825BC7A00C4
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 07:25:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 29 Sep 2026 07:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gitbutler.net;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1790681158;
	 x=1790767558; bh=xRVucyQBWWgcTqXpQjuNb3Qxh0xIopBZFYuv75iYFvk=; b=
	BYz85Yao+VqNbXpXmT03zhDcG1IZPleoE8CDvYjW8eRKlm9I1yU3GYc28jmER4GE
	itZvlTVBUmKZ9hr1EfoMitjrm2f4oapXEBMm4dubjOEX2olzWj4IP+AX3+BB77Pv
	ypbl/MN6trliwvcmdDNbXm9HYlF6Upxt1b5MqubpCi0qXRSAdMOk4vyqCUbFdu8G
	TcUOoWRtf+lhUauPFa6p7vKAKittT516AtVyUcSmC/UHE6hydNcFtFKTrL/42WBc
	r9dFZops95MpZxf71/0FDx1/8I8GjGxa6dufzK2K7xvn9KmaF9vnknMkUQcHgG/O
	X/99jKGaHx6v1VjKuCzmhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790681158; x=1790767558; bh=x
	RVucyQBWWgcTqXpQjuNb3Qxh0xIopBZFYuv75iYFvk=; b=frLIVzPF7IdFeHAPn
	To2IEiurv5MubWcTcu316jvEJdt46huYdYPGAmluQHGsARmN4+7ZjddqqIjo/KOJ
	py4J+33SG8S0WU1CjeUavOtQyb7C3fTiPg7MP0pnd3+qBCKAVu0nEBAnmfv1Omr4
	hY2Ngrjz7Rh8fiv3z7f5fFrzzZsblJXTQ0VHytiBmuHHf2vZ+baUBOymhMNQ2SdY
	6jbypPo2EoXAFCye4jHcQfTb7KUk8DYzVNPLRY5fOAou6wG6uuqWttRGgWtw3S8L
	XKw3QBnvwZOyNqDhTF8xiJ6/Q0cVYHSIwb/Jit5vR8u/m3LnxS5/NwVHUYu6lgYR
	uNQ1w==
X-ME-Sender: <xms:RqC7at1bbVtiwMUxSyUAkOAjI3kI3msaqvGCopYfz9jgwzdWJx3Pbg>
    <xme:RqC7arC_dCpr37apYT8jtE1FgXqmWpAjccjZku6CxMVfw6YD6zUJJLtNstqInOy83
    yXYlHB01q7oKoAirkkIDstR1-qMFjJxpVgjREnr8C3zQNLHGTnAz88u>
X-ME-Received: <xmr:RqC7ajgpUMqIMbWPgLBnjF6VxWRxh8UuwPa1d2cmA_0HcHO_O9B2Sy0LHhbkE8w71tqmvw>
X-ME-Proxy-Cause: dmFkZTE9kmltghFDfr4Pcq9atLw9Y1Ls3Yq2KHKMSz3wo7lvM1VkIyVOsw8gq+mapJJlGE
    c9yGgtvEPLe8mYIgxcwuodYkGuuNdK1RxlXgyQ4qHl7ISCf3z9P+nIjjHQjtEf6oJxuAVW
    L5umzAdCEXKN4Pmz9ZY46DJHSIa6DV8bbkjUgVwD1yRB33QQTOrxUVWFhbUC0R56PtYfRY
    mPMFZCpOcJWyyUB61VpvsT9AARelqLxeIF6TUw21ymdtXNqTMab0PrRICjJj9B+eDb+AR/
    WbOVkiqsyemyJs+EV8Dr3jUb4bZCK+7zN5TP1H7k82ToV9bLS9jRk7/PubpEaJKblGNSMi
    mNMxpm0YVTAm01AUFDETjGG6PJxS1IAFEZOGXcPQ9/U2igZpltVYkK1uu7rm/064Afq3eY
    Pj+pWdTy3oUF4zho6GDXJRMWLBahj1iwml1xQfIQhbsdV+6bIIPZ/TPfYJRfUmO/prKTxE
    oAOR6XsZlUCYR//oI8OSFkrqJsriCj5iccw3+glttddDJWWF5GYh1by/oFkeJw0JfzFMuW
    F7v0F7api8gMxCtTU3MSktz5RK29Un5QicmSy83eyojHHSUD4cogJPw3esIb28meyDwb0e
    2AmuC2kxQBJxrHrwoIzRVyQV4DttZrJ9VrysrAaCP7KWCeaunh1BXnDBOyJw
X-ME-Proxy: <xmx:RqC7av9dPyGyCD8P5Ym3gQJtfkXeoXWl7uI3fJlPKd2mweesmEcDWw>
    <xmx:RqC7av8Up4CmzY3zuyDry6vpeQWgbx3Xjv3Kzq_-TGFC-HRmpT9BBw>
    <xmx:RqC7aoD3vyLZGKTMF3mcoLtj1aCA3NY7OJabV4V_st2LSIh6mcco8w>
    <xmx:RqC7avxqGH3Uq2QUwgvSDIKncngb4egpRsefwL8qrOnxr7f0O-eTQQ>
    <xmx:RqC7ajErU4mYlZKSbor_oB5OBfeXgdoskUjCmC9Tz-o43hUQskZVNArV>
Feedback-ID: iecfe4abb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 29 Sep 2026 07:25:55 -0400 (EDT)
From: Scott Chacon <scott@gitbutler.net>
To: git@vger.kernel.org
Subject: [PATCH 2/4] sha1dc-accel: vectorize the unavoidable-bitconditions check
Date: Tue, 29 Sep 2026 13:25:42 +0200
Message-ID: <20260929112544.86511-3-scott@gitbutler.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929112544.86511-1-scott@gitbutler.net>
References: <20260929112544.86511-1-scott@gitbutler.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After compressing a block, sha1dc checks its expanded message schedule
against the "unavoidable bitconditions" (UBCs) of each of its 32
disturbance vectors (DVs). Each condition says that one bit of W[i]
XORed with one bit of W[j] must have a particular value if an attack
along that DV is in progress. A failed condition rules out its DVs, and
if all 32 are ruled out, which happens for about 95% of blocks, we can
skip the expensive recompression.

That makes the check a cheap filter, but it's cheap only compared to
recompressing. It's 111 scalar statements, of which 47 run for every
block, and the rest sit behind tests of whether their DVs are still
alive. On this machine it takes about half as long as the compression
itself.

The conditions for any one DV aren't a fixed list, though. They're
equations over the bits of the schedule, and equations chain: if bit A
must equal bit B, and B must equal C, then A must equal C. So each DV
really has a whole space of equivalent condition sets. The generator
that wrote sha1dc's ubc_check.c picked conditions that are shared by
many DVs, which is the right thing for scalar code. But a vector unit
can check 4 (or 8) conditions in a single pair of loads if they have the
same shape: the same distance between the two words, the same bit
positions, at consecutive values of i. That wants a different choice.

The sha1dc Rust crate has a solver that makes that choice for each
instruction set. It picks a "prefix" of vector groups that runs on every
block, sized so that it rules out as many blocks as possible for what
it costs, and leaves the remaining conditions to a scalar "tail" that
only runs for DVs the prefix left alive. Its plans work out roughly like
this (the last column is the solver's estimate for random blocks):

  form    prefix               tail   blocks reaching tail
  scalar  70 statements        86     21%
  sse2    26 groups of 4       58      9%
  avx2    16 groups of 8       44      7%
  neon    20 groups of 4       77     17%

The crate only emits Rust, so ubc_check.c carries its plans over as
tables: for each form, the conditions of its prefix (as one entry per
vector group, giving the two words, their shifts, and the bit and DVs
of each lane), and the remaining conditions of each DV for its tail.
The code that runs them is a short loop per form. We ask the compiler to
unroll the prefix loops fully, so that each table entry turns back into
immediates; without that, the forms are 2.2x to 2.4x slower with GCC
and 1.3x to 3.6x slower with clang. With it, GCC's build of the tables
runs the same number of instructions as the crate's plans written out as
straight-line code, at the same speed. The exception so far is clang 18
on x86-64, where the scalar form runs at half that speed (68ns a block
instead of 34ns), since it spills partial masks to the stack. That form
is only the fallback for CPUs without SSE2 or NEON, and Apple clang 21
does not do this.

The tables come from the crate as of commit 426b4afd. The crate is MIT
or Apache-2.0 at your option (sha1collisiondetection itself is MIT); we
use the tables under the MIT license, and the file carries its notice.
Note that the crate stores its schedule backwards on x86 (to save a
shuffle in its SHA-NI code), where we keep it in step order everywhere,
so our SSE2 and AVX2 tables list their lanes in the opposite order from
the crate's.

We now have these backends, in order of preference:

  - portable+avx2: if the CPU has AVX2 (and the OS saves the YMM
    registers, which we check with xgetbv)

  - portable+sse2: always on x86-64, where SSE2 is part of the ABI

  - portable+neon: always on arm64

  - portable: everywhere else, which still gets the new scalar form

The vector forms need target attributes and intrinsics, so for now
they're only built with GCC 5 or newer and clang. Other compilers (and
32-bit x86, where SSE2 isn't a given) get only the portable one.

With 256MB of random data again, the Xeon picks portable+avx2:

  Benchmark 1: test-tool.old sha1
    Time (mean ± σ):     801.1 ms ±  82.9 ms    [User: 750.1 ms, System: 40.3 ms]
    Range (min … max):   673.1 ms … 1006.1 ms    30 runs

  Benchmark 2: test-tool.new sha1
    Time (mean ± σ):     620.4 ms ± 111.2 ms    [User: 571.0 ms, System: 41.9 ms]
    Range (min … max):   486.4 ms … 857.2 ms    30 runs

  Summary
    test-tool.new sha1 ran
      1.29 ± 0.27 times faster than test-tool.old sha1

and callgrind counts 16% fewer instructions than before this patch. The
M5 Max picks portable+neon, and hashes 1GiB in 1.22s instead of 1.55s
(median of 9 runs), 1.27x faster.

For testing, the unit test compares every form against sha1dc's own
ubc_check(). Random schedules aren't enough, though: the prefix rules
out most of them, so the tail checks for any one DV would hardly ever
run. So for each DV, the test also generates random schedules until one
keeps that DV alive, and then compares all forms on it with each of its
2560 bits flipped in turn. That's the same approach the crate takes (and
sha1collisiondetection's own tools before it).

Outside of the test suite, I also checked every form against ubc_check()
on a million random schedules and 256 of those witnesses: built with
GCC 13 and clang 18 on x86-64, with Apple clang on arm64 (and with it
targeting x86-64, running the SSE2 form under Rosetta and the AVX2 one
translated to NEON by SIMDe), and with GCC and clang for aarch64 under
qemu.

Signed-off-by: Scott Chacon <scott@gitbutler.net>
Assisted-by: Claude Opus 5.5 <noreply@anthropic.com>
---
 Makefile                            |    5 +-
 contrib/buildsystems/CMakeLists.txt |    2 +-
 meson.build                         |    2 +
 sha1dc-accel/internal.h             |   49 +
 sha1dc-accel/sha1.c                 |   47 +-
 sha1dc-accel/ubc_check.c            | 1789 +++++++++++++++++++++++++++
 sha1dc-accel/x86.c                  |   38 +
 t/unit-tests/u-sha1dc.c             |   75 ++
 8 files changed, 1985 insertions(+), 22 deletions(-)
 create mode 100644 sha1dc-accel/ubc_check.c
 create mode 100644 sha1dc-accel/x86.c

diff --git a/Makefile b/Makefile
index 9ab13ca2ab..3ad8a7fc92 100644
--- a/Makefile
+++ b/Makefile
@@ -568,7 +568,8 @@ include shared.mak
 # submodule.
 #
 # Unless DC_SHA1_EXTERNAL is defined, the built-in code is driven by the
-# block loop in sha1dc-accel/, which gives the same results.
+# faster implementation in sha1dc-accel/, which gives the same results
+# using the CPU's vector units where it has them.
 # Define DC_SHA1_NO_ACCEL to use the sha1collisiondetection code alone.
 #
 # === SHA-256 backend ===
@@ -2177,6 +2178,8 @@ ifdef DC_SHA1_NO_ACCEL
 	BASIC_CFLAGS += -DDC_SHA1_NO_ACCEL
 else
 	LIB_OBJS += sha1dc-accel/sha1.o
+	LIB_OBJS += sha1dc-accel/ubc_check.o
+	LIB_OBJS += sha1dc-accel/x86.o
 endif
 	BASIC_CFLAGS += \
 		-DSHA1DC_NO_STANDARD_INCLUDES \
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 3c0ea2a27c..67b96d601b 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -218,7 +218,7 @@ add_compile_definitions(NO_OPENSSL SHA1_DC SHA1DC_NO_STANDARD_INCLUDES
 			SHA1DC_INIT_SAFE_HASH_DEFAULT=0
 			SHA1DC_CUSTOM_INCLUDE_SHA1_C="git-compat-util.h"
 			SHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="git-compat-util.h" )
-list(APPEND compat_SOURCES sha1dc_git.c sha1dc/sha1.c sha1dc/ubc_check.c sha1dc-accel/sha1.c block-sha1/sha1.c sha256/block/sha256.c compat/qsort_s.c)
+list(APPEND compat_SOURCES sha1dc_git.c sha1dc/sha1.c sha1dc/ubc_check.c sha1dc-accel/sha1.c sha1dc-accel/ubc_check.c sha1dc-accel/x86.c block-sha1/sha1.c sha256/block/sha256.c compat/qsort_s.c)
 
 
 add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
diff --git a/meson.build b/meson.build
index a821b85f30..47a60526e9 100644
--- a/meson.build
+++ b/meson.build
@@ -1632,6 +1632,8 @@ if sha1_backend == 'sha1dc'
     'sha1dc/sha1.c',
     'sha1dc/ubc_check.c',
     'sha1dc-accel/sha1.c',
+    'sha1dc-accel/ubc_check.c',
+    'sha1dc-accel/x86.c',
   ]
 endif
 if sha1_backend == 'CommonCrypto' or sha1_unsafe_backend == 'CommonCrypto'
diff --git a/sha1dc-accel/internal.h b/sha1dc-accel/internal.h
index bf3513a1e3..03427224da 100644
--- a/sha1dc-accel/internal.h
+++ b/sha1dc-accel/internal.h
@@ -10,10 +10,38 @@
  * A "state" is the five working words [a, b, c, d, e] before a step.
  */
 
+/*
+ * Which forms this build can have. The vector and hardware forms need
+ * GCC-compatible target attributes and intrinsics; anything else gets the
+ * portable form, which every build has.
+ */
+#if defined(__GNUC__) && !defined(SHA1DC_ACCEL_PORTABLE_ONLY)
+# if defined(__x86_64__) && (defined(__clang__) || __GNUC__ >= 5)
+#  define SHA1DC_HAVE_SSE2 1
+#  define SHA1DC_HAVE_AVX2 1
+#  include <immintrin.h>
+#  define SHA1DC_TARGET_SSE2
+#  define SHA1DC_TARGET_AVX2 __attribute__((target("avx2")))
+# elif defined(__aarch64__) && defined(__ARM_NEON)
+#  define SHA1DC_HAVE_NEON 1
+#  include <arm_neon.h>
+# endif
+#endif
+
 #if defined(__GNUC__)
 # define SHA1DC_NOINLINE __attribute__((noinline))
+# define sha1dc_ctz(x) ((unsigned)__builtin_ctz(x))
 #else
 # define SHA1DC_NOINLINE
+static inline unsigned sha1dc_ctz(uint32_t x)
+{
+	unsigned n = 0;
+	while (!(x & 1)) {
+		x >>= 1;
+		n++;
+	}
+	return n;
+}
 #endif
 
 /* The step a DV's recompression starts from. */
@@ -22,4 +50,25 @@ enum sha1dc_from {
 	SHA1DC_FROM_65 = 65
 };
 
+/*
+ * The UBC check, one form per instruction set. Each returns the same mask
+ * as ubc_check() in sha1dc/: a set bit names a DV that is still possible.
+ * See ubc_check.c.
+ */
+uint32_t sha1dc_ubc_check_scalar(const uint32_t w[80]);
+#ifdef SHA1DC_HAVE_SSE2
+uint32_t sha1dc_ubc_check_sse2(const uint32_t w[80]);
+#endif
+#ifdef SHA1DC_HAVE_AVX2
+uint32_t sha1dc_ubc_check_avx2(const uint32_t w[80]);
+#endif
+#ifdef SHA1DC_HAVE_NEON
+uint32_t sha1dc_ubc_check_neon(const uint32_t w[80]);
+#endif
+
+/* Whether the CPU (and OS) can run the AVX2 form. In x86.c. */
+#ifdef SHA1DC_HAVE_AVX2
+int sha1dc_avx2_available(void);
+#endif
+
 #endif /* SHA1DC_ACCEL_INTERNAL_H */
diff --git a/sha1dc-accel/sha1.c b/sha1dc-accel/sha1.c
index fd75289997..1b3d82b4e4 100644
--- a/sha1dc-accel/sha1.c
+++ b/sha1dc-accel/sha1.c
@@ -1,19 +1,23 @@
 /*
- * SHA-1 with collision detection.
+ * SHA-1 with collision detection, faster.
  *
  * This computes exactly what sha1dc/ computes: the SHA-1 digest of the
  * input, and whether any block of it looks like one half of a collision
  * made by one of the 32 known disturbance vectors (DVs) of Stevens and
- * Shumow. It works on sha1dc's SHA1_CTX, and uses its table of DVs, but
- * has its own block loop, which gives the following patches room to
- * follow the approach of the "sha1dc" Rust crate by Sam Reis
- * (https://github.com/srijs/sha1dc), which gitoxide uses.
+ * Shumow. It is a port to C of the approach of the "sha1dc" Rust crate by
+ * Sam Reis (https://github.com/srijs/sha1dc), which gitoxide uses:
  *
- * Each block is compressed by a "backend", which also spills the expanded
- * message schedule, and the two intermediate states that recompression
- * starts from (at steps 58 and 65). The unavoidable-bitconditions (UBC)
- * filter then rules out about 95% of blocks; the rest are recompressed,
- * once for each DV the filter could not rule out.
+ *  - The unavoidable-bitconditions (UBC) filter, which rules out about 95%
+ *    of blocks and is most of what detection costs, has one form per
+ *    instruction set (SSE2, AVX2, NEON and portable C). For each, the
+ *    crate's solver picked conditions equivalent to the published ones
+ *    that fill vector lanes well, for a prefix run on every block, and left
+ *    the rest to a scalar tail that few blocks reach. Those choices are
+ *    kept as tables, run by a short loop per form. See ubc_check.c.
+ *
+ * The compression is portable C, and spills the expanded message schedule
+ * and the two states that recompression starts from (at steps 58 and 65)
+ * as it goes.
  */
 
 #include "../git-compat-util.h"
@@ -221,18 +225,21 @@ struct backend {
 	int (*available)(void);
 };
 
-/* sha1dc's own UBC check. */
-static uint32_t ubc_check_sha1dc(const uint32_t w[80])
-{
-	uint32_t mask;
-
-	ubc_check(w, &mask);
-	return mask;
-}
-
 /* In order of preference. */
 static const struct backend backends[] = {
-	{ "portable", compress_portable, ubc_check_sha1dc, NULL },
+#ifdef SHA1DC_HAVE_AVX2
+	{ "portable+avx2", compress_portable, sha1dc_ubc_check_avx2,
+	  sha1dc_avx2_available },
+#endif
+#ifdef SHA1DC_HAVE_SSE2
+	{ "portable+sse2", compress_portable, sha1dc_ubc_check_sse2,
+	  NULL },
+#endif
+#ifdef SHA1DC_HAVE_NEON
+	{ "portable+neon", compress_portable, sha1dc_ubc_check_neon,
+	  NULL },
+#endif
+	{ "portable", compress_portable, sha1dc_ubc_check_scalar, NULL },
 };
 
 static int usable(const struct backend *be)
diff --git a/sha1dc-accel/ubc_check.c b/sha1dc-accel/ubc_check.c
new file mode 100644
index 0000000000..f95b799f9d
--- /dev/null
+++ b/sha1dc-accel/ubc_check.c
@@ -0,0 +1,1789 @@
+/*
+ * The unavoidable-bitconditions (UBC) check of SHA-1 collision detection,
+ * in one form per instruction set.
+ *
+ * Every form returns the same mask as ubc_check() in sha1dc/ubc_check.c:
+ * one bit per disturbance vector (DV) that the expanded message w[] has not
+ * ruled out. A DV is ruled out as soon as one of its bitconditions fails;
+ * each condition says that bit a of w[i] XOR bit b of w[j] equals c.
+ *
+ * Each form runs in two parts. The prefix tests a fixed set of conditions,
+ * chosen and packed into vector lanes for that instruction set, on every
+ * block; it rules out every DV for almost all blocks. The few blocks that
+ * survive it run the tail, which tests the remaining conditions of each DV
+ * still alive.
+ *
+ * The tables in this file were derived from the output of the solver in
+ * the "sha1dc" Rust crate by Sam Reis (https://github.com/srijs/sha1dc,
+ * commit 426b4afd), which picks the conditions and their packing. They are
+ * used under the MIT license:
+ *
+ *   Copyright (c) 2017 Marc Stevens (Cryptology Group, Centrum Wiskunde &
+ *   Informatica)
+ *   Copyright (c) 2017 Dan Shumow (Microsoft Research)
+ *   Copyright (c) 2026 Sam Reis
+ *
+ *   Permission is hereby granted, free of charge, to any person obtaining a
+ *   copy of this software and associated documentation files (the
+ *   "Software"), to deal in the Software without restriction, including
+ *   without limitation the rights to use, copy, modify, merge, publish,
+ *   distribute, sublicense, and/or sell copies of the Software, and to
+ *   permit persons to whom the Software is furnished to do so, subject to
+ *   the following conditions:
+ *
+ *   The above copyright notice and this permission notice shall be included
+ *   in all copies or substantial portions of the Software.
+ *
+ *   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ *   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ *   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ *   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ *   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ *   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ *   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "../git-compat-util.h"
+#include "internal.h"
+
+#define DV_I_43_0_BIT ((uint32_t)1 << 0)
+#define DV_I_44_0_BIT ((uint32_t)1 << 1)
+#define DV_I_45_0_BIT ((uint32_t)1 << 2)
+#define DV_I_46_0_BIT ((uint32_t)1 << 3)
+#define DV_I_46_2_BIT ((uint32_t)1 << 4)
+#define DV_I_47_0_BIT ((uint32_t)1 << 5)
+#define DV_I_47_2_BIT ((uint32_t)1 << 6)
+#define DV_I_48_0_BIT ((uint32_t)1 << 7)
+#define DV_I_48_2_BIT ((uint32_t)1 << 8)
+#define DV_I_49_0_BIT ((uint32_t)1 << 9)
+#define DV_I_49_2_BIT ((uint32_t)1 << 10)
+#define DV_I_50_0_BIT ((uint32_t)1 << 11)
+#define DV_I_50_2_BIT ((uint32_t)1 << 12)
+#define DV_I_51_0_BIT ((uint32_t)1 << 13)
+#define DV_I_51_2_BIT ((uint32_t)1 << 14)
+#define DV_I_52_0_BIT ((uint32_t)1 << 15)
+#define DV_II_45_0_BIT ((uint32_t)1 << 16)
+#define DV_II_46_0_BIT ((uint32_t)1 << 17)
+#define DV_II_46_2_BIT ((uint32_t)1 << 18)
+#define DV_II_47_0_BIT ((uint32_t)1 << 19)
+#define DV_II_48_0_BIT ((uint32_t)1 << 20)
+#define DV_II_49_0_BIT ((uint32_t)1 << 21)
+#define DV_II_49_2_BIT ((uint32_t)1 << 22)
+#define DV_II_50_0_BIT ((uint32_t)1 << 23)
+#define DV_II_50_2_BIT ((uint32_t)1 << 24)
+#define DV_II_51_0_BIT ((uint32_t)1 << 25)
+#define DV_II_51_2_BIT ((uint32_t)1 << 26)
+#define DV_II_52_0_BIT ((uint32_t)1 << 27)
+#define DV_II_53_0_BIT ((uint32_t)1 << 28)
+#define DV_II_54_0_BIT ((uint32_t)1 << 29)
+#define DV_II_55_0_BIT ((uint32_t)1 << 30)
+#define DV_II_56_0_BIT ((uint32_t)1 << 31)
+
+/*
+ * The prefixes loop over constant tables. Unrolling those loops fully lets
+ * the compiler fold each entry into the code as immediates, which is what
+ * makes them fast; without it they are two to three times slower.
+ */
+#if defined(__clang__) || (defined(__GNUC__) && __GNUC__ >= 8)
+#define UNROLL_TABLE _Pragma("GCC unroll 128")
+#else
+#define UNROLL_TABLE
+#endif
+
+/*
+ * The tail loops run over a few conditions at a time, too few to gain from
+ * vectorizing; clang would otherwise vectorize them when targeting AVX2.
+ */
+#ifdef __clang__
+#define NO_VECTORIZE _Pragma("clang loop vectorize(disable)")
+#else
+#define NO_VECTORIZE
+#endif
+
+/* A bitcondition: bit a of w[i] XOR bit b of w[j] must equal c. */
+struct ubc_cond {
+	uint8_t i, a, j, b, c;
+};
+
+static inline uint32_t cond_fails(const uint32_t *w, const struct ubc_cond *c)
+{
+	return (((w[c->i] >> c->a) ^ (w[c->j] >> c->b) ^ c->c) & 1);
+}
+
+/* A condition of the scalar prefix, and the DVs it rules out if it fails. */
+struct ubc_prefix_cond {
+	struct ubc_cond cond;
+	uint32_t dvs;
+};
+
+/*
+ * A group of conditions for a vector prefix, one per lane. In lane k, the
+ * bit selected by test[k] of (w[lo + k] >> lo_shift) ^ (w[hi + k] >> hi_shift)
+ * must equal want, or the DVs in dvs[k] are ruled out. The lanes share
+ * everything but test[] and dvs[]; an unused lane has both 0.
+ *
+ * No group reads past w[66].
+ */
+struct ubc_group4 {
+	uint8_t lo, lo_shift, hi, hi_shift, want;
+	uint32_t test[4];
+	uint32_t dvs[4];
+};
+
+struct ubc_group8 {
+	uint8_t lo, lo_shift, hi, hi_shift, want;
+	uint32_t test[8];
+	uint32_t dvs[8];
+};
+
+/* The tail conditions of DV d are checks[spans[d].start] onwards. */
+struct tail_span {
+	uint16_t start;
+	uint8_t len;
+};
+
+/*
+ * Runs the tail conditions of each DV still alive in `mask`, and clears
+ * the DVs with a failing one. Each condition fails about half the time, so
+ * it tests all of a DV's conditions rather than branch on each one.
+ */
+static inline uint32_t run_tail(const uint32_t *w, uint32_t mask,
+				const struct ubc_cond *checks,
+				const struct tail_span *spans)
+{
+	uint32_t out = mask;
+	while (mask) {
+		unsigned d = sha1dc_ctz(mask);
+		const struct ubc_cond *c = checks + spans[d].start;
+		const struct ubc_cond *end = c + spans[d].len;
+		uint32_t fail = 0;
+
+		NO_VECTORIZE
+		for (; c < end; c++)
+			fail |= cond_fails(w, c);
+		out &= ~(fail << d);
+		mask &= mask - 1;
+	}
+	return out;
+}
+
+/* scalar form */
+
+static const struct ubc_prefix_cond scalar_prefix_conds[] = {
+	{ { 44, 29, 45, 29, 0 },
+	  DV_I_48_0_BIT | DV_I_51_0_BIT | DV_I_52_0_BIT | DV_II_45_0_BIT |
+	  DV_II_46_0_BIT | DV_II_50_0_BIT | DV_II_51_0_BIT },
+	{ { 46, 29, 47, 29, 0 },
+	  DV_I_43_0_BIT | DV_I_50_0_BIT | DV_II_47_0_BIT | DV_II_48_0_BIT |
+	  DV_II_52_0_BIT | DV_II_53_0_BIT },
+	{ { 45, 4, 48, 29, 0 },
+	  DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_49_0_BIT | DV_I_51_0_BIT |
+	  DV_II_49_0_BIT | DV_II_54_0_BIT },
+	{ { 49, 29, 50, 29, 0 },
+	  DV_I_46_0_BIT | DV_II_45_0_BIT | DV_II_50_0_BIT | DV_II_51_0_BIT |
+	  DV_II_55_0_BIT | DV_II_56_0_BIT },
+	{ { 40, 29, 41, 29, 0 },
+	  DV_I_44_0_BIT | DV_I_47_0_BIT | DV_I_48_0_BIT | DV_II_46_0_BIT |
+	  DV_II_47_0_BIT | DV_II_56_0_BIT },
+	{ { 36, 1, 37, 6, 1 },
+	  DV_I_47_2_BIT | DV_I_50_2_BIT | DV_II_46_2_BIT },
+	{ { 47, 29, 48, 29, 0 },
+	  DV_I_44_0_BIT | DV_I_51_0_BIT | DV_II_48_0_BIT | DV_II_49_0_BIT |
+	  DV_II_53_0_BIT | DV_II_54_0_BIT },
+	{ { 39, 1, 40, 6, 1 },
+	  DV_I_46_2_BIT | DV_I_50_2_BIT | DV_II_49_2_BIT },
+	{ { 40, 1, 41, 6, 1 },
+	  DV_I_47_2_BIT | DV_I_51_2_BIT | DV_II_50_2_BIT },
+	{ { 41, 1, 42, 6, 1 },
+	  DV_I_48_2_BIT | DV_II_46_2_BIT | DV_II_51_2_BIT },
+	{ { 43, 4, 46, 29, 0 },
+	  DV_I_43_0_BIT | DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_49_0_BIT |
+	  DV_II_47_0_BIT | DV_II_52_0_BIT },
+	{ { 46, 4, 49, 29, 0 },
+	  DV_I_46_0_BIT | DV_I_48_0_BIT | DV_I_50_0_BIT | DV_I_52_0_BIT |
+	  DV_II_50_0_BIT | DV_II_55_0_BIT },
+	{ { 45, 6, 47, 6, 0 },
+	  DV_I_47_2_BIT | DV_I_49_2_BIT | DV_I_51_2_BIT },
+	{ { 45, 29, 46, 29, 0 },
+	  DV_I_49_0_BIT | DV_I_52_0_BIT | DV_II_46_0_BIT | DV_II_47_0_BIT |
+	  DV_II_51_0_BIT | DV_II_52_0_BIT },
+	{ { 44, 4, 47, 29, 0 },
+	  DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_48_0_BIT | DV_I_50_0_BIT |
+	  DV_II_48_0_BIT | DV_II_53_0_BIT },
+	{ { 48, 29, 49, 29, 0 },
+	  DV_I_45_0_BIT | DV_I_52_0_BIT | DV_II_49_0_BIT | DV_II_50_0_BIT |
+	  DV_II_54_0_BIT | DV_II_55_0_BIT },
+	{ { 44, 6, 46, 6, 0 },
+	  DV_I_46_2_BIT | DV_I_48_2_BIT | DV_I_50_2_BIT },
+	{ { 47, 4, 50, 29, 0 },
+	  DV_I_47_0_BIT | DV_I_49_0_BIT | DV_I_51_0_BIT | DV_II_45_0_BIT |
+	  DV_II_51_0_BIT | DV_II_56_0_BIT },
+	{ { 35, 1, 36, 6, 1 },
+	  DV_I_46_2_BIT | DV_I_49_2_BIT },
+	{ { 44, 1, 45, 6, 1 },
+	  DV_I_51_2_BIT | DV_II_49_2_BIT },
+	{ { 42, 6, 43, 1, 0 },
+	  DV_II_46_2_BIT | DV_II_51_2_BIT },
+	{ { 37, 4, 40, 29, 0 },
+	  DV_I_43_0_BIT | DV_I_47_0_BIT | DV_II_46_0_BIT | DV_II_53_0_BIT |
+	  DV_II_55_0_BIT },
+	{ { 41, 6, 42, 1, 0 },
+	  DV_I_51_2_BIT | DV_II_50_2_BIT },
+	{ { 40, 4, 43, 29, 0 },
+	  DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_50_0_BIT | DV_II_49_0_BIT |
+	  DV_II_56_0_BIT },
+	{ { 41, 4, 44, 29, 0 },
+	  DV_I_43_0_BIT | DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_51_0_BIT |
+	  DV_II_45_0_BIT | DV_II_50_0_BIT },
+	{ { 52, 29, 53, 29, 0 },
+	  DV_I_49_0_BIT | DV_II_45_0_BIT | DV_II_48_0_BIT | DV_II_53_0_BIT |
+	  DV_II_54_0_BIT },
+	{ { 40, 6, 41, 1, 0 },
+	  DV_I_50_2_BIT | DV_II_49_2_BIT },
+	{ { 46, 6, 47, 1, 0 },
+	  DV_I_46_2_BIT | DV_II_50_2_BIT },
+	{ { 47, 6, 48, 1, 0 },
+	  DV_I_47_2_BIT | DV_II_51_2_BIT },
+	{ { 42, 4, 45, 29, 0 },
+	  DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_48_0_BIT | DV_I_52_0_BIT |
+	  DV_II_46_0_BIT | DV_II_51_0_BIT },
+	{ { 37, 1, 38, 6, 1 },
+	  DV_I_48_2_BIT | DV_I_51_2_BIT },
+	{ { 43, 6, 45, 6, 0 },
+	  DV_I_47_2_BIT | DV_I_49_2_BIT },
+	{ { 53, 29, 54, 29, 0 },
+	  DV_I_50_0_BIT | DV_II_46_0_BIT | DV_II_49_0_BIT | DV_II_54_0_BIT |
+	  DV_II_55_0_BIT },
+	{ { 41, 29, 42, 29, 0 },
+	  DV_I_45_0_BIT | DV_I_48_0_BIT | DV_I_49_0_BIT | DV_II_47_0_BIT |
+	  DV_II_48_0_BIT },
+	{ { 50, 29, 51, 29, 0 },
+	  DV_I_47_0_BIT | DV_II_46_0_BIT | DV_II_51_0_BIT | DV_II_52_0_BIT |
+	  DV_II_56_0_BIT },
+	{ { 61, 2, 62, 7, 1 },
+	  DV_I_46_2_BIT | DV_II_46_2_BIT },
+	{ { 46, 6, 48, 6, 0 },
+	  DV_I_48_2_BIT | DV_I_50_2_BIT },
+	{ { 39, 4, 42, 29, 0 },
+	  DV_I_43_0_BIT | DV_I_45_0_BIT | DV_I_49_0_BIT | DV_II_48_0_BIT |
+	  DV_II_55_0_BIT },
+	{ { 43, 29, 44, 29, 0 },
+	  DV_I_47_0_BIT | DV_I_50_0_BIT | DV_I_51_0_BIT | DV_II_45_0_BIT |
+	  DV_II_49_0_BIT | DV_II_50_0_BIT },
+	{ { 47, 6, 49, 6, 0 },
+	  DV_I_49_2_BIT | DV_I_51_2_BIT },
+	{ { 51, 29, 52, 29, 0 },
+	  DV_I_48_0_BIT | DV_II_47_0_BIT | DV_II_52_0_BIT | DV_II_53_0_BIT },
+	{ { 36, 0, 37, 5, 1 },
+	  DV_II_49_2_BIT },
+	{ { 37, 0, 38, 5, 1 },
+	  DV_II_50_2_BIT },
+	{ { 38, 0, 39, 5, 1 },
+	  DV_II_51_2_BIT },
+	{ { 38, 4, 41, 29, 0 },
+	  DV_I_44_0_BIT | DV_I_48_0_BIT | DV_II_47_0_BIT | DV_II_54_0_BIT |
+	  DV_II_56_0_BIT },
+	{ { 50, 6, 51, 1, 0 },
+	  DV_I_50_2_BIT | DV_II_46_2_BIT },
+	{ { 42, 6, 44, 6, 0 },
+	  DV_I_46_2_BIT | DV_I_48_2_BIT },
+	{ { 48, 4, 51, 29, 0 },
+	  DV_I_48_0_BIT | DV_I_50_0_BIT | DV_I_52_0_BIT | DV_II_46_0_BIT |
+	  DV_II_52_0_BIT },
+	{ { 42, 29, 43, 29, 0 },
+	  DV_I_46_0_BIT | DV_I_49_0_BIT | DV_I_50_0_BIT | DV_II_48_0_BIT |
+	  DV_II_49_0_BIT },
+	{ { 54, 29, 55, 29, 0 },
+	  DV_I_51_0_BIT | DV_II_47_0_BIT | DV_II_50_0_BIT | DV_II_55_0_BIT |
+	  DV_II_56_0_BIT },
+	{ { 38, 1, 39, 6, 1 },
+	  DV_I_49_2_BIT },
+	{ { 45, 1, 46, 6, 1 },
+	  DV_II_50_2_BIT },
+	{ { 46, 1, 47, 6, 1 },
+	  DV_II_51_2_BIT },
+	{ { 50, 1, 51, 6, 1 },
+	  DV_II_49_2_BIT },
+	{ { 39, 4, 40, 29, 1 },
+	  DV_I_43_0_BIT | DV_II_53_0_BIT | DV_II_55_0_BIT },
+	{ { 55, 29, 56, 29, 0 },
+	  DV_I_52_0_BIT | DV_II_48_0_BIT | DV_II_51_0_BIT | DV_II_56_0_BIT },
+	{ { 48, 6, 50, 6, 0 },
+	  DV_I_50_2_BIT | DV_II_46_2_BIT },
+	{ { 49, 4, 52, 29, 0 },
+	  DV_I_49_0_BIT | DV_I_51_0_BIT | DV_II_45_0_BIT | DV_II_47_0_BIT |
+	  DV_II_53_0_BIT },
+	{ { 40, 4, 41, 29, 1 },
+	  DV_I_44_0_BIT | DV_II_54_0_BIT | DV_II_56_0_BIT },
+	{ { 41, 4, 42, 29, 1 },
+	  DV_I_43_0_BIT | DV_I_45_0_BIT | DV_II_55_0_BIT },
+	{ { 42, 1, 43, 6, 1 },
+	  DV_I_49_2_BIT },
+	{ { 51, 1, 52, 6, 1 },
+	  DV_II_50_2_BIT },
+	{ { 52, 1, 53, 6, 1 },
+	  DV_II_51_2_BIT },
+	{ { 62, 2, 63, 7, 1 },
+	  DV_I_47_2_BIT },
+	{ { 63, 2, 64, 7, 1 },
+	  DV_I_48_2_BIT },
+	{ { 45, 6, 46, 1, 0 },
+	  DV_II_49_2_BIT },
+	{ { 36, 4, 40, 29, 0 },
+	  DV_I_46_0_BIT | DV_I_49_0_BIT | DV_II_45_0_BIT | DV_II_48_0_BIT },
+	{ { 50, 4, 53, 29, 0 },
+	  DV_I_50_0_BIT | DV_I_52_0_BIT | DV_II_46_0_BIT | DV_II_48_0_BIT |
+	  DV_II_54_0_BIT },
+	{ { 56, 29, 57, 29, 0 },
+	  DV_II_49_0_BIT | DV_II_52_0_BIT },
+	{ { 43, 4, 44, 29, 1 },
+	  DV_I_43_0_BIT | DV_I_45_0_BIT | DV_I_47_0_BIT }
+};
+
+static const struct ubc_cond scalar_tail_checks[] = {
+	/* DV_I_43_0 */
+	{ 58, 0, 59, 5, 1 },
+	{ 58, 0, 63, 30, 1 },
+	{ 61, 1, 62, 6, 1 },
+	{ 43, 4, 47, 29, 0 },
+	/* DV_I_44_0 */
+	{ 40, 4, 42, 4, 1 },
+	{ 42, 4, 44, 4, 1 },
+	{ 59, 0, 60, 5, 1 },
+	{ 59, 0, 64, 30, 1 },
+	{ 62, 1, 63, 6, 1 },
+	{ 44, 4, 48, 29, 0 },
+	/* DV_I_45_0 */
+	{ 43, 4, 45, 4, 1 },
+	{ 60, 0, 61, 5, 1 },
+	{ 63, 1, 64, 6, 1 },
+	{ 35, 4, 39, 29, 0 },
+	/* DV_I_46_0 */
+	{ 40, 4, 42, 4, 1 },
+	{ 42, 4, 44, 4, 1 },
+	{ 44, 4, 46, 4, 1 },
+	{ 61, 0, 62, 5, 1 },
+	/* DV_I_46_2 */
+	{ 39, 1, 42, 6, 1 },
+	/* DV_I_47_0 */
+	{ 43, 4, 45, 4, 1 },
+	{ 45, 4, 47, 4, 1 },
+	{ 62, 0, 63, 5, 1 },
+	{ 37, 4, 41, 29, 0 },
+	/* DV_I_47_2 */
+	{ 40, 1, 43, 6, 1 },
+	/* DV_I_48_0 */
+	{ 42, 4, 44, 4, 1 },
+	{ 44, 4, 46, 4, 1 },
+	{ 46, 4, 48, 4, 1 },
+	{ 63, 0, 64, 5, 1 },
+	{ 35, 4, 39, 29, 0 },
+	{ 38, 4, 42, 29, 0 },
+	/* DV_I_48_2 */
+	{ 41, 1, 49, 1, 1 },
+	/* DV_I_49_0 */
+	{ 43, 4, 45, 4, 1 },
+	{ 45, 4, 47, 4, 1 },
+	{ 47, 4, 49, 4, 1 },
+	{ 39, 4, 43, 29, 0 },
+	/* DV_I_49_2 */
+	{ 38, 1, 40, 1, 1 },
+	{ 42, 1, 50, 1, 1 },
+	/* DV_I_50_0 */
+	{ 36, 4, 37, 4, 1 },
+	{ 44, 4, 46, 4, 1 },
+	{ 46, 4, 48, 4, 1 },
+	{ 48, 4, 50, 4, 1 },
+	{ 37, 4, 41, 29, 0 },
+	{ 40, 4, 44, 29, 0 },
+	/* DV_I_50_2 */
+	{ 43, 1, 44, 6, 1 },
+	/* DV_I_51_0 */
+	{ 37, 4, 38, 4, 1 },
+	{ 45, 4, 47, 4, 1 },
+	{ 47, 4, 49, 4, 1 },
+	{ 52, 29, 55, 29, 1 },
+	{ 35, 3, 39, 28, 0 },
+	{ 38, 4, 42, 29, 0 },
+	{ 41, 4, 45, 29, 0 },
+	{ 51, 4, 54, 29, 0 },
+	/* DV_I_51_2 */
+	{ 44, 1, 51, 6, 1 },
+	{ 44, 1, 52, 1, 1 },
+	{ 35, 5, 39, 30, 0 },
+	{ 37, 1, 37, 6, 0 },
+	/* DV_I_52_0 */
+	{ 38, 4, 39, 4, 1 },
+	{ 46, 4, 48, 4, 1 },
+	{ 48, 4, 50, 4, 1 },
+	{ 53, 29, 56, 29, 1 },
+	{ 39, 4, 43, 29, 0 },
+	{ 42, 4, 46, 29, 0 },
+	{ 52, 4, 55, 29, 0 },
+	/* DV_II_45_0 */
+	{ 47, 4, 49, 4, 1 },
+	{ 60, 0, 61, 5, 1 },
+	{ 63, 1, 64, 6, 1 },
+	{ 41, 4, 45, 29, 0 },
+	/* DV_II_46_0 */
+	{ 48, 4, 50, 4, 1 },
+	{ 61, 0, 62, 5, 1 },
+	{ 37, 4, 41, 29, 0 },
+	{ 42, 4, 46, 29, 0 },
+	/* DV_II_46_2 */
+	{ 47, 1, 48, 6, 1 },
+	/* DV_II_47_0 */
+	{ 52, 29, 55, 29, 1 },
+	{ 62, 0, 63, 5, 1 },
+	{ 35, 3, 39, 28, 0 },
+	{ 35, 4, 39, 29, 0 },
+	{ 38, 4, 42, 29, 0 },
+	{ 43, 4, 47, 29, 0 },
+	{ 51, 4, 54, 29, 0 },
+	/* DV_II_48_0 */
+	{ 35, 30, 36, 3, 1 },
+	{ 35, 30, 40, 28, 1 },
+	{ 52, 29, 55, 29, 1 },
+	{ 53, 29, 56, 29, 1 },
+	{ 63, 0, 64, 5, 1 },
+	{ 39, 4, 43, 29, 0 },
+	{ 44, 4, 48, 29, 0 },
+	{ 52, 4, 55, 29, 0 },
+	/* DV_II_49_0 */
+	{ 36, 30, 37, 3, 1 },
+	{ 36, 30, 41, 28, 1 },
+	{ 53, 29, 56, 29, 1 },
+	{ 37, 4, 41, 29, 0 },
+	{ 40, 4, 44, 29, 0 },
+	{ 51, 4, 54, 29, 0 },
+	{ 53, 4, 56, 29, 0 },
+	/* DV_II_49_2 */
+	{ 36, 0, 41, 30, 1 },
+	{ 50, 1, 53, 6, 1 },
+	{ 50, 1, 54, 1, 1 },
+	/* DV_II_50_0 */
+	{ 37, 30, 38, 3, 1 },
+	{ 37, 30, 42, 28, 1 },
+	{ 55, 29, 58, 29, 1 },
+	{ 38, 4, 42, 29, 0 },
+	{ 41, 4, 45, 29, 0 },
+	{ 52, 4, 55, 29, 0 },
+	{ 54, 4, 57, 29, 0 },
+	{ 57, 29, 58, 29, 0 },
+	/* DV_II_50_2 */
+	{ 37, 0, 42, 30, 1 },
+	{ 51, 1, 54, 6, 1 },
+	{ 51, 1, 55, 1, 1 },
+	/* DV_II_51_0 */
+	{ 38, 30, 39, 3, 1 },
+	{ 38, 30, 43, 28, 1 },
+	{ 55, 29, 58, 29, 1 },
+	{ 56, 29, 59, 29, 1 },
+	{ 39, 4, 43, 29, 0 },
+	{ 42, 4, 46, 29, 0 },
+	{ 53, 4, 56, 29, 0 },
+	{ 55, 4, 58, 29, 0 },
+	/* DV_II_51_2 */
+	{ 38, 0, 43, 30, 1 },
+	{ 52, 1, 55, 6, 1 },
+	{ 52, 1, 56, 1, 1 },
+	/* DV_II_52_0 */
+	{ 36, 4, 38, 4, 1 },
+	{ 39, 30, 40, 3, 1 },
+	{ 39, 30, 44, 28, 1 },
+	{ 54, 4, 60, 29, 1 },
+	{ 56, 29, 59, 29, 1 },
+	{ 40, 4, 44, 29, 0 },
+	{ 43, 4, 47, 29, 0 },
+	{ 54, 4, 57, 29, 0 },
+	{ 56, 4, 59, 29, 0 },
+	/* DV_II_53_0 */
+	{ 55, 4, 57, 4, 1 },
+	{ 55, 4, 61, 29, 1 },
+	{ 41, 3, 45, 28, 0 },
+	{ 41, 4, 45, 29, 0 },
+	{ 44, 4, 48, 29, 0 },
+	{ 55, 4, 58, 29, 0 },
+	{ 57, 29, 58, 29, 0 },
+	/* DV_II_54_0 */
+	{ 36, 4, 38, 4, 1 },
+	{ 42, 3, 46, 28, 0 },
+	{ 42, 4, 46, 29, 0 },
+	{ 56, 4, 59, 29, 0 },
+	{ 56, 4, 58, 29, 0 },
+	{ 58, 4, 62, 29, 0 },
+	/* DV_II_55_0 */
+	{ 43, 3, 47, 28, 0 },
+	{ 43, 4, 47, 29, 0 },
+	{ 51, 4, 54, 29, 0 },
+	{ 57, 4, 59, 29, 0 },
+	{ 59, 4, 63, 29, 0 },
+	/* DV_II_56_0 */
+	{ 40, 4, 42, 4, 1 },
+	{ 44, 3, 48, 28, 0 },
+	{ 44, 4, 48, 29, 0 },
+	{ 52, 4, 55, 29, 0 },
+	{ 60, 4, 64, 29, 0 }
+};
+
+static const struct tail_span scalar_tail_spans[32] = {
+	{ 0, 4 },	/* DV_I_43_0 */
+	{ 4, 6 },	/* DV_I_44_0 */
+	{ 10, 4 },	/* DV_I_45_0 */
+	{ 14, 4 },	/* DV_I_46_0 */
+	{ 18, 1 },	/* DV_I_46_2 */
+	{ 19, 4 },	/* DV_I_47_0 */
+	{ 23, 1 },	/* DV_I_47_2 */
+	{ 24, 6 },	/* DV_I_48_0 */
+	{ 30, 1 },	/* DV_I_48_2 */
+	{ 31, 4 },	/* DV_I_49_0 */
+	{ 35, 2 },	/* DV_I_49_2 */
+	{ 37, 6 },	/* DV_I_50_0 */
+	{ 43, 1 },	/* DV_I_50_2 */
+	{ 44, 8 },	/* DV_I_51_0 */
+	{ 52, 4 },	/* DV_I_51_2 */
+	{ 56, 7 },	/* DV_I_52_0 */
+	{ 63, 4 },	/* DV_II_45_0 */
+	{ 67, 4 },	/* DV_II_46_0 */
+	{ 71, 1 },	/* DV_II_46_2 */
+	{ 72, 7 },	/* DV_II_47_0 */
+	{ 79, 8 },	/* DV_II_48_0 */
+	{ 87, 7 },	/* DV_II_49_0 */
+	{ 94, 3 },	/* DV_II_49_2 */
+	{ 97, 8 },	/* DV_II_50_0 */
+	{ 105, 3 },	/* DV_II_50_2 */
+	{ 108, 8 },	/* DV_II_51_0 */
+	{ 116, 3 },	/* DV_II_51_2 */
+	{ 119, 9 },	/* DV_II_52_0 */
+	{ 128, 7 },	/* DV_II_53_0 */
+	{ 135, 6 },	/* DV_II_54_0 */
+	{ 141, 5 },	/* DV_II_55_0 */
+	{ 146, 5 }	/* DV_II_56_0 */
+};
+
+static uint32_t scalar_prefix(const uint32_t *w)
+{
+	uint32_t mask = 0xFFFFFFFF;
+	size_t i;
+
+	UNROLL_TABLE
+	for (i = 0; i < ARRAY_SIZE(scalar_prefix_conds); i++) {
+		const struct ubc_prefix_cond *p = &scalar_prefix_conds[i];
+		mask &= ~(p->dvs & (0 - cond_fails(w, &p->cond)));
+	}
+	return mask;
+}
+
+uint32_t sha1dc_ubc_check_scalar(const uint32_t w[80])
+{
+	uint32_t mask = scalar_prefix(w);
+	/* Every check only clears bits, so an empty mask settles it. */
+	if (!mask)
+		return 0;
+	return run_tail(w, mask, scalar_tail_checks, scalar_tail_spans);
+}
+
+/* neon form */
+
+#ifdef SHA1DC_HAVE_NEON
+
+static const struct ubc_group4 neon_groups[] = {
+	{ 35, 0, 36, 5, 1,
+	  { 1u << 1, 1u << 1, 1u << 1, 1u << 0 },
+	  { DV_I_46_2_BIT | DV_I_49_2_BIT,
+	    DV_I_47_2_BIT | DV_I_50_2_BIT | DV_II_46_2_BIT,
+	    DV_I_48_2_BIT | DV_I_51_2_BIT,
+	    DV_II_51_2_BIT } },
+	{ 36, 0, 37, 5, 1,
+	  { 1u << 0, 1u << 0, 1u << 1, 1u << 1 },
+	  { DV_II_49_2_BIT,
+	    DV_II_50_2_BIT,
+	    DV_I_49_2_BIT,
+	    DV_I_46_2_BIT | DV_I_50_2_BIT | DV_II_49_2_BIT } },
+	{ 36, 0, 38, 0, 1,
+	  { 1u << 4, 1u << 4, 1u << 1, 1u << 4 },
+	  { DV_II_52_0_BIT | DV_II_54_0_BIT,
+	    DV_I_43_0_BIT | DV_II_53_0_BIT | DV_II_55_0_BIT,
+	    DV_I_49_2_BIT,
+	    DV_I_43_0_BIT | DV_I_45_0_BIT | DV_II_55_0_BIT } },
+	{ 36, 0, 40, 25, 0,
+	  { 1u << 4, 1u << 5, 1u << 5, 1u << 5 },
+	  { DV_I_46_0_BIT | DV_I_49_0_BIT | DV_II_45_0_BIT |
+	    DV_II_48_0_BIT,
+	    DV_II_49_2_BIT,
+	    DV_II_50_2_BIT,
+	    DV_II_51_2_BIT } },
+	{ 38, 0, 40, 0, 1,
+	  { 1u << 4, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_I_44_0_BIT | DV_II_54_0_BIT | DV_II_56_0_BIT,
+	    DV_I_50_2_BIT | DV_II_49_2_BIT,
+	    DV_I_51_2_BIT | DV_II_50_2_BIT,
+	    DV_II_46_2_BIT | DV_II_51_2_BIT } },
+	{ 37, 0, 40, 25, 0,
+	  { 1u << 4, 1u << 4, 1u << 4, 1u << 4 },
+	  { DV_I_43_0_BIT | DV_I_47_0_BIT | DV_II_46_0_BIT |
+	    DV_II_53_0_BIT | DV_II_55_0_BIT,
+	    DV_I_44_0_BIT | DV_I_48_0_BIT | DV_II_47_0_BIT |
+	    DV_II_54_0_BIT | DV_II_56_0_BIT,
+	    DV_I_43_0_BIT | DV_I_45_0_BIT | DV_I_49_0_BIT | DV_II_48_0_BIT |
+	    DV_II_55_0_BIT,
+	    DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_50_0_BIT | DV_II_49_0_BIT |
+	    DV_II_56_0_BIT } },
+	{ 40, 0, 41, 5, 1,
+	  { 1u << 1, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_I_47_2_BIT | DV_I_51_2_BIT | DV_II_50_2_BIT,
+	    DV_I_48_2_BIT | DV_II_46_2_BIT | DV_II_51_2_BIT,
+	    DV_I_49_2_BIT,
+	    DV_I_50_2_BIT } },
+	{ 40, 0, 41, 0, 0,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 29 },
+	  { DV_I_44_0_BIT | DV_I_47_0_BIT | DV_I_48_0_BIT | DV_II_46_0_BIT |
+	    DV_II_47_0_BIT | DV_II_56_0_BIT,
+	    DV_I_45_0_BIT | DV_I_48_0_BIT | DV_I_49_0_BIT | DV_II_47_0_BIT |
+	    DV_II_48_0_BIT,
+	    DV_I_46_0_BIT | DV_I_49_0_BIT | DV_I_50_0_BIT | DV_II_48_0_BIT |
+	    DV_II_49_0_BIT,
+	    DV_I_47_0_BIT | DV_I_50_0_BIT | DV_I_51_0_BIT | DV_II_45_0_BIT |
+	    DV_II_49_0_BIT | DV_II_50_0_BIT } },
+	{ 41, 0, 43, 0, 0,
+	  { 1u << 6, 1u << 6, 1u << 6, 1u << 6 },
+	  { DV_I_47_2_BIT,
+	    DV_I_46_2_BIT | DV_I_48_2_BIT,
+	    DV_I_47_2_BIT | DV_I_49_2_BIT,
+	    DV_I_46_2_BIT | DV_I_48_2_BIT | DV_I_50_2_BIT } },
+	{ 41, 0, 44, 25, 0,
+	  { 1u << 4, 1u << 4, 1u << 4, 1u << 4 },
+	  { DV_I_43_0_BIT | DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_51_0_BIT |
+	    DV_II_45_0_BIT | DV_II_50_0_BIT,
+	    DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_48_0_BIT | DV_I_52_0_BIT |
+	    DV_II_46_0_BIT | DV_II_51_0_BIT,
+	    DV_I_43_0_BIT | DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_49_0_BIT |
+	    DV_II_47_0_BIT | DV_II_52_0_BIT,
+	    DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_48_0_BIT | DV_I_50_0_BIT |
+	    DV_II_48_0_BIT | DV_II_53_0_BIT } },
+	{ 44, 0, 45, 5, 1,
+	  { 1u << 1, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_I_51_2_BIT | DV_II_49_2_BIT,
+	    DV_II_50_2_BIT,
+	    DV_II_51_2_BIT,
+	    DV_II_46_2_BIT } },
+	{ 44, 0, 45, 0, 0,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 29 },
+	  { DV_I_48_0_BIT | DV_I_51_0_BIT | DV_I_52_0_BIT | DV_II_45_0_BIT |
+	    DV_II_46_0_BIT | DV_II_50_0_BIT | DV_II_51_0_BIT,
+	    DV_I_49_0_BIT | DV_I_52_0_BIT | DV_II_46_0_BIT |
+	    DV_II_47_0_BIT | DV_II_51_0_BIT | DV_II_52_0_BIT,
+	    DV_I_43_0_BIT | DV_I_50_0_BIT | DV_II_47_0_BIT |
+	    DV_II_48_0_BIT | DV_II_52_0_BIT | DV_II_53_0_BIT,
+	    DV_I_44_0_BIT | DV_I_51_0_BIT | DV_II_48_0_BIT |
+	    DV_II_49_0_BIT | DV_II_53_0_BIT | DV_II_54_0_BIT } },
+	{ 45, 5, 46, 0, 0,
+	  { 1u << 1, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_II_49_2_BIT,
+	    DV_I_46_2_BIT | DV_II_50_2_BIT,
+	    DV_I_47_2_BIT | DV_II_51_2_BIT,
+	    DV_I_48_2_BIT } },
+	{ 45, 0, 47, 0, 0,
+	  { 1u << 6, 1u << 6, 1u << 6, 1u << 6 },
+	  { DV_I_47_2_BIT | DV_I_49_2_BIT | DV_I_51_2_BIT,
+	    DV_I_48_2_BIT | DV_I_50_2_BIT,
+	    DV_I_49_2_BIT | DV_I_51_2_BIT,
+	    DV_I_50_2_BIT | DV_II_46_2_BIT } },
+	{ 45, 0, 47, 0, 1,
+	  { 1u << 29, 1u << 29, 1u << 4, 1u << 4 },
+	  { DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_48_0_BIT,
+	    DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_49_0_BIT,
+	    DV_I_49_0_BIT | DV_I_51_0_BIT | DV_II_45_0_BIT,
+	    DV_I_50_0_BIT | DV_I_52_0_BIT | DV_II_46_0_BIT } },
+	{ 45, 0, 48, 25, 0,
+	  { 1u << 4, 1u << 4, 1u << 4, 1u << 4 },
+	  { DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_49_0_BIT | DV_I_51_0_BIT |
+	    DV_II_49_0_BIT | DV_II_54_0_BIT,
+	    DV_I_46_0_BIT | DV_I_48_0_BIT | DV_I_50_0_BIT | DV_I_52_0_BIT |
+	    DV_II_50_0_BIT | DV_II_55_0_BIT,
+	    DV_I_47_0_BIT | DV_I_49_0_BIT | DV_I_51_0_BIT | DV_II_45_0_BIT |
+	    DV_II_51_0_BIT | DV_II_56_0_BIT,
+	    DV_I_48_0_BIT | DV_I_50_0_BIT | DV_I_52_0_BIT | DV_II_46_0_BIT |
+	    DV_II_52_0_BIT } },
+	{ 48, 0, 49, 0, 0,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 29 },
+	  { DV_I_45_0_BIT | DV_I_52_0_BIT | DV_II_49_0_BIT |
+	    DV_II_50_0_BIT | DV_II_54_0_BIT | DV_II_55_0_BIT,
+	    DV_I_46_0_BIT | DV_II_45_0_BIT | DV_II_50_0_BIT |
+	    DV_II_51_0_BIT | DV_II_55_0_BIT | DV_II_56_0_BIT,
+	    DV_I_47_0_BIT | DV_II_46_0_BIT | DV_II_51_0_BIT |
+	    DV_II_52_0_BIT | DV_II_56_0_BIT,
+	    DV_I_48_0_BIT | DV_II_47_0_BIT | DV_II_52_0_BIT |
+	    DV_II_53_0_BIT } },
+	{ 52, 0, 53, 0, 0,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 29 },
+	  { DV_I_49_0_BIT | DV_II_45_0_BIT | DV_II_48_0_BIT |
+	    DV_II_53_0_BIT | DV_II_54_0_BIT,
+	    DV_I_50_0_BIT | DV_II_46_0_BIT | DV_II_49_0_BIT |
+	    DV_II_54_0_BIT | DV_II_55_0_BIT,
+	    DV_I_51_0_BIT | DV_II_47_0_BIT | DV_II_50_0_BIT |
+	    DV_II_55_0_BIT | DV_II_56_0_BIT,
+	    DV_I_52_0_BIT | DV_II_48_0_BIT | DV_II_51_0_BIT |
+	    DV_II_56_0_BIT } },
+	{ 52, 0, 55, 0, 1,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 29 },
+	  { DV_I_51_0_BIT | DV_II_47_0_BIT | DV_II_48_0_BIT,
+	    DV_I_52_0_BIT | DV_II_48_0_BIT | DV_II_49_0_BIT,
+	    DV_II_49_0_BIT | DV_II_50_0_BIT,
+	    DV_II_50_0_BIT | DV_II_51_0_BIT } },
+	{ 60, 0, 61, 5, 1,
+	  { 1u << 0, 1u << 2, 1u << 2, 1u << 2 },
+	  { DV_I_45_0_BIT | DV_II_45_0_BIT,
+	    DV_I_46_2_BIT | DV_II_46_2_BIT,
+	    DV_I_47_2_BIT,
+	    DV_I_48_2_BIT } }
+};
+
+static const struct ubc_cond neon_tail_checks[] = {
+	/* DV_I_43_0 */
+	{ 41, 4, 43, 4, 1 },
+	{ 58, 0, 59, 5, 1 },
+	{ 58, 0, 63, 30, 1 },
+	{ 61, 1, 62, 6, 1 },
+	{ 43, 4, 47, 29, 0 },
+	/* DV_I_44_0 */
+	{ 40, 4, 42, 4, 1 },
+	{ 59, 0, 60, 5, 1 },
+	{ 59, 0, 64, 30, 1 },
+	{ 62, 1, 63, 6, 1 },
+	{ 44, 4, 48, 29, 0 },
+	/* DV_I_45_0 */
+	{ 41, 4, 43, 4, 1 },
+	{ 63, 1, 64, 6, 1 },
+	{ 35, 4, 39, 29, 0 },
+	/* DV_I_46_0 */
+	{ 40, 4, 42, 4, 1 },
+	{ 44, 4, 46, 4, 1 },
+	{ 61, 0, 62, 5, 1 },
+	/* DV_I_46_2 */
+	{ 39, 1, 42, 6, 1 },
+	/* DV_I_47_0 */
+	{ 41, 4, 43, 4, 1 },
+	{ 45, 4, 47, 4, 1 },
+	{ 62, 0, 63, 5, 1 },
+	{ 37, 4, 41, 29, 0 },
+	/* DV_I_48_0 */
+	{ 44, 4, 46, 4, 1 },
+	{ 46, 4, 48, 4, 1 },
+	{ 63, 0, 64, 5, 1 },
+	{ 35, 4, 39, 29, 0 },
+	{ 38, 4, 42, 29, 0 },
+	/* DV_I_49_0 */
+	{ 45, 4, 47, 4, 1 },
+	{ 39, 4, 43, 29, 0 },
+	{ 49, 4, 52, 29, 0 },
+	/* DV_I_49_2 */
+	{ 42, 1, 50, 1, 1 },
+	/* DV_I_50_0 */
+	{ 36, 4, 37, 4, 1 },
+	{ 44, 4, 46, 4, 1 },
+	{ 46, 4, 48, 4, 1 },
+	{ 37, 4, 41, 29, 0 },
+	{ 40, 4, 44, 29, 0 },
+	{ 50, 4, 53, 29, 0 },
+	/* DV_I_50_2 */
+	{ 48, 6, 51, 1, 0 },
+	/* DV_I_51_0 */
+	{ 37, 4, 38, 4, 1 },
+	{ 45, 4, 47, 4, 1 },
+	{ 35, 3, 39, 28, 0 },
+	{ 38, 4, 42, 29, 0 },
+	{ 41, 4, 45, 29, 0 },
+	{ 49, 4, 52, 29, 0 },
+	{ 51, 4, 54, 29, 0 },
+	/* DV_I_51_2 */
+	{ 44, 1, 51, 6, 1 },
+	{ 44, 1, 52, 1, 1 },
+	{ 35, 5, 39, 30, 0 },
+	{ 37, 1, 37, 6, 0 },
+	/* DV_I_52_0 */
+	{ 38, 4, 39, 4, 1 },
+	{ 46, 4, 48, 4, 1 },
+	{ 39, 4, 43, 29, 0 },
+	{ 42, 4, 46, 29, 0 },
+	{ 50, 4, 53, 29, 0 },
+	{ 52, 4, 55, 29, 0 },
+	/* DV_II_45_0 */
+	{ 63, 1, 64, 6, 1 },
+	{ 41, 4, 45, 29, 0 },
+	{ 49, 4, 52, 29, 0 },
+	/* DV_II_46_0 */
+	{ 61, 0, 62, 5, 1 },
+	{ 37, 4, 41, 29, 0 },
+	{ 42, 4, 46, 29, 0 },
+	{ 50, 4, 53, 29, 0 },
+	/* DV_II_46_2 */
+	{ 48, 6, 51, 1, 0 },
+	/* DV_II_47_0 */
+	{ 62, 0, 63, 5, 1 },
+	{ 35, 3, 39, 28, 0 },
+	{ 35, 4, 39, 29, 0 },
+	{ 38, 4, 42, 29, 0 },
+	{ 43, 4, 47, 29, 0 },
+	{ 49, 4, 52, 29, 0 },
+	{ 51, 4, 54, 29, 0 },
+	/* DV_II_48_0 */
+	{ 35, 30, 36, 3, 1 },
+	{ 35, 30, 40, 28, 1 },
+	{ 63, 0, 64, 5, 1 },
+	{ 39, 4, 43, 29, 0 },
+	{ 44, 4, 48, 29, 0 },
+	{ 50, 4, 53, 29, 0 },
+	{ 52, 4, 55, 29, 0 },
+	/* DV_II_49_0 */
+	{ 36, 30, 37, 3, 1 },
+	{ 36, 30, 41, 28, 1 },
+	{ 37, 4, 41, 29, 0 },
+	{ 40, 4, 44, 29, 0 },
+	{ 51, 4, 54, 29, 0 },
+	{ 53, 4, 56, 29, 0 },
+	/* DV_II_49_2 */
+	{ 50, 1, 51, 6, 1 },
+	{ 50, 1, 53, 6, 1 },
+	{ 50, 1, 54, 1, 1 },
+	/* DV_II_50_0 */
+	{ 37, 30, 38, 3, 1 },
+	{ 37, 30, 42, 28, 1 },
+	{ 38, 4, 42, 29, 0 },
+	{ 41, 4, 45, 29, 0 },
+	{ 52, 4, 55, 29, 0 },
+	{ 54, 4, 57, 29, 0 },
+	/* DV_II_50_2 */
+	{ 51, 1, 52, 6, 1 },
+	{ 51, 1, 54, 6, 1 },
+	{ 51, 1, 55, 1, 1 },
+	/* DV_II_51_0 */
+	{ 38, 30, 39, 3, 1 },
+	{ 38, 30, 43, 28, 1 },
+	{ 56, 29, 59, 29, 1 },
+	{ 39, 4, 43, 29, 0 },
+	{ 42, 4, 46, 29, 0 },
+	{ 53, 4, 56, 29, 0 },
+	{ 55, 4, 58, 29, 0 },
+	/* DV_II_51_2 */
+	{ 52, 1, 53, 6, 1 },
+	{ 52, 1, 55, 6, 1 },
+	{ 52, 1, 56, 1, 1 },
+	/* DV_II_52_0 */
+	{ 39, 30, 40, 3, 1 },
+	{ 39, 30, 44, 28, 1 },
+	{ 54, 4, 56, 4, 1 },
+	{ 54, 4, 60, 29, 1 },
+	{ 56, 29, 59, 29, 1 },
+	{ 40, 4, 44, 29, 0 },
+	{ 43, 4, 47, 29, 0 },
+	{ 54, 4, 57, 29, 0 },
+	{ 56, 4, 59, 29, 0 },
+	/* DV_II_53_0 */
+	{ 55, 4, 57, 4, 1 },
+	{ 55, 4, 61, 29, 1 },
+	{ 41, 3, 45, 28, 0 },
+	{ 41, 4, 45, 29, 0 },
+	{ 44, 4, 48, 29, 0 },
+	{ 49, 4, 52, 29, 0 },
+	{ 55, 4, 58, 29, 0 },
+	{ 55, 4, 57, 29, 0 },
+	/* DV_II_54_0 */
+	{ 42, 3, 46, 28, 0 },
+	{ 42, 4, 46, 29, 0 },
+	{ 50, 4, 53, 29, 0 },
+	{ 56, 4, 59, 29, 0 },
+	{ 56, 4, 58, 29, 0 },
+	{ 58, 4, 62, 29, 0 },
+	/* DV_II_55_0 */
+	{ 43, 3, 47, 28, 0 },
+	{ 43, 4, 47, 29, 0 },
+	{ 51, 4, 54, 29, 0 },
+	{ 57, 4, 59, 29, 0 },
+	{ 59, 4, 63, 29, 0 },
+	/* DV_II_56_0 */
+	{ 40, 4, 42, 4, 1 },
+	{ 44, 3, 48, 28, 0 },
+	{ 44, 4, 48, 29, 0 },
+	{ 52, 4, 55, 29, 0 },
+	{ 60, 4, 64, 29, 0 }
+};
+
+static const struct tail_span neon_tail_spans[32] = {
+	{ 0, 5 },	/* DV_I_43_0 */
+	{ 5, 5 },	/* DV_I_44_0 */
+	{ 10, 3 },	/* DV_I_45_0 */
+	{ 13, 3 },	/* DV_I_46_0 */
+	{ 16, 1 },	/* DV_I_46_2 */
+	{ 17, 4 },	/* DV_I_47_0 */
+	{ 21, 0 },	/* DV_I_47_2 */
+	{ 21, 5 },	/* DV_I_48_0 */
+	{ 26, 0 },	/* DV_I_48_2 */
+	{ 26, 3 },	/* DV_I_49_0 */
+	{ 29, 1 },	/* DV_I_49_2 */
+	{ 30, 6 },	/* DV_I_50_0 */
+	{ 36, 1 },	/* DV_I_50_2 */
+	{ 37, 7 },	/* DV_I_51_0 */
+	{ 44, 4 },	/* DV_I_51_2 */
+	{ 48, 6 },	/* DV_I_52_0 */
+	{ 54, 3 },	/* DV_II_45_0 */
+	{ 57, 4 },	/* DV_II_46_0 */
+	{ 61, 1 },	/* DV_II_46_2 */
+	{ 62, 7 },	/* DV_II_47_0 */
+	{ 69, 7 },	/* DV_II_48_0 */
+	{ 76, 6 },	/* DV_II_49_0 */
+	{ 82, 3 },	/* DV_II_49_2 */
+	{ 85, 6 },	/* DV_II_50_0 */
+	{ 91, 3 },	/* DV_II_50_2 */
+	{ 94, 7 },	/* DV_II_51_0 */
+	{ 101, 3 },	/* DV_II_51_2 */
+	{ 104, 9 },	/* DV_II_52_0 */
+	{ 113, 8 },	/* DV_II_53_0 */
+	{ 121, 6 },	/* DV_II_54_0 */
+	{ 127, 5 },	/* DV_II_55_0 */
+	{ 132, 5 }	/* DV_II_56_0 */
+};
+
+static uint32_t neon_prefix(const uint32_t *w)
+{
+	uint32x4_t acc = vdupq_n_u32(0);
+	uint32x2_t folded;
+	size_t i;
+
+	UNROLL_TABLE
+	for (i = 0; i < ARRAY_SIZE(neon_groups); i++) {
+		const struct ubc_group4 *g = &neon_groups[i];
+		uint32x4_t lo = vld1q_u32(w + g->lo);
+		uint32x4_t hi = vld1q_u32(w + g->hi);
+		uint32x4_t dvs = vld1q_u32(g->dvs);
+		uint32x4_t set, fail;
+
+		lo = vshlq_u32(lo, vdupq_n_s32(-(int32_t)g->lo_shift));
+		hi = vshlq_u32(hi, vdupq_n_s32(-(int32_t)g->hi_shift));
+		set = vtstq_u32(veorq_u32(lo, hi), vld1q_u32(g->test));
+		/*
+		 * The DVs of the lanes where the bit is not g->want. Each lane
+		 * of set is all ones or zero, so a saturating subtraction keeps
+		 * dvs where the bit is clear, and min keeps it where it is set.
+		 */
+		fail = g->want ? vqsubq_u32(dvs, set) : vminq_u32(set, dvs);
+		acc = vorrq_u32(acc, fail);
+	}
+
+	folded = vorr_u32(vget_low_u32(acc), vget_high_u32(acc));
+	return ~vget_lane_u32(vorr_u32(folded, vdup_lane_u32(folded, 1)), 0);
+}
+
+uint32_t sha1dc_ubc_check_neon(const uint32_t w[80])
+{
+	uint32_t mask = neon_prefix(w);
+	/* Every check only clears bits, so an empty mask settles it. */
+	if (!mask)
+		return 0;
+	return run_tail(w, mask, neon_tail_checks, neon_tail_spans);
+}
+
+#endif /* SHA1DC_HAVE_NEON */
+
+/* sse2 form */
+
+#ifdef SHA1DC_HAVE_SSE2
+
+static const struct ubc_group4 sse2_groups[] = {
+	{ 35, 0, 36, 5, 1,
+	  { 1u << 1, 1u << 1, 1u << 1, 1u << 0 },
+	  { DV_I_46_2_BIT | DV_I_49_2_BIT,
+	    DV_I_47_2_BIT | DV_I_50_2_BIT | DV_II_46_2_BIT,
+	    DV_I_48_2_BIT | DV_I_51_2_BIT,
+	    DV_II_51_2_BIT } },
+	{ 36, 0, 37, 5, 1,
+	  { 1u << 0, 1u << 0, 1u << 1, 1u << 1 },
+	  { DV_II_49_2_BIT,
+	    DV_II_50_2_BIT,
+	    DV_I_49_2_BIT,
+	    DV_I_46_2_BIT | DV_I_50_2_BIT | DV_II_49_2_BIT } },
+	{ 36, 0, 38, 0, 1,
+	  { 1u << 4, 1u << 4, 1u << 1, 1u << 4 },
+	  { DV_II_52_0_BIT | DV_II_54_0_BIT,
+	    DV_I_43_0_BIT | DV_II_53_0_BIT | DV_II_55_0_BIT,
+	    DV_I_49_2_BIT,
+	    DV_I_43_0_BIT | DV_I_45_0_BIT | DV_II_55_0_BIT } },
+	{ 37, 0, 40, 25, 0,
+	  { 1u << 4, 1u << 4, 1u << 4, 1u << 4 },
+	  { DV_I_43_0_BIT | DV_I_47_0_BIT | DV_II_46_0_BIT |
+	    DV_II_53_0_BIT | DV_II_55_0_BIT,
+	    DV_I_44_0_BIT | DV_I_48_0_BIT | DV_II_47_0_BIT |
+	    DV_II_54_0_BIT | DV_II_56_0_BIT,
+	    DV_I_43_0_BIT | DV_I_45_0_BIT | DV_I_49_0_BIT | DV_II_48_0_BIT |
+	    DV_II_55_0_BIT,
+	    DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_50_0_BIT | DV_II_49_0_BIT |
+	    DV_II_56_0_BIT } },
+	{ 36, 0, 40, 25, 0,
+	  { 1u << 4, 1u << 5, 1u << 5, 1u << 5 },
+	  { DV_I_46_0_BIT | DV_I_49_0_BIT | DV_II_45_0_BIT |
+	    DV_II_48_0_BIT,
+	    DV_II_49_2_BIT,
+	    DV_II_50_2_BIT,
+	    DV_II_51_2_BIT } },
+	{ 38, 0, 40, 0, 1,
+	  { 1u << 4, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_I_44_0_BIT | DV_II_54_0_BIT | DV_II_56_0_BIT,
+	    DV_I_50_2_BIT | DV_II_49_2_BIT,
+	    DV_I_51_2_BIT | DV_II_50_2_BIT,
+	    DV_II_46_2_BIT | DV_II_51_2_BIT } },
+	{ 40, 0, 41, 5, 1,
+	  { 1u << 1, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_I_47_2_BIT | DV_I_51_2_BIT | DV_II_50_2_BIT,
+	    DV_I_48_2_BIT | DV_II_46_2_BIT | DV_II_51_2_BIT,
+	    DV_I_49_2_BIT,
+	    DV_I_50_2_BIT } },
+	{ 40, 0, 41, 0, 0,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 29 },
+	  { DV_I_44_0_BIT | DV_I_47_0_BIT | DV_I_48_0_BIT | DV_II_46_0_BIT |
+	    DV_II_47_0_BIT | DV_II_56_0_BIT,
+	    DV_I_45_0_BIT | DV_I_48_0_BIT | DV_I_49_0_BIT | DV_II_47_0_BIT |
+	    DV_II_48_0_BIT,
+	    DV_I_46_0_BIT | DV_I_49_0_BIT | DV_I_50_0_BIT | DV_II_48_0_BIT |
+	    DV_II_49_0_BIT,
+	    DV_I_47_0_BIT | DV_I_50_0_BIT | DV_I_51_0_BIT | DV_II_45_0_BIT |
+	    DV_II_49_0_BIT | DV_II_50_0_BIT } },
+	{ 41, 0, 44, 25, 0,
+	  { 1u << 4, 1u << 4, 1u << 4, 1u << 4 },
+	  { DV_I_43_0_BIT | DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_51_0_BIT |
+	    DV_II_45_0_BIT | DV_II_50_0_BIT,
+	    DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_48_0_BIT | DV_I_52_0_BIT |
+	    DV_II_46_0_BIT | DV_II_51_0_BIT,
+	    DV_I_43_0_BIT | DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_49_0_BIT |
+	    DV_II_47_0_BIT | DV_II_52_0_BIT,
+	    DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_48_0_BIT | DV_I_50_0_BIT |
+	    DV_II_48_0_BIT | DV_II_53_0_BIT } },
+	{ 42, 0, 44, 0, 0,
+	  { 1u << 6, 1u << 6, 1u << 6, 1u << 6 },
+	  { DV_I_46_2_BIT | DV_I_48_2_BIT,
+	    DV_I_47_2_BIT | DV_I_49_2_BIT,
+	    DV_I_46_2_BIT | DV_I_48_2_BIT | DV_I_50_2_BIT,
+	    DV_I_47_2_BIT | DV_I_49_2_BIT | DV_I_51_2_BIT } },
+	{ 40, 0, 44, 0, 0,
+	  { 1u << 6, 1u << 6, 1u << 29, 1u << 29 },
+	  { DV_I_46_2_BIT,
+	    DV_I_47_2_BIT,
+	    DV_I_43_0_BIT | DV_I_45_0_BIT,
+	    DV_I_44_0_BIT | DV_I_46_0_BIT } },
+	{ 44, 0, 45, 5, 1,
+	  { 1u << 1, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_I_51_2_BIT | DV_II_49_2_BIT,
+	    DV_II_50_2_BIT,
+	    DV_II_51_2_BIT,
+	    DV_II_46_2_BIT } },
+	{ 44, 0, 45, 0, 0,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 29 },
+	  { DV_I_48_0_BIT | DV_I_51_0_BIT | DV_I_52_0_BIT | DV_II_45_0_BIT |
+	    DV_II_46_0_BIT | DV_II_50_0_BIT | DV_II_51_0_BIT,
+	    DV_I_49_0_BIT | DV_I_52_0_BIT | DV_II_46_0_BIT |
+	    DV_II_47_0_BIT | DV_II_51_0_BIT | DV_II_52_0_BIT,
+	    DV_I_43_0_BIT | DV_I_50_0_BIT | DV_II_47_0_BIT |
+	    DV_II_48_0_BIT | DV_II_52_0_BIT | DV_II_53_0_BIT,
+	    DV_I_44_0_BIT | DV_I_51_0_BIT | DV_II_48_0_BIT |
+	    DV_II_49_0_BIT | DV_II_53_0_BIT | DV_II_54_0_BIT } },
+	{ 45, 5, 46, 0, 0,
+	  { 1u << 1, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_II_49_2_BIT,
+	    DV_I_46_2_BIT | DV_II_50_2_BIT,
+	    DV_I_47_2_BIT | DV_II_51_2_BIT,
+	    DV_I_48_2_BIT } },
+	{ 45, 0, 47, 0, 1,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 4 },
+	  { DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_48_0_BIT,
+	    DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_49_0_BIT,
+	    DV_I_46_0_BIT | DV_I_48_0_BIT | DV_I_50_0_BIT,
+	    DV_I_50_0_BIT | DV_I_52_0_BIT | DV_II_46_0_BIT } },
+	{ 46, 0, 48, 0, 0,
+	  { 1u << 6, 1u << 6, 1u << 6, 1u << 6 },
+	  { DV_I_48_2_BIT | DV_I_50_2_BIT,
+	    DV_I_49_2_BIT | DV_I_51_2_BIT,
+	    DV_I_50_2_BIT | DV_II_46_2_BIT,
+	    DV_I_51_2_BIT } },
+	{ 45, 0, 48, 25, 0,
+	  { 1u << 4, 1u << 4, 1u << 4, 1u << 4 },
+	  { DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_49_0_BIT | DV_I_51_0_BIT |
+	    DV_II_49_0_BIT | DV_II_54_0_BIT,
+	    DV_I_46_0_BIT | DV_I_48_0_BIT | DV_I_50_0_BIT | DV_I_52_0_BIT |
+	    DV_II_50_0_BIT | DV_II_55_0_BIT,
+	    DV_I_47_0_BIT | DV_I_49_0_BIT | DV_I_51_0_BIT | DV_II_45_0_BIT |
+	    DV_II_51_0_BIT | DV_II_56_0_BIT,
+	    DV_I_48_0_BIT | DV_I_50_0_BIT | DV_I_52_0_BIT | DV_II_46_0_BIT |
+	    DV_II_52_0_BIT } },
+	{ 48, 0, 49, 0, 0,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 29 },
+	  { DV_I_45_0_BIT | DV_I_52_0_BIT | DV_II_49_0_BIT |
+	    DV_II_50_0_BIT | DV_II_54_0_BIT | DV_II_55_0_BIT,
+	    DV_I_46_0_BIT | DV_II_45_0_BIT | DV_II_50_0_BIT |
+	    DV_II_51_0_BIT | DV_II_55_0_BIT | DV_II_56_0_BIT,
+	    DV_I_47_0_BIT | DV_II_46_0_BIT | DV_II_51_0_BIT |
+	    DV_II_52_0_BIT | DV_II_56_0_BIT,
+	    DV_I_48_0_BIT | DV_II_47_0_BIT | DV_II_52_0_BIT |
+	    DV_II_53_0_BIT } },
+	{ 49, 5, 50, 0, 0,
+	  { 1u << 1, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_I_49_2_BIT,
+	    DV_I_50_2_BIT | DV_II_46_2_BIT,
+	    DV_I_51_2_BIT,
+	    0 } },
+	{ 49, 0, 52, 25, 0,
+	  { 1u << 4, 1u << 4, 1u << 4, 1u << 4 },
+	  { DV_I_49_0_BIT | DV_I_51_0_BIT | DV_II_45_0_BIT |
+	    DV_II_47_0_BIT | DV_II_53_0_BIT,
+	    DV_I_50_0_BIT | DV_I_52_0_BIT | DV_II_46_0_BIT |
+	    DV_II_48_0_BIT | DV_II_54_0_BIT,
+	    DV_I_51_0_BIT | DV_II_47_0_BIT | DV_II_49_0_BIT |
+	    DV_II_55_0_BIT,
+	    DV_I_52_0_BIT | DV_II_48_0_BIT | DV_II_50_0_BIT |
+	    DV_II_56_0_BIT } },
+	{ 49, 0, 53, 0, 1,
+	  { 1u << 29, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_II_45_0_BIT,
+	    DV_II_49_2_BIT,
+	    DV_II_50_2_BIT,
+	    DV_II_51_2_BIT } },
+	{ 52, 0, 53, 0, 0,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 29 },
+	  { DV_I_49_0_BIT | DV_II_45_0_BIT | DV_II_48_0_BIT |
+	    DV_II_53_0_BIT | DV_II_54_0_BIT,
+	    DV_I_50_0_BIT | DV_II_46_0_BIT | DV_II_49_0_BIT |
+	    DV_II_54_0_BIT | DV_II_55_0_BIT,
+	    DV_I_51_0_BIT | DV_II_47_0_BIT | DV_II_50_0_BIT |
+	    DV_II_55_0_BIT | DV_II_56_0_BIT,
+	    DV_I_52_0_BIT | DV_II_48_0_BIT | DV_II_51_0_BIT |
+	    DV_II_56_0_BIT } },
+	{ 53, 5, 54, 0, 0,
+	  { 1u << 1, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_II_49_2_BIT,
+	    DV_II_50_2_BIT,
+	    DV_II_51_2_BIT,
+	    0 } },
+	{ 52, 0, 55, 0, 1,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 29 },
+	  { DV_I_51_0_BIT | DV_II_47_0_BIT | DV_II_48_0_BIT,
+	    DV_I_52_0_BIT | DV_II_48_0_BIT | DV_II_49_0_BIT,
+	    DV_II_49_0_BIT | DV_II_50_0_BIT,
+	    DV_II_50_0_BIT | DV_II_51_0_BIT } },
+	{ 53, 0, 56, 25, 0,
+	  { 1u << 4, 1u << 4, 1u << 4, 1u << 4 },
+	  { DV_II_49_0_BIT | DV_II_51_0_BIT,
+	    DV_II_50_0_BIT | DV_II_52_0_BIT,
+	    DV_II_51_0_BIT | DV_II_53_0_BIT,
+	    DV_II_52_0_BIT | DV_II_54_0_BIT } },
+	{ 60, 0, 61, 5, 1,
+	  { 1u << 0, 1u << 2, 1u << 2, 1u << 2 },
+	  { DV_I_45_0_BIT | DV_II_45_0_BIT,
+	    DV_I_46_2_BIT | DV_II_46_2_BIT,
+	    DV_I_47_2_BIT,
+	    DV_I_48_2_BIT } }
+};
+
+static const struct ubc_cond sse2_tail_checks[] = {
+	/* DV_I_43_0 */
+	{ 41, 4, 43, 4, 1 },
+	{ 58, 0, 59, 5, 1 },
+	{ 58, 0, 63, 30, 1 },
+	{ 61, 1, 62, 6, 1 },
+	{ 43, 4, 47, 29, 0 },
+	/* DV_I_44_0 */
+	{ 59, 0, 60, 5, 1 },
+	{ 59, 0, 64, 30, 1 },
+	{ 62, 1, 63, 6, 1 },
+	{ 38, 4, 42, 4, 0 },
+	{ 44, 4, 48, 29, 0 },
+	/* DV_I_45_0 */
+	{ 41, 4, 43, 4, 1 },
+	{ 63, 1, 64, 6, 1 },
+	{ 35, 4, 39, 29, 0 },
+	/* DV_I_46_0 */
+	{ 61, 0, 62, 5, 1 },
+	/* DV_I_47_0 */
+	{ 41, 4, 43, 4, 1 },
+	{ 45, 4, 47, 4, 1 },
+	{ 62, 0, 63, 5, 1 },
+	{ 37, 4, 41, 29, 0 },
+	/* DV_I_48_0 */
+	{ 46, 4, 48, 4, 1 },
+	{ 63, 0, 64, 5, 1 },
+	{ 35, 4, 39, 29, 0 },
+	{ 38, 4, 42, 29, 0 },
+	/* DV_I_49_0 */
+	{ 45, 4, 47, 4, 1 },
+	{ 39, 4, 43, 29, 0 },
+	{ 45, 4, 49, 4, 0 },
+	/* DV_I_50_0 */
+	{ 36, 4, 37, 4, 1 },
+	{ 46, 4, 48, 4, 1 },
+	{ 37, 4, 41, 29, 0 },
+	{ 40, 4, 44, 29, 0 },
+	/* DV_I_51_0 */
+	{ 37, 4, 38, 4, 1 },
+	{ 45, 4, 47, 4, 1 },
+	{ 35, 3, 39, 28, 0 },
+	{ 38, 4, 42, 29, 0 },
+	{ 41, 4, 45, 29, 0 },
+	{ 45, 4, 49, 4, 0 },
+	/* DV_I_51_2 */
+	{ 35, 5, 39, 30, 0 },
+	{ 37, 1, 37, 6, 0 },
+	/* DV_I_52_0 */
+	{ 38, 4, 39, 4, 1 },
+	{ 46, 4, 48, 4, 1 },
+	{ 39, 4, 43, 29, 0 },
+	{ 42, 4, 46, 29, 0 },
+	/* DV_II_45_0 */
+	{ 63, 1, 64, 6, 1 },
+	{ 41, 4, 45, 29, 0 },
+	/* DV_II_46_0 */
+	{ 61, 0, 62, 5, 1 },
+	{ 37, 4, 41, 29, 0 },
+	{ 42, 4, 46, 29, 0 },
+	/* DV_II_47_0 */
+	{ 62, 0, 63, 5, 1 },
+	{ 35, 3, 39, 28, 0 },
+	{ 35, 4, 39, 29, 0 },
+	{ 38, 4, 42, 29, 0 },
+	{ 43, 4, 47, 29, 0 },
+	/* DV_II_48_0 */
+	{ 35, 30, 36, 3, 1 },
+	{ 35, 30, 40, 28, 1 },
+	{ 63, 0, 64, 5, 1 },
+	{ 39, 4, 43, 29, 0 },
+	{ 44, 4, 48, 29, 0 },
+	/* DV_II_49_0 */
+	{ 36, 30, 37, 3, 1 },
+	{ 36, 30, 41, 28, 1 },
+	{ 37, 4, 41, 29, 0 },
+	{ 40, 4, 44, 29, 0 },
+	/* DV_II_49_2 */
+	{ 50, 1, 51, 6, 1 },
+	/* DV_II_50_0 */
+	{ 37, 30, 38, 3, 1 },
+	{ 37, 30, 42, 28, 1 },
+	{ 38, 4, 42, 29, 0 },
+	{ 41, 4, 45, 29, 0 },
+	/* DV_II_50_2 */
+	{ 51, 1, 52, 6, 1 },
+	/* DV_II_51_0 */
+	{ 38, 30, 39, 3, 1 },
+	{ 38, 30, 43, 28, 1 },
+	{ 56, 29, 59, 29, 1 },
+	{ 39, 4, 43, 29, 0 },
+	{ 42, 4, 46, 29, 0 },
+	/* DV_II_51_2 */
+	{ 52, 1, 53, 6, 1 },
+	/* DV_II_52_0 */
+	{ 39, 30, 40, 3, 1 },
+	{ 39, 30, 44, 28, 1 },
+	{ 54, 4, 56, 4, 1 },
+	{ 54, 4, 60, 29, 1 },
+	{ 56, 29, 59, 29, 1 },
+	{ 40, 4, 44, 29, 0 },
+	{ 43, 4, 47, 29, 0 },
+	/* DV_II_53_0 */
+	{ 55, 4, 57, 4, 1 },
+	{ 55, 4, 61, 29, 1 },
+	{ 41, 3, 45, 28, 0 },
+	{ 41, 4, 45, 29, 0 },
+	{ 44, 4, 48, 29, 0 },
+	{ 55, 4, 57, 29, 0 },
+	/* DV_II_54_0 */
+	{ 42, 3, 46, 28, 0 },
+	{ 42, 4, 46, 29, 0 },
+	{ 56, 4, 58, 29, 0 },
+	{ 58, 4, 62, 29, 0 },
+	/* DV_II_55_0 */
+	{ 43, 3, 47, 28, 0 },
+	{ 43, 4, 47, 29, 0 },
+	{ 57, 4, 59, 29, 0 },
+	{ 59, 4, 63, 29, 0 },
+	/* DV_II_56_0 */
+	{ 38, 4, 42, 4, 0 },
+	{ 44, 3, 48, 28, 0 },
+	{ 44, 4, 48, 29, 0 },
+	{ 60, 4, 64, 29, 0 }
+};
+
+static const struct tail_span sse2_tail_spans[32] = {
+	{ 0, 5 },	/* DV_I_43_0 */
+	{ 5, 5 },	/* DV_I_44_0 */
+	{ 10, 3 },	/* DV_I_45_0 */
+	{ 13, 1 },	/* DV_I_46_0 */
+	{ 14, 0 },	/* DV_I_46_2 */
+	{ 14, 4 },	/* DV_I_47_0 */
+	{ 18, 0 },	/* DV_I_47_2 */
+	{ 18, 4 },	/* DV_I_48_0 */
+	{ 22, 0 },	/* DV_I_48_2 */
+	{ 22, 3 },	/* DV_I_49_0 */
+	{ 25, 0 },	/* DV_I_49_2 */
+	{ 25, 4 },	/* DV_I_50_0 */
+	{ 29, 0 },	/* DV_I_50_2 */
+	{ 29, 6 },	/* DV_I_51_0 */
+	{ 35, 2 },	/* DV_I_51_2 */
+	{ 37, 4 },	/* DV_I_52_0 */
+	{ 41, 2 },	/* DV_II_45_0 */
+	{ 43, 3 },	/* DV_II_46_0 */
+	{ 46, 0 },	/* DV_II_46_2 */
+	{ 46, 5 },	/* DV_II_47_0 */
+	{ 51, 5 },	/* DV_II_48_0 */
+	{ 56, 4 },	/* DV_II_49_0 */
+	{ 60, 1 },	/* DV_II_49_2 */
+	{ 61, 4 },	/* DV_II_50_0 */
+	{ 65, 1 },	/* DV_II_50_2 */
+	{ 66, 5 },	/* DV_II_51_0 */
+	{ 71, 1 },	/* DV_II_51_2 */
+	{ 72, 7 },	/* DV_II_52_0 */
+	{ 79, 6 },	/* DV_II_53_0 */
+	{ 85, 4 },	/* DV_II_54_0 */
+	{ 89, 4 },	/* DV_II_55_0 */
+	{ 93, 4 }	/* DV_II_56_0 */
+};
+
+SHA1DC_TARGET_SSE2
+static uint32_t sse2_prefix(const uint32_t *w)
+{
+	const __m128i zero = _mm_setzero_si128();
+	__m128i acc = zero;
+	size_t i;
+
+	UNROLL_TABLE
+	for (i = 0; i < ARRAY_SIZE(sse2_groups); i++) {
+		const struct ubc_group4 *g = &sse2_groups[i];
+		__m128i lo = _mm_loadu_si128((const __m128i *)(w + g->lo));
+		__m128i hi = _mm_loadu_si128((const __m128i *)(w + g->hi));
+		__m128i test = _mm_loadu_si128((const __m128i *)g->test);
+		__m128i dvs = _mm_loadu_si128((const __m128i *)g->dvs);
+		__m128i clear, fail;
+
+		lo = _mm_srl_epi32(lo, _mm_cvtsi32_si128(g->lo_shift));
+		hi = _mm_srl_epi32(hi, _mm_cvtsi32_si128(g->hi_shift));
+		clear = _mm_and_si128(_mm_xor_si128(lo, hi), test);
+		clear = _mm_cmpeq_epi32(clear, zero);
+		/* The DVs of the lanes where the bit is not g->want. */
+		fail = g->want ? _mm_and_si128(clear, dvs) :
+				 _mm_andnot_si128(clear, dvs);
+		acc = _mm_or_si128(acc, fail);
+	}
+
+	acc = _mm_or_si128(acc, _mm_shuffle_epi32(acc, 0x4E));
+	acc = _mm_or_si128(acc, _mm_shuffle_epi32(acc, 0xB1));
+	return ~(uint32_t)_mm_cvtsi128_si32(acc);
+}
+
+SHA1DC_TARGET_SSE2
+uint32_t sha1dc_ubc_check_sse2(const uint32_t w[80])
+{
+	uint32_t mask = sse2_prefix(w);
+	/* Every check only clears bits, so an empty mask settles it. */
+	if (!mask)
+		return 0;
+	return run_tail(w, mask, sse2_tail_checks, sse2_tail_spans);
+}
+
+#endif /* SHA1DC_HAVE_SSE2 */
+
+/* avx2 form */
+
+#ifdef SHA1DC_HAVE_AVX2
+
+static const struct ubc_group8 avx2_groups[] = {
+	{ 35, 0, 36, 5, 1,
+	  { 1u << 1, 1u << 1, 1u << 1, 1u << 0,
+	    1u << 1, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_I_46_2_BIT | DV_I_49_2_BIT,
+	    DV_I_47_2_BIT | DV_I_50_2_BIT | DV_II_46_2_BIT,
+	    DV_I_48_2_BIT | DV_I_51_2_BIT,
+	    DV_II_51_2_BIT,
+	    DV_I_46_2_BIT | DV_I_50_2_BIT | DV_II_49_2_BIT,
+	    DV_I_47_2_BIT | DV_I_51_2_BIT | DV_II_50_2_BIT,
+	    DV_I_48_2_BIT | DV_II_46_2_BIT | DV_II_51_2_BIT,
+	    DV_I_49_2_BIT } },
+	{ 36, 0, 38, 0, 1,
+	  { 1u << 4, 1u << 4, 1u << 4, 1u << 4,
+	    1u << 4, 1u << 4, 1u << 4, 1u << 4 },
+	  { DV_II_52_0_BIT | DV_II_54_0_BIT,
+	    DV_I_43_0_BIT | DV_II_53_0_BIT | DV_II_55_0_BIT,
+	    DV_I_44_0_BIT | DV_II_54_0_BIT | DV_II_56_0_BIT,
+	    DV_I_43_0_BIT | DV_I_45_0_BIT | DV_II_55_0_BIT,
+	    DV_I_44_0_BIT | DV_I_46_0_BIT | DV_II_56_0_BIT,
+	    DV_I_43_0_BIT | DV_I_45_0_BIT | DV_I_47_0_BIT,
+	    DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_48_0_BIT,
+	    DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_49_0_BIT } },
+	{ 37, 0, 38, 5, 1,
+	  { 1u << 0, 1u << 1, 0, 0,
+	    0, 0, 1u << 1, 1u << 1 },
+	  { DV_II_50_2_BIT,
+	    DV_I_49_2_BIT,
+	    0,
+	    0,
+	    0,
+	    0,
+	    DV_I_50_2_BIT,
+	    DV_I_51_2_BIT | DV_II_49_2_BIT } },
+	{ 35, 0, 39, 25, 0,
+	  { 1u << 5, 1u << 4, 1u << 5, 1u << 5,
+	    1u << 5, 1u << 3, 1u << 3, 1u << 4 },
+	  { DV_I_51_2_BIT,
+	    DV_I_46_0_BIT | DV_I_49_0_BIT | DV_II_45_0_BIT |
+	    DV_II_48_0_BIT,
+	    DV_II_49_2_BIT,
+	    DV_II_50_2_BIT,
+	    DV_II_51_2_BIT,
+	    DV_II_52_0_BIT,
+	    DV_II_53_0_BIT,
+	    DV_I_52_0_BIT | DV_II_46_0_BIT | DV_II_51_0_BIT |
+	    DV_II_54_0_BIT } },
+	{ 37, 0, 40, 25, 0,
+	  { 1u << 4, 1u << 4, 1u << 4, 1u << 4,
+	    1u << 4, 1u << 4, 1u << 4, 1u << 4 },
+	  { DV_I_43_0_BIT | DV_I_47_0_BIT | DV_II_46_0_BIT |
+	    DV_II_53_0_BIT | DV_II_55_0_BIT,
+	    DV_I_44_0_BIT | DV_I_48_0_BIT | DV_II_47_0_BIT |
+	    DV_II_54_0_BIT | DV_II_56_0_BIT,
+	    DV_I_43_0_BIT | DV_I_45_0_BIT | DV_I_49_0_BIT | DV_II_48_0_BIT |
+	    DV_II_55_0_BIT,
+	    DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_50_0_BIT | DV_II_49_0_BIT |
+	    DV_II_56_0_BIT,
+	    DV_I_43_0_BIT | DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_51_0_BIT |
+	    DV_II_45_0_BIT | DV_II_50_0_BIT,
+	    DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_48_0_BIT | DV_I_52_0_BIT |
+	    DV_II_46_0_BIT | DV_II_51_0_BIT,
+	    DV_I_43_0_BIT | DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_49_0_BIT |
+	    DV_II_47_0_BIT | DV_II_52_0_BIT,
+	    DV_I_44_0_BIT | DV_I_46_0_BIT | DV_I_48_0_BIT | DV_I_50_0_BIT |
+	    DV_II_48_0_BIT | DV_II_53_0_BIT } },
+	{ 39, 5, 40, 0, 0,
+	  { 1u << 1, 1u << 1, 1u << 1, 1u << 1,
+	    1u << 1, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_I_49_2_BIT,
+	    DV_I_50_2_BIT | DV_II_49_2_BIT,
+	    DV_I_51_2_BIT | DV_II_50_2_BIT,
+	    DV_II_46_2_BIT | DV_II_51_2_BIT,
+	    0,
+	    0,
+	    DV_II_49_2_BIT,
+	    DV_I_46_2_BIT | DV_II_50_2_BIT } },
+	{ 40, 0, 41, 0, 0,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 29,
+	    1u << 29, 1u << 29, 1u << 29, 1u << 29 },
+	  { DV_I_44_0_BIT | DV_I_47_0_BIT | DV_I_48_0_BIT | DV_II_46_0_BIT |
+	    DV_II_47_0_BIT | DV_II_56_0_BIT,
+	    DV_I_45_0_BIT | DV_I_48_0_BIT | DV_I_49_0_BIT | DV_II_47_0_BIT |
+	    DV_II_48_0_BIT,
+	    DV_I_46_0_BIT | DV_I_49_0_BIT | DV_I_50_0_BIT | DV_II_48_0_BIT |
+	    DV_II_49_0_BIT,
+	    DV_I_47_0_BIT | DV_I_50_0_BIT | DV_I_51_0_BIT | DV_II_45_0_BIT |
+	    DV_II_49_0_BIT | DV_II_50_0_BIT,
+	    DV_I_48_0_BIT | DV_I_51_0_BIT | DV_I_52_0_BIT | DV_II_45_0_BIT |
+	    DV_II_46_0_BIT | DV_II_50_0_BIT | DV_II_51_0_BIT,
+	    DV_I_49_0_BIT | DV_I_52_0_BIT | DV_II_46_0_BIT |
+	    DV_II_47_0_BIT | DV_II_51_0_BIT | DV_II_52_0_BIT,
+	    DV_I_43_0_BIT | DV_I_50_0_BIT | DV_II_47_0_BIT |
+	    DV_II_48_0_BIT | DV_II_52_0_BIT | DV_II_53_0_BIT,
+	    DV_I_44_0_BIT | DV_I_51_0_BIT | DV_II_48_0_BIT |
+	    DV_II_49_0_BIT | DV_II_53_0_BIT | DV_II_54_0_BIT } },
+	{ 40, 0, 42, 0, 0,
+	  { 1u << 6, 1u << 6, 1u << 6, 1u << 6,
+	    1u << 6, 1u << 6, 1u << 6, 1u << 6 },
+	  { DV_I_46_2_BIT,
+	    DV_I_47_2_BIT,
+	    DV_I_46_2_BIT | DV_I_48_2_BIT,
+	    DV_I_47_2_BIT | DV_I_49_2_BIT,
+	    DV_I_46_2_BIT | DV_I_48_2_BIT | DV_I_50_2_BIT,
+	    DV_I_47_2_BIT | DV_I_49_2_BIT | DV_I_51_2_BIT,
+	    DV_I_48_2_BIT | DV_I_50_2_BIT,
+	    DV_I_49_2_BIT | DV_I_51_2_BIT } },
+	{ 45, 0, 46, 5, 1,
+	  { 1u << 1, 1u << 1, 1u << 1, 1u << 1,
+	    1u << 1, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_II_50_2_BIT,
+	    DV_II_51_2_BIT,
+	    DV_II_46_2_BIT,
+	    0,
+	    0,
+	    DV_II_49_2_BIT,
+	    DV_II_50_2_BIT,
+	    DV_II_51_2_BIT } },
+	{ 45, 0, 48, 25, 0,
+	  { 1u << 4, 1u << 4, 1u << 4, 1u << 4,
+	    1u << 4, 1u << 4, 1u << 4, 1u << 4 },
+	  { DV_I_45_0_BIT | DV_I_47_0_BIT | DV_I_49_0_BIT | DV_I_51_0_BIT |
+	    DV_II_49_0_BIT | DV_II_54_0_BIT,
+	    DV_I_46_0_BIT | DV_I_48_0_BIT | DV_I_50_0_BIT | DV_I_52_0_BIT |
+	    DV_II_50_0_BIT | DV_II_55_0_BIT,
+	    DV_I_47_0_BIT | DV_I_49_0_BIT | DV_I_51_0_BIT | DV_II_45_0_BIT |
+	    DV_II_51_0_BIT | DV_II_56_0_BIT,
+	    DV_I_48_0_BIT | DV_I_50_0_BIT | DV_I_52_0_BIT | DV_II_46_0_BIT |
+	    DV_II_52_0_BIT,
+	    DV_I_49_0_BIT | DV_I_51_0_BIT | DV_II_45_0_BIT |
+	    DV_II_47_0_BIT | DV_II_53_0_BIT,
+	    DV_I_50_0_BIT | DV_I_52_0_BIT | DV_II_46_0_BIT |
+	    DV_II_48_0_BIT | DV_II_54_0_BIT,
+	    DV_I_51_0_BIT | DV_II_47_0_BIT | DV_II_49_0_BIT |
+	    DV_II_55_0_BIT,
+	    DV_I_52_0_BIT | DV_II_48_0_BIT | DV_II_50_0_BIT |
+	    DV_II_56_0_BIT } },
+	{ 47, 5, 48, 0, 0,
+	  { 1u << 1, 1u << 1, 1u << 1, 1u << 1,
+	    1u << 1, 1u << 1, 1u << 1, 1u << 1 },
+	  { DV_I_47_2_BIT | DV_II_51_2_BIT,
+	    DV_I_48_2_BIT,
+	    DV_I_49_2_BIT,
+	    DV_I_50_2_BIT | DV_II_46_2_BIT,
+	    DV_I_51_2_BIT,
+	    0,
+	    DV_II_49_2_BIT,
+	    DV_II_50_2_BIT } },
+	{ 47, 0, 49, 0, 1,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 29,
+	    1u << 4, 1u << 4, 1u << 4, 1u << 4 },
+	  { DV_I_46_0_BIT | DV_I_48_0_BIT | DV_I_50_0_BIT,
+	    DV_I_47_0_BIT | DV_I_49_0_BIT | DV_I_51_0_BIT,
+	    DV_I_48_0_BIT | DV_I_50_0_BIT | DV_I_52_0_BIT,
+	    DV_I_49_0_BIT | DV_I_51_0_BIT | DV_II_45_0_BIT,
+	    DV_II_49_0_BIT,
+	    DV_II_50_0_BIT,
+	    DV_II_51_0_BIT,
+	    DV_II_52_0_BIT } },
+	{ 48, 0, 49, 0, 0,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 29,
+	    1u << 29, 1u << 29, 1u << 29, 1u << 29 },
+	  { DV_I_45_0_BIT | DV_I_52_0_BIT | DV_II_49_0_BIT |
+	    DV_II_50_0_BIT | DV_II_54_0_BIT | DV_II_55_0_BIT,
+	    DV_I_46_0_BIT | DV_II_45_0_BIT | DV_II_50_0_BIT |
+	    DV_II_51_0_BIT | DV_II_55_0_BIT | DV_II_56_0_BIT,
+	    DV_I_47_0_BIT | DV_II_46_0_BIT | DV_II_51_0_BIT |
+	    DV_II_52_0_BIT | DV_II_56_0_BIT,
+	    DV_I_48_0_BIT | DV_II_47_0_BIT | DV_II_52_0_BIT |
+	    DV_II_53_0_BIT,
+	    DV_I_49_0_BIT | DV_II_45_0_BIT | DV_II_48_0_BIT |
+	    DV_II_53_0_BIT | DV_II_54_0_BIT,
+	    DV_I_50_0_BIT | DV_II_46_0_BIT | DV_II_49_0_BIT |
+	    DV_II_54_0_BIT | DV_II_55_0_BIT,
+	    DV_I_51_0_BIT | DV_II_47_0_BIT | DV_II_50_0_BIT |
+	    DV_II_55_0_BIT | DV_II_56_0_BIT,
+	    DV_I_52_0_BIT | DV_II_48_0_BIT | DV_II_51_0_BIT |
+	    DV_II_56_0_BIT } },
+	{ 48, 0, 50, 0, 0,
+	  { 1u << 6, 1u << 6, 1u << 6, 1u << 6,
+	    1u << 6, 1u << 6, 1u << 6, 1u << 6 },
+	  { DV_I_50_2_BIT | DV_II_46_2_BIT,
+	    DV_I_51_2_BIT,
+	    0,
+	    DV_II_49_2_BIT,
+	    DV_II_50_2_BIT,
+	    DV_II_51_2_BIT,
+	    0,
+	    0 } },
+	{ 51, 0, 54, 0, 1,
+	  { 1u << 29, 1u << 29, 1u << 29, 1u << 29,
+	    1u << 29, 1u << 29, 1u << 29, 1u << 29 },
+	  { DV_I_50_0_BIT | DV_II_46_0_BIT | DV_II_47_0_BIT,
+	    DV_I_51_0_BIT | DV_II_47_0_BIT | DV_II_48_0_BIT,
+	    DV_I_52_0_BIT | DV_II_48_0_BIT | DV_II_49_0_BIT,
+	    DV_II_49_0_BIT | DV_II_50_0_BIT,
+	    DV_II_50_0_BIT | DV_II_51_0_BIT,
+	    DV_II_51_0_BIT | DV_II_52_0_BIT,
+	    DV_II_52_0_BIT,
+	    DV_II_53_0_BIT } },
+	{ 58, 0, 59, 5, 1,
+	  { 1u << 0, 1u << 0, 1u << 0, 1u << 2,
+	    1u << 2, 1u << 2, 0, 0 },
+	  { DV_I_43_0_BIT,
+	    DV_I_44_0_BIT,
+	    DV_I_45_0_BIT | DV_II_45_0_BIT,
+	    DV_I_46_2_BIT | DV_II_46_2_BIT,
+	    DV_I_47_2_BIT,
+	    DV_I_48_2_BIT,
+	    0,
+	    0 } }
+};
+
+static const struct ubc_cond avx2_tail_checks[] = {
+	/* DV_I_43_0 */
+	{ 58, 0, 63, 30, 1 },
+	{ 61, 1, 62, 6, 1 },
+	{ 43, 4, 47, 29, 0 },
+	/* DV_I_44_0 */
+	{ 59, 0, 64, 30, 1 },
+	{ 62, 1, 63, 6, 1 },
+	{ 44, 4, 48, 29, 0 },
+	/* DV_I_45_0 */
+	{ 63, 1, 64, 6, 1 },
+	{ 35, 4, 39, 29, 0 },
+	/* DV_I_46_0 */
+	{ 61, 0, 62, 5, 1 },
+	/* DV_I_47_0 */
+	{ 62, 0, 63, 5, 1 },
+	{ 37, 4, 41, 29, 0 },
+	/* DV_I_48_0 */
+	{ 63, 0, 64, 5, 1 },
+	{ 35, 4, 39, 29, 0 },
+	{ 38, 4, 42, 29, 0 },
+	/* DV_I_49_0 */
+	{ 39, 4, 43, 29, 0 },
+	/* DV_I_50_0 */
+	{ 36, 4, 37, 4, 1 },
+	{ 37, 4, 41, 29, 0 },
+	{ 40, 4, 44, 29, 0 },
+	{ 46, 4, 50, 4, 0 },
+	/* DV_I_51_0 */
+	{ 37, 4, 38, 4, 1 },
+	{ 35, 3, 39, 28, 0 },
+	{ 38, 4, 42, 29, 0 },
+	{ 41, 4, 45, 29, 0 },
+	/* DV_I_51_2 */
+	{ 37, 1, 37, 6, 0 },
+	/* DV_I_52_0 */
+	{ 38, 4, 39, 4, 1 },
+	{ 39, 4, 43, 29, 0 },
+	{ 46, 4, 50, 4, 0 },
+	/* DV_II_45_0 */
+	{ 63, 1, 64, 6, 1 },
+	{ 41, 4, 45, 29, 0 },
+	/* DV_II_46_0 */
+	{ 61, 0, 62, 5, 1 },
+	{ 37, 4, 41, 29, 0 },
+	/* DV_II_47_0 */
+	{ 62, 0, 63, 5, 1 },
+	{ 35, 3, 39, 28, 0 },
+	{ 35, 4, 39, 29, 0 },
+	{ 38, 4, 42, 29, 0 },
+	{ 43, 4, 47, 29, 0 },
+	/* DV_II_48_0 */
+	{ 35, 30, 36, 3, 1 },
+	{ 35, 30, 40, 28, 1 },
+	{ 63, 0, 64, 5, 1 },
+	{ 39, 4, 43, 29, 0 },
+	{ 44, 4, 48, 29, 0 },
+	/* DV_II_49_0 */
+	{ 36, 30, 37, 3, 1 },
+	{ 36, 30, 41, 28, 1 },
+	{ 37, 4, 41, 29, 0 },
+	{ 40, 4, 44, 29, 0 },
+	/* DV_II_49_2 */
+	{ 36, 0, 37, 5, 1 },
+	/* DV_II_50_0 */
+	{ 37, 30, 38, 3, 1 },
+	{ 37, 30, 42, 28, 1 },
+	{ 38, 4, 42, 29, 0 },
+	{ 41, 4, 45, 29, 0 },
+	{ 54, 4, 57, 29, 0 },
+	/* DV_II_51_0 */
+	{ 38, 30, 39, 3, 1 },
+	{ 38, 30, 43, 28, 1 },
+	{ 39, 4, 43, 29, 0 },
+	{ 55, 4, 58, 29, 0 },
+	/* DV_II_51_2 */
+	{ 52, 1, 56, 1, 1 },
+	/* DV_II_52_0 */
+	{ 39, 30, 40, 3, 1 },
+	{ 40, 4, 44, 29, 0 },
+	{ 43, 4, 47, 29, 0 },
+	{ 54, 4, 57, 29, 0 },
+	{ 56, 4, 59, 29, 0 },
+	/* DV_II_53_0 */
+	{ 55, 4, 57, 4, 1 },
+	{ 41, 4, 45, 29, 0 },
+	{ 44, 4, 48, 29, 0 },
+	{ 55, 4, 58, 29, 0 },
+	{ 55, 4, 57, 29, 0 },
+	/* DV_II_54_0 */
+	{ 42, 3, 46, 28, 0 },
+	{ 56, 4, 59, 29, 0 },
+	{ 56, 4, 58, 29, 0 },
+	{ 58, 4, 62, 29, 0 },
+	/* DV_II_55_0 */
+	{ 43, 3, 47, 28, 0 },
+	{ 43, 4, 47, 29, 0 },
+	{ 57, 4, 59, 29, 0 },
+	{ 59, 4, 63, 29, 0 },
+	/* DV_II_56_0 */
+	{ 44, 3, 48, 28, 0 },
+	{ 44, 4, 48, 29, 0 },
+	{ 60, 4, 64, 29, 0 }
+};
+
+static const struct tail_span avx2_tail_spans[32] = {
+	{ 0, 3 },	/* DV_I_43_0 */
+	{ 3, 3 },	/* DV_I_44_0 */
+	{ 6, 2 },	/* DV_I_45_0 */
+	{ 8, 1 },	/* DV_I_46_0 */
+	{ 9, 0 },	/* DV_I_46_2 */
+	{ 9, 2 },	/* DV_I_47_0 */
+	{ 11, 0 },	/* DV_I_47_2 */
+	{ 11, 3 },	/* DV_I_48_0 */
+	{ 14, 0 },	/* DV_I_48_2 */
+	{ 14, 1 },	/* DV_I_49_0 */
+	{ 15, 0 },	/* DV_I_49_2 */
+	{ 15, 4 },	/* DV_I_50_0 */
+	{ 19, 0 },	/* DV_I_50_2 */
+	{ 19, 4 },	/* DV_I_51_0 */
+	{ 23, 1 },	/* DV_I_51_2 */
+	{ 24, 3 },	/* DV_I_52_0 */
+	{ 27, 2 },	/* DV_II_45_0 */
+	{ 29, 2 },	/* DV_II_46_0 */
+	{ 31, 0 },	/* DV_II_46_2 */
+	{ 31, 5 },	/* DV_II_47_0 */
+	{ 36, 5 },	/* DV_II_48_0 */
+	{ 41, 4 },	/* DV_II_49_0 */
+	{ 45, 1 },	/* DV_II_49_2 */
+	{ 46, 5 },	/* DV_II_50_0 */
+	{ 51, 0 },	/* DV_II_50_2 */
+	{ 51, 4 },	/* DV_II_51_0 */
+	{ 55, 1 },	/* DV_II_51_2 */
+	{ 56, 5 },	/* DV_II_52_0 */
+	{ 61, 5 },	/* DV_II_53_0 */
+	{ 66, 4 },	/* DV_II_54_0 */
+	{ 70, 4 },	/* DV_II_55_0 */
+	{ 74, 3 }	/* DV_II_56_0 */
+};
+
+SHA1DC_TARGET_AVX2
+static uint32_t avx2_prefix(const uint32_t *w)
+{
+	const __m256i zero = _mm256_setzero_si256();
+	__m256i acc = zero;
+	__m128i half;
+	size_t i;
+
+	UNROLL_TABLE
+	for (i = 0; i < ARRAY_SIZE(avx2_groups); i++) {
+		const struct ubc_group8 *g = &avx2_groups[i];
+		__m256i lo = _mm256_loadu_si256((const __m256i *)(w + g->lo));
+		__m256i hi = _mm256_loadu_si256((const __m256i *)(w + g->hi));
+		__m256i test = _mm256_loadu_si256((const __m256i *)g->test);
+		__m256i dvs = _mm256_loadu_si256((const __m256i *)g->dvs);
+		__m256i clear, fail;
+
+		lo = _mm256_srl_epi32(lo, _mm_cvtsi32_si128(g->lo_shift));
+		hi = _mm256_srl_epi32(hi, _mm_cvtsi32_si128(g->hi_shift));
+		clear = _mm256_and_si256(_mm256_xor_si256(lo, hi), test);
+		clear = _mm256_cmpeq_epi32(clear, zero);
+		/* The DVs of the lanes where the bit is not g->want. */
+		fail = g->want ? _mm256_and_si256(clear, dvs) :
+				 _mm256_andnot_si256(clear, dvs);
+		acc = _mm256_or_si256(acc, fail);
+	}
+
+	half = _mm_or_si128(_mm256_castsi256_si128(acc),
+			    _mm256_extracti128_si256(acc, 1));
+	half = _mm_or_si128(half, _mm_shuffle_epi32(half, 0x4E));
+	half = _mm_or_si128(half, _mm_shuffle_epi32(half, 0xB1));
+	return ~(uint32_t)_mm_cvtsi128_si32(half);
+}
+
+SHA1DC_TARGET_AVX2
+uint32_t sha1dc_ubc_check_avx2(const uint32_t w[80])
+{
+	uint32_t mask = avx2_prefix(w);
+	/* Every check only clears bits, so an empty mask settles it. */
+	if (!mask)
+		return 0;
+	return run_tail(w, mask, avx2_tail_checks, avx2_tail_spans);
+}
+
+#endif /* SHA1DC_HAVE_AVX2 */
diff --git a/sha1dc-accel/x86.c b/sha1dc-accel/x86.c
new file mode 100644
index 0000000000..7c942fe4de
--- /dev/null
+++ b/sha1dc-accel/x86.c
@@ -0,0 +1,38 @@
+/*
+ * The x86-64 parts of sha1.c: detecting what the CPU has.
+ */
+
+#include "../git-compat-util.h"
+#include "internal.h"
+
+#ifdef SHA1DC_HAVE_SSE2
+
+#include <cpuid.h>
+
+/* Leaf 7 of CPUID, subleaf 0, if the CPU has it. */
+static int cpuid_7(unsigned int *ebx)
+{
+	unsigned int eax, ecx, edx;
+
+	if (__get_cpuid_max(0, NULL) < 7)
+		return 0;
+	__cpuid_count(7, 0, eax, *ebx, ecx, edx);
+	return 1;
+}
+
+int sha1dc_avx2_available(void)
+{
+	unsigned int eax, ebx, ecx, edx, xcr0_lo, xcr0_hi;
+
+	if (!__get_cpuid(1, &eax, &ebx, &ecx, &edx))
+		return 0;
+	/* OSXSAVE and AVX, then whether the OS saves the YMM registers. */
+	if ((ecx & (1u << 27 | 1u << 28)) != (1u << 27 | 1u << 28))
+		return 0;
+	__asm__("xgetbv" : "=a"(xcr0_lo), "=d"(xcr0_hi) : "c"(0));
+	if ((xcr0_lo & 6) != 6)
+		return 0;
+	return cpuid_7(&ebx) && (ebx & (1u << 5));
+}
+
+#endif /* SHA1DC_HAVE_SSE2 */
diff --git a/t/unit-tests/u-sha1dc.c b/t/unit-tests/u-sha1dc.c
index 31fcd68451..15e71fb023 100644
--- a/t/unit-tests/u-sha1dc.c
+++ b/t/unit-tests/u-sha1dc.c
@@ -126,6 +126,76 @@ static void every_backend_agrees_with_sha1dc(void)
 	cl_assert_equal_i(sha1dc_accel_select(orig), 0);
 }
 
+/* Asserts only on a mismatch; clar's assertions are too slow to run 10^5 times. */
+#define check_form(got, want) do { \
+		uint32_t got_ = (got); \
+		if (got_ != (want)) \
+			cl_assert_equal_i(got_, (want)); \
+	} while (0)
+
+/*
+ * Checks every form of the UBC check against sha1dc/'s on `w`, and next to
+ * it, with each bit flipped in turn if `flip`.
+ */
+static void check_ubc_forms(uint32_t w[80], int flip, int avx2)
+{
+	int k;
+
+	for (k = 0; k <= (flip ? 80 * 32 : 0); k++) {
+		uint32_t want;
+
+		if (k)
+			w[(k - 1) / 32] ^= 1u << ((k - 1) % 32);
+		ubc_check(w, &want);
+		check_form(sha1dc_ubc_check_scalar(w), want);
+#ifdef SHA1DC_HAVE_SSE2
+		check_form(sha1dc_ubc_check_sse2(w), want);
+#endif
+#ifdef SHA1DC_HAVE_AVX2
+		if (avx2)
+			check_form(sha1dc_ubc_check_avx2(w), want);
+#endif
+#ifdef SHA1DC_HAVE_NEON
+		check_form(sha1dc_ubc_check_neon(w), want);
+#endif
+		(void)avx2;
+		if (k)
+			w[(k - 1) / 32] ^= 1u << ((k - 1) % 32);
+	}
+}
+
+static void ubc_forms_agree_with_sha1dc(void)
+{
+	uint32_t w[80];
+	int i, k, dv, avx2 = 0;
+
+#ifdef SHA1DC_HAVE_AVX2
+	/* Once: CPUID can take microseconds under a hypervisor. */
+	avx2 = sha1dc_avx2_available();
+#endif
+	rng_seed(2);
+	for (i = 0; i < 20000; i++) {
+		for (k = 0; k < 80; k++)
+			w[k] = rng();
+		check_ubc_forms(w, 0, avx2);
+	}
+
+	/*
+	 * Random schedules rarely get past the vector prefix of a form, so
+	 * look for one that keeps each DV alive, and check around it.
+	 */
+	for (dv = 0; dv < 32; dv++) {
+		uint32_t mask;
+
+		do {
+			for (k = 0; k < 80; k++)
+				w[k] = rng();
+			ubc_check(w, &mask);
+		} while (!(mask & (1u << dv)));
+		check_ubc_forms(w, 1, avx2);
+	}
+}
+
 #endif /* HAVE_SHA1DC_ACCEL */
 
 #ifdef HAVE_SHA1DC_ACCEL
@@ -143,3 +213,8 @@ void test_sha1dc__every_backend_agrees_with_sha1dc(void)
 {
 	RUN_OR_SKIP(every_backend_agrees_with_sha1dc);
 }
+
+void test_sha1dc__ubc_forms_agree_with_sha1dc(void)
+{
+	RUN_OR_SKIP(ubc_forms_agree_with_sha1dc);
+}
-- 
2.50.1 (Apple Git-155)


