Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26162C33CBA
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E656920728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+wu5dsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgAPQJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:09:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35789 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgAPQJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 11:09:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so19712445wro.2
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 08:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o54LTk41F7GdjdM41hLXdu642jqyPrhLkXFEoFT0caQ=;
        b=e+wu5dsmBOTYRdcGyiNtMh0ey9VdjgjNF0sMT2eLPlcrxwLbH/pnx+cvYAAZnuRBDL
         +CSTFYoqRMsospjIm4pEIT+MLr/KBxUkljdPAhPVrh8WWjFb7BLRwAROTgya9wLcGmFa
         6/rPiLes4taQdzFSU17iaveKXpp75OWF3RsrZS7BqLohQVhlNbslL6q76Jq6rnqTjeaD
         14jNn3e32LRzvbYeqExtnYx8Np+lVdVGiTNJP4nb/MTqmOerkAXymvAyva5x3MgE2TkE
         1/FaXKvgi94+mn9kJYs7rQu5ELhXtoPC7g8utbCqKtH2CUcRl6+ZxcwPd4seqwd3de6F
         GXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o54LTk41F7GdjdM41hLXdu642jqyPrhLkXFEoFT0caQ=;
        b=SjWMvt6JhecDEp7Wl6jUQMNLfhM20Juh73BAIYQ1C8ThtfApCngV102PbxHfsE55VH
         045DYUWr9V1eMHpLOCdS06htl2hisnnn0tN+TVZAZq+JpYu/t7d1+I0hUNK+cHITL/V5
         kiNrhbuCVqgpWVWJJMvq47SDSTRW3oQ5VucTDevDPgePfIgledBCPCG9imQv9a59efWr
         Afo8rXRd6vYMfohMvq+I1SGBPLPUPm4/MN/Cv6nGWSmV9Gcx1No3Ji5xco2ov/BXTXSN
         2gPaq8wOsa58gUCCjSBdEj5EcQwg7AdDNuNfAn/Fok+XttjwiHUv7aB0LVLYxiyXg2PA
         e0qA==
X-Gm-Message-State: APjAAAWusNSGta0cVMDhRsQ5+jsE/6JRmP4hY3Tp1Xx+i9bXge5CpgF1
        56SKzA9kPJbTDZeZh9pxGUpSFqtC
X-Google-Smtp-Source: APXvYqxFFWVskDelYu/2bTVbefYLtcv4tRaamzzGrdnHwIywDUBbf2ulrvABLHFSdlrzum0BE2cVUQ==
X-Received: by 2002:adf:97d6:: with SMTP id t22mr312868wrb.407.1579190974616;
        Thu, 16 Jan 2020 08:09:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n189sm1481067wme.33.2020.01.16.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:09:34 -0800 (PST)
Message-Id: <7a8d36d49f85940d95f989741e68ba480abaa4eb.1579190965.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.git.1579190965.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 16:09:24 +0000
Subject: [PATCH 7/8] stash: eliminate crude option parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Eliminate crude option parsing and rely on real parsing instead, because
1) Crude parsing is crude, for example it's not capable of
   handling things like `git stash -m Message`
2) Adding options in two places is inconvenient and prone to bugs

As a side result, the case of `git stash -m Message` gets fixed.
Also give a good error message instead of just throwing usage at user.

----

Some review of what's been happening to this code:

Before [1], `git-stash.sh` only verified that all args begin with `-` :

	# The default command is "push" if nothing but options are given
	seen_non_option=
	for opt
	do
		case "$opt" in
		--) break ;;
		-*) ;;
		*) seen_non_option=t; break ;;
		esac
	done

Later, [1] introduced the duplicate code I'm now removing, also making
the previous test more strict by white-listing options.

----

[1] Commit 40af1468 ("stash: convert `stash--helper.c` into `stash.c`" 2019-02-26)

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/stash.c  | 59 +++++++++++++++++-------------------------------
 t/t3903-stash.sh |  5 ++++
 2 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 4ad3adf4ba..7bc4c5d696 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1448,8 +1448,10 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 	return ret;
 }
 
-static int push_stash(int argc, const char **argv, const char *prefix)
+static int push_stash(int argc, const char **argv, const char *prefix,
+		      int push_assumed)
 {
+	int force_assume = 0;
 	int keep_index = -1;
 	int patch_mode = 0;
 	int include_untracked = 0;
@@ -1471,10 +1473,22 @@ static int push_stash(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	if (argc)
+	if (argc) {
+		force_assume = !strcmp(argv[0], "-p");
 		argc = parse_options(argc, argv, prefix, options,
 				     git_stash_push_usage,
-				     0);
+				     PARSE_OPT_KEEP_DASHDASH);
+	}
+
+	if (argc) {
+		if (!strcmp(argv[0], "--")) {
+			argc--;
+			argv++;
+		} else if (push_assumed && !force_assume) {
+			die("subcommand wasn't specified; 'push' can't be assumed due to unexpected token '%s'",
+			    argv[0]);
+		}
+	}
 
 	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
 		       prefix, argv);
@@ -1547,7 +1561,6 @@ static int use_builtin_stash(void)
 
 int cmd_stash(int argc, const char **argv, const char *prefix)
 {
-	int i = -1;
 	pid_t pid = getpid();
 	const char *index_file;
 	struct argv_array args = ARGV_ARRAY_INIT;
@@ -1580,7 +1593,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 		    (uintmax_t)pid);
 
 	if (!argc)
-		return !!push_stash(0, NULL, prefix);
+		return !!push_stash(0, NULL, prefix, 0);
 	else if (!strcmp(argv[0], "apply"))
 		return !!apply_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "clear"))
@@ -1600,45 +1613,15 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	else if (!strcmp(argv[0], "create"))
 		return !!create_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "push"))
-		return !!push_stash(argc, argv, prefix);
+		return !!push_stash(argc, argv, prefix, 0);
 	else if (!strcmp(argv[0], "save"))
 		return !!save_stash(argc, argv, prefix);
 	else if (*argv[0] != '-')
 		usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 			      git_stash_usage, options);
 
-	if (strcmp(argv[0], "-p")) {
-		while (++i < argc && strcmp(argv[i], "--")) {
-			/*
-			 * `akpqu` is a string which contains all short options,
-			 * except `-m` which is verified separately.
-			 */
-			if ((strlen(argv[i]) == 2) && *argv[i] == '-' &&
-			    strchr("akpqu", argv[i][1]))
-				continue;
-
-			if (!strcmp(argv[i], "--all") ||
-			    !strcmp(argv[i], "--keep-index") ||
-			    !strcmp(argv[i], "--no-keep-index") ||
-			    !strcmp(argv[i], "--patch") ||
-			    !strcmp(argv[i], "--quiet") ||
-			    !strcmp(argv[i], "--include-untracked"))
-				continue;
-
-			/*
-			 * `-m` and `--message=` are verified separately because
-			 * they need to be immediately followed by a string
-			 * (i.e.`-m"foobar"` or `--message="foobar"`).
-			 */
-			if (starts_with(argv[i], "-m") ||
-			    starts_with(argv[i], "--message="))
-				continue;
-
-			usage_with_options(git_stash_usage, options);
-		}
-	}
-
+	/* Assume 'stash push' */
 	argv_array_push(&args, "push");
 	argv_array_pushv(&args, argv);
-	return !!push_stash(args.argc, args.argv, prefix);
+	return !!push_stash(args.argc, args.argv, prefix, 1);
 }
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ea56e85e70..3ad23e2502 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -285,6 +285,11 @@ test_expect_success 'stash --no-keep-index' '
 	test bar,bar2 = $(cat file),$(cat file2)
 '
 
+test_expect_success 'dont assume push with non-option args' '
+	test_must_fail git stash -q drop 2>err &&
+	test_i18ngrep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t be assumed due to unexpected token '\''drop'\''" err
+'
+
 test_expect_success 'stash --invalid-option' '
 	echo bar5 >file &&
 	echo bar6 >file2 &&
-- 
gitgitgadget

