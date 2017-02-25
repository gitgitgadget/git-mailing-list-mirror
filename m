Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 151FE201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 20:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbdBYU2c (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 15:28:32 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34642 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdBYU2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 15:28:31 -0500
Received: by mail-wr0-f193.google.com with SMTP id m5so67993wrm.1
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 12:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1QNEwTX+YpftuSIXzpKvR8JYIY+Ioy1yn9Novc/aASw=;
        b=gEmP6nxDCeqatRGVNkT0ASYQfEtmCnyLb2b87HrCb5rCy+2ggTquWO4Co+AnkT7BMn
         01kzUUO4w70yy58sOYKkU6mWLprZH0eXi+YhJTFR6jZFRDHHeYrDnMSd0++zy0qw30Tj
         QoiiNjvLCqTlWkwRjGA6JHnqxcMmR5YbRtXY7Wcrw7HsqNOi5O1NydsNd3q/0DF4nQ9D
         eLadlQWpE7sBObzWJidkWyR1cffvxblMtOQI/I7rMfkXaVt09I1ue/NTU4DraiEW18Ch
         Lnp0Vf0R5teZUMlZ6I9Hl5pY81ZI4O/nCAviBSn1yI5gxJEzmEZICtcfDwk0pGLs1H54
         6Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1QNEwTX+YpftuSIXzpKvR8JYIY+Ioy1yn9Novc/aASw=;
        b=Ph6HXlczEYD7J2s821uTdtuAoQDj4p44q56S6Q7urGuPvwfkCjKVBLrX4Tf0QBomOY
         cZOgN+lCSvbTRNkYa4aBA3uM8yQlrX+6JCptCTrBLUxVVP2MP2WDxHb1j343evSIAEfQ
         H+CUaAWm6RH66vwfZ3rct0YggS1oNFa9nuP7ENVqoKSFMxoQ5xSvG5HaL1ReMWxaF61d
         0rotc3Z6oCks8ZzyYOwtuNd6OaxxyIMOXxtTnN4Fct3lnr9yijV4thULTwyPEp74GajO
         /6VA8DVQw7ZC5za/RWyd0VES140gbENIHsBQuEGS3VyE5s7DiWMyQ4jhvn8LgSsSpHOK
         iWCA==
X-Gm-Message-State: AMke39l1NQQJOvkzhVga6+pAaM+kzr10Wul7/MS+MYvtFcbLiUfJYalxxCKBSbalcoQ1Aw==
X-Received: by 10.223.154.72 with SMTP id z66mr7949152wrb.76.1488054450419;
        Sat, 25 Feb 2017 12:27:30 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id b17sm7573064wma.33.2017.02.25.12.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Feb 2017 12:27:29 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v7 2/6] stash: add test for the create command line arguments
Date:   Sat, 25 Feb 2017 21:33:02 +0000
Message-Id: <20170225213306.2410-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g275aeb250c.dirty
In-Reply-To: <20170225213306.2410-1-t.gummerer@gmail.com>
References: <20170219110313.24070-1-t.gummerer@gmail.com>
 <20170225213306.2410-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently there is no test showing the expected behaviour of git stash
create's command line arguments.  Add a test for that to show the
current expected behaviour and to make sure future refactorings don't
break those expectations.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t3903-stash.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 3577115807..ffe3549ea5 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -784,4 +784,22 @@ test_expect_success 'push -m shows right message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create stores correct message' '
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create "create test message") &&
+	echo "On master: create test message" >expect &&
+	git show --pretty=%s -s ${STASH_ID} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'create with multiple arguments for the message' '
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create test untracked) &&
+	echo "On master: test untracked" >expect &&
+	git show --pretty=%s -s ${STASH_ID} >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0.301.g275aeb250c.dirty

