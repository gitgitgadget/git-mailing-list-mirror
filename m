Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86B891F453
	for <e@80x24.org>; Thu, 25 Oct 2018 09:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeJYSMq (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 14:12:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33304 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeJYSMq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 14:12:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id x6-v6so3608084pln.0
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGNcAN7yir9SF2CEh/ZnTEriqT35Bbnh/v0cm4KwA30=;
        b=q5fLUYmJUBIbcExJlX4jNkUbLOSp4z0hbrPYaLscFtTa5VeKsxi2bRX/I63P6u36jC
         +2Bq40URRKOtbD2R9xrVcSO/Fum2NT7oLpEmNEKUIThXny1nbdOnScAcmFd9XF2HVNdb
         wbAZjQI1FWzIs1oM7jjKiX7fDZqMZODXTmhuueoeX39qso/LXqezVkTqKx1/kJzKXsyR
         v578Fg3ALQuNw1wBmDfCUid4StnMG9saKV2RVi0iARntO0PPxL4FLpIoX6UZb5N3jyQU
         geqCWlyg8QeiiGzzo1s7Fuqy1jfDyOvjVFtDcnmlz4Bz+eAj3Cu0sbHgBiqup8wXHQzV
         8XxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGNcAN7yir9SF2CEh/ZnTEriqT35Bbnh/v0cm4KwA30=;
        b=JzMPuUfUqDFZQ5RaPlErdPfRFS6QW1DDurqczIqfv3G8JfxWtG3qmZsE7bGSzZjA8p
         auYWlUrE7igNk5GluJlk/k/UeAX+kV4ksbTRbh1GHnbm++sqsgSmfRj3ic/52v3PmNvo
         ykDsgeEgTUK7ht8N5ui80uwGwuqf0JnaTSGo5rOcQOUbpa7PXC2SLl8/haaJ7EhCpx04
         ozCcA/c+1lwiiKSJyiUErtfdu2dy0tBsgZcJs67mgybxd/wxfvDsyEzFpHQHZWR5ivoo
         vBonkaQ15Ijx4rI0Od3NCY3ygEszjnzRY6b8JTWVFVvc21uc7yrvb3m1zNA3SEJGvd6t
         0HEw==
X-Gm-Message-State: AGRZ1gKYPfn6a6TDFDNfRMjceVZJJIoZlwJ0goPbaUMNSqoF8+BFdImM
        0uzFQ0Dm7Mj64OzH+yrq4G1OAVkE4OQ=
X-Google-Smtp-Source: AJdET5eDEQt8aM1cG6uqJ0MQYDJSPvdRsQe83Wm7fH1jKWs5BO1h8qjEHk+HInDfg5OWh6Jx/iyH+Q==
X-Received: by 2002:a17:902:bc8a:: with SMTP id bb10-v6mr783634plb.99.1540460448028;
        Thu, 25 Oct 2018 02:40:48 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id f68-v6sm23069141pfe.143.2018.10.25.02.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 02:40:47 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     alban.gruin@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2] sequencer: cleanup for gcc warning in non developer mode
Date:   Thu, 25 Oct 2018 02:38:54 -0700
Message-Id: <20181025093854.12783-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <CAPUEsphFSs3gmo2N6Oi7rhhsgU2BC3ijZH4yxbcF1R8SKQLjhg@mail.gmail.com>
References: <CAPUEsphFSs3gmo2N6Oi7rhhsgU2BC3ijZH4yxbcF1R8SKQLjhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

as shown by:

  sequencer.c: In function ‘write_basic_state’:
  sequencer.c:2392:37: warning: zero-length gnu_printf format string [-Wformat-zero-length]
     write_file(rebase_path_verbose(), "");

where write_file will create an empty file if told to write an empty string
as can be inferred by the previous call

the somehow more convoluted syntax works around the issue by providing a non
empty format string and is already being used for the abort safety file since
1e41229d96 ("sequencer: make sequencer abort safer", 2016-12-07)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---

Notes:
    Changes in v2
    
     - Avoid change of behaviour as suggested by Junio

 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 8dd6db5a01..10f602c4d4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2335,7 +2335,7 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_quiet(), "\n");
 
 	if (opts->verbose)
-		write_file(rebase_path_verbose(), "");
+		write_file(rebase_path_verbose(), "%s", "");
 	if (opts->strategy)
 		write_file(rebase_path_strategy(), "%s\n", opts->strategy);
 	if (opts->xopts_nr > 0)
-- 
2.19.1

