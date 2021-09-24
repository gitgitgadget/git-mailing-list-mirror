Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DE5C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91EF161242
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347299AbhIXPlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347225AbhIXPk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:40:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAC0C061768
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g16so28769611wrb.3
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nh2RD3Yg/rudV33Lfw2h4WjGPfRbyKyvhLRmZNtCiNE=;
        b=YS5YoRaAnqVLuQZeG0RkEs+pTLEi4202eOZaP4px3XYMc3m+CC4CFdNU4PHPz3Iffs
         FJvJPbhEpYpeSo5q9fLfnazwZrgWh3ZXMICt5p8xyXEVhnTQnJDZ7fSBZ4GecL9zfb4A
         19c6LUZ6WePnNWaraJQ4zE8P9/rFVE6YafuW/4qUUG98HOMKmL4hKLA+6oV30uqjkm0l
         r6ZH7dJqdOKo6uDNqyk6rTFuPE3P/7yyh2MNP/vMkxsWQci4DaelueR6G6qgbYf4maRh
         xAmO7M7pNCzktXdwVxvyTrxNjDIMp7W8782PzQW0kZfxJi9nYKrZ9ScVjA5oui72tr/F
         Isvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nh2RD3Yg/rudV33Lfw2h4WjGPfRbyKyvhLRmZNtCiNE=;
        b=qL33IYCRIv91XXHntmhH+Rj/ZA7B3ktUH2CDiJrjdf1iyHr4K0cHr24BQOQxnIaOR9
         demo4yGatcuJ1XXlVkl6giw9krOygbDH2/anqx6hcFsumWZqfR8VyaFtm0t4PZkuO5od
         mUS79WaNORyzBJFbSMXrreNWmNUmBTdqVemWLohONMSaEubHojzvmEUHcqvlBxE7VNi2
         OOF04eRPJ+NxhlAOuVA6BJKTsA6LlKW6Phdop4RDnDO7+qAyVkihkMp/+AO1zY4CrD+N
         VGEdAm0aKjxNkxLNK6ioTGUkag0ks7B+AK2QWx6Be/3HWQFlff+NZHvoYwSgpVzhAvyZ
         DTpw==
X-Gm-Message-State: AOAM533aeBULELq5xeLGKhDmchj+AVx54BPrIluW1rRBBBvdxYotZH3x
        hTUZ8gv1wOHUOhMXM2WAf9WkUTcmz5E=
X-Google-Smtp-Source: ABdhPJyAJFqzeHoonPfoBcaj0jrf07OX6ltpfzZtqkPSFRAQ/nS4UyulW9BOoaRz34o8wnbhWX5myQ==
X-Received: by 2002:adf:f805:: with SMTP id s5mr11947498wrp.259.1632497961972;
        Fri, 24 Sep 2021 08:39:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm13000263wml.28.2021.09.24.08.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:39:21 -0700 (PDT)
Message-Id: <47a1444115b517b2842f179ba692962a982860cb.1632497954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
References: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 15:39:12 +0000
Subject: [PATCH v4 11/13] rm: skip sparse paths with missing SKIP_WORKTREE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If a path does not match the sparse-checkout cone but is somehow missing
the SKIP_WORKTREE bit, then 'git rm' currently succeeds in removing the
file. One reason a user might be in this situation is a merge conflict
outside of the sparse-checkout cone. Removing such a file might be
problematic for users who are not sure what they are doing.

Add a check to path_in_sparse_checkout() when 'git rm' is checking if a
path should be considered for deletion. Of course, this check is ignored
if the '--sparse' option is specified, allowing users who accept the
risks to continue with the removal.

This also removes a confusing behavior where a user asks for a directory
to be removed, but only the entries that are within the sparse-checkout
definition are removed. Now, 'git rm <dir>' will fail without '--sparse'
and will succeed in removing all contained paths with '--sparse'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/rm.c                  |  4 +++-
 t/t3602-rm-sparse-checkout.sh | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 4208f3f9a5f..a6da03da2be 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -301,7 +301,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 
-		if (!include_sparse && ce_skip_worktree(ce))
+		if (!include_sparse &&
+		    (ce_skip_worktree(ce) ||
+		     !path_in_sparse_checkout(ce->name, &the_index)))
 			continue;
 		if (!ce_path_match(&the_index, ce, &pathspec, seen))
 			continue;
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index 493c8f636b8..5f92b60a56a 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -37,9 +37,13 @@ done
 test_expect_success 'recursive rm does not remove sparse entries' '
 	git reset --hard &&
 	git sparse-checkout set sub/dir &&
-	git rm -r sub &&
+	test_must_fail git rm -r sub &&
+	git rm --sparse -r sub &&
 	git status --porcelain -uno >actual &&
-	echo "D  sub/dir/e" >expected &&
+	cat >expected <<-\EOF &&
+	D  sub/d
+	D  sub/dir/e
+	EOF
 	test_cmp expected actual
 '
 
@@ -87,4 +91,15 @@ test_expect_success 'do not warn about sparse entries with --ignore-unmatch' '
 	git ls-files --error-unmatch b
 '
 
+test_expect_success 'refuse to rm a non-skip-worktree path outside sparse cone' '
+	git reset --hard &&
+	git sparse-checkout set a &&
+	git update-index --no-skip-worktree b &&
+	test_must_fail git rm b 2>stderr &&
+	test_cmp b_error_and_hint stderr &&
+	git rm --sparse b 2>stderr &&
+	test_must_be_empty stderr &&
+	test_path_is_missing b
+'
+
 test_done
-- 
gitgitgadget

