Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAFF11F576
	for <e@80x24.org>; Fri, 26 Jan 2018 09:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeAZJzo (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 04:55:44 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44211 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753134AbeAZJzh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 04:55:37 -0500
Received: by mail-pg0-f66.google.com with SMTP id m20so6974088pgc.11
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 01:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5mYyTwG6MAXlFXAPIO3HzUTBxlTB6+C1W5ZrNvKtXB8=;
        b=r723mqYA3mF8M93Q5LlQDp5NzKaCsGnofFzkO98OKK8UWX6r/eoOFu0wXxIyQ04wtD
         vyEDaYpF5o1Q2vuYV/LvMsizEmWFGiAq5TE9U9gAkEFj4fGXTknB4radf3NDvyJORqyu
         LZk0VW6Ry3NGwOd1Lh3kQlXW1a1qmAlRpkTgaMO8kRn8pjDEjvTvVpyVkxWaZCfl2/Mn
         8P+7Wy3ErXT1yS77/nw2aRr0fZemjrgauDaESZSSx525mQPsxmdOSeaUTw8+nKGQe+gL
         kzDPcbg8Ld2rkCRmdG2fJNG1C9YmYO4ITSg1NbHi9BX7dJONrNWbS5M9AsHvkAsKM1AW
         qsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5mYyTwG6MAXlFXAPIO3HzUTBxlTB6+C1W5ZrNvKtXB8=;
        b=nG37iCvqEpzHSN5pXfiuH6TCNpsRD6/kKOrWQNcB3A2CaNsZIbGfjVXHkDbHa+esLq
         50mE4pxH4APLqoJ7K4d/n+Cp33fUvAud2pBT8aTbXRBpmgUo09z/wIUAKggSryf/QqC/
         grx14hJPHahiffvVUqgsJDcNrnmequYc+8/KTiy5oaZ2cbxHq6DlAUEealFvotRIvI9i
         8pHXbRAipFalccl1FfFo7MUMEXIi1BS7YXiGJskeBlDb6EZnFvRVOfeGdZMkQal/BIXz
         bBvbOQihDiceP4j7WiBfJJpHfZmytzD93LjnboRsh93g18f/Rs/T7awhcMdDjh3iEoQJ
         ToMw==
X-Gm-Message-State: AKwxytcoxnIiprLxmtsJK2Sei0uaHoIVAA7Z4RvDxiMedFjgQaJdQ099
        r66FZ+SjIvlZHU6nnaCDEqyOwQ==
X-Google-Smtp-Source: AH8x226isZxLJNNuHSWFeYF1E3k9bIrNw+Bq3akDRcR1hOctoC5QtK1MJFhO3wgc9U1N84wI0WjmlQ==
X-Received: by 10.99.111.193 with SMTP id k184mr14809554pgc.378.1516960536317;
        Fri, 26 Jan 2018 01:55:36 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id 12sm20620661pfr.147.2018.01.26.01.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2018 01:55:35 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 26 Jan 2018 16:55:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] rebase: add --show-patch
Date:   Fri, 26 Jan 2018 16:55:20 +0700
Message-Id: <20180126095520.919-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180126095520.919-1-pclouds@gmail.com>
References: <20180126095520.919-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is useful to see the full patch while resolving conflicts in a
rebase. The only way to do it now is

    less .git/rebase-*/patch

which could turn out to be a lot longer to type [1] if you are in a
linked worktree, or not at top-dir. On top of that, an ordinary user
should not need to peek into .git directory. The new option is
provided to examine the patch.

[1] A conflict caused by git-rebase--am.sh does show the path to this
    patch file so you could copy/paste. But then after some time and
    lots of commands to resolve the conflict, that path is likely
    scrolled out of your terminal.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-rebase.txt           |  5 +++-
 contrib/completion/git-completion.bash |  4 +--
 git-rebase--am.sh                      |  3 +++
 git-rebase--interactive.sh             |  4 +++
 git-rebase--merge.sh                   |  4 +++
 git-rebase.sh                          |  7 +++++-
 t/t3400-rebase.sh                      | 34 ++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh          |  6 +++++
 8 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8a861c1e0d..4fd571d393 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	[<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
-'git rebase' --continue | --skip | --abort | --quit | --edit-todo
+'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --show-patch
 
 DESCRIPTION
 -----------
@@ -250,6 +250,9 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 --edit-todo::
 	Edit the todo list during an interactive rebase.
 
+--show-patch::
+	Show the current patch in an interactive rebase.
+
 -m::
 --merge::
 	Use merging strategies to rebase.  When the recursive (default) merge
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1e9105f6d5..b70da4990f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1992,11 +1992,11 @@ _git_rebase ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/rebase-merge/interactive ]; then
-		__gitcomp "--continue --skip --abort --quit --edit-todo"
+		__gitcomp "--continue --skip --abort --quit --edit-todo --show-patch"
 		return
 	elif [ -d "$__git_repo_path"/rebase-apply ] || \
 	     [ -d "$__git_repo_path"/rebase-merge ]; then
-		__gitcomp "--continue --skip --abort --quit"
+		__gitcomp "--continue --skip --abort --quit --show-patch"
 		return
 	fi
 	__git_complete_strategy && return
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 14c50782e0..564a4a5830 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -27,6 +27,9 @@ skip)
 	move_to_original_branch
 	return
 	;;
+show-patch)
+	exec git am --show-patch
+	;;
 esac
 
 if test -z "$rebase_root"
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d47bd29593..01cc002efd 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -840,6 +840,10 @@ To continue rebase after editing, run:
 
 	exit
 	;;
+show-patch)
+	cmt="$(cat "$state_dir/stopped-sha")"
+	exec git format-patch --subject-prefix= --stdout "${cmt}^!"
+	;;
 esac
 
 comment_for_reflog start
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 06a4723d4d..5c513a9736 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -137,6 +137,10 @@ skip)
 	finish_rb_merge
 	return
 	;;
+show-patch)
+	cmt="$(cat "$state_dir/current")"
+	exec git format-patch --subject-prefix= --stdout "${cmt}^!"
+	;;
 esac
 
 mkdir -p "$state_dir"
diff --git a/git-rebase.sh b/git-rebase.sh
index fd72a35c65..ce17090520 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -45,6 +45,7 @@ abort!             abort and check out the original branch
 skip!              skip current patch and continue
 edit-todo!         edit the todo list during an interactive rebase
 quit!              abort but keep HEAD where it is
+show-patch!        show the patch file being applied or merged
 "
 . git-sh-setup
 set_reflog_action rebase
@@ -245,7 +246,7 @@ do
 	--verify)
 		ok_to_skip_pre_rebase=
 		;;
-	--continue|--skip|--abort|--quit|--edit-todo)
+	--continue|--skip|--abort|--quit|--edit-todo|--show-patch)
 		test $total_argc -eq 2 || usage
 		action=${1##--}
 		;;
@@ -412,6 +413,10 @@ quit)
 edit-todo)
 	run_specific_rebase
 	;;
+show-patch)
+	run_specific_rebase
+	die "BUG: run_specific_rebase is not supposed to return here"
+	;;
 esac
 
 # Make sure no rebase is in progress
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 8ac58d5ea5..599f0d5606 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -277,4 +277,38 @@ EOF
 	test_cmp From_.msg out
 '
 
+test_expect_success 'rebase--am.sh and --show-patch' '
+	test_create_repo conflict-apply &&
+	(
+		cd conflict-apply &&
+		test_commit init &&
+		echo one >>init.t &&
+		git commit -a -m one &&
+		echo two >>init.t &&
+		git commit -a -m two &&
+		git tag two &&
+		test_must_fail git rebase --onto init HEAD^ &&
+		git rebase --show-patch >actual.patch &&
+		test_cmp .git/rebase-apply/0001 actual.patch
+	)
+'
+
+test_expect_success 'rebase--merge.sh and --show-patch' '
+	test_create_repo conflict-merge &&
+	(
+		cd conflict-merge &&
+		test_commit init &&
+		echo one >>init.t &&
+		git commit -a -m one &&
+		echo two >>init.t &&
+		git commit -a -m two &&
+		git tag two &&
+		test_must_fail git rebase --merge --onto init HEAD^ &&
+		git rebase --show-patch >actual.patch &&
+		cmt=$(cat .git/rebase-merge/current) &&
+		git format-patch --stdout --subject-prefix= ${cmt}^! >expected.patch &&
+		test_cmp expected.patch actual.patch
+	)
+'
+
 test_done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 481a350090..40f70a0333 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -225,6 +225,12 @@ test_expect_success 'stop on conflicting pick' '
 	test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
 '
 
+test_expect_success 'show conflicted patch' '
+	git rebase --show-patch >actual.patch &&
+	git format-patch --subject-prefix= --stdout new-branch1^! >expected.patch &&
+	test_cmp expected.patch actual.patch
+'
+
 test_expect_success 'abort' '
 	git rebase --abort &&
 	test $(git rev-parse new-branch1) = $(git rev-parse HEAD) &&
-- 
2.16.1.205.g271f633410

