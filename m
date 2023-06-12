Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D33C7EE25
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbjFLMy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjFLMxV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD67173F
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:13 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f654d713c0so4567900e87.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574391; x=1689166391;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRxjfJg1uXE6Fstm9uVOLObk2IL6n83aPh98fojxElM=;
        b=SjqM2OxTjgMrAvaa9Cp0YAergUGVuo4K+PP3adQIyjwXiKAE4GAZieG7OC6vUn8fIb
         aU2UAb9QHnLdNmdkrD5cDr+hOGM3be+RLhVqKUMv5LP63iU/rnPk+eb1V5Sb7ubA10mI
         tqqsmfwLgWEcrDfEEuE3xQ5N4DHH6JkpK9leKIwgbcarWT+rsxieMNDaArr6HLv6mhtT
         rP+7hJ+PJl5RzmnQKa0m/EsHNwYDW5fcmyVaD0Fz1MWzXts9UmmoPXpgt9R1DdRdZtUx
         pJQaKiABaLQ/M2EqG+akUvfg9+FFcl8QXHttVL3hxvzTNWmAXvh73brrd8dH2RMmFEH9
         LjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574391; x=1689166391;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRxjfJg1uXE6Fstm9uVOLObk2IL6n83aPh98fojxElM=;
        b=BKTr40SmQXS4tIrNuA7BqBDcfHBGVI6rdXYk81ceZwFh78efYQ/3NXyw5kJOXeM+u/
         +6kCLY41HpjeXfptn+rIB6NDQtEFow6zy007k0pxzr96rSf4o9q5NrXbtr1UzCeX+Qxi
         1itrqVLY0FguUWE3nh3SLao545Q5xI83+1E+hJt8S/vbi3C2Xey+ztwyhH6WyzUMBfpK
         ZSXHfHlCKKPTF5g90fdsyYab0BZWPaNtWiQrTulAYBiCjzVf19sg81NyAWmBWZv8aLq5
         Vf/2FSeGWAvy4CazpSpdW5JiQH1rXiri8U16f59OTgfVJnj3Wc1Nc5Yfekc6OyExJ2xA
         QxIA==
X-Gm-Message-State: AC+VfDy7Jc44DvazfSaZrhig/YnU0G6oVb7qhxSxfP5On50E3K/fBEu6
        X79fnND7EdtisF/CjNT4W6TIw1Icv9g=
X-Google-Smtp-Source: ACHHUZ6LYWcYqc3LDpCEs2xuaztqry3YrJd905gpzlwwaHn8WGJdPnQKY+quiwR6tDsucZzlUgJ1eQ==
X-Received: by 2002:ac2:4db1:0:b0:4f1:3d7d:409e with SMTP id h17-20020ac24db1000000b004f13d7d409emr4398525lfe.0.1686574391047;
        Mon, 12 Jun 2023 05:53:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bca47000000b003f80b96097esm8717495wml.31.2023.06.12.05.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:10 -0700 (PDT)
Message-Id: <807b8201d145a21c629797067cee21d1d1b9a0d4.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:47 +0000
Subject: [PATCH v2 19/25] completion: complete --patch-with-raw
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
index a69421cd740..c0d2678d320 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1741,7 +1741,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
 			--find-copies --find-object --find-renames
-			--no-relative --relative
+			--no-relative --relative --patch-with-raw
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
-- 
gitgitgadget

