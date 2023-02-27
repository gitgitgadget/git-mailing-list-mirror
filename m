Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9351C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjB0P2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjB0P22 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 10:28:28 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550A2B473
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:25 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v16so3844049wrn.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLo1zUU46LmESvRDG8CVbF8q0iwxbn/Du3MzxOLzph8=;
        b=BrDbAjWU7/t9bDALdgDw8rJ00w3XckTSPc3yWn4Ee1t0rlTb35OQGyX5Y5OQajfXCJ
         cXhLoljtl6xRn1PXnNvMs/e/7ER0bcEFe1v6Wil7EZG/Yvpo+Z1OwCMs7C3CHcOwhEk/
         LFbTNtO5hOplzMfNTBudFfo0A7gXQ6i9I1WiZm+7ed8Uczm5K1RiMPl7JAbTWzfIsKfy
         GpEbP5hoXikJhOxOaqU965ftBKKxO4sU0eq0TQ5h5JKR6ccTO8NC+1dOgQd0zLD8Bu2e
         CgIZu/omQhZ/nUXMwLB9epiazfZaJbGGGoCsJOv3kIU2catlECl7NuZx3yRzRDS7Q6WX
         MtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLo1zUU46LmESvRDG8CVbF8q0iwxbn/Du3MzxOLzph8=;
        b=ZI3qiPD1h7SU2L7aDbABwHYMjjIM7j3hHQI7opKl8jdaOYhVcJ1kFI3XZQ1cazagni
         FOenZy64xgaYorceJ3dLQ0Q+bDLBq4JPixWwIz+eXqPxGH8OlHSOlUBp1tPjm7tVELZB
         eC5vcgDNHWmftrgLzQ5OO7/rDI9DCnCnqrBxojtPaYy0D4Fx6OLCPfJ1OzXMEEovk8H7
         Wh73sKIxWpcd1XeOy1fSsXTvuBq7o+0AYOeczY1JrkSNp+lCQODzvfaRg71S+FHESdTL
         zuDXy7uvy3+DSGDlT8Xf+iBlOp5HIjw+/QwpvaHL1zCW0/ReEJKY/O2ceM3YRwrR6Ibo
         qj6A==
X-Gm-Message-State: AO0yUKWXnlDgmiLD0RtxCfzl8RfLkBdfMQHzl2CFPw14gaRqTzKh/uRP
        f5GFjpamZgKcwE03Bijsrv4FTQgELyA=
X-Google-Smtp-Source: AK7set8gAXKCOm2kYpcoyR5SIDQDwgaBXTii3yc/CZBay7DCD3br+DAVls/YTlnCfmVnfeRM8MY+Kw==
X-Received: by 2002:a5d:568c:0:b0:2c7:478:d1d9 with SMTP id f12-20020a5d568c000000b002c70478d1d9mr17860182wrv.33.1677511703561;
        Mon, 27 Feb 2023 07:28:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2-20020adfdd02000000b002c3f03d8851sm7465019wrm.16.2023.02.27.07.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:28:22 -0800 (PST)
Message-Id: <8ffdb6c8a8a3b162c898ba759137d41bbfd44b39.1677511700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
References: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
        <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 15:28:09 +0000
Subject: [PATCH v3 02/13] unpack-trees: heed requests to overwrite ignored
 files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When a directory exists but has only ignored files within it and we are
trying to switch to a branch that has a file where that directory is,
the behavior depends upon --[no]-overwrite-ignore.  If the user wants to
--overwrite-ignore (the default), then we should delete the ignored file
and directory and switch to the new branch.

The code to handle this in verify_clean_subdirectory() in unpack-trees
tried to handle this via paying attention to the exclude_per_dir setting
of the internal dir field.  This came from commit c81935348b ("Fix
switching to a branch with D/F when current branch has file D.",
2007-03-15), which pre-dated 039bc64e88 ("core.excludesfile clean-up",
2007-11-14), and thus did not pay attention to ignore patterns from
other relevant files.  Change it to use setup_standard_excludes() so
that it is also aware of excludes specified in other locations.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2021-checkout-overwrite.sh | 11 +++++++++++
 unpack-trees.c                |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite.sh
index baca66e1a31..034f62c13c5 100755
--- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -69,4 +69,15 @@ test_expect_success SYMLINKS 'checkout -f must not follow symlinks when removing
 	test_path_is_file untracked/f
 '
 
+test_expect_success 'checkout --overwrite-ignore should succeed if only ignored files in the way' '
+	git checkout -b df_conflict &&
+	test_commit contents some_dir &&
+	git checkout start &&
+	mkdir some_dir &&
+	echo autogenerated information >some_dir/ignore &&
+	echo ignore >.git/info/exclude &&
+	git checkout --overwrite-ignore df_conflict &&
+	! test_path_is_dir some_dir
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 3d05e45a279..4518d33ed99 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2337,7 +2337,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
-		d.exclude_per_dir = o->dir->exclude_per_dir;
+		setup_standard_excludes(&d);
 	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
 	dir_clear(&d);
 	free(pathbuf);
-- 
gitgitgadget

