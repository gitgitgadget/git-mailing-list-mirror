Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65514C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 18:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJLSwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJLSwg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 14:52:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DDFE070C
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 11:52:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so27542359wrr.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 11:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTLoZaZ6n+Wz/7kdysCOtNZST9K2cELlvFYvnhYh5CM=;
        b=KPPdok5zjzNPtRh6FyTkBUyfMPtVXUNLtyHcLvEGnBvuFyvFINonzessWq7UO8lnnK
         Okqp18ZF+kZ15bitfYBrkU4hmFF36V5OziYPAoI+KntxPgSHJD6SIXI2psVcVjySEx+D
         B0SKffZ97HshKHbDNItjXFtePnDiXoly2QO9GsS6K5YldDQuKJvDM8Uy4b+VtAGmYpY2
         ojxpGep1dDaqkFxq4Z8chAB+AFamcn5asDHQKsnPs8PQ3VOaz+qVud4kFepQ+UmXZO8q
         ZGYSDCUTsHW1Bs1e+DlbK+nk1ZwCqq16OH6epNPs3bT3eclvGQi1xs+AOwJF6cwZVXA4
         wU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTLoZaZ6n+Wz/7kdysCOtNZST9K2cELlvFYvnhYh5CM=;
        b=qUSphNkLoXIrLVyRf7aMnwMO1Dwb8uO61XtBsDXZNAZxO2+gDsiM+xg2fBcA8Ry2vH
         QvydP9myGK+lu0VcZXaA2jddrIbRCCPlADHkoinjbYqAVXWLk40byS2hThUMOMVRAvFO
         5yY4DnLtpnO9S0Eaef5yrqSVmPTiT240gXz2ZUhYdk6fOtrcBNVPtE826rGa/Khq74PC
         Q77F9gCUUZM77mY6S+Ob3f8KbPRqd1Ud73xpi3VfklqmvnE8MoCgNe5/N6W6k4wbPoem
         HVeBgFwgOKPlQ1w5tlwJpiGulSuWComv0sPoLUNs2yDrrxlk6gdCmmhm8NqsBoTQZQS3
         H07A==
X-Gm-Message-State: ACrzQf33OVJUNNo57ZkGMNRn0+4PQ+SDtkPFvLSsI3V4CuxlQU0/qWeN
        pLZODNdMoyGBhcdKd95TLYXuGl6N7/k=
X-Google-Smtp-Source: AMsMyM4WGTHXiwo0y4RtwEWRHasaw6GS8LPZpqwQgY1alkxvMQwqj8JPyBmWjN8dmVTg4KpaIFPI7Q==
X-Received: by 2002:a5d:43c8:0:b0:22e:632a:9bbf with SMTP id v8-20020a5d43c8000000b0022e632a9bbfmr18553851wrr.481.1665600753234;
        Wed, 12 Oct 2022 11:52:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9-20020adfe709000000b0022add371ed2sm338956wrm.55.2022.10.12.11.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:52:32 -0700 (PDT)
Message-Id: <6e7e4f3187e2fbbbb54bb1cf5793bf6e981a5a94.1665600750.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
        <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 18:52:24 +0000
Subject: [PATCH v2 1/7] trace2: use size_t alloc,nr_open_regions in
 tr2tls_thread_ctx
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use "size_t" rather than "int" for the "alloc" and "nr_open_regions"
fields in the "tr2tls_thread_ctx".  These are used by ALLOC_GROW().

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index b1e327a928e..a90bd639d48 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -11,8 +11,8 @@
 struct tr2tls_thread_ctx {
 	struct strbuf thread_name;
 	uint64_t *array_us_start;
-	int alloc;
-	int nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
+	size_t alloc;
+	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
 	int thread_id;
 };
 
-- 
gitgitgadget

