Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260EF515890
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681157; cv=none; b=Yqu0kJaxiZI4pscz7Bsqtlk5frjSE5oQhxoHNDk50LNf/9txK1lR36/zBSnHe7unWpZG/Y3PzUibo0pek85jouQJ0bHd0QRWaB3/VSkZYSU2AYr4YjkAVWr086V71eYXedluKKUW1BGngNoCdjwYUqDRqBXmlLqCvMBSgZv8riM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681157; c=relaxed/simple;
	bh=+zobmKouazCjwAKtTI2PU63xXDyNJ/7yoM5xET3am6s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beNs11PUyskThI0nQbkktCnGaC/kv1ruqD/FJanKVNRnq3YHROIHTmflTOLgaYOv4T4g9cAJoGN5TslLhhZ/1ZoAPdcpKmDXxEA9wyfAh2RuJH4v1IVjco+1pWOKnKivP2cN8BnepAsYz7bouSIX2NHCQTTgoxe87b6D/IDUhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net; spf=pass smtp.mailfrom=gitbutler.net; dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b=XAdR3e2e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qCrAea8V; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b="XAdR3e2e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qCrAea8V"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D3781D000FA
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 07:25:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 29 Sep 2026 07:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gitbutler.net;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1790681153;
	 x=1790767553; bh=6AU29yvc5tpGecx0mf86eEXu9q35H2NFmgQpWWU+OjE=; b=
	XAdR3e2e8HfGKr2BJf4cGDqt5mBncphw9hWLX5sebV0nzZKxBsQ9BucHC///XFDt
	B4AusOt798GKiPNZzcJJFGPbtQMQeC+ql4kLc3yHPUfNg9NqEhl5EyhHjfKLpA0l
	XBx2xU4+ElndX9Pxu6hjTJuJgbryyLxrOCGHiZw+rfLKdCjRSLGjSw1qZ8fVAgdd
	7h38EX870SuCu5Sg6k/muy/lNi+ZwftLP7Hfb5VEfj1jhog7paowuNg3i4DgHh62
	OVy2HZWto4/ptx067ZtVr5Hf66Xv3Wg88/2GBf4BT99q/jD7+sQrue88nrY9hYBr
	GKThvUdV0BtwUsBlBzoBxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790681153; x=1790767553; bh=6
	AU29yvc5tpGecx0mf86eEXu9q35H2NFmgQpWWU+OjE=; b=qCrAea8VP3kkz9X1G
	BnIzeo7T1PAk3I2Li2/WMjMI9WVbbUxXWXhHJNszP5nO980y8sM+29f16EY6lAa+
	YGQU94O6j9LoMMpy+pi1yvoIp0+oQmL9uIpSFwXAeWffXXznS+gduysBH9tZjML9
	b0rM34cMNEn8/y1ih/jKHE7cJuuhemFWOeD3sue2eYUpe53gaN0324dtfMYePM8n
	J0A9lGq1dziAwqz9/9VXzomrrO54COtqB8nJMmJNjwQrkxR0A+P4UrLVIS2KsjJ+
	+1KW57X1JS3Ro2KrePx6yPkO9RCmRSjVV6fFY30xqwpaORxZkJAbXmXTFajKAXhR
	D3WPQ==
X-ME-Sender: <xms:QaC7aooKjwpaRiw4-HqQ90oHONuILaer5Tdr2_qk_c9opZjw90dDoA>
    <xme:QaC7almNNwxlSctuJfh0QcIl_USQ2QtTdx0S4mTFDMClRdoShm4doMDoSnHOPcyAI
    rWtw2LVK-nilUJDI0tJt1HTtMrUy7M46MqWBvIon-f9-XhPvCw-LmU->
X-ME-Received: <xmr:QaC7ai2Q0xR--jK8cfFg09s96lGFpVfamIR8qUIBpD1tetL1ZpWfsvW6vDEBAZfBooGWHQ>
X-ME-Proxy-Cause: dmFkZTFoomYl2Sc2Ccaoa9RQ4KkdzM/I1ZXdpwOc7cKTAnXFKkNxec8ostJF0G45ol/V0R
    OzQ9Ec6LWgrPDWQiJnSNBxrLvX/ngzYFxJQZvYMLXHdmkNglOw6RTzyhQe6g7+LFmo/MAs
    +c0PYFS/lUSZA6CZzxUeawpOUFL+Bb4QagIk2mMyTRcq55abSf4ztzocrf23qvSrDcv70L
    EXWwBrWePbMoaXygN5LbnoHTorkKKsCz82Q44yTkpxrYK7onE8phubyJHpCPMqW2ezWy0s
    Gqsrx/MD0kki8o8tNU7K3FH7HJAgspSVCDac/+3/+QhqevJMklUOfTYdji8RlWcQiH13kv
    FumUr7PsD6tONiZauuYMLgy5GNmZeRwuDqMYXPfx5qkdgB0EYpC4wyGhDOSIe1OkKR8rSu
    kR38Y/RYu5SCygYUni0uqka+k7zOzzlxXkKMLhhCIsZYcYCbkSOytW2aY35V3CM/8c7ie3
    DIOvHKCw02ZMpDnmfpbbr9f4wfalUI6fadjScjinXRKi+xJj/4nUmo7z7NVIGxC/zU9DtA
    DTSiKkIOL6tH7xaj1xkeihLJzs5/v809wYECeOTBuhC5vU0tk1R1dBP3jTkOCHlLzVPj20
    zN1fyjSgZQqv6knb+W6UPovBykjGiGIxNR6E9XaF6gadfSJ9oYq2GaFfP/bA
X-ME-Proxy: <xmx:QaC7alBSjklN38CZOuo79Vqdr77XUEy2XRslgFx9hokFJdORLEUhsw>
    <xmx:QaC7anzhcRL7QLZfmwbHjWb7KXK44c5zhOJvbzhYZ7qOzNiOOGdB0Q>
    <xmx:QaC7arlWDVNWr12Bo_XIS_6bPppc2rtElye450yW8HO29iUMywhbdQ>
    <xmx:QaC7akEsI8iM-vX7gi_Mgo75edxguJF1a63u8O4RJA_srnPNp4O6Fw>
    <xmx:QaC7asLV-3fzgr2GDYisc34Zf1mL4t_LmWDte12NYmnYLrqTHqILEe-S>
Feedback-ID: iecfe4abb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 29 Sep 2026 07:25:50 -0400 (EDT)
From: Scott Chacon <scott@gitbutler.net>
To: git@vger.kernel.org
Subject: [PATCH 1/4] sha1dc-accel: add a block loop for sha1dc's SHA1_CTX
Date: Tue, 29 Sep 2026 13:25:41 +0200
Message-ID: <20260929112544.86511-2-scott@gitbutler.net>
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

Unless you build with some other SHA-1 implementation, every object we
hash goes through sha1collisiondetection. That's what we want for
safety, but it's not free. On the machine I'm testing with (a 4-vCPU
Xeon VM, which has SHA-NI and AVX2), sha1dc hashes at about 400 MiB/s,
while OpenSSL's SHA-1 (which does no detection) does about 1100 MiB/s.
On an Apple M5 Max, sha1dc manages about 700 MiB/s.
That matters for anything that hashes a lot of data we don't trust,
like index-pack.

Sam Reis recently wrote about closing that gap for gitoxide [1], with a
from-scratch rewrite of the detection code as a Rust crate [2]. There
are really three separate tricks in there:

  1. Compress with the CPU's SHA-1 instructions, and spill the expanded
     message schedule as we go. That's all the detection needs from the
     vast majority of blocks.

  2. The "unavoidable bitconditions" (UBC) filter, which rules out ~95%
     of blocks before we get to the expensive part, is most of what
     detection costs. Its conditions can be rewritten into an
     equivalent set that lines up in vector lanes, and the crate has a
     solver that does that for each instruction set.

  3. Recompress the few blocks the filter can't rule out with the SHA-1
     instructions, too.

We could in theory use the crate itself through our Rust support. But
that support is optional, the crate needs a much newer Rust than we
allow, and none of the three is all that much code once you know what
it's doing. So let's do it in C, which helps every build.

We can't really do any of that inside sha1dc/ itself. It's third-party
code (optionally a submodule), and its block loop is built around its
scalar compression, which stores intermediate states as it goes. So this
patch adds sha1dc-accel/, which has its own block loop but works on
sha1dc's SHA1_CTX and uses its table of disturbance vectors (DVs). For
each block it asks a "backend" to compress it (spilling the schedule and
the two states that recompression starts from), runs the UBC filter,
and then recompresses the block for each DV the filter didn't rule out.

For now there's only one backend: a portable C compression, plus
sha1dc's own ubc_check(). So this is just a reshuffling of what sha1dc/
already does, and the speedups come in the following patches. It comes
out a little slower. With 256MB of random data on the Xeon (GCC 13,
pinned to one CPU):

  Benchmark 1: test-tool.base sha1
    Time (mean ± σ):     727.3 ms ±  60.8 ms    [User: 677.2 ms, System: 40.7 ms]
    Range (min … max):   607.5 ms … 837.0 ms    30 runs

  Benchmark 2: test-tool.new sha1
    Time (mean ± σ):     797.2 ms ± 115.5 ms    [User: 745.4 ms, System: 41.8 ms]
    Range (min … max):   630.5 ms … 1078.0 ms    30 runs

  Summary
    test-tool.base sha1 ran
      1.10 ± 0.18 times faster than test-tool.new sha1

That's within the noise of this machine (which is quite noisy, sadly),
but callgrind counts 2.3% more instructions for the new code, and on the
M5 Max (Apple clang), hashing 1GiB goes from 1.49s to 1.55s (median of
9 runs), about 4% slower. That's a price I'm willing to pay for what
comes next.

A few other notes:

  - The results must be identical to sha1dc/'s: the same digest, and
    the same verdict on collisions. That includes the modes that Git
    itself doesn't use (the "safe hash" mitigation, disabling the UBC
    filter, and detecting reduced-round collisions). The new unit test
    checks exactly that against sha1dc/ for every backend the machine
    can run, on random data. There's only one so far, but there will be
    more. It also checks that sha1dc/'s table of DVs is laid out the way
    we expect, so that a change there fails loudly.

  - Likewise, "test-tool sha1dc-backends" lists the backends, and
    GIT_TEST_SHA1DC_BACKEND picks one for "test-tool sha1", which lets
    t0013 run its collision test against each of them. While I was
    there I added a second collision, the SHA-mbles chosen-prefix one
    [3]. It trips the same disturbance vector as SHAttered, II(52,0),
    but it's a different kind of attack, and gets detected in the
    tenth block rather than the fifth.

  - "test-tool sha1dc-compare" hashes a file both ways, in every
    combination of those modes and with the input split around each
    block, and dies if the two ever disagree. t0013 runs it for each
    backend on SHAttered, SHA-mbles and a reduced-round collision (from
    the crate's tests), which is the only way to exercise what happens
    after a collision is found. The last has no NUL byte, so
    t/.gitattributes marks t0013's .bin files as binary.

  - The backend is picked once, on first use. Threads can race to pick
    it, but they'd all store the same value; with GCC and clang we use
    relaxed atomics for that. Other compilers only get the portable
    backend, so they have nothing to pick, and no shared state.

  - DC_SHA1_EXTERNAL builds are left alone, since we don't know what
    their context looks like. For everybody else, DC_SHA1_NO_ACCEL
    goes back to using sha1dc/ on its own.

[1] https://sam.dev/blog/faster-sha1-collision-detection
[2] https://github.com/srijs/sha1dc
[3] https://sha-mbles.github.io/

Signed-off-by: Scott Chacon <scott@gitbutler.net>
Assisted-by: Claude Opus 5.5 <noreply@anthropic.com>
---
 Makefile                            |  10 +
 contrib/buildsystems/CMakeLists.txt |   2 +-
 meson.build                         |   1 +
 sha1dc-accel/internal.h             |  25 ++
 sha1dc-accel/sha1.c                 | 434 ++++++++++++++++++++++++++++
 sha1dc-accel/sha1.h                 |  31 ++
 sha1dc_git.c                        |  18 ++
 t/.gitattributes                    |   1 +
 t/helper/test-sha1.c                |  95 ++++++
 t/helper/test-tool.c                |   2 +
 t/helper/test-tool.h                |   2 +
 t/meson.build                       |   1 +
 t/t0013-sha1dc.sh                   |  47 +++
 t/t0013/sha-mbles-1.bin             | Bin 0 -> 640 bytes
 t/t0013/sha1-reduced-round.bin      | Bin 0 -> 128 bytes
 t/unit-tests/u-sha1dc.c             | 145 ++++++++++
 16 files changed, 813 insertions(+), 1 deletion(-)
 create mode 100644 sha1dc-accel/internal.h
 create mode 100644 sha1dc-accel/sha1.c
 create mode 100644 sha1dc-accel/sha1.h
 create mode 100644 t/t0013/sha-mbles-1.bin
 create mode 100644 t/t0013/sha1-reduced-round.bin
 create mode 100644 t/unit-tests/u-sha1dc.c

diff --git a/Makefile b/Makefile
index c649c93c51..9ab13ca2ab 100644
--- a/Makefile
+++ b/Makefile
@@ -567,6 +567,10 @@ include shared.mak
 # by the git project to migrate to using sha1collisiondetection as a
 # submodule.
 #
+# Unless DC_SHA1_EXTERNAL is defined, the built-in code is driven by the
+# block loop in sha1dc-accel/, which gives the same results.
+# Define DC_SHA1_NO_ACCEL to use the sha1collisiondetection code alone.
+#
 # === SHA-256 backend ===
 #
 # ==== Security ====
@@ -1555,6 +1559,7 @@ CLAR_TEST_SUITES += u-reftable-readwrite
 CLAR_TEST_SUITES += u-reftable-stack
 CLAR_TEST_SUITES += u-reftable-table
 CLAR_TEST_SUITES += u-reftable-tree
+CLAR_TEST_SUITES += u-sha1dc
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
 CLAR_TEST_SUITES += u-string-list
@@ -2167,6 +2172,11 @@ ifdef DC_SHA1_SUBMODULE
 else
 	LIB_OBJS += sha1dc/sha1.o
 	LIB_OBJS += sha1dc/ubc_check.o
+endif
+ifdef DC_SHA1_NO_ACCEL
+	BASIC_CFLAGS += -DDC_SHA1_NO_ACCEL
+else
+	LIB_OBJS += sha1dc-accel/sha1.o
 endif
 	BASIC_CFLAGS += \
 		-DSHA1DC_NO_STANDARD_INCLUDES \
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 7874e5a326..3c0ea2a27c 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -218,7 +218,7 @@ add_compile_definitions(NO_OPENSSL SHA1_DC SHA1DC_NO_STANDARD_INCLUDES
 			SHA1DC_INIT_SAFE_HASH_DEFAULT=0
 			SHA1DC_CUSTOM_INCLUDE_SHA1_C="git-compat-util.h"
 			SHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="git-compat-util.h" )
-list(APPEND compat_SOURCES sha1dc_git.c sha1dc/sha1.c sha1dc/ubc_check.c block-sha1/sha1.c sha256/block/sha256.c compat/qsort_s.c)
+list(APPEND compat_SOURCES sha1dc_git.c sha1dc/sha1.c sha1dc/ubc_check.c sha1dc-accel/sha1.c block-sha1/sha1.c sha256/block/sha256.c compat/qsort_s.c)
 
 
 add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
diff --git a/meson.build b/meson.build
index 0a95d90d21..a821b85f30 100644
--- a/meson.build
+++ b/meson.build
@@ -1631,6 +1631,7 @@ if sha1_backend == 'sha1dc'
     'sha1dc_git.c',
     'sha1dc/sha1.c',
     'sha1dc/ubc_check.c',
+    'sha1dc-accel/sha1.c',
   ]
 endif
 if sha1_backend == 'CommonCrypto' or sha1_unsafe_backend == 'CommonCrypto'
diff --git a/sha1dc-accel/internal.h b/sha1dc-accel/internal.h
new file mode 100644
index 0000000000..bf3513a1e3
--- /dev/null
+++ b/sha1dc-accel/internal.h
@@ -0,0 +1,25 @@
+#ifndef SHA1DC_ACCEL_INTERNAL_H
+#define SHA1DC_ACCEL_INTERNAL_H
+
+/*
+ * Shared between the files of sha1dc-accel/. See sha1.c for an overview.
+ *
+ * The schedule `w` is always the 80 expanded message words in step order,
+ * w[t] at index t, which is also what sha1dc/ keeps in SHA1_CTX.m1.
+ *
+ * A "state" is the five working words [a, b, c, d, e] before a step.
+ */
+
+#if defined(__GNUC__)
+# define SHA1DC_NOINLINE __attribute__((noinline))
+#else
+# define SHA1DC_NOINLINE
+#endif
+
+/* The step a DV's recompression starts from. */
+enum sha1dc_from {
+	SHA1DC_FROM_58 = 58,
+	SHA1DC_FROM_65 = 65
+};
+
+#endif /* SHA1DC_ACCEL_INTERNAL_H */
diff --git a/sha1dc-accel/sha1.c b/sha1dc-accel/sha1.c
new file mode 100644
index 0000000000..fd75289997
--- /dev/null
+++ b/sha1dc-accel/sha1.c
@@ -0,0 +1,434 @@
+/*
+ * SHA-1 with collision detection.
+ *
+ * This computes exactly what sha1dc/ computes: the SHA-1 digest of the
+ * input, and whether any block of it looks like one half of a collision
+ * made by one of the 32 known disturbance vectors (DVs) of Stevens and
+ * Shumow. It works on sha1dc's SHA1_CTX, and uses its table of DVs, but
+ * has its own block loop, which gives the following patches room to
+ * follow the approach of the "sha1dc" Rust crate by Sam Reis
+ * (https://github.com/srijs/sha1dc), which gitoxide uses.
+ *
+ * Each block is compressed by a "backend", which also spills the expanded
+ * message schedule, and the two intermediate states that recompression
+ * starts from (at steps 58 and 65). The unavoidable-bitconditions (UBC)
+ * filter then rules out about 95% of blocks; the rest are recompressed,
+ * once for each DV the filter could not rule out.
+ */
+
+#include "../git-compat-util.h"
+#include "../sha1dc_git.h"
+#if defined(DC_SHA1_SUBMODULE)
+#include "../sha1collisiondetection/lib/ubc_check.h"
+#else
+#include "../sha1dc/ubc_check.h"
+#endif
+#include "sha1.h"
+#include "internal.h"
+
+#define ROL(x, n) (((x) << (n)) | ((x) >> (32 - (n))))
+
+#define F_CH(b, c, d) ((d) ^ ((b) & ((c) ^ (d))))
+#define F_PARITY(b, c, d) ((b) ^ (c) ^ (d))
+#define F_MAJ(b, c, d) (((b) & (c)) | ((d) & ((b) | (c))))
+
+#define K0 0x5A827999
+#define K1 0x6ED9EBA1
+#define K2 0x8F1BBCDC
+#define K3 0xCA62C1D6
+
+/*
+ * One step, on names that rotate: after it, (e, a, b, c, d) are the new
+ * (a, b, c, d, e).
+ */
+#define STEP(f, k, a, b, c, d, e, x) \
+	do { \
+		e += ROL(a, 5) + f(b, c, d) + (k) + (x); \
+		b = ROL(b, 30); \
+	} while (0)
+
+#define LOAD(t) (w[t] = get_be32(block + 4 * (t)))
+#define EXPAND(t) (w[t] = ROL(w[(t) - 3] ^ w[(t) - 8] ^ w[(t) - 14] ^ w[(t) - 16], 1))
+
+#define FIVE_LOAD(f, k, a, b, c, d, e, t) \
+	do { \
+		STEP(f, k, a, b, c, d, e, LOAD(t)); \
+		STEP(f, k, e, a, b, c, d, LOAD((t) + 1)); \
+		STEP(f, k, d, e, a, b, c, LOAD((t) + 2)); \
+		STEP(f, k, c, d, e, a, b, LOAD((t) + 3)); \
+		STEP(f, k, b, c, d, e, a, LOAD((t) + 4)); \
+	} while (0)
+
+#define FIVE_EXPAND(f, k, a, b, c, d, e, t) \
+	do { \
+		STEP(f, k, a, b, c, d, e, EXPAND(t)); \
+		STEP(f, k, e, a, b, c, d, EXPAND((t) + 1)); \
+		STEP(f, k, d, e, a, b, c, EXPAND((t) + 2)); \
+		STEP(f, k, c, d, e, a, b, EXPAND((t) + 3)); \
+		STEP(f, k, b, c, d, e, a, EXPAND((t) + 4)); \
+	} while (0)
+
+/*
+ * The portable compression. Like the hardware ones it spills the schedule,
+ * but it writes the states at steps 58 and 65 directly, on the way past.
+ */
+static void compress_portable(uint32_t ihv[5], const unsigned char *block,
+			      uint32_t w[80], uint32_t state_58[5],
+			      uint32_t state_65[5])
+{
+	uint32_t a = ihv[0], b = ihv[1], c = ihv[2], d = ihv[3], e = ihv[4];
+
+	FIVE_LOAD(F_CH, K0, a, b, c, d, e, 0);
+	FIVE_LOAD(F_CH, K0, a, b, c, d, e, 5);
+	FIVE_LOAD(F_CH, K0, a, b, c, d, e, 10);
+	STEP(F_CH, K0, a, b, c, d, e, LOAD(15));
+	STEP(F_CH, K0, e, a, b, c, d, EXPAND(16));
+	STEP(F_CH, K0, d, e, a, b, c, EXPAND(17));
+	STEP(F_CH, K0, c, d, e, a, b, EXPAND(18));
+	STEP(F_CH, K0, b, c, d, e, a, EXPAND(19));
+
+	FIVE_EXPAND(F_PARITY, K1, a, b, c, d, e, 20);
+	FIVE_EXPAND(F_PARITY, K1, a, b, c, d, e, 25);
+	FIVE_EXPAND(F_PARITY, K1, a, b, c, d, e, 30);
+	FIVE_EXPAND(F_PARITY, K1, a, b, c, d, e, 35);
+
+	FIVE_EXPAND(F_MAJ, K2, a, b, c, d, e, 40);
+	FIVE_EXPAND(F_MAJ, K2, a, b, c, d, e, 45);
+	FIVE_EXPAND(F_MAJ, K2, a, b, c, d, e, 50);
+	STEP(F_MAJ, K2, a, b, c, d, e, EXPAND(55));
+	STEP(F_MAJ, K2, e, a, b, c, d, EXPAND(56));
+	STEP(F_MAJ, K2, d, e, a, b, c, EXPAND(57));
+	state_58[0] = c;
+	state_58[1] = d;
+	state_58[2] = e;
+	state_58[3] = a;
+	state_58[4] = b;
+	STEP(F_MAJ, K2, c, d, e, a, b, EXPAND(58));
+	STEP(F_MAJ, K2, b, c, d, e, a, EXPAND(59));
+
+	FIVE_EXPAND(F_PARITY, K3, a, b, c, d, e, 60);
+	state_65[0] = a;
+	state_65[1] = b;
+	state_65[2] = c;
+	state_65[3] = d;
+	state_65[4] = e;
+	FIVE_EXPAND(F_PARITY, K3, a, b, c, d, e, 65);
+	FIVE_EXPAND(F_PARITY, K3, a, b, c, d, e, 70);
+	FIVE_EXPAND(F_PARITY, K3, a, b, c, d, e, 75);
+
+	ihv[0] += a;
+	ihv[1] += b;
+	ihv[2] += c;
+	ihv[3] += d;
+	ihv[4] += e;
+}
+
+/*
+ * The rest runs only for blocks the filter flags, about one in twenty, so
+ * it favours being short over being fast.
+ */
+
+/*
+ * Moves `s` from the state before step `from` to the one before step `to`,
+ * either way, on the schedule `m1 ^ dm` (`dm` may be NULL). One loop per
+ * round function keeps the steps free of branches.
+ */
+#define WORD(t) (dm ? m1[t] ^ dm[t] : m1[t])
+#define FORWARD(f, k, end) \
+	for (; t < to && t < (end); t++) { \
+		x = ROL(a, 5) + f(b, c, d) + (k) + e + WORD(t); \
+		e = d; \
+		d = c; \
+		c = ROL(b, 30); \
+		b = a; \
+		a = x; \
+	}
+#define BACKWARD(f, k, start) \
+	for (; t > to && t > (start); t--) { \
+		x = a; \
+		a = b; \
+		b = ROL(c, 2); \
+		c = d; \
+		d = e; \
+		e = x - (ROL(a, 5) + f(b, c, d) + (k) + WORD(t - 1)); \
+	}
+
+static void walk(uint32_t s[5], const uint32_t *m1, const uint32_t *dm,
+		 unsigned from, unsigned to)
+{
+	uint32_t a = s[0], b = s[1], c = s[2], d = s[3], e = s[4], x;
+	unsigned t = from;
+
+	FORWARD(F_CH, K0, 20);
+	FORWARD(F_PARITY, K1, 40);
+	FORWARD(F_MAJ, K2, 60);
+	FORWARD(F_PARITY, K3, 80);
+
+	BACKWARD(F_PARITY, K3, 60);
+	BACKWARD(F_MAJ, K2, 40);
+	BACKWARD(F_PARITY, K1, 20);
+	BACKWARD(F_CH, K0, 0);
+
+	s[0] = a;
+	s[1] = b;
+	s[2] = c;
+	s[3] = d;
+	s[4] = e;
+}
+
+/*
+ * The recompression, the way sha1dc/ does it: from this block's state at
+ * `from`, the partner block's chaining value on the way in (`ihv_in`) and
+ * on the way out (`ihv_out`).
+ */
+static void recompress_portable(enum sha1dc_from from, const uint32_t m1[80],
+				const uint32_t dm[80], const uint32_t state[5],
+				uint32_t ihv_in[5], uint32_t ihv_out[5])
+{
+	uint32_t fwd[5];
+	int i;
+
+	memcpy(ihv_in, state, 5 * sizeof(*ihv_in));
+	walk(ihv_in, m1, dm, from, 0);
+	memcpy(fwd, state, sizeof(fwd));
+	walk(fwd, m1, dm, from, 80);
+	for (i = 0; i < 5; i++)
+		ihv_out[i] = ihv_in[i] + fwd[i];
+}
+
+/* For a mitigated ("safe") hash: one more compression of the schedule. */
+static void compress_schedule(uint32_t ihv[5], const uint32_t w[80])
+{
+	uint32_t s[5];
+	int i;
+
+	memcpy(s, ihv, sizeof(s));
+	walk(s, w, NULL, 0, 80);
+	for (i = 0; i < 5; i++)
+		ihv[i] += s[i];
+}
+
+struct backend {
+	const char *name;
+	/*
+	 * Compresses a block, spilling its schedule and the states at steps
+	 * 58 and 65.
+	 */
+	void (*compress)(uint32_t ihv[5], const unsigned char *block,
+			 uint32_t w[80], uint32_t state_58[5],
+			 uint32_t state_65[5]);
+	uint32_t (*ubc_check)(const uint32_t w[80]);
+	int (*available)(void);
+};
+
+/* sha1dc's own UBC check. */
+static uint32_t ubc_check_sha1dc(const uint32_t w[80])
+{
+	uint32_t mask;
+
+	ubc_check(w, &mask);
+	return mask;
+}
+
+/* In order of preference. */
+static const struct backend backends[] = {
+	{ "portable", compress_portable, ubc_check_sha1dc, NULL },
+};
+
+static int usable(const struct backend *be)
+{
+	return !be->available || be->available();
+}
+
+#if defined(__GNUC__)
+/*
+ * The backend in use, chosen on first use. Threads that race to choose it
+ * all store the same value, with relaxed atomics so that they may.
+ */
+static const struct backend *selected;
+
+static const struct backend *backend(void)
+{
+	const struct backend *be = __atomic_load_n(&selected, __ATOMIC_RELAXED);
+	size_t i;
+
+	if (be)
+		return be;
+	/* The last one, "portable", is always usable. */
+	for (i = 0; !usable(&backends[i]); i++)
+		;
+	be = &backends[i];
+	__atomic_store_n(&selected, be, __ATOMIC_RELAXED);
+	return be;
+}
+
+static void select_backend(const struct backend *be)
+{
+	__atomic_store_n(&selected, be, __ATOMIC_RELAXED);
+}
+#else
+/*
+ * Other compilers only get the portable backend (see internal.h), so
+ * there is nothing to choose, and no shared state to guard.
+ */
+static const struct backend *backend(void)
+{
+	return &backends[0];
+}
+
+static void select_backend(const struct backend *be UNUSED)
+{
+}
+#endif
+
+const char *sha1dc_accel_backend(void)
+{
+	return backend()->name;
+}
+
+int sha1dc_accel_select(const char *name)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(backends); i++) {
+		if (!strcmp(backends[i].name, name) && usable(&backends[i])) {
+			select_backend(&backends[i]);
+			return 0;
+		}
+	}
+	return -1;
+}
+
+const char *const *sha1dc_accel_backends(void)
+{
+	static const char *names[ARRAY_SIZE(backends) + 1];
+	size_t i, n = 0;
+
+	for (i = 0; i < ARRAY_SIZE(backends); i++)
+		if (usable(&backends[i]))
+			names[n++] = backends[i].name;
+	names[n] = NULL;
+	return names;
+}
+
+/*
+ * Whether any DV in `candidates` makes this block half of a collision.
+ * `ihv_in` and `ihv_out` are the chaining values before and after it.
+ */
+static SHA1DC_NOINLINE int attacked(SHA1_CTX *ctx, uint32_t candidates,
+				    const uint32_t w[80],
+				    const uint32_t state_58[5],
+				    const uint32_t state_65[5],
+				    const uint32_t ihv_in[5],
+				    const uint32_t ihv_out[5])
+{
+	int i;
+
+	for (i = 0; sha1_dvs[i].dvType != 0; i++) {
+		const dv_info_t *dv = &sha1_dvs[i];
+		enum sha1dc_from from;
+		const uint32_t *state;
+		uint32_t ihv2_in[5], ihv2_out[5];
+
+		if (!(candidates & ((uint32_t)1 << dv->maskb)))
+			continue;
+		switch (dv->testt) {
+		case 58:
+			from = SHA1DC_FROM_58;
+			state = state_58;
+			break;
+		case 65:
+			from = SHA1DC_FROM_65;
+			state = state_65;
+			break;
+		default:
+			BUG("sha1dc DV %d(%d,%d) recompresses from step %d, "
+			    "which sha1dc-accel does not save",
+			    dv->dvType, dv->dvK, dv->dvB, dv->testt);
+		}
+
+		recompress_portable(from, w, dv->dm, state, ihv2_in, ihv2_out);
+		if (!memcmp(ihv2_out, ihv_out, sizeof(ihv2_out)) ||
+		    (ctx->reduced_round_coll &&
+		     !memcmp(ihv2_in, ihv_in, sizeof(ihv2_in))))
+			return 1;
+	}
+	return 0;
+}
+
+static inline void process(const struct backend *be, SHA1_CTX *ctx,
+			   const unsigned char *block)
+{
+	uint32_t w[80], state_58[5], state_65[5], ihv_in[5], candidates;
+
+	memcpy(ihv_in, ctx->ihv, sizeof(ihv_in));
+	be->compress(ctx->ihv, block, w, state_58, state_65);
+	if (!ctx->detect_coll)
+		return;
+
+	candidates = ctx->ubc_check ? be->ubc_check(w) : 0xFFFFFFFF;
+	if (candidates &&
+	    attacked(ctx, candidates, w, state_58, state_65, ihv_in,
+		     ctx->ihv)) {
+		ctx->found_collision = 1;
+		/*
+		 * Two more compressions of this block give a digest that the
+		 * other block of the pair does not share.
+		 */
+		if (ctx->safe_hash) {
+			compress_schedule(ctx->ihv, w);
+			compress_schedule(ctx->ihv, w);
+		}
+	}
+}
+
+void sha1dc_accel_update(SHA1_CTX *ctx, const void *data, size_t len)
+{
+	const struct backend *be = backend();
+	const unsigned char *buf = data;
+	unsigned left, fill;
+
+	if (!len)
+		return;
+
+	left = ctx->total & 63;
+	fill = 64 - left;
+
+	if (left && len >= fill) {
+		ctx->total += fill;
+		memcpy(ctx->buffer + left, buf, fill);
+		process(be, ctx, ctx->buffer);
+		buf += fill;
+		len -= fill;
+		left = 0;
+	}
+	while (len >= 64) {
+		ctx->total += 64;
+		process(be, ctx, buf);
+		buf += 64;
+		len -= 64;
+	}
+	if (len) {
+		ctx->total += len;
+		memcpy(ctx->buffer + left, buf, len);
+	}
+}
+
+int sha1dc_accel_final(unsigned char hash[20], SHA1_CTX *ctx)
+{
+	static const unsigned char padding[64] = { 0x80 };
+	uint32_t last = ctx->total & 63;
+	uint32_t padn = last < 56 ? 56 - last : 120 - last;
+	uint64_t bits;
+	int i;
+
+	sha1dc_accel_update(ctx, padding, padn);
+	bits = (ctx->total - padn) << 3;
+	put_be32(ctx->buffer + 56, (uint32_t)(bits >> 32));
+	put_be32(ctx->buffer + 60, (uint32_t)bits);
+	process(backend(), ctx, ctx->buffer);
+
+	for (i = 0; i < 5; i++)
+		put_be32(hash + 4 * i, ctx->ihv[i]);
+	return ctx->found_collision;
+}
diff --git a/sha1dc-accel/sha1.h b/sha1dc-accel/sha1.h
new file mode 100644
index 0000000000..53dda518f0
--- /dev/null
+++ b/sha1dc-accel/sha1.h
@@ -0,0 +1,31 @@
+#ifndef SHA1DC_ACCEL_SHA1_H
+#define SHA1DC_ACCEL_SHA1_H
+
+#if defined(DC_SHA1_SUBMODULE)
+#include "../sha1collisiondetection/lib/sha1.h"
+#else
+#include "../sha1dc/sha1.h"
+#endif
+
+/*
+ * A faster implementation of SHA-1 with collision detection, working on
+ * the SHA1_CTX of sha1dc/ (or of the sha1collisiondetection submodule).
+ * SHA1DCInit() and the SHA1DCSet*() functions set it up as usual; these
+ * then take the place of SHA1DCUpdate() and SHA1DCFinal(), with the same
+ * results. See sha1.c.
+ */
+
+void sha1dc_accel_update(SHA1_CTX *ctx, const void *data, size_t len);
+int sha1dc_accel_final(unsigned char hash[20], SHA1_CTX *ctx);
+
+/*
+ * The implementation in use, such as "shani+avx2" or "portable". For tests,
+ * sha1dc_accel_select() switches to another one by that name; it returns -1
+ * if this build or CPU does not have it. Neither is thread-safe.
+ */
+const char *sha1dc_accel_backend(void);
+int sha1dc_accel_select(const char *name);
+/* The names this build and CPU can use, NULL-terminated. */
+const char *const *sha1dc_accel_backends(void);
+
+#endif /* SHA1DC_ACCEL_SHA1_H */
diff --git a/sha1dc_git.c b/sha1dc_git.c
index fe58d7962a..03958762cf 100644
--- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -2,6 +2,15 @@
 #include "sha1dc_git.h"
 #include "hex.h"
 
+/*
+ * Unless told otherwise, hash with sha1dc-accel/, which gives the same
+ * results as sha1dc/ on the same SHA1_CTX.
+ */
+#if !defined(DC_SHA1_EXTERNAL) && !defined(DC_SHA1_NO_ACCEL)
+#include "sha1dc-accel/sha1.h"
+#define USE_SHA1DC_ACCEL
+#endif
+
 #ifdef DC_SHA1_EXTERNAL
 /*
  * Same as SHA1DCInit, but with default save_hash=0
@@ -18,8 +27,13 @@ void git_SHA1DCInit(SHA1_CTX *ctx)
  */
 void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
 {
+#ifdef USE_SHA1DC_ACCEL
+	if (!sha1dc_accel_final(hash, ctx))
+		return;
+#else
 	if (!SHA1DCFinal(hash, ctx))
 		return;
+#endif
 	die("SHA-1 appears to be part of a collision attack: %s",
 	    hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
 }
@@ -29,6 +43,9 @@ void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
  */
 void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, size_t len)
 {
+#ifdef USE_SHA1DC_ACCEL
+	sha1dc_accel_update(ctx, vdata, len);
+#else
 	const char *data = vdata;
 	while (len > INT_MAX) {
 		SHA1DCUpdate(ctx, data, INT_MAX);
@@ -36,4 +53,5 @@ void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, size_t len)
 		len -= INT_MAX;
 	}
 	SHA1DCUpdate(ctx, data, len);
+#endif
 }
diff --git a/t/.gitattributes b/t/.gitattributes
index e867f38c71..f9437159ae 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -2,6 +2,7 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
 /chainlint/*.expect eol=lf -whitespace
 /greplint/*.expect eol=lf -whitespace
 /greplint/*.test eol=lf -whitespace
+/t0013/*.bin binary
 /t0110/url-* binary
 /t3206/* eol=lf
 /t3900/*.txt eol=lf
diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index 349540c4df..7a0e9cc716 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -1,8 +1,20 @@
 #include "test-tool.h"
 #include "hash.h"
+#include "strbuf.h"
+
+#if defined(SHA1_DC) && !defined(DC_SHA1_EXTERNAL) && !defined(DC_SHA1_NO_ACCEL)
+#include "sha1dc-accel/sha1.h"
+#define HAVE_SHA1DC_ACCEL
+#endif
 
 int cmd__sha1(int ac, const char **av)
 {
+#ifdef HAVE_SHA1DC_ACCEL
+	const char *backend = getenv("GIT_TEST_SHA1DC_BACKEND");
+
+	if (backend && sha1dc_accel_select(backend))
+		die("sha1dc backend '%s' is not available", backend);
+#endif
 	return cmd_hash_impl(ac, av, GIT_HASH_SHA1, 0);
 }
 
@@ -14,6 +26,89 @@ int cmd__sha1_is_sha1dc(int argc UNUSED, const char **argv UNUSED)
 	return 1;
 }
 
+/*
+ * Lists the implementations of collision-detecting SHA-1 this build and
+ * CPU can use, which GIT_TEST_SHA1DC_BACKEND selects for "test-tool sha1".
+ */
+int cmd__sha1dc_backends(int argc UNUSED, const char **argv UNUSED)
+{
+#ifdef HAVE_SHA1DC_ACCEL
+	const char *const *names;
+
+	for (names = sha1dc_accel_backends(); *names; names++)
+		puts(*names);
+#endif
+	return 0;
+}
+
+/*
+ * Hashes a file with sha1dc/ and with sha1dc-accel/ (the backend that
+ * GIT_TEST_SHA1DC_BACKEND selects), under every combination of settings,
+ * and dies if they ever disagree on the digest or on whether there is a
+ * collision. sha1dc-accel/ sees the file split at and around every block
+ * boundary, with an empty update in between. Prints what sha1dc/ found for
+ * each combination.
+ */
+int cmd__sha1dc_compare(int argc MAYBE_UNUSED, const char **argv MAYBE_UNUSED)
+{
+#ifdef HAVE_SHA1DC_ACCEL
+	const char *backend = getenv("GIT_TEST_SHA1DC_BACKEND");
+	struct strbuf buf = STRBUF_INIT;
+	int mode;
+
+	if (argc != 2)
+		die("usage: test-tool sha1dc-compare <file>");
+	if (backend && sha1dc_accel_select(backend))
+		die("sha1dc backend '%s' is not available", backend);
+	if (strbuf_read_file(&buf, argv[1], 0) < 0)
+		die_errno("could not read '%s'", argv[1]);
+
+	for (mode = 0; mode < 16; mode++) {
+		int detect = !!(mode & 8), safe = !!(mode & 4);
+		int ubc = !!(mode & 2), reduced = !!(mode & 1);
+		unsigned char want[20], got[20];
+		SHA1_CTX init, ctx;
+		int want_coll, got_coll, i;
+		size_t split;
+
+		SHA1DCInit(&init);
+		SHA1DCSetUseDetectColl(&init, detect);
+		SHA1DCSetSafeHash(&init, safe);
+		SHA1DCSetUseUBC(&init, ubc);
+		SHA1DCSetDetectReducedRoundCollision(&init, reduced);
+
+		ctx = init;
+		SHA1DCUpdate(&ctx, buf.buf, buf.len);
+		want_coll = SHA1DCFinal(want, &ctx);
+
+		for (split = 0; split <= buf.len; split++) {
+			if (split % 64 > 1 && split % 64 < 63 && split != buf.len)
+				continue;
+			ctx = init;
+			sha1dc_accel_update(&ctx, buf.buf, split);
+			sha1dc_accel_update(&ctx, buf.buf + split, 0);
+			sha1dc_accel_update(&ctx, buf.buf + split, buf.len - split);
+			got_coll = sha1dc_accel_final(got, &ctx);
+			if (got_coll != want_coll || memcmp(got, want, sizeof(got)))
+				die("%s disagrees with sha1dc/ on '%s' with detect=%d "
+				    "safe=%d ubc=%d reduced=%d, split at %"PRIuMAX,
+				    sha1dc_accel_backend(), argv[1], detect, safe,
+				    ubc, reduced, (uintmax_t)split);
+		}
+
+		printf("detect=%d safe=%d ubc=%d reduced=%d collision=%d ",
+		       detect, safe, ubc, reduced, want_coll);
+		for (i = 0; i < 20; i++)
+			printf("%02x", want[i]);
+		putchar('\n');
+	}
+	strbuf_release(&buf);
+	return 0;
+#else
+	die("test-tool sha1dc-compare: not built with sha1dc-accel");
+#endif
+}
+
 int cmd__sha1_unsafe(int ac, const char **av)
 {
 	return cmd_hash_impl(ac, av, GIT_HASH_SHA1, 1);
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b71a22b43b..c459218f0b 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -73,6 +73,8 @@ static struct test_cmd cmds[] = {
 	{ "serve-v2", cmd__serve_v2 },
 	{ "sha1", cmd__sha1 },
 	{ "sha1-is-sha1dc", cmd__sha1_is_sha1dc },
+	{ "sha1dc-backends", cmd__sha1dc_backends },
+	{ "sha1dc-compare", cmd__sha1dc_compare },
 	{ "sha1-unsafe", cmd__sha1_unsafe },
 	{ "sha256", cmd__sha256 },
 	{ "sigchain", cmd__sigchain },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f2885b33d5..f0cdbddcdf 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -66,6 +66,8 @@ int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__serve_v2(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 int cmd__sha1_is_sha1dc(int argc, const char **argv);
+int cmd__sha1dc_backends(int argc, const char **argv);
+int cmd__sha1dc_compare(int argc, const char **argv);
 int cmd__sha1_unsafe(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
diff --git a/t/meson.build b/t/meson.build
index 3ca7b27104..ec25f0de40 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -20,6 +20,7 @@ clar_test_suites = [
   'unit-tests/u-reftable-stack.c',
   'unit-tests/u-reftable-table.c',
   'unit-tests/u-reftable-tree.c',
+  'unit-tests/u-sha1dc.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
   'unit-tests/u-string-list.c',
diff --git a/t/t0013-sha1dc.sh b/t/t0013-sha1dc.sh
index 3ea3169d92..c3c4b9d951 100755
--- a/t/t0013-sha1dc.sh
+++ b/t/t0013-sha1dc.sh
@@ -19,4 +19,51 @@ test_expect_success 'test-sha1 detects shattered pdf' '
 	test_grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err
 '
 
+test_expect_success 'test-sha1 detects SHA-mbles chosen-prefix collision' '
+	test_must_fail test-tool sha1 <"$TEST_DATA/sha-mbles-1.bin" 2>err &&
+	test_grep collision err &&
+	test_grep 8ac60ba76f1999a1ab70223f225aefdc78d4ddc0 err
+'
+
+# Each implementation of the detection this build and CPU can use.
+for backend in $(test-tool sha1dc-backends)
+do
+	test_expect_success "$backend: detects collisions" '
+		test_must_fail env GIT_TEST_SHA1DC_BACKEND=$backend \
+			test-tool sha1 <"$TEST_DATA/shattered-1.pdf" 2>err &&
+		test_grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err &&
+		test_must_fail env GIT_TEST_SHA1DC_BACKEND=$backend \
+			test-tool sha1 <"$TEST_DATA/sha-mbles-1.bin" 2>err &&
+		test_grep 8ac60ba76f1999a1ab70223f225aefdc78d4ddc0 err
+	'
+
+	# In every combination of settings, and with the input split around
+	# each block, it must find what sha1dc/ finds and give its digest.
+	test_expect_success "$backend: agrees with sha1dc/ on collisions" '
+		test_copy_bytes 320 <"$TEST_DATA/shattered-1.pdf" >shattered &&
+		for f in shattered "$TEST_DATA/sha-mbles-1.bin"
+		do
+			GIT_TEST_SHA1DC_BACKEND=$backend \
+				test-tool sha1dc-compare "$f" >out &&
+			test_grep ! "detect=1 .* collision=0" out &&
+			test_grep ! "detect=0 .* collision=1" out || return 1
+		done &&
+
+		# A reduced-round collision counts only when asked for.
+		GIT_TEST_SHA1DC_BACKEND=$backend test-tool sha1dc-compare \
+			"$TEST_DATA/sha1-reduced-round.bin" >out &&
+		grep "collision=1" out >actual &&
+		grep "detect=1 .* reduced=1 collision=1" out >expect &&
+		test_line_count = 4 expect &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$backend: hashes like the others" '
+		test-tool genrandom "$backend" 100000 >data &&
+		GIT_TEST_SHA1DC_BACKEND=$backend test-tool sha1 <data >actual &&
+		test-tool sha1 <data >expect &&
+		test_cmp expect actual
+	'
+done
+
 test_done
diff --git a/t/t0013/sha-mbles-1.bin b/t/t0013/sha-mbles-1.bin
new file mode 100644
index 0000000000000000000000000000000000000000..5a7c30e97646c66422abe0a9793a5fcb9f1cf8d6
GIT binary patch
literal 640
zcmV-`0)PFP1Pug#=of$iAOQbMWqBZJb0BbGa&#bXW*}i8V{dG1X>)0BZXqB^bSHBl
zVIXvJVQ?XN#v1Ui%mqai*(XkO2VzSd$NM9gi@4s4S6#Y$o~tpzXG?9DLwKksb1(IU
z9Co7S2XeKfeBtWE3%QfQEsSvDN>7bn&F#UnES&M4F|Q;kb)7=w-`g>9pICMy?o}x{
zw%puBpUP8JJ8<}Z-Y}v^>N@tvS)%d_G7WYOwomkV2v5_@v(40lV%ch(Lk1Vh|7<qK
zH|0OxC_#T>Z|qd<c|)XbUso{lyEywD_TUKs5YP@Jt$4qZWEqoSj*S(Hc%L-HZ{g+w
ze>J4b`+{(G#SY32i+svyyDTet0$KULm2lmSL^q=mU$6JW%D|e^Qf38QClE(f7mlv~
zf?6!9D$ljvWX^U$+*zeTsr;OEXIA3kJ;xKs!c3Qts%s87r}bYHMJgPkg$>=6V*Q#J
ztwKp^sc;DQMsoI!^kM6Wu$eQ~Cban&bezB^{oQOrU&JA3HP91H6)0P)EVqQD_sg{V
zQB6zm_9J}o3Z9=6E1CvwZ_$5jLYQ=TSa0@Gua<Owv?jTSE1HPp20vN5Gfcn+Q2084
z#3xa=8FbSC{3scs=<(w$8&S&`=D)<-o38eC)T;HdS4sqbk8RTI6*`kaB9oU*l8=ba
z*)}}>`F!H%LccW0YmW1WR(AfS%&6t}-k`d&K|M|24(A@=9~LXyZ62@LCFZWWu4*+-
z@qF?Hqy+oh68uF?LH*fW@<o<pqOAih9i|F%CO~!9@!;0MKsx83*kRv4<#2I`-ChUL
aSeu`VW-wJhkHb>4;KF^V3*EX*WC9JhR6N@N

literal 0
HcmV?d00001

diff --git a/t/t0013/sha1-reduced-round.bin b/t/t0013/sha1-reduced-round.bin
new file mode 100644
index 0000000000000000000000000000000000000000..4623336222bd5c9e7b1b0e244a5897430c1b5c12
GIT binary patch
literal 128
zcmV-`0Du3yemOb>aQ1}Yq=eq3R)<>6-}%Tb0s(7=4(It1;e;4*zrXPYaFxmJM6d36
z5+n(uvg<Auz|X=4#ULmUI6NzJ=Hkdhf3ZGJO<lI*gWw%|>Le^HwlGv^MX^H+A(X58
iQZ~LT$sQRU5x<XSUiqt^kK<}UEWbI|d>^ztun2PMcs$<#

literal 0
HcmV?d00001

diff --git a/t/unit-tests/u-sha1dc.c b/t/unit-tests/u-sha1dc.c
new file mode 100644
index 0000000000..31fcd68451
--- /dev/null
+++ b/t/unit-tests/u-sha1dc.c
@@ -0,0 +1,145 @@
+#include "unit-test.h"
+#include "hash.h"
+
+/*
+ * Tests sha1dc-accel/ against sha1dc/, which it must agree with exactly.
+ */
+#if defined(SHA1_DC) && !defined(DC_SHA1_EXTERNAL) && !defined(DC_SHA1_NO_ACCEL)
+#define HAVE_SHA1DC_ACCEL
+
+#if defined(DC_SHA1_SUBMODULE)
+#include "sha1collisiondetection/lib/ubc_check.h"
+#else
+#include "sha1dc/ubc_check.h"
+#endif
+#include "sha1dc-accel/sha1.h"
+#include "sha1dc-accel/internal.h"
+
+static uint64_t rng_state;
+
+static void rng_seed(uint64_t seed)
+{
+	rng_state = seed * 2 + 1;
+}
+
+static uint32_t rng(void)
+{
+	/* xorshift64* */
+	rng_state ^= rng_state >> 12;
+	rng_state ^= rng_state << 25;
+	rng_state ^= rng_state >> 27;
+	return (uint32_t)((rng_state * 0x2545F4914F6CDD1DULL) >> 32);
+}
+
+/*
+ * Hashes `buf` with sha1dc/ and with sha1dc-accel/ under the same settings
+ * and checks that both agree. Returns whether they found a collision.
+ */
+static int check_same(const unsigned char *buf, size_t len, int split,
+		      int safe_hash, int ubc, int reduced_round)
+{
+	SHA1_CTX want_ctx, got_ctx;
+	unsigned char want[20], got[20];
+	int want_coll, got_coll;
+
+	SHA1DCInit(&want_ctx);
+	SHA1DCSetSafeHash(&want_ctx, safe_hash);
+	SHA1DCSetUseUBC(&want_ctx, ubc);
+	SHA1DCSetDetectReducedRoundCollision(&want_ctx, reduced_round);
+	got_ctx = want_ctx;
+
+	SHA1DCUpdate(&want_ctx, (const char *)buf, len);
+	want_coll = SHA1DCFinal(want, &want_ctx);
+
+	sha1dc_accel_update(&got_ctx, buf, split);
+	sha1dc_accel_update(&got_ctx, buf + split, len - split);
+	got_coll = sha1dc_accel_final(got, &got_ctx);
+
+	cl_assert_equal_i(got_coll, want_coll);
+	cl_assert(!memcmp(got, want, sizeof(want)));
+	return got_coll;
+}
+
+/*
+ * sha1dc-accel/ relies on sha1dc/'s table of DVs having the 32 DVs below,
+ * with DV n at bit n of the UBC mask, and each recompressing from a state
+ * it saves (step 58 or 65). A change there must fail here, rather than
+ * quietly check the wrong DV or start from the wrong state.
+ */
+static void dv_table_is_as_expected(void)
+{
+	static const struct { int type, k, b; } want[] = {
+		{ 1, 43, 0 }, { 1, 44, 0 }, { 1, 45, 0 }, { 1, 46, 0 },
+		{ 1, 46, 2 }, { 1, 47, 0 }, { 1, 47, 2 }, { 1, 48, 0 },
+		{ 1, 48, 2 }, { 1, 49, 0 }, { 1, 49, 2 }, { 1, 50, 0 },
+		{ 1, 50, 2 }, { 1, 51, 0 }, { 1, 51, 2 }, { 1, 52, 0 },
+		{ 2, 45, 0 }, { 2, 46, 0 }, { 2, 46, 2 }, { 2, 47, 0 },
+		{ 2, 48, 0 }, { 2, 49, 0 }, { 2, 49, 2 }, { 2, 50, 0 },
+		{ 2, 50, 2 }, { 2, 51, 0 }, { 2, 51, 2 }, { 2, 52, 0 },
+		{ 2, 53, 0 }, { 2, 54, 0 }, { 2, 55, 0 }, { 2, 56, 0 },
+	};
+	int i;
+
+	for (i = 0; sha1_dvs[i].dvType != 0; i++) {
+		const dv_info_t *dv = &sha1_dvs[i];
+
+		cl_assert(i < (int)ARRAY_SIZE(want));
+		cl_assert_equal_i(dv->dvType, want[i].type);
+		cl_assert_equal_i(dv->dvK, want[i].k);
+		cl_assert_equal_i(dv->dvB, want[i].b);
+		cl_assert_equal_i(dv->maski, 0);
+		cl_assert_equal_i(dv->maskb, i);
+		cl_assert(dv->testt == SHA1DC_FROM_58 || dv->testt == SHA1DC_FROM_65);
+	}
+	cl_assert_equal_i(i, ARRAY_SIZE(want));
+}
+
+static void every_backend_agrees_with_sha1dc(void)
+{
+	const char *const *names = sha1dc_accel_backends();
+	unsigned char buf[4200];
+	const char *orig = sha1dc_accel_backend();
+
+	for (; *names; names++) {
+		size_t i;
+
+		cl_assert_equal_i(sha1dc_accel_select(*names), 0);
+		rng_seed(1);
+		for (i = 0; i < sizeof(buf); i++)
+			buf[i] = rng();
+
+		for (i = 0; i < 600; i++) {
+			size_t len = i < 200 ? i : rng() % (sizeof(buf) - 16);
+			size_t off = rng() % 16;
+			size_t split = len ? rng() % (len + 1) : 0;
+			/*
+			 * Without the filter, every block is recompressed
+			 * for all 32 DVs, which must not find anything in
+			 * random data either.
+			 */
+			int ubc = i % 5 != 4;
+
+			cl_assert_equal_i(check_same(buf + off, len, split,
+						     i & 1, ubc, i % 3 == 0), 0);
+		}
+	}
+	cl_assert_equal_i(sha1dc_accel_select(orig), 0);
+}
+
+#endif /* HAVE_SHA1DC_ACCEL */
+
+#ifdef HAVE_SHA1DC_ACCEL
+#define RUN_OR_SKIP(fn) fn()
+#else
+#define RUN_OR_SKIP(fn) cl_skip()
+#endif
+
+void test_sha1dc__dv_table_is_as_expected(void)
+{
+	RUN_OR_SKIP(dv_table_is_as_expected);
+}
+
+void test_sha1dc__every_backend_agrees_with_sha1dc(void)
+{
+	RUN_OR_SKIP(every_backend_agrees_with_sha1dc);
+}
-- 
2.50.1 (Apple Git-155)


