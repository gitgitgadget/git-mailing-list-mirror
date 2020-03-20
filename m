Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F78C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 12:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559352072C
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 12:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw047+5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgCTM1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:27:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36926 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgCTM1d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 08:27:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id b23so6916748edx.4
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 05:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uk9UBL1AafgnBCWRq+cUahHUwAOsVkqa928Rxbj+t1Y=;
        b=gw047+5KFQ4nAyE5dZNCx25DMR3Ff+NrMnpemgJ5Ms9wVjBnwNaVn2nQaX31X5Wc9g
         UVjObcMbOxjBjrAKO48ma9JC8KMazEWdiMnfHr8sRN0A/YUo/1CsWaAgLY0KyAOV33hq
         XPZmZZ4eHb/fxoiTatuwoUFkWU4ZeZVECnSHxE7qrrT+VlGAANpJ065hNHX1ZqUGtuN2
         VY9gpyRFDK5d2GzoZN5aIEtUZZIPlM33omFKkG4+djA7KDnjHWvrnEYfTxzFsE39jRmK
         JFGlZJ4D5ePsHB/HiSus+mwr8rNaYAs3W4RXQaqwPyMRnFTsRL9bG3JlDAe1+8rJuF1y
         6lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uk9UBL1AafgnBCWRq+cUahHUwAOsVkqa928Rxbj+t1Y=;
        b=OhvPXj49mqN06JnuoroX2tBTnD3fct7EeGwA9UQSZuyvL6QKj8S6cck7OXiGHEkI85
         P5bcA5UDneSBNe4adcV4qqIcw02+DW6Zi5o6hZFftTuYcesUJ8seY/ROpUqpN6dBde3N
         hEgY8a5c9710iUjeO5Y7K+6Jb6Oxy56BGXiXLKozk0XHe8pQ0UaO1OnlN1evZ5wrE+cU
         4rn2VxVOKDecjZnIMkq61bLcofetpLU0QvD2+G7PCtk66XX3lEObv0Day5C++cXwu4Er
         /jfT07sTlwc4cjAT6bWuPWAn0B2EsuElUSm0Xk8KJCSjBgh+OWYupEV26S7JUWTEKI+T
         VTOg==
X-Gm-Message-State: ANhLgQ2LUU4Auf48ZhYA4JZ5mzYaD42H2yTS9ED0Cknw3xJvgVovAFo6
        lx6BVP1hsdUnz0VwFPu3twiYU9AL
X-Google-Smtp-Source: ADFU+vvWL1QGNHrcBcktwCXOmNtVs+bRRS0FKo+dc14AMCH3Sh/YumOSH9x3Y6xH0IRsNv0fot6ifw==
X-Received: by 2002:a50:9f6e:: with SMTP id b101mr7539302edf.372.1584707249199;
        Fri, 20 Mar 2020 05:27:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b20sm347295edt.93.2020.03.20.05.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:27:28 -0700 (PDT)
Message-Id: <pull.585.v2.git.1584707247753.gitgitgadget@gmail.com>
In-Reply-To: <pull.585.git.1584583110914.gitgitgadget@gmail.com>
References: <pull.585.git.1584583110914.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Mar 2020 12:27:27 +0000
Subject: [PATCH v2] config: set pack.useSparse=true by default
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
    config: set pack.useSparse=true by default
    
    Here is a small patch to convert pack.useSparse to true by default. It's
    been released for over a year, so the feature is quite stable. I'm
    submitting this now to allow it to cook for a while during the next
    release cycle.
    
    Thanks to Jonathan Nieder pointing out the test implications, I've added
    a patch to swap the role of GIT_TEST_PACK_SPARSE to test the other mode.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-585%2Fderrickstolee%2Fpack-use-sparse-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-585/derrickstolee/pack-use-sparse-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/585

Range-diff vs v1:

 1:  02e9a813126 ! 1:  60b5cc6f337 config: set pack.useSparse=true by default
     @@ -16,6 +16,13 @@
          sending more objects across a push, but requires a special
          arrangement of exact _copies_ across directories. There is a test
          in t5322-pack-objects-sparse.sh that demonstrates this possibility.
     +    This test uses the --sparse option to "git pack-objects" but we
     +    can make it implied by the config value to demonstrate that the
     +    default value has changed.
     +
     +    While updating that test, I noticed that the documentation did not
     +    include an option for --no-sparse, which is now more important than
     +    it was before.
      
          Since the downside is unlikely but the upside is significant, set
          the default value of pack.useSparse to true. Remove it from the
     @@ -52,6 +59,39 @@
       pack.writeBitmaps (deprecated)::
       	This is a deprecated synonym for `repack.writeBitmaps`.
      
     + diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
     + --- a/Documentation/git-pack-objects.txt
     + +++ b/Documentation/git-pack-objects.txt
     +@@
     + 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
     + 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
     + 	[--stdout [--filter=<filter-spec>] | base-name]
     +-	[--shallow] [--keep-true-parents] [--sparse] < object-list
     ++	[--shallow] [--keep-true-parents] [--[no-]sparse] < object-list
     + 
     + 
     + DESCRIPTION
     +@@
     + 	Add --no-reuse-object if you want to force a uniform compression
     + 	level on all data no matter the source.
     + 
     +---sparse::
     +-	Use the "sparse" algorithm to determine which objects to include in
     ++--[no-]sparse::
     ++	Toggle the "sparse" algorithm to determine which objects to include in
     + 	the pack, when combined with the "--revs" option. This algorithm
     + 	only walks trees that appear in paths that introduce new objects.
     + 	This can have significant performance benefits when computing
     + 	a pack to send a small change. However, it is possible that extra
     + 	objects are added to the pack-file if the included commits contain
     +-	certain types of direct renames.
     ++	certain types of direct renames. If this option is not included,
     ++	it defaults to the value of `pack.useSparse`, which is true unless
     ++	otherwise specified.
     + 
     + --thin::
     + 	Create a "thin" pack by omitting the common objects between a
     +
       diff --git a/repo-settings.c b/repo-settings.c
       --- a/repo-settings.c
       +++ b/repo-settings.c
     @@ -72,3 +112,24 @@
       		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
       		UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 1);
       	}
     +
     + diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
     + --- a/t/t5322-pack-objects-sparse.sh
     + +++ b/t/t5322-pack-objects-sparse.sh
     +@@
     + 	test_cmp required_objects.txt nonsparse_required_objects.txt
     + '
     + 
     ++# --sparse is enabled by default by pack.useSparse
     + test_expect_success 'sparse pack-objects' '
     + 	git rev-parse			\
     + 		topic1			\
     +@@
     + 		topic1:f3		\
     + 		topic1:f3/f4		\
     + 		topic1:f3/f4/data.txt | sort >expect_sparse_objects.txt &&
     +-	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
     ++	git pack-objects --stdout --revs <packinput.txt >sparse.pack &&
     + 	git index-pack -o sparse.idx sparse.pack &&
     + 	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
     + 	test_cmp expect_sparse_objects.txt sparse_objects.txt


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

base-commit: 6c85aac65fb455af85745130ce35ddae4678db84
-- 
gitgitgadget
