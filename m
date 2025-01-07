Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B884879B
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 06:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736232722; cv=none; b=mWFsh/LVQXWyvemuIPokJ5sORM11NydohdvCgDbU6C3ow0TOBoIZMy2IdTtKyz03pPTAvAkv7QPXhMcq6w1k3tSUshVLpfvmr8aBNxgfd5BbcREGhUPhe6Yq9KKotxmvuqN6QMO3CMdciHScDmTTe5DkuyY86AsMz/di7q2F040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736232722; c=relaxed/simple;
	bh=+3g63bM7lYL3sS35UCPn2IMjqRXXGqQvIjPUDMRSO7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKAfRniZpEFYo0sAklTunwGdgRzvZIGac2RTd6GOTBxg/3Yw395Hk5qW7Pq/uh/HgnllVymDHv/IRUVRkxpktjbA4uGTJ44x13xfL/KF3t6xAoRUDP+s43iO7+2QfIlyB0oHFSOuPsH+EltKoaig1Qu1ocUIbW7rOFHjNP4y3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mujCNDJ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oZDheDyj; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mujCNDJ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oZDheDyj"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 750081140152;
	Tue,  7 Jan 2025 01:51:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jan 2025 01:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736232717; x=1736319117; bh=bS6A/5Z69x
	lCf506JHztdVlVOCSJoSIk4n1lIhqLyDo=; b=mujCNDJ1AOWBu/syYWuz0oD4Bo
	ozOl/+0InEBSp+SOj5iRSwoX0uPVZ1O1c1k0lBC5I1ZSe1y29NOWqvtLxM+d/0BI
	hjBm9Hl/1tEz9o/Pe7jN+ssfczMYW42o34OSvp885QO7kMb8L62IZ0LEHCELMZ9a
	A14y6P3/HgJGBRaD3lw5nvJ5pSXJYmjGN/4nNdnqrgONkGKv36FNF2cGLgEXk00/
	m5Vin1goxktN134OwgqODdG+VEMgRdOFQ7nR/RTft41zlZ8KW93z2QU42dYl/WL8
	a8Gx+90oMMLDDH5qsPXiavGt0qp5/t9E/H8dVEWJBOCkQ3Gslv+bDz0jzquQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736232717; x=1736319117; bh=bS6A/5Z69xlCf506JHztdVlVOCSJoSIk4n1
	lIhqLyDo=; b=oZDheDyjqsKA5+OSUKpPZF1mIpNnc+3qnwRP193bu6BSFaIFO7b
	gJczrsmFaZfTvGOo9kfHydnN4WddTy7b5oA3+3yGbT5DWJy4XdbRCsqBHhnxQlHC
	smaeBI0Lbpx7/QAtXhn55qg0bEsLPvP7ivFdj5ARWaMb1AwDGWNliVfw1lVPoxCn
	HxWrfe/RvZNNms/DEaKZ3TxYf6ygW/1SyYsH107qQgbXkVWzNU7JKi3INm3Pidsw
	iozYIT4CsWkQog96hTfyRJpdR0pt2dVWAN+UYQDRdx5PxQtYquA9DzXTU/la/gWq
	5AdPqMdFAOnPfiwk6Z9qHH/7+zrEJrmIzpQ==
X-ME-Sender: <xms:Dc98Z115xPprA81Ol91kRHixBz0ui4Q-Xz9HU-AEnPjIrORihPoyIQ>
    <xme:Dc98Z8FWYxoGTUnyyNhOanrzJYulfneO98RIJaCS4JbYVO68akf60pzdkwvrMU0qE
    7eOvDxUXKzCuYJSHg>
X-ME-Received: <xmr:Dc98Z16uicvKlaG4RUnhE6zz4IcP_na3LOxFB5HJc8RbCCiSR_0sbFW4Xhts4QBdejQRgr6fgNoCKFzA41Jz9d14MwfD9Slkvbesm6bSbkjgDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepgfevieehle
    dvleevkeekvdfhjeejledvgfduvdetkeekgfeilefftdeitdehledunecuffhomhgrihhn
    pehuphgurghtvgdrnhgvfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Dc98Zy0e0-PW0oKy-cQNhJHxYt3mNUJG7Oce_FcZAeJOavZCAqpxLQ>
    <xmx:Dc98Z4ELwMF7OuBnwMgqFZzNFoOOoUijaGQyuBiNljI3qJS0U6_qag>
    <xmx:Dc98Zz9o7QIpcG8sqhk63RiT2rW_epGGNeg5RjMtqPF4IIfNCcCHSA>
    <xmx:Dc98Z1mOb7kEMwGJuhgwwdIYoqJ8XxiIHYUpHhG15NHf2TWgpZotLg>
    <xmx:Dc98Z9SnVsZnuEMwDmE6JWCutS17X_4e2ePhdRSSpOChTj4XJD1puKDs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 01:51:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2d299d7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 06:51:53 +0000 (UTC)
Date: Tue, 7 Jan 2025 07:51:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [BUG] Git 2.48.0-rc2 - Test t0610.26 Fails
Message-ID: <Z3zPCCLo5YUc0HUv@pks.im>
References: <002c01db60a5$7a367060$6ea35120$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002c01db60a5$7a367060$6ea35120$@nexbridge.com>

On Mon, Jan 06, 2025 at 08:42:51PM -0500, rsbecker@nexbridge.com wrote:
> The following breaks at rc2. It worked correctly at rc1 on x86 but
> apparently not on ia64.
> 
> The OpenSSL random generator on ia64 uses PRNGD. On x86, the hardware
> randomizer
> is used. Nonetheless, this is not working properly:
[snip]
> fatal: unable to get random bytes
> fatal: unable to get random bytes
> fatal: unable to get random bytes
> fatal: unable to get random bytes
> fatal: unable to get random bytes
> fatal: unable to get random bytes
> fatal: unable to get random bytes

This here is the underlying error. I cannot spot any single change in
v2.48.0-rc1..v2.48.0-rc2 that would cause a difference in how we compute
random bytes. Seeing that this is in the reftable library, the only
change that _could_ be related are the realloc followup-fixes, but that
could only be a sensible explanation in case we ever tried to populate a
reallocated buffer with N random bytes. We don't though, as there are
only two callsites where we compute random bytes:

  - `format_name()`

  - `reftable_stack_reload_maybe_reuse()`

In both cases we only want to have a single integer.

The latter callsite is somewhat curious because we don't call
`git_rand()`, but `rand()` directly. That wouldn't ever cause us to die,
so we know that it has to be `format_name()` that dies in `git_rand()`.

So yes, I doubt that this has been introduced with v2.48.0-rc2, and
rather assume that this is a flake that you just never hit before by
chance. Due to the many threads racing with one another, all of which
will repeatedly acquire random bytes, we probably end up exhausting the
pool of strong random entropy, and that makes OpenSSLs `RAND_bytes()`
fail.

It's somewhat sad that we die here, because it would be perfectly fine
to accept a pseudo-random number in our usecase. Using `rand()` does not
work work though because we never seed it, and I don't want to get into
that business, and thus it would return deterministic sequences of file
names for reftable stacks.

We _could_ adapt the code to use `RAND_pseudo_bytes()` for OpenSSL,
which never fails due to an exhausted entropy pool, but that'd first
require us to audit every callsite to figure out whether or not it needs
strong entropy. Another alternative would be to introduce a flag into
`csprng_bytes()` that tells it to also accept insecure bytes. That would
look something like the (not even compile-tested) diff at the end of
this mail.

Anyway. If my analysis is correct I don't think we need to rush a fix
into Git v2.48. The behaviour is preexisting, it's unlikely, and in the
error case we don't misbehave.

Patrick


diff --git a/builtin/gc.c b/builtin/gc.c
index a9b1c36de27..3e754f25bba 100644
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
index 531660a49f0..8427c49026c 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -659,7 +659,7 @@ int reftable_stack_add(struct reftable_stack *st,
 static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
 {
 	char buf[100];
-	uint32_t rnd = (uint32_t)git_rand();
+	uint32_t rnd = (uint32_t)git_rand(CSPRNG_BYTES_INSECURE);
 	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
 		 min, max, rnd);
 	reftable_buf_reset(dest);
diff --git a/t/helper/test-csprng.c b/t/helper/test-csprng.c
index a4a0aca6177..c86dcc4870f 100644
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
index 6b75a419b9d..f22b9775639 100644
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
index fa79fd6ec9e..8b985931490 100644
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
index a6b3e1f09ec..7df824e34a9 100644
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
