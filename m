Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7A2C4332F
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 16:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiCIQDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiCIQC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 11:02:59 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7020F1795DE
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 08:01:59 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so3735950wmj.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wtq4sy4sjg9ijxSnEbwHlFT5qYc6N4W4kaL9UO5zixo=;
        b=LVthuGICN2ngnO5HXMvgLcIEg80Q9I6Wh4d/V8vaHXtQMehEWNG+8O43Zj2SiSo/8B
         dlhiaxVWdkUsQ3rlQcxLqAsiegw2iTDgxYHYniWBXj4cTMCTc4JTY95z6kjpX5OCtNZn
         DugRN7FS9IpnLNrLQ1olr34GEShIoMVM7/j6Edu0gevArx6vc1I7WJH2T7TbudN4/v5J
         toARHKRzqTOHnq1arcRSB+Irt6vs9gEv15/PU/JW/vDzJMCUtvNQYdLslNfhiLyolclU
         vspElfV0WnCqklD+H5JBY1NCtutH7OKRNCkGkT5xdmbMU9mtF4wprvnTZQQ2z6S4O5GA
         imvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wtq4sy4sjg9ijxSnEbwHlFT5qYc6N4W4kaL9UO5zixo=;
        b=hl9LxC26NiNz3LCHlp+K9pYOzWmeyfTQZZSoljs+O79af3G9k438Y5XFB4OvOTCfID
         xNWk24lRErb4xKwHzdvjjACdIeCR08eTq37WiNtOsb2RUdEPYImkZR/hBPBP/haaWYki
         qPyRft1ZpEUtuTgRXxvhQpqasD/REKaWfHDsL0o2kqPTFSwOYThkMRIiPEcmOt4raJMC
         cbM+CPtehLuFroZTBygSmBgM+umqz53NVP0Ys+j27tNNS5s2mVJ+hDFU8CrXo7rn+0H5
         IhzExSqlIq4La+tH00ucB0wlda1RGtMphyNR0TQMOvxXDKFGcPSrQ13DFLmgR47XvWxc
         kj0Q==
X-Gm-Message-State: AOAM530yFF5S5DWQIz0p2Hk3zuBOcJFUxG5to8/C2rnrBEo5IPvrBWeH
        nm9Kbtirkgr45ogHhLJ6fGLflFP7dTg=
X-Google-Smtp-Source: ABdhPJyoP65g/4WzdgsXDeKZvnDzJq+kiKMmcglDfNedzn5P6PlDu5Ye5yZgswUoslRY8X37CL31ww==
X-Received: by 2002:a05:600c:3b13:b0:389:cf43:eaf5 with SMTP id m19-20020a05600c3b1300b00389cf43eaf5mr41139wms.198.1646841717792;
        Wed, 09 Mar 2022 08:01:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b0037bf934bca3sm6366611wmq.17.2022.03.09.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:01:57 -0800 (PST)
Message-Id: <7435095bbc997ee8646bdfd804b1e820ffa80100.1646841704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 16:01:41 +0000
Subject: [PATCH v4 11/13] bundle: create filtered bundles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

A previous change allowed Git to parse bundles with the 'filter'
capability. Now, teach Git to create bundles with this option.

Some rearranging of code is required to get the option parsing in the
correct spot. There are now two reasons why we might need capabilities
(a new hash algorithm or an object filter) so that is pulled out into a
place where we can check both at the same time.

The --filter option is parsed as part of setup_revisions(), but it
expected the --objects flag, too. That flag is somewhat implied by 'git
bundle' because it creates a pack-file walking objects, but there is
also a walk that walks the revision range expecting only commits. Make
this parsing work by setting 'revs.tree_objects' and 'revs.blob_objects'
before the call to setup_revisions().

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle.c               | 53 +++++++++++++++++++++++++++++++++---------
 t/t6020-bundle-misc.sh | 48 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 11 deletions(-)

diff --git a/bundle.c b/bundle.c
index 41e75efab9a..9370a6e307c 100644
--- a/bundle.c
+++ b/bundle.c
@@ -332,6 +332,9 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
 		     "--stdout", "--thin", "--delta-base-offset",
 		     NULL);
 	strvec_pushv(&pack_objects.args, pack_options->v);
+	if (revs->filter.choice)
+		strvec_pushf(&pack_objects.args, "--filter=%s",
+			     list_objects_filter_spec(&revs->filter));
 	pack_objects.in = -1;
 	pack_objects.out = bundle_fd;
 	pack_objects.git_cmd = 1;
@@ -499,10 +502,37 @@ int create_bundle(struct repository *r, const char *path,
 	int bundle_to_stdout;
 	int ref_count = 0;
 	struct rev_info revs, revs_copy;
-	int min_version = the_hash_algo == &hash_algos[GIT_HASH_SHA1] ? 2 : 3;
+	int min_version = 2;
 	struct bundle_prerequisites_info bpi;
 	int i;
 
+	/* init revs to list objects for pack-objects later */
+	save_commit_buffer = 0;
+	repo_init_revisions(r, &revs, NULL);
+
+	/*
+	 * Pre-initialize the '--objects' flag so we can parse a
+	 * --filter option successfully.
+	 */
+	revs.tree_objects = revs.blob_objects = 1;
+
+	argc = setup_revisions(argc, argv, &revs, NULL);
+
+	/*
+	 * Reasons to require version 3:
+	 *
+	 * 1. @object-format is required because our hash algorithm is not
+	 *    SHA1.
+	 * 2. @filter is required because we parsed an object filter.
+	 */
+	if (the_hash_algo != &hash_algos[GIT_HASH_SHA1] || revs.filter.choice)
+		min_version = 3;
+
+	if (argc > 1) {
+		error(_("unrecognized argument: %s"), argv[1]);
+		goto err;
+	}
+
 	bundle_to_stdout = !strcmp(path, "-");
 	if (bundle_to_stdout)
 		bundle_fd = 1;
@@ -525,17 +555,14 @@ int create_bundle(struct repository *r, const char *path,
 		write_or_die(bundle_fd, capability, strlen(capability));
 		write_or_die(bundle_fd, the_hash_algo->name, strlen(the_hash_algo->name));
 		write_or_die(bundle_fd, "\n", 1);
-	}
-
-	/* init revs to list objects for pack-objects later */
-	save_commit_buffer = 0;
-	repo_init_revisions(r, &revs, NULL);
 
-	argc = setup_revisions(argc, argv, &revs, NULL);
-
-	if (argc > 1) {
-		error(_("unrecognized argument: %s"), argv[1]);
-		goto err;
+		if (revs.filter.choice) {
+			const char *value = expand_list_objects_filter_spec(&revs.filter);
+			capability = "@filter=";
+			write_or_die(bundle_fd, capability, strlen(capability));
+			write_or_die(bundle_fd, value, strlen(value));
+			write_or_die(bundle_fd, "\n", 1);
+		}
 	}
 
 	/* save revs.pending in revs_copy for later use */
@@ -558,6 +585,10 @@ int create_bundle(struct repository *r, const char *path,
 	bpi.fd = bundle_fd;
 	bpi.pending = &revs_copy.pending;
 
+	/*
+	 * Remove any object walking here. We only care about commits and
+	 * tags here. The revs_copy has the right instances of these values.
+	 */
 	revs.blob_objects = revs.tree_objects = 0;
 	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
 	object_array_remove_duplicates(&revs_copy.pending);
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index df5ff561fa5..6e97c044ee7 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -487,4 +487,52 @@ test_expect_success 'unfiltered bundle with --objects' '
 	test_cmp expect actual
 '
 
+for filter in "blob:none" "tree:0" "tree:1" "blob:limit=100"
+do
+	test_expect_success "filtered bundle: $filter" '
+		test_when_finished rm -rf .git/objects/pack cloned unbundled &&
+		git bundle create partial.bdl \
+			--all \
+			--filter=$filter &&
+
+		git bundle verify partial.bdl >unfiltered &&
+		make_user_friendly_and_stable_output <unfiltered >actual &&
+
+		cat >expect <<-EOF &&
+		The bundle contains these 10 refs:
+		<COMMIT-P> refs/heads/main
+		<COMMIT-N> refs/heads/release
+		<COMMIT-D> refs/heads/topic/1
+		<COMMIT-H> refs/heads/topic/2
+		<COMMIT-D> refs/pull/1/head
+		<COMMIT-G> refs/pull/2/head
+		<TAG-1> refs/tags/v1
+		<TAG-2> refs/tags/v2
+		<TAG-3> refs/tags/v3
+		<COMMIT-P> HEAD
+		The bundle uses this filter: $filter
+		The bundle records a complete history.
+		EOF
+		test_cmp expect actual &&
+
+		test_config uploadpack.allowfilter 1 &&
+		test_config uploadpack.allowanysha1inwant 1 &&
+		git clone --no-local --filter=$filter --bare "file://$(pwd)" cloned &&
+
+		git init unbundled &&
+		git -C unbundled bundle unbundle ../partial.bdl >ref-list.txt &&
+
+		# Count the same number of reachable objects.
+		reflist=$(git for-each-ref --format="%(objectname)") &&
+		git rev-list --objects --filter=$filter --missing=allow-any \
+			$reflist >expect &&
+		for repo in cloned unbundled
+		do
+			git -C $repo rev-list --objects --missing=allow-any \
+				$reflist >actual &&
+			test_cmp expect actual || return 1
+		done
+	'
+done
+
 test_done
-- 
gitgitgadget

