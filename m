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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256FBC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80E0208B6
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl1OjyYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgJEM2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgJEM1w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:27:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AF8C0613A8
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:27:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e18so3435913wrw.9
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cIMY4obEMVT1HyovhuoLTYqtYdv+pCw5tXwxpQnpBl8=;
        b=Jl1OjyYRyoRO08+TH3oQnOUEVwnVTjO9tpKqgj30B+l9pEsixmyk7nOciPk+GPGj6g
         pSRoh/AL0I41Ahxr9iFQkV2qt/T1WSYlboJbUGaIaLzk+jTo5vIvgK5hNurFx+mIIiOy
         jPwLAqWxNNaKiNWuMxnNkJ1ZkfyWl8O4gh5ylpviJfUIvq+wI5mPa+msWBi8C2851pDC
         8x3Uvw+iir+L2TbRBRikcF1ci5mu0oqz1MNPsFPxtyz4XBOZcb5ipzvlo/sodfw2BxGP
         iPKxgNmNyQvgcIa3f32Ox2FeIT7141/jZRNMHfly6u9SKpPTWsGgEmrZ+YVH3Gepl8/E
         0w3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cIMY4obEMVT1HyovhuoLTYqtYdv+pCw5tXwxpQnpBl8=;
        b=RCTUcpg7mbcQbsGgmu6j2vJx/e1yU13If+MFGglW8JF+CZCbeN0KyKpOUVC6MeAMEx
         YU2sPZ0X5c6Jb0T1NIpzWWIryhZtg8Ed72dCz8QWgM2jdm6gNYwu9BPy+NGT1NJfNQ7/
         odQgt0r+i8EcPrpXQx/cRwnJdy89M4Wex57ghBHUBt4I727D7OTfTS83z9JUmafb5bw8
         9QU8FfPSNEogM4mo+r1LkESPiIi4OlkQWmMuIPZ2/0wb7cILrsg5mgWrC5fK/9dvCpCc
         FhMw67+HAu0UIN4EtAHU18Xsar6kDCqENzg/3VlfqONfTBuHeKedrlvOKgH3KQz3+rW2
         /Gkg==
X-Gm-Message-State: AOAM530+ZubpmOp3UeZgAe5dYmHPvZRdSqS2YwWaviZx0YCXc5NZDn0X
        s+s187/SUaRlmPKuWMqro0+l6GuwBEs=
X-Google-Smtp-Source: ABdhPJyMX+WZCEKvPPcigdq1YfWdF0zak5lk2lvtxnelO//0uWjtfv+qxUi2TVcmE/0jGaotXq+RiQ==
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr17406467wrn.257.1601900870452;
        Mon, 05 Oct 2020 05:27:50 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-293-21.w86-199.abo.wanadoo.fr. [86.199.76.21])
        by smtp.googlemail.com with ESMTPSA id n2sm13270400wma.29.2020.10.05.05.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:49 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 11/11] sequencer: use the "octopus" merge strategy without forking
Date:   Mon,  5 Oct 2020 14:26:46 +0200
Message-Id: <20201005122646.27994-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201005122646.27994-1-alban.gruin@gmail.com>
References: <20200901105705.6059-1-alban.gruin@gmail.com>
 <20201005122646.27994-1-alban.gruin@gmail.com>
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
index ff411d54af..746afad930 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2005,6 +2005,9 @@ static int do_pick_commit(struct repository *r,
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
2.28.0.662.ge304723957

