Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_ABUSE_SURBL,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330DEC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E525920B1F
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 15:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYdGEenE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbgDAPzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:55:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44698 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733121AbgDAPzd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 11:55:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id 142so233214pgf.11
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 08:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ka7EhvJEchjTFE9nCYQzvV+GsJFgkK5pSK4IHY7drsA=;
        b=jYdGEenEUndb/o5WXEm8JYEduLOPXoK/25yMUSF877HxMnAhZPlDftD6GslQlq4c7N
         x+fxAW84vQL8HJKvy02QtUd7t3nHQeicl2LrmN+IEd/rymAAIEIl4MNz1Nbv3qQ8y0Vo
         ZQFsRBXjj1yUkVFajnEANEjyzBOdFyv8Tq2TCK5nxSAAANcinPsZ5GNOq9iVD+Qb662q
         BCcxh20/aBdHgf89w2Y58bWz2kaeL3s58bcghpGH/BloWGrMg+0qHUM1G8yWfU7fc26D
         uVPwQ5lfMA9SVIRFK6OYzrsjX9+yWV0zz+5uODZiV2EenNhi9bgxUeGYNCA4aO45Rq1c
         zZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ka7EhvJEchjTFE9nCYQzvV+GsJFgkK5pSK4IHY7drsA=;
        b=joTFq85sCT+BWxLLxPc7MpzQLw9pbKVwlLex734/m3CFGPlu6dVoqgLMyTIqS2KA85
         8gavrknS0ApHUpnyXeQHtqUphKz2JvIJnbj6ndegdun+pEuzFk4LanU+Z/hQ4kPtVkWO
         mJ9EzeIDi2GRwG/IiRthokxhIldfTvlX+h6JHq+N6k+PAjiw6dbiM5I60OElXphJgCDH
         /ubmLGl3KD4xKErB34nscm/MJvIOVLPi+g/0AYdlb+7MiJmT2eM1rVMPCUNuZiwRlYXg
         PiTkjaDUEpO5ozufQAs3kInVq2pICNw+2rrcP9iV719xAq98n++hxgodfFLU1hOAY3Uy
         iSKw==
X-Gm-Message-State: AGi0PuZDMDdluSt/XCz0BN+IXYhylMVPhUZXswPGJzpBdB3QfvzPvF9K
        RmjoOK8kHkgbZbl91tE3PsqKZFtP
X-Google-Smtp-Source: APiQypIvsM395mfOTgPp2VMtNlvGu3vRLWKcH61u+NbpLn5kriKwR3irwWRlgnmBqY/df8I7cKyF0w==
X-Received: by 2002:a63:f50c:: with SMTP id w12mr5160970pgh.253.1585756530698;
        Wed, 01 Apr 2020 08:55:30 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id x4sm1990826pjf.23.2020.04.01.08.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 08:55:30 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 0/6] ci: replace our Azure Pipeline by GitHub Actions
Date:   Wed,  1 Apr 2020 22:55:02 +0700
Message-Id: <cover.1585756350.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on work started by Dscho,
I started to work with this series since there're merge conflicts
with my series at dd/ci-musl-lib, and Dscho said he was busy for a while.

Changes frome Dscho's version:
* Based on dd/ci-musl-libc
* Move artifact extraction out of Test phase of windows-test
* Move ci/print-test-failures.sh out of build-and-test phase
* set TERM environment variable if not exist
* add linux-musl job
* v1 doesn't report failure on linux32, fixed
* run linux32 directly inside container
* install development file of curl in documentation job because "curl-config"
  will be called in pu's Makefile
  + Other approach could be call make CURL_CONFIG=: in test-documentation.sh

Sample run:
* of this series: https://github.com/sgn/git/actions/runs/68291472
* pretend compile failure: https://github.com/sgn/git/actions/runs/68292112
* pretend test failure: https://github.com/sgn/git/actions/runs/68293056
* merged to pu: https://github.com/sgn/git/actions/runs/68301122


Johannes Schindelin (4):
  ci/lib: if CI type is unknown, show the environment variables
  ci/lib: allow running in GitHub Actions
  README: add a build badge for the GitHub Actions runs
  ci: retire the Azure Pipelines definition

Đoàn Trần Công Danh (2):
  ci/lib: set TERM environment variable if not exist
  ci: configure GitHub Actions for CI/PR

 .github/workflows/main.yml | 314 ++++++++++++++++++++
 README.md                  |   2 +-
 azure-pipelines.yml        | 593 -------------------------------------
 ci/lib.sh                  |  24 +-
 4 files changed, 338 insertions(+), 595 deletions(-)
 create mode 100644 .github/workflows/main.yml
 delete mode 100644 azure-pipelines.yml

Range-diff against v1:
1:  64d61c3e38 ! 1:  27cb77c257 ci/lib: if CI type is unknown, show the environment variables
    @@ Commit message
         This should help with adding new CI-specific if-else arms.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    -    Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## ci/lib.sh ##
     @@ ci/lib.sh: then
2:  4a0ec072cc ! 2:  079038c4a7 ci/lib: allow running in GitHub Actions
    @@ Commit message
         construct in ci/lib.sh. Let's add one for GitHub Actions.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    -    Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## ci/lib.sh ##
     @@ ci/lib.sh: save_good_tree () {
-:  ---------- > 3:  f9d0b6b0d5 ci/lib: set TERM environment variable if not exist
3:  e33653fdf0 ! 4:  fb714f5889 ci: configure GitHub Actions for CI/PR
    @@
      ## Metadata ##
    -Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    +Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
         ci: configure GitHub Actions for CI/PR
     
         This patch adds CI builds via GitHub Actions. While the underlying
         technology is at least _very_ similar to that of Azure Pipelines, GitHub
    -    Actions are much easier to set up than Azure Pipelines: no need to
    -    install a GitHub App, no need to set up an Azure DevOps account, all you
    -    need to do is push to your fork on GitHub.
    +    Actions are much easier to set up than Azure Pipelines:
    +    - no need to install a GitHub App,
    +    - no need to set up an Azure DevOps account,
    +    - all you need to do is push to your fork on GitHub.
     
         Therefore, it makes a lot of sense for us to have a working GitHub
         Actions setup.
     
    -    While transmogrifying `azure-pipelines.yml` into
    +    While translate-and-modify `azure-pipelines.yml` into
         `.github/workflows/main.yml`, we also use the opportunity to accelerate
         the step that sets up a minimal subset of Git for Windows' SDK in the
    -    Windows-build job: we now download a `.tar.xz` stored in Azure Blobs and
    -    extract it simultaneously (by calling `curl` and piping the result to
    -    `tar`, decompressing via `xz`, all three utilities being available by
    -    grace of using Git for Windows' Bash that is installed on the build
    -    agents). This accelerates that step from ~1m50s to ~7s.
    +    Windows-build job:
    +    - we now download a `.tar.xz` stored in Azure Blobs and extract it
    +    simultaneously (by calling `curl` and piping the result to `tar`,
    +    - decompressing via `xz`,
    +    - all three utilities are installed together with Git for Windows
     
         Also, we do away with the parts that try to mount a file share on which
         `prove` can store data between runs. It is just too complicated to set
         up, so it's little return on investment there.
     
    +    Based-on-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
    @@ .github/workflows/main.yml (new)
     +      with:
     +        name: windows-artifacts
     +        path: ${{github.workspace}}
    -+    - name: Test
    ++    - name: extract artifact
     +      shell: powershell
     +      run: |
     +        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
    @@ .github/workflows/main.yml (new)
     +            echo No test artifacts found\; skipping >&2
     +            exit 0
     +          }
    -+          tar xf artifacts.tar.gz || exit 1
    -+
    ++          tar xf artifacts.tar.gz
    ++        "@
    ++        if (!$?) { exit(1) }
    ++    - name: Test
    ++      shell: powershell
    ++      run: |
    ++        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
     +          # Let Git ignore the SDK
     +          printf '%s\n' /git-sdk-64-minimal/ >>.git/info/exclude
     +
    -+          ci/run-test-slice.sh ${{matrix.nr}} 10 || {
    -+            ci/print-test-failures.sh
    -+            exit 1
    -+          }
    ++          ci/run-test-slice.sh ${{matrix.nr}} 10
     +        "@
     +        if (!$?) { exit(1) }
    ++    - name: ci/print-test-failures.sh
    ++      if: failure()
    ++      shell: powershell
    ++      run: |
    ++        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc ci/print-test-failures.sh
    ++        exit(1)
     +  vs-build:
     +    runs-on: windows-latest
     +    steps:
    @@ .github/workflows/main.yml (new)
     +    - name: ci/run-build-and-test.sh
     +      env:
     +        CC: clang
    ++      run: ci/run-build-and-tests.sh
    ++    - name: ci/print-test-failures.sh
    ++      if: failure()
    ++      env:
    ++        CC: clang
     +      run: |
    -+        ci/run-build-and-tests.sh || {
    -+          ci/print-test-failures.sh
    -+          exit 1
    -+        }
    ++        ci/print-test-failures.sh
    ++        exit 1
     +  linux-gcc:
     +    runs-on: ubuntu-latest
     +    steps:
    @@ .github/workflows/main.yml (new)
     +        sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2 language-pack-is git-svn gcc-8 &&
     +        ci/install-dependencies.sh
     +    - name: ci/run-build-and-tests.sh
    ++      run: ci/run-build-and-tests.sh
    ++    - name: ci/print-test-failures.sh
    ++      if: failure()
     +      run: |
    -+        ci/run-build-and-tests.sh || {
    -+          ci/print-test-failures.sh
    -+          exit 1
    -+        }
    ++        ci/print-test-failures.sh
    ++        exit 1
     +  osx-clang:
     +    runs-on: macos-latest
     +    steps:
    @@ .github/workflows/main.yml (new)
     +      env:
     +        CC: clang
     +      run: ci/install-dependencies.sh
    -+    - name: ci/run-build-and-tests.sh
    ++    - name: ci/run-build-and-test.sh
    ++      env:
    ++        CC: clang
    ++      run: ci/run-build-and-tests.sh
    ++    - name: ci/print-test-failures.sh
    ++      if: failure()
     +      env:
     +        CC: clang
     +      run: |
    -+        ci/run-build-and-tests.sh || {
    -+          ci/print-test-failures.sh
    -+          exit 1
    -+        }
    ++        ci/print-test-failures.sh
    ++        exit 1
     +  osx-gcc:
     +    runs-on: macos-latest
     +    steps:
    @@ .github/workflows/main.yml (new)
     +    - name: install dependencies
     +      run: ci/install-dependencies.sh
     +    - name: ci/run-build-and-tests.sh
    ++      run: ci/run-build-and-tests.sh
    ++    - name: ci/print-test-failures.sh
    ++      if: failure()
     +      run: |
    -+        ci/run-build-and-tests.sh || {
    -+          ci/print-test-failures.sh
    -+          exit 1
    -+        }
    ++        ci/print-test-failures.sh
    ++        exit 1
     +  GETTEXT_POISON:
     +    runs-on: ubuntu-latest
     +    steps:
    @@ .github/workflows/main.yml (new)
     +    - name: ci/run-build-and-tests.sh
     +      env:
     +        jobname: GETTEXT_POISON
    ++      run: ci/run-build-and-tests.sh
    ++    - name: ci/print-test-failures.sh
    ++      if: failure()
    ++      env:
    ++        jobname: GETTEXT_POISON
     +      run: |
    -+        ci/run-build-and-tests.sh || {
    -+          ci/print-test-failures.sh
    -+          exit 1
    -+        }
    -+  linux32:
    ++        ci/print-test-failures.sh
    ++        exit 1
    ++  linux-musl:
     +    runs-on: ubuntu-latest
    ++    container: alpine
     +    steps:
     +    - uses: actions/checkout@v1
    -+    - name: ci/run-linux32-docker.sh
    ++    - name: install additional dependencies
    ++      run: apk add --update ncurses perl-utils
    ++    - name: prepare /usr/src/git
     +      run: |
    -+        res=0
    -+        sudo GITHUB_ACTIONS="$GITHUB_ACTIONS" RUNNER_OS="$RUNNER_OS" GITHUB_REF="$GITHUB_REF" GITHUB_SHA="$GITHUB_SHA" GITHUB_REPOSITORY="$GITHUB_REPOSITORY" GITHUB_RUN_ID="$GITHUB_RUN_ID" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=1
    ++        mkdir -p /usr/src &&
    ++        rm -rf /usr/src/git &&
    ++        ln -sf $(pwd) /usr/src/git
    ++    - name: ci/run-alpine-build.sh
    ++      run: ci/run-alpine-build.sh $(id -u)
    ++    - name: ci/print-test-failures.sh
    ++      if: failure()
    ++      run: ci/print-test-failures.sh
    ++  linux32:
    ++    runs-on: ubuntu-latest
    ++    container: daald/ubuntu32:xenial
    ++    steps:
    ++    - uses: actions/checkout@v1
    ++    - name: prepare /usr/src/git
    ++      run:
    ++        mkdir -p /usr/src &&
    ++        rm -rf /usr/src/git &&
    ++        ln -sf $(pwd) /usr/src/git
    ++    - name: ci/run-linux32-build.sh
    ++      run: ci/run-linux32-build.sh $(id -u)
    ++    - name: ci/print-test-failures.sh
    ++      if: failure()
    ++      run: ci/print-test-failures.sh
     +  static-analysis:
     +    runs-on: ubuntu-latest
     +    steps:
    @@ .github/workflows/main.yml (new)
     +    - name: install dependencies
     +      run: |
     +        sudo apt-get update &&
    -+        sudo apt-get install -y asciidoc xmlto asciidoctor docbook-xsl-ns
    ++        sudo apt-get install -y asciidoc xmlto asciidoctor docbook-xsl-ns libcurl4-openssl-dev
     +    - name: ci/test-documentation.sh
     +      env:
     +        ALREADY_HAVE_ASCIIDOCTOR: yes.
4:  c4f7338184 ! 5:  4310a7c9d6 README: add a build badge for the GitHub Actions runs
    @@ Commit message
         README: add a build badge for the GitHub Actions runs
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    -    Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## README.md ##
     @@
5:  9598f73435 ! 6:  2451d4991f ci: retire the Azure Pipelines definition
    @@ Commit message
         Pipelines would be redundant, and a waste of energy.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    [Danh: fix apply conflicts]
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## README.md ##
    @@ azure-pipelines.yml (deleted)
     -       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
     -
     -       res=0
    --       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=1
    +-       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" jobname=Linux32 bash -lxc ci/run-docker.sh || res=1
     -
     -       sudo chmod a+r t/out/TEST-*.xml
     -       test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
     -
     -       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
     -       exit $res
    --    displayName: 'ci/run-linux32-docker.sh'
    +-    displayName: 'jobname=Linux32 ci/run-docker.sh'
     -    env:
     -      GITFILESHAREPWD: $(gitfileshare.pwd)
     -  - task: PublishTestResults@2
    @@ azure-pipelines.yml (deleted)
     -      PathtoPublish: t/failed-test-artifacts
     -      ArtifactName: failed-test-artifacts
     -
    +-- job: linux_musl
    +-  displayName: linux-musl
    +-  condition: succeeded()
    +-  pool:
    +-    vmImage: ubuntu-latest
    +-  steps:
    +-  - bash: |
    +-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
    +-
    +-       res=0
    +-       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" jobname=linux-musl bash -lxc ci/run-docker.sh || res=1
    +-
    +-       sudo chmod a+r t/out/TEST-*.xml
    +-       test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
    +-
    +-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
    +-       exit $res
    +-    displayName: 'jobname=linux-musl ci/run-docker.sh'
    +-    env:
    +-      GITFILESHAREPWD: $(gitfileshare.pwd)
    +-  - task: PublishTestResults@2
    +-    displayName: 'Publish Test Results **/TEST-*.xml'
    +-    inputs:
    +-      mergeTestResults: true
    +-      testRunTitle: 'musl'
    +-      platform: Linux
    +-      publishRunAttachments: false
    +-    condition: succeededOrFailed()
    +-  - task: PublishBuildArtifacts@1
    +-    displayName: 'Publish trash directories of failed tests'
    +-    condition: failed()
    +-    inputs:
    +-      PathtoPublish: t/failed-test-artifacts
    +-      ArtifactName: failed-test-artifacts
    +-
     -- job: static_analysis
     -  displayName: StaticAnalysis
     -  condition: succeeded()
-- 
2.26.0.334.g6536db25bb

