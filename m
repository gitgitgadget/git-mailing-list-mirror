Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CFC11F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbeCVQ54 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:57:56 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41263 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeCVQ5u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:57:50 -0400
Received: by mail-pg0-f65.google.com with SMTP id m24so3491067pgv.8
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=G+UupBsk37XM1vVPBGdAgfdmeM8kHPHxvUeUQaXsbgs=;
        b=DYM055YfFh6d5Zi3ojq+HlrhbUsKQNGvd2eubduyDdJ3eg0GTDx+lcZAZ6yIhECsVW
         BfbgalJU26f+1ObyuxmchVGzEYRY2ukMsE/VKorbwFsytiEOgMNgNTzNtVJj3zpnAgqv
         Yh3ohNUIKF74Jx6PnQvoUgiUGMmS+WUQsWPDHGnfJOe7XmmMuNcoVppCxObkoYpkJRyD
         AUFgHaeoLOSCmsLXxg4rtYXCTqtuh/ysQRb63k26pnJOK2ZnRtDNJ8vAoQ4+NyBBiVq2
         sWCN+0ONTnZCJL/C7QseyCnb9ConsOHwpve1FmS88DY2poAAA5I5vxTmk9oRxCusg17U
         rs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=G+UupBsk37XM1vVPBGdAgfdmeM8kHPHxvUeUQaXsbgs=;
        b=C5OUKoeoQFJG7XMvUxlt4zhU0RzwWwTD5nIAH5tuHI82nFqFK1X43m/6BewwqOxwMy
         n43Dbbx/P3pUWZvpU2m09loZ+r2+Bkv/O8uPPzMWj+V1KBuKyiuhxzPx7X/aAl+7KSHX
         RClFSCtt1g4F8WlEMyw9UQaNuLN+T8ifljYt5Nmn+WzkrJS2KNIIb/2HQuxhhbtHUipl
         LXm7gKyqAVBavFal1VIJiAjUhfW3rthwCyKafHsxtadMHOo/auXR5VBTSJrlL7X7XYjq
         EEXLq1iLwqHWyIpv0/Y+I4y5aRGSKE61YzEcrU2oWiHMe1Txn4NiSglBrzs8KLwvRb53
         P0sA==
X-Gm-Message-State: AElRT7FCFTiPVOHNsN1fQA7IXwc1e6BEsCRa2lLZ+5Rhco34IM5rUY8L
        t41lhQv1WwgT5B1TJjFOrIPZ0FQARO4=
X-Google-Smtp-Source: AG47ELsntyBk2F2j6EQweJgsiO6Wrpe7xDssLq11oONkiKfp5kl04SOV4SxEn9/GQV/nuG/+63nTxA==
X-Received: by 10.98.61.80 with SMTP id k77mr14789456pfa.2.1521737869073;
        Thu, 22 Mar 2018 09:57:49 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id 2sm15043830pfo.70.2018.03.22.09.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 09:57:47 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: [RFC PATCH v3 6/9] Add and use git_rebase__interactive__preserve_merges
Date:   Thu, 22 Mar 2018 09:57:26 -0700
Message-Id: <4b0a72043d351ced18b299c8bb9b0f3f27f101fb.1521690197.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the moment it's an exact copy of git_rebase__interactive except
the name has changed.

Signed-off-by: Wink Saville <wink@saville.com>
---
 git-rebase--interactive.sh | 108 +++++++++++++++++++++++++++++++++++++++++++++
 git-rebase.sh              |   7 ++-
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2c10a7f1a..ab5513d80 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1058,3 +1058,111 @@ git_rebase__interactive () {
 
 	complete_action
 }
+
+git_rebase__interactive__preserve_merges () {
+	initiate_action "$action"
+	ret=$?
+	if test $ret = 0; then
+		return 0
+	fi
+
+	setup_reflog_action
+	init_basic_state
+
+	if test t = "$preserve_merges"
+	then
+		if test -z "$rebase_root"
+		then
+			mkdir "$rewritten" &&
+			for c in $(git merge-base --all $orig_head $upstream)
+			do
+				echo $onto > "$rewritten"/$c ||
+					die "$(gettext "Could not init rewritten commits")"
+			done
+		else
+			mkdir "$rewritten" &&
+			echo $onto > "$rewritten"/root ||
+				die "$(gettext "Could not init rewritten commits")"
+		fi
+		# No cherry-pick because our first pass is to determine
+		# parents to rewrite and skipping dropped commits would
+		# prematurely end our probe
+		merges_option=
+	else
+		merges_option="--no-merges --cherry-pick"
+	fi
+
+	init_revisions_and_shortrevisions
+
+	if test t != "$preserve_merges"
+	then
+		git rebase--helper --make-script ${keep_empty:+--keep-empty} \
+			$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
+		die "$(gettext "Could not generate todo list")"
+	else
+		format=$(git config --get rebase.instructionFormat)
+		# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
+		git rev-list $merges_option --format="%m%H ${format:-%s}" \
+			--reverse --left-right --topo-order \
+			$revisions ${restrict_revision+^$restrict_revision} | \
+			sed -n "s/^>//p" |
+		while read -r sha1 rest
+		do
+
+			if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
+			then
+				comment_out="$comment_char "
+			else
+				comment_out=
+			fi
+
+			if test -z "$rebase_root"
+			then
+				preserve=t
+				for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
+				do
+					if test -f "$rewritten"/$p
+					then
+						preserve=f
+					fi
+				done
+			else
+				preserve=f
+			fi
+			if test f = "$preserve"
+			then
+				touch "$rewritten"/$sha1
+				printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
+			fi
+		done
+	fi
+
+	# Watch for commits that been dropped by --cherry-pick
+	if test t = "$preserve_merges"
+	then
+		mkdir "$dropped"
+		# Save all non-cherry-picked changes
+		git rev-list $revisions --left-right --cherry-pick | \
+			sed -n "s/^>//p" > "$state_dir"/not-cherry-picks
+		# Now all commits and note which ones are missing in
+		# not-cherry-picks and hence being dropped
+		git rev-list $revisions |
+		while read rev
+		do
+			if test -f "$rewritten"/$rev &&
+			   ! sane_grep "$rev" "$state_dir"/not-cherry-picks >/dev/null
+			then
+				# Use -f2 because if rev-list is telling us this commit is
+				# not worthwhile, we don't want to track its multiple heads,
+				# just the history of its first-parent for others that will
+				# be rebasing on top of it
+				git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
+				sha1=$(git rev-list -1 $rev)
+				sane_grep -v "^[a-z][a-z]* $sha1" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
+				rm "$rewritten"/$rev
+			fi
+		done
+	fi
+
+	complete_action
+}
diff --git a/git-rebase.sh b/git-rebase.sh
index c4ec7c21b..b32282f4c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -199,7 +199,12 @@ run_specific_rebase () {
 	if test "$type" = interactive
 	then
 		. git-rebase--interactive
-		git_rebase__interactive
+		if test "$preserve_merges" = t
+		then
+			git_rebase__interactive__preserve_merges
+		else
+			git_rebase__interactive
+		fi
 		ret=$?
 	else
 		. git-rebase--$type
-- 
2.16.2

