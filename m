Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC44C433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 20:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiF2UlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiF2Ukz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 16:40:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3DC1401B
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:40:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so376809wmi.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KjNW3Gm2WhxAqkTS0+RBx9Ks7QbGhw2NsFVbenGWA48=;
        b=EY3zxDC28fIdawRq/sQF82G5WwNPk4Lsw2D9LEoAPT9ylhkMGilSnyhC4kZ11UVVi4
         NtT15VXIIJjLH2l+eb3tI5QENyJizvhepiUWhdNF+sfoNRICUpjkfRpRU9ThZ9HXBk5A
         KODkIAKo4ZWvWsqZxOm7edJWXJPY6SAYbBY/R8AWHJRnoEGOfHaQw7W2/PQepqFxW1Xu
         HYEnBtmKRTfzT0Onv+RdXVubOYQUhVdIAkJRvqOSPzJZMw6x1Hcbl1rxlRIrk8WAbRsx
         h+pIZ7VGUwJfx0+iudVHjA+eC03+PCSn0pV3NGjd3j4iNYz3dgF4SuLv/yTNe7j7UzlO
         QEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KjNW3Gm2WhxAqkTS0+RBx9Ks7QbGhw2NsFVbenGWA48=;
        b=1Iz9btWLbACLzgXgoIvPEp+gS9wCvCQhwaEUvok5hzgcrAVqqn/bdXahPCrWYYUKhN
         PdID2Wms17DfG0YffEtXDt9oqDM5USPWOKtH/Qza/OSDovBc3x6bafOgmgPUuTPGgP5V
         vGtYpmB7ZVUzkC5xSPRHha2PBHgNXSlbQ3kZFFK0uM0R4iQNpHiXYCn9FuFR9Scl/NWL
         No/OHrtIgRKoUAqMhZvphVgww4YXV1WsYtrTD8maepHmMK0ms9sT8AV4vrP6rTPeelk5
         O1INXiVSKLsTOvw3pHvzAWJ4EPA0mNqoCILibMzWwJDbdduyY3EWqOlHGbMboIsmSFuZ
         42mw==
X-Gm-Message-State: AJIora+cIPt6WwtYJXnXwIkYtSeUq+jLvKKMheqllBYSTWrXVaUb9UKk
        vSGbNX2TtvqvFwqUemvGSd8tg6LNoxGYdA==
X-Google-Smtp-Source: AGRyM1tlqwdU9TqxI4o33zHWVtvIrGh0EZjQ9hTMX8ZUCPq/hqEUgglPvU33erqInhHknfbYtMRIOQ==
X-Received: by 2002:a05:600c:3b1c:b0:3a1:729a:387a with SMTP id m28-20020a05600c3b1c00b003a1729a387amr3810258wms.183.1656535252192;
        Wed, 29 Jun 2022 13:40:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c1c1600b003a046549a85sm191809wms.37.2022.06.29.13.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:40:51 -0700 (PDT)
Message-Id: <f6255ec5188572f26d260b890a9398c65d0d5eac.1656535245.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jun 2022 20:40:43 +0000
Subject: [PATCH v2 4/6] fetch: add --bundle-uri option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Teach 'git fetch' a new --bundle-uri=<uri> option which changes the mode
from fetching from a remote using the Git protocol to fetching a bundle
from the given <uri>. See Documentation/technical/bundle-uri.txt for
more information on the design of this feature.

This implementation is limited to the most basic version of the feature.
We expect the content at that URI to be a bundle file, not a bundle
list. Bundle lists will be implemented later.

This implementation is sufficient for a bundle provider to create a
single bootstrap bundle for a large repository. The user would bootstrap
a repository using a sequence of Git commands, such as:

 1. git init <repo> && cd <repo>
 2. git fetch --bundle-uri=<uri>
 3. git remote add origin <url>
 4. git fetch origin
 5. git checkout FETCH_HEAD

Since the unbundle_from_file() in bundle-uri.c stores the bundled refs
into the refs/bundle/* namespace, those references are useful for the
fetch negotiation in step 4, reducing the size of the download in that
step.

Later changes will make this seamless within a 'git clone' command, but
this implementation is large enough to delay that integration.

Currently, this option supports local filenames. Other protocols will be
added in the future.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/fetch-options.txt |  5 +++++
 Documentation/git-fetch.txt     |  1 +
 builtin/fetch.c                 | 10 ++++++++++
 bundle-uri.c                    |  8 ++++++--
 t/t5558-fetch-bundle-uri.sh     | 34 +++++++++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100755 t/t5558-fetch-bundle-uri.sh

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 622bd84768b..09bd1feeed8 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -317,3 +317,8 @@ endif::git-pull[]
 -6::
 --ipv6::
 	Use IPv6 addresses only, ignoring IPv4 addresses.
+
+--bundle-uri=<uri>::
+	Instead of fetching from a remote, fetch a bundle from the given
+	`<uri>` and unbundle the data into the local repository. The refs
+	in the bundle will be stored under the `refs/bundle/*` namespace.
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index e9d364669af..4fd8911b336 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git fetch' [<options>] <group>
 'git fetch' --multiple [<options>] [(<repository> | <group>)...]
 'git fetch' --all [<options>]
+'git fetch' --bundle-uri=<uri> [<options>]
 
 
 DESCRIPTION
diff --git a/builtin/fetch.c b/builtin/fetch.c
index e3791f09ed5..cb0d2fbe82c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -29,6 +29,7 @@
 #include "commit-graph.h"
 #include "shallow.h"
 #include "worktree.h"
+#include "bundle-uri.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
@@ -37,6 +38,7 @@ static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] <group>"),
 	N_("git fetch --multiple [<options>] [(<repository> | <group>)...]"),
 	N_("git fetch --all [<options>]"),
+	N_("git fetch --bundle-uri=<uri> [<options>]"),
 	NULL
 };
 
@@ -86,6 +88,7 @@ static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
 static int fetch_write_commit_graph = -1;
 static int stdin_refspecs = 0;
 static int negotiate_only;
+static const char *bundle_uri;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -224,6 +227,8 @@ static struct option builtin_fetch_options[] = {
 		 N_("write the commit-graph after fetching")),
 	OPT_BOOL(0, "stdin", &stdin_refspecs,
 		 N_("accept refspecs from stdin")),
+	OPT_STRING(0, "bundle-uri", &bundle_uri, N_("uri"),
+		   N_("download bundle data from the given URI instead of from a remote")),
 	OPT_END()
 };
 
@@ -2181,6 +2186,11 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (dry_run)
 		write_fetch_head = 0;
 
+	if (bundle_uri) {
+		result = fetch_bundle_uri(the_repository, bundle_uri);
+		goto cleanup;
+	}
+
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
diff --git a/bundle-uri.c b/bundle-uri.c
index f0abbf434c8..f80a3b14103 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -77,11 +77,15 @@ int fetch_bundle_uri(struct repository *r, const char *uri)
 	struct strbuf filename = STRBUF_INIT;
 
 	find_temp_filename(&filename);
-	if ((result = copy_uri_to_file(uri, filename.buf)))
+	if ((result = copy_uri_to_file(uri, filename.buf))) {
+		error(_("failed to download bundle from URI '%s'"), uri);
 		goto cleanup;
+	}
 
-	if ((result = !is_bundle(filename.buf, 0)))
+	if ((result = !is_bundle(filename.buf, 0))) {
+		error(_("file at URI '%s' is not a bundle"), uri);
 		goto cleanup;
+	}
 
 	if ((result = unbundle_from_file(r, filename.buf)))
 		goto cleanup;
diff --git a/t/t5558-fetch-bundle-uri.sh b/t/t5558-fetch-bundle-uri.sh
new file mode 100755
index 00000000000..381e56cac20
--- /dev/null
+++ b/t/t5558-fetch-bundle-uri.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='test fetching bundles with --bundle-uri'
+
+. ./test-lib.sh
+
+test_expect_success 'fail to fetch from non-existent file' '
+	test_must_fail git fetch --bundle-uri="$(pwd)/does-not-exist" 2>err &&
+	grep "failed to download bundle from URI" err
+'
+
+test_expect_success 'fail to fetch from non-bundle file' '
+	echo bogus >bogus &&
+	test_must_fail git fetch --bundle-uri="$(pwd)/bogus" 2>err &&
+	grep "is not a bundle" err
+'
+
+test_expect_success 'create bundle' '
+	git init fetch-from &&
+	git -C fetch-from checkout -b topic &&
+	test_commit -C fetch-from A &&
+	test_commit -C fetch-from B &&
+	git -C fetch-from bundle create B.bundle topic
+'
+
+test_expect_success 'fetch file bundle' '
+	git init fetch-to &&
+	git -C fetch-to fetch --bundle-uri="$(pwd)/fetch-from/B.bundle" &&
+	git -C fetch-to rev-parse refs/bundles/topic >actual &&
+	git -C fetch-from rev-parse topic >expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget

