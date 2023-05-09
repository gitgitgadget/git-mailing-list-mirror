Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D920CC7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 19:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjEITnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 15:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjEITnF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 15:43:05 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E6A49C1
        for <git@vger.kernel.org>; Tue,  9 May 2023 12:43:02 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f390fb063cso13079811cf.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 12:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683661381; x=1686253381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AApz5+Lh6E/3Y8dGc7YO37u/LcRdaV57ysLBekPiBKE=;
        b=HhhugXS3fMdSu1+dbMqlCJfX/jFD8n68p5qxmM7sZvoPk9uBDP5XAy2mjD1vs4PAJ7
         wEA/GV0kyFaNRxPBdbZT0EcxVlehdIBixb9azKw1s6oX9DpB3JGpp5IMQjHglAuUlOS6
         OATyEXpyU0B0UHLjI+5DnIAnXlFQSkULwK+OF21YSR5YgZz4hWdxbxTNKd1S7Vk4domX
         SybPhhThIuu91o3ZrOZrdwvEkwvh8KwN2MAVIPdMasNKRKKMYtYLshg6eEp2ilyAUk+W
         XM31Ke2pSupjXdrzrdcbswu7P/JIlT4JlaNX47QH83R9UbU3xzicElJz6UY3AWw6VU9M
         Z98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683661381; x=1686253381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AApz5+Lh6E/3Y8dGc7YO37u/LcRdaV57ysLBekPiBKE=;
        b=mH9BL3dPIy+cBn8cfCsxTnJlgTE/3Sx5WKgom1P7Dpuq63pMKGsrjT4doYrgpirsi5
         g2o/dMf45+SnxI9p/X+F85pSv+KLVZHmrJJvp45JAGXPzzJg7gmkeHDFdamRRtE3sx4g
         SxHGEJufr7aY1+ihBGcsbtSrqwBEKLEDfpWQr0dGUAj3Y48OHBkXloFsz7C1yUqz/9uY
         q9OcI0/uojMflQ8l2+jgeTl0tjJubnMPWgpOK1xwbS+aqj3Sr2H5956OrZ00TWLrd4xF
         X/FhU4eaUmEWAjJnO+EoDF2LtWEMAPmElJwXFIxT23ITLHawKg4rPF5rnSI0e+P38LAh
         m/pg==
X-Gm-Message-State: AC+VfDxBcYQ4/YFOd5128LB94GgJxuChPle1seTysfTzUK0IIz0Z1DY7
        xy7SIHXWzj74CLUYxjsy/bUa/266JGZqVA==
X-Google-Smtp-Source: ACHHUZ6KriYyST6wGDdGEkxd7FW57fbaTWPWUnWvCgacPKSvFWj4D0dItB+5UAXMeuhHBoov9FgM/g==
X-Received: by 2002:ac8:5716:0:b0:3ec:a94b:c454 with SMTP id 22-20020ac85716000000b003eca94bc454mr22042680qtw.21.1683661380765;
        Tue, 09 May 2023 12:43:00 -0700 (PDT)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id j11-20020ac8550b000000b003f1f26bbb50sm756038qtq.35.2023.05.09.12.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:43:00 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v12 2/2] diff-files: integrate with sparse index
Date:   Tue,  9 May 2023 15:42:41 -0400
Message-Id: <20230509194241.469477-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230509194241.469477-1-cheskaqiqi@gmail.com>
References: <20230508184652.4283-1-cheskaqiqi@gmail.com>
 <20230509194241.469477-1-cheskaqiqi@gmail.com>
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

Test                                               before  after
-----------------------------------------------------------------------
2000.94: git diff-files (full-v3)                  0.09    0.08 -11.1%
2000.95: git diff-files (full-v4)                  0.09    0.09 +0.0%
2000.96: git diff-files (sparse-v3)                0.52    0.02 -96.2%
2000.97: git diff-files (sparse-v4)                0.51    0.02 -96.1%
2000.98: git diff-files -- f2/f4/a (full-v3)       0.06    0.07 +16.7%
2000.99: git diff-files -- f2/f4/a (full-v4)       0.08    0.08 +0.0%
2000.100: git diff-files -- f2/f4/a (sparse-v3)    0.46    0.01 -97.8%
2000.101: git diff-files -- f2/f4/a (sparse-v4)    0.51    0.02 -96.1%

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
index 60d1de0662..901cc493ef 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -129,5 +129,7 @@ test_perf_on_all git grep --cached bogus -- "f2/f1/f1/*"
 test_perf_on_all git write-tree
 test_perf_on_all git describe --dirty
 test_perf_on_all 'echo >>new && git describe --dirty'
+test_perf_on_all git diff-files
+test_perf_on_all git diff-files -- $SPARSE_CONE/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index b06b522030..e58bfbfcb4 100755
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
 	test_all_match git diff-files -- "folder*/a"
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
+	ensure_not_expanded diff-files -- deep/a &&
+	ensure_not_expanded diff-files -- "deep/*"
+'
+
 test_done
-- 
2.39.0

