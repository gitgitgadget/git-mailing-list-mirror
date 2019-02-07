Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41E71211B5
	for <e@80x24.org>; Thu,  7 Feb 2019 06:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBGGdG (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 01:33:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37581 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfBGGdD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 01:33:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so4347552pfb.4
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 22:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kf9e4LRyCqZCmqgsE54RptfKjip3VWXLKuzyyiaBXOw=;
        b=ewObR1s+vO23eL2/HzzsgnODrGnxIWxsoBaZg0zl6WCzAzQNxWMX313uZBWGEstnMb
         4773WUPtUcxH0JxQKlCYpHwXVZyThdAHRPWbj7IwmjfMIYyOXpF9aV5NC6tUcfLbQ0kj
         ysIMXrNnZ9nJSgZDhLKK7ctcc05cyVTyDmbrtNrdrRZu2Ej4Itpf6qFP01UqD2xG/X+I
         Hl+OXPB1nCeCQgP+7xLk/x19i5ZEIjPNWWYotMAOz/nZqNV6niSPggjs6N5K/g7FsbJp
         pozFJNrVY7XW1pq43c5F7xjoJ9HBLKDT5qws4+LXKoOjPYwx3z/7QopReobc7YXFkg1d
         R/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kf9e4LRyCqZCmqgsE54RptfKjip3VWXLKuzyyiaBXOw=;
        b=ntpo7WFhUjCFpqFkjrpyBwtR+Dx8jTKiDpfZ39jSSeZlE9JBOElH1pfk4Kog4uGS+A
         lJ1zwgRnf8BM3btHrVRmvbEOOCSk/xZ6/jD4UIShh2kQdZau7B7fNqHa2XQfgul2TjLh
         rSbk9tSAcJTp96ljyOpEUse/waajzHFU55imrIWe04CqT4vVcTtkvAhbz7Dk2SxxR9Ua
         Uu9RTxayJN90UMW2RY2AE/uRReRBWP1gTHqdf+vKByTrHyBL6wbCrXQMjtOMUv967b25
         eBGQQYYCrP+/I4D1c7uNh67rf+jEDsXsgI3Kizg18dtnT/j0Bx6r5ZHnapdKvvJmJCbR
         8nKw==
X-Gm-Message-State: AHQUAuY38NFwgAztJZHMNPYFXMfTbQexl406tU8uKi5WvAuE2WSNiPGI
        vcFQmSZ9yDB24nfTz/bnvfZa95Jz
X-Google-Smtp-Source: AHgI3IZTeM1zpnzDgpBIFV8EKSSsPqS//RKvE/KoDXLlwYgh7gsAMr51Ejo4XFYLZcZl+c/LPKIqhw==
X-Received: by 2002:a63:2c8c:: with SMTP id s134mr12162787pgs.269.1549521181898;
        Wed, 06 Feb 2019 22:33:01 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id a13sm8965133pgq.65.2019.02.06.22.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 22:33:01 -0800 (PST)
Date:   Wed, 6 Feb 2019 22:32:59 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 2/3] submodule--helper: teach config subcommand --unset
Message-ID: <c562ca0c252da88cba8806e20e0803068616e80c.1549521103.git.liu.denton@gmail.com>
References: <cover.1549450636.git.liu.denton@gmail.com>
 <cover.1549521103.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549521103.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches submodule--helper config the --unset option, which removes
the specified configuration key from the .gitmodule file.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/submodule--helper.c | 18 ++++++++++++------
 t/t7411-submodule-config.sh |  9 +++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0e140f176c..5a4a7b1993 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2147,17 +2147,22 @@ static int check_name(int argc, const char **argv, const char *prefix)
 static int module_config(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		CHECK_WRITEABLE = 1
-	} command = 0;
+		NONE,
+		CHECK_WRITEABLE,
+		DO_UNSET
+	} command = NONE;
 
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
+		N_("git submodule--helper config name [--unset] [value]"),
 		N_("git submodule--helper config --check-writeable"),
 		NULL
 	};
@@ -2169,15 +2174,16 @@ static int module_config(int argc, const char **argv, const char *prefix)
 		return is_writing_gitmodules_ok() ? 0 : -1;
 
 	/* Equivalent to ACTION_GET in builtin/config.c */
-	if (argc == 2)
+	if (argc == 2 && command != DO_UNSET)
 		return print_config_from_gitmodules(the_repository, argv[1]);
 
 	/* Equivalent to ACTION_SET in builtin/config.c */
-	if (argc == 3) {
+	if (argc == 3 || (argc == 2 && command == DO_UNSET)) {
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

