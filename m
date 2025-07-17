Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5611FCD1F
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728214; cv=none; b=i3u82tlwaADZRWjN5gof8NRuKTk6dX21JsLi0Tx5Rd0gml3HMpgPJbx8E/jBPmbRhxj9ktO00E5TsaSe34IGNf/7Uk3ZVWSqBM2fcLXxL0H5rgk/YutXj79WghXAGkYA8Whu5pyEf/tsxAv18TW7YkaOjV+7mWjQ+W0hFSFMQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728214; c=relaxed/simple;
	bh=J3F9tB7VUTcMXNaGlinq1iMiMdjsCMqZmmsQ38XvPcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SWrtB5M+Ur/y1M/IPZ28ad7+MSB+KySSUV5rsDcfPSUZekJ6fX7oLlvq5XeRjRwHfrrJJJNQnIrgyDU6QtcvLcHIhCTDF4+CZc/C0CaUdiED/X632W46w1re1KdyHR9kIAviSos2BqdbM9ZAGmM1trcYxlCzn5NOnZ9UcO2+uXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qUIFFKpj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hXu/sUye; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qUIFFKpj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hXu/sUye"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A5AB61D00193;
	Thu, 17 Jul 2025 00:56:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 17 Jul 2025 00:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752728211;
	 x=1752814611; bh=PEzHcRqi+kM3Lv7mvHo1jJAPOjianw2LX3z5mpP/e5Y=; b=
	qUIFFKpjuXC118epJU1YPw+Nmm/EFG5AKyc40Yb7nv+O448in49FNRywI87MybGe
	ChLh2L02nERxE7Y7SRpcuZkEhDpzIjXByiw/QyOwYUKXkYXZDR1NunIwYnMZqF4/
	CihGJ3I4ev1t7wK2UfgqMq6LrnGFroRFLD7Mtxs39qDHkH4Kl5rhHBy/OuEFWjIr
	lgYEJ8Com112YFjvGM9ykY1INc/AsDOmWAe8uFjXXSYBSTqPQWcJDOg8XXGaNe1o
	/9+U4rK6cqWeqE2s+433HhLyeaFyUcugFVj4DV8+E3S+kCf7KLNFIjolroAOlSdq
	SVgqglJda6rKtV7dwkdSgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752728211; x=
	1752814611; bh=PEzHcRqi+kM3Lv7mvHo1jJAPOjianw2LX3z5mpP/e5Y=; b=h
	Xu/sUyeuz7zpqwUaXU9E34MCOfEJJph0RsStdewPIO0jd38Nc6Q7xLtbT/ptBaTk
	FWdzthcCQmWJxJI8WDJz25zF01lFNBCc9QVOQMJ83wmzrhL877J5nndCjZqBrGuU
	p5fxvyV9nXHe++fekD4kXUi3Of8S7Sla7l5vMoQ42sirIAm7ZQNe6rmTovrgwlan
	b7ksZGkHWrGweec6mcJ2z7gXrxsJX5xz+fIzwxLSEUnftNS2TVxkNZ2B9dZISkjA
	i2MbKB2PuN+ajz2Hxutd+GvvY0iLghjb5HWc5IMOpE6tsA2AyqUIcugZ/X/XlYBL
	XtsuOvMxhGPUBk4Dq6y0g==
X-ME-Sender: <xms:k4J4aKwgl7ktBHLlmuwhBBrRmhcUqJcA-Hoo9XWtOcTnFsBB5KQGcw>
    <xme:k4J4aBwEVrbtxVdgpPZYzqcgUNzOeKBFZMSTfylZ-U761HdfoNkt_FKsXKWzgOnrR
    2uZ_1RGvEtRuQaxgQ>
X-ME-Received: <xmr:k4J4aCwSwoFTJ6gK1TXtfxTsfm8ExqirXxYE0Bd20KSnwXYwWGCOjlSVC1CZqmzoaONL9Hec940ipV87plVj_34QzFKX1vHSbBuSRywOCq4u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:k4J4aLYBm7nY8g6QS0wzBp1DFUw3jxKOFdxiMVa5m0cv_weONbPRCQ>
    <xmx:k4J4aDWYTbaGCggy-LHG79slXzZ7gqC2V2a7MKmWJ_tGVMsUDSOOwQ>
    <xmx:k4J4aJi03vJfg_rJY8cX2WbEI9lhY3wWDHwLsoLNCLh1Ttv4Cuv3XA>
    <xmx:k4J4aBu2pMJwki5Tbu_mzKPCqjCzBKO9sssCz4oIgmeKHQ40ux8CeA>
    <xmx:k4J4aKsVl-ruIRfcpZnDftQg1_AYeowrhRwki9ARF5Po_6f6TnpUSkXb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:56:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 356f0f23 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 04:56:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 06:56:31 +0200
Subject: [PATCH v2 05/16] object-file: get rid of `the_repository` when
 freshening objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-object-file-wo-the-repository-v2-5-36d2cd6c700e@pks.im>
References: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
In-Reply-To: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

We implicitly depend on `the_repository` when freshening either loose or
packed objects. Refactor these functions to instead accept an object
database as input so that we can get rid of the global dependency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/object-file.c b/object-file.c
index 9e17e608f78..3453989b7e3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -893,23 +893,21 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 					  FOF_SKIP_COLLISION_CHECK);
 }
 
-static int freshen_loose_object(const struct object_id *oid)
+static int freshen_loose_object(struct object_database *odb,
+				const struct object_id *oid)
 {
-	struct odb_source *source;
-
-	odb_prepare_alternates(the_repository->objects);
-	for (source = the_repository->objects->sources; source; source = source->next) {
+	odb_prepare_alternates(odb);
+	for (struct odb_source *source = odb->sources; source; source = source->next)
 		if (check_and_freshen_source(source, oid, 1))
 			return 1;
-	}
-
 	return 0;
 }
 
-static int freshen_packed_object(const struct object_id *oid)
+static int freshen_packed_object(struct object_database *odb,
+				 const struct object_id *oid)
 {
 	struct pack_entry e;
-	if (!find_pack_entry(the_repository, oid, &e))
+	if (!find_pack_entry(odb->repo, oid, &e))
 		return 0;
 	if (e.p->is_cruft)
 		return 0;
@@ -999,7 +997,8 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 		die(_("deflateEnd on stream object failed (%d)"), ret);
 	close_loose_object(fd, tmp_file.buf);
 
-	if (freshen_packed_object(oid) || freshen_loose_object(oid)) {
+	if (freshen_packed_object(the_repository->objects, oid) ||
+	    freshen_loose_object(the_repository->objects, oid)) {
 		unlink_or_warn(tmp_file.buf);
 		goto cleanup;
 	}
@@ -1062,7 +1061,8 @@ int write_object_file_flags(const void *buf, unsigned long len,
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
-	if (freshen_packed_object(oid) || freshen_loose_object(oid))
+	if (freshen_packed_object(repo->objects, oid) ||
+	    freshen_loose_object(repo->objects, oid))
 		return 0;
 	if (write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags))
 		return -1;

-- 
2.50.1.465.gcb3da1c9e6.dirty

