Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8F82208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeHHR3B (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:29:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37425 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeHHR3B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:29:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so1436058eds.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2nDuFhYq6xBuXc5AJJ7xL/44Ppj7a46lSUOWHESOLE0=;
        b=QHIXOEV7WiZSrFxT5myYlPEMTjv056RSNJ8x17/jtFQwCYsJTNWreWBxZJ994kjb/U
         dMFMNcfiXILaUBB+QNAyUUFxK0uoDd+pe7LpnzE1uXCg//r5NLvaqlYkxAQ25o4AUL/5
         FdlxoyQecN4GtJdS341rNFa3EemxjgYGwxW298YNJwUUJsrYsIzYUsiYm8viiW9QDYv/
         3RgEjKfwrxxM1G+gP+FuEgDOxiI7KfS/TsrSfDKCuL4arKsaxnJJT2vPVPGVGCxNThUL
         XmEB7vfM8XXqnY7DAj0uD2OTdj59NcmTVR0J1cT/LMP0QHeCvuqQ60DSuRZdpGoy1nDG
         3lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2nDuFhYq6xBuXc5AJJ7xL/44Ppj7a46lSUOWHESOLE0=;
        b=VQpNY9tjCe7qru3sShwcrJ2mO4zeeWy9qzzBQCzLy2diiMGfkuc2E6OKLjA2rV2y0L
         Eo5FUqwJqUllQJ97uaFOI8nIQ2tUOc5n6AVDX3gx+CIac+pyi90uHrUB2361954C2rPz
         65H20ok5wxVtwMKotrfcskGP0mngwDrI9cYKE0n+Nh2z3/mY6ZXplAuceyxO9RJhxL12
         oR3a6M8igUqWZbt8L2NOejUv0IVyBaMDp/kA7VpUde0yFSNiTpneDvXizPCDdLWtnuo6
         Dfj5u4TkhpGl8RP3UlbFTAN7TmKNtsh1mWoLS6BxnsOO+H/+COPytWtLoaeSVMQt+8XR
         JHhQ==
X-Gm-Message-State: AOUpUlENR5hqo9HtSdRWeDsd7dLWVlUd+hjiaYwXHJJTMEZKzLowAzar
        TZL9cfJm+2MOkjw4pWa3lOoDkey9
X-Google-Smtp-Source: AA+uWPzBZtzJhziFsguGhTaffvRgtcICLvGglfaaonfyfNkltwqRu80E+Y8aXv+at8wxvTrUAoKXIA==
X-Received: by 2002:a50:dd4b:: with SMTP id u11-v6mr3841743edk.298.1533740936000;
        Wed, 08 Aug 2018 08:08:56 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id w1-v6sm6771259eda.63.2018.08.08.08.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:08:55 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 6/7] builtin rebase: actions require a rebase in progress
Date:   Wed,  8 Aug 2018 20:51:21 +0545
Message-Id: <20180808150622.9614-7-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808150622.9614-1-predatoramigo@gmail.com>
References: <20180808150622.9614-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit prevents actions (such as --continue, --skip) from running
when there is no rebase in progress.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e3dd2f511e..1344e071f3 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -577,6 +577,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	if (action != NO_ACTION && !in_progress)
+		die(_("No rebase in progress?"));
+
 	if (action == ACTION_EDIT_TODO && !is_interactive(&options))
 		die(_("The --edit-todo action can only be used during "
 		      "interactive rebase."));
-- 
2.18.0

