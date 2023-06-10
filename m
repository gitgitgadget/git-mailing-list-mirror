Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90ACC7EE2E
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjFJUVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjFJUVe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05E63AB3
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30ae901a9ffso2674369f8f.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428487; x=1689020487;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfh2VMkOGYUvE4AgBkzqydrO8d9hs/sP/UEVum3BtSI=;
        b=Er6HbmG4iqyD5Md5vjMVbocKSCHnFpF0fsQmQizZFU8O3YkvueTcQh/kaVNwsnlZfr
         z2Dlx5RybVjgJ9FrQb8z0DXc5uDl/NzScdtEtzrSBwhS6RH51Lp/jZuZQmxXXXT6jKwj
         DyQfGZf31Vb1Ts30PVZhIlnphWuC/H3oQSAuMcPXQuhNP3HOizCn/l8S+Rtyh6KcsLsq
         icHDZOyA5H+unxEwM/Ew2jZlTWX+6JBZDHdacFj/o8TbjqNHdOSESBM+F5m0/zMMyFLf
         Kf/CWZz1hEYCksymmoWZaZgSEwsIFT8yJunbmsZmUFpJ6eNitYMEL5oTxSS8B46i6nVI
         aZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428487; x=1689020487;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfh2VMkOGYUvE4AgBkzqydrO8d9hs/sP/UEVum3BtSI=;
        b=Q5m0S0bl+N5vL6/3140VG6PvxgOs/MFFx3WlS5VbyZtTyvWuoaglEaH3RBCyjIPdyN
         qOG8+otKquhJHlEBXtPAU96CmSbphqeZvhC/92aqaEzwz5tz2W7BOq3gA2+Wn8GNWqU1
         R5KztGWj7Isjg8nK1uKFjqN00zHZ3fFcLKq+VPwFAQMdHZKIaGpoRAAPAX0+gzrm+/BO
         791FGxRkdqE/Z8E/0Wep3lpOE1XngWMEWoxdPGz8HGf0ba4BBG+KmGyE7ueUM8cLEDx/
         yd+BoKdAKBkRGMxWbyC0WL0+f6MS/PtTJbx1w5FMzN7J+vZeuOODiWzliLrLNGfV6s2/
         ulDA==
X-Gm-Message-State: AC+VfDyBPDXnErrWPSqQYzslRZ776vLE3Lanl5lMWkaim/XiJLOcWfAG
        Zjxdztqv+bYIy+ULDcEfxb+/zB9wGak=
X-Google-Smtp-Source: ACHHUZ6P4ZsNNV661LF7tqG+7u0C9o+khctd+MloexmpTgkwuhKtM7cQoOcNqXKcNSxKqmGE0Udo9Q==
X-Received: by 2002:a5d:5486:0:b0:306:2c5b:9da6 with SMTP id h6-20020a5d5486000000b003062c5b9da6mr1828222wrv.56.1686428486870;
        Sat, 10 Jun 2023 13:21:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i1-20020adfefc1000000b0030647449730sm7975030wrp.74.2023.06.10.13.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:26 -0700 (PDT)
Message-Id: <4edabc7f15c3ad55c911919bec5a406bb48ad0ee.1686428484.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:00 +0000
Subject: [PATCH 01/25] completion: add comments describing __git_diff_*
 globals
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Add descriptive comments for '__git_diff_common_options' and
'__git_diff_difftool_options', so that it is clearer when looking at
these variables to know in which command's completion they are used.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dc95c34cc85..90fe292459b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1733,6 +1733,7 @@ __git_color_moved_opts="no default plain blocks zebra dimmed-zebra"
 __git_color_moved_ws_opts="no ignore-space-at-eol ignore-space-change
 			ignore-all-space allow-indentation-change"
 
+# Options for the diff machinery (diff, log, show, stash, range-diff, ...)
 __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch-with-stat --name-only --name-status --color
 			--no-color --color-words --no-renames --check
@@ -1757,6 +1758,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--anchored=
 "
 
+# Options for diff/difftool
 __git_diff_difftool_options="--cached --staged --pickaxe-all --pickaxe-regex
 			--base --ours --theirs --no-index --relative --merge-base
 			$__git_diff_common_options"
-- 
gitgitgadget

