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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E796C4361A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D890064F73
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhCQU5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhCQU44 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C18C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g25so2304097wmh.0
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1DFlMB63W4F/A/eg4m30Yw+Qeg6+PBNVZ8sDqRX8T7g=;
        b=F8iqGiUG+FZFUphsAtoPOswVkOfE5MOoCLYrgHw/SsTDm1W/wfnWMXAj6q7zK0v392
         a30JN52eDCWEEhltNdm9jJcQIaQ8F4zKwmIuOvTP+fyNxRrMGlOGmtvtfI6GY4XMZztp
         MnMYnSUxXbFTHg+bW1KDI27YmMbDelvP3DBRkzJrnVeDgzoRqLO59VykBY9/6I6phkpm
         eXdRU1s7cGzXXSIUh2KO+y/PRw6gGl6wR9WrVqf8qBvwDoCq0Qt8QHsCwd1CxHzeGowD
         wWo+Gfyaz1j1zK7P9nznL9GtPTBYWJPYbk6P0FDaulbm5xG+Uewo2u+PyfTLJcbmMJ1f
         vWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1DFlMB63W4F/A/eg4m30Yw+Qeg6+PBNVZ8sDqRX8T7g=;
        b=HKd1Hu60kk3A2ujZBnOxLWcXieQ2HSRvyqNZjP7UiyFzqX+j2+YNyaqxvX6jM/yZlK
         cMqeKs92K8nd5RPqlK+ID3EyNq6eXq6sHJwcOQhUh+fo83cCF9Og4LWdLn9hLvuGb3i1
         OJ4hSSuImXYHKA3D0nmtqj8jWvs9GToKpnsPyYiRoq56K0MciboGEAUiiJ3qHSRa275L
         zf3q18HeHXOd9r7xN1VUCyTVWsRrejzEBqE0J1xYZVviEZI8A1/2Z2ZsgBKndPy0Mg9L
         h2KljsB+oD7fIyHe9TKYq3mX5F63WsWKHHooWILESNmKG7LoRk7qYw0LqeHd29fgy1Sp
         U/1g==
X-Gm-Message-State: AOAM530zEqcxApmmm7z/g4aETI3t2bUsMi0bq3ermBaQjX7cxhs3HwFG
        06/Az43WqzQSMuwV3STo4n4cUQ7BvNs=
X-Google-Smtp-Source: ABdhPJy0c6IDnj92RRL5ssZq69PprAgfcs1Ub31yLvBoA85C/gU0aRSOfvzN2wnqatLJLJUkWcy1hQ==
X-Received: by 2002:a05:600c:4f03:: with SMTP id l3mr553654wmq.149.1616014614538;
        Wed, 17 Mar 2021 13:56:54 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:54 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 14/15] sequencer: use the "resolve" strategy without forking
Date:   Wed, 17 Mar 2021 21:49:38 +0100
Message-Id: <20210317204939.17890-15-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the sequencer to invoke the "resolve" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d2332d3e17..ec8e9bda22 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -34,6 +34,7 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "merge-strategies.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -2049,9 +2050,16 @@ static int do_pick_commit(struct repository *r,
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res |= try_merge_command(r, opts->strategy,
-					 opts->xopts_nr, (const char **)opts->xopts,
-					common, oid_to_hex(&head), remotes);
+
+		if (!strcmp(opts->strategy, "resolve")) {
+			repo_read_index(r);
+			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
+		} else {
+			res |= try_merge_command(r, opts->strategy,
+						 opts->xopts_nr, (const char **)opts->xopts,
+						 common, oid_to_hex(&head), remotes);
+		}
+
 		free_commit_list(common);
 		free_commit_list(remotes);
 	}
-- 
2.31.0

