Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D781F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbeCVQ5u (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:57:50 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:43783 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeCVQ5q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:57:46 -0400
Received: by mail-pf0-f170.google.com with SMTP id j2so3586799pff.10
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=y1ZdWP3MUGbykMmEK4MWJeSCOABENWzIUYnjJ8+iq+k=;
        b=ZcWpQYY5dL/fgI5j+Wyn+fpngqyyp+2xTEdFEwx6R/vBdxlQHFWnJky8fwsEXmzeaS
         k5VvqoKldvaODQw7frvLZenVNhKm2t/0xa4TpFd6OeHT0g7X/bpbX8mlX0FSaGz6xjEc
         ERnOMSyAgjSoSJ1OJaRQ2an/05GTE5UsVFn9OcCrFsMzL6CE3QXZEBakDJ/GGvoxN8FC
         uyZ9TTYG49PWRsm3lU99qRAAAjp0Aq82/oNd5qXY+KGC1ayBz7wZ+y3iedvWY0+NoqP8
         hKzr+p3XrKHzJXA/BzIKepwq5vmp52dZPlY4k/Bo2acGKAQ1FureW79PVHsS7sycg9mX
         fITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=y1ZdWP3MUGbykMmEK4MWJeSCOABENWzIUYnjJ8+iq+k=;
        b=SxTcGLmfTeh6zP+nqcJAZ7R5KJNzobwhxAl8iDcb+g3/mEuiXDbqOeaapwwf2rlMY0
         OAdRrjXWG2T6q29Hyq/iDqb3lqeDfOEo4AUh61LF+4NKXdIa4RPpX96ARYxg4myojcDN
         7fheTI3LYMXJabNnvo6Qu6pCIcGvvaNXkcL71cW9VmJrRtHZUGSmsbENlujkxzEQ+/WV
         KUF9DZc0so1y1XyjAqaHV8CTfoZVDRB74/rTxvi0KYwlWN7RNlMWxnNP9gR5tzSMOMAS
         ixaRQdWFN2mSFF6B88iYWSlSmWmxNZrG/vg8AQsD/VLpB77mZliL6XBmogEoI6r7za8H
         WaUg==
X-Gm-Message-State: AElRT7F/z+y0XJwtS0nGlzkAP6BdWSNP5Oq5uploKA/z3jBHcACfKh+8
        TDvfQW/ImDhUJ8CZ6OczwWntyEk9+kM=
X-Google-Smtp-Source: AG47ELswsjrhloHePFGDoigBd5OZn+o2jS/AfF7uf0KA5Aa71sqjz5YMz7R0iz7rkWq2bzB0wF7ziQ==
X-Received: by 10.99.131.73 with SMTP id h70mr18241557pge.195.1521737864812;
        Thu, 22 Mar 2018 09:57:44 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id 2sm15043830pfo.70.2018.03.22.09.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 09:57:43 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: [RFC PATCH v3 4/9] Extract functions out of git_rebase__interactive
Date:   Thu, 22 Mar 2018 09:57:24 -0700
Message-Id: <fd4a622bf7a7b94924c9f9e5dd2ed1bd5255ec7d.1521690197.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
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

Signed-off-by: Wink Saville <wink@saville.com>
---
 git-rebase--interactive.sh | 211 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 211 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a79330f45..b72f80ae8 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -740,6 +740,217 @@ get_missing_commit_check_level () {
 	printf '%s' "$check_level" | tr 'A-Z' 'a-z'
 }
 
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
+	continue)
+		if test ! -d "$rewritten"
+		then
+			exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
+				--continue
+		fi
+		# do we have anything to commit?
+		if git diff-index --cached --quiet HEAD --
+		then
+			# Nothing to commit -- skip this commit
+
+			test ! -f "$GIT_DIR"/CHERRY_PICK_HEAD ||
+			rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
+			die "$(gettext "Could not remove CHERRY_PICK_HEAD")"
+		else
+			if ! test -f "$author_script"
+			then
+				gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
+				die "$(eval_gettext "\
+You have staged changes in your working tree.
+If these changes are meant to be
+squashed into the previous commit, run:
+
+  git commit --amend \$gpg_sign_opt_quoted
+
+If they are meant to go into a new commit, run:
+
+  git commit \$gpg_sign_opt_quoted
+
+In both cases, once you're done, continue with:
+
+  git rebase --continue
+")"
+			fi
+			. "$author_script" ||
+				die "$(gettext "Error trying to find the author identity to amend commit")"
+			if test -f "$amend"
+			then
+				current_head=$(git rev-parse --verify HEAD)
+				test "$current_head" = $(cat "$amend") ||
+				die "$(gettext "\
+You have uncommitted changes in your working tree. Please commit them
+first and then run 'git rebase --continue' again.")"
+				do_with_author git commit --amend --no-verify -F "$msg" -e \
+					${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
+					die "$(gettext "Could not commit staged changes.")"
+			else
+				do_with_author git commit --no-verify -F "$msg" -e \
+					${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
+					die "$(gettext "Could not commit staged changes.")"
+			fi
+		fi
+
+		if test -r "$state_dir"/stopped-sha
+		then
+			record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
+		fi
+
+		require_clean_work_tree "rebase"
+		do_rest
+		return 0
+		;;
+	skip)
+		git rerere clear
+
+		if test ! -d "$rewritten"
+		then
+			exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
+				--continue
+		fi
+		do_rest
+		return 0
+		;;
+	edit-todo)
+		git stripspace --strip-comments <"$todo" >"$todo".new
+		mv -f "$todo".new "$todo"
+		collapse_todo_ids
+		append_todo_help
+		gettext "
+You are editing the todo file of an ongoing interactive rebase.
+To continue rebase after editing, run:
+    git rebase --continue
+
+" | git stripspace --comment-lines >>"$todo"
+
+		git_sequence_editor "$todo" ||
+			die "$(gettext "Could not execute editor")"
+		expand_todo_ids
+
+		exit
+		;;
+	show-current-patch)
+		exec git show REBASE_HEAD --
+		;;
+	*)
+		return 1 # continue
+		;;
+	esac
+}
+
+setup_reflog_action () {
+	comment_for_reflog start
+
+	if test ! -z "$switch_to"
+	then
+		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
+		output git checkout "$switch_to" -- ||
+			die "$(eval_gettext "Could not checkout \$switch_to")"
+
+		comment_for_reflog start
+	fi
+}
+
+init_basic_state () {
+	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
+	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
+	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
+
+	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
+	write_basic_state
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
 git_rebase__interactive () {
 	case "$action" in
 	continue)
-- 
2.16.2

