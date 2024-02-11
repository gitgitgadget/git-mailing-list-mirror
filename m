Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C435A4ED
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707652363; cv=none; b=G2OuHM3IyqWKqTkVHA3ryB4NsIlRleJDw4d0kwo/jNwzntGDzAHD+SfoVAF1RqZFb6qd+MsZyMRHlxc1h+6WQeatU9wuiXPq0NAvCZ9SKP1Htgx5hrsCj9PWPgBDWwkJWc8dYbWnbCKGS3hU1rWZ49ZjDYj8+amoB+OmEsLtNdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707652363; c=relaxed/simple;
	bh=ydd1vPlCoyq9aCjVPHYIy06GdfQK7RtrSMNuCDnTRmc=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=V21RXirfoGVKIVnN4WDzrWbu9x9BDfqlWQcYInxEzT4//xt78FExrFZIDUKAo8h402mZ+7AAogw5IxzxEnrgs2HMGFNjSuN0axea23if+zr+8Z2AF+oHkPxOiUoK1QzKTzEEcqTP4A8gnMTbufaIZn0OJQ2VDBhgXF5KPSVY58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0cAzKpS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0cAzKpS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41097f9a9a4so6687905e9.2
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 03:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707652359; x=1708257159; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=880p1dgrYbVA4u9XMKUo/MQCkeyJxR1KAOMfBGN9oyo=;
        b=F0cAzKpSXuWpcSMdXJup9pnIFRgz160bheBFktjvk5yM97/egykNkR4czBAg9nOywW
         2Q2+IqMd28yAiGS2VO0Yso0Ah9QMzwToDR1wZR4Y6T/Rh3iYcr6mm3mZggiNQGUtqHGz
         ultLvz2KG33JQ0PpqRxqCPtfrh82fFjvDJPFe89IQz07f9QjzX5eb2B47e1c0OvO6gRG
         25bkG+YC/tMvQkhPzUvJEqIoNuiNNaUr95ss47AGEiGptkeb7D/W3APJOtZbOLErF8CX
         RWPk9ZoVJbKagxgtW1f3NPqK8ekjug9/guEa+ykDO/cyhkRvWQUj/wtHb66hfqcz1hDO
         3hLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707652359; x=1708257159;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=880p1dgrYbVA4u9XMKUo/MQCkeyJxR1KAOMfBGN9oyo=;
        b=WYNRuidGm29/VT6fgd8GTX4eO11SFqmH38p8GB+kebhsxW27NHADKa+xlsBbk1J/y4
         R2ER7u3JBZYBy38zdY0r6lPBtpFakyNVAJyi6A/aGKSNbbF3VJiPq+vyCZXvP0KSfkfz
         F7q8smgNFyu5n/4nsCt0cqYBdyUZuOhrJFLi5Xx4FzIpsDN7l/kwcz8bRZ7ptmK2hhwd
         ylRDwRo3X5SkbaLJMzn47ary2/sUXkRzaCIugOWzXcQi/aNRdcWGywqBc9ponyauRP2U
         MRMOm+V8oFCPxUl2F74njzRNblFEjvxzTbKSdE7dw8K9BoMab7TrqViQh4NHyztB74Yd
         UgyA==
X-Gm-Message-State: AOJu0YzfEDoPYSNVfRt+Ypw8AjSaycjJHwsxHfyNGcf1LJTsoFocOkDe
	QdSAAst2WfFkbcwuBXFjEbA1j6A4aEwQNF68mjPoTGWQkOOopD2GvHiLODIf
X-Google-Smtp-Source: AGHT+IFYXmttLWTd1MULdlaEMH3c9ISJT9+KO74TBHEboMs1M5Kx0pu7HXAzZipfWsavS5Iy6wdn4g==
X-Received: by 2002:a05:600c:4ed0:b0:410:c127:62fe with SMTP id g16-20020a05600c4ed000b00410c12762femr864072wmq.1.1707652358531;
        Sun, 11 Feb 2024 03:52:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jz15-20020a05600c580f00b004101f27737asm5575696wmb.29.2024.02.11.03.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 03:52:38 -0800 (PST)
Message-ID: <pull.1660.git.1707652357696.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Feb 2024 11:52:37 +0000
Subject: [PATCH] ci: bump remaining outdated Actions versions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

This avoids "Node.js 16 Actions" deprecation messages by bumping the
following Actions' versions:

- actions/upload-artifact from 3 to 4
- actions/download-artifact from 3 to 4
- actions/cache from 3 to 4

Helped-by: Matthias Aßhauer <mha1993@live.de>
Original-commits-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: bump remaining outdated Actions versions
    
    I noticed that Junio recently bumped a couple of these Actions versions,
    and incidentally I also activated automatic Dependabot updates of those
    in git-for-windows/git. Dependabot noticed a couple of yet-unaddressed
    updates, which I accumulated into a single patch.
    
    This patch is based on jc/github-actions-update.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1660%2Fdscho%2Fmoar-github-actions-updates-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1660/dscho/moar-github-actions-updates-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1660

 .github/workflows/coverity.yml |  4 ++--
 .github/workflows/main.yml     | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index a81a7566d10..53cf12fe044 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -98,7 +98,7 @@ jobs:
       # A cache miss will add ~30s to create, but a cache hit will save minutes.
       - name: restore the Coverity Build Tool
         id: cache
-        uses: actions/cache/restore@v3
+        uses: actions/cache/restore@v4
         with:
           path: ${{ runner.temp }}/cov-analysis
           key: cov-build-${{ env.COVERITY_LANGUAGE }}-${{ env.COVERITY_PLATFORM }}-${{ steps.lookup.outputs.hash }}
@@ -141,7 +141,7 @@ jobs:
           esac
       - name: cache the Coverity Build Tool
         if: steps.cache.outputs.cache-hit != 'true'
-        uses: actions/cache/save@v3
+        uses: actions/cache/save@v4
         with:
           path: ${{ runner.temp }}/cov-analysis
           key: cov-build-${{ env.COVERITY_LANGUAGE }}-${{ env.COVERITY_PLATFORM }}-${{ steps.lookup.outputs.hash }}
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index bb857bdaf08..4eea49fc85c 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -123,7 +123,7 @@ jobs:
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-      uses: actions/upload-artifact@v3
+      uses: actions/upload-artifact@v4
       with:
         name: windows-artifacts
         path: artifacts
@@ -140,7 +140,7 @@ jobs:
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v3
+      uses: actions/download-artifact@v4
       with:
         name: windows-artifacts
         path: ${{github.workspace}}
@@ -157,7 +157,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v3
+      uses: actions/upload-artifact@v4
       with:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -212,7 +212,7 @@ jobs:
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-      uses: actions/upload-artifact@v3
+      uses: actions/upload-artifact@v4
       with:
         name: vs-artifacts
         path: artifacts
@@ -230,7 +230,7 @@ jobs:
     steps:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v3
+      uses: actions/download-artifact@v4
       with:
         name: vs-artifacts
         path: ${{github.workspace}}
@@ -248,7 +248,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v3
+      uses: actions/upload-artifact@v4
       with:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -305,7 +305,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v3
+      uses: actions/upload-artifact@v4
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -353,13 +353,13 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname != 'linux32'
-      uses: actions/upload-artifact@v3
+      uses: actions/upload-artifact@v4
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname == 'linux32'
-      uses: actions/upload-artifact@v1
+      uses: actions/upload-artifact@v4
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}

base-commit: dcce2bda214ac4c838f4b85f2c550816df3a6ac9
-- 
gitgitgadget
