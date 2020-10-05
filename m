Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B69C4727E
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F50208C3
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu3iU65B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgJEM2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgJEM1v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:27:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC56FC0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:27:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e18so3435858wrw.9
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mb9tLYVsaEjYwo9yQTDbfBTN4/5xWRH6g0bAbuFD01I=;
        b=Bu3iU65B46o9u11J4R004DWiZ5Mk/HVEG3X4qLFDhCQrxxUcnxNUNV3jXrDI0xCyj2
         kTT4biqGXlJL5Bkx/9FvnB4kMAB3X/rNx0l5eZpAbX20v0zsw21SR2SFl/OkTOQoRO6U
         GxrW0rdUUvFo0s79ItHBtVB6Ro9LTJYe/E/L0mfMQsHz5Czj4u0l1NyzVD1KqusGeQUA
         z+C+RIgD43C5Ziq7mx6yMeLnwWj0Bh0cFGrrGYF+PJku+iXzQyvfESL1siLtlhTuqlkM
         YW4ntIuzAsdnCEOXSiotTU6vVH3S9Ev+lx+O7vH8t1hC5nD3Lxkhsjqyclm5gFt6AwU6
         4tJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mb9tLYVsaEjYwo9yQTDbfBTN4/5xWRH6g0bAbuFD01I=;
        b=uiisrPbVFy0tjjpoDSlq65vfrPcY+KEWMMbXNFHclmEqV9mDFmmKQQnGqe+uftrRcZ
         +qYVJMOPVsUmbeADhr7bjJaj50lyKonJPGMD+ocF+am6oyEkKg9Efii88tsD+0R1Qzjz
         C6lv88rt/2o7UxAADumY/lqJg90eXCy0PADwqYw+cNjVofgdxLqyvJmqfG5TS/Aew7iq
         dJmj5fWmkPsdTpfwyvnC8C2lkq0Eo0dwaPLorp4UcjctBOY3A6g2RyXlB82UIAE/80qE
         kBTWrFzzzmSJm6NWF9oMIXGoaRM7D+Bi1ocV6RgBnrzsc4ChzHi6ZNtPqi1LwdxgSa0k
         QmFQ==
X-Gm-Message-State: AOAM533UPEIfb7mjQF0x3y/9azH+IjKom/6Zl+CX0VmiGTPpQt6CSXQz
        FW2G9F/Dmc8DrWjvjRRr/W6r0br4BVk=
X-Google-Smtp-Source: ABdhPJzRLZDOIsQaG/AkJiAwqroo3nUAn3jXKkKtJFVrS6cjceOT04Bik1V9eeY6E778LUaVAp2D9g==
X-Received: by 2002:a5d:40c3:: with SMTP id b3mr7734042wrq.157.1601900869424;
        Mon, 05 Oct 2020 05:27:49 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-293-21.w86-199.abo.wanadoo.fr. [86.199.76.21])
        by smtp.googlemail.com with ESMTPSA id n2sm13270400wma.29.2020.10.05.05.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:48 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 10/11] sequencer: use the "resolve" strategy without forking
Date:   Mon,  5 Oct 2020 14:26:45 +0200
Message-Id: <20201005122646.27994-11-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201005122646.27994-1-alban.gruin@gmail.com>
References: <20200901105705.6059-1-alban.gruin@gmail.com>
 <20201005122646.27994-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the sequencer to invoke the "resolve" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e8676e965f..ff411d54af 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -33,6 +33,7 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "merge-strategies.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -2000,9 +2001,15 @@ static int do_pick_commit(struct repository *r,
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res |= try_merge_command(r, opts->strategy,
-					 opts->xopts_nr, (const char **)opts->xopts,
-					common, oid_to_hex(&head), remotes);
+
+		if (!strcmp(opts->strategy, "resolve")) {
+			repo_read_index(r);
+			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
+		} else
+			res |= try_merge_command(r, opts->strategy,
+						 opts->xopts_nr, (const char **)opts->xopts,
+						 common, oid_to_hex(&head), remotes);
+
 		free_commit_list(common);
 		free_commit_list(remotes);
 	}
-- 
2.28.0.662.ge304723957

