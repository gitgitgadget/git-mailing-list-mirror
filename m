Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557922500BA
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732481814; cv=none; b=DkWzgbtGgWTZtpLzb9z/M9y9NlbTcOwO0HeFE9+6BsKrsrhUjvY6SSBHICqak0l3CrHb3r+J8lmkjLwP/yjfC++jjK5H6odpz27VYt3NvH8fQI5fC1XWzMG8se1/gzTmYy3dTxDpHglftSp9Ugcck/eJcfqDqe/lPPb8PjVwTIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732481814; c=relaxed/simple;
	bh=sPV16vSDS9r37vIPsLiCW39BXY/j3BepnHG3BctzMw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hnjh1DGg5SGxaZNmWTi/gHwaW+1A5LyGjxxeRHxATC1TierWjh/vK0ZMQKq71aCtk13pXruC7KzXEMhNkEc2TIOBjnKs6PgdPOq1l5zPEoVy88BkCJsZ0E461CyzmfMxkm+0PdPnFEGiEwIlzkh7iPCxkI5b91BZ8frlAwjzccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kSEIaTsE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ds51VBYI; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kSEIaTsE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ds51VBYI"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D18A2540161;
	Sun, 24 Nov 2024 15:56:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 24 Nov 2024 15:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732481811;
	 x=1732568211; bh=1ZSXeLVIIG0cmqg4VGR0yGgPzz37hbK3lK98B+UkRxE=; b=
	kSEIaTsEmKXTM3rldqj4g5tCsf/UO7RICb7CR8o0mU58+4MLiC4rQhBb2PFuH0X2
	CJrNiAmOc4XtdEPYli2hnhDaNF/l77q3tdV2iDR2QyqVhy+GvQGyo2Mv7ea1meIj
	iumq7V6H9wz4LSJ6wyh7CVoNakovQdt8UmHmwBQIfZmpYHwoRwV3UsfLSb939g21
	QOgnOAHlRdAyqq1pXV7bas2jd73rRGygT4Bx67bU7wfwkxTv4LVqdFBPg/2vugxb
	JvT9vsgr/JMWmcgJnaYhNrWqWjbW/FzLKAosQ4Hkm8yDIoaWm/B2XT4R698zE3cY
	UAPzxRX1D2+3md2qAtZPzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732481811; x=
	1732568211; bh=1ZSXeLVIIG0cmqg4VGR0yGgPzz37hbK3lK98B+UkRxE=; b=D
	s51VBYILC4NP1M2YKacIWn56OFiPrCwBr9k0XbZpiQ9CqGqm9hUA3RitlRYqPRCy
	q/M8+LvwHtE9oohAvf+Rq4oOSU2fYAt6FV3zQkThy22d/YLGsvjVqqoJPUfAT7+D
	ar7RymBkHzH/zwBy0rcq+0I4TyB/x5GRdK6mG09v4G/5IgjJbby02gfbATMfQAcT
	lb09ZNacbVDafKUlOzu4H2S35AcNBt1ITCK9McNsnPJ6wKTiKCFDS821GXh1CDTj
	T4ARu+pt0fCnqS5p40bPnHw9J/T7P8yT8sdP9fMqjGtaNG1cnMczbLl0HlrMwsvu
	fvbpqHMurnl9SWt5rjYtQ==
X-ME-Sender: <xms:E5NDZyhqARTnryXlU56igf4iSWj96BvGxDSMphMGHifw3Q_Eq3iqCmE>
    <xme:E5NDZzA_0J7Q3o_vm4MiU3eBdr4EE7jlNxnlXPrZj02bkRUKX10OHrbQv41jqgH8s
    NJHp0cUjgU1MS_JEA>
X-ME-Received: <xmr:E5NDZ6FfEI8hmh3uNh_389cITNyjkKcCkGjdHucJjROStLTBNNOgiiMu_8A8pgLhtBUJmJ8_GAfJZn-NJaTrFDkgzoc0FgvLJMKac0Jd3bglRS1GvGVO2uunJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeefgddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgf
    euieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsthholhgvvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:E5NDZ7TJMqvwVZtAPWLcpIQN-8MSFgDc_Sm4TENGLMNa-3Jjt5qz0A>
    <xmx:E5NDZ_xdC8zF2bDKiGRq1bNuiwD7gv9npCuaNvxQNlD6BO3YBt_Atw>
    <xmx:E5NDZ54IfsRVLt0JkzMV7qEJdclidiU8z_ow7FtAMROL7YrWf_QzzQ>
    <xmx:E5NDZ8wwrU1GcCjyHJgRrHN9HNl3thTJ5kA5og640ctnxQkvBrCAtg>
    <xmx:E5NDZ6pMkoFw7aov1cfk_IrrVU7eid_OEsEzNd7CksnFEqOku6jFvUWG>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 15:56:49 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com,
	phillip.wood123@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v3 1/3] sequencer: comment checked-out branch properly
Date: Sun, 24 Nov 2024 21:56:10 +0100
Message-ID: <a46767263f6e0f032ed7eb2af2e5f1620f14dfbf.1732481200.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732481200.git.code@khaugsbakk.name>
References: <cover.1731406513.git.code@khaugsbakk.name> <cover.1732481200.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

`git rebase --update-ref` does not insert commands for dependent/sub-
branches which are checked out.[1]  Instead it leaves a comment about
that fact.  The comment char is hardcoded (#).  In turn the comment
line gets interpreted as an invalid command when `core.commentChar`/
`core.commentString` is in use.

† 1: See 900b50c242 (rebase: add --update-refs option, 2022-07-19)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Review feedback: check more in the test by inspecting the
      sequence editor
    
      Link: https://lore.kernel.org/git/5ed77fab-678d-4a06-bbd0-ea25462a7562@gmail.com/
    • Message: consistency with the other two messages:
      • Mention both commentChar and commentString
      • Commit footnote style: See <commit>
    v2:
    • Message: “hardcoded” (more common according to `git grep`)

 sequencer.c       |  5 +++--
 t/t3400-rebase.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 353d804999b..1b6fd86f70b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6382,8 +6382,9 @@ static int add_decorations_to_list(const struct commit *commit,
 		/* If the branch is checked out, then leave a comment instead. */
 		if ((path = branch_checked_out(decoration->name))) {
 			item->command = TODO_COMMENT;
-			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
-				    decoration->name, path);
+			strbuf_commented_addf(ctx->buf, comment_line_str,
+					      "Ref %s checked out at '%s'\n",
+					      decoration->name, path);
 		} else {
 			struct string_list_item *sti;
 			item->command = TODO_UPDATE_REF;
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 09f230eefb2..711bd230695 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -456,4 +456,23 @@ test_expect_success 'rebase when inside worktree subdirectory' '
 	)
 '
 
+test_expect_success 'git rebase --update-ref with core.commentChar and branch on worktree' '
+	test_when_finished git branch -D base topic2 &&
+	test_when_finished git checkout main &&
+	test_when_finished git branch -D wt-topic &&
+	test_when_finished git worktree remove wt-topic &&
+	git checkout main &&
+	git checkout -b base &&
+	git checkout -b topic2 &&
+	test_commit msg2 &&
+	git worktree add wt-topic &&
+	git checkout base &&
+	test_commit msg3 &&
+	git checkout topic2 &&
+	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
+		 rebase -i --update-refs base &&
+	grep "% Ref refs/heads/wt-topic checked out at" actual &&
+	grep "% Ref refs/heads/topic2 checked out at" actual
+'
+
 test_done
-- 
2.47.0

