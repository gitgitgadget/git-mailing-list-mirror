Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C346C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5FE220789
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX44Ttqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgKXVE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgKXVEz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 16:04:55 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489D9C061A4D
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 13:04:55 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y16so23674254ljk.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 13:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DUdSd6pQs4jmskCyVGNyzDYV2RBm7j5o4x+7rAAh1I=;
        b=kX44TtqcgLvzLnbeK1ONwIVMbsdYysSjMzcgdzWxtOR6vyg11/mCT+5FIvZ8ZOGR5T
         gJGFPLE2hq52250MMf2Uhg+EmYSlWb6ROhqBbdAhD8wDyJZOJy5BVACaSyjA0j8JcbRF
         Bv0akRa1CBMQCzox2OuPGTnrlcrEa+dahvtYxjjvpByaR4fZRuYx5ib6Us/7K6+d1Mw1
         9MsgPwJfDaMVKvhYcbsy40P9fJQER2NzSXFUDujX8/mtWXG2/ypjS+isARuzy9ogRsMu
         eEcpMTDtvhcAYSdYwV3gHefWC55sFOwylgx5Qerw60rO6tQIacPQivAGOxvvFtbgbFoj
         TmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DUdSd6pQs4jmskCyVGNyzDYV2RBm7j5o4x+7rAAh1I=;
        b=bedTyTNwacpA2G1cLu+jXKkY/s6ACDDmLLjAehSt1rbrd/f5xK9F52QvFttk6qyX0H
         aoWO8PgHIqC0BwvnETGU/9WH4qsLTga7aHcY/aBhr9KtqUr7g3ZpMtFBUDJ33FqktPhJ
         YFVfmLXrgNPFHWlHvj7uM3tpmICom6nXjCy9QqUP5UfJtwWssu8xncv5MCQAc6fFK71J
         u1hTpohYEqflVKi8KJHOXyFDVufxUeERKJNwf6rZBiEvkzJCslkytXp2F8PkBnVkvWOX
         cVx6zoUqHyqYDgRN1HMHKgXs+okjDpt1Y+orsMhEa+dt7Sp+YqOPTsckxeuHwQpM9o6D
         kkMg==
X-Gm-Message-State: AOAM5307QdIi8nrsBXZtS0c5R5+drE1BYCWTMFIIJzIs/bJVGxMbfC/O
        ruQYNrSaKZ3RHd+S2v0wZsZvU62bvhzZBw==
X-Google-Smtp-Source: ABdhPJzkTxf4rWv3sj5bVx4w6x1jGPIx23lSkmX3s6Ks4VJJaWytIx+kbiUmU/mcnjeoKEUeylOVmA==
X-Received: by 2002:a2e:81cf:: with SMTP id s15mr53398ljg.459.1606251893527;
        Tue, 24 Nov 2020 13:04:53 -0800 (PST)
Received: from localhost.localdomain (h-79-136-116-123.NA.cust.bahnhof.se. [79.136.116.123])
        by smtp.gmail.com with ESMTPSA id z20sm22911ljm.138.2020.11.24.13.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:04:53 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 4/4] MyFirstObjectWalk: drop `init_walken_defaults()`
Date:   Tue, 24 Nov 2020 22:04:16 +0100
Message-Id: <c2af3639239329675f61bb06380fdc77d0d4eb3b.1606251358.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2
In-Reply-To: <cover.1606251357.git.martin.agren@gmail.com>
References: <cover.1605972564.git.martin.agren@gmail.com> <cover.1606251357.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a recent commit, we stopped calling `init_grep_defaults()` from this
function. Thus, by the end of the tutorial, we still haven't added any
contents to this function. Let's remove it for simplicity.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 7f4bffc4dd..2d10eea7a9 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -182,30 +182,6 @@ its `init_log_defaults()` sets its own state (`decoration_style`) and asks
 `grep` and `diff` to initialize themselves by calling each of their
 initialization functions.
 
-For our first example within `git walken`, we don't intend to use any other
-components within Git, and we don't have any configuration to do.  However, we
-may want to add some later, so for now, we can add an empty placeholder. Create
-a new function in `builtin/walken.c`:
-
-----
-static void init_walken_defaults(void)
-{
-	/*
-	 * We don't actually need the same components `git log` does; leave this
-	 * empty for now.
-	 */
-}
-----
-
-Make sure to add a line invoking it inside of `cmd_walken()`.
-
-----
-int cmd_walken(int argc, const char **argv, const char *prefix)
-{
-	init_walken_defaults();
-}
-----
-
 ==== Configuring From `.gitconfig`
 
 Next, we should have a look at any relevant configuration settings (i.e.,
-- 
2.29.2.454.gaff20da3a2

