Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717DA7080E
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779797; cv=none; b=eklyHyTA5T4RIWqYXaL7K9F/eQHxLwOOtgzbrR/BsW5fuZHIG7jY254eRMUmIoPjkXHijVhI3zQu/MkN8G9p8gOEPdtN+zW6Kh/UhU0k3qqZv/USySYL9MO4YLxCPS2F6kEQA1UMITo9Pgp3mFJuEDKbIeLab217zb0vrfq0juw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779797; c=relaxed/simple;
	bh=OR5sMpCCi9plRiYKpB3JAlVwujN6nFUPHr9MsJhxtSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lEFVBJCaBeQ4wRmU2L+f4i0LI4viOiCN/huWSPiTHvfVYzkgeAxi6m2tCrdiC9PSLGX15ztZ9/9CGchrpvMGWNK/cAromwQ88rMZJ2Wc5+uqYtGeseHau81PaFhoj5bd8umPNpmiHsF73rkRH1IspYgDDfN8HkrR/iYaGfz9IWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qGGz2w9w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XaUMZOJr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qGGz2w9w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XaUMZOJr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BC1FCEC0561;
	Fri, 30 Jan 2026 08:29:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 30 Jan 2026 08:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769779795;
	 x=1769866195; bh=/dumAxFzqTThxQPxDCNMH5SkZKbEEK/y9iBfa+K50GA=; b=
	qGGz2w9w2CdzBmMWGoc/tnY/kLTg6F7uaWyS7dBkxRNwcWTbgM9BVGO7Y3aQ4xeT
	goa5hBRoMXDUmJcgqa9NxS7HroxxiURcLl/kuiCcPn+lcN8r/pdk0Wy8/pS1AU6a
	kSjd+8i/eqhh6n09O9x/y+dCQiFkYX4m4M6TuEDyt4r+Lg40vxfMx6hQ3kOtOzB7
	aEo1xEo5Qd4WZvyc5VLHr8a2I+26HliF5G/D7p3DCAszhEzPOm4tHHwvAj3dmeeV
	E2g4HUBMxz5ZJ+kLR86BvzxsRAQ8ZRHOrAGGnvpfhacuJOOofFOTalAdtmGyggD2
	tnmZD4ytODD3gy1wbMzeQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769779795; x=
	1769866195; bh=/dumAxFzqTThxQPxDCNMH5SkZKbEEK/y9iBfa+K50GA=; b=X
	aUMZOJrK49dwhsb4LdeeGCz7kOCqjFjfviymY7YsH9+023gFX7H+jPlRuCWFmHQg
	J+AjssCsK+27kCXDlvUTi0uMOixOOPPVLiqUJCaMgzCzORALXcZFqQElTyCprOAi
	zsEfOa4UGKU+pdn0FXdfRVohicmprvhWApwUNFZJ4ST26SFR901ZACpQT0UvRGtf
	OcjwIX2ATdmP0msukoERcsoRWMuf7KMtG4y7yOO+HawcqyRzYPBrEDmDrFRykJ5x
	rvRnta91peEzSGRw80/0dG4suz+ZLfDSl8Cw3EiaM/sO4MxHckHvGl9NvdUUn/r0
	BT6CHbJvhfeXknDKCRG5Q==
X-ME-Sender: <xms:U7J8aWBXeX1HsmSA5wgDmgc4nFIMIMk9T6RT5u-eNK_-19FKZMwW_A>
    <xme:U7J8aX9rfO9sPlOESvvELOvWADVcFXJ5y_ENI8NdzcI6xtrkh_KRdXQWxb1w4X16P
    Tf_f5NBzhcQr06MH-TOOg9vdUiD1HAzQqy8ykFSoq6TGOVSiMlBklI>
X-ME-Received: <xmr:U7J8aW_nHzAkF_31ShgyFbaLOY7Hy4ZkAbOB8o7tLFbSErLnFXONJn4WaAaYEH8sUUs7C1qxndALA9wAHjwwqYaaLw1KqcccAAPJGMu5wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeludeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:U7J8aefHoayb8hX_OrZWrJw8vGRJhJQynRrBO6gZbR6KPE6PueFsEg>
    <xmx:U7J8afEi0d_GWA6tpJKKomFLpjeBPuNCPsjitO7v6FDTyiLpBNMCfg>
    <xmx:U7J8acfnLXDnyCmAToimiMVCv7eg10AZWTJQ2m2Sktk2bYrCupvq8w>
    <xmx:U7J8aZGDD630nNSZdvcajOExAtoYaAIel4IYGABGMl2UtpO34R9zzg>
    <xmx:U7J8abajvm59zbirW6flNgSzHGQ-Ba4CUXk6L0-imMiB2Verbcp9OELQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 08:29:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b07f5c03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Jan 2026 13:29:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 Jan 2026 14:27:45 +0100
Subject: [PATCH v2 4/4] bisect: simplify string_list memory handling
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-4-0449b198a681@pks.im>
References: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im>
In-Reply-To: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

From: Jeff King <peff@peff.net>

We declare the refs_for_removal string_list as NODUP, forcing us to
manually allocate strings we insert. And then when it comes time to
clean up, we set strdup_strings so that string_list_clear() will free
them for us.

This is a confusing pattern, and can be done much more simply by just
declaring the list with the DUP initializer in the first place.

It was written this way originally because one of the callsites
generated the item using xstrfmt(). But that spot switched to a plain
xstrdup() in the preceding commit. That means we can now just let the
string_list code handle allocation itself.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4f0d1a1853..268f5e36f8 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1180,8 +1180,7 @@ int estimate_bisect_steps(int all)
 static int mark_for_removal(const struct reference *ref, void *cb_data)
 {
 	struct string_list *refs = cb_data;
-	char *bisect_ref = xstrdup(ref->name);
-	string_list_append(refs, bisect_ref);
+	string_list_append(refs, ref->name);
 	return 0;
 }
 
@@ -1190,16 +1189,15 @@ int bisect_clean_state(void)
 	int result = 0;
 
 	/* There may be some refs packed during bisection */
-	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
+	struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
 	refs_for_each_fullref_in(get_main_ref_store(the_repository),
 				 "refs/bisect/", NULL, mark_for_removal,
 				 &refs_for_removal);
-	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
-	string_list_append(&refs_for_removal, xstrdup("BISECT_EXPECTED_REV"));
+	string_list_append(&refs_for_removal, "BISECT_HEAD");
+	string_list_append(&refs_for_removal, "BISECT_EXPECTED_REV");
 	result = refs_delete_refs(get_main_ref_store(the_repository),
 				  "bisect: remove", &refs_for_removal,
 				  REF_NO_DEREF);
-	refs_for_removal.strdup_strings = 1;
 	string_list_clear(&refs_for_removal, 0);
 	unlink_or_warn(git_path_bisect_ancestors_ok());
 	unlink_or_warn(git_path_bisect_log());

-- 
2.53.0.rc2.206.g60c1bca835.dirty

