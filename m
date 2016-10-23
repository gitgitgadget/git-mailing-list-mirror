Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4938920229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756466AbcJWJ2C (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:28:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34016 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755566AbcJWJ1S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id d199so5245875wmd.1
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aK9XBv1PL4KqYfitqfcRapn3WpZlupRaESomgGM+kTk=;
        b=JuwnTHC/uU8i4uddBdS/YQfGGXHTBV7uFJVm68VZ66bd408Xt/0MhFW9Mp8iGB6jjB
         VwI5SeCEH9EtQn0mX3lBcpqWhA/V9BsZhXBziXXcT6mPXxpy4N35FCvUfmmV9UFqcw+t
         0EfAgif89usJbN42ueNNor33ME4nv6/h/HMHRXZNgZJ1Ah9g+QmRBeK2sDb1LDHq5m3T
         CdgGXcla9IPzUR/3dr+8RsH4iOJx+5ZtzAqLDYMxB5FWwM/oalyXb1hefM51oUaBWBYP
         N4naGR8mGM9nJzyJ2jf9OB104wwD9ZirA02ZNdLvUGY+7tkwu5hTR5MpAjtWZ/dYGcGt
         ypeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aK9XBv1PL4KqYfitqfcRapn3WpZlupRaESomgGM+kTk=;
        b=HkeMl4e23ZgW7ZIAo4B3bU0O/gWvQYpJ+eFSlLr8dH2scrTgfolHFhHnepsGA8Vshh
         4DBK2i4awh2V5lFk2nbIemDAtz8UxTWSyM4noW4bwVufWeMX04xnk/C8mW2kPBUvjdu4
         b2eQr2hOL+XwCTBnXDY4GdDf9WnQeWr5s3Oic/P/Bh8z4MuwaHVhl99mAfJUGe4aHYfy
         BKhrV7LwQTUtv5ROue4h1v3SbuEnVc2tpWP2hgpba6FRb4vh5r2ueqcNxP75vpv5qkgL
         oiBqSTDbPSxP6wxkUi+P1M2s+F7bbsIeS8z1U6mxzMwDDY3ZbYieB0bNense3Kd6JXA6
         1ofQ==
X-Gm-Message-State: ABUngvet8W9mxw1ujAqivohSKhemrdXjmwI/EBKMyYH75Kw2YUGUuYkrGEIloMHn1CPpeA==
X-Received: by 10.194.110.129 with SMTP id ia1mr8610425wjb.230.1477214837005;
        Sun, 23 Oct 2016 02:27:17 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:15 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 06/19] t1700: add tests for core.splitIndex
Date:   Sun, 23 Oct 2016 11:26:35 +0200
Message-Id: <20161023092648.12086-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 292a072..db8c39f 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -200,4 +200,41 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'set core.splitIndex config variable to true' '
+	git config core.splitIndex true &&
+	: >three &&
+	git update-index --add three &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	three
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+EOF
+	test_cmp ls-files.expect ls-files.actual &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+replacements:
+deletions:
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'set core.splitIndex config variable to false' '
+	git config core.splitIndex false &&
+	git update-index --force-remove three &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+EOF
+	test_cmp ls-files.expect ls-files.actual &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+not a split index
+EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.10.1.462.g7e1e03a

