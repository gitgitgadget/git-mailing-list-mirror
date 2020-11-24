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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B457C6379D
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5C02076E
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GciUFFBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbgKXLzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733124AbgKXLzL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 06:55:11 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F6FC061A4D
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:11 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 64so8609761wra.11
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DbtMZQ5t8mR1d5oo1jepHJcMLQ+sOdNLanbj3Vpmc/Y=;
        b=GciUFFBc3ckgVdBwyyyEWMpCxOFyU0JdFPckb+XGz3FfhfJF1LIUmBA0K8erQ/l5z3
         1jTx8uKvK4tZOZ5ZA91x81sYe/h1Rh8hUMQYIUX1Xnum16oOjCWolBbQKWqF5ap5iOdk
         SuNHmtfIiI8HCceOBJGEcuPTtGUXXnV8sGlnwGhumqq6Gt09IgGNnTPJj9sSTpcNAFB1
         IwX3NaAhf3PNTBMdwRN+WptgJmfjCDrwZAeWelSu2cYtSIENt+SNrwI+bEWMeO77H1PX
         CnE/QSSaVlXkgFApg9QBqPvy4hXNO3mpA5T7Ia8a8s0bn1uouTwdHWt2VJQdd60cevea
         wvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DbtMZQ5t8mR1d5oo1jepHJcMLQ+sOdNLanbj3Vpmc/Y=;
        b=scnsNjb+IxOjtC3/GnHm0e2KMC81PcHUGWC8hO3M8XZVho5Mva2EDJYPv6GnefaKyv
         BBq3A9LZgK+HmH5lVRftKYir+HyfpgJfpv5/8acSlLcHE94bpkHNsLPVHsgknuheajWG
         v/FvV5d/mhrgGquJ4YiBHDnK2WmUF7YfQ1qBCIsWysdgHV3Mzgvju+N1IwkidRwXGeM4
         tphfU5F2XUZwFoO6MJe/TbT1dxLLuW4Ym2nmdp5xrYuNzN6lihPxb+gt8trl0oyZA6gs
         f1SRWG0WV4bc60nQEwSKT/ao/urTUHKks4d6SJrBOVVZq7b/2rd3jzkmEoszEkkYix7w
         /idg==
X-Gm-Message-State: AOAM532tmauBiQlPgKQ+X8w/CO8ppvJlknnIawYAt0vCzD4O17OkpAUi
        +m2ck+3wlrdKBjRY7JHNX8t3qdjWmRg=
X-Google-Smtp-Source: ABdhPJw8HmcP+spGGAgBbu5CkJH1fb9FCxqfKknD8FvsfbJ4uJx8FTAEtqp5Sez/zuVxyZe5yccNDQ==
X-Received: by 2002:adf:db87:: with SMTP id u7mr5018792wri.334.1606218909770;
        Tue, 24 Nov 2020 03:55:09 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-307-224.w86-199.abo.wanadoo.fr. [86.199.90.224])
        by smtp.googlemail.com with ESMTPSA id l13sm25893227wrm.24.2020.11.24.03.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:55:09 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 12/13] sequencer: use the "resolve" strategy without forking
Date:   Tue, 24 Nov 2020 12:53:14 +0100
Message-Id: <20201124115315.13311-13-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124115315.13311-1-alban.gruin@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
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
index e8676e965f..706c2eee87 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -33,6 +33,7 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "merge-strategies.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -2000,9 +2001,16 @@ static int do_pick_commit(struct repository *r,
 
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
2.29.2.260.ge31aba42fb

