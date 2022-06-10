Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B726C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345885AbiFJCCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244188AbiFJCBz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:01:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51296D1B6
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:01:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x17so34640535wrg.6
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuiohgOZJcJpB/4P2Kb33rwOlO2lK/7Zha5CpV6bUKw=;
        b=JslQr7Ke5tLvjdsvEzzcUXqn5CuwckPdHuY4obH1xgQoAP0tKByL40zP/yykhr9oxb
         TycAwr+w6XFytlh9lpzWUN0AAS+OvXYZwkjclq0bEP/CHYo8J+VD/hfotO0dwEheTNLS
         jVObdLCW9VAA6JF0tbUYYBMPnr0shSxtT4w1QZtUnuqhfSrQmJJ3JycMr1MmJpZsVF/M
         EVgizzLS6k8GtTGk3kHQy8HyQ0Y570v/9j8LsknQJ5ePpgV4u29Hyg/qw/rx+0iQcSvD
         oX/aX1BFZPzbWZZtD80DQgvgZmG3Q54OOuPAouszdkw+28XBIpsSEHq8XyMcNRjnQisu
         /nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuiohgOZJcJpB/4P2Kb33rwOlO2lK/7Zha5CpV6bUKw=;
        b=h/Rz5fgXEO0aGPmBKV3sPjABptCV73vJjKTsrb/1cCHuLj0KAD/xg/yUJCdKo5tDCK
         GWq5GHC1UxMD3zQDG22j8KsSPyGJPlYLa+6J4/mba1Ys3j316Q8Y4XuaCUZEUUptpLtS
         qFFHFoBB8SzsS4mJD6nG9G0NSgmXdMe60Q4hoIIcdzcDCSSGwtMR3pspYOlYAu816Pik
         qAS6MbrAdrulatZdUc1+m2BkgBfY1QrNVVlNLGXVZhvlqJHyMI6Ffb8pJtdX1oZdjEAx
         iwurZWGnz51h1GTv/hK/2V2WL6XnKqrro3CLa/wcJB2ZplnBzvzeLM2zgW1IneIp8W2g
         V0Mw==
X-Gm-Message-State: AOAM530J/le/RWf/UdHs6oSlTYE9Uypx/ay6/zxgDfCFNgjfu3HxLZjh
        jcYYj/Tw+LhpOMFl5Cjzloy71PbEEl7Oww==
X-Google-Smtp-Source: ABdhPJzOyR14Vuv/+TBSuDClxYSgsVoMU8WJV593NWN3CExYBzekHRigbm4bKhQhGrbJl49q687O+g==
X-Received: by 2002:adf:f14b:0:b0:213:b98e:c0df with SMTP id y11-20020adff14b000000b00213b98ec0dfmr37109230wro.79.1654826512088;
        Thu, 09 Jun 2022 19:01:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 08/20] submodule--helper: pretend to be "git submodule" in "-h" output
Date:   Fri, 10 Jun 2022 04:01:20 +0200
Message-Id: <RFC-patch-08.20-0c1a5063653-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the usage output for "git submodule--helper" so that it will
pretend to be named "git submodule". This will allow us to dispatch
further into "git submodule--helper" from git-submodule.sh while
emitting the correct usage output.

This fixes a bug that's been there ever since "git submodule
absorbgitdirs" was added in f6f85861400 (submodule: add absorb-git-dir
function, 2016-12-12). Before this we'd emit e.g. this on invalid
usage:

	$ git submodule absorbgitdirs --blah
	error: unknown option `blah'
	usage: git submodule--helper absorbgitdirs [<options>] [<path>...]

Now we'll emit the same, except that the usage line is now referring
to the correct command run by the user:

	usage: git submodule absorbgitdirs [<options>] [<path>...]
	[.. same usage output ...]

Note that in the case of "status", "deinit" and "update" we were
already referring to ourselves as "git submodule" in
builtin/submodule--helper.c.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8df1541baf8..3173295ed8e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -286,7 +286,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
+		N_("git submodule list [--prefix=<path>] [<path>...]"),
 		NULL
 	};
 
@@ -444,7 +444,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper foreach [--quiet] [--recursive] [--] <command>"),
+		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
 		NULL
 	};
 
@@ -582,7 +582,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper init [<options>] [<path>]"),
+		N_("git submodule init [<options>] [<path>]"),
 		NULL
 	};
 
@@ -786,7 +786,7 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	const struct submodule *sub;
 
 	if (argc != 2)
-		usage(_("git submodule--helper name <path>"));
+		usage(_("git submodule name <path>"));
 
 	sub = submodule_from_path(the_repository, null_oid(), argv[1]);
 
@@ -1185,7 +1185,7 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper summary [<options>] [<commit>] [--] [<path>]"),
+		N_("git submodule summary [<options>] [<commit>] [--] [<path>]"),
 		NULL
 	};
 
@@ -1349,7 +1349,7 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper sync [--quiet] [--recursive] [<path>]"),
+		N_("git submodule sync [--quiet] [--recursive] [<path>]"),
 		NULL
 	};
 
@@ -1789,7 +1789,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
+		N_("git submodule clone [--prefix=<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
 		   "[--single-branch] [--filter <filter-spec>] "
 		   "--url <url> --path <path>"),
@@ -2784,7 +2784,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper absorbgitdirs [<options>] [<path>...]"),
+		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
 		NULL
 	};
 
@@ -2848,9 +2848,9 @@ static int module_config(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper config <name> [<value>]"),
-		N_("git submodule--helper config --unset <name>"),
-		"git submodule--helper config --check-writeable",
+		N_("git submodule config <name> [<value>]"),
+		N_("git submodule config --unset <name>"),
+		"git submodule config --check-writeable",
 		NULL
 	};
 
@@ -2889,7 +2889,7 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const usage[] = {
-		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
+		N_("git submodule set-url [--quiet] <path> <newurl>"),
 		NULL
 	};
 
@@ -2928,8 +2928,8 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const usage[] = {
-		N_("git submodule--helper set-branch [-q|--quiet] (-d|--default) <path>"),
-		N_("git submodule--helper set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
+		N_("git submodule set-branch [-q|--quiet] (-d|--default) <path>"),
+		N_("git submodule set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
 		NULL
 	};
 
@@ -2970,7 +2970,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const usage[] = {
-		N_("git submodule--helper create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"),
+		N_("git submodule create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"),
 		NULL
 	};
 
@@ -3273,7 +3273,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const usage[] = {
-		N_("git submodule--helper add [<options>] [--] <repository> [<path>]"),
+		N_("git submodule add [<options>] [--] <repository> [<path>]"),
 		NULL
 	};
 
-- 
2.36.1.1178.gb5b1747c546

