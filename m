Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D4C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbhLGUXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241179AbhLGUXr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:23:47 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9B1C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:20:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d24so253719wra.0
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Dx/Z/0JJSdb9jiXU9QHXS7LmKrOPgM8MWB76VKSSA1M=;
        b=FWFN2OLpuDl7O58iEfimYv7NXXTezUXYLMoUoSRGCY1HSLTHgXME2w2018418PJTwy
         kSJvruwoIXXO/xU1jifEEC2MAu+lU9RDswVdsR80UFTO/WELDGwuxPTngMrUxFXev7j9
         5lQghsR8Xri7bV0X58ruKglyPEDRWFelnNH80g0kVJCf4GoyvZHS5VOpl2zBlSotNQm9
         ucw1TqO7m7Jz1XjkCFOvw+Zj31+MR57le70Ijj/93X40cvLA+cUCSMW5TN8VAW/hI95K
         NAGS1lPORZH8bkn4Lo0vTaUbPcXhvnNqGCh6zL/R79vV6ePw2PFqz9EgYOzf1EkRW1m/
         /1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Dx/Z/0JJSdb9jiXU9QHXS7LmKrOPgM8MWB76VKSSA1M=;
        b=RugX/AdL1Bvno8hVO0iNi0dTUcQAVeuTYN+d1E47r9XIZmyetL8T0sztr1mlkAqU2z
         UByChw/CfW5vFDb2c3wuuZ2azDi0mEK4wM1KrBDbA99iPjduaRZhZhYLBTvcmq6UsL8T
         EgUAGkF1D1sjuTZOdpOo/DQDUOrk59cAtu9lFnZAvQk0mE0O2W5jZST8sS/oXqxB0nsu
         t0jULqU9KKXBhb2EACxAP/dwT+ufU6Ix3zlPpb/EVjMecBTvMtYSVQnGM9D4IqnMIVHE
         UP3MBtqRWEHl782rNBwOYerspT0amjKf5UDXDIbHgIih8zH7UB7PClLj99HLB5jlt2Tp
         X7pQ==
X-Gm-Message-State: AOAM530yb/kF7BwIJpjSqtks42dds455wtQ026RRA6uq8kxwsCYRPVGB
        2uCC5L8zbB/FTqmb6kezHGHtc/678Ig=
X-Google-Smtp-Source: ABdhPJy265mGtDPT7KEROzzAMxEXntckOhKyk7yjzIbh15J46YEXtznYxhV25tVy3W1IiJePvFlWBQ==
X-Received: by 2002:adf:cd89:: with SMTP id q9mr54056593wrj.205.1638908415167;
        Tue, 07 Dec 2021 12:20:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm748317wrh.54.2021.12.07.12.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:20:14 -0800 (PST)
Message-Id: <0180bfc4a93107750799457725d4e64fb5ff5874.1638908410.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
        <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:20:04 +0000
Subject: [PATCH v2 04/10] sparse-checkout: disallow --no-stdin as an argument
 to set
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We intentionally added --stdin as an option to `sparse-checkout set`,
but didn't intend for --no-stdin to be permitted as well.

Reported-by: Victoria Dye <vdye@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index e9f644ac362..0ee28f48134 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -699,8 +699,9 @@ static struct sparse_checkout_set_opts {
 static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_set_options[] = {
-		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
-			 N_("read patterns from standard in")),
+		OPT_BOOL_F(0, "stdin", &set_opts.use_stdin,
+			   N_("read patterns from standard in"),
+			   PARSE_OPT_NONEG),
 		OPT_END(),
 	};
 
-- 
gitgitgadget

