Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 062D4200B9
	for <e@80x24.org>; Tue, 22 May 2018 21:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeEVVQn (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 17:16:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53678 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753116AbeEVVQj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 17:16:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id a67-v6so3388403wmf.3
        for <git@vger.kernel.org>; Tue, 22 May 2018 14:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UgWZwwHf9jHjy4LAeVyEh0E9njw41iEHuTSaKLlVslI=;
        b=PchR5TxBIx8xM6OoAFc2iJEO/1EgaU0wbv4vMKyC9G8/MXvSB1gq/xl5qpIyqTwLoF
         qovLwjIDgyADtPl69wStYb8Vk3lPB75izyr07A7xvdy5dPmlMMX6Ac6m1ZEor7E+2cgV
         TYXs9QRI21PF76op150vqwU6g1PhlLmkaFjtrZ3BZyY7u1SK0dC+uLDRPBQW3hf5DslC
         Hslhkx9Db4/UdlZbSAs0YYjjvHdWV4jIQuLAMgZwLaNmTzfmhjiQjmtybuJ+0hhsa/DA
         9nKCryf1/xRPC1s8bkt47BsfVn/JebFYDVjHaf5EkEOc190klum/HXeAXzzUSp8K49Ti
         sSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UgWZwwHf9jHjy4LAeVyEh0E9njw41iEHuTSaKLlVslI=;
        b=AtzvuEILhVLu4GvILrKixkVIh0TEuREDP9tUrMe6e1qOH8PRNhVDchwVU9g2uqCDuc
         iytGlllkMswj92HWC+9SZXiXUi/rBOAxuDiPEeAqpedbZTFFwHdqYZOoQEXQAiNZc+/X
         U9tSDOb6pPG9puKa4ism/Ee75ViWgOLvLRihRLBZsALuXJW8AI2iPZbElDe/HetsKyiJ
         qAd3FPZBXRHyIXKc1ym9mqiN4Wh9h4nR5SjK5LxrJ831RUXcfXcrNaej4QXsEcikjxKI
         tIdkooF+0P5huJUpe3w7zHOhVkH6ltDWbJG5ve10HIi7oqJmDnTtelYGnSG1pLcXZu3w
         YWPQ==
X-Gm-Message-State: ALKqPwerLOmGXP1EZRXGR9P92Y4wQIpRq7dCbxQacBCShUFGOSGj4c87
        81pc+XAI6qw8w+QSVr6s0e4NPVbEj3w=
X-Google-Smtp-Source: AB8JxZqSrR5KXnpZVNxQl8HNFWj4STr83qVSrkRQcLqkeQch1M5I1tetemiLZ7+8N1XcQUokvwITqg==
X-Received: by 2002:a1c:8f8f:: with SMTP id r137-v6mr2220024wmd.103.1527023798153;
        Tue, 22 May 2018 14:16:38 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-64.w86-221.abo.wanadoo.fr. [86.221.117.64])
        by smtp.googlemail.com with ESMTPSA id z66-v6sm941983wme.13.2018.05.22.14.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 May 2018 14:16:36 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 3/4] rebase: use the new git-rebase--preserve-merges.sh
Date:   Tue, 22 May 2018 23:16:24 +0200
Message-Id: <20180522211625.23893-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180522211625.23893-1-alban.gruin@gmail.com>
References: <20180522133110.32723-1-alban.gruin@gmail.com>
 <20180522211625.23893-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Creates a new type of rebase, "preserve-merges", used when rebase is called with
-p.

Before that, the type for preserve-merges was "interactive", and some places of
this script compared $type to "interactive". Instead, the code now checks if
$interactive_rebase is empty or not, as it is set to "explicit" when calling an
interactive rebase (and, possibly, one of its submodes), and "implied" when
calling one of its submodes (eg. preserve-merges) *without* interactive rebase.

It also detects the presence of the directory "$merge_dir"/rewritten left by the
preserve-merges script when calling rebase --continue, --skip, etc., and, if it
exists, sets the rebase mode to preserve-merges. In this case,
interactive_rebase is set to "explicit", as "implied" would break some tests.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 git-rebase.sh | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 40be59ecc..19bdebb48 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -207,7 +207,14 @@ run_specific_rebase () {
 		autosquash=
 	fi
 	. git-rebase--$type
-	git_rebase__$type${preserve_merges:+__preserve_merges}
+
+	if test -z "$preserve_merges"
+	then
+		git_rebase__$type
+	else
+		git_rebase__preserve_merges
+	fi
+
 	ret=$?
 	if test $ret -eq 0
 	then
@@ -239,7 +246,12 @@ then
 	state_dir="$apply_dir"
 elif test -d "$merge_dir"
 then
-	if test -f "$merge_dir"/interactive
+	if test -d "$merge_dir"/rewritten
+	then
+		type=preserve-merges
+		interactive_rebase=explicit
+		preserve_merges=t
+	elif test -f "$merge_dir"/interactive
 	then
 		type=interactive
 		interactive_rebase=explicit
@@ -402,14 +414,14 @@ if test -n "$action"
 then
 	test -z "$in_progress" && die "$(gettext "No rebase in progress?")"
 	# Only interactive rebase uses detailed reflog messages
-	if test "$type" = interactive && test "$GIT_REFLOG_ACTION" = rebase
+	if test -n "$interactive_rebase" && test "$GIT_REFLOG_ACTION" = rebase
 	then
 		GIT_REFLOG_ACTION="rebase -i ($action)"
 		export GIT_REFLOG_ACTION
 	fi
 fi
 
-if test "$action" = "edit-todo" && test "$type" != "interactive"
+if test "$action" = "edit-todo" && test -z "$interactive_rebase"
 then
 	die "$(gettext "The --edit-todo action can only be used during interactive rebase.")"
 fi
@@ -487,7 +499,13 @@ fi
 
 if test -n "$interactive_rebase"
 then
-	type=interactive
+	if test -z "$preserve_merges"
+	then
+		type=interactive
+	else
+		type=preserve-merges
+	fi
+
 	state_dir="$merge_dir"
 elif test -n "$do_merge"
 then
@@ -647,7 +665,7 @@ require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
 # but this should be done only when upstream and onto are the same
 # and if this is not an interactive rebase.
 mb=$(git merge-base "$onto" "$orig_head")
-if test "$type" != interactive && test "$upstream" = "$onto" &&
+if test -z "$interactive_rebase" && test "$upstream" = "$onto" &&
 	test "$mb" = "$onto" && test -z "$restrict_revision" &&
 	# linear history?
 	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
@@ -691,7 +709,7 @@ then
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
 fi
 
-test "$type" = interactive && run_specific_rebase
+test -n "$interactive_rebase" && run_specific_rebase
 
 # Detach HEAD and reset the tree
 say "$(gettext "First, rewinding head to replay your work on top of it...")"
-- 
2.16.1

