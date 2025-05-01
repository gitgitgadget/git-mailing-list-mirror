Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B63262FEF
	for <git@vger.kernel.org>; Thu,  1 May 2025 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135265; cv=none; b=kQOaMGSzn99frjA9DFnH15WfZjXN8p0H6SY4djrJ10ZlfCK68kYN6ZIYbG1Gu3ZztD/eB8SKThxSUdy9HnfURL9FB+bafiit3kQV8TsEmT10AAVruXn63d1nLzjPNtGjhjdPaoszET/E3QC+M4h0yOdC9jnOweFXWZ+GbKYNhQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135265; c=relaxed/simple;
	bh=u9FotMkuibEDVv9YuEAU4mvxv2a03auoj7XIo2LbzKY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APfRtAfyHeWg6ZlN9yu9YzW1uK7svgIp2PTxUhTE0BzD7Q3NJwFxA77i3f/tvanfR4Bsoaq+ewXqHOXsRD+icY2+8Dt5XThbMCVrNrjTt4m+/BLd/kjS9lEMnnJcNhhdrd0ZaeWaSwtagtsN3UMqRpZRninWTMTB0JVZgyA6GHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OWaRa0nS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E3hKXIE/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OWaRa0nS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E3hKXIE/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D9E751140277;
	Thu,  1 May 2025 17:34:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 01 May 2025 17:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746135262; x=
	1746221662; bh=ItUIH4BDDCxL7qhXlr3OLbuE1wdAOwXrR8P++Y8h1oY=; b=O
	WaRa0nSzhR8FVD7Dc9lIJGmp7w6AeHFTA1bpPAXz/jgyzgEZy5FheQsJ66djMTmF
	z9Nsamqv0t1z2mKWugsSDTPEj8E3sKHIk6AEjFyPqK6/oSZwcMrIO+bI8tpMgJY5
	IrMwW0c3TfLHwJR5aVvbSkPzJxYwfEiXS23b25CsQ/aEoBNUH5xVS1R5S3xFWQfk
	W829UjT9iTmo0XilVCjkPAsIppoBMtd1JzxGBQPXisV8udxxqGuPPeYPr51Bl2/C
	Kkv9fFUpNIG/FEHS6XnX2sCsyzFgBcCDyQErfEO+3nK/HRKOGzCiqz5yy+9XmUve
	L+x2ZATA964K5uRRaaCGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746135262; x=1746221662; bh=ItUIH4BDDCxL7qhXlr3OLbuE1wdA
	OwXrR8P++Y8h1oY=; b=E3hKXIE/V6e8Xkw28dQfqVY2+7nPJlUbET6jnBRE+Xk1
	qw2f7ZYM8X4SLmsFJ4Af5dTSebUW277YhQNh1y/Fl/Tg3uLbNsKDrXJydpjeuwBc
	4uaBj3JKQvcGQrUpnAuexS7IVlLdvU3ZYO9V2c5H04suxR84myUuJUGKc5QOeMbO
	7iyUMZMS2nEwLcA0PiYPy2uvzXp+UXF4Iq5+6Z0+AXBKEK5I4IrSEl+Q872TvJNv
	TmS/RcNM7oyYxsW3SBbCoivSZnPF70d1s1QF21qlh7rghVNsN54+Mo4LX/2bv39U
	1QgAl3+Vf7Q1htYmh+wcOOx35YyKGSy3ICguatwEEQ==
X-ME-Sender: <xms:3ugTaMzwuQy2rzLcQ-JdxW9QLam_ztPYpkeOrMca11alQZVEDOECOw>
    <xme:3ugTaATriKXVL-GM_K_ibCD9TyuyQQuAUcYEN9skx5AoET26nbPdA_APPX17WrpYB
    JGkqmB1OMkYrnqYWQ>
X-ME-Received: <xmr:3ugTaOUAgpUrUh5no3SoBp7JCQErjHiKY-vWCtufs0LvVC3IavYYla94dfKiL96chaut6MnUWMUrDLJfyAVKNFWmX70noSm3IatN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3ugTaKiLJyOjY5mTK87BTMAT0ch27aWQ8ISzms0dsF3o_xA2gWcN9A>
    <xmx:3ugTaOAqcyoCyc4st2mx4m8q-stq01pvTY-v0gJLeWOmkVk52urFJQ>
    <xmx:3ugTaLId9dIMCX3ytQGJ2pde4QKXEWu3FAeP8REi87IMMbRgrqMeZg>
    <xmx:3ugTaFAiwTngN8CurK_GkrEKm7RKu3oYeMC09HHMXn3cIOPds8Kzlg>
    <xmx:3ugTaAxhU2ESLsEdiV73IgtFrDUGaQbUys_ctrF8qaEMnxo5BM6u9Sv4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 17:34:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [WIP PATCH 4/4] git-worktree doc: update mark-up of synopsis option descriptions
Date: Thu,  1 May 2025 14:34:14 -0700
Message-ID: <20250501213414.370514-5-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-599-gc9a5c860a0
In-Reply-To: <20250501213414.370514-1-gitster@pobox.com>
References: <20250501213414.370514-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To unify mark-up used in our documentation to a newer convention,
started by 22293895 (doc: apply synopsis simplification on git-clone
and git-init, 2024-09-24), update the documentation of 'git worktree'
to

 * use [synopsis], not [verse] in the SYNOPSIS section
 * enclose `--option=<value>` in backquotes

Also, split '--[no-]option' into '--option' and '--no-option'
to make it easier to grep for them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-worktree.adoc | 71 ++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index 8340b7f028..46715cbef7 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -8,16 +8,16 @@ git-worktree - Manage multiple working trees
 
 SYNOPSIS
 --------
-[verse]
-'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]]
-		   [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]
-'git worktree list' [-v | --porcelain [-z]]
-'git worktree lock' [--reason <string>] <worktree>
-'git worktree move' <worktree> <new-path>
-'git worktree prune' [-n] [-v] [--expire <expire>]
-'git worktree remove' [-f] <worktree>
-'git worktree repair' [<path>...]
-'git worktree unlock' <worktree>
+[synopsis]
+git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]
+		 [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]
+git worktree list [-v | --porcelain [-z]]
+git worktree lock [--reason <string>] <worktree>
+git worktree move <worktree> <new-path>
+git worktree prune [-n] [-v] [--expire <expire>]
+git worktree remove [-f] <worktree>
+git worktree repair [<path>...]
+git worktree unlock <worktree>
 
 DESCRIPTION
 -----------
@@ -169,8 +169,8 @@ Unlock a worktree, allowing it to be pruned, moved or deleted.
 OPTIONS
 -------
 
--f::
---force::
+`-f`::
+`--force`::
 	By default, `add` refuses to create a new worktree when
 	`<commit-ish>` is a branch name and is already checked out by
 	another worktree, or if `<path>` is already assigned to some
@@ -186,8 +186,8 @@ allows the move to proceed; use `--force` twice if the destination is locked.
 `remove` refuses to remove an unclean worktree unless `--force` is used.
 To remove a locked worktree, specify `--force` twice.
 
--b <new-branch>::
--B <new-branch>::
+`-b <new-branch>`::
+`-B <new-branch>`::
 	With `add`, create a new branch named `<new-branch>` starting at
 	`<commit-ish>`, and check out `<new-branch>` into the new worktree.
 	If `<commit-ish>` is omitted, it defaults to `HEAD`.
@@ -195,18 +195,20 @@ To remove a locked worktree, specify `--force` twice.
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
 	`<commit-ish>`.
 
--d::
---detach::
+`-d`::
+`--detach`::
 	With `add`, detach `HEAD` in the new worktree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
 
---[no-]checkout::
+`--checkout`::
+`--no-checkout`::
 	By default, `add` checks out `<commit-ish>`, however, `--no-checkout` can
 	be used to suppress checkout in order to make customizations,
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
 
---[no-]guess-remote::
+`--guess-remote`::
+`--no-guess-remote`::
 	With `worktree add <path>`, without `<commit-ish>`, instead
 	of creating a new branch from `HEAD`, if there exists a tracking
 	branch in exactly one remote matching the basename of `<path>`,
@@ -216,7 +218,8 @@ To remove a locked worktree, specify `--force` twice.
 This can also be set up as the default behaviour by using the
 `worktree.guessRemote` config option.
 
---[no-]relative-paths::
+`--relative-paths`
+`--no-relative-paths`::
 	Link worktrees using relative paths or absolute paths (default).
 	Overrides the `worktree.useRelativePaths` config option, see
 	linkgit:git-config[1].
@@ -224,55 +227,57 @@ This can also be set up as the default behaviour by using the
 With `repair`, the linking files will be updated if there's an absolute/relative
 mismatch, even if the links are correct.
 
---[no-]track::
-	When creating a new branch, if `<commit-ish>` is a branch,
+`--track`::
+`--no-track`::
+	With `--track`, when creating a new branch,
+	if `<commit-ish>` is a branch,
 	mark it as "upstream" from the new branch.  This is the
 	default if `<commit-ish>` is a remote-tracking branch.  See
 	`--track` in linkgit:git-branch[1] for details.
 
---lock::
+`--lock`::
 	Keep the worktree locked after creation. This is the
 	equivalent of `git worktree lock` after `git worktree add`,
 	but without a race condition.
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	With `prune`, do not remove anything; just report what it would
 	remove.
 
---orphan::
+`--orphan`::
 	With `add`, make the new worktree and index empty, associating
 	the worktree with a new unborn branch named `<new-branch>`.
 
---porcelain::
+`--porcelain`::
 	With `list`, output in an easy-to-parse format for scripts.
 	This format will remain stable across Git versions and regardless of user
 	configuration.  It is recommended to combine this with `-z`.
 	See below for details.
 
--z::
+`-z`::
 	Terminate each line with a NUL rather than a newline when
 	`--porcelain` is specified with `list`. This makes it possible
 	to parse the output when a worktree path contains a newline
 	character.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	With `add`, suppress feedback messages.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	With `prune`, report all removals.
 +
 With `list`, output additional information about worktrees (see below).
 
---expire <time>::
+`--expire <time>`::
 	With `prune`, only expire unused worktrees older than `<time>`.
 +
 With `list`, annotate missing worktrees as prunable if they are older than
 `<time>`.
 
---reason <string>::
+`--reason <string>`::
 	With `lock` or with `add --lock`, an explanation why the worktree
 	is locked.
 
-- 
2.49.0-599-g90c2cffacf

