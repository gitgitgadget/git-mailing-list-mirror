Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7B4C33CB7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD63215A4
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVI1d3xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgAaUQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38157 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgAaUQX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id a9so10148016wmj.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pp+putYic/YPhOPXhgtuPLfFxxGHo2lzSEwyNyMGA0M=;
        b=VVI1d3xiMpLwIbREkgD6McZU/hwFDDQBJhhIgqjyREQfmUh3fbQqU/09aUJdbxNoZW
         ksFeaMzq9GM4jHMI4B477CMu+lLpAAv+HMHcx4EEN1W5ap21RvQFl2Dw8/0if4eXyH3i
         9UDb0xPtX7UGYas46ubfIdlINa8jmqb9IeR5TzmcCr0LOgd7aDv8DJalt7DKxO3CZCNB
         F/l7nrC5Nxpxm0kE2HG7pSlZeAH14GQ9kdcBLmmfFqTKIqHjatx1/YLy26Hw/JqF8RXT
         A1iljbzfyWEiNXzSCMJT1gO+rDD0TnVMncVuVHls0ymcQaQXWa4cSPIfWH7cfYUhA8ec
         WEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pp+putYic/YPhOPXhgtuPLfFxxGHo2lzSEwyNyMGA0M=;
        b=ZXd1cNarZX4qfe7pkKfS5BK53ZEj7J5FvwHQhYQ68RooS8ND6LMyStT3mN1IsVK3Qg
         zdlPyDYnzjSmKZIsEOM/tj2idSLbF6HOSB0/QLtVoUPnZDMBZTRuxd7PMgvP//wmGDpy
         uYNIgg3nI3oJD23gMB7N8/vsg8k5PVjcSeExDvFVAGk5998qx36Cpip0HshcTB+shvMe
         37DhkJ0Hb1q64Le2mz0njoAbhf/bFab+EVnJsR9w69DHU5NS660/EejOS6UKocJASplZ
         DQxiCvVO7JK6eHxWpW7WFHW1d2Q6kdZtQ138Qub4GCshfpcPwat98vtk2Plu3gtHjFq7
         HJtA==
X-Gm-Message-State: APjAAAX2DASNG6FrUIQH0N74TLjbpWeDPU8RE+jhFD+bR+nfT2HCQjl7
        xpc36CSrRyHejbwDhsTz0QYqRIP3
X-Google-Smtp-Source: APXvYqx2oNJFu0JmQ6yzDxSQdWHmBdomP7RRdRH7bwSAoLMFPfjBE9Z+G9KSP3j6eownDKMpJTfOnQ==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr13170402wmj.7.1580501780757;
        Fri, 31 Jan 2020 12:16:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11sm1069774wrn.40.2020.01.31.12.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:20 -0800 (PST)
Message-Id: <2ad4d3e467a7e2be679de4084e54f426aa242bd6.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:06 +0000
Subject: [PATCH v4 06/15] sparse-checkout: cone mode does not recognize "**"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When core.sparseCheckoutCone is enabled, the 'git sparse-checkout set'
command creates a restricted set of possible patterns that are used
by a custom algorithm to quickly match those patterns.

If a user manually edits the sparse-checkout file, then they could
create patterns that do not match these expectations. The cone-mode
matching algorithm can return incorrect results. The solution is to
detect these incorrect patterns, warn that we do not recognize them,
and revert to the standard algorithm.

Check each pattern for the "**" substring, and revert to the old
logic if seen. While technically a "/<dir>/**" pattern matches
the meaning of "/<dir>/", it is not one that would be written by
the sparse-checkout builtin in cone mode. Attempting to accept that
pattern change complicates the logic and instead we punt and do
not accept any instance of "**".

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              |  7 +++++-
 t/t1091-sparse-checkout-builtin.sh | 34 ++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 22d08e61c2..40fed73a94 100644
--- a/dir.c
+++ b/dir.c
@@ -651,11 +651,16 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		return;
 	}
 
+	if (strstr(given->pattern, "**")) {
+		/* Not a cone pattern. */
+		warning(_("unrecognized pattern: '%s'"), given->pattern);
+		goto clear_hashmaps;
+	}
+
 	if (given->patternlen > 2 &&
 	    !strcmp(given->pattern + given->patternlen - 2, "/*")) {
 		if (!(given->flags & PATTERN_FLAG_NEGATIVE)) {
 			/* Not a cone pattern. */
-			pl->use_cone_patterns = 0;
 			warning(_("unrecognized pattern: '%s'"), given->pattern);
 			goto clear_hashmaps;
 		}
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index cf4a595c86..e2e45dc7fd 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -305,4 +305,38 @@ test_expect_success 'different sparse-checkouts with worktrees' '
 	check_files worktree a deep
 '
 
+check_read_tree_errors () {
+	REPO=$1
+	FILES=$2
+	ERRORS=$3
+	git -C $REPO read-tree -mu HEAD 2>err &&
+	if test -z "$ERRORS"
+	then
+		test_must_be_empty err
+	else
+		test_i18ngrep "$ERRORS" err
+	fi &&
+	check_files $REPO $FILES
+}
+
+test_expect_success 'pattern-checks: /A/**' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/folder1/**
+	EOF
+	check_read_tree_errors repo "a folder1" "disabling cone pattern matching"
+'
+
+test_expect_success 'pattern-checks: /A/**/B/' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/deep/**/deepest
+	EOF
+	check_read_tree_errors repo "a deep" "disabling cone pattern matching" &&
+	check_files repo/deep "deeper1" &&
+	check_files repo/deep/deeper1 "deepest"
+'
+
 test_done
-- 
gitgitgadget

