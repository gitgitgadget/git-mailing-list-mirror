Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DADCC2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 22:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D2C206D5
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 22:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRarUl44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgA2WDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:03:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37011 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgA2WDt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 17:03:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so1416801wru.4
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 14:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9gJy8rO8rX3RtYiNe+N6NAtJQNv32fz37U/5D9/Csog=;
        b=bRarUl44iOptLWY4ChH6DQH1AAaTIy3n4YXAKZuy4VA15hcKCOfdSp2BuoYsIReicT
         HDfL7Z0kzbaJCIQPKqdkG+74tb7HHjoIBI+ZAnAvlHa3Vd1CfjUI+RVOOtRQV+LWQ5LQ
         PIg3EtXYv5ixB9k2jCgk9xx6fED+7iDD1Nt6AOOMDmZMf7w3aSRsVdeZhtHi3jmyZDZq
         4HoUt3Qt/AVfbwIf1s43FfsEaiDynbbYycmTGL52DGGviTe2kL0C65YhLJ4hL3I3YDhC
         NNKe1rovzal4h1+3XNOi+6QYxK/whqibixVutmjSCySAvWJFR4htlBy3nO6xWU4IWpml
         Jdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9gJy8rO8rX3RtYiNe+N6NAtJQNv32fz37U/5D9/Csog=;
        b=Dfk14agYuohdhrnP6GEKuBcq6jLNCiWURqpOzdVttXkeXjFWcySleuopDFSWw4ZnrP
         mA1N0QtUraliuIgGwWqyLaJWpT48QhlhFHqrMglc/dGDkjT2CeNEGI1EJpDK0+0IIzKV
         FWMC1wisAOQUJ5C44AB2KZPbvOFo1AM+eNC+VcSj/sC217Nv+jEpMxV0Hz976OEOEkl4
         JhZvqFTHaemupNk9by63QjqbtRJfBdDwzMy5b3D1tjMovVGIGPOZfqaWyGuZROrWovWU
         dfUh7a07nMDLHL63LJ9Xf8Tjs6J5UfSPPOHtBOJxO0+/bTQryKtkUjVuylhsXWj4mwBo
         XSIQ==
X-Gm-Message-State: APjAAAW3icXOU3Ke5hS1ZsaRJU3pCzXboo804hy07A6c8GSp3cr60zaq
        kLenMBZJiQQxWp8WycB770j4+33G
X-Google-Smtp-Source: APXvYqx/imBl1nW9t1IOyoN09dRxiaVTEnhtBPR4eCUU/2STB6xk65o7Ct5NH/yYSjhJ/P/R2kmPgg==
X-Received: by 2002:a5d:488c:: with SMTP id g12mr1041237wrq.67.1580335427167;
        Wed, 29 Jan 2020 14:03:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1sm4510986wrr.80.2020.01.29.14.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 14:03:46 -0800 (PST)
Message-Id: <2ceb64ae61eccd662922f6156e00d4044bef515c.1580335424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jan 2020 22:03:39 +0000
Subject: [PATCH 2/6] dir: fix broken comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
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
index 68c56aeddb..c358158f55 100644
--- a/dir.c
+++ b/dir.c
@@ -2259,7 +2259,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 					add_untracked(untracked, path.buf + baselen);
 				break;
 			}
-			/* skip the dir_add_* part */
+			/* skip the add_path_to_appropriate_result_list() */
 			continue;
 		}
 
-- 
gitgitgadget

