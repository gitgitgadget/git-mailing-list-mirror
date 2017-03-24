Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9CC1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965653AbdCXSmP (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:42:15 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36017 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965192AbdCXSmE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:42:04 -0400
Received: by mail-wr0-f193.google.com with SMTP id u1so1659407wra.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXHvC8QxRqz2D6ulYgWFyHitCP72Aoo1YQSGMdx8ewQ=;
        b=ElUVs+s5GvysYZ/WOEFTF6EBD6/uzs1i7K4N/i+b6Xs8NFw8/Z+QIr0xn6kJUhZQ+V
         W3GEii+KrnS+MudP9b43GxrDN89VrnlzQH/W6ODqzY3a9jedCA0+yZHLvwxprZBb4IQD
         fpMZYdxOoPzTxPUaWIm+5YdMPw5vcDAQresWfPOPZ7ufuJvOvWcjKDI96nOwud1c4nJW
         HSaZVU9YD6ZRszZBp/4wQvFW4ZdNUjGF7LdZ+NV+smpPwyihWBGQSyimg4LtdpLkBWLW
         LZjHnND8TX9qgit+NBPtHl676uE3hWphDzt6PUPeFVmpDiozv16JsYu3lsQAG6nXbtyE
         Dt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXHvC8QxRqz2D6ulYgWFyHitCP72Aoo1YQSGMdx8ewQ=;
        b=YmuRK19VtNshP3CqGmZ9rZxDzKFCTaBlOzsR4framJ2COhFbs885yA0KPH2W+Qqz9p
         L6RU6AaKGH8bedi5Mp1s3sLXBRdNKB7+iAw5g3s+mjDvn42dCSbU5E5Mre4+WVekF4CF
         f3fndziFx3Wwp7PBrYhi+4oBacjYG0nQXaqCHA8kMMVS7zwhyuSkFcCq38nuCfkdxxqr
         nBnEi1g+KDBWTESGwvpn+hCFrWun5/py6Ceos+l5jyswSAeisNQ4TXwOYmydNyzKX8fy
         YHVkA0IMLx7se57Yvz7YKIkj/fW06gK/QdegmyBel8YVsri2P1005M3IWUS11t59BbbJ
         gMfQ==
X-Gm-Message-State: AFeK/H0TqZ2w3kBQpTZrs9qK6r3EOQiuIex1O7nIEDawUExblVNjdyfSDEdmvS4MSINM7g==
X-Received: by 10.223.133.182 with SMTP id 51mr9573219wrt.39.1490380922267;
        Fri, 24 Mar 2017 11:42:02 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j77sm3440560wmj.3.2017.03.24.11.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 11:42:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 16/16] tag: add tests for --with and --without
Date:   Fri, 24 Mar 2017 18:40:59 +0000
Message-Id: <20170324184059.5374-17-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170324184059.5374-1-avarab@gmail.com>
References: <20170324184059.5374-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test suite to test for these synonyms for --contains and
--no-contains, respectively.

Before this change there were no tests for them at all. This doesn't
exhaustively test for them as well as their --contains and
--no-contains synonyms, but at least it's something.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7004-tag.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 8a6e8032da..6143113dbb 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1599,10 +1599,12 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag --contains tag-blob &&
 	test_must_fail git tag --no-contains tag-tree &&
 	test_must_fail git tag --no-contains tag-blob &&
-	test_must_fail git tag --contains --no-contains
+	test_must_fail git tag --contains --no-contains &&
+	test_must_fail git tag --no-with HEAD &&
+	test_must_fail git tag --no-without HEAD
 '
 
-for option in --contains --no-contains --merged --no-merged --points-at
+for option in --contains --with --no-contains --without --merged --no-merged --points-at
 do
 	test_expect_success "mixing incompatible modes with $option is forbidden" "
 		test_must_fail git tag -d $option HEAD &&
-- 
2.11.0

