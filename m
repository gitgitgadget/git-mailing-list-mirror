Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D79C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiJUJWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiJUJWC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:22:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A7225641B
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:21:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bk15so3812543wrb.13
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSEIaLYWwqPrjb06JkAriDRxYvo8kNvRobBzwV8/xxo=;
        b=bbwvMy8CyQdAVEL138Hlqwe5dHEMw/pjb67kNpIjDAfRA/SvLFYHFYeWZFW7zvD+tZ
         5ZgfMu4UZzoyPEb1HQXnmRdXx5ZdhIrNtV6vxugy1Gk4nj2nyltQQNRYXJUziKHRl5wI
         ywjs+7LT4jWgANUOVPYVLEc+d0DGHHiAnrbr07xGGOfQwW2dA3DNUrrUt+qZHrttA93l
         rLEvGWJy6yuzPLkf6/MIEfou/lsQyX3tp6CVJ9wmvrXrd8gLH7Fqhfqhb9VCQIqesuHu
         c04klI7iuIzMwNNSdgVP9VJGOIxC4ld7H1uzpBDr/QSHUVk6GBmuo9Fqyjwz75C20jxJ
         /xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSEIaLYWwqPrjb06JkAriDRxYvo8kNvRobBzwV8/xxo=;
        b=lDq1Kku+sEYerYESMM/q5+8tHQo9xFJjlrdZuksRcd9WwFPsNg7p002UizIRdal51J
         Hc8b+3sPZncqO2KZYbqwRU8kK6iqa725IV1iDw2eZAhBAUJ5gyIvltziAk0cRxPQ7Ayo
         59SRXbMODNrVd55oWid6n2XEJNZ6tHfqlEJsxFK6IFl1z1aZ6TwICyzfdA4/WwTVomNS
         vBN6lx2dxQJSz6oWFdiZ/NXb3zUHrM+QKj7n46EUZvIcppY84aNvu4bwJ34C5BQGmxZa
         51oqzE/nq6nvUbWU9MqgHXwSIJzB9qX77+zjyq65Y1yatjhNlXwOed81rOnyrin8UbVU
         PoKg==
X-Gm-Message-State: ACrzQf3KRvTtZ7/hoJzM51apF3Ky96wHqGgunYoNGrJw08MOrPNNnPMa
        OtAtLN+CV8/0DCSsRvOgLv6zX4kkS/c=
X-Google-Smtp-Source: AMsMyM62Sui6Jj9Fhmz8aFyqCGScxkY265wa0Xvt5J387ITk2Z9ytSKHeC/BfFEmhFAeNOVMo4M3xw==
X-Received: by 2002:a05:6000:1d8d:b0:22e:6371:65b6 with SMTP id bk13-20020a0560001d8d00b0022e637165b6mr11624699wrb.657.1666344116432;
        Fri, 21 Oct 2022 02:21:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c468900b003c452678025sm2392511wmo.4.2022.10.21.02.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:21:55 -0700 (PDT)
Message-Id: <0c71c73290441b67e2d70809cfaf605a1f3f70ca.1666344108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 09:21:45 +0000
Subject: [PATCH v4 5/8] rebase --apply: respect GIT_REFLOG_ACTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The reflog messages when finishing a rebase hard code "rebase" rather
than using GIT_REFLOG_ACTION.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          | 7 ++++---
 t/t3406-rebase-message.sh | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c1e68173b5f..ea246c6bb3a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -582,10 +582,11 @@ static int move_to_original_branch(struct rebase_options *opts)
 	if (!opts->onto)
 		BUG("move_to_original_branch without onto");
 
-	strbuf_addf(&branch_reflog, "rebase finished: %s onto %s",
+	strbuf_addf(&branch_reflog, "%s finished: %s onto %s",
+		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
-	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
-		    opts->head_name);
+	strbuf_addf(&head_reflog, "%s finished: returning to %s",
+		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), opts->head_name);
 	ropts.branch = opts->head_name;
 	ropts.flags = RESET_HEAD_REFS_ONLY;
 	ropts.branch_msg = branch_reflog.buf;
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 8aa6a79acc1..bb2a4949abc 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -88,7 +88,7 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
 write_reflog_expect () {
 	if test $mode = --apply
 	then
-		sed 's/.*(finish)/rebase finished/; s/ ([^)]*)//'
+		sed 's/(finish)/finished/; s/ ([^)]*)//'
 	else
 		cat
 	fi >expect
-- 
gitgitgadget

