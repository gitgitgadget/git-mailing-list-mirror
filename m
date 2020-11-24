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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2CFC64E7A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A352076B
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqqNWtkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbgKXLzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733124AbgKXLzN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 06:55:13 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32348C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:12 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x22so2163133wmc.5
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eaAEaHSXinEPwrLnHLHK2esi5cNUvdE9lR2s/q/f5fY=;
        b=fqqNWtkVvbfR/jFlXwIAwdq+D2tjffEw/jjMQivDKqLcgKGXgYXRLsAXuxKngk/g1d
         3CrXUZio5nxi7QZWQHe2MBq4caHoBt77lsA+FHIuOh1M20HM6pPv7KC+uTmM95LOoC2d
         g56a/BkYFk+IA7L96BBsrnEJ6ipyA2YaiWLdDwLawH0hKSeYMU2IrzKjcg36ebAN4aJA
         G7C8ah31FxGiBeprztkcw/PVZqqG5O4BYMUHm6vUGwiC6dAm2VEiDFxOBwGeyWLuL2Ut
         bokb6GWGf6mb5snU3cjtuFElYf+UsAgICceGi1uRL28jbrqpW1amleoAxUDk+nnNG/rZ
         FiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eaAEaHSXinEPwrLnHLHK2esi5cNUvdE9lR2s/q/f5fY=;
        b=KxtTl+/FMYyvulK+iN2R4SovX5aAag8fFFE5K5ok2IHvZVPoNqYmoO12WdFwJcWO1T
         EWijaKHhoTrNS6JaGzBcQq4uowSbqTxSCoR0wPdb2zs34Gh3CH5ccQOn38fTy1ZDQSz8
         Tfu2nbfTGzyFurXj4x88Hv+4C3HldRSgOTXdlPx/doOdEVD/yZQ496lkFXFPJRH3+tdq
         zRPJ50OvA88cGFIbOSVgieLD9UPjU2leOQFRyPsJZ5AHu7BZgML05/S+EmlV+KQMhrt8
         VFOSBmAuK220qs0yWRZIAe7CF54NTujgB8e+VzBZm22enJkPBe5cMZ8Y1Q/KFzaL7Hjo
         Mnrw==
X-Gm-Message-State: AOAM53095hwfPYVjUPlB0GaLPV+c4Ug+OUzXGmi3uTNo6Bzd/BrjneJ+
        raNCZbMPYwaLUbMY3gd3f+v1z5Ee6Pk=
X-Google-Smtp-Source: ABdhPJzEvwo3wV/qpg2euXtF68xllSaBunZuorKmRYRUEpL/cBoYLijw6jmMKJS0bW3OEVHnc3yCsg==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr3115393wml.11.1606218910726;
        Tue, 24 Nov 2020 03:55:10 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-307-224.w86-199.abo.wanadoo.fr. [86.199.90.224])
        by smtp.googlemail.com with ESMTPSA id l13sm25893227wrm.24.2020.11.24.03.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:55:10 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 13/13] sequencer: use the "octopus" merge strategy without forking
Date:   Tue, 24 Nov 2020 12:53:15 +0100
Message-Id: <20201124115315.13311-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124115315.13311-1-alban.gruin@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 706c2eee87..591de451a2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2005,6 +2005,9 @@ static int do_pick_commit(struct repository *r,
 		if (!strcmp(opts->strategy, "resolve")) {
 			repo_read_index(r);
 			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
+		} else if (!strcmp(opts->strategy, "octopus")) {
+			repo_read_index(r);
+			res |= merge_strategies_octopus(r, common, oid_to_hex(&head), remotes);
 		} else {
 			res |= try_merge_command(r, opts->strategy,
 						 opts->xopts_nr, (const char **)opts->xopts,
-- 
2.29.2.260.ge31aba42fb

