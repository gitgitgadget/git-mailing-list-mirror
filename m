Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C836208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 19:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbeHFVmK (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 17:42:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41321 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbeHFVmK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 17:42:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id s24-v6so5731027edr.8
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 12:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mQUTrshVHVrvTg4o2xhkRzfJs4Wie4g+V6cOdNckjn4=;
        b=mol3jqR0aNDHVorv88adYoqksefG+5alMMFLRdvWE326YboZwKobn4zMw7xLozrGSk
         BpORdaD6ib1uBWxEutUxPTfTTskdK4TwaS4/uz8DR20SxMFpcZNsezFemZJdbg2YS5zC
         Ebz9v5waGp//2sllzfdUZAvqT4nnmpH/9lB5AsQQYHFZ/8SxLFQNgNStkoPpiHK91Jt4
         /gImo76AyC/HJlt6kyZjhRXiJZh4nebRLCGdkKayIV0Wk3eoBUrOXX3E896pjHq4b6Xc
         bRHu8fSyPK2hYurqopkjH5aijU76C2vVCOkb7KR4CUwmXwmuHOLRkrBNloLNkxggQKE0
         6inQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mQUTrshVHVrvTg4o2xhkRzfJs4Wie4g+V6cOdNckjn4=;
        b=Lq4nPVwe70By3LqFwcOUB1eJLq1/FeOSAoar3jYLfKRAYIFLBcpud9YRx1FwH9rIYT
         RG7W89xw3L+kiEuo1EI04YsTX5GEHad2kIssTlXQtW4iEySXDEWPdG6CJ1Ml3JsX4I+F
         b+tw6RD+XnWgsh3hVDaYf9JNIamszZpq7G5JF9KDMFwHi/fOfIzDs7QnKVIvA3h5kCdi
         Me5YHk6ZMYWtQSIIxw0cAz/fcDChdrsOg7bJbcj673XFHj1BM7tGpbueXq8AkYORrseh
         rTiqUi+Nc/vQrSxf/0XNMNT3+wcVT1/tG5eJP9JE+p6vfwFyZEnVa1lGboe+3RbJnHTf
         btaQ==
X-Gm-Message-State: AOUpUlE+ADiugEZ0PSYQpyzrkVnSMclUhurTLZoGjlPxDlfziQssJ0Lm
        aDQ1FnCt9L+anZAj9iGw+JfFOuiZ
X-Google-Smtp-Source: AAOMgpfjSdDt+3UEQpy3KtWB2IA9aQiZXIU9WSNri8Z/eU2zJwzZF6BqKSJAEGWjyI7PlYd2vIggvw==
X-Received: by 2002:a50:eacb:: with SMTP id u11-v6mr19925294edp.7.1533583894578;
        Mon, 06 Aug 2018 12:31:34 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.100])
        by smtp.gmail.com with ESMTPSA id x13-v6sm15485811edx.17.2018.08.06.12.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 12:31:33 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [GSoC] [PATCH v6 2/3] rebase: refactor common shell functions into their own file
Date:   Tue,  7 Aug 2018 01:16:10 +0545
Message-Id: <20180806193111.12229-3-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806193111.12229-1-predatoramigo@gmail.com>
References: <20180730162920.20318-1-predatoramigo@gmail.com>
 <20180806193111.12229-1-predatoramigo@gmail.com>
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
Unchanged since v5.

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
index c311532791..c210681a1d 100644
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
index 7973447645..af2cdfef03 100755
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

