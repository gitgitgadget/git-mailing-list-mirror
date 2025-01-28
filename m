Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD81DF726
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053700; cv=none; b=nfFYh6kw2NfszyV8xUkpVDLb7oP1yoeXNJMNTDPrxGCNpWlbpovBeYeLdAm0yIyScjO4yBJdOOP9plvPXXG/MIb6es3Ha0xZEkx1xcDGcwlrwCslW3ohgkahEUzGWB2p9E1otMpx0YbqYDzpP+cwI30OgcjKqYOwQBR+/HNCkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053700; c=relaxed/simple;
	bh=zZGXGDizTU3E9EbJ+rPAfP9sgckuNAVodGZ+YTvJKQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8Gio7kVDSxQrnROQTbzSM/4SVG4qtK7q2LjEkncwopckbArS4n5AotI7Qf5TE9X40MBZmRh87mVsh98euLMEzY33egTCgFafXrdmvY3Qu1JKnRoFoHJ32ovuyDUcBrg880p3JbFdFetcBkER1O3BHoJ8i9YtA+LnJPDI8wndc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hV0fdO5t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HtkEVvDP; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hV0fdO5t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HtkEVvDP"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DBB162540232;
	Tue, 28 Jan 2025 03:41:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 28 Jan 2025 03:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738053697;
	 x=1738140097; bh=6wAnyBP8fE54KLvjAXJrtArARqhzZAYDfe0IH5trm/Y=; b=
	hV0fdO5tdNCNjKIxTc5UBtFzsKAr2AylQwJbW5s8n8ladNnBI4XhfKotqChvLE6n
	3TnP3mRO1rez+3KDpuU4zWHfV/csuB2sLAAN9eFuczcZITRovPD1eZEmnRl2w3wR
	Ko1+iSdNhNKY4QNgEwHCa9OS7RqH40mpXiKFGMOv/lZu2NMDdoX6Y7mv1R2Qxnp9
	T698tAjLiwjHkPyqh9IVSLHMB1dkcym2dIhHpPqWyTzC1/tLSb7I0KAqVwf2Hxgk
	3BdoNZjoLJd49DKpa4zdbSklTo10rxqfiO0EZgEmp1xFVFM0aukhG50poPn4AC4l
	rdlrk0HwCQW4m7ImlQjolw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738053697; x=
	1738140097; bh=6wAnyBP8fE54KLvjAXJrtArARqhzZAYDfe0IH5trm/Y=; b=H
	tkEVvDP29R3sNtdYAn0iJF1QTbY0pSU6x0uCDJ00T+0hoJWL7fvXGLe8vcVas3Hq
	Ptxj9RAu7LPPlFfA0v5lmwm5M3q6vc1XvEMhS9cWMr6E/o1mxP7O2HtzaWgW+gfn
	5xReVqI9cvq5Dg39gi1tjM2zzPNpq1D2IAcYGHLhtsaXCY0WIiMlvoACwZRt6kKD
	WBKvxmdihO755aWDro4fwAHngkdHxIBoikgDqr6H6JAYbn11TBW35kTNfkks5sbv
	FarFIUHccNsXxG3nYrFb391cKjBmtKcKdBAa0tKXy6o4gUVWNUZv08AS+wSa6O5u
	N2+DgKLl8VHUnIUx2uXyw==
X-ME-Sender: <xms:QZiYZ2bOTbW-1j26rFZEXaK_WIMAKkJuM4PDJlPGNwbjZ8EtaPEjZw>
    <xme:QZiYZ5ahjhvZ45reGhjyOrdyuvA0hefr9nplhMXuKK26M3JOO_Oa4Kv6efJ3jvXbD
    90WWFBgNWNviQGhZw>
X-ME-Received: <xmr:QZiYZw_pj-IoUNtfiq_3eo6P49vr6JS03zIiF18cKiCf6wJEzxmGslTJyDqOd_Zo4omCNIOtR0rkR7kiBkb2kUndW2Zb7sa1VsQSWEg6QDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QZiYZ4ohYePVBFCb4Ci-dYb1zP7jCVJq_hSeGWjNY8DB-tM3MxcYHA>
    <xmx:QZiYZxoI-eem15Hs_EnU0Iy1wUFvv67qqDCftU2vAPyYwgNvdjhWqQ>
    <xmx:QZiYZ2RrLgcbvt5rlXR9Ocic3PsCGGUcOXioQ2n5Q08bVB7xiXYDWA>
    <xmx:QZiYZxojDe7mVp0m8JmhkNHUOR17nWsKsVtd40ujS-U9bJxa06HcZA>
    <xmx:QZiYZ4VZy0gXSTtIoTAeAjo4JEaQJOUJtpzYvgOZTY6dJjzSisWQfHFU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:41:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50aed50d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:41:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:41:32 +0100
Subject: [PATCH v4 06/10] compat/zlib: provide stubs for
 `deflateSetHeader()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-b4-pks-compat-drop-uncompress2-v4-6-129bc36ae8f5@pks.im>
References: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
In-Reply-To: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The function `deflateSetHeader()` has been introduced with zlib v1.2.2.1,
so we don't use it when linking against an older version of it. Refactor
the code to instead provide a central stub via "compat/zlib.h" so that
we can adapt it based on whether or not we use zlib-ng in a subsequent
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive-tar.c        |  4 ----
 compat/zlib-compat.h | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index e7b3489e1e..0edf13fba7 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -473,9 +473,7 @@ static const char internal_gzip_command[] = "git archive gzip";
 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args)
 {
-#if ZLIB_VERNUM >= 0x1221
 	struct gz_header_s gzhead = { .os = 3 }; /* Unix, for reproducibility */
-#endif
 	struct strbuf cmd = STRBUF_INIT;
 	struct child_process filter = CHILD_PROCESS_INIT;
 	int r;
@@ -486,10 +484,8 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	if (!strcmp(ar->filter_command, internal_gzip_command)) {
 		write_block = tgz_write_block;
 		git_deflate_init_gzip(&gzstream, args->compression_level);
-#if ZLIB_VERNUM >= 0x1221
 		if (deflateSetHeader(&gzstream.z, &gzhead) != Z_OK)
 			BUG("deflateSetHeader() called too late");
-#endif
 		gzstream.next_out = outbuf;
 		gzstream.avail_out = sizeof(outbuf);
 
diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
index 96a08811a9..6226b30c0c 100644
--- a/compat/zlib-compat.h
+++ b/compat/zlib-compat.h
@@ -7,4 +7,23 @@
 # define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
 
+/*
+ * zlib only gained support for setting up the gzip header in v1.2.2.1. In
+ * Git we only set the header to make archives reproducible across different
+ * operating systems, so it's fine to simply make this a no-op when using a
+ * zlib version that doesn't support this yet.
+ */
+#if ZLIB_VERNUM < 0x1221
+struct gz_header_s {
+	int os;
+};
+
+static int deflateSetHeader(z_streamp strm, struct gz_header_s *head)
+{
+	(void)(strm);
+	(void)(head);
+	return Z_OK;
+}
+#endif
+
 #endif /* COMPAT_ZLIB_H */

-- 
2.48.1.362.g079036d154.dirty

