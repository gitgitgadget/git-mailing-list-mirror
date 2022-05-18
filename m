Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B8BC433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 18:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbiERSkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 14:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241440AbiERSkX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 14:40:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908B31E38AB
        for <git@vger.kernel.org>; Wed, 18 May 2022 11:40:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r23so3914625wrr.2
        for <git@vger.kernel.org>; Wed, 18 May 2022 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=l+AYXSULqS5l3lNAYhb5ltvAGhjHIa+6wQ6d3TJcNT4=;
        b=I6LPCJZxsHpTyU3KMsatNeCEu+lKnzVAsnMp0ARjIgEEzQhO65zu0uVu3BFRof/kRP
         bIrFcUVlY9Li9blRMmvmBHMpVf9L+xDzfywEgvXNEFkXktFSHr7RFHXhIvlBxyh2Qc2O
         WWOjzbvnU7xc9IRX8C1r3sp6JzGTXKrM3hjz49tGcc58veRsyjKQdpFkhBiMJeFwXTl5
         hWbamCPl0wAj0b0wRiXI2MC0e+7938yiFZ0YyLfq51fJiqf5heNCWquDkIoT+m2UhtGY
         uKCAiIfAnYrHooiR2Psl5lz/E0qJi5m+o06648h9WuCqhTLi3jCN0e+ogbvt7tYizr/W
         0lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l+AYXSULqS5l3lNAYhb5ltvAGhjHIa+6wQ6d3TJcNT4=;
        b=hU7RD6y1oB2cub6RLiNVWbxR3h0SJdfvRcJ3Kirr7/Hk0gn5pmpeehYIUTh0uA11C4
         AlH1Z5rdOnxznfxpkN/mebHbgkmsx9qXaJO7p8ETKexmuGwgDvFJBgRSZtklz/9AwZmX
         c0JHO+2Yte6Gze1K264RAre7RyWCwc2VgXwEkwM4shDJ88JfYlJIe04uJpoAQ09tOdLu
         LRXqXR6CNLEQaj0GPChyxGdGx8d3UPEpm/ugDWNXn758WuiuJotE5a5Aa9sKtkRcTTN3
         axJz2RR3oKbdKvQNPUYEVNb4yl+uFfWbDXn1+xImgtJP67JJlr8zf/DwX6se+hf5vAYu
         Relg==
X-Gm-Message-State: AOAM530w2GWsUjOG/HlU9CZhH1Bvzwcx4dzTwoVcnkVtKpL/l5QOoD/4
        FRa5kmQdEEbyjbNcSjRGtCS+ZBB0t8A=
X-Google-Smtp-Source: ABdhPJwMCU2PomhOg8o28weJWUJLtHGtiaKurmvyooavC+38T4ZH0x8Ds65eqtD7DgLYVOlNRJKpsQ==
X-Received: by 2002:adf:fc01:0:b0:20c:ff9a:2c53 with SMTP id i1-20020adffc01000000b0020cff9a2c53mr870272wrr.142.1652899220716;
        Wed, 18 May 2022 11:40:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c351500b003971ece4e8bsm2561303wmq.13.2022.05.18.11.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:40:20 -0700 (PDT)
Message-Id: <pull.1265.git.git.1652899219597.gitgitgadget@gmail.com>
From:   "mataha via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 May 2022 18:40:19 +0000
Subject: [PATCH] templates: clarify SHA1 arg in prepare-commit-msg
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     mataha <mateusz.kazimierczuk@xolv.io>,
        mataha <mateusz.kazimierczuk@xolv.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: mataha <mateusz.kazimierczuk@xolv.io>

'prepare-commit-msg' hook sample description doesn't mention the third
argument (a commit object name) nor when is it actually passed to that
hook by git-commit (if the source is a commit; see builtin/commit.c#L777,
sequencer.c#L1219). Seeing that it's documented in githooks(5), there
should be no reason not to include that in the sample hook as well.

Signed-off-by: Mateusz 'mataha' Kazimierczuk <mateusz.kazimierczuk@xolv.io>
---
    Mention the third argument in 'prepare-commit-msg' hook sample
    
    'prepare-commit-msg' hook sample doesn't mention what the third argument
    is for nor when is it actually passed; I feel like it should be, for the
    sake of convenience (this doesn't mean that a user shouldn't refer to a
    more detailed description in the manual, of course).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1265%2Fmataha%2Fdoc%2Fprepare-commit-msg-args-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1265/mataha/doc/prepare-commit-msg-args-v1
Pull-Request: https://github.com/git/git/pull/1265

 templates/hooks--prepare-commit-msg.sample | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 318afe3fd86..bc06d0701a8 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -3,9 +3,9 @@
 # An example hook script to prepare the commit log message.
 # Called by "git commit" with the name of the file that has the
 # commit message, followed by the description of the commit
-# message's source.  The hook's purpose is to edit the commit
-# message file.  If the hook fails with a non-zero status,
-# the commit is aborted.
+# message's source and the commit object name (if the source was
+# a commit).  The hook's purpose is to edit the commit message file.
+# If the hook fails with a non-zero status, the commit is aborted.
 #
 # To enable this hook, rename this file to "prepare-commit-msg".
 

base-commit: 277cf0bc36094f6dc4297d8c9cef79df045b735d
-- 
gitgitgadget
