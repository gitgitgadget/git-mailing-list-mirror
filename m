Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41C0A1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 10:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfBFK76 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 05:59:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33579 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfBFK75 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 05:59:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id z8so295964plo.0
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 02:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D+wYeqL196jGWECUl39JdL7IpNP2Jb/VtyP9jCU3FWs=;
        b=eHiR7FMVDmSiyRzi4o66epZbKCQT8F7WKiRJVwKRS64R95dc+8My28dm2FqPxF30tS
         SAxvRh8onbzOXXZSm3JT8/4IWHwvp5WodmiysVaUBvSUV4H4trrrj2ZS5vMF6rysgnMV
         m7scQyOI8/BZR/r328AESTMFriUUzRr0KzIu4ogEfb6ARoXAslmjFwOooy/uP54FiseL
         x3LsZb513ZE4Oj0FRJVjdRi30Ukhkkmtu6dTogaAJZ0mJC5XTKak6D1UyL4S6PzUad3p
         eOWn7sdCJbwWYj2SxqLaAAxLfpHltApef4TJ4lvNpKmD7G8nRExqszhDGx6KPz7LyAZI
         sSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D+wYeqL196jGWECUl39JdL7IpNP2Jb/VtyP9jCU3FWs=;
        b=tyMyVhnKBm9FLFZQG8sJdmitEJ1bRcnNueNo32czx7w/5MzyzP+/W9GMEvK1+6mxrN
         hXmJnMU+pt6ME2g6HOcFcp/bx/UixIDhL3oKgl7QOB5K6TqM33pVgkPFbhYUBB76cg1w
         T3BeJOZxxPYK1g+eYOocZUgsJJhRb9XzyUIDwmzmp32JFYxvDo7RZTuCko2h07Th0t9g
         RfCokSgockBstcHsz9yNbVy0xkQtCvO6prWT4ANNqWOqDrwTdwR8RUDb62oclDGPVh1q
         EFqB0ErxLuOMD0LC4RMWihT7tzCMs+5NqKa/QsqrsHI2nQ753m5KVvn4gMZEpk7llwyo
         EYWw==
X-Gm-Message-State: AHQUAubCTM+OX2pW+AjhL27sxpG78eJesRR6o5TGUO5SEUTVawOYy1Qp
        W45THDpbvyX3QBRatJNY3JqJW6W/
X-Google-Smtp-Source: AHgI3IY7iNlXkbuGZEzxDDSBTjMDtYqerCanglBk7F+KJzf0qTfiTkGunkOISSMgzLaN1M40EhKLJQ==
X-Received: by 2002:a17:902:9691:: with SMTP id n17mr10365932plp.9.1549450797028;
        Wed, 06 Feb 2019 02:59:57 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id m3sm9477017pfi.102.2019.02.06.02.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 02:59:56 -0800 (PST)
Date:   Wed, 6 Feb 2019 02:59:54 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 2/3] submodule--helper: teach config subcommand --unset
Message-ID: <f24f20b024f4d41f106ed014a31508fab4fa5eb2.1549450636.git.liu.denton@gmail.com>
References: <cover.1549450636.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549450636.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches submodule--helper config the --unset option, which removes
the specified configuration key from the .gitmodule file.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/submodule--helper.c | 15 +++++++++++----
 t/t7411-submodule-config.sh |  9 +++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0e140f176c..336e4429e6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2149,15 +2149,21 @@ static int module_config(int argc, const char **argv, const char *prefix)
 	enum {
 		CHECK_WRITEABLE = 1
 	} command = 0;
+	enum {
+		DO_UNSET = 1
+	} unset = 0;
 
 	struct option module_config_options[] = {
 		OPT_CMDMODE(0, "check-writeable", &command,
 			    N_("check if it is safe to write to the .gitmodules file"),
 			    CHECK_WRITEABLE),
+		OPT_CMDMODE(0, "unset", &unset,
+			    N_("unset the config in the .gitmodules file"),
+			    DO_UNSET),
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper config name [value]"),
+		N_("git submodule--helper config name [--unset] [value]"),
 		N_("git submodule--helper config --check-writeable"),
 		NULL
 	};
@@ -2169,15 +2175,16 @@ static int module_config(int argc, const char **argv, const char *prefix)
 		return is_writing_gitmodules_ok() ? 0 : -1;
 
 	/* Equivalent to ACTION_GET in builtin/config.c */
-	if (argc == 2)
+	if (argc == 2 && unset != DO_UNSET)
 		return print_config_from_gitmodules(the_repository, argv[1]);
 
 	/* Equivalent to ACTION_SET in builtin/config.c */
-	if (argc == 3) {
+	if (argc == 3 || (argc == 2 && unset == DO_UNSET)) {
 		if (!is_writing_gitmodules_ok())
 			die(_("please make sure that the .gitmodules file is in the working tree"));
 
-		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
+		const char *value = (argc == 3) ? argv[2] : NULL;
+		return config_set_in_gitmodules_file_gently(argv[1], value);
 	}
 
 	usage_with_options(git_submodule_helper_usage, module_config_options);
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 89690b7adb..fcc0fb82d8 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -142,6 +142,15 @@ test_expect_success 'reading submodules config from the working tree with "submo
 	)
 '
 
+test_expect_success 'unsetting submodules config from the working tree with "submodule--helper config --unset"' '
+	(cd super &&
+		git submodule--helper config --unset submodule.submodule.url &&
+		git submodule--helper config submodule.submodule.url >actual &&
+		test_must_be_empty actual
+	)
+'
+
+
 test_expect_success 'writing submodules config with "submodule--helper config"' '
 	(cd super &&
 		echo "new_url" >expect &&
-- 
2.20.1.522.g5f42c252e9

