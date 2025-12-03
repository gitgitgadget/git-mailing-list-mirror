Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C402F3C07
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758954; cv=none; b=e3eX5OP85uSPoOgtjk+7QyRDhO310pfZErn12CmZGon1byA7kX2JrMDezakgXSE7I19Vxfio9VD/MKq0NbYmYuKKvDYXolxVbOpAMm1nrn2eJc7wRSgLvteSewacn6BcXdW6WSsAfm43rs+2SpU79ee/hPE1kWwB2xG0mR7NXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758954; c=relaxed/simple;
	bh=804KjUC7jAiNh/mp69GXsPEZmoULddR/j64txsejSPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q6dl+0T6nYWKFGG26FYz9pSTKeIjdEW2DxLmGYARWkayu+Ydgx5avuWSQU9y7CIb4Wnsc16Xd9lgJcFaA4t7jmuoHCl1eC+MQ3FmYJcPDh0jFO9egFeNQprwQ36GxCO+Tefi4yu0vFKVkAMrtTye/kAAhhKYKYt99DmcTF3F3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JHEjiSQH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wg3gUAux; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JHEjiSQH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wg3gUAux"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C14CB140014A;
	Wed,  3 Dec 2025 05:49:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 03 Dec 2025 05:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764758952;
	 x=1764845352; bh=Q1MjVgdmF+0qX1uZExw58hrN0WGWKfr/8x5mv3CDrwU=; b=
	JHEjiSQHKZHKDB3KQxk5r6vBNRYQIkWQ20bwqyE2hY2P4bKMn6eIpTmqDBNUtgcQ
	uUCI6XcyZ68iiltjkxipCWOnAiM1X7urefZ4v1qkFiOLsZoU0UUnBDp9VN0p0TMT
	O3CWLk1sOule3Ls2ZXrJ+o8tewnPA+okCP9z+6M3zvj/PwYZCSwStGUM5dgdmrzo
	zSQOQNxApNUqVLP/pJQGVMRSnvflmUfVschLPcNoYN83D3vxHAQQPpoSNtECmcbn
	8eP6k0KWiJI4Fz4Qlg54LzkP5yK9y2JlZVFQQJm2m4R9xqQSTajl6QSbbFfyOdBn
	Of3/cTAcPOkwE93/9WQu0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764758952; x=
	1764845352; bh=Q1MjVgdmF+0qX1uZExw58hrN0WGWKfr/8x5mv3CDrwU=; b=W
	g3gUAuxxU8aIarzH9ecuzWeqqN5eOL9VU/RjHKABriyxazrm7SH1R1V5CXYa943z
	y1jZwHVxzfp3FbwUAdpUrEj5yZyEIEBDwQzMyz6bnGlhMxvxGmlA79NNgtvaBgOT
	D+gnkVhnBLlJuzxePvbUEhuXPEGq1aEh5ZCLasQLv176/MD3oQLJ+iEoMzw0fH8a
	D+KVHJaTz1cHgFqJatqqGM3ByaKTfl9WVT31G3KCqR/RAs47gWxvuJcLGGj24BG/
	8m++UOOuvyJ4ZGf9m1Gm05mozZPlkI8AinpxmW8++p8JjFqN0hOBA+1UkQcJmC4s
	TFl5wPgjlyQ8oRPhYWXqA==
X-ME-Sender: <xms:qBUwaRj4s5TUTJcwpOAU21bADYqegcYRaD1nRr5HlF6T9utHD_s1Aw>
    <xme:qBUwaYkSWrozanuyyHeqKDU3OlYJxpyeEi01Bx-iYfmwkrZUr5THQveQqOYMyV0Zq
    e33WPbmmw_ERWJz-N1Gtc_eRQtDGMAWnqcZvcivwndDHtws0bcaDA>
X-ME-Received: <xmr:qBUwaUvParDO9sxoRATlX_gS--0DjfaKo3NLpXTlpJqfGfS0Ci7atky_U1ffQrtv89Km25VGEVOlkgU6y4Op3n3emm28QNf9TgJt48c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilh
    drtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qBUwaWZaaEQd_2x4sAsvs6hmzZeU0bVnkvahvi3SprnCPzi8Repcew>
    <xmx:qBUwaUBRLi2IEW92xk8CJXwwc9ykatoWfjQJxgNstE4Wni1w9JTnjQ>
    <xmx:qBUwaW_OWVKQUUPwTqP4V6Cyi4UPz0WQ5XtqmkRrJSqVnc_Womqk_A>
    <xmx:qBUwaYSbDxm3aqascbXZOD_fIeCRqjU7sEPFf1P6jJTFJUcy4UFZQw>
    <xmx:qBUwaT8leOFIzPhmQDUka5ha9urzHFROw4if4KI8BLXsh9UahfkSsDG8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 05:49:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 510ad4a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Dec 2025 10:49:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Dec 2025 11:48:38 +0100
Subject: [PATCH v7 11/12] cache-tree: allow writing in-memory index as tree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-b4-pks-history-builtin-v7-11-9e9f849bfd0e@pks.im>
References: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
In-Reply-To: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The function `write_in_core_index_as_tree()` takes a repository and
writes its index into a tree object. What this function cannot do though
is to take an _arbitrary_ in-memory index.

Introduce a new `struct index_state` parameter so that the caller can
pass a different index than the one belonging to the repository. This
will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/checkout.c | 3 ++-
 cache-tree.c       | 4 ++--
 cache-tree.h       | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d325083ff3..aa00f0f483 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -902,7 +902,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 					   0);
 			init_ui_merge_options(&o, the_repository);
 			o.verbosity = 0;
-			work = write_in_core_index_as_tree(the_repository);
+			work = write_in_core_index_as_tree(the_repository,
+							   the_repository->index);
 
 			ret = reset_tree(new_tree,
 					 opts, 1,
diff --git a/cache-tree.c b/cache-tree.c
index 2d8947b518..2976092270 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -723,11 +723,11 @@ static int write_index_as_tree_internal(struct object_id *oid,
 	return 0;
 }
 
-struct tree* write_in_core_index_as_tree(struct repository *repo) {
+struct tree *write_in_core_index_as_tree(struct repository *repo,
+					 struct index_state *index_state) {
 	struct object_id o;
 	int was_valid, ret;
 
-	struct index_state *index_state	= repo->index;
 	was_valid = index_state->cache_tree &&
 		    cache_tree_fully_valid(index_state->cache_tree);
 
diff --git a/cache-tree.h b/cache-tree.h
index b82c4963e7..f8bddae523 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -47,7 +47,8 @@ int cache_tree_verify(struct repository *, struct index_state *);
 #define WRITE_TREE_UNMERGED_INDEX (-2)
 #define WRITE_TREE_PREFIX_ERROR (-3)
 
-struct tree* write_in_core_index_as_tree(struct repository *repo);
+struct tree *write_in_core_index_as_tree(struct repository *repo,
+					 struct index_state *index_state);
 int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix);
 void prime_cache_tree(struct repository *, struct index_state *, struct tree *);
 

-- 
2.52.0.239.gd5f0c6e74e.dirty

