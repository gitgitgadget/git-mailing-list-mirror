Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8DDC433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 19:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiKITet (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiKITeq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 14:34:46 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B89E225
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 11:34:45 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v17so28604609edc.8
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 11:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQ9PkqmSjW9fPATZnZRCUb0G/3O7miHrAaJAdh4MEl4=;
        b=crg5r5AvGcKwjoaeoXdpExbyWxUjRPkIONLXj0Sh1i9ZD2DdHLMgay9DGGJZr74ved
         5+G6sp9AsMTWz9bvPxXc3g0Icrrt5+1jsQMKvmeF4WdC6cOuUcGo6HrlAIg4G40zehbm
         23FgUSZAqlZ7D/npfhaZMcApoiEnMUEbCJj4+F8Cg3DITsgnKkSH4/wuSfzQrMo6G1iC
         ZrzgyYEr+oSMd+9jt5XYPHoXA4QOyLW6bFXq4dwqzSmJ8wvFe5WNlHrxDMFL1fyN+hj0
         Om8WULP8qCeXOJOW/nnh4QlQcuPv/qOgPy/HBUoV2/tdPt/fGhn3GXulJSP7Ezp6IEec
         OCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQ9PkqmSjW9fPATZnZRCUb0G/3O7miHrAaJAdh4MEl4=;
        b=iCZ89kwFPNgx2FswbvFI1pPS29pUb5l1szMW8GxqZ/9vbtVeQF4Q4k9l93GXSgZz+t
         iqVGEz4GCnJDTPo708bY1tHd3Mxt2ukLHnTvuztnO7LAs4nkuF6kZt8Fnmp1fKD3XbRH
         muQuo7RD0zo53ZGFoRuM7xesYJt6UlMzoslcKALCMQkIn0wh83MZxjNMO1zOyRVAXSGG
         Wk9esGKlPesV5qO8kRUn7C454yRLXt8ghjwLGH2BE+J9bCyFIx+Rice3pvh9ceaDqI9U
         OdvHKXRZwoezqDJkq5JfwrbP3Rs5a0PGTbOyanj89qklvQQqSauZXsx5NVlXXF0p4Lt/
         uLDA==
X-Gm-Message-State: ACrzQf1fefspFL+WfWy718LVeZg2wX+P5fa773RCXeI/lgzSIy0XIgas
        jvTXA2N+fthfts3x2PIju/tIO5FQIppJFw==
X-Google-Smtp-Source: AMsMyM5L/6yUWxghBnqq+6ujL0d/iWVPnJPS+s8M9y1GI+OwIapYVHmMvAINiwECyMzjVjiXyceoXg==
X-Received: by 2002:a05:6402:b9e:b0:463:1a8f:820a with SMTP id cf30-20020a0564020b9e00b004631a8f820amr55819264edb.406.1668022483206;
        Wed, 09 Nov 2022 11:34:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q21-20020a056402041500b004589da5e5cesm7387566edv.41.2022.11.09.11.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:34:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 3/8] submodule--helper: convert "foreach" to its own "--super-prefix"
Date:   Wed,  9 Nov 2022 20:34:31 +0100
Message-Id: <RFC-patch-3.8-4858e2ad0ed-20221109T192315Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
References: <20221109004708.97668-1-chooglen@google.com> <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with a preceding commit to convert "absorbgitdirs", we can convert
"submodule--helper foreach" to use its own "--super-prefix", instead
of relying on the global "--super-prefix" argument to "git"
itself. See that earlier commit for the rationale and background.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c4d5e029b37..989c75280af 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -285,6 +285,7 @@ struct foreach_cb {
 	int argc;
 	const char **argv;
 	const char *prefix;
+	const char *super_prefix;
 	int quiet;
 	int recursive;
 };
@@ -300,7 +301,8 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *displaypath;
 
-	displaypath = get_submodule_displaypath(path, info->prefix);
+	displaypath = get_submodule_displaypath_sp(path, info->prefix,
+						   info->super_prefix);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -370,10 +372,10 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		cpr.dir = path;
 		prepare_submodule_repo_env(&cpr.env);
 
-		strvec_pushl(&cpr.args, "--super-prefix", NULL);
-		strvec_pushf(&cpr.args, "%s/", displaypath);
 		strvec_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
 			     NULL);
+		strvec_pushl(&cpr.args, "--super-prefix", NULL);
+		strvec_pushf(&cpr.args, "%s/", displaypath);
 
 		if (info->quiet)
 			strvec_push(&cpr.args, "--quiet");
@@ -396,7 +398,9 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	struct foreach_cb info = FOREACH_CB_INIT;
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
+	const char *super_prefix = NULL;
 	struct option module_foreach_options[] = {
+		OPT__SUPER_PREFIX(&super_prefix),
 		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
 		OPT_BOOL(0, "recursive", &info.recursive,
 			 N_("recurse into nested submodules")),
@@ -417,6 +421,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	info.argc = argc;
 	info.argv = argv;
 	info.prefix = prefix;
+	info.super_prefix = super_prefix;
 
 	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
 
@@ -3390,8 +3395,8 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	subcmd = argv[0];
 
 	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
-	    strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
-	    strcmp(subcmd, "sync") && get_super_prefix())
+	    strcmp(subcmd, "status") && strcmp(subcmd, "sync") &&
+	    get_super_prefix())
 		/*
 		 * xstrfmt() rather than "%s %s" to keep the translated
 		 * string identical to git.c's.
-- 
2.38.0.1467.g709fbdff1a9

