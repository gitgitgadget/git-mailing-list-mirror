Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8D9C433FE
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0812523108
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgLFEFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 23:05:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51277 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLFEFv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 23:05:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id v14so8607631wml.1
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 20:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ryQpPExquUBq583kIRwvMOxUA4LGKZHQxIo9/ZDyZHM=;
        b=g3Ec82JScVRMwiJgCvupoNA+GUI8Yw7vQNijJCt/Ptj5a0nLQYOFlcD4phNCZrY42Z
         WZkJ2u0NlKzbeO7+j+ZMhvkDAejI0fc/9aquUluEiK3OPh70HJjXUj5c6tqqcUS5i17H
         qmqxcfTTkpa4Pb1iIizBmDa+A8qVWbix2DD5aeRrTNGbNNmpwexFY0YzxNgc+YSCRgId
         WfnpSqsoSb1A30GnX081MHGUPVEcf91+VdSmRZ4vXPaJDq/y8oUgK0x1iK50Dzk05+ky
         rHEV6u5q+0D7CJzZjzXg4qFxtXixY68HcPWCm3rMXZD+B8iylqLlO7Tz8zJx/aRwgXI7
         yCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ryQpPExquUBq583kIRwvMOxUA4LGKZHQxIo9/ZDyZHM=;
        b=WbiyBeC0dw9wDWtYCfluhJ6F//uLgjF5DUsX896/dciY7RUFWv94faUWALg3bQuVwn
         kEowpAX7XWrj94SVOtNe5xk5VUo4p002f2h2r60EILY2l9VGQa7FAUsZzeRuwBDPRoLo
         o5JALm7vOZ2TB9o7fMvxs7RZKAdHEQ8hwO1R5L3iPxuXLnEm44tj5+WvAFzMQrKP14jO
         d4UiQ7VuznOzCC1fykytQd+KBETcT+ev270CHppAnfO9cztDlkZQJiC5xU+G7NvF2o2u
         NzDCd8EGdJAFTEq5ZNNaEWT+TzfKZBUVke80EClkBgvKyOvLk8hILPzYb7B2mLQcL7GK
         HmKg==
X-Gm-Message-State: AOAM531Dys5E5Dg/pRWxb2y+mNAMkye0OMBAOgfLB7iZ9vZf2ToGmqNt
        bpa91mmO2KiveapKIZLS9UJOFtouuBQ=
X-Google-Smtp-Source: ABdhPJwRr3s/Pr+RMUqLf3hDE1Jk3WkXH/fzWIYowaKkcYMucQegixmXtL/0qgqEueNRY5grET2byw==
X-Received: by 2002:a1c:bc88:: with SMTP id m130mr11883992wmf.82.1607223280569;
        Sat, 05 Dec 2020 18:54:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 35sm9181552wro.71.2020.12.05.18.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 18:54:40 -0800 (PST)
Message-Id: <f96bb36930a6e5e42f0d3b9c5dfa3b2cc27c1f9d.1607223276.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Dec 2020 02:54:31 +0000
Subject: [PATCH 2/7] diffcore-rename: remove unnecessary if-clause
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

diffcore-rename had two different checks of the form

    if ((a < limit || b < limit) &&
        a * b <= limit * limit)

Since these are all non-negative integers, this can be simplified to

    if (a * b <= limit * limit)

The only advantage of the former would be in avoiding a couple
multiplications in the rare case that both a and b are BOTH very large.
I see no reason for such an optimization given that this code is not in
any kind of loop.  Prefer code simplicity here and change to the latter
form.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 68ddf51a2a1..0f8fce9293e 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -450,9 +450,8 @@ static int too_many_rename_candidates(int num_targets, int num_sources,
 	 */
 	if (rename_limit <= 0)
 		rename_limit = 32767;
-	if ((num_targets <= rename_limit || num_sources <= rename_limit) &&
-	    ((uint64_t)num_targets * (uint64_t)num_sources
-	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
+	if ((uint64_t)num_targets * (uint64_t)num_sources
+	    <= (uint64_t)rename_limit * (uint64_t)rename_limit)
 		return 0;
 
 	options->needed_rename_limit =
@@ -468,9 +467,8 @@ static int too_many_rename_candidates(int num_targets, int num_sources,
 			continue;
 		limited_sources++;
 	}
-	if ((num_targets <= rename_limit || limited_sources <= rename_limit) &&
-	    ((uint64_t)num_targets * (uint64_t)limited_sources
-	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
+	if ((uint64_t)num_targets * (uint64_t)limited_sources
+	    <= (uint64_t)rename_limit * (uint64_t)rename_limit)
 		return 2;
 	return 1;
 }
-- 
gitgitgadget

