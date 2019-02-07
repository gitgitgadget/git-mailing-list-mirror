Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10C81F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfBGKTB (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:19:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44474 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfBGKTB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:19:01 -0500
Received: by mail-pl1-f194.google.com with SMTP id p4so4552278plq.11
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LSguYJ0JwFdSlgtxUqnrD01QHLcQemGRCQs5CQwKXRc=;
        b=KGpEh9eD8EYDgAooYDH3ihBqFxFsfxLH9CCV8I2aDYf2uw5sdoF3ulEIMo7zUU9y2A
         FKcVuAbc/Li73PNslWR3QdPwoH8q9pjX5tiNvx+4jc/yavXROt40AkgKZmzKO+tczLbY
         nSIEpN70HXJvqgdVRIWFnxUb/JgAHRwm75pmAP6zepJzeYTjZE9HjbXpga9sIgwAaasw
         ktqCo9SNVJZQsU3oZmxPdRmDs975QvTBhaJRLpiNFNQP8KJZsj/rv+hyUiXXYJT9qMLO
         /+W+XjpiElx3LmUHry5m42yfQ4o7MgBQei8mbXMYyPAwiFt1miBtHyfmAGSGB1Owtceb
         42Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LSguYJ0JwFdSlgtxUqnrD01QHLcQemGRCQs5CQwKXRc=;
        b=gyzILqYqQ4t0OPi5GLujV2jhrKAm3KLJmQCr3cEXzJyuFyBwwrGRu1Zs8hNK/TXp4g
         b2ztHzntl7MuMuHBxO1z+lTI128v2FH4GZoWo3lGSDxtFskcCZywng6dJiYiLpXrSld9
         MR5uI2rrUlCk5Zef6Rz5e0LyskkX1wJRhsYrS20xtAquGb/AaKBiiRwuLV8whsiRYb1P
         p5aeGEdZJ8zJZDZmYrwCOf2kInOwQID+KV8H3XGd547MWaNmS8jhzGfQi7uoUnKt10UC
         cbhyu4akBF6SHmOS79EpQsPwZ/8AWtRi4dgJNwEmMildeu+CrFOwe974lwvZT/StFFPP
         Ji6Q==
X-Gm-Message-State: AHQUAuZ3F4OvOk4fGiJaPWTJdOEVR/US08fxqUFr3AMC25SwXabsmv17
        Tdf0+mzmiYxrIxcSDcDJvi7flO+m
X-Google-Smtp-Source: AHgI3IYW/xmQMK3aVbJdEL+YvQ24pB2c0TugBThhyPXrLG5HmWa5dt+9edDPXePQ1mhm1yNyOaSleQ==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr15093562plb.6.1549534740068;
        Thu, 07 Feb 2019 02:19:00 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id w5sm11183652pfn.89.2019.02.07.02.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 02:18:59 -0800 (PST)
Date:   Thu, 7 Feb 2019 02:18:57 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v3 2/3] submodule--helper: teach config subcommand --unset
Message-ID: <e90dfe992e96b33f167d08fe51df49ab1d10ef23.1549534460.git.liu.denton@gmail.com>
References: <cover.1549521103.git.liu.denton@gmail.com>
 <cover.1549534460.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549534460.git.liu.denton@gmail.com>
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
index b80fc4ba3d..a86eacf167 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2148,17 +2148,22 @@ static int check_name(int argc, const char **argv, const char *prefix)
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
@@ -2170,15 +2175,16 @@ static int module_config(int argc, const char **argv, const char *prefix)
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

