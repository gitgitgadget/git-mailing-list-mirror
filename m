Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06190C2D0D3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4C52146E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7/GfE9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfLTWFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:05:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47005 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbfLTWFc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:05:32 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so9822146edi.13
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 14:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q7UcMuQt+q25b4TZtxCocB+fPmX1EuIgEXFmxv7wSug=;
        b=m7/GfE9KEOhY2QWpk3HVA33LBuWRitGRzraNOav5FsjyStzFxKN0DTnCxmSEEjCZqe
         D8/hJYpQsH1C178csqnPGuKi+WuX8tgPrxi5qe+t/XyM53t3dpu9KUQEghtNdaAbK35Y
         JVyIs8KcNa27ZwL2KJmi+RjuiHQyBKhgAMB+A6TFzt++CdHj8NgvbCAT4aRAzlCF4+cd
         r42515EqTPGzDMxV94vvodFd73v5jAPxFfaekSbHmqcyi/ogppdI5KR1MehGNvTO1Ogh
         H/PAtpWHGT3lOzAtdzGuKEu7onChQildXQOV6dvbk7Aw6BDnVTgDKJ9jwYvVV/CqrjI0
         nCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q7UcMuQt+q25b4TZtxCocB+fPmX1EuIgEXFmxv7wSug=;
        b=kuRQgYkSHZJeGUKeNicYRjENfS45RDmJ6Fw1warbR5nLJhPvdggA9POnMYpwRd/++E
         pCzH9IIABPA2cZyRNNfFqKGSld9/4iMsJZowPS4wwL18jLTUOh6L9JWUU9FRhZgFv93j
         NgbFZF4ulCflH6fZQWeRogK2B7B6KHZ/fG+pFZNmjCw1oivB3F7e2rl9jHQMLDP2uiSB
         IJKWgsWkRFeDJybhOkmD8aZFxgNfnZvThAFrOpKgU9zbU8rMlzmDbAt/c1ysbdG8Nk9p
         fr9MI1YnGYsXdB14KpfNGvAcbTvWy5647Ptxm6oeEDjGeaWP5YIpXvMreTnV58JD88yj
         mjJA==
X-Gm-Message-State: APjAAAXMjIN0UOYK+j786wqoT954CHfnwLJ1UVS0ijwDuM3tCkE2+HWq
        zOUkqbm/61Fj30CvG4CMrjV03nmT
X-Google-Smtp-Source: APXvYqxWRJdtC10tLD/8sd0689Q0fne+LF6EfdhtX1yO1zCpgkU6zRq8KUMCr+f2OQKMSI+FrlDEig==
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr18798945edr.164.1576879529728;
        Fri, 20 Dec 2019 14:05:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e20sm1232185ejq.62.2019.12.20.14.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 14:05:29 -0800 (PST)
Message-Id: <e1c315d0a766af147eb4ead41a172f724e90cc34.1576879520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 22:05:20 +0000
Subject: [PATCH 9/9] commit-graph: add GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS
 test flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Add GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS test flag to the test setup suite in
order to toggle writing bloom filters when running any of the git tests. If set
to true, we will compute and write bloom filters every time a test calls
`git commit-graph write`.

The test suite passes when GIT_TEST_COMMIT_GRAPH and
GIT_COMMIT_GRAPH_BLOOM_FILTERS are enabled.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 builtin/commit-graph.c        | 2 +-
 ci/run-build-and-tests.sh     | 1 +
 commit-graph.h                | 1 +
 t/README                      | 3 +++
 t/t4216-log-bloom.sh          | 3 +++
 t/t5318-commit-graph.sh       | 2 ++
 t/t5324-split-commit-graph.sh | 1 +
 t/t5325-commit-graph-bloom.sh | 3 +++
 8 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 9bd1e11161..97167959b2 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -146,7 +146,7 @@ static int graph_write(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
-	if (opts.enable_bloom_filters)
+	if (opts.enable_bloom_filters || git_env_bool(GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS, 0))
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
 	read_replace_refs = 0;
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index ff0ef7f08e..19d0846d34 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -19,6 +19,7 @@ linux-gcc)
 	export GIT_TEST_OE_SIZE=10
 	export GIT_TEST_OE_DELTA_SIZE=5
 	export GIT_TEST_COMMIT_GRAPH=1
+	export GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	make test
 	;;
diff --git a/commit-graph.h b/commit-graph.h
index 2202ad91ae..d914e6abf1 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -8,6 +8,7 @@
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
+#define GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS "GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS"
 
 struct commit;
 struct bloom_filter_settings;
diff --git a/t/README b/t/README
index caa125ba9a..399b190437 100644
--- a/t/README
+++ b/t/README
@@ -378,6 +378,9 @@ GIT_TEST_COMMIT_GRAPH=<boolean>, when true, forces the commit-graph to
 be written after every 'git commit' command, and overrides the
 'core.commitGraph' setting to true.
 
+GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=<boolean>, when true, forces commit-graph
+write to compute and write bloom filters for every 'git commit-graph write'
+
 GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all exercises the fsmonitor
 code path for utilizing a file system monitor to speed up detecting
 new or changed files.
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index d42f077998..0e092b387c 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -3,6 +3,9 @@
 test_description='git log for a path with bloom filters'
 . ./test-lib.sh
 
+GIT_TEST_COMMIT_GRAPH=0
+GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=0
+
 test_expect_success 'setup repo' '
 	git init &&
 	git config core.commitGraph true &&
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3f03de6018..613228bb12 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -3,6 +3,8 @@
 test_description='commit graph'
 . ./test-lib.sh
 
+GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=0
+
 test_expect_success 'setup full repo' '
 	mkdir full &&
 	cd "$TRASH_DIRECTORY/full" &&
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index c24823431f..181ca7e0cb 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -4,6 +4,7 @@ test_description='split commit graph'
 . ./test-lib.sh
 
 GIT_TEST_COMMIT_GRAPH=0
+GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=0
 
 test_expect_success 'setup repo' '
 	git init &&
diff --git a/t/t5325-commit-graph-bloom.sh b/t/t5325-commit-graph-bloom.sh
index d7ef0e7fb3..a9c9e9fef6 100755
--- a/t/t5325-commit-graph-bloom.sh
+++ b/t/t5325-commit-graph-bloom.sh
@@ -3,6 +3,9 @@
 test_description='commit graph with bloom filters'
 . ./test-lib.sh
 
+GIT_TEST_COMMIT_GRAPH=0
+GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=0
+
 test_expect_success 'setup repo' '
 	git init &&
 	git config core.commitGraph true &&
-- 
gitgitgadget
