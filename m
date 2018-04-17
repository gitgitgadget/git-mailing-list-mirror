Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ECBD1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 21:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753365AbeDQVaB (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 17:30:01 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40139 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbeDQVaA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 17:30:00 -0400
Received: by mail-wr0-f193.google.com with SMTP id v60so35456326wrc.7
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LNzhrF+7TOuFnuQCIC9ixlNQ9Y8vzbk3Tz55lb/Oj7c=;
        b=MoIyMJSJrgJPCSnda2boOoc8aqUbLf22vDCy7Ag2s2bc/k1jRQJy3+Xrs5dYFvKGiT
         gyFMs9XnJzW2K4/dAGHsCBsqkfRfcNasIAjXAOQHcs01Qq3757t2U3DrQL497aQn+OEj
         FylK/Qf+2MaZdzZwMicALmw+S0l7v16bB6I4z3Pk+ahHxTSph/CSklrB9kMdCwqe5jwq
         5GH93DpWSxIy2KkfvvRlU60JAKpAy1ol1WMqKZ9tpYc6p8VqGKci2qXw0H8KNBBcAIZV
         GCoxqFaXlrUDVeJPmcwMjmPuVSPzA7HZyQICyM3ywDMjnvmW7Cl7mmJ/838OQq8rywWc
         s+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LNzhrF+7TOuFnuQCIC9ixlNQ9Y8vzbk3Tz55lb/Oj7c=;
        b=N6PRG/Zq3Bg2WckvrfOOLYM/9zewSxYVd3CeqFBry5GMClnKEkY9cBxCSem4e9uBNI
         dBGtgwHWFnXx9CqFbIE/CoP69hTArkhW58kDzkrX3H+CIL/hizg2Nf75+DXCCVBbelUZ
         TLk9RGcuGdhrfvNzrSHNwa+on6jOT7Uq9NhjJ5oK1ifJmPpvruSPZO83zKThW6z56/6t
         VcJQFxhS7rSPWEjwzSnPPuJrvmq72f7D0bMGO0XUxFJzKDnoNywB/9gl2csxAWt9T4fI
         oJsSCL4SmBL/b/rJ61EL1oB9FeKnlWzrIntgjbqrLnVB2ArLbhwuh6i+Q3T/AAQqkfWx
         jgOw==
X-Gm-Message-State: ALQs6tCgwqu5FaBiIk1Ju1uCjHk1O1ZQciTmGrI+baxXMKKIQRiLSmIh
        cs8skb4A8uPAEkU25wgWIWcPisWQ
X-Google-Smtp-Source: AIpwx4/yX4YAJlflHgHKnHDbMi4bx2hINNLNttA5teEHbSMObEFHMVlUSjT1jVUc5xt8PF/UFi/RxQ==
X-Received: by 10.28.45.9 with SMTP id t9mr2039664wmt.161.1524000598669;
        Tue, 17 Apr 2018 14:29:58 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id j126sm10536592wmb.33.2018.04.17.14.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 14:29:57 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/3] completion: stop completing 'save' as stash subcommand
Date:   Tue, 17 Apr 2018 22:29:44 +0100
Message-Id: <20180417212945.24002-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <20180417212945.24002-1-t.gummerer@gmail.com>
References: <20180417212945.24002-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'save' subcommand in git stash has been deprecated in
fd2ebf14db ("stash: mark "git stash save" deprecated in the man page",
2017-10-22).  It is however still completed by the git bash
completion.

Stop completing the 'save' subcommand as a further step in the
deprecation process.  As the only use of the bash completion is
interactive, this wouldn't break any scripts, but may give users a
hint that the command is deprecated.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 contrib/completion/git-completion.bash | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 39c123926c..452c3d4490 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2774,7 +2774,7 @@ _git_show_branch ()
 _git_stash ()
 {
 	local default_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
-	local subcommands='push save list show apply clear drop pop create branch'
+	local subcommands='push list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
@@ -2792,9 +2792,6 @@ _git_stash ()
 		push,--*)
 			__gitcomp "$default_opts --message"
 			;;
-		save,--*)
-			__gitcomp "$default_opts"
-			;;
 		apply,--*|pop,--*)
 			__gitcomp "--index --quiet"
 			;;
-- 
2.17.0.252.gfe0a9eaf31

