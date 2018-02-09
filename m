Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9CB71F404
	for <e@80x24.org>; Fri,  9 Feb 2018 02:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeBICnN (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 21:43:13 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36096 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752267AbeBICnI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 21:43:08 -0500
Received: by mail-wr0-f193.google.com with SMTP id y3so6741784wrh.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 18:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhWRRvGGOu9E+ZGOyJ4ROLMNwMkTRTWrKtKEWHp8BEE=;
        b=VGMTHiC++zg3dlbw2H/e8dka9k8G1PgO2aqiLCc8zWvY4ehmMPSMbc77/q87mpOusn
         snUKvZKuuSSUNE1ripNo1XMpnvm9xg4n8jEwUp2R5cpUw2rdDOfKhkI4b08sqEK+ihx7
         Ov3fIi7wQZqstEkBebHU0nfzriFLu9LIy5y6R9FGpby3FNxjjw0FfBXI4nYuxfc5tHin
         6nU6DPD5723sPXS4t75XgyuHeGf/DHV1nQEB2+8eeuEr9ZaZO337oS3lmqBbtznOOn8y
         Imkw7c7ntn/bhiqwcoAYJWT1IAdoo09fzqxlhuviAv+4pKWgjnfvH160GmA/2cYkku5l
         eYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhWRRvGGOu9E+ZGOyJ4ROLMNwMkTRTWrKtKEWHp8BEE=;
        b=ijcJHtudjKcpXEGRDFp9Pgca14uTOlkE5j8XftMtXfZseHDHyW4QxX5w6NeWVgT6WS
         KeL7jQHf7dXApxbgxAe12Flpw1OsNm/o54VBeOb8gPX1jQBqKR92lAzIl1aDHD0rR/6w
         sk9qM4nEIsN7maXlsBAkq3REbFaGumwuQjDrmNpAJhcpVtqLYidMvfDfmF1DTESFIY44
         zwHG3HBBT1k4zS9aJ4iQ8XzLDYZZeZcG8G7IOdBmzS25bXNKjDTIfLzX3TXwnanDtaxr
         kcT7iUwdJbxQyBUTd5Ry+CYE4iExjY+GT7dDxLVXfb7xHe485k5tWH6TIdXHA7bT0VxI
         uaXQ==
X-Gm-Message-State: APf1xPAEmxB/CC5sorP6W5uUDsLSqt3APXzHoHH32OPmWMnVoESjOHhe
        /o4u786gd0VM5b4rs525gUD1wQ==
X-Google-Smtp-Source: AH8x224xr0tQHb7OIBQoPuFvi5XGmYbsbRKOCh7xXOwarsKDY995iG+nZp0ASoJquyKSPPXFNbdVKA==
X-Received: by 10.223.154.72 with SMTP id z66mr1014207wrb.209.1518144186684;
        Thu, 08 Feb 2018 18:43:06 -0800 (PST)
Received: from localhost.localdomain (x4db2a6c8.dyn.telefonica.de. [77.178.166.200])
        by smtp.gmail.com with ESMTPSA id x18sm2226174wrg.82.2018.02.08.18.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 18:43:06 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/3] t1404: use 'test_must_fail stderr=<file>'
Date:   Fri,  9 Feb 2018 03:42:35 +0100
Message-Id: <20180209024235.3431-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.180.g07550b0b1b
In-Reply-To: <20180209024235.3431-1-szeder.dev@gmail.com>
References: <20180209024235.3431-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of 'test_must_fail git cmd... 2>output.err', which redirects
the standard error of the 'test_must_fail' helper function as well,
causing various issues as discussed in the previous patch.

With this patch t1404 succeeds when run with '-x', even with shells
not supporting $BASH_XTRACEFD.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1404-update-ref-errors.sh | 46 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 3a887b5113..91250bc6a0 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -26,7 +26,7 @@ test_update_rejected () {
 		git pack-refs --all
 	fi &&
 	printf "create $prefix/%s $C\n" $create >input &&
-	test_must_fail git update-ref --stdin <input 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin <input &&
 	grep -F "$error" output.err &&
 	git for-each-ref $prefix >actual &&
 	test_cmp unchanged actual
@@ -102,7 +102,7 @@ df_test() {
 	else
 		printf "%s\n" "delete $delname" "create $addname $D"
 	fi >commands &&
-	test_must_fail git update-ref --stdin <commands 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin <commands &&
 	test_cmp expected-err output.err &&
 	printf "%s\n" "$C $delref" >expected-refs &&
 	git for-each-ref --format="%(objectname) %(refname)" $prefix/r >actual-refs &&
@@ -337,7 +337,7 @@ test_expect_success 'missing old value blocks update' '
 	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
 	EOF
 	printf "%s\n" "update $prefix/foo $E $D" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -348,7 +348,7 @@ test_expect_success 'incorrect old value blocks update' '
 	fatal: cannot lock ref $Q$prefix/foo$Q: is at $C but expected $D
 	EOF
 	printf "%s\n" "update $prefix/foo $E $D" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -359,7 +359,7 @@ test_expect_success 'existing old value blocks create' '
 	fatal: cannot lock ref $Q$prefix/foo$Q: reference already exists
 	EOF
 	printf "%s\n" "create $prefix/foo $E" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -370,7 +370,7 @@ test_expect_success 'incorrect old value blocks delete' '
 	fatal: cannot lock ref $Q$prefix/foo$Q: is at $C but expected $D
 	EOF
 	printf "%s\n" "delete $prefix/foo $D" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -381,7 +381,7 @@ test_expect_success 'missing old value blocks indirect update' '
 	fatal: cannot lock ref $Q$prefix/symref$Q: unable to resolve reference $Q$prefix/foo$Q
 	EOF
 	printf "%s\n" "update $prefix/symref $E $D" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -393,7 +393,7 @@ test_expect_success 'incorrect old value blocks indirect update' '
 	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
 	EOF
 	printf "%s\n" "update $prefix/symref $E $D" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -405,7 +405,7 @@ test_expect_success 'existing old value blocks indirect create' '
 	fatal: cannot lock ref $Q$prefix/symref$Q: reference already exists
 	EOF
 	printf "%s\n" "create $prefix/symref $E" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -417,7 +417,7 @@ test_expect_success 'incorrect old value blocks indirect delete' '
 	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
 	EOF
 	printf "%s\n" "delete $prefix/symref $D" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -428,7 +428,7 @@ test_expect_success 'missing old value blocks indirect no-deref update' '
 	fatal: cannot lock ref $Q$prefix/symref$Q: reference is missing but expected $D
 	EOF
 	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -440,7 +440,7 @@ test_expect_success 'incorrect old value blocks indirect no-deref update' '
 	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
 	EOF
 	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -452,7 +452,7 @@ test_expect_success 'existing old value blocks indirect no-deref create' '
 	fatal: cannot lock ref $Q$prefix/symref$Q: reference already exists
 	EOF
 	printf "%s\n" "option no-deref" "create $prefix/symref $E" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -464,7 +464,7 @@ test_expect_success 'incorrect old value blocks indirect no-deref delete' '
 	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
 	EOF
 	printf "%s\n" "option no-deref" "delete $prefix/symref $D" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -477,13 +477,13 @@ test_expect_success 'non-empty directory blocks create' '
 	fatal: cannot lock ref $Q$prefix/foo$Q: there is a non-empty directory $Q.git/$prefix/foo$Q blocking reference $Q$prefix/foo$Q
 	EOF
 	printf "%s\n" "update $prefix/foo $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err &&
 	cat >expected <<-EOF &&
 	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
 	EOF
 	printf "%s\n" "update $prefix/foo $D $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -496,13 +496,13 @@ test_expect_success 'broken reference blocks create' '
 	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
 	EOF
 	printf "%s\n" "update $prefix/foo $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err &&
 	cat >expected <<-EOF &&
 	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
 	EOF
 	printf "%s\n" "update $prefix/foo $D $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -516,13 +516,13 @@ test_expect_success 'non-empty directory blocks indirect create' '
 	fatal: cannot lock ref $Q$prefix/symref$Q: there is a non-empty directory $Q.git/$prefix/foo$Q blocking reference $Q$prefix/foo$Q
 	EOF
 	printf "%s\n" "update $prefix/symref $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err &&
 	cat >expected <<-EOF &&
 	fatal: cannot lock ref $Q$prefix/symref$Q: unable to resolve reference $Q$prefix/foo$Q
 	EOF
 	printf "%s\n" "update $prefix/symref $D $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -535,13 +535,13 @@ test_expect_success 'broken reference blocks indirect create' '
 	fatal: cannot lock ref $Q$prefix/symref$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
 	EOF
 	printf "%s\n" "update $prefix/symref $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err &&
 	cat >expected <<-EOF &&
 	fatal: cannot lock ref $Q$prefix/symref$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
 	EOF
 	printf "%s\n" "update $prefix/symref $D $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
+	test_must_fail stderr=output.err git update-ref --stdin &&
 	test_cmp expected output.err
 '
 
@@ -612,7 +612,7 @@ test_expect_success 'delete fails cleanly if packed-refs file is locked' '
 	# Now try to delete it while the `packed-refs` lock is held:
 	: >.git/packed-refs.lock &&
 	test_when_finished "rm -f .git/packed-refs.lock" &&
-	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
+	test_must_fail stderr=err git update-ref -d $prefix/foo >out &&
 	git for-each-ref $prefix >actual &&
 	test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File exists" err &&
 	test_cmp unchanged actual
-- 
2.16.1.180.g07550b0b1b

