Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9377C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 23:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhKSXGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbhKSXGu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 18:06:50 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E43C06173E
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so20600003wru.13
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uQJ4Fsl7CqY1kSfF5905tSksE/gGYx0P1d+aDxCpFio=;
        b=dE8INfGTJbaMu0hrTC+1laKVhYVbwHYiWa/dQBYmZIZD1j09mSJU4cUU0f2/cfrQQ7
         zKEPLDeILDujDH4KqDrh4D7ldCJBJkwXBqgFTUJLd7KncgXpz44aQNMSqe71riS7con3
         cD8OwlRdtwIMu4vsqt12uiBrq/dRb8X+hnAk0PcclZDIYPNrzKM75HaymHeMxn56YvyV
         B37ubKTuFn9hMFKRMNKR+XVnxxgOOXcz7WF7ta9MM0VjL02KNwfJzfSQT/OgUNZv3BXC
         XN2dMY5u83xQ3cBvLS/7tWgCJQl3cFjQ7+2Z4jy9NE+pcvg4OBC82O2B7yOz66Qv5goh
         JhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uQJ4Fsl7CqY1kSfF5905tSksE/gGYx0P1d+aDxCpFio=;
        b=mPfRPfbRAgOLnWne2zXILtXIToUMF9xPi3b3HHzOJzYxG3eltDs/eVG1nK8vgimcB3
         1zwsPNqPpOA0ngEOJwluiL3vDgrNLzGe0WXPWa6OYD1f8YTYCRy4m6mym/4NQddSk4P4
         B9kLxlpD47kicLyoWtRmgLw7jnVmRkbgzJUO6SA/Z1tbTGjFJcL+9JrGyi3BFUjMpN7Y
         akpC10k7s8tzUy2jX9R3vQTSG4/sFdcN1Ii7RmfBJdvLBzyxfT7wwBAP26V1K+5CA6WV
         Y3bdWEXDeHhZSCitq5yE0lqrMiJPe/ds9IRARdCFej67mSLnm6uWUxrNIrXX9XAKma/R
         IHnA==
X-Gm-Message-State: AOAM532rbi0c7uD/Z4iP2R4y7MTAdsyWeXxrdR+bVdjcN6EvtUXDGG40
        gvzy86uSY+RHC+TxrTORdCRP8RMC/qY=
X-Google-Smtp-Source: ABdhPJwF+ezmDkBeT+GD0ViYp+jnrv51xxijaX1EyCdsOQFaT84aKjfwb88uOIy8XwkjC0/WX9oEDw==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr12031963wri.343.1637363026468;
        Fri, 19 Nov 2021 15:03:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l124sm13916383wml.8.2021.11.19.15.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 15:03:46 -0800 (PST)
Message-Id: <3a2e28275f112d114bbd3ba046f440c5f917fc32.1637363025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
        <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 23:03:28 +0000
Subject: [PATCH v8 01/17] scalar: add a README with a roadmap
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
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Scalar command will be contributed incrementally, over a bunch of
patch series. Let's document what Scalar is about, and then describe the
patch series that are planned.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/README.md | 82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 contrib/scalar/README.md

diff --git a/contrib/scalar/README.md b/contrib/scalar/README.md
new file mode 100644
index 00000000000..634b5771ed3
--- /dev/null
+++ b/contrib/scalar/README.md
@@ -0,0 +1,82 @@
+# Scalar - an opinionated repository management tool
+
+Scalar is an add-on to Git that helps users take advantage of advanced
+performance features in Git. Originally implemented in C# using .NET Core,
+based on the learnings from the VFS for Git project, most of the techniques
+developed by the Scalar project have been integrated into core Git already:
+
+* partial clone,
+* commit graphs,
+* multi-pack index,
+* sparse checkout (cone mode),
+* scheduled background maintenance,
+* etc
+
+This directory contains the remaining parts of Scalar that are not (yet) in
+core Git.
+
+## Roadmap
+
+The idea is to populate this directory via incremental patch series and
+eventually move to a top-level directory next to `gitk-git/` and to `git-gui/`. The
+current plan involves the following patch series:
+
+- `scalar-the-beginning`: The initial patch series which sets up
+  `contrib/scalar/` and populates it with a minimal `scalar` command that
+  demonstrates the fundamental ideas.
+
+- `scalar-c-and-C`: The `scalar` command learns about two options that can be
+  specified before the command, `-c <key>=<value>` and `-C <directory>`.
+
+- `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
+
+- `scalar-and-builtin-fsmonitor`: The built-in FSMonitor is enabled in `scalar
+  register` and in `scalar clone`, for an enormous performance boost when
+  working in large worktrees. This patch series necessarily depends on Jeff
+  Hostetler's FSMonitor patch series to be integrated into Git.
+
+- `scalar-gentler-config-locking`: Scalar enlistments are registered in the
+  user's Git config. This usually does not represent any problem because it is
+  rare for a user to register an enlistment. However, in Scalar's functional
+  tests, Scalar enlistments are created galore, and in parallel, which can lead
+  to lock contention. This patch series works around that problem by re-trying
+  to lock the config file in a gentle fashion.
+
+- `scalar-extra-docs`: Add some extensive documentation that has been written
+  in the original Scalar project (all subject to discussion, of course).
+
+- `optionally-install-scalar`: Now that Scalar is feature (and documentation)
+  complete and is verified in CI builds, let's offer to install it.
+
+- `move-scalar-to-toplevel`: Now that Scalar is complete, let's move it next to
+  `gitk-git/` and to `git-gui/`, making it a top-level command.
+
+The following two patch series exist in Microsoft's fork of Git and are
+publicly available. There is no current plan to upstream them, not because I
+want to withhold these patches, but because I don't think the Git community is
+interested in these patches.
+
+There are some interesting ideas there, but the implementation is too specific
+to Azure Repos and/or VFS for Git to be of much help in general (and also: my
+colleagues tried to upstream some patches already and the enthusiasm for
+integrating things related to Azure Repos and VFS for Git can be summarized in
+very, very few words).
+
+These still exist mainly because the GVFS protocol is what Azure Repos has
+instead of partial clone, while Git is focused on improving partial clone:
+
+- `scalar-with-gvfs`: The primary purpose of this patch series is to support
+  existing Scalar users whose repositories are hosted in Azure Repos (which
+  does not support Git's partial clones, but supports its predecessor, the GVFS
+  protocol, which is used by Scalar to emulate the partial clone).
+
+  Since the GVFS protocol will never be supported by core Git, this patch
+  series will remain in Microsoft's fork of Git.
+
+- `run-scalar-functional-tests`: The Scalar project developed a quite
+  comprehensive set of integration tests (or, "Functional Tests"). They are the
+  sole remaining part of the original C#-based Scalar project, and this patch
+  adds a GitHub workflow that runs them all.
+
+  Since the tests partially depend on features that are only provided in the
+  `scalar-with-gvfs` patch series, this patch cannot be upstreamed.
-- 
gitgitgadget

