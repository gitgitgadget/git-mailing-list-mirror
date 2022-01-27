Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB65C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 22:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242109AbiA0WD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 17:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241948AbiA0WD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 17:03:56 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1536BC06173B
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 14:03:56 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id s18so7227077wrv.7
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 14:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IQ5jWY+xYlcNn4NI1yM8DBqVyn55ObKSQu1zGQxHLuI=;
        b=J8fWzEfH6lUr/BCWKYXJJ6TdGthvoEeHWITUSqNHxgPpizjd2E9FOO9u0StCem7pys
         0hJ5vOT3D8QiP2rYgnbhgb6XzExJauoUGHCHIYgKCBlFqmdKyTzCN8eCsQI+AbEfsBEd
         tyMFn96Vg271w9qJIAtJDIENcSpQMWwk2xGF6XmcFEVs5OPXQcFACRvb1pav4Mzgku05
         OqsGZKjbHbKzLQWPYIz4i18DF3pUb93HnPB2rkDTCZPD0URBkBcgyD/BVNp3oKtES0vW
         0HqWceyG29By920vbzllBN2lXvIsY3wtF/u4UafNNRVbTafwpqVZAKOpkSJFclMNRVpG
         IrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IQ5jWY+xYlcNn4NI1yM8DBqVyn55ObKSQu1zGQxHLuI=;
        b=O3yYzhbmWAbbIM6euRw+ghaurolIPX9tvEdlu9qj2fDEL8MrUFqdqOGAuijg1UPehM
         iER+07bkcOYX9OBHodY0j8F2w7W2YoOpBsxyjI8+VFvhVAKEPtkOv7Fxugvu13RU41mK
         qTp9YakBXopPly/aRDDpKcpXdQCFmrMQhs7yWxZjvoGu7x+UUD6Eal8bIbhInR15eE1o
         9bI1n8HS6xfPngt5APaeOc0y11Y/GT95AVPhBMmOX5mn5qlCdSAzy6VVrqVrNgGySbHv
         HxQjdT/pOylLqQ2ZZub+zJOrG+eCVYcCf46i7c6XJHpdnAGGdgNha6nTjFmhNFyFHcE/
         gaiQ==
X-Gm-Message-State: AOAM533CfV9VYFQGMvMXbAW3EKPyylAveEpMGYGAXNezHLjuytFPpjkE
        iIXjM7QiUmGAtaJRci7uJQq1GJj/0vk=
X-Google-Smtp-Source: ABdhPJzu4IQB34nqiQFukbdx2wSaD61x5qxd0FDDBX5FGKe1nXvY9Vgw/uXwECbt/IlsKiiFB6Tw5A==
X-Received: by 2002:a05:6000:1ac8:: with SMTP id i8mr4538465wry.136.1643321034552;
        Thu, 27 Jan 2022 14:03:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4sm3612971wrd.111.2022.01.27.14.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 14:03:54 -0800 (PST)
Message-Id: <0e6625fed2a8d1c7c842234e946af19c69950eb7.1643321031.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1133.git.1643321031.gitgitgadget@gmail.com>
References: <pull.1133.git.1643321031.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 22:03:49 +0000
Subject: [PATCH 2/4] add: remove support for `git-legacy-stash`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 90a6bb98d11 (legacy stash -p: respect the add.interactive.usebuiltin
setting, 2019-12-21), we added support to use the built-in `add -p` from
the scripted `stash -p`.

In 8a2cd3f5123 (stash: remove the stash.useBuiltin setting, 2020-03-03),
we retired the scripted `stash` (including the scripted `stash -p`).

Therefore this support is no longer necessary.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/add.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 84dff3e7969..3ffb86a4338 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -32,7 +32,6 @@ static int add_renormalize;
 static int pathspec_file_nul;
 static int include_sparse;
 static const char *pathspec_from_file;
-static int legacy_stash_p; /* support for the scripted `git stash` */
 
 struct update_callback_data {
 	int flags;
@@ -388,8 +387,6 @@ static struct option builtin_add_options[] = {
 		   N_("override the executable bit of the listed files")),
 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
 			N_("warn when adding an embedded repository")),
-	OPT_HIDDEN_BOOL(0, "legacy-stash-p", &legacy_stash_p,
-			N_("backend for `git stash -p`")),
 	OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
 	OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 	OPT_END(),
@@ -512,17 +509,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--interactive/--patch");
 		exit(interactive_add(argv + 1, prefix, patch_interactive));
 	}
-	if (legacy_stash_p) {
-		struct pathspec pathspec;
-
-		parse_pathspec(&pathspec, 0,
-			PATHSPEC_PREFER_FULL |
-			PATHSPEC_SYMLINK_LEADING_PATH |
-			PATHSPEC_PREFIX_ORIGIN,
-			prefix, argv);
-
-		return run_add_interactive(NULL, "--patch=stash", &pathspec);
-	}
 
 	if (edit_interactive) {
 		if (pathspec_from_file)
-- 
gitgitgadget

