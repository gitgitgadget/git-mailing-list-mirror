Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0627C64981
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 20:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjAFUhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbjAFUgy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 15:36:54 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4984DF42
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 12:36:52 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so1894318wms.4
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 12:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIj/lOnTlyUoUEdpwNnBKfyNb5OD/JzFRM7pdqmx+FQ=;
        b=IyKnsr8jmG3io6oNF9D4vbSEg3U7BV+nUxrNYZDkfCq0Y3W7a3GEC1/U4L+Ro7gxea
         TROLS3jWcOcK7xnn4QI2dIudsxN463vpHbkLfl+bWfjOzgldJb32DsfX+HT1HD8wKtYu
         S6KTVheK4fnEvnsXkhTwVkoX6S6ZBjmK878NakltQCDOM+f7RWXQUP0+0Kt1LWr/2vfS
         PpHZiWbF2VELZQqNw07litgRe4Y8qxcNGs6y173YpYilkWUQ4y1fryhEhNeXrPm9VnMp
         5T49L81Q0UxJ+/QtQxuHValAv5fS2QyuZ25IGNj/DpXV8jp6jDcd2i8jG2PmaqUe/K87
         zaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIj/lOnTlyUoUEdpwNnBKfyNb5OD/JzFRM7pdqmx+FQ=;
        b=WGRVpSKcDJr+Tu+DsPjAN5/eLNvldRVtolCQZVTb0RG8l05RtLwTaWoOqb/Jhw4ie1
         6CpcPbRf8Iz7uW55+PxXJpCwttlIuRgdS4VzshrHgfO0RCfBGdykvC+RIotuatgMF6gv
         vhaGPQ81wiAcG9ZrZjjvTxF5RnCyi7n/m45Nz4wUCRr64oYCp/bg5/d2kM+t+UeGV6hP
         716BLPYVMM3FTXbCLv6QS/7k6d4Z3qRRx7CeIqDVR9L0UakKPeJGFDNAGEY9NeK8eRw+
         xztUz7U2ibIg0XRoKkpCl73L3hKOiLR2XZ0OpST303DXX/eE99YokmlZsyO3kLaxEGRN
         TYcg==
X-Gm-Message-State: AFqh2koua9HoRR6nWqxDajcY1bKCcKsZE0jMaArwzGOwNGkFbYmd3oTi
        f0BlCbPxL2+jKe36AdFUd7L/8kWjp0Y=
X-Google-Smtp-Source: AMrXdXs47ncFN8DJPO0igVDl7YbVixVYamZSHkp7aLbS4cKvzmo7vMP9hqglXm3HrFQb8ZXZZxDfTQ==
X-Received: by 2002:a05:600c:4c21:b0:3cf:f18b:327e with SMTP id d33-20020a05600c4c2100b003cff18b327emr41161365wmp.4.1673037411080;
        Fri, 06 Jan 2023 12:36:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c301300b003d6b71c0c92sm7712336wmh.45.2023.01.06.12.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:36:50 -0800 (PST)
Message-Id: <d9c6f50e4f218267c1e8da060ce5b190dc8a709c.1673037405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Jan 2023 20:36:42 +0000
Subject: [PATCH 5/8] clone: set fetch.bundleURI if appropriate
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Bundle providers may organize their bundle lists in a way that is
intended to improve incremental fetches, not just initial clones.
However, they do need to state that they have organized with that in
mind, or else the client will not expect to save time by downloading
bundles after the initial clone. This is done by specifying a
bundle.heuristic value.

There are two types of bundle lists: those at a static URI and those
that are advertised from a Git remote over protocol v2.

The new fetch.bundleURI config value applies for static bundle URIs that
are not advertised over protocol v2. If the user specifies a static URI
via 'git clone --bundle-uri', then Git can set this config as a reminder
for future 'git fetch' operations to check the bundle list before
connecting to the remote(s).

For lists provided over protocol v2, we will want to take a different
approach and create a property of the remote itself by creating a
remote.<id>.* type config key. That is not implemented in this change.

Later changes will update 'git fetch' to consume this option.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/fetch.txt |  8 ++++++++
 builtin/clone.c                |  6 +++++-
 bundle-uri.c                   | 10 +++++++---
 bundle-uri.h                   |  8 +++++++-
 t/t5558-clone-bundle-uri.sh    | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index cd65d236b43..4f796218aab 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -96,3 +96,11 @@ fetch.writeCommitGraph::
 	merge and the write may take longer. Having an updated commit-graph
 	file helps performance of many Git commands, including `git merge-base`,
 	`git push -f`, and `git log --graph`. Defaults to false.
+
+fetch.bundleURI::
+	This value stores a URI for fetching Git object data from a bundle URI
+	before performing an incremental fetch from the origin Git server. If
+	the value is `<uri>` then running `git fetch <args>` is equivalent to
+	first running `git fetch --bundle-uri=<uri>` immediately before
+	`git fetch <args>`. See details of the `--bundle-uri` option in
+	linkgit:git-fetch[1].
diff --git a/builtin/clone.c b/builtin/clone.c
index 5453ba5277f..5370617664d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1248,12 +1248,16 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	 * data from the --bundle-uri option.
 	 */
 	if (bundle_uri) {
+		int has_heuristic = 0;
+
 		/* At this point, we need the_repository to match the cloned repo. */
 		if (repo_init(the_repository, git_dir, work_tree))
 			warning(_("failed to initialize the repo, skipping bundle URI"));
-		else if (fetch_bundle_uri(the_repository, bundle_uri))
+		else if (fetch_bundle_uri(the_repository, bundle_uri, &has_heuristic))
 			warning(_("failed to fetch objects from bundle URI '%s'"),
 				bundle_uri);
+		else if (has_heuristic)
+			git_config_set_gently("fetch.bundleuri", bundle_uri);
 	}
 
 	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
diff --git a/bundle-uri.c b/bundle-uri.c
index b30c85ba6f2..1dbbbb980eb 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -594,9 +594,10 @@ static int fetch_bundle_list_in_config_format(struct repository *r,
 	 * it advertises are expected to be bundles, not nested lists.
 	 * We can drop 'global_list' and 'depth'.
 	 */
-	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN)
+	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN) {
 		result = fetch_bundles_by_token(r, &list_from_bundle);
-	else if ((result = download_bundle_list(r, &list_from_bundle,
+		global_list->heuristic = BUNDLE_HEURISTIC_CREATIONTOKEN;
+	} else if ((result = download_bundle_list(r, &list_from_bundle,
 					   global_list, depth)))
 		goto cleanup;
 
@@ -707,7 +708,8 @@ static int unlink_bundle(struct remote_bundle_info *info, void *data)
 	return 0;
 }
 
-int fetch_bundle_uri(struct repository *r, const char *uri)
+int fetch_bundle_uri(struct repository *r, const char *uri,
+		     int *has_heuristic)
 {
 	int result;
 	struct bundle_list list;
@@ -727,6 +729,8 @@ int fetch_bundle_uri(struct repository *r, const char *uri)
 	result = unbundle_all_bundles(r, &list);
 
 cleanup:
+	if (has_heuristic)
+		*has_heuristic = (list.heuristic != BUNDLE_HEURISTIC_NONE);
 	for_all_bundles_in_list(&list, unlink_bundle, NULL);
 	clear_bundle_list(&list);
 	clear_remote_bundle_info(&bundle, NULL);
diff --git a/bundle-uri.h b/bundle-uri.h
index 1cae418211b..52b27cd10e3 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -124,8 +124,14 @@ int bundle_uri_parse_config_format(const char *uri,
  * based on that information.
  *
  * Returns non-zero if no bundle information is found at the given 'uri'.
+ *
+ * If the pointer 'has_heuristic' is non-NULL, then the value it points to
+ * will be set to be non-zero if and only if the fetched list has a
+ * heuristic value. Such a value indicates that the list was designed for
+ * incremental fetches.
  */
-int fetch_bundle_uri(struct repository *r, const char *uri);
+int fetch_bundle_uri(struct repository *r, const char *uri,
+		     int *has_heuristic);
 
 /**
  * Given a bundle list that was already advertised (likely by the
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index d7461ec907e..8ff560425ee 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -435,6 +435,39 @@ test_expect_success 'clone bundle list (http, creationToken)' '
 	test_bundle_downloaded bundle-2.bundle trace-clone.txt
 '
 
+test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
+	test_when_finished rm -rf fetch-http-4 trace*.txt &&
+
+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = bundle-1.bundle
+		creationToken = 1
+	EOF
+
+	GIT_TRACE2_EVENT="$(pwd)/trace-clone.txt" \
+	git clone --single-branch --branch=base \
+		--bundle-uri="$HTTPD_URL/bundle-list" \
+		"$HTTPD_URL/smart/fetch.git" fetch-http-4 &&
+
+	test_cmp_config -C fetch-http-4 "$HTTPD_URL/bundle-list" fetch.bundleuri &&
+
+	# The clone should copy two files: the list and bundle-1.
+	test_bundle_downloaded bundle-list trace-clone.txt &&
+	test_bundle_downloaded bundle-1.bundle trace-clone.txt &&
+
+	# only received base ref from bundle-1
+	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	EOF
+	test_cmp expect refs
+'
+
 # Do not add tests here unless they use the HTTP server, as they will
 # not run unless the HTTP dependencies exist.
 
-- 
gitgitgadget

