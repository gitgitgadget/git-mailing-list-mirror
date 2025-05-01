Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CCB226D00
	for <git@vger.kernel.org>; Thu,  1 May 2025 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135262; cv=none; b=mvxRQktui/eF4qh83zZWBetELyJRwsTB67Gc2QvI6RGl8+cNOqOV+E3EBqRz260HYnLfzvV4auxVZJGA6SXD+vCOK7abPa/jMZvXkwJYme/ZUppta67Skd71WvCbJb20sTtQtLMn8G8rUz1zph3BCf8UDvz2aXLEkQ1t26GuA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135262; c=relaxed/simple;
	bh=cA91fKFYm0CCXTdDuRkKnm80f303z7tXwZJ8uItEYpA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+aEyBgmUc0xxT3pqQZ/a6LnnCtaZk7rQOw82UxTDYwv4yrTu8fQkWbSCNK1sQ5tf6fJHCZ4SIbSnsodIRdC51sfRYhthMGutSePM1tMrUY/0a+q37nJF5k0irjyOoJdRFjiNsZKZRUXLmLYn9ljRHunuXl9CNxoB7nWU37iIM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g/FLzgcG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ImPGhzND; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g/FLzgcG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ImPGhzND"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B15961140277;
	Thu,  1 May 2025 17:34:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 01 May 2025 17:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746135259; x=
	1746221659; bh=yuKi0I0ObigbPubwfCnI5N3KwJ7MISO6frL+mF0YrwQ=; b=g
	/FLzgcG+QBlFXskuZIluUglw2vr5BXiYCKnceeVdumyy4QZzXmeH2Eam8FNHkSdt
	z+AewunAp3l/G+e6Ljscb4hOPVGJsbrc8rDUzXhaI+crLfkBujVcO8TVgxNZUBF4
	pbU43ak8sgargQn0vMNdml5ypXRKH9JWXQPJowmTLRrhjG0YqNEUFVlfRWuYperZ
	BZKWRB7kBb1sVP+c80gcghcs0xZbRhjmAEsxJCuJ033hvtz4o9ZszvHmt/8+DTWH
	D5NcuAP6Rp58gxVCcm9x02D3Fe1B/TbEFtlfF72ReflwMPeomXG1uDc/B2wvjnzL
	lIoPAYq3tLLsl4o9qDIEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746135259; x=1746221659; bh=yuKi0I0ObigbPubwfCnI5N3KwJ7M
	ISO6frL+mF0YrwQ=; b=ImPGhzNDr8/xcdCLsYeKcvAl2jykUc+bjmVVLerACUsw
	a4C6QYYO03fyAAyTFNYwvXhkk0YSP/XKU0Q8LZDAJ8vCevXImWmyLQ7oV3E9NK7O
	yH2Tj+T0Buf4IJfJoX3+H0eAHMa+rMVMd4Xjnkn5vIBrhGw9AnBP7Qf9ViD7V/O+
	wbgLdhSqm7Yrx9QN53DormvLcMM0O8BLOq66QGeC9gsRhBjH0edZzLC0Oi0gru0u
	p9OVwTjIjbWKDwFuuvlyBWLEqWVWO6Aj3V8ZtBr+pzb/TTeG02msm2ysN+7bQd6c
	QvMbjZ7PAPm7jKxYoQrCgLAnATbXKxW94R9eSJ+mCQ==
X-ME-Sender: <xms:2-gTaAR6AqOu4odbtFvfcvTkrO_ffM2LB7b0c9LTr04tYm8qLHsbaA>
    <xme:2-gTaNynU90o6NrAaJxSqTTPkvgl0vP4vjnuwqs0XeXFQASjbTvweMXZBxZOPxfm_
    YkhhDQWYv77t7_hpg>
X-ME-Received: <xmr:2-gTaN14nuOLPcxrpber9rdM4Zj6Xdq-OoZDjpg5L-opaHyHtuPiHvKa-2tyighOA_nJTvkPbEsYybAw-jI6eowfKjp5nZKioV9n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2-gTaEBwr6HtGV5lvKQtSXV-lS993chfP9L68X7amQBkEHzwzsUkow>
    <xmx:2-gTaJgP0K04UJU-GUbi9zR_ipz6kkE6j-zAl-j-R0gPAUrJPuAunQ>
    <xmx:2-gTaArQn6BlMTxNgkzITrUIoP16Ucv0wbGeUNjifvP-bS71On9CmA>
    <xmx:2-gTaMghyuBBDh2BtXwoRKjqzkkalnvQOIEogqa2wLg2tu2BIAXCMA>
    <xmx:2-gTaETmcP956pZCmZoeioOKqaMeG2-DZvZsGRBcj_shP8P9kJ_K-1Jg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 17:34:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/4] git-{var,write-tree} docs: update mark-up of synopsis option descriptions
Date: Thu,  1 May 2025 14:34:12 -0700
Message-ID: <20250501213414.370514-3-gitster@pobox.com>
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
and git-init, 2024-09-24), update the documentation for 'git var' and
'git write-tree' to

 * use [synopsis], not [verse] in the SYNOPSIS section
 * enclose `--option=<value>` in backquotes

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-var.adoc        |  6 +++---
 Documentation/git-write-tree.adoc | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 0680568dfd..909963b1c2 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -8,8 +8,8 @@ git-var - Show a Git logical variable
 
 SYNOPSIS
 --------
-[verse]
-'git var' (-l | <variable>)
+[synopsis]
+git var (-l | <variable>)
 
 DESCRIPTION
 -----------
@@ -18,7 +18,7 @@ no value.
 
 OPTIONS
 -------
--l::
+`-l`::
 	Display the logical variables. In addition, all the
 	variables of the Git configuration file .git/config are listed
 	as well. (However, the configuration variables listing functionality
diff --git a/Documentation/git-write-tree.adoc b/Documentation/git-write-tree.adoc
index f22041a9dc..4e1c3b9c0c 100644
--- a/Documentation/git-write-tree.adoc
+++ b/Documentation/git-write-tree.adoc
@@ -8,8 +8,8 @@ git-write-tree - Create a tree object from the current index
 
 SYNOPSIS
 --------
-[verse]
-'git write-tree' [--missing-ok] [--prefix=<prefix>/]
+[synopsis]
+git write-tree [--missing-ok] [--prefix=<prefix>/]
 
 DESCRIPTION
 -----------
@@ -18,21 +18,21 @@ tree object is printed to standard output.
 
 The index must be in a fully merged state.
 
-Conceptually, 'git write-tree' sync()s the current index contents
+Conceptually, `git write-tree` sync()s the current index contents
 into a set of tree files.
 In order to have that match what is actually in your directory right
-now, you need to have done a 'git update-index' phase before you did the
-'git write-tree'.
+now, you need to have done a `git update-index` phase before you did the
+`git write-tree`.
 
 
 OPTIONS
 -------
---missing-ok::
-	Normally 'git write-tree' ensures that the objects referenced by the
+`--missing-ok`::
+	Normally `git write-tree` ensures that the objects referenced by the
 	directory exist in the object database.  This option disables this
 	check.
 
---prefix=<prefix>/::
+`--prefix=<prefix>/`::
 	Writes a tree object that represents a subdirectory
 	`<prefix>`.  This can be used to write the tree object
 	for a subproject that is in the named subdirectory.
-- 
2.49.0-599-g90c2cffacf

