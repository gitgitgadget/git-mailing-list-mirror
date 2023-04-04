Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602E8C76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 00:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjDDAf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 20:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDDAfz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 20:35:55 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9AE2113
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 17:35:54 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p15so36883546ybl.9
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 17:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680568553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hKn17XFuLx80/b0CiPGkShrS2aDj9Z6ag/jSfS8Me0=;
        b=fB3GBwcGDlh/BbWmwkm4QQjjqunCTAL4ZgeGgtPZ5HvU5/Hw0FNkmHXCt3h3X1oCrh
         zVVQ6zL5oReJieKo+iuw2jUH8GbU9cwKpnfcIeov8VcBypPElRENcULqSl8F7qWdTPbL
         +fEJC5n3igIs27MBnrynn3a+AwkDmIE5GEnMG9oEWRfZ9MWCswy/tYoGB+/SpmeTCxAc
         B7TYzaSN5bB9DiGY4/9MzeLqkKZqevyxVRCuqQvNJ7Q5xsYhjNj5mwycVnXxE1X4fmtP
         PaWGqHZ6VUpA0iajQgfirHx+Twg7d5ljcZU0oSqB/WL1YWwwUAcFl4swbzB7HNlfrJG9
         mz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680568553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hKn17XFuLx80/b0CiPGkShrS2aDj9Z6ag/jSfS8Me0=;
        b=j6LgXMuAbTOZYLa0axAFHpRIMNwgUk0XDEqHj/FuFRAoyu3aTltDbzgdU4bVQLYKxj
         GwKRb+n3mYXv+ZL8vy/ZgWBiruX2Dk+EZIWwCdQJ+quMFXRzU/ian4Ujw+Q77baDUZbd
         qYI5muRmzgBAOhrUD7Uux2mnoMzLlOhQpZ3VaCGcZnAq6scFsKEiszjg9pIETgcRwi9j
         qLeaqynzt61V8Q5lYKqSNyzteOzauQpvpCQNH2EiQXVLnNfDHnz1BqQV+K47pt9zfhym
         ii1B2/l4T3tN8JACCRMonnf0oGxcUmm+vCCI3wgtxA7Eh9BLFgbbRbXIBMUmuvPBYw2j
         udPA==
X-Gm-Message-State: AAQBX9dMHX+jfPEZCvNtseWGquaz/y/ROLDDuhoEjN+boaF61bIlv72x
        +tD+8jOun4DoI1vdKq6n/cAmfG4agDvVog==
X-Google-Smtp-Source: AKy350ZVzOI+zZvwo3f/eWuXIrr6N9K9kcKR6qEx26VVWnJ94/bkMNcN771YbU+iBl9rrffS8WuVVg==
X-Received: by 2002:a25:aa26:0:b0:b6b:edd:8772 with SMTP id s35-20020a25aa26000000b00b6b0edd8772mr1332778ybi.6.1680568552977;
        Mon, 03 Apr 2023 17:35:52 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id n1-20020a05690211c100b00b7c727ddcadsm2915284ybu.63.2023.04.03.17.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 17:35:52 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v2] write-tree: integrate with sparse index
Date:   Mon,  3 Apr 2023 20:35:39 -0400
Message-Id: <20230404003539.1578245-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230402000117.313171-1-cheskaqiqi@gmail.com>
References: <20230402000117.313171-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update 'git write-tree' to allow using the sparse-index in memory
without expanding to a full one.

The recursive algorithm for update_one() was already updated in 2de37c5
(cache-tree: integrate with sparse directory entries, 2021-03-03) to
handle sparse directory entries in the index. Hence we can just set the
requires-full-index to false for "write-tree".

The `p2000` tests demonstrate a ~96% execution time reduction for 'git
write-tree' using a sparse index:

Test                                           before  after
-----------------------------------------------------------------
2000.78: git write-tree (full-v3)              0.34    0.33 -2.9%
2000.79: git write-tree (full-v4)              0.32    0.30 -6.3%
2000.80: git write-tree (sparse-v3)            0.47    0.02 -95.8%
2000.81: git write-tree (sparse-v4)            0.45    0.02 -95.6%

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---

* change the position of "settings.command_requires_full_index = 0"

Range-diff against v1:
1:  d8a9ccd0b3 ! 1:  8873c79759 write-tree: integrate with sparse index
    @@ Commit message
     
      ## builtin/write-tree.c ##
     @@ builtin/write-tree.c: int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
    - 	};
    - 
    - 	git_config(git_default_config, NULL);
    -+	
    -+	prepare_repo_settings(the_repository);
    -+	the_repository->settings.command_requires_full_index = 0;
    -+
      	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
      			     write_tree_usage, 0);
      
    ++	prepare_repo_settings(the_repository);
    ++	the_repository->settings.command_requires_full_index = 0;
    ++	
    + 	ret = write_cache_as_tree(&oid, flags, tree_prefix);
    + 	switch (ret) {
    + 	case 0:
     
      ## t/perf/p2000-sparse-operations.sh ##
     @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git checkout-index -f --all


 builtin/write-tree.c                     |  3 +++
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 28 ++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 45d61707e7..4492da0912 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -38,6 +38,9 @@ int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
 	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
 			     write_tree_usage, 0);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+	
 	ret = write_cache_as_tree(&oid, flags, tree_prefix);
 	switch (ret) {
 	case 0:
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 3242cfe91a..9924adfc26 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -125,5 +125,6 @@ test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
 test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
+test_perf_on_all git write-tree 
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..3b8191b390 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2055,4 +2055,32 @@ test_expect_success 'grep sparse directory within submodules' '
 	test_cmp actual expect
 '
 
+test_expect_success 'write-tree on all' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+	run_on_all git update-index deep/a &&
+	test_all_match git write-tree &&
+
+	run_on_all mkdir -p folder1 &&
+	run_on_all cp a folder1/a &&
+	run_on_all ../edit-contents folder1/a &&
+	run_on_all git update-index folder1/a &&
+	test_all_match git write-tree
+'
+
+test_expect_success 'sparse-index is not expanded: write-tree' '
+	init_repos &&
+
+	ensure_not_expanded write-tree &&
+
+	echo "test1" >>sparse-index/a &&
+	git -C sparse-index update-index a &&
+	ensure_not_expanded write-tree 
+'
+
 test_done
-- 
2.39.0

