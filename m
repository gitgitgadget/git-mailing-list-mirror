Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74A5C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B99613E2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhFRTAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhFRTAu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 15:00:50 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB550C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:58:39 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10691594otl.3
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVHW9pBpi9UldKhSBuTBqkdj1LNZIt+9vs/mSWCrzoM=;
        b=HyoMkG7Uim2QQcU30k/OQQt5Xg3LRcCZcw52DVrgtjaXDlkNDmL0H9WOJG3SvOq1Cw
         wex/e3hBdcvizPcFzP9hojWbfAuOxOmAz2R9zOG7cY2VXT65dIAhdT52JFtbMmTSFiOK
         fHb4GnXDfI91OHz1XvFHiPANe0y64O+FLJvtJcJVqnZHziZrbWPCiYar3njCzCF0GTXD
         zucroEjWjkqLWJ5r9QsaER37uAjw8rHnHIgurZDJkxtyfYl7RcCFYCRqMZ2pvcErI0pf
         f0YpX6NHQq2vAxLDZuRSDVMbqpzLc1zcfaRIukMukO481RQbTZ+nDGQ/nduMuEACwCnO
         7ZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVHW9pBpi9UldKhSBuTBqkdj1LNZIt+9vs/mSWCrzoM=;
        b=DFpxdQPql4iCG1qa4uoeLFdVn+9AN2T40IlSoy64Jxc43HeTxGUPQXe5hYXOSrAfwL
         6Kw4W/BWV4BhNjdaumtiqBhcug7HZ8FNTbCcyr3P+EjR0wgTGpfiHr5UvWraKFa2yPq+
         n3eDKL4jzhiN3ZZjwxfTU9r7vSkf+hZniERiHvAuh85+5BoFrrzi2w+lLu9y0Z0n5xYe
         a9jNGWky/QVtr8r2xEhXV+W+qfvgnCoEGtAdfnMjpH8WMmDlXW+EFjG2uR3yrSmWLh9F
         eIE8jGTGsPC+7RBT2GEs8GC8aMrLEfafoUO8wHpLPnNjWFe8/a/X7l7fgX9c33BOer7j
         lang==
X-Gm-Message-State: AOAM532u4gChZPxQj3HhbM+g08Th5324Iuit75aEzB6GxpN3bMlzdXUn
        2P7I0nouZDb9/mGuvO3zTkclhOqA/Fi8lA==
X-Google-Smtp-Source: ABdhPJwexlzRv4NsI7Do3RYfEnAMalDP9vrb2vxByWGMVce+qhVtYyj5BoY11ud+UaRJA9bWkfvk/w==
X-Received: by 2002:a9d:4689:: with SMTP id z9mr10821351ote.129.1624042719143;
        Fri, 18 Jun 2021 11:58:39 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id s187sm1986340oig.6.2021.06.18.11.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:58:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Harrison McCullough <mccullough.harrison@gmail.com>,
        Fabian Wermelinger <fabianw@mavt.ethz.ch>
Subject: [PATCH] completion: fix __git_cmd_idx regression
Date:   Fri, 18 Jun 2021 13:58:32 -0500
Message-Id: <20210618185832.700477-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-2-felipe.contreras@gmail.com>
References: <20210618182518.697912-2-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit 59d85a2a05 (git-completion.bash: use $__git_cmd_idx in more
places, 2021-04-22) caused a regression when using __git_complete and a
command relies on __git_cmd_idx.

We need the function wrapper to define __git_cmd_idx.

Reported-by: Harrison McCullough <mccullough.harrison@gmail.com>
Helped-by: Fabian Wermelinger <fabianw@mavt.ethz.ch>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-completion.bash | 2 +-
 git-completion.zsh  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-completion.bash b/git-completion.bash
index b50c5d0..c053a62 100644
--- a/git-completion.bash
+++ b/git-completion.bash
@@ -3511,7 +3511,7 @@ fi
 
 __git_func_wrap ()
 {
-	local cur words cword prev
+	local cur words cword prev __git_cmd_idx=0
 	_get_comp_words_by_ref -n =: cur words cword prev
 	$1
 }
diff --git a/git-completion.zsh b/git-completion.zsh
index cac6f61..a1f2d27 100644
--- a/git-completion.zsh
+++ b/git-completion.zsh
@@ -271,7 +271,7 @@ __git_zsh_main ()
 _git ()
 {
 	local _ret=1
-	local cur cword prev
+	local cur cword prev __git_cmd_idx=0
 
 	cur=${words[CURRENT]}
 	prev=${words[CURRENT-1]}
-- 
2.32.0

