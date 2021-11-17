Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CA4C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F034161A79
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbhKQOW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238365AbhKQOWg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 09:22:36 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB41FC061202
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:33 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso4931873wmr.4
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8D4/O9BIeJDyx7UkKc8qSSrWGbYPXQcqw1HfHqLPa9c=;
        b=qRfzNiY5A+H60JN8L5xV8K3xES9+sg925F6K525z7v42jfVTuZSb3jpNnTJvBqDFK6
         nYVDCmkTyY87XH8yBeWXKRgAArSDr3lIJ7zRzcVXDfBJqwlf+aF52Uwvk1axdeLnvpF3
         pA+r17BvL1SL0UWkAAsv2UDEAkTPGI5rLC8bcAZdVJmB3ecElaWR8Jr6Prv4PWP4Xkwf
         ONsylAjgXaX2JULj5au5PIh/NsoU90eEAn1xfzpCLWl2aOD0KHKsvo11PNCZKZrYdDqk
         BU23vZhsW04fI4ydO/0BLhEt/VN0stky6lNTSZPk9IBDjnYb3fCcRfZ803MGBl2yLgD5
         H9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8D4/O9BIeJDyx7UkKc8qSSrWGbYPXQcqw1HfHqLPa9c=;
        b=lw+kx2iSS2cbqdpbYNhgTcAv2tO5jyqoS1Q9N7+q3mYE9G/U/bTgm8Jz13hVTpTIU9
         kBUAcPvcsP4dddV5sKwGVdUmJ5YfbhiUnQTcBTLzA1VVt3uHe3BOvxDiRIg498WxbVWZ
         fcsLstSNY5GxhWdF9XMXMrPeUHS7EtHgG5ukYwCP7vvOOkl+Jd4vHzh+JItDsg/rQzw5
         L6GfF2DcXJiHoWGkoRXPX8LSO4a3806+CBO1oSaYLUyb9wnQFVfmY3EnyNTjn1HBeku1
         YcLyCxqZDnPYtmAFSv7i1yuYk07shxUFTeMn+tc5fxOu+efYlyAMHvZ83tCCKHiJO+Ya
         MBfQ==
X-Gm-Message-State: AOAM531rLKQyaaYJaC85SsuvUtv4XbfO5AzwTq/OhzCK/MGhfL6HzhT1
        mSUCDj4bTqn+afV9ZgPNjeSbxlebDcI=
X-Google-Smtp-Source: ABdhPJy9HhBI2I8rAlDGleZOpSVfaaIPxlrSn/KfcRdvGwzTfM9aljjwlCsZ8Cbi7NHGLar4g7XRCw==
X-Received: by 2002:a1c:1b08:: with SMTP id b8mr67687wmb.28.1637158772248;
        Wed, 17 Nov 2021 06:19:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm7429314wmq.46.2021.11.17.06.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:19:31 -0800 (PST)
Message-Id: <d80627615f82051919ce3c5f89d2e42ce63ad8fd.1637158762.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
        <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 14:19:08 +0000
Subject: [PATCH v7 03/17] scalar: start documenting the command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Let's build up the documentation for the Scalar command along with the
patches that implement its functionality.

Note: To discourage the feature-incomplete documentation from being
mistaken for the complete thing, we do not yet provide any way to build
HTML or manual pages from the text file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.txt | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 contrib/scalar/scalar.txt

diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
new file mode 100644
index 00000000000..5f7131861a5
--- /dev/null
+++ b/contrib/scalar/scalar.txt
@@ -0,0 +1,38 @@
+scalar(1)
+=========
+
+NAME
+----
+scalar - an opinionated repository management tool
+
+SYNOPSIS
+--------
+[verse]
+scalar <command> [<options>]
+
+DESCRIPTION
+-----------
+
+Scalar is an opinionated repository management tool. By creating new
+repositories or registering existing repositories with Scalar, your Git
+experience will speed up. Scalar sets advanced Git config settings,
+maintains your repositories in the background, and helps reduce data sent
+across the network.
+
+An important Scalar concept is the enlistment: this is the top-level directory
+of the project. It usually contains the subdirectory `src/` which is a Git
+worktree. This encourages the separation between tracked files (inside `src/`)
+and untracked files, such as build artifacts (outside `src/`). When registering
+an existing Git worktree with Scalar whose name is not `src`, the enlistment
+will be identical to the worktree.
+
+The `scalar` command implements various subcommands, and different options
+depending on the subcommand.
+
+SEE ALSO
+--------
+linkgit:git-maintenance[1].
+
+Scalar
+---
+Associated with the linkgit:git[1] suite
-- 
gitgitgadget

