Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E7481ABC
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550056; cv=none; b=fYHsr5VSrpmKvhd1gbQVN/BE7jn9qnksp13/irdLYAzuNBcdsrcAdnYJFzceCNLj/ecb8vAyFYxa83MjFlYkjRSqUaPs5tWdfs02yApxFQR+EEWaEr6/TmjtUlVYCtzu3BJdpXVJZeWPKB2V/quOkyaj0vIYEq58jAUdM5oG6og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550056; c=relaxed/simple;
	bh=yaEgS8bt07FtvtpiCuFaBMTRkKtc61xBy465K6V5qro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sc/ViJ/EnjRClFVCmz/NWK3Xep+ZF1OYIOOrgqQyicy0bkVzMqeJPhbETuFerusgZOW9qYhNCJQ88VDxozcCHLPFfDOhhhtcQnVXRP+YVKf9c7664kHmNC3BvizYoSfcdVQdDURiEgoKOC2pX6+gQFBxyPEs8WZcM4N4MzjVIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e/TESSye; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RSypWbwo; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e/TESSye";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RSypWbwo"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C4289EC05CF;
	Tue,  3 Mar 2026 10:00:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 03 Mar 2026 10:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772550054;
	 x=1772636454; bh=9n6J8kXI3Px0+z1kA4KZRss+40HwXV1+VDJ/Ws4Yd1k=; b=
	e/TESSyexFkC/2Yo7wU55dChw7oPzBZ+DT6A0yyg2EHNco5n+1juTWH/4vXTalC+
	8tmZCuTPnlHN6f7S/qGe6wAgFacI0eWzhZCVBEUZ5sdwRoT2JFDxmlvDa934LblG
	UGiuExLj6Reh2f4T61v9iQhBORUvu3Qi8fmpoQ9Mtm8Eesi68HeOi4VMJFvQIpIt
	FavGucFBKHY+F9gDiPasI7iOU0VTjaCh4wSJAW/wFwPM5HwBWuqoSiCVbeQ7Je02
	+L6GofjoNWyQL26WpZpFZskrbSTU2yhKUMqgX2FFVlaGvbTSrdtAKP2+Ky6GPa4N
	8+VwL55OvL0XHAghFjZ27g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772550054; x=
	1772636454; bh=9n6J8kXI3Px0+z1kA4KZRss+40HwXV1+VDJ/Ws4Yd1k=; b=R
	SypWbwoYAi/J0SmycKse22X+FYyj95t6MDLfU7PlkjfTsW4XzDiK1Y8E7toAzFZj
	kcEqydKsBC63UB0iSTldPoiQHk9Zdk+SF2iGAlHvWeRsm4f8Ju9VdgDALOc2L9Rp
	5AQWSToZ/GHNCi+pUD42wXP7tTOsY4OnYxW3V5whqCzv37++VncKmGFs9It0UsVg
	Zgyf9YgA/TAR33UzhEhXbRc9mErBTWqq75eh/JEIZxuNjrCw9wL4CoiFGF9vGGU5
	o+FI+wTILSpp8JEsfJTMDkfg9aA5b7NEAvsFUxB7hASfwAApbjYbmJKvlh2B5puT
	ZlMSua1mtUryUdCWoY73A==
X-ME-Sender: <xms:pvemaV0amEDalyhRk8PD4_irSClxHB7GdF45t2q2WGaf3iewAkl2FA>
    <xme:pvemaTGIXX_m8J48sMbzBb2U4L_G5CXF1WgA8CBz_w2AMzWE0U7hjLZBdQ1uXL_Uz
    Ggf2AS2VYvFaBAhTAS2F9DqvqjgAnl656cdhxISNY_v6ttcTaPC7w>
X-ME-Received: <xmr:pvemaa4QRbw7nLHVH6vkO4HDeHURny31qt43lrYd59XNUnKQkvBk_dh3cGkIZtp_XJJz7JhyRPSpL0MnZ2rXL3yYeupvhnAcxcSNRxsbRkXL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:pvemaRt87FPBGeT4oOS-EJZPOQJVkGKQGAnERjFQ4DOd1JdTsPO-Uw>
    <xmx:pvemaT5PVrP9mGi2IUi4XZUUDyWHXxL62k7_YTlgKPtK2HO5vdE-uQ>
    <xmx:pvemaUW_rwZNGDPWCu0F2eWp9wox08goRj4JB7jAeiYt1O26oonIQg>
    <xmx:pvemad-BM3DWgu5EoCQxZx-X90hu_Jt-sdTip-0QbQVZq40Q24Trow>
    <xmx:pvemaRRPxPJNR9NAGYdbbnDIzM1-92tPFCGDNNfEtPbTKxE3K8rn1AWv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 10:00:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d75b1a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 15:00:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Mar 2026 16:00:24 +0100
Subject: [PATCH v2 09/10] csum-file: drop `hashfd_throughput()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-pks-upload-pack-write-contention-v2-9-7321830f08fe@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

The `hashfd_throughput()` function is used by a single callsite in
git-pack-objects(1). In contrast to `hashfd()`, this function uses a
progress meter to measure throughput and a smaller buffer length so that
the progress meter can provide more granular metrics.

We're going to change that caller in the next commit to be a bit more
specific to packing objects. As such, `hashfd_throughput()` will be a
somewhat unfitting mechanism for any potential new callers.

Drop the function and replace it with a call to `hashfd_ext()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 19 +++++++++++++++----
 csum-file.c            | 16 ----------------
 csum-file.h            |  2 --
 3 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cfb03d4c09..db04e6dd0e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1330,11 +1330,22 @@ static void write_pack_file(void)
 		unsigned char hash[GIT_MAX_RAWSZ];
 		char *pack_tmp_name = NULL;
 
-		if (pack_to_stdout)
-			f = hashfd_throughput(the_repository->hash_algo, 1,
-					      "<stdout>", progress_state);
-		else
+		if (pack_to_stdout) {
+			/*
+			 * Since we are expecting to report progress of the
+			 * write into this hashfile, use a smaller buffer
+			 * size so the progress indicators arrive at a more
+			 * frequent rate.
+			 */
+			struct hashfd_options opts = {
+				.progress = progress_state,
+				.buffer_len = 8 * 1024,
+			};
+			f = hashfd_ext(the_repository->hash_algo, 1,
+				       "<stdout>", &opts);
+		} else {
 			f = create_tmp_packfile(the_repository, &pack_tmp_name);
+		}
 
 		offset = write_pack_header(f, nr_remaining);
 
diff --git a/csum-file.c b/csum-file.c
index a50416247e..5dfaca5543 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -197,22 +197,6 @@ struct hashfile *hashfd(const struct git_hash_algo *algop,
 	return hashfd_ext(algop, fd, name, &opts);
 }
 
-struct hashfile *hashfd_throughput(const struct git_hash_algo *algop,
-				   int fd, const char *name, struct progress *tp)
-{
-	/*
-	 * Since we are expecting to report progress of the
-	 * write into this hashfile, use a smaller buffer
-	 * size so the progress indicators arrive at a more
-	 * frequent rate.
-	 */
-	struct hashfd_options opts = {
-		.progress = tp,
-		.buffer_len = 8 * 1024,
-	};
-	return hashfd_ext(algop, fd, name, &opts);
-}
-
 void hashfile_checkpoint_init(struct hashfile *f,
 			      struct hashfile_checkpoint *checkpoint)
 {
diff --git a/csum-file.h b/csum-file.h
index a03b60120d..01472555c8 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -63,8 +63,6 @@ struct hashfile *hashfd(const struct git_hash_algo *algop,
 			int fd, const char *name);
 struct hashfile *hashfd_check(const struct git_hash_algo *algop,
 			      const char *name);
-struct hashfile *hashfd_throughput(const struct git_hash_algo *algop,
-				   int fd, const char *name, struct progress *tp);
 
 /*
  * Free the hashfile without flushing its contents to disk. This only

-- 
2.53.0.697.g625c4fb2da.dirty

