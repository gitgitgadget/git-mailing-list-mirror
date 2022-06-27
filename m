Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147B8CCA473
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbiF0ShP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbiF0Sga (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2727E18B23
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s1so14247123wra.9
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nXVMYcLWZAMrPSYJKYZsdZn/FbV67Pph+03E2sIMsUg=;
        b=ZhTlYEHqSSGORXgXD1vSjAPOLPHVZDwPO1vvshM/m7066hfyRwgvi12jlW/55EuKL9
         LuIU1H3v87jSU96dR4y26WwW43fBrvAeyjdyZ8b6HgceOYps4PqwR16JbqdsUJSmJhHA
         wqONCJbWOMAs0uk6Qq1UjJBJCpv2EZZ5zEmxeKqJv8uNeHREbMCyChNwqe+1g17dnvOB
         exsWVvHaGcuhBdNDl8jhsBfsyt6YuC9IuAdXtFzSjN91GZn+ZqmdpUftzLYXlpvnfhXE
         H/C/K2VMiqIhd8Zmo94zERmHws5RKhHUyRVZPKd7grGOHOcbkrlrtnmmT9+AZAzBMomr
         NohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nXVMYcLWZAMrPSYJKYZsdZn/FbV67Pph+03E2sIMsUg=;
        b=yaq2oIdh5UoYqZQVqkMbltPF9dOc1Vk4E3tqjSKvOjPCuDKxhcclubVPCeiD2VYrQl
         HVAKOwjvOBPJP9Y+/TWET/XQ/ODfgGQntUOzxOES02N0j0nyLhfavD+/H237iN7rwD9p
         UyNN4EsQbAU9+BWbbp802e6YbJeeZ1CMSs/62to/XwJ7B+8IIQG8tBJdCfdAYMj5mjJW
         fjdObi9n7Dh1C4nJh8iWc/TIQ2sCvlGRwi8Nj8HffAJpcNcfyXXrRdy+PsoV+3YpXB6W
         8+nYMNFFF2ssXxLDiZuPwrYHexZx6mWDyOdEqCXpZND8zDn/8V7OsldNrS1Ej3FaCp+F
         Z4DA==
X-Gm-Message-State: AJIora+sRZRyvKLlhKvIVqmKrwo3J96rXxbxx2i9xX84GJY6S1sK5lJL
        lSm6t5NMwWnZm4Q7yX92GDH4qFAnESRKzA==
X-Google-Smtp-Source: AGRyM1uUbDeQuZhjRG5/Vpxlf0LyadksFaGXZckfa9S6AmT6Po11EQTVgSvuvbO8qq+58hbm7NnNww==
X-Received: by 2002:a05:6000:1a8b:b0:219:ad61:f4e3 with SMTP id f11-20020a0560001a8b00b00219ad61f4e3mr14809892wry.190.1656354695323;
        Mon, 27 Jun 2022 11:31:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d6984000000b0021bbc5a26cfsm8323410wru.79.2022.06.27.11.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:34 -0700 (PDT)
Message-Id: <d56f2a140602d2029e1091c20172214045686ab9.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:14 +0000
Subject: [PATCH v4 13/16] bisect: move even the command-line parsing to
 `bisect--helper`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On our journey to a fully built-in `git bisect`, this is the
last step.

Side note: The `parse-options` API is not at all set up to parse
subcommands such as `git bisect start`, `git bisect reset`, etc.
Instead of fighting an up-hill battle trying to "fix" that, we simply
roll the same type of manual subcommand parsing as we already do e.g.
in `builtin/bundle.c`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 103 +++++++++++----------------------------
 git-bisect.sh            |  49 +------------------
 2 files changed, 30 insertions(+), 122 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1914aa7c69f..7232d650905 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -23,7 +23,7 @@ static const char *bisect_usage =
 	N_("git bisect [help|start|bad|good|new|old|terms|skip|next|reset|"
 	   "visualize|view|replay|log|run]");
 
-static const char * const bisect_long_usage[] = {
+static const char *bisect_long_usage =
 	N_("git bisect [help|start|bad|good|new|old|terms|skip|next|reset|"
 	   "visualize|view|replay|log|run]\n"
 	   "\n"
@@ -58,9 +58,7 @@ static const char * const bisect_long_usage[] = {
 	   "git bisect run <cmd>...\n"
 	   "\tuse <cmd>... to automatically bisect.\n"
 	   "\n"
-	   "Please use \"git help bisect\" to get the full man page."),
-	NULL
-};
+	   "Please use \"git help bisect\" to get the full man page.");
 
 struct add_bisect_ref_data {
 	struct rev_info *revs;
@@ -1305,110 +1303,67 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	enum {
-		BISECT_START = 1,
-		BISECT_STATE,
-		BISECT_TERMS,
-		BISECT_SKIP,
-		BISECT_NEXT,
-		BISECT_RESET,
-		BISECT_VISUALIZE,
-		BISECT_REPLAY,
-		BISECT_LOG,
-		BISECT_RUN,
-	} cmdmode = 0;
 	int res = 0;
-	struct option options[] = {
-		OPT_CMDMODE(0, "bisect-start", &cmdmode,
-			 N_("start the bisect session"), BISECT_START),
-		OPT_CMDMODE(0, "bisect-state", &cmdmode,
-			 N_("mark the state of ref (or refs)"), BISECT_STATE),
-		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
-			 N_("print out the bisect terms"), BISECT_TERMS),
-		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
-			 N_("skip some commits for checkout"), BISECT_SKIP),
-		OPT_CMDMODE(0, "bisect-next", &cmdmode,
-			 N_("find the next bisection commit"), BISECT_NEXT),
-		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
-			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
-			 N_("visualize the bisection"), BISECT_VISUALIZE),
-		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
-			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
-		OPT_CMDMODE(0, "bisect-log", &cmdmode,
-			 N_("list the bisection steps so far"), BISECT_LOG),
-		OPT_CMDMODE(0, "bisect-run", &cmdmode,
-			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
-		OPT_END()
-	};
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+	const char *command = argc > 1 ? argv[1] : "help";
+
+	if (!strcmp("-h", command) || !strcmp("help", command))
+		usage(bisect_long_usage);
 
-	argc = parse_options(argc, argv, prefix, options,
-			     bisect_long_usage,
-			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
+	argc -= 2;
+	argv += 2;
 
-	switch (cmdmode ? cmdmode : BISECT_STATE) {
-	case BISECT_START:
+	if (!strcmp("start", command)) {
 		set_terms(&terms, "bad", "good");
 		res = bisect_start(&terms, argv, argc);
-		break;
-	case BISECT_TERMS:
+	} else if (!strcmp("terms", command)) {
 		if (argc > 1)
-			die(_("--bisect-terms requires 0 or 1 argument"));
+			die(_("'terms' requires 0 or 1 argument"));
 		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
-		break;
-	case BISECT_SKIP:
+	} else if (!strcmp("skip", command)) {
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
 		res = bisect_skip(&terms, argv, argc);
-		break;
-	case BISECT_NEXT:
+	} else if (!strcmp("next", command)) {
 		if (argc)
-			die(_("--bisect-next requires 0 arguments"));
+			die(_("'next' requires 0 arguments"));
 		get_terms(&terms);
 		res = bisect_next(&terms, prefix);
-		break;
-	case BISECT_RESET:
+	} else if (!strcmp("reset", command)) {
 		if (argc > 1)
-			die(_("--bisect-reset requires either no argument or a commit"));
+			die(_("'reset' requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
-		break;
-	case BISECT_VISUALIZE:
+	} else if (one_of(command, "visualize", "view", NULL)) {
 		get_terms(&terms);
 		res = bisect_visualize(&terms, argv, argc);
-		break;
-	case BISECT_REPLAY:
+	} else if (!strcmp("replay", command)) {
 		if (argc != 1)
 			die(_("no logfile given"));
 		set_terms(&terms, "bad", "good");
 		res = bisect_replay(&terms, argv[0]);
-		break;
-	case BISECT_LOG:
+	} else if (!strcmp("log", command)) {
 		if (argc)
-			die(_("--bisect-log requires 0 arguments"));
+			die(_("'log' requires 0 arguments"));
 		res = bisect_log();
-		break;
-	case BISECT_RUN:
+	} else if (!strcmp("run", command)) {
 		if (!argc)
 			die(_("bisect run failed: no command provided."));
 		get_terms(&terms);
 		res = bisect_run(&terms, argv, argc);
-		break;
-	case BISECT_STATE:
-		if (argc &&
-		    !file_is_not_empty(git_path_bisect_start()) &&
-		    !one_of(argv[0], "bad", "good", "new", "old", NULL))
+	} else {
+		if (!file_is_not_empty(git_path_bisect_start()) &&
+		    !one_of(command, "bad", "good", "new", "old", NULL))
 			usage(bisect_usage);
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-		if (!cmdmode &&
-		    (!argc || check_and_set_terms(&terms, argv[0])))
+		if (check_and_set_terms(&terms, command))
 			usage(bisect_usage);
+		/* shift the `command` back in */
+		argc++;
+		argv--;
 		res = bisect_state(&terms, argv, argc);
-		break;
-	default:
-		BUG("unknown subcommand %d", cmdmode);
 	}
+
 	free_terms(&terms);
 
 	/*
diff --git a/git-bisect.sh b/git-bisect.sh
index fbf56649d7d..028d39cd9ce 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -34,51 +34,4 @@ Please use "git help bisect" to get the full man page.'
 OPTIONS_SPEC=
 . git-sh-setup
 
-TERM_BAD=bad
-TERM_GOOD=good
-
-get_terms () {
-	if test -s "$GIT_DIR/BISECT_TERMS"
-	then
-		{
-		read TERM_BAD
-		read TERM_GOOD
-		} <"$GIT_DIR/BISECT_TERMS"
-	fi
-}
-
-case "$#" in
-0)
-	usage ;;
-*)
-	cmd="$1"
-	get_terms
-	shift
-	case "$cmd" in
-	help)
-		git bisect -h ;;
-	start)
-		git bisect--helper --bisect-start "$@" ;;
-	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper "$cmd" "$@" ;;
-	skip)
-		git bisect--helper --bisect-skip "$@" || exit;;
-	next)
-		# Not sure we want "next" at the UI level anymore.
-		git bisect--helper --bisect-next "$@" || exit ;;
-	visualize|view)
-		git bisect--helper --bisect-visualize "$@" || exit;;
-	reset)
-		git bisect--helper --bisect-reset "$@" ;;
-	replay)
-		git bisect--helper --bisect-replay "$@" || exit;;
-	log)
-		git bisect--helper --bisect-log || exit ;;
-	run)
-		git bisect--helper --bisect-run "$@" || exit;;
-	terms)
-		git bisect--helper --bisect-terms "$@" || exit;;
-	*)
-		usage ;;
-	esac
-esac
+exec git bisect--helper "$@"
-- 
gitgitgadget

