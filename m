Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B84AC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E8F60F58
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbhJGLBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240626AbhJGLBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:01:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E780C061772
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:59:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o20so17775157wro.3
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=argkibHjUQ9fS/MNRyNYx0ks0Fl/uHUjHr6yTHx1viE=;
        b=KdG/IfQPme3p58PDKkK8RUfXxYWBuTC34JccgzPkKh+bzSty0/PQLRAQFDl/wE6veP
         T3NxymUKu+iEHNpIuokeRU2sG/nyY2zYkIiNwNZaV5GtBM7y3Se0ZJctS8dwMsnjeYk6
         XnSJBHIEsm/XeKiJaT3uGNc8DvnLg0xeq/JnvXl4YRkOh5jnax5pWpqHkvXCt+ggjsHA
         Kv7y8mr7KCF/xr2/a+69Lw+qFv/RLVLq4NNLqA/tbUIxX9p2qLDcIDBweAKh/m0AiJpb
         d+RHvoX4aW+yYWHs8q/6ve9VHW8Bsg9AI8+mpz/SJWiX3QQ3D+UbVgakL9ahVZOXJL8+
         J+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=argkibHjUQ9fS/MNRyNYx0ks0Fl/uHUjHr6yTHx1viE=;
        b=CKWzq7SE0SMrJz2+16TvQATFTLVyyA/fNIkYp8co6rnO13uYVxXKLfG74CgdHDReFA
         MZot3a2EY+QC9enshgRMuHhMORSJF4oYQ/RuWLx4/YGzGZSs4PiF3ALG0glgzPCqJiMs
         XXHBv/BhSNlxR3yufzwRrZMACQCuUD88xLuTow/oh1gvLwTv+eRzRq7Y4+B8d0H6Y72y
         qQaXgGUum3nms1CZiRrF3t6saudJD7pi/r4nafv/B6jCqoPfrulgGFz66CZtRPuOjjTd
         J/tKE3A7yV3OCJFtgQdjwXMm48T55eqPSYLKKcJnqM4rCswA/ZSCmvh9tWz9TnTpxdNO
         LSog==
X-Gm-Message-State: AOAM5339Dqxgsm3hwZp/ir3PFJT8+fOFlfnKj4AvnG8JcnMaSL17OymC
        aWZrt8TdaM1eKItC5JkGDWfYIzJYkA4=
X-Google-Smtp-Source: ABdhPJxf5crLtB8zsr9HF/jhU05OB5elZ/oO+cTR3xps2MZMQ616tsvnMedTtlPySey5iHGVX1cRuw==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr15902380wmc.59.1633604358655;
        Thu, 07 Oct 2021 03:59:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm24679958wrg.58.2021.10.07.03.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:59:18 -0700 (PDT)
Message-Id: <2967d7f1425e06f15e3f696fa873b952b128df51.1633604349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
References: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 10:59:06 +0000
Subject: [PATCH v5 12/15] scalar: teach 'reconfigure' to optionally handle all
 registered enlistments
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

After a Scalar upgrade, it can come in really handy if there is an easy
way to reconfigure all Scalar enlistments. This new option offers this
functionality.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 61 ++++++++++++++++++++++++++++++--
 contrib/scalar/scalar.txt        |  9 +++--
 contrib/scalar/t/t9099-scalar.sh |  3 ++
 3 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 6bebba0b51f..234a7dce479 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -487,22 +487,77 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
+static int get_scalar_repos(const char *key, const char *value, void *data)
+{
+	struct string_list *list = data;
+
+	if (!strcmp(key, "scalar.repo"))
+		string_list_append(list, value);
+
+	return 0;
+}
+
 static int cmd_reconfigure(int argc, const char **argv)
 {
+	int all = 0;
 	struct option options[] = {
+		OPT_BOOL('a', "all", &all,
+			 N_("reconfigure all registered enlistments")),
 		OPT_END(),
 	};
 	const char * const usage[] = {
-		N_("scalar reconfigure [<enlistment>]"),
+		N_("scalar reconfigure [--all | <enlistment>]"),
 		NULL
 	};
+	struct string_list scalar_repos = STRING_LIST_INIT_DUP;
+	int i, res = 0;
+	struct repository r = { NULL };
+	struct strbuf commondir = STRBUF_INIT, gitdir = STRBUF_INIT;
 
 	argc = parse_options(argc, argv, NULL, options,
 			     usage, 0);
 
-	setup_enlistment_directory(argc, argv, usage, options, NULL);
+	if (!all) {
+		setup_enlistment_directory(argc, argv, usage, options, NULL);
+
+		return set_recommended_config(1);
+	}
+
+	if (argc > 0)
+		usage_msg_opt(_("--all or <enlistment>, but not both"),
+			      usage, options);
+
+	git_config(get_scalar_repos, &scalar_repos);
 
-	return set_recommended_config(1);
+	for (i = 0; i < scalar_repos.nr; i++) {
+		const char *dir = scalar_repos.items[i].string;
+
+		strbuf_reset(&commondir);
+		strbuf_reset(&gitdir);
+
+		if (chdir(dir) < 0) {
+			warning_errno(_("could not switch to '%s'"), dir);
+			res = -1;
+		} else if (discover_git_directory(&commondir, &gitdir) < 0) {
+			warning_errno(_("git repository gone in '%s'"), dir);
+			res = -1;
+		} else {
+			git_config_clear();
+
+			the_repository = &r;
+			r.commondir = commondir.buf;
+			r.gitdir = gitdir.buf;
+
+			if (set_recommended_config(1) < 0)
+				res = -1;
+		}
+	}
+
+	string_list_clear(&scalar_repos, 1);
+	strbuf_release(&commondir);
+	strbuf_release(&gitdir);
+
+	return res;
 }
 
 static int cmd_run(int argc, const char **argv)
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index f4e4686e8c8..2fa96fcabc6 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -13,7 +13,7 @@ scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
-scalar reconfigure <enlistment>
+scalar reconfigure [ --all | <enlistment> ]
 
 DESCRIPTION
 -----------
@@ -32,8 +32,8 @@ an existing Git worktree with Scalar whose name is not `src`, the enlistment
 will be identical to the worktree.
 
 The `scalar` command implements various subcommands, and different options
-depending on the subcommand. With the exception of `clone` and `list`, all
-subcommands expect to be run in an enlistment.
+depending on the subcommand. With the exception of `clone`, `list` and
+`reconfigure --all`, all subcommands expect to be run in an enlistment.
 
 COMMANDS
 --------
@@ -124,6 +124,9 @@ After a Scalar upgrade, or when the configuration of a Scalar enlistment
 was somehow corrupted or changed by mistake, this subcommand allows to
 reconfigure the enlistment.
 
+With the `--all` option, all enlistments currently registered with Scalar
+will be reconfigured. Use this option after each Scalar upgrade.
+
 SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index e6d74a06ca0..5fe7fabd0e5 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -70,6 +70,9 @@ test_expect_success 'scalar reconfigure' '
 	scalar register one &&
 	git -C one/src config core.preloadIndex false &&
 	scalar reconfigure one &&
+	test true = "$(git -C one/src config core.preloadIndex)" &&
+	git -C one/src config core.preloadIndex false &&
+	scalar reconfigure -a &&
 	test true = "$(git -C one/src config core.preloadIndex)"
 '
 
-- 
gitgitgadget

