Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4C6C433FE
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 15:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1BD363214
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 15:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbhKPPlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhKPPlE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 10:41:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF5C061746
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 07:38:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso2336429wms.3
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 07:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZTm/lMC1VdsYogwRtfWJz19TAr59chbjv/gs74DRcYI=;
        b=WWRLoETu3CRLozbUm7QbZjtTCpbrenUW3x+dzGA2gtfhiwpuYkIriA2iHf2zU142Ei
         CIPMQvr9SWHOaMYWQuovm8bJLgp4VhgAI1yGqs5y3T4LvKLacTYZ9mOZ0QzBycs8MBSG
         RqsvCLlEseCx3/oYsjAqAQjCfcCEhXnAb+A8ajUEiuRqjcjKaZ73ntECHt2Q/pA4CX8c
         DWWte0uG9LK8o86epHOnw9sg7tPf15XVTuUuA1jJnGA+RNBc0R2giA9PI0LVy0f5KSui
         jV7vaTSBz1F551Zti/HSCy1TkCmIYtB03bC+h16EkhNBbHhiGVtj4SUknW+AZetkhh7+
         tbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZTm/lMC1VdsYogwRtfWJz19TAr59chbjv/gs74DRcYI=;
        b=MwHWGzBX5V+9Dk3qIXJHh8BU+DP6zR4ub4qEbesVRaXggntnAZUrhgaM5DodrtQO93
         gWDjqo4wgSsttec915QOrgrUEfgDkfDx+iysnffUS7vUmolZ6NYEZ81ZAZHciOY4nilH
         h1KqQMNJsjtZ6Z2jS7quqUrdf7v/ROj84Hjke4lX0gkSy5d4Bs3vOu3w53vxBchcZOxI
         t/m90061llCm/8AdIhr7jvNG2SzNQ21LAKbXYKSlbWOMxFnR7VwS7IoPMBdSw1wpmXQx
         qQg37DgANZs0sTkaD5NTmYN++fc8Ymggf9V7EPLFSonx+25uVxWFe1Cg8mTgo5H+gzT4
         GoXA==
X-Gm-Message-State: AOAM533czAyNyJM9/OKbRjPbYhG0b7pBZRp7z+fpJkfljFAUYYJ1YkvO
        RYacVsKMaUVuZRcN/2OdU7iuvX2/O3s=
X-Google-Smtp-Source: ABdhPJy+kdhRYAP+nxHe+3GP+WW0El61KeVbJGBThanDiRmFblRC2BIvmYV7O3hXAXgxoiwrW4c3YQ==
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr70240642wmq.26.1637077084750;
        Tue, 16 Nov 2021 07:38:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm17715160wrt.49.2021.11.16.07.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 07:38:04 -0800 (PST)
Message-Id: <451056e1a77893374ec07509f25d35c11eae59b7.1637077083.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 15:38:01 +0000
Subject: [PATCH 1/2] fetch/pull: use the sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git fetch' and 'git pull' commands parse the index in order to
determine if submodules exist. Without command_requires_full_index=0,
this will expand a sparse index, causing slow performance even when
there is no new data to fetch.

The .gitmodules file will never be inside a sparse directory entry, and
even if it was, the index_name_pos() method would expand the sparse
index if needed as we search for the path by name. These commands do not
iterate over the index, which is the typical thing we are careful about
when integrating with the sparse index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/fetch.c                          |  2 ++
 builtin/pull.c                           |  2 ++
 t/t1092-sparse-checkout-compatibility.sh | 10 ++++++++++
 3 files changed, 14 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f7abbc31ff1..1696b7791d4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1993,6 +1993,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	}
 
 	git_config(git_fetch_config, NULL);
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
diff --git a/builtin/pull.c b/builtin/pull.c
index 127798ba84e..9f6174f4433 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -993,6 +993,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		set_reflog_message(argc, argv);
 
 	git_config(git_pull_config, NULL);
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index d75f64aad56..f8a8dde60af 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -932,6 +932,16 @@ test_expect_success 'sparse index is not expanded: blame' '
 	ensure_not_expanded blame deep/deeper1/deepest/a
 '
 
+test_expect_success 'sparse index is not expanded: fetch/pull' '
+	init_repos &&
+
+	git -C sparse-index remote add full "file://$(pwd)/full-checkout" &&
+	ensure_not_expanded fetch full &&
+	git -C full-checkout commit --allow-empty -m "for pull merge" &&
+	git -C sparse-index commit --allow-empty -m "for pull merge" &&
+	ensure_not_expanded pull full base
+'
+
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 # in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
-- 
gitgitgadget

