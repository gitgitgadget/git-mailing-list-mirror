Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00B5E201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 20:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbdBYU2f (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 15:28:35 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35982 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdBYU2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 15:28:31 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so7833444wmd.3
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 12:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8P/bLmz2z57lwNeUpph/Sp71m/IbD1WuVWZc//XC1VE=;
        b=giZrlU2G5QevO06m2K21oA0UlCBf3qvyAmToALIbVT2NwMQBXNCJMWOBzNIxBQPy9l
         Qd6IYTb0Hzz9EcRZhCrdnHTETFkMnTKQWi5i4i8tmxMl/cRGJGQj3GKI18CsiLhmZub5
         8gGlydSBxiozpHcN8NevjHWPWgBHeo3DLy0iqmbBpv2yCWkVLP8kzNYfVFCnUPVAzAOV
         0o0uTguuD6mO00a54quUQgBdNmhZZ8AhkKpavxEsYmIq7WfAlRdkMatqxAPy9/4qtVob
         Cre5wbZqpceHhhTAyOa9yhVx2RB8zddDnEAGtzEAXOUezqg5Ix7KArYj7RDqiVQXzB+L
         kFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8P/bLmz2z57lwNeUpph/Sp71m/IbD1WuVWZc//XC1VE=;
        b=MXqH8boYenz5Wv2EkrhwCrkCg7wa8+b6ebvQCWutiysQvMutxt/6FzgDiAdpUOYC47
         pzBPq1w9phmaI5Q2pGYcl/AyMLDnGe5tCLZHu5MSz/P31pSN08g+F/HWjJsgrxaqn1kG
         +Lyc6fVLOJxbi+bOArKdDZc54Yl6/M9/2bxmI1zIxbWSeYSYqfPY0iLRDYeP6kxCFKMN
         f/ENOqMFTqQUR7NHF8ohR5ywLIKjJIvMbrts3ypf3Q0oEQMv3KHnoYfYUbu0+Q4HUYmz
         Eoh6YAlKIXgyAlwjDRAvpB7H3vQTFbU4UO2Xqt2S5W05+h9p62Wsydo816Qmch42PC8r
         pFMg==
X-Gm-Message-State: AMke39niUYH+LT4pdf6JEM3SRlx/lwf6ysrNjqYxgs12uYXX/VEwjrOMA2Pgk+Uofyxnpg==
X-Received: by 10.28.154.7 with SMTP id c7mr4473010wme.119.1488054456445;
        Sat, 25 Feb 2017 12:27:36 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id g81sm7595585wmf.16.2017.02.25.12.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Feb 2017 12:27:35 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v7 6/6] stash: allow pathspecs in the no verb form
Date:   Sat, 25 Feb 2017 21:33:06 +0000
Message-Id: <20170225213306.2410-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g275aeb250c.dirty
In-Reply-To: <20170225213306.2410-1-t.gummerer@gmail.com>
References: <20170219110313.24070-1-t.gummerer@gmail.com>
 <20170225213306.2410-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that stash_push is used in the no verb form of stash, allow
specifying the command line for this form as well.  Always use -- to
disambiguate pathspecs from other non-option arguments.

Also make git stash -p an alias for git stash push -p.  This allows
users to use git stash -p <pathspec>.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt | 11 +++++++----
 git-stash.sh                |  3 +++
 t/t3903-stash.sh            | 15 +++++++++++++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 4d8d30f179..70191d06b6 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -54,10 +54,13 @@ push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
 	Save your local modifications to a new 'stash' and roll them
 	back to HEAD (in the working tree and in the index).
 	The <message> part is optional and gives
-	the description along with the stashed state.  For quickly making
-	a snapshot, you can omit _both_ "save" and <message>, but giving
-	only <message> does not trigger this action to prevent a misspelled
-	subcommand from making an unwanted stash.
+	the description along with the stashed state.
++
+For quickly making a snapshot, you can omit "push".  In this mode,
+non-option arguments are not allowed to prevent a misspelled
+subcommand from making an unwanted stash.  The two exceptions to this
+are `stash -p` which acts as alias for `stash push -p` and pathspecs,
+which are allowed after a double hyphen `--` for disambiguation.
 +
 When pathspec is given to 'git stash push', the new stash records the
 modified states only for the files that match the pathspec.  The index
diff --git a/git-stash.sh b/git-stash.sh
index 2d7b30ec5e..28d0624c75 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -655,12 +655,15 @@ apply_to_branch () {
 	}
 }
 
+test "$1" = "-p" && set "push" "$@"
+
 PARSE_CACHE='--not-parsed'
 # The default command is "push" if nothing but options are given
 seen_non_option=
 for opt
 do
 	case "$opt" in
+	--) break ;;
 	-*) ;;
 	*) seen_non_option=t; break ;;
 	esac
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2f5888df0d..f7733b4dd4 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -876,4 +876,19 @@ test_expect_success 'untracked files are left in place when -u is not given' '
 	test_path_is_file untracked
 '
 
+test_expect_success 'stash without verb with pathspec' '
+	>"foo bar" &&
+	>foo &&
+	>bar &&
+	git add foo* &&
+	git stash -- "foo b*" &&
+	test_path_is_missing "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	git stash pop &&
+	test_path_is_file "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_done
-- 
2.11.0.301.g275aeb250c.dirty

