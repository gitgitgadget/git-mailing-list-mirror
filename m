Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B646288CB3
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709907; cv=none; b=KugZ+/+wawBdFIuKA0gVe/3MMkqVyS+zS/D4mPAIcHfc+aZpsW09gK7+HFdMpCOnpIusU5tQJkrRPPQ4Nxck+DC3HGcVEA76vQShpQT1vTO8odAlcviwcwfiKny5WBd9c3WGwBZLXYz+EXEgn//xTtxqhug6i7Bix8W6U2hFwho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709907; c=relaxed/simple;
	bh=6PsRcAsQoUkbOfO7WCPlk+hK24YLzuYwgI4yZjO0cZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cwIG4j/kfswPpRUka9QD8lz7eBdpDsUR5DQXlX1BGSWZk/D31EswbfmhWpKLauOAwdnrj4wJdhXSqaS2vUBzQP7F6TXcprutjHRiDyDBMzf1J0P0OY3pcmze6skkxNrZ79hzo8tvKEjnslAGaxagGdI8gj0N1BPOrU0BwUJyKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pIQpaOYo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JEWcR6oZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pIQpaOYo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JEWcR6oZ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 97AF8114030C;
	Tue, 15 Apr 2025 05:38:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 15 Apr 2025 05:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744709904;
	 x=1744796304; bh=JmS/BR5MTGZ7ABf/EDYEPfsd8N1GvW6fgoEt5xaCqIw=; b=
	pIQpaOYoAvJ0pKQ4Tudd34S5cJIc9QmSw7Q1QjCDRA9KzbmPZrEWW2e7wWszPBNJ
	BmZao1ZF15pkV1coF7hKpkOSBetFXS+PUR/naIaipErIPjcI75cb8VWy4KCkwAWc
	lwbsObfToTM1jq9hkOiJ7y/0iKvTEjYei12smf2eQSiOCfOqr8KY302mLi0iaRVf
	VAlQwsGiHrHYzuF39zPh+nm790WRD5D/D8UQdeaflZ71JdAxRyV21zTAKlVftRQs
	xVFzJpS5VQmWELExjo3WvXwEBR1wDKbhBtRwCA0W+OX3+t+ZOZo9m023uno7JWVR
	OIT7B8VhoyM5XRd/sEvVLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744709904; x=
	1744796304; bh=JmS/BR5MTGZ7ABf/EDYEPfsd8N1GvW6fgoEt5xaCqIw=; b=J
	EWcR6oZPhoIUhLt52+ThySoCNXVbeRGLW3U5A7GE6pxEdt5LySFsebk6HGyaJ6Ma
	Ggq26zNMYV4EherPR1UZDu9XHnLRhYlQ8h39JXc+TACHXTnwfw4PYNXcOwqtnj8M
	y8+Z/81iVw+HoQY34f+RaOrVT0lXJHWd9Ro46v071LFSvyF+m3Xv7zDhUOFZmoMG
	vfya7EAo670521JB+F51qZNC3mALd+xqNbvlVICAoq7LnpcMfMGhG/kGXNV9Ln0A
	TczFAAUsmqrSTcFL52eNyC3ssaUEGCfpt3B+cLtAKLwmhMdNBsquMLo776UdNlhU
	dXnqePO+uEBaKSc7j/8Ag==
X-ME-Sender: <xms:ECn-ZxTvltEkPpA-fxohdoRXMdJIQRy2vMtBGHxSnJxe8CG3Hz8ffg>
    <xme:ECn-Z6zfdd4FfTEsb5ws1blBz5nThUFzp2ZTwni_Hms6HNJW7Pza8mVz7Yf8ej609
    UiEKQ3ifQLk9zKmhQ>
X-ME-Received: <xmr:ECn-Z20cFfEAREyKlXi0j_kkyK_4ncRSiZ7ii_oyZwIhFZcwhKYF3xdK_ecuGQt3YkfuSjYX-j2T5V53WF_rfeaJeZEnr0U7n5miryp92vp4WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:ECn-Z5B05pwE66qU5_XNuYEQdoCpF71WPYxAAzNnbNFwjxtIDChQFw>
    <xmx:ECn-Z6jF3GsZL4hluOOXApqPjMU_x2W7LIkLD5VREYTpWS-bkC_ujQ>
    <xmx:ECn-Z9q0W67_8SXBBA2qBiXQwvw6An7qRm8NQv0CtGrB0PiV6mKn8g>
    <xmx:ECn-Z1huHdlIoVXcUUtqOAXSuX8T0IVRq9j4olDqdhKwDtjKn2l6JA>
    <xmx:ECn-Z5YRXFG84uJSeU4VDKSHx4EUM3j-DW-rMoZ4kx1bZGfV9sqmMcLP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:38:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 06ba431b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:38:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 11:38:17 +0200
Subject: [PATCH v3 04/10] object-file: move `xmmap()` into "wrapper.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-pks-split-object-file-v3-4-6aa7db7ad7b0@pks.im>
References: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
In-Reply-To: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `xmmap()` function is provided by "object-file.c" even though its
functionality has nothing to do with the object file subsystem. Move it
into "wrapper.c", whose header already declares those functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 48 ------------------------------------------------
 wrapper.c     | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/object-file.c b/object-file.c
index c3e20417f3f..a7868201d09 100644
--- a/object-file.c
+++ b/object-file.c
@@ -718,54 +718,6 @@ int has_loose_object(const struct object_id *oid)
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
2.49.0.805.g082f7c87e0.dirty

