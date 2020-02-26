Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8860DC4BA21
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537C521556
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwwYnMzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgBZUJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:09:41 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35268 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgBZUJl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:09:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id c7so361049edu.2
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 12:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PvLcEFm2U2RuVDEvvMsqbjR3vL2S4N4DlN6D8Aeo/gU=;
        b=NwwYnMzWBotsM8D1lfZoC3Di3EsPyDRCJjqmTMuvjcsCqz3A0Ej3omqDyx6eR7aVF4
         tDBkRjBln2Q9mtIx9o+I2XlI18jsV0AZVCTWoGfUrAQ3bypR3tgwkYzbPplS7BMErYhh
         BKW8aFwWHIIif9BXj5YwCZ6IVIaT+ZgZrrkQqsEp24DxOiGt4eRUyDSEKtNgle79wRqL
         UYKv9B7pCUxX+U03ac8TD5msOCmu/TWmSQ+WSHAfNeREwQVnxN4D1Dy+U5bfgBx+yV+F
         4tgVvC7OF6NVejJWnFu9dZD1+jW2+vzQWjse+2Fb+dEEtlq8Q8tHxnLHUgdv2yFCqySc
         obHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PvLcEFm2U2RuVDEvvMsqbjR3vL2S4N4DlN6D8Aeo/gU=;
        b=cZOcNYtmGUYCtyaINCcUqJVN+qMIlXGkwMUjyxLpxFyLGgrVloyzcIkXDoUr7RUIBU
         r+6X+niPxdlSHy0aS0M58buTUAlci0VcpZlA8ekEscOAXgmMFDZNBp9ifLFFexWY8GEL
         fMGoaJk6pANkfprua+Nez6EbMA6JCVNXtGVW9KOSFzkBSAj5VwpGlBxljBfjrnOcNYQX
         dXfN0HpdAdMlKHBU1a6G9XNj7f3OxOlLFb58zwI6NMxna06wliqfHpaJ4ygfWJSmcDpb
         J/nw44271tsOBSjyEeS0EzMbrUCi6wqSCYCZiS6e2aBkH+yB0aL+G4pq4j9TKQdSMcH9
         qAnA==
X-Gm-Message-State: APjAAAUtyOTKYpG0Myyfe7cuQGPoEwnMOqldPxoeaOpbuDKzTqNsetG6
        AlkyLTWk5L6i7G8Cg6RJWGMZprv2
X-Google-Smtp-Source: APXvYqxoqwAthh6z2VQugR5GrjRba9gHoR2V2g/AhIS9V6DKEn7B0K6lg05BXJUJdaGSPlYKJmBONQ==
X-Received: by 2002:aa7:c946:: with SMTP id h6mr132219edt.186.1582747778904;
        Wed, 26 Feb 2020 12:09:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11sm203771edj.78.2020.02.26.12.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 12:09:38 -0800 (PST)
Message-Id: <f141c295fd84e619ab84bdaf440a0bff966b2861.1582747775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>
References: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 20:09:35 +0000
Subject: [PATCH 3/3] Azure Pipeline: switch to the latest agent pools
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It would seem that at least the `vs2015-win2012r2` pool (which we use
via its old name, `Hosted`) is about to be phased out. Let's switch
before that.

While at it, use the newer pool names as suggested at
https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops#use-a-microsoft-hosted-agent

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index af2a5ea4845..675c3a43c9c 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -5,7 +5,8 @@ jobs:
 - job: windows_build
   displayName: Windows Build
   condition: succeeded()
-  pool: Hosted
+  pool:
+    vmImage: windows-latest
   timeoutInMinutes: 240
   steps:
   - powershell: |
@@ -61,7 +62,8 @@ jobs:
   displayName: Windows Test
   dependsOn: windows_build
   condition: succeeded()
-  pool: Hosted
+  pool:
+    vmImage: windows-latest
   timeoutInMinutes: 240
   strategy:
     parallel: 10
@@ -133,7 +135,8 @@ jobs:
 - job: vs_build
   displayName: Visual Studio Build
   condition: succeeded()
-  pool: Hosted VS2017
+  pool:
+    vmImage: windows-latest
   timeoutInMinutes: 240
   steps:
   - powershell: |
@@ -181,6 +184,7 @@ jobs:
       platform: x64
       configuration: Release
       maximumCpuCount: 4
+      msbuildArguments: /p:PlatformToolset=v142
   - powershell: |
       & compat\vcbuild\vcpkg_copy_dlls.bat release
       if (!$?) { exit(1) }
@@ -224,7 +228,8 @@ jobs:
   displayName: Visual Studio Test
   dependsOn: vs_build
   condition: succeeded()
-  pool: Hosted
+  pool:
+    vmImage: windows-latest
   timeoutInMinutes: 240
   strategy:
     parallel: 10
@@ -292,7 +297,8 @@ jobs:
 - job: linux_clang
   displayName: linux-clang
   condition: succeeded()
-  pool: Hosted Ubuntu 1604
+  pool:
+    vmImage: ubuntu-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
@@ -330,7 +336,8 @@ jobs:
 - job: linux_gcc
   displayName: linux-gcc
   condition: succeeded()
-  pool: Hosted Ubuntu 1604
+  pool:
+    vmImage: ubuntu-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
@@ -367,7 +374,8 @@ jobs:
 - job: osx_clang
   displayName: osx-clang
   condition: succeeded()
-  pool: Hosted macOS
+  pool:
+    vmImage: macOS-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
@@ -402,7 +410,8 @@ jobs:
 - job: osx_gcc
   displayName: osx-gcc
   condition: succeeded()
-  pool: Hosted macOS
+  pool:
+    vmImage: macOS-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
@@ -435,7 +444,8 @@ jobs:
 - job: gettext_poison
   displayName: GETTEXT_POISON
   condition: succeeded()
-  pool: Hosted Ubuntu 1604
+  pool:
+    vmImage: ubuntu-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
@@ -472,7 +482,8 @@ jobs:
 - job: linux32
   displayName: Linux32
   condition: succeeded()
-  pool: Hosted Ubuntu 1604
+  pool:
+    vmImage: ubuntu-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
@@ -506,7 +517,8 @@ jobs:
 - job: static_analysis
   displayName: StaticAnalysis
   condition: succeeded()
-  pool: Hosted Ubuntu 1604
+  pool:
+    vmImage: ubuntu-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
@@ -526,7 +538,8 @@ jobs:
 - job: documentation
   displayName: Documentation
   condition: succeeded()
-  pool: Hosted Ubuntu 1604
+  pool:
+    vmImage: ubuntu-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
-- 
gitgitgadget
