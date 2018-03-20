Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC4561F404
	for <e@80x24.org>; Tue, 20 Mar 2018 20:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbeCTUpW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 16:45:22 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40612 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeCTUpS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 16:45:18 -0400
Received: by mail-pf0-f196.google.com with SMTP id x1so1125083pfh.7
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5zN2UIW5x/n807fwVvT+ow9waxYnaCIUfl9mVTNVWhI=;
        b=rH59Hofg9524utSCXi/xeXyvso+W1PaZhh3kHo76BPXmVUn3OAR134eotEthX77tFm
         YOabPN3Qop9MmOg+RjT7mqk5Plf7nfy6a5u9dtNfv9XqQv5CooxFpcXCWyU1L38AiQ6c
         sFjnZ2X7UaTV6t5xfMGlqJWJyd25D/gNlRa3iqLGY5GGoGuhgWNMMS2/MTvvRYL7wbnC
         0Mvb9Z/FN/Cju4NJDD9ZUdz/oqS6xb6hDGaQX/Qe7F11GtYuQkrmCthKiLNXfoNEPsPk
         +O8XIFkO/Sd7OvyWVbV8ZRjxH2xtAOoEF4KC6RxzQJt/T0//0rayhohpPuVVexbWbuHw
         Xvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5zN2UIW5x/n807fwVvT+ow9waxYnaCIUfl9mVTNVWhI=;
        b=MSUkYmICBxN8opEJSNi5g5RZYsGGMuofgkwDMRAxcbyopCsklFM8FNfLrs0k9GXjkR
         TJsP7bkl2ySdzrnGGNgoO9sYMwzuJkmvD/FRMBKR4Z/fdtx5AGkT/kwK4hrrRA+OETTZ
         S9nH6Y+xY8RoNmfV1noa37VbN/sPSWr40BqeZip8QxNL+2OrNvbqSm43KAm7A1SBq4+s
         Z8XDuds6821TCnRrW/Jdmg0AMuC1Cg9NJRwiFB5Qyd1qB0iBoeoy0Ba/k3UBpA6SXQnj
         j4xSNV7U9imXWn4pytfj+f7JVx76A3MQSnSvQfaQjqAdBWoklM4NFxGmR369yw29Dz1M
         yT+w==
X-Gm-Message-State: AElRT7HkKgN3QNRqv0h6vlWMNefrrbW9vnge/xn5GrRTQ39kUyPf0BPs
        QZ+VEwfK4r4vf2vprckVzunlP72aU4c=
X-Google-Smtp-Source: AG47ELsjWPVY2fRrXAIzWiaFt2ScuA5dU/7DQBYSnuA3IEfryzUdqg1dZxHVnOIC21B/QZ2IsZ1aIQ==
X-Received: by 10.101.66.6 with SMTP id c6mr3649904pgq.35.1521578717035;
        Tue, 20 Mar 2018 13:45:17 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id m18sm4180259pgu.51.2018.03.20.13.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Mar 2018 13:45:15 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, Wink Saville <wink@saville.com>
Subject: [RFC PATCH 2/3] rebase-interactive: create git-rebase--interactive--preserve-merges
Date:   Tue, 20 Mar 2018 13:45:06 -0700
Message-Id: <20180320204507.12623-3-wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320204507.12623-1-wink@saville.com>
References: <20180320204507.12623-1-wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract the code that is executed when $preserve_merges is t from
git-rebase--interactive to git-rebase--interactive--preserve-merges.sh.
The extracted code uses functions from git-rebase--interactve--lib.

Signed-off-by: Wink Saville <wink@saville.com>
---
 .gitignore                                  |   1 +
 Makefile                                    |   1 +
 git-rebase--interactive--preserve-merges.sh | 134 ++++++++++++++++++++++++++++
 git-rebase.sh                               |   7 +-
 4 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 git-rebase--interactive--preserve-merges.sh

diff --git a/.gitignore b/.gitignore
index 4ea246780..c57a6b563 100644
--- a/.gitignore
+++ b/.gitignore
@@ -116,6 +116,7 @@
 /git-rebase--am
 /git-rebase--helper
 /git-rebase--interactive
+/git-rebase--interactive--preserve-merges
 /git-rebase--interactive--lib
 /git-rebase--merge
 /git-receive-pack
diff --git a/Makefile b/Makefile
index f13540da6..543e0a659 100644
--- a/Makefile
+++ b/Makefile
@@ -567,6 +567,7 @@ SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--am
 SCRIPT_LIB += git-rebase--interactive
+SCRIPT_LIB += git-rebase--interactive--preserve-merges
 SCRIPT_LIB += git-rebase--interactive--lib
 SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
diff --git a/git-rebase--interactive--preserve-merges.sh b/git-rebase--interactive--preserve-merges.sh
new file mode 100644
index 000000000..e00b5c990
--- /dev/null
+++ b/git-rebase--interactive--preserve-merges.sh
@@ -0,0 +1,134 @@
+#!/bin/sh
+# This shell script fragment is sourced by git-rebase to implement
+# its interactive mode with --preserve-merges flag.
+# "git rebase --interactive" makes it easy to fix up commits in the
+# middle of a series and rearrange commits and adding --preserve-merges
+# requests it to preserve merges while rebase.
+#
+# Copyright (c) 2006 Johannes E. Schindelin
+#
+# The original idea comes from Eric W. Biederman, in
+# https://public-inbox.org/git/m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com/
+
+. git-rebase--interactive--lib
+
+# The whole contents of this file is run by dot-sourcing it from
+# inside a shell function.  It used to be that "return"s we see
+# below were not inside any function, and expected to return
+# to the function that dot-sourced us.
+#
+# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
+# construct and continue to run the statements that follow such a "return".
+# As a work-around, we introduce an extra layer of a function
+# here, and immediately call it after defining it.
+git_rebase__interactive__preserve_merges () {
+	initiate_action "$action"
+	ret=$?
+	if test $ret == 0; then
+		return 0
+	fi
+
+	setup_reflog_action
+	init_basic_state
+
+	if test -z "$rebase_root"
+	then
+		mkdir "$rewritten" &&
+		for c in $(git merge-base --all $orig_head $upstream)
+		do
+			echo $onto > "$rewritten"/$c ||
+			    die "$(gettext "Could not init rewritten commits")"
+		done
+	else
+		mkdir "$rewritten" &&
+		echo $onto > "$rewritten"/root ||
+			die "$(gettext "Could not init rewritten commits")"
+	fi
+
+	# No cherry-pick because our first pass is to determine
+	# parents to rewrite and skipping dropped commits would
+	# prematurely end our probe
+	merges_option=
+
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
+
+	# The 'rev-list .. | sed'
+	#   requires %m to parse; where as the the instruction
+	#   requires %H to parse
+	format=$(git config --get rebase.instructionFormat)
+	git rev-list $merges_option --format="%m%H ${format:-%s}" \
+		--reverse --left-right --topo-order \
+		$revisions ${restrict_revision+^$restrict_revision} | \
+		sed -n "s/^>//p" |
+	while read -r sha1 rest
+	do
+		if test -z "$keep_empty" \
+			&& is_empty_commit $sha1 \
+			&& ! is_merge_commit $sha1
+		then
+			comment_out="$comment_char "
+		else
+			comment_out=
+		fi
+
+		if test -z "$rebase_root"
+		then
+			preserve=t
+			for p in $(git rev-list --parents -1 $sha1 | \
+				cut -d' ' -s -f2-)
+			do
+				if test -f "$rewritten"/$p
+				then
+					preserve=f
+				fi
+			done
+		else
+			preserve=f
+		fi
+		if test f = "$preserve"
+		then
+			touch "$rewritten"/$sha1
+			printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
+		fi
+	done
+
+	mkdir "$dropped"
+	# Save all non-cherry-picked changes
+	git rev-list $revisions --left-right --cherry-pick | \
+		sed -n "s/^>//p" > "$state_dir"/not-cherry-picks
+	# Now all commits and note which ones are missing in
+	# not-cherry-picks and hence being dropped
+	git rev-list $revisions |
+	while read rev
+	do
+		if test -f "$rewritten"/$rev &&
+		   ! sane_grep "$rev" "$state_dir"/not-cherry-picks >/dev/null
+		then
+			# Use -f2 because if rev-list is telling us this commit
+			# is not worthwhile, we don't want to track its
+			# multiple heads, just the history of its first-parent
+			# for others that will be rebasing on top of it.
+			git rev-list --parents -1 $rev | \
+				cut -d' ' -s -f2 > "$dropped"/$rev
+			sha1=$(git rev-list -1 $rev)
+			sane_grep -v "^[a-z][a-z]* $sha1" <"$todo" > "${todo}2"
+			mv "${todo}2" "$todo"
+			rm "$rewritten"/$rev
+		fi
+	done
+
+	complete_action
+}
+# ... and then we call the whole thing.
+git_rebase__interactive__preserve_merges
diff --git a/git-rebase.sh b/git-rebase.sh
index a1f6e5de6..3c2fc35f7 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -196,7 +196,12 @@ run_specific_rebase () {
 		export GIT_EDITOR
 		autosquash=
 	fi
-	. git-rebase--$type
+	if test "$type" = interactive
+	then
+		. git-rebase--${type}${preserve_merges:+--preserve-merges}
+	else
+		. git-rebase--${type}
+	fi
 	ret=$?
 	if test $ret -eq 0
 	then
-- 
2.16.2

