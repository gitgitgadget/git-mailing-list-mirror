Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D720400E
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905884; cv=none; b=c3JCPI9/4T440CSVUl1F+sZkxSjHpnj8d7na4CFChn+HTy33IuifioQQYiyc3B7uDVe1HnLyYjNvXmcdsgDpiKU81XQEeDwG830VLWUTy2DZgR9IR8JgldjCgqKssC8cIANRu8VxtEpEYb2IRhLU1kLIKD58aKZuK9vb1ZD4hVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905884; c=relaxed/simple;
	bh=6cgGwqd2xDdrV/LtQDf/uPURxlPtLIAgrmbT0rAH+Hc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kx1QXh3rzUPKfzZAAexeVMoFhuLpPjgPhqtfRioYUhfCy/iZcrvPR8cumyH1lh5CXIUAnTX5TEgSgppxobLSxCc2Dwda9iJ3JEK/CGmxcyeEuEXrq4oKyv4FG1xBzu/kelvrR2Lut6hg/Y4XbOXhzFOa4qc/UpaoG7iJCFapvdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MxzArfGf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D1bVJKHs; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MxzArfGf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D1bVJKHs"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C80AE1140129
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 06 Nov 2024 10:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905881; x=1730992281; bh=LrxMFhS5md
	TG5Pt1KunkHC0CfpsyYp1HV6ycRcaeAnQ=; b=MxzArfGfHOY2fd2dwP35c32JGD
	VfHbiaxslPoODZGy9d3fajmxWYgYdhq/6u1qUTsv0FLkzb6GKknBkj1JSNd6xYgI
	sZFLQ/T1JXlCMTuVkBwn7wcSCFaNm+sAPIX0tWwRH2mI0TZr2rN33LqX0ABimJRV
	nXDV48xpFTEnhG+bjW+eUahsd5p2TFLUqf8V1oX/JCg8AzG86x5iyzqzI+Xpo9gk
	KO6EsKRkU7yRFK/1NP4riR/E5NNXiR7GWw96AiDjZ50+mDvp+LfxYV57p+xNhDhd
	IyLOzx/aEaPYJeasabOHEtPEpRJXQJwMUNokAkOn70XXLwmXRm3vYBhCag1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905881; x=1730992281; bh=LrxMFhS5mdTG5Pt1KunkHC0CfpsyYp1HV6y
	cRcaeAnQ=; b=D1bVJKHs0N7+5/ltQd9WwTcA6pAjYnGxXC46aj3LmrzPSuZUAB7
	+ZIeGPP/gVRiACWaJB0UjhsVJb3xHPz+y0W8RYw0C1s4WU2QtKt2YLl43nD+3QdD
	Rl+ZtcovesikB8wAlhin/1OlQ/ur71hTyD9D8jUvu6eMQanOuhbmgXX03SabTp3V
	MZQfZKy36yl67coMRSgGFizDS0NBEUiIw+9TPWWPYl+icpIzmoiN7GIiMMzeUP5u
	l6g43Q4M7EdBLIvn7Qd0WfUVr/v1jvgoii0+l1Kl2I1iEL9eOOOG2oURelqpT44+
	Lx78Em12EHL7p0wzXV4f/7IwCtIo7NBHwyQ==
X-ME-Sender: <xms:GYcrZ-NvogueknPF2964Sb240Uom_-AVGqN3bC5lpqrs7ehtjxPlIg>
    <xme:GYcrZ8-x6SuJaW_m47GvUQtquEnuQHMipzq-eAaBo4X1RQepeiJLFmIz9sXwXDCt7
    I2XI5tnsF6O0gbBkw>
X-ME-Received: <xmr:GYcrZ1QHdQyeE3fkSMcH6B6g6mgmYN7_I8RCFEUDW8Vp1RjOM4h0wiFVFaE2hmvrVek46FjXmkjA7_vmvgIP4jX3pZge87QZbZIlhDIxITjIvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GYcrZ-sCvVC60sumM7fTVqe24v55onsjA8nwXRpaa-p7jELZ58VFKg>
    <xmx:GYcrZ2ckAei882EnMGQzBiJsrrrxRedzMzYqO_vARU64-kuYkmoEEQ>
    <xmx:GYcrZy2mCzHxzsGOA0qjxZ2fClbgkX_07sWrbR8rfeg3EBL0r0bmJA>
    <xmx:GYcrZ6_AWwPyB4c4jB3ZP3pxu5oNTmepGjLtgUSToDVnqp-HWdLohw>
    <xmx:GYcrZ6Fge0nAtCUPm4ShUjNSQRHyiuiToNV0-YaDccB0Dn5LaL6Fzz6A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 038b1543 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:56 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:11:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 18/26] builtin/init-db: fix leaking directory paths
Message-ID: <256427084f63c9b2141bd468d633ee4d079fd33f.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

We've got a couple of leaking directory paths in git-init(1), all of
which are marked with `UNLEAK()`. Fixing them is trivial, so let's do
that instead so that we can get rid of `UNLEAK()` entirely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/init-db.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 7e00d57d654..9e069e27426 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -75,10 +75,12 @@ int cmd_init_db(int argc,
 		const char *prefix,
 		struct repository *repo UNUSED)
 {
-	const char *git_dir;
+	char *git_dir;
 	const char *real_git_dir = NULL;
-	const char *work_tree;
+	char *real_git_dir_to_free = NULL;
+	char *work_tree = NULL;
 	const char *template_dir = NULL;
+	char *template_dir_to_free = NULL;
 	unsigned int flags = 0;
 	const char *object_format = NULL;
 	const char *ref_format = NULL;
@@ -106,6 +108,7 @@ int cmd_init_db(int argc,
 			   N_("specify the reference format to use")),
 		OPT_END()
 	};
+	int ret;
 
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
@@ -113,12 +116,10 @@ int cmd_init_db(int argc,
 		die(_("options '%s' and '%s' cannot be used together"), "--separate-git-dir", "--bare");
 
 	if (real_git_dir && !is_absolute_path(real_git_dir))
-		real_git_dir = real_pathdup(real_git_dir, 1);
+		real_git_dir = real_git_dir_to_free = real_pathdup(real_git_dir, 1);
 
-	if (template_dir && *template_dir && !is_absolute_path(template_dir)) {
-		template_dir = absolute_pathdup(template_dir);
-		UNLEAK(template_dir);
-	}
+	if (template_dir && *template_dir && !is_absolute_path(template_dir))
+		template_dir = template_dir_to_free = absolute_pathdup(template_dir);
 
 	if (argc == 1) {
 		int mkdir_tried = 0;
@@ -192,7 +193,7 @@ int cmd_init_db(int argc,
 	 * Set up the default .git directory contents
 	 */
 	if (!git_dir)
-		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
+		git_dir = xstrdup(DEFAULT_GIT_DIR_ENVIRONMENT);
 
 	/*
 	 * When --separate-git-dir is used inside a linked worktree, take
@@ -213,6 +214,7 @@ int cmd_init_db(int argc,
 			if (chdir(mainwt.buf) < 0)
 				die_errno(_("cannot chdir to %s"), mainwt.buf);
 			strbuf_release(&mainwt);
+			free(git_dir);
 			git_dir = strbuf_detach(&sb, NULL);
 		}
 		strbuf_release(&sb);
@@ -245,12 +247,14 @@ int cmd_init_db(int argc,
 			set_git_work_tree(work_tree);
 	}
 
-	UNLEAK(real_git_dir);
-	UNLEAK(git_dir);
-	UNLEAK(work_tree);
-
 	flags |= INIT_DB_EXIST_OK;
-	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
+	ret =  init_db(git_dir, real_git_dir, template_dir, hash_algo,
 		       ref_storage_format, initial_branch,
 		       init_shared_repository, flags);
+
+	free(template_dir_to_free);
+	free(real_git_dir_to_free);
+	free(work_tree);
+	free(git_dir);
+	return ret;
 }
-- 
2.47.0.229.g8f8d6eee53.dirty

