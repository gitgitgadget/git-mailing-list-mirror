Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D70A1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390594AbfJRWKn (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:10:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46728 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390558AbfJRWKk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so4661123pfg.13
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q9Rmxbd6f9HFKGKnSFTmLyEMqsXoXai0k8/rbaD4GDM=;
        b=g+dMz7jPq2BG83kWMX3W4icmkNzEbqwXU47ok0aR08XQPikr+O3M56ccMB1seIAK/w
         QpAfdUTjLElJcixeQm5VeRs3LQwb25CViL0nZmH+nDkCjHUpHwBUUwfNrQlAfFcQL2vM
         JEWFqHE+/+2SFFb3APggnTALw29gMb1y6LFcJ6C1QvkCnx/w/JxVsWa+QFkg7mMm10MP
         uNUYELZ68zSWoLPRHnfMvkqeDsSCAED/fSdx7LnnNSkRYWrP/amI+arxkkQZ7aM2YB3A
         1Hf1wtoNBOWt/K+wBFkQbmjKDs3QV1Do1d9BnZW3PnCEdw4UDkNGYoEod1iiyAuqHaYr
         +Y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q9Rmxbd6f9HFKGKnSFTmLyEMqsXoXai0k8/rbaD4GDM=;
        b=U/j1ezC3lyLbwdH5GJVQC5j7idczfnW9r/E35OmajoaN/ZFay3Qn5hTYrXO2u/WpRK
         bKIUYXYyYdca9kLrQNjkte2GvYF6SYm5K1T+Gd8JW4RjKtpEF6GMWHo1WU2o3lReNMVl
         Gz5F+1l4BvYRCZ/Owq3F2zQpoXkHz9xtl8NhgyPjT3Dd3wgOu6lXIRGfQA00Ekw5l9gz
         mz/Yqe5sjAEDta/2gl9t890pGtCCtQ2xpTuoF0oPdTyFEOVzEfiTV0Rq2HMBkeU0viDr
         jKnurEFKtAq5Rx0dgQRgeavwQfADE0DUaGplx5yTMDWvT5qC2nkPnMWeiGjl6MOpY+5F
         YBMA==
X-Gm-Message-State: APjAAAXj4M3IDugnFjiaedyGpWDmUvQMsbKiE/9TjwLB7wF3Eo72Tptr
        WvebRKFp+fiC40acoudHRCfXYsS0
X-Google-Smtp-Source: APXvYqxqzsrSbTxB6+dp1EERsaiQAnrxhhblE7L8XiAKpkGMCGx2oOzO4FCL2W7PaQAeHQh4KMWV5Q==
X-Received: by 2002:a65:6702:: with SMTP id u2mr13024369pgf.426.1571436639503;
        Fri, 18 Oct 2019 15:10:39 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id v19sm7680061pff.46.2019.10.18.15.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:10:39 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:10:37 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 08/15] t5520: use test_line_count where possible
Message-ID: <3d982230be6af86120534d1233eee98d5a152485.1571435195.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of rolling our own functionality to test the number of lines a
command outputs, use test_line_count() which provides better debugging
information in the case of a failure.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 7bb9031140..0ca4867e96 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -699,7 +699,8 @@ test_expect_success 'git pull --rebase does not reapply old patches' '
 	(
 		cd dst &&
 		test_must_fail git pull --rebase &&
-		test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
+		find .git/rebase-apply -name "000*" >patches &&
+		test_line_count = 1 patches
 	)
 '
 
-- 
2.23.0.897.g0a19638b1e

