Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D601A7AFD
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110004; cv=none; b=O1DbsCot3OT+VTmCRwBzi0Ve9SmjYYDvNy8MgWDPDb6PNzXKL08vkKFuERLxDQ24criNN92KcPEBevvufVdIR9jQ0qlengMMNrYFeMHSDRwao5vxS2COmCW2FI0UjOfcqhQbk4mfvVjzoweqPdEH4eVNIKzkIDuu3cosZ096OLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110004; c=relaxed/simple;
	bh=sbXkNOKQpbbecsDr5C9PLV6H4ciO0eQRzGH6OuGWcbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T5705D57XgmDeaYr3xHIawAYvRlni2euoMMV18Sus403duXm4xNpjYZoCBZxG8W5TyLIbq6AeOJhri2w72ZzZTuUEjtLl+XAvFsvH8zLn18O29Z6r81/zHux0wJ8FvFseTRHfpWmZfFhgH+tsnw7cWjJq7VVYN0vYRx5O5qDFPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hb5/kvLX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g8lu3yD1; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hb5/kvLX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g8lu3yD1"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFCF911401D2;
	Wed, 20 Nov 2024 08:40:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 20 Nov 2024 08:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732110001;
	 x=1732196401; bh=ZnyHn/uuEWFye+tXCYvshtxfLvUOwiPBZmsRbngxiG4=; b=
	Hb5/kvLX8NEeEtWN4hlYO1Snlmi8IyD+AKzYIvW25M0F4GQRmcDopn1lNr81D+m0
	KtWTQjEChVA0KLgF700E7YVvHBZEKZG43I3gw11/5CKjuowYmBxeTUH3FVAfJSay
	DnVWWwjSxEVaZ0TBcaIWqpNrdWzqyGIVacL0liaqQwgOWEQIY/gMtHuC9Fs25/NE
	2srHhfwTPjcGhUVb1JcFpFpyodQdLInI3LnzZXUbqXZ4dW4bCskWuejIFcvHsUtU
	RM6PYvsPquCzUz8brcAVVRKjZ9ibRDXBfTMCNAHuDwXzGnbMqv9crQmzdnciXQBb
	Oo7uVuHiV/2+nepK5u8IMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732110001; x=
	1732196401; bh=ZnyHn/uuEWFye+tXCYvshtxfLvUOwiPBZmsRbngxiG4=; b=g
	8lu3yD1hI+utbmBqG+hz/CIZN6KKS+kGOd4BSpPAOx3Hoj1X4VQKSA5P5F8dMrfQ
	GFXMwy/Yss2900RClCaGI5/9aOPfGR6PD8vthdu52HUy96UGdJTDq4T+T1xeIWGI
	GVR1GZGsb7DYl/Wz4uU5zTM6MxDNLijvvBMn6cEPidp3TRl+4lvEX2LHCZzKXGC5
	+OrHnUVESfzbOmrgtxdMOLuhuH9ycObz1j+6RIgS0b3OUfanvm7S2N11z5qkqkyr
	mMT1w2KOqn0tCc4CBsfIbXKL1akA7SHHANpIL3WrX6IjMqludhIrtTDMH33lO8Sm
	DzjlctSQISTE2T7vnsFyw==
X-ME-Sender: <xms:seY9Z5cTPrIK1HX-CHXvWQAxyZgdqcLKdQH6K1ZfUJrtFx2Je5-Pmw>
    <xme:seY9Z3MdMvMi8Ph-nVF8LNLmfbWKbJ9F5cCCl-m-jVQvSnaDuKWNXSduHNdR71AgQ
    cuCambO73cRgrFhMw>
X-ME-Received: <xmr:seY9Zyg0MGpeYM4JrDohCgSA9hZrGLpGJ9s185qs425yx2nTktzH0fATLGPliMhEloVuoO1XQS1i5SSTD4eehhrq1rPnHqe7La4-XdoM5xs8kQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhjuhhsthhosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:seY9Zy-RJY-oXgMJwetltdYCowKhiYkA4YDAqWcKhOHda5BXjrsBOg>
    <xmx:seY9Z1vPBonvjQMUhxHmP6jZXr93Ku8wMkr7yRDhsKj0ppyIH7i7Aw>
    <xmx:seY9ZxGo_Ai1IOHaNV_gfh9kesKIsZKSAhOrcttg1myXQfWHnCMljQ>
    <xmx:seY9Z8Nm3PKc0dfp3bjI3GsggSv9PGN05EeJ41a6SUbwRRx_2DeEJw>
    <xmx:seY9Z_LqXH6MQjoGRQtQmz-y595dqhuNRTzk5czF72BSOwlB0ghJF8Qj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:40:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a066794e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:43 +0100
Subject: [PATCH v3 14/27] help: refactor to not use globals for reading
 config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-14-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

We're reading the "help.autocorrect" and "alias.*" configuration into
global variables, which makes it hard to manage their lifetime
correctly. Refactor the code to use a struct instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 help.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/help.c b/help.c
index 4ad4ebdd2cfddb3191bb4f6d593a55d3c5d3ed14..8794f81db9bbf457b7cabca59222299922f3cc7f 100644
--- a/help.c
+++ b/help.c
@@ -546,8 +546,10 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 	return 0;
 }
 
-static int autocorrect;
-static struct cmdnames aliases;
+struct help_unknown_cmd_config {
+	int autocorrect;
+	struct cmdnames aliases;
+};
 
 #define AUTOCORRECT_PROMPT (-3)
 #define AUTOCORRECT_NEVER (-2)
@@ -555,28 +557,29 @@ static struct cmdnames aliases;
 
 static int git_unknown_cmd_config(const char *var, const char *value,
 				  const struct config_context *ctx,
-				  void *cb UNUSED)
+				  void *cb)
 {
+	struct help_unknown_cmd_config *cfg = cb;
 	const char *p;
 
 	if (!strcmp(var, "help.autocorrect")) {
 		if (!value)
 			return config_error_nonbool(var);
 		if (!strcmp(value, "never")) {
-			autocorrect = AUTOCORRECT_NEVER;
+			cfg->autocorrect = AUTOCORRECT_NEVER;
 		} else if (!strcmp(value, "immediate")) {
-			autocorrect = AUTOCORRECT_IMMEDIATELY;
+			cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
 		} else if (!strcmp(value, "prompt")) {
-			autocorrect = AUTOCORRECT_PROMPT;
+			cfg->autocorrect = AUTOCORRECT_PROMPT;
 		} else {
 			int v = git_config_int(var, value, ctx->kvi);
-			autocorrect = (v < 0)
+			cfg->autocorrect = (v < 0)
 				? AUTOCORRECT_IMMEDIATELY : v;
 		}
 	}
 	/* Also use aliases for command lookup */
 	if (skip_prefix(var, "alias.", &p))
-		add_cmdname(&aliases, p, strlen(p));
+		add_cmdname(&cfg->aliases, p, strlen(p));
 
 	return 0;
 }
@@ -611,30 +614,28 @@ static const char bad_interpreter_advice[] =
 
 const char *help_unknown_cmd(const char *cmd)
 {
+	struct help_unknown_cmd_config cfg = { 0 };
 	int i, n, best_similarity = 0;
-	struct cmdnames main_cmds, other_cmds;
+	struct cmdnames main_cmds = { 0 };
+	struct cmdnames other_cmds = { 0 };
 	struct cmdname_help *common_cmds;
 
-	memset(&main_cmds, 0, sizeof(main_cmds));
-	memset(&other_cmds, 0, sizeof(other_cmds));
-	memset(&aliases, 0, sizeof(aliases));
-
-	read_early_config(the_repository, git_unknown_cmd_config, NULL);
+	read_early_config(the_repository, git_unknown_cmd_config, &cfg);
 
 	/*
 	 * Disable autocorrection prompt in a non-interactive session
 	 */
-	if ((autocorrect == AUTOCORRECT_PROMPT) && (!isatty(0) || !isatty(2)))
-		autocorrect = AUTOCORRECT_NEVER;
+	if ((cfg.autocorrect == AUTOCORRECT_PROMPT) && (!isatty(0) || !isatty(2)))
+		cfg.autocorrect = AUTOCORRECT_NEVER;
 
-	if (autocorrect == AUTOCORRECT_NEVER) {
+	if (cfg.autocorrect == AUTOCORRECT_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 		exit(1);
 	}
 
 	load_command_list("git-", &main_cmds, &other_cmds);
 
-	add_cmd_list(&main_cmds, &aliases);
+	add_cmd_list(&main_cmds, &cfg.aliases);
 	add_cmd_list(&main_cmds, &other_cmds);
 	QSORT(main_cmds.names, main_cmds.cnt, cmdname_compare);
 	uniq(&main_cmds);
@@ -693,7 +694,7 @@ const char *help_unknown_cmd(const char *cmd)
 		     n++)
 			; /* still counting */
 	}
-	if (autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
+	if (cfg.autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
 		const char *assumed = main_cmds.names[0]->name;
 		main_cmds.names[0] = NULL;
 		cmdnames_release(&main_cmds);
@@ -701,12 +702,12 @@ const char *help_unknown_cmd(const char *cmd)
 			   _("WARNING: You called a Git command named '%s', "
 			     "which does not exist."),
 			   cmd);
-		if (autocorrect == AUTOCORRECT_IMMEDIATELY)
+		if (cfg.autocorrect == AUTOCORRECT_IMMEDIATELY)
 			fprintf_ln(stderr,
 				   _("Continuing under the assumption that "
 				     "you meant '%s'."),
 				   assumed);
-		else if (autocorrect == AUTOCORRECT_PROMPT) {
+		else if (cfg.autocorrect == AUTOCORRECT_PROMPT) {
 			char *answer;
 			struct strbuf msg = STRBUF_INIT;
 			strbuf_addf(&msg, _("Run '%s' instead [y/N]? "), assumed);
@@ -719,8 +720,8 @@ const char *help_unknown_cmd(const char *cmd)
 			fprintf_ln(stderr,
 				   _("Continuing in %0.1f seconds, "
 				     "assuming that you meant '%s'."),
-				   (float)autocorrect/10.0, assumed);
-			sleep_millisec(autocorrect * 100);
+				   (float)cfg.autocorrect/10.0, assumed);
+			sleep_millisec(cfg.autocorrect * 100);
 		}
 		return assumed;
 	}

-- 
2.47.0.274.g962d0b743d.dirty

