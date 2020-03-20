Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B838C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 12:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2360320777
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 12:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8/FRyHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgCTMiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:38:16 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45694 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgCTMiP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 08:38:15 -0400
Received: by mail-ed1-f52.google.com with SMTP id u59so6884212edc.12
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 05:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BegkCao7aXxyIqvZOnBRAvg0DlWcFw0p5P8u8suUCQE=;
        b=p8/FRyHPTIlHR45W8+bXw3pOizJxNjmeizkJET/TQmRMPMVUsOl9rI27caa5LZdF7S
         50Y3xAn/hapKZPsd2zDv6BxOgFLTdbmj5/SxTCcpTl3JmQre7lFNj/zXpfflxgoXSOdU
         5IaFE/g4frbHbV8xy1lu+9q/Hgt4XiVVF+UJP1jaPSNwS2UXleg9b4+/1Ld2pOD04TYf
         nWgx3e9V661MH4OUE17pWSYAXxv10TU1K97B1vbzBsuhdCfKjYgzd6dBGCidMOyQJpcs
         npKqGg99Y9q4dKKlQzm5AKjSHnx91Ful2pnG0YmwjjYHbJzHgz+5IZcAkvc+LdTYO+24
         juxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BegkCao7aXxyIqvZOnBRAvg0DlWcFw0p5P8u8suUCQE=;
        b=jQGUo/cXsB8eP/5sWWDTqBn8uzrlOxBTl/1YBn69ehgqvBhDcXUfK0C5vlOql1tU0X
         A6uZNHjRV/YLTb457VH4dYQQZEUrVeopXJ5ODlp+uDAKNEVlYyj0xPsAHgMsSsngTN8Z
         3wLbNCJSAA2offqL48JTgbUedQOnHL7tx9qR6gBb6lrJvarMpczErH9bEszefns33Wia
         ktWN+b6urhtSwmnOHBcBnMwjTsNijaiwMidKvNRwD6HI5U4bdXpM9JTPThH3IrJGrp/K
         zflEW7abHpfdGtBJxhtIjb8ZN6/ogL/u7N9B33cGrE6shmmdi1XpeCjc+4xYqEvdfnu1
         BdMQ==
X-Gm-Message-State: ANhLgQ0LI+ff5u6810UpCs77CRXiYVfOaVsPB4BAHo13SrUW2fUusiku
        tsu5/o+bwKjjLJa/WZ9Tta++lg4W
X-Google-Smtp-Source: ADFU+vuhhUFbWgpR3212hzjeQvsfq9yTe/cKWvgOgPcDVkfY03cXgVEgezKXhQHaZk3C59LRpes2QA==
X-Received: by 2002:aa7:d64a:: with SMTP id v10mr7755475edr.324.1584707892807;
        Fri, 20 Mar 2020 05:38:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o33sm160013eda.30.2020.03.20.05.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:38:12 -0700 (PDT)
Message-Id: <60b5cc6f337011a7f2d5a229a83df7b82638d421.1584707890.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.585.v3.git.1584707890.gitgitgadget@gmail.com>
References: <pull.585.v2.git.1584707247753.gitgitgadget@gmail.com>
        <pull.585.v3.git.1584707890.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Mar 2020 12:38:09 +0000
Subject: [PATCH v3 1/2] config: set pack.useSparse=true by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The pack.useSparse config option was introduced by 3d036eb0
(pack-objects: create pack.useSparse setting, 2019-01-19) and was
first available in v2.21.0. When enabled, the pack-objects process
during 'git push' will use a sparse tree walk when deciding which
trees and blobs to send to the remote. The algorithm was introduced
by d5d2e93 (revision: implement sparse algorithm, 2019-01-16) and
has been in production use by VFS for Git since around that time.
The features.experimental config option also enabled pack.useSparse,
so hopefully that has also increased exposure.

It is worth noting that pack.useSparse has a possibility of
sending more objects across a push, but requires a special
arrangement of exact _copies_ across directories. There is a test
in t5322-pack-objects-sparse.sh that demonstrates this possibility.
This test uses the --sparse option to "git pack-objects" but we
can make it implied by the config value to demonstrate that the
default value has changed.

While updating that test, I noticed that the documentation did not
include an option for --no-sparse, which is now more important than
it was before.

Since the downside is unlikely but the upside is significant, set
the default value of pack.useSparse to true. Remove it from the
set of options implied by features.experimental.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/feature.txt   |  3 ---
 Documentation/config/pack.txt      |  4 ++--
 Documentation/git-pack-objects.txt | 10 ++++++----
 repo-settings.c                    |  3 ++-
 t/t5322-pack-objects-sparse.sh     |  3 ++-
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index 875f8c8a66f..4e3a5c0cebc 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -12,9 +12,6 @@ feature.experimental::
 	setting if you are interested in providing feedback on experimental
 	features. The new default values are:
 +
-* `pack.useSparse=true` uses a new algorithm when constructing a pack-file
-which can improve `git push` performance in repos with many files.
-+
 * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
 skipping more commits at a time, reducing the number of round trips.
 +
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 0dac5805816..837f1b16792 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -119,8 +119,8 @@ pack.useSparse::
 	objects. This can have significant performance benefits when
 	computing a pack to send a small change. However, it is possible
 	that extra objects are added to the pack-file if the included
-	commits contain certain types of direct renames. Default is `false`
-	unless `feature.experimental` is enabled.
+	commits contain certain types of direct renames. Default is
+	`true`.
 
 pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index fecdf2600cc..eaa2f2a4041 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
 	[--stdout [--filter=<filter-spec>] | base-name]
-	[--shallow] [--keep-true-parents] [--sparse] < object-list
+	[--shallow] [--keep-true-parents] [--[no-]sparse] < object-list
 
 
 DESCRIPTION
@@ -196,14 +196,16 @@ depth is 4095.
 	Add --no-reuse-object if you want to force a uniform compression
 	level on all data no matter the source.
 
---sparse::
-	Use the "sparse" algorithm to determine which objects to include in
+--[no-]sparse::
+	Toggle the "sparse" algorithm to determine which objects to include in
 	the pack, when combined with the "--revs" option. This algorithm
 	only walks trees that appear in paths that introduce new objects.
 	This can have significant performance benefits when computing
 	a pack to send a small change. However, it is possible that extra
 	objects are added to the pack-file if the included commits contain
-	certain types of direct renames.
+	certain types of direct renames. If this option is not included,
+	it defaults to the value of `pack.useSparse`, which is true unless
+	otherwise specified.
 
 --thin::
 	Create a "thin" pack by omitting the common objects between a
diff --git a/repo-settings.c b/repo-settings.c
index a703e407a3f..dc6817daa95 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -45,6 +45,8 @@ void prepare_repo_settings(struct repository *r)
 
 	if (!repo_config_get_bool(r, "pack.usesparse", &value))
 		r->settings.pack_use_sparse = value;
+	UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
+
 	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
 		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
 		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
@@ -52,7 +54,6 @@ void prepare_repo_settings(struct repository *r)
 	if (!repo_config_get_bool(r, "fetch.writecommitgraph", &value))
 		r->settings.fetch_write_commit_graph = value;
 	if (!repo_config_get_bool(r, "feature.experimental", &value) && value) {
-		UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
 		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
 		UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 1);
 	}
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index 7124b5581a0..6e5d6bdb0a7 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -105,6 +105,7 @@ test_expect_success 'non-sparse pack-objects' '
 	test_cmp required_objects.txt nonsparse_required_objects.txt
 '
 
+# --sparse is enabled by default by pack.useSparse
 test_expect_success 'sparse pack-objects' '
 	git rev-parse			\
 		topic1			\
@@ -112,7 +113,7 @@ test_expect_success 'sparse pack-objects' '
 		topic1:f3		\
 		topic1:f3/f4		\
 		topic1:f3/f4/data.txt | sort >expect_sparse_objects.txt &&
-	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
+	git pack-objects --stdout --revs <packinput.txt >sparse.pack &&
 	git index-pack -o sparse.idx sparse.pack &&
 	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
 	test_cmp expect_sparse_objects.txt sparse_objects.txt
-- 
gitgitgadget

