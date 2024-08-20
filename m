Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0068192B7F
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162732; cv=none; b=PJYsU6uV3rnpoq0O1G8mZ+iQYmdVreqtaepkDgJsNUWzKHOYouLHmKVVopHsSU6LPoqiS4XVDRw3VwGLLS8WA5XPyQ2Jhs8ApXEWUmPcqphJ3VdaLceuSol6UCh4UI6qNeXGJh5qjPZV0uwIJ0mNOf/svkzBbtKrPGAmvHi3kPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162732; c=relaxed/simple;
	bh=DEea8iumaiIyTjdVibVHbZDBXPo2P26lnOzw+eVBliw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8baXhVcX2sfHutvgWMaMigMzvcslP/JgXtRwW2PkIbO0D/rSvamFtopnFrsqJV2KbU8QQrwBiqPNGxO8fnp9KNB6jxWA4K81aLAnw/xID5QboZXIiiif6l7UZY3FY0zqaCWr/3hgXC7bczfFpb1uWXhiCFb0qtHEVNrAQeJ6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HQC8tb0M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PFEH/H8z; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HQC8tb0M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PFEH/H8z"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6DBBB1151A9A
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162728; x=1724249128; bh=TBKopDpBE3
	gNhl9eJ/7zC7QF/PLppGWTdOdaR3zQNxY=; b=HQC8tb0MCe7f8BlUugplUIlrFg
	zmuFNg+0XFKGW9zyL3x1ZH/ZpTPFOitJJSffxKBCYVPKcfbjL4i6EKClvITj4OOy
	W06vLDxweQFpeHafdZ2hYzWL92B6qisUjhk+TRBW6h2U2qqR3IeDflnekYCKvx30
	/gO2KpsDXHZqlkVcFhXrgjJW9BNR5htkDD9B2lrdemxzDbFf4ieVuGOt/rxiB3d7
	LZeVgsLfVNsnPZRcu/j4YxTYD26MthWJwQWuyS4GupSc3cjflH2v/POGLtUhR44W
	bC2SHKeCyuA0zSAowD/VzIojguVGn0mypRk++cA/cp+W4Irk9/MUj10utjgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162728; x=1724249128; bh=TBKopDpBE3gNhl9eJ/7zC7QF/PLp
	pGWTdOdaR3zQNxY=; b=PFEH/H8zI4nZBKPdlhXtI+s+95H+FMLvu2W27SySs03L
	ZPdgGn1cHgQ3T3/GQM6iT+I0IAKPPSEwUKwO7n+NhYL84OCTI+TxFQf6WGix9q5R
	38rjtaOZy43o93P+WsYR5FpZV78Q7wpnrdUWx8BkLbQehLqlqvmPgCBF2MGdKTXL
	MPOMPA7sS+KOWF6HCwssnVEJSjjL4YA2E3IgGjmkCCA6ClmHNcAqrFnlyyAuoP5B
	Aa3rVvHPpB+BzVpWWBffZhNiRGX4GX6lC3J6IVrVGbXk/my2pCBPr3fseBBJitgJ
	rw+O7by6P1nDKc6/txEA/moi6XJdM1tLqhcqXQ4Ycg==
X-ME-Sender: <xms:p6LEZuSR-jAR9nWsFjTZhBlDi86rDjNv3h6lYT6diznGsxZH1GhgUA>
    <xme:p6LEZjwS6XfqIGbwIvG7YN87lnjcT_bwaLL-CMXsnTNSL1BF1JCypbqUCEIrjSgCu
    jUOsj8LgQCuOu1H1A>
X-ME-Received: <xmr:p6LEZr0DT0NNYZ4YJqRmgbZjRypL-QmlsD6YM5L6y1Kb_hAoNMlJeGYpU2qQjnzd4Wm6_Se9XEu6PbxVkaYU1mpweptjZOsW47HI4_VXDDq2XPgODg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qKLEZqDRH0P9VOKcDvK_K9jQi5sdb9d6TqLou2I_lsYXCN01jhdsUQ>
    <xmx:qKLEZnjFpWZll-0Kvjx1RRfNEhSEFMA25j3P4naRn8UVxLsY_KPRzg>
    <xmx:qKLEZmqAhT-_eZRnkOYsE3N2TpJ9wRs20eVbschvQ9NePvWgmxFfzA>
    <xmx:qKLEZqh6jL2Md_6594iKWq3gvKsyr-rjl1DBDBmKA2GcSNLtmTvylw>
    <xmx:qKLEZvZwwzFvDE7fXQno-pY5FPsr8bTsSdxRpd2VB0tjM0QbXy0a9jvR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ab98c092 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:04:56 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/20] builtin/repack: fix leaks when computing packs to
 repack
Message-ID: <5c820da97616466dd903f35981033a4fbf431dbc.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

When writing an MIDX in git-repack(1) we first collect all the pack
names that we want to add to it in a string list. This list is marked as
`NODUP`, which indicates that it will neither duplicate nor own strings
added to it. In `write_midx_included_packs()` we then `insert()` strings
via `xstrdup()` or `strbuf_detach()`, but the resulting strings will not
be owned by anything and thus leak.

Fix this issue by marking the list as `DUP` and using a local buffer to
compute the pack names.

This leak is hit in t5319, but plugging it is not sufficient to make the
whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 62cfa50c50f..8bb875532b4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -732,14 +732,23 @@ static void midx_included_packs(struct string_list *include,
 				struct pack_geometry *geometry)
 {
 	struct string_list_item *item;
+	struct strbuf buf = STRBUF_INIT;
+
+	for_each_string_list_item(item, &existing->kept_packs) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%s.idx", item->string);
+		string_list_insert(include, buf.buf);
+	}
+
+	for_each_string_list_item(item, names) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "pack-%s.idx", item->string);
+		string_list_insert(include, buf.buf);
+	}
 
-	for_each_string_list_item(item, &existing->kept_packs)
-		string_list_insert(include, xstrfmt("%s.idx", item->string));
-	for_each_string_list_item(item, names)
-		string_list_insert(include, xstrfmt("pack-%s.idx", item->string));
 	if (geometry->split_factor) {
-		struct strbuf buf = STRBUF_INIT;
 		uint32_t i;
+
 		for (i = geometry->split; i < geometry->pack_nr; i++) {
 			struct packed_git *p = geometry->pack[i];
 
@@ -754,17 +763,21 @@ static void midx_included_packs(struct string_list *include,
 			if (!p->pack_local)
 				continue;
 
+			strbuf_reset(&buf);
 			strbuf_addstr(&buf, pack_basename(p));
 			strbuf_strip_suffix(&buf, ".pack");
 			strbuf_addstr(&buf, ".idx");
 
-			string_list_insert(include, strbuf_detach(&buf, NULL));
+			string_list_insert(include, buf.buf);
 		}
 	} else {
 		for_each_string_list_item(item, &existing->non_kept_packs) {
 			if (pack_is_marked_for_deletion(item))
 				continue;
-			string_list_insert(include, xstrfmt("%s.idx", item->string));
+
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s.idx", item->string);
+			string_list_insert(include, buf.buf);
 		}
 	}
 
@@ -784,8 +797,13 @@ static void midx_included_packs(struct string_list *include,
 		 */
 		if (pack_is_marked_for_deletion(item))
 			continue;
-		string_list_insert(include, xstrfmt("%s.idx", item->string));
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%s.idx", item->string);
+		string_list_insert(include, buf.buf);
 	}
+
+	strbuf_release(&buf);
 }
 
 static int write_midx_included_packs(struct string_list *include,
@@ -1476,7 +1494,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		mark_packs_for_deletion(&existing, &names);
 
 	if (write_midx) {
-		struct string_list include = STRING_LIST_INIT_NODUP;
+		struct string_list include = STRING_LIST_INIT_DUP;
 		midx_included_packs(&include, &existing, &names, &geometry);
 
 		ret = write_midx_included_packs(&include, &geometry, &names,
-- 
2.46.0.164.g477ce5ccd6.dirty

