Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDBDC7618E
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 01:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDWBIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 21:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjDWBH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 21:07:59 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9AB2136
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 18:07:52 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-32a7770f7d1so33556675ab.1
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 18:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682212072; x=1684804072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pZrA85wvMinszlhdO60mxtbhGR0mKkbUVreqrOEy3w=;
        b=fwXOZFg6Nx7GzX3d309//C6bJyxSC3APsKIPxi2gda1eU8ntAPJLHcOz2GzWV3wVk8
         efEue8Fvbwg1+lfXAb3vAP654qAK/xXtE1BnxdGfCYL4tkv4zgJO5klalolRJ3YOYZJS
         ftF6vbYWgo0ZRRy2bVRBexaqvqul1rbuRqfZIXg1zbb/VlIR/T416lmDNdgPBbEGhcsh
         4GobWS92ykB36bejoQUynzQ48NGn/302RBM76HTEJugVXXU6PqhIAmSOyqu5s9WKjt24
         n4FaRshCNc2KYnJuN+4g63EBaIbsIEVywn3uxsnzYIn7/OCbsSokHd0jc/yMgFV/5V4j
         2Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682212072; x=1684804072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pZrA85wvMinszlhdO60mxtbhGR0mKkbUVreqrOEy3w=;
        b=ELCtYog4OATzNnsL+uypBYOQfcjpaLMRRAFLroQVAi92P6qoNxyxU/eiAi+wAqiWK5
         y6BCkeRsq+xbVLNCZ1Vrwwoznv+cAZn/oODt4X//BdZeujrfchMUolt59lo1cllXIoZw
         qORXAU6skh0Kh6y8BLW8aEWGO9TpEnPZuwGGekClCV1YH75mF6oqXcAr+8m6fY85Mrl3
         H73G6sX+brZh9sVOZTDgKwLmqGFibpyzgXWSwIe9/qYXIF5DIODYkb/RpaML1KQSbnTM
         koAKIYqj73lxT5gVReyKJjG360+bhltGAJD4kOaLyyv6HOIW8d7Rrx+c+jrGWMAcDVUL
         PX0w==
X-Gm-Message-State: AAQBX9fBbl21gyvsTlkfVWc2KHAG0/7K+usvvCXXs73d0HDSS9luAjTc
        vEf+CN5Ya7bqUjmLOUzTu9N130xP6eoMng==
X-Google-Smtp-Source: AKy350bVgm2ukVFoOnW/VdW1qZnOLRaEYEeI/GjbVemjaV4cCsGb84Sd1gmKREG9avGrEP9w/rhmHA==
X-Received: by 2002:a92:d806:0:b0:32e:41ce:e52c with SMTP id y6-20020a92d806000000b0032e41cee52cmr1237844ilm.1.1682212071691;
        Sat, 22 Apr 2023 18:07:51 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id z1-20020a92d6c1000000b0032e28db67dcsm669819ilp.84.2023.04.22.18.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 18:07:51 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v8 2/2] diff-files: integrate with sparse index
Date:   Sat, 22 Apr 2023 21:07:21 -0400
Message-Id: <20230423010721.1402736-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230423010721.1402736-1-cheskaqiqi@gmail.com>
References: <20230322161820.3609-1-cheskaqiqi@gmail.com>
 <20230423010721.1402736-1-cheskaqiqi@gmail.com>
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
 builtin/diff-files.c                     |  4 +++
 t/perf/p2000-sparse-operations.sh        |  2 ++
 t/t1092-sparse-checkout-compatibility.sh | 35 ++++++++++++++++++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

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
index 3c140103c5..7ebcfe785e 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1377,7 +1377,10 @@ test_expect_success 'index.sparse disabled inline uses full index' '
 	! test_region index ensure_full_index trace2.txt
 '
 
-ensure_not_expanded () {
+ensure_index_state () {
+	local expected_expansion="$1"
+	shift
+
 	rm -f trace2.txt &&
 	if test -z "$WITHOUT_UNTRACKED_TXT"
 	then
@@ -1398,7 +1401,21 @@ ensure_not_expanded () {
 			>sparse-index-out \
 			2>sparse-index-error || return 1
 	fi &&
-	test_region ! index ensure_full_index trace2.txt
+
+	if [ "$expected_expansion" = "expanded" ]
+	then
+		test_region index ensure_full_index trace2.txt
+	else
+		test_region ! index ensure_full_index trace2.txt
+	fi
+}
+
+ensure_expanded () {
+	ensure_index_state "expanded" "$@"
+}
+
+ensure_not_expanded () {
+	ensure_index_state "not_expanded" "$@"
 }
 
 test_expect_success 'sparse-index is not expanded' '
@@ -2154,4 +2171,18 @@ test_expect_success 'diff-files with pathspec outside sparse definition' '
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

