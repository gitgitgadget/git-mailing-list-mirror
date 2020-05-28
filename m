Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DD9C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 02:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E843A207E8
	for <git@archiver.kernel.org>; Thu, 28 May 2020 02:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gTT+lwAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgE1C5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 22:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1C5E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 22:57:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AE7C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 19:57:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f130so10124933yba.9
        for <git@vger.kernel.org>; Wed, 27 May 2020 19:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=S9oDeDbX2YID3XcZrNUI6NP9XJgUnCDE4vT3rka2EoU=;
        b=gTT+lwAa7g28yWJLGKTrpSPZiwJwwCSl0Xx7FeSB/IBg4rq3GQCV734NTNV9Kshp0A
         NpeApR/ZhVrIjvc0X5i2D0+EK6AKsZeieuKfjNcmOX8x6lkd+QxfOypMmZRSDHjfQNtX
         mkH6WZZuFt+jTh/v09xWBZgL6sqneMHXd0IBtDtaZTCR7nvpiMFPBGE8QkuDNJdVMtRu
         zzuNj3cO4C8O5K93H46At8p5t9pGUYa8xPG8Y6wgstzygZyFryEhIwuSlBloZ5naH99A
         J8CqtmOUJE/69IAAVZO6j7HkM2pwMZbnLChnT5BDq5BGgtqcOBS/2py+wyBgvFmvy14a
         51ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=S9oDeDbX2YID3XcZrNUI6NP9XJgUnCDE4vT3rka2EoU=;
        b=V/WNlRjc9ROX0iouJb2SjywoclUzQsuMTOdWrWZEtEqNhD3VSwbrVE0ZacvBdnZQMq
         D6P+5kBJxs36dmI69d3lUfqtp4/L3WMpXbYa15EZct8shblkACUkao9Anw+sR0AOfaFC
         3/3dqD00iP5ETgzdIONmnNokguInLUZUNjlrGXsU1dVc9/FKhogiVKPNptzBCgiJ+ex+
         AKRirM6n1QUd0FEl6oIh5cnP/pjl5Kq7wQVIt8S/mmc8PrWVO5i2XWG0ZeGCp1sC+drC
         MWLD7gO1RZ2/fJKiO+MtEko4oCZ01tM8jFje4FZkgwVH3XrGovqSADhzzuIfM2THsHJQ
         5nMQ==
X-Gm-Message-State: AOAM533uuaZTK5UHV3j1ihNIHHQxasQGrJRhzuXqDcwAlVZmVZN6JhUf
        Kvq//JZRb58p0Ye8Qz4t0rNqSHQwgfZ8p01pNADy03DtM0aDFehM2eUPlIsTFIIyigddiZ7aScl
        C7OZZDj69tNAw4WKaK+xz0hclJ6LIBI25XEXK+o367LtWB9UYRXHBl9NdpCiq
X-Google-Smtp-Source: ABdhPJwO0CUAvFopFS47V4JYhk+chAnOtZGoUOQfI1OyrxjIO1T1js+Y1VdA8T7VDRyTZprHISmB/2kL1w/8
X-Received: by 2002:a05:6902:508:: with SMTP id x8mr2005359ybs.206.1590634622642;
 Wed, 27 May 2020 19:57:02 -0700 (PDT)
Date:   Wed, 27 May 2020 19:54:00 -0700
In-Reply-To: <20200513234435.GG6605@camp.crustytoothpaste.net>
Message-Id: <20200528025359.20931-2-delphij@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 1/1] fetch: allow adding a filter after initial clone.
From:   Xin Li <delphij@google.com>
To:     git@vger.kernel.org
Cc:     Xin Li <delphij@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Retroactively adding filter can be useful for existing shallow clones as
they allow users to see earlier change histories without downloading all
git objects in a regular --unshallow fetch.

Previously this is possible by manually amending the repository
configuration to make git think there is an existing promisor. Because
the code already does most of the hard work, it's safer for git to
just perform the configuration change automatically instead.

Instead of bailing out immediately when no promisor is available, make
the code check more specific issue (extension became special in
repository version 1, while it can have any value in version 0, so
upgrade should not happen if the repository have an unsupported
configuration that would render it invalid if we upgraded).

Signed-off-by: Xin Li <delphij@google.com>
---
 builtin/fetch.c               |  3 ---
 list-objects-filter-options.c |  3 ++-
 repository.h                  |  6 ++++++
 setup.c                       | 30 ++++++++++++++++++++++++++++++
 t/t0410-partial-clone.sh      | 21 +++++++++++++++++++++
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
index 256bcfbdfe..6d62b60eac 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -326,7 +326,8 @@ void partial_clone_register(
 
 	/* Check if it is already registered */
 	if (!promisor_remote_find(remote)) {
-		git_config_set("core.repositoryformatversion", "1");
+		if (upgrade_repository_format(the_repository, 1) < 0)
+			die(_("Unable to upgrade repository format to support partial clone"));
 
 		/* Add promisor config for the remote */
 		cfg_name = xstrfmt("remote.%s.promisor", remote);
diff --git a/repository.h b/repository.h
index 6534fbb7b3..f301f6f456 100644
--- a/repository.h
+++ b/repository.h
@@ -196,4 +196,10 @@ void repo_update_index_if_able(struct repository *, struct lock_file *);
 
 void prepare_repo_settings(struct repository *r);
 
+/*
+ * Return 1 if upgrade repository format to target_version succeeded,
+ * 0 if no upgrade is necessary.
+ */
+int upgrade_repository_format(struct repository *r, int target_version);
+
 #endif /* REPOSITORY_H */
diff --git a/setup.c b/setup.c
index 65fe5ecefb..84da976e07 100644
--- a/setup.c
+++ b/setup.c
@@ -538,6 +538,36 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	return 0;
 }
 
+int upgrade_repository_format(struct repository *r, int target_version)
+{
+	const char *gitdir = get_git_dir();
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct strbuf repo_version = STRBUF_INIT;
+	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+
+	strbuf_git_common_path(&sb, r, "/config");
+	read_repository_format(&repo_fmt, sb.buf);
+	strbuf_release(&sb);
+
+	if (repo_fmt.version >= target_version)
+		return 0;
+
+	repo_fmt.version = target_version;
+
+	if (verify_repository_format(&repo_fmt, &err) < 0) {
+		warning("Unable to upgrade repository format to %d: %s",
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
index a3988bd4b8..71270d3a53 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -30,6 +30,27 @@ test_expect_success 'extensions.partialclone without filter' '
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

