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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA10C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB692078D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCHCpIWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgJEM1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgJEM1t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:27:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F6C0613AF
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:27:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v12so8578378wmh.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sjabLEscXQSt36QjKVAcgAVQ781KyGg0xYwQdX+/Zks=;
        b=SCHCpIWHj8e4eHCVya1k3i1kzHxlDinOvNu0A3U2BO9fz3nL0CxbkHlm15NUqXuN0m
         P8sv7+DSTqviVveG9KnTbpNxMta45AzfbXRjo7FJs52DqNpkS/Ycpg/u57TuwMoYGz92
         FSyWM0/W6LCqWXvr30b5DJtG5Nm/HGc+usdeO8rSAps3O9eUy5fLjF90txkwEiF4iBRI
         Nn7QYfR025xnwUdUVuZihTTwxJcHxxHYJ8kOsbBonG8hLCG8B9ATXmitfUZAFmD4oq94
         d5qff8K2EFdEN2F4+2spQsXSLiUXd9/iV6a2WrJtQSKIQGyw6ToXebjlQybJUVWoJdEA
         4yyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sjabLEscXQSt36QjKVAcgAVQ781KyGg0xYwQdX+/Zks=;
        b=qldzFXlG/mgUSMipDXnQDRFzC/x6TUVu4CBQnS7QD+NtlRPnU9FoYDSw3O0mtDLJlo
         Oxo0rSBKO9LMeF7ToHfQJ7KNVJ9bvvJU/xucb8mhLSCbMX5jUOBg28mKE2XvR1mYtKuV
         vUfBgKGSG2g4Bv1Zfg+qakMy6uAzikA8k57VdJVk697v/cWiIIP5pPSQKuAgY7RU5bU1
         XdIjw3SI1srN3jRlDkbahsKgTw4n5rvwUFbnvuyJ58P0KcqEswfQXswF56Gfmdh73smg
         CmidcDRplkR2V+BVBXtp5OkuXnvuqFOht22wEctwRBp/j3H0y1RHz2qy454xtXLBq6G2
         d1dA==
X-Gm-Message-State: AOAM5310wf2+VIVb+5aN7UHv4EZn2HvJDy7zYX9YivFvg3hUS9SAuu5A
        8HQnQTfjdNDiik7VS1hQsOKvQm1yfzE=
X-Google-Smtp-Source: ABdhPJzL2xHIuP8sT46Nw1mM+qnXyAoVwfIObTrVjd634fE7TdAoxGzm60YChIDZDXESVGwsFRt12Q==
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr16841355wml.121.1601900866958;
        Mon, 05 Oct 2020 05:27:46 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-293-21.w86-199.abo.wanadoo.fr. [86.199.76.21])
        by smtp.googlemail.com with ESMTPSA id n2sm13270400wma.29.2020.10.05.05.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:46 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 08/11] merge: use the "resolve" strategy without forking
Date:   Mon,  5 Oct 2020 14:26:43 +0200
Message-Id: <20201005122646.27994-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201005122646.27994-1-alban.gruin@gmail.com>
References: <20200901105705.6059-1-alban.gruin@gmail.com>
 <20201005122646.27994-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches `git merge' to invoke the "resolve" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9d5359edc2..ddfefd8ce3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -41,6 +41,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "merge-strategies.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -740,7 +741,10 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write %s"), get_index_file());
 		return clean ? 0 : 1;
-	} else {
+	} else if (!strcmp(strategy, "resolve"))
+		return merge_strategies_resolve(the_repository, common,
+						head_arg, remoteheads);
+	else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
 					 common, head_arg, remoteheads);
-- 
2.28.0.662.ge304723957

