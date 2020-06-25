Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3511CC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C166206BE
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAbBmMQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404855AbgFYMtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404830AbgFYMtR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268E2C061573
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g18so5739879wrm.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQnHjs2gUr9h7Af164bmLeznclPTq6fiIICM3Trsxx8=;
        b=FAbBmMQXfu1GFu34JAUrdcib+KbKfcCXCH44DbnykE4EMTM3L0rFEwZ7enbR0focB3
         yw8DguuWP4Da+froo/5Pn8naLbzhyEiCcm1ZUEhqd1CgaSyZF54qYWWG83iN8u6ayumy
         9u2IuNa4C0/qud6BF7Snn32k2VtkO49kN8tma1e23W99KlcC19YTuoCEn6KrwEvseqCy
         4Bs4fRik2ie4aptTXQIynlQtrSIAkLcnEWfW+pnAAaRK6gCPLuj3qwRTnUuiPgRz79yG
         PO2rZNfW02NXtzs5M/r2JbcoB1xUrfwXxqIa8QQyJKVF/jmCFrhQ4Jz6Qkel/8kbVNjK
         nWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQnHjs2gUr9h7Af164bmLeznclPTq6fiIICM3Trsxx8=;
        b=I73mbvIdk0wg584jhNaywTsF7W1S4Uy+G0P9iEthjXM7+Ly5WACKdpHb1HolJ1euDE
         UY82b2TSJ7bTs2flfZaIfKe4NQvy8Z6xAGV58+vhPW4DulqG30nLKaANDrCzSWNDHicw
         vpNWdTNln4ReYUh/36J8uLCM+i3pDSYzEHZlbeKWz7I8JHTmXNES9EEgVW3/x3nVuPbP
         6JFjd+a9CwW91sp5DsWGSRd52S5AYv+WDD4YFj2UcofrJU6DBLq6+8L5zMvon3aiHKXu
         3sy72fPHBGqjoh9nUzxB6njCxJl9J1FSCqOmuSnjMHv866mfbH5fdJxm3u4N/RaHjGTS
         DXtQ==
X-Gm-Message-State: AOAM533ipkryoNA7y7TWVpFUqA5EDW0Reps6d1QLasKcqLtPO+EmPDmc
        21MhyrcT7CGLiNn+FQfq4fIsCkCJ
X-Google-Smtp-Source: ABdhPJxWcCM6/nuVn0gBTuuRnioKdZqd5XXgmFO4weSOsOAhe35quVdT8jChgVNNcs3Jo7RubPIVqQ==
X-Received: by 2002:a5d:5549:: with SMTP id g9mr34197175wrw.419.1593089355468;
        Thu, 25 Jun 2020 05:49:15 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:49:15 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 17/17] sequencer: use the "octopus" merge strategy without forking
Date:   Thu, 25 Jun 2020 14:19:53 +0200
Message-Id: <20200625121953.16991-18-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the sequencer to invoke the "octopus" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index ea8dc58108..f9fa995b4b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1927,6 +1927,9 @@ static int do_pick_commit(struct repository *r,
 		if (!strcmp(opts->strategy, "resolve")) {
 			repo_read_index(r);
 			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
+		} else if (!strcmp(opts->strategy, "octopus")) {
+			repo_read_index(r);
+			res |= merge_strategies_octopus(r, common, oid_to_hex(&head), remotes);
 		} else
 			res |= try_merge_command(r, opts->strategy,
 						 opts->xopts_nr, (const char **)opts->xopts,
-- 
2.27.0.139.gc9c318d6bf

