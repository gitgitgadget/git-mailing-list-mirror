Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2028E1FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758103AbcLQO4Z (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:25 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:34810 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757814AbcLQO4W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:22 -0500
Received: by mail-wj0-f193.google.com with SMTP id xy5so17992006wjc.1
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jodYtiJyudZ35AQ2MYJr7HA0VAYdzm9u2+PuxX2/Vm4=;
        b=k4v6QTWjIkj9GK/sAPzXGjkS9McT5sP8tdKbBQVbMECGSZCw+5BNcN9q8uBvBsA/aY
         uVyvlw7Jzh9QHYhRa/LBztdS1hmPmYcvm5Sa4wU81cnQ9a/P9JDASDnTO/LtaE9Sg6lt
         HUX1NWRrWLHYHN76NcmMi126iisangNHw0QEwfJYsJR3l1eG7W/i+XrukQMjbkB3wW5f
         okdqKxIkMJaRzFzJdXPrkVcU6GuDCcwCaXbMaKd8KeRTUHvuTJKN3cmIrri4T/HtjE/M
         7Wqz1x4S7tfRoeR7Sa7wRguuCtzPtF+Dn6cB3quLKnA981YE6be0D5tGNHnWFmKzgzrV
         0qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jodYtiJyudZ35AQ2MYJr7HA0VAYdzm9u2+PuxX2/Vm4=;
        b=A7Yowv2/y6Db+cTC+Y6NXhMXClmkgaIR/SHhFP4IYcOaZEqUhIjIj43xepXcxBYGuJ
         V0lBVrJsW5ui+H7nOEJqkXRhqB13xI8ahtVjVvtXq+cYg8fRAfQq52wVawKyAQ9yFE2d
         hHG35cUQlhTSEPI90kB21zbDU62rGXO6xWw2mu+dlmOF0lu9K2ilWjNLbtBdDTpbhUVr
         00GTU6MwgmblYskay38Ma+t1lvcVvs4Pm3iZlxJjPI3sN5z7HPg6iJq83TkAqOj8aAWK
         +gbjVRJYSU20N9fZwLmAL142aDvbe5bVpm4uAzuW+hJCofK2uT2tZ/VP+xBNaulKADja
         McEw==
X-Gm-Message-State: AKaTC01oKrgimc9enrbNumli0xTG4jL5vR8KgE80rIzR+lvdGbGOK5WcWEhcIA5FWdbm7Q==
X-Received: by 10.194.171.66 with SMTP id as2mr8414940wjc.77.1481986575705;
        Sat, 17 Dec 2016 06:56:15 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:14 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 11/21] t1700: add tests for splitIndex.maxPercentChange
Date:   Sat, 17 Dec 2016 15:55:37 +0100
Message-Id: <20161217145547.11748-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
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
2.11.0.49.g2414764.dirty

