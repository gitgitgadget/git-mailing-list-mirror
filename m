Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DADD1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 00:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeJYIoc (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 04:44:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38571 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYIoc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 04:44:32 -0400
Received: by mail-io1-f68.google.com with SMTP id q18-v6so4321093iod.5
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 17:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T4KK9W20tkontEeVN1e0DYAD3BIU9c6RMaj5COEfkcQ=;
        b=B7RI/B76/n1IOPmpTGsFMLs7G2KyF60GduiPi7sTGzc6QCECuod/baAeO6z9R1Tqkg
         FvYwQOOcXqT4lJDt6laxR5XBTr6AO+r/5JWX8cvssXkw3vPVmyDIM0JbTjP4vytjXSOk
         n/XT/9/lVvpjj1TxWi8rGlbPwvnKeLhsdHm1rUziUmoCcDzsbyD8mlDZS0ztRiU2QM+x
         H85sJMBTyDreTl9AzE1eNFVer5N8MvDIS1OOXb01EQgf1dcgA/vnh2B/aPTqkyV1oLpV
         2n79u4ek1pMcEKui4i43dW+uX5QuP0xtS4C6wIyoIfs6f2l4BJavvaSpsG/kKTbSvyD/
         WJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T4KK9W20tkontEeVN1e0DYAD3BIU9c6RMaj5COEfkcQ=;
        b=hy+o6dy3zrqMhZiKV2TpoDghhnBarEINqH0zXjH1xlq+nHvbvPeLY0aQDfI5UZXZeB
         OeF8LONVuQK+iP0ETQnwgOK+di954fQKuedfyBIRH1sW6cKcEirJLNp2L7baqCDVRzuQ
         uggPvPjMoSutRYPFniXrxTAmLl6HkR3qtLvjn9e9mXjnPehH1P1vcKLsmEWLBvB0/azf
         JWHMdxhl3zXnWqfLyKAZ8bM2Mk1vHRydD7XVPzGUIlgsY64tuLKo9tBrQkJzLlemCvEQ
         Jxh5bf/tKVhql1cntVwu4rCxqC7fyrGxGTlDtNOQ08JwtiuiwUkK4FyoboN7Yb84HLYc
         mTdg==
X-Gm-Message-State: AGRZ1gLIukP3rESlhJmQZaqJ+Yx9tMLf2e69sVkY2VLM9IiUjyoBew3d
        p1xnZRcYoMtrZmwz9yyZZX21rifH
X-Google-Smtp-Source: AJdET5cDFiVJLz4FL0MMO0k/B6x5ndqBsLZ4aoLBAI7RsqKyiVM98hwqU+NTv17nXHEXSL4Dwp82kQ==
X-Received: by 2002:a6b:9286:: with SMTP id u128-v6mr6262473iod.264.1540426457895;
        Wed, 24 Oct 2018 17:14:17 -0700 (PDT)
Received: from Carlos-MBP-2.sf.stch.co (50-207-95-178-static.hfc.comcastbusiness.net. [50.207.95.178])
        by smtp.gmail.com with ESMTPSA id u206-v6sm4353381iod.18.2018.10.24.17.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 17:14:17 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     alban.gruin@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] sequencer: cleanup for gcc 8.2.1 warning
Date:   Wed, 24 Oct 2018 17:14:06 -0700
Message-Id: <20181025001406.6729-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sequencer.c: In function ‘write_basic_state’:
sequencer.c:2392:37: warning: zero-length gnu_printf format string [-Wformat-zero-length]
   write_file(rebase_path_verbose(), "");

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 8dd6db5a01..358e83bf6b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2335,7 +2335,7 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_quiet(), "\n");
 
 	if (opts->verbose)
-		write_file(rebase_path_verbose(), "");
+		write_file(rebase_path_verbose(), "\n");
 	if (opts->strategy)
 		write_file(rebase_path_strategy(), "%s\n", opts->strategy);
 	if (opts->xopts_nr > 0)
-- 
2.19.1

