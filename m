Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7182C1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbeCWVZ5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:25:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44111 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbeCWVZz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:25:55 -0400
Received: by mail-pf0-f196.google.com with SMTP id m68so5210878pfm.11
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Ejq7XhN1Tv6IFQgzfp7gEPj32C+HZZVRUU3u9YLELF0=;
        b=zH0HETtJV3DtTfIPxUoC0rfUG8CSoDQ28/YVSX/IAiIQwrtxm/+UtmIGu5pRsFdOZW
         HbmogSsOj0VABLIfV2pAU0t5Rs1CI7mgietjPvBp1xLlln7FecC9OgkzkWXUGnsRMvCA
         siyuVrPYdJOUpj5MkVNjBX0KHHetG5UC1HhN7Ea/QfuXsEeOSjF6gJ6NXVk9mkAzrezM
         06SDgSzegnguiQxcS0TxQf9PqxwSWDxfqU9AczHN1XR5ZNoMs5fRYDlh9JBnprv72/uZ
         jSfrEjniN6mIcTIyjdJkjY8l7GQB7DVofbjfQb8v7a1cdKIDOrlQJU4s2GsM1HzWHRcv
         VtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Ejq7XhN1Tv6IFQgzfp7gEPj32C+HZZVRUU3u9YLELF0=;
        b=K7RUPiAoEVN/qN0L1StW+/pmITIb7jEBQMoRMkX0o/I5nrBl/evmV26VY39GklEumG
         xTJeR8BNjB71jr9/u4S2HP/HQybRoUBb9pAJ+rvGFfqlv+kgN/8rgl3pMhefOn7RlYRh
         yIWUU2cPy7seaNZvjq0Pssb7Z5V7SMZpQeMgrcFpVugzmlj5cdhxBAzsfI/AICfgnyEj
         BLmhKSrvldc1UlVs20u1n6ai+JFTVs4Yfeanl6XaTiRtYCJjeW0SHeJ1VMpeyy0HxQC9
         zEJJ+xAorXnYRF1PD2bX7gOLbVN6SvibW+SzDEclESNVghTlrAnpGgcAVIggQB5lLtYm
         /A4Q==
X-Gm-Message-State: AElRT7HRrU7rPypjvKii51ZQ4t0OHPb4lCrsRKyQQlGHvbboZvHjFn4l
        tsDZp9q+eEhxoD7rL9UO9NGhcLeA9xI=
X-Google-Smtp-Source: AG47ELtKTQxLUYtChtk08qYZw+XNsUxK+L703h7ivsgKk7K9ui0iQSlHW7xhnohAcM3wbd/FLiKgpg==
X-Received: by 10.98.137.218 with SMTP id n87mr2905832pfk.48.1521840353845;
        Fri, 23 Mar 2018 14:25:53 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id z28sm15380096pgc.15.2018.03.23.14.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 14:25:51 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gister@pobox.com,
        sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v5 4/8] Extract functions out of git_rebase__interactive
Date:   Fri, 23 Mar 2018 14:25:25 -0700
Message-Id: <baf0d9bab81bb3a80d0428c4aaa33cf32b3823e4.1521839546.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521839546.git.wink@saville.com>
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The extracted functions are:
  - initiate_action
  - setup_reflog_action
  - init_basic_state
  - init_revisions_and_shortrevisions
  - complete_action

Used by git_rebase__interactive

Signed-off-by: Wink Saville <wink@saville.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git-rebase--interactive.sh | 182 +++++++++++++++++++++++++++------------------
 1 file changed, 111 insertions(+), 71 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a79330f45..2c10a7f1a 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -740,8 +740,20 @@ get_missing_commit_check_level () {
 	printf '%s' "$check_level" | tr 'A-Z' 'a-z'
 }
 
-git_rebase__interactive () {
-	case "$action" in
+# Initiate an action. If the cannot be any
+# further action it  may exec a command
+# or exit and not return.
+#
+# TODO: Consider a cleaner return model so it
+# never exits and always return 0 if process
+# is complete.
+#
+# Parameter 1 is the action to initiate.
+#
+# Returns 0 if the action was able to complete
+# and if 1 if further processing is required.
+initiate_action () {
+	case "$1" in
 	continue)
 		if test ! -d "$rewritten"
 		then
@@ -836,8 +848,13 @@ To continue rebase after editing, run:
 	show-current-patch)
 		exec git show REBASE_HEAD --
 		;;
+	*)
+		return 1 # continue
+		;;
 	esac
+}
 
+setup_reflog_action () {
 	comment_for_reflog start
 
 	if test ! -z "$switch_to"
@@ -848,13 +865,102 @@ To continue rebase after editing, run:
 
 		comment_for_reflog start
 	fi
+}
 
+init_basic_state () {
 	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
 	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
 	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 
 	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
 	write_basic_state
+}
+
+init_revisions_and_shortrevisions () {
+	shorthead=$(git rev-parse --short $orig_head)
+	shortonto=$(git rev-parse --short $onto)
+	if test -z "$rebase_root"
+		# this is now equivalent to ! -z "$upstream"
+	then
+		shortupstream=$(git rev-parse --short $upstream)
+		revisions=$upstream...$orig_head
+		shortrevisions=$shortupstream..$shorthead
+	else
+		revisions=$onto...$orig_head
+		shortrevisions=$shorthead
+	fi
+}
+
+complete_action() {
+	test -s "$todo" || echo noop >> "$todo"
+	test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
+	test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
+
+	todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
+	todocount=${todocount##* }
+
+cat >>"$todo" <<EOF
+
+$comment_char $(eval_ngettext \
+	"Rebase \$shortrevisions onto \$shortonto (\$todocount command)" \
+	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
+	"$todocount")
+EOF
+	append_todo_help
+	gettext "
+	However, if you remove everything, the rebase will be aborted.
+
+	" | git stripspace --comment-lines >>"$todo"
+
+	if test -z "$keep_empty"
+	then
+		printf '%s\n' "$comment_char $(gettext "Note that empty commits are commented out")" >>"$todo"
+	fi
+
+
+	has_action "$todo" ||
+		return 2
+
+	cp "$todo" "$todo".backup
+	collapse_todo_ids
+	git_sequence_editor "$todo" ||
+		die_abort "$(gettext "Could not execute editor")"
+
+	has_action "$todo" ||
+		return 2
+
+	git rebase--helper --check-todo-list || {
+		ret=$?
+		checkout_onto
+		exit $ret
+	}
+
+	expand_todo_ids
+
+	test -d "$rewritten" || test -n "$force_rebase" ||
+	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
+	die "Could not skip unnecessary pick commands"
+
+	checkout_onto
+	if test -z "$rebase_root" && test ! -d "$rewritten"
+	then
+		require_clean_work_tree "rebase"
+		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
+			--continue
+	fi
+	do_rest
+}
+
+git_rebase__interactive () {
+	initiate_action "$action"
+	ret=$?
+	if test $ret = 0; then
+		return 0
+	fi
+
+	setup_reflog_action
+	init_basic_state
+
 	if test t = "$preserve_merges"
 	then
 		if test -z "$rebase_root"
@@ -878,18 +984,8 @@ To continue rebase after editing, run:
 		merges_option="--no-merges --cherry-pick"
 	fi
 
-	shorthead=$(git rev-parse --short $orig_head)
-	shortonto=$(git rev-parse --short $onto)
-	if test -z "$rebase_root"
-		# this is now equivalent to ! -z "$upstream"
-	then
-		shortupstream=$(git rev-parse --short $upstream)
-		revisions=$upstream...$orig_head
-		shortrevisions=$shortupstream..$shorthead
-	else
-		revisions=$onto...$orig_head
-		shortrevisions=$shorthead
-	fi
+	init_revisions_and_shortrevisions
+
 	if test t != "$preserve_merges"
 	then
 		git rebase--helper --make-script ${keep_empty:+--keep-empty} \
@@ -960,61 +1056,5 @@ To continue rebase after editing, run:
 		done
 	fi
 
-	test -s "$todo" || echo noop >> "$todo"
-	test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
-	test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
-
-	todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
-	todocount=${todocount##* }
-
-cat >>"$todo" <<EOF
-
-$comment_char $(eval_ngettext \
-	"Rebase \$shortrevisions onto \$shortonto (\$todocount command)" \
-	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
-	"$todocount")
-EOF
-	append_todo_help
-	gettext "
-	However, if you remove everything, the rebase will be aborted.
-
-	" | git stripspace --comment-lines >>"$todo"
-
-	if test -z "$keep_empty"
-	then
-		printf '%s\n' "$comment_char $(gettext "Note that empty commits are commented out")" >>"$todo"
-	fi
-
-
-	has_action "$todo" ||
-		return 2
-
-	cp "$todo" "$todo".backup
-	collapse_todo_ids
-	git_sequence_editor "$todo" ||
-		die_abort "$(gettext "Could not execute editor")"
-
-	has_action "$todo" ||
-		return 2
-
-	git rebase--helper --check-todo-list || {
-		ret=$?
-		checkout_onto
-		exit $ret
-	}
-
-	expand_todo_ids
-
-	test -d "$rewritten" || test -n "$force_rebase" ||
-	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
-	die "Could not skip unnecessary pick commands"
-
-	checkout_onto
-	if test -z "$rebase_root" && test ! -d "$rewritten"
-	then
-		require_clean_work_tree "rebase"
-		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-			--continue
-	fi
-	do_rest
+	complete_action
 }
-- 
2.16.2

