Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB46298CA2
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363802; cv=none; b=C/2lxhaoW+bi0GfDF7dgGUY3jdyAzgA6GkTv9oTZA+FSFK/KCIQj0QpO8GcVgEO4cQ+tmi04TAZvN0yGBzbin2tRf8ab6JUufsvx5UwDfGAkp5DmJqttDHc1tHbqpC18/IzeGhglfhILaLi8WUJxfBkyvNMmTCGfGXPaVlUhgDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363802; c=relaxed/simple;
	bh=2H47hlgLbWLa96FCQE+a812DiPi+EMpyHTkVenOjMco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYAZtBweDubkBQjZeMEBtBdz43iMCtAdLbXugqyZX0jmhdEVcHgGeLOdTIxCCUYOytcND4SfWjjW1Zl9ZJ2tH9jLd6KwyfO7jhhcWcha0tKsNY8277bznsP+xdGh8YCo3gpL1TjUBLcHlDWFm5X4ZyFUUbtF43z9lhrc44omfxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BUiN2mTR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q41XlB8F; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BUiN2mTR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q41XlB8F"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 700631380293;
	Fri, 11 Apr 2025 05:30:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 11 Apr 2025 05:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744363800;
	 x=1744450200; bh=BZIsF5M4kt6YM+lJLCnnQF/fjnD33ofT0ZlPSnF9FXE=; b=
	BUiN2mTRDYnoE1IjlZ9mqaoqLLXeu2oDRKaffK2gvzvIVemFnUGEuG4TH9UpjXtK
	CI+sMhANWgT7VtGatuSN9NxXzJvuBxQW5jDaEOvoXXl4X9sDcf7z2KN+IHkpddSE
	z92N4VGXQbMCSkqkfmhm0AEjH4x0gy9Wi8NVagW66oQ3f3tokP69ynzafQ0A33aT
	AGugrSJiu9L75R9Z/8hniG68reRtzSspZbdbWk4OfUQltIlcAw6Whbs0LDif2U0p
	fSrMS1LMFwMfiBDYlge2K/Zmp2bbc695ldNSAQNdxxfDMqLjpImBwKTM2xUwAZxF
	1NCdmioDkvNoLS5h0R2W5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744363800; x=
	1744450200; bh=BZIsF5M4kt6YM+lJLCnnQF/fjnD33ofT0ZlPSnF9FXE=; b=q
	41XlB8F1Ja7C6D90tvwaAuU1dmKP6lq2yoFOIXOpYYb9csftoQflaN8J2YthHhE9
	S1aQZAv7vz8jZdvRM6QHCaLkbYLogdiwjwNImCg2opaLqkIIip6mx9hChCuuv0Iu
	vR0+emXsjqU0N0v/s6NchsHwmUI+UsMUL9PgOUx241IE3c3GZbXV/TPW3vUcQxx0
	7dTxh0AVCZGj67ch8P+4z21wbjcBYQT7oy9k5uN6VMwUfC3m1xD/HLC2fXI/us4U
	qh2SPCXtpT6NYsyEvXtpASVjpCcE1FQokyBMn2O6ZWy5/cWfb5wtecjMzUy9b4w0
	UsZA0amDUbOtNZkjHhqAg==
X-ME-Sender: <xms:GOH4ZybUiaiHIlgFyGpqlVCKVFt57ZO_mIQy9n6SUi_QgosYmdcq8A>
    <xme:GOH4Z1aUR2ahF-LSo3civ0MQNPhZ_AakEtpYKQm2s46MbFWAtHuQJ5BTFyVzm0mVX
    IFdZRgm0TEU-mUlTw>
X-ME-Received: <xmr:GOH4Z8_EZybWY_KEer_p305XoPhHazWRelaJMQGnmmI0Oxrzx-x0ZZDsM1MhR8JcBHsB1pGcBgNUhaB0Kspe2a7fZiref7Kj-4aeDgxOyia2Fg8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GOH4Z0oyuMqtxpc2zQa-rxAdIy31v951qedRe3pp9gMmi5Vo53GMLQ>
    <xmx:GOH4Z9qpF5LH4O9QrIIkFhiJCV3VdPGCp7d42Z3XSaFY0ffikkKCnQ>
    <xmx:GOH4ZyTKi5jhwbYSO3BDmwPO1I39QrWQQAFVXXPY1tTi7gXiEso1fA>
    <xmx:GOH4Z9r67o729GvoSOUzjySUGfmKJYdvNGMSuQstSElx8skfqtqdxQ>
    <xmx:GOH4Z5GHoXutMZHcvIKEJrKltRdpy2ELQZ-WCUIPxWhuqOWzh2Llg4IX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 05:29:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f9d40051 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 09:29:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Apr 2025 11:29:52 +0200
Subject: [PATCH v2 3/9] object-file: move `xmmap()` into "wrapper.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-pks-split-object-file-v2-3-2bea0c9033ae@pks.im>
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
In-Reply-To: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
2.49.0.777.g153de2bbd5.dirty

