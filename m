Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B92D2036EB
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905858; cv=none; b=jI3gqTuhYwbsn83uRT+kE8PH0JeVU7DOHcLZAEUAHxYIZTtIy6vRolS2oBFAjYEKE2nZxuY9zLUuDR7JWylIlqlY1dU/439CJbfXbSCTXH0DgQn6Jw7adcNmGp9FPH0xyHI+fnGIYYigbZX5UTYKBLVZtRi0vjK7l1sF0yus4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905858; c=relaxed/simple;
	bh=Yj2ZAXCk7CFK3TagxUaULQVIGycbOH2B/5GpyXDn4tA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9ajnE8rZf0rb16Y7wVGqD6g4DrvGg6VsFSxK1ZOgWndBUBNfDrxCstHaWgCYbxFfC3W0dZBaL/m6OzKLzYCqHfbJlZwA7khzFH1C0iVNf/Xe4EwmJZgpRtCaIeba8s0za4O8eNVhm1tT+BH44N21apE8v0BdRsvEIGeLqBlcwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1brFcqgL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j2DKkhgF; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1brFcqgL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j2DKkhgF"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DDD3F1140129
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:10:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 06 Nov 2024 10:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905855; x=1730992255; bh=hVeMsx0dat
	TqPbnG0FU9kkrgy9XmjB3xz4YmX+gKltw=; b=1brFcqgLDsm8rnXM79wCKYAZvH
	Uw3W4qwjuYp8SxQ/QEsZLE7qQ+CEkT/urlAnDR8ZFvrnbFbDlinYX5ZC/Aod4hTw
	gInGdkyE5lc2f0FADy0j4DIbbyjzC/nUMJGbPpgNU6LFFSJmUQ9nosIsMZkwi7iq
	ZKZgZ3M6c0tv3Zo7NVAW06lQ6/S4MUwhse2trewGQYPW2/fdqJJLyD+7RV1bMcM0
	UCcfAynhWoZW2Sjb9Dg1dH2k3mNMQKHTYM9S6M5AMEsQjNkb6D0AAbEEe8jY//Ev
	y8+L1Rx8VOy8b5O3GfbR/iHb9RCI7dVcjCOVtinbkbgGkA9hehXNnXbsuGjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905855; x=1730992255; bh=hVeMsx0datTqPbnG0FU9kkrgy9XmjB3xz4Y
	mX+gKltw=; b=j2DKkhgFif5QgYZLoZ3BFDOE2zNYviwG0hlFn6rCUO5thsMeWSD
	IQKitmMxdRuVBmY80U04C+MI3ykjcDVg7WpIgSJrgEmGR5fBCXz37q195cxaW3C9
	Y9JSBTX8kDVPYEmzVgTA680gP7+PkRk+PA/FYyNl3uUiuBuPYa88txBhuf3QwMlB
	TDBKodVdz9JsJ07pD2jEVUbYC0gp4DCBZ3IRGHnmFQq8noK11/ecOJ3E6ZdTyMnt
	3E5JaiBIsmngrMVoFAXKRo718wuXNSkyMbui81oSot2pp351C43ENIljyvqMDqfG
	OFTXYVRlNsrIca8+ghPPSNK/IA6A68AHEkg==
X-ME-Sender: <xms:_4YrZyFIfcZRr9PbTgunFtcRxtDPUofk54jM0DRKzYlRcdZekWTtXQ>
    <xme:_4YrZzV4h3bOHOjWquKM90dGlr3GUTrJcm8AtPW6YcrfLOiwNJlOo4WMit-LQHccj
    um5nVNTo4fEqvZEDg>
X-ME-Received: <xmr:_4YrZ8Ik6usa1H-qfLi-2pdHnXr0ZMYwIs7UGK7ExZQyCVFih2fh9zbye8wJqL5hG17dTGmRNn_klxlkeHhxg4sNb-xvy2iUg49g3JUV5pvKdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_4YrZ8FeczNfLgTKIVvuMzU2V3Jz6KVas-zYQmr00zVN3gpZefBItA>
    <xmx:_4YrZ4WCcIOz_Bxd_eOuc0ARlxgvSAIyq14XQXe3Zjr1ZzDiXcN9dw>
    <xmx:_4YrZ_OsrTXkLqPd2Y2IHwVTqclpsyFIdv295JssUcm1YqfxIaMQYg>
    <xmx:_4YrZ_2G9oAsrmR6Ouj5ZNtCVYpabHknvI_eQnUgtIvDwInTrtcFbg>
    <xmx:_4YrZzch9fW1yOzZzhgxKArN7P1jb2i5ZDuCJ0upJydZH_DmQAbT_4fM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:10:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eff49797 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:30 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:10:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/26] git: refactor alias handling to use a `struct strvec`
Message-ID: <93aed59eaf67739e25dee4bd6cc0a3f2a527f345.1730901926.git.ps@pks.im>
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

In `handle_alias()` we use both `argcp` and `argv` as in-out parameters.
Callers mostly pass through the static array from `main()`, but once we
handle an alias we replace it with an allocated array that may contain
some allocated strings. Callers do not handle this scenario at all and
thus leak memory.

We could in theory handle the lifetime of `argv` in a hacky fashion by
letting callers free it in case they see that an alias was handled. But
while that would likely work, we still wouldn't be able to easily handle
the lifetime of strings referenced by `argv`.

Refactor the code to instead use a `struct strvec`, which effectively
removes the need for us to manually track lifetimes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c            | 58 ++++++++++++++++++++++++++----------------------
 t/t0014-alias.sh |  1 +
 2 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/git.c b/git.c
index c2c1b8e22c2..88356afe5fb 100644
--- a/git.c
+++ b/git.c
@@ -362,7 +362,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 	return (*argv) - orig_argv;
 }
 
-static int handle_alias(int *argcp, const char ***argv)
+static int handle_alias(struct strvec *args)
 {
 	int envchanged = 0, ret = 0, saved_errno = errno;
 	int count, option_count;
@@ -370,10 +370,10 @@ static int handle_alias(int *argcp, const char ***argv)
 	const char *alias_command;
 	char *alias_string;
 
-	alias_command = (*argv)[0];
+	alias_command = args->v[0];
 	alias_string = alias_lookup(alias_command);
 	if (alias_string) {
-		if (*argcp > 1 && !strcmp((*argv)[1], "-h"))
+		if (args->nr > 1 && !strcmp(args->v[1], "-h"))
 			fprintf_ln(stderr, _("'%s' is aliased to '%s'"),
 				   alias_command, alias_string);
 		if (alias_string[0] == '!') {
@@ -390,7 +390,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			child.wait_after_clean = 1;
 			child.trace2_child_class = "shell_alias";
 			strvec_push(&child.args, alias_string + 1);
-			strvec_pushv(&child.args, (*argv) + 1);
+			strvec_pushv(&child.args, args->v + 1);
 
 			trace2_cmd_alias(alias_command, child.args.v);
 			trace2_cmd_name("_run_shell_alias_");
@@ -423,15 +423,13 @@ static int handle_alias(int *argcp, const char ***argv)
 		trace_argv_printf(new_argv,
 				  "trace: alias expansion: %s =>",
 				  alias_command);
-
-		REALLOC_ARRAY(new_argv, count + *argcp);
-		/* insert after command name */
-		COPY_ARRAY(new_argv + count, *argv + 1, *argcp);
-
 		trace2_cmd_alias(alias_command, new_argv);
 
-		*argv = new_argv;
-		*argcp += count - 1;
+		/* Replace the alias with the new arguments. */
+		strvec_splice(args, 0, 1, new_argv, count);
+
+		free(alias_string);
+		free(new_argv);
 
 		ret = 1;
 	}
@@ -800,10 +798,10 @@ static void execv_dashed_external(const char **argv)
 		exit(128);
 }
 
-static int run_argv(int *argcp, const char ***argv)
+static int run_argv(struct strvec *args)
 {
 	int done_alias = 0;
-	struct string_list cmd_list = STRING_LIST_INIT_NODUP;
+	struct string_list cmd_list = STRING_LIST_INIT_DUP;
 	struct string_list_item *seen;
 
 	while (1) {
@@ -817,8 +815,8 @@ static int run_argv(int *argcp, const char ***argv)
 		 * process.
 		 */
 		if (!done_alias)
-			handle_builtin(*argcp, *argv);
-		else if (get_builtin(**argv)) {
+			handle_builtin(args->nr, args->v);
+		else if (get_builtin(args->v[0])) {
 			struct child_process cmd = CHILD_PROCESS_INIT;
 			int i;
 
@@ -834,8 +832,8 @@ static int run_argv(int *argcp, const char ***argv)
 			commit_pager_choice();
 
 			strvec_push(&cmd.args, "git");
-			for (i = 0; i < *argcp; i++)
-				strvec_push(&cmd.args, (*argv)[i]);
+			for (i = 0; i < args->nr; i++)
+				strvec_push(&cmd.args, args->v[i]);
 
 			trace_argv_printf(cmd.args.v, "trace: exec:");
 
@@ -850,13 +848,13 @@ static int run_argv(int *argcp, const char ***argv)
 			i = run_command(&cmd);
 			if (i >= 0 || errno != ENOENT)
 				exit(i);
-			die("could not execute builtin %s", **argv);
+			die("could not execute builtin %s", args->v[0]);
 		}
 
 		/* .. then try the external ones */
-		execv_dashed_external(*argv);
+		execv_dashed_external(args->v);
 
-		seen = unsorted_string_list_lookup(&cmd_list, *argv[0]);
+		seen = unsorted_string_list_lookup(&cmd_list, args->v[0]);
 		if (seen) {
 			int i;
 			struct strbuf sb = STRBUF_INIT;
@@ -873,14 +871,14 @@ static int run_argv(int *argcp, const char ***argv)
 			      " not terminate:%s"), cmd_list.items[0].string, sb.buf);
 		}
 
-		string_list_append(&cmd_list, *argv[0]);
+		string_list_append(&cmd_list, args->v[0]);
 
 		/*
 		 * It could be an alias -- this works around the insanity
 		 * of overriding "git log" with "git show" by having
 		 * alias.log = show
 		 */
-		if (!handle_alias(argcp, argv))
+		if (!handle_alias(args))
 			break;
 		done_alias = 1;
 	}
@@ -892,6 +890,7 @@ static int run_argv(int *argcp, const char ***argv)
 
 int cmd_main(int argc, const char **argv)
 {
+	struct strvec args = STRVEC_INIT;
 	const char *cmd;
 	int done_help = 0;
 
@@ -951,25 +950,32 @@ int cmd_main(int argc, const char **argv)
 	 */
 	setup_path();
 
+	for (size_t i = 0; i < argc; i++)
+		strvec_push(&args, argv[i]);
+
 	while (1) {
-		int was_alias = run_argv(&argc, &argv);
+		int was_alias = run_argv(&args);
 		if (errno != ENOENT)
 			break;
 		if (was_alias) {
 			fprintf(stderr, _("expansion of alias '%s' failed; "
 					  "'%s' is not a git command\n"),
-				cmd, argv[0]);
+				cmd, args.v[0]);
+			strvec_clear(&args);
 			exit(1);
 		}
 		if (!done_help) {
-			cmd = argv[0] = help_unknown_cmd(cmd);
+			strvec_replace(&args, 0, help_unknown_cmd(cmd));
+			cmd = args.v[0];
 			done_help = 1;
-		} else
+		} else {
 			break;
+		}
 	}
 
 	fprintf(stderr, _("failed to run command '%s': %s\n"),
 		cmd, strerror(errno));
+	strvec_clear(&args);
 
 	return 1;
 }
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 854d59ec58c..2a6f39ad9c8 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -2,6 +2,7 @@
 
 test_description='git command aliasing'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'nested aliases - internal execution' '
-- 
2.47.0.229.g8f8d6eee53.dirty

