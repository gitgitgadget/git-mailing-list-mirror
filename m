Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7516C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 11:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbhKYLpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbhKYLm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 06:42:59 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8375FC0613FC
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 03:36:59 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v11so10917809wrw.10
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 03:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BoRC4SLUdHBgMFCmpUs4CTbpsRy44x811GAPAcmmqv8=;
        b=BuxnI73Ph7sf8vHkOVkT+7bCJKY4zr7nqhab5iB+CupOBXyZQx7PWfCHBG11CqH7yQ
         gj3zSENgUMsPYe42c5l1AsJv523ObLzT5SU1bHSfL2YqcP9rLJrRn98agcbrns6YY5km
         BddUvgUa7srAVhjHMPC1v6MjQxYsvAvUvp/1DeSHUvEjLJ0me0g8C1ANWOB250PgQipA
         GLEjYB9j0ugdiZ8/14HWpIB+Xu4hqVwjQFQ9n4DGa3Thbwwvvn3qYHm3WzGfdJ6YWjOa
         1epZp6KvNyW9lHNuIJMxozUM2m1WEhnR65YnK6a26r1nh73ESSPKXmOBowKES5gqNKsv
         SxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BoRC4SLUdHBgMFCmpUs4CTbpsRy44x811GAPAcmmqv8=;
        b=qe2ByPWrxpOkfhj1C0rkDpYnHXJmKKwgBcDQ2km1RCxHrLyFAXi+mt+K2Ko81HGg5D
         Ssuh6JDSnOjohfZw0p5WapEc6NGc1SeXcy9ARZqOTxgCdq2ppzCLr8R1Y9JbWJ3rtenL
         o+RkxcEjHqA/s+jpZRKMz+J2BAKC3TCSjmIf4hbdGqxsRSbWISm8Q8C2kL3b+Xskc/t7
         aJndLZT6i28gZn9r07kI2p8O0dNllgpZnur8aHOyPvOIgedJtL9/RumbZU/9MGtGBklU
         wJTVGhfye2E+h17PSVEamnL9qXWX4PtTyLj4wv1Jq62znkwsnBXvR77LkCICqppgL0lE
         7geQ==
X-Gm-Message-State: AOAM533gbcxgRR/tj8cnvN/sDO1Ii3Hnhjn+2qEbmLPkzs/5iQVi13io
        5I/rAOOk+xwXHUzd2P5/+JCETFW9txU=
X-Google-Smtp-Source: ABdhPJyUI9SZ7AUD8JuhVkQz7n2HxWpW3p/SN8eNGJwQNQc1hn845ZR6T9mD/Ejz0BND4rSJM6iY2g==
X-Received: by 2002:a5d:4904:: with SMTP id x4mr5737810wrq.139.1637840217866;
        Thu, 25 Nov 2021 03:36:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm2497868wrv.95.2021.11.25.03.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 03:36:57 -0800 (PST)
Message-Id: <pull.1146.git.git.1637840216877.gitgitgadget@gmail.com>
From:   "Mahdi Hosseinzadeh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 11:36:56 +0000
Subject: [PATCH] githubci: add a workflow for creating GitHub release notes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>,
        Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>

GitHub now allows users to subscribe only to
"release" notifications of a repository.
So, users can be notified of new releases and their
changelog/release notes automatically.

This workflow works whenever:
    a new version tag
    (with the format following the regex "v\d+\..*")
    is pushed to the repository
AND
    the commit that the tag points to, created/modified
    a release notes file from Doumentation/RelNotes/ directory.

The script for generating the temporary changelog file is
written in Kotlin language which can be a much better alternative
to shell scripts in terms of features and readability
(it is like a python script but with static typing support).
The Kotlin runner is pre-installed in GitHub Actions environments;
for more information see
    https://github.com/actions/virtual-environments/
    https://stackoverflow.com/a/69116750/8583692

The "Release Notes (yyyy-MM-dd)" link in https://git-scm.com/
website can also link to these GitHub release pages instead of
to the raw .txt release note file in the repository.

See the issue related to GitHub release notifications:
https://github.com/isaacs/github/issues/410

Also see GitHub announcement for this feature:
https://github.blog/changelog/2018-11-27-watch-releases/

Signed-off-by: Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>
---
    Add a workflow for creating GitHub release notes
    
    Because this is not directly the git code and is related to GitHub CI, I
    post it here.
    
    This pull request adds a new GitHub Actions workflow that automatically
    creates releases on GitHub repository when pushing a new tag to the
    repository.
    
    GitHub now allows users to subscribe only to "release" notifications of
    a repository. So, users can be notified of new releases and their
    changelog/release notes automatically.
    
    This workflow works whenever: a new version tag (with the format
    following the regex v\d+\..*) is pushed to the repository AND the commit
    that the tag points to, created/modified a release notes file from
    Doumentation/RelNotes/ directory.
    
    The script for generating the temporary changelog file is written in
    Kotlin language [https://kotlinlang.org/] which can be a better
    alternative to shell scripts in terms of features and readability (it is
    like a python script but with static typing support). The Kotlin runner
    is pre-installed in GitHub Actions environments; for more information
    see https://github.com/actions/virtual-environments/
    https://stackoverflow.com/a/69116750/8583692
    
    The Release Notes (yyyy-MM-dd) link in https://git-scm.com/ website can
    also link to these GitHub release pages instead of to the raw .txt
    release note file in the repository.
    
    See the issue related to GitHub release notifications:
    https://github.com/isaacs/github/issues/410
    
    Also see GitHub announcement for this feature:
    https://github.blog/changelog/2018-11-27-watch-releases/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1146%2Fmahozad%2Fadd-github-releases-workflow-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1146/mahozad/add-github-releases-workflow-v1
Pull-Request: https://github.com/git/git/pull/1146

 .../generate-github-changelog.main.kts        | 21 ++++++++++
 .github/workflows/create-release.yml          | 40 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 .github/scripts/generate-github-changelog.main.kts
 create mode 100644 .github/workflows/create-release.yml

diff --git a/.github/scripts/generate-github-changelog.main.kts b/.github/scripts/generate-github-changelog.main.kts
new file mode 100644
index 00000000000..e57fd2a6ae5
--- /dev/null
+++ b/.github/scripts/generate-github-changelog.main.kts
@@ -0,0 +1,21 @@
+#!/usr/bin/env kotlin
+
+/**
+ * Copies contents of the release notes file created/modified
+ * in this commit to a new file to be used by the workflow.
+ */
+
+import java.io.File
+
+println("Files modified in this commit:")
+args.forEachIndexed { index, name ->
+    println("\t${index + 1}- $name")
+}
+
+val notesFile = args
+    .map(::File)
+    .singleOrNull { "RelNotes" in it.parent }
+
+notesFile
+    ?.copyTo(File("changelog.txt"))
+    ?: println("No release notes file modified in this commit")
diff --git a/.github/workflows/create-release.yml b/.github/workflows/create-release.yml
new file mode 100644
index 00000000000..711ba105e42
--- /dev/null
+++ b/.github/workflows/create-release.yml
@@ -0,0 +1,40 @@
+name: Create GH release
+
+# Create a GitHub release for each new tag.
+# The release notes are taken from the release notes file
+# modified in that commit located in Documentation/RelNotes directory.
+
+on:
+  push:
+    tags:
+      - v[0-9]+.*
+
+permissions:
+  contents: write
+
+jobs:
+  create-gh-release:
+    name: Create a new release or update an existing release in the GitHub repository
+    runs-on: ubuntu-latest
+    steps:
+      - name: Checkout the repository
+        uses: actions/checkout@v2
+        with:
+          fetch-depth: 2  # OR '0' To retrieve all preceding commit.
+      - name: Get changed files
+        uses: tj-actions/changed-files@v11.7
+        id: changed-files
+        with:
+          separator: ' '
+      - name: Generate the changelog
+        run: kotlin .github/scripts/generate-github-changelog.main.kts ${{ steps.changed-files.outputs.all_changed_and_modified_files }}
+      - name: Create the release
+        uses: actions/create-release@v1
+        env:
+          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
+        with:
+          tag_name: ${{ github.ref_name }}
+          release_name: ${{ github.ref_name }}
+          body_path: changelog.txt
+          draft: false
+          prerelease: false

base-commit: 5f439a0ecfb4657100ec1e56ef9c6eca963b5a94
-- 
gitgitgadget
