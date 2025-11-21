Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B383B33A030
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710897; cv=none; b=FxomilgOhylh50nL4+8Bf/Toaac8/6VL4g/G0PyNElrHpGubdQ5BTmpIRdZxGLN0mbEk8Ft70c0eyW+238XlOQdqRbLsQOpsRgQrJoGf8PAQqj7AeI2VMhCD8j5N38lpbc5dBZB8n8OEmYAb6KFpT8i+2aBtCuYMn08OwX+1ZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710897; c=relaxed/simple;
	bh=7ytD0HuLNkdWNVcNVM9qApTVo24giKsylNamDNG4bSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FrJByPiDsJLBmFg+0lKyJovaBRaufKQmhp2stZ77KBq/tDbQidhUtFwc8jVEMdu/7tvhWQwk+5I5S8dIn5xiV95GkGfuuffoADxOssUESINNXRvXnskTVYwR6CWlOjxpR9YxKYHg1noWs4xdlHyD0ukykVSMAm/GCHprDZfyjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OmCLWDHM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s2jf6jCo; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OmCLWDHM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s2jf6jCo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E53267A003C;
	Fri, 21 Nov 2025 02:41:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 02:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710894;
	 x=1763797294; bh=m5BfVQf3yvgNxPhvVNVWvFA7f3S0bQ0bbsSiH7f1Y3c=; b=
	OmCLWDHMQbujNezOltlGESch7jkqENVRrEbp6Uan8HBSQQu5lc652aoBNpmP81L7
	I8l0KxbYikiLP4dfRJNJ6MCFtfC8iocSvSvOzUxuZPW8O38MmTKketRUWe/vGI9O
	4i7sTlMsCJM94ip/Z+kcoYsjAl0WWgoSZfZDE7i3PtEfoX+wyFVbhuMXbvK7/iKR
	P/fXrR9lIiLB7gMaKLFYvMvNZt25+zX1aAIY6BGBt8CQNLxGxdV+R6qT5Ztt5zih
	6MuCwf/mLxVchQdaILVzvpVW3jCBhV8BsA3R7fmL+reNZUy7QJpDzaZa0t7CgdPq
	41KfZUCH36nFGth4n5/IhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710894; x=
	1763797294; bh=m5BfVQf3yvgNxPhvVNVWvFA7f3S0bQ0bbsSiH7f1Y3c=; b=s
	2jf6jCoroEqVp0mZoAgSCme34W/7y5Azwmzl6CX7nUe/B9YuVhv/FBntJ2DyK4mX
	Z98BYZnJDHX3+eUPNYKWMHsQA7rwrl02mPWdOFXOqHKdrQyCKeBmdNQXrinY2N+3
	idQuaSsfbUY160uJDw1p5RQltF7FImPgdc5TlPBG9TnC+VWwXN++3jOZHX1BY351
	P1Udj3uwO0IKwUx9hBB1QZaPuSLf+OItm6dE/ZCzsqrSOZ+eueYVk5Kf2SQu9DKX
	yyi/DdaK24Ax7MQg1pXo8ArQQ4zi1sFdzCgAa4/A3wVKtfycgpE7Jtl59ZEMWA6w
	u4HcGI35W+xKBkqcPupwg==
X-ME-Sender: <xms:rhcgaXHqeY5SKwZ2RZbZbkmOXuQ5BvZ2phff4qYNmgD99vq3qZKOYA>
    <xme:rhcgabxPiAIXO5TA3xpeMwll3UY6ob00XWO--azsp10EA-zVw4BMjeVdoEwpbjh09
    AGiZkKRpPwlufOhISSY38ZGQ-3am0CvpyiLuwBEcfF4DJ1hfQz4qg>
X-ME-Received: <xmr:rhcgaWjjeknIO7xmT95i8ZVntGdFC8WGeOQuzVZx2UfNzlfR1VD1dSwJoqDcS-O_iP4ry_u9iJra0pJmoWKjzv3QOtNocs0Fo94Hq0XoHXTi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:rhcgaezGTG6yEvnnmxZ296leSh0jr-nzi0L5jZyE9elqr1TZpNVKJQ>
    <xmx:rhcgaRI2WmVutb-q-tg3Hg3cRlqcUlFVkhVVu06Nae6R2ernxLTYgg>
    <xmx:rhcgadSyJrOhriEHKSNbK8Y-2fKrGhO-j-M-hoj4iZZMY3YAQdG_0A>
    <xmx:rhcgaRqmZy1MUiEyaXWe_7T5sLEhBi5kY61LVjca6gUhM_mfNWoGSA>
    <xmx:rhcgacPDZckq4TwmFahFIsx8KDkojDMd1VRw7wY32aN3NR_SVoTU5g6J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc492c0d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:41:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:40:54 +0100
Subject: [PATCH v2 09/19] streaming: create structure for filtered object
 streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-9-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

As explained in a preceding commit, we want to get rid of the union of
stream-type specific data in `struct odb_read_stream`. Create a new
structure for filtered object streams to move towards this design.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 54 +++++++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/streaming.c b/streaming.c
index 014c9b8d90..45463b5c55 100644
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

