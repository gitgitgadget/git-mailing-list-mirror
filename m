Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD681F404
	for <e@80x24.org>; Fri, 26 Jan 2018 12:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeAZMhc (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 07:37:32 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39736 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbeAZMh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 07:37:29 -0500
Received: by mail-wr0-f196.google.com with SMTP id z48so405349wrz.6
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 04:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+LOhe9cwirc6jdzV1lxJI8ekNjgy4bfYK6Oc3YxbSA=;
        b=TpjzvDXxCwsqnaMeG7Kes/APaFlQApOPall0nSLXczmL9PVq/81mFGJJcspFluWPhM
         p/vej5gKr2MaXyPI0NAYMf2f8cLaKrlenpPDj7HGzmAhrBKTFJGcUkckzFby29tJgU4I
         SN7e67AEnNbuUUppI20s/1OtQLhjt/TOQOW4uqXLFWLr0mnQCRcj27CNbbmeGlvPWoDk
         DHGVsyqMK5eWL5oIRM6vhEYnhtii/1laNH2knZnWFOjus6jI3sZRxQglamY3FcmA/CAV
         Nvywmu18RvB/xOwxMEJ/cNcy4hQ1SbXTJjujY4RQlTpsUwVGw0bKsyDE+7pE2FSpSuEI
         PwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+LOhe9cwirc6jdzV1lxJI8ekNjgy4bfYK6Oc3YxbSA=;
        b=jkEyHUup5kJrhHShISaiVMDHJcdwCBFbm+Z6tIqfF7ijEgPzLvotWPLFyOXV8PSWCC
         t9gObLoPjCgwP84YCylNsMLMl1UltpUvVWEFWfzUzhVCLFsQLB3SRP8ZuF2ZqiDrO9UD
         WOmhvfd7fGytfWllnkVeX0YabBI8Wu4m3nTB7v82Ti317A6uB4PRfgHydHSJH3BDpRYW
         MEiLPZgqdWsBcp/yrHgYCvzWWdAdHVad2LehsqiNIFvO/vSif0EnYp6I+aJ6hcDne0C4
         Hxo84R4rEMHbtY36pqe5mUtteJNVA4u9Av3RY3dia1+3YCHYFZ33Vzb2kHPHI/LLjQKT
         o0iQ==
X-Gm-Message-State: AKwxytfVr3Z5u3NDxSX6Gn1VcopgmUoI12xs6wFl8OsDtoLU+ANJxOXF
        nSnbCdCcZTUaE3VfWSEgAfmU2w==
X-Google-Smtp-Source: AH8x227rXeg1noHgeIfpMyYJJN2hLuGTvo/km7VjtQqXewqXrRG8DNg2ssO+FFtw3BOWm5OqDPBBhw==
X-Received: by 10.223.186.10 with SMTP id o10mr10081962wrg.150.1516970247789;
        Fri, 26 Jan 2018 04:37:27 -0800 (PST)
Received: from localhost.localdomain (x590dab0e.dyn.telefonica.de. [89.13.171.14])
        by smtp.gmail.com with ESMTPSA id d17sm4756626wrd.50.2018.01.26.04.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 04:37:27 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 07/10] t: move 'test_i18ncmp' and 'test_i18ngrep' to 'test-lib-functions.sh'
Date:   Fri, 26 Jan 2018 13:37:05 +0100
Message-Id: <20180126123708.21722-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.155.g5159265b1
In-Reply-To: <20180126123708.21722-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both 'test_i18ncmp' and 'test_i18ngrep' helper functions are supposed
to be called from our test scripts, so they should be in
'test-lib-functions.sh'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib-functions.sh | 26 ++++++++++++++++++++++++++
 t/test-lib.sh           | 26 --------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1701fe2a0..92ed02937 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -705,6 +705,32 @@ test_cmp_bin() {
 	cmp "$@"
 }
 
+# Use this instead of test_cmp to compare files that contain expected and
+# actual output from git commands that can be translated.  When running
+# under GETTEXT_POISON this pretends that the command produced expected
+# results.
+test_i18ncmp () {
+	test -n "$GETTEXT_POISON" || test_cmp "$@"
+}
+
+# Use this instead of "grep expected-string actual" to see if the
+# output from a git command that can be translated either contains an
+# expected string, or does not contain an unwanted one.  When running
+# under GETTEXT_POISON this pretends that the command produced expected
+# results.
+test_i18ngrep () {
+	if test -n "$GETTEXT_POISON"
+	then
+	    : # pretend success
+	elif test "x!" = "x$1"
+	then
+		shift
+		! grep "$@"
+	else
+		grep "$@"
+	fi
+}
+
 # Call any command "$@" but be more verbose about its
 # failure. This is handy for commands like "test" which do
 # not output anything when they fail.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9a0a21f49..852b22c80 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1062,32 +1062,6 @@ else
 	test_set_prereq C_LOCALE_OUTPUT
 fi
 
-# Use this instead of test_cmp to compare files that contain expected and
-# actual output from git commands that can be translated.  When running
-# under GETTEXT_POISON this pretends that the command produced expected
-# results.
-test_i18ncmp () {
-	test -n "$GETTEXT_POISON" || test_cmp "$@"
-}
-
-# Use this instead of "grep expected-string actual" to see if the
-# output from a git command that can be translated either contains an
-# expected string, or does not contain an unwanted one.  When running
-# under GETTEXT_POISON this pretends that the command produced expected
-# results.
-test_i18ngrep () {
-	if test -n "$GETTEXT_POISON"
-	then
-	    : # pretend success
-	elif test "x!" = "x$1"
-	then
-		shift
-		! grep "$@"
-	else
-		grep "$@"
-	fi
-}
-
 test_lazy_prereq PIPE '
 	# test whether the filesystem supports FIFOs
 	test_have_prereq !MINGW,!CYGWIN &&
-- 
2.16.1.155.g5159265b1

