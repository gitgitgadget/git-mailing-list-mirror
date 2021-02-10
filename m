Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634D9C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231B464E40
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhBJLmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhBJLkO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 06:40:14 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4406C06178A
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:09 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g3so1063567plp.2
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vB/vp16qXROfq3bntBD1qroyPdmfkJY699iQWDu/g2A=;
        b=nv0yY5YGf/W4WsNiIXvBqYXqUmUANOhXgVUHbRbZBa1toSF5f0keQlA/NywIiRoqpt
         HHGBOj3ENPOdfUfqBqtxqm6d5wg5DLcGIf3I9XaX/CC47qsgj18R9gGNZV9ZgZQo/Z74
         xmnK7VEuhCROo7xVxo6+bN2ji1MX7PjypeAiBUSBjNzBuU07tI3wbZ23NuUMBjRYwxbF
         prF1NznZNXuetT798KE/xwbYTiJ9LUJeCgVQeuvFi9X/SU4PUW4K+PFXB8v8YsqmH6X1
         +w9fM+yCxiqiy06dla6SCfKCYpfyleVMwaAjhkVp0vE2jQkwMog1MXEN7wso4kX8Gt0N
         hlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vB/vp16qXROfq3bntBD1qroyPdmfkJY699iQWDu/g2A=;
        b=DCBZzmCUbfWcSO2cPFfNTZOyrjV+oMJlwI25OYtBWuhfFSOrXFM1/lbPOtGF7GtYn5
         arb2KPDK0Rc4qEYYmKGFV+gSLu7ytrEzX/vqVSviFq2uj54ldxaSZC/xbmxfEp99xQ68
         T5qqO36pxEHwqQPDMnnTo49JHkVPpzJ7qEpdR/I5QwuDL1KHYqWMiXDXYeuMiXy4f4xK
         v5g2zFj6oWZuPqPnYexBOmxeLA553y4QKPbb6NqrNF+CuTimjdKVXk3f5UVR5k2gNdzv
         luj83jvQFi0uoBkggMp16x7LB+fQrDYUXwjwh32zu4GSkEtyYcGf+FdE1GfgYJrqpVjf
         HUTg==
X-Gm-Message-State: AOAM530iFDTQy94Mt7MzkSZqmtWBbHpQrTlKpbVhUeNj5/3NAGi35Csj
        5Z1SOGJQ/QtJCq8xcFPXIIxMKkv1F96lTg==
X-Google-Smtp-Source: ABdhPJxFlPHsYHHzDJOnitHSnIRsPPRSfRSZ7jB/yJ7wRMsnw8cFSW6y6OZYYTFPx0byIOy8mR2RYw==
X-Received: by 2002:a17:90a:4287:: with SMTP id p7mr2745751pjg.226.1612957089141;
        Wed, 10 Feb 2021 03:38:09 -0800 (PST)
Received: from localhost.localdomain ([171.76.0.223])
        by smtp.googlemail.com with ESMTPSA id y3sm2123731pfr.125.2021.02.10.03.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:38:08 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 03/11] rebase -i: clarify and fix 'fixup -c' rebase-todo help
Date:   Wed, 10 Feb 2021 17:06:43 +0530
Message-Id: <20210210113650.19715-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `-c` says "edit the commit message" it's not clear what will be
edited. The original's commit message or the replacement's message or a
combination of the two. Word it such that it states more precisely what
exactly will be edited. While at it, also drop the jarring period and
capitalization, neither of which is otherwise present in the message.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 rebase-interactive.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index c3bd02adee..b6cbd16a17 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -44,9 +44,10 @@ void append_todo_help(int command_count,
 "r, reword <commit> = use commit, but edit the commit message\n"
 "e, edit <commit> = use commit, but stop for amending\n"
 "s, squash <commit> = use commit, but meld into previous commit\n"
-"f, fixup [-C | -c] <commit> = like \"squash\", but discard this\n"
-"                   commit's log message. Use -C to replace with this\n"
-"                   commit message or -c to edit the commit message\n"
+"f, fixup [-C | -c] <commit> = like \"squash\" but keep only the previous\n"
+"                   commit's log message, unless -C is used, in which case\n"
+"                   keep only this commit's message; -c is same as -C but\n"
+"                   opens the editor\n"
 "x, exec <command> = run command (the rest of the line) using shell\n"
 "b, break = stop here (continue rebase later with 'git rebase --continue')\n"
 "d, drop <commit> = remove commit\n"
@@ -55,7 +56,7 @@ void append_todo_help(int command_count,
 "m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]\n"
 ".       create a merge commit using the original merge commit's\n"
 ".       message (or the oneline, if no original merge commit was\n"
-".       specified). Use -c <commit> to reword the commit message.\n"
+".       specified); use -c <commit> to reword the commit message\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
 	unsigned edit_todo = !(shortrevisions && shortonto);
-- 
2.29.0.rc1

