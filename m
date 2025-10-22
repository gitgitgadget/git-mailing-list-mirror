Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950662EFDB5
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115288; cv=none; b=kx79d9/e03KllQd65QiDHfB5pSWwY7nPN2s2QiVAaSJbnQ/AWb3uHGxWQxuZ3Qwlc+zigJM1B3OlZv3hia+lmpiMStQPsCnUwKF3o+60gCRKnNlpcWpD4b7Dzskm84/e5qWhIGUXR7ig60WwL6LUnCyZOeh7IBNtTwfsYFzxlFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115288; c=relaxed/simple;
	bh=Yq3Qzu5sSy4zb6Tu57T1VEuVU2HbR1swT0r1SskdzNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4qHt9GZObdn8L/Z46EpQ/6M/EySR0dZXHQY+7zQoQp8/KZnSZ5Qnh+w6JMsJ6sCVH6tT5NRvlemEZAaG8Jo7xCsyDyLZWPMf6Qs7+yq2WElbL6Pai7+KMwRTOflCHuVAsPsT6iLhgwNPnQj0TVrMIDGEO0webBK0zK7/dqgtng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C4CgsVcg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S8bKSrix; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C4CgsVcg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S8bKSrix"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 77B5E1D00172;
	Wed, 22 Oct 2025 02:41:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 22 Oct 2025 02:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761115285;
	 x=1761201685; bh=5Wkpv6XKnEaAPMkW9DSfJum0jGxhsc0SNwdpeisAbP0=; b=
	C4CgsVcgIjtYSk3TpTjqSYhLmmM1XM34a4DI3LdR7Q5BNWHLR6hG6QMjYL9oiJ+C
	SBQoiZspGB4LB2SXYOwbvBD2b10HfZocZ6pHOyHzAWrZBtX0Rkl6RYccWoxFC0lA
	fqxVe8mF02D8aEi5YODpCbnNVoyC0YOUSg4vyO+I1BKX2n0W9vo/yTcVqVzb3NPB
	ngD9gyfPKqodNj7aMGHCvdUKTZYeJWybBV2pCq0rKJTi0TBXsNtqpg73Z/QeIUYr
	V5K6buAbkUMU+o0M3+2QaKCIegunSv3fkjozBLrNnYt/XUzy6qBOGrh/8ewLPkP1
	ynml9KagdOdGx1CNMclbFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761115285; x=
	1761201685; bh=5Wkpv6XKnEaAPMkW9DSfJum0jGxhsc0SNwdpeisAbP0=; b=S
	8bKSrixtblcgTe1lI91AU+TzHrYToQlzf5b5Xn3OlNGpFYyWhUqGVjPnlN6WBXny
	f1RIl3xkKbjFae2gq77Bymc8Wu157t8n6s6nnPcoWa6xO3Cv9eWRpZmfiQ7eEvdl
	HEm8QxryaIACu/IxDnqJH0hpk9PjW8HxZ15YQuGnVQAXrbCJOgVw0jqXK9dWj9Kz
	kRWgJgHb7EYBx468EkpyaFPLsKrL0i8sYI0lP8puJkPYThFEVlcl1aXzeqExM8FH
	amFJyi/vWM9e2ls84767BOygZ3NiSIxZLUFf2fhxP7mDCVCPfRQ0TwDXKxIAnhEb
	xlhhk1lwyzJau6gYgWYXg==
X-ME-Sender: <xms:lXz4aJ8VHkjufuw4xRF3iqop-qrwkhqI-fuOVTGA68JCrhDOBSwHHg>
    <xme:lXz4aBZQQYQkchmzzDKeOQpBJVkkdDdAre5KfvMM4n8r5bObMLlCKAm2P0pv4T5e9
    JFDlxer2ZHESUswG8KGDBlcEIfngfsxA_Sm9SwC9uHTLsICENrwrQ>
X-ME-Received: <xmr:lXz4aA04zi5HglB_ICB9yXrNNzSEbkn8bUOoU91nS-yJ-NRS7y8YLQGZeuuRRGs1lI7tlCHVAo2s3UhV2ti3-KOP0I8EjFcI5DWEXijohiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtth
    hopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:lXz4aEb7EgpEE-cobotmEEu-ZQ4NW-pplwdiP0dIw4tnd69BfRAFlw>
    <xmx:lXz4aAKw0xbTqqdohqgM-D99NUD41g5X5pxFD6fT6M4WZXOYNMnvYQ>
    <xmx:lXz4aLHbS3We6SIYIjgKptQpmJAPWrde9GCawrDgRfglJ7qMNXFaJQ>
    <xmx:lXz4aPsG4ivPiVT_g-6bbt-CytOVeK1XJfQRglDFjizmJa2nHVCbxw>
    <xmx:lXz4aN42qowndCkqCzCmxZnI_Q1ChrRcSnDG5b21SCpEdbS3OyktgDgW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 02:41:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 437e5d0c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 22 Oct 2025 06:41:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Oct 2025 08:41:06 +0200
Subject: [PATCH v3 06/14] upload-pack: convert to use
 `reference_get_peeled_oid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-6-eb9f71985ef0@pks.im>
References: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
In-Reply-To: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The `write_v0_ref()` callback is invoked from two callsites:

  - Once via `send_ref()` which is a callback passed to
    `for_each_namespaced_ref_1()` and `refs_head_ref_namespaced()`.

  - Once manually to announce capabilities.

When sending references to the client we also send the peeled value of
tags. As we don't have a `struct reference` available in the second
case, we cannot easily peel by calling `reference_get_peeled_oid()`, but
we instead have to depend on on global state via `peel_iterated_oid()`.

We do have a reference available though in the first case, it's only the
second case that keeps us from using `reference_get_peeled_oid()`. But
that second case only announces capabilities anyway, so we're not really
handling a reference at all here.

Adapt that case to construct a reference manually and pass that to
`write_v0_ref()`. Start to use `reference_get_peeled_oid()` now that we
always have a `struct reference` available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 upload-pack.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0d563ae74e9..2d2b70cbf2d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1249,15 +1249,15 @@ static void format_session_id(struct strbuf *buf, struct upload_pack_data *d) {
 }
 
 static void write_v0_ref(struct upload_pack_data *data,
-			const char *refname, const char *refname_nons,
-			const struct object_id *oid)
+			 const struct reference *ref,
+			 const char *refname_nons)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
 		" deepen-relative no-progress include-tag multi_ack_detailed";
 	struct object_id peeled;
 
-	if (mark_our_ref(refname_nons, refname, oid, &data->hidden_refs))
+	if (mark_our_ref(refname_nons, ref->name, ref->oid, &data->hidden_refs))
 		return;
 
 	if (capabilities) {
@@ -1267,7 +1267,7 @@ static void write_v0_ref(struct upload_pack_data *data,
 		format_symref_info(&symref_info, &data->symref);
 		format_session_id(&session_id, data);
 		packet_fwrite_fmt(stdout, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
-			     oid_to_hex(oid), refname_nons,
+			     oid_to_hex(ref->oid), refname_nons,
 			     0, capabilities,
 			     (data->allow_uor & ALLOW_TIP_SHA1) ?
 				     " allow-tip-sha1-in-want" : "",
@@ -1283,17 +1283,17 @@ static void write_v0_ref(struct upload_pack_data *data,
 		strbuf_release(&session_id);
 		data->sent_capabilities = 1;
 	} else {
-		packet_fwrite_fmt(stdout, "%s %s\n", oid_to_hex(oid), refname_nons);
+		packet_fwrite_fmt(stdout, "%s %s\n", oid_to_hex(ref->oid), refname_nons);
 	}
 	capabilities = NULL;
-	if (!peel_iterated_oid(the_repository, oid, &peeled))
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled))
 		packet_fwrite_fmt(stdout, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
 	return;
 }
 
 static int send_ref(const struct reference *ref, void *cb_data)
 {
-	write_v0_ref(cb_data, ref->name, strip_namespace(ref->name), ref->oid);
+	write_v0_ref(cb_data, ref, strip_namespace(ref->name));
 	return 0;
 }
 
@@ -1442,8 +1442,12 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 					 send_ref, &data);
 		for_each_namespaced_ref_1(send_ref, &data);
 		if (!data.sent_capabilities) {
-			const char *refname = "capabilities^{}";
-			write_v0_ref(&data, refname, refname, null_oid(the_hash_algo));
+			struct reference ref = {
+				.name = "capabilities^{}",
+				.oid = null_oid(the_hash_algo),
+			};
+
+			write_v0_ref(&data, &ref, ref.name);
 		}
 		/*
 		 * fflush stdout before calling advertise_shallow_grafts because send_ref

-- 
2.51.1.851.g4ebd6896fd.dirty

