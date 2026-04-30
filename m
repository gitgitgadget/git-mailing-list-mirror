Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05FA3DCD94
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534526; cv=none; b=XW/eEnOQfMtgV7hS7oV3Hfm4j8PAR+lgub5i8PHvQvdxnfrCInPt4gtmRw2erUfqiIh1zxKioFitEHULl9Sa6XJOkak/mdbWJ1EIL+2eNGNam8cyCS83GkkXbnAwJO5wDd3ipccJBgwvq2D711aPqXwXUg28D8n5znxS3Lx43tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534526; c=relaxed/simple;
	bh=TzsOmCfh29CX5FOYTA6kFhGm/muHTfX72lg1yEqLb4Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W19xhX7vI1vdOgF1zHheClBIj7SbKIwS/tfNTjNw63NpppRglHkJvENV3m/nl06SArEYHvx71edP5SaN2drOpHz9+QRFGWy+oBnZ5IjqXL/63S3nhQPmtE98a9RdY5By2XZNMPEEq4PNxRjDMy2Vnsf7doKudaq2rn0z6iPsOyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gl0Q4IfJ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl0Q4IfJ"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89fc4147f2eso7965736d6.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777534509; x=1778139309; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0c6sxsAB7vLfeCVNDGdQeMNlWzlfomYjfvDnHOWHnzY=;
        b=Gl0Q4IfJlebcbfBrUjYLq+eVs8rRrajReFVTL1YzKoXb13FA67Zf93i8lLMnbo74a1
         OGc/2aaYGhrmRjb14GVo2wq3ORqO/WIsLOwfyopBMYTeXdT2SpxlQwO/TOZFuEGvu5vE
         VSj3bHaenPWfSNt10A049FIgpaqzHCvakjbXP4vB3o9mxgU32D92vuPTcSSVUNOcHbvY
         XZmmX/h0C9WfmyEaVod3D0JMRcJCpGSYp4MxAskgKEACaGE2V6DvbOn3qb5hmadI/ka7
         lSIMYKccyDO/BF+72669hRLDlHgkK0pMhFf0HYqlKDaML+I9W1UhJxOlaabTGVSDyvfJ
         tAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534509; x=1778139309;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0c6sxsAB7vLfeCVNDGdQeMNlWzlfomYjfvDnHOWHnzY=;
        b=aNabe/s8uavaO6SAKc/BZDJRxW7yNJCHbr8QDnvh3IQ+pcUzkbo5OX7PiHZo/BsUI7
         qfczz+3t03ePw1TO3xm3KsVq0wA0spmuyy9F/P3snDtCV2w1cQcvamAC5UPDgJHxPh6I
         XGraaZMPzbv6iPyutC+i8xZ75ld9FmtZqIqjvqdAX0QCqt3vbOwQYURCxXCUdR1Bw8KN
         j+U+7j7tuzNx+HYFZZqZ3D7Lo98e/mgHKxHrgXlD9ln0FzrIH67FvzmSfaBUZyVO8mC9
         +6v3OCuQJQtU7g4RtreXxYSs8DvSZHebMgApJNEPhmR+r3LZp/UERg5V0DyRvmdQoHQb
         +XLA==
X-Gm-Message-State: AOJu0YzbbxsYn7Z8QloCSoVldCwk0s4oHDr+TMNaDzRTrfb4aDtHL5qB
	uMBIJoDpTk7ucNJdUQLSp4uT4lSVdb0jcAwNhUJdoL/fTTsU3yqWnf9413bnEA==
X-Gm-Gg: AeBDietL68MTA9rpt7QvGz3ae/ehkud98BmMAYE1y93T2hSM17GQlPgsl29Rsp9I9Z7
	s/KtZouaS85HPnB8NwdawBIYQC3e+161Q3qw4aTbdTtvjbx1c9dUSvgyw25dNVc/TO6PJvknxTy
	dWUsg3pSS4EDI6QcDbChfWu+nFTDCDOWRfMxr9q4qyCat4DvRsLNKsV7qTaVwqj/3OV+qJglqHx
	WvVLwi756HFR7oArmYR2S0V+lYPSE5LbmYlRJ7hd4NPJtGRBAnI3kYVT2wPPDQubkjwTaD/QtHj
	eJ1kwlY0B9z2L8/gFfI1uQgcLU9vJWOiJM4KhAzJxzF/3CMW6SD5Gr6itoLDUUiEgkAL82GH8Qo
	UrtJfvs3TzSGoEum5Zv0ySNzL19D+CcV8wpwKCtjRS50xzC/DKXJ58DOZwXyQgCf5KK2mzCAi2p
	cUpqIgKgilNm91jzxxgqAfQypZB/qUbl24F/nD
X-Received: by 2002:a05:6214:610d:b0:8a3:8f4c:3b6f with SMTP id 6a1803df08f44-8b3ff0189b7mr21744066d6.51.1777534509182;
        Thu, 30 Apr 2026 00:35:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.192])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ff321bf9sm11528866d6.13.2026.04.30.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:35:08 -0700 (PDT)
Message-Id: <c6e8df1eff329302ac080f70d4db6d9fdd1ae8ae.1777534500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.v3.git.1777534500.gitgitgadget@gmail.com>
References: <pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
	<pull.2097.v3.git.1777534500.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Apr 2026 07:34:59 +0000
Subject: [PATCH v3 5/6] ci: bump git-for-windows/setup-git-for-windows-sdk
 from v1 to v2
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christoph =?UTF-8?Q?Gr=C3=BCninger?= <foss@grueninger.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The v1 of `git-for-windows/setup-git-for-windows-sdk` runs on
Node.js 20, which GitHub is phasing out of the Actions runners.
v2 moves the action to Node.js 24 so that the CI jobs relying on
a Git for Windows SDK keep working once Node.js 20 is removed.

The risk is very low: v2 contains no functional changes to the
SDK setup itself, only the runtime upgrade. The action still
provisions the same minimal SDK and exposes the same outputs.
The sole precondition is a recent Actions Runner (>= 2.327.1),
which the github.com-hosted runners already satisfy.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/coverity.yml | 2 +-
 .github/workflows/main.yml     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index 89bef26727..58a78f1eb3 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -41,7 +41,7 @@ jobs:
       - uses: actions/checkout@v6
       - name: install minimal Git for Windows SDK
         if: contains(matrix.os, 'windows')
-        uses: git-for-windows/setup-git-for-windows-sdk@v1
+        uses: git-for-windows/setup-git-for-windows-sdk@v2
       - run: ci/install-dependencies.sh
         if: contains(matrix.os, 'ubuntu') || contains(matrix.os, 'macos')
         env:
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 0ea266f27c..3da5326f0b 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -113,7 +113,7 @@ jobs:
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - uses: actions/checkout@v6
-    - uses: git-for-windows/setup-git-for-windows-sdk@v1
+    - uses: git-for-windows/setup-git-for-windows-sdk@v2
     - name: build
       shell: bash
       env:
@@ -147,7 +147,7 @@ jobs:
     - name: extract tracked files and build artifacts
       shell: bash
       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
-    - uses: git-for-windows/setup-git-for-windows-sdk@v1
+    - uses: git-for-windows/setup-git-for-windows-sdk@v2
     - name: test
       shell: bash
       run: . /etc/profile && ci/run-test-slice.sh $((${{matrix.nr}} + 1)) 10
@@ -174,7 +174,7 @@ jobs:
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - uses: actions/checkout@v6
-    - uses: git-for-windows/setup-git-for-windows-sdk@v1
+    - uses: git-for-windows/setup-git-for-windows-sdk@v2
     - name: initialize vcpkg
       uses: actions/checkout@v6
       with:
@@ -224,7 +224,7 @@ jobs:
       group: vs-test-${{ matrix.nr }}-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: git-for-windows/setup-git-for-windows-sdk@v1
+    - uses: git-for-windows/setup-git-for-windows-sdk@v2
     - name: download tracked files and build artifacts
       uses: actions/download-artifact@v8
       with:
-- 
gitgitgadget

