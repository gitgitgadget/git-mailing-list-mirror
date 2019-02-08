Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6FFD1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 11:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfBHLVf (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 06:21:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41381 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHLVf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 06:21:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so1527592pfi.8
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 03:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gmPLZydiL8Cx8rABMoM1PM2RP7+7iShM38FR2ZJgZ2g=;
        b=mk9tGENZxkQRqK3T6MjVW9R/3fHmsexyF9HeFk+U27YzkxQCUEuKDzYdboMOOdsIh0
         NGAWUPrte2anJFmCBsCCBT7rkwxQ3p4LH1DSvAZvGLF0WrZiNdCGWj3wEpErL/hsbKGw
         xrsTKqfWSKvtk/WZzOvnJeMBJcdaR9YmgXnbJNqbldF2uIp3HgBCx2ngl5Kw87LCU3yq
         yJd1kPp0E7zULVW9ewDsTnZd+3gy2Sob3xDO8gvGKMcca8zIWW9DyhsdloiW4vjFMUyY
         5VDQvkd9eEY8EHo6x2XD5eMV1rF5kFcLUPUeJ7S/71QCmFhcOXHOWVuT0OPiBP5/8/eC
         u9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gmPLZydiL8Cx8rABMoM1PM2RP7+7iShM38FR2ZJgZ2g=;
        b=OqR2dcMsVPvT0guNQFNmxqOvAWyVvAT4zqXZi4arvhSIJbabav+vQpa6M0Iz9oPfgR
         F/qNpKkSUbQCju3QN2q6N2YoAiCMPvhWHWz4bAZ/9bq/uFS2qHxrzQHme8P/XvJa16sv
         r4lQDPWGwyABEbKYLHRyKsi7OxM10/XhbivJHJdhBxK4qw679w79MeYqtDmrFXFBq6Ks
         9kguwvfBth7qVnsSUYQIRluprgsrD5a4Ox025wbGNXYSPksF8+W+s5N+PqNvMg0JmP6t
         KPK3LQ3N8AzeFuqQeN3n0yJy3U92SCtDfvtN4e8IyI0T/3uEfExyZXG2+qLZsBGIeD+R
         dRrg==
X-Gm-Message-State: AHQUAua1GVtCTPtJ9huBnychFpeAqnhaHAXT2ZnIQ871r0qVf9mw0uRD
        Tk1Rlvx+N5jDKnKCHffe5DCmEiYR
X-Google-Smtp-Source: AHgI3IbApeD1fzq0YNDSpk5WkB6lbXg57wJ9WsJfYW1YKRDl3dLECUgcwvs3LMkOWXJJasaBJNIt+g==
X-Received: by 2002:a63:fc59:: with SMTP id r25mr4734520pgk.302.1549624894039;
        Fri, 08 Feb 2019 03:21:34 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id g20sm3231799pfg.85.2019.02.08.03.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 03:21:33 -0800 (PST)
Date:   Fri, 8 Feb 2019 03:21:31 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v4 2/3] submodule--helper: teach config subcommand --unset
Message-ID: <e204c58f0fd702a9bbd09fcc033ca1a9f99cd362.1549624679.git.liu.denton@gmail.com>
References: <cover.1549534460.git.liu.denton@gmail.com>
 <cover.1549624679.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549624679.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches submodule--helper config the --unset option, which removes
the specified configuration key from the .gitmodule file.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/submodule--helper.c | 17 ++++++++++++-----
 t/t7411-submodule-config.sh |  9 +++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0e140f176c..449e56f30c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2147,17 +2147,22 @@ static int check_name(int argc, const char **argv, const char *prefix)
 static int module_config(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		CHECK_WRITEABLE = 1
+		CHECK_WRITEABLE = 1,
+		DO_UNSET = 2
 	} command = 0;
 
 	struct option module_config_options[] = {
 		OPT_CMDMODE(0, "check-writeable", &command,
 			    N_("check if it is safe to write to the .gitmodules file"),
 			    CHECK_WRITEABLE),
+		OPT_CMDMODE(0, "unset", &command,
+			    N_("unset the config in the .gitmodules file"),
+			    DO_UNSET),
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper config name [value]"),
+		N_("git submodule--helper config <name> [<value>]"),
+		N_("git submodule--helper config --unset <name>"),
 		N_("git submodule--helper config --check-writeable"),
 		NULL
 	};
@@ -2169,15 +2174,17 @@ static int module_config(int argc, const char **argv, const char *prefix)
 		return is_writing_gitmodules_ok() ? 0 : -1;
 
 	/* Equivalent to ACTION_GET in builtin/config.c */
-	if (argc == 2)
+	if (argc == 2 && command != DO_UNSET)
 		return print_config_from_gitmodules(the_repository, argv[1]);
 
 	/* Equivalent to ACTION_SET in builtin/config.c */
-	if (argc == 3) {
+	if (argc == 3 || (argc == 2 && command == DO_UNSET)) {
+		const char *value = (argc == 3) ? argv[2] : NULL;
+
 		if (!is_writing_gitmodules_ok())
 			die(_("please make sure that the .gitmodules file is in the working tree"));
 
-		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
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

