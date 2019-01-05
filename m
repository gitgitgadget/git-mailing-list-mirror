Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C196A1F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 01:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfAEBJY (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 20:09:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36568 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfAEBJX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 20:09:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so38009235wrp.3
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 17:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7metkaiqsKkcA5vAFcp8Hn49kr8AAvhs0uVYwAiajJU=;
        b=SCJKIScG2c4q1KdnA8k8K6GmdVqisjPgVxorkoLQwHx8+f36PZwAPbD1fx4KIhNVHH
         HaCUpn3Us8lbYcc+AiBt3K9sCI7PMo7/B+cZnWp9uQJvbROtZnSp69qi6XkLIUw4Rh6N
         0SN281MXRyhYky6ktELf/U/aB6cso2LQygvfLyPKcIr/OBK/+IesDNzrCeaGb+KGwqFY
         //kpWr0gM3zfyvU4F3FZoyQ1VuDvy7kBY9soaxjlU0wN5Kx8U9PmvQGEuXMhA//AJJ8w
         5pqXicnW+tK51DD4Og5N2pIOkvWOW2ROaf8/acylS7SSxhMLrjCWxBbbUdF5ev17JRjl
         mX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7metkaiqsKkcA5vAFcp8Hn49kr8AAvhs0uVYwAiajJU=;
        b=JMtXJ1jemml4lU5wpwkaQCjzaPvLaQGEs16DP9MH14E+KMcziGDp7AhTcX3jVN+oDL
         6OrTBE7CU0wuIqLjTBFRktc1iPq+r1zuPjhQ8swX6kuesAesuzf599PN22mFRBV9nYMZ
         z7PXs42lO+vy8Bfg7NtMCEpwpGEunZDReD00m6vTReaq1voyCCP6LMA6aC9zxQfzgTDz
         2MAzKPB9LCXluiJ09ui3SHXju2AjoJXdRJ29EilOEV3HT7Kreav3Ccvn2CYSnpUdq6hh
         WeelEaZUyWZTCnOpBwFVGA69UgXdSfJJdNogdNn+VzknNJ2gjOfnjeDImEFQVHkYfTte
         mC6w==
X-Gm-Message-State: AJcUukeCEkDMURqRm2kJjjulCV7o84da/ktwiF+ee+xPb6J21//ZlSL8
        aoeo5gNKZyeIhxAWXXQcS3KZWv9Z
X-Google-Smtp-Source: ALg8bN6wPLe9/xvJACkBUVuNaAfsKYwbRquJJPst34EnK0mFWGRSUpf9GJR3X4GaZeUlncLhZWlCOg==
X-Received: by 2002:a5d:4dc8:: with SMTP id f8mr47257839wru.45.1546650560423;
        Fri, 04 Jan 2019 17:09:20 -0800 (PST)
Received: from localhost.localdomain (94-21-23-250.pool.digikabel.hu. [94.21.23.250])
        by smtp.gmail.com with ESMTPSA id c15sm1851353wml.27.2019.01.04.17.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 17:09:19 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 6/8] test-lib: set $TRASH_DIRECTORY earlier
Date:   Sat,  5 Jan 2019 02:08:57 +0100
Message-Id: <20190105010859.11031-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20190105010859.11031-1-szeder.dev@gmail.com>
References: <20181230191629.3232-1-szeder.dev@gmail.com>
 <20190105010859.11031-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A later patch in this series will need to know the path to the trash
directory early in 'test-lib.sh', but $TRASH_DIRECTORY is set much
later.

Set $TRASH_DIRECTORY earlier, where the other test-specific path
variables are set.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5720292641..0e9ac9118d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -163,6 +163,12 @@ fi
 TEST_NAME="$(basename "$0" .sh)"
 TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
 TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME"
+TRASH_DIRECTORY="trash directory.$TEST_NAME"
+test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
+case "$TRASH_DIRECTORY" in
+/*) ;; # absolute path is good
+ *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
+esac
 
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
@@ -1051,12 +1057,6 @@ then
 fi
 
 # Test repository
-TRASH_DIRECTORY="trash directory.$TEST_NAME"
-test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
-case "$TRASH_DIRECTORY" in
-/*) ;; # absolute path is good
- *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
-esac
 rm -fr "$TRASH_DIRECTORY" || {
 	GIT_EXIT_OK=t
 	echo >&5 "FATAL: Cannot prepare test area"
-- 
2.20.1.151.gec613c4b75

