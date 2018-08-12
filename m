Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5726E1F404
	for <e@80x24.org>; Sun, 12 Aug 2018 20:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeHLW6F (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 18:58:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39389 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbeHLW6F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 18:58:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so7235637edi.6
        for <git@vger.kernel.org>; Sun, 12 Aug 2018 13:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+51uBlehmuQxL9mYw6HAKEwVlrmVEynf/7DnNLESL2k=;
        b=pEX6tPLUZ28G6dQNcdnhSq2W/t/wt7XmVUFjpDCa6o6ZUkjqcOWzUIruxUnYRt3vaq
         G2sf2AzPOkeOgQ+1oPsX7vjX+ngBYpORcE1Qy0lvDng/CUSGP/i+7VPVpGAJkrWorrUZ
         nHNgQAbtM/0F07yBYiKOv7GPgwqhpcFI+uid5jULhx3dnMYVpGsCq0iu0bnqxtV4Fut+
         NnKZ+WU8ma1V8eccDSkY4u1ptv4FrvIh4sffOJIKgAHua7i+gt5B12dJyMar4DyJf9hS
         pGFjEERxEZwimYccr5XXSmi++l//nGnIaS7U9Hhrhgs0i9kAad8RCoT054FzpHjGJg7a
         SMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+51uBlehmuQxL9mYw6HAKEwVlrmVEynf/7DnNLESL2k=;
        b=adOgvbNsEI8MQNxd4kLkuRvIcCakv3NVRshQECub78KsYnzZIOzNRxe2bsrxCkXZY+
         Z6CKHa9MsUURxNQtNkEXbnuUQno51l6Z0/af+NkJyYDAzvHkGVvl1B1OuhCOaXnYr28Y
         yMbh8SaPTjY2NoKtYXNt5zyA6yMgW+pJLN/EOJ+vlk4495UrtoTqDZ/d9M30ssR6YprF
         sj9dlKxkxJvOL/ALKOlK5XFcx2Jyd0Tshr79aYepRTcSf4R8cFPs1cIWj0gJLRVczPUT
         UnCgP0/SGXwGbY2kHJhZE59OQnXH/v6bWJh34OzcX9j4QRHnFZudoKovVVSxbCFsgJz5
         Z2GQ==
X-Gm-Message-State: AOUpUlH3KWWtIdQgBftepYbV5pzLk4QYFhyjercrSEvh0b1Iaxu8QJKP
        7ZGbOr73E+Wemclcr1WlPqs=
X-Google-Smtp-Source: AA+uWPxkDC9Ey89mG84qPuuECetEIa9jqoAZqAl/IByyFIMxe/Cs/4TRStMSFmQv2pGeGpVdM8xwOg==
X-Received: by 2002:a50:c3c7:: with SMTP id i7-v6mr19030468edf.232.1534105135624;
        Sun, 12 Aug 2018 13:18:55 -0700 (PDT)
Received: from localhost.localdomain (x590c5679.dyn.telefonica.de. [89.12.86.121])
        by smtp.gmail.com with ESMTPSA id a5-v6sm6002001edr.1.2018.08.12.13.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Aug 2018 13:18:54 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t5318: use 'test_cmp_bin' to compare commit-graph files
Date:   Sun, 12 Aug 2018 22:18:45 +0200
Message-Id: <20180812201845.2923-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180627132447.142473-22-dstolee@microsoft.com>
References: <20180627132447.142473-22-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph files are binary files, so they should not be
compared with 'test_cmp', because that might cause issues on Windows,
where 'test_cmp' is a shell function to deal with random LF-CRLF
conversions.

Use 'test_cmp_bin' instead.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5318-commit-graph.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4f17d7701e..1c148ebf21 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -254,9 +254,9 @@ test_expect_success 'check that gc computes commit-graph' '
 	git config gc.writeCommitGraph true &&
 	git gc &&
 	cp $objdir/info/commit-graph commit-graph-after-gc &&
-	! test_cmp commit-graph-before-gc commit-graph-after-gc &&
+	! test_cmp_bin commit-graph-before-gc commit-graph-after-gc &&
 	git commit-graph write --reachable &&
-	test_cmp commit-graph-after-gc $objdir/info/commit-graph
+	test_cmp_bin commit-graph-after-gc $objdir/info/commit-graph
 '
 
 # the verify tests below expect the commit-graph to contain
-- 
2.18.0.408.g42635c01bc

