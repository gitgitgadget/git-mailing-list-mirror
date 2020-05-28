Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1693C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 04:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5D9207E8
	for <git@archiver.kernel.org>; Thu, 28 May 2020 04:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eu3wlDYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgE1EIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 00:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgE1EIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 00:08:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5791C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 21:08:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x10so26974282ybx.8
        for <git@vger.kernel.org>; Wed, 27 May 2020 21:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1yEfr+kRwAd8/bvjABJItewfp7swJ0sgNfl/whzN47E=;
        b=Eu3wlDYk40B3j1/Ph233GiARgBAGER0I4cSFMcuBMpTDM9ExD2429GEyn/xYkcWXU9
         3myDEit/y0htmoUwSBMLdrbx1w5Zdu5X7DV5Xw0vnathXb1RH/yyuCT6yqYz3mwPnlEP
         d3AQItRBhwRJesN8xI48Jb3YuycIRpKx8c+EnjY2UNGCR+A7HqUAIsbXoonBDqBOIhhZ
         wiVhjOnB9+lXifxl3jy86HDtaKPQw0xdOM81J7c58JbhQVgkB2OKphshuPByYxiLnlmC
         3PMBJ7j1Z1qja+B7FJJJlwLtqt+vzmjCXRkl4NcH/Po1C+bhtlndF383Om9LoGfuYLCO
         1ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1yEfr+kRwAd8/bvjABJItewfp7swJ0sgNfl/whzN47E=;
        b=VXm9Ur4bEVtvTFs9kUdiIOTXTjxRUuglluDapHz8IazqN1zFwDob9XnQVhhDJjnQAE
         OckJSS3b1qjqbGMTv7eB4KmC7pwTomBxOW40pdCaHyFACGHXgxmPA6/lEB0vpjq3B2AU
         ucaYociy7zfKmpleCLUxRfyJpdq1sdnGhei0+lQFRxyfWxDnX6AWsHnxI1sbvz/OTZbe
         mPOSa3Z1B5c9X+GSSzC6EzEC8bj5BjCwMN2cxEiCargaoBBpkKwFa6ME/dBryW/dMIiU
         seNtQ5cV/knGcwJ0TsPhGgqXMRZosrRyjg7VIhvfjSxBR3Yeil/DeO0eDTwY3fUPOcc9
         IknA==
X-Gm-Message-State: AOAM530kPMG/ORv7cCUh0GCPA0RCt4U6wu29ZTBCjTyBoBkPVUZww9fD
        eikLpre1BsHVjwrAPYz/JIUtjehVYn2XPxvGFAJcetarufHbjRxYvxW7nz4tRQVkSQszEWK1Qq3
        HFYWBth7xr9egqKdc/5o0gdib312sevYMlbze6Toz5igL8qf7RXOAzCaMnGRA
X-Google-Smtp-Source: ABdhPJxCBx2npQwswCGxfxXc9OHMUqcH6BSxzPxQKMxCRV5KFD+wrQtxApR+0ynBV7t0noXdXOuNbMkJlMqT
X-Received: by 2002:a25:40c:: with SMTP id 12mr1442996ybe.377.1590638902851;
 Wed, 27 May 2020 21:08:22 -0700 (PDT)
Date:   Wed, 27 May 2020 21:08:12 -0700
In-Reply-To: <20200528032837.GE56118@google.com>
Message-Id: <20200528040812.131224-1-delphij@google.com>
Mime-Version: 1.0
References: <20200513234435.GG6605@camp.crustytoothpaste.net> <20200528025359.20931-2-delphij@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v3] fetch: allow adding a filter after initial clone.
From:   Xin Li <delphij@google.com>
To:     git@vger.kernel.org
Cc:     Xin Li <delphij@google.com>, jrn@google.com, iankaz@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Retroactively adding filter can be useful for existing shallow clones as
they allow users to see earlier change histories without downloading all
git objects in a regular --unshallow fetch.

Without this patch, users can make a clone partial by editing the
repository configuration to convert the remote into a promisor, like:

  git config core.repositoryFormatVersion 1
  git config extensions.partialClone origin
  git fetch --unshallow --filter=blob:none origin

Since the hard part of making this work is already in place and such
edits can be error-prone, teach Git to perform the required configuration
change automatically instead.

Instead of bailing out immediately when no promisor is available, make
the code perform a more precise check for any potential problems
(extensions became special in repository version 1, while it can have
any value in version 0, so upgrade should not happen if the repository
have an unsupported configuration that would render it invalid if we
upgraded).

Signed-off-by: Xin Li <delphij@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/fetch.c               |  3 ---
 list-objects-filter-options.c |  3 ++-
 repository.h                  |  6 ++++++
 setup.c                       | 29 +++++++++++++++++++++++++++++
 t/t0410-partial-clone.sh      | 22 ++++++++++++++++++++++
 5 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b5788c16bf..3347d578ea 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1790,9 +1790,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
-	if (filter_options.choice && !has_promisor_remote())
-		die("--filter can only be used when extensions.partialClone is set");
-
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 256bcfbdfe..3553ad7b0a 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -326,7 +326,8 @@ void partial_clone_register(
 
 	/* Check if it is already registered */
 	if (!promisor_remote_find(remote)) {
-		git_config_set("core.repositoryformatversion", "1");
+		if (upgrade_repository_format(1) < 0)
+			die(_("unable to upgrade repository format to support partial clone"));
 
 		/* Add promisor config for the remote */
 		cfg_name = xstrfmt("remote.%s.promisor", remote);
diff --git a/repository.h b/repository.h
index 6534fbb7b3..40cc12c7cf 100644
--- a/repository.h
+++ b/repository.h
@@ -196,4 +196,10 @@ void repo_update_index_if_able(struct repository *, struct lock_file *);
 
 void prepare_repo_settings(struct repository *r);
 
+/*
+ * Return 1 if upgrade repository format to target_version succeeded,
+ * 0 if no upgrade is necessary; returns -1 when upgrade is not possible.
+ */
+int upgrade_repository_format(int target_version);
+
 #endif /* REPOSITORY_H */
diff --git a/setup.c b/setup.c
index 65fe5ecefb..123d3d3433 100644
--- a/setup.c
+++ b/setup.c
@@ -538,6 +538,35 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	return 0;
 }
 
+int upgrade_repository_format(int target_version)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct strbuf repo_version = STRBUF_INIT;
+	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+
+	strbuf_git_common_path(&sb, the_repository, "config");
+	read_repository_format(&repo_fmt, sb.buf);
+	strbuf_release(&sb);
+
+	if (repo_fmt.version >= target_version)
+		return 0;
+
+	repo_fmt.version = target_version;
+
+	if (verify_repository_format(&repo_fmt, &err) < 0) {
+		warning("unable to upgrade repository format to %d: %s",
+		    target_version, err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+
+	strbuf_addf(&repo_version, "%d", target_version);
+	git_config_set("core.repositoryformatversion", repo_version.buf);
+	strbuf_release(&repo_version);
+	return 1;
+}
+
 static void init_repository_format(struct repository_format *format)
 {
 	const struct repository_format fresh = REPOSITORY_FORMAT_INIT;
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index a3988bd4b8..d580488330 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -30,6 +30,28 @@ test_expect_success 'extensions.partialclone without filter' '
 	git -C client fetch origin
 '
 
+test_expect_success 'convert shallow clone to partial clone' '
+	rm -fr server client &&
+	test_create_repo server &&
+	test_commit -C server my_commit 1 &&
+	test_commit -C server my_commit2 1 &&
+	git clone --depth=1 "file://$(pwd)/server" client &&
+	git -C client fetch --unshallow --filter="blob:none" &&
+	test_cmp_config -C client true remote.origin.promisor &&
+	test_cmp_config -C client blob:none remote.origin.partialclonefilter &&
+	test_cmp_config -C client 1 core.repositoryformatversion
+'
+
+test_expect_success 'convert shallow clone to partial clone must fail with invalid extension' '
+	rm -fr server client &&
+	test_create_repo server &&
+	test_commit -C server my_commit 1 &&
+	test_commit -C server my_commit2 1 &&
+	git clone --depth=1 "file://$(pwd)/server" client &&
+	git -C client config extensions.sandwidth true &&
+	test_must_fail git -C client fetch --unshallow --filter="blob:none"
+'
+
 test_expect_success 'missing reflog object, but promised by a commit, passes fsck' '
 	rm -rf repo &&
 	test_create_repo repo &&
-- 
2.27.0.rc0.183.gde8f92d652-goog

