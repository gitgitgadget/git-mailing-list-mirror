Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25EAF201A9
	for <e@80x24.org>; Sun, 19 Feb 2017 11:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbdBSLMO (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 06:12:14 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35829 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751627AbdBSLMN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 06:12:13 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so9574761wmu.2
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 03:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6FWIVKoxgzazOAVDP9DKRPupWyRNtLUgJ+nNxZrOKdU=;
        b=X2RPp2/XGp9ZUTRQk4e1c/pEy2VjfI4QEPzl/MkUTzKYTWHK8IOlhrj1/jKxVWblpc
         HzM3LxJxL1DQ6+4dGV7sSkNlD0ZkDIKPT+qCpo4eNyZuc0t4qyh1f3tmFslCu+OaMsV9
         yuqcJ2StgEaF2DbL00wLIa5gYNJOxEWh0wgEV3wQqKEhXE2GVczJ+luXlN3cosZ2GabL
         YQDCVJKkqdZL+060qkACph4SjiAbxIv54tiOsFB83qUu0WOzwfdCRX/eQg+Z9SJ2r/Pe
         qGK0Oc4QmP2IU42myhmkOCv9JpSHj0O32y+KBIjKI9SPbgP7tvuNqog1IXRDGCN4tmgZ
         SIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6FWIVKoxgzazOAVDP9DKRPupWyRNtLUgJ+nNxZrOKdU=;
        b=jKrgbk2vTMNM74izpr09rk/GdxKHalosy36vWkTcMHYEBSyOTHx+Vb53eCNURhaxlQ
         joHfRKQ/IZWx7GHDGOLBZ5tUtVS/0tGjk2YxT2YlDAJUwYEwFiIwMR3EZPqUVKbpJ1Si
         TgxZnbMoI841ZwKQ3VdLB9dmjovvFt6GZ4z3SrmkPuSBdQOm02em5SHmEEBgAbHe8oFl
         kji6VV05PMJ+6XX51zIQiDWHgnxPl4oyEdqFb5lqlJWx1yPvo+ag/KIMNkPpesnm/kWz
         1AWE4ENV4fwNmEu8T3Jyt8qgAyhT/kdgKElemDS6cLnuvWy8x7bCgJG6/KQgNcevCmPv
         jW9Q==
X-Gm-Message-State: AMke39lxZ7sLsRlVqKubyQmngudFf+hXkBqM+GvptFrgsOXvbe1tqsoXN2om9hUCCN5G5Q==
X-Received: by 10.28.69.28 with SMTP id s28mr12471728wma.40.1487502194632;
        Sun, 19 Feb 2017 03:03:14 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 17sm20405402wru.16.2017.02.19.03.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Feb 2017 03:03:14 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 6/6] stash: allow pathspecs in the no verb form
Date:   Sun, 19 Feb 2017 11:03:13 +0000
Message-Id: <20170219110313.24070-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.rc2.399.g0ca89a282
In-Reply-To: <20170219110313.24070-1-t.gummerer@gmail.com>
References: <20170217224141.19183-1-t.gummerer@gmail.com>
 <20170219110313.24070-1-t.gummerer@gmail.com>
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
index 3f7fa88ddc..369bfae33d 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -53,10 +53,13 @@ push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  The <message> part is optional and gives
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
index 1e55cd5fdd..18aba1346f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -666,12 +666,15 @@ apply_to_branch () {
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
index 7f90a247b4..c0ae41e724 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -872,4 +872,19 @@ test_expect_success 'untracked files are left in place when -u is not given' '
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
2.12.0.rc2.399.g0ca89a282

