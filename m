Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBD7C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjAWPWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjAWPW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:22:28 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863D929404
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:03 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so8831636wms.2
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znl0EhyHD8RVNecs85AAFqvciRWhRkW3gJPZgJlcpL4=;
        b=oiECA9DwcvbzFY0/9LR5uJicxJu356qFQ86dpXVQbcwdF0BAm8BcflYASWIv7X830C
         yrG/ZxypYKAf5NOwxx1jV3wrFgT0BcyecVEeKVAX7NU5BtjqXD2eJZLRMujOF7qyc/zp
         f6WhojPqSq3EXTrIAf6ZLjqejo/nNZiQTbNBY4FNeYVyxghcE//nDAaiXpU+twaAZ8yI
         4P2RkINf9PWbDO1H2KPy1YGjf8kXtmDXsIVmdIPMZtaKGbn/YX+F5LMbBXlipjV+8N6d
         ev0XT8F0NKWFh9YbHd0627iPx0NFQUyW13PAdvhr6WDFyOm5bTi2mOW2fnMDRmFdnEbk
         UzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znl0EhyHD8RVNecs85AAFqvciRWhRkW3gJPZgJlcpL4=;
        b=6c3y7VjP51uX+hJvOZ7VIEYPX+p+FS/5yBLXsHlaQ5HhWURv9uY3eYvL7eZSsib1y2
         ntnOgc0rjgcmgw6PKAGw6g+9h2Dbe3/u/Mg/Qvsre5DYyx3JyVEeQ1SUo9rP2HZkmt5Z
         JMYNjdcup7ohOWLlIPA54Yif0gUbJLRreLU+nQKPS8wZ8lqyWM86om1h5755Wjxn4uKN
         FlEZv73c6r/5uSTP1NLrEC4K/ffVb33bWZ+6JPXF9LYXqgUyGGWQnOd+eVa6OhUkdYcU
         SISM3kUKkUiE6f2iElQkOuMSnFyoZb5+eVHhxieFTlr2DY+Aa03RCQMBh2sZQlEcpVt1
         /Jxg==
X-Gm-Message-State: AFqh2kqTExZTD8T6mz8MsD5WY8oe4cVDWLXTp8VMSPdhMG0vOmlfpEmq
        /85o9meXj8v89MJSr6Si3TxN1WnHniY=
X-Google-Smtp-Source: AMrXdXvbtIKj1480JNyHnWXbsD1F/0l9xtf7hDzsiLX5FXdDg2t/Pjd6IsNYzdc+BTrr6y0ZlzIMmg==
X-Received: by 2002:a1c:7415:0:b0:3da:fd07:1e3 with SMTP id p21-20020a1c7415000000b003dafd0701e3mr23138857wmc.22.1674487317578;
        Mon, 23 Jan 2023 07:21:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg24-20020a05600c3c9800b003d9ed40a512sm15136081wmb.45.2023.01.23.07.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:21:57 -0800 (PST)
Message-Id: <17c404c1b836d7c160defe97e1667c631d292fb0.1674487310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 15:21:46 +0000
Subject: [PATCH v2 06/10] clone: set fetch.bundleURI if appropriate
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
index 39acd856fb9..162a9276f31 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -742,7 +742,8 @@ static int unlink_bundle(struct remote_bundle_info *info, void *data)
 	return 0;
 }
 
-int fetch_bundle_uri(struct repository *r, const char *uri)
+int fetch_bundle_uri(struct repository *r, const char *uri,
+		     int *has_heuristic)
 {
 	int result;
 	struct bundle_list list;
@@ -762,6 +763,8 @@ int fetch_bundle_uri(struct repository *r, const char *uri)
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

