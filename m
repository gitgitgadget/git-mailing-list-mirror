Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676A2156C71
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487192; cv=none; b=kMnzwm5r5OW+RU3o7HnYPDY24awrGMRwkv8dWQYK0HEIh9jQ231/Gvg2qZMStO6sKMuLkTDZqBPuQPiesBfGEnghvEIIcQYbbo9/zYYsuxMKfIbYJ4+qXKK3aaa/w7HWpeGK/CjVxGH2jYBDFRnk7tMfUn84cJ3o0oAnLNWZOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487192; c=relaxed/simple;
	bh=LzYiJKX+8TzJZY41NnK6Zh67MMV4gZk8FgSvDHSbKI0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6SN7YOcq4n3NA+4ZKWxvUFnJJHGeGBnTdRDDoQKZOvBHK7veg19wXeSHDj3pfR/syKzfvecJeDMpjHcAlnZd+PYQOghC5m+ex/DRdMI+/kegPy1WWcwA2/o/lUQqzKaZwY17zkZIHFaMoptWR04jxabVK/o9eGLTnuBERE0Hkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NoFkCQU1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uIEsjUzz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NoFkCQU1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uIEsjUzz"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C5A051380246
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 16 Sep 2024 07:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487189; x=1726573589; bh=BaCi1wvQnd
	tdzDNioDS5oxo5dxFCUqqwLF6Hj7036Ks=; b=NoFkCQU1IRvXUdBZ3eCsUpRPQ8
	NAamYVGC1fHsgkrZfMvZYRdc43aEwas/uW/kjsrK/ZaYmBHCOdxY2hF0kYBy9z4u
	YJJMZ0LqUTfr2EA9DPWCMYTjC92Pb2cQ75Ymbsm+7H/FHm9sxEMcuMxE47fTLCa1
	owUECHC+iZ/Ttm0qZOPgMTuCU4FNvkHq5w8PeacVcwanI6S8vGw3iwsPcquoofaq
	Vz0Qzbc8z1I2HoJD49/EG1PWL6eGiS2b9me/hAdAIvt4/Lrbw8aweLRFebxy3X+O
	z0lCuJB4iJPLzFDvDity3+2HP98SJaCk9wjmvQtmeFcq95QWvNKIn9B0Schw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487189; x=1726573589; bh=BaCi1wvQndtdzDNioDS5oxo5dxFC
	UqqwLF6Hj7036Ks=; b=uIEsjUzzCv2Ox4F6nuIdN8nPrxDHkuzGM5zO0yMihrhx
	ujJd80KK5p869q2xXThkYjiijoQP1KGNqVVpctOXrBahdm2aM54vIIV+6y0H5Dbb
	v/dtOA1l8GCuUJuZTcZZ4MR16ewBejw2yCxHxpjfEjr09OavbgAOh+RQRPkk0Isz
	uceeoH8eAREBtJbgX0hIV7n2drmgtCC/CwtB0m9P+KZ5HJukZPImES0lFRKQASLi
	NXMyFcEn8oe2P9QUDF5LvLvlLlMLMH1NoT3B8iWgANCKGyO/zSdykc4zRPe2kHPE
	EwYuaIWHjuIvO8eF9EJGVUIs5yvoHCtfUC3dQTdj8Q==
X-ME-Sender: <xms:lRroZlNPRtoL3FbA0nRKHl5kZrWd1R_MOMTJ8dt9RP3Rfl95Q87p6g>
    <xme:lRroZn90rn2WL-vhYzerB_i7mSlEZHCbNSxNeFXNUO3hw53SySQpf3MffgwF1yML6
    9dYJNGVgb7jct7PJg>
X-ME-Received: <xmr:lRroZkQMZr4BsgbefYNg9atJkCrvTUD200pQnGFyJtzg6JgMV_qrT_FBKpLCt9_8qdIAT8yn_XHXliVamT2GooCi_qIk8qjmYk79FP1vf16qQMax>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lRroZhu9C0ymDyM0Inqir1RiIdcuWvoiUIHgHa4YxP2Yqqd9T-1zTQ>
    <xmx:lRroZteKDehkYppC4xdF3iXA01naE7fqioKWKNL4g3Hmb82WJXVltg>
    <xmx:lRroZt3jm-l2kfX20X-IBDPVEW9axNfU8A-AAKIqhYz__6Q4hLlpoQ>
    <xmx:lRroZp8kcq7Szd2TC1N_FX1bOm2Nl45_EHBDGFtP34fx7RfB8pMCAw>
    <xmx:lRroZtEwNU000TAxtLkxM4cUonEujsq8crIuwOhVdWhQnF17qtwygcSk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 188f6aad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:46:12 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:46:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 22/23] revision: fix leaking parents when simplifying commits
Message-ID: <2a23df9a6869f58a231cfe4947b322690d48cb1a.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

When simplifying commits, e.g. because they are treesame with their
parents, we unset the commit's parent pointers but never free them. Plug
the resulting memory leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c                        | 5 +++++
 t/t1414-reflog-walk.sh            | 1 +
 t/t5310-pack-bitmaps.sh           | 1 +
 t/t5326-multi-pack-bitmaps.sh     | 2 ++
 t/t6004-rev-list-path-optim.sh    | 1 +
 t/t6019-rev-list-ancestry-path.sh | 1 +
 t/t6111-rev-list-treesame.sh      | 1 +
 7 files changed, 12 insertions(+)

diff --git a/revision.c b/revision.c
index 2d7ad2bddff..e79f39e5555 100644
--- a/revision.c
+++ b/revision.c
@@ -1071,7 +1071,11 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 					ts->treesame[nth_parent] = 1;
 				continue;
 			}
+
+			free_commit_list(parent->next);
 			parent->next = NULL;
+			while (commit->parents != parent)
+				pop_commit(&commit->parents);
 			commit->parents = parent;
 
 			/*
@@ -1103,6 +1107,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 					die("cannot simplify commit %s (invalid %s)",
 					    oid_to_hex(&commit->object.oid),
 					    oid_to_hex(&p->object.oid));
+				free_commit_list(p->parents);
 				p->parents = NULL;
 			}
 		/* fallthrough */
diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index be6c3f472c1..49d28166da0 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -4,6 +4,7 @@ test_description='various tests of reflog walk (log -g) behavior'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up some reflog entries' '
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index a6de7c57643..7044c7d7c6d 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -2,6 +2,7 @@
 
 test_description='exercise basic bitmap functionality'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 832b92619c0..6eaa692f33b 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='exercise basic multi-pack bitmap functionality'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 
diff --git a/t/t6004-rev-list-path-optim.sh b/t/t6004-rev-list-path-optim.sh
index cd4f420e2a1..5416241edea 100755
--- a/t/t6004-rev-list-path-optim.sh
+++ b/t/t6004-rev-list-path-optim.sh
@@ -16,6 +16,7 @@ test_description='git rev-list trivial path optimization test
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 738da23628b..1aabab69568 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -29,6 +29,7 @@ test_description='--ancestry-path'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_merge () {
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 90ff1416400..f63bc8d3da6 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -16,6 +16,7 @@ test_description='TREESAME and limiting'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 note () {
-- 
2.46.0.551.gc5ee8f2d1c.dirty

