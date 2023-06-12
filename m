Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8C1C7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbjFLMyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjFLMxV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AB910D4
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30ae95c4e75so4242619f8f.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574395; x=1689166395;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBjVsTfHC97mrXrTf7OOMY/gBC1f5uYUeDEimD9hNGU=;
        b=l9VjLlPLGEYl3x5Y2CbCbh7g4Z/QPqPO0njF9goXPt5zTDCn86lobZHNOaNIGzsTN7
         UfvjyeUslY4OtL8ArdsMsE6+Cj3BJEjgiJptFNLUli80YEraQzrKTKW6Ys/XnqD/FD/t
         ZsM2q+Ri3ex6dA8HTp5qvh0bpID8pTWKpQnHsWHLnqbPpQP1xLsODXJgtV4SaaXj1502
         GUze+rdSEwyDqK9rAmrpEeFix3fbdcaJhg8D/U1byNqLK+hRbj/Yv2fsjTI7lVjkJVAH
         PY3qDFg0F+Lr2fxmgh/Cnh92aXEvVDJ9+iSwL/z1myVBkmO7Vc634V0DdU2pvhQ8TwdL
         5l9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574395; x=1689166395;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBjVsTfHC97mrXrTf7OOMY/gBC1f5uYUeDEimD9hNGU=;
        b=glmc1Zy3OVwFHZGifcktiPUqz/yDVXZihfvHoSuqx47dmiTbo8W8AdbC8NWQqw3HVJ
         1EBDSONbHVv2xWKiIzI9DSBV1USsYTelEdcP0aRIqDtcjDanfSt7eBB780qajLHt6KsN
         zV2/qJ/k+f0VLv2+bNN36TmVbIOBrTszuif4fDQJbvV/iAvyornh45uvWLPmXlL0SpdY
         jlxnL+9KdcEupsd26rxm1zm4zLXtQM42q/P9mmYnL0SW9Nyr91BbJuBQrIiF6+8nRKHK
         UBAJmKTz2vmv6+WwiAiAKFwYnhdyDXJAu7vnFHoeMYMoEpn93FqmtF2a1GcgQMxgbh/o
         WGXQ==
X-Gm-Message-State: AC+VfDwhy0oZgdiCfL/qZz56Zalc9zBRqJ1MgYMWYMYEQEOq8nN/ePPC
        whIsaGWRNLeU1MKW3SWcVqr8SEl/Ivo=
X-Google-Smtp-Source: ACHHUZ5N5Sp2Aacg4lYHCqQk4B+EFchvNINgg6Zd+F0x4RAMpLlM0SdjRPKD6Pq2xYJu/OGxPoTq1A==
X-Received: by 2002:a05:6000:184:b0:309:4358:5afd with SMTP id p4-20020a056000018400b0030943585afdmr4293675wrx.54.1686574394768;
        Mon, 12 Jun 2023 05:53:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b002ca864b807csm12466391wro.0.2023.06.12.05.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:14 -0700 (PDT)
Message-Id: <d5fc5b04b00c863a7201b6762f5034a89adc4577.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:52 +0000
Subject: [PATCH v2 24/25] completion: complete --remerge-diff
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
index 7b7f3f838e0..38b6bac9154 100644
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

