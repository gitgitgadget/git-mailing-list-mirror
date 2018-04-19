Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF68B1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 23:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753817AbeDSXZT (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 19:25:19 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44469 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753601AbeDSXZS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 19:25:18 -0400
Received: by mail-wr0-f194.google.com with SMTP id o15-v6so18199362wro.11
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 16:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fM7ZHK9BK2DMUGHDBr9il2kPEAOJSY4lHm3irk3jO1s=;
        b=lUaj3ryGa/yl+QQwmyiYUytwoou2e5sWsl6olf+3KcGivLvLCEn7k3wwjXT2rptgLe
         7rDrgPW3cFDOuqcGIjtgIve2ix5oLlLzuANxxHBFy0Ed4VAXrD2FYRtf6vujiOJon/H/
         BoM6CTjvHQtezEcyTwQIoWwiI6Vt1DRFT1Ty+bUXQwpvpaPYCUp98YQjzSTPhRGl925w
         wf/+wYImAw5whaPMo3vK6cYdIM8HUozky+nfP3dLeM1rLwY7UMv7sj4gFl7DfAj8aqKy
         A2CeDEzZoEaEF8K+WefzP4cHO2pGUJ2JYw606pjr0UQNp3mV+Jxq3pXRyITfAtdzdeUK
         Qfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fM7ZHK9BK2DMUGHDBr9il2kPEAOJSY4lHm3irk3jO1s=;
        b=JGjc6TAVbMVTJwvwwzRB878S514vBrZnTDr5xCYnHB/2oHRBvJ5xD64eh47wDgGDRi
         3ZqG40G1gR1DzOnfJV1qBKoPxsfAu8nHKx0cs4QJzaBLqmpkuGd5Hc+WaNA0hlTDUNzO
         4tF3aXG0G6ZHtbo6EBgZLuC73Z0JRq05rpsV7otk1MRwE1nEI8HC2JhoKPBF4W9ZnwIY
         xC2U8sn106RnvvPylnu7nb5dR8Tby5MMznuHUXSnW6ij2BzkiO6zxa0+2JVsIFNKUy94
         3Eqm3w6KsZmddfPQNtra5sAhaNTq/2E71NnyesrG3txG6jkw76Qv3SxbqhT8dhjYwZnO
         wsYg==
X-Gm-Message-State: ALQs6tAOTNPETVCPNJ7BmHcJ8f/tYu3pa9vBxfN9TkvbC+RiPhtMvaO2
        AKJOFyBhYkp9FdrUt9BwUDGM2H1c
X-Google-Smtp-Source: AIpwx48JyFATzzYMmCXF+uD09bTkC7kw8GbyUItE4EnnLbv231N46WDHt88qR2ToSFRDZdDgOFsMIA==
X-Received: by 2002:adf:c358:: with SMTP id e24-v6mr6320839wrg.86.1524180317283;
        Thu, 19 Apr 2018 16:25:17 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 55-v6sm8442064wrw.52.2018.04.19.16.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 16:25:16 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/2] completion: stop showing 'save' for stash by default
Date:   Fri, 20 Apr 2018 00:25:13 +0100
Message-Id: <20180419232514.16572-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <20180419232514.16572-1-t.gummerer@gmail.com>
References: <20180417212945.24002-1-t.gummerer@gmail.com>
 <20180419232514.16572-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'save' subcommand in git stash has been deprecated in
fd2ebf14db ("stash: mark "git stash save" deprecated in the man page",
2017-10-22).

Stop showing it when the users enters 'git stash <tab>' or 'git stash
s<tab>'.  Keep showing it however when the user enters 'git stash sa<tab>'
or any more characters of the 'save' subcommand.  This is designed to
not encourage users to use 'git stash save', but still leaving the
completion option once it's clear that's what the user means.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 contrib/completion/git-completion.bash | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a757073945..9a95b3b7b1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2774,13 +2774,18 @@ _git_show_branch ()
 _git_stash ()
 {
 	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
-	local subcommands='push save list show apply clear drop pop create branch'
-	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	local subcommands='push list show apply clear drop pop create branch'
+	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
 			__gitcomp "$save_opts"
 			;;
+		sa*)
+			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
+				__gitcomp "save"
+			fi
+			;;
 		*)
 			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
 				__gitcomp "$subcommands"
-- 
2.17.0.252.gfe0a9eaf31

