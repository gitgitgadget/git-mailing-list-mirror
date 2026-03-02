Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BBB364942
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453600; cv=none; b=f7SG/nWaaVaJ8gqv9xrfJRi3S2cTlxt55XJ5UtUkmnSf48laAduhtnXsZqGaQeapiUNRIhKX3R2kP8oOP6WORjyhgfzG/EpPvtSCWpv9Jtcg0EUEYzjXtgB+s39WESdoZLAmzXt0qDQQtfql0W/6egTn27IHH8zEUwws8KP/HfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453600; c=relaxed/simple;
	bh=wYgT/niU6FXJUhkPPYX/S60sZibb+Xq4L2fOlj4cxec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rb8q6VOYNwnwg05G89qjzLXfi9+eElH/iL0dZ4AJsT5ywYbvcGJD0GcDQoIKgUkMNOqRSiLw3TmGK5IZ+I2xGTkOABTtrw9oeMG2Z55lgtwviGYHWzf5PXqYj2tftSgtLaeWhv+thqNEm3WJactkEnE8MhnUT9zouzVII9DMEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NkY8mEgm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+u8UI75; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NkY8mEgm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+u8UI75"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1A6351D00078;
	Mon,  2 Mar 2026 07:13:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 07:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772453596;
	 x=1772539996; bh=ey4G5dJl23KvkeCYCXUr6acQVl1qjb9Ah+RKboxbeP0=; b=
	NkY8mEgmBm6tUD3c1oN0AiLCSjnrB17gZdqL4lyf6+0CxnQbG3f/etJLJ9yNdZ9S
	dBm9UQHFBo7bncrDMWyw8bSAtAHmM3jjuy88nosuNaCHLARQeO3fxog5VXwh2P6I
	7iRImKnUhMAY2EzBGyDlixz1Ym3aneATrrShXnbdCYbC9daEVsifxe/ufQ2q306t
	rKlxwe0dh9j29Bv/m9OWlg5Ka2GsfVdfX9RQZwJUZsOMXSWgWuHfWTHd/WJ4xHLI
	LeT449ZdZ1g9XXYFL1o4MEYUwltKsjd6dqbcPs+tBNMhYupnUyCMBepKe9sZ8pkk
	m1PgqQFAqzOPlj3yBb/I4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772453596; x=
	1772539996; bh=ey4G5dJl23KvkeCYCXUr6acQVl1qjb9Ah+RKboxbeP0=; b=a
	+u8UI75V5TFhaaMdnBrLk8A8sNdk9P8UvZW/aTL1y3gRo3WgErm1qCoBiDIJM2sg
	qj3pwnT6ZBeAbdL+kxfUMXq3tRJnpspdjRt5gNXfYxCPLj6wG5xlZQLVSzpATqVm
	4QUQaMVJRta3Ucl29X2TNDu7Mm3/m4HqP0FoLjpC63eROxb+G4cbJRdlOB7Ig7ff
	xGIq9tEqdVJMirVBb8Uxz1wxoZpNPPQsSzjH4mhAZCvrIl6lb2vog7obERzzU+Co
	0H99DU+aGjq5WMZZBWXFPHyzEZvnm5LFm0Frfh993NFIR7Qmvndq3qphZheNISe6
	egKYp3q0pXu9pnYNG1QuA==
X-ME-Sender: <xms:3H6laYwp7VCTSpDhuOfu5ABlukPQ8hRbtzWz5L_edIzkeT1lBeW9JQ>
    <xme:3H6laSQY8hVDwZSbuM8z9IEILaSXGC93MWBUF3TgcVcCk_vSOUmAEBCesScLoQ0-x
    2QknCPxevxjTQj3BKSV93JqInAQRIP0wJ07DyvBVNx5r3jKbDXmXQ>
X-ME-Received: <xmr:3H6laX-VPYea0e-Qx6g8uRCE-uiopssJA4IkeXIEitNiSGN0aX5YaNe4Om4lZ1YR_QO4LerzccY5chGIW3dtFdBCRbCI54EWCFrMSvdhGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeifeelheehheetgeefhfekgeffheevveetfeeltdejgedufeeljeehtdehvdevveen
    ucffohhmrghinhepihhnthgvrhhhuhhnkhgtohhnthgvgihtrdgruhhtohdptghfghdrrg
    huthhopdgtfhhgrdhhvghlphenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3H6laRoKdwQPyKfwSC4M7akuxjkRKqrwrnXA_NbFg25RiB8U3sQh3w>
    <xmx:3H6lackmgZ_lnT6UjcCwu51h7jsZ53CS1Jg0rkVTALDSNX7eZnrXTw>
    <xmx:3H6laQIFup8hpdwMXRyrmHSCj7zhXR-f0QGanqX_nkfGX14-s4yUTg>
    <xmx:3H6laZygIFgfbkQIi1z2S__u3yWCOXbO8lZTV8z6BkT6Dlrmuid5IQ>
    <xmx:3H6laUjdfgOfzE-zopKW0yh_-WS3NQjUwI3H-NrFe35xYxM0IF4qmQqJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 07:13:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a527f8a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Mar 2026 12:13:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Mar 2026 13:13:06 +0100
Subject: [PATCH 2/8] add-patch: split out `struct interactive_options`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-pks-history-split-v1-2-444fc987a324@pks.im>
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
In-Reply-To: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.3

The `struct add_p_opt` is reused both by our infra for "git add -p" and
"git add -i". Users of `run_add_i()` for example are expected to pass
`struct add_p_opt`. This is somewhat confusing and raises the question
of which options apply to what part of the stack.

But things are even more confusing than that: while callers are expected
to pass in `struct add_p_opt`, these options ultimately get used to
initialize a `struct add_i_state` that is used by both subsystems. So we
are basically going full circle here.

Refactor the code and split out a new `struct interactive_options` that
hosts common options used by both. These options are then applied to a
`struct interactive_config` that hosts common configuration.

This refactoring doesn't yet fully detangle the two subsystems from one
another, as we still end up calling `init_add_i_state()` in the "git add
-p" subsystem. This will be fixed in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-interactive.c  | 177 +++++++++++---------------------------------------
 add-interactive.h  |  24 +------
 add-patch.c        | 187 +++++++++++++++++++++++++++++++++++++++++++----------
 add-patch.h        |  38 ++++++++++-
 builtin/add.c      |  26 ++++----
 builtin/checkout.c |   4 +-
 builtin/commit.c   |  16 ++---
 builtin/reset.c    |  20 +++---
 builtin/stash.c    |  54 ++++++++--------
 commit.h           |   2 +-
 10 files changed, 290 insertions(+), 258 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 1580639682..152e2a0297 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -3,7 +3,6 @@
 #include "git-compat-util.h"
 #include "add-interactive.h"
 #include "color.h"
-#include "config.h"
 #include "diffcore.h"
 #include "gettext.h"
 #include "hash.h"
@@ -20,120 +19,18 @@
 #include "prompt.h"
 #include "tree.h"
 
-static void init_color(struct repository *r, enum git_colorbool use_color,
-		       const char *section_and_slot, char *dst,
-		       const char *default_color)
-{
-	char *key = xstrfmt("color.%s", section_and_slot);
-	const char *value;
-
-	if (!want_color(use_color))
-		dst[0] = '\0';
-	else if (repo_config_get_value(r, key, &value) ||
-		 color_parse(value, dst))
-		strlcpy(dst, default_color, COLOR_MAXLEN);
-
-	free(key);
-}
-
-static enum git_colorbool check_color_config(struct repository *r, const char *var)
-{
-	const char *value;
-	enum git_colorbool ret;
-
-	if (repo_config_get_value(r, var, &value))
-		ret = GIT_COLOR_UNKNOWN;
-	else
-		ret = git_config_colorbool(var, value);
-
-	/*
-	 * Do not rely on want_color() to fall back to color.ui for us. It uses
-	 * the value parsed by git_color_config(), which may not have been
-	 * called by the main command.
-	 */
-	if (ret == GIT_COLOR_UNKNOWN &&
-	    !repo_config_get_value(r, "color.ui", &value))
-		ret = git_config_colorbool("color.ui", value);
-
-	return ret;
-}
-
 void init_add_i_state(struct add_i_state *s, struct repository *r,
-		      struct add_p_opt *add_p_opt)
+		      struct interactive_options *opts)
 {
 	s->r = r;
-	s->context = -1;
-	s->interhunkcontext = -1;
-	s->auto_advance = add_p_opt->auto_advance;
-
-	s->use_color_interactive = check_color_config(r, "color.interactive");
-
-	init_color(r, s->use_color_interactive, "interactive.header",
-		   s->header_color, GIT_COLOR_BOLD);
-	init_color(r, s->use_color_interactive, "interactive.help",
-		   s->help_color, GIT_COLOR_BOLD_RED);
-	init_color(r, s->use_color_interactive, "interactive.prompt",
-		   s->prompt_color, GIT_COLOR_BOLD_BLUE);
-	init_color(r, s->use_color_interactive, "interactive.error",
-		   s->error_color, GIT_COLOR_BOLD_RED);
-	strlcpy(s->reset_color_interactive,
-		want_color(s->use_color_interactive) ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
-
-	s->use_color_diff = check_color_config(r, "color.diff");
-
-	init_color(r, s->use_color_diff, "diff.frag", s->fraginfo_color,
-		   diff_get_color(s->use_color_diff, DIFF_FRAGINFO));
-	init_color(r, s->use_color_diff, "diff.context", s->context_color,
-		   "fall back");
-	if (!strcmp(s->context_color, "fall back"))
-		init_color(r, s->use_color_diff, "diff.plain",
-			   s->context_color,
-			   diff_get_color(s->use_color_diff, DIFF_CONTEXT));
-	init_color(r, s->use_color_diff, "diff.old", s->file_old_color,
-		   diff_get_color(s->use_color_diff, DIFF_FILE_OLD));
-	init_color(r, s->use_color_diff, "diff.new", s->file_new_color,
-		   diff_get_color(s->use_color_diff, DIFF_FILE_NEW));
-	strlcpy(s->reset_color_diff,
-		want_color(s->use_color_diff) ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
-
-	FREE_AND_NULL(s->interactive_diff_filter);
-	repo_config_get_string(r, "interactive.difffilter",
-			       &s->interactive_diff_filter);
-
-	FREE_AND_NULL(s->interactive_diff_algorithm);
-	repo_config_get_string(r, "diff.algorithm",
-			       &s->interactive_diff_algorithm);
-
-	if (!repo_config_get_int(r, "diff.context", &s->context))
-		if (s->context < 0)
-			die(_("%s cannot be negative"), "diff.context");
-	if (!repo_config_get_int(r, "diff.interHunkContext", &s->interhunkcontext))
-		if (s->interhunkcontext < 0)
-			die(_("%s cannot be negative"), "diff.interHunkContext");
-
-	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
-	if (s->use_single_key)
-		setbuf(stdin, NULL);
-
-	if (add_p_opt->context != -1) {
-		if (add_p_opt->context < 0)
-			die(_("%s cannot be negative"), "--unified");
-		s->context = add_p_opt->context;
-	}
-	if (add_p_opt->interhunkcontext != -1) {
-		if (add_p_opt->interhunkcontext < 0)
-			die(_("%s cannot be negative"), "--inter-hunk-context");
-		s->interhunkcontext = add_p_opt->interhunkcontext;
-	}
+	interactive_config_init(&s->cfg, r, opts);
 }
 
 void clear_add_i_state(struct add_i_state *s)
 {
-	FREE_AND_NULL(s->interactive_diff_filter);
-	FREE_AND_NULL(s->interactive_diff_algorithm);
+	interactive_config_clear(&s->cfg);
 	memset(s, 0, sizeof(*s));
-	s->use_color_interactive = GIT_COLOR_UNKNOWN;
-	s->use_color_diff = GIT_COLOR_UNKNOWN;
+	interactive_config_clear(&s->cfg);
 }
 
 /*
@@ -287,7 +184,7 @@ static void list(struct add_i_state *s, struct string_list *list, int *selected,
 		return;
 
 	if (opts->header)
-		color_fprintf_ln(stdout, s->header_color,
+		color_fprintf_ln(stdout, s->cfg.header_color,
 				 "%s", opts->header);
 
 	for (i = 0; i < list->nr; i++) {
@@ -355,7 +252,7 @@ static ssize_t list_and_choose(struct add_i_state *s,
 
 		list(s, &items->items, items->selected, &opts->list_opts);
 
-		color_fprintf(stdout, s->prompt_color, "%s", opts->prompt);
+		color_fprintf(stdout, s->cfg.prompt_color, "%s", opts->prompt);
 		fputs(singleton ? "> " : ">> ", stdout);
 		fflush(stdout);
 
@@ -433,7 +330,7 @@ static ssize_t list_and_choose(struct add_i_state *s,
 
 			if (from < 0 || from >= items->items.nr ||
 			    (singleton && from + 1 != to)) {
-				color_fprintf_ln(stderr, s->error_color,
+				color_fprintf_ln(stderr, s->cfg.error_color,
 						 _("Huh (%s)?"), p);
 				break;
 			} else if (singleton) {
@@ -993,7 +890,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 				free(files->items.items[i].string);
 			} else if (item->index.unmerged ||
 				 item->worktree.unmerged) {
-				color_fprintf_ln(stderr, s->error_color,
+				color_fprintf_ln(stderr, s->cfg.error_color,
 						 _("ignoring unmerged: %s"),
 						 files->items.items[i].string);
 				free(item);
@@ -1015,10 +912,10 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 	opts->prompt = N_("Patch update");
 	count = list_and_choose(s, files, opts);
 	if (count > 0) {
-		struct add_p_opt add_p_opt = {
-			.context = s->context,
-			.interhunkcontext = s->interhunkcontext,
-			.auto_advance = s->auto_advance
+		struct interactive_options opts = {
+			.context = s->cfg.context,
+			.interhunkcontext = s->cfg.interhunkcontext,
+			.auto_advance = s->cfg.auto_advance,
 		};
 		struct strvec args = STRVEC_INIT;
 		struct pathspec ps_selected = { 0 };
@@ -1030,7 +927,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 		parse_pathspec(&ps_selected,
 			       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 			       PATHSPEC_LITERAL_PATH, "", args.v);
-		res = run_add_p(s->r, ADD_P_ADD, &add_p_opt, NULL, &ps_selected);
+		res = run_add_p(s->r, ADD_P_ADD, &opts, NULL, &ps_selected);
 		strvec_clear(&args);
 		clear_pathspec(&ps_selected);
 	}
@@ -1066,10 +963,10 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
 		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached", NULL);
-		if (s->context != -1)
-			strvec_pushf(&cmd.args, "--unified=%i", s->context);
-		if (s->interhunkcontext != -1)
-			strvec_pushf(&cmd.args, "--inter-hunk-context=%i", s->interhunkcontext);
+		if (s->cfg.context != -1)
+			strvec_pushf(&cmd.args, "--unified=%i", s->cfg.context);
+		if (s->cfg.interhunkcontext != -1)
+			strvec_pushf(&cmd.args, "--inter-hunk-context=%i", s->cfg.interhunkcontext);
 		strvec_pushl(&cmd.args, oid_to_hex(!is_initial ? &oid :
 			     s->r->hash_algo->empty_tree), "--", NULL);
 		for (i = 0; i < files->items.nr; i++)
@@ -1087,17 +984,17 @@ static int run_help(struct add_i_state *s, const struct pathspec *ps UNUSED,
 		    struct prefix_item_list *files UNUSED,
 		    struct list_and_choose_options *opts UNUSED)
 {
-	color_fprintf_ln(stdout, s->help_color, "status        - %s",
+	color_fprintf_ln(stdout, s->cfg.help_color, "status        - %s",
 			 _("show paths with changes"));
-	color_fprintf_ln(stdout, s->help_color, "update        - %s",
+	color_fprintf_ln(stdout, s->cfg.help_color, "update        - %s",
 			 _("add working tree state to the staged set of changes"));
-	color_fprintf_ln(stdout, s->help_color, "revert        - %s",
+	color_fprintf_ln(stdout, s->cfg.help_color, "revert        - %s",
 			 _("revert staged set of changes back to the HEAD version"));
-	color_fprintf_ln(stdout, s->help_color, "patch         - %s",
+	color_fprintf_ln(stdout, s->cfg.help_color, "patch         - %s",
 			 _("pick hunks and update selectively"));
-	color_fprintf_ln(stdout, s->help_color, "diff          - %s",
+	color_fprintf_ln(stdout, s->cfg.help_color, "diff          - %s",
 			 _("view diff between HEAD and index"));
-	color_fprintf_ln(stdout, s->help_color, "add untracked - %s",
+	color_fprintf_ln(stdout, s->cfg.help_color, "add untracked - %s",
 			 _("add contents of untracked files to the staged set of changes"));
 
 	return 0;
@@ -1105,21 +1002,21 @@ static int run_help(struct add_i_state *s, const struct pathspec *ps UNUSED,
 
 static void choose_prompt_help(struct add_i_state *s)
 {
-	color_fprintf_ln(stdout, s->help_color, "%s",
+	color_fprintf_ln(stdout, s->cfg.help_color, "%s",
 			 _("Prompt help:"));
-	color_fprintf_ln(stdout, s->help_color, "1          - %s",
+	color_fprintf_ln(stdout, s->cfg.help_color, "1          - %s",
 			 _("select a single item"));
-	color_fprintf_ln(stdout, s->help_color, "3-5        - %s",
+	color_fprintf_ln(stdout, s->cfg.help_color, "3-5        - %s",
 			 _("select a range of items"));
-	color_fprintf_ln(stdout, s->help_color, "2-3,6-9    - %s",
+	color_fprintf_ln(stdout, s->cfg.help_color, "2-3,6-9    - %s",
 			 _("select multiple ranges"));
-	color_fprintf_ln(stdout, s->help_color, "foo        - %s",
+	color_fprintf_ln(stdout, s->cfg.help_color, "foo        - %s",
 			 _("select item based on unique prefix"));
-	color_fprintf_ln(stdout, s->help_color, "-...       - %s",
+	color_fprintf_ln(stdout, s->cfg.help_color, "-...       - %s",
 			 _("unselect specified items"));
-	color_fprintf_ln(stdout, s->help_color, "*          - %s",
+	color_fprintf_ln(stdout, s->cfg.help_color, "*          - %s",
 			 _("choose all items"));
-	color_fprintf_ln(stdout, s->help_color, "           - %s",
+	color_fprintf_ln(stdout, s->cfg.help_color, "           - %s",
 			 _("(empty) finish selecting"));
 }
 
@@ -1154,7 +1051,7 @@ static void print_command_item(int i, int selected UNUSED,
 
 static void command_prompt_help(struct add_i_state *s)
 {
-	const char *help_color = s->help_color;
+	const char *help_color = s->cfg.help_color;
 	color_fprintf_ln(stdout, help_color, "%s", _("Prompt help:"));
 	color_fprintf_ln(stdout, help_color, "1          - %s",
 			 _("select a numbered item"));
@@ -1165,7 +1062,7 @@ static void command_prompt_help(struct add_i_state *s)
 }
 
 int run_add_i(struct repository *r, const struct pathspec *ps,
-	      struct add_p_opt *add_p_opt)
+	      struct interactive_options *interactive_opts)
 {
 	struct add_i_state s = { NULL };
 	struct print_command_item_data data = { "[", "]" };
@@ -1208,15 +1105,15 @@ int run_add_i(struct repository *r, const struct pathspec *ps,
 			->util = util;
 	}
 
-	init_add_i_state(&s, r, add_p_opt);
+	init_add_i_state(&s, r, interactive_opts);
 
 	/*
 	 * When color was asked for, use the prompt color for
 	 * highlighting, otherwise use square brackets.
 	 */
-	if (want_color(s.use_color_interactive)) {
-		data.color = s.prompt_color;
-		data.reset = s.reset_color_interactive;
+	if (want_color(s.cfg.use_color_interactive)) {
+		data.color = s.cfg.prompt_color;
+		data.reset = s.cfg.reset_color_interactive;
 	}
 	print_file_item_data.color = data.color;
 	print_file_item_data.reset = data.reset;
diff --git a/add-interactive.h b/add-interactive.h
index 6c62489bfe..eefa2edc7c 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -2,38 +2,20 @@
 #define ADD_INTERACTIVE_H
 
 #include "add-patch.h"
-#include "color.h"
 
 struct pathspec;
 struct repository;
 
 struct add_i_state {
 	struct repository *r;
-	enum git_colorbool use_color_interactive;
-	enum git_colorbool use_color_diff;
-	char header_color[COLOR_MAXLEN];
-	char help_color[COLOR_MAXLEN];
-	char prompt_color[COLOR_MAXLEN];
-	char error_color[COLOR_MAXLEN];
-	char reset_color_interactive[COLOR_MAXLEN];
-
-	char fraginfo_color[COLOR_MAXLEN];
-	char context_color[COLOR_MAXLEN];
-	char file_old_color[COLOR_MAXLEN];
-	char file_new_color[COLOR_MAXLEN];
-	char reset_color_diff[COLOR_MAXLEN];
-
-	int use_single_key;
-	char *interactive_diff_filter, *interactive_diff_algorithm;
-	int context, interhunkcontext;
-	int auto_advance;
+	struct interactive_config cfg;
 };
 
 void init_add_i_state(struct add_i_state *s, struct repository *r,
-		      struct add_p_opt *add_p_opt);
+		      struct interactive_options *opts);
 void clear_add_i_state(struct add_i_state *s);
 
 int run_add_i(struct repository *r, const struct pathspec *ps,
-	      struct add_p_opt *add_p_opt);
+	      struct interactive_options *opts);
 
 #endif
diff --git a/add-patch.c b/add-patch.c
index 8ce2fc02f6..756143eb84 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -5,6 +5,8 @@
 #include "add-interactive.h"
 #include "add-patch.h"
 #include "advice.h"
+#include "config.h"
+#include "diff.h"
 #include "editor.h"
 #include "environment.h"
 #include "gettext.h"
@@ -279,6 +281,123 @@ struct add_p_state {
 	const char *revision;
 };
 
+static void init_color(struct repository *r,
+		       enum git_colorbool use_color,
+		       const char *section_and_slot, char *dst,
+		       const char *default_color)
+{
+	char *key = xstrfmt("color.%s", section_and_slot);
+	const char *value;
+
+	if (!want_color(use_color))
+		dst[0] = '\0';
+	else if (repo_config_get_value(r, key, &value) ||
+		 color_parse(value, dst))
+		strlcpy(dst, default_color, COLOR_MAXLEN);
+
+	free(key);
+}
+
+static enum git_colorbool check_color_config(struct repository *r, const char *var)
+{
+	const char *value;
+	enum git_colorbool ret;
+
+	if (repo_config_get_value(r, var, &value))
+		ret = GIT_COLOR_UNKNOWN;
+	else
+		ret = git_config_colorbool(var, value);
+
+	/*
+	 * Do not rely on want_color() to fall back to color.ui for us. It uses
+	 * the value parsed by git_color_config(), which may not have been
+	 * called by the main command.
+	 */
+	if (ret == GIT_COLOR_UNKNOWN &&
+	    !repo_config_get_value(r, "color.ui", &value))
+		ret = git_config_colorbool("color.ui", value);
+
+	return ret;
+}
+
+void interactive_config_init(struct interactive_config *cfg,
+			     struct repository *r,
+			     struct interactive_options *opts)
+{
+	cfg->context = -1;
+	cfg->interhunkcontext = -1;
+	cfg->auto_advance = opts->auto_advance;
+
+	cfg->use_color_interactive = check_color_config(r, "color.interactive");
+
+	init_color(r, cfg->use_color_interactive, "interactive.header",
+		   cfg->header_color, GIT_COLOR_BOLD);
+	init_color(r, cfg->use_color_interactive, "interactive.help",
+		   cfg->help_color, GIT_COLOR_BOLD_RED);
+	init_color(r, cfg->use_color_interactive, "interactive.prompt",
+		   cfg->prompt_color, GIT_COLOR_BOLD_BLUE);
+	init_color(r, cfg->use_color_interactive, "interactive.error",
+		   cfg->error_color, GIT_COLOR_BOLD_RED);
+	strlcpy(cfg->reset_color_interactive,
+		want_color(cfg->use_color_interactive) ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
+
+	cfg->use_color_diff = check_color_config(r, "color.diff");
+
+	init_color(r, cfg->use_color_diff, "diff.frag", cfg->fraginfo_color,
+		   diff_get_color(cfg->use_color_diff, DIFF_FRAGINFO));
+	init_color(r, cfg->use_color_diff, "diff.context", cfg->context_color,
+		   "fall back");
+	if (!strcmp(cfg->context_color, "fall back"))
+		init_color(r, cfg->use_color_diff, "diff.plain",
+			   cfg->context_color,
+			   diff_get_color(cfg->use_color_diff, DIFF_CONTEXT));
+	init_color(r, cfg->use_color_diff, "diff.old", cfg->file_old_color,
+		diff_get_color(cfg->use_color_diff, DIFF_FILE_OLD));
+	init_color(r, cfg->use_color_diff, "diff.new", cfg->file_new_color,
+		diff_get_color(cfg->use_color_diff, DIFF_FILE_NEW));
+	strlcpy(cfg->reset_color_diff,
+		want_color(cfg->use_color_diff) ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
+
+	FREE_AND_NULL(cfg->interactive_diff_filter);
+	repo_config_get_string(r, "interactive.difffilter",
+			       &cfg->interactive_diff_filter);
+
+	FREE_AND_NULL(cfg->interactive_diff_algorithm);
+	repo_config_get_string(r, "diff.algorithm",
+			       &cfg->interactive_diff_algorithm);
+
+	if (!repo_config_get_int(r, "diff.context", &cfg->context))
+		if (cfg->context < 0)
+			die(_("%s cannot be negative"), "diff.context");
+	if (!repo_config_get_int(r, "diff.interHunkContext", &cfg->interhunkcontext))
+		if (cfg->interhunkcontext < 0)
+			die(_("%s cannot be negative"), "diff.interHunkContext");
+
+	repo_config_get_bool(r, "interactive.singlekey", &cfg->use_single_key);
+	if (cfg->use_single_key)
+		setbuf(stdin, NULL);
+
+	if (opts->context != -1) {
+		if (opts->context < 0)
+			die(_("%s cannot be negative"), "--unified");
+		cfg->context = opts->context;
+	}
+	if (opts->interhunkcontext != -1) {
+		if (opts->interhunkcontext < 0)
+			die(_("%s cannot be negative"), "--inter-hunk-context");
+		cfg->interhunkcontext = opts->interhunkcontext;
+	}
+}
+
+void interactive_config_clear(struct interactive_config *cfg)
+{
+	FREE_AND_NULL(cfg->interactive_diff_filter);
+	FREE_AND_NULL(cfg->interactive_diff_algorithm);
+	memset(cfg, 0, sizeof(*cfg));
+	cfg->use_color_interactive = GIT_COLOR_UNKNOWN;
+	cfg->use_color_diff = GIT_COLOR_UNKNOWN;
+}
+
 static void add_p_state_clear(struct add_p_state *s)
 {
 	size_t i;
@@ -299,9 +418,9 @@ static void err(struct add_p_state *s, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	fputs(s->s.error_color, stdout);
+	fputs(s->s.cfg.error_color, stdout);
 	vprintf(fmt, args);
-	puts(s->s.reset_color_interactive);
+	puts(s->s.cfg.reset_color_interactive);
 	va_end(args);
 }
 
@@ -424,12 +543,12 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	int res;
 
 	strvec_pushv(&args, s->mode->diff_cmd);
-	if (s->s.context != -1)
-		strvec_pushf(&args, "--unified=%i", s->s.context);
-	if (s->s.interhunkcontext != -1)
-		strvec_pushf(&args, "--inter-hunk-context=%i", s->s.interhunkcontext);
-	if (s->s.interactive_diff_algorithm)
-		strvec_pushf(&args, "--diff-algorithm=%s", s->s.interactive_diff_algorithm);
+	if (s->s.cfg.context != -1)
+		strvec_pushf(&args, "--unified=%i", s->s.cfg.context);
+	if (s->s.cfg.interhunkcontext != -1)
+		strvec_pushf(&args, "--inter-hunk-context=%i", s->s.cfg.interhunkcontext);
+	if (s->s.cfg.interactive_diff_algorithm)
+		strvec_pushf(&args, "--diff-algorithm=%s", s->s.cfg.interactive_diff_algorithm);
 	if (s->revision) {
 		struct object_id oid;
 		strvec_push(&args,
@@ -458,9 +577,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	}
 	strbuf_complete_line(plain);
 
-	if (want_color_fd(1, s->s.use_color_diff)) {
+	if (want_color_fd(1, s->s.cfg.use_color_diff)) {
 		struct child_process colored_cp = CHILD_PROCESS_INIT;
-		const char *diff_filter = s->s.interactive_diff_filter;
+		const char *diff_filter = s->s.cfg.interactive_diff_filter;
 
 		setup_child_process(s, &colored_cp, NULL);
 		xsnprintf((char *)args.v[color_arg_index], 8, "--color");
@@ -693,7 +812,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 				   hunk->colored_end - hunk->colored_start);
 			return;
 		} else {
-			strbuf_addstr(out, s->s.fraginfo_color);
+			strbuf_addstr(out, s->s.cfg.fraginfo_color);
 			p = s->colored.buf + header->colored_extra_start;
 			len = header->colored_extra_end
 				- header->colored_extra_start;
@@ -715,7 +834,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		if (len)
 			strbuf_add(out, p, len);
 		else if (colored)
-			strbuf_addf(out, "%s\n", s->s.reset_color_diff);
+			strbuf_addf(out, "%s\n", s->s.cfg.reset_color_diff);
 		else
 			strbuf_addch(out, '\n');
 	}
@@ -1104,12 +1223,12 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
 
 		strbuf_addstr(&s->colored,
 			      plain[current] == '-' ?
-			      s->s.file_old_color :
+			      s->s.cfg.file_old_color :
 			      plain[current] == '+' ?
-			      s->s.file_new_color :
-			      s->s.context_color);
+			      s->s.cfg.file_new_color :
+			      s->s.cfg.context_color);
 		strbuf_add(&s->colored, plain + current, eol - current);
-		strbuf_addstr(&s->colored, s->s.reset_color_diff);
+		strbuf_addstr(&s->colored, s->s.cfg.reset_color_diff);
 		if (next > eol)
 			strbuf_add(&s->colored, plain + eol, next - eol);
 		current = next;
@@ -1238,7 +1357,7 @@ static int run_apply_check(struct add_p_state *s,
 
 static int read_single_character(struct add_p_state *s)
 {
-	if (s->s.use_single_key) {
+	if (s->s.cfg.use_single_key) {
 		int res = read_key_without_echo(&s->answer);
 		printf("%s\n", res == EOF ? "" : s->answer.buf);
 		return res;
@@ -1252,7 +1371,7 @@ static int read_single_character(struct add_p_state *s)
 static int prompt_yesno(struct add_p_state *s, const char *prompt)
 {
 	for (;;) {
-		color_fprintf(stdout, s->s.prompt_color, "%s", _(prompt));
+		color_fprintf(stdout, s->s.cfg.prompt_color, "%s", _(prompt));
 		fflush(stdout);
 		if (read_single_character(s) == EOF)
 			return -1;
@@ -1541,7 +1660,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		/* Everything decided? */
 		if (undecided_previous < 0 && undecided_next < 0 &&
 		    hunk->use != UNDECIDED_HUNK) {
-				if (!s->s.auto_advance)
+				if (!s->s.cfg.auto_advance)
 					all_decided = 1;
 				else {
 					patch_update_resp++;
@@ -1595,11 +1714,11 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 				permitted |= ALLOW_EDIT;
 				strbuf_addstr(&s->buf, ",e");
 			}
-			if (!s->s.auto_advance && s->file_diff_nr > 1) {
+			if (!s->s.cfg.auto_advance && s->file_diff_nr > 1) {
 				permitted |= ALLOW_GOTO_NEXT_FILE;
 				strbuf_addstr(&s->buf, ",>");
 			}
-			if (!s->s.auto_advance && s->file_diff_nr > 1) {
+			if (!s->s.cfg.auto_advance && s->file_diff_nr > 1) {
 				permitted |= ALLOW_GOTO_PREVIOUS_FILE;
 				strbuf_addstr(&s->buf, ",<");
 			}
@@ -1614,7 +1733,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		else
 			prompt_mode_type = PROMPT_HUNK;
 
-		printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->s.prompt_color,
+		printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->s.cfg.prompt_color,
 			      (uintmax_t)hunk_index + 1,
 			      (uintmax_t)(file_diff->hunk_nr
 						? file_diff->hunk_nr
@@ -1627,8 +1746,8 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		}
 		printf(_(s->mode->prompt_mode[prompt_mode_type]),
 			hunk_use_decision, s->buf.buf);
-		if (*s->s.reset_color_interactive)
-			fputs(s->s.reset_color_interactive, stdout);
+		if (*s->s.cfg.reset_color_interactive)
+			fputs(s->s.cfg.reset_color_interactive, stdout);
 		fflush(stdout);
 		if (read_single_character(s) == EOF) {
 			patch_update_resp = s->file_diff_nr;
@@ -1679,7 +1798,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		} else if (ch == 'q') {
 			patch_update_resp = s->file_diff_nr;
 			break;
-		} else if (!s->s.auto_advance && s->answer.buf[0] == '>') {
+		} else if (!s->s.cfg.auto_advance && s->answer.buf[0] == '>') {
 			if (permitted & ALLOW_GOTO_NEXT_FILE) {
 				if (patch_update_resp == s->file_diff_nr - 1)
 					patch_update_resp = 0;
@@ -1690,7 +1809,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 				err(s, _("No next file"));
 				continue;
 			}
-		} else if (!s->s.auto_advance && s->answer.buf[0] == '<') {
+		} else if (!s->s.cfg.auto_advance && s->answer.buf[0] == '<') {
 			if (permitted & ALLOW_GOTO_PREVIOUS_FILE) {
 				if (patch_update_resp == 0)
 					patch_update_resp = s->file_diff_nr - 1;
@@ -1813,7 +1932,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 				err(s, _("Sorry, cannot split this hunk"));
 			} else if (!split_hunk(s, file_diff,
 					     hunk - file_diff->hunk)) {
-				color_fprintf_ln(stdout, s->s.header_color,
+				color_fprintf_ln(stdout, s->s.cfg.header_color,
 						 _("Split into %d hunks."),
 						 (int)splittable_into);
 				rendered_hunk_index = -1;
@@ -1831,7 +1950,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		} else if (s->answer.buf[0] == '?') {
 			const char *p = _(help_patch_remainder), *eol = p;
 
-			color_fprintf(stdout, s->s.help_color, "%s",
+			color_fprintf(stdout, s->s.cfg.help_color, "%s",
 				      _(s->mode->help_patch_text));
 
 			/*
@@ -1855,13 +1974,13 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 						if (file_diff->hunk[i].use == SKIP_HUNK)
 							skipped += 1;
 					}
-					color_fprintf_ln(stdout, s->s.help_color, _(p),
+					color_fprintf_ln(stdout, s->s.cfg.help_color, _(p),
 							 total, used, skipped);
 				}
 				if (*p != '?' && !strchr(s->buf.buf, *p))
 					continue;
 
-				color_fprintf_ln(stdout, s->s.help_color,
+				color_fprintf_ln(stdout, s->s.cfg.help_color,
 						 "%.*s", (int)(eol - p), p);
 			}
 		} else {
@@ -1870,7 +1989,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		}
 	}
 
-	if (s->s.auto_advance)
+	if (s->s.cfg.auto_advance)
 		apply_patch(s, file_diff);
 
 	putchar('\n');
@@ -1878,7 +1997,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 }
 
 int run_add_p(struct repository *r, enum add_p_mode mode,
-	      struct add_p_opt *o, const char *revision,
+	      struct interactive_options *opts, const char *revision,
 	      const struct pathspec *ps)
 {
 	struct add_p_state s = {
@@ -1886,7 +2005,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	};
 	size_t i, binary_count = 0;
 
-	init_add_i_state(&s.s, r, o);
+	init_add_i_state(&s.s, r, opts);
 
 	if (mode == ADD_P_STASH)
 		s.mode = &patch_mode_stash;
@@ -1932,7 +2051,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 		 if ((i = patch_update_file(&s, i)) == s.file_diff_nr)
 			break;
     }
-	if (!s.s.auto_advance)
+	if (!s.s.cfg.auto_advance)
 		for (i = 0; i < s.file_diff_nr; i++)
 			apply_patch(&s, s.file_diff + i);
 
diff --git a/add-patch.h b/add-patch.h
index 88b00ca788..e6868c60a2 100644
--- a/add-patch.h
+++ b/add-patch.h
@@ -1,16 +1,48 @@
 #ifndef ADD_PATCH_H
 #define ADD_PATCH_H
 
+#include "color.h"
+
 struct pathspec;
 struct repository;
 
-struct add_p_opt {
+struct interactive_options {
 	int context;
 	int interhunkcontext;
 	int auto_advance;
 };
 
-#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1, .auto_advance = 1 }
+#define INTERACTIVE_OPTIONS_INIT { \
+	.context = -1, \
+	.interhunkcontext = -1, \
+	.auto_advance = 1, \
+}
+
+struct interactive_config {
+	enum git_colorbool use_color_interactive;
+	enum git_colorbool use_color_diff;
+	char header_color[COLOR_MAXLEN];
+	char help_color[COLOR_MAXLEN];
+	char prompt_color[COLOR_MAXLEN];
+	char error_color[COLOR_MAXLEN];
+	char reset_color_interactive[COLOR_MAXLEN];
+
+	char fraginfo_color[COLOR_MAXLEN];
+	char context_color[COLOR_MAXLEN];
+	char file_old_color[COLOR_MAXLEN];
+	char file_new_color[COLOR_MAXLEN];
+	char reset_color_diff[COLOR_MAXLEN];
+
+	int use_single_key;
+	char *interactive_diff_filter, *interactive_diff_algorithm;
+	int context, interhunkcontext;
+	int auto_advance;
+};
+
+void interactive_config_init(struct interactive_config *cfg,
+			     struct repository *r,
+			     struct interactive_options *opts);
+void interactive_config_clear(struct interactive_config *cfg);
 
 enum add_p_mode {
 	ADD_P_ADD,
@@ -21,7 +53,7 @@ enum add_p_mode {
 };
 
 int run_add_p(struct repository *r, enum add_p_mode mode,
-	      struct add_p_opt *o, const char *revision,
+	      struct interactive_options *opts, const char *revision,
 	      const struct pathspec *ps);
 
 #endif
diff --git a/builtin/add.c b/builtin/add.c
index 4357f87b7f..84f9bcb789 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -31,7 +31,7 @@ static const char * const builtin_add_usage[] = {
 	NULL
 };
 static int patch_interactive, add_interactive, edit_interactive;
-static struct add_p_opt add_p_opt = ADD_P_OPT_INIT;
+static struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
 static int take_worktree_changes;
 static int add_renormalize;
 static int pathspec_file_nul;
@@ -160,7 +160,7 @@ static int refresh(struct repository *repo, int verbose, const struct pathspec *
 int interactive_add(struct repository *repo,
 		    const char **argv,
 		    const char *prefix,
-		    int patch, struct add_p_opt *add_p_opt)
+		    int patch, struct interactive_options *interactive_opts)
 {
 	struct pathspec pathspec;
 	int ret;
@@ -172,9 +172,9 @@ int interactive_add(struct repository *repo,
 		       prefix, argv);
 
 	if (patch)
-		ret = !!run_add_p(repo, ADD_P_ADD, add_p_opt, NULL, &pathspec);
+		ret = !!run_add_p(repo, ADD_P_ADD, interactive_opts, NULL, &pathspec);
 	else
-		ret = !!run_add_i(repo, &pathspec, add_p_opt);
+		ret = !!run_add_i(repo, &pathspec, interactive_opts);
 
 	clear_pathspec(&pathspec);
 	return ret;
@@ -256,10 +256,10 @@ static struct option builtin_add_options[] = {
 	OPT_GROUP(""),
 	OPT_BOOL('i', "interactive", &add_interactive, N_("interactive picking")),
 	OPT_BOOL('p', "patch", &patch_interactive, N_("select hunks interactively")),
-	OPT_BOOL(0, "auto-advance", &add_p_opt.auto_advance,
+	OPT_BOOL(0, "auto-advance", &interactive_opts.auto_advance,
 		 N_("auto advance to the next file when selecting hunks interactively")),
-	OPT_DIFF_UNIFIED(&add_p_opt.context),
-	OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
+	OPT_DIFF_UNIFIED(&interactive_opts.context),
+	OPT_DIFF_INTERHUNK_CONTEXT(&interactive_opts.interhunkcontext),
 	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and apply")),
 	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files"), 0),
 	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
@@ -402,9 +402,9 @@ int cmd_add(int argc,
 	prepare_repo_settings(repo);
 	repo->settings.command_requires_full_index = 0;
 
-	if (add_p_opt.context < -1)
+	if (interactive_opts.context < -1)
 		die(_("'%s' cannot be negative"), "--unified");
-	if (add_p_opt.interhunkcontext < -1)
+	if (interactive_opts.interhunkcontext < -1)
 		die(_("'%s' cannot be negative"), "--inter-hunk-context");
 
 	if (patch_interactive)
@@ -414,13 +414,13 @@ int cmd_add(int argc,
 			die(_("options '%s' and '%s' cannot be used together"), "--dry-run", "--interactive/--patch");
 		if (pathspec_from_file)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--interactive/--patch");
-		exit(interactive_add(repo, argv + 1, prefix, patch_interactive, &add_p_opt));
+		exit(interactive_add(repo, argv + 1, prefix, patch_interactive, &interactive_opts));
 	} else {
-		if (add_p_opt.context != -1)
+		if (interactive_opts.context != -1)
 			die(_("the option '%s' requires '%s'"), "--unified", "--interactive/--patch");
-		if (add_p_opt.interhunkcontext != -1)
+		if (interactive_opts.interhunkcontext != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--interactive/--patch");
-		if (!add_p_opt.auto_advance)
+		if (!interactive_opts.auto_advance)
 			die(_("the option '%s' requires '%s'"), "--no-auto-advance", "--interactive/--patch");
 	}
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index eefefd5d0f..bebe18c1d9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -532,7 +532,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 
 	if (opts->patch_mode) {
 		enum add_p_mode patch_mode;
-		struct add_p_opt add_p_opt = {
+		struct interactive_options interactive_opts = {
 			.context = opts->patch_context,
 			.interhunkcontext = opts->patch_interhunk_context,
 			.auto_advance = opts->auto_advance
@@ -562,7 +562,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		else
 			BUG("either flag must have been set, worktree=%d, index=%d",
 			    opts->checkout_worktree, opts->checkout_index);
-		return !!run_add_p(the_repository, patch_mode, &add_p_opt,
+		return !!run_add_p(the_repository, patch_mode, &interactive_opts,
 				   rev, &opts->pathspec);
 	}
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 9e3a09d532..a1d64dd699 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -123,7 +123,7 @@ static const char *edit_message, *use_message;
 static char *fixup_message, *fixup_commit, *squash_message;
 static const char *fixup_prefix;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
-static struct add_p_opt add_p_opt = ADD_P_OPT_INIT;
+static struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
@@ -357,9 +357,9 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	const char *ret;
 	char *path = NULL;
 
-	if (add_p_opt.context < -1)
+	if (interactive_opts.context < -1)
 		die(_("'%s' cannot be negative"), "--unified");
-	if (add_p_opt.interhunkcontext < -1)
+	if (interactive_opts.interhunkcontext < -1)
 		die(_("'%s' cannot be negative"), "--inter-hunk-context");
 
 	if (is_status)
@@ -408,7 +408,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
 		setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
 
-		if (interactive_add(the_repository, argv, prefix, patch_interactive, &add_p_opt) != 0)
+		if (interactive_add(the_repository, argv, prefix, patch_interactive, &interactive_opts) != 0)
 			die(_("interactive add failed"));
 
 		the_repository->index_file = old_repo_index_file;
@@ -433,9 +433,9 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		ret = get_lock_file_path(&index_lock);
 		goto out;
 	} else {
-		if (add_p_opt.context != -1)
+		if (interactive_opts.context != -1)
 			die(_("the option '%s' requires '%s'"), "--unified", "--interactive/--patch");
-		if (add_p_opt.interhunkcontext != -1)
+		if (interactive_opts.interhunkcontext != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--interactive/--patch");
 	}
 
@@ -1743,8 +1743,8 @@ int cmd_commit(int argc,
 		OPT_BOOL('i', "include", &also, N_("add specified files to index for commit")),
 		OPT_BOOL(0, "interactive", &interactive, N_("interactively add files")),
 		OPT_BOOL('p', "patch", &patch_interactive, N_("interactively add changes")),
-		OPT_DIFF_UNIFIED(&add_p_opt.context),
-		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
+		OPT_DIFF_UNIFIED(&interactive_opts.context),
+		OPT_DIFF_INTERHUNK_CONTEXT(&interactive_opts.interhunkcontext),
 		OPT_BOOL('o', "only", &only, N_("commit only specified files")),
 		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),
 		OPT_BOOL(0, "dry-run", &dry_run, N_("show what would be committed")),
diff --git a/builtin/reset.c b/builtin/reset.c
index 88f95f9fc7..4a74a82c0a 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -346,7 +346,7 @@ int cmd_reset(int argc,
 	struct object_id oid;
 	struct pathspec pathspec;
 	int intent_to_add = 0;
-	struct add_p_opt add_p_opt = ADD_P_OPT_INIT;
+	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
 	const struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_BOOL(0, "no-refresh", &no_refresh,
@@ -371,10 +371,10 @@ int cmd_reset(int argc,
 			       PARSE_OPT_OPTARG,
 			       option_parse_recurse_submodules_worktree_updater),
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
-		OPT_BOOL(0, "auto-advance", &add_p_opt.auto_advance,
+		OPT_BOOL(0, "auto-advance", &interactive_opts.auto_advance,
 			 N_("auto advance to the next file when selecting hunks interactively")),
-		OPT_DIFF_UNIFIED(&add_p_opt.context),
-		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
+		OPT_DIFF_UNIFIED(&interactive_opts.context),
+		OPT_DIFF_INTERHUNK_CONTEXT(&interactive_opts.interhunkcontext),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
 		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
@@ -425,9 +425,9 @@ int cmd_reset(int argc,
 		oidcpy(&oid, &tree->object.oid);
 	}
 
-	if (add_p_opt.context < -1)
+	if (interactive_opts.context < -1)
 		die(_("'%s' cannot be negative"), "--unified");
-	if (add_p_opt.interhunkcontext < -1)
+	if (interactive_opts.interhunkcontext < -1)
 		die(_("'%s' cannot be negative"), "--inter-hunk-context");
 
 	prepare_repo_settings(the_repository);
@@ -438,14 +438,14 @@ int cmd_reset(int argc,
 			die(_("options '%s' and '%s' cannot be used together"), "--patch", "--{hard,mixed,soft}");
 		trace2_cmd_mode("patch-interactive");
 		update_ref_status = !!run_add_p(the_repository, ADD_P_RESET,
-						&add_p_opt, rev, &pathspec);
+						&interactive_opts, rev, &pathspec);
 		goto cleanup;
 	} else {
-		if (add_p_opt.context != -1)
+		if (interactive_opts.context != -1)
 			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
-		if (add_p_opt.interhunkcontext != -1)
+		if (interactive_opts.interhunkcontext != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
-		if (!add_p_opt.auto_advance)
+		if (!interactive_opts.auto_advance)
 			die(_("the option '%s' requires '%s'"), "--no-auto-advance", "--patch");
 	}
 
diff --git a/builtin/stash.c b/builtin/stash.c
index e79d612e57..c467c02c7f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1306,7 +1306,7 @@ static int stash_staged(struct stash_info *info, struct strbuf *out_patch,
 
 static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 		       struct strbuf *out_patch, int quiet,
-		       struct add_p_opt *add_p_opt)
+		       struct interactive_options *interactive_opts)
 {
 	int ret = 0;
 	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
@@ -1331,7 +1331,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
 	setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
 
-	ret = !!run_add_p(the_repository, ADD_P_STASH, add_p_opt, NULL, ps);
+	ret = !!run_add_p(the_repository, ADD_P_STASH, interactive_opts, NULL, ps);
 
 	the_repository->index_file = old_repo_index_file;
 	if (old_index_env && *old_index_env)
@@ -1427,7 +1427,8 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 }
 
 static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_buf,
-			   int include_untracked, int patch_mode, struct add_p_opt *add_p_opt,
+			   int include_untracked, int patch_mode,
+			   struct interactive_options *interactive_opts,
 			   int only_staged, struct stash_info *info, struct strbuf *patch,
 			   int quiet)
 {
@@ -1509,7 +1510,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		untracked_commit_option = 1;
 	}
 	if (patch_mode) {
-		ret = stash_patch(info, ps, patch, quiet, add_p_opt);
+		ret = stash_patch(info, ps, patch, quiet, interactive_opts);
 		if (ret < 0) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save the current "
@@ -1595,7 +1596,8 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 }
 
 static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
-			 int keep_index, int patch_mode, struct add_p_opt *add_p_opt,
+			 int keep_index, int patch_mode,
+			 struct interactive_options *interactive_opts,
 			 int include_untracked, int only_staged)
 {
 	int ret = 0;
@@ -1667,7 +1669,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 	if (stash_msg)
 		strbuf_addstr(&stash_msg_buf, stash_msg);
 	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
-			    add_p_opt, only_staged, &info, &patch, quiet)) {
+			    interactive_opts, only_staged, &info, &patch, quiet)) {
 		ret = -1;
 		goto done;
 	}
@@ -1841,7 +1843,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	const char *stash_msg = NULL;
 	char *pathspec_from_file = NULL;
 	struct pathspec ps;
-	struct add_p_opt add_p_opt = ADD_P_OPT_INIT;
+	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
 	struct option options[] = {
 		OPT_BOOL('k', "keep-index", &keep_index,
 			 N_("keep index")),
@@ -1849,10 +1851,10 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 			 N_("stash staged changes only")),
 		OPT_BOOL('p', "patch", &patch_mode,
 			 N_("stash in patch mode")),
-		OPT_BOOL(0, "auto-advance", &add_p_opt.auto_advance,
+		OPT_BOOL(0, "auto-advance", &interactive_opts.auto_advance,
 			 N_("auto advance to the next file when selecting hunks interactively")),
-		OPT_DIFF_UNIFIED(&add_p_opt.context),
-		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
+		OPT_DIFF_UNIFIED(&interactive_opts.context),
+		OPT_DIFF_INTERHUNK_CONTEXT(&interactive_opts.interhunkcontext),
 		OPT__QUIET(&quiet, N_("quiet mode")),
 		OPT_BOOL('u', "include-untracked", &include_untracked,
 			 N_("include untracked files in stash")),
@@ -1909,21 +1911,21 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	}
 
 	if (!patch_mode) {
-		if (add_p_opt.context != -1)
+		if (interactive_opts.context != -1)
 			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
-		if (add_p_opt.interhunkcontext != -1)
+		if (interactive_opts.interhunkcontext != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
-		if (!add_p_opt.auto_advance)
+		if (!interactive_opts.auto_advance)
 			die(_("the option '%s' requires '%s'"), "--no-auto-advance", "--patch");
 	}
 
-	if (add_p_opt.context < -1)
+	if (interactive_opts.context < -1)
 		die(_("'%s' cannot be negative"), "--unified");
-	if (add_p_opt.interhunkcontext < -1)
+	if (interactive_opts.interhunkcontext < -1)
 		die(_("'%s' cannot be negative"), "--inter-hunk-context");
 
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
-			    &add_p_opt, include_untracked, only_staged);
+			    &interactive_opts, include_untracked, only_staged);
 
 	clear_pathspec(&ps);
 	free(pathspec_from_file);
@@ -1948,7 +1950,7 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 	const char *stash_msg = NULL;
 	struct pathspec ps;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
-	struct add_p_opt add_p_opt = ADD_P_OPT_INIT;
+	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
 	struct option options[] = {
 		OPT_BOOL('k', "keep-index", &keep_index,
 			 N_("keep index")),
@@ -1956,10 +1958,10 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 			 N_("stash staged changes only")),
 		OPT_BOOL('p', "patch", &patch_mode,
 			 N_("stash in patch mode")),
-		OPT_BOOL(0, "auto-advance", &add_p_opt.auto_advance,
+		OPT_BOOL(0, "auto-advance", &interactive_opts.auto_advance,
 			 N_("auto advance to the next file when selecting hunks interactively")),
-		OPT_DIFF_UNIFIED(&add_p_opt.context),
-		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
+		OPT_DIFF_UNIFIED(&interactive_opts.context),
+		OPT_DIFF_INTERHUNK_CONTEXT(&interactive_opts.interhunkcontext),
 		OPT__QUIET(&quiet, N_("quiet mode")),
 		OPT_BOOL('u', "include-untracked", &include_untracked,
 			 N_("include untracked files in stash")),
@@ -1979,22 +1981,22 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 
 	memset(&ps, 0, sizeof(ps));
 
-	if (add_p_opt.context < -1)
+	if (interactive_opts.context < -1)
 		die(_("'%s' cannot be negative"), "--unified");
-	if (add_p_opt.interhunkcontext < -1)
+	if (interactive_opts.interhunkcontext < -1)
 		die(_("'%s' cannot be negative"), "--inter-hunk-context");
 
 	if (!patch_mode) {
-		if (add_p_opt.context != -1)
+		if (interactive_opts.context != -1)
 			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
-		if (add_p_opt.interhunkcontext != -1)
+		if (interactive_opts.interhunkcontext != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
-		if (!add_p_opt.auto_advance)
+		if (!interactive_opts.auto_advance)
 			die(_("the option '%s' requires '%s'"), "--no-auto-advance", "--patch");
 	}
 
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
-			    patch_mode, &add_p_opt, include_untracked,
+			    patch_mode, &interactive_opts, include_untracked,
 			    only_staged);
 
 	strbuf_release(&stash_msg_buf);
diff --git a/commit.h b/commit.h
index 1635de418b..a2337a5af0 100644
--- a/commit.h
+++ b/commit.h
@@ -277,7 +277,7 @@ int for_each_commit_graft(each_commit_graft_fn, void *);
 int interactive_add(struct repository *repo,
 		    const char **argv,
 		    const char *prefix,
-		    int patch, struct add_p_opt *add_p_opt);
+		    int patch, struct interactive_options *opts);
 
 struct commit_extra_header {
 	struct commit_extra_header *next;

-- 
2.53.0.697.g625c4fb2da.dirty

