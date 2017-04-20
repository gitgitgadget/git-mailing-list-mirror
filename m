Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5405E207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944914AbdDTL1w (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:27:52 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33452 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031886AbdDTL1l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:27:41 -0400
Received: by mail-io0-f196.google.com with SMTP id k87so15234126ioi.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIx/uGS6Z7c8D5GCrLzbzDI9GEetbrppHmXwkbIk9Ew=;
        b=r2r8bkEoAXaooBszNbVLShGNkcFtgrTxTqjdjZFOS7LV0LlTCtPFzavgAFRGjqCVT7
         8CYxoesXrG6EGXYDgWQ1fJkoHpUmlay1X5tq8k23QQ/Vpws0H03Xj0xhgDEExEdYs1EX
         1mloL9B/3n5K6pjLS4aTyQg9FFoJsMcGo88eCLWw2XWh5/z52PUKvTcbzKG2AWzlGbIA
         +M5E4AifOrBrwb1JFF/FsoQwOEzCmxzHgEXytfDGDsjobmhm+Rhzaq95idWj44J5NsML
         K3M5rq/1oYGmTk4nSlYCrzHzMsXuyGiUtWedwTWOOKdqIcwFsKPoqE4Ea+05wGLPKP+k
         xvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIx/uGS6Z7c8D5GCrLzbzDI9GEetbrppHmXwkbIk9Ew=;
        b=ZVAHrb3zwjdhrLHpRrktqaiTAe/iy1NZFpdFXR/TYIvSuJBkbxZDxPZWesLwEFda+9
         PUAH1gA0gTZeDAOPy4Gdwv1Rfr5uYWr5ZnTZBK8dFJqpD4ZR+3U8M/vayo0fZODX/DJn
         lvKpb5XgvUK/7oOTuQG/M32Oe00VhbBcbf1MvTEiYKQAenYK97zoyBA7wATdvppez/0C
         LC/GJGdMsmhliwk7pu8YrDURZ29b0E1xkJSLukbkSr/51OY+Cr4yaDSo5M9VGp1wz51x
         djiFtLmIhNZN604KYOXZcK3ioEWJDEDNQBzevkoSSPxWcwJDbP9bTIUxIQnYrsf0RaCR
         QUuA==
X-Gm-Message-State: AN3rC/7CIY2nXeWWubMMsnQ7yxOVlTAPXdXHcbS7mINnLK2KU/haSVhx
        h0R0dXFlqjv+IQ==
X-Received: by 10.98.133.78 with SMTP id u75mr7582922pfd.261.1492687660318;
        Thu, 20 Apr 2017 04:27:40 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id z5sm10048892pff.73.2017.04.20.04.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:27:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:27:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/15] t1308: add a test case on open a config directory
Date:   Thu, 20 Apr 2017 18:26:09 +0700
Message-Id: <20170420112609.26089-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420112609.26089-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
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

