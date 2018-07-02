Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84D821F516
	for <e@80x24.org>; Mon,  2 Jul 2018 09:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933282AbeGBJQm (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 05:16:42 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43340 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933108AbeGBJQj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 05:16:39 -0400
Received: by mail-pg0-f65.google.com with SMTP id v13-v6so1236799pgr.10
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 02:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Inoxp+kBKDX8Q0SDF/JNcFlBvFBEnkXgAm1sxiERI9g=;
        b=FEke6JlfwC84V1coZZ1ft1zuwf+TPF08yH93J/FZTa5MEhJseNzB93iTUW6H1//+A6
         IBlYJ+4xcsZdkdw4q0hukQerukU5vgf3FMoLUwJVvmSMIJ98uVeXZ7Le76EOA4GNkTbS
         Opjx1gQ/mx+bie2syjnzP5EwPLdH0X2XSwOStCWknjRQ4/IXUCPgsbl4ysMVQb59mixg
         2ki1wOp6zUEaNtjaDjYbgazgLB8mfSEFDiyyuEbGqgvtmwnzkc1gx8+cdhOfcAnSHuBw
         K9DDINduy0+hGSVnowmyOb73gkbUJf+3ReGVzxNVl8vSOAwh6H0wGoT6MmQtGzHPBHGn
         vSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Inoxp+kBKDX8Q0SDF/JNcFlBvFBEnkXgAm1sxiERI9g=;
        b=S78a9x2tXlXcG4XLDj+QVyHc6VE5xicNYm0Z2xj1+6jI2AwudH7XTy4xtk5t2x7DfY
         GUINywoLZnlxVyDZqdkSKh3nVkLMh98BEtZeyLLoi2JsIFgYzmoU4N+FLM7Uv76b/ocS
         KP9O3l743zAmr4KrfX4IllgVP2AFCA8vknD0gH7vF0leLVqqvsHqF8JZ7H8syRCDsivg
         qct/Y7FHeDePvolbJpwBwmpRyKvVYuyOLgwHB0Sskya96e03fY81Qgh1fDNkQLhri6H8
         siT2HXeSDKM4tB6N7uM3omY64Pl8yWhDRqJ/OKAAPCxNXRqQqet1ZoqPCRlnE2IiR/D2
         tHdQ==
X-Gm-Message-State: APt69E2aavOEvCZWofx/rP6vGwPN+8hyDi5t/IM1hmxfYHpgPPTzk5PI
        7TxHo+W3TEeTAhycAhAuLqNProNf4Yw=
X-Google-Smtp-Source: ADUXVKI/Sq6QMyKFYjlRZfgIK6FcRzdySXSgc8ppKFXQwoiERl1u24vjUbfDJsLd6KU+NmxaT91PKA==
X-Received: by 2002:a63:4b1f:: with SMTP id y31-v6mr21383813pga.14.1530522999088;
        Mon, 02 Jul 2018 02:16:39 -0700 (PDT)
Received: from localhost.localdomain ([27.34.68.63])
        by smtp.gmail.com with ESMTPSA id y2-v6sm35961795pfk.82.2018.07.02.02.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 02:16:38 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH v2 2/4] rebase: refactor common shell functions into their own file
Date:   Mon,  2 Jul 2018 15:00:07 +0545
Message-Id: <20180702091509.15950-3-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702091509.15950-1-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180702091509.15950-1-predatoramigo@gmail.com>
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
`. git-rebase--common` in that script snippet so that those functions
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
index 000000000..fdce7bba5
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
-- 
2.18.0

