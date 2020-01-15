Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A042BC32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72859207E0
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih/eJbKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgAOUZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:25:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43303 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgAOUZt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 15:25:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so17013511wre.10
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 12:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=gOiqA0/O6apXtHcHA8d2GBSYg4paUgz953Vy1XSbM9c=;
        b=Ih/eJbKplhj3TvJW4mprqXRG6yCpxmcrL8NwQA6d6WPmZ67lGlFsNNyoWDzURs2LgR
         boqo6FuJxGxpRU4eJKZVr4NTvxIl5JAmLiulR+D/jdIgAZsilu9U2juSDCyyoA2hEB4c
         6IJdGrXxBIVbW8+MEX4/6LS9cAiwYkBAedtvrIbKw/h1y8tYBWCDw0eSld/J4xmD8NTm
         LUfHkopuG/EOySPAIxtY1LDCFQ2jW/IyhHYg+xXbZ+ygDcEMlDQahBe6SSVKy00alwz1
         EfAcz0ZOTSkQF8WgywmVH6ArwsXiKRPef1Al1uBAj6+73HmMYQJ+vIq3Bs0XnowbFgLY
         pi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gOiqA0/O6apXtHcHA8d2GBSYg4paUgz953Vy1XSbM9c=;
        b=ruKMou3LwbGfsT7Kkgx8TJQUAxlF6cCV72o+65mf/UZC9x/2/m98ghRPo1XS3mlIRC
         po5SGIwh7nnZbx6USRR1TqltAKzVrqyQ5JXTxrrqhm1Vm3c3G5Eh6f2FEoUWxEKtT+Cp
         pYvteRFdsylWSI3En6lO428bJnT/4UxMxQj6zJYmfy5c5qAftfn2hnzFijpocmsoEFkA
         jJD6mPOYALJrHi2nSiZkVCsJtkUEvT9rh29I2plsGYQPBjIxurRj3X6sAiE1VLo9zeRU
         T8eFCZYuY6LO4fFtyS9BAfBLtbJmLkVpAGArsIqEpBsyyHCMj30jl6uJhuEGBEsKzqvr
         mzLw==
X-Gm-Message-State: APjAAAVWC7YRB3zjHduqZukGLu2nctTwfEO4iaaQscyKgb5BwT1FdxIT
        Kybql4qIhHD+vA70kAcA/B2SVodk
X-Google-Smtp-Source: APXvYqwu6LwAGv/nyIFgCRCULI8em+bwlpe9yaKG86uHteQUKvaT8uUY2xy1yaxU34CoGxasv/uSHQ==
X-Received: by 2002:adf:ee45:: with SMTP id w5mr32266512wro.352.1579119947161;
        Wed, 15 Jan 2020 12:25:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm25759979wrq.22.2020.01.15.12.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:25:46 -0800 (PST)
Message-Id: <pull.526.git.1579119946211.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jan 2020 20:25:45 +0000
Subject: [PATCH] clean: demonstrate a bug with pathspecs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin.Willford@microsoft.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

b9660c1 (dir: fix checks on common prefix directory, 2019-12-19)
modified the way pathspecs are handled when handling a directory
during "git clean -f <path>". While this improved the behavior
for known test breakages, it also regressed in how the clean
command handles cleaning a specified file.

Add a test case that demonstrates this behavior. This test passes
before b9660c1 then fails after.

Helped-by: Kevin Willford <Kevin.Willford@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    clean: demonstrate a bug with pathspecs
    
    While integrating v2.25.0 into the microsoft/git fork, one of our VFS
    for Git functional tests started failing. Looking into it, the only
    possible place could have been where one of our integration points with
    the virtualfilesystem hook was moved by c5c4edd (dir: break part of
    read_directory_recursive() out for reuse, 2019-12-10) and then used in
    the following two commits.
    
    By reverting these two commits, we stopped the failure, but it took a
    while before figuring out that it was a regression in Git and not a
    failure in our integration to the new logic. Thanks to Kevin Willford
    for producing a test case.
    
    b9660c1 (dir: fix checks on common prefix directory, 2019-12-19) is the
    culprit, so this patch is based on that. If rebased to c5c4edd, then the
    test passes.
    
    As for actually fixing this regression, I don't know how. This code is
    pretty dense and I don't have a firm grasp of what is happening in both
    b9660c1 and the following 777b420 (dir: synchronize tread_leading_path()
    and read_directory_recursive()). Elijah is CC'd in case he still has
    context on this area.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-526%2Fderrickstolee%2Fclean-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-526/derrickstolee/clean-bug-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/526

 t/t7300-clean.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 6e6d24c1c3..782e125c89 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -737,4 +737,13 @@ test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
 	test_i18ngrep "too long" .git/err
 '
 
+test_expect_failure 'clean untracked paths by pathspec' '
+	git init untracked &&
+	mkdir untracked/dir &&
+	echo >untracked/dir/file.txt &&
+	git -C untracked clean -f dir/file.txt &&
+	ls untracked/dir >actual &&
+	test_must_be_empty actual
+'
+
 test_done

base-commit: b9670c1f5e6b98837c489a03ac0d343d30e08505
-- 
gitgitgadget
