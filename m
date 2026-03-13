Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A9B316199
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384349; cv=none; b=qvO9eIaR1Bl7E8AfgXzt11YbO3ByoPSm7DffV1VcLmK39CbYUdSTDDi3IZt3lvONwwKs08uCgKtnoxV0+jor/z5H0rbO4EdOnbbhMjJNX7ffv7Kjfd0yTmVoV5R7hUw53SgXLUUDcwk44QNk/4SdQhPGzoIDh6FUAUBlA9XRK2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384349; c=relaxed/simple;
	bh=5WKJnkPGgAAmt+/1VbykiLj7acBpJmJ7YlcwCkpUFww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SC3tLQG3TEX41X6TrJNDpR54bpauyPZoOzy80nrUpkHq5KuznEwXl0wlil3NwXL/9JNE54ldoQLDHZw60whj9rMO8FJtBI4hUPtu/itqmNxEuFwhTxsUkj4H5kEDLWFVtTFDuOVM2hvpOFWmHTxWqEd2B80irb1RkyXWVeX8m78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XRGphCaL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lke8PdUC; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XRGphCaL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lke8PdUC"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 29CD27A019E;
	Fri, 13 Mar 2026 02:45:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 13 Mar 2026 02:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773384344;
	 x=1773470744; bh=HCPMJOhr/AAIz4lE80lPIx5Wsuz1zLbir7KEr+4zfy0=; b=
	XRGphCaLyFrXQ3GhxwZHIobSGkLHJYHvfknxrawTGi5PyrUIQou9sHDrRrpq/sRc
	YrbkENu0zGWr7ePODBk2Os/sHtZD+7wx2iP0U2CxNreZGPp2TLbJqTmpeiQSqRDP
	C0ktazpSB/7gD7EFTur2ST+t11Xs0raS752J5KM8sG6fnXJOIt1XCgbM17c2HmDT
	1clWYkyRrNSMcA30CiuMQlHC2aad4OIyz/SqXWA3d6JO4wvjnAfB9hQc6dr8LFng
	g4s72IqzXKjflOdiB/ELINIDuRZ9AJm1uOTHKUMrnI/MOiH0/ixGEHVud6t0UEPP
	TMGl8WEnpqrpzxSQiqVP5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773384344; x=
	1773470744; bh=HCPMJOhr/AAIz4lE80lPIx5Wsuz1zLbir7KEr+4zfy0=; b=L
	ke8PdUCLOXZTvK5Khg4wsYmsEwzeDIeaVwQ3xWCwwGA8I99YWIJQ44GzHhtFFXh1
	dXeYZOSbSirDb7wauu6F7BezqdFoPUpdeWJpOPBGToFBcJyOESjRuDdYCflhqDLQ
	9ZrEtYYH1d6sskaJF6H3xEUqGY7p1JAksMbYBt1qs3XLizkmuD804qhHxFs1GEb5
	YZhQ7jBbjCUF6gG1SKpwJuEazUJgBqIlfYEqy68ly6cBvxjpZkawEqOpkv46MxcP
	gNpfFZeELgQiAdRONc7W81tL39SasDiCZURGg7BnLLWX1n5B7Fe9Ox34Hy6OEaI0
	IoYPk04yIAKUZ3P3byKRw==
X-ME-Sender: <xms:l7KzaTTeVzGT-03_bVcaEEcCWk6i8uqnTQ2Y8S0ztCO7xy-EK9XiJQ>
    <xme:l7Kzabo6Kf_rxXIiMuenXL6D4zaGPGx7qUpl0jOxZAxz4swZDbuPe_QlpQCJ2pb45
    hYbUA9qVh_fi625g5QQ-RktGiKO172xqL4cocFhjktKyF41lxCl>
X-ME-Received: <xmr:l7KzaRKw28EemOqITcJ-zLEEKTZo1VC_2J_kbyPAZdATvepuhFYqwd6PszSSZLRMTASjEzTnYA9N0fs-RgL71WwRxRxYVp2px6Dlplu8Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruh
    hsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhhsmhhilhgvhiesghhi
    thhlrggsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjiehtsehkuggsghdrohhrgh
X-ME-Proxy: <xmx:l7KzaepN81yaPa_XQr0J0GWyAllZUqE-lvabvaamvq-oaO-OXJf9JA>
    <xmx:l7KzaZwlZiAoPGBY7CWAG7HvR76CyGareNpK4ez2wHiSDixbuYFndg>
    <xmx:l7KzaSOFFIkJrCbxAXiwqvu0dWwRahuXphT2xnqcyyi_ezCFBI7MrQ>
    <xmx:l7Kzae5p1zlMMtrgcXU5KU4epf6Ka7KRlgY16lMmiaVcCGj1wsYIIg>
    <xmx:mLKzabLzBhXxqZSX9ARlYMcpfPviqWipKjECR8SoWaofR__zNQ2zymaK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:45:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7bc4c7fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:45:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Mar 2026 07:45:20 +0100
Subject: [PATCH v4 09/10] csum-file: drop `hashfd_throughput()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-pks-upload-pack-write-contention-v4-9-7a9668061f7f@pks.im>
References: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
In-Reply-To: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
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
2.53.0.904.g2727be2e99.dirty

