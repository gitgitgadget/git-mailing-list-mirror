Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE8C7EE24
	for <git@archiver.kernel.org>; Mon,  8 May 2023 18:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjEHSrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 14:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjEHSrM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 14:47:12 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A435BAE
        for <git@vger.kernel.org>; Mon,  8 May 2023 11:47:11 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7576deacbd6so118653485a.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683571630; x=1686163630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzSx/kvJ1O5wNwqfDmbFPshW2IHfh6CLkNNVVc4E46I=;
        b=ovcI4esF31yfdCvtG0N+Bp6+n1dPlUGef7OhHUzmqg4Jz3loQz9F6kGzbFN6TFfbOX
         dgyjk441uZZoIZv+AkN+V9xXb+VInlJ765nXiD9bKZOjfKgJluMg584w9wncna/sYCG0
         TLYbht4uXwEkR1ZeM+6+eqfyrBBSaZEVKxl5iLhTdJyApAHCoI+EWLCLR9aKt6OI4oTe
         14TQNY4/zYSNCfDit/QZgU/cNm09dqOz7JJ1AG36keqbCJXUaRpqyo3TpJCyhUgzzyCR
         +XqUTUj2u9GsB5GQtk5BrKznrX9Ppu6nhwmrbA9L55DubBiCXCK5wFEbnfkVu+nNs+/J
         tJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683571630; x=1686163630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzSx/kvJ1O5wNwqfDmbFPshW2IHfh6CLkNNVVc4E46I=;
        b=ABOlpDt1nwL44LQk3M6VBp0JsuFqRmotpEFXXE3I3MlT836pDGT0m40fXbtge2YHKR
         53anQ+hvr1EL/aJ1lc6y99uPg98xAElyBzQuxU8GTavFNo6WOBB5APnalRfBVa5S6tfW
         dGx9/az9sz7cBkKP3oectzbHaHAKJdjTxkdbv6bQtFDg0gvVhV1bRe0GUn9X7mdR59lP
         RzkXq7LXCXWoHoPQmITXtSphXDT2zVwk9NB6vk2D5jZnzMBhZbnC6D3UXruKvRORkCpK
         v/iYWY5Of1bMVVcpgTV5JFRjlsivye1hcZ6fGEG++2IMiXvjYDsVqiJ6bD1tiVYH2JtM
         R4oQ==
X-Gm-Message-State: AC+VfDzl+asitRUSnelTOIeoTb5mtADMw56n+PrzPPjePqnFvjLlr0vX
        HVyDcIv9qhUpxzC+HP5uR8C2i8sVR+b+GQ==
X-Google-Smtp-Source: ACHHUZ4KJLBZ01i1ndDtNZivMmgE4nPZWFcsYT87aM+nw7Uziw3llYLlCJKOyCxuZusxxbZ1T615cA==
X-Received: by 2002:ac8:59cc:0:b0:3f1:381d:1067 with SMTP id f12-20020ac859cc000000b003f1381d1067mr18173469qtf.42.1683571630035;
        Mon, 08 May 2023 11:47:10 -0700 (PDT)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id q29-20020ac8411d000000b003f1f26bbb50sm1900982qtl.35.2023.05.08.11.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 11:47:09 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v11 2/2] diff-files: integrate with sparse index
Date:   Mon,  8 May 2023 14:46:52 -0400
Message-Id: <20230508184652.4283-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230508184652.4283-1-cheskaqiqi@gmail.com>
References: <20230503215549.511999-1-cheskaqiqi@gmail.com>
 <20230508184652.4283-1-cheskaqiqi@gmail.com>
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
index efc709afa5..176153738a 100755
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
+	ensure_not_expanded diff-files deep/a &&
+	ensure_not_expanded diff-files "deep/*"
+'
+
 test_done
-- 
2.39.0

