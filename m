Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C397A2EDD7A
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538481; cv=none; b=Zj8ajis3ssVLkllArMlxzrsD0yRO/L+4or9GfrsrS30fFwEOtw1AnqO5xr0wlDjI+jOajUmzG9jwlgFtNZI0sUIID6UX3nRtGFYiLZTkH2Yzfq0Festoa392QUxx/Hp1af07sOaHA0zYXzhv790jtK/2lw4dgNN60srRi6kTfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538481; c=relaxed/simple;
	bh=Kej2Ff/yT721m5P32hNtpTzQsFOMHHZk+i9tm+AogE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSvb+V1oKvUT28JWocWO/+C+97WejtF2XcPYaAZeC2WPuBwNP/f2jaoQVoStla4ztd1iOs0RzSUeWK9vx77uJ+RKVv6dTUiGLBHaVu0v2/6uao9ZDR3Fe6ul8qHGdTYAc3gW/Q8IB4szxAMMVzofrDef4Z76LK4hnBuxd80k1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C+qQG60x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AWlq66am; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C+qQG60x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AWlq66am"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC6F114001FA
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 19 Nov 2025 02:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538477;
	 x=1763624877; bh=TzgEDrXsyxvqKiz+3VlV6+nR0MLEFFC6qfWVrcyVgvQ=; b=
	C+qQG60xWM5bkOjWUSrK2LyFR2apyAIrLAPFy0Yrhz5hZjiO+bWr+O5CupIsPEyP
	ZTl3+cVNbjZJn0ppAoSsc0f8dQ1nquBijllE6NFMbeZXR0SWTGVPbAG11cpZqeCX
	RaxrJGze4CPLEAuZRic0oA1zjB09grtRUhFd0cg1ebCsBLtlh0+8LVuzLE3QCIba
	UCt6JLBekpnIW7XrXsrq6wDSBhIGV4wYRvWgW89I2zo1kX3kjI007h07i721M9LZ
	Vyfd+tBn8cHgfJ7q1CBTNYyGMVfoudza0wUI82TkrBcM7tTxPDc9+46PWZhwClLn
	6pEHNA0RgmB8GA5QAxz5+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538477; x=
	1763624877; bh=TzgEDrXsyxvqKiz+3VlV6+nR0MLEFFC6qfWVrcyVgvQ=; b=A
	Wlq66amHg1DVgJp86LTj1uXqjoYZFaTvDc0rynmUKbGZoDB4XNMJaGtZZbWW62Hn
	swS1le+c6ljnZuQSFs29HwsSfdFsEeo+xKtAX8S6hdXEn2CPNWcbZfuafjDKLYRI
	4Bai5xQpIrwuVUJ+tJF+13KuarKgdupWizTVwRjfbDYGXIC138D4aQOmLX7WCKk3
	Y0Uex3Fs8t/dc5nNUQJtFnpnwGWo7jgrV1JyyDSFhQti2Vcyfk4+zb9CsvpaQ0q9
	YKX3xqicAWufW/dZDj6FCSF0DOws/q9Ew88fFDrrw/FlD+MAWpO42AYI3vqlXVKt
	HmF8HEPDlhDl9gXpEuvEA==
X-ME-Sender: <xms:LXYdaRDLaxdb30UeqOdiqRkIZ7kPGS6Ay4HEhDGVR-SnyBwxzq7QRw>
    <xme:LXYdaWfqtYrJ7yHcgOjawDwov4Fp_qs9BBf2DC7wjsLvJfy-FFHQsfi9xmISfUCoR
    fHwIEmOV6bkzp4V5-aT-WiQRGCVNlJ6ezmsMb1i2oeNiOPztwmN5g>
X-ME-Received: <xmr:LXYdaSPDI2WoF0edBFi1RWlaaV75iP-QlQ1aZ4MD9V7IXg6NxXLUpd1LknQ3z7VpMi6OfKw-hF-7Pwl2T-iQaSjdhHrtXYAfnlnzVwtclA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:LXYdaQ4JRdgVJojOgCFxpVmEbexi1P12DBCENf2JDfWzK3HexhgSjA>
    <xmx:LXYdaWJklDl58XYv69NA5tJO0sFXgiVAYGhTs7mIHYQWPvi2SL-jfw>
    <xmx:LXYdaae2YR7i2gtQAy2E7bj4pM1Y5SVw9aYm2a9XLo69k5EV-9_TGA>
    <xmx:LXYdaZfYp_zw-pnf9IWKk1i9f0Vdc7EJT9rdqD7rzbwTOj8nRtueBg>
    <xmx:LXYdaQC45S9MTBz8VKmNwe4-yiM0_ds-Dyhc3Mmdh8aQo7ukRUifX5mj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6282fa25 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:47:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:09 +0100
Subject: [PATCH 09/18] streaming: create structure for filtered object
 streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-9-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

As explained in a preceding commit, we want to get rid of the union of
stream-type specific data in `struct odb_read_stream`. Create a new
structure for filtered object streams to move towards this design.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 54 +++++++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/streaming.c b/streaming.c
index 435ead1066..8210b21b53 100644
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

