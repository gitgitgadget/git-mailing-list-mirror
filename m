Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413F0259C83
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794989; cv=none; b=QeOZ0vQMzq6BrWXUgQ0oUsG4jH42kb3jzLEWAJpax3idFVcR8wS3oMNdOB3EvDm87RRP9U65HQ8OqdzNa6ldntXZQzjBMHUMmoS1CjIiw/PvML9vpXvbNCsORm+ABljPCcwkbqcqZXFRzUeh1ITOpwMIZm8lKnRplxHd2e+RejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794989; c=relaxed/simple;
	bh=i9zsBYfFR4LpMFSxhoX6blqilRvlU2We+avpj2EMjqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XT601PN9wvn2j52VCpXu3VjixD7gk6L+4JeypsgsyqV8Tk4ZtuI0HuuHoFK+VSpbxiKkc4IVfzH2V5SEiDpp4GIJHVafZGt4Wim+AMyGzAZx/hxlWAU5+HdjvdZFAEESz8plQdoVQYI6VOVeeAZdkORUZRayM4kWpdPMH0ym2iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jYstaYM/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EHTfvNAo; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jYstaYM/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EHTfvNAo"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C058254030A;
	Wed, 12 Mar 2025 11:56:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 12 Mar 2025 11:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741794987;
	 x=1741881387; bh=G96edxJMxXRHToB7xNoWWK9UN+aH2smKObNcv11cvyk=; b=
	jYstaYM/p03TJVC+OzOfE787+R+mtjK1eAtKZLepmQ3F18Ue/QfNh5nSdKSBz52s
	SKegaw9Fume1w4ectBtHhq4XCo6k9F44u0xNDTumRvYEFLtgaL5pzE+2SVhFjfEe
	CM3LfVT/IgvflBlJNk7Q1Mw1clr0ToIpmMQseUBfQyWOHt1feZ9sx+ardPQWl1uK
	o38kbIKz5tLMoym1xtLGb+IaO3vGWGBEwkiMz4yJ36UHVLLhWdizG1GgPbu4JlUV
	W9yq703CbqgE7TPHqlsgUBeZPMFirMYjwG1dSAIWRCzSMA3mzG+itSYBDnRRZ7bX
	1ToyWa0A+ZMyvHh/DdEt0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741794987; x=
	1741881387; bh=G96edxJMxXRHToB7xNoWWK9UN+aH2smKObNcv11cvyk=; b=E
	HTfvNAoXCqTOtiJm5fJ/u4HBK6xxq0G6b1zCdym0j/+gYZti8lvWobF6TQV3rrHP
	2a8gCpc2SNIssXXV170XKcdTML730l6OI0pF8hCHG9qVDrDVj8pDmZiAcrwNTQL5
	vSiE1bjRT2Tp5nz+HlKeOqkQIcuZh02LajdnqAc08ALWACHzx0lzs8WpcleXDbg8
	aUV66Hxctb+/nSuUO2QOxFwOPXojOJqWsWjboHcdvF/tQXP3pbrd1pmn3BdxLM1+
	x/Z0v28xbYZTRjRFjbjluSmHSdbNOWLig0olskkeD7f/t8t7tNLPxRwIs7MZSjVe
	/hcSSRzmANRPFzLtIwVhg==
X-ME-Sender: <xms:q67RZxjKE7-f_cr6Qgg9Br3MxO4ZOio1KkxtNd-jIS3X8Q7rudMYMw>
    <xme:q67RZ2C4FIl1OIJrodEk2AbYTO4i9J6KIfpHN9A4aoCC4MKsT5KggP8d_j2ZBE_dP
    ZqfjiU0Ztt9qyzWJQ>
X-ME-Received: <xmr:q67RZxEZWSuwPhPQphj8lDLWSWFm98oq0af8dkoSJach6_mB83iivuMZhGIFPCGCkC6cMF5DWgZ9qytqsIbj-eX0vBGeRce8ZvbUO_LM7GNGBmqk-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:q67RZ2ReBKCv-VuzXRzlvggCxt7xPTjJe4O30aWunmgQJ5OKDteo8g>
    <xmx:q67RZ-zMHQeY7E33LJVnBHaKM0UtglsJWTmz9_R6-luiF84JMNWDqQ>
    <xmx:q67RZ87kQuB5pMD-qAhIOmW03k388YY6QNeiA21xUSadrd6amCnQRQ>
    <xmx:q67RZzwRkpr1D-PzTDN7D6jD40yGXhQn9jfycQ50vn7-kiCK0MvJ4Q>
    <xmx:q67RZ5wanXWYWy2OgSAuB5QbG_7N-QGhwTeOnQ4CEuEht7Yf1bdgFGpc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 49bb309d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:56:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 16:56:21 +0100
Subject: [PATCH v6 15/16] refs/iterator: implement seeking for files
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pks-update-ref-optimization-v6-15-f778e0414f55@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
In-Reply-To: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking for "files" iterators. As we simply use a ref-cache
iterator under the hood the implementation is straight-forward. Note
that we do not implement seeking on reflog iterators, same as with the
"reftable" backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e97a267ad65..5f921e85eb4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -918,6 +918,14 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
+static int files_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *prefix)
+{
+	struct files_ref_iterator *iter =
+		(struct files_ref_iterator *)ref_iterator;
+	return ref_iterator_seek(iter->iter0, prefix);
+}
+
 static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -936,6 +944,7 @@ static void files_ref_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable files_ref_iterator_vtable = {
 	.advance = files_ref_iterator_advance,
+	.seek = files_ref_iterator_seek,
 	.peel = files_ref_iterator_peel,
 	.release = files_ref_iterator_release,
 };
@@ -2294,6 +2303,12 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
+static int files_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
+				      const char *prefix UNUSED)
+{
+	BUG("ref_iterator_seek() called for reflog_iterator");
+}
+
 static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
 				      struct object_id *peeled UNUSED)
 {
@@ -2309,6 +2324,7 @@ static void files_reflog_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	.advance = files_reflog_iterator_advance,
+	.seek = files_reflog_iterator_seek,
 	.peel = files_reflog_iterator_peel,
 	.release = files_reflog_iterator_release,
 };

-- 
2.49.0.rc2.394.gf6994c5077.dirty

