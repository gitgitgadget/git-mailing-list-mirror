Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218BFC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 11:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKDLKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 07:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKDLKI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 07:10:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F221B793
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 04:10:06 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id io19so4555344plb.8
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 04:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xvnMsbBEPX2QWg87E2vMqBQ617yxYDUtJKNwFlkoY0w=;
        b=WeQtEj2rupCUVQGyFqC5XhMegddg3+wIGKwusKkLmvIHE7ec5Xm7qR2Ms463xZT3nh
         S62KQUXHrPsfQ0xVHx/wK7HxMiJzf7lIZvpYfmXd5nzKpKDwLEYzmF1JoFUTFCNab6Xv
         IA//x7j60AS0WKTVVUF15MTEtxwdL49dczVHHeTzb6iBa5XeH36Ak8NNetWYYU7sa+kL
         zRVL+Djub/KFFRQuCVHYz7LMierH0TYK48G7XJPLWwfClXmE3diXFS9YrrSIkN0cHnko
         oqD+BWTVe9J5paO3e+up4M1thxfPoTkcC65HmqfNluDY0Z1yJQMOozZTMMP+l8mtjEzX
         epNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvnMsbBEPX2QWg87E2vMqBQ617yxYDUtJKNwFlkoY0w=;
        b=p+c+Go0K2Cbf6ghOIAec/8m2GFyK3lowj0U1ZwigB5hmSg+QTBA3+ANPPA4Mwlun1/
         XZ4XEPd99xdeBSucCrItoKHIeRKFQpiA/O83rnfnwT0dLTkOxX6Yh6xaEhnlhR8hV3jB
         vucZlkrJvZvUtf7+7HD1nwAelVko7Bkj5/KgBpCB44WRIHSoW0Ua1abInOStFsGIwvnV
         EZizqRcajPjmQZMh7zfx+mQX5qAWXNNO5gduZL2wl6S6mg/QQBTlkl7FhOnDrrr0UG+k
         QfEw7fkMFeNgPAiv75DWEIJe3fouTVBQ9uMpGKzmb901A0lrilvTaAPlGuEeH332ppin
         Qk+g==
X-Gm-Message-State: ACrzQf0FHlm9INS4yEi40lLopaCifF60a9Py+Njdkuoeu73fMbVn2AF/
        rRQpPRn+HCZBqrpqRWX6JsEFYG3kdK8=
X-Google-Smtp-Source: AMsMyM5V9wPMJBTrnyU7XdDKok1AX9en86C2wT27DOembuCV2+sTPv22PslMULfxsmNZH8F9VY7EpQ==
X-Received: by 2002:a17:903:181:b0:187:ba:6f79 with SMTP id z1-20020a170903018100b0018700ba6f79mr36500789plg.117.1667560205568;
        Fri, 04 Nov 2022 04:10:05 -0700 (PDT)
Received: from localhost ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id y10-20020aa79aea000000b0056b9d9e2521sm2525556pfp.177.2022.11.04.04.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:10:05 -0700 (PDT)
Date:   Fri, 4 Nov 2022 18:10:02 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: "git bisect run" strips "--log" from the list of arguments
Message-ID: <Y2Ty6KZT8iACqHf+@danh.dev>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <Y2TfUFkLUa2tHdS7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2TfUFkLUa2tHdS7@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-04 05:45:52-0400, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 04, 2022 at 07:31:26AM +0100, Lukáš Doktor wrote:
> 
> > Steps to Reproduce:
> > 
> > 1. git bisect start BAD GOOD
> > 2. git bisect run ./myscript arg1 --log arg2 --log -- arg3 --log arg4
> > 
> > Results with 2.34.1:
> > 
> >     running  './myscript' 'arg1' 'arg2' '--' 'arg3' '--log' 'arg4'
> > 
> > Results with 2.33.0:
> > 
> >     running ./myscript arg1 --log arg2 --log -- arg3 --log arg4
> 
> Thanks for an easy reproduction recipe. I used this as an easy-to-see
> test case, which works in any repo:
> 
>   git bisect start HEAD HEAD~2 >/dev/null 2>&1
>   git bisect bisect run echo --log 2>&1 | grep running
> 
> > Is this expected? In https://bugzilla.redhat.com/show_bug.cgi?id=2139883 Todd suggested it might be related to
> > 
> >     d1bbbe45df (bisect--helper: reimplement `bisect_run` shell function in C, 2021-09-13) 
> > 
> > but I haven't tried it myself.
> 
> Yes, it bisects to that commit. +cc Christian, who mentored this gsoc
> project.
> 
> I think the problem is that we are now feeding the arguments to
> parse_options() in git bisect--helper, and it doesn't realize that it
> needs to stop after seeing that we are in "run" mode.  And because
> "--log" is an option to git-bisect--helper (it is the opposite of
> "--no-log"), it is consumed there.
> 
> As you noticed, the "--" stops parsing, so the one between "arg3" and
> "arg4" is preserved.
> 
> It feels like the invocation of bisect--helper ought to be passing "--"
> itself to indicate the end of options, like:

I think we should use OPT_SUBCOMMAND to parse bisect--helper
subcommand instead, which would pave ways for easier converting to
built-int git-bisect. This huge patch, which could be splited into
2 patches can fix the problem:
---- 8< ----

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1d2ce8a0e1..fe8aea7240 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1279,115 +1279,119 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 	return res;
 }
 
+static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED)
+{
+	if (argc > 1)
+		return error(_("--bisect-reset requires either no argument or a commit"));
+	return bisect_reset(argc ? argv[0] : NULL);
+}
+
+static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED)
+{
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	if (argc > 1)
+		return error(_("--bisect-terms requires 0 or 1 argument"));
+	return bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
+}
+
+static int cmd_bisect__start(int argc, const char **argv, const char *prefix UNUSED)
+{
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	set_terms(&terms, "bad", "good");
+	return bisect_start(&terms, argv, argc);
+}
+
+static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *prefix)
+{
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	if (argc)
+		return error(_("--bisect-next requires 0 arguments"));
+	get_terms(&terms);
+	return bisect_next(&terms, prefix);
+}
+
+static int cmd_bisect__state(int argc, const char **argv, const char *prefix UNUSED)
+{
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	set_terms(&terms, "bad", "good");
+	get_terms(&terms);
+	return bisect_state(&terms, argv, argc);
+}
+
+static int cmd_bisect__log(int argc, const char **argv UNUSED, const char *prefix UNUSED)
+{
+	if (argc)
+		return error(_("--bisect-log requires 0 arguments"));
+	return bisect_log();
+}
+
+static int cmd_bisect__replay(int argc, const char **argv, const char *prefix UNUSED)
+{
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	if (argc != 1)
+		return error(_("no logfile given"));
+	set_terms(&terms, "bad", "good");
+	return bisect_replay(&terms, argv[0]);
+}
+
+static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUSED)
+{
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	set_terms(&terms, "bad", "good");
+	get_terms(&terms);
+	return bisect_skip(&terms, argv, argc);
+}
+
+static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix UNUSED)
+{
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	get_terms(&terms);
+	return bisect_visualize(&terms, argv, argc);
+}
+
+static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSED)
+{
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	if (!argc)
+		return error(_("bisect run failed: no command provided."));
+	get_terms(&terms);
+	return bisect_run(&terms, argv, argc);
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	enum {
-		BISECT_RESET = 1,
-		BISECT_NEXT_CHECK,
-		BISECT_TERMS,
-		BISECT_START,
-		BISECT_AUTOSTART,
-		BISECT_NEXT,
-		BISECT_STATE,
-		BISECT_LOG,
-		BISECT_REPLAY,
-		BISECT_SKIP,
-		BISECT_VISUALIZE,
-		BISECT_RUN,
-	} cmdmode = 0;
-	int res = 0, nolog = 0;
+	int res = 0;
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
-		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
-			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
-			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
-		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
-			 N_("print out the bisect terms"), BISECT_TERMS),
-		OPT_CMDMODE(0, "bisect-start", &cmdmode,
-			 N_("start the bisect session"), BISECT_START),
-		OPT_CMDMODE(0, "bisect-next", &cmdmode,
-			 N_("find the next bisection commit"), BISECT_NEXT),
-		OPT_CMDMODE(0, "bisect-state", &cmdmode,
-			 N_("mark the state of ref (or refs)"), BISECT_STATE),
-		OPT_CMDMODE(0, "bisect-log", &cmdmode,
-			 N_("list the bisection steps so far"), BISECT_LOG),
-		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
-			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
-		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
-			 N_("skip some commits for checkout"), BISECT_SKIP),
-		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
-			 N_("visualize the bisection"), BISECT_VISUALIZE),
-		OPT_CMDMODE(0, "bisect-run", &cmdmode,
-			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
-		OPT_BOOL(0, "no-log", &nolog,
-			 N_("no log for BISECT_WRITE")),
+		OPT_SUBCOMMAND("bisect-reset", &fn, cmd_bisect__reset),
+		OPT_SUBCOMMAND("bisect-terms", &fn, cmd_bisect__terms),
+		OPT_SUBCOMMAND("bisect-start", &fn, cmd_bisect__start),
+		OPT_SUBCOMMAND("bisect-next", &fn, cmd_bisect__next),
+		OPT_SUBCOMMAND("bisect-state", &fn, cmd_bisect__state),
+		OPT_SUBCOMMAND("bisect-log", &fn, cmd_bisect__log),
+		OPT_SUBCOMMAND("bisect-replay", &fn, cmd_bisect__replay),
+		OPT_SUBCOMMAND("bisect-skip", &fn, cmd_bisect__skip),
+		OPT_SUBCOMMAND("bisect-visualize", &fn, cmd_bisect__visualize),
+		OPT_SUBCOMMAND("bisect-run", &fn, cmd_bisect__run),
 		OPT_END()
 	};
-	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
-
 	argc = parse_options(argc, argv, prefix, options,
-			     git_bisect_helper_usage,
-			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN_OPT);
+			     git_bisect_helper_usage, 0);
 
-	if (!cmdmode)
+	if (!fn)
 		usage_with_options(git_bisect_helper_usage, options);
+	argc--;
+	argv++;
 
-	switch (cmdmode) {
-	case BISECT_RESET:
-		if (argc > 1)
-			return error(_("--bisect-reset requires either no argument or a commit"));
-		res = bisect_reset(argc ? argv[0] : NULL);
-		break;
-	case BISECT_TERMS:
-		if (argc > 1)
-			return error(_("--bisect-terms requires 0 or 1 argument"));
-		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
-		break;
-	case BISECT_START:
-		set_terms(&terms, "bad", "good");
-		res = bisect_start(&terms, argv, argc);
-		break;
-	case BISECT_NEXT:
-		if (argc)
-			return error(_("--bisect-next requires 0 arguments"));
-		get_terms(&terms);
-		res = bisect_next(&terms, prefix);
-		break;
-	case BISECT_STATE:
-		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
-		res = bisect_state(&terms, argv, argc);
-		break;
-	case BISECT_LOG:
-		if (argc)
-			return error(_("--bisect-log requires 0 arguments"));
-		res = bisect_log();
-		break;
-	case BISECT_REPLAY:
-		if (argc != 1)
-			return error(_("no logfile given"));
-		set_terms(&terms, "bad", "good");
-		res = bisect_replay(&terms, argv[0]);
-		break;
-	case BISECT_SKIP:
-		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
-		res = bisect_skip(&terms, argv, argc);
-		break;
-	case BISECT_VISUALIZE:
-		get_terms(&terms);
-		res = bisect_visualize(&terms, argv, argc);
-		break;
-	case BISECT_RUN:
-		if (!argc)
-			return error(_("bisect run failed: no command provided."));
-		get_terms(&terms);
-		res = bisect_run(&terms, argv, argc);
-		break;
-	default:
-		BUG("unknown subcommand %d", cmdmode);
-	}
-	free_terms(&terms);
+	res = fn(argc, argv, prefix);
 
 	/*
 	 * Handle early success
diff --git a/git-bisect.sh b/git-bisect.sh
index 405cf76f2a..07a7257be4 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -58,26 +58,26 @@ case "$#" in
 	help)
 		git bisect -h ;;
 	start)
-		git bisect--helper --bisect-start "$@" ;;
+		git bisect--helper bisect-start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper --bisect-state "$cmd" "$@" ;;
+		git bisect--helper bisect-state "$cmd" "$@" ;;
 	skip)
-		git bisect--helper --bisect-skip "$@" || exit;;
+		git bisect--helper bisect-skip "$@" || exit;;
 	next)
 		# Not sure we want "next" at the UI level anymore.
-		git bisect--helper --bisect-next "$@" || exit ;;
+		git bisect--helper bisect-next "$@" || exit ;;
 	visualize|view)
-		git bisect--helper --bisect-visualize "$@" || exit;;
+		git bisect--helper bisect-visualize "$@" || exit;;
 	reset)
-		git bisect--helper --bisect-reset "$@" ;;
+		git bisect--helper bisect-reset "$@" ;;
 	replay)
-		git bisect--helper --bisect-replay "$@" || exit;;
+		git bisect--helper bisect-replay "$@" || exit;;
 	log)
-		git bisect--helper --bisect-log || exit ;;
+		git bisect--helper bisect-log || exit ;;
 	run)
-		git bisect--helper --bisect-run "$@" || exit;;
+		git bisect--helper bisect-run "$@" || exit;;
 	terms)
-		git bisect--helper --bisect-terms "$@" || exit;;
+		git bisect--helper bisect-terms "$@" || exit;;
 	*)
 		usage ;;
 	esac
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 83931d482f..e957772b05 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -266,6 +266,17 @@ test_expect_success '"git bisect run" simple case' '
 	git bisect reset
 '
 
+# We want to automatically find the commit that
+# added "Another" into hello. We also want to make sure --log is not eaten
+test_expect_success '"git bisect run" simple case' '
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect run printf "%s\n" --log >my_bisect_log.txt &&
+	grep -e --log my_bisect_log.txt &&
+	git bisect reset
+'
+
 # We want to automatically find the commit that
 # added "Ciao" into hello.
 test_expect_success '"git bisect run" with more complex "git bisect start"' '
----- >8 -----

I can turn this into 2 patches series if you thinks this is the right
direction.

-- 
Danh
