Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153C4ECAAD6
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 09:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245226AbiHZJjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 05:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343852AbiHZJjf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 05:39:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A6CBD4C6
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 02:39:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bu22so791760wrb.3
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 02:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Xz7J6OrGaIgQ7hSnkce2GXnpTMORuOGYW2GpHHfDyeQ=;
        b=AaYVzruWuFNBfwmQ/0Dhced/NgnoTbi+qO/KBKi8MzyEzhoTY6KMcLudn0PB0Kcy76
         cazPluljyvoOqxKg9LQWMKTTBFP9+a2700hM4pftjtG8+KAuqWUzC+xGqpsqPqMmbrBR
         hxpfIMfqTFFICNJy/RAqCu5lxXyBIL6qf+H0I/CsL0Y5WdIMlsD6UEyxfg9VbesU0xu6
         ezrCydoNsBGz8dVd+pQOGJ8FL31sLZ1TZ7J7fE/oErHWcJJz/T3ocfsp/hp4FPJvRQkc
         uzUPKjHIsI79VO39Dy//D2WFYn+RHIAcWv13IHFstllyruw33t4d2xVZntAqKD5r2a1C
         n8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Xz7J6OrGaIgQ7hSnkce2GXnpTMORuOGYW2GpHHfDyeQ=;
        b=A8Ob4evthCIUpxXQ72JRZpc2S7ogKcJ8oAUnAIRow/7s31eSL7XwDx7rf2jCS5JWgS
         bdhCIR6fdzw3e0x5XNZF9Btf8GHZYH7f2j1kFP1exSzmoFmyA0LwTVgWmtbbn+2gpzOx
         QfQX8NACj8gViELTb/3OgKct7WqFp12Z2G2IowGbYndLXIvVkeggKY0SLgFQ7e/uyaoB
         xSpnTH4PO0gmUgbBSdXuvIMd2LCnXlVQRSsm1LusyRMzkfaAMHIb1AtTFXrlapxMlBNp
         6NFlNqcFYNrV48anyixDLDtNFRK/Sw/9rxzcbICPAYBz3Wck0ckwJZW1jy3qL4W92MM0
         V87w==
X-Gm-Message-State: ACgBeo0nsgxv/z/ZhCxkGRxaF54W5AcekrJ8q7ae7mNOcnDy1B3WFd3D
        qolNoiDKH2TfY+z/krsBBf/HEX15uWs=
X-Google-Smtp-Source: AA6agR4unQDOd6y0zk+Yo+wUJKnLfRLqycWIOoNsQ963N8RhP0C3OH8Bp2SqCbkanHIaiXYXV6dvZw==
X-Received: by 2002:a5d:5388:0:b0:225:4427:696a with SMTP id d8-20020a5d5388000000b002254427696amr4503264wrv.355.1661506772566;
        Fri, 26 Aug 2022 02:39:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bj22-20020a0560001e1600b002251639bfd0sm1400493wrb.59.2022.08.26.02.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 02:39:31 -0700 (PDT)
Message-Id: <pull.1335.v2.git.1661506770.gitgitgadget@gmail.com>
In-Reply-To: <pull.1335.git.1661258122.gitgitgadget@gmail.com>
References: <pull.1335.git.1661258122.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Aug 2022 09:39:27 +0000
Subject: [PATCH v2 0/3] Allow passing pathspecs to git range-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just had the need to find out upstream commits corresponding to a handful
of backported commits, and most importantly, identify upstream commits
touching a given file that had not yet been backported.

This new mode helped me identify them.

Changes since v1:

 * The command-line parameter parsing now avoids duplicating code as much as
   possible.
 * This also fixes a bug where git range-diff <incorrect-symmetric-range> --
   <pathspec> was mistaken for using the three-revision stanza.
 * Consistent validation of the command-line arguments has been extracted
   into its own patch.
 * Sadly, these changes make the overall diff much larger. I hope that the
   readability is worth that price.

Johannes Schindelin (3):
  range-diff: reorder argument handling
  range-diff: consistently validate the arguments
  range-diff: optionally accept pathspecs

 Documentation/git-range-diff.txt |   4 ++
 builtin/range-diff.c             | 101 +++++++++++++++++++++++--------
 range-diff.c                     |   2 +-
 t/t3206-range-diff.sh            |  13 +++-
 4 files changed, 94 insertions(+), 26 deletions(-)


base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1335%2Fdscho%2Frange-diff-with-pathspec-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1335/dscho/range-diff-with-pathspec-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1335

Range-diff vs v1:

 1:  7fe4f228ae0 ! 1:  150f29a1c48 range-diff: reorder argument handling
     @@ Commit message
          In preparation for allowing pathspecs in `git range-diff` invocations,
          where we no longer have the luxury of using the number of arguments to
          disambiguate between these three different ways to specify the commit
     -    ranges, we need to order these cases by argument count, in ascending
     +    ranges, we need to order these cases by argument count, in descending
          order.
      
          This patch is best viewed with `--color-moved`.
     @@ builtin/range-diff.c: int cmd_range_diff(int argc, const char **argv, const char
       		diffopt.use_color = 1;
       
      -	if (argc == 2) {
     --		if (!is_range_diff_range(argv[0]))
     --			die(_("not a commit range: '%s'"), argv[0]);
     --		strbuf_addstr(&range1, argv[0]);
     --
     --		if (!is_range_diff_range(argv[1]))
     --			die(_("not a commit range: '%s'"), argv[1]);
     --		strbuf_addstr(&range2, argv[1]);
     ++	if (argc == 3) {
     ++		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
     ++		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
     ++	} else if (argc == 2) {
     + 		if (!is_range_diff_range(argv[0]))
     + 			die(_("not a commit range: '%s'"), argv[0]);
     + 		strbuf_addstr(&range1, argv[0]);
     +@@ builtin/range-diff.c: int cmd_range_diff(int argc, const char **argv, const char *prefix)
     + 		if (!is_range_diff_range(argv[1]))
     + 			die(_("not a commit range: '%s'"), argv[1]);
     + 		strbuf_addstr(&range2, argv[1]);
      -	} else if (argc == 3) {
      -		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
      -		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
     --	} else if (argc == 1) {
     -+	if (argc == 1) {
     + 	} else if (argc == 1) {
       		const char *b = strstr(argv[0], "..."), *a = argv[0];
       		int a_len;
     - 
     -@@ builtin/range-diff.c: int cmd_range_diff(int argc, const char **argv, const char *prefix)
     - 			b = "HEAD";
     - 		strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
     - 		strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
     -+	} else if (argc == 2) {
     -+		if (!is_range_diff_range(argv[0]))
     -+			die(_("not a commit range: '%s'"), argv[0]);
     -+		strbuf_addstr(&range1, argv[0]);
     -+
     -+		if (!is_range_diff_range(argv[1]))
     -+			die(_("not a commit range: '%s'"), argv[1]);
     -+		strbuf_addstr(&range2, argv[1]);
     -+	} else if (argc == 3) {
     -+		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
     -+		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
     - 	} else {
     - 		error(_("need two commit ranges"));
     - 		usage_with_options(builtin_range_diff_usage, options);
 -:  ----------- > 2:  4cd7f09557c range-diff: consistently validate the arguments
 2:  064b147451b ! 3:  a52ad40e015 range-diff: optionally accept a pathspec
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    range-diff: optionally accept a pathspec
     +    range-diff: optionally accept pathspecs
      
          The `git range-diff` command can be quite expensive, which is not a
          surprise given that the underlying algorithm to match up pairs of
     @@ Documentation/git-range-diff.txt: DESCRIPTION
      
       ## builtin/range-diff.c ##
      @@ builtin/range-diff.c: int cmd_range_diff(int argc, const char **argv, const char *prefix)
     + 		OPT_END()
     + 	};
       	struct option *options;
     - 	int res = 0;
     +-	int res = 0;
     ++	int i, dash_dash = -1, res = 0;
       	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
     -+	struct object_id oid;
     -+	const char *p;
     + 	struct object_id oid;
     ++	const char *three_dots = NULL;
       
       	git_config(git_diff_ui_config, NULL);
       
     @@ builtin/range-diff.c: int cmd_range_diff(int argc, const char **argv, const char
       	diff_setup_done(&diffopt);
       
      @@ builtin/range-diff.c: int cmd_range_diff(int argc, const char **argv, const char *prefix)
     - 			b = "HEAD";
     - 		strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
     - 		strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
     -+	} else if (argc > 1 && (p = strstr(argv[0], "..."))) {
     -+		const char *a = argv[0];
     -+		int a_len = (int)(p - a);
     -+
     -+		if (!a_len) {
     -+			a = "HEAD";
     -+			a_len = strlen(a);
     + 	if (!simple_color)
     + 		diffopt.use_color = 1;
     + 
     +-	if (argc == 3) {
     +-		if (get_oid_committish(argv[0], &oid))
     ++	for (i = 0; i < argc; i++)
     ++		if (!strcmp(argv[i], "--")) {
     ++			dash_dash = i;
     ++			break;
      +		}
     -+		p += 3;
     -+		if (!*p)
     -+			p = "HEAD";
     -+		strbuf_addf(&range1, "%s..%.*s", p, a_len, a);
     -+		strbuf_addf(&range2, "%.*s..%s", a_len, a, p);
     -+		strvec_pushv(&other_arg, argv + 1);
     - 	} else if (argc == 2) {
     - 		if (!is_range_diff_range(argv[0]))
     - 			die(_("not a commit range: '%s'"), argv[0]);
     ++
     ++	if (dash_dash == 3 ||
     ++	    (dash_dash < 0 && argc > 2 &&
     ++	     !get_oid_committish(argv[0], &oid) &&
     ++	     !get_oid_committish(argv[1], &oid) &&
     ++	     !get_oid_committish(argv[2], &oid))) {
     ++		if (dash_dash < 0)
     ++			; /* already validated arguments */
     ++		else if (get_oid_committish(argv[0], &oid))
     + 			usage_msg_optf(_("not a revision: '%s'"),
     + 				       builtin_range_diff_usage, options,
     + 				       argv[0]);
      @@ builtin/range-diff.c: int cmd_range_diff(int argc, const char **argv, const char *prefix)
     - 		if (!is_range_diff_range(argv[1]))
     - 			die(_("not a commit range: '%s'"), argv[1]);
     - 		strbuf_addstr(&range2, argv[1]);
     -+	} else if (argc > 2 &&
     -+	    is_range_diff_range(argv[0]) && is_range_diff_range(argv[1])) {
     -+		strbuf_addstr(&range1, argv[0]);
     -+		strbuf_addstr(&range2, argv[1]);
     -+		strvec_pushv(&other_arg, argv + 2);
     - 	} else if (argc == 3) {
     + 
       		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
       		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
     -+	} else if (argc > 3 &&
     -+		   get_oid_committish(argv[0], &oid) &&
     -+		   get_oid_committish(argv[1], &oid) &&
     -+		   get_oid_committish(argv[2], &oid)) {
     -+		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
     -+		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
     -+		strvec_pushv(&other_arg, argv + 3);
     - 	} else {
     - 		error(_("need two commit ranges"));
     - 		usage_with_options(builtin_range_diff_usage, options);
     +-	} else if (argc == 2) {
     +-		if (!is_range_diff_range(argv[0]))
     ++
     ++		strvec_pushv(&other_arg, argv +
     ++			     (dash_dash < 0 ? 3 : dash_dash));
     ++	} else if (dash_dash == 2 ||
     ++		   (dash_dash < 0 && argc > 1 &&
     ++		    is_range_diff_range(argv[0]) &&
     ++		    is_range_diff_range(argv[1]))) {
     ++		if (dash_dash < 0)
     ++			; /* already validated arguments */
     ++		else if (!is_range_diff_range(argv[0]))
     + 			usage_msg_optf(_("not a commit range: '%s'"),
     + 				       builtin_range_diff_usage, options,
     + 				       argv[0]);
     +@@ builtin/range-diff.c: int cmd_range_diff(int argc, const char **argv, const char *prefix)
     + 
     + 		strbuf_addstr(&range1, argv[0]);
     + 		strbuf_addstr(&range2, argv[1]);
     +-	} else if (argc == 1) {
     +-		const char *b = strstr(argv[0], "..."), *a = argv[0];
     ++
     ++		strvec_pushv(&other_arg, argv +
     ++			     (dash_dash < 0 ? 2 : dash_dash));
     ++	} else if (dash_dash == 1 ||
     ++		   (dash_dash < 0 && argc > 0 &&
     ++		    (three_dots = strstr(argv[0], "...")))) {
     ++		const char *a, *b;
     + 		int a_len;
     + 
     +-		if (!b)
     ++		if (dash_dash < 0)
     ++			; /* already validated arguments */
     ++		else if (!(three_dots = strstr(argv[0], "...")))
     + 			usage_msg_optf(_("not a symmetric range: '%s'"),
     +-				       builtin_range_diff_usage, options,
     +-				       argv[0]);
     ++					 builtin_range_diff_usage, options,
     ++					 argv[0]);
     + 
     +-		a_len = (int)(b - a);
     +-		if (!a_len) {
     ++		if (three_dots == argv[0]) {
     + 			a = "HEAD";
     + 			a_len = strlen(a);
     ++		} else {
     ++			a = argv[0];
     ++			a_len = (int)(three_dots - a);
     + 		}
     +-		b += 3;
     +-		if (!*b)
     ++
     ++		if (three_dots[3])
     ++			b = three_dots + 3;
     ++		else
     + 			b = "HEAD";
     ++
     + 		strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
     + 		strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
     ++
     ++		strvec_pushv(&other_arg, argv +
     ++			     (dash_dash < 0 ? 1 : dash_dash));
     + 	} else
     + 		usage_msg_opt(_("need two commit ranges"),
     + 			      builtin_range_diff_usage, options);
      
       ## range-diff.c ##
      @@ range-diff.c: static int read_patches(const char *range, struct string_list *list,
     @@ range-diff.c: static int read_patches(const char *range, struct string_list *lis
       	cp.git_cmd = 1;
      
       ## t/t3206-range-diff.sh ##
     +@@ t/t3206-range-diff.sh: test_expect_success 'A^! and A^-<n> (unmodified)' '
     + '
     + 
     + test_expect_success 'A^{/..} is not mistaken for a range' '
     +-	test_must_fail git range-diff topic^.. topic^{/..} 2>error &&
     ++	test_must_fail git range-diff topic^.. topic^{/..} -- 2>error &&
     + 	test_i18ngrep "not a commit range" error
     + '
     + 
      @@ t/t3206-range-diff.sh: test_expect_success '--left-only/--right-only' '
       	test_cmp expect actual
       '

-- 
gitgitgadget
