Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91D918A956
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321538; cv=none; b=AzmM7uuSW3ZRnWQbhteoWHauHsB/XgfZyVdMgmTdrPkSm6DWd6FJrYcIZ+j77bXuGXvaIkguSLCB8//vL98LR35innIcs4yD8TCYHmbh26xVQGitc45u4PCEmSt3+DLgDAnQy3BdrLDXiN0OwesCXD/xesfi77+FZgP4DI7OQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321538; c=relaxed/simple;
	bh=NVe534/FfgbOTRvy0G/lEpUw+uB16xGDVjQHtDE3jbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3vRnl4lYhz1roTtm/ua6IULb/5Jch7IJgnni8c/+lGu4HLVNnVR1iivSAi2H620OCH+ci6ZDD5axPOEH/3JO7UQP4SgN51KPhL25xAgZMpwcE4N5xy5Iyd6uazbO+PtA9tQ3tw7C6c4q6XVsWOUxr5D4p3Ft2GoCw6+En/xO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sZzSc++k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CAAycCnV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sZzSc++k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CAAycCnV"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F1DB3114015C;
	Mon, 11 Nov 2024 05:38:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 05:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321535;
	 x=1731407935; bh=ZTe1849Z7PZeZGT6m+uGegeYpxf5rgBXV+/QzQCyWbA=; b=
	sZzSc++khDr+OIVY45tH7Xe/kz1t9Byffmkl1AeAc7hdVQEKZZPkPAnxKLNKMUPr
	cNhkh8ZjdtsDY13jPYw+Xe/fnEID7YHynbA+8Fjq/Sph6R9MJHpu5f4EvXzeHo6G
	6aFQfOdCIsKFFIELudBPHaGG2UzHaWRL7aSdpKrLmLqoqvIEZCduki2MuxY9ojod
	ofYX5X+nZbAcWNnzOZnqKlTsjg0ivuFqYf1e8k/14iezpu9Mzy+AT1fa1BW31dDQ
	XUcbvwMFx1sPTJVb8TSIEHKr26Ggyqsm0Gprxkb7pJd1tolk97Q36MKfJWhZjNzK
	CpTdIrHMpuwOK7ViHihNZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321535; x=
	1731407935; bh=ZTe1849Z7PZeZGT6m+uGegeYpxf5rgBXV+/QzQCyWbA=; b=C
	AAycCnVIxydxEiwQhil5fSHIJWvKllISiUHnfB78DfckTSmfu7yVzwo+dAEbcJ1a
	e9XC2WDH0Ub+gUccUVltOrjR/919NWEzBaBXbo01FdTQViX4lxmoAZe70b0SNvNA
	Q/exRgwDxCDUgnshZ9MNHnt537ikhhSpmU2dvzj8Uiyq3pQT2cTVyEwBZ3BnkiSq
	NiAkulZ5dBnu5Vow9S4KQQB4ra2wweztKFHwg6ovV/vIlzDj4XCcnVysUAlbDT/J
	bmnQISnQertwmAw9c+j/2X8eSJ0H0W2FVr0HHEbU/hp24t+nBV7qRyUWV1o/tLFd
	MUwvOK/BNvGsDsIxhOSGQ==
X-ME-Sender: <xms:v94xZ9jC72uRcl4zkMFBZuEj9iu-IoNGyY9j6js3oA_PwUmWM5oqeg>
    <xme:v94xZyAiOpVPyDMp5hXKAqola_8HSuuB18heM4_ZltqG3avPLc5YNpGQLmHLS3PjL
    xjiWTMnd-0H0qrGdQ>
X-ME-Received: <xmr:v94xZ9GfSfFihvtTYBOCE1LriqhrsrcLn-oF226mEL0bT7N-YtUeC2proU-TzTXr3pv1FfRV-ZKfEW4QmWk9zEfYKtA1_TDHnfu_rhyJQns9asCc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrjhhushhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:v94xZyQ-frmwain8VDwRKI5SqOZtmvMDxHnOwZ5uRG7GliRLQ66Xjw>
    <xmx:v94xZ6yRCCSDVwUFKAFxqYHchnj08um4krF89nRPP90FGaJiTOYfZA>
    <xmx:v94xZ44q_f2M6K_ncncW9WfVqulTjZEIbeHUUJN3TwGh_8a8ICfirA>
    <xmx:v94xZ_xDjGrEKmMazONwFzdDvmoEsvrgn-ZgAHYmYczekRRVcFh9Mw>
    <xmx:v94xZ1-oO5bBZwu6EfMDYvC7RnyfQ8CCVBWsvXkk9rDM4ygw4Rtiaonl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 339bb9fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:39 +0100
Subject: [PATCH v2 10/27] git: refactor alias handling to use a `struct
 strvec`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-10-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

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
 git.c            | 58 +++++++++++++++++++++++++++++++-------------------------
 t/t0014-alias.sh |  1 +
 2 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/git.c b/git.c
index c2c1b8e22c2d91824ad6d631ea9374424ab53435..88356afe5fb568ccc147f055e3ab253c53a1befa 100644
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
index 854d59ec58c25ab2cfb58113bf5ea8d670829fe0..2a6f39ad9c81958d5152139995feab57c4371363 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -2,6 +2,7 @@
 
 test_description='git command aliasing'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'nested aliases - internal execution' '

-- 
2.47.0.229.g8f8d6eee53.dirty

