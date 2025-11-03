Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906F2C0F71
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155754; cv=none; b=YlM6dj4qOaEA+VYc/mtZwlNBTOb2pgwtV4YMqzq/oK1VfQKoKgpV9bDsmtwd6xC/oqtpOy4Zof3PHDlmypihOoNN5weym14fQiPUN7KTR/rviJz//fhITVIQ8qCi8qRgg+6ge6arSIjarLaJdckO0KMg9d4FPAqbEUbtB7Lb000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155754; c=relaxed/simple;
	bh=SWPowJbZHShHZj6tG06OjTYwkz+fh0Wpy6XR41ditRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TET6XzngR9a2XKH4GaaO6sT9kXOC2GymaV1VtFLMfOyBZWIudNifM/Uxm1TMGAE566QxJUxlnZ/mzVCZZlKnRmmO1zOdXC9x5HBFEtA9Hcf7O9O55MdWfC+fxAeOoMYjgbVojDqXdtXB8xojLDbuh8+Mg6ZyGJFA7W3PFXIU628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZznlrYfE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oS8ksGYa; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZznlrYfE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oS8ksGYa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D9F31D000E3;
	Mon,  3 Nov 2025 02:42:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 03 Nov 2025 02:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762155751;
	 x=1762242151; bh=/KO0dCh+NnIpea/Obd4qt1LJJjbi0JUmgEZdnfSK/Bs=; b=
	ZznlrYfEJRrTkCjgfLb+bGyvkVwRlOEELNRYhiYXwj/osyaP8z+C+kA8osSocpI8
	tke88CgeorKwRO7RcRAlQ/gT1YOuxCR2b82piWRcvI9qsRf8+KWWmF7wmjKUn0ua
	tntaor7Jzsiu7SM4DJtqr5ke1TE2p+WaBb04uYrOxutovPls6GZvfJg5idLTnh/R
	eJUYo45i/ajJ3H2bnDSZLgAp4Ggimul2Y/VJFMOtg37vzfCcLpdKdBfmdNOn9AhY
	y66jCBFgsJosm5eRODT/oDVM8FMdvnRDO9Gi2bsQixXXQy5KYTm+UvNiSgQH6apN
	i+n2w1JcMUdZ9lpQ7ZWkag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762155751; x=
	1762242151; bh=/KO0dCh+NnIpea/Obd4qt1LJJjbi0JUmgEZdnfSK/Bs=; b=o
	S8ksGYar1cXMPmlkeMMt8+mcKnXBX/RAiX3B8GArcRzvi6uKN4sMpLMbdWAb3cRE
	LX4rkH88xaJDmdVkRetmZz3+oGKv6lSDvZJ0e4hXsa0GVCY9bnWd6poxLLQBPxWt
	TGofwf+YcmQXwcep1LG7N87DOk/wPo/G+mQTWbShWAJC344p+w1v5351UV4W4H3e
	LcCkdTkRrSWo0wp6xSQvPt+stkPjSwVdPTsNCiudGFhfnDC4mgFJL8Agx2p2X4DB
	MZehmdC1d/dcIp137OsjotKBD9UmA0UKVf94y8ohYRIBcdDxlcLwpyUfJmJ7Fm9w
	pAnUYtmtFrwpAH8XK4L6g==
X-ME-Sender: <xms:51wIadLYc1Fe3L11ilG1ztw2BOauP3mlYL0g3uGGSRxTC4xLBh-KnQ>
    <xme:51wIaQn1iXL2wEKg2SOxp4sdrtgxTPwTimS2CuBZ8Zl5uVAUk1jiV588eT679Lb5u
    3ZRZd-qFP7UcAuQRrzllp2XXWa_ZszocVA_vIpl1jscc3sz9aieUw>
X-ME-Received: <xmr:51wIaTFzrZ3aw7wj9cRG_kQsiROj3Zgbetqu8elEdsx-FTI2vHqq66SBOTCx0gvedXOmpA591rzU1c5NNSLYJNE_d7ZoC1_00OS-DnnaCmfj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:51wIaYGVTpAc8DUUwy71nZiPF0CNaj6aUJksR3zm6QKuWaywK1xTCw>
    <xmx:51wIaYMJFSfx_P8l_qrLJzdIXYeAAzqrlkdKhB3ObA6PRpAlkJxDIg>
    <xmx:51wIafE_1vN-WkpH7wlpgtyPAZ81XHQLMfq2gy-gTKsc_OqkcFzw6Q>
    <xmx:51wIaXPJqq063ZchkodYWpLF3LAuDUj8ji_Mivk-7Sk-QTp2Wot8PQ>
    <xmx:51wIaYnkL4xPkX75LCUM7A7DNIGvQLqikDLU8Ua8d9iTByHIrPAnf2mv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:42:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fdb2c5f7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:42:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Nov 2025 08:42:02 +0100
Subject: [PATCH v3 07/13] object-file: hide internals when we need to
 reprepare loose sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-pks-odb-loose-backend-v3-7-6a61ea977393@pks.im>
References: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
In-Reply-To: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

There are two different situations where we have to clear the cache of
loose objects:

  - When freeing the loose object source itself to avoid memory leaks.

  - When repreparing the loose object source so that any potentially-
    stale data is getting evicted from the cache.

The former is already handled by `odb_source_loose_free()`. But the
latter case is still done manually by in `odb_reprepare()`, so we are
leaking internals into that code.

Introduce a new `odb_source_loose_reprepare()` function as an equivalent
to `packfile_store_prepare()` to hide these implementation details.
Furthermore, while at it, rename the function `odb_clear_loose_cache()`
to `odb_source_loose_clear()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 17 +++++++++++------
 object-file.h |  6 +++---
 odb.c         |  2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index fef00d6d3d..20daa629a1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1834,12 +1834,17 @@ struct oidtree *odb_source_loose_cache(struct odb_source *source,
 	return source->loose->cache;
 }
 
-void odb_clear_loose_cache(struct odb_source *source)
+static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
-	oidtree_clear(source->loose->cache);
-	FREE_AND_NULL(source->loose->cache);
-	memset(&source->loose->subdir_seen, 0,
-	       sizeof(source->loose->subdir_seen));
+	oidtree_clear(loose->cache);
+	FREE_AND_NULL(loose->cache);
+	memset(&loose->subdir_seen, 0,
+	       sizeof(loose->subdir_seen));
+}
+
+void odb_source_loose_reprepare(struct odb_source *source)
+{
+	odb_source_loose_clear_cache(source->loose);
 }
 
 static int check_stream_oid(git_zstream *stream,
@@ -2008,6 +2013,6 @@ void odb_source_loose_free(struct odb_source_loose *loose)
 {
 	if (!loose)
 		return;
-	odb_clear_loose_cache(loose->source);
+	odb_source_loose_clear_cache(loose);
 	free(loose);
 }
diff --git a/object-file.h b/object-file.h
index 90da69cf5f..bec855e8e5 100644
--- a/object-file.h
+++ b/object-file.h
@@ -37,6 +37,9 @@ struct odb_source_loose {
 struct odb_source_loose *odb_source_loose_new(struct odb_source *source);
 void odb_source_loose_free(struct odb_source_loose *loose);
 
+/* Reprepare the loose source by emptying the loose object cache. */
+void odb_source_loose_reprepare(struct odb_source *source);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -44,9 +47,6 @@ void odb_source_loose_free(struct odb_source_loose *loose);
 struct oidtree *odb_source_loose_cache(struct odb_source *source,
 				       const struct object_id *oid);
 
-/* Empty the loose object cache for the specified object directory. */
-void odb_clear_loose_cache(struct odb_source *source);
-
 /*
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified oid.
diff --git a/odb.c b/odb.c
index 87d84688c6..b3e8d4a49c 100644
--- a/odb.c
+++ b/odb.c
@@ -1071,7 +1071,7 @@ void odb_reprepare(struct object_database *o)
 	odb_prepare_alternates(o);
 
 	for (source = o->sources; source; source = source->next)
-		odb_clear_loose_cache(source);
+		odb_source_loose_reprepare(source);
 
 	o->approximate_object_count_valid = 0;
 

-- 
2.51.2.1041.gc1ab5b90ca.dirty

