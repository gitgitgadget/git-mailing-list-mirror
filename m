Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF62BC43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 19:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiFFTzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 15:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiFFTzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 15:55:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0586D96D
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 12:55:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x17so21233785wrg.6
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DvUWcVg6QiFElQLPBSGxt1zjmUCpH8UE/q7c40PX5PA=;
        b=HDHuizG8HSLkRANR6AN9omdb8DLRxYhZgkB63qx/221+kin3sCK2t9tW04CICpihTH
         bfk1In9O+HlvI9S8BG1YGVLRTfEx0PlVpPjn2oDfPpvyt+vYfIWMj6r0Qr6wt7Z4Xf2Z
         3cFl2Tx2cwIsF0tHQuk3vOaVkF5GOiNMqwlCu/QBezqGvUVyBW3YIfB/Kz973nZWmBrz
         LaCl4jFdFR3+Jtbh3N864skembpR1UGlh2hQw5aVop2HTfzMZMjPB1UirG1qtmoWmVTH
         FA1mmxIquGDkOoULkqLiV86Gklr8DUd+rZbVyaCDszBlDX4/jj3WHMppa3azNj3T+WAT
         /69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DvUWcVg6QiFElQLPBSGxt1zjmUCpH8UE/q7c40PX5PA=;
        b=x2FBD1FURSr2TfcxOJ7VDFDDvsUGIZk5PXJXhRrIZEObT5QxBVkTW2tVQh4msmUNWs
         4hLHMNE51c7NdMOkqTAXEaBmWHEDHEQKKd+wv0RxFOK9mDEwSJSmC8pf+kmXddSh2aOo
         1vSGyKgJcMJLa/kML0dr2It9oIx8SkiTWXbnigvmlLVCB+gMqImii5e4A2SkRtSZ/fho
         AettM0V7uM9IXvuJ3tIdWA534C5kVgcYaAagC0esWFKpOfOFN2uYG07iV5WJj7NENlfE
         MayiaH7d4FAIhXsv223vHzUtAkqk7Gz10lRiseuCaCZ3dHJmfzb5OldP7CTMLn7sV47m
         b4qQ==
X-Gm-Message-State: AOAM530tzau+EnITYLnJd4vfVqgEDTVnVY0QapxyfYemJnnZMwsGrIwL
        YOUUD15ffXqIjlHgz3/heQoOp7CeXQwvvCIP
X-Google-Smtp-Source: ABdhPJw/vr6LZDsdfrF8feNIkPKWZs7714sggxCKHmG7MlP/XFgvLDU9/VP6eeZrp9dN3qluhEagLg==
X-Received: by 2002:a5d:6d0f:0:b0:213:1c53:6c85 with SMTP id e15-20020a5d6d0f000000b002131c536c85mr21465334wrq.18.1654545331125;
        Mon, 06 Jun 2022 12:55:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13-20020adfe54d000000b002103cfd2fbasm16990807wrm.65.2022.06.06.12.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:55:30 -0700 (PDT)
Message-Id: <f9e416164e419cee0122b58162d903ccd8b0f808.1654545325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jun 2022 19:55:23 +0000
Subject: [PATCH 4/6] fetch: add --bundle-uri option
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
index 07b4bfe4e11..095779352e7 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -76,11 +76,15 @@ int fetch_bundle_uri(struct repository *r, const char *uri)
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

