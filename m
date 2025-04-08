Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809BE2690F1
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107860; cv=none; b=mK8Gh33floFhskjjy6tk9RVe7TRE72NjkV3AgR4ExyUR4r1M4/N2s//Pj6H6sBVTa7ZvQyiI2jZ0bCJpvcAWNAnGcYZGcmiZS/NZkSyZmtftcFRMWGyBZ9rvsvwMWrJyhJ4MTwnBqqipZMQgk/qTNjpveuC+r28iV+SL7DKftBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107860; c=relaxed/simple;
	bh=Gskf+OAr0VPgd6DysmZ5QVhDL63xRF/SGIWBMbm5czA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FKLbF01pt9v/f56rerU31E/JItkSk9PTk+Zp1/UQFvjOp/FpdD3vROKINXHRQ6M6adeE0pOCKL4wKV4imMB4k2GW8DzD8BJ4sN5wnl+93TVkLc58xzi3eeRFZH+cVXxEopqIz+EtdC5Q0hEOkv3wYAUxO9MUtjV+A4c2RvHppm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FljR9W3+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xdjtLe0f; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FljR9W3+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xdjtLe0f"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 88384114011C
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:24:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 08 Apr 2025 06:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744107857;
	 x=1744194257; bh=6B7hrXwHVmBXGx54iYdPAxQGgwq8NB66MUMbUqAz67U=; b=
	FljR9W3+cRu10/OHIuQpGv1U8zPpUMOxnj9+VjELAjBPZn3tCy1fpv5J/Pux0mQ3
	bDEr0NTv96x6mS2+7MirbeDEecZNdcxdk9TTmQydjzrrvh/s28Dx+rg4YE6tFN+5
	uHpuJHDyOIPzbXd6QLrfibrrIdMPJ9x3Gga0hrA+OqmsO5l8IOEletNsB2LxwwLq
	4ZRSfXCZirgWf+Xgn6vOU5ovcJWFKLk5U+gNC3I9RLxdxsz4OvSkGskdxiJuFF6G
	CGf4GpYOQjjYxM3Rg4frzxa7atP+xkyp4NRms1NRw5etc16H+2bWqUaUbYU8XXQ7
	5M9wWuz9YT4GXfNX4QpoWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744107857; x=
	1744194257; bh=6B7hrXwHVmBXGx54iYdPAxQGgwq8NB66MUMbUqAz67U=; b=x
	djtLe0ftmO9yg6mLSQ1ZOwuVHm8Uw53MklQ8bZrNjY/W1pizjbssP+szSuaIcf3Z
	BWtaFDxjAdo+VE2Fh0VvuLhgqA1mB3XGMzivHcVtRRn/Fsu7JaYpElYgneuVbueM
	fBG5jd1JiYAY+lWdlQxIyLUoC0jGeVCcNWP6w26lMeBdF83gwUHPqZUqSfeAS8NT
	vp8CH6GFLZ7zRuH2RUwnNVisy6XT+O61Q2HCB33XLaNoR15iQPjCISTyoPqqZPhU
	A+Sv+c/63U4Bc8lDfi2oWmxmjVLW2Z8FD4RZkpzQ6qZOq9OwDA+rIJ5ndmYfh1Ii
	A1ycztmwqZE/XfZoCHYkQ==
X-ME-Sender: <xms:Ufn0Z7Y7fLJeIq9VEpG2B2q04tORFUbj9DsAR1u3R5T5gQHRI3FFgw>
    <xme:Ufn0Z6YMScSB8UF8WPFEYb0u9Gh9E0AtDTyyNx_tkwsLSEW0o1gUlQEbKrLKmH4L-
    7DHpntfELHI1MeYAg>
X-ME-Received: <xmr:Ufn0Z9_e38jIBmccwaR7l0coeEJLhziiWLMDM2qON09wKVpyBL4KaXlMfQvKxWMnuZG6BjSHZ5Z2czu0uduiNN7v_2mHdnEy5UBjq3oRowENuG1i1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ufn0ZxqrBcZnvvb5NDGKkFFpO1IJOBeH3V9W3E6pp_o4nomnMAnWug>
    <xmx:Ufn0Z2r6Xuy26qRYVMxV4UFgpICgrUeot0oQftFDUx7gdkC2bwnA1Q>
    <xmx:Ufn0Z3R3CkBUIDpvUwHERjeXTgS0M1KmufC_HTizRj3zSfnebznpow>
    <xmx:Ufn0Z-qlVNWzkR3dKSxqfHUiSZwSJYXos4S-7qtvfTqP_uJerf4cJw>
    <xmx:Ufn0Z13Go7cHNh8resOTn362STAR0mR65-cEbtslTBOgYLaCMeSamRs4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 8 Apr 2025 06:24:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 169010ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 8 Apr 2025 10:24:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Apr 2025 12:24:11 +0200
Subject: [PATCH 3/9] object-file: move `xmmap()` into "wrapper.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-pks-split-object-file-v1-3-f1fd50191143@pks.im>
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
In-Reply-To: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `xmmap()` function is provided by "object-file.c" even though its
functionality got nothing to do with the object file subsystem. Move it
into "wrapper.c", whose header already declares those functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 48 ------------------------------------------------
 wrapper.c     | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/object-file.c b/object-file.c
index 1a20c7fa072..ea2ed7628e6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -719,54 +719,6 @@ int has_loose_object(const struct object_id *oid)
 	return check_and_freshen(oid, 0);
 }
 
-static void mmap_limit_check(size_t length)
-{
-	static size_t limit = 0;
-	if (!limit) {
-		limit = git_env_ulong("GIT_MMAP_LIMIT", 0);
-		if (!limit)
-			limit = SIZE_MAX;
-	}
-	if (length > limit)
-		die(_("attempting to mmap %"PRIuMAX" over limit %"PRIuMAX),
-		    (uintmax_t)length, (uintmax_t)limit);
-}
-
-void *xmmap_gently(void *start, size_t length,
-		  int prot, int flags, int fd, off_t offset)
-{
-	void *ret;
-
-	mmap_limit_check(length);
-	ret = mmap(start, length, prot, flags, fd, offset);
-	if (ret == MAP_FAILED && !length)
-		ret = NULL;
-	return ret;
-}
-
-const char *mmap_os_err(void)
-{
-	static const char blank[] = "";
-#if defined(__linux__)
-	if (errno == ENOMEM) {
-		/* this continues an existing error message: */
-		static const char enomem[] =
-", check sys.vm.max_map_count and/or RLIMIT_DATA";
-		return enomem;
-	}
-#endif /* OS-specific bits */
-	return blank;
-}
-
-void *xmmap(void *start, size_t length,
-	int prot, int flags, int fd, off_t offset)
-{
-	void *ret = xmmap_gently(start, length, prot, flags, fd, offset);
-	if (ret == MAP_FAILED)
-		die_errno(_("mmap failed%s"), mmap_os_err());
-	return ret;
-}
-
 static int format_object_header_literally(char *str, size_t size,
 					  const char *type, size_t objsize)
 {
diff --git a/wrapper.c b/wrapper.c
index 8b985931490..3c79778055e 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -829,3 +829,51 @@ uint32_t git_rand(unsigned flags)
 
 	return result;
 }
+
+static void mmap_limit_check(size_t length)
+{
+	static size_t limit = 0;
+	if (!limit) {
+		limit = git_env_ulong("GIT_MMAP_LIMIT", 0);
+		if (!limit)
+			limit = SIZE_MAX;
+	}
+	if (length > limit)
+		die(_("attempting to mmap %"PRIuMAX" over limit %"PRIuMAX),
+		    (uintmax_t)length, (uintmax_t)limit);
+}
+
+void *xmmap_gently(void *start, size_t length,
+		  int prot, int flags, int fd, off_t offset)
+{
+	void *ret;
+
+	mmap_limit_check(length);
+	ret = mmap(start, length, prot, flags, fd, offset);
+	if (ret == MAP_FAILED && !length)
+		ret = NULL;
+	return ret;
+}
+
+const char *mmap_os_err(void)
+{
+	static const char blank[] = "";
+#if defined(__linux__)
+	if (errno == ENOMEM) {
+		/* this continues an existing error message: */
+		static const char enomem[] =
+", check sys.vm.max_map_count and/or RLIMIT_DATA";
+		return enomem;
+	}
+#endif /* OS-specific bits */
+	return blank;
+}
+
+void *xmmap(void *start, size_t length,
+	int prot, int flags, int fd, off_t offset)
+{
+	void *ret = xmmap_gently(start, length, prot, flags, fd, offset);
+	if (ret == MAP_FAILED)
+		die_errno(_("mmap failed%s"), mmap_os_err());
+	return ret;
+}

-- 
2.49.0.682.gc9b6a7b2b0.dirty

