Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 275CC1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 12:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeGLMbq (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 08:31:46 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:39545 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeGLMbp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 08:31:45 -0400
Received: by mail-ed1-f42.google.com with SMTP id w14-v6so21736317eds.6
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 05:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cM03t2aQYna4nylwUlk++DeNLoMqsZnDd+fm/lcOEbA=;
        b=YM6Cc34ktG/7hdpi8vBiL4zRPR03U+lbhYMm7NRaH4UCXwh/rzjMgvyGUbv75pGDgv
         xHVCvTz4yLx6iD4fzOuo+gYwOnx/eEZCbK3xoHqgxH4QsRLZnap3AjbwjqgOi3XT+rcg
         ZkQ5KncINkIRjTzFVwy6BZU2cMEqc4WCtJb3Lqg1OTnU6lVp6P2E95oa+7h/XT0+THMq
         w74tyDK2y88yxs8yEkyxOXq+FDJ0c2xCHDWJcJTTwm/Ndw0d4d2WtOu4YMMBIg/Jb4i4
         APa47oCLDPAUx6Yzj7WgvNxAT+pnKrzbpYYG0RTA4hJb0vS7am0LGOplDHaxNgcC3+1y
         SDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cM03t2aQYna4nylwUlk++DeNLoMqsZnDd+fm/lcOEbA=;
        b=K+8k+bgxG12VWKCDL78loSYjtnDfF4bLxdxmrxSFytApFJ9DAr5hsQSiH1MaeBT6Q8
         ysTpFvff+8eHidmp9xmWCsQfyBRcE45yrh49Llhaq/Y/NRVYpJFGaGSql4qERqMcYdzv
         6IrQdZY1EKUyhrnoAuGZIUEeVISNr0DbxHS70oxizI4FhtExwmh+bm5kDfaUFfCX/BC7
         z0f3vRGra96an/sPum4NPsiMKAion76pR7ICmHi7J6gM88I8ex+FatUt5J7mX/ch2/V4
         YCCVVtkfhjaoJi5xy6GBfqkTNAemq7uT0CTK8bdg1g/TuNbrUJhQPt4Oa2ZVirlxd0pI
         fchg==
X-Gm-Message-State: AOUpUlGyotVnGC+Y0weho64VlzGoCDQB9RgKkJm+o8roh8BXeixLuU38
        ZGV1PFbtOct66C2ZuVhVg1I=
X-Google-Smtp-Source: AAOMgpeIclWd8pgtno/2hd5HmlgtKa/iKFnnHxsusx4rgIEbhR3EtOaZX/TMuJQuRnB7D5iVt9XtdQ==
X-Received: by 2002:a50:8ca9:: with SMTP id q38-v6mr2386940edq.2.1531398144879;
        Thu, 12 Jul 2018 05:22:24 -0700 (PDT)
Received: from localhost.localdomain (x590d07e3.dyn.telefonica.de. [89.13.7.227])
        by smtp.gmail.com with ESMTPSA id a2-v6sm165618ede.21.2018.07.12.05.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 05:22:24 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 1/3] t5541: clean up truncating access log
Date:   Thu, 12 Jul 2018 14:22:14 +0200
Message-Id: <20180712122216.12691-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.305.g66e9e0a543
In-Reply-To: <20180712122216.12691-1-szeder.dev@gmail.com>
References: <20180711125647.16512-1-szeder.dev@gmail.com>
 <20180712122216.12691-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the second test of 't5541-http-push-smart.sh', 'no empty path
components' we truncate Apache's access log by running:

  echo >.../access.log

There are two issues with this approach:

  - This doesn't leave an empty file behind, like a proper truncation
    would, but a file with a lone newline in it.  Consequently, a
    later test checking the log's contents must consider this improper
    truncation and include an empty line in the expected content.

  - This truncation is done in the middle of the test, because,
    quoting the in-code comment, "we do this [truncation] before the
    actual comparison to ensure the log is cleared" even when
    subsequent 'test_cmp' fails.  Alas, this is not quite robust
    enough, as it is conceivable that 'git clone' fails after already
    having sent a request, in which case the access log would not be
    truncated and would leave stray log entries behind.

Since there is no need for that newline at all, drop the 'echo' from
the truncation and adjust the expected content accordingly.
Furthermore, make sure that the truncation is performed no matter
whether and how 'git clone' fails unexpectedly by specifying it as a
'test_when_finished' command.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5541-http-push-smart.sh | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index a2af693068..5c9ca19401 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -38,6 +38,10 @@ GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
 EOF
 test_expect_success 'no empty path components' '
+	# Clear the log, so that it does not affect the "used receive-pack
+	# service" test which reads the log too.
+	test_when_finished ">\"$HTTPD_ROOT_PATH\"/access.log" &&
+
 	# In the URL, add a trailing slash, and see if git appends yet another
 	# slash.
 	cd "$ROOT_PATH" &&
@@ -49,13 +53,6 @@ test_expect_success 'no empty path components' '
 		s/ [1-9][0-9]*\$//
 		s/^GET /GET  /
 	" >act <"$HTTPD_ROOT_PATH"/access.log &&
-
-	# Clear the log, so that it does not affect the "used receive-pack
-	# service" test which reads the log too.
-	#
-	# We do this before the actual comparison to ensure the log is cleared.
-	echo > "$HTTPD_ROOT_PATH"/access.log &&
-
 	test_cmp exp act
 '
 
@@ -124,7 +121,6 @@ test_expect_success 'rejected update prints status' '
 rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
 
 cat >exp <<EOF
-
 GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
 GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-- 
2.18.0.305.g66e9e0a543

