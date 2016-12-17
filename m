Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E7611FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757336AbcLQO4N (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:13 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:36667 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757128AbcLQO4L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:11 -0500
Received: by mail-wj0-f195.google.com with SMTP id j10so18022371wjb.3
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uJgpAk/FbOXHTRWCA5nyIeZO0HFQgf7aUJsKw0H7PfY=;
        b=ucxqFe1xZ3LhvHkEDu3xkKUOl7RxfpoDackBy6kTEDJl2lD0f7HHUsd37GeCaVYGqE
         ft5JwY3CqEV6stJpWkcD7gd0pe4QIGr3NNW8J3Jdr3L0as64Ajb7Jznhi6fDAnZxt8zI
         aGFbfGleUIicuLblmroexnffmqeeO3emwVgREIKAC3BHKQZeg0rp0AmlXnYf5+614Ay1
         ueK/Op22a2vNJXp8SVck52CMd9T+ZEDMY7Z23M1XaUL6ZaPkbisLp+104QfqyD3G/yms
         EYE6KtJ2hA0mnekJ3+iPidmkEhglFqASMLHPbUtIoYhZW4OF9DQouvEAbLCbovAZDpGI
         LrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uJgpAk/FbOXHTRWCA5nyIeZO0HFQgf7aUJsKw0H7PfY=;
        b=jUsLOT7jmT2g+8h6qIkRyjtRN89czKQfIZ7KOKo1Qpm9Sp241sw//A6TJchS1wPTPx
         7OZPmV/5oIZw9SaM63krYFfBcxNo34Uqh320/TDOgVbQ5D41Bhqtt6a9lpUpOg8FasHi
         zBNk3LeMnbm5XZ//eiEHu1/IM4xQY18GBVzX+8rB5RHyJIJoOlDpESw+xxMFtcRX8OWH
         vidbUNZ9qVfSDrAmZdlbGRE3dNHVgQWlDMYSyZ3yciXk9VwPKyIkTYoqDUyJeG59s5VJ
         v57alURjOcvpU6QYHKmByk1mWzwc8dQScsBSbjU+LYIIXnTKpH1x4wCtibRJDpv16M5y
         wqbA==
X-Gm-Message-State: AKaTC012ftJqTUEZchJ8mwqWnfDq+7/Lq1SnBvTqDsKqS65gVcgO92If0XGlM59mDEPZcg==
X-Received: by 10.194.108.10 with SMTP id hg10mr8395967wjb.58.1481986569943;
        Sat, 17 Dec 2016 06:56:09 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:09 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 06/21] t1700: add tests for core.splitIndex
Date:   Sat, 17 Dec 2016 15:55:32 +0100
Message-Id: <20161217145547.11748-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 292a0720fc..db8c39f446 100755
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
2.11.0.49.g2414764.dirty

