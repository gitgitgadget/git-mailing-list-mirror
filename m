Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AF871F453
	for <e@80x24.org>; Sat, 19 Jan 2019 23:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfASXYQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 18:24:16 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44364 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbfASXYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 18:24:16 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so11837062oig.11
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 15:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NVpLm8zt4mqkBiwvwti1T/4jQszzhNoXc+dS8HWMqVk=;
        b=Ynp5PWDJ02tKvK1ybG+p4e+5z4CXdiXbdll7bgqpA6Dp5BzwZRNb1FEp3zdwjWfH4l
         u8w0JZ6qCNzcZYVd2dMGJBxxJmrBVsOchAHVN62c5Uu/06xTRbseqSLw9qlu6Ex/M2Mo
         z1mIzbXDsZXwOAgxl7Nq4AYNKAOY3O+NgePgzYEoIkR0wEkJKYexhT+FATa9RkvJV7xI
         1/xuN/AS7dcfbDLG2DSr97UNHfwOP/zx8iEa7W/j1xYs16A5TKxbrjJK1xErDOXWFs5j
         WWe5gPg3WJ7tk3wV1/WIDFqJTP76IUYJ+gKZtfgD+TW/SglPK33jYAfFEA0Cob7rWnCi
         rbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NVpLm8zt4mqkBiwvwti1T/4jQszzhNoXc+dS8HWMqVk=;
        b=aw6GSzJHG0ie0OGr7dePfJMiFP1LbtuyYf9CP3cXjXHbfhbX+HiMfOHR6yEyoxxPQM
         p0IRf5DX1oVSZ3KKk8myDfRBdW3usqfzyRMoYOX+i+9OglriK+YtDQi9dPtl1bNkw34w
         FwMl7IojlA4WunrnjsRO+xprND1AAKBAQ5mGTEQUu2uTi//LteNTuraUFrSQGzTQy7PK
         SV8cS1awiFSKchRwpV3+o8v+k7VACKEYjIgt0puLnLyGaCRv3uzm3dILw7L4uyJOMS5y
         bcQiB+u2xF4U/duyoVRDHBNkwmUYFznonKuy90g7dHgwGwOWTZYfeMtYMtKL9rapTUEA
         Ut7g==
X-Gm-Message-State: AJcUukfr6IlTJHlNGJTM221EotukKaEQtoxSXPSSV+B4mDa7ecTZ2ayA
        HsLO6JNiC4ULIqPF/S0ZTJ/6vlkKnKujkQ==
X-Google-Smtp-Source: ALg8bN44B4+U3hwPB6KoYyCgtmuGvEThLtTjv/4XcLaYQCI5InDuBZdXUm+Hf5hXmRxKf7tajdxxPw==
X-Received: by 2002:aca:293:: with SMTP id 141mr2031508oic.28.1547940254429;
        Sat, 19 Jan 2019 15:24:14 -0800 (PST)
Received: from localhost.localdomain ([165.231.210.5])
        by smtp.gmail.com with ESMTPSA id q131sm4217385oih.1.2019.01.19.15.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 19 Jan 2019 15:24:13 -0800 (PST)
From:   Brandon Richardson <brandon1024.br@gmail.com>
To:     git@vger.kernel.org, martin.agren@gmail.com, gitster@pobox.com
Cc:     Brandon Richardson <brandon1024.br@gmail.com>
Subject: [PATCH v4 1/2] t7510: invoke git as part of &&-chain
Date:   Sat, 19 Jan 2019 19:23:33 -0400
Message-Id: <20190119232334.31646-1-brandon1024.br@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Ågren <martin.agren@gmail.com>

If `git commit-tree HEAD^{tree}` fails on us and produces no output on
stdout, we will substitute that empty string and execute `git tag
ninth-unsigned`, i.e., we will tag HEAD rather than a newly created
object. But we are lucky: we have a signature on HEAD, so we should
eventually fail the next test, where we verify that "ninth-unsigned" is
indeed unsigned.

We have a similar problem a few lines later. If `git commit-tree -S`
fails with no output, we will happily tag HEAD as "tenth-signed". Here,
we are not so lucky. The tag ends up on the same commit as
"eighth-signed-alt", and that's a signed commit, so t7510-signed-commit
will pass, despite `git commit-tree -S` failing.

Make these `git commit-tree` invocations a direct part of the &&-chain,
so that we can rely less on luck and set a better example for future
tests modeled after this one. Fix a 9/10 copy/paste error while at it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Brandon Richardson <brandon1024.br@gmail.com>
---
 t/t7510-signed-commit.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 86d3f93fa..58f528b98 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -49,9 +49,13 @@ test_expect_success GPG 'create signed commits' '
 	git tag eighth-signed-alt &&
 
 	# commit.gpgsign is still on but this must not be signed
-	git tag ninth-unsigned $(echo 9 | git commit-tree HEAD^{tree}) &&
+	echo 9 | git commit-tree HEAD^{tree} >oid &&
+	test_line_count = 1 oid &&
+	git tag ninth-unsigned $(cat oid) &&
 	# explicit -S of course must sign.
-	git tag tenth-signed $(echo 9 | git commit-tree -S HEAD^{tree})
+	echo 10 | git commit-tree -S HEAD^{tree} >oid &&
+	test_line_count = 1 oid &&
+	git tag tenth-signed $(cat oid)
 '
 
 test_expect_success GPG 'verify and show signatures' '
-- 
2.20.1

