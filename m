Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F22C1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 03:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfHTDqI (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 23:46:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36206 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfHTDqH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 23:46:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id w2so2489619pfi.3
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 20:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNYGeO5ODNaXeY8aFA2IpaDSTCOV+n7rztBxatQy0eg=;
        b=k/yUg1vXIDb8YujR26Oajm6truGgPIy5zbnqTlfQM2kYs5fDy5mTBi/GwPlWtLdTQT
         VkkqHX5fp2SVBUWPvR9zpXrGgwjPqnuTe+q5SKulvTYz0hFI+2lBF/eVm/UHSmKqH1KH
         WTTD8KIUOq4CjO/kRypI0v/lX0TphkDRiK00AsTybUPP6lBlvIvy6K451hPIu12FTyeS
         Ve3dNuvgbxlIr6pq7fioKIjE5/gVt2fkqg0CljH8eMT3lkJqymJAEcSoYuDuwgBmREV2
         n1gTFcPLXoiAOwepxCdjtPR8elLPcZfDJmZjk9xChDDN0BW6oktmxpql7pYLFLUaC94j
         NiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNYGeO5ODNaXeY8aFA2IpaDSTCOV+n7rztBxatQy0eg=;
        b=RpNXHwawu3pkO37MHUz5EdyNZFX6pN6WzRjkvDmmr4qPYpUUOvfr+1fw26S2oqUKEu
         CXE4JxgEIaj5+uVzZSb6e+bfPzZaCcnm7Wtsd0xT5Uxp2KxVS77KFXbbHQOptQJY6Ns7
         TsP2w0emC47RVwH2tCZmdUn6q8CZraWRXQGrpLeEXHwJ4XacvcKRQ0GNchxkMeLthSPw
         SdAV1XABxtXZDiCedDNVhftuvvZQGylZqpDO0YWZmIob6Vw+Q8xKedvFAqTvWbDJzwyU
         PhUUBcE4IVrSfz2tXM1Ksv/Q2Ehrr0HZmspFcFbbdMxAImU03Mq8Tc0gqzapbLhg20RJ
         EEYg==
X-Gm-Message-State: APjAAAXUQ+T1LIVYNuLL9TLDi/D3LgJFNX6LQB6icZiD3tu4lolWpW3V
        2+522h+WqcsWBfaU6X1FIvM=
X-Google-Smtp-Source: APXvYqyCXkGXD8jZpGPICbAJM4Qkq3qflp/iuSn9sbFJlrRdmvrejFLpHpzKU5NQrXB3M5VMkoZ7Wg==
X-Received: by 2002:a65:4205:: with SMTP id c5mr22505838pgq.265.1566272767129;
        Mon, 19 Aug 2019 20:46:07 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.227])
        by smtp.gmail.com with ESMTPSA id v67sm30115686pfb.45.2019.08.19.20.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 20:46:06 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v2 6/6] rebase: add --author-date-is-committer-date
Date:   Tue, 20 Aug 2019 09:15:35 +0530
Message-Id: <20190820034536.13071-7-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit introduced --ignore-date flag to interactive
rebase, but the name is actually very vague in context of rebase -i
since there are two dates we can work with. Add an alias to convey
the precise purpose.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-rebase.txt | 1 +
 builtin/rebase.c             | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 24ad2dda0b..6a52d721e2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -388,6 +388,7 @@ See also INCOMPATIBLE OPTIONS below.
 	as the committer date. This implies --force-rebase.
 
 --ignore-date::
+--author-date-is-committer-date::
 	Instead of using the given author date, re-set it to the value
 	same as committer (current) date. This implies --force-rebase.
 +
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ed58ca8e5a..19b1fc0f3a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1442,6 +1442,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
+		OPT_BOOL(0, "author-date-is-committer-date", &options.ignore_date,
+			 "ignore author date and use current date"),
 		OPT_BOOL(0, "ignore-date", &options.ignore_date,
 			 "ignore author date and use current date"),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
-- 
2.21.0

