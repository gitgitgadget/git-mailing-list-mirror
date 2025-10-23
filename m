Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CB82D6E6D
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203798; cv=none; b=QTrVUvbBZWDylSGh2OABXZy2IucLmKzLo9VKq8BLATnobe4K34pgpX/d1fVK5BcDbWUYWT923Bq+yRMOzowV2AUwROQwYQMEo8iKkyixZe2wfU8m/G4N7r53m+m8WJmEzMlZbZhhMSLr5EzxtXq/eHIUfCgqHKej9ZmTlogTHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203798; c=relaxed/simple;
	bh=PLf76s9XjzkiWuHWRBNIMHsb2GxxrqQmzej5uet3iwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CXYZrtkM8MhBfUwUUIJmANsV58gGPacMbQbjyE1lqMEbHUSaXrTH0hAL62DM4ComIVDXNqlYODHb5fClUhceu6JCmG52vt4cx7lyDWY4A6uQWKyGaOmy6YSVhP8+WoU41oI6gCyV/y+mLt8t/yzF8WTGBNbfEb+8Sxa/nwteoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ORaEB0lj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j178ZQ6i; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ORaEB0lj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j178ZQ6i"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1431EEC0129;
	Thu, 23 Oct 2025 03:16:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 23 Oct 2025 03:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203796;
	 x=1761290196; bh=yxY2hn3QSYLdKZHUevxer210butxQ3QlPZb6hoVZJDA=; b=
	ORaEB0ljYXDQes6EHhrfjZFAvakEtaAv4XmyqsKC1qOjthCsU5bMn0xtT3I23wYx
	rgyeKV72iTCasWiqRcKRIlM/Hrz1JdSjHSalh2613FlDU3kCKws4+FsGRm1FMfBN
	lbwSL2Eb1CuNXB6jtDgUrxM51I6dS6D/5/iOR4IuXTw3IsbgcPUjNNjI6dmyuv19
	YnctHkvt8RtaIkeqy2VnNHR9tz1vBLcyp33TxGpphPuhTJbgNnkIcsadLXFJHN80
	tdWEFHm863MV7D0N85FtQhtIVkepnc5/AKTgKKCshgNi1ev5nV1WSqDNZBnskWXv
	STCebpUYyH8Kxcghdp0adw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203796; x=
	1761290196; bh=yxY2hn3QSYLdKZHUevxer210butxQ3QlPZb6hoVZJDA=; b=j
	178ZQ6i4U6nkS3UKSesf9YepS3HDiCotVD+vcUT0W9PDkTOOLHvnGHCltPOKxDBA
	UxkqBH5iCYCebuWm+ivJGOz92cvpxL/6mg8W8QYmJ2xMxMSZF/l5wPnwZE1ywler
	ARh4WwoCqtbq2YOY+UaEuiuNux/1lmIEkDZ4QId82bkqy0uo/P6GqcqaLloLpvPl
	IEJGNhaT4AsxX4v1FwOdUrllWpOGyNnaWamdcWQIBWI+T7MaDg+tUv7JJFSJPF0f
	JP05VWAwKOP0SDc8f4VLJK1Su//vFZQeYDm7lfw/JST/1AebJNy+Xb07+Ztf+02P
	ao+Mnw6Hp3tuWI65EBWMg==
X-ME-Sender: <xms:U9b5aKqGUo0Ia7wM8kw0F8f9hb9bqoiwXCw51SFmDyywfxeCT6KTtw>
    <xme:U9b5aMVTSdkfuQ_MCOGc3TIuvpkOMJ2AiVjUrcDXwAAiIAL-VToZdSLPAbaojz0Kk
    utACg9EGI_iShK-Ak2m30Oy5kiZ4I5KCwexdNeLOVGrDZgz92RfAg>
X-ME-Received: <xmr:U9b5aJAD273HNMey5E_7W2UqaPuN_nmtJj-PZ2JFYlioVNLHECsHW5l7luJC7Jb8K2VmcI9ZcqjQnb4dhAe18HCS1p2b_Rha9LdK0ODsiuuJmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:U9b5aA1UIaikxz0hGECeqIW6xGulyYaj-u3wj112fKweCLbhTESziA>
    <xmx:U9b5aL1GJrBVV3kc2R77U2yQkrZp7G9nX6iOgNvWn03Ojr06qnPBjQ>
    <xmx:U9b5aFALRg-9t06J6Kl11Ohp1WqDzEmxELVD3BAkyl_k-pk7e27CEQ>
    <xmx:U9b5aK4nxUp_7fNbLCjogJWpVocR1yhm2AMAiXSBe3pVIkPJ9AuoZg>
    <xmx:VNb5aDkjcFg4em4H5fR73OUYXsxWCDp6BH_PGfST1-2I-9LDcujvsR8x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 06e47525 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:16:15 +0200
Subject: [PATCH v4 06/14] upload-pack: convert to use
 `reference_get_peeled_oid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-6-2be68ce82c9a@pks.im>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
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
2.51.1.930.gacf6e81ea2.dirty

