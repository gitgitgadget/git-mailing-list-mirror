Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08FFB1F406
	for <e@80x24.org>; Sat,  9 Dec 2017 20:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbdLIUkk (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 15:40:40 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34357 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdLIUkg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 15:40:36 -0500
Received: by mail-wm0-f65.google.com with SMTP id y82so8462229wmg.1
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 12:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Q6HdqHoihfE4OjztgXSvgFFEEqlAPhJDK2NdAQDAuI=;
        b=IY5ozFKzxCccIjvxkovWqs7VTsrtvTYz1vetqvMAE9+IVDvqttzV6c3rmsbmB+xmJ3
         rafsuOJJkzrppEs6sjackSyojsFtQsTeynreO2paMzeYoiCE/QeO1jTGZA777AHknWPg
         29HCyF3J8UZtbuCEBdhZAWSa05DoEu2d/HisqXfmfEHiuvKvLlz7nee51tR9LrxYPARH
         2clVSjmtmPyk/Pp6CEJEN7s8Zpc4aJK/CEFCiXdQf4fNGV96CVlSiLoJaMTdVWlrJaB1
         6Xfrem66BX1kQg3JTI5rM+SAoUZ+RHqZaVJz0rrl1H0DfWVoi+DtHI9FDQZ2hND1LF2q
         vD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Q6HdqHoihfE4OjztgXSvgFFEEqlAPhJDK2NdAQDAuI=;
        b=kMSjpWUYiaYardhMHKgkxwqwQUyGGa/8+3GdtWp+vhLz6z9jgdEhe63XFv2iPWh7V4
         RReEX7HnfTiDUOloQV0iJ83ok9jPQY8EOzoBny5T9ntX6WNYiWI3a7sqFIhbSo17MOLw
         jcYLQ7uMiNK168tuGgqGHFkpruK5rlYBBEyxdxABswpJohnu8xICwpcHfGsJw+GyLGvO
         ev+zcOPp0/DveXDC76IJnMTkMfKSH65XdYm4g7hSPAgPl2q/of0WYw2rRclqLnR3882b
         OKfJ5SBRbmfT6VtJX9sdGvk3cFl9fbRf1ZB3o91PNG9ESVsTd+YkC7yh5aqUmuHbyLe3
         CUbw==
X-Gm-Message-State: AKGB3mJ65Kr19NDjWrAbYeECXNysNRSBjYYY8+0RQX2nWXIyXHvE5pqb
        aDGzpdkuMSGn+aT8X8rietrlJIg6
X-Google-Smtp-Source: AGs4zMZxEvElNQtEFoUe1z7gjelhBVDU9hcS02qT5cEqDqK4tAGuiVqYoA3CLC6Txw+k6VuAmMGgFg==
X-Received: by 10.28.144.10 with SMTP id s10mr6437967wmd.103.1512852035338;
        Sat, 09 Dec 2017 12:40:35 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id v18sm12491283wrv.37.2017.12.09.12.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Dec 2017 12:40:34 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Donald R Laster Jr <laster@dlaster.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 6/7] diff: add tests for --relative without optional prefix value
Date:   Sat,  9 Dec 2017 21:40:12 +0100
Message-Id: <20171209204013.10997-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171209204013.10997-1-chriscool@tuxfamily.org>
References: <20171209204013.10997-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

We already have tests for --relative, but they currently only test when
a prefix has been provided. This fails to test the case where --relative
by itself should use the current directory as the prefix.

Teach the check_$type functions to take a directory argument to indicate
which subdirectory to run the git commands in. Add a new test which uses
this to test --relative without a prefix value.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t4045-diff-relative.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 3950f5034d..7d68a6e2a5 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -13,6 +13,7 @@ test_expect_success 'setup' '
 '
 
 check_diff() {
+dir=$1; shift
 expect=$1; shift
 cat >expected <<EOF
 diff --git a/$expect b/$expect
@@ -24,50 +25,54 @@ index 0000000..25c05ef
 +other content
 EOF
 test_expect_success "-p $*" "
-	git diff -p $* HEAD^ >actual &&
+	git -C '$dir' diff -p $* HEAD^ >actual &&
 	test_cmp expected actual
 "
 }
 
 check_numstat() {
+dir=$1; shift
 expect=$1; shift
 cat >expected <<EOF
 1	0	$expect
 EOF
 test_expect_success "--numstat $*" "
 	echo '1	0	$expect' >expected &&
-	git diff --numstat $* HEAD^ >actual &&
+	git -C '$dir' diff --numstat $* HEAD^ >actual &&
 	test_cmp expected actual
 "
 }
 
 check_stat() {
+dir=$1; shift
 expect=$1; shift
 cat >expected <<EOF
  $expect | 1 +
  1 file changed, 1 insertion(+)
 EOF
 test_expect_success "--stat $*" "
-	git diff --stat $* HEAD^ >actual &&
+	git -C '$dir' diff --stat $* HEAD^ >actual &&
 	test_i18ncmp expected actual
 "
 }
 
 check_raw() {
+dir=$1; shift
 expect=$1; shift
 cat >expected <<EOF
 :000000 100644 0000000000000000000000000000000000000000 25c05ef3639d2d270e7fe765a67668f098092bc5 A	$expect
 EOF
 test_expect_success "--raw $*" "
-	git diff --no-abbrev --raw $* HEAD^ >actual &&
+	git -C '$dir' diff --no-abbrev --raw $* HEAD^ >actual &&
 	test_cmp expected actual
 "
 }
 
 for type in diff numstat stat raw; do
-	check_$type file2 --relative=subdir/
-	check_$type file2 --relative=subdir
-	check_$type dir/file2 --relative=sub
+	check_$type . file2 --relative=subdir/
+	check_$type . file2 --relative=subdir
+	check_$type . dir/file2 --relative=sub
+	check_$type subdir file2 --relative
 done
 
 test_done
-- 
2.15.1.361.g8b07d831d0

