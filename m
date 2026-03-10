Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D93BAD81
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149131; cv=none; b=hp+CMcTY4hi5i/5fyULJEiA3FTHW83Rllp/06NWzaz0qs0+Kz3IJ3pSOXbc2iBC5W43jZAOBERlTsu9GpDqjCjQCUZqJYdUGkNT3J5OrEEDFOnMtlQ0P8TGOYyq8hW7Oad2A9M/dpujIz1MPDc8tH0LYAWYvTt0GxZLBO6S38W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149131; c=relaxed/simple;
	bh=GCGYr2m5OC7/ZqbYceVabuvKFUO7U7mMixVc6z1g/Kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CxiNWbhHnStED0IEmisn7zy9ciEMKOzx+MUJejh3DgczP+JOrM8hVgdvZKp0aoCYdFYO8vf9wx6U8RQbtHybE5zFv63KpMZ6G46byGmuUu19F0lBywcEFn1R3uz0U6/Hr9NmAbj0q6z4tIdJyFB44UJgXy2kCr/lG1CYPL2a2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ExWW9J43; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDcE9TuR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ExWW9J43";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDcE9TuR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A8D3314001D7;
	Tue, 10 Mar 2026 09:25:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 10 Mar 2026 09:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773149128;
	 x=1773235528; bh=G41TBCRZ48TEVSrWvr9ovJgb3bkcIBBrySNtnwLTTxE=; b=
	ExWW9J43+OVnGwL7fs0otSGxN2luZhygob3wXdoK2FBdz6ify8Kh6AaqUEkkcTav
	sOG19r7iqHU7YV3uQDCRISGt4Xjzhb+LyUtKp+urnQlJ08pCFnDHtApLxwaidDor
	BzlmTuL5zgYu8uxv6iQwg5MRA1SXHTX76miadepQ/1uozzZ0nS3fsSNUeRjtyvKO
	cQkj2bSsqxSRBoEe8ciMcGoy9tlpc0HSFT3N8JtHhCi1N6swNszAQXXQ1qy9KW3r
	WlqhDZ7H8AGsaEtlgwRG9q//2FucwJ6yt7i+62wXyZqMahdlL6KRc6r379oqBVSE
	4U0sMT0aQ4CEDcl95GEwLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773149128; x=
	1773235528; bh=G41TBCRZ48TEVSrWvr9ovJgb3bkcIBBrySNtnwLTTxE=; b=S
	DcE9TuRLhyKT6AIQRFGdOUizaN1x0YsZvMRFiBnKD0kRnvuoKedVWHBDHH/rJLUQ
	FqEBGuLJ5zM09EmQUojzpUXMtXb4K613mjvsX0TaHqw3vPnzlbI4+RU+9x6+8LsC
	UdpuPdgUxDJHROM9OrPi1WC3CERz4JyVE/T7Phx8ykyjKyiexBfhFg6+LzWKARiY
	Yo9ZfxRrPAsae9pcfBxWiEFVhDJhc18an9e4/5xmUzAvJx5vP6LBx/9TtzfkAn+s
	pQR0Ymb3H2p27YYr2th71L1WLg6ZB7x29nD8JNi++O6X/XSjwL3FZO2o7J4XBBMK
	TZmEZmU81NYZ0BdH0sn6A==
X-ME-Sender: <xms:yBuwaS9AnKErCsbJMtD0zuIl_oNIvXd_wHsypn-sd4MxSfF5Xll97w>
    <xme:yBuwaZl0sjmv3U_A_8RGAQkN7L73iR2P3icpzr3NPzM-wut6qsxAK-UNfOoSJ7PEc
    Sl8n72AWKwHbb_4_6-d_1YlgA-U_v7QVRqHXcbq7OI9A8ysWwlJDOc>
X-ME-Received: <xmr:yBuwaQWu27M-P31MSwaWQaVEaKtA39SWIRP-kYKKO1IuX7ewF_IOyi59tJElKx1esUQyTaXolSPmfUi-lAbRVxsLRTsMmxX6haWHPrxC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehjiehtsehk
    uggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:yBuwaWHAHjuuWCi667sUk_TB7utHLPk980gKQPi6B0Qekc0kPx1kkw>
    <xmx:yBuwaUfMcHlZkNm2QwRsEQeUaTziPskzYrBlXKVh39ZP_W6dn3awHg>
    <xmx:yBuwafId__Py0s4zQa-Ez3Nt2JhcWNizl1BSAACIvQCby-1Ng1mOSQ>
    <xmx:yBuwaRF02OVMImQgNBhAIZHzTrFPF-zH98pxJPCInmw2WLkxRY_bgg>
    <xmx:yBuwadRNgkjIcD8jLoQTHjx6zzoZI88UZQU7Od_DqyiFSEuBbWHL_mcF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:25:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 419e3c01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 13:25:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 14:25:05 +0100
Subject: [PATCH v3 09/10] csum-file: drop `hashfd_throughput()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-pks-upload-pack-write-contention-v3-9-8bc97aa3e267@pks.im>
References: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
In-Reply-To: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
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
index c1ee4d5ed7..f5cb80e870 100644
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
2.53.0.880.g73c4285caa.dirty

