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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4295EC56202
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8402076B
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkkl8tF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbgKXLzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733119AbgKXLzL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 06:55:11 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D9FC0617A6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:09 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so2564123wmb.5
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ii/tzVduYTctfq88RDBrPMqZBuH6pHFJMScduWmFHU=;
        b=lkkl8tF+m1BF8SbKIoJmeCiSjfTeThVsbTPNVPf04fnmw3cbrBN76OkLUzPA8a1CPF
         YqUTY5PWmPOPqhu2Zkcv83QpjI8rV/Gahp3Qih0nMqA7U1BNc4aeLD6yCPZ+XHt2uMci
         TStr1HTjUUTIqZ9b5COtFbH7bxG4hbK1nF7KkAg0jMJEVS074px1OBTq5f0pZEEOSFza
         P3MuC7by/sWWYoJHxInFRHwOVGvbJCREveYM1R9NCiLWbsH693QTh+uiWCEEPU0PldrP
         ip80CPnbNMhFd1Ip57u+JqXgxPbugzV88Pp7anCrZ5/jKu9HXp100dGcR2ogStTzpBHk
         iCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ii/tzVduYTctfq88RDBrPMqZBuH6pHFJMScduWmFHU=;
        b=rfcD6O2/O7Hs9GT0z/BRjFXHkPABzId6kYzPnV+f+RXWvpqiHHzG0q1JgqjwQyrGiB
         +9XpFWgZ8/Vn4TiKqfNu+ERvjab1ChDnwIu+mzFrN8qUCuA4Csinv9e6r75y64kyYlt6
         WiJZNgYxTAljG4jaaK9j7XOTyCJ6+VaPySxH94SKjK0Aes9dPcIB73wZHEgIFdkvpZab
         IrC/VkunfjsvJcAqqGTl1bq7uH1RyU6of5kP33kssqpUVUOL5yVxIHPI4tzbEEpr/uI8
         Ku+ezD+qgNKDXsVEpHSXZW11mioAozxESuhMVslDdMDoVnQnrCR2lTwulTo+A6M/678n
         DTdw==
X-Gm-Message-State: AOAM533gkphTplztP6J3nc8Wuh9rIvgMdEp+Gg9oiKw3ltiFfnpUr5CN
        koggQcg2KRE2FAgqZIsSL8OswHmufIw=
X-Google-Smtp-Source: ABdhPJxKSe+mbK824tqTe8ThcZ4aRKiNEDeKu0Z1YGF92WpJxyrNtruMY3gpt+r/NEmIUB9dFyaxXQ==
X-Received: by 2002:a1c:e1c5:: with SMTP id y188mr3985436wmg.81.1606218907755;
        Tue, 24 Nov 2020 03:55:07 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-307-224.w86-199.abo.wanadoo.fr. [86.199.90.224])
        by smtp.googlemail.com with ESMTPSA id l13sm25893227wrm.24.2020.11.24.03.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:55:07 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 10/13] merge: use the "resolve" strategy without forking
Date:   Tue, 24 Nov 2020 12:53:12 +0100
Message-Id: <20201124115315.13311-11-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124115315.13311-1-alban.gruin@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches `git merge' to invoke the "resolve" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9d5359edc2..3b35aa320c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -41,6 +41,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "merge-strategies.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -740,6 +741,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write %s"), get_index_file());
 		return clean ? 0 : 1;
+	} else if (!strcmp(strategy, "resolve")) {
+		return merge_strategies_resolve(the_repository, common,
+						head_arg, remoteheads);
 	} else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
-- 
2.29.2.260.ge31aba42fb

