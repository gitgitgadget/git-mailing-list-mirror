Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572453D5651
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550053; cv=none; b=d6NLJYSXry7z+S6Svm8nlHbpt/vQh5wxy+86XuQk2Rnh507rWRU3Tpe0nwnIoUz2Mq2brpY0lUs6NcjP0ZZVVhoSe0oVm2GREM6LZ7hmRfkvBGPAeRW0oKkSNGg9MlPljztRvEctX3A5ynmqDH8CU48NMT4VKi7uGIodXXpL2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550053; c=relaxed/simple;
	bh=SxYKZY+iShKIsmukKEqTXrbMx7enbeSk/Rm5djyxbpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=etvtyDMHR5KuHE97wKYpPhQ1Tv8TqEZ3WYIl6oRIkUwDs94SVgcidCYXt0xLtkIIUGzwEHWGzRirjYpn1OzrpYaMGNDsmlVJaXodLBArmanDwZOH8/cAetqQUbXUfA9p84YEG9KHCD6F1EumjvN1DjnzZ96nt8JSMni4DCOVu+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kwtXoiO+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VE/0zSMg; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kwtXoiO+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VE/0zSMg"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A49E614001B5;
	Tue,  3 Mar 2026 10:00:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 03 Mar 2026 10:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772550051;
	 x=1772636451; bh=QC3HU8VsNUqqKuaF699nau7+iQVFR6SohUJKFUwfAFg=; b=
	kwtXoiO+W6WGwDnbC7kYrcbwvly2aJTEH33Hf6QzTIgwFbUiqQV4Su02F6m+5Toi
	TynfCAN/DdetEw7BQzMtcByGrlaVaTpFVMrgAcWcVCIlPtHCTJv0qjv4twAHhNc0
	+bn2biKVPKaMurPQJ1QTN+w9xSD94K2wPs/QZB5fwFAPC+bDB4c4n+dWcfzCAdLf
	zCTEOsGg7LsTe+W8v1EikGe6G8p0pS8gmVy8y9x2UyjIEYktHiK9nyPplE/9fFsS
	At1pFM3QB3aUoflbmBU7SVolaI8y5txWJRIUqlAL0E2ZJVpi3sJBrBBopurssYtp
	QaoLzmgMnfYMyOyqdh/cGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772550051; x=
	1772636451; bh=QC3HU8VsNUqqKuaF699nau7+iQVFR6SohUJKFUwfAFg=; b=V
	E/0zSMg3RSlUBts7W8r8akGFup9tLFc+YxGtjWHLAqNgaoE3p4HNJcALLrO85cbY
	109evfQ0XBMedGi8F0gU84KJFkKBzjaOtZLmdib9/IoqgjWag44OdCn3WVxGtmv5
	JNkDDur7goS2wmEM3EAPHF3YP5qwR9cOqqSn87FCo9v4dxL1wrC9szS57rbq1aWk
	tHsMLjh2vloDdzUIFzpdUW9mPcv11T/7BjdA+NiLFWbWYDGesOgvaarzxdbUOYQS
	MlP6i9hCxGsUDlk5yl5NEXU8ssQP0BgThQjbaeHfHdVYowFV0nwB8dDHQAZ1ldP7
	PG5kVxVF0FjaY3RAigdeA==
X-ME-Sender: <xms:o_emaQuUqJLI1Djg1PCdtKE_OPIt0pJ94XlNWgr5pp_xt0Cl-6sJaQ>
    <xme:o_emaUerG05i88UNuHDrC3zz8buprFfOihknTBisH6kWrxhXUWMq5YkuOTrkzTXcQ
    oJvXSS9UNlPKoeDa53vG-yg1KgyE0vRZT5jMeFXJZmS9uQ01C9Kdw>
X-ME-Received: <xmr:o_emaQzFBwNhQey5U_GNGh-iD3MXNZU0aEYChCZcVmBZ71lv3HWhmt2wPc9Qdlwbrb8vEnK-OWk6tjBkUtvhVDCZUMpyhqP15dG5xXROdm2e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:o_emaSG8hy26wIYA5qUTn8RraQ6ho9N5qIQfz6pItRBnfF9SN29PXw>
    <xmx:o_emacz1fQ8IIq8_WweWc_Ltd3um5Mpe-s1YzOYytU1lVGmxM-BFqA>
    <xmx:o_emabs9HZIvR-SLuM6XwYWqeIyd6Xh4o4ZboIG7JOAoT9V32ps2JQ>
    <xmx:o_emaR1eOBZAHfkaqVP3wvh5szFrcJxjjT5E2BK17bN7y2RLQH8J-Q>
    <xmx:o_emaSJzOhNAIlB72iANimuNnCpxdnE3GjU7cGHQHy5Y5h4_BZdbDtN3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 10:00:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f985abe2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 15:00:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Mar 2026 16:00:23 +0100
Subject: [PATCH v2 08/10] csum-file: introduce `hashfd_ext()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-pks-upload-pack-write-contention-v2-8-7321830f08fe@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

Introduce a new `hashfd_ext()` function that takes an options structure.
This function will replace `hashd_throughput()` in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 csum-file.c | 22 +++++++++++++---------
 csum-file.h | 14 ++++++++++++++
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 6e21e3cac8..a50416247e 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -161,17 +161,16 @@ struct hashfile *hashfd_check(const struct git_hash_algo *algop,
 	return f;
 }
 
-static struct hashfile *hashfd_internal(const struct git_hash_algo *algop,
-					int fd, const char *name,
-					struct progress *tp,
-					size_t buffer_len)
+struct hashfile *hashfd_ext(const struct git_hash_algo *algop,
+			    int fd, const char *name,
+			    const struct hashfd_options *opts)
 {
 	struct hashfile *f = xmalloc(sizeof(*f));
 	f->fd = fd;
 	f->check_fd = -1;
 	f->offset = 0;
 	f->total = 0;
-	f->tp = tp;
+	f->tp = opts->progress;
 	f->name = name;
 	f->do_crc = 0;
 	f->skip_hash = 0;
@@ -179,8 +178,8 @@ static struct hashfile *hashfd_internal(const struct git_hash_algo *algop,
 	f->algop = unsafe_hash_algo(algop);
 	f->algop->init_fn(&f->ctx);
 
-	f->buffer_len = buffer_len;
-	f->buffer = xmalloc(buffer_len);
+	f->buffer_len = opts->buffer_len ? opts->buffer_len : 128 * 1024;
+	f->buffer = xmalloc(f->buffer_len);
 	f->check_buffer = NULL;
 
 	return f;
@@ -194,7 +193,8 @@ struct hashfile *hashfd(const struct git_hash_algo *algop,
 	 * measure the rate of data passing through this hashfile,
 	 * use a larger buffer size to reduce fsync() calls.
 	 */
-	return hashfd_internal(algop, fd, name, NULL, 128 * 1024);
+	struct hashfd_options opts = { 0 };
+	return hashfd_ext(algop, fd, name, &opts);
 }
 
 struct hashfile *hashfd_throughput(const struct git_hash_algo *algop,
@@ -206,7 +206,11 @@ struct hashfile *hashfd_throughput(const struct git_hash_algo *algop,
 	 * size so the progress indicators arrive at a more
 	 * frequent rate.
 	 */
-	return hashfd_internal(algop, fd, name, tp, 8 * 1024);
+	struct hashfd_options opts = {
+		.progress = tp,
+		.buffer_len = 8 * 1024,
+	};
+	return hashfd_ext(algop, fd, name, &opts);
 }
 
 void hashfile_checkpoint_init(struct hashfile *f,
diff --git a/csum-file.h b/csum-file.h
index 07ae11024a..a03b60120d 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -45,6 +45,20 @@ int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
 #define CSUM_FSYNC		2
 #define CSUM_HASH_IN_STREAM	4
 
+struct hashfd_options {
+	/*
+	 * Throughput progress that counts the number of bytes that have been
+	 * hashed.
+	 */
+	struct progress *progress;
+
+	/* The length of the buffer that shall be used read read data. */
+	size_t buffer_len;
+};
+
+struct hashfile *hashfd_ext(const struct git_hash_algo *algop,
+			    int fd, const char *name,
+			    const struct hashfd_options *opts);
 struct hashfile *hashfd(const struct git_hash_algo *algop,
 			int fd, const char *name);
 struct hashfile *hashfd_check(const struct git_hash_algo *algop,

-- 
2.53.0.697.g625c4fb2da.dirty

