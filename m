Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6C701FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965222AbdCXSl6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:41:58 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35848 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965044AbdCXSlz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:41:55 -0400
Received: by mail-wr0-f195.google.com with SMTP id u1so1658294wra.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sPzMPaIQ4O/OdVyltoMv0aeWceLmrE7iXvBtp3jYqGQ=;
        b=rAqL7CbEXY0TPO7seC+A+ZYVLxiZ5gzUpw6eMAOZLrf/dDFm28xVkAxDa8WhkKiFeg
         S1BhHmPoEaa/qFuqGAraqLjI1beDcjSDp7VjbIErEaqa/uSR8J0/9yF8QuvgIjrs+gPC
         Kdo+BK/rreowzy+EPvoydW8I9Aim7fFMBW6fH1wnYopdzUOMpeUNd7OcGxnRz2nlBvxm
         mU7OLPS1gfUpXghW5Fio6D9mROW7qyl5J+V91RhLHlt6r77rWWjcl8vnM7iyLMD1cn8d
         35FnUm3McfGOfRPqs1JHAQ1eibJMNs1zfYQ5AYG6WewL3Ycf6/e/naqXg/25GgurozCs
         TWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sPzMPaIQ4O/OdVyltoMv0aeWceLmrE7iXvBtp3jYqGQ=;
        b=pu2n5nMfYPdap2QL1911jGMfNBzrdIqn+uiw/q3TI2yUOTQUUGFX0/OiWuc+Nfs1LW
         LXvC5aLXeps7Hp0jHHkSp7qE0I1RxAaWQTWapcs58JkNjEVOMWKBHdKrezadwo614o6b
         /vVq9cVYobIAGOmJBGQd2I3gsJdBFIPqKvEicQ1ITpbwYzHo9VDgODRntntB7Db8mI5+
         OIMOlLdaV8I0SCKE/gbY7WgZ4j5bdcqF/JRagxtRLTr4bHnk+C2mr6gPRkbz23P/zXMz
         ZUDcvxpbP+xLl+rZtEOw5QonAnC01WGuqsv9BxPwZZMZfQ+6MJGgoh4wFmeFQKWqsjng
         eRyQ==
X-Gm-Message-State: AFeK/H1EkG7aZOYBRyMl4hWxnaNLY5WQ6pYdWzCD5LCMua/8z3rbDlFXj6OWIrG4IVW3Lg==
X-Received: by 10.223.163.131 with SMTP id l3mr9277447wrb.138.1490380903195;
        Fri, 24 Mar 2017 11:41:43 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j77sm3440560wmj.3.2017.03.24.11.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 11:41:42 -0700 (PDT)
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
Subject: [PATCH v4 09/16] tag: add more incompatibles mode tests
Date:   Fri, 24 Mar 2017 18:40:52 +0000
Message-Id: <20170324184059.5374-10-avarab@gmail.com>
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

Amend the test suite to test for more invalid uses like "-l -a"
etc.

This change tests the code path in builtin/tag.c between lines:

    if (argc == 0 && !cmdmode)

And:

    if ((create_tag_object || force) && (cmdmode != 0))

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7004-tag.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 63ee2cf727..92af8bb7e6 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1455,8 +1455,24 @@ test_expect_success 'checking that initial commit is in all tags' "
 
 test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag -a &&
+	test_must_fail git tag -a -l &&
+	test_must_fail git tag -s &&
+	test_must_fail git tag -s -l &&
+	test_must_fail git tag -m &&
+	test_must_fail git tag -m -l &&
+	test_must_fail git tag -m "hlagh" &&
+	test_must_fail git tag -m "hlagh" -l &&
+	test_must_fail git tag -F &&
+	test_must_fail git tag -F -l &&
+	test_must_fail git tag -f &&
+	test_must_fail git tag -f -l &&
+	test_must_fail git tag -a -s -m -F &&
+	test_must_fail git tag -a -s -m -F -l &&
 	test_must_fail git tag -l -v &&
+	test_must_fail git tag -l -d &&
+	test_must_fail git tag -l -v -d &&
 	test_must_fail git tag -n 100 &&
+	test_must_fail git tag -n 100 -v &&
 	test_must_fail git tag -l -m msg &&
 	test_must_fail git tag -l -F some file &&
 	test_must_fail git tag -v -s &&
-- 
2.11.0

