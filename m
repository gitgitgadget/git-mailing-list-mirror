Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5020B2EBDFD
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891184; cv=none; b=cLDAn+2pFc9KUJ+8qSNE/5oghb8CaULmQpGgKU6Asim49GkxpARhkv4D1VzZiOqJUK/4cPRfdSbzG5IOQNeTiiKmTUApifugob5GcJjd/8l3FQS1DxDmErGtCTIwk9WJHJWYBmFNy8auKoImqXIO/Zw/TSg6O/x5UkdSWSDZMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891184; c=relaxed/simple;
	bh=6zKNpYYylidoLcuo5+I6O7FFvd88JIKYp93M6tqqYHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gG2ggmF7bmqKwjj2MIeOAvhaG7SqoDRHgYJkSYTMw9QtE8/Bo+tui3piUKiCaxyir+YCGGNjuynxOG6Iq5JDJayV2fP7+25HrOEOZgnARR36nApnj1W8ZkZyTzhVVCvJIujpANVbOulcsib2bm7RUs1sJxPRVA0FsaeK3bJ4Ph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a9x+cTxP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HXBc/11e; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a9x+cTxP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HXBc/11e"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 768B7EC0084;
	Fri, 31 Oct 2025 02:13:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 31 Oct 2025 02:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761891181;
	 x=1761977581; bh=rk3s/PSDx447yUTb9dquSjGUmMyAA6LpIiRtod/O0OY=; b=
	a9x+cTxPfej8er6b1lJv1FLlGE83HfxbvbGfhiEB6jjj4bkCG8CSw9PCRTKB64ld
	s09EIqCqAbewuIWSnLtfnsAjsNYOqkZvkjxl0+BFgxC8rQJUQrJ3okSYRFXsdR/D
	ExoZh2bVJp2y4rRQ0ejQM6MauJgh087HzQbcUxDHQZqo8rqZ3ND2zLC69zISJ1Ls
	jnREq8Sj1LPsDQAV9AYniFwBde+aPgEupX9mbSPRWDM5SSUalqn/Ejp+YZKdmAZf
	sIs9JwCAn1TocDFCj2u+UvrEsrSDAoOJgDtanNvvJ/ELtofBd5iBvloBRpQdlV9h
	2dLRttJ3bwUgyWzhVWNQjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761891181; x=
	1761977581; bh=rk3s/PSDx447yUTb9dquSjGUmMyAA6LpIiRtod/O0OY=; b=H
	XBc/11e6M81G1+Aciw60e8piZRS2A0xyvRrUr213nBHCl4dBEWMhaEVKRszq2BKA
	vlCSLRKIJ42UkCM4EwaqWkwaRF0OS8rPC4ZSTjrDX9TxdOAY9Yy1FKqLGFF1GVYC
	NyvNfymqC94wmWKthxhjBQMDEG8DseM8HU71HXwdg/qhktwfL4++h5B2TBXwCF4v
	AqwKKxKW1AE9kJltdvYxsJ7u0LJwy3ZWzFagANyebplJFUAhSJdKlFMoZJR7VDrz
	2E3/7VnIYErFFiw2ed+fencTMDKyzWg4slQ1Q2/iwPyH8xIKc4bDl83ghuBGJjVU
	OJyk+ReLqeMI+G+XdFG6w==
X-ME-Sender: <xms:bVMEaWIbbgrqcwM_qypoPEVVKfxHSPNqy7UimiHv50U_3DgVHMWnBg>
    <xme:bVMEaVmspUmfz8jQXa4huo3Fbup_37Fr2t3r_gPLgdCTu8kneZfjpwHRxftWFT5zz
    qiG1i2sD2rrwoO-JrRpXGzXazCauqmn7OvoMzJ2CH_yGscm15vXMw>
X-ME-Received: <xmr:bVMEaUFg7Hi1ViXXcZZVOOvx1sutszKwFh8OxZjGYtqSbyERtmFl5u6lWQkZPHorskAds8qS3egKMAgYvq_IEWPmj8L6zJ0dIALYikvPtf8xEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:bVMEaVHl1d32S4N7hJgMmAZS2PqQtrXRcnrtk5li1xpzeZTyXFnacg>
    <xmx:bVMEaRPlJq_XQKKIXZAZF_9NgB9OCdo1RbYdr2mNKZjc3zhWn4SFFw>
    <xmx:bVMEaUEcdDdsu7IB4c_f67k65wGVoO9RnJvtVLldDFrBIjX6rgsM1g>
    <xmx:bVMEaYN3kcXv4akz5jKfXFYiB2PrtWbZ8agJTHsMeIIlZOA4jn_q5Q>
    <xmx:bVMEadnfCw3cTXLjfF8CmOIcQatj8IGsZXnjJX5M_TZfD1vISKlo17YD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:13:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 010e76cd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:12:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Oct 2025 07:12:41 +0100
Subject: [PATCH v2 05/13] object-file: introduce `struct odb_loose_source`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-pks-odb-loose-backend-v2-5-920f721aef71@pks.im>
References: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
In-Reply-To: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Currently, all state that relates to loose objects is held directly by
the `struct odb_source`. Introduce a new `struct odb_loose_source` to
hold the state instead so that it is entirely self-contained.

This structure will eventually morph into the backend for accessing
loose objects. As such, this is part of the refactorings to introduce
pluggable object databases.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 13 +++++++++++++
 object-file.h |  7 +++++++
 odb.c         |  2 ++
 odb.h         |  3 +++
 4 files changed, 25 insertions(+)

diff --git a/object-file.c b/object-file.c
index 4675c8ed6b6..4dfea0ebebd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1995,3 +1995,16 @@ void object_file_transaction_commit(struct odb_transaction *transaction)
 	transaction->odb->transaction = NULL;
 	free(transaction);
 }
+
+struct odb_loose_source *odb_loose_source_new(struct odb_source *source)
+{
+	struct odb_loose_source *loose;
+	CALLOC_ARRAY(loose, 1);
+	loose->source = source;
+	return loose;
+}
+
+void odb_loose_source_free(struct odb_loose_source *loose)
+{
+	free(loose);
+}
diff --git a/object-file.h b/object-file.h
index 097e9764be1..d9d2de5055e 100644
--- a/object-file.h
+++ b/object-file.h
@@ -18,6 +18,13 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 
 struct odb_source;
 
+struct odb_loose_source {
+	struct odb_source *source;
+};
+
+struct odb_loose_source *odb_loose_source_new(struct odb_source *source);
+void odb_loose_source_free(struct odb_loose_source *loose);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
diff --git a/odb.c b/odb.c
index 77490d7fdbe..f1b250ceffe 100644
--- a/odb.c
+++ b/odb.c
@@ -151,6 +151,7 @@ struct odb_source *odb_source_new(struct object_database *odb,
 	source->odb = odb;
 	source->local = local;
 	source->path = xstrdup(path);
+	source->loose = odb_loose_source_new(source);
 
 	return source;
 }
@@ -368,6 +369,7 @@ struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 static void odb_source_free(struct odb_source *source)
 {
 	free(source->path);
+	odb_loose_source_free(source->loose);
 	odb_clear_loose_cache(source);
 	loose_object_map_clear(&source->loose_map);
 	free(source);
diff --git a/odb.h b/odb.h
index 2346ffeca85..f7e1bf87803 100644
--- a/odb.h
+++ b/odb.h
@@ -48,6 +48,9 @@ struct odb_source {
 	/* Object database that owns this object source. */
 	struct object_database *odb;
 
+	/* Private state for loose objects. */
+	struct odb_loose_source *loose;
+
 	/*
 	 * Used to store the results of readdir(3) calls when we are OK
 	 * sacrificing accuracy due to races for speed. That includes

-- 
2.51.2.1041.gc1ab5b90ca.dirty

