Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9113D8B1
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618359; cv=none; b=qdrO1ni3/bbmm7RtGfQ03QCK5okHDy8ZvJex//kiyE4NPpEt9kCbhB51pR7nJt7/tV/CtagYJ9t6qZ+ggiILWumE9GLOWt76DRsaf7jzfcCAW5/Hc6cYGWYFmbcsJDPlLbSaNxFTStZJp5DYAAJs6ozgAINxK1o2jA9KlG+wfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618359; c=relaxed/simple;
	bh=Ukaij5hmrPErRpw4QDKh97/DgmHZG0a41YRLxtb5IaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9wCAfc+hiS8pPl0G+jY8X5v7C7i+g1Ex7ouY8LrSUpuE1f7yOWXmoqa2Md5pW0s5v6RngjxKcZt7f/pK1MwfnkgQ3tfXLTuQq2MNM7Z3Q87xlDAGUrBP0aIaKR23+1mCcTTjv2+elN8fzLQTqNSLPqqLE1FdXKK+S5+MEJvbAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UbOkcffP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uqkGd1RO; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UbOkcffP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uqkGd1RO"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id CB6031388210;
	Wed, 14 Aug 2024 02:52:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 14 Aug 2024 02:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618356; x=1723704756; bh=2pdPl8fWIg
	Pa+FaufSSoP60mf5EmVgiEfhB5i2Ic8MQ=; b=UbOkcffPWXx9tUFOpbhpfDtf4g
	0n1LyowtnimGFcesw9VolO7vuTgA0RhFlyE6juHa6DjiccmormqNe2HBBRKDfhth
	h3QRsAarzzyCrT0LnNodaZdv3baYwXUnjSdZzf0wW1YQCUjB8c5z3jKGPNbeHjlE
	xaQ2FEAF6KV6dL9zSiLMdh+UFhrh42rKRgSS/BdaYV8r1azTAu7hpmQqww0BZmvf
	LPvKC59nDuYLm4017tQQ1FBb794BGuotteJAM5R61jvIL62RaGVN6/M3jCe5YbpV
	/qRHz2o0KoDUK848G4T0bwYqFvImzDuJ7SWjrqmfM8Rn53gJr9S97rNaN8rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618356; x=1723704756; bh=2pdPl8fWIgPa+FaufSSoP60mf5Em
	VgiEfhB5i2Ic8MQ=; b=uqkGd1ROB9MFKalr0SFpVExTQuJv0QaNWe6Vw/XWrPPN
	yx8GDQxCqP0yM5YegzfisfOfdXrfmKSYsA1IqMlxna2YZsQMTdHEymgiJrN4teXL
	Gfw2wW2KnY27IE6wP36MVe64mvswn9rSNwIkH2BHU09PaYIAlT36w48aVF5exiwC
	8ynK3yl0ai3myuzotoOPB6Kb3q5clDnrKUso/z1WvSgFKDOi+hc2rZ3UPrp7jvZm
	ecta92ybEY6+e4vTH96FQ/gy+uUZ/asC5knEV40oXaBSzZ/BYDvHuS49+WTNMazE
	7k/5mLpA2wYXA+MqVJgfvXdN6pEuiuVbHgglTmqOGw==
X-ME-Sender: <xms:NFS8ZnxxHTxy1fvDfUUGF5Uh5DnLVhgF6cCZDqt0aBCLLt82GIv-XQ>
    <xme:NFS8ZvTVxHoVneAbgL83H7UKkCgB8J5KsgdSh78OpW7cFEULxVGJ_F2_FcLHYPDm7
    bGj5oLaPYnMsO71kw>
X-ME-Received: <xmr:NFS8ZhWpWOrCNRqtfOFEUeBiMjU5duv_JKfeoIhvKf-sl3faDHBoNQf20lUm2zKVaFT3C_Ynr9C6dq1YDhhv6BhKs5W6XlcaU8lPRt-GQVGWEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NFS8ZhhI6MmOIVEg-yNOSxksZcNvbLnJsqy7whE7jsXKngCGRjAG8A>
    <xmx:NFS8ZpAGECvgp6AyCe1Bt3K5Qpeabw-VRRRSnHHePQdmveYJfguhQw>
    <xmx:NFS8ZqLHXilI6derto4v6V_7fpjrTHXoSTMc6hGiwF8CiUhMgDcBMw>
    <xmx:NFS8ZoAdrLw2XtxJ1D6WIKROREcMuqgeaoiJsha1YpxVKWnzFU9HdA>
    <xmx:NFS8Zr0t-hVkG0ksjnL0YxwxqC2iWNQNy9gH0P0onIWIRY7GxKubeYJ6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 54cab469 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:52:17 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 14/22] merge-ort: unconditionally release attributes index
Message-ID: <bdfdf533134ff979f3236740b96101b83fd78bcc.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

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

