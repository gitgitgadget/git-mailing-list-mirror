Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51479C47097
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 04:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3880B6140C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 04:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFDEmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 00:42:44 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:51901 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhFDEmn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 00:42:43 -0400
Received: by mail-wm1-f53.google.com with SMTP id r13so4592837wmq.1
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 21:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VU00cywIlwLeCBDcEnqZW2ZnRbOIBvFkVNGp2zvI9ko=;
        b=ErBALFMCTfhG8aMAIZQ9unsPgMjN7dgqmfihFyAGGzo4ggFyYqFwud4eaV2bn6owpu
         0nkEMGTdIXSrXdtdajqxjNQr1X4jyD3+Etkt0BS579Ue/wgpf03HphzOdjwIJvjjasjg
         zOKraEg/DEois0Mp9ZHfMc2pmJoWeVrHqB+7m0pLg+bLHsdzt6ewFs6bFop3a9RtOWo8
         UK55Y5e1qFYvWlEwuNR1GpEjPS7Jelf/W3KRqJ1ppqTSaSyjvEWqz1HBRoeULFNcTHJa
         8VYiqyXs/IGE9zEpXzAXDyW8GJMP8g8fPOty9fQ68HNgKbGXRm/kVTGiG7BKvytMj642
         n0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VU00cywIlwLeCBDcEnqZW2ZnRbOIBvFkVNGp2zvI9ko=;
        b=Qpf453ArijL5SHzodWpTnbMIpWOa9H/yHKFAyGJACvFrDq7MUrdOkiiNGe/uRXj+20
         543Bt+LwKApNsErkt+iYxWvdXZ5FZOPKoth4iyrsTwGY2qW/LF3wFQ0Mp/zbpdd6+yVo
         EnDA9FGb3K6I9Lq3h9cIPJttYf0FoZv0vznV1Uvi0MppNodHxGZECzVonpz1EPb+M8uX
         xzKr8rJ0jhBgcgYn5WWK6JqRBavamg4FfnC5j3+1euuJ8e9oUxaH6p9Dw8yMozfl4WSi
         LHM+6kv/T3H0ycw1FBPzPOjahOSExFYAtX3fgsQm/aOh/y3EeBqEREb13LrqqyJWCL8d
         o6Yg==
X-Gm-Message-State: AOAM531eBW/Oy1of2g113Z2iykygo47BUCmOQ/+xCkWliZDXmYm9Z18e
        Dlph1pLTdvlDm5hUCyLB3uyqk8v7U6Y=
X-Google-Smtp-Source: ABdhPJxVMjyGd869e/6LAaGcRhhM2Ve1+L6/iVPYiAtPwDTYn7MbiWb+WfkOpE5rjG2ph2dMGH06/g==
X-Received: by 2002:a7b:c761:: with SMTP id x1mr1599511wmk.118.1622781581224;
        Thu, 03 Jun 2021 21:39:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6sm5450851wrf.51.2021.06.03.21.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 21:39:40 -0700 (PDT)
Message-Id: <cd13499a6ff5f9ac2287d18ff00d8f7d1690bb6c.1622781578.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
References: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
        <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Jun 2021 04:39:36 +0000
Subject: [PATCH v3 2/4] diffcore-rename: avoid unnecessary strdup'ing in
 break_idx
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The keys of break_idx are strings from the diff_filepairs of
diff_queued_diff.  break_idx is only used in location_rename_dst(), and
that usage is always before any free'ing of the pairs (and thus the
strings in the pairs).  As such, there is no need to strdup these keys;
we can just reuse the existing strings as-is.

The merge logic doesn't make use of break detection, so this does not
affect the performance of any of my testcases.  It was just a minor
unrelated optimization noted in passing while looking at the code.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Derrick Stolee <dstolee@microsoft.com>
---
 diffcore-rename.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3375e24659ea..e333a6d64791 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -54,7 +54,7 @@ static void register_rename_src(struct diff_filepair *p)
 	if (p->broken_pair) {
 		if (!break_idx) {
 			break_idx = xmalloc(sizeof(*break_idx));
-			strintmap_init(break_idx, -1);
+			strintmap_init_with_options(break_idx, -1, NULL, 0);
 		}
 		strintmap_set(break_idx, p->one->path, rename_dst_nr);
 	}
-- 
gitgitgadget

