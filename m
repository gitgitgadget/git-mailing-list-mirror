Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CC1A1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 18:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932372AbeGHSBi (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 14:01:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44771 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932184AbeGHSBh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 14:01:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so807245pgp.11
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 11:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ysJk6jih7DI4gXLyv8VUNW7+kRznCjzCtHEqbo7wPDk=;
        b=eNo3LkXU58sD7UZOPZkL3l2uLYl3dw5L1HICCk7+eTH1xBdKkw/fh/jh4HTkNK0NuW
         BqkGw6P3OqG1skFgIupjEJNnkx9f9AKsZSSj8RHYgvGW7CZMmHphF1ajxPv9YuC1Srzp
         bdtGUaxHJmC9hkaMPvwFtZvyiKjyUcNA6rZIZTv9IedC/geUaelCwAvU4ZvMn0RtRByT
         xmVCYZQjzXUQly6J9QUs9hV8b2qwaExZLtGzFlZAwQzxXC8P4J8fEJsMUM+AX5hkNhvL
         zcEvEUsOnMh7IhNFv9jSqZK9EfwhYEHKVPtUh+Cq3i7fUZk2hlz6fggRAD7nNpJgbGGi
         M0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ysJk6jih7DI4gXLyv8VUNW7+kRznCjzCtHEqbo7wPDk=;
        b=UOS4oI+RLTQZ4DNObTFAGOPh4CoBXW0g2GgeiVeHM1w5ASWAn09lHnsFF2p+htdxpT
         eMDZRHTFs82OsmwqBqdeLZQ+WueGNfCIHLHTt7HqwjmSoago2SfduN6IQvtgU9VO9xKP
         56P0ItsngpM4MYPNN5ogbbPrRkJL2gRb3Ft1N9XcUanBbC1TmxJk4g+rDx+Ms86ZUPNJ
         t0jO0ODVyhGDDFJseoKYJ2bT/RchAVceQONtb1uDIcUlqjVS5ZVwktx0/nDB0XChBNW9
         rvuaW9n7CxTFAONiRnsNdA6EjVToO4hL6SJIzPd3qFLpck7P9dgs4s6wvLiFvVRZ88Zx
         iT5w==
X-Gm-Message-State: APt69E0C8zrk+GbT3ICCmTx2ZbVhROcgrJFFR7T7AC7kq3XjXQTUJ90K
        8s+xvMtI0rx/BDzQYrLVzWe6cRrp
X-Google-Smtp-Source: AAOMgpfg8gKe3qedlQVLstylKW497nv9Fy8QbVRfV3Bw5RIgfu+ZitXBTdhM3rp+id2bF8CltAVehQ==
X-Received: by 2002:a62:e00a:: with SMTP id f10-v6mr18394478pfh.208.1531072895906;
        Sun, 08 Jul 2018 11:01:35 -0700 (PDT)
Received: from localhost.localdomain ([27.34.68.75])
        by smtp.gmail.com with ESMTPSA id u13-v6sm18019149pgr.36.2018.07.08.11.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 11:01:35 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     Pratik Karki <predatoramigo@gmail.com>, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com, gitster@pobox.com
Subject: [PATCH v4 2/4] rebase: refactor common shell functions into their own file
Date:   Sun,  8 Jul 2018 23:46:02 +0545
Message-Id: <20180708180104.17921-3-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708180104.17921-1-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180708180104.17921-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The functions present in `git-legacy-rebase.sh` are used by the rebase
backends as they are implemented as shell script functions in the
`git-rebase--<backend>` files.

To make the `builtin/rebase.c` work, we have to provide support via
a Unix shell script snippet that uses these functions and so, we
want to use the rebase backends *directly* from the builtin rebase
without going through `git-legacy-rebase.sh`.

This commit extracts the functions to a separate file,
`git-rebase--common`, that will be read by `git-legacy-rebase.sh` and
by the shell script snippets which will be used extensively in the
following commits.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 .gitignore            |  1 +
 Makefile              |  1 +
 git-legacy-rebase.sh  | 69 ++-----------------------------------------
 git-rebase--common.sh | 68 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 67 deletions(-)
 create mode 100644 git-rebase--common.sh

diff --git a/.gitignore b/.gitignore
index ec23959014..824141cba1 100644
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
index e88fe2e5fb..163e52ad1a 100644
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
index 19bdebb480..fbaf16420d 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -57,12 +57,7 @@ cd_to_toplevel
 LF='
 '
 ok_to_skip_pre_rebase=
-resolvemsg="
-$(gettext 'Resolve all conflicts manually, mark them as resolved with
-"git add/rm <conflicted_files>", then run "git rebase --continue".
-You can instead skip this commit: run "git rebase --skip".
-To abort and get back to the state before "git rebase", run "git rebase --abort".')
-"
+
 squash_onto=
 unset onto
 unset restrict_revision
@@ -102,6 +97,7 @@ case "$(git config --bool commit.gpgsign)" in
 true)	gpg_sign_opt=-S ;;
 *)	gpg_sign_opt= ;;
 esac
+. git-rebase--common
 
 read_basic_state () {
 	test -f "$state_dir/head-name" &&
@@ -132,67 +128,6 @@ read_basic_state () {
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
index 0000000000..7e39d22871
--- /dev/null
+++ b/git-rebase--common.sh
@@ -0,0 +1,68 @@
+
+resolvemsg="
+$(gettext 'Resolve all conflicts manually, mark them as resolved with
+"git add/rm <conflicted_files>", then run "git rebase --continue".
+You can instead skip this commit: run "git rebase --skip".
+To abort and get back to the state before "git rebase", run "git rebase --abort".')
+"
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

