Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515318991F
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541491; cv=none; b=OvUbZh/ATnPLljRh7BAYePXmTgKYVlm0U2LIf741bVIijW/H6Tdb28vuTXUFzzwGgmd5IUGTOgNLDb0GbpQG+gRrgf6huv5Q6UElT0IInPZPm7ZIp0YeGFs0ZzYZxNla2HBIPOPEpjetDkJGnfB/q++iuoBSnYG+/zu6fe3VUHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541491; c=relaxed/simple;
	bh=CaOKLE2CK9G7u392qJvsw2Dbm3caVNaWCGfMUY2S+3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oc4N+C1YTqZSYq1xZcgvZeckjk8LUGuV0TVMUU7JC5ex+MJYj0JnPBkWnjbgiti3ulkIMQ9L+gUh63sGf2qdT6Ji2SSbIwBCqwJDPCA3TfypMMI3Z04DaZytQBjsxBec671t/JPxLRyg63YzHBlTizBap9XZ5ctjkqAMSry06BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HOAiMaq1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QFlEf6BL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HOAiMaq1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QFlEf6BL"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B251F1151A09;
	Tue, 13 Aug 2024 05:31:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 05:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541488; x=1723627888; bh=7Brhjh8WAs
	xHHK5TQO3EKm2eiNXT7xyJHDErGuFzrck=; b=HOAiMaq12EM3HG78LuR2/inkaH
	YHdhN5l3frx5oLXhRVh7uU8wE++KYfJXcAzH1cKosUG+26fPHvJtDcR4zyOzUYqQ
	1tYJ98SjQTGSz6y5Wk8zKQ7s6iKYHA5eRRk6VnFSDcbCCazjboaYE9eWKSqvYosG
	fNuq+Qm5pQkbvIscqui8e96JhGxZiFpgIezs0DmuPgU5uoNbmV1/Gma6IJOkWrDN
	L+EpFUd2n9P+anTapI96kONc84NGvvMl97o195dH0qAi4TvjsXUcVB1BnvFyitFG
	NXd1lpSNyWEV0SkJ+Coz1Sv6SuC88VZA7v+So6dTVN2ulRnz9OOgYPYd95FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541488; x=1723627888; bh=7Brhjh8WAsxHHK5TQO3EKm2eiNXT
	7xyJHDErGuFzrck=; b=QFlEf6BL2gVRpq4Pn/KqWVmVKFjCWFsyexZq0m5SztbJ
	mdVylYLWXODr1MzeR6Bg2DdMZnkzlz/NKnJS1scUjjlEePWI7G9UEQh1nd/DenW1
	fM+nDDaFRE0OSBu4FNLa45x/VDodbJ0VN4MplriTb4PMDP8o0FLbvYpGmOpVihlG
	dftg1nq5HMu5GycevFtQbqglkI5A22VMzM5GBGyQac3mwBaPuikUQCli7B1ZJSSR
	AVPYwPDvMoP78eYUr8aVJWCpBPOTTUbpKyAjI8TPieARJhtC7NbCSFJvykhRtxGw
	ZilcAdNmLcihB49gXPMhF3x91CQ2NPTNycN3dqXuTA==
X-ME-Sender: <xms:8Ce7ZsaFl4zppRPzRMqe964jbQ6TSn8JifW8HNfFp4zUwKU7MhsiqA>
    <xme:8Ce7Znb1MU1-qQA4-4WO2o6RyVJYv9hgiWwpPGaP1JWLdl6Y4OnM-apk923-VVHFy
    8xy7oWvWLklRrmYlA>
X-ME-Received: <xmr:8Ce7Zm_f9VSXJ-xzwu1dlLpf9U7yvmIL90boyUoIwVTZH659pC72PmdWVJ9aD1BSeujDlTbo9Uiv_j3auF89Ym93zuiz7Y3hjUk01KWIZaTwjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhu
    rdhiohdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8Ce7ZmpIpZTVrO_4ZQ_COclxkJESsRdGDTL0sp_Gg3_i-vl6ccwuLg>
    <xmx:8Ce7ZnrVarPBWeZ2y3eqF1dH70YI6kJJW97Pq1KNN8_H_uupY8-VRA>
    <xmx:8Ce7ZkQdp3nj_ZjXXjAX80AGznIF_idFOSgKSEP3sG5AhDGRNJVZ7Q>
    <xmx:8Ce7ZnofwFXnpUoirWhx0LJwUhkcsH8f_9oCjLQ_g3Jp5GgxouzHGg>
    <xmx:8Ce7ZofoqWpNITtNzHh2DxEZT61bPr5QF7_xdMXC-U16n-P-37sejgNb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id db9c568d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:10 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 07/22] submodule-config: fix leaking name entry when
 traversing submodules
Message-ID: <b7a7f88c7d8abe6f0460df20d37001ec26b6d8e9.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

We traverse through submodules in the tree via `tree_entry()`, passing
to it a `struct name_entry` that it is supposed to populate with the
tree entry's contents. We unnecessarily allocate this variable instead
of passing a variable that is allocated on the stack, and the ultimately
don't even free that variable. This is unnecessary and leaks memory.

Convert the variable to instead be allocated on the stack to plug the
memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule-config.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 9b0bb0b9f4..c8f2bb2bdd 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -899,27 +899,25 @@ static void traverse_tree_submodules(struct repository *r,
 {
 	struct tree_desc tree;
 	struct submodule_tree_entry *st_entry;
-	struct name_entry *name_entry;
+	struct name_entry name_entry;
 	char *tree_path = NULL;
 
-	name_entry = xmalloc(sizeof(*name_entry));
-
 	fill_tree_descriptor(r, &tree, treeish_name);
-	while (tree_entry(&tree, name_entry)) {
+	while (tree_entry(&tree, &name_entry)) {
 		if (prefix)
 			tree_path =
-				mkpathdup("%s/%s", prefix, name_entry->path);
+				mkpathdup("%s/%s", prefix, name_entry.path);
 		else
-			tree_path = xstrdup(name_entry->path);
+			tree_path = xstrdup(name_entry.path);
 
-		if (S_ISGITLINK(name_entry->mode) &&
+		if (S_ISGITLINK(name_entry.mode) &&
 		    is_tree_submodule_active(r, root_tree, tree_path)) {
 			ALLOC_GROW(out->entries, out->entry_nr + 1,
 				   out->entry_alloc);
 			st_entry = &out->entries[out->entry_nr++];
 
 			st_entry->name_entry = xmalloc(sizeof(*st_entry->name_entry));
-			*st_entry->name_entry = *name_entry;
+			*st_entry->name_entry = name_entry;
 			st_entry->submodule =
 				submodule_from_path(r, root_tree, tree_path);
 			st_entry->repo = xmalloc(sizeof(*st_entry->repo));
@@ -927,9 +925,9 @@ static void traverse_tree_submodules(struct repository *r,
 						root_tree))
 				FREE_AND_NULL(st_entry->repo);
 
-		} else if (S_ISDIR(name_entry->mode))
+		} else if (S_ISDIR(name_entry.mode))
 			traverse_tree_submodules(r, root_tree, tree_path,
-						 &name_entry->oid, out);
+						 &name_entry.oid, out);
 		free(tree_path);
 	}
 }
-- 
2.46.0.46.g406f326d27.dirty

