Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC6891F404
	for <e@80x24.org>; Thu,  8 Feb 2018 15:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeBHP5U (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 10:57:20 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43744 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbeBHP5R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 10:57:17 -0500
Received: by mail-wr0-f194.google.com with SMTP id b52so5213824wrd.10
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 07:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+RtvAWFwgywt8xdL510V4TumDE9hoDppw4p1op4Hhfs=;
        b=AvTGptDbpaFVbLKMakldZXtRMHXvR84A+vDs8IHRn6r4nvx0McTl3J1XZKcsdq/IH+
         zE7ufpwW7R2TCDaPgVC3qXN2BcqZjntYOGrXIicNRB92FkYCp4vzpTMT8pixHf4z9H6t
         ApNTT42zCfb1S8WfH6v3eT1SoxbxT4Fnj7t1BOqzLzTPI3wDPHy3U6I20Z8d6eXdZwnB
         rTR6zv/lFyZ0IG08rEOTwhr+Mb+93SuRwIJbu4pY3xm2v3ZzeqJWZp9dhY9I2zzyqDrx
         HFFeqtK4JB9NNCJWZN0Y9xkNvGQvSDNdB0j+6vDTQGsoYASQH0b5bxTOdzDZFHv6jhLm
         w3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+RtvAWFwgywt8xdL510V4TumDE9hoDppw4p1op4Hhfs=;
        b=eG2H9KNjyOVzvDqMcvVnPm3o/SxnlcqUh9O4Dgn47z7J1ePAsvuU2ADWjUV8+kLVeU
         AYGHMi9pIww9FolK40Wmc2j5Umxsaqie2HhNQ+87ly8A3TWWeb4Yiw/tifcrYsGTuVkR
         l/YVCr4+SYS4Vn2EE0NMXnWC4XD0rxv6eL+tuNVrgNf4rni8RZZXrv7k/W8VxYeNmxQO
         anFhmRDeWKKuDEOp8PTXSIoU4PZZSZjac2AECXjdZzRUVDimebc92PYvaPN147WoIpj3
         VQRK8jgtKghV1F6aF+xII1wMPEj9hD/J64XJKQYhL2l+s5Zxc99qiu2lm56BuxI+CK4E
         MMKQ==
X-Gm-Message-State: APf1xPBFPEQMA9lY1H/ybSZUncbIJ/WBYRfW9tpKbrn67HHhwBFtWJ/h
        Gb9xBg9oPrkjjOionXTQXGE=
X-Google-Smtp-Source: AH8x226gQVHZNqQ0aLZxCjVQfppygz0f19wxnItoJ7hdUPjJk1FY+7kpxtMn7/n67ARdIxpGGhgmxg==
X-Received: by 10.223.157.30 with SMTP id k30mr1330879wre.84.1518105436230;
        Thu, 08 Feb 2018 07:57:16 -0800 (PST)
Received: from localhost.localdomain (x4db2a6c8.dyn.telefonica.de. [77.178.166.200])
        by smtp.gmail.com with ESMTPSA id p14sm308880wrg.42.2018.02.08.07.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 07:57:15 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 9/9] t: make 'test_i18ngrep' more informative on failure
Date:   Thu,  8 Feb 2018 16:56:56 +0100
Message-Id: <20180208155656.9831-10-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <20180208155656.9831-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180208155656.9831-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'test_i18ngrep' can't find the expected pattern, it exits
completely silently; when its negated form does find the pattern that
shouldn't be there, it prints the matching line(s) but otherwise exits
without any error message.  This leaves the developer puzzled about
what could have gone wrong.

Make 'test_i18ngrep' more informative on failure by printing an error
message including the invoked 'grep' command and the contents of the
file it had to scan through.

Note that this "dump the scanned file" part is not quite perfect, as
it dumps only the file specified as the function's last positional
parameter, thus assuming that there is only a single file parameter.
I think that's a reasonable assumption to make, one that holds true in
the current code base.  And even if someone were to scan multiple
files at once in the future, the worst thing that could happen is that
the verbose error message won't include the contents of all those
files, only the last one.  Alas, we can't really do any better than
this, because checking whether the other positional parameters match a
filename can result in false positives: 't3400-rebase.sh' and
't3404-rebase-interactive.sh' contain one test each, where the
'test_i18ngrep's pattern verbatimly matches a file in the trash
directory.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib-functions.sh | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index a1676e0386..d936ecc0a5 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -733,14 +733,30 @@ test_i18ngrep () {
 
 	if test -n "$GETTEXT_POISON"
 	then
-	    : # pretend success
-	elif test "x!" = "x$1"
+		# pretend success
+		return 0
+	fi
+
+	if test "x!" = "x$1"
 	then
 		shift
-		! grep "$@"
+		! grep "$@" && return 0
+
+		echo >&2 "error: '! grep $@' did find a match in:"
 	else
-		grep "$@"
+		grep "$@" && return 0
+
+		echo >&2 "error: 'grep $@' didn't find a match in:"
 	fi
+
+	if test -s "$last_arg"
+	then
+		cat >&2 "$last_arg"
+	else
+		echo >&2 "<File '$last_arg' is empty>"
+	fi
+
+	return 1
 }
 
 # Call any command "$@" but be more verbose about its
-- 
2.16.1.158.ge6451079d

