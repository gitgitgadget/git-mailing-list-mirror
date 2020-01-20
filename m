Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4EBC2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B6C217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4/ewVWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgATOjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:39:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52942 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgATOjF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:39:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so14753774wmc.2
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MgqUhtYt3rl1yMH3xNNgjtpaX77opSuQtQCandelRJo=;
        b=T4/ewVWTZyJkLBLEY+CfAgZfGJ6pft8Ofs6ww9cpO7M5pC7+QlfYAPzSYcuueGokxN
         Vmds+nNGXpNV+Syoio9iaagdLBIw5nHRfy0GK5bewi1CVxSWt1czXPhaiZz8uga+46Jl
         bbH5RCZREIeLSPS0bY/Ad2eeFz5qJryWd1hVK3mV2hO8s42xfSRFtNrB4jsnhfl88vqW
         nidOeUU2EVP+0lytjMKAJmhKFGaShHs5LIu/v93HDAaDTKHBOo33nmnDZ3chByMsLKFR
         +LYnn5mMIfiOst8bLd3LHJxUSbnVuK6pMxWNRyQIOd6oL1gi3y1uPdEl/BHREI2r3s36
         qQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MgqUhtYt3rl1yMH3xNNgjtpaX77opSuQtQCandelRJo=;
        b=a2+YNRN6PUJdD3P872gLRvUH9kgNnMcfa4Bvl6JDuG9AP4gqorg3C8W1y1KU3id5cL
         IQz0tkFJ0KZVXTYKalUSyIkDeJnZPcqxXesw6lQ2UXfCYUf3uTumOXR/l7jAcp/Kkp7O
         MiV6dh1PdiYEk4m9hN9bxs+7yQqn0Z4FEQyxpFthtHUcO+hDiNwvpOpSeTg3EFi5ogmh
         GrvRndCk8QAKXf97tJE9qw7x5y8yRsJdnr6pKcnpSIHjjpBGnOuTKiQ5JlsgMQla0AUP
         +E4FaXnJQRaLmWu9Pp1COODh9+N1HrChmj2W6g5ivTyyHyiSjDxsjTmYX24qz7VSDOBY
         WBiQ==
X-Gm-Message-State: APjAAAUAuvK0H7WcE0YoNz6lAj3wJBuIPEtU4CqvHbq8xGe2TvjIUMcK
        SsYz1ACDUi2KImSjESvRz39xFc+mwPo=
X-Google-Smtp-Source: APXvYqxbAnWiPbZKy1EheAhTW4cxqDp1kLZLtpH7A0kJbyTKKAAt0u+EfbxeHKMZN1Gxd8H8XMy+lA==
X-Received: by 2002:a05:600c:2c06:: with SMTP id q6mr20135302wmg.154.1579531143073;
        Mon, 20 Jan 2020 06:39:03 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:39:02 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 28/29] bisect--helper: reimplement `bisect_visualize()`shell function in C
Date:   Mon, 20 Jan 2020 15:37:59 +0100
Message-Id: <20200120143800.900-29-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_visualize()` shell function
in C and also add `--bisect-visualize` subcommand to
`git bisect--helper` to call it from git-bisect.sh.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 48 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 25 +--------------------
 2 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7bc28d728e..4b41cc7749 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -30,6 +30,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
 	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
+	N_("git bisect--helper --bisect-visualize"),
 	NULL
 };
 
@@ -1053,6 +1054,44 @@ static int bisect_skip(struct bisect_terms *terms, const char **argv, int argc)
 	return res;
 }
 
+static int bisect_visualize(struct bisect_terms *terms, const char **argv, int argc)
+{
+	struct argv_array args = ARGV_ARRAY_INIT;
+	int flags = RUN_COMMAND_NO_STDIN, res = 0;
+	struct strbuf sb;
+
+	if (!bisect_next_check(terms, NULL))
+		return -1;
+
+	if (!argc) {
+		if ((getenv("DISPLAY") || getenv("SESSIONNAME") || getenv("MSYSTEM") ||
+		     getenv("SECURITYSESSIONID")) && exists_in_PATH("gitk"))
+			argv_array_push(&args, "gitk");
+		else {
+			argv_array_pushl(&args, "log", NULL);
+			flags |= RUN_GIT_CMD;
+		}
+	} else {
+		if (argv[0][0] == '-') {
+			argv_array_pushl(&args, "log", NULL);
+			flags |= RUN_GIT_CMD;
+		} else if (strcmp(argv[0], "tig") && !starts_with(argv[0], "git"))
+			flags |= RUN_GIT_CMD;
+
+		argv_array_pushv(&args, argv);
+	}
+
+	argv_array_pushl(&args, "--bisect",  NULL);
+
+	strbuf_read_file(&sb, git_path_bisect_names(), 0);
+	argv_array_split(&args, sb.buf);
+	strbuf_release(&sb);
+
+	res = run_command_v_opt(args.argv, flags);
+	argv_array_clear(&args);
+	return res;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -1064,7 +1103,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_STATE,
 		BISECT_LOG,
 		BISECT_REPLAY,
-		BISECT_SKIP
+		BISECT_SKIP,
+		BISECT_VISUALIZE
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -1086,6 +1126,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
 		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
 			 N_("skip some commits for checkout"), BISECT_SKIP),
+		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
+			 N_("visualize the bisection"), BISECT_VISUALIZE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -1150,6 +1192,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_skip(&terms, argv, argc);
 		break;
+	case BISECT_VISUALIZE:
+		get_terms(&terms);
+		res = bisect_visualize(&terms, argv, argc);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index edfd3f8b3d..084766636d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -39,29 +39,6 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 
-bisect_visualize() {
-	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
-
-	if test $# = 0
-	then
-		if test -n "${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set}${SECURITYSESSIONID+set}" &&
-			type gitk >/dev/null 2>&1
-		then
-			set gitk
-		else
-			set git log
-		fi
-	else
-		case "$1" in
-		git*|tig) ;;
-		-*)	set git log "$@" ;;
-		*)	set git "$@" ;;
-		esac
-	fi
-
-	eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
-}
-
 bisect_run () {
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
@@ -153,7 +130,7 @@ case "$#" in
 		get_terms
 		git bisect--helper --bisect-next "$@" || exit ;;
 	visualize|view)
-		bisect_visualize "$@" ;;
+		git bisect--helper --bisect-visualize "$@" ;;
 	reset)
 		git bisect--helper --bisect-reset "$@" ;;
 	replay)
-- 
2.21.1 (Apple Git-122.3)

