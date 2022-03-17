Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE64C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 18:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbiCQSK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbiCQSKS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 14:10:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8486D13666B
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:09:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r10so8501658wrp.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=485DI4WvEIaaT5aUbcD34MYWxVDjN6wLGOlEN93oYJs=;
        b=h2+WcZlkXSNTIWvqVs+asAIyGlCkZ1FY/vPNbNBFm3nDMCJnU0o2CT8KTxy/MKD46u
         DYTmOsSzVSOhUKK8w1snwWrrNa0/YVuJqwEmQkjLnC4isQ7GAO29bt930IIQe313QQVL
         8Bj4hNc6lgmn6zFou0WHebhnySuRgFdwDnOHnYQCQYfFl1e+K/4SJ7M+xEBYqHqow9IS
         CksfWKSR1lZzniqEc2ppDkApRVp2dt4RRkhAJdXcP9fOV1ISQijxX/PjxZCMtgW5uBOD
         1+FeeNWlcPR7LCSVFnDuaG2+c5lhkV1Bb30IVZpt8RV4i7ZtZEpZRSiU9DHPwdGEqWOx
         CEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=485DI4WvEIaaT5aUbcD34MYWxVDjN6wLGOlEN93oYJs=;
        b=sxS7m1GCRVjwC7kY3Jr7h4yxHqJDJSX3p1X4d7HWi9x2YDf8RMdu42YTEQ02htZj2B
         cXRg2csI8AyqvgmZWuCTZziZG5dsSQn0RuD7yNYfGM6v7MsF0DtLg57UoRxSoG/BsDq2
         IWKAnrraAI3p3gF3H6rcHE8+jCV9oLkFSXjjzSCFA/PBmOZtq0KxdrPA7G/YTRGLlP5P
         2KcMMeUNlD5etDMOphcdseysjdQe5jJaE2oH46JAiZlkNG2U4SY3D5iEmG8Jp9rGpadm
         wyC01W00pmluC8BFJC1iiaWMYUgzaLR6d7yl33eAxDFx+IZEk6Vw5YpPySzSkhGf1ueJ
         kNEg==
X-Gm-Message-State: AOAM532lI7E7DfeyF3gJ/0F17yFch3km+5n40oBgEWpz3znu5OP3CXEf
        eeNNa9G8f5PaPoO9DAPtMY8Gl2X6WbAySg==
X-Google-Smtp-Source: ABdhPJwGxLvOOA5wD5V6Ui9jEoGO3G3LX7sSDtBM/pdM1KLsKNBnV5ObjLUhOm8/F2t2INmHjnx+/Q==
X-Received: by 2002:adf:fd50:0:b0:1f0:7a8e:c922 with SMTP id h16-20020adffd50000000b001f07a8ec922mr5046151wrs.166.1647540539794;
        Thu, 17 Mar 2022 11:08:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm4756253wri.105.2022.03.17.11.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 11:08:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/8] reflog exists: use parse_options() API
Date:   Thu, 17 Mar 2022 19:08:38 +0100
Message-Id: <patch-6.8-f88acdc9702-20220317T180439Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "reflog exists" command added in afcb2e7a3b8 (git-reflog:
add exists command, 2015-07-21) to use parse_options() instead of its
own custom command-line parser. This continues work started in
33d7bdd6459 (builtin/reflog.c: use parse-options api for expire,
delete subcommands, 2022-01-06).

As a result we'll understand the --end-of-options synonym for "--", so
let's test for that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c         | 38 ++++++++++++++++----------------------
 t/t1418-reflog-exists.sh |  5 +++++
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 458764400b5..9847e9db3de 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -27,8 +27,10 @@ static const char *const reflog_delete_usage[] = {
 	NULL
 };
 
-static const char reflog_exists_usage[] =
-	BUILTIN_REFLOG_EXISTS_USAGE;
+static const char *const reflog_exists_usage[] = {
+	BUILTIN_REFLOG_EXISTS_USAGE,
+	NULL,
+};
 
 static timestamp_t default_reflog_expire;
 static timestamp_t default_reflog_expire_unreachable;
@@ -350,28 +352,20 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 
 static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
 {
-	int i, start = 0;
-
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		else if (arg[0] == '-')
-			usage(_(reflog_exists_usage));
-		else
-			break;
-	}
-
-	start = i;
+	struct option options[] = {
+		OPT_END()
+	};
+	const char *refname;
 
-	if (argc - start != 1)
-		usage(_(reflog_exists_usage));
+	argc = parse_options(argc, argv, prefix, options, reflog_exists_usage,
+			     0);
+	if (!argc)
+		usage_with_options(reflog_exists_usage, options);
 
-	if (check_refname_format(argv[start], REFNAME_ALLOW_ONELEVEL))
-		die(_("invalid ref format: %s"), argv[start]);
-	return !reflog_exists(argv[start]);
+	refname = argv[0];
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+		die(_("invalid ref format: %s"), refname);
+	return !reflog_exists(refname);
 }
 
 /*
diff --git a/t/t1418-reflog-exists.sh b/t/t1418-reflog-exists.sh
index 60c6411ce3c..d51ecd5e925 100755
--- a/t/t1418-reflog-exists.sh
+++ b/t/t1418-reflog-exists.sh
@@ -29,4 +29,9 @@ test_expect_success 'reflog exists works with a "--" delimiter' '
 	test_must_fail git reflog exists -- refs/heads/nonexistent
 '
 
+test_expect_success 'reflog exists works with a "--end-of-options" delimiter' '
+	git reflog exists --end-of-options refs/heads/main &&
+	test_must_fail git reflog exists --end-of-options refs/heads/nonexistent
+'
+
 test_done
-- 
2.35.1.1384.g7d2906948a1

