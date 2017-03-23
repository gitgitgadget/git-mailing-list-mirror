Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DBC920958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934526AbdCWNHO (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:07:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33841 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754013AbdCWNHM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:07:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id y90so7323551wrb.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXHvC8QxRqz2D6ulYgWFyHitCP72Aoo1YQSGMdx8ewQ=;
        b=occPHQphyU8vRrSoGfGiD1La/LuSDiWSo97ZXoIZqtionisL8sEEZR+uZI49YuPpDJ
         lYNNi8p0tzgr65tLTqa0LESoQrIqZgYSgEjQcVRyi2ebSn4yVOTcElASbaDmcT7Mj4K7
         0wnJdprGsG7lY0yhTedIDrFp8VxJmUDy6NxgOuLrfhj69CNntlJGRqudDZP+VnYkWRpc
         7TZ8rBu4QI4RMPaJSNdwDIkHSHDVmanS4ggMLVcakvhsOUgqEUSdueKcc9I46b8iMHp6
         CjtnWYWz+BZh8Sh/G0O4dXkJbcxeZ94iQYm2fZ+4CBL1QArxlyv2ele7ptM98osLIP9W
         gQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXHvC8QxRqz2D6ulYgWFyHitCP72Aoo1YQSGMdx8ewQ=;
        b=hR9t2QFKuOVXQipC+j9VWkmecIAFiLIoltZyya1c/SCZgWfYGPZ1q6zgv/r0oqNHzh
         PwiRd2RKsWDxfJsDFtgjmAhVAqtVpP1hNmsXKOaTl35qsxVMukfPA5q3WAq+jklCXQvl
         A2PZgCAHbnw8VhuUVDsaO99rPX9jHLm+vE9r6qdvwVuLqgeAAXX6uYG9rt0Vx2AM0J50
         r/wZLFFnaU5v9TZMYM9dFlKURofM3Hheg6eDQi0yFX9Hs4cpXX5VEC7bUYy5SkhfqFB7
         wFfwywa/L25X58sE2xZ6i8KXS2jj260JMIog9Ej02pLtOJTv7gySctZfZgj798fxSfZE
         a9sA==
X-Gm-Message-State: AFeK/H0FFb1Yrv0/kCaFi0hZAP43XMNghOGO9Z9AMNtI+lP9DQnQHUR6DaKaLie7UUdCPg==
X-Received: by 10.223.143.68 with SMTP id p62mr2474435wrb.2.1490274425753;
        Thu, 23 Mar 2017 06:07:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:07:04 -0700 (PDT)
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
Subject: [PATCH v3 16/16] tag: add tests for --with and --without
Date:   Thu, 23 Mar 2017 13:05:29 +0000
Message-Id: <20170323130529.11361-17-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170323130529.11361-1-avarab@gmail.com>
References: <20170323130529.11361-1-avarab@gmail.com>
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

