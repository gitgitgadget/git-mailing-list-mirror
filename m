Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7B791F461
	for <e@80x24.org>; Sat,  7 Sep 2019 21:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395254AbfIGVgT (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 17:36:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41184 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392847AbfIGVgT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 17:36:19 -0400
Received: by mail-io1-f66.google.com with SMTP id r26so20558734ioh.8
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 14:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZW9z16mPTeDwVhhYfI1crJmrdaVkq/2LfkRla+UznUE=;
        b=NlxwJr6lyLiG4+Fhhi9TblECFQ9JEe4keQze8Q0NxE/UnXqQvRC5YV+I1cgl6/U7YG
         fNV+hzIXbeCSwjwTtfr7G9jB+JgihiF3T+eCVmpe+A3hf6aL+oZZ7tlu4e2FeImF/hfj
         llDX135EV2KQI3wIe2lyQwdcaX9TQPfpMbIvrrU6XYQ0kR6w/dL1AyHAR5sJeW1vIbUT
         wfHMK5AFjVmQ6FJZTxmxh/50CXDjbqlamSyjmVaPSs3Fjz3Ti/gTkTJzI6jf6u0UP8CJ
         kwgQJRTKPcUictBtdTY7ncp8KSxGVcAlN7x8YOzq0ZxuLVlofQ4vRvXmx8DpP2oE1aYq
         LdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZW9z16mPTeDwVhhYfI1crJmrdaVkq/2LfkRla+UznUE=;
        b=RJEYZ566l0DE0N/bpUr4fo6vm1SO2j/EXhtXi6FjVHl/+no/BLIaza4rJ9tzlz3FNm
         ZaJMTllpbHk2ZLu7T26V1UJT/5ZClOL4ON+7+ovuYXudoWUDLvEY3p5E+Bum+yRUCADb
         VXttOTs+W5IL88vTHwh+AYGRa3QzUMd0QCmZHPVhmp7F0Zy6XGWe0nBcrscZsd5rJb4T
         M1RB1TDDAGOJePOW+Jzto8x7jLqY4KP2lRiiFuILJ05mhpWq0MYq3gk57jVKlXC3eHai
         g4Ik0GPsuXccIhxm5/YpndIgLaBy+t0o7bH8wXamL9EQ/EMCpkaQwcWdorbVZXouf6ig
         66Lg==
X-Gm-Message-State: APjAAAXS0mqJ4q3FiTRe21aDR1Rbejv/PaBU6yP7hgCF6nXVIlQE8H89
        cHs/kT1YAfLFVDWDu3v4gJg90U4n
X-Google-Smtp-Source: APXvYqwl3kO2ioR5QRLRte4Em+MXGOS7gUkfcFO1XabYresY1la2JstGcRAeNsk0WbbLPwqDcboJZQ==
X-Received: by 2002:a5d:888a:: with SMTP id d10mr10966666ioo.201.1567892178252;
        Sat, 07 Sep 2019 14:36:18 -0700 (PDT)
Received: from ericfreese.hsd1.co.comcast.net ([2601:285:8280:27a7::c608])
        by smtp.gmail.com with ESMTPSA id x5sm4379774ior.46.2019.09.07.14.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 14:36:17 -0700 (PDT)
From:   Eric Freese <ericdfreese@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Freese <ericdfreese@gmail.com>
Subject: [RFC PATCH 1/1] for-each-ref: add '--no-symbolic' option
Date:   Sat,  7 Sep 2019 15:36:46 -0600
Message-Id: <20190907213646.21231-2-ericdfreese@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190907213646.21231-1-ericdfreese@gmail.com>
References: <20190907213646.21231-1-ericdfreese@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the new flag will omit symbolic refs from the output.

Without this flag, it is possible to get this behavior by using the
`%(symref)` formatting field name and piping output through grep to
include only those refs that do not output a value for `%(symref)`, but
having this flag is more elegant and intention revealing.
---
 Documentation/git-for-each-ref.txt | 3 +++
 builtin/for-each-ref.c             | 4 +++-
 ref-filter.c                       | 4 ++++
 ref-filter.h                       | 3 ++-
 t/t6302-for-each-ref-filter.sh     | 6 ++++++
 5 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6dcd39f6f6..be19111510 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -95,6 +95,9 @@ OPTIONS
 --ignore-case::
 	Sorting and filtering refs are case insensitive.
 
+--no-symbolic::
+	Only list refs that are not symbolic.
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 465153e853..b71ab2f135 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -18,7 +18,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
-	int maxcount = 0, icase = 0;
+	int maxcount = 0, icase = 0, nosym = 0;
 	struct ref_array array;
 	struct ref_filter filter;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -46,6 +46,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_CONTAINS(&filter.with_commit, N_("print only refs which contain the commit")),
 		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
 		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
+		OPT_BOOL(0, "no-symbolic", &nosym, N_("exclude symbolic refs")),
 		OPT_END(),
 	};
 
@@ -72,6 +73,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		sorting = ref_default_sorting();
 	sorting->ignore_case = icase;
 	filter.ignore_case = icase;
+	filter.no_symbolic = nosym;
 
 	filter.name_patterns = argv;
 	filter.match_as_path = 1;
diff --git a/ref-filter.c b/ref-filter.c
index f27cfc8c3e..01beb279dc 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2093,6 +2093,10 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
+	if (filter->no_symbolic && flag & REF_ISSYMREF) {
+		return 0;
+	}
+
 	/* Obtain the current ref kind from filter_ref_kind() and ignore unwanted refs. */
 	kind = filter_ref_kind(filter, refname);
 	if (!(kind & filter->kind))
diff --git a/ref-filter.h b/ref-filter.h
index f1dcff4c6e..23e0d01a33 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -65,7 +65,8 @@ struct ref_filter {
 	unsigned int with_commit_tag_algo : 1,
 		match_as_path : 1,
 		ignore_case : 1,
-		detached : 1;
+		detached : 1,
+		no_symbolic : 1;
 	unsigned int kind,
 		lines;
 	int abbrev,
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 35408d53fd..ab9c00fff4 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -454,4 +454,10 @@ test_expect_success 'validate worktree atom' '
 	test_cmp expect actual
 '
 
+test_expect_success 'filtering with --no-symbolic' '
+	git symbolic-ref refs/symbolic refs/heads/master &&
+	git for-each-ref --format="%(refname)" --no-symbolic >actual &&
+	test_must_fail grep refs/symbolic actual
+'
+
 test_done
-- 
2.23.0

