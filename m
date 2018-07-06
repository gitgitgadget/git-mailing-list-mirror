Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965621F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 12:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932746AbeGFMI4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 08:08:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39779 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeGFMIy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 08:08:54 -0400
Received: by mail-pf0-f195.google.com with SMTP id s21-v6so8317132pfm.6
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rt6UYMZ3cK9M2mYpE1h7IwrVI1jhHCFymqykIzjsYBg=;
        b=RNAUbfgp+ZvZ3jENQrrYpZptcKcLFgWBsC67exykaRcjS75THA6kcNsAO9x2CxuYa8
         a8U860inHkT/3NeLP6HEO34dL4XTOY+1qLRTSl4ciW1j8DCxRM4Y7jfSBwnQeoTLTI5V
         QIcvF3HD07lxZqO0U0/Am1Q4Udug8U3MP6dd75AJkjBnH5LAzeCZG1hAbxiNk011ujq5
         Zd/+Q1IIpkAUO7XoqyLJuMCnflucmFodos6JDL14eRgJJQI+CmZNbvYUMNO0nXt8/jyV
         p40HzHMIbPEAQ6zPUbfTApfGdFX/0/r8s0U+PkF5uYPAqZEmj6R43jpUDk6jUOmas7mj
         fE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rt6UYMZ3cK9M2mYpE1h7IwrVI1jhHCFymqykIzjsYBg=;
        b=NcQitJrbV3Q9shO8pY3PAJO9AruqV2hgpRkGU6Z1AxUrRFK32lwJc5biYv7s3bn8Px
         yn8CYCHTO2BOLCpZaJyr5QQCVgXN9gSiAtnqyp1zu3nmbbFpWIDlcNqaIPKWIuhXIyCP
         XGfwt/+aLGHQP7H8o0gLoZ+kqjx3Go44BoDWd/LuhgYLtb+aj2+dt7QhCP2ORxentfcR
         +/Z5QI5YTQj7Gox9kwGiY4pzcDo1ukIWucBojwZxbe8woMm5S8utQgCsC48bF5PrOb5Z
         B7QWYda/ssVm71SfOfXrLep7TAj6mzA4d5gBJQzgUjHkTSieL0hvr202pu8NkEESw5E0
         W/4g==
X-Gm-Message-State: APt69E2KPzwV4BGi/CT/IUHAVkkDotWlAtjwFhogPt7ppZF43Y+nUsaF
        s4hf+lwXeEaL8DYwLEvfGVd6jwnHoQs=
X-Google-Smtp-Source: AAOMgpeL6GWI8lypkbBIOytj0Jj1W/0+jYIb/JLHb9KcIhsOTTVNltlC6kfXJ1z0e17mHV4ylLG+rA==
X-Received: by 2002:a62:b29c:: with SMTP id z28-v6mr10532327pfl.8.1530878933559;
        Fri, 06 Jul 2018 05:08:53 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.186])
        by smtp.gmail.com with ESMTPSA id j23-v6sm13925519pfi.137.2018.07.06.05.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 05:08:52 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH v3 2/4] rebase: refactor common shell functions into their own file
Date:   Fri,  6 Jul 2018 17:53:13 +0545
Message-Id: <20180706120815.17851-3-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706120815.17851-1-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180706120815.17851-1-predatoramigo@gmail.com>
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
 git-legacy-rebase.sh  | 62 +------------------------------------------
 git-rebase--common.sh | 61 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 61 deletions(-)
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
index 19bdebb480..240aac507c 100755
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
index 0000000000..5ba0603924
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

