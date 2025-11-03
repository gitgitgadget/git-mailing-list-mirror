Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802C72C1587
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155747; cv=none; b=rp6KhosyeE+WJKpfjdtdWXfxBw5x8tP5FK5EVrZTNT7Fx/0lYGxzUbwS1urbidX62YWLam8pA51zw0/di783YVDFAM9bLwWqOR1In1N64sXlpHHE2lsAWz9BjI8K9GZqgnsV1pUJEALk9+gv2MVZC2vacIEsNDRLLwhBe/pSfXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155747; c=relaxed/simple;
	bh=rlIqQ3rMnUEjfz9ieEyEgpSBK1JQ1dYJnFU+b5a1VLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mX35fXLVy3oEh4fS3+JuOehNWMEh3G/RJ3PLjUwlAgfkUL+PPfy1tAjaI4RQzR85ceC8CrBOCeTNHC6XKdeEqdl4mZnwXeGtI4r5IfQyoKYGxCwmoHILClBuMFEH5n/k8JCTaaQGe7LZHSUSP3FzFdysuwQuEtHCTAF+boOpLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OeofwdIr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bYw2d5Ps; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OeofwdIr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bYw2d5Ps"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D68A17A009B;
	Mon,  3 Nov 2025 02:42:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 03 Nov 2025 02:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762155744;
	 x=1762242144; bh=d1jOgPuJDjUxwyQ4OAdh/7HVhyeMLBPkqyfXpEmErj4=; b=
	OeofwdIrap0ml8nB7+ysqJjJMHCZAliFDD7aOoFmhUSNsQULXgvWxkJ1fVMxYx0q
	5poDHR29Mi0LIBmSX2bBh1XuBXK6L5+E/kYRTD3mWnP++6TVm4UoUK5SWlzHomBe
	65k+TBymxmrOPp0ttedRyY1KtSPXcTXDaXM12o54q+BLwm5VMonNVI4sQe93gMPA
	1K2lPUYSeX+/BKKPIUjq9liQehRTDOHyzbFQRUbDNk9mJAH7V1AgYYqDBpGJHfMv
	rnluWVPI58WmO++0UQXmoMmp0fc0icgVPZcTiKi0LBhshNnVlDKLC3f/wI7AzY6K
	TnFzhfm9SPa5D4JkNQPwyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762155744; x=
	1762242144; bh=d1jOgPuJDjUxwyQ4OAdh/7HVhyeMLBPkqyfXpEmErj4=; b=b
	Yw2d5Ps2NU3Xp5IOIcgN/ruMyrYSyJ3c857b8jOJsQjZ2j18fs/Ynl3q0XHYFCVF
	Jt3qszMflSiIyz8puqfMvPU3iSZ3pE5/cwMAAZ9nEEoAet39kemBl565Vd/Hd2Kz
	aZPPNwDVCzEGXro8dC7l9KRwDHdF5yOCjNTX/CRMZtSr1wr9iYxLPh/phP/915EH
	xyJyrwYtjdPB+yahyRg7PiXEptJaJFDSTAnItTIfOSRj7m1nL1xarHOZpnKQToHP
	Gn/J4gwJr61b9gfzS1sDyHcmVmuMB2SbIwWHjn1Jjcb9YVBFSG81NUPluzCaaVwL
	kOJkfu08EQP0j4lpyWmsg==
X-ME-Sender: <xms:4FwIaRF-oPTwYkNQ5PSf0FSCpTMourBNTRV0Rkty8cKQwymEAJcevQ>
    <xme:4FwIadzqFgGWiSMqD40nELX8EVTpWo2zRJ3VbgTUUz2GNA0Z5cvgguyx3Rsu5DTsi
    vgbgZKsgV4-5GbA7JOQ1sCmYouMY0DrD3a5x0-rVQVSu7BCwmvr>
X-ME-Received: <xmr:4FwIaQiwEY2XSaJ146ioUdiPMjGWDZyFcCtX55jTq_BncmYzYunl1OwzWHxTkBP0cy9Wyth3e1Uq_AxB7zK1Gm67x_i7_5ukoiBy_7GJ7hzj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:4FwIaQyn2RSEUWoh97Ug3vg0hGC2GT8wTAq5oI-ZJOm6R4TPiZi5BQ>
    <xmx:4FwIabJjMj7cFtNaLdFG_p-MlMQjtSjazPA48F8kKTm3yo2S97sYow>
    <xmx:4FwIafTfrw-5p-uzhbi4jj-eSgO2Ry6s8jgDAHoj3StyzcNm4_O_bQ>
    <xmx:4FwIabqc2is_mDS719vWdj75aiiyOXBW4cNIDJwJwtaKjH1BEUPlZw>
    <xmx:4FwIaRxAqJCxcic1e_Pql89CHoVS-f-O6XbJGK__zFybTWMbcF-Ilqqs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:42:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 454bcb8b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:42:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Nov 2025 08:42:00 +0100
Subject: [PATCH v3 05/13] object-file: introduce `struct odb_source_loose`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-pks-odb-loose-backend-v3-5-6a61ea977393@pks.im>
References: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
In-Reply-To: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Currently, all state that relates to loose objects is held directly by
the `struct odb_source`. Introduce a new `struct odb_source_loose` to
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
index 4675c8ed6b6..cd6aa561fa7 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1995,3 +1995,16 @@ void object_file_transaction_commit(struct odb_transaction *transaction)
 	transaction->odb->transaction = NULL;
 	free(transaction);
 }
+
+struct odb_source_loose *odb_source_loose_new(struct odb_source *source)
+{
+	struct odb_source_loose *loose;
+	CALLOC_ARRAY(loose, 1);
+	loose->source = source;
+	return loose;
+}
+
+void odb_source_loose_free(struct odb_source_loose *loose)
+{
+	free(loose);
+}
diff --git a/object-file.h b/object-file.h
index 097e9764be1..695a7e8e7c4 100644
--- a/object-file.h
+++ b/object-file.h
@@ -18,6 +18,13 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 
 struct odb_source;
 
+struct odb_source_loose {
+	struct odb_source *source;
+};
+
+struct odb_source_loose *odb_source_loose_new(struct odb_source *source);
+void odb_source_loose_free(struct odb_source_loose *loose);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
diff --git a/odb.c b/odb.c
index 77490d7fdbe..2d06ab0bb85 100644
--- a/odb.c
+++ b/odb.c
@@ -151,6 +151,7 @@ struct odb_source *odb_source_new(struct object_database *odb,
 	source->odb = odb;
 	source->local = local;
 	source->path = xstrdup(path);
+	source->loose = odb_source_loose_new(source);
 
 	return source;
 }
@@ -368,6 +369,7 @@ struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 static void odb_source_free(struct odb_source *source)
 {
 	free(source->path);
+	odb_source_loose_free(source->loose);
 	odb_clear_loose_cache(source);
 	loose_object_map_clear(&source->loose_map);
 	free(source);
diff --git a/odb.h b/odb.h
index 2346ffeca85..49b398bedae 100644
--- a/odb.h
+++ b/odb.h
@@ -48,6 +48,9 @@ struct odb_source {
 	/* Object database that owns this object source. */
 	struct object_database *odb;
 
+	/* Private state for loose objects. */
+	struct odb_source_loose *loose;
+
 	/*
 	 * Used to store the results of readdir(3) calls when we are OK
 	 * sacrificing accuracy due to races for speed. That includes

-- 
2.51.2.1041.gc1ab5b90ca.dirty

