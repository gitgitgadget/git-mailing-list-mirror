Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F964C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 13:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjAaN3n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjAaN33 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 08:29:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E82D4DBFE
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so13739311wrg.13
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCQCgTP5dGvVcPHMeLYc7PxeJqBE0GAhPPkU5Yq/epU=;
        b=LEymr8/RnVBhRlpE5WAF6ZF4amscJadk/p6Aofh5NQYauLxefWdOBvI6de6h40Mtte
         1siGcmiIqyDo8yJJSDKPrpX9SXDwMQ6sQfsNgN+yBDGAPpo4HuSfqvzobVPW37EXyWYC
         aWQZ34iwn4p4fm06upJHcV9vXlXnibztvi6gJFGcJRDCZCXPNmtXvVjDCAeutoLYcQF2
         v3hzPG1OsLCHVjVFDdOuEDNBi/oQx+Ze4wB81W3FB/Ym5x1bLHPu2bjYwzqyqEBYgrXe
         qC0K3XYTngApW1JImtllAq8JK3g7+OxkJhu8p2DDONGJ6+XOYzYEH/bDqethAM6vWIyT
         BllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCQCgTP5dGvVcPHMeLYc7PxeJqBE0GAhPPkU5Yq/epU=;
        b=JC3iuh/yrRwX3imgPk2jydYQZBx8W39mVoj4eRleEG+OSfPEPIY0P3Jv5xPO2pn05z
         jmh81T+as+T/7kkG9hZ6lt9nGpndQ51Jt8u9YBVMfqqc0QgR8brc4ujEQHtsn5j1aLi6
         vDpxckSI7j9tIWGhQsh4bzqmFDLjbWibcUzsiqUY2spuGYXQkFl7vECN4s8F0klo4KZA
         Sy13s2Brkj7Cv2csZaat8p52FKdZEbShHmC/WrSy6oU3hPzxp8j7djDpnqljGA+MuXKv
         REL4qniohvzI0YX9y4K/wjd9F6iJEdhzMxXGkAIWt4Gj1VfC9+ofdkj78JXhvthBj4Zf
         RCOQ==
X-Gm-Message-State: AO0yUKWZaQYSpmWFJ+IkpvKu+YsFQbse3t7Ox6gWrIy6Xr1UdFsuk9f2
        n5hjLilcfJhpZMdCKuFtrSQebR8sVKA=
X-Google-Smtp-Source: AK7set//Y/fGbNeSHk6E79YFH15wajcj3ikUTKLGPb5cKIR1fzM1A1ywERLvLAcBNf9X5h/RHPQTRg==
X-Received: by 2002:adf:f38e:0:b0:2bd:c83a:6e3 with SMTP id m14-20020adff38e000000b002bdc83a06e3mr2881012wro.7.1675171767656;
        Tue, 31 Jan 2023 05:29:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4-20020adffb84000000b002bc7f64efa3sm14505281wrr.29.2023.01.31.05.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:29:27 -0800 (PST)
Message-Id: <b59c4e2d39032628e029eb830f82963787eca176.1675171760.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 13:29:15 +0000
Subject: [PATCH v3 07/11] clone: set fetch.bundleURI if appropriate
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
 Documentation/config/fetch.txt |  8 +++++++
 builtin/clone.c                |  6 +++++-
 bundle-uri.c                   |  5 ++++-
 bundle-uri.h                   |  8 ++++++-
 t/t5558-clone-bundle-uri.sh    | 39 ++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index cd65d236b43..244f44d460f 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -96,3 +96,11 @@ fetch.writeCommitGraph::
 	merge and the write may take longer. Having an updated commit-graph
 	file helps performance of many Git commands, including `git merge-base`,
 	`git push -f`, and `git log --graph`. Defaults to false.
+
+fetch.bundleURI::
+	This value stores a URI for downloading Git object data from a bundle
+	URI before performing an incremental fetch from the origin Git server.
+	This is similar to how the `--bundle-uri` option behaves in
+	linkgit:git-clone[1]. `git clone --bundle-uri` will set the
+	`fetch.bundleURI` value if the supplied bundle URI contains a bundle
+	list that is organized for incremental fetches.
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
index af48938d243..7a1b6d94bf5 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -736,7 +736,8 @@ static int unlink_bundle(struct remote_bundle_info *info, void *data)
 	return 0;
 }
 
-int fetch_bundle_uri(struct repository *r, const char *uri)
+int fetch_bundle_uri(struct repository *r, const char *uri,
+		     int *has_heuristic)
 {
 	int result;
 	struct bundle_list list;
@@ -756,6 +757,8 @@ int fetch_bundle_uri(struct repository *r, const char *uri)
 	result = unbundle_all_bundles(r, &list);
 
 cleanup:
+	if (has_heuristic)
+		*has_heuristic = (list.heuristic != BUNDLE_HEURISTIC_NONE);
 	for_all_bundles_in_list(&list, unlink_bundle, NULL);
 	clear_bundle_list(&list);
 	clear_remote_bundle_info(&bundle, NULL);
diff --git a/bundle-uri.h b/bundle-uri.h
index ef32840bfa6..6dbc780f661 100644
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
index 6f9417a0afb..b2d15e141ca 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -432,6 +432,8 @@ test_expect_success 'clone incomplete bundle list (http, creationToken)' '
 		--single-branch --branch=base --no-tags \
 		"$HTTPD_URL/smart/fetch.git" clone-token-http &&
 
+	test_cmp_config -C clone-token-http "$HTTPD_URL/bundle-list" fetch.bundleuri &&
+
 	cat >expect <<-EOF &&
 	$HTTPD_URL/bundle-list
 	$HTTPD_URL/bundle-1.bundle
@@ -441,6 +443,43 @@ test_expect_success 'clone incomplete bundle list (http, creationToken)' '
 	test_cmp expect actual
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
+	cat >expect <<-EOF &&
+	$HTTPD_URL/bundle-list
+	$HTTPD_URL/bundle-1.bundle
+	EOF
+
+	test_remote_https_urls <trace-clone.txt >actual &&
+	test_cmp expect actual &&
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

