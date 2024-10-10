Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544B18BC0F
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728585587; cv=none; b=fflTQO71GNVLGrd1HCwWAxp0nH6rZyKvqF17MJlhzRr3Ftiy5tCEFn2rVARvhMmFLEVqTsHwy5j+0cEOz515wouU70BJJ2eHrDqbUHB1fjN3xgs52Uo5D9ZmlAmJJlS1GPNfkI1eNf5lf07wZomaoua31ybCrhk+X/Y8JJH5CKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728585587; c=relaxed/simple;
	bh=+6EvGTdtTyUjkmX8nHm+u25ZlDszA5zGQcQdgxZrXe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pp9CCK06rO43ji2kSYLc6koPEpL/ORGGGcEN94METIOQV8aeIsa5e5ou8kLaP7WrxSnv+N4fnnuI7nh+V86ZgrIVYkU0aWCTIyqm7oXSM6WYU95gRCik81bsCISSHkChmxkFRlc2hdHhdizoU8qUDJdFC5rCtGLbhvReWnxRPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YWkxBwf8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MQKHChfC; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YWkxBwf8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQKHChfC"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6CB8011401EB;
	Thu, 10 Oct 2024 14:39:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 10 Oct 2024 14:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728585584;
	 x=1728671984; bh=EzZ0l2GOx2JIpEvHw9UiA9PR61SoYo00ryb6SDk8upA=; b=
	YWkxBwf80PXW/5Dsh+OCj8T4RnzqQAcoZoOXyyi3m+qBfKWw1aa0/PevM5fwrif8
	3uRqlU4giOx7uDDBES3yemlntEWIpInTxDp2QKWICB9QVKEgK4GpZ1/Q2MLPxwA5
	nHucQw5FFJwGi8bbikC6obrIWLTIN3jrgiu9/ew75+2J/rHkl5/ajQzyN5vpw5vz
	b/O9jGRfC7skjoUps1KoCRImOV2JrukyxsLT0dJfGF1DhHeS+yFmHDPV/GyHI4t+
	lXTfzdeGXYSSKO3BHwrjoJF8pbXt4GGkuGIvicgtxGeeC64/mvySaCo6VHF/KWmZ
	1eHIE/4McnsnREeI675lNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728585584; x=
	1728671984; bh=EzZ0l2GOx2JIpEvHw9UiA9PR61SoYo00ryb6SDk8upA=; b=M
	QKHChfCyMJlzwji9iU35/OkZ7rSh8DhIQaeOE/ccVeYaxsQcGntjOf8qS+VuPOfH
	RzoU9rJPZgc0nJqwC2cYnK4vHlVNQLfgAH1b++S/BRjGjn7mFA7ph+ZI/hR+zYvx
	6w0gAhxuKZbl34saLM296qgpamP5VW+UYMRU7znbY6zh1t/8fBbAuMFlORUNsfCv
	/vl1FJDJOI+z/1SLNk902pQfxcZx8dH3onY0F+9wFztn8aCUGTbmSU/We1e1Hqlf
	0VOR62yNXj4G+ctBFDchgKKLaORuDZdUGEnrBQdBA6pGa1V2nRUM6zHH9W2YQD4x
	/Tqydh6KPEQYa1IJ1HWqA==
X-ME-Sender: <xms:cB8IZ1UQfcUlnevqfB0UBqnoywflZrJ_BvH4IpjHmTmvulHzEXrZFag>
    <xme:cB8IZ1luPn_Pt05uTwnXpozhcC2i1MK-Mw1domu5fvoBF_JtJO55mbP1HswMjSYOz
    3jMXAcerFPassZnog>
X-ME-Received: <xmr:cB8IZxZKJST3dve3R5aY3Zl0jNuGYSpsVIJTTkKPMA6nwd5eobeKPOBVFMx8Hpr_NF6OLnkKhvXZf-0pgiHZEsb3oWYeq50nVAO_ZXao3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefiedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cB8IZ4W7m4kBTZ4bpQv3em6blcQjoNKxbXq6ZZ_gUvs1m1LRpvXZcw>
    <xmx:cB8IZ_kZqPLJxW8qemsAmemtbCdggozVS9BfV71feKUDrnQ-r5PoJg>
    <xmx:cB8IZ1dhW7noDTGEMt3gGk_eKt00e-Z1QFp-Ye-LWpuckuxaoXxaew>
    <xmx:cB8IZ5EtLqb4NuCIeeaPClCrLGoL0hHSo9GjdY3kid7ZcuvVwQlhmA>
    <xmx:cB8IZ9j6d6YQkcze34rVd6HFtiriVO7IEgNg2KHzRFE5BaWNSObKn4xh>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 14:39:43 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	gitster@pobox.com
Subject: [PATCH v2] checkout: refer to other-worktree branch, not ref
Date: Thu, 10 Oct 2024 20:39:29 +0200
Message-ID: <fcfbcd3868bda75dd0463e04739047e74d239d32.1728585467.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <259fcbb61f13873421d50df77f151130fdbf0166.1728494795.git.code@khaugsbakk.name>
References: <259fcbb61f13873421d50df77f151130fdbf0166.1728494795.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: fcfbcd3868bda75dd0463e04739047e74d239d32
X-Previous-Commits: 259fcbb61f13873421d50df77f151130fdbf0166
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We can only check out commits or branches, not refs in general.  And the
problem here is if another worktree is using the branch that we want to
check out.

Let’s be more direct and just talk about branches instead of refs.

Also replace “be held” with “in use”.  Further, “in use” is not
restricted to a branch being checked out (e.g. the branch could be busy
on a rebase), hence generalize to “or otherwise in use” in the option
description.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Commit to replacing “be held” with “in use”
      • Also mention “in use” in the commit message
    • Add “or otherwise in use”
    • Flow/format `--ignore-other-worktrees` paragraph since a line was
      getting long
    
    ❦
    
    (from v1)
    
    I also change “is holding” to “is using”.  This has plenty of
    precedence:
    
    1. The code ultimately calls
      `builtin/checkout.c:die_if_switching_to_a_branch_in_use` which says
      that we die if the branch is “in use” by another worktree, just like
      we do here for the new description string on
      `--ignore-other-worktrees` (c.f. “holding the given ref”).
    2. `man git checkout` uses the phrase “in use by” when talking about the
       branch being checked out in another worktree.

 Documentation/git-checkout.txt | 8 ++++----
 builtin/checkout.c             | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 8bdfa54ab09..bf26655764f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -290,10 +290,10 @@ Note that this option uses the no overlay mode by default (see also
 `--overlay`), and currently doesn't support overlay mode.
 
 --ignore-other-worktrees::
-	`git checkout` refuses when the wanted ref is already checked
-	out by another worktree. This option makes it check the ref
-	out anyway. In other words, the ref can be held by more than one
-	worktree.
+	`git checkout` refuses when the wanted branch is already checked
+	out or otherwise in use by another worktree. This option makes
+	it check the branch out anyway. In other words, the branch can
+	be in use by more than one worktree.
 
 --overwrite-ignore::
 --no-overwrite-ignore::
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9c30000d3af..c449558e663 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1716,7 +1716,7 @@ static struct option *add_common_switch_branch_options(
 			   N_("update ignored files (default)"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
-			 N_("do not check if another worktree is holding the given ref")),
+			 N_("do not check if another worktree is using this branch")),
 		OPT_END()
 	};
 	struct option *newopts = parse_options_concat(prevopts, options);

Interdiff against v1:
  diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
  index b00b375dd27..bf26655764f 100644
  --- a/Documentation/git-checkout.txt
  +++ b/Documentation/git-checkout.txt
  @@ -291,9 +291,9 @@ Note that this option uses the no overlay mode by default (see also
   
   --ignore-other-worktrees::
   	`git checkout` refuses when the wanted branch is already checked
  -	out by another worktree. This option makes it check the branch
  -	out anyway. In other words, the branch can be held by more than one
  -	worktree.
  +	out or otherwise in use by another worktree. This option makes
  +	it check the branch out anyway. In other words, the branch can
  +	be in use by more than one worktree.
   
   --overwrite-ignore::
   --no-overwrite-ignore::
-- 
2.46.1.641.g54e7913fcb6

