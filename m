Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0763CC11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC69020722
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJJktVey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgBTUHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:07:10 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41117 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgBTUHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 15:07:09 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so35206123eds.8
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 12:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/Z27Puf3lg9q6oucV2AViWEvYmokAB0T87w1Ij61OjA=;
        b=oJJktVeyyWwJZNDOCy1I63Vpp7GHZrAl1X+9Vnn+eJhYnnsI6emzYei+FexjJbIkN+
         1wbgH65YnCZ3PHC9VE7V3E+3ZGoerscM1LwPaz82NsPNNafuYoUDrKbIeOaR4q7J9job
         8bkz+mICX25CcV1VJ2jHHJrZAtkC+4RPF+ZPmxvAJKOqstkoJRKTdGdiEf2U9fqwA0JT
         rWlKGzn3+n6Xblq9yEEbhdr62xICa4xkiW5iXcIvjSZa340LbfRDFJZrzpTuojYOVXvp
         I9zTJZ+y9fBl0p2OQi0BPIKLle89Qxon+XnzG08dbzkZyV5h28GEBBaI9OLxvn5OzFSK
         oa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Z27Puf3lg9q6oucV2AViWEvYmokAB0T87w1Ij61OjA=;
        b=qPq6IoY8uJBYo2ie9d305FZsFZnudBfxiqKXRB3d7g4PQamJihlENK6WziYDpkLjMU
         LuPJZifJzUfFJgGH3BMLQvyQ/6RWkFUBmkUQACNalUsVPGXcQ+UglZV8OMOON3O1WfXz
         SNg4ZtslcrFVO5Avh2B3ZjR89uO/d/1YMmxV1s7zjJyIeGPa4d6fl8w9s66CK9KU1BP9
         3grDB6/agzLqhZfb4IbCxmZZWaC2MRqZAhp+veRwoeFPF87xtHX1fI7BXXSiNjHZp78d
         n5bkYnCFbHjrWG0PBCxeytlJQUP8FFwFatdyrrbyE+siqxwz8HI6IurroWQc5ZW/Hd+b
         Wa2A==
X-Gm-Message-State: APjAAAXgzlhLQH1rMBMdoe17HMKePeaAxxQxgG9RQq3WoI0PXYF5yfJ4
        G3FxpZhWOn8AhLJPund/vqwakye1
X-Google-Smtp-Source: APXvYqx5dg6x55vn3ihlLcTAQzdvILh+h7dQIOPO1svAsYKa5IbKyXTQMn5aqu0JffpBmwHlye4Jyw==
X-Received: by 2002:a05:6402:1694:: with SMTP id a20mr29350650edv.211.1582229227568;
        Thu, 20 Feb 2020 12:07:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay2sm40439ejb.75.2020.02.20.12.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:07:07 -0800 (PST)
Message-Id: <pull.558.git.1582229226637.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Feb 2020 20:07:06 +0000
Subject: [PATCH] sparse-checkout: allow one-character directories in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In 9e6d3e64 (sparse-checkout: detect short patterns, 2020-01-24), a
condition on the minimum length of a cone-mode pattern was introduced.
However, this condition was off-by-one.

If we have a directory with a single character, say "b", then the
command

	git sparse-checkout set b

will correctly add the pattern "/b/" to the sparse-checkout file. When
this is interpeted in dir.c, the pattern is "/b" with the
PATTERN_FLAG_MUSTBEDIR flag. This string has length two, which satisfies
our inclusive inequality (<= 2).

The reason for this inequality is that we will start to read the pattern
string character-by-character using three char pointers: prev, cur,
next. In particular, next is set to the current pattern plus two. The
mistake was that next will still be a valid pointer when the pattern
length is two, since the string is null-terminated.

Make this inequality strict so these patterns work.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    sparse-checkout: allow one-character directories in cone mode
    
    This is based on ds/sparse-add.
    
    I discovered this while taking v2.25.1 and ds/sparse-add into our fork
    of Git and testing it with Scalar.
    
    Off-by-one errors are tricky, sometimes.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-558%2Fderrickstolee%2Fsparse-short-pattern-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-558/derrickstolee/sparse-short-pattern-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/558

 dir.c                              |  2 +-
 t/t1091-sparse-checkout-builtin.sh | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 7ac0920b713..a87900d43a2 100644
--- a/dir.c
+++ b/dir.c
@@ -682,7 +682,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		return;
 	}
 
-	if (given->patternlen <= 2 ||
+	if (given->patternlen < 2 ||
 	    *given->pattern == '*' ||
 	    strstr(given->pattern, "**")) {
 		/* Not a cone pattern. */
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index c35cbdef454..b4c9c32a037 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -417,10 +417,20 @@ test_expect_success 'pattern-checks: too short' '
 	cat >repo/.git/info/sparse-checkout <<-\EOF &&
 	/*
 	!/*/
-	/a
+	/
 	EOF
 	check_read_tree_errors repo "a" "disabling cone pattern matching"
 '
+test_expect_success 'pattern-checks: not too short' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/b/
+	EOF
+	git -C repo read-tree -mu HEAD 2>err &&
+	test_must_be_empty err &&
+	check_files repo a
+'
 
 test_expect_success 'pattern-checks: trailing "*"' '
 	cat >repo/.git/info/sparse-checkout <<-\EOF &&

base-commit: ef07659926f64d70e8cb41025c3d7456eecb962e
-- 
gitgitgadget
