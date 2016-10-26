Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2566820193
	for <e@80x24.org>; Wed, 26 Oct 2016 09:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754031AbcJZJrP (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 05:47:15 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32891 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbcJZJrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 05:47:12 -0400
Received: by mail-pf0-f175.google.com with SMTP id 197so13187078pfu.0
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ERxDhqp9cn0Q5DZRiqQhTzZ6cX351YKvMwv6V24cPI0=;
        b=gGzKNiH9zDd0D7nNqyAWPnhsIJ0AW+8OBnkQv4lR5KWcc06ILuMxVX66hFUcXC2Knc
         EP1hglrxRPZGZ1rgYLJ9mmKTdljMxwOe/hYKGHPMZw3g6wzQYDLG/rmZInKgiezRoeNp
         tHD6F1XLC/eVuGFA5wy0v9mHo2sclXweBPF5Tsbf79wEIbt2PhyI+En18kv0ISBicITi
         +pZSQqJCjbs5KIT6mENLbI4+Ucxpp0oQX/WKm7AaScoKvEU5F4EIRW7w+/Rg/0gLKQMO
         sDFr6Z6rTSlSb7W60VpHegqQRxrKJEDU6hZlBVzmHQ0zaw0t9Qi9VWa8MW8h1suNiqPV
         HNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ERxDhqp9cn0Q5DZRiqQhTzZ6cX351YKvMwv6V24cPI0=;
        b=HAIfDI9jS/5DqvVouFJmTds9M1XU+8RLorBU4cKW7LJeOWVA5PdNaTK12+v3GQrBxu
         nSfHmeHe+TxURdCo53tAe/RsxoYvZygGiGWZHo98sgciGUYwG/OYuK2o3nZykV6FhC15
         B7sCkvtXbSMe4osDErdMKdq49+a2EtBCcKzRN5JKsMvnmIZvzhao8fJeuEkh5dzIbqMY
         clpXrnqxHPPAMsCAddTaKkqca4mr/xzl1U6G2My+7YKQNuKxGPE+5eB8C8VdCmRAu1G9
         /uCOTMWc6pzvD1kzH2x4webQkeZPU/gY/tdxAfJoDxKUBMf8vWcqD+Xbe/cDQ8v6CG10
         oHJw==
X-Gm-Message-State: ABUngvc8rAcwEzPzOCMDec+Sn3Wm2WzgV0qELw0YEMB7dkK/1lxJ1PEAzqScuUDe7krGhQ==
X-Received: by 10.98.10.6 with SMTP id s6mr2617622pfi.8.1477475231886;
        Wed, 26 Oct 2016 02:47:11 -0700 (PDT)
Received: from ash ([115.73.162.90])
        by smtp.gmail.com with ESMTPSA id f75sm2822213pfj.76.2016.10.26.02.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Oct 2016 02:47:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 26 Oct 2016 16:47:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] rebase: add --forget to cleanup rebase, leave HEAD untouched
Date:   Wed, 26 Oct 2016 16:46:58 +0700
Message-Id: <20161026094658.20704-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are occasions when you decide to abort an in-progress rebase and
move on to do something else but you forget to do "git rebase --abort"
first. Or the rebase has been in progress for so long you forgot about
it. By the time you realize that (e.g. by starting another rebase)
it's already too late to retrace your steps. The solution is normally

    rm -r .git/<some rebase dir>

and continue with your life. But there could be two different
directories for <some rebase dir> (and it obviously requires some
knowledge of how rebase works), and the ".git" part could be much
longer if you are not at top-dir, or in a linked worktree. And
"rm -r" is very dangerous to do in .git, a mistake in there could
destroy object database or other important data.

Provide "git rebase --forget" for this exact use case.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-rebase.txt           |  5 ++++-
 contrib/completion/git-completion.bash |  4 ++--
 git-rebase.sh                          |  6 +++++-
 t/t3407-rebase-abort.sh                | 24 ++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index de222c8..5a58fb3 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	[<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
-'git rebase' --continue | --skip | --abort | --edit-todo
+'git rebase' --continue | --skip | --abort | --forget | --edit-todo
 
 DESCRIPTION
 -----------
@@ -252,6 +252,9 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	will be reset to where it was when the rebase operation was
 	started.
 
+--forget::
+	Abort the rebase operation but leave HEAD where it is.
+
 --keep-empty::
 	Keep the commits that do not change anything from its
 	parents in the result.
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9c8f738..bb64fb4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1733,10 +1733,10 @@ _git_rebase ()
 {
 	local dir="$(__gitdir)"
 	if [ -f "$dir"/rebase-merge/interactive ]; then
-		__gitcomp "--continue --skip --abort --edit-todo"
+		__gitcomp "--continue --skip --abort --forget --edit-todo"
 		return
 	elif [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
-		__gitcomp "--continue --skip --abort"
+		__gitcomp "--continue --skip --abort --forget"
 		return
 	fi
 	__git_complete_strategy && return
diff --git a/git-rebase.sh b/git-rebase.sh
index 04f6e44..de712b7 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -43,6 +43,7 @@ continue!          continue
 abort!             abort and check out the original branch
 skip!              skip current patch and continue
 edit-todo!         edit the todo list during an interactive rebase
+forget!            abort but keep HEAD where it is
 "
 . git-sh-setup
 set_reflog_action rebase
@@ -241,7 +242,7 @@ do
 	--verify)
 		ok_to_skip_pre_rebase=
 		;;
-	--continue|--skip|--abort|--edit-todo)
+	--continue|--skip|--abort|--forget|--edit-todo)
 		test $total_argc -eq 2 || usage
 		action=${1##--}
 		;;
@@ -399,6 +400,9 @@ abort)
 	finish_rebase
 	exit
 	;;
+forget)
+	exec rm -rf "$state_dir"
+	;;
 edit-todo)
 	run_specific_rebase
 	;;
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index a6a6c40..6bc5e71 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -99,4 +99,28 @@ testrebase() {
 testrebase "" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 
+test_expect_success 'rebase --forget' '
+	cd "$work_dir" &&
+	# Clean up the state from the previous one
+	git reset --hard pre-rebase &&
+	test_must_fail git rebase master &&
+	test_path_is_dir .git/rebase-apply &&
+	head_before=$(git rev-parse HEAD) &&
+	git rebase --forget &&
+	test $(git rev-parse HEAD) = $head_before &&
+	test ! -d .git/rebase-apply
+'
+
+test_expect_success 'rebase --merge --forget' '
+	cd "$work_dir" &&
+	# Clean up the state from the previous one
+	git reset --hard pre-rebase &&
+	test_must_fail git rebase --merge master &&
+	test_path_is_dir .git/rebase-merge &&
+	head_before=$(git rev-parse HEAD) &&
+	git rebase --forget &&
+	test $(git rev-parse HEAD) = $head_before &&
+	test ! -d .git/rebase-merge
+'
+
 test_done
-- 
2.8.2.524.g6ff3d78

