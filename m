Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 439F91FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 14:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932262AbcLHOYs (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 09:24:48 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35955 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbcLHOYa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 09:24:30 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so3849811wma.3
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 06:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eq4/gXi3pQouGQOhUnp2uOZQRm234a5/8DEb3bup6wA=;
        b=fMhgkenXWIF3hqjyrDfKcdcC3eQRCDhjki2aUr3DyM/6m9p1n6Tdj+8Picrgy7sxS8
         BK/wqam+gl09whkUpC6eN46KX2wYBEf8FZrVj16928zb6POya9W8MIhdJHrFf8ljvx/F
         ZRHsV000MW8oxDQW1WsuSMRJCxeiS5KZsrr9UlA6bK3564EgzsYD3fQ0A4gNPExdb2OE
         UJ48JJhlgY31lKI+Id6HsUiBFruKLkTvwkmv5UUDjaSiooERccL1bPhEPQLoE49HzpvN
         E/1vlvZ6IVzXSGvyN81NRC5H72tMjD1vroP3lQb0UdxPLYqX8ULvJwrGijU+59s0tIS5
         ILFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eq4/gXi3pQouGQOhUnp2uOZQRm234a5/8DEb3bup6wA=;
        b=kj34uhtvr8H8xMp5HEFHLRWnaml1BETBQvyKRmpAqz6WJAzOoI36ulJ99UySc3aYW/
         51urVLJpAw3/Pdr5upftxEWXQOEXdGJP2UxANbwP1U6UqVFxSfSn/SfI8B/CZwKSTOQz
         3po4j64dNJWlJpNeedZ90LhchLrUk4bwKyDFUpSLfIbX5TXv1hjqhOvb7lOU2YISYFCw
         lbYJRJtvvjeBYOeipzmeo3owcuzMAPaZXPBb4UXeEAYUVyUiT0mO8rcQoEu/pjlTGnj8
         TQ/Yva0xVlY9RHBslNA/whg+alkmo2RVw8TL9S8/HlCGPYP20UkSAcZjufPrMR2G6TRV
         yJuw==
X-Gm-Message-State: AKaTC03KVPNWL4QfI26yGwfNxjXbZmvFy0byNRUsXYmDXyg3xfDAs8DO0o6+TX6tyKyitA==
X-Received: by 10.28.230.72 with SMTP id d69mr2556540wmh.119.1481207069215;
        Thu, 08 Dec 2016 06:24:29 -0800 (PST)
Received: from localhost.localdomain (x590d68ae.dyn.telefonica.de. [89.13.104.174])
        by smtp.gmail.com with ESMTPSA id l67sm15464028wmf.20.2016.12.08.06.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 06:24:28 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Leho Kraav <leho@conversionready.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 2/7] t7004-tag: use test_config helper
Date:   Thu,  8 Dec 2016 15:23:56 +0100
Message-Id: <20161208142401.1329-3-szeder.dev@gmail.com>
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

... instead of setting and then manually unsetting configuration
variables, on one occasion even outside the test_expect_success block.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t7004-tag.sh | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 396cffeeb..920a1b4b2 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -297,11 +297,9 @@ EOF
 '
 
 test_expect_success 'listing tags in column with column.*' '
-	git config column.tag row &&
-	git config column.ui dense &&
+	test_config column.tag row &&
+	test_config column.ui dense &&
 	COLUMNS=40 git tag -l >actual &&
-	git config --unset column.ui &&
-	git config --unset column.tag &&
 	cat >expected <<\EOF &&
 a1      aa1   cba     t210    t211
 v0.2.1  v1.0  v1.0.1  v1.1.3
@@ -314,9 +312,8 @@ test_expect_success 'listing tag with -n --column should fail' '
 '
 
 test_expect_success 'listing tags -n in column with column.ui ignored' '
-	git config column.ui "row dense" &&
+	test_config column.ui "row dense" &&
 	COLUMNS=40 git tag -l -n >actual &&
-	git config --unset column.ui &&
 	cat >expected <<\EOF &&
 a1              Foo
 aa1             Foo
@@ -1200,11 +1197,10 @@ test_expect_success GPG,RFC1991 \
 '
 
 # try to sign with bad user.signingkey
-git config user.signingkey BobTheMouse
 test_expect_success GPG \
 	'git tag -s fails if gpg is misconfigured (bad key)' \
-	'test_must_fail git tag -s -m tail tag-gpg-failure'
-git config --unset user.signingkey
+	'test_config user.signingkey BobTheMouse &&
+	test_must_fail git tag -s -m tail tag-gpg-failure'
 
 # try to produce invalid signature
 test_expect_success GPG \
@@ -1484,7 +1480,7 @@ test_expect_success 'reverse lexical sort' '
 '
 
 test_expect_success 'configured lexical sort' '
-	git config tag.sort "v:refname" &&
+	test_config tag.sort "v:refname" &&
 	git tag -l "foo*" >actual &&
 	cat >expect <<-\EOF &&
 	foo1.3
@@ -1495,6 +1491,7 @@ test_expect_success 'configured lexical sort' '
 '
 
 test_expect_success 'option override configured sort' '
+	test_config tag.sort "v:refname" &&
 	git tag -l --sort=-refname "foo*" >actual &&
 	cat >expect <<-\EOF &&
 	foo1.6
@@ -1509,13 +1506,12 @@ test_expect_success 'invalid sort parameter on command line' '
 '
 
 test_expect_success 'invalid sort parameter in configuratoin' '
-	git config tag.sort "v:notvalid" &&
+	test_config tag.sort "v:notvalid" &&
 	test_must_fail git tag -l "foo*"
 '
 
 test_expect_success 'version sort with prerelease reordering' '
-	git config --unset tag.sort &&
-	git config versionsort.prereleaseSuffix -rc &&
+	test_config versionsort.prereleaseSuffix -rc &&
 	git tag foo1.6-rc1 &&
 	git tag foo1.6-rc2 &&
 	git tag -l --sort=version:refname "foo*" >actual &&
@@ -1530,6 +1526,7 @@ test_expect_success 'version sort with prerelease reordering' '
 '
 
 test_expect_success 'reverse version sort with prerelease reordering' '
+	test_config versionsort.prereleaseSuffix -rc &&
 	git tag -l --sort=-version:refname "foo*" >actual &&
 	cat >expect <<-\EOF &&
 	foo1.10
-- 
2.11.0.78.g5a2d011

