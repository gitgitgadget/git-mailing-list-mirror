Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2437C43461
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4EAD215A4
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj5vItpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgINUsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgINUsi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 16:48:38 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253B5C06174A
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 13:48:38 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c18so1287616qtw.5
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RAiMy8VLP5+yJEgI2GoMzXIB7Zj2+bDVPolRRZH5GpE=;
        b=lj5vItpTsf/Sx7B8zLUUzS8WGiVNs1H9pnxw1lRvJ2b5wFgEoI/Kak41+uRRIwetw9
         BfQUs/YD3QC24hmi8fsQuPt0jWTa4vgpsZ509eTh3HR0c4I5t4ffyf+7J9iv8TS6Z4Lz
         bjRUweZIYPHdNGMcyT9SJKol9DEiU5W7mcr/zaIeL4TCCYsbmRZ0Jfm3rB7xRadgqhUD
         x/12M3w59zApEqSkA6ZOFqE3muJHl0JZPZ8gFoyaHSZvdLOcTAcn+manxqNAaOycxBp9
         SJMJcDxcSHpOvqScuLw+/rsyTJHV7TsUcmYXVZ9CnUNc8TXWCBw5uDDNdS/BQhk2rYRP
         9yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RAiMy8VLP5+yJEgI2GoMzXIB7Zj2+bDVPolRRZH5GpE=;
        b=GdS1/oUj3h7dLA+L6z3ayE8e7OCAnr51OI1AKbcxwDQbhMdOwVruop5I6CDXYGW2MH
         ODW6yvLTvdh93S3IMKXrdfDrvTixtc0nkKOto0YFp4cbi05tA+88hV92JQfrbGeJoxAc
         iiUW3Nhnqb0y/zFwbIMpOujrVZjDg/6OglwaJp/2eSTCujaMpBYFcjCbaiwDNmAB89Mh
         XHAH5K6/HUpHGVFgMuU3woq0G/ouKQH+nb2VrUGv+2I4F29YONdBDEE7ErH28IJbe5DN
         kXCER2NMJ9FEtTr4mDPDIr0//ItD9pe7dH2RSwamu3yLj08YF04DzWEEEGM909Q2SX0q
         mqWA==
X-Gm-Message-State: AOAM530m/JUZSOwRPuvbTaA4L6Ce9WUTr7xT7ClSZrHfVJrx1ZJYDJLN
        CgjTxLTlgcNqVL5c93KoUbM=
X-Google-Smtp-Source: ABdhPJxZ3AVLBydUxEy0zZRn29Fx5aKiEc/hhva0+xhaBgcIEL66lNZgXyHY4xIIfpCZIZRnYUowdg==
X-Received: by 2002:ac8:1c16:: with SMTP id a22mr14292091qtk.85.1600116516798;
        Mon, 14 Sep 2020 13:48:36 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:6091:313a:250c:77ff? ([2600:1700:e72:80a0:6091:313a:250c:77ff])
        by smtp.gmail.com with ESMTPSA id p187sm5353115qkd.129.2020.09.14.13.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 13:48:36 -0700 (PDT)
Subject: Re: bug found on the new git maintenance builtin command
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com
References: <20200914194938.GA4235@contrib-buster.localdomain>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0b35829f-a83b-a093-2dc5-0e7d3b42fd15@gmail.com>
Date:   Mon, 14 Sep 2020 16:48:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200914194938.GA4235@contrib-buster.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/14/2020 3:49 PM, Rafael Silva wrote:
> Hi Everyone,
> 
> I found a minor bug when testing the new maintenance built-in command that was
> introduced on 679768e2a1 (maintenance: create basic maintenance runner, 2020-08-25) submitted in [1]

Thank you for identifying the original patch! My gut reaction was that
this is just in the Part III code which adds subcommands, but that is
incorrect.

> (gdb) list
> 1628    int cmd_maintenance(int argc, const char **argv, const char *prefix)
> 1629    {
> 1630        if (argc == 2 && !strcmp(argv[1], "-h"))
> 1631            usage(builtin_maintenance_usage);
> 1632
> 1633        fprintf(stdout, "run");
> 1634        if (!strcmp(argv[1], "run"))
> 1635            return maintenance_run(argc - 1, argv + 1, prefix);
> 1636        if (!strcmp(argv[1], "start"))
> 1637            return maintenance_start();
> (gdb) print argc
> $5 = 1
> (gdb) print argv[1]
> $6 = 0x0
> 
> Hope all this information helps with the fixing it

Thank you so much for the report!

The patch below applies to ds/maintenance-part-1, to fix the problem.
Hopefully it also merges cleanly with the changes in ds/maintenance-part-3,
but I can deal with that when I submit my next re-roll.

Thanks!
-Stolee

-- >8 --

From 8cd793e16cd8521f4f8d7ccf2b93492ba444e8e7 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Mon, 14 Sep 2020 16:42:36 -0400
Subject: [PATCH] maintenance: correctly handle missing subcommand

The maintenance builtin created in 679768e2a12 (maintenance: create
basic maintenance runner, 2020-08-25) has a flaw in that it does not
protect against a user running "git maintenance" without any additional
parameters. Correct this by adding a check on argc before looking for
the -h option.

Reported-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c           | 3 ++-
 t/t7900-maintenance.sh | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c3bcdc1167a..090959350e0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1027,7 +1027,8 @@ static const char builtin_maintenance_usage[] = N_("git maintenance run [<option
 
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
 {
-	if (argc == 2 && !strcmp(argv[1], "-h"))
+	if (argc < 2 ||
+	    (argc == 2 && !strcmp(argv[1], "-h")))
 		usage(builtin_maintenance_usage);
 
 	if (!strcmp(argv[1], "run"))
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4f6a04ddb1e..53c883531e4 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -10,7 +10,9 @@ test_expect_success 'help text' '
 	test_expect_code 129 git maintenance -h 2>err &&
 	test_i18ngrep "usage: git maintenance run" err &&
 	test_expect_code 128 git maintenance barf 2>err &&
-	test_i18ngrep "invalid subcommand: barf" err
+	test_i18ngrep "invalid subcommand: barf" err &&
+	test_expect_code 129 git maintenance 2>err &&
+	test_i18ngrep "usage: git maintenance" err
 '
 
 test_expect_success 'run [--auto|--quiet]' '
-- 
2.28.0.vfs.0.0



