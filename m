Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D431F404
	for <e@80x24.org>; Thu,  8 Feb 2018 15:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeBHP5V (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 10:57:21 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34894 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeBHP5P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 10:57:15 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so10921571wme.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 07:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ree9t/Cg6Iy9zzCftVba/DkP0xyxnAmXRXfiqGJAE5s=;
        b=Va+ZbM8ijFpNH2WEhtBElWTSGNP/FDuF1NFgtGzm/Mp7PUypY4nNInJR4bhUESJkfL
         UhUXCy6gEC9k+iLwieV0Krt9x45ENzuUfrc8tyTdlqni60gYCPPrMWfq6zeBikyh9wVg
         3zdMgzpY3vgkSeb2YQPFXrKW7vXROOjnDilGuJEwyTdE0djl6EB56VqgHTA1M6TJFQqG
         lxX9Q3muunlCUl6aHOWwDh83Os1Xc8eh3HJMFBWN4rf3Rnh6scL7EnpEpg5fdhEFc8pq
         ld9Uj7CtHRSAJF/iCcwO8+dQSSY/fi+/6TlIaC9memhxM2iOO0Gsbk+cGEQSU5XzS3hh
         6rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ree9t/Cg6Iy9zzCftVba/DkP0xyxnAmXRXfiqGJAE5s=;
        b=J3VsdLscvFfJ0YsnjpgdARwZ3Ye9GwUkHGDZXn04JzmBfvKe7IZ9MzIb2YxJ0/VDmL
         oQzAWdJB6A4WRaQ7jXSe9upxZfJOKT69BWhFISBHAzRpoTWSQXaxrl/xFF/JnoqPozJC
         i/OI3v7DOyiRNASMwf+IP/YaI8woGM45e71V7bnUABO1TsUxjQP9EO7rVj6mkPJ65Zji
         gxnobTdjCNIlJQkCBt6EiM3nlIjoZAm+zmMCOZnng2pruxYP7AEszNlKuuWylxv1jkPC
         /zG21GWM9NI1C9V80GRUDX58ZYlo3/qSHyHIHDfe/dAJRsC6GphjbSrdpX04G7mORQAQ
         rnwA==
X-Gm-Message-State: APf1xPAh3DFWV+9HKPVwzYEPdBGHS9OCD3MgzTaRMzriYCRPAoPcoMdy
        CG43K3mInj2j768BG3vW7kQ=
X-Google-Smtp-Source: AH8x2243aSwj76Dd2sO9cg9x3WgyurjNWzvhv/7E9PaKF/H3d70YTKdjADL38jnL+fFnDBWfW+mZrQ==
X-Received: by 10.28.99.137 with SMTP id x131mr1401009wmb.12.1518105434207;
        Thu, 08 Feb 2018 07:57:14 -0800 (PST)
Received: from localhost.localdomain (x4db2a6c8.dyn.telefonica.de. [77.178.166.200])
        by smtp.gmail.com with ESMTPSA id p14sm308880wrg.42.2018.02.08.07.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 07:57:13 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 7/9] t: move 'test_i18ncmp' and 'test_i18ngrep' to 'test-lib-functions.sh'
Date:   Thu,  8 Feb 2018 16:56:54 +0100
Message-Id: <20180208155656.9831-8-szeder.dev@gmail.com>
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

Both 'test_i18ncmp' and 'test_i18ngrep' helper functions are supposed
to be called from our test scripts, so they should be in
'test-lib-functions.sh'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib-functions.sh | 26 ++++++++++++++++++++++++++
 t/test-lib.sh           | 26 --------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1701fe2a06..92ed029371 100644
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
index 9a0a21f49a..852b22c80a 100644
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
2.16.1.158.ge6451079d

