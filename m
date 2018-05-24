Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 595371F51C
	for <e@80x24.org>; Thu, 24 May 2018 11:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967122AbeEXLui (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 07:50:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33296 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969289AbeEXLuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 07:50:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id x12-v6so26775006wmc.0
        for <git@vger.kernel.org>; Thu, 24 May 2018 04:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UgWZwwHf9jHjy4LAeVyEh0E9njw41iEHuTSaKLlVslI=;
        b=jNQ4PGsEdrOAI5QZP/2MdM123LbEI2GYzaAQ1fF1CPfqRYl+qIM40Fxqi6qRBXeAuK
         uIucx85Vhcu9TUjbRBsQDwi75seQA1QIF/kv0+86csxoOoUBUBemQXe4LohpzaUy2417
         FbHt+/1LruQN3aHZ9VNzTvyxUwQuaw0yGK7RVKBNKDvKtaIwDfyETY/usmN6Gk7IBo+A
         t7cpG1aSoJ0y8kwZjuq2UTD52f8cqixfsJQ1hQB5u3IDCWJhiDhIuVGtB3otEOAzC0Ij
         Jg2/NqnSOy3luZfAokyJZ9A1l3o3fSA3n6jFdh1W/2qYWMJoObeKwr+Y+XJzz1aWNMab
         gQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UgWZwwHf9jHjy4LAeVyEh0E9njw41iEHuTSaKLlVslI=;
        b=WgpKJMKokmkecN99JGxMTuLVVmmU6vSyImej6FuY732yNzBIDZRaW/Bd7Z2ZcRnPY2
         4f1PRrKUXD8WuV5VsLBR2lmFAUOemS9PmZs5vGFrAUjwLcVJXBUYI0I21Fz22rLGx3jc
         W6eS+xOWre1R02bvm6qbsHiTgEvBGVwvv/5O/KpNf6rrwdUGyUKpUOc4D5/i+E/HJ8bc
         joV6rLBJru1Jf8tbv+eW/SwPCXj+geTQ5Y3p3B1xXvJNjU9o65rZeTuXfmcRD1Enao74
         xX8zjd+o5+3r0clrkffhi0BGhiRf0nnkNuqp8F75lDyBzD1BGg5b4ketQ8Dua0f6FDa1
         NUQw==
X-Gm-Message-State: ALKqPwfaWwx0rz9mLa2JhALMbwvXtUU61ObYlxBGe6c8Nu9y0VxSN296
        KuBTm0XlzsQ8yPhEaTa7r99ZGCMZeFU=
X-Google-Smtp-Source: AB8JxZpsyliQLrSiDw8e1Y3Mp2BMh2GAhn3ywBeyr6edBc/7cs1v7f9Bjd3cLbR/A5Iti1xvn3SM1A==
X-Received: by 2002:a1c:8350:: with SMTP id f77-v6mr6950951wmd.1.1527162614477;
        Thu, 24 May 2018 04:50:14 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-64.w86-221.abo.wanadoo.fr. [86.221.117.64])
        by smtp.googlemail.com with ESMTPSA id o53-v6sm31494264wrc.96.2018.05.24.04.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 May 2018 04:50:13 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 3/4] rebase: use the new git-rebase--preserve-merges.sh
Date:   Thu, 24 May 2018 13:49:57 +0200
Message-Id: <20180524114958.26521-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180524114958.26521-1-alban.gruin@gmail.com>
References: <20180522211625.23893-1-alban.gruin@gmail.com>
 <20180524114958.26521-1-alban.gruin@gmail.com>
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

