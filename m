Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4601207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbdECKUA (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:20:00 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35886 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753434AbdECKT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:19:59 -0400
Received: by mail-pg0-f65.google.com with SMTP id v1so27637758pgv.3
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIx/uGS6Z7c8D5GCrLzbzDI9GEetbrppHmXwkbIk9Ew=;
        b=hbeRvevQCbAPvnDFM/Pwdt7qAyClFVBuB3ezrwBl8m6+9iD8ECvINZY6xts0+oOvbr
         gqc7nmdX1Uzm72sTmtYraxppBj+c6ad/RzyQJP7cIeFfcqYZ8jKtQK087loYVveKzCu3
         W9kN6GAWdRlY18slAbpFwwNYmSRv8DHGg6wqeETwgrMY3oYhoQDvsMWUlC1WwsY7monV
         JJgPrEtdmX2BmDadBi0AVrIIv2xMtuh0K1nA5rmAyJ46wmrAumht98p6G2TqUS8zHOR0
         a+6+gk/cqb4RoP2DvLbv96G2v/e0GGBZim6j2ocxX4nyvpL/r97MCv3t6ZEWY8srr8/q
         ZKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIx/uGS6Z7c8D5GCrLzbzDI9GEetbrppHmXwkbIk9Ew=;
        b=KqkX9NVaR4kxHvQcL4soWoUZRUbDOjgaLKa6BKwqyuyaItiRAYmdKqclYhZp8a17AN
         zh2QycHRI5nRN28FT6fBheEX1K1irWH8F/JRZ+VbdP8uf3JcwSfSFDOL+ijGzxv5A6zJ
         t2Nd7CKc3n+f5OtemRZ3H1ekvTStceFGQZQ/mbzH2KCVRgPRNU45iUr/5Bcg9JE7+6oV
         k+Rrq1zxOpx7g0BYgGu/snsD9CCVwatuGvmSRe3gxLs7LgXSHhU+xC92Oh9Vz6k8xHad
         UM9rdmICrg/doVC0DztXEkmE5eJKJCWQYol6teNQkWiBaRCPBq5du4G+xU2yX8rLxPDF
         uB1Q==
X-Gm-Message-State: AN3rC/4W9BEDSERig+n8l5NxoaFNliiI1TVWUqDPxpVSTYUlDbbFb34Y
        cnnjhjG7eYXHVQ==
X-Received: by 10.98.145.18 with SMTP id l18mr3967072pfe.173.1493806798564;
        Wed, 03 May 2017 03:19:58 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id f131sm3922890pfc.54.2017.05.03.03.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:19:58 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:19:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 21/21] t1308: add a test case on open a config directory
Date:   Wed,  3 May 2017 17:17:06 +0700
Message-Id: <20170503101706.9223-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170503101706.9223-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170503101706.9223-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't support config-as-a-directory (maybe someday we will?). Make
sure we consistently fail in this case, which should happen on platforms
where fopen(<directory>) returns non-NULL if FREAD_READS_DIRECTORIES is
defined.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t1308-config-set.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 13e95561f4..e495a61616 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -183,6 +183,15 @@ test_expect_success 'proper error on non-existent files' '
 	test_cmp expect actual
 '
 
+test_expect_success 'proper error on directory "files"' '
+	echo "Error (-1) reading configuration file a-directory." >expect &&
+	mkdir a-directory &&
+	test_expect_code 2 test-config configset_get_value foo.bar a-directory 2>output &&
+	grep "^warning:" output &&
+	grep "^Error" output >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success POSIXPERM,SANITY 'proper error on non-accessible files' '
 	chmod -r .git/config &&
 	test_when_finished "chmod +r .git/config" &&
-- 
2.11.0.157.gd943d85

