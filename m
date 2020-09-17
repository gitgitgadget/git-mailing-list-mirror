Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A334BC43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACCE2072E
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7rOVS5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgIQHoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgIQHoh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 03:44:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79F1C06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o20so671287pfp.11
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/mwx6ZHN/3I6oH1IScrvUQS1SzymAXYB1bi5yg/wxYw=;
        b=m7rOVS5ajWn/6DfIZFVa3QFJ9MifA//RL5zwwUTtL0ao60FkXf93StpSj7eShbzLOk
         udlVSglRSNjSmgGZ+SbOPf3wqJ0Pz5wjRDLgX+p6VBT0SS2Ipnn1wy9SBbTw5EShDbUm
         64vS9YOAM0l4EbPibu9eGS5x0juPGuv8m/Ytr7aUDYyjMBMKBx+o8k/XvVEmlPTt3mLH
         A0tYz5Kjc5MR8ew+c30vdvV1JJMatmy2OWA6o0ntl49Hs+ZvNFZohNvDkDTYlIkLX7zN
         Bu3S7DtcWXoyksjDyenWNaNBtr6tKslSNOJhn7xmdhruZ+FO+WCnhvSXc1ao82B0CBWg
         eUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/mwx6ZHN/3I6oH1IScrvUQS1SzymAXYB1bi5yg/wxYw=;
        b=ir7nPfB/w3eZX5aCq2kHmN+auIhYJFfNjpQtuJQyIvPsKBPhGIjs9Vdti9lqcEpe3n
         MM3v03Z9gjCsXf8dURYNTVKZoSg7t4k0AsbLlTeqJPS6hmz/M4oUAkVSb0OzimHEgUxs
         tsa0ZekklsPdTCWjvQ91jQFLpjLx2FPG9g7PNQPuM6y2QFrPrk0PyB6Et4DSJHzW6ODX
         Z6asI+FaMlw6LvVLvb+qxfynAi6qgFQnw+wSu0fVo6UEpO7UlstzypevsH92WThkp1Vq
         PD17kQNGL4nUUXe88v77O8jQzm6nv7ZhYPKWMl4/PXWuk7T6KQZd9q64esUNi4E97oGv
         ODvg==
X-Gm-Message-State: AOAM532H8szXKiWkD+PODbXtUws8ELSSMN8kGqpsP3s0XNYlMI1U7nWy
        WU5JJo4UGZkO3SOvaLGIyD6oZgqbljqXeA==
X-Google-Smtp-Source: ABdhPJyMJUBOqykPov5xnAOdkhsWHwUfaBD1U2fQFfsN2QSHm87bGa33oP697k66noEzpR7c6khgAA==
X-Received: by 2002:a05:6a00:1513:b029:142:2501:34de with SMTP id q19-20020a056a001513b0290142250134demr10118233pfu.55.1600328675148;
        Thu, 17 Sep 2020 00:44:35 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j9sm4931711pfc.175.2020.09.17.00.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:44:34 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/10] git-diff-index.txt: make --cached description a proper sentence
Date:   Thu, 17 Sep 2020 00:44:06 -0700
Message-Id: <21b20281e6a1fa265d4853fa04cc71ba7e843267.1600328335.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1600328335.git.liu.denton@gmail.com>
References: <cover.1599723087.git.liu.denton@gmail.com> <cover.1600328335.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-diff-index.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index f4bd8155c0..25fe165f00 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -27,7 +27,7 @@ include::diff-options.txt[]
 	The id of a tree object to diff against.
 
 --cached::
-	do not consider the on-disk file at all
+	Do not consider the on-disk file at all.
 
 -m::
 	By default, files recorded in the index but not checked
-- 
2.28.0.618.gf4bc123cb7

