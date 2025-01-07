Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306381F2C44
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263636; cv=none; b=LT77riQR5x09WCRMscwKQnlNDRCAX2tlYd7w5aQY5QcWHhRMa+j7d6gu6QGDriIOYLzYn0a8KhAnWUjGvWhLlla1YtPfqws3wuBUx/IX3HtapDYpSjE6iRu/aiKxrn1xa/EeXcid+yXRE/r17ByiLX/gQ6zG6iMBf9HscOgbSrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263636; c=relaxed/simple;
	bh=FXEXDGh68JkInQ9TqpsrlNrmga4+34Xs9p/hTqjHM3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZYZG+g1l5e6OJ7jz23judkv7hEW576jYBARVoy8MWvcnQF8aa27OxEhXU1QLfJIqKY22rcwGOaBzFQBaOV87EJzMPye9YpZikxJ2g2GmeRMZRmHpMUQymvPF0SFa8pDQDtdDD+3RUJmrwP2/HlAqcYYzzA7EQ4eFNbDzX0Xddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Of419Qd2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bmw0frqR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Of419Qd2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bmw0frqR"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 203A61140169;
	Tue,  7 Jan 2025 10:27:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 07 Jan 2025 10:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736263631;
	 x=1736350031; bh=28ANiA4160CGlqsNGgqhzCi4IiKxYtWq3PDnIEU6NyU=; b=
	Of419Qd2I3dplWMiWneEQ3nPTFASKGNN34BdPxl+bVArBnJ93tmd3iAsF4ZLEQiB
	PzE/epzSKvVt8CnHwUu9VS9kqH2NKHdMF0CieFbuXImWBTfdNKRUzEQieZF1oSVG
	Mg5MfNGsjDNZMmQeXqbQNmvuIq+To/lhG3xErqfoCwYWAIxR34WrRXfN+FOJ697w
	Hm672wjz3/r7VT9wMb87ajAMqHQSQ5HHntB9YRfIQ+mVCzVG+D9ZO7LJT3bscG6E
	xnTChW8u41dVFoiW1vI8Ac0TMLaHDEIZ8jYr5DPDIQxyCY5Sn6I6jpy+AGB9LR/5
	HSedWXGa12cHh+0tiE3bdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736263631; x=
	1736350031; bh=28ANiA4160CGlqsNGgqhzCi4IiKxYtWq3PDnIEU6NyU=; b=B
	mw0frqRD3eKWEHegM8Q3Y9L3uASQT30jVgn15JLPkYVEHwgkDimfagkXRcnMkiax
	dv4s2AacoIKEMspFcp83hDEgN3QhHyXnApJJ9l0F2VPADQ9wUCYfRKZRsLvIs5dg
	Buu+Ha0W9J31KpKZj3/zNDS9lwyoz9idKz+Yd/nSbrWP28KKpoJrIEvisOha+h4s
	IPp8kJI1ks+Kf3xM3ANLDMQ8jHWbM2mMeZVX9iUmVfRdpBAyx1HdlRIIpHtdKdGv
	Ud2u1Ng9iR+RWgZwqUimUitqftIuBwsvnZ2Cx+WZGJRSboPrZ2mIT9FGuk7dF08o
	Bzq8U1SWmAYG1cOXursTg==
X-ME-Sender: <xms:zkd9Z0booki_NU0CCow9OD1UPhdAcN_HqEvyfHoIg0cXvgJus02oTw>
    <xme:zkd9Z_bliWY111KPbN-3bPj-dmzc7gxwz8SSbYJQRuQVbRE2lP2KcBMizaUNS8lP2
    UKpOI_F4OnzZvPtYw>
X-ME-Received: <xmr:zkd9Z-9FetfDr-dgJNoZfp5ie7s0Y677GCQ6PrudBkn7nAh34R6gipCH8WMVy6AM9hSqLqIRN7kTatxoYCLxpsqnN7Rk_7-EMrfPvlsV2sp_sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeeigeevtddvuedtjeelteehhfeukeegkeevtddvleeu
    geeiudduiefgveevveefleenucffohhmrghinhepuhhpuggrthgvrdhnvgifnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprh
    grnhgurghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zkd9Z-rsG5kuMOzxwo-wC3g-5E9IQprDxh6RIUk7dQ1CroVDHBYwsw>
    <xmx:zkd9Z_rfudfQC9iTGONTYN3p6k8slfzZYJa4pR6iCWWvaglfsvrYKg>
    <xmx:zkd9Z8SVvaBC667KnUTr0jxOHw19GkqpUF39iLzBmZfFQbNJQWF0wQ>
    <xmx:zkd9Z_ptlEAeFRDOdSadDiIGLoBZ4M56R4S4xQlfaEUhDAfb5OW-2Q>
    <xmx:z0d9Z20y_6LfdfiyhamfRWFqWEMzi4S2uPKB5bdTMRPTpQrNxNvuOaFq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 10:27:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 964df029 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 15:27:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jan 2025 16:26:59 +0100
Subject: [PATCH 1/2] wrapper: allow generating insecure random bytes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-b4-pks-reftable-csprng-v1-1-6109a54a8756@pks.im>
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
In-Reply-To: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

The `csprng_bytes()` function generates randomness and writes it into a
caller-provided buffer. It abstracts over a couple of implementations,
where the exact one that is used depends on the platform.

These implementations have different guarantees: while some guarantee to
never fail (arc4random(3)), others may fail. There are two significant
failures to distinguish from one another:

  - Systemic failure, where e.g. opening "/dev/urandom" fails or when
    OpenSSL doesn't have a provider configured.

  - Entropy failure, where the entropy pool is exhausted, and thus the
    function cannot guarantee strong cryptographic randomness.

While we cannot do anything about the former, the latter failure can be
acceptable in some situations where we don't care whether or not the
randomness can be predicted.

Introduce a new `CSPRNG_BYTES_INSECURE` flag that allows callers to opt
into weak cryptographic randomness. The exact behaviour of the flag
depends on the underlying implementation:

    - `arc4random_buf()` never returns an error, so it doesn't change.

    - `getrandom()` pulls from "/dev/urandom" by default, which never
      blocks on modern systems even when the entropy pool is empty.

    - `getentropy()` seems to block when there is not enough randomness
      available, and there is no way of changing that behaviour.

    - `GtlGenRandom()` doesn't mention anything about its specific
      failure mode.

    - The fallback reads from "/dev/urandom", which also returns bytes in
      case the entropy pool is drained in modern Linux systems.

That only leaves OpenSSL with `RAND_bytes()`, which returns an error in
case the returned data wouldn't be cryptographically safe. This function
is replaced with a call to `RAND_pseudo_bytes()`, which can indicate
whether or not the returned data is cryptographically secure via its
return value. If it is insecure, and if the `CSPRNG_BYTES_INSECURE` flag
is set, then we ignore the insecurity and return the data regardless.

It is somewhat questionable whether we really need the flag in the first
place, or whether we wouldn't just ignore the potentially-insecure data.
But the risk of doing that is that we might have or grow callsites that
aren't aware of the potential insecureness of the data in places where
it really matters. So using a flag to opt-in to that behaviour feels
like the more secure choice.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c                        |  2 +-
 reftable/stack.c                    |  2 +-
 t/helper/test-csprng.c              |  2 +-
 t/unit-tests/t-reftable-readwrite.c |  6 +++---
 wrapper.c                           | 24 ++++++++++++++----------
 wrapper.h                           | 16 ++++++++++++----
 6 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index a9b1c36de27da2ffb16aaa45e979cbaeec18bfa1..3e754f25bba2aa16fbae9b2b6229961a53409395 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1909,7 +1909,7 @@ static int get_random_minute(void)
 	if (getenv("GIT_TEST_MAINT_SCHEDULER"))
 		return 13;
 
-	return git_rand() % 60;
+	return git_rand(0) % 60;
 }
 
 static int is_launchctl_available(void)
diff --git a/reftable/stack.c b/reftable/stack.c
index 531660a49f0948c33041831ee0d740feacb22b2f..6d0aa774e7e29d5366ed55df19725944f8eef792 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -659,7 +659,7 @@ int reftable_stack_add(struct reftable_stack *st,
 static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
 {
 	char buf[100];
-	uint32_t rnd = (uint32_t)git_rand();
+	uint32_t rnd = (uint32_t)git_rand(0);
 	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
 		 min, max, rnd);
 	reftable_buf_reset(dest);
diff --git a/t/helper/test-csprng.c b/t/helper/test-csprng.c
index a4a0aca61773b0b30de618955e5a5b61bba2d0cc..c86dcc4870fed8ab81aa7c6c17d77c0b32101cf8 100644
--- a/t/helper/test-csprng.c
+++ b/t/helper/test-csprng.c
@@ -15,7 +15,7 @@ int cmd__csprng(int argc, const char **argv)
 
 	while (count) {
 		unsigned long chunk = count < sizeof(buf) ? count : sizeof(buf);
-		if (csprng_bytes(buf, chunk) < 0) {
+		if (csprng_bytes(buf, chunk, 0) < 0) {
 			perror("failed to read");
 			return 5;
 		}
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 6b75a419b9d3bbfb720a3c39f741f940dfcd56aa..f22b9775639e3ec9167336100753d5736e5a2957 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -108,8 +108,8 @@ static void t_log_buffer_size(void)
 	   hash, to ensure that the compressed part is larger than the original.
 	*/
 	for (i = 0; i < REFTABLE_HASH_SIZE_SHA1; i++) {
-		log.value.update.old_hash[i] = (uint8_t)(git_rand() % 256);
-		log.value.update.new_hash[i] = (uint8_t)(git_rand() % 256);
+		log.value.update.old_hash[i] = (uint8_t)(git_rand(0) % 256);
+		log.value.update.new_hash[i] = (uint8_t)(git_rand(0) % 256);
 	}
 	reftable_writer_set_limits(w, update_index, update_index);
 	err = reftable_writer_add_log(w, &log);
@@ -325,7 +325,7 @@ static void t_log_zlib_corruption(void)
 	};
 
 	for (i = 0; i < sizeof(message) - 1; i++)
-		message[i] = (uint8_t)(git_rand() % 64 + ' ');
+		message[i] = (uint8_t)(git_rand(0) % 64 + ' ');
 
 	reftable_writer_set_limits(w, 1, 1);
 
diff --git a/wrapper.c b/wrapper.c
index fa79fd6ec9e144509f34e007bb2ffa458d69e695..8b985931490d62acb2030c147b8728b34917df8a 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -479,7 +479,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 	for (count = 0; count < TMP_MAX; ++count) {
 		int i;
 		uint64_t v;
-		if (csprng_bytes(&v, sizeof(v)) < 0)
+		if (csprng_bytes(&v, sizeof(v), 0) < 0)
 			return error_errno("unable to get random bytes for temporary file");
 
 		/* Fill in the random bits. */
@@ -750,7 +750,7 @@ int open_nofollow(const char *path, int flags)
 #endif
 }
 
-int csprng_bytes(void *buf, size_t len)
+int csprng_bytes(void *buf, size_t len, MAYBE_UNUSED unsigned flags)
 {
 #if defined(HAVE_ARC4RANDOM) || defined(HAVE_ARC4RANDOM_LIBBSD)
 	/* This function never returns an error. */
@@ -785,14 +785,18 @@ int csprng_bytes(void *buf, size_t len)
 		return -1;
 	return 0;
 #elif defined(HAVE_OPENSSL_CSPRNG)
-	int res = RAND_bytes(buf, len);
-	if (res == 1)
+	switch (RAND_pseudo_bytes(buf, len)) {
+	case 1:
 		return 0;
-	if (res == -1)
-		errno = ENOTSUP;
-	else
+	case 0:
+		if (flags & CSPRNG_BYTES_INSECURE)
+			return 0;
 		errno = EIO;
-	return -1;
+		return -1;
+	default:
+		errno = ENOTSUP;
+		return -1;
+	}
 #else
 	ssize_t res;
 	char *p = buf;
@@ -816,11 +820,11 @@ int csprng_bytes(void *buf, size_t len)
 #endif
 }
 
-uint32_t git_rand(void)
+uint32_t git_rand(unsigned flags)
 {
 	uint32_t result;
 
-	if (csprng_bytes(&result, sizeof(result)) < 0)
+	if (csprng_bytes(&result, sizeof(result), flags) < 0)
 		die(_("unable to get random bytes"));
 
 	return result;
diff --git a/wrapper.h b/wrapper.h
index a6b3e1f09ecdef72fdcc4a234df7a176c4daded6..7df824e34a906e9f822ad3bee27b8b1b0000621b 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -127,18 +127,26 @@ int open_nofollow(const char *path, int flags);
 
 void sleep_millisec(int millisec);
 
+enum {
+	/*
+	 * Accept insecure bytes, which some CSPRNG implementations may return
+	 * in case the entropy pool has been exhausted.
+	 */
+	CSPRNG_BYTES_INSECURE = (1 << 0),
+};
+
 /*
  * Generate len bytes from the system cryptographically secure PRNG.
  * Returns 0 on success and -1 on error, setting errno.  The inability to
- * satisfy the full request is an error.
+ * satisfy the full request is an error. Accepts CSPRNG flags.
  */
-int csprng_bytes(void *buf, size_t len);
+int csprng_bytes(void *buf, size_t len, unsigned flags);
 
 /*
  * Returns a random uint32_t, uniformly distributed across all possible
- * values.
+ * values. Accepts CSPRNG flags.
  */
-uint32_t git_rand(void);
+uint32_t git_rand(unsigned flags);
 
 /* Provide log2 of the given `size_t`. */
 static inline unsigned log2u(uintmax_t sz)

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

