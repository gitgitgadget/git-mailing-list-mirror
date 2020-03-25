Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAD8C2D0E8
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8696C20740
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO1w9z/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgCYTcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:32:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33052 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgCYTcF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 15:32:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id z65so4103198ede.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ip1sdkCAke+L9RTot1ew8WG61s7QEX3alK/LLGEt0Fk=;
        b=lO1w9z/6FDRRhLtNgNyU0UUJ5mCuegH9Lwt9PzfuD+KyewcPUUXqHi+tS29+AdN+hR
         tn67KKRQgCgX/Qvg1jH9a4pUPuteIHvi/WHn9Xzqa78rwv0+Wa34Nup1f84mrKHXHHfo
         Er+Q5LRcNnUhbM5oDPPzakWEqe3a4Vhsy3L3GAbgskipgRsGs7ZNtSTfxM+oNHNdtbl8
         ENmN/1obgzrDijh9VphQUMkumIeyobokOTj+lp/V1bHzSouLT2pZtvoNbdV8xcMYO6n1
         TrZQ01xZwSN0AZqcIGOUvMKg6N+3NUAE/n6a2lDgUl8zJmFMIF37l7R2J+yYcvmz3X/k
         bv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ip1sdkCAke+L9RTot1ew8WG61s7QEX3alK/LLGEt0Fk=;
        b=drubRhwGStStmYN08RTXr2E8Lp+FqXpTr3l9E4hXaThpUD+nzbfqj6MPomN14Lzmer
         cnprfeb7womNCoZKr4HXoMVDlw04wAUDB9/2RhOgYGF9bVIMIOCsj2Df0CNSk+o2Y+7H
         CyOS6YDvP3Djg6OZ6AAdlbQtHgBjfnYMAxiSuMLvAhJcezjrj0sTOWv18f/pcyHtnkk8
         65VC01y3c0sUaixyvDtcJKOInHe1LD21oXS67wYKkjMiRxbN/7t0IbcKiRk4hoH5dS+I
         mceHaOQEK9yd6sHiYDOqR6dyTXsY76U+a8+K4q/BmHIPSSf9pSnp3RQmyldf8yJkRGlm
         B0bg==
X-Gm-Message-State: ANhLgQ3eFa36lx+HTznFjsudQ9LKLgFaXx1Vp8LM+B5JyU/YRevfmtYy
        wzDWd5KLtmCsno4TN6LEVm2McpvI
X-Google-Smtp-Source: ADFU+vs2WF84bEK1OZHE7bNdhH3wBdKSgJX8S39geqSCG18J9UPCWa9AbI7oiMbyQFp0MAJl+zaslw==
X-Received: by 2002:a17:906:71b:: with SMTP id y27mr4713469ejb.366.1585164722469;
        Wed, 25 Mar 2020 12:32:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y62sm1721295ede.5.2020.03.25.12.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:32:02 -0700 (PDT)
Message-Id: <02e652d1869b6ed48ab363316d0f676474d57c4a.1585164718.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
References: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
        <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 19:31:54 +0000
Subject: [PATCH v3 4/7] dir: fix broken comment
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
index d0f3d660850..3a367683661 100644
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

