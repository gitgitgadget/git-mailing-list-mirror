Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB2DEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjFZQ0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjFZQZN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180361707
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fa8692a006so26957355e9.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796709; x=1690388709;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c24uSQ9nKgDHUqXbXwvgV+/kOTkn9VdgClatDZCr/fs=;
        b=GJw0309GGW+TWHYQ6cLbkE8RS29X1rJjS2d50RJkNUukbQp4Jprvj5orvuEq3g+tue
         d8uHFhUsH4Bd/LgfFscAvw9t4J2XKZPhXBiLPvELEYSkHnkk5Xnwg2eeBE/vPI1RQoqb
         l9WBMJUSZ8tD7+sxujJcYU0KuvMWXD4igd4sBvJEm4btVblEqS8AWg/OTvmx+HYd2r4q
         lvg5eWiwsbLqxcq4Jx+W7sY4cNiENR690gHszJ0VmX8XMTn0XsQikDSxQpvGT+/pbnkf
         UFjfFTtNyeXgHhJaeit4V+PW5PFQSl78XsKDQLLxOFSBGqDWBhmdwQssPMgHyJLo6pxy
         MYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796709; x=1690388709;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c24uSQ9nKgDHUqXbXwvgV+/kOTkn9VdgClatDZCr/fs=;
        b=Avy4MuiznuDw2vbKl6hVruNfQJxrd3r86ZW4n4SKcv8gHXV6vc5FuBB79Jq8osLkpO
         ai+alUBwLSO0yRUt7hhdGKwjxRgcn4HgEcUA4v/T9V1qGNTwtHyaThsOxsXAyGNyOqHc
         gTfSqNj5icd9E3KuXCME0m/QZMrqC/5lj2SxL3TFhTg0Wq6Jb8FibNkYtn12hDpzqbBG
         8Ubm6y5zXDnqu/VYFsZuemmzDF1vPzmzLtWQiYTlgIcEUc+pB+LaAX0AB24cviH5HSYO
         Bh1R/p8oRT+oR97RgcN/7gg2QoNJ4P3+ATzIJlylLi+/AQqWwHSYdPsG3+qYhY4pfsxk
         a9lw==
X-Gm-Message-State: AC+VfDw550upHwnbd3XL53qgO5bDVXo+vF3jkXgO/jGK+/h8rdCgswni
        x8+/xXj5v0pedlJ786z33z5zDaVDJWc=
X-Google-Smtp-Source: ACHHUZ7gsAe51THuE19LZKVlRL0wj7ZSugG/BQNROjItWx2WT6yRRDApfQA4KpNVnd8xMMyFIXqpYg==
X-Received: by 2002:a1c:ed0b:0:b0:3f7:948f:ad1c with SMTP id l11-20020a1ced0b000000b003f7948fad1cmr23990771wmh.6.1687796709223;
        Mon, 26 Jun 2023 09:25:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k26-20020a7bc41a000000b003f080b2f9f4sm11102999wmi.27.2023.06.26.09.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:08 -0700 (PDT)
Message-Id: <47e81c2add6bad8ca5adf40fb13935bb1e5fd533.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:48 +0000
Subject: [PATCH v3 24/24] diff.c: mention completion above add_diff_options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Add a comment on top of add_diff_options, where common diff options are
listed, mentioning __git_diff_common_options in the completion script,
in the hope that contributors update it when they add new diff flags.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 diff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/diff.c b/diff.c
index 3c88c37908d..64c93c0f0e2 100644
--- a/diff.c
+++ b/diff.c
@@ -5491,6 +5491,10 @@ static int diff_opt_rotate_to(const struct option *opt, const char *arg, int uns
 	return 0;
 }
 
+/*
+ * Consider adding new flags to __git_diff_common_options
+ * in contrib/completion/git-completion.bash
+ */
 struct option *add_diff_options(const struct option *opts,
 				struct diff_options *options)
 {
-- 
gitgitgadget
