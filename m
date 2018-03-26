Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76A0F1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 13:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbeCZNL3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 09:11:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51084 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeCZNL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 09:11:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id i75so15272714wmf.0
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 06:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PoPIS8F8fj8mlHoDexzS4CFMT3hXti3C7p113m0qFOA=;
        b=QpXiCRekrCDVTnkyRrKQIBJsI80KQV49kpzPQiKzVKZi0TkO110yOOYxapGyvv/uhd
         hCCWTUQbd0UXtWBDCvFtrtD+HuhYSmGoMV2XxvdXl9iDtMyrYjIiT4pshC3BnhLYzfYZ
         xi5sGVdOa/QC4jYN+ogQbi2FomkkzF0qGI3aXNkCMxwIqhm+JFmJ1Be5EOmZmrXGNN6r
         mrLYli4oO5oCejmUkGqiDnvJVnZjNJSkKBmZPdgzzkm1jPBvcWHO9LZgDDhKQwCEax5r
         5tydl0xwCDRD6SsMCtIgF/wrRMX6I+zoTUT2zYMG0WJTbwPi9FqIux4MQhZS47YS6fQA
         ZWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoPIS8F8fj8mlHoDexzS4CFMT3hXti3C7p113m0qFOA=;
        b=QXjdPLuAHxAfff8WR59xOHn9VM9RU1bcI3bc26Cdjnjm1x7B51F9O9TdpfVt+9ccyo
         xEFEzGjflaupJ7QpHKJPmeCk8MRPF28S9hgqoKE5TqLA8X9JhH/5t4fMax/s85J9SbYz
         GDwZFc+G+HCHLDJ95+R72AQNHjBpTEAGWHC5k3/CaIDFf878tUAaSDMXK/DPgaVkPMaN
         BsVD2W0uiXk6ETilnhCBDGkxbOxBT+OfsI0XH800DkDgyi6Y6ug4hUeBYz772C/baCUx
         ZWy8fct7e9G4i5jBoh3fns9Uq/3UttPaKBtKS976udohUb0QWaCb+laypAz5JyLsLSvi
         vkWQ==
X-Gm-Message-State: AElRT7GTEOj6NQeZG/ve6dmPZwQ5AH5r8SSebUgoKwbllmNQRuvkuuKB
        hVRWXiyQ/yS3YK1ZMak5Ka9vdw==
X-Google-Smtp-Source: AG47ELugfEARLPYnq71wOi5wJafUzcYuaBh1SgcaDldx8iXmwVNI89P8T1vqK+LjvP8QkEvuZyoxyQ==
X-Received: by 10.80.164.14 with SMTP id u14mr39207878edb.115.1522069887670;
        Mon, 26 Mar 2018 06:11:27 -0700 (PDT)
Received: from localhost.localdomain (x4db0d68c.dyn.telefonica.de. [77.176.214.140])
        by smtp.gmail.com with ESMTPSA id f6sm10422037edl.9.2018.03.26.06.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Mar 2018 06:11:27 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] test_must_be_empty: simplify file existence check
Date:   Mon, 26 Mar 2018 15:11:24 +0200
Message-Id: <20180326131124.13003-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.148.gc92dc354c5
In-Reply-To: <20180326124847.GA21993@sigill.intra.peff.net>
References: <20180326124847.GA21993@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 11395a3b4b (test_must_be_empty: make sure the file exists, not
just empty, 2018-02-27) basically duplicated the 'test_path_is_file'
helper function in 'test_must_be_empty'.

Just call 'test_path_is_file' to avoid this code duplication.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

The only change is to refer to the right commit in the log message.

 t/test-lib-functions.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index d2eaf5ab67..36ad8accdd 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -718,11 +718,8 @@ verbose () {
 # otherwise.
 
 test_must_be_empty () {
-	if ! test -f "$1"
-	then
-		echo "'$1' is missing"
-		return 1
-	elif test -s "$1"
+	test_path_is_file "$1" &&
+	if test -s "$1"
 	then
 		echo "'$1' is not empty, it contains:"
 		cat "$1"
-- 
2.17.0.rc1.148.gc92dc354c5

