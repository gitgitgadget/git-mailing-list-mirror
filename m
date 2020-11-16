Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F06C4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207DD221F8
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hven03TM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgKPKXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgKPKXV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 05:23:21 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15073C0613D1
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:20 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p19so11705640wmg.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffaO07lkSqT/s54SNv4krQd6SSHjCTt+XHwgCwqfNuo=;
        b=hven03TMJE42GlHW+/SAoQyWyagJMSLKc2HdCAauQggRDCQR9yFoEp5u+i/3Oc5WEk
         S9dTP+hISIjYd2ZiDRntizvhpzdjmix7xXwd4pYuw9qU1jj03qPkzjib2oLY1rHSZqUZ
         f1ODcXM0d4OJLN4wNfWL5vE0pME8Op5fSxcn8x/MRNPSd8NSQMVfPmH6NoInMMBlHrPo
         aQI+fNWE7Nv8VTS8W7BLbWpwLOWMG9YQpmqJyO84cFEv1Z0VJE2hAktw/adt/mitQGP2
         zZUgt8M58RUGNLmRyNhKwTgNoA2nHm6ct00bo5xxAYO3eUor8093IAMLQ1ylJTAcYi1/
         otBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffaO07lkSqT/s54SNv4krQd6SSHjCTt+XHwgCwqfNuo=;
        b=bPhs+Anh4mzGu6xqwlim2U12DaslrgLwEdK7mltHbYmaierkbRfpezqZwNGLS5O4VO
         ToZ1MPcvoMs1O5ewRH8jYKlCIgcWhSLsqwgAL6GcxBfTABtELB8K76ayem4CLY/y2WXn
         OyxZZceOIVO/23JMu5IHVDvEWwodv2sLbmmZPfHl/yw0uZHamuGqY3qtPm38BmzHOHy0
         2o5haub9BVi29qZImEYntOINZD5pRhqxvcgoQuSUgdOVA7SdE0oM0WdrNaVLXY1W6HPr
         RflLs2GxX55u6GXHoggROPgzSmfE18wuvr8RvDFgRGhZBaPiukOYCVpoxRb1eltOGH5z
         zQOg==
X-Gm-Message-State: AOAM532zti7U+J+FDx4GnEfMarndddEZtKndz8R4pSwmB3lh0uE0NBtl
        hgDvAP/oMBl7C8LrudfALI2p5e5YwpA=
X-Google-Smtp-Source: ABdhPJyDFsLX0KGRRjW0/PI1Ce1yZ9rRLCt3u4I0sHxlRic03bpAywR5yalXu0trJKpiqZOTmlUU0g==
X-Received: by 2002:a1c:4b18:: with SMTP id y24mr15340203wma.154.1605522198434;
        Mon, 16 Nov 2020 02:23:18 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id f5sm22884520wrg.32.2020.11.16.02.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:23:17 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 10/12] merge: use the "octopus" strategy without forking
Date:   Mon, 16 Nov 2020 11:21:56 +0100
Message-Id: <20201116102158.8365-11-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201116102158.8365-1-alban.gruin@gmail.com>
References: <20201113110428.21265-1-alban.gruin@gmail.com>
 <20201116102158.8365-1-alban.gruin@gmail.com>
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
index 3b35aa320c..f3345a582a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -744,6 +744,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	} else if (!strcmp(strategy, "resolve")) {
 		return merge_strategies_resolve(the_repository, common,
 						head_arg, remoteheads);
+	} else if (!strcmp(strategy, "octopus")) {
+		return merge_strategies_octopus(the_repository, common,
+						head_arg, remoteheads);
 	} else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
-- 
2.20.1

