Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B16E91F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932136AbeGBA0A (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:26:00 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50711 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752788AbeGBAYz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:24:55 -0400
Received: by mail-it0-f65.google.com with SMTP id u4-v6so9894597itg.0
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bUJ43XQS7HyrM82hlz4zVr23JT4HVBrUGakLeF3CEoQ=;
        b=R5F4M56Lg5UXvs4vZL5ekBsPrZAC/APqZsXbBAXpa3ndZjy6k9SdEg/Y/KtTLyOr5/
         mby1qiRw4HNEWxnd0ghoJVGi9RwsRgeGa7YlDgaDzVsixpisIIxrH7IbCMTIEb2um4vp
         nvp9JN3iqHJfz1oSC87xNFLZ1X0G2wpJIzJ1zrfpradWPnFfqIN5+vJ54rb3wdPssnrQ
         AkUf45rj5McvbrMqyoKtbUgnwabxdIEenI2wJctZojz1BuFQKkzXr35idMgwRjVH5D0u
         ovtYI9mdFJIoTrPMqqzcar0LP6FxXWdRldqnPeeImLqoa7cl7YuOtFk6Bru0+m3fZwxR
         jWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=bUJ43XQS7HyrM82hlz4zVr23JT4HVBrUGakLeF3CEoQ=;
        b=IkIZET3H4kgQ2Gd45Q8z3UIvEVQmcWWE09wIJx19bYSk7Xj9nbLXojALVtdccSRyZG
         DehLnMRKMuX8KkrEmsv6EzTL+xFK1yBuKZbOFzHjeCLll11xyGmTHFDYXN57C0Ec2e6o
         UdxVROfDXYTcv8NYffjpAYwIl24jdadvCsk6iXEj+j23fjaSuzJ5VsN6UiXaMui/Y/vT
         uWpOBiUV2O0s8f0P6EKmqBQ4APJZRq5DEDTVNMt+OJNDpIwVKifIvzpwV7WLM+b6rgRE
         Apdm0cMCQnrOB/ZTJ4o0ADv+HbItCp30OnX17WTqzMFZoGnT2lswWBj6RdynNFw6UyTx
         +qPQ==
X-Gm-Message-State: APt69E15cUALBswF5WFRxL5shBywes7i5DqWdRHAcYehHB1F2LOblG+W
        9ZPEe1dadZwq/hFNeeL7iPKS0g==
X-Google-Smtp-Source: AAOMgpd9CD1TsUnZgKxorUGHk31qP2QFQmhPeA97SUpafOEYRBVPTTyY3Z22cXO1ib1u6I0rjAZHMw==
X-Received: by 2002:a02:85a1:: with SMTP id d30-v6mr18689451jai.59.1530491094728;
        Sun, 01 Jul 2018 17:24:54 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.24.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:24:54 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 06/25] t5405: use test_must_fail() instead of checking exit code manually
Date:   Sun,  1 Jul 2018 20:23:46 -0400
Message-Id: <20180702002405.3042-7-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test expects "git push" to fail, thus it manually inverts that
local expected failure into a successful exit code for the test overall.
In doing so, it intentionally breaks the &&-chain. Modernize by
replacing manual exit code management with test_must_fail() and a normal
&&-chain.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t5405-send-pack-rewind.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t5405-send-pack-rewind.sh b/t/t5405-send-pack-rewind.sh
index 4bda18a662..235fb7686a 100755
--- a/t/t5405-send-pack-rewind.sh
+++ b/t/t5405-send-pack-rewind.sh
@@ -25,8 +25,7 @@ test_expect_success 'non forced push should die not segfault' '
 
 	(
 		cd another &&
-		git push .. master:master
-		test $? = 1
+		test_must_fail git push .. master:master
 	)
 
 '
-- 
2.18.0.203.gfac676dfb9

