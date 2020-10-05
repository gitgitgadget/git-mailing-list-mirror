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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3F3C4727F
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290312085B
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qttoVSo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgJEM2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgJEM1u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:27:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0D8C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:27:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e2so8579526wme.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=56EjVO+wZTopXnAlR4SnRyJwwjdvLiBgA5T16TnpTVA=;
        b=qttoVSo82hk8Gmn8p81FPFz7gww8qkL57ZQkkP1IXyMGJVsRKTXvUhHxJKrhTIC0oz
         VpYUqRSPbEJ2uBJ0gZpdlfIvirYJYlWKU6sWJNiNJkLkalXSzjHJytVBj8qb6mYFOOcm
         Dmqt+TOKZGoBLM4pdzHzFc+0hs0Wb0ZkH2ua5Y4gH1zwSHt1/p1LxzOlNYQlxxhDaf+W
         JKVih716ReMzkXRPyz1XnLAeK9uPO1/QWkds1zo1yCVb90eTEOtri0I6/Xc48ipgkUYG
         O86A/LZ14fI59pZ0g2Hv7UI8t2OcOt7QHs3VmS+0pfSmvos9rdnuR9aT2FYx5yyJt9+l
         FALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=56EjVO+wZTopXnAlR4SnRyJwwjdvLiBgA5T16TnpTVA=;
        b=WDWJQ6V6Mj1geOS08Iog71Ye9jrmI34vXQLjsHps0SqpW7qrIjqt1JHqw2/PuIC8Te
         cFPt4jnH3//Usf7E6tdVSHW2jemyohPigeuuGlYJXVCkdvaWieey1ojvQr7IqN8JmiCR
         0JoSLpMsgIFLlkYzqF8YAKtp+kBNECjBbyS5xfwtowlmdn4jKd7swdFmkulvMBHGGj1Z
         mt46hve5T3E55go/AvMJ995MT5QhIKiQXteyvFuK9hweiSLfEeFbIp6h/8wW+CP+TEKS
         4udatx5xRAqbbOTRb+EDof7Ta6z4Yn//9EYsXi8HKCVJVQmxU97nvEh0H7mhrbzWdTS3
         VkIA==
X-Gm-Message-State: AOAM533I1s/YwX1dXYO+7VORLZWLxmUtUI/qSckInCaYNWP1h0SwwUXk
        DYxxswMJW6G71QLZ6Ahle2fvTjKe+LM=
X-Google-Smtp-Source: ABdhPJwrOJJtWEAfdfNEfEO71geW6JNZ7k+aHl899taynwtYYGzhhvtTg6/0oJ/N02DrSOh24I8dHg==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr16679112wma.88.1601900868303;
        Mon, 05 Oct 2020 05:27:48 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-293-21.w86-199.abo.wanadoo.fr. [86.199.76.21])
        by smtp.googlemail.com with ESMTPSA id n2sm13270400wma.29.2020.10.05.05.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:47 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 09/11] merge: use the "octopus" strategy without forking
Date:   Mon,  5 Oct 2020 14:26:44 +0200
Message-Id: <20201005122646.27994-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201005122646.27994-1-alban.gruin@gmail.com>
References: <20200901105705.6059-1-alban.gruin@gmail.com>
 <20201005122646.27994-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches `git merge' to invoke the "octopus" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index ddfefd8ce3..02a2367647 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -744,6 +744,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	} else if (!strcmp(strategy, "resolve"))
 		return merge_strategies_resolve(the_repository, common,
 						head_arg, remoteheads);
+	else if (!strcmp(strategy, "octopus"))
+		return merge_strategies_octopus(the_repository, common,
+						head_arg, remoteheads);
 	else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
-- 
2.28.0.662.ge304723957

