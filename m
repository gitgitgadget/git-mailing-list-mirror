Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C70A1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 08:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfHEICx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 04:02:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39276 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfHEICx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 04:02:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so61667883wmc.4
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HpERa9+AyMfRwv23vvkwLNJzuyy57v+PKzUXGJV9nTc=;
        b=DJF9I4y2nalS53cid8+Atcv/FVfiHQyXicyC4s9W/C5+BCFJNduKTsMgnDhgjCwkiM
         Rm9Lz829NvOzgOopLH2ehgkyGQcoFJ8N03ScxnFbXJYB9qWBHgYvHhpFxZZokmCsQiuR
         MSFCLdyYZ5bX4ARvAqZUp/FybZ40Qh2B3Svojl+HZY1tr5rE0NNvRmlZeGtbbwlGOCgZ
         RAggTnUMNXhBGVBc0VTxALXLAVavBQBJ0DyNBtcF2ZXf5t5QNKTF8iDOySK8rE2KCqPo
         dkdWYFqsff5quyHuWk1O/tqMBu3Y/iyhKEw4Oih/1vyOH8UrxUKX1HHMExpf9I/0W+Vv
         ij4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HpERa9+AyMfRwv23vvkwLNJzuyy57v+PKzUXGJV9nTc=;
        b=KPu71lC1mLpy6wTWh7kvEnxUJ0B8VslmcbtoGQRcwbR3ilhzTCgNKmc4zCDdl0rpPn
         86TY7dujNuvrjIku+2TMbjdbTRiSGNXp0gX6mlG9ZvZb/dgWHQ6zEqBeFoSU0XJL4/Rk
         0yujGKzEFlnsL2O1s8rH3qBRmOmjfXQXySbOyNvzeAmoCL6wGT76sTl9i6gb+Zq+TX4l
         1lUttqoXo372Ur6ZgEbZ31/xHcC9AxmiswlnGX2j7UEjpFrVNzLRzIZ3l/Kv2kjUzK4N
         /itnucYO5NSN7itpkQNjCXMyrAHYGkxgmSXADpF6eKqHR5PD7armNTrE6YaCLvW55bJR
         4P0w==
X-Gm-Message-State: APjAAAVEOJzMdZRbFsH+u7niiJOpEY665toKU7P4zPiqtypD2fwf3+CP
        PnzRE77YeH8llFjaGEO1BVE=
X-Google-Smtp-Source: APXvYqx1V6Z0zaLOtr7UBFbgrSaws4/wsxPb7FBUv9wwfr8NtyDwB9byzNhWMseJ2Ud4LxCaf+uH1w==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr16407944wmk.99.1564992171907;
        Mon, 05 Aug 2019 01:02:51 -0700 (PDT)
Received: from localhost.localdomain (x4db4a28a.dyn.telefonica.de. [77.180.162.138])
        by smtp.gmail.com with ESMTPSA id v124sm89514573wmf.23.2019.08.05.01.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Aug 2019 01:02:51 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] t5318-commit-graph: use 'test_expect_code'
Date:   Mon,  5 Aug 2019 10:02:38 +0200
Message-Id: <20190805080240.30892-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.309.g896d8c5f5f
In-Reply-To: <20190805080240.30892-1-szeder.dev@gmail.com>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 't5318-commit-graph.sh' the test 'close with correct error on bad
input' manually verifies the exit code of a 'git commit-graph write'
command.

Use 'test_expect_code' instead.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5318-commit-graph.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 22cb9d6643..4391007f4c 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -26,8 +26,7 @@ test_expect_success 'write graph with no packs' '
 test_expect_success 'close with correct error on bad input' '
 	cd "$TRASH_DIRECTORY/full" &&
 	echo doesnotexist >in &&
-	{ git commit-graph write --stdin-packs <in 2>stderr; ret=$?; } &&
-	test "$ret" = 1 &&
+	test_expect_code 1 git commit-graph write --stdin-packs <in 2>stderr &&
 	test_i18ngrep "error adding pack" stderr
 '
 
-- 
2.23.0.rc1.309.g896d8c5f5f

