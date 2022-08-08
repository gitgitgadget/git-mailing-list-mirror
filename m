Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C55C25B08
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 19:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbiHHTH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 15:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244191AbiHHTH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 15:07:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0929A5584
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 12:07:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso666389wmb.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=KmzkJanP+r7zmAbvFVV+dBLWZoBVdjJr9uFqVzfdDDA=;
        b=jHgGg6/1jfJgy/FD1jG6RJKOAnhxaEOdUYYjMXsKtfbK1jeb5S/q5wtDSwLIk4dm23
         UusV7MQCvmJ5twW20aUaHVwT3J5Kodvrj/FTHCRYCW2JKu1u29ymUekXx6uff22jY1Ww
         ob3ygk3qcM6+2024/AECVWSGdrAh/kDudfW09elxjWmmyFSQ5XxThxkOp7nynMVFjPjw
         zE2HgJpt0E628UwiBoIqmlt5SVmCZ0Jhn4O/jY3mZwSIQ/UAm2uvb6jgJ3UzrAhCgYdI
         diRUK7ZG4gg+53HHazNGYAswj3FI5RVwqJXmJBX3vP5YKGvF5RyagHlMjTnF7bu1b/Zz
         4N7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=KmzkJanP+r7zmAbvFVV+dBLWZoBVdjJr9uFqVzfdDDA=;
        b=uwXtsOcjteqPy2ECIlbJfpuebJDOb3+9zusBnJFyr2Lrl32i8lyIIwVHTG/ldxN1qY
         nehrONq0AjPgUfOOEpAMwx86DFjS4hNFBuUIs7QhS3ep4SN/jMKFDZZtp5mBpoyLHSxY
         RVCvmUXvejTzBLmDfcGfEs7Bl+NcgTSMrFMGHdoDhY8M58xHwYVs+dNG+XbEA79zFPYF
         bel6s/tO2Xq+Jlm0A9DA7ymUNp9RvwLJl5HCgt6iQGd5XUUTHjy6v4QgBDAhmkIPe02m
         baBF7oWihPPDmPmZ4L6UcZ1qaH5MKrdb1ycR+qaL0GTe+7c12Mo5kYtFf+RTe+ccZc9C
         PkRQ==
X-Gm-Message-State: ACgBeo3hsFdZE0U/2y8Co237dOU3zecdKL03RUSAknepaDoI0Cc0Yy7K
        cTnZvLRv/LTYHUpiz0vZ+FaKyF4HYzM=
X-Google-Smtp-Source: AA6agR4dNjh/AVRgVjotmFxQwksOav3jMXs5CIr/FIqE0qMUfidgwe7NUk8wljrBQqntIhfUMsP2hQ==
X-Received: by 2002:a05:600c:5123:b0:3a3:2543:be80 with SMTP id o35-20020a05600c512300b003a32543be80mr18311148wms.155.1659985675227;
        Mon, 08 Aug 2022 12:07:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j42-20020a05600c1c2a00b003a30c3d0c9csm20433402wms.8.2022.08.08.12.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 12:07:54 -0700 (PDT)
Message-Id: <255318f4dc61daef3e892a4dd5c571463985f340.1659985672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.v3.git.1659985672.gitgitgadget@gmail.com>
References: <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
        <pull.1312.v3.git.1659985672.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 19:07:49 +0000
Subject: [PATCH v3 1/4] checkout: fix nested sparse directory diff in sparse
 index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, shaoxuan.yuan02@gmail.com,
        newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add the 'recursive' diff flag to the local changes reporting done by 'git
checkout' in 'show_local_changes()'. Without the flag enabled, unexpanded
sparse directories will not be recursed into to report the diff of each
file's contents, resulting in the reported local changes including
"modified" sparse directories.

The same issue was found and fixed for 'git status' in 2c521b0e49 (status:
fix nested sparse directory diff in sparse index, 2022-03-01)

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/checkout.c                       | 1 +
 t/t1092-sparse-checkout-compatibility.sh | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 29c74f898bf..f9d63d80b92 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -626,6 +626,7 @@ static void show_local_changes(struct object *head,
 	repo_init_revisions(the_repository, &rev, NULL);
 	rev.diffopt.flags = opts->flags;
 	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
+	rev.diffopt.flags.recursive = 1;
 	diff_setup_done(&rev.diffopt);
 	add_pending_object(&rev, head, NULL);
 	run_diff_index(&rev, 0);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 763c6cc6846..99a1425a929 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -372,6 +372,14 @@ test_expect_success 'deep changes during checkout' '
 	test_all_match git checkout base
 '
 
+test_expect_success 'checkout with modified sparse directory' '
+	init_repos &&
+
+	test_all_match git checkout rename-in-to-out -- . &&
+	test_sparse_match git sparse-checkout reapply &&
+	test_all_match git checkout base
+'
+
 test_expect_success 'add outside sparse cone' '
 	init_repos &&
 
-- 
gitgitgadget

