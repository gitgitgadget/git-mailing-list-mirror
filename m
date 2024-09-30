Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D22189F58
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687649; cv=none; b=jZcE0ZLeic93/Y66BZIqptBNoMRpjE7FQs89ie9AvdwTYobUav5SAVumqb7pUagdaxrt72YIqatb3ov5fRyLieYpwzFVewUKXoGzf9+MPH1h/dN5RYVoR/zeoLSbpJzfsgsCz3H3/uFbHA8fB0/YJIUE4GLFSDEeOxeleKY4ktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687649; c=relaxed/simple;
	bh=hkmezCtm7cUj3Y0Tt3ex8uNxObEnkhhQ2gWCT80EOgg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tblXqCAthNIjLFJG01f5tBd3SIqru97ZWOFdieDnQ7zSBDigrXX23g8LFLMSjiMZBZfUxtID3P9ZJ2WiybZjv7YVY0nzoMS2lkQEvYdA8Ftj/Ec1f2zfjrf2VZLAbjF/afwc5dK7Tm/xWdLPt1lox4CamY4CFt3qt/vVgibW3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZaPafXoe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fEyZV0hm; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZaPafXoe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fEyZV0hm"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 89D3B1140259
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 30 Sep 2024 05:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687647; x=1727774047; bh=5MWaEBGYIu
	IbDGXGEIT52eBhAHsEX7PZm2OU2ca0N98=; b=ZaPafXoeythBtjeLCgIgUVk664
	OMYLnDlHPfPo7IaV44RTxQLtjl0cJDkAZAmYeu2/NEe1LoODz3Mij9y8O1bIwS6p
	ra5I03LDVC17Lrzt2irSZ9DoFcI0mrwEHCmbCfmp4j0WzntBzuDV+5ypFdmzKBiB
	txxcrfTVThpkb7f+IhLeajWpZoEEFgQofVWxAfUXvLgu6hY9QA4hwFQis/kZADMJ
	TW9AEmm8H4jZsbokbnFVx2HHYo315YcN9+Gyfk/GGrNXXTSZBxpTv91fHJlv9UEN
	4xjz+up9pjk7eu67mwqC2gpIeNESqoZBO9nIuv+vi1cUSZywpHE4c5xZUGhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687647; x=1727774047; bh=5MWaEBGYIuIbDGXGEIT52eBhAHsE
	X7PZm2OU2ca0N98=; b=fEyZV0hmlTHsiOuoXXzVDyUabmoPR/igYzHV5s8FKTYX
	fp4AAbcwzs1Evs50xMrVE1j5k1+DvHEZ4afzQo/zu+WkRMfVmywSx+0oYGh5AemH
	hgja7BbS27qGud65cA2ojDo/9/14Se53SPq1VHTX8Ego1pJl+4BManaCo+B54S+n
	+3pOAiV4HO+kbxC3t2u9qnUr1Nf6qmz6lkPMoRNeAcvp8CWA3KJJGe7tS8PW2j1M
	dQMD+hrCWbuja7nYNa0X83We0NL5r/VRuU6WLaMQtSgqvz8EnJVjRjN6HK7xjrSU
	BqkETrwHSWfatxHFAJfuEC8lJRcdqp8oXLdZrL4HOg==
X-ME-Sender: <xms:32v6ZtvYMkkr9GzV5TdUAcLbIfAlfWW3fNuopjPiTnk3e4qoDk7c4A>
    <xme:32v6ZmczVfUjRYoi-Xim92fJ-eQ13KK79PsJsbDSfZpEHaC721QmUhdaAF5xB0E7d
    lIDbU-lrmb-LPDDJw>
X-ME-Received: <xmr:32v6ZgzFya3HwcFVzckAIWMyM4s960tiZzXisTSxvxYbbM3BTEkvFZ7lqxtGosfpUd92eNjyhXWkIzOdKY7zAveSpFkjno5DiUZvZeOD1H9oKto>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:32v6ZkMa5Zkhz7XLQprgIQux4oUBgs-mCes4THfubnMY0E-E7sWQrQ>
    <xmx:32v6Zt8kLOhUgaHiY9D19ZvbQQy4mCFM0k1cmxcK4vCNYCbnuvjMoQ>
    <xmx:32v6ZkWpZmTm105-6JFxXgJ2nAW460pBeCcf5Qg2LIk199brBcdD7Q>
    <xmx:32v6ZuehA1CGOraWEixYnxokCxKqqPXy-zX_21IlIWi4GDjBmDfH8A>
    <xmx:32v6ZvkK3qW4FMCjuNJFaZKB5hKJscjHFmnqyFvVdw_1tDPtxcAwMWD3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id facf0840 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:13:20 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:14:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 18/23] revision: fix memory leaks when rewriting parents
Message-ID: <09e067162aa82fddabe6c7aeffc55f734212ee4e.1727687410.git.ps@pks.im>
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

Both `rewrite_parents()` and `remove_duplicate_parents()` may end up
dropping some parents from a commit without freeing the respective
`struct commit_list` items. This causes a bunch of memory leaks. Plug
these.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c                                 | 2 ++
 t/t3427-rebase-subtree.sh                  | 1 +
 t/t6016-rev-list-graph-simplify-history.sh | 1 +
 t/t7003-filter-branch.sh                   | 1 +
 t/t9350-fast-export.sh                     | 1 +
 t/t9402-git-cvsserver-refs.sh              | 1 +
 6 files changed, 7 insertions(+)

diff --git a/revision.c b/revision.c
index e79f39e555..6b452ea182 100644
--- a/revision.c
+++ b/revision.c
@@ -3250,6 +3250,7 @@ static int remove_duplicate_parents(struct rev_info *revs, struct commit *commit
 		struct commit *parent = p->item;
 		if (parent->object.flags & TMP_MARK) {
 			*pp = p->next;
+			free(p);
 			if (ts)
 				compact_treesame(revs, commit, surviving_parents);
 			continue;
@@ -4005,6 +4006,7 @@ int rewrite_parents(struct rev_info *revs, struct commit *commit,
 			break;
 		case rewrite_one_noparents:
 			*pp = parent->next;
+			free(parent);
 			continue;
 		case rewrite_one_error:
 			return -1;
diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 1b3e97c875..5e9046e3df 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -7,6 +7,7 @@ This test runs git rebase and tests the subtree strategy.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index 54b0a6f5f8..2656d6a6bc 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -10,6 +10,7 @@ test_description='--graph and simplified history'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 5ab4d41ee7..bf3e3f0b67 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -4,6 +4,7 @@ test_description='git filter-branch'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 1eb035ee4c..2bdc02b459 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -7,6 +7,7 @@ test_description='git fast-export'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index 2ee41f9443..c847120d52 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -8,6 +8,7 @@ tags, branches and other git refspecs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 #########
-- 
2.46.2.852.g229c0bf0e5.dirty

