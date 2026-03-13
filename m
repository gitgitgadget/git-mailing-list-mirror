Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4733F8B4
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384343; cv=none; b=AZwaeBGkAWKod5PiGIk8GdMlBNY7wzlfaNGshYdaHxiYBynd8Ln/kUUcr3xR6t72e6lM2QWU2uzbnQQMmDHGW3DGA1vB7FI2s7S+6oitvNfxM6YZrSnquls6eicsVVt3fugwN4Xi7uthMOnn5xfrJksUqcX+H0UrSK1kbPiwoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384343; c=relaxed/simple;
	bh=JoxIgNsA6zzl8zplULQhioDT43SQVSCb25WoviIVum8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hdEcvDI5AvqtDmv3kJb2+/0mvYpMM5qI4iJ9afaOGpQngrAU5E1FVjVmYDAv3htyHGqj82s9zx8fyN6yV03iQr/f69sv3BqiNqa6hQo72JO9qkSO4lV29NPYWRBj5ful5QJeWSWpJau+ktV0lcEx10ia0wFJFmA4gu8aoQRxHWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N5gzmqWM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lEZIt1PH; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N5gzmqWM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lEZIt1PH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 84CA97A0190;
	Fri, 13 Mar 2026 02:45:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 13 Mar 2026 02:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773384341;
	 x=1773470741; bh=huTTE60rJPmXEJV8F19QsiNBUdt2zCU1JCWvGVpnjA4=; b=
	N5gzmqWMYvrKq3lMrR477Yo1ubvqe4aMXgsD/4suE1wOz3yofd9W8J2tl0TwYOVQ
	FhTWKVQMAS0CKrRgRx7GAEp5C9HYojPN6nZgIMaUntfkCEYGO74JJtJzcEt1eHDm
	wy+2b3vEjjpDO1Qx85VJFmPbhru9g3NKz+9fnO7+DZ/+phi6zkMLvCHa9QiX5OT8
	xMhd/wpqqv8QkGS33DLcQ13/gpdavur46m3Zhx8mQFGzRoJlOndFtWNGgDZCt6kp
	WNtekfuyE/FOZaDEk21GBjGl1GaVLI3dKd8ErpaZmu3AEc1+rFZjjS9zFrGKAnM6
	bn74gzsszOcPGnETx3Sy7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773384341; x=
	1773470741; bh=huTTE60rJPmXEJV8F19QsiNBUdt2zCU1JCWvGVpnjA4=; b=l
	EZIt1PH0ialtdty/phTZx6+bzEV5FG3JAOamJxYD1LJMb8iuY8v01iN6dLoZgoH4
	f/un+a2clJiMLlhDa9jIb7Na9WFceYP8GbRrQj0Ks1ZqRK7xL+qp8todTSiLcUYK
	ELJECZe6xem2EXpEU3DJ4t9Z/KNkKoahIPkaI5NZ+uIqWRGOOlXCdcEIYIgXLjXv
	bx0QVSBeohb7NkeRhAUY6oLv52fkJWOC9YGN1Xi1FNmMAZLEr0SFYwR8dWwTZWCx
	YkCK5GM8maysYPYiXyI8vF/TFuuPZPbkWHpT+cR0jcS+sZ+DCuJ02MspkXQWL1ew
	YwnLBkNwJdAgcpfgt1rkw==
X-ME-Sender: <xms:lbKzaTS52-XfR1ROhrKV78EvFrp_-btbEiSPBgKZu7VIITpKVbckzA>
    <xme:lbKzabp5DzaTXE6FOp3yNEe93m-gHZ6gcP_kDapkn_YeQrICog4gjcQQao4El8mpQ
    d33EpLsYr2Ir7oWBDexBKxoX3xpuItFGGHZanet2IuZ62dcGxzknSw>
X-ME-Received: <xmr:lbKzaRKDfhLUgQL-hmEhtiloy20hbWJHsX3NnDp3-rwrTdSr9vm-z7puQkF4GEIyqasAVpJ3wKqZj-CPADi8M7QVMoemClXN48FwNsJHgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:lbKzaeok2X805Dox99WglFjLvHSrDYNohWGRJOylqiJFOTEx1_MZQg>
    <xmx:lbKzaZywbK9juJttDcBqhyR1Bw6w4qep3NDlyFBFEWEvv-HKSXpL4Q>
    <xmx:lbKzaSO0v3O4zxFMVdKHythRl0Cri2H12CSRYauwK3v6v1I2vW0vCg>
    <xmx:lbKzae5s9ESuisetZ2BJE0uxrWUR1tnT1D6Yu787JeMFet2GiTq_2A>
    <xmx:lbKzabJq20EkaHD7MChvjU1XxHvo0p0wEPn9WDDRTff-_2_Z3TfPd8X6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:45:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a14d80e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:45:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Mar 2026 07:45:19 +0100
Subject: [PATCH v4 08/10] csum-file: introduce `hashfd_ext()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-pks-upload-pack-write-contention-v4-8-7a9668061f7f@pks.im>
References: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
In-Reply-To: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
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
2.53.0.904.g2727be2e99.dirty

