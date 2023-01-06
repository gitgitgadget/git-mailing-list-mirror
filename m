Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A1DC677F1
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 20:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbjAFUhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbjAFUgz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 15:36:55 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAF9DEC2
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 12:36:54 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso4390787wmb.3
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 12:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cq6fUvCCRlZM7IOW6GK8FRCdHs6Q5WUvLgxna34762w=;
        b=aj0PTbj2lR7Jnj8pZK1Bpt51QHPjI8G8kUW6SSzLgQsCU8GlL2dKruJPlbElA43J4/
         BFGyJyc5246kh9iWtoysZT7JvWwSY60ImEA5PTQ9osHZ2g4Z9fIFB6BllpTsEgLFVi8/
         lMbfKlrqASoZs6yOPXm7rmt6dWLejfW1G0F+Q+6/Hc17b2vB6RBwQ2M+IPS4MQih/TFb
         uhGXBlzfiPqN+vqFjKXSM59I8ZvNQhS98AOyMqZJ75pAJ37J/PfwifTVC6cuG+zM/UIT
         4Rx65MSeX/GB66XfUfTRNri+on8CMblxznk0jjy1eHsvUpbCtoCVkpQ1pz63nBJOdE75
         de4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cq6fUvCCRlZM7IOW6GK8FRCdHs6Q5WUvLgxna34762w=;
        b=4i6QNJdp94BcF9SpEiNNH4kvT+u07mdSLoj/5xXG6oknOhC/GZueRSHA69SNYRReaM
         bw92vSJIcd3oKr58f7hTZGYreU92K1ZRBKCRDQhtwpkHHleqj9hYLaAi11SLyFKe1lFj
         E1Ef/vXeRNZyhQiAqqmnLwNJJD6LP4ZTnFawrHLSaoJlA6bVQu/1DwHxRiE3xhyS1hyv
         /PijnwjYdeVoBldwa/NFgUl8B/oY2gQSCAAOI+y2Vzum68oth923/pSGUkQOV65DVCh8
         CUAZ8M1OcNCorTshMvO1gqxl5bdlOkaLE999O00jrjN3l0pn5C6wMggCosAbT8A6IycB
         UP5Q==
X-Gm-Message-State: AFqh2kroKmZr2YOZF+FvWLwAB1lLeNbw2JwK47W3+Ttb/V5hMm5leKJD
        1AG33/qkkOjsciHLdR8lte7zG2ECJ+A=
X-Google-Smtp-Source: AMrXdXtB/XhfDKdGXFyH6RvvI4LkepjEJR0BZoehBHh8Y1iZEDMblDhO60C4zjyRqNRrmS9hLxju9A==
X-Received: by 2002:a05:600c:250:b0:3d2:2830:b8bb with SMTP id 16-20020a05600c025000b003d22830b8bbmr44089448wmj.34.1673037412690;
        Fri, 06 Jan 2023 12:36:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c1d1000b003d23928b654sm8263811wms.11.2023.01.06.12.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:36:52 -0800 (PST)
Message-Id: <1627fc158b1e301a1663e24f9f21268b4f1caa55.1673037405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Jan 2023 20:36:44 +0000
Subject: [PATCH 7/8] fetch: fetch from an external bundle URI
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

When a user specifies a URI via 'git clone --bundle-uri', that URI may
be a bundle list that advertises a 'bundle.heuristic' value. In that
case, the Git client stores a 'fetch.bundleURI' config value storing
that URI.

Teach 'git fetch' to check for this config value and download bundles
from that URI before fetching from the Git remote(s). Likely, the bundle
provider has configured a heuristic (such as "creationToken") that will
allow the Git client to download only a portion of the bundles before
continuing the fetch.

Since this URI is completely independent of the remote server, we want
to be sure that we connect to the bundle URI before creating a
connection to the Git remote. We do not want to hold a stateful
connection for too long if we can avoid it.

To test that this works correctly, extend the previous tests that set
'fetch.bundleURI' to do follow-up fetches. The bundle list is updated
incrementally at each phase to demonstrate that the heuristic avoids
downloading older bundles. This includes the middle fetch downloading
the objects in bundle-3.bundle from the Git remote, and therefore not
needing that bundle in the third fetch.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/fetch.c             |  8 +++++
 t/t5558-clone-bundle-uri.sh | 59 +++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7378cafeec9..fbb1d470c38 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -29,6 +29,7 @@
 #include "commit-graph.h"
 #include "shallow.h"
 #include "worktree.h"
+#include "bundle-uri.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
@@ -2109,6 +2110,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	int i;
+	const char *bundle_uri;
 	struct string_list list = STRING_LIST_INIT_DUP;
 	struct remote *remote = NULL;
 	int result = 0;
@@ -2194,6 +2196,12 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (dry_run)
 		write_fetch_head = 0;
 
+	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri) &&
+	    !starts_with(bundle_uri, "remote:")) {
+		if (fetch_bundle_uri(the_repository, bundle_uri, NULL))
+			warning(_("failed to fetch bundles from '%s'"), bundle_uri);
+	}
+
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 8ff560425ee..3f4d61a915c 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -465,6 +465,65 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 	cat >expect <<-\EOF &&
 	refs/bundles/base
 	EOF
+	test_cmp expect refs &&
+
+	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle "bundle-2"]
+		uri = bundle-2.bundle
+		creationToken = 2
+	EOF
+
+	# Fetch the objects for bundle-2 _and_ bundle-3.
+	GIT_TRACE2_EVENT="$(pwd)/trace1.txt" \
+		git -C fetch-http-4 fetch origin --no-tags \
+		refs/heads/left:refs/heads/left \
+		refs/heads/right:refs/heads/right &&
+
+	# This fetch should copy two files: the list and bundle-2.
+	test_bundle_downloaded bundle-list trace1.txt &&
+	test_bundle_downloaded bundle-2.bundle trace1.txt &&
+	! test_bundle_downloaded bundle-1.bundle trace1.txt &&
+
+	# received left from bundle-2
+	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect refs &&
+
+	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle "bundle-3"]
+		uri = bundle-3.bundle
+		creationToken = 3
+
+	[bundle "bundle-4"]
+		uri = bundle-4.bundle
+		creationToken = 4
+	EOF
+
+	# This fetch should skip bundle-3.bundle, since its objets are
+	# already local (we have the requisite commits for bundle-4.bundle).
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		git -C fetch-http-4 fetch origin --no-tags \
+		refs/heads/merge:refs/heads/merge &&
+
+	# This fetch should copy three files: the list, bundle-3, and bundle-4.
+	test_bundle_downloaded bundle-list trace2.txt &&
+	test_bundle_downloaded bundle-4.bundle trace2.txt &&
+	! test_bundle_downloaded bundle-1.bundle trace2.txt &&
+	! test_bundle_downloaded bundle-2.bundle trace2.txt &&
+	! test_bundle_downloaded bundle-3.bundle trace2.txt &&
+
+	# received merge ref from bundle-4, but right is missing
+	# because we did not download bundle-3.
+	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	refs/bundles/merge
+	EOF
 	test_cmp expect refs
 '
 
-- 
gitgitgadget

