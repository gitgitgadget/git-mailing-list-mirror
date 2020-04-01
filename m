Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC0AC2D0E7
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567932077D
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="renFfEQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbgDAERx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:17:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40765 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgDAERx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 00:17:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id u10so28876596wro.7
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 21:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p9Pr9vcHIBAGv0RtCZmYZyBzvmoQaEM7VyyaJVVCmuc=;
        b=renFfEQAfyZRTa9yNxGEB3mevSRwG58HempbwCDjbdsNscTqJNUrOZMDLMuEyJM+uf
         Pzl3dLzt7WcR/x3oIgiy7oaRdt8UQMcqrLXlApfKERO6EbLAZwaienavHhDYfzRGWCVw
         Wu2/zXDBmVJe+MMshRxD6zFpP781VRniaqx+1pL+1ylPNPOWA1l4m6WbXBIwb7Hy1qZv
         WDsnrhmDYctMDadUsd84lOcM5K/yPbjmLyur9kTHt7RkmqVKf401x24zHY6LVDEWk5ux
         g938j3MIKmRv9e65kol/2U0fMbciu01LiSoxo04yrvQl1MCPYzKMcpBCAnfCsIUCkDtl
         ttmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p9Pr9vcHIBAGv0RtCZmYZyBzvmoQaEM7VyyaJVVCmuc=;
        b=r7Du8//DCF3X1d5mAlMThJOMotKxTrQZjpOMcNA7NkLuQxCh9AJxB068VcnSf51gkh
         XEw7KNRcfTIgKl/8ODkuMva+zVFHf7OYLxXgBb5mVrTliJewbljOS67hiwjFj+7m8OL4
         hjlcdI3bE6nZ1wbk809ZJr9SSZX7qvWL0cCaqHElyr6VAT91lTCZyr1Uh9nlpgGisZjz
         69NwWrTDvR+UXD1OiQwVQqU+gAQIXl5wNZtWokfginlmwsI+s8i6B9tDHahipfs5dj5h
         uZ0OpOVPp6qYKwNuOIIubKU++40KX0jwxtEGh+Usq4/QUPTJCReGjzVCRjp4tTL4Aldz
         bHdA==
X-Gm-Message-State: ANhLgQ3R2/sn+L0Z+jfOJ5jT+xUjev9w0c1Rn6Xa3FmUkbblBe6W25Mo
        z06Ec1OJ6D+XUBR6uCVzBgg15huo
X-Google-Smtp-Source: ADFU+vvAQXSzqkwV3muFX6kzCV3wMQsf9+N5BNODm3JLQAqf94GdgojydtNYWwV9FjnSVhX79nMs4A==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr25311157wrp.403.1585714670923;
        Tue, 31 Mar 2020 21:17:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3sm1211949wrm.35.2020.03.31.21.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 21:17:50 -0700 (PDT)
Message-Id: <38d4d5a46b1ee4cabe0fafc0eea12542577adf49.1585714667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
        <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 04:17:37 +0000
Subject: [PATCH v5 03/12] dir: fix simple typo in comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index b460211e614..b505ba747bb 100644
--- a/dir.c
+++ b/dir.c
@@ -2174,7 +2174,7 @@ static void add_path_to_appropriate_result_list(struct dir_struct *dir,
  * If 'stop_at_first_file' is specified, 'path_excluded' is returned
  * to signal that a file was found. This is the least significant value that
  * indicates that a file was encountered that does not depend on the order of
- * whether an untracked or exluded path was encountered first.
+ * whether an untracked or excluded path was encountered first.
  *
  * Returns the most significant path_treatment value encountered in the scan.
  * If 'stop_at_first_file' is specified, `path_excluded` is the most
-- 
gitgitgadget

