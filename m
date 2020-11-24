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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1B6C63798
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDB020782
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgxmvWSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbgKXLzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733124AbgKXLzK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 06:55:10 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35639C061A4D
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:10 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id e7so4492222wrv.6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1s+k75PrIsWkaaEQUEdJCm45/zDTIPCPAWVINzNLa4w=;
        b=hgxmvWSwi0eTtJMdIM8nSoTMfWCw5dDdm+pKOvd6WAgd/n+gvZ0e59edmcnfoKrZMU
         uU+mZMywM4a3rjPK2qxLLFakYOoOaBEGFIu/bqpH8UwrkAgrE7CbeuQXNxz4O5eiZcYs
         DgV66hi60iIkKlmYgIWlKl4HcMmCxEqFhrYKbd/BsRwurnt+/s1zIcHu1FVzaKSqVg0y
         VwQo/v/2/KFiVUYyWaPI61nydIldV+m8yc7Mie/myEXELwnJDyS45b3ErNPDUQlOdca1
         9JesT8svzAvVOev425J1YfskOSmRZsk6ih20t1cXWJAnDOVsWy1DellnUAuQthEp+nRf
         rFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1s+k75PrIsWkaaEQUEdJCm45/zDTIPCPAWVINzNLa4w=;
        b=C0Cq4HnTClIX4QAhB9TodgE+FlWvi8s/7kUO2IWfftPkxVtoP958zoVeflVs3xRRIe
         RLNPl9L6n67+Phw5Z33uqpixa9p5fPN2s7zdTKZvOfUU+lffuGjWjQP9VzdyOnFgaglt
         wiayKLZ+Pm6AMBaQuAwcY6aXjBoDM/6oYOgkMo1h9RyJ4xMObjWnJL8lz4KK7YS4uwTL
         C+RqQN0GzqtedAEtUDZVhzRoPggALHw9ea2ok5AbqvqjIKGm8GjF9y+IbaKZWly2tAO8
         u9Tj4Pvoz7n8hrXogQ+LFPzGX9slVNEoMsiJL62v6wRU70PDI+tf/HptqDkgA4gI/dKt
         NMXA==
X-Gm-Message-State: AOAM533XMBv1FTXl6c+HhkATnlRo/mtiFUNa7V9ifL2rt0JUH61Ovm5M
        a6ptjNHdEZw9z54I299vGRMObbs0K0o=
X-Google-Smtp-Source: ABdhPJym/QTPC9CwBNkm+RZoubB6aEpsTqzE45wuNMZTGPqttIFx0aAKgZvLlo6mKR5KEJ+h5k4flg==
X-Received: by 2002:adf:fa4a:: with SMTP id y10mr4972878wrr.122.1606218908764;
        Tue, 24 Nov 2020 03:55:08 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-307-224.w86-199.abo.wanadoo.fr. [86.199.90.224])
        by smtp.googlemail.com with ESMTPSA id l13sm25893227wrm.24.2020.11.24.03.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:55:08 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 11/13] merge: use the "octopus" strategy without forking
Date:   Tue, 24 Nov 2020 12:53:13 +0100
Message-Id: <20201124115315.13311-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124115315.13311-1-alban.gruin@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
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
2.29.2.260.ge31aba42fb

