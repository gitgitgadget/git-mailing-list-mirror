Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF874192D6D
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321541; cv=none; b=XXgp8qPX4zd73StZ5obSUsKFiRo+BB5OfZT8GbH0Sq+uo5H/aHCmCfAmHMhVWLFG3UZ+vPZfwiHi/1Mk9fXEXtlzKlbHFoBRjz3pX6PnAcsYsGo2iMNWyJGfG9Ik4h2a4Bm7Bgjy2jGwUsqH0VEYRzw5BzZACvcVTaAQ4eSXf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321541; c=relaxed/simple;
	bh=xn0aqucqDia969/fqtlMOMnoMz+rjCVtP2xShOQoLgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNlkdN3Vx45mb1243XkZROvevZj/5OZe1/xe7FZsrL+7sEl1ftJpiRRQYZgskiLx+FRI76PNtyHZgqZBtxMGh99nLs8g0oAimJsy/vVZsaj1EsPKQZqrzxOT/h2dpQ6uIsS4K0GYBBWUtILpU1YYU8DC4pOTo9O/YEcK6ummeA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AMDtMmmj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jahGk/hi; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AMDtMmmj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jahGk/hi"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDB81114015C;
	Mon, 11 Nov 2024 05:38:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 11 Nov 2024 05:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321538;
	 x=1731407938; bh=brl8hItrr35jWbzklh6mC4sKOjCgfTP9SVSETi4672Q=; b=
	AMDtMmmjY7wclyB6KHePVUXqZk4kXTTAMlO/rqLFkJvRcgzH0IrY5PM52gYmjnJa
	U3WPisDdomwO1wKD1XnJaBqFyHAFf1K75wcxIlvNFdnX1naflCEix5+KvtOzs3eb
	jdcMqU8jHk4SaB3FjCBADQY4tTiTyRAyEOqrgOQg6vZsH3/Q0WX/dxSLlV+omx9/
	k0Hep5vGs6SnwOBeUkkRecKnA8WvSh/oeHYqn4uTNbZ/uC6G4Wx4wK2Eq4tZTeZn
	TN0Y9hIAP84Fe78Vd694BUSQgob9wxU3e6TKRSg0T+64X9j+IgiiyvZ/8rSp4ypT
	js0g+Vjx1kyRZx5hlH+BVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321538; x=
	1731407938; bh=brl8hItrr35jWbzklh6mC4sKOjCgfTP9SVSETi4672Q=; b=j
	ahGk/hiwJLtQpFkLSAXqEo6keJjQSMZlT5lIRN1onvvkmD9mM+K7RXqYnsJ6IqsL
	6asAnmxTg4jr3Tmowc1cdfnDSX8RVqPKzYwQlCFT72DAIjBP7RAyNKF58N/+6m9Z
	4XHUtXsR0wFxOf/3EDu7c2zvttO3Bzfbj8wtr7X0ZUdqcp8BPR4vORL+KGMECcRO
	OvgCOggaU946H6pBSICmE6NrINy+WRVA/wCHpgTrhRG8roKiLA0aDwC2082Jgc7A
	Rn0Hbt1cdFla0dT3qNZfM4sj9wx6WzsNlT5WUB2/ii63/A9sFkkoGd0zHYDi5gw7
	0lO3iO23h/DP1J5zbWLcA==
X-ME-Sender: <xms:wt4xZ1TcRiWZgozSyuKUWizSSl1F6wfKXsDKgnHZDO3-NzW0Dza4BQ>
    <xme:wt4xZ-xjhcYu6WP_BcfbQP8hqOcA0DbTHYnMD_FNqgPd3z4HN5nQlCIx4YTFjONRc
    1SDnJLYgb7KqfnvYg>
X-ME-Received: <xmr:wt4xZ63rgRtNOeAJyPIl87q_urHHcG2MiSR0kcGq36HjpmaK5pH8FckU57MeBQTXugHMXI6YwrKdcbv_DJ8GdHaLA1I92ki3ZeL4HTzKHeGFaUB->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wt4xZ9Aybv4f_TQ5Ce9MXJRIa2lwTmMYpqWsgbptr0O8IVMyINWPog>
    <xmx:wt4xZ-hGlspxAh6-Rfn9wIJZsyINiwGCOATah5BOoeLAvAcGlrbGtA>
    <xmx:wt4xZxo9d1QtiwrtMyFmnQMQcL-jCxu3O7zrknWsQldvLKw2NtlUsw>
    <xmx:wt4xZ5jxP2raxfUcZKBDjVYrBTpmEGm6IcrOWpMtLXwvUbXLZivq9Q>
    <xmx:wt4xZxtJvIdGvG_YoounjGZyXAnpqdVAa4widzA2lGLBiH0h_fWc06JH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1384e290 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:43 +0100
Subject: [PATCH v2 14/27] help: refactor to not use globals for reading
 config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-14-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
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
2.47.0.229.g8f8d6eee53.dirty

