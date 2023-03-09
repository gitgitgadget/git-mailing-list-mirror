Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2E9C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 06:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjCIGkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 01:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCIGkW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 01:40:22 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158293C7A6
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 22:40:14 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id r5so1026877qtp.4
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 22:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678344013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56chFgoWQrCGRHH11rozNrQKMcO8pFxblBDIAG0YBBk=;
        b=ohLTpfuKN3P/Vq6iZ/wiU+SNmdQJ7QAzNjM7IT0HGlvtj3qMIef+4QZx/N8Y25ydaS
         37babWAlN0NIwxBU3f2PcUjmslz1NjhL0GE0uj8typ6ojL4E7xwdRZRy2wd/oU6jvl1X
         luAx6SsnTCwCth515MB3eUqWsnLEcOZFGvWHNibSKMF4UxUSnS4PhFUqUNWb6jPoOMHx
         YtFnUVptkZ3ggIMsz+L82GDBzQI/SUvj7y946aR12ER8uZYJ320AGFtBkwKWrBWb+Ihe
         oC1//P/Iwxh4K8F/55meUdpsEGtZtDg4w7LGIehJhEAWmcudAuT+Nj9zqKWPc/bbO1GQ
         b1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678344013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56chFgoWQrCGRHH11rozNrQKMcO8pFxblBDIAG0YBBk=;
        b=YtMAPCAF59XQbrISoFt4AZzOFWZsqJSZhpLFiAEjpIZfHt87qRD7tCAa6D8DpbqSVP
         TJP2xT9lGP4tiI5BwvJiCSqKiYJHEwaqeO6WUMo7eOITJlE1sH82DQ+71xg2DX/JuSU0
         mSo9Hn/G56I3vtWI4Ggozc80BWeVZNecu/O3hH5p4VKnyspKLNQFMDslpIuSfnx++Z7b
         2Fm0AXa0in0o2j+v5DP/9haDTDQgvtmd/xnJ0ugnluKQKHk7A3kXRAyCttlCmtvaTx77
         Ia4EfrFrBTr09sqOWP501USmHEYAEvFFsjjoPt17Q0TKDdPxLBWdEGsGKRGM1EVFa92T
         0N3w==
X-Gm-Message-State: AO0yUKWuc/2MuC68TtNaFSjCI4cxsrLsG8pzA0mRFgyD/RzgEarF1Fwk
        XttjO1oIpEwGTTBu7KWMpqQDJRYi/JM=
X-Google-Smtp-Source: AK7set/LSXtKCbb9zJaHnLypd1S6DIHYYfQVCdKfhnKy9yxHIxl8cp1fhyBqC6a0sXI3fr+hVWp/zQ==
X-Received: by 2002:ac8:57cd:0:b0:3b9:b619:42c1 with SMTP id w13-20020ac857cd000000b003b9b61942c1mr34417360qta.27.1678344012854;
        Wed, 08 Mar 2023 22:40:12 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id v25-20020ac873d9000000b003c033b23a9asm5834970qtp.12.2023.03.08.22.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 22:40:12 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, gitster@pobox.com,
        vdye@github.com, derrickstolee@github.com
Subject: [PATCH v4 2/2] diff-files: integrate with sparse index
Date:   Thu,  9 Mar 2023 01:39:52 -0500
Message-Id: <20230309063952.42362-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230309063952.42362-1-cheskaqiqi@gmail.com>
References: <20230309013314.119128-1-cheskaqiqi@gmail.com>
 <20230309063952.42362-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove full index requirement for `git diff-files`
and test to ensure the index is not expanded in `git diff-files`.

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
 t/t1092-sparse-checkout-compatibility.sh | 13 +++++++++++++
 3 files changed, 19 insertions(+)

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
index 3242cfe91a..82751f2ca3 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -125,5 +125,7 @@ test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
 test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
+test_perf_on_all git diff-files
+test_perf_on_all git diff-files $SPARSE_CONE/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 18d3b4f313..7cc6287627 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2094,4 +2094,17 @@ test_expect_success 'diff-files with pathspec outside sparse definition' '
 	test_sparse_match git diff-files newdirectory/testfile 
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
+	ensure_not_expanded diff-files  &&
+	ensure_not_expanded diff-files deep/a 
+'
+
 test_done
-- 
2.39.0

