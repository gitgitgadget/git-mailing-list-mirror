Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0F223328
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924418; cv=none; b=I32027RtXiC3x+BDhCbmHmY9Tth3mmfd0DviGMrcOKft/jlUsvcQzsO7jNCW99+XrnGFJSDduCEahe3m9x7i2fg6iH+B6zwFjx0AMppHVgCPqYdtdmaw4IcUFGW8YA6VxgZCJvWNKwmlO03C1dhg+R1jx7cFMI4bKgRq6K5NaSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924418; c=relaxed/simple;
	bh=rkeIsU19acKdsJozZVQorhFz+wfqJB00BDt4dnAKLYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hu2BY6mVbPRI5Yqw5GVbnwMPr5CI1/Wg0iF2Nc1duXKqnsMww4kXDeir3WkEG5x/R7YQnxKmNSHeRfQtYnTAgENscaXl2bSZ4HNwZGyvMBGkfjlDxnkLJRf1NhRyBB2q9iEYet8sEfQtUv6KFDBVRPUip31AVMz3c9kPpEhcTdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a4ZClzLq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AUw+oV4+; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a4ZClzLq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AUw+oV4+"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1820B7A0091;
	Sun, 23 Nov 2025 14:00:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 23 Nov 2025 14:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924415;
	 x=1764010815; bh=pfP/2jPGHmQ0haa+Z3uyFjs1O7JMy0EKvVTLRDpFHgw=; b=
	a4ZClzLqpPO4dZF02ESLa9PLYWej70mLscSTOH54qlHTHJ/mgaGbQEdqc9Cx0gOc
	nC/SqhH+0MtEudN5gqsral+CgdaTaqYEJZ1d6kMKyb648IQPiZ+ViLOr/65c6BPO
	4VJ0Agtnf9ETtGOqXqrKgfoUA2BcOUhCCc5kRH/hL79j6nxhfpHMa583lE7KP/NQ
	UtXKFTrbTDPkoIrjaYmEbIdTdQpy/7TskjbaVa9pwKh/7H06iqcaSxljoaTwlypC
	DoOHtgOyMR7gfqcB8iBAef71IJWRrAxVs2WgqjuWHLLLjsv0JqooeaWeQxBb3IIG
	j+4TTX9EWOsyyFjOUl/QQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924415; x=
	1764010815; bh=pfP/2jPGHmQ0haa+Z3uyFjs1O7JMy0EKvVTLRDpFHgw=; b=A
	Uw+oV4+OJJZjoDd0GQaMwLRC2EVpaOhFpWCCgYaCy/WwQJ9xm78Dka+EFiDq4/59
	Vd8jTrimJsONwfAC3T6tEl4QAlUe9P+uijPX4aDqh37tMpIKioDWLytL6TmNF/3I
	sq9rAYsl/xgSONEqxg1RSv6mnmD4qV100B8Kbkv1Y4UIGfeIOPlfUFOjdFW1Zka6
	pklMwDNVuYa9JNhW8Ug+PDEOS7M+tLzMYulX43n3jTVrAeNd9qgcXut6Kdg27Nsw
	hxur9iDfuCfGBA2P3lztLCOb3qoBRZwH6S7KFwKotnP333UhEYRJ6D1bLonulxu1
	n5EcvK7p6sxf31uYiPocw==
X-ME-Sender: <xms:v1kjaa4Pi7rzukflvtGtNQUwTp5YFac29rrYsF93KWCHly9YdGw3Fw>
    <xme:v1kjaa7B4hhmmwn25lHjMrp3yX5kmV3nsBaVY_gsO0igfcfTV4DYYI6QHQCvxwLac
    91J8cnEn6Vyc2pTC4P9LhlsM8agA-qCexlqNohYA4r8FW6wGetO>
X-ME-Received: <xmr:v1kjaefY4DCT2lvYeK-bhs9n4jpCpvsRWc-1r1Hn4eZ8HxvNCVP3plzYVWRdQok1-SfK5D3Ak7JbI2ZHGFMG48X9wFydlqhUahKyXcJnx83oSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:v1kjaWDyr_KMv-dza_NkRTm1q1qFbfg9UQRwdx8c1ywKWH55uO3P4A>
    <xmx:v1kjaZ-obcZTJeygqZAw1bQHExXSetJc6I4ExIvsaN8zGBJFkzp1yQ>
    <xmx:v1kjaZLzWaV82Kf1HLeG9YOpsduff-Kw2mtcY6lqxKwCLr7UrptsjA>
    <xmx:v1kjaaj0pOa-jUBt2l_zkhyaA2hIKsyYdT7dMZ5_yHndunIroLF7HQ>
    <xmx:v1kjad-FbkQE6WhjRSimxLQ1M5UAVTScRd47SpViOPjmFj3q-cf6nGj->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 14:00:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab2f37ab (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 19:00:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:34 +0100
Subject: [PATCH v3 09/19] streaming: create structure for filtered object
 streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-9-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

As explained in a preceding commit, we want to get rid of the union of
stream-type specific data in `struct odb_read_stream`. Create a new
structure for filtered object streams to move towards this design.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 54 +++++++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/streaming.c b/streaming.c
index 788f04e83e..199cca5abb 100644
--- a/streaming.c
+++ b/streaming.c
@@ -19,16 +19,6 @@ typedef ssize_t (*read_istream_fn)(struct odb_read_stream *, char *, size_t);
 
 #define FILTER_BUFFER (1024*16)
 
-struct filtered_istream {
-	struct odb_read_stream *upstream;
-	struct stream_filter *filter;
-	char ibuf[FILTER_BUFFER];
-	char obuf[FILTER_BUFFER];
-	int i_end, i_ptr;
-	int o_end, o_ptr;
-	int input_finished;
-};
-
 struct odb_read_stream {
 	close_istream_fn close;
 	read_istream_fn read;
@@ -37,10 +27,6 @@ struct odb_read_stream {
 	unsigned long size; /* inflated size of full object */
 	git_zstream z;
 	enum { z_unused, z_used, z_done, z_error } z_state;
-
-	union {
-		struct filtered_istream filtered;
-	} u;
 };
 
 /*****************************************************************
@@ -62,16 +48,28 @@ static void close_deflated_stream(struct odb_read_stream *st)
  *
  *****************************************************************/
 
-static int close_istream_filtered(struct odb_read_stream *st)
+struct odb_filtered_read_stream {
+	struct odb_read_stream base;
+	struct odb_read_stream *upstream;
+	struct stream_filter *filter;
+	char ibuf[FILTER_BUFFER];
+	char obuf[FILTER_BUFFER];
+	int i_end, i_ptr;
+	int o_end, o_ptr;
+	int input_finished;
+};
+
+static int close_istream_filtered(struct odb_read_stream *_fs)
 {
-	free_stream_filter(st->u.filtered.filter);
-	return close_istream(st->u.filtered.upstream);
+	struct odb_filtered_read_stream *fs = (struct odb_filtered_read_stream *)_fs;
+	free_stream_filter(fs->filter);
+	return close_istream(fs->upstream);
 }
 
-static ssize_t read_istream_filtered(struct odb_read_stream *st, char *buf,
+static ssize_t read_istream_filtered(struct odb_read_stream *_fs, char *buf,
 				     size_t sz)
 {
-	struct filtered_istream *fs = &(st->u.filtered);
+	struct odb_filtered_read_stream *fs = (struct odb_filtered_read_stream *)_fs;
 	size_t filled = 0;
 
 	while (sz) {
@@ -131,19 +129,17 @@ static ssize_t read_istream_filtered(struct odb_read_stream *st, char *buf,
 static struct odb_read_stream *attach_stream_filter(struct odb_read_stream *st,
 						    struct stream_filter *filter)
 {
-	struct odb_read_stream *ifs = xmalloc(sizeof(*ifs));
-	struct filtered_istream *fs = &(ifs->u.filtered);
+	struct odb_filtered_read_stream *fs;
 
-	ifs->close = close_istream_filtered;
-	ifs->read = read_istream_filtered;
+	CALLOC_ARRAY(fs, 1);
+	fs->base.close = close_istream_filtered;
+	fs->base.read = read_istream_filtered;
 	fs->upstream = st;
 	fs->filter = filter;
-	fs->i_end = fs->i_ptr = 0;
-	fs->o_end = fs->o_ptr = 0;
-	fs->input_finished = 0;
-	ifs->size = -1; /* unknown */
-	ifs->type = st->type;
-	return ifs;
+	fs->base.size = -1; /* unknown */
+	fs->base.type = st->type;
+
+	return &fs->base;
 }
 
 /*****************************************************************

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

