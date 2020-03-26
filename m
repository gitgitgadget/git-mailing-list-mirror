Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE50C2D0ED
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E192D20722
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LytDxeZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgCZV1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:27:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35016 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCZV1r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 17:27:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20so8740031edj.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ip1sdkCAke+L9RTot1ew8WG61s7QEX3alK/LLGEt0Fk=;
        b=LytDxeZFrUPMIRK0eZbLnSX0a3aKsEkML949NS+giPsNNaahqWRerMbqUbLSTLc/6n
         rf41UQar2XtB25GuR1Lom+ltPtDPtSeLbxqSOJjGR+IVs1QoRGYEj6xe4pafVbNbtvUn
         BwByflbHaSwXFqZuFuYwk1Ku50Q/E8mnaiLQSWxeNZxuqb6+++QA4rWf4LkB2OlMM3I9
         DbaCZsqlJ6ackU9kr0KS5xHs8MSBwYCZo64NEv/g+6Ysmo4gfbLX07B7kiZDMvjzgJPc
         /F9ksMaDE6wR+G1U3rGS7cCh5EMTu0I8Vl+wCosciVclLON5TSv2XDgKf2VlbaxodoEA
         uM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ip1sdkCAke+L9RTot1ew8WG61s7QEX3alK/LLGEt0Fk=;
        b=rdSii8bsgxiCqftAX1JHD2Bie+6MeMlVU1br64BGEepqn7l4zqSeWyhL9a0XEo5H10
         XIvJZdXne15yBuQ81YjzCYLSP1URHxOTqTq+HL1cjLrwrzIjPntswEqHBifFyqHTFzBo
         RoKAO14bHfk5D2l96INFibToPJENOgRY1rFnEsb4AGPjUIWsIBUtF1u67/4BC9tbqVRN
         imGlHYEDz02gOw4BCEQazsmo44nV9rj0C1gdwpIL+mwffuHvhw+L7WTWe5WnfnY7mRHu
         YLHEDg1GIrROHHHCGPzKSjd4jTAZhET1kaZNZLklJe8RCENUW6eHLlosTdZoiB+9frbn
         yw6A==
X-Gm-Message-State: ANhLgQ13hY2wI/TEnhPoBwcUVZpYl/d9yz4VCBYPLvilSMG1WT/bCAtU
        7J8DeaCyIL1ZRhfyYMMFE9ND/v6t
X-Google-Smtp-Source: ADFU+vtmVUl9PawTvVQQoPoigFsOQoH1fcTuMLpBgOib2HYqSuHc64FTT76hL+3Bh57mnKhpNpF6JQ==
X-Received: by 2002:a17:906:2cd1:: with SMTP id r17mr9974315ejr.280.1585258066027;
        Thu, 26 Mar 2020 14:27:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u29sm523960edd.47.2020.03.26.14.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 14:27:45 -0700 (PDT)
Message-Id: <b5ad1939379a7cc6727fe5fdab3210a60cb56542.1585258061.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
References: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
        <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Mar 2020 21:27:37 +0000
Subject: [PATCH v4 4/7] dir: fix broken comment
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

