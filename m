Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244023B9DB8
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149128; cv=none; b=pSbjrmil0NChz1eispk55U1SYYfwKh0zBpVAkOKAYMcwqxFAjq2aEYzGUdTRbOnhjfCB8Y4R79dqn8ujUK96ti5f01XAXvNMCn9wk3IBt6c8fl9HX5qAJ/dC9xqIb1EMOn4V9VldHeLOk2XQ4cmgdWZUGKTp6VRhsLfOzpMlLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149128; c=relaxed/simple;
	bh=994n2oPVTXP2ZXhV5KniDkDZLnlckrvTKsLV2ehhPpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a1QDCZQiQgylqzx26c//OMdv/EFjxI/M1d0zn4zN2O1w/BrEMnsut9k3KzxxIOlmvr7Dgf3vGBbf3kKY5liUxCj0gEodYirJFK7oIvgZwhKq79CNO/6/Jc2orKwfV5Z7lzpdjppYV7tVbYGp8mxQwig4grJHx8cWe7HC2ss08cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ECI1HIyT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aWcQgqT8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ECI1HIyT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aWcQgqT8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 555C8EC0B0A;
	Tue, 10 Mar 2026 09:25:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 10 Mar 2026 09:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773149126;
	 x=1773235526; bh=orx53Qu66e2mHhciw1ZsG5Brzw3jcP830xF1OHBkecY=; b=
	ECI1HIyTIbPphR3bBZL0f3fAeCpchdM3rLeSHYWzmZvsIN/4OVPGaigBOoI8GGxW
	8iBNl+jwkmpHY66P3AwKtiiN6qQ0ASa5BzVUOS15F8fifACaUKX9ov8wonbhgnmD
	p2I2/LkOl7Tv4Jk0N12Egyi7/SInNJdNYvyON++vthgU6PcQ1hjw2YV4GAc2g44A
	ZBQGAS15yv2Y8K7NklWJALuNCGFKIGf0D2a/QbyN8ce6tAMxba5VrQ4bCvGv/rDf
	TQT7J/gvIfz2BZ8vpodSBz2bvYHsOTM/stuw7hChN00id9AEv8R3rViPmdi56ypN
	Wvg9VRtTaJ0CZjnq5DVNAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773149126; x=
	1773235526; bh=orx53Qu66e2mHhciw1ZsG5Brzw3jcP830xF1OHBkecY=; b=a
	WcQgqT8FiuY9aeip4o3iktDvv/auBqLvyXjxNMfV2tFgQnq3G92AI+Z6jbURbzMj
	Oq7mCnjxNp2qV9YrvMBjWgAuiyThhWYrIuWhjtrMIE1L8l3sFWZAIHObaewWJkqK
	EbNwBY4AzE4QZIUTfXu4BlhqeuNU9NSvwMkaKgRQDlHrEyOp3N3ZYflkj7p8FlzX
	x3SlIdhCzZzrK1UWZDk86x5Rv7yiFndJDECUJo9286eJnMyFxw7i9lhycTZdwk2x
	qNtkq/rINyZvVhEMtHcg/q82XCOBtks7/mloOQI8iBaredaZ/anTIoXX4USHyMXp
	+092CvA3tABIEtcuj0r2Q==
X-ME-Sender: <xms:xhuwaRo6gZJXC9dDvRVLnot5Dcv9PXoachhOYyjktwywDRL4oqfJBg>
    <xme:xhuwaaj_XbJHS93FzK2dc12h_6FOxpFM_VoCluhIkADF7_CJrzx5XpevD8aPVTEa6
    nFwIOH12KXSyfBRACQqw0Xx1-NRN1fg_tOJMac4msa6JDD-AWT-5w>
X-ME-Received: <xmr:xhuwaWhdqWeJAQmDPGxaadTIaoBrnTn0Ska8iQNTWSe6ACAzasV9wjO5aQ94851WgX8Pg_ACppeVyDaxZkyqKYVObdPlar2yQ8Y7lFt5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskh
    gusghgrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:xhuwaYhfiR58hk50yxOxAsbaf9M2Fjq2Dw5XkC_g-pfsIi5X3yhTuw>
    <xmx:xhuwaeKZx6JtxEuzOjRb-rP_CpMgYvH5UD2MEgM2-K7IQ5QO_8O3Qw>
    <xmx:xhuwafHqkX8vTRzcovP2R98Fq4Xu24B4SEodAleYLeNBrPGBaz4XyQ>
    <xmx:xhuwaaTWmlRkDPZVg56cyow4eowb5crrWSQlPut2x4z_4zT4FN5nQA>
    <xmx:xhuwaY8756hY6nUtJYJ7etoM6P0GGwstLPSgHfyf7W_WnEs5o0O7X1BG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:25:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea2a759d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 13:25:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 14:25:04 +0100
Subject: [PATCH v3 08/10] csum-file: introduce `hashfd_ext()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-pks-upload-pack-write-contention-v3-8-8bc97aa3e267@pks.im>
References: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
In-Reply-To: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
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
2.53.0.880.g73c4285caa.dirty

