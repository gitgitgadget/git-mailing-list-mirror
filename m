Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45A811FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754113AbdCFJvu (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:51:50 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35219 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753509AbdCFJv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:51:28 -0500
Received: by mail-wm0-f68.google.com with SMTP id z63so10568904wmg.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YmtYLmKkHsbdhMNRgnFtVc2E1W1Qme1uS+cZr/EeXS4=;
        b=hdVvG5aHMK6/16VSp4AMapFAjryMAuQEP423roqSVUwl2LN4sQyfkeuHrm6RsP3OYu
         yyQ58ETaPl+YV3irGzxdHWw9CiadPLUmeYVI5/nFNX//zX5h5rDpZTt6pqvCAIrRv334
         72ZrFTgMJI5DI5wGSW7aUIuMNixQvVKiJbdUyKTeXfEIBKVMVznK9FRUkep0yOfa2hJn
         2LvbWst+96MzkbX7kfbUnAT2lKCSW5MKY9HN58y4n2VJqaGg8BQAjYArfgISiTNEgQjp
         RKLmATpHOGXKwdJ+EzGL/RKxGtot7PaBaxbROB/+ll4dIIXitvvDVvGh6YY9b70s78G8
         9hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YmtYLmKkHsbdhMNRgnFtVc2E1W1Qme1uS+cZr/EeXS4=;
        b=NIAI1beWLWJo3xlO/SxUlCsJgdQhi+dUg07yc9vfT4/Bk9Ha2kAX+meqRKfLJtZgoe
         4bSjlWTtMHuzn5DZ1GBdsg9GpsUD5DwUVYKkr6ap7Z9XOW4sPwHhaOapMoXXItEOcwmJ
         Vjp51SH3G4pgJI6l1NAeB6An0C1Q767sqDNNfVk6MQe806ZVN4viq3IMtvxfi+L9A1lA
         yFlhpT7yJ9Tw9SYXReNpbajkatfcrpLnves5w6dpuRnrsXJP9LaXH9GCUdQNiqd6lIBv
         KXtTdvKiK1C49HPLhpOMBRE6TWAZ5pmnzJDAKgDTZcz98m2Cq71qReKGSy4jEyFUzzGZ
         UCfg==
X-Gm-Message-State: AMke39k9VW5hhIYRcrNekNjiRjcuX7S1ta9xUqxMff3v8EAX9hhIL3dsPLVXhH0CNasuvg==
X-Received: by 10.28.100.193 with SMTP id y184mr12200106wmb.2.1488793347039;
        Mon, 06 Mar 2017 01:42:27 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:25 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 07/22] t1700: add tests for core.splitIndex
Date:   Mon,  6 Mar 2017 10:41:48 +0100
Message-Id: <20170306094203.28250-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 5ea227e6a1..aa2aff1778 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -216,4 +216,41 @@ test_expect_success 'rev-parse --shared-index-path' '
 	)
 '
 
+test_expect_success 'set core.splitIndex config variable to true' '
+	git config core.splitIndex true &&
+	: >three &&
+	git update-index --add three &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<-EOF &&
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	three
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+	EOF
+	test_cmp ls-files.expect ls-files.actual &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'set core.splitIndex config variable to false' '
+	git config core.splitIndex false &&
+	git update-index --force-remove three &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<-EOF &&
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+	EOF
+	test_cmp ls-files.expect ls-files.actual &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	not a split index
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.12.0.206.g74921e51d6.dirty

