Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D704499A1
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083508; cv=none; b=Xr0GgEXao5T9RsYGBf88nIwwx6q8cxG42IpZqie5aFTdE6VdFY6nQDX0CcpGbT37QLHm/cbhJhyk66uu1WWXyGPcXCqzLAUmOFuhfS9NbyZbaQr2OTStytQcf+R3Drp1B03quozXkBMHbpiOcdIAJrALSoIuQEEc02nzayhwIoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083508; c=relaxed/simple;
	bh=yp3r5XsigUq+tcF20yEFLb8au0d5dmg4nDEYzhHZTh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VMcSaqmlf7YCypqW4iu/gm1S9R8Ir3LC2ZURuQVXA0PNx/cG6xdc9/3QpXUy4szpRdxpr46Wu9QTI9Ju8yuJV53W4yTonvF8shHR/BiLIOZZCvctYQXlsF2fMnPSbkORZFzOfHEnP21qsEcDWF/404geJnHg9xKwzxbiMo9CJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ji9RjGLA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mKdP1g2h; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ji9RjGLA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mKdP1g2h"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 08D6D140010F;
	Fri,  7 Aug 2026 02:18:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 07 Aug 2026 02:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786083506;
	 x=1786169906; bh=saH6IEHh9UP4BAhw+yVnlOXrBIcyH0VZQ+jt3urAHNs=; b=
	ji9RjGLA8MxLe0hgRsQ9X3VbFQIvhdrKUpF7H7HtpbXuesXYRvM/lPXDAtJhjuQr
	Uu7Xpi76Zjv+aSTypBgMNhv5ijID55WOVWBH6GKZuKv+jIoAuY3u6FKT1X+zv7P3
	IYmrj1Gqwq0y8nGrCX1FywGDezgDpYuZQrd2GL6evI5BUtxQRCnICBlXYVDeFjhC
	BQqwX3mk6bBv9R8A6Vb9mP6KPP7O0Y0EMvPgCTGycIB1BJhbwBIwX/2QekvLATZJ
	g8cmyvxhvBLQg7XZD4CugcWGzJhMw7vGixMN6Q848sX50oJgIq40+1t5E0eDXZ/u
	u/FTPcWS4ylIByALZ+zqJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786083506; x=
	1786169906; bh=saH6IEHh9UP4BAhw+yVnlOXrBIcyH0VZQ+jt3urAHNs=; b=m
	KdP1g2hpgafMKS1W16nQaikiLs1H5OGxtvV3nE+ITvai6yx7jPXXEcoGHLSrVa+l
	ezLsz4f/k0N8WPq+xGFvPjLF0bcMyD5Toc9DpJsalIiNKwvbT98ZvTN6VaP3bhXQ
	0/dAA02z6YB6UdsnXHuxGNGGiYXSeUYJsIil5S8lfCX9xaPsl+tS4jq5DPYaRRl5
	NxfUuccAPGrdAder5cH74ZsEfqkOF+m4Nlp9ylkk6zbl68jbGUlMtpZs+6/vkWOd
	F2VZ1dmYk++2tx/DQCIkarxeabF8oodwnk3g+Q6qJHamR1t0goHKWkbabjwmRRFK
	GfjtMj7F+zMnEa8QQ8bIQ==
X-ME-Sender: <xms:sXh1aiBHyX8R0omVTQmXlcUlRWOqy5ey3GjvytRvZfxG72foNRifug>
    <xme:sXh1amgmAwXeHYD-KE05891K54epxMMfXW0Dg70E4lViwbYojfPw2eIuCzCi60Aud
    tbxhifKY2-BmeTxbqAQeccseLst_SL_x9OikT-Xova7JbAYwUO-GQ>
X-ME-Received: <xmr:sXh1asNY97ZHP0s5teUDLTFeEnim9S0CaQlu4h8XBue_Vh53JWcO5fuJsh-16TWRydXJzrIEbzAJ2yWfCp5Y5RNtDTi39cdlsm84TlV9CuZrRg>
X-ME-Proxy-Cause: dmFkZTGxsXQxKCuZD43rQ0iQZSX6hFfdSm1xpAVnkHujAW4j84qLesqV7BI0VpDAUjHiJj
    bteZnKwWUajn7OyWhebuFwqBXr0kKTVu3Y4voxbTTO1qPGbzlRn9tJ6YcNwS/+h4F3w9Si
    xXI2kegTHwZO9NClbeciECSmL9ME801qlkQg3EiPrOPVdRMexWpRGZIFTpz3yR+IV8D8I9
    d5UqoEC9/V8bu2c5JFh5Mq64+MuJJQOS6TCGFkfv0TYV2mQS7o8Y33R3K/UP1xHAz1J0qb
    W5idYLdcUApeWCf4xejYjtMvlch8B1o/bJJq6OeKeh0iiHguZh1WG1III4QDtmdAJRHPKw
    cshXJCGxItNEBMyG4LKAbIdLn4fAUn+N0R7iUi2BJQdPeR1RNsih6sY1NQVzjawsygdlhf
    laEwbWHvQ50JNDvEXkyBIxo7xiJxoyqyLd3AZZ86g4TtMnl/uqVB5oUUK2IhWQ9/xaFWK7
    EtbIIvNiv83piQfUCZxMaN/UkUCpg7/ryQeHa0Owjs4UT5tu/k8986slHx7SppqHHOjc4A
    SniXN5bAv4fVd15zczN2PweOqQ3ZqLnTgwIFCUmUSSryklGwuDHZavHfAnfWe1qEs0XM15
    ECSRHCby4YtvJ662UU93G26o3szugvVrr5EiAERDjuBNYpawKM6+SmugEAzg
X-ME-Proxy: <xmx:sXh1au_6i-_WPTOTOw6gYgREUmaavUtPnSZi2e9uE8INPWfANWlVBw>
    <xmx:sXh1alfiI9usDvkpMWb-5u-i2P0Jj9S1hibU1unLcXhm6jgBk1WA-Q>
    <xmx:sXh1alxpidiN-zYPom958p-RA8tsXfWBiU13bhnIAfTuTYBjSgX-sw>
    <xmx:sXh1aiJZGBdiEu_A7AWcTnrTJTeealdYHC16AvJbmANDgyx7BAn_dw>
    <xmx:snh1alxxlpFo4_0-PmJy838-cvtbGeOoWNkoWQAO7fdeLWL1v6mC94Sf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 02:18:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 06291d32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 06:18:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 08:18:07 +0200
Subject: [PATCH v2 5/5] fast-import: use writev(3p) to send cat-blob
 responses
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260807-pks-reintroduce-writev-v2-5-30fcff0e89c1@pks.im>
References: <20260807-pks-reintroduce-writev-v2-0-30fcff0e89c1@pks.im>
In-Reply-To: <20260807-pks-reintroduce-writev-v2-0-30fcff0e89c1@pks.im>
To: git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

When answering a `cat-blob` command, `cat_blob()` issues three separate
calls to write(3p) on the cat-blob fd: one for the header line, one for
the full blob payload, and one for the trailing newline. Frontends like
git-filter-repo issue these commands in bulk, once per rewritten blob,
so the syscall overhead adds up.

Use `writev_in_full()` to send all three parts with a single syscall.

This can be benchmarked with the following setup:

    $ git cat-file --unordered --filter=object:type=blob
        --batch-check='cat-blob %(objectname)' --batch-all-objects >request
    $ git fast-import --cat-blob-fd=3 <request

Executing this with 100,000 objects in linux.git:

  Benchmark 1: HEAD~
    Time (mean ± σ):      1.320 s ±  0.003 s    [User: 1.154 s, System: 0.161 s]
    Range (min … max):    1.314 s …  1.324 s    10 runs

  Benchmark 2: HEAD
    Time (mean ± σ):      1.270 s ±  0.022 s    [User: 1.133 s, System: 0.132 s]
    Range (min … max):    1.209 s …  1.282 s    10 runs

  Summary
    HEAD ran
      1.04 ± 0.02 times faster than HEAD~

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index aa656c5195..48fda01c94 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3332,6 +3332,7 @@ static void cat_blob_write(const char *buf, unsigned long size)
 static void cat_blob(struct object_entry *oe, struct object_id *oid)
 {
 	struct strbuf line = STRBUF_INIT;
+	struct iovec iov[3];
 	unsigned long size;
 	enum object_type type = 0;
 	char *buf;
@@ -3365,10 +3366,21 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 	strbuf_reset(&line);
 	strbuf_addf(&line, "%s %s %"PRIuMAX"\n", oid_to_hex(oid),
 		    type_name(type), (uintmax_t)size);
-	cat_blob_write(line.buf, line.len);
+
+	/*
+	 * Write the header, the payload and the trailing newline with a
+	 * single writev(3p) call instead of three separate write(3p) calls.
+	 */
+	iov[0].iov_base = line.buf;
+	iov[0].iov_len = line.len;
+	iov[1].iov_base = buf;
+	iov[1].iov_len = size;
+	iov[2].iov_base = (void *) "\n";
+	iov[2].iov_len = 1;
+
+	if (writev_in_full(cat_blob_fd, iov, ARRAY_SIZE(iov)) < 0)
+		die_errno(_("write to frontend failed"));
 	strbuf_release(&line);
-	cat_blob_write(buf, size);
-	cat_blob_write("\n", 1);
 	if (oe && oe->pack_id == pack_id) {
 		last_blob.offset = oe->idx.offset;
 		strbuf_attach(&last_blob.data, buf, size, size + 1);

-- 
2.55.0.679.g6767b8d81c.dirty

