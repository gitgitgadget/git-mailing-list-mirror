Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6D2C433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C9161073
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbhJ0Ia2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbhJ0IaE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:30:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64631C06122C
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p14so2645330wrd.10
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jJDYJo44Y8BM7lrDqtg86RWVN1sbIBqsCul47VJJ01s=;
        b=lgoGWhMGhVIehBsdKGdvBTqsF+12/hVfMyCbqXQEnkXoqUUF7BtwhwPJYx51+N+8Hm
         7+oer5YhiTqb0Cafj0nIcVQUUWOGRbj/zMYTSi6FwpdHwkliK/9oLCfF9fRI0sQuJH8B
         oHkbg1joGA0U50dtj7riuHJMCMIeForPHiBS0jl+grStIXfIPbW+E3i8p3f7mvgDCqSW
         96ZxBqwwqmQe16ZTpesfPKFZWuAicHNCB0UsMkhdC/WCd86GW1bkhqnRUkU6Xaf6b009
         BVF2kwmf4sGFx3B21EjA2tfaZtpykF5HdBIKnDMBEje2gpnOyg/g7n0h2CcW9/oSKL/A
         KOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jJDYJo44Y8BM7lrDqtg86RWVN1sbIBqsCul47VJJ01s=;
        b=UmpdTIt+AvdxS7Uwoz4n5JFMPdiSBnIlDr0ZrHkRj/y6DXZJ2XZcYiLVkZ4YkhGbkl
         jbE/exk8BGD/PfkvCa9BaN+G1myaAiTKF6SD8qrTyUOsndydBA2wR72U+TZUO9gpIVDu
         Rwo6b3z9D7N/xY7Xt2dRjU601VzgC0sPY4vxgZGBVe+delE2qv1K7Weiy0y/gg3VHaMu
         cnBhfwZ70iIxnWA6D7rFLNYsKBrkAN/d9s4Bx1wOIa2sdKQZBwlW8LhRovyiS3TIXyJc
         vyqnlU/IsLNZLIfKo88iEQxzyj+ROOUjsoRnMY6DAEPVY8m/ZsohQqYl2JhwwU/Zb5Wm
         qIkg==
X-Gm-Message-State: AOAM530ZSADo2SIXq9cxs/EOwgRRXKshxU28tSA25RoMOQQiuNcigofW
        DZ0e8vGG5dK3Ez3Z4fWl6/OQMk37g0E=
X-Google-Smtp-Source: ABdhPJwsO3tm4ALp2zLGP0pAXqvLekdhP7yywHCFqRYEA+raV8kRCIxULmXMeiY+jHDcRUBYNZGqvg==
X-Received: by 2002:adf:f5c1:: with SMTP id k1mr16061458wrp.96.1635323247061;
        Wed, 27 Oct 2021 01:27:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm23056868wrr.67.2021.10.27.01.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:27:26 -0700 (PDT)
Message-Id: <c4778c1dc5fc20d06918504132be21f5d4b6a50a.1635323239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
References: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
        <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 08:27:15 +0000
Subject: [PATCH v6 11/15] scalar: allow reconfiguring an existing enlistment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This comes in handy during Scalar upgrades, or when config settings were
messed up by mistake.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 79 +++++++++++++++++++++-----------
 contrib/scalar/scalar.txt        |  8 ++++
 contrib/scalar/t/t9099-scalar.sh |  8 ++++
 3 files changed, 67 insertions(+), 28 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index d9631287e12..6bebba0b51f 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -108,18 +108,20 @@ static int run_git(const char *arg, ...)
 	return res;
 }
 
-static int set_recommended_config(void)
+static int set_recommended_config(int reconfigure)
 {
 	struct {
 		const char *key;
 		const char *value;
+		int overwrite_on_reconfigure;
 	} config[] = {
-		{ "am.keepCR", "true" },
-		{ "core.FSCache", "true" },
-		{ "core.multiPackIndex", "true" },
-		{ "core.preloadIndex", "true" },
+		/* Required */
+		{ "am.keepCR", "true", 1 },
+		{ "core.FSCache", "true", 1 },
+		{ "core.multiPackIndex", "true", 1 },
+		{ "core.preloadIndex", "true", 1 },
 #ifndef WIN32
-		{ "core.untrackedCache", "true" },
+		{ "core.untrackedCache", "true", 1 },
 #else
 		/*
 		 * Unfortunately, Scalar's Functional Tests demonstrated
@@ -133,28 +135,29 @@ static int set_recommended_config(void)
 		 * Therefore, with a sad heart, we disable this very useful
 		 * feature on Windows.
 		 */
-		{ "core.untrackedCache", "false" },
+		{ "core.untrackedCache", "false", 1 },
 #endif
-		{ "core.logAllRefUpdates", "true" },
-		{ "credential.https://dev.azure.com.useHttpPath", "true" },
-		{ "credential.validate", "false" }, /* GCM4W-only */
-		{ "gc.auto", "0" },
-		{ "gui.GCWarning", "false" },
-		{ "index.threads", "true" },
-		{ "index.version", "4" },
-		{ "merge.stat", "false" },
-		{ "merge.renames", "false" },
-		{ "pack.useBitmaps", "false" },
-		{ "pack.useSparse", "true" },
-		{ "receive.autoGC", "false" },
-		{ "reset.quiet", "true" },
-		{ "feature.manyFiles", "false" },
-		{ "feature.experimental", "false" },
-		{ "fetch.unpackLimit", "1" },
-		{ "fetch.writeCommitGraph", "false" },
+		{ "core.logAllRefUpdates", "true", 1 },
+		{ "credential.https://dev.azure.com.useHttpPath", "true", 1 },
+		{ "credential.validate", "false", 1 }, /* GCM4W-only */
+		{ "gc.auto", "0", 1 },
+		{ "gui.GCWarning", "false", 1 },
+		{ "index.threads", "true", 1 },
+		{ "index.version", "4", 1 },
+		{ "merge.stat", "false", 1 },
+		{ "merge.renames", "false", 1 },
+		{ "pack.useBitmaps", "false", 1 },
+		{ "pack.useSparse", "true", 1 },
+		{ "receive.autoGC", "false", 1 },
+		{ "reset.quiet", "true", 1 },
+		{ "feature.manyFiles", "false", 1 },
+		{ "feature.experimental", "false", 1 },
+		{ "fetch.unpackLimit", "1", 1 },
+		{ "fetch.writeCommitGraph", "false", 1 },
 #ifdef WIN32
-		{ "http.sslBackend", "schannel" },
+		{ "http.sslBackend", "schannel", 1 },
 #endif
+		/* Optional */
 		{ "status.aheadBehind", "false" },
 		{ "commitGraph.generationVersion", "1" },
 		{ "core.autoCRLF", "false" },
@@ -165,7 +168,8 @@ static int set_recommended_config(void)
 	char *value;
 
 	for (i = 0; config[i].key; i++) {
-		if (git_config_get_string(config[i].key, &value)) {
+		if ((reconfigure && config[i].overwrite_on_reconfigure) ||
+		    git_config_get_string(config[i].key, &value)) {
 			trace2_data_string("scalar", the_repository, config[i].key, "created");
 			if (git_config_set_gently(config[i].key,
 						  config[i].value) < 0)
@@ -230,7 +234,7 @@ static int register_dir(void)
 	int res = add_or_remove_enlistment(1);
 
 	if (!res)
-		res = set_recommended_config();
+		res = set_recommended_config(0);
 
 	if (!res)
 		res = toggle_maintenance(1);
@@ -418,7 +422,7 @@ static int cmd_clone(int argc, const char **argv)
 	    (res = run_git("sparse-checkout", "init", "--cone", NULL)))
 		goto cleanup;
 
-	if (set_recommended_config())
+	if (set_recommended_config(0))
 		return error(_("could not configure '%s'"), dir);
 
 	if ((res = run_git("fetch", "--quiet", "origin", NULL))) {
@@ -483,6 +487,24 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
+static int cmd_reconfigure(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar reconfigure [<enlistment>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	setup_enlistment_directory(argc, argv, usage, options, NULL);
+
+	return set_recommended_config(1);
+}
+
 static int cmd_run(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -619,6 +641,7 @@ static struct {
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
 	{ "run", cmd_run },
+	{ "reconfigure", cmd_reconfigure },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 39143b08324..89fd7901585 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -13,6 +13,7 @@ scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
+scalar reconfigure <enlistment>
 
 DESCRIPTION
 -----------
@@ -117,6 +118,13 @@ opinionated default settings that make Git work more efficiently with
 large repositories. As this task is run as part of `scalar clone`
 automatically, explicit invocations of this task are rarely needed.
 
+Reconfigure
+~~~~~~~~~~~
+
+After a Scalar upgrade, or when the configuration of a Scalar enlistment
+was somehow corrupted or changed by mistake, this subcommand allows to
+reconfigure the enlistment.
+
 SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 9a35ab4fde6..e6d74a06ca0 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -65,4 +65,12 @@ test_expect_success 'scalar clone' '
 	)
 '
 
+test_expect_success 'scalar reconfigure' '
+	git init one/src &&
+	scalar register one &&
+	git -C one/src config core.preloadIndex false &&
+	scalar reconfigure one &&
+	test true = "$(git -C one/src config core.preloadIndex)"
+'
+
 test_done
-- 
gitgitgadget

