Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5ED4200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755629AbcLZKWw (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:22:52 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:34719 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbcLZKWr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:47 -0500
Received: by mail-wj0-f194.google.com with SMTP id qs7so10343200wjc.1
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HujMjXiPJd7rmJobQpjBBBUAknP7mltW6zF7Sx2d0x4=;
        b=cYqsTwUJo8KaWmVhyW0hCuNFOhR8BaqNFTot8Sd2p+5FTpl3Mvc9KES4JXhvCsk4MA
         fgzmncr3eqUavshAdMi586ewepDFdhbvFWadOFUleb16wOo7a4zc4jvfPBZKRqXdiB4r
         8GjNREwGBCk+8MXe5VvriU4xib9viGUB7TlDOnoHb3EiXX4yXqVZn7pO3rENwFuw2ZG8
         giOEH4N+isuT86bmgvaYa7ZWTfoFCO6k92oxaQm4Q3qYSElaOH8Cna0q4bkvAFQjuw4n
         pa2G8pDa9FcQvTArtV5EjvQmJQ4NGhGQ5noZdmuqtYpgwsmfX1sxBzDPdIDtlZu0pAbX
         QQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HujMjXiPJd7rmJobQpjBBBUAknP7mltW6zF7Sx2d0x4=;
        b=kejU/SF8Qmfd7SLGDJ51wdjoEdAMp8O7b0cHYMTpbB+3tO7R2Q0YrldWo1ULOlqrKo
         IB8s9TVtWe32L9XjyPS+pXDi9ojR+eG0bfr+0C9xHKkYPHbHHbAirC8p/nKFk+EeqRs+
         vsZ60lLQHm8XvlQKbUVZKTVSW3KwimDqz7CWE+FJKVCIz6C0gcu0bXnOHGUHvL4ZRge4
         X7eFqhmBJPJ//8dlpPrNMCXz+Ci3ikK3iT0ACtEmpQ2xWCEgbhGuwkhhKQoOhqOHAvhr
         +gnm/qUPmSyQxPAWEjRCeuQbqiFOWsK27syzg0ImArsnFMXbis7p7PmykBPjrQolQM3A
         dE+g==
X-Gm-Message-State: AIkVDXJcdv+hECAVEjxHf6n6uv4fgMbdEuH8uu2EHvyDvYaQiTuKbNiHvabUl2K3TOhmtA==
X-Received: by 10.194.246.170 with SMTP id xx10mr23153084wjc.174.1482747765831;
        Mon, 26 Dec 2016 02:22:45 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:45 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 11/21] t1700: add tests for splitIndex.maxPercentChange
Date:   Mon, 26 Dec 2016 11:22:12 +0100
Message-Id: <20161226102222.17150-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 507a1dd1ad..f03addf654 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -238,4 +238,76 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'set core.splitIndex config variable to true' '
+	git config core.splitIndex true &&
+	: >three &&
+	git update-index --add three &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+replacements:
+deletions:
+EOF
+	test_cmp expect actual &&
+	: >four &&
+	git update-index --add four &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	four
+replacements:
+deletions:
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
+	git config --unset splitIndex.maxPercentChange &&
+	: >five &&
+	git update-index --add five &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+replacements:
+deletions:
+EOF
+	test_cmp expect actual &&
+	: >six &&
+	git update-index --add six &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	six
+replacements:
+deletions:
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check splitIndex.maxPercentChange set to 0' '
+	git config splitIndex.maxPercentChange 0 &&
+	: >seven &&
+	git update-index --add seven &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+replacements:
+deletions:
+EOF
+	test_cmp expect actual &&
+	: >eight &&
+	git update-index --add eight &&
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
 test_done
-- 
2.11.0.209.gda91e66374.dirty

