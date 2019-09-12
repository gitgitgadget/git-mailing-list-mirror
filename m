Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 579821F463
	for <e@80x24.org>; Thu, 12 Sep 2019 19:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfILTn6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 15:43:58 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:41819 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfILTn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 15:43:58 -0400
Received: by mail-pf1-f175.google.com with SMTP id b13so16600547pfo.8
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 12:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JMFyGPaW8u0D+73VKD7Y+f05/5ugjxDsVNTdQrXP2EM=;
        b=gOBaUnl9BayIjoJGHKPj+rzxS42v3DKt033KBPxQGjLTfdqnF4jWpw+/y3nJErLxDK
         tRJX+7Juwy0NQJ8nQMEz9BMs1T2icGLwEnYCsElsJ9JbiqSj36HKQb84kVza/VhJYB7r
         nw9Q+kXgqpWM6rdkJRf7o1AGHR5jqXJZGD4DvLHhADPQscOBecBaTG+T86sKSHB2QQ0C
         Ik5qOikCOlKqGdLQ4Ss6ZmRt4ChFoKDu1YG+to15kRIYAiR0L2TdEJ+kPuR7mw1XlV0b
         GS8evsLYs7S0WhNeC1j/YLqDloE91O4XAWi/qzRJrh2wXgeYsyWpQSOlgKqfGA+YKtUU
         QNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JMFyGPaW8u0D+73VKD7Y+f05/5ugjxDsVNTdQrXP2EM=;
        b=XMpxVCjw7V/JRSbgpstpb1Aq/LhqFhYQ8whtfOtSu3RYu0ZOsWEFshDCCXtI2mKrme
         XWE+5AoOqtOeGDrMm3suKWrM5ejXN9TGRMd4OD5wkNoqUuLZ2zYTrzmdrDIWNLKnrvML
         C6yOlFnawG8X9ctRdb9gEGKwBUBQaBbMwYymPErjRV+2OY5o1DpnZus6A1+U1SP74k4X
         Rmhphwsd8+MKGggeJwFvw+qKlgibeieoeKQw9VvcV3gyrygWJ62n2aq4VW5/n16jsUU7
         kHst1wKkyZpSW64kiNsds8w3XfBfpe0fG9T1S6JgRuDm7BfW79V1zX7T5yrLRm8lscVr
         Fh4Q==
X-Gm-Message-State: APjAAAXleFnvsVkXmDldYUVOHjnB8uKFkDAMoQ+i0ouCgcJE8E+ffjQX
        FTl8YL5pYyDlrhL1QO5OQB0m6DAJVqk=
X-Google-Smtp-Source: APXvYqy+x8a56iViFrK/DlCoSP/7na1YG8zvbYylvAkOeVVRSwhEauzBCXdHSRVUjAF555EBlF/uKg==
X-Received: by 2002:a17:90a:f993:: with SMTP id cq19mr385434pjb.51.1568317437067;
        Thu, 12 Sep 2019 12:43:57 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id q186sm36279001pfb.47.2019.09.12.12.43.56
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 12:43:56 -0700 (PDT)
Date:   Thu, 12 Sep 2019 12:43:55 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/2] completion: teach rebase to use __gitcomp_builtin
Message-ID: <7c4f2361842f5a9cbaf6130cafe1dd77f75e19e0.1568317093.git.liu.denton@gmail.com>
References: <cover.1568317093.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568317093.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, _git_rebase() uses a hardcoded list of options for its
completion. However, we can use __gitcomp_builtin() to get a dynamically
generated list of completions instead.

Teach _git_rebase() to use __gitcomp_builtin() so that newly implemented
options in rebase will be automatically completed without any mucking
around in git-completion.bash.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e087c4bf00..365edff639 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2004,15 +2004,18 @@ _git_range_diff ()
 	__git_complete_revlist
 }
 
+__git_rebase_inprogress_options="--continue --skip --abort --quit --show-current-patch"
+__git_rebase_interactive_inprogress_options="$__git_rebase_inprogress_options --edit-todo"
+
 _git_rebase ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/rebase-merge/interactive ]; then
-		__gitcomp "--continue --skip --abort --quit --edit-todo --show-current-patch"
+		__gitcomp "$__git_rebase_interactive_inprogress_options"
 		return
 	elif [ -d "$__git_repo_path"/rebase-apply ] || \
 	     [ -d "$__git_repo_path"/rebase-merge ]; then
-		__gitcomp "--continue --skip --abort --quit --show-current-patch"
+		__gitcomp "$__git_rebase_inprogress_options"
 		return
 	fi
 	__git_complete_strategy && return
@@ -2022,19 +2025,8 @@ _git_rebase ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--onto --merge --strategy --interactive
-			--rebase-merges --preserve-merges --stat --no-stat
-			--committer-date-is-author-date --ignore-date
-			--ignore-whitespace --whitespace=
-			--autosquash --no-autosquash
-			--fork-point --no-fork-point
-			--autostash --no-autostash
-			--verify --no-verify
-			--keep-empty --root --force-rebase --no-ff
-			--rerere-autoupdate
-			--exec
-			"
+		__gitcomp_builtin rebase "" \
+			"$__git_rebase_interactive_inprogress_options"
 
 		return
 	esac
-- 
2.23.0.37.g745f681289

