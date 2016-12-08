Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBCCD1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 14:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbcLHOYd (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 09:24:33 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34102 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbcLHOYb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 09:24:31 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so3878918wme.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 06:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dOCsal4LJeOdtxek7crpkVy92H5K01O81dugYfGlPh4=;
        b=gzwM1biVG1kMqZPd1feZR4lpy0+3vTjdaFKneS82NvVa0x8jqmjHmQlZLfMrDxdUY5
         fXKZ5HK+akyW8LzFyBrIo5eSve6j9/d2f7Jn3w+rZtl+Z1MYER9AIYcMWoLH4JjPTQGx
         iv0gIRxlJ/0r/qOzafMGDACCZ/k1FatQnufE/zmxq4e1UslhBDsmzf8Xu2PK3oguSqLJ
         wxJnmJyUiE14WiumfN3ZyJecwYPkJmvVG4mkwxz0HkBk6WmJUULeoZPA45LSN0IGcHWd
         dfBmIjc7aSfwkaQzqMeHVCtsPp/LC4YC58PYEO/3KqH/w3hXJ+0m2BitGOcz1fcbnQp+
         BkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dOCsal4LJeOdtxek7crpkVy92H5K01O81dugYfGlPh4=;
        b=bRdVvzXFRPCiLBILfcP/Z5ONuh9PDocCmUHFZV2KlCV3P7O2wmhog7SbesumQwS0CV
         Fzn09dRpiwHAhSGUWT9BPn7Ruv6FCtywDn8Z+Jq/kJS1S+QetXa4DWOvLSKkUkIFu74z
         cLGhcWtlSkdvVFotP82F6YnyeFqRzvSerPzkmsCctIZPchh4seQ3hzJt04SD+x+VT4JB
         K1bYMOYqcjkZ5njNXWpzxs6BugRMuSrehTC09MoPFslGdEs2/1gZJlpGAkqV10zqGu/L
         g1QNg+a4bZ6MQ9ov9/vpEPVn0UrEBOEYHzoyRCBCILORRwhR+1cjecjvpRg3KsAYqr9I
         u2Ug==
X-Gm-Message-State: AKaTC01MT15gcCuN6rvLcBcuCnkwJNYQ0F10ITNvlOj+F9/5gRK54ZnuAh/PSzdLnfjEvQ==
X-Received: by 10.28.166.20 with SMTP id p20mr2574107wme.87.1481207070167;
        Thu, 08 Dec 2016 06:24:30 -0800 (PST)
Received: from localhost.localdomain (x590d68ae.dyn.telefonica.de. [89.13.104.174])
        by smtp.gmail.com with ESMTPSA id l67sm15464028wmf.20.2016.12.08.06.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 06:24:29 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Leho Kraav <leho@conversionready.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 3/7] t7004-tag: add version sort tests to show prerelease reordering issues
Date:   Thu,  8 Dec 2016 15:23:57 +0100
Message-Id: <20161208142401.1329-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.78.g5a2d011
In-Reply-To: <20161208142401.1329-1-szeder.dev@gmail.com>
References: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
 <20161208142401.1329-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Version sort with prerelease reordering sometimes puts tagnames in the
wrong order, when the common part of two compared tagnames ends with
the leading character(s) of one or more configured prerelease
suffixes.  Add tests that demonstrate these issues.

The unrelated '--format should list tags as per format given' test
later uses tags matching the same prefix as the version sort tests,
thus was affected by the new tags added for the new tests in this
patch.  Change that test to perform its checks on a different set of
tags.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t7004-tag.sh | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 920a1b4b2..6445aae29 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1538,6 +1538,32 @@ test_expect_success 'reverse version sort with prerelease reordering' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'version sort with prerelease reordering and common leading character' '
+	test_config versionsort.prereleaseSuffix -before &&
+	git tag foo1.7-before1 &&
+	git tag foo1.7 &&
+	git tag foo1.7-after1 &&
+	git tag -l --sort=version:refname "foo1.7*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.7-before1
+	foo1.7
+	foo1.7-after1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_failure 'version sort with prerelease reordering, multiple suffixes and common leading character' '
+	test_config versionsort.prereleaseSuffix -before &&
+	git config --add versionsort.prereleaseSuffix -after &&
+	git tag -l --sort=version:refname "foo1.7*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.7-before1
+	foo1.7-after1
+	foo1.7
+	EOF
+	test_cmp expect actual
+'
+
 run_with_limited_stack () {
 	(ulimit -s 128 && "$@")
 }
@@ -1566,13 +1592,11 @@ EOF"
 
 test_expect_success '--format should list tags as per format given' '
 	cat >expect <<-\EOF &&
-	refname : refs/tags/foo1.10
-	refname : refs/tags/foo1.3
-	refname : refs/tags/foo1.6
-	refname : refs/tags/foo1.6-rc1
-	refname : refs/tags/foo1.6-rc2
+	refname : refs/tags/v1.0
+	refname : refs/tags/v1.0.1
+	refname : refs/tags/v1.1.3
 	EOF
-	git tag -l --format="refname : %(refname)" "foo*" >actual &&
+	git tag -l --format="refname : %(refname)" "v1*" >actual &&
 	test_cmp expect actual
 '
 
-- 
2.11.0.78.g5a2d011

