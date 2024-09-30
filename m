Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D00185B76
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687614; cv=none; b=om0K1QK5Nx1USOKy9cgNuBLpMPhVIgdhvUaxLZ/VaA4hjDEe61KC+66CZ6DwxoEaHnSOg3+x41hMCIMDjnRYsy68V9JrbTXy9fLykhhpAWzQbaSKONCDzoFdTappdAE1qCcfQOWBUU5cJe9/VtFP3EYwtVZv8qWaesX5RMMLJGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687614; c=relaxed/simple;
	bh=ioHGAxCfNZwc2w2Kk2FZRE8YlBScfUxhRBJqJ6C4/W8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsX03iS+vEglqJm4IEEtSeJWRUQ303f92743Ja3WiFDtqtDRrSG8PmXco9lUEhh9uw9GdATDZcDHUUcL+ZCZzg4FhJO8FiSwVw9q/S2xM3EDuoKX1b4JlgBZlT1jb0C2wKyY4ZfQqWFjIbxR+28oq4B5Cg+yfE4b4WLeJF3URz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bS9L+3m5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LP3hmKwP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bS9L+3m5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LP3hmKwP"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 35E0A1380459
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 30 Sep 2024 05:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687611; x=1727774011; bh=QAGQG/pVp4
	OPTpBYnfwNgwaQjCmH/Je2DlDtoTCQ/So=; b=bS9L+3m50MrWT7kQ05nwnOf78v
	eESytOvNLHVIFCT9g9CQPDKWogp8UQQqz7rLSl9rTQXkSww5G2Z84iiS1Br+2ZxW
	9oZIVfQqIyGGP4GOljkWia2ZgIDdVDPX0pYVfL6UU/wDp/lcgT+OdqYrE5nIZq14
	bfH/F8k545DfuSqJC/eO2eDUFvWeH33B81PeBVr1vh8hX+N7jpJ5OqyCWvg0b8O3
	VzMEwrRmUwhUf1p/36pIx1YU30VKW+fSAiIur9FPuzV1JejVzeNQYsDTnqXp1cYz
	gIv3bUKk5nDjd9IyVM6OTXJXSTQDfoa9m3BgHnmCMSGxMUUzW3E2fagEoKuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687611; x=1727774011; bh=QAGQG/pVp4OPTpBYnfwNgwaQjCmH
	/Je2DlDtoTCQ/So=; b=LP3hmKwPERBsMphM/o8w4GfC00BZsdGwy7nhqZeaZ3yy
	opEazU0Iuj1iNX92HssePPFEHHduxS6R+FJIVQVHgNFMZ5ZDSPEITtGnknZuTLiq
	9O6tFZ7uZOnsXe85OEFJydwpVyji0/DKDPEvDtIKf8XU+Cr5b6eYUYu4KfpdhSFF
	9sICLmLVPWSij6ksMeUTWptgbIwmOwDVPjT+aBTrdoXvmktnHAJ1Cn9SAE4wdP0u
	F4D8XBcrwAqyPNxYdut/zAOSf1fe+lIEbrmQjrvlOVgor1S6dRzYrc7+ZkyxWzip
	e+cMpMDuOaKy3DUUFngBFQuX8f/duDYoPrkSqscxNg==
X-ME-Sender: <xms:u2v6ZmDyf_9QujCFhPGcN0x8L-1oVm7qPcFKUeSQSGCncDjqLjghwg>
    <xme:u2v6ZgiPsrWWa3nl0rKrLmBpJggYTwA9pMgD_p7ruKLmKpaVBgYV2wvyFm9uh7PwZ
    EKmFqg4MsAwkfkXGA>
X-ME-Received: <xmr:u2v6ZpluSIxIkuKOn8c9z2nVhDY4P2hrVm7Wkduf9ZfN5ng_K6yLnOhcq88ohwJFihqGGofVGQ1soAWOKpvDgYnltdblNmiIG9gmK4GVhIeuwdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:u2v6Zkz5I7Zvt5Y3hCneubWV4t0FIdm7gLPNncpDgHm_FLZ-VjlCDA>
    <xmx:u2v6ZrQxn9UCFg9yWatxVKYX5Bo4-JNM-ImEentA1kdRHcHLbYCBqQ>
    <xmx:u2v6ZvZ9RmbNZd1NNZcBcvyPVvxa-jLOTpBse15dvLzFWS8s_JYsTA>
    <xmx:u2v6ZkQ3lMYq1c_1A6_J9L9DbD1IojJQl-Vigl2KaAribc_psjiZ_Q>
    <xmx:u2v6ZiJizCkH4Z_a-uxhhrziB2H2_WbORoCuzBh9rWBPCfGowpf_qdzf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3f14d376 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:12:44 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/23] submodule: fix leaking submodule entry list
Message-ID: <7781d7644e9f76a6638cabc0412d583ad703905d.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

The submodule entry list returned by `submodules_of_tree()` is never
completely free'd by its only caller. Introduce a new function that
free's the list for us and call it.

While at it, also fix the leaking `branch_point` string.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c                    |  8 ++++++--
 submodule-config.c          | 15 ++++++++++++++-
 submodule-config.h          |  3 +++
 t/t3207-branch-submodule.sh |  1 +
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index 08fa4094d2..44977ad0aa 100644
--- a/branch.c
+++ b/branch.c
@@ -738,6 +738,7 @@ static int submodule_create_branch(struct repository *r,
 
 	strbuf_release(&child_err);
 	strbuf_release(&out_buf);
+	free(out_prefix);
 	return ret;
 }
 
@@ -794,7 +795,7 @@ void create_branches_recursively(struct repository *r, const char *name,
 	create_branch(r, name, start_committish, force, 0, reflog, quiet,
 		      BRANCH_TRACK_NEVER, dry_run);
 	if (dry_run)
-		return;
+		goto out;
 	/*
 	 * NEEDSWORK If tracking was set up in the superproject but not the
 	 * submodule, users might expect "git branch --recurse-submodules" to
@@ -815,8 +816,11 @@ void create_branches_recursively(struct repository *r, const char *name,
 			die(_("submodule '%s': cannot create branch '%s'"),
 			    submodule_entry_list.entries[i].submodule->name,
 			    name);
-		repo_clear(submodule_entry_list.entries[i].repo);
 	}
+
+out:
+	submodule_entry_list_release(&submodule_entry_list);
+	free(branch_point);
 }
 
 void remove_merge_branch_state(struct repository *r)
diff --git a/submodule-config.c b/submodule-config.c
index 471637a725..9c8c37b259 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -901,8 +901,9 @@ static void traverse_tree_submodules(struct repository *r,
 	struct submodule_tree_entry *st_entry;
 	struct name_entry name_entry;
 	char *tree_path = NULL;
+	char *tree_buf;
 
-	fill_tree_descriptor(r, &tree, treeish_name);
+	tree_buf = fill_tree_descriptor(r, &tree, treeish_name);
 	while (tree_entry(&tree, &name_entry)) {
 		if (prefix)
 			tree_path =
@@ -930,6 +931,8 @@ static void traverse_tree_submodules(struct repository *r,
 						 &name_entry.oid, out);
 		free(tree_path);
 	}
+
+	free(tree_buf);
 }
 
 void submodules_of_tree(struct repository *r,
@@ -943,6 +946,16 @@ void submodules_of_tree(struct repository *r,
 	traverse_tree_submodules(r, treeish_name, NULL, treeish_name, out);
 }
 
+void submodule_entry_list_release(struct submodule_entry_list *list)
+{
+	for (size_t i = 0; i < list->entry_nr; i++) {
+		free(list->entries[i].name_entry);
+		repo_clear(list->entries[i].repo);
+		free(list->entries[i].repo);
+	}
+	free(list->entries);
+}
+
 void submodule_free(struct repository *r)
 {
 	if (r->submodule_cache)
diff --git a/submodule-config.h b/submodule-config.h
index b6133af71b..f55d4e3b61 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -136,4 +136,7 @@ struct submodule_entry_list {
 void submodules_of_tree(struct repository *r,
 			const struct object_id *treeish_name,
 			struct submodule_entry_list *ret);
+
+void submodule_entry_list_release(struct submodule_entry_list *list);
+
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
index fe72b24716..904eea7df5 100755
--- a/t/t3207-branch-submodule.sh
+++ b/t/t3207-branch-submodule.sh
@@ -5,6 +5,7 @@ test_description='git branch submodule tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
-- 
2.46.2.852.g229c0bf0e5.dirty

