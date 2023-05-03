Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8EFC7EE25
	for <git@archiver.kernel.org>; Wed,  3 May 2023 21:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjECV4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 17:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjECV4S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 17:56:18 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109B183C4
        for <git@vger.kernel.org>; Wed,  3 May 2023 14:56:11 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-32ad8ca1e69so45016685ab.3
        for <git@vger.kernel.org>; Wed, 03 May 2023 14:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683150970; x=1685742970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d29HnZMN680T8eUyzUa3LxFF0tHIYf6eH9YkLZm7dnI=;
        b=CbclxmD/V+ZPlycT2iQ+M972XjF/9Miq7ZjAC4jNMlp84RrSGJPqaqYQlHcwgRysBq
         /EDMiHe+T7uIOhQorkfaRcYLMvWJE9rdkv21oEgVzS3NiwU34YIPbnjncEplUmf/ZaBR
         k1v4zAqU4W8eebrM+dT0tM/s+s2B4Y5ikV9yuxfDLXk2EhcTNlFmVDD9gAtfnbU2tT+a
         OKOcFaBmt5Yy/ahtR8lqVzjFaWrwr+x/ocoBZOyeRavAIVucfG6bWea6t3FlCbD6BjwD
         vpFvMYp+nIPGDfh+wD2ZMmM2uDRjp3LqL8dNR+J/rTXpsHtrs+6kDiq0JbIvN90nBGCf
         4DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683150970; x=1685742970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d29HnZMN680T8eUyzUa3LxFF0tHIYf6eH9YkLZm7dnI=;
        b=aE58+pWX9ZDjt73FH5UCSO88ahSYTm4I1Qfg+MXCOcc88FWFoMQ/OkF9O60xk0xmhS
         Bo9M+g+drZZx3JFFoA+91kv/bfQJieB8pdgQjuqQBoaUiGakO9SGlnztes6DBhbSq19X
         +qoq+wmumFSwozqF9hxgoDiY+KvLMVH065/T6Bm46XhZns0MCTcrPQDIRVgc39xknE6m
         vK/sP4d/MwC2icK1GrWiZKv0scvmwcgh+KliOWf7zzGRzdgg4WCPPR0llMSdwxkr6KoN
         Q8HTbJ36MADiklrkGPa5z3Rfh+Fh+ysfhRt9RApURwpbLxCKUq/U6S5Q1JDP3uDd1HqS
         X5zg==
X-Gm-Message-State: AC+VfDxn6zeBuNuws6JvH1vQpkJROaecrf8dNqG9pj+FlZalSY7FKmXn
        GYP2bLnEDHFw+zGEJs/bys8BpcAMh7Flhg==
X-Google-Smtp-Source: ACHHUZ4stmt7MSh7RhS65mpuZ23MT0Gv4G/36BOvFkxLhF5Q8KpC+xYYEJAnWfTuS/Ywi7rbesOJvA==
X-Received: by 2002:a92:2a0c:0:b0:323:1869:15a1 with SMTP id r12-20020a922a0c000000b00323186915a1mr15410278ile.25.1683150969895;
        Wed, 03 May 2023 14:56:09 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id p13-20020a02290d000000b00411af6e8091sm210419jap.66.2023.05.03.14.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:56:09 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v10 2/2] diff-files: integrate with sparse index
Date:   Wed,  3 May 2023 17:55:49 -0400
Message-Id: <20230503215549.511999-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230503215549.511999-1-cheskaqiqi@gmail.com>
References: <20230502172335.478312-1-cheskaqiqi@gmail.com>
 <20230503215549.511999-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove full index requirement for `git diff-files`. Refactor the
ensure_expanded and ensure_not_expanded functions by introducing a
common helper function, ensure_index_state. Add test to ensure the index
is no expanded in `git diff-files`.

The `p2000` tests demonstrate a ~96% execution time reduction for 'git
diff-files' and a ~97% execution time reduction for 'git diff-files'
for a file using a sparse index:

Test                                           before  after
-----------------------------------------------------------------
2000.78: git diff-files (full-v3)              0.09    0.08 -11.1%
2000.79: git diff-files (full-v4)              0.09    0.09 +0.0%
2000.80: git diff-files (sparse-v3)            0.52    0.02 -96.2%
2000.81: git diff-files (sparse-v4)            0.51    0.02 -96.1%
2000.82: git diff-files f2/f4/a (full-v3)      0.06    0.07 +16.7%
2000.83: git diff-files f2/f4/a (full-v4)      0.08    0.08 +0.0%
2000.84: git diff-files f2/f4/a (sparse-v3)    0.46    0.01 -97.8%
2000.85: git diff-files f2/f4/a (sparse-v4)    0.51    0.02 -96.1%

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 builtin/diff-files.c                     |  4 ++++
 t/perf/p2000-sparse-operations.sh        |  2 ++
 t/t1092-sparse-checkout-compatibility.sh | 27 ++++++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index dc991f753b..360464e6ef 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -27,6 +27,10 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 		usage(diff_files_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
 
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 60d1de0662..29165b3493 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -129,5 +129,7 @@ test_perf_on_all git grep --cached bogus -- "f2/f1/f1/*"
 test_perf_on_all git write-tree
 test_perf_on_all git describe --dirty
 test_perf_on_all 'echo >>new && git describe --dirty'
+test_perf_on_all git diff-files
+test_perf_on_all git diff-files $SPARSE_CONE/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index eddae7ee08..ed9bf466c2 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1377,7 +1377,7 @@ test_expect_success 'index.sparse disabled inline uses full index' '
 	! test_region index ensure_full_index trace2.txt
 '
 
-ensure_not_expanded () {
+run_sparse_index_trace2 () {
 	rm -f trace2.txt &&
 	if test -z "$WITHOUT_UNTRACKED_TXT"
 	then
@@ -1397,7 +1397,16 @@ ensure_not_expanded () {
 			git -C sparse-index "$@" \
 			>sparse-index-out \
 			2>sparse-index-error || return 1
-	fi &&
+	fi
+}
+
+ensure_expanded () {
+	run_sparse_index_trace2 "$@" &&
+	test_region index ensure_full_index trace2.txt
+}
+
+ensure_not_expanded () {
+	run_sparse_index_trace2 "$@" &&
 	test_region ! index ensure_full_index trace2.txt
 }
 
@@ -2147,4 +2156,18 @@ test_expect_success 'diff-files with pathspec outside sparse definition' '
 	test_all_match git diff-files "folder*/a"
 '
 
+test_expect_success 'sparse index is not expanded: diff-files' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+
+	ensure_not_expanded diff-files &&
+	ensure_not_expanded diff-files deep/a &&
+	ensure_not_expanded diff-files "deep/*"
+'
+
 test_done
-- 
2.39.0

