Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76C731F516
	for <e@80x24.org>; Thu, 28 Jun 2018 07:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965095AbeF1Hsg (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 03:48:36 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43984 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964960AbeF1Hsd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 03:48:33 -0400
Received: by mail-pl0-f67.google.com with SMTP id c41-v6so2356291plj.10
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 00:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F4I0oZ5mhe6WoiTPfftIvWXVRGQMVn7y8gxZ6gv4lso=;
        b=X/v9hq1WzzxTTCA75HAJV0yDDG0Tr8h0f2Ma61XR0GcqS20tA6KB1HT50pt7+DbKMj
         2PDDD97gynXPYvHb22TKwl/PD7xSrwdYblSZ+VkWdafzDnHXQ4J6BeYAW14im4R9QVsr
         FsxsC1yiCLI4oSA+y9PH8jg1VdjGG3H4CGVa/NZDvLkOtsJL7++8Xko3EVeNTKZzTn32
         gbgguVSFT+S1ASb1uqqehw2K7NjFYavTsdZZaWdY4pkUOxUWrnWnI0X2FZ0S85u5QAPJ
         JXx50acIzo18Bq7iRsKLD+f8AYFa0kgJMPeBvB4GpEtLwquLcbkCofBNBH2bVFMUvV7o
         +wDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F4I0oZ5mhe6WoiTPfftIvWXVRGQMVn7y8gxZ6gv4lso=;
        b=ODhxlmOnS2DMQJsZHkPiriIbPp6x6VjX4fvnslTfOMGuRCYP43MAeuMibCn1+c5HTz
         KjbHg/n7sda2C77+TbJ44HUspzLo8X1IuRWDBinam3sPSYjD5SveMqcBssLBXSYjmG+V
         aiyUZSPFoHMFSRapjBsf+5G4Sh5i8RidieDoPeja4Uo5BnuktOScBlXPN+zId9vPH07g
         98t6oLvGM3anwMAc+DhsjPGIXkFpcg+oyUw6zfStta1WDOnOyU8WEe/loAp7i49ZbMCR
         alO+0rk0Q9FWI3fc/3yclJj/eSHTDuwPZ54Nj1S+hf+8mFDm2U8CgcXt5UwbJNPFl1X3
         RLFQ==
X-Gm-Message-State: APt69E2UVEwY9R0XPkSji3czGPNP0KyahjpQupQb2c2Bhmhmjl95Er1I
        GGAGYQLBCtBznPSX6ukyPRjB4dk7OQg=
X-Google-Smtp-Source: ADUXVKJkQ0TQ52hcTW9SHPQBNuU3OMrJ3YIPetU7+6x8ovPAuPVabaq6nPFVaGjYIbbWI+lQ033pNQ==
X-Received: by 2002:a17:902:b58f:: with SMTP id a15-v6mr9536604pls.76.1530172112792;
        Thu, 28 Jun 2018 00:48:32 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.160])
        by smtp.gmail.com with ESMTPSA id x90-v6sm23416168pfk.151.2018.06.28.00.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 00:48:32 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 3/5] rebase: refactor common shell functions into their own file
Date:   Thu, 28 Jun 2018 13:31:53 +0545
Message-Id: <20180628074655.5756-4-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628074655.5756-1-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function present in `git-legacy-rebase.sh` are used by backends
so, this refactor tries to extract the functions out so that, the
`git-legacy-rebase.sh` can be retired easily as the
`git-rebase--common.sh` will provide the functions for now.

The motivation behind this is to call the backend functions
*directly* from C, bypassing `git-rebase.sh`. Therefore those functions
need to live in a separate file: we need to be able to call
`.git-rebase--common` in that script snippet so that those functions
are defined.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 .gitignore            |  1 +
 Makefile              |  1 +
 git-legacy-rebase.sh  | 62 +------------------------------------------
 git-rebase--common.sh | 61 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 61 deletions(-)
 create mode 100644 git-rebase--common.sh

diff --git a/.gitignore b/.gitignore
index ec2395901..824141cba 100644
--- a/.gitignore
+++ b/.gitignore
@@ -117,6 +117,7 @@
 /git-read-tree
 /git-rebase
 /git-rebase--am
+/git-rebase--common
 /git-rebase--helper
 /git-rebase--interactive
 /git-rebase--merge
diff --git a/Makefile b/Makefile
index e88fe2e5f..163e52ad1 100644
--- a/Makefile
+++ b/Makefile
@@ -619,6 +619,7 @@ SCRIPT_SH += git-web--browse.sh
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--am
+SCRIPT_LIB += git-rebase--common
 SCRIPT_LIB += git-rebase--interactive
 SCRIPT_LIB += git-rebase--preserve-merges
 SCRIPT_LIB += git-rebase--merge
diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index 19bdebb48..240aac507 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -102,6 +102,7 @@ case "$(git config --bool commit.gpgsign)" in
 true)	gpg_sign_opt=-S ;;
 *)	gpg_sign_opt= ;;
 esac
+. git-rebase--common
 
 read_basic_state () {
 	test -f "$state_dir/head-name" &&
@@ -132,67 +133,6 @@ read_basic_state () {
 	}
 }
 
-write_basic_state () {
-	echo "$head_name" > "$state_dir"/head-name &&
-	echo "$onto" > "$state_dir"/onto &&
-	echo "$orig_head" > "$state_dir"/orig-head &&
-	echo "$GIT_QUIET" > "$state_dir"/quiet &&
-	test t = "$verbose" && : > "$state_dir"/verbose
-	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
-	test -n "$strategy_opts" && echo "$strategy_opts" > \
-		"$state_dir"/strategy_opts
-	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
-		"$state_dir"/allow_rerere_autoupdate
-	test -n "$gpg_sign_opt" && echo "$gpg_sign_opt" > "$state_dir"/gpg_sign_opt
-	test -n "$signoff" && echo "$signoff" >"$state_dir"/signoff
-}
-
-output () {
-	case "$verbose" in
-	'')
-		output=$("$@" 2>&1 )
-		status=$?
-		test $status != 0 && printf "%s\n" "$output"
-		return $status
-		;;
-	*)
-		"$@"
-		;;
-	esac
-}
-
-move_to_original_branch () {
-	case "$head_name" in
-	refs/*)
-		message="rebase finished: $head_name onto $onto"
-		git update-ref -m "$message" \
-			$head_name $(git rev-parse HEAD) $orig_head &&
-		git symbolic-ref \
-			-m "rebase finished: returning to $head_name" \
-			HEAD $head_name ||
-		die "$(eval_gettext "Could not move back to \$head_name")"
-		;;
-	esac
-}
-
-apply_autostash () {
-	if test -f "$state_dir/autostash"
-	then
-		stash_sha1=$(cat "$state_dir/autostash")
-		if git stash apply $stash_sha1 >/dev/null 2>&1
-		then
-			echo "$(gettext 'Applied autostash.')" >&2
-		else
-			git stash store -m "autostash" -q $stash_sha1 ||
-			die "$(eval_gettext "Cannot store \$stash_sha1")"
-			gettext 'Applying autostash resulted in conflicts.
-Your changes are safe in the stash.
-You can run "git stash pop" or "git stash drop" at any time.
-' >&2
-		fi
-	fi
-}
-
 finish_rebase () {
 	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 	apply_autostash &&
diff --git a/git-rebase--common.sh b/git-rebase--common.sh
new file mode 100644
index 000000000..5ba060392
--- /dev/null
+++ b/git-rebase--common.sh
@@ -0,0 +1,61 @@
+
+write_basic_state () {
+	echo "$head_name" > "$state_dir"/head-name &&
+	echo "$onto" > "$state_dir"/onto &&
+	echo "$orig_head" > "$state_dir"/orig-head &&
+	echo "$GIT_QUIET" > "$state_dir"/quiet &&
+	test t = "$verbose" && : > "$state_dir"/verbose
+	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
+	test -n "$strategy_opts" && echo "$strategy_opts" > \
+		"$state_dir"/strategy_opts
+	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
+		"$state_dir"/allow_rerere_autoupdate
+	test -n "$gpg_sign_opt" && echo "$gpg_sign_opt" > "$state_dir"/gpg_sign_opt
+	test -n "$signoff" && echo "$signoff" >"$state_dir"/signoff
+}
+
+apply_autostash () {
+	if test -f "$state_dir/autostash"
+	then
+		stash_sha1=$(cat "$state_dir/autostash")
+		if git stash apply $stash_sha1 >/dev/null 2>&1
+		then
+			echo "$(gettext 'Applied autostash.')" >&2
+		else
+			git stash store -m "autostash" -q $stash_sha1 ||
+			die "$(eval_gettext "Cannot store \$stash_sha1")"
+			gettext 'Applying autostash resulted in conflicts.
+Your changes are safe in the stash.
+You can run "git stash pop" or "git stash drop" at any time.
+' >&2
+		fi
+	fi
+}
+
+move_to_original_branch () {
+	case "$head_name" in
+	refs/*)
+		message="rebase finished: $head_name onto $onto"
+		git update-ref -m "$message" \
+			$head_name $(git rev-parse HEAD) $orig_head &&
+		git symbolic-ref \
+			-m "rebase finished: returning to $head_name" \
+			HEAD $head_name ||
+		die "$(eval_gettext "Could not move back to \$head_name")"
+		;;
+	esac
+}
+
+output () {
+	case "$verbose" in
+	'')
+		output=$("$@" 2>&1 )
+		status=$?
+		test $status != 0 && printf "%s\n" "$output"
+		return $status
+		;;
+	*)
+		"$@"
+		;;
+	esac
+}
-- 
2.18.0

