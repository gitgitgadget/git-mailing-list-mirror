Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE2A1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbdB0SCQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:02:16 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32890 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbdB0SCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:02:03 -0500
Received: by mail-wr0-f196.google.com with SMTP id g10so11038207wrg.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sdObAKU/YVKmkTc1NFiJRCVh2RCXQ1Z2IPGbWGuXKTE=;
        b=UUOyjJ9ccvU+kF4YiWd7HY3Y5EXaKJBGjIEaFsOT0FwAPSS/rdR9mE1cjKCzJvXWbv
         cfOe/irtkY/RH/5ohvVn7vMy+s+0g3O6fck60vglDZMNKkmvl8j8XN8kQWFkWKvu41xd
         eBWsxyfkPRnQYNAuhWX8WgCOxmCxBf31f1KWXplDsS1hjHqa5R9+PmK+YCd/ZXLiS61C
         w+3ItvI2WZBF/yFSE71U1gmNqCNDhiUrbEDVncAANyOwqz3aNoDRQYf/et2Y5+oQvVke
         bzoZFlwtxVeniRpeo648pc4Fniv+Xah1i+ikBwkqcFXtASBoo887q79f+Bi71JAK3qrn
         RqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sdObAKU/YVKmkTc1NFiJRCVh2RCXQ1Z2IPGbWGuXKTE=;
        b=obapZMNrj8tp1NRvZ1rlJd6qIDwlVgdImMjTO/PfVQgBh+1ZhthW4nBEyEulpDmHD6
         QbRc17K3uIR7MS6i5VX7bkZ3WZkcxxgZCePkS9htNvSEF3eNrJDlybwM86gfWBB8bf7h
         rjerRcZQ4DBWeQL565+LDYmOYVM5RJzwVPGm7xxzpxlV6aopFPyWQfiWbVsbGVeaNhht
         XaMX+Onq8VKLQePqsRdPPb1x2dkokK9vijVqqM77/nMpLENMcqKKmX/gNChAkcx55gli
         61sygrNYvCddiQGTLWZUGv10v8XsjA9eBXEKMqupnToEIWhPtzzG1o5g2m8UUrm4jADP
         EDUQ==
X-Gm-Message-State: AMke39lV3RBtnLsYLB6J+0PiE6P6alzmtbO+5BrHwulH0GepK8rwK3+14+p1Yc+P4QalUA==
X-Received: by 10.223.142.34 with SMTP id n31mr15167057wrb.11.1488218446855;
        Mon, 27 Feb 2017 10:00:46 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:45 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 07/22] t1700: add tests for core.splitIndex
Date:   Mon, 27 Feb 2017 19:00:04 +0100
Message-Id: <20170227180019.18666-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index cb68b8dc1e..1659986d8d 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -200,4 +200,41 @@ test_expect_success 'unify index, two files remain' '
 	test_cmp expect actual
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
2.12.0.22.g0672473d40

