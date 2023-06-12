Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30729C7EE25
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbjFLMyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjFLMxV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D771980
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:13 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f7f6341bf9so43092375e9.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574392; x=1689166392;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDvxqnfpWYnoIzV5Z9Y90KCQwDVlVuLP1sO5xxzYWXU=;
        b=brrEgOSOa/esz91LrTaQXisuoKVh7qDg34oOmThREfWoWgoEscCRHtO/ARn0biIbxx
         W6k1NFFvT11oDRj00lQ73OONcBuR+0P7j9A0EvJzpyNcKG+T3o6l0qHwQrpECN+Bc0II
         Olu6XWp8u1xiCpul8iZc1FVwIYfzjdp11Fy0HTLbEBXKrNKM24RyL8GuGAbzGcbuSqHe
         1EWu/L1qBNZ8jzq5RXlQEgH7mH0HP27cUPVhj9mDnvQdajBPBwrOFpQghw1V+X+UL+Eg
         zDKZJHxwCkDkhOjzkKmPPHGquwBYBhAzlSSBQW+uOV/ScyfZ3KQpC0eZGi8TC+rs0XET
         3USQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574392; x=1689166392;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDvxqnfpWYnoIzV5Z9Y90KCQwDVlVuLP1sO5xxzYWXU=;
        b=eyfOwgm7Xw/AX5uU10qGgPbPq2RqQQ63rnAmgqu4zRGCWMATOsjl8Ogrnm0pGimW4u
         iQjJc2WynJWCNO12SXdGvS3yiEY+jJAiuAVcJ8Px/4EtAt5gRWWo824pKjpz9A64zfq0
         r0TWw4jTQUwHA6QRMGIH0MC0/zYI3u2dIahfdBlJENCcZz2QL4k0V4E3JkpYDZidhlJ1
         lOpYJRsH6J15QB/0x9iYzBKPyMLnFRY9Ohd47+RLV+ZEEyqfJOLTg65MS95MbPg+OvPC
         8Hy7mwe6PZPW1Z5a3jEgcQ8TtQWs+nKf/ujKi7CxpBy9YIsKfGWwVFUGA06ggc3BIzGF
         nqMA==
X-Gm-Message-State: AC+VfDz6j5NEJBaJwxuBY/ArlwdThi/2tXjLuVeslNTTYnxA8CvdP7nJ
        TXwM+cjXjkjzgWnFZXFTOng55DEMJjA=
X-Google-Smtp-Source: ACHHUZ7IohZlc5CEIX8m84uRg75odRLD/rGk2v1OffifLvz5Qnj5ZExf5jTEuevINtGkSZcN33QHcg==
X-Received: by 2002:a5d:5543:0:b0:30a:e5ba:170d with SMTP id g3-20020a5d5543000000b0030ae5ba170dmr5065369wrw.32.1686574391829;
        Mon, 12 Jun 2023 05:53:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a18-20020a056000101200b002c70ce264bfsm925908wrx.76.2023.06.12.05.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:11 -0700 (PDT)
Message-Id: <19507b1a2109f419ba5c628c32db46f96903e166.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:48 +0000
Subject: [PATCH v2 20/25] completion: complete --unified
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c0d2678d320..230d5807860 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1745,7 +1745,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
-			--quiet --ext-diff --no-ext-diff
+			--quiet --ext-diff --no-ext-diff --unified=
 			--no-prefix --src-prefix= --dst-prefix=
 			--inter-hunk-context= --function-context
 			--patience --histogram --minimal
-- 
gitgitgadget

