Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78817C21C
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541514; cv=none; b=ayMetCbCbkuLVs/DTkCFMjgyEl7lR3ArJCtij3YDq0GbMw7byoMBMds0Kz7J/TgsEqxqi+QBk5Iq9oh995yUxvPDB4ZdJgNis465xyKKMI94/r2+Rp9h2sOdFfe9k7/VY7QnEH4/TZM1n674sWj/sNqR3EPJwRsMM5LMYJRNdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541514; c=relaxed/simple;
	bh=Ukaij5hmrPErRpw4QDKh97/DgmHZG0a41YRLxtb5IaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNm2XqCReS6K2azq0vygRRfIWEitQHuYiLgyKCLn9Uu0cnFfnGTKAfsxLPCxo5Lo8rUbEdLT1zN59Hn6FqMM+XqeLPJn82eIQe/1L1R/QD++Mx3XV4KqmRF2+2udRDthp/Ft4r2qX2u7ALrLP0wnliYnVjyIJ/0CtExXIH0EaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OCasxnQz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NM/WVN6R; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OCasxnQz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NM/WVN6R"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C452C114EA7D;
	Tue, 13 Aug 2024 05:31:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 05:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541511; x=1723627911; bh=2pdPl8fWIg
	Pa+FaufSSoP60mf5EmVgiEfhB5i2Ic8MQ=; b=OCasxnQzM3TS1KPtvfS/YhUfNn
	lqZWNnCNr+FtH5mxGDrLSo4KvH8c61UfADXRsSp6w9xfrPgna1GSLWPHTpx/ZJOC
	rELnvQNMbGpcgLuwsw5dw7gPWNazlc70ZNniU3g9TwdosSgjj+TLTQdOSimOilfU
	rmhbHwpS0zsT8/WXCCUmDV6UqD4kfStdW5ZDm6NEEkYZxtTQBqTK526K9lJAyTH5
	reDuL7IZ6KKPRv40iI4j6W9Z+moMLmN0auruaR8tIK6s0R/Vk56FDFBy+CcNcjwS
	wR8QqheQqeO0ijmGUWogI1V/P/lCj6LUB71toqKmUZc5ur8IsQdr2hHuXgng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541511; x=1723627911; bh=2pdPl8fWIgPa+FaufSSoP60mf5Em
	VgiEfhB5i2Ic8MQ=; b=NM/WVN6Rhh032jb9YbldIXmWehgWSzPvgKpN27WchdQP
	g+FVUaan2PHdyzOeNcOT8NDUMbRXD+pPNKC3OxWtRoa13TCS3+gpEe2epLQm790S
	x97qlRXKKuX4Mp75lDbrnqWFCjYJor0rk/NcUoR0lU754Ogo1Lm2VRPPh6rGKPB2
	1W4vGSZ/Y0jxdNc+ALblfasCwIA/HcJe1QPb8i4ixPDNKGdabgrMstFtMbreMkXp
	4PmeD0EsP/M6MDxQ2iGgWnjp8bWaGpd++NL4fOM2uNApbfWafLQ7Eu1+/yNHd9W4
	rETmMX0OumsH7iY+Iwwite2KwKdVd6q2JJQXySRgoQ==
X-ME-Sender: <xms:Byi7ZjBYaj_F4b4-DeaxgSwLySJg-X70G909d3K-2Y7nhoFYLHQJVw>
    <xme:Byi7ZpjIuL9i2AOQkldY__bRNzXu-zL_52g10c_idXMouWGZgxoHXSToA8Dfur1uU
    NOO930uOTTBnSI8fw>
X-ME-Received: <xmr:Byi7ZulQZlnRuKIwJyuBJU6hHQYU7tIYRBZhbDq4ncXiV2sbER_liiYx-BikLGe2GD7CLHnKWuuoTZlbNtfEP6vZnhNyEMwhscUdi1rqNqAl-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:Byi7Zlw18eYNgNxE5RX2xcphPaG2LuRjLimS9iYmttng5wWYgg00cA>
    <xmx:Byi7ZoQkuD8uzS7uEdXTeDCI05P6ZcilXLLQidFf-HvGvxf0AYY7cQ>
    <xmx:Byi7ZobAzDRbL76xc9UlydsXSK7uK8QaYKWWmSsNYmh0D2FHBYwybg>
    <xmx:Byi7ZpTuS5J7RKnfHIRQXIv1N0DAjgBYGr2m5UTh1dTyki3eELkOOA>
    <xmx:Byi7ZnEp3o_4GtbuXxrvkrEWPJYuWJpBmHOmtWExmM4DlKp299L9F6Xb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 33d96a77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:33 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 14/22] merge-ort: unconditionally release attributes index
Message-ID: <334c4ed71a1e51f9bbbc567e13c10b5fd0c303ed.1723540931.git.ps@pks.im>
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

We conditionally release the index used for reading gitattributes in
merge-ort based on whether or the index has been populated. This check
uses `cache_nr` as a condition. This isn't sufficient though, as the
variable may be zero even when some other parts of the index have been
populated. This leads to memory leaks when sparse checkouts are in use,
as we may not end up releasing the sparse checkout patterns.

Fix this issue by unconditionally releasing the index.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 merge-ort.c                       | 3 +--
 t/t3507-cherry-pick-conflict.sh   | 1 +
 t/t6421-merge-partial-clone.sh    | 1 +
 t/t6428-merge-conflicts-sparse.sh | 1 +
 t/t7817-grep-sparse-checkout.sh   | 1 +
 5 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index e9d01ac7f7..3752c7e595 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -689,8 +689,7 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	 */
 	strmap_clear_func(&opti->conflicted, 0);
 
-	if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
-		discard_index(&opti->attr_index);
+	discard_index(&opti->attr_index);
 
 	/* Free memory used by various renames maps */
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index f3947b400a..10e9c91dbb 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -13,6 +13,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pristine_detach () {
diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index 711b709e75..020375c805 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -26,6 +26,7 @@ test_description="limiting blob downloads when merging with partial clones"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sparse.sh
index 9919c3fa7c..8a79bc2e92 100755
--- a/t/t6428-merge-conflicts-sparse.sh
+++ b/t/t6428-merge-conflicts-sparse.sh
@@ -22,6 +22,7 @@ test_description="merge cases"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
index eb59564565..0ba7817fb7 100755
--- a/t/t7817-grep-sparse-checkout.sh
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -33,6 +33,7 @@ should leave the following structure in the working tree:
 But note that sub2 should have the SKIP_WORKTREE bit set.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.46.0.46.g406f326d27.dirty

