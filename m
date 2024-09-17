Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A8814F9EA
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557195; cv=none; b=OdpMqabBP+nJpD9LT5rTa19bUpPzDFuJPEr8fDdiVSBlExegFc1XPRU9S8uaDbg+Ni6NBpU4RCz4Tkp1fEk1Xkr0NSQivjMB89YmUhxuH89Hm4tE//W3HRThz9itddOxHQ79PBEdf9cCRT0dDGGuJ83ZrkQ1qjC+MDNoi5s9LxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557195; c=relaxed/simple;
	bh=LSIqlUPZUDS1Fl9koj78b4X1FIpsTtCThb00Q6VBxwY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDf7lIRTqBc0oFwSFJ8Jeyzk1/r8WOYH0FGh7aiBHGEUQA+PBBQwBFlXbfGiPwKlssHpul3qTtShqRWEGWnpKWoYkDHoNZslJB39eJ2b0dSQO605F4cBt/2gtytZDy3SLjSUUwm1W00zLPD3YZG0l+bvVHFNGZfxevkVwVltlcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YH7cj74+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q6jO/h9n; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YH7cj74+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q6jO/h9n"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 62CB313803BA
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 03:13:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 17 Sep 2024 03:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726557192; x=1726643592; bh=zIcFGO1k7A
	GoaECrbDRHuR94awjsluhDl35uU8i1MjA=; b=YH7cj74+UK1JkxVzxLNeDVEcLA
	vHQbK/pIsmja6TTyxKzn79zXUbYv1D8alzUDd6d3VXmowrK0G/VQcfiH1IsnRW2Q
	NtYjiW2qA2QO1WO3+Z9U97teYbTZ8WOxG5PVJ+dwMZN9MnGSZmnYJEnCFJQpemDv
	7z/QTX20ru8CC9e+4YPdBsz83Necqe0GrGs+p/v/qXOqvGcEigJCxwFbRKNfP9Hy
	Yuu6Cz9IZwmNuDSk3eDqD1C1Tdu9y2eVQ05/PKrd/b0Sd0SB8EHANb1G3JHbvjRs
	bitB3w7IsQlT07sAOaiG6gMlu0Ihd8UtQdIlyz5hKm5TudsBlpw/UQl79Zjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726557192; x=1726643592; bh=zIcFGO1k7AGoaECrbDRHuR94awjs
	luhDl35uU8i1MjA=; b=q6jO/h9nZS5rNeRIGbyZ0yFg8DPyCEe46k7rsXj6pUBj
	XagV9kHldKMWJRVlmXsXqf5bg1Wrpc9p9wiuSdDUDlFkFQcMmk65hicE3OBjI0NZ
	bhETOPQn3PgZSJrewBRHO3kK2Pp/5WPyWWIKII8bfoTj0xiz483D53D6gJomvnTV
	vtqISwUFg40fzkI8Dfbw9lRO1LRHjGdbzNBBCLVXoA3Y1Pxi6KXU5107G+0kheKj
	M+EZ1zCJ+7u4/lqCtgY2WI9vZf/IxM8h3Ul8a5s2p88Yuur4+nzRBmDnREiaHPiG
	tqXOpP0PbOYhjAyBvRvsoSzVC+ciuqzVc8rSlsbshg==
X-ME-Sender: <xms:CCzpZvmQSYjObaBWmD_5dLdKzfFLPuqpfx2ylqjdJJ1WEeH1-ThRbw>
    <xme:CCzpZi2MFPtpfODQlSjfMBl69QCp9-JTeJ5OoGNYyn3ZyFXEp3CHQz6x_CBQ8NMFM
    QsWtbKXNimJM_MZtw>
X-ME-Received: <xmr:CCzpZlp1jJSuyL7sK_4vCOXBT_gBJYBoqEH8ekIfIUgG8zxcjj6TQC9yJSS4wLZpQV2c5ZCCcRnAl0CXNtPm27mSyPtEbGFiiV8UhNjEtCW5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekiedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CCzpZnk_GPHXrKs5D6moTearW9rYaeERJVPi9Bsp2ocQWKjTvwVKrQ>
    <xmx:CCzpZt2AKR6D0pu-HGiZ4aOMdLgdBWiJ9nqPvIXz8a7OU5if_82J8g>
    <xmx:CCzpZmsIFRTkPcAqZ6gq8UQPLQAlrkLBCrWPrTu7Bze1_9ywMYRe0w>
    <xmx:CCzpZhVJxnFBrKW8D4axMpFbI9qMBEJRliepi_6ZdyFFum6fvs0W5A>
    <xmx:CCzpZu9gYJKj_Xse0tpuVlKBXuRuCnHiaw1qRe6MkHiI3vez9bzPLp7q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Sep 2024 03:13:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c3f1c53d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Sep 2024 07:12:53 +0000 (UTC)
Date: Tue, 17 Sep 2024 09:13:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/3] cache-tree: detect mismatching number of index entries
Message-ID: <595693a6420b2571aabd51ed989bedfa0cfa62e2.1726556195.git.ps@pks.im>
References: <cover.1726556195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726556195.git.ps@pks.im>

In t4058 we have some tests that exercise git-read-tree(1) when used
with a tree that contains duplicate entries. While the expectation is
that we fail, we ideally should fail gracefully without a segfault.

But that is not the case: we never check that the number of entries in
the cache-tree is less than or equal to the number of entries in the
index. This can lead to an out-of-bounds read as we unconditionally
access `istate->cache[idx]`, where `idx` is controlled by the number of
cache-tree entries and the current position therein. The result is a
segfault.

Fix this segfault by adding a sanity check for the number of index
entries before dereferencing them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 cache-tree.c               |  5 +++++
 t/t4058-diff-duplicates.sh | 12 ++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 4228b6fad48..1e625673086 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -933,6 +933,11 @@ static int verify_one(struct repository *r,
 		pos = 0;
 	}
 
+	if (it->entry_count + pos > istate->cache_nr) {
+		ret = error(_("corrupted cache-tree has entries not present in index"));
+		goto out;
+	}
+
 	i = 0;
 	while (i < it->entry_count) {
 		struct cache_entry *ce = istate->cache[pos + i];
diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
index 2501c89c1c9..3f602adb055 100755
--- a/t/t4058-diff-duplicates.sh
+++ b/t/t4058-diff-duplicates.sh
@@ -132,15 +132,15 @@ test_expect_success 'create a few commits' '
 	rm commit_id up final
 '
 
-test_expect_failure 'git read-tree does not segfault' '
-	test_when_finished rm .git/index.lock &&
-	test_might_fail git read-tree --reset base
+test_expect_success 'git read-tree does not segfault' '
+	test_must_fail git read-tree --reset base 2>err &&
+	test_grep "error: corrupted cache-tree has entries not present in index" err
 '
 
-test_expect_failure 'reset --hard does not segfault' '
-	test_when_finished rm .git/index.lock &&
+test_expect_success 'reset --hard does not segfault' '
 	git checkout base &&
-	test_might_fail git reset --hard
+	test_must_fail git reset --hard 2>err &&
+	test_grep "error: corrupted cache-tree has entries not present in index" err
 '
 
 test_expect_failure 'git diff HEAD does not segfault' '
-- 
2.46.0.551.gc5ee8f2d1c.dirty

