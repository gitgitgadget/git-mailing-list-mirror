Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD061F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeIRDQE (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:16:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44420 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIRDQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:16:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so18815967wro.11
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DLJfPuQZwc0rk/SrTO3j6mJRIJBfe9/31YGxx6s1Yo=;
        b=qg+ViggpBMikVtyodeHgE3s1F//K05MTYRFPTxnuPa6JwmsGa9vtecHpIwGWN8Ckir
         henlFcBACCIb/c4CyzkbwJt0LtIcyDePogRkaDx42/14PiKyFv6jGXaTjFX1Tx3+qgGF
         chxR2EQb+yC7HgH+9VZw2+0aJcPk5uCy4/Rj4LrVy4raRwHTlXYF2FE8PieHo75v4pgZ
         aoRG6iI26fa+fqao5d4mKRmr0BIyMlMd3RtGzYJCEzCl6xe4TdU3UhtVbDuDxVD4SjQ0
         fD2EIvW5PnQaQU54jZosDsSsbAinKBQlTxOzD2cH5E4HL4Nq8KvmfHY7qXJ9OQC0/qoV
         tvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DLJfPuQZwc0rk/SrTO3j6mJRIJBfe9/31YGxx6s1Yo=;
        b=b/k3Nyc1bMNRaS3yfx+rSvYxMV4KLtRtI5m1TqUXFQewn665rVDST7B2wfVVrmXYVb
         te04WUoJJg8qGdkuHLN+oacj8xJfu3RtAWMKzgSaIAPr0aDWY3dm9RtPwQbKzgEsGnl2
         PE/KJknLWmY1I7y9KgCf2A10342nMTkMNi1WkjtpDjsAJd4vjglF7x4h8HQznR2kZdbt
         2++XNm6+DOZ9DYLfZvGkYioVFotlxo5jqqQYOgebejSY6k9t3kEGBNFx0Ik4O6PsVFVR
         9mjGBkGstXMKzPjKeW6b74LUyYEfvrkqrbPVNPvMn6jX8ATSaNaXKYMH22Tpgw/GcPN/
         NI4w==
X-Gm-Message-State: APzg51CEV9pnJjIyU3kbsgM13sEg1ewidTOOvmO6wvxudwnYCZSrfv8A
        Mln8YRKkbS9H6h0nnhM0NxiSLeQt
X-Google-Smtp-Source: ANB0VdYLtP1Y8JOv//y/vURVg0ooQDnYZFsxhRHe0cCQz1S/h0UivYtPBscqRn3CnomCPuDsdjg47g==
X-Received: by 2002:adf:e792:: with SMTP id n18-v6mr20255346wrm.136.1537220810465;
        Mon, 17 Sep 2018 14:46:50 -0700 (PDT)
Received: from localhost ([2.28.194.193])
        by smtp.gmail.com with ESMTPSA id d22-v6sm30097591wra.80.2018.09.17.14.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 14:46:49 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/2] t5551: move setup code inside test_expect blocks
Date:   Mon, 17 Sep 2018 22:46:27 +0100
Message-Id: <20180917214628.28325-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef
In-Reply-To: <20180917214628.28325-1-t.gummerer@gmail.com>
References: <20180917191806.19958-1-t.gummerer@gmail.com>
 <20180917214628.28325-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move setup code inside test_expect blocks, to catch unexpected
failures in the setup steps, and bring the test scripts in line with
our modern test style.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t5551-http-fetch-smart.sh | 66 ++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 771f36f9ff..71535631d3 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -23,26 +23,26 @@ test_expect_success 'create http-accessible bare repository' '
 
 setup_askpass_helper
 
-cat >exp <<EOF
-> GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
-> Accept: */*
-> Accept-Encoding: ENCODINGS
-> Pragma: no-cache
-< HTTP/1.1 200 OK
-< Pragma: no-cache
-< Cache-Control: no-cache, max-age=0, must-revalidate
-< Content-Type: application/x-git-upload-pack-advertisement
-> POST /smart/repo.git/git-upload-pack HTTP/1.1
-> Accept-Encoding: ENCODINGS
-> Content-Type: application/x-git-upload-pack-request
-> Accept: application/x-git-upload-pack-result
-> Content-Length: xxx
-< HTTP/1.1 200 OK
-< Pragma: no-cache
-< Cache-Control: no-cache, max-age=0, must-revalidate
-< Content-Type: application/x-git-upload-pack-result
-EOF
 test_expect_success 'clone http repository' '
+	cat >exp <<-\EOF &&
+	> GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
+	> Accept: */*
+	> Accept-Encoding: ENCODINGS
+	> Pragma: no-cache
+	< HTTP/1.1 200 OK
+	< Pragma: no-cache
+	< Cache-Control: no-cache, max-age=0, must-revalidate
+	< Content-Type: application/x-git-upload-pack-advertisement
+	> POST /smart/repo.git/git-upload-pack HTTP/1.1
+	> Accept-Encoding: ENCODINGS
+	> Content-Type: application/x-git-upload-pack-request
+	> Accept: application/x-git-upload-pack-result
+	> Content-Length: xxx
+	< HTTP/1.1 200 OK
+	< Pragma: no-cache
+	< Cache-Control: no-cache, max-age=0, must-revalidate
+	< Content-Type: application/x-git-upload-pack-result
+	EOF
 	GIT_TRACE_CURL=true git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
 	tr '\''\015'\'' Q <err |
@@ -96,13 +96,13 @@ test_expect_success 'fetch changes via http' '
 	test_cmp file clone/file
 '
 
-cat >exp <<EOF
-GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-POST /smart/repo.git/git-upload-pack HTTP/1.1 200
-GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-POST /smart/repo.git/git-upload-pack HTTP/1.1 200
-EOF
 test_expect_success 'used upload-pack service' '
+	cat >exp <<-\EOF &&
+	GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+	POST /smart/repo.git/git-upload-pack HTTP/1.1 200
+	GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+	POST /smart/repo.git/git-upload-pack HTTP/1.1 200
+	EOF
 	check_access_log exp
 '
 
@@ -203,15 +203,15 @@ test_expect_success 'dumb clone via http-backend respects namespace' '
 	test_cmp expect actual
 '
 
-cat >cookies.txt <<EOF
-127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
-EOF
-cat >expect_cookies.txt <<EOF
-
-127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
-127.0.0.1	FALSE	/smart_cookies/repo.git/info/	FALSE	0	name	value
-EOF
 test_expect_success 'cookies stored in http.cookiefile when http.savecookies set' '
+	cat >cookies.txt <<-\EOF &&
+	127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
+	EOF
+	cat >expect_cookies.txt <<-\EOF &&
+
+	127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
+	127.0.0.1	FALSE	/smart_cookies/repo.git/info/	FALSE	0	name	value
+	EOF
 	git config http.cookiefile cookies.txt &&
 	git config http.savecookies true &&
 	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
-- 
2.19.0.444.g18242da7ef

