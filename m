Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3CCEB64DC
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjFZQ0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjFZQZM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5227810A
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa99742af9so9816335e9.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796708; x=1690388708;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKu0gew+L0cr2subSDlfRN9FFp2QTYIXuB6vWqdWXfc=;
        b=RVFuNABophH+G7Oey1iAseGGbBmhIxT2YSV9a+IveVbQlJd5IHX/bcbn0+SCC4VSp8
         nimoTqXCSiWtJLh1lIcMYJkkZKu0DwmWOJqKqsCK6wVqBTFW2yPrqe4muf20kl9ts4dh
         dkFgj6T5BeVM4UHHJZL7EuoF9Q1jWGmFwGVPKRJgfpY0FSasGsZxQLe8lDCcogv9G+lx
         GTi+JJtpJ76z4nU4DSLbEfvoCGdtyU4bb+bEVl/1n3VSiSD03T8KtdGN8sVZfH4XH17n
         lL9ixYdaXMX9xjmHMDvGompBzFdUDAdAIXpKIY62eSxTrHih0qphhkwTftKNordDVpzk
         KtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796708; x=1690388708;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKu0gew+L0cr2subSDlfRN9FFp2QTYIXuB6vWqdWXfc=;
        b=Gb/oT2RtKoC8/gMSbRW+PZIGkbp7a6D1/p9wykxU/f7g4TcPxQcblcDLtRKXICv9Dt
         8rsBb/kUpBK9SV3LltaXeyqJUaiHv2hCC7tYxmHyShFxCyvNxNSUFqeXiojyuGEhlC79
         qYOQaD4Lk/KSntO+h1QlE6k9cJSyrcY7/wFyaQlUZL31VckWgcN/iLBRO6uK6N9xuRL8
         BV2/0e0fGPaBMbIgADCV9nf4kQwAlbLPvOnxEjawE/m/lwoWCdgBk9bvdXhnEx1GE3su
         WBlnOuDgWRglGrwiDuxm8MSuRqGgBm5gIcmdw2spByAXNSVzfHDKEsdH4dsuMUg1/dZ2
         NQdQ==
X-Gm-Message-State: AC+VfDzFz1B4dxGfp9XJ7jHYGt/ePdxqv7DSgB9e50zg2974/nUnTMd/
        QKL09hSk2Yrq38MgpGo72aAW3CCYu0o=
X-Google-Smtp-Source: ACHHUZ6iHjQfoI6bmUN7jo6BjY8jYIHAZZsy0E+iuARKSSSw4t3n5gZpqnBoAWGWCzs7seySeYVQJg==
X-Received: by 2002:a5d:4148:0:b0:313:f54a:a848 with SMTP id c8-20020a5d4148000000b00313f54aa848mr1475125wrq.61.1687796708539;
        Mon, 26 Jun 2023 09:25:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11-20020adfdd8b000000b00313ecd3714csm4932428wrl.19.2023.06.26.09.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:08 -0700 (PDT)
Message-Id: <eb9a6a069147b5664a636095f398e3aac2e90dbf.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:47 +0000
Subject: [PATCH v3 23/24] completion: complete --remerge-diff
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

--remerge-diff only makes sense for 'git log' and 'git show', so add it
to __git_log_show_options which is referenced in the completion for
these two commands.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8688f7c433c..11f2edf47be 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2042,7 +2042,7 @@ __git_log_shortlog_options="
 "
 # Options accepted by log and show
 __git_log_show_options="
-	--diff-merges --diff-merges= --no-diff-merges
+	--diff-merges --diff-merges= --no-diff-merges --remerge-diff
 "
 
 __git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-combined cc remerge r"
-- 
gitgitgadget

