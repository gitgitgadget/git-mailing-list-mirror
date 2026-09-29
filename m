Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27C51477C
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681166; cv=none; b=HbOjdNHUJKt/DePDosH38Yj6WLV6VcHdprWko9rR0qMOweOfFpku7NaLi8iUC5YQ2sVaa1/kNI1Er908l7w3Qjo68uEUGWid3f44d5UjvevMW0zDC6Pw4EFcp++wdssFSovUHGczPTxbJnrWv/5prIspTZZfhdTRS10mABqSuro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681166; c=relaxed/simple;
	bh=watE2Kuw+OqaX5XK1Vu5TLVzGJi11h873R5DQS2Wq6c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HS5BUIFDPg9OpfpZ7F8/Tb03Ae8ZUcWUeXbA0Iz6o3yUbuC+Ap8aFX3rfqzm/cTNZCASBCcYhn4RImc7AtohbeWVxAAcUYMUtDdj196+27EHBqk2ZkHlS7muluHyfHi81DJII4qG+jPWr+CMExtc1lkNgK8EVyQRYkiwvwpqKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net; spf=pass smtp.mailfrom=gitbutler.net; dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b=FjKqDWeI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n/y1vlqF; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b="FjKqDWeI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n/y1vlqF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1323D7A0038
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 07:26:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 29 Sep 2026 07:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gitbutler.net;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1790681162;
	 x=1790767562; bh=UMCm7w2GjdtirjcYwu+bhsJwa+rNNkylgIVKylPtiqU=; b=
	FjKqDWeIeuPq/YPG8flPqR1WkjGu0FYti2f5eg6acZzz3sIzK8VD+Xp0NhcCTjxz
	jTT0nhjO71zm1PB2wj//G0psTkBqMHMZLmRTzJ2zKxbV0HMlAA9QKVFgvlVZ4Qmk
	uFtCkKpaod7RIycdwGG3UyXwP73vR77BiR5A9an0bb2DrnybqaZhV9VETAoYL1m1
	8iyxbmWsChZHkgwA6MrZ5Vl3VOzCOSG8t0gEoui6hkabNV/c1SMLqCGlUtR6hbY/
	OHfh7WgJGX5Ybx6ucmG5uHhi9vzBzuJrqBbNOeCxuq1eNJXXbSkCLeJ0Qr9wnRVj
	aYGIGPJbuTvn+4ecf7Rszw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790681162; x=1790767562; bh=U
	MCm7w2GjdtirjcYwu+bhsJwa+rNNkylgIVKylPtiqU=; b=n/y1vlqFlWJm6YH4P
	1z+j1+vxpdqOOLjNPy7+SPuProec+pCVTWLv4IXNi0ihEK2OgGifqs2U1NyKyDGj
	NQ6wPXhvcZcb10CqJ9MAfH7gfwgcWUTGQoauDY3s/KCIjHXc7qvh54j3xqvxMVLY
	Y2YhtVXILCx100P/t/nnwNUkHqaOz3UyqkGJeYE5hvN8XmLjeMd4dlkc+TDOV4DV
	Z9RZMMF2CjpW1cDPXyLs4O59ywecWuOpIyzV8MS5oIiH7VCgXjIBTo+9n8HNn+9D
	AHM4oNtjsOFZJzNn4jJjTkPj1b1dUVb8r51PACoOrIYKAheCMS9TV3MnvswxHbC8
	aZfGA==
X-ME-Sender: <xms:SqC7aumDiOgzkhN4dWzH7UjtJiny_3RNL7_Tdqs5j18g6vUMG_eyFA>
    <xme:SqC7asyUD_gt-qV2ONPTueVvjJR1ODwtmkjm9Qdwm0PZVb0VXH463_1Alf_oONipJ
    XfuHepBvC3O2EqLWsT67MAZANx9WWWcFkyuSsFNwJ5ke-V4_EmqAN-b>
X-ME-Received: <xmr:SqC7aiQOhC7YkYG1H-c6zuAe0_dQcrcGoCiioawikhUNYr0zq_Ms-1EAsHsi3dfprqYSug>
X-ME-Proxy-Cause: dmFkZTE9kmltghFDfr4Pcq9atLw9Y1Ls3Yq2KHKMSz3wo7lvM1VkIyVOsw8gq+mapJJlGE
    c9yGgtvEPLe8mYIgxcwuodYkGuuNdK1RxlXgyQ4qHl7ISCf3z9P+nIjjHQjtEf6oJxuAVW
    L5umzAdCEXKN4Pmz9ZY46DJHSIa6DV8bbkjUgVwD1yRB33QQTOrxUVWFhbUC0R56PtYfRY
    mPMFZCpOcJWyyUB61VpvsT9AARelqLxeIF6TUw21ymdtXNqTMab0PrRICjJj9B+eDb+AR/
    WbOVkiqsyemyJs+EV8Dr3jUb4bZCK+7zN5TP1H7k82ToV9bLS9jRk7/PubpEaJKblGNSLi
    K24AeFshOTKL3FchGgPYRXU5/GM6EpnitlJIQkr4jE5v4ev0loENYdpJQvKmC3OGv5lwul
    +zwu7W//Apu0r5JAbI8MefwhzwpyTy6R2j18GJ+o9k+BkmTppQgaSmxp6FyoP+gwFmWG2d
    u8NHIqn5BU+7R0Qo77MlYsPA8RQu5Mg3QyZFOjradD8v9uJxn40QnPwxK+IYSfDFV8VDmk
    sYmCSGeCBah//6n0GADdWj4lZx7kah2loQqZwTravfaFiOFD89AU/wxJMTkUmZlssLZmog
    QRCqYN9Xpf60iRwVXY/PCNf3dX7f/SAWcgcrpdchIDb+GYAsFWgN/bZMjB1g
X-ME-Proxy: <xmx:SqC7anvekxxB2QLsQDXFn_Juz2arUp-iDPII6MQc3Yh1cGBvw4enbA>
    <xmx:SqC7assxYWmEnlw3pOMJTldi12ByJTuJaWl5UtSiMhrP2bAH7zEQ3w>
    <xmx:SqC7alyC7ePxcW_TxJKIRLzpZA5Rv210Pef9YFrNRjn_vyRIIUGeZA>
    <xmx:SqC7aqgyDnNxU-8sVkposwZ2H1JVKv1klgsJt8Gzav3djOt8W_UyVg>
    <xmx:SqC7aq3C-LpM2yjYQ66bcTD65bgwmI34V7trABDRmSzL-FX7DN8xzL-2>
Feedback-ID: iecfe4abb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 29 Sep 2026 07:26:00 -0400 (EDT)
From: Scott Chacon <scott@gitbutler.net>
To: git@vger.kernel.org
Subject: [PATCH 3/4] sha1dc-accel: compress with SHA-NI on x86-64
Date: Tue, 29 Sep 2026 13:25:43 +0200
Message-ID: <20260929112544.86511-4-scott@gitbutler.net>
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

With the UBC check out of the way, most of what's left is the SHA-1
compression itself, which we still do in portable C. Most x86-64 CPUs
from the last several years (Intel since Ice Lake and some Atoms, AMD
since Zen) have instructions for that: sha1rnds4 does four rounds at a
time, and sha1msg1/sha1msg2 do the message expansion.

There are two catches. The first is that the detection needs the
expanded schedule, which the instructions keep to themselves. That's
easy enough: as each group of four words is used, we store it (with a
shuffle, since SHA-NI holds them in reverse order). Words 16 to 31 come
from sha1msg1/sha1msg2, and the rest from the recurrence

  W[t] = (W[t-6] ^ W[t-16] ^ W[t-28] ^ W[t-32]) <<< 2

in plain SSE, in which no word of a group depends on another. That's
what the crate does, too; it notes that sha1msg2 is microcoded on
Sapphire Rapids, where this runs about 10% faster.

The second catch is that the recompression starts from the working
state before step 58 or step 65, and the instructions only let us see
the state between groups of four steps. But the state at step 60 is
just two steps away from 58, and 64 is one step from 65. So we save
those two for every block, and only for a block that the filter flags
(about one in twenty) do we walk them the rest of the way.

While we're here, we can do the recompression of those flagged blocks
with the SHA-1 instructions, too. The portable code runs the partner
block backwards from its state at 58 or 65 to find the chaining value
it started from, then forwards to find the one it ends on, and compares
that with ours. But the instructions only go forwards. So instead we run
the partner forwards from step 60 or 64 to step 80, which tells us the
only input chaining value that could produce our output (it's the output
minus the state at 80, since the feed-forward is just addition). Then we
run forwards from that input to step 60 or 64 and see if we arrive back
where we started. Since each step is a bijection, that's the same test.

The exception is reduced-round detection, which also wants to know the
partner's input chaining value for its own sake. Git never turns that
on, so it just keeps using the portable recompression.

We check for SHA-NI (plus SSSE3 and SSE4.1, which the code also needs)
with cpuid when we pick a backend, and compile with target attributes,
so there's nothing to configure. That gives two new backends in front of
the others, shani+avx2 and shani+sse2, which differ only in the UBC
check.

The unit test gains a check of the compression against SHA-1 steps
written out in the test itself, and of the recompression, which must
accept the partner's real output and reject any other.

With the usual 256MB of random data (the Xeon picks shani+avx2):

  Benchmark 1: test-tool.old sha1
    Time (mean ± σ):     590.3 ms ±  83.8 ms    [User: 541.0 ms, System: 42.6 ms]
    Range (min … max):   440.2 ms … 750.7 ms    30 runs

  Benchmark 2: test-tool.new sha1
    Time (mean ± σ):     285.2 ms ±  26.0 ms    [User: 238.9 ms, System: 42.1 ms]
    Range (min … max):   223.9 ms … 341.5 ms    30 runs

  Summary
    test-tool.new sha1 ran
      2.07 ± 0.35 times faster than test-tool.old sha1

That makes the whole series so far 2.70 ± 0.35 times faster than plain
sha1dc/ on this machine. Or, for index-pack on the 208MB pack of a clone
of git.git, single-threaded:

  Benchmark 1: git.old index-pack --threads=1
    Time (mean ± σ):     24.301 s ±  1.102 s    [User: 23.739 s, System: 0.219 s]
    Range (min … max):   23.557 s … 26.215 s    5 runs

  Benchmark 2: git.new index-pack --threads=1
    Time (mean ± σ):     12.689 s ±  0.385 s    [User: 12.293 s, System: 0.197 s]
    Range (min … max):   12.274 s … 13.226 s    5 runs

  Summary
    git.new index-pack --threads=1 ran
      1.92 ± 0.10 times faster than git.old index-pack --threads=1

and with 4 threads:

  Benchmark 1: git.old index-pack --threads=4
    Time (mean ± σ):     10.450 s ±  0.445 s    [User: 27.147 s, System: 0.497 s]
    Range (min … max):    9.853 s … 10.782 s    5 runs

  Benchmark 2: git.new index-pack --threads=4
    Time (mean ± σ):      5.924 s ±  0.214 s    [User: 12.693 s, System: 0.527 s]
    Range (min … max):    5.591 s …  6.185 s    5 runs

  Summary
    git.new index-pack --threads=4 ran
      1.76 ± 0.10 times faster than git.old index-pack --threads=4

Hashing in-process, shani+avx2 runs at 900 to 1050 MiB/s for messages
of 1KiB and up, against 1130 to 1230 MiB/s for OpenSSL's SHA-1 (which
doesn't detect collisions at all) and 420 to 450 MiB/s for sha1dc/. The
full test suite passes on this machine, as do t0013 and the unit tests
for each of its five backends.

Signed-off-by: Scott Chacon <scott@gitbutler.net>
Assisted-by: Claude Opus 5.5 <noreply@anthropic.com>
---
 Makefile                |   2 +-
 sha1dc-accel/internal.h |  28 +++++
 sha1dc-accel/sha1.c     | 105 ++++++++++++++-----
 sha1dc-accel/x86.c      | 224 +++++++++++++++++++++++++++++++++++++++-
 t/unit-tests/u-sha1dc.c | 141 ++++++++++++++++++++++++-
 5 files changed, 471 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index 3ad8a7fc92..8181ea5692 100644
--- a/Makefile
+++ b/Makefile
@@ -569,7 +569,7 @@ include shared.mak
 #
 # Unless DC_SHA1_EXTERNAL is defined, the built-in code is driven by the
 # faster implementation in sha1dc-accel/, which gives the same results
-# using the CPU's vector units where it has them.
+# using the CPU's SHA-1 instructions and vector units where it has them.
 # Define DC_SHA1_NO_ACCEL to use the sha1collisiondetection code alone.
 #
 # === SHA-256 backend ===
diff --git a/sha1dc-accel/internal.h b/sha1dc-accel/internal.h
index 03427224da..a27fda19d1 100644
--- a/sha1dc-accel/internal.h
+++ b/sha1dc-accel/internal.h
@@ -19,9 +19,11 @@
 # if defined(__x86_64__) && (defined(__clang__) || __GNUC__ >= 5)
 #  define SHA1DC_HAVE_SSE2 1
 #  define SHA1DC_HAVE_AVX2 1
+#  define SHA1DC_HAVE_SHANI 1
 #  include <immintrin.h>
 #  define SHA1DC_TARGET_SSE2
 #  define SHA1DC_TARGET_AVX2 __attribute__((target("avx2")))
+#  define SHA1DC_TARGET_SHANI __attribute__((target("sha,sse4.1,ssse3")))
 # elif defined(__aarch64__) && defined(__ARM_NEON)
 #  define SHA1DC_HAVE_NEON 1
 #  include <arm_neon.h>
@@ -71,4 +73,30 @@ uint32_t sha1dc_ubc_check_neon(const uint32_t w[80]);
 int sha1dc_avx2_available(void);
 #endif
 
+/*
+ * The state the partner block of a DV reaches at the group boundary next to
+ * where its recompression starts: step 60 from step 58, step 64 from step
+ * 65. `state` is this block's state at `from`. In sha1.c.
+ */
+void sha1dc_partner_boundary(enum sha1dc_from from, const uint32_t m1[80],
+			     const uint32_t dm[80], const uint32_t state[5],
+			     uint32_t out[5]);
+
+/*
+ * The hardware compression. It compresses one 64-byte block into `ihv`,
+ * writes the expanded schedule to `w`, and this block's own states at
+ * steps 60 and 64 to `at_60` and `at_64`.
+ *
+ * Its recompression answers whether a DV candidate is really an attack,
+ * running the partner block forwards from `state` (this block's state at
+ * `from`) with the SHA-1 instructions.
+ */
+#ifdef SHA1DC_HAVE_SHANI
+int sha1dc_shani_available(void);
+void sha1dc_compress_shani(uint32_t ihv[5], const unsigned char *block,
+			   uint32_t w[80], uint32_t at_60[5], uint32_t at_64[5]);
+int sha1dc_recompress_shani(enum sha1dc_from from, const uint32_t m1[80],
+			    const uint32_t dm[80], const uint32_t state[5],
+			    const uint32_t ihv_out[5]);
+#endif
 #endif /* SHA1DC_ACCEL_INTERNAL_H */
diff --git a/sha1dc-accel/sha1.c b/sha1dc-accel/sha1.c
index 1b3d82b4e4..2f30b207db 100644
--- a/sha1dc-accel/sha1.c
+++ b/sha1dc-accel/sha1.c
@@ -7,6 +7,14 @@
  * Shumow. It is a port to C of the approach of the "sha1dc" Rust crate by
  * Sam Reis (https://github.com/srijs/sha1dc), which gitoxide uses:
  *
+ *  - The compression runs on the CPU's SHA-1 instructions where it has them
+ *    (SHA-NI on x86-64), and
+ *    spills the expanded message schedule as it goes, which is all that
+ *    detection needs from an ordinary block. The hardware keeps no
+ *    intermediate states around, so the two states that recompression
+ *    starts from (at steps 58 and 65) are recovered from the ones at steps
+ *    60 and 64, and only for the rare block that needs them.
+ *
  *  - The unavoidable-bitconditions (UBC) filter, which rules out about 95%
  *    of blocks and is most of what detection costs, has one form per
  *    instruction set (SSE2, AVX2, NEON and portable C). For each, the
@@ -15,9 +23,12 @@
  *    the rest to a scalar tail that few blocks reach. Those choices are
  *    kept as tables, run by a short loop per form. See ubc_check.c.
  *
- * The compression is portable C, and spills the expanded message schedule
- * and the two states that recompression starts from (at steps 58 and 65)
- * as it goes.
+ *  - The recompression of a flagged block also runs on the SHA-1
+ *    instructions, forwards from the partner block's state at step 60 or
+ *    64, since that is the only direction they go.
+ *
+ * Without SHA-1 instructions the compression is portable C, and the
+ * best-suited form of the filter still applies.
  */
 
 #include "../git-compat-util.h"
@@ -180,6 +191,14 @@ static void walk(uint32_t s[5], const uint32_t *m1, const uint32_t *dm,
 	s[4] = e;
 }
 
+void sha1dc_partner_boundary(enum sha1dc_from from, const uint32_t m1[80],
+			     const uint32_t dm[80], const uint32_t state[5],
+			     uint32_t out[5])
+{
+	memcpy(out, state, 5 * sizeof(*out));
+	walk(out, m1, dm, from, from == SHA1DC_FROM_58 ? 60 : 64);
+}
+
 /*
  * The recompression, the way sha1dc/ does it: from this block's state at
  * `from`, the partner block's chaining value on the way in (`ihv_in`) and
@@ -215,31 +234,49 @@ static void compress_schedule(uint32_t ihv[5], const uint32_t w[80])
 struct backend {
 	const char *name;
 	/*
-	 * Compresses a block, spilling its schedule and the states at steps
-	 * 58 and 65.
+	 * Compresses a block and spills its schedule. If `at_60_64` is set,
+	 * it leaves the states at steps 60 and 64 where the others leave the
+	 * ones at 58 and 65.
 	 */
 	void (*compress)(uint32_t ihv[5], const unsigned char *block,
-			 uint32_t w[80], uint32_t state_58[5],
-			 uint32_t state_65[5]);
+			 uint32_t w[80], uint32_t s1[5], uint32_t s2[5]);
+	int at_60_64;
 	uint32_t (*ubc_check)(const uint32_t w[80]);
+	/* Whether a candidate is an attack; NULL for recompress_portable(). */
+	int (*recompress)(enum sha1dc_from from, const uint32_t m1[80],
+			  const uint32_t dm[80], const uint32_t state[5],
+			  const uint32_t ihv_out[5]);
 	int (*available)(void);
 };
 
+#ifdef SHA1DC_HAVE_SHANI
+static int shani_avx2_available(void)
+{
+	return sha1dc_shani_available() && sha1dc_avx2_available();
+}
+#endif
+
 /* In order of preference. */
 static const struct backend backends[] = {
+#ifdef SHA1DC_HAVE_SHANI
+	{ "shani+avx2", sha1dc_compress_shani, 1, sha1dc_ubc_check_avx2,
+	  sha1dc_recompress_shani, shani_avx2_available },
+	{ "shani+sse2", sha1dc_compress_shani, 1, sha1dc_ubc_check_sse2,
+	  sha1dc_recompress_shani, sha1dc_shani_available },
+#endif
 #ifdef SHA1DC_HAVE_AVX2
-	{ "portable+avx2", compress_portable, sha1dc_ubc_check_avx2,
+	{ "portable+avx2", compress_portable, 0, sha1dc_ubc_check_avx2, NULL,
 	  sha1dc_avx2_available },
 #endif
 #ifdef SHA1DC_HAVE_SSE2
-	{ "portable+sse2", compress_portable, sha1dc_ubc_check_sse2,
+	{ "portable+sse2", compress_portable, 0, sha1dc_ubc_check_sse2, NULL,
 	  NULL },
 #endif
 #ifdef SHA1DC_HAVE_NEON
-	{ "portable+neon", compress_portable, sha1dc_ubc_check_neon,
+	{ "portable+neon", compress_portable, 0, sha1dc_ubc_check_neon, NULL,
 	  NULL },
 #endif
-	{ "portable", compress_portable, sha1dc_ubc_check_scalar, NULL },
+	{ "portable", compress_portable, 0, sha1dc_ubc_check_scalar, NULL, NULL },
 };
 
 static int usable(const struct backend *be)
@@ -320,22 +357,27 @@ const char *const *sha1dc_accel_backends(void)
 
 /*
  * Whether any DV in `candidates` makes this block half of a collision.
- * `ihv_in` and `ihv_out` are the chaining values before and after it.
+ * `s1` and `s2` are what the compression left, `ihv_in` and `ihv_out` the
+ * chaining values before and after it.
  */
-static SHA1DC_NOINLINE int attacked(SHA1_CTX *ctx, uint32_t candidates,
-				    const uint32_t w[80],
-				    const uint32_t state_58[5],
-				    const uint32_t state_65[5],
+static SHA1DC_NOINLINE int attacked(const struct backend *be, SHA1_CTX *ctx,
+				    uint32_t candidates, const uint32_t w[80],
+				    uint32_t s1[5], uint32_t s2[5],
 				    const uint32_t ihv_in[5],
 				    const uint32_t ihv_out[5])
 {
+	const uint32_t *state_58 = s1, *state_65 = s2;
 	int i;
 
+	if (be->at_60_64) {
+		walk(s1, w, NULL, 60, 58);
+		walk(s2, w, NULL, 64, 65);
+	}
+
 	for (i = 0; sha1_dvs[i].dvType != 0; i++) {
 		const dv_info_t *dv = &sha1_dvs[i];
 		enum sha1dc_from from;
 		const uint32_t *state;
-		uint32_t ihv2_in[5], ihv2_out[5];
 
 		if (!(candidates & ((uint32_t)1 << dv->maskb)))
 			continue;
@@ -354,11 +396,23 @@ static SHA1DC_NOINLINE int attacked(SHA1_CTX *ctx, uint32_t candidates,
 			    dv->dvType, dv->dvK, dv->dvB, dv->testt);
 		}
 
-		recompress_portable(from, w, dv->dm, state, ihv2_in, ihv2_out);
-		if (!memcmp(ihv2_out, ihv_out, sizeof(ihv2_out)) ||
-		    (ctx->reduced_round_coll &&
-		     !memcmp(ihv2_in, ihv_in, sizeof(ihv2_in))))
-			return 1;
+		/*
+		 * Reduced-round collisions are recognized by the partner
+		 * block's chaining value on the way in, which only the
+		 * portable recompression computes.
+		 */
+		if (be->recompress && !ctx->reduced_round_coll) {
+			if (be->recompress(from, w, dv->dm, state, ihv_out))
+				return 1;
+		} else {
+			uint32_t ihv2_in[5], ihv2_out[5];
+
+			recompress_portable(from, w, dv->dm, state, ihv2_in, ihv2_out);
+			if (!memcmp(ihv2_out, ihv_out, sizeof(ihv2_out)) ||
+			    (ctx->reduced_round_coll &&
+			     !memcmp(ihv2_in, ihv_in, sizeof(ihv2_in))))
+				return 1;
+		}
 	}
 	return 0;
 }
@@ -366,17 +420,16 @@ static SHA1DC_NOINLINE int attacked(SHA1_CTX *ctx, uint32_t candidates,
 static inline void process(const struct backend *be, SHA1_CTX *ctx,
 			   const unsigned char *block)
 {
-	uint32_t w[80], state_58[5], state_65[5], ihv_in[5], candidates;
+	uint32_t w[80], s1[5], s2[5], ihv_in[5], candidates;
 
 	memcpy(ihv_in, ctx->ihv, sizeof(ihv_in));
-	be->compress(ctx->ihv, block, w, state_58, state_65);
+	be->compress(ctx->ihv, block, w, s1, s2);
 	if (!ctx->detect_coll)
 		return;
 
 	candidates = ctx->ubc_check ? be->ubc_check(w) : 0xFFFFFFFF;
 	if (candidates &&
-	    attacked(ctx, candidates, w, state_58, state_65, ihv_in,
-		     ctx->ihv)) {
+	    attacked(be, ctx, candidates, w, s1, s2, ihv_in, ctx->ihv)) {
 		ctx->found_collision = 1;
 		/*
 		 * Two more compressions of this block give a digest that the
diff --git a/sha1dc-accel/x86.c b/sha1dc-accel/x86.c
index 7c942fe4de..c2a0c71f17 100644
--- a/sha1dc-accel/x86.c
+++ b/sha1dc-accel/x86.c
@@ -1,5 +1,6 @@
 /*
- * The x86-64 parts of sha1.c: detecting what the CPU has.
+ * The x86-64 parts of sha1.c: detecting what the CPU has, and the SHA-1
+ * compression and recompression on SHA-NI.
  */
 
 #include "../git-compat-util.h"
@@ -35,4 +36,225 @@ int sha1dc_avx2_available(void)
 	return cpuid_7(&ebx) && (ebx & (1u << 5));
 }
 
+#ifdef SHA1DC_HAVE_SHANI
+
+int sha1dc_shani_available(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	if (!__get_cpuid(1, &eax, &ebx, &ecx, &edx))
+		return 0;
+	/* SSSE3 and SSE4.1 */
+	if ((ecx & (1u << 9 | 1u << 19)) != (1u << 9 | 1u << 19))
+		return 0;
+	return cpuid_7(&ebx) && (ebx & (1u << 29));
+}
+
+/*
+ * `sha1rnds4` does four steps at a time, on `abcd` held with A in the top
+ * lane; `sha1nexte` derives the fifth working word for the next group from
+ * the previous `abcd`, which is why two registers alternate as `live` and
+ * `held`. The group of schedule words for steps t..t+3 is held reversed too.
+ * Words 16 to 31 come from `sha1msg1`/`sha1msg2`, the rest from plain SSE
+ * by the recurrence W[t] = (W[t-6] ^ W[t-16] ^ W[t-28] ^ W[t-32]) <<< 2, in
+ * which no word of a group depends on another.
+ */
+
+/* Turns a group round, between step order and the order SHA-NI holds. */
+#define REVERSE 0x1B
+
+#define LOADU(p) _mm_loadu_si128((const __m128i *)(const void *)(p))
+#define STOREU(p, v) _mm_storeu_si128((__m128i *)(void *)(p), (v))
+
+/* Writes group `v` (steps t..t+3, held reversed) to w[t..t+3]. */
+#define SPILL(t, v) STOREU(w + (t), _mm_shuffle_epi32((v), REVERSE))
+
+/* Schedule words 4k..4k+3 for k from 8 on, from groups k-8, k-7, k-4, k-2, k-1. */
+SHA1DC_TARGET_SHANI
+static inline __m128i expand_rol2(__m128i v8, __m128i v7, __m128i v4,
+				  __m128i v2, __m128i v1)
+{
+	__m128i x = _mm_xor_si128(_mm_xor_si128(v8, v7), v4);
+	/* Words t-6 to t-3: the last two of group k-2, the first two of k-1. */
+	x = _mm_xor_si128(x, _mm_alignr_epi8(v2, v1, 8));
+	return _mm_or_si128(_mm_slli_epi32(x, 2), _mm_srli_epi32(x, 30));
+}
+
+/* Schedule words 4k..4k+3 for k from 4 to 7, with the SHA-NI instructions. */
+#define EXPAND_NI(a, b, c, d) \
+	_mm_sha1msg2_epu32(_mm_xor_si128(_mm_sha1msg1_epu32((a), (b)), (c)), (d))
+
+/* One group of four steps on schedule group `t / 4`, spilling it first. */
+#define ROUNDS(t, k, live, held) \
+	do { \
+		SPILL(t, v[(t) / 4]); \
+		live = _mm_sha1nexte_epu32(live, v[(t) / 4]); \
+		held = abcd; \
+		abcd = _mm_sha1rnds4_epu32(abcd, live, k); \
+	} while (0)
+
+/* The same, also storing the state [A, B, C, D, E] before it in `at`. */
+#define ROUNDS_AT(t, k, live, held, at) \
+	do { \
+		SPILL(t, v[(t) / 4]); \
+		live = _mm_sha1nexte_epu32(live, v[(t) / 4]); \
+		STOREU(at, _mm_shuffle_epi32(abcd, REVERSE)); \
+		/* `live` holds E + W[t] in its top lane. */ \
+		at[4] = (uint32_t)_mm_extract_epi32(_mm_sub_epi32(live, v[(t) / 4]), 3); \
+		held = abcd; \
+		abcd = _mm_sha1rnds4_epu32(abcd, live, k); \
+	} while (0)
+
+#define ROL2(k) v[k] = expand_rol2(v[(k) - 8], v[(k) - 7], v[(k) - 4], v[(k) - 2], v[(k) - 1])
+
+SHA1DC_TARGET_SHANI
+void sha1dc_compress_shani(uint32_t ihv[5], const unsigned char *block,
+			   uint32_t w[80], uint32_t at_60[5], uint32_t at_64[5])
+{
+	/* Big-endian words, and the four of a group reversed. */
+	const __m128i swap = _mm_set_epi64x(0x0001020304050607LL,
+					    0x08090A0B0C0D0E0FLL);
+	__m128i abcd = _mm_shuffle_epi32(LOADU(ihv), REVERSE);
+	const __m128i abcd_in = abcd;
+	const __m128i e_in = _mm_set_epi32((int)ihv[4], 0, 0, 0);
+	__m128i e0, e1, v[20];
+
+	v[0] = _mm_shuffle_epi8(LOADU(block), swap);
+	v[1] = _mm_shuffle_epi8(LOADU(block + 16), swap);
+	v[2] = _mm_shuffle_epi8(LOADU(block + 32), swap);
+	v[3] = _mm_shuffle_epi8(LOADU(block + 48), swap);
+
+	SPILL(0, v[0]);
+	e0 = _mm_add_epi32(e_in, v[0]);
+	e1 = abcd;
+	abcd = _mm_sha1rnds4_epu32(abcd, e0, 0);
+	v[4] = EXPAND_NI(v[0], v[1], v[2], v[3]);
+
+	ROUNDS(4, 0, e1, e0);
+	v[5] = EXPAND_NI(v[1], v[2], v[3], v[4]);
+	ROUNDS(8, 0, e0, e1);
+	v[6] = EXPAND_NI(v[2], v[3], v[4], v[5]);
+	ROUNDS(12, 0, e1, e0);
+	v[7] = EXPAND_NI(v[3], v[4], v[5], v[6]);
+	ROUNDS(16, 0, e0, e1);
+	ROL2(8);
+	ROUNDS(20, 1, e1, e0);
+	ROL2(9);
+	ROUNDS(24, 1, e0, e1);
+	ROL2(10);
+	ROUNDS(28, 1, e1, e0);
+	ROL2(11);
+	ROUNDS(32, 1, e0, e1);
+	ROL2(12);
+	ROUNDS(36, 1, e1, e0);
+	ROL2(13);
+	ROUNDS(40, 2, e0, e1);
+	ROL2(14);
+	ROUNDS(44, 2, e1, e0);
+	ROL2(15);
+	ROUNDS(48, 2, e0, e1);
+	ROL2(16);
+	ROUNDS(52, 2, e1, e0);
+	ROL2(17);
+	ROUNDS(56, 2, e0, e1);
+	ROL2(18);
+	ROUNDS_AT(60, 3, e1, e0, at_60);
+	ROL2(19);
+	ROUNDS_AT(64, 3, e0, e1, at_64);
+	ROUNDS(68, 3, e1, e0);
+	ROUNDS(72, 3, e0, e1);
+	ROUNDS(76, 3, e1, e0);
+
+	/* Feed-forward. */
+	e0 = _mm_sha1nexte_epu32(e0, e_in);
+	abcd = _mm_add_epi32(abcd, abcd_in);
+	STOREU(ihv, _mm_shuffle_epi32(abcd, REVERSE));
+	ihv[4] = (uint32_t)_mm_extract_epi32(e0, 3);
+}
+
+/*
+ * The partner block's schedule words for group `g`, in the order the
+ * rounds take them.
+ */
+#define WORDS(g) \
+	_mm_shuffle_epi32(_mm_xor_si128(LOADU(m1 + 4 * (g)), LOADU(dm + 4 * (g))), REVERSE)
+
+/* Four steps. The first of a run adds the fifth word itself. */
+#define GROUP_FIRST(e, g, k) \
+	do { \
+		__m128i live_ = _mm_add_epi32((e), WORDS(g)); \
+		held = abcd; \
+		abcd = _mm_sha1rnds4_epu32(abcd, live_, k); \
+	} while (0)
+#define GROUP(g, k) \
+	do { \
+		__m128i live_ = _mm_sha1nexte_epu32(held, WORDS(g)); \
+		held = abcd; \
+		abcd = _mm_sha1rnds4_epu32(abcd, live_, k); \
+	} while (0)
+
+/*
+ * Whether the partner block, whose state at `from` is `state`, ends on
+ * `ihv_out`. From its state at step 60 or 64, it runs out to step 80,
+ * which gives the chaining value an attack would have had to start from,
+ * and then in from that value, which must arrive back at the same state.
+ */
+SHA1DC_TARGET_SHANI
+int sha1dc_recompress_shani(enum sha1dc_from from, const uint32_t m1[80],
+			    const uint32_t dm[80], const uint32_t state[5],
+			    const uint32_t ihv_out[5])
+{
+	uint32_t at[5], reached[5];
+	__m128i abcd, held, e_at, e_80, e_in;
+
+	sha1dc_partner_boundary(from, m1, dm, state, at);
+	abcd = _mm_shuffle_epi32(LOADU(at), REVERSE);
+
+	/* Out to step 80, from 60 or from 64. */
+	e_at = _mm_set_epi32((int)at[4], 0, 0, 0);
+	if (from == SHA1DC_FROM_58) {
+		GROUP_FIRST(e_at, 15, 3);
+		GROUP(16, 3);
+	} else {
+		GROUP_FIRST(e_at, 16, 3);
+	}
+	GROUP(17, 3);
+	GROUP(18, 3);
+	GROUP(19, 3);
+
+	/*
+	 * The feed-forward adds the input to the state at 80, so the only
+	 * input that gives this block's output is the output less that state.
+	 */
+	e_80 = _mm_sha1nexte_epu32(held, _mm_setzero_si128());
+	abcd = _mm_sub_epi32(_mm_shuffle_epi32(LOADU(ihv_out), REVERSE), abcd);
+	e_in = _mm_sub_epi32(_mm_set_epi32((int)ihv_out[4], 0, 0, 0), e_80);
+
+	/* In from there, as far as the state the way out started from. */
+	GROUP_FIRST(e_in, 0, 0);
+	GROUP(1, 0);
+	GROUP(2, 0);
+	GROUP(3, 0);
+	GROUP(4, 0);
+	GROUP(5, 1);
+	GROUP(6, 1);
+	GROUP(7, 1);
+	GROUP(8, 1);
+	GROUP(9, 1);
+	GROUP(10, 2);
+	GROUP(11, 2);
+	GROUP(12, 2);
+	GROUP(13, 2);
+	GROUP(14, 2);
+	if (from == SHA1DC_FROM_65)
+		GROUP(15, 3);
+
+	STOREU(reached, _mm_shuffle_epi32(abcd, REVERSE));
+	reached[4] = (uint32_t)_mm_extract_epi32(
+		_mm_sha1nexte_epu32(held, _mm_setzero_si128()), 3);
+	return !memcmp(reached, at, sizeof(at));
+}
+
+#endif /* SHA1DC_HAVE_SHANI */
+
 #endif /* SHA1DC_HAVE_SSE2 */
diff --git a/t/unit-tests/u-sha1dc.c b/t/unit-tests/u-sha1dc.c
index 15e71fb023..5948466cb9 100644
--- a/t/unit-tests/u-sha1dc.c
+++ b/t/unit-tests/u-sha1dc.c
@@ -2,7 +2,8 @@
 #include "hash.h"
 
 /*
- * Tests sha1dc-accel/ against sha1dc/, which it must agree with exactly.
+ * Tests sha1dc-accel/ against sha1dc/, which it must agree with exactly,
+ * and its parts against the plain SHA-1 step function written out here.
  */
 #if defined(SHA1_DC) && !defined(DC_SHA1_EXTERNAL) && !defined(DC_SHA1_NO_ACCEL)
 #define HAVE_SHA1DC_ACCEL
@@ -196,6 +197,139 @@ static void ubc_forms_agree_with_sha1dc(void)
 	}
 }
 
+#ifdef SHA1DC_HAVE_SHANI
+
+static uint32_t rol(uint32_t x, int n)
+{
+	return (x << n) | (x >> (32 - n));
+}
+
+static uint32_t f_k(int t, uint32_t b, uint32_t c, uint32_t d)
+{
+	if (t < 20)
+		return ((b & c) | (~b & d)) + 0x5A827999;
+	if (t < 40)
+		return (b ^ c ^ d) + 0x6ED9EBA1;
+	if (t < 60)
+		return ((b & c) | (b & d) | (c & d)) + 0x8F1BBCDC;
+	return (b ^ c ^ d) + 0xCA62C1D6;
+}
+
+/* One SHA-1 step forwards, from the state before step t. */
+static void step(uint32_t s[5], int t, uint32_t w)
+{
+	uint32_t a = rol(s[0], 5) + f_k(t, s[1], s[2], s[3]) + s[4] + w;
+	s[4] = s[3];
+	s[3] = s[2];
+	s[2] = rol(s[1], 30);
+	s[1] = s[0];
+	s[0] = a;
+}
+
+/* One SHA-1 step backwards, to the state before step t. */
+static void unstep(uint32_t s[5], int t, uint32_t w)
+{
+	uint32_t a = s[1], b = rol(s[2], 2), c = s[3], d = s[4];
+	s[4] = s[0] - (rol(a, 5) + f_k(t, b, c, d) + w);
+	s[0] = a;
+	s[1] = b;
+	s[2] = c;
+	s[3] = d;
+}
+
+typedef void (*compress_fn)(uint32_t ihv[5], const unsigned char *block,
+			    uint32_t w[80], uint32_t at_60[5], uint32_t at_64[5]);
+typedef int (*recompress_fn)(enum sha1dc_from from, const uint32_t m1[80],
+			     const uint32_t dm[80], const uint32_t state[5],
+			     const uint32_t ihv_out[5]);
+
+static void check_compress(compress_fn compress)
+{
+	int i, t;
+
+	rng_seed(3);
+	for (i = 0; i < 2000; i++) {
+		unsigned char block[64];
+		uint32_t ihv[5], got[5], w[80], at_60[5], at_64[5], s[5];
+
+		for (t = 0; t < 64; t++)
+			block[t] = rng();
+		for (t = 0; t < 5; t++)
+			ihv[t] = got[t] = rng();
+		compress(got, block, w, at_60, at_64);
+
+		memcpy(s, ihv, sizeof(s));
+		for (t = 0; t < 80; t++) {
+			uint32_t want_w = t < 16 ? get_be32(block + 4 * t) :
+				rol(w[t - 3] ^ w[t - 8] ^ w[t - 14] ^ w[t - 16], 1);
+			cl_assert_equal_i(w[t], want_w);
+			if (t == 60)
+				cl_assert(!memcmp(at_60, s, sizeof(s)));
+			if (t == 64)
+				cl_assert(!memcmp(at_64, s, sizeof(s)));
+			step(s, t, w[t]);
+		}
+		for (t = 0; t < 5; t++)
+			cl_assert_equal_i(got[t], ihv[t] + s[t]);
+	}
+}
+
+/*
+ * A recompression must accept exactly the chaining value the partner
+ * block ends on, and nothing else.
+ */
+static void check_recompress(recompress_fn recompress)
+{
+	int i, t, d;
+
+	rng_seed(4);
+	for (i = 0; i < 50; i++) {
+		uint32_t w[80], state[5];
+
+		for (t = 0; t < 80; t++)
+			w[t] = rng();
+		for (t = 0; t < 5; t++)
+			state[t] = rng();
+
+		for (d = 0; sha1_dvs[d].dvType; d++) {
+			const dv_info_t *dv = &sha1_dvs[d];
+			enum sha1dc_from from = dv->testt == 58 ? SHA1DC_FROM_58 : SHA1DC_FROM_65;
+			uint32_t in[5], out[5];
+			unsigned nudge = rng();
+
+			memcpy(in, state, sizeof(in));
+			for (t = dv->testt - 1; t >= 0; t--)
+				unstep(in, t, w[t] ^ dv->dm[t]);
+			memcpy(out, state, sizeof(out));
+			for (t = dv->testt; t < 80; t++)
+				step(out, t, w[t] ^ dv->dm[t]);
+			for (t = 0; t < 5; t++)
+				out[t] += in[t];
+
+			cl_assert(recompress(from, w, dv->dm, state, out));
+			out[nudge % 5] ^= 1u << (nudge / 5 % 32);
+			cl_assert(!recompress(from, w, dv->dm, state, out));
+		}
+	}
+}
+
+#endif
+
+static void hardware_compression(void)
+{
+	int tested = 0;
+
+#ifdef SHA1DC_HAVE_SHANI
+	if (sha1dc_shani_available()) {
+		check_compress(sha1dc_compress_shani);
+		check_recompress(sha1dc_recompress_shani);
+		tested = 1;
+	}
+#endif
+	if (!tested)
+		cl_skip();
+}
+
 #endif /* HAVE_SHA1DC_ACCEL */
 
 #ifdef HAVE_SHA1DC_ACCEL
@@ -218,3 +352,8 @@ void test_sha1dc__ubc_forms_agree_with_sha1dc(void)
 {
 	RUN_OR_SKIP(ubc_forms_agree_with_sha1dc);
 }
+
+void test_sha1dc__hardware_compression(void)
+{
+	RUN_OR_SKIP(hardware_compression);
+}
-- 
2.50.1 (Apple Git-155)


