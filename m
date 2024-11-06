Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2292022EE
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905870; cv=none; b=DMMsCcURsTdCqUEgMquWKIU8Vx7rZ3xGmobi+sYH/B/3tRSmw+HBZwW3Nsu4E5JlLjpr3yeRV7i/yZVKID0tCZqTluULeKKi3f2662X+BDEY9NVffn5rBBQQCp9/M9rh50YId5j7VSzJa8VWi397uCldrignGhlpiI0TKgDmyc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905870; c=relaxed/simple;
	bh=zBHoayYeNEMc/FAS06+jRlwmytO/tZuJkS9zy2MX/sQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFqY6IfXHE8vOLewkzPVmGVL6Xdw4Q7w5F+B4uvrI9gpmdtb7HiomJSx63Iio0VqO/bY+yijRL4TDo9XlXUF+incUIbWqTs5XuBzI0ISxQrfDZyhSz3/8u8uH/E/LYZfGEaOK9Dltw8U0RqXvDRBeq2UYXB+yUGYWjnnA9AwUuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BXcXKUPu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K3LhRdze; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BXcXKUPu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K3LhRdze"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 47A8B1140196
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 06 Nov 2024 10:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905868; x=1730992268; bh=KSvy6IX80F
	ZorxX4ZpfbtHmfuwoiryygn27gLRpYRgw=; b=BXcXKUPui+eFxQEiooPpDDy+cQ
	0jr/6q+mJIwbnmX6bFWuRbpMtr3nW8nCOxL6KVRnssmGDSylOwQ4jbDSE6XhQiWf
	PHrpC/vuAMFDMDeg4x0YNv/RhDit8DABZagTNGRB8FzJPIUe3S3bHJrB0w8e6LLt
	xRKJaqMg4/L84K4p8NjcgqyY8eMRrRCgaYal5ph+oFzUhxxKY+HOkSXkYC+aUmNW
	BD0SkQnW8AndDH70zMYf5k85yTdu0/SEifHg9vnANsVrqPx03RJBwSq68cA4f2UR
	VszLIfImvHf7WaNXjpnXaQ0JqNL317V0rrkUr9Mt5aeK+j6w2ba/UWdExGgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905868; x=1730992268; bh=KSvy6IX80FZorxX4ZpfbtHmfuwoiryygn27
	gLRpYRgw=; b=K3LhRdzecTYMf4Bzt1ndsAPNgLyZ4xJiBI+Li1BXHi9Z3WORa3t
	0ECCGp5btZjPj8a5jfsFvPh5RMxVHB6tUGxsl2JnMFrhBj0P4YzF30m47dKBouWW
	qbTFUAPggWg4zcQ67lGVyRqCuiSt4y7E6ufmQkktGF0JwgLBXpSx3cKzJArQL1WG
	9yYxKGI8b8xgh8qAVM55wKG6O3jG1n7b050bk0aW3jXJ1k0jVQYzxXNIfr0N2Puy
	Zd0G0JfbxeKmRrnEOl+c+hJ88PWM1bpyJfwB+9/0AqPCmepl7/kE/iUzJqtDkoAB
	VFTaivDNw8xLVHWIYio51dLPSnB5J8totKw==
X-ME-Sender: <xms:DIcrZ5uW3bUIFpb9zTTMLRPLwBGbdsjdzwf0v47Iny_oM_0zTPQnNQ>
    <xme:DIcrZyd-gg20QSD662GpgaXZxt6Vqy8hk97DlCW5vTf-KPAzqv53LDCsQEcPTIVdT
    C0toILhriAcDyB3Zg>
X-ME-Received: <xmr:DIcrZ8wYOxMuoZZOjtgodf5SkFTetMPgPPaptqc6aROV1PbRvBuUBIAvSDQhfC-yoWfA2SmSe6gCxc08-CBkHNs0t43h4mPt4Pqf38T5fK4PTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DIcrZwNDZFE5Jk67xaFIEhm7JKzZRS6GtZr4d9aaDpFLTDhkd_MfPA>
    <xmx:DIcrZ5_-7Fi4HvgcyTw5qZe7T96lKO4GeY8G9BNlHMIF2QhdYQlnKw>
    <xmx:DIcrZwXgJecDrLj2tt0EK2CCxTAaMgq8Cqjm6fMgmJ8hJOqkdyjUgQ>
    <xmx:DIcrZ6dxnr-DInbPdCgmls73uydc12QHdF2_v249AF3jAF9H1AFMsA>
    <xmx:DIcrZ7mLUWsBGnqP7StEeCDmlvgfIxlo9c51RADWYbzUdjpQ3BRJlKd1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 19c40e44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:43 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:11:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 14/26] help: refactor to not use globals for reading config
Message-ID: <865ed1f597181641cd0163b05351521315fc6d5e.1730901926.git.ps@pks.im>
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

We're reading the "help.autocorrect" and "alias.*" configuration into
global variables, which makes it hard to manage their lifetime
correctly. Refactor the code to use a struct instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 help.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/help.c b/help.c
index 4ad4ebdd2cf..8794f81db9b 100644
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

