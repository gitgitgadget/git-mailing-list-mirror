Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833015A119
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707653495; cv=none; b=ZzmojZ4zpAXOtbjgqa7vqw9ipRgqzAlQETwh0tQuXPsSjkAWZ+lvx2HgarmoCyEQLnc8CjQMF9elmVOXxcJ7g/oP5r6bgSghHsGaCwMpFK/NNxdMvYsaHaRcUIuz8UApKhPuq53oTrbWvPzHbNJvaXUWuep+xwA617g5Pdl9T9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707653495; c=relaxed/simple;
	bh=pRS5ob6D3kGuUIsIFBKm85vXrIp4WKdzHArHAhKC5+M=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=anx6VU4PiwOLz5U4mr3bDDbb4aq6MGqK82P7SOiwRCyVhW7axIK88gtOTA46+PRtFaUAHuhX+MV3Q8sGlyr5hAhwX9atU8OsWmIP+UskYEBrDI4kOzkbXVNVhEp59W6VMQap353ecMaaA9dgibVccOUTQ0ZmohiClxL3ZKqRoQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbUbmZQy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbUbmZQy"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41089cc9ae4so8105995e9.1
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 04:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707653491; x=1708258291; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDGPHMbdujFADps21XrEjHFLLY5Xz47ddk7X4+ivJXc=;
        b=AbUbmZQyWEpJ2o3BGDtK2W2UiAvIuU43HR7rP/yAQER0TAXovJsKwoKEIE1HAimm/S
         +hwWgCAae7DRDeatfOEYI01Io4kAByNfJaSfyHDPSxmUiLEoVYRcHdpX3wzuKWDK44Sa
         anL1YaLHgIsj/pPt/EjrbHF4wqaNNVe1Y1JA0oZYxvlaaNOY6k1ra4EwO3BmBQdoBmv1
         LaUg3JaHn7tKix9kJCadzpxOCI2MSY4rtVHbEr9kfMjABBG09ufqn5wflOIJoZNcrMMv
         LHOC9Thl9J+pTPZay37gF2QgT/q5CN1xd/5MOJqFpgOGbfwqe8GoNJmh6xNTXG09pKSa
         EU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707653491; x=1708258291;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDGPHMbdujFADps21XrEjHFLLY5Xz47ddk7X4+ivJXc=;
        b=sU/vUw4JTwyPNRgNHKHgVmNtEE8cTZnx2qjY8B3jADjvYo9y3OJSuUfkVAyr0xMjPw
         QKAy7mIY74ytbQHwLHEhW5JR4qrR7VGpCUlZyVsOIHhtXc8FsY1qXBE7KkSx9dA3EuRT
         xtG0R0y9msNS6JWlt++/W7dHwiSBrQtyglaSB8x6iPHNOXMqfmXmcazzJo+eC4cqqoDa
         FNGA0ZXgClGdAe//W1iebVyuNedbRTvMbUtY1BjKjYKzBr8IQ7te8RvWMDyiyxeglLZC
         P7Qy3Gnq/iUYY/h8pmQV1CvTOBme4IsNkXFXno8DXYOhhHBtewDNI5bKOeVDt7SISJ1c
         yNEQ==
X-Gm-Message-State: AOJu0YzzvTBGUckT+Gev9FOzITg6J/lrX4JWRWB9G6GQTnnlAWeDBzOp
	ZJujYnEC9z9la1cU89EyAR57/599H5j0mkYH4hO/D+khlzjNVbuq0IU+DVHy
X-Google-Smtp-Source: AGHT+IHXKc8pHAF59CZh35Gtt1Ljwdert9s+oRbABHtr3Gk6mzzLCgXfSJ0n1mL2D31Bcxo7Y8Q7GA==
X-Received: by 2002:a05:600c:b95:b0:410:aba8:a600 with SMTP id fl21-20020a05600c0b9500b00410aba8a600mr1677581wmb.30.1707653490853;
        Sun, 11 Feb 2024 04:11:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d4d4d000000b0033b13922263sm4124628wru.60.2024.02.11.04.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:11:30 -0800 (PST)
Message-ID: <2b35b9878a7ed6da268bff11c41a261ea774161f.1707653489.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.v2.git.1707653489.gitgitgadget@gmail.com>
References: <pull.1660.git.1707652357696.gitgitgadget@gmail.com>
	<pull.1660.v2.git.1707653489.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Feb 2024 12:11:28 +0000
Subject: [PATCH v2 1/2] ci: bump remaining outdated Actions versions
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
 .github/workflows/coverity.yml |  4 ++--
 .github/workflows/main.yml     | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

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
index bb857bdaf08..ec25f6f99de 100644
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
@@ -353,7 +353,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname != 'linux32'
-      uses: actions/upload-artifact@v3
+      uses: actions/upload-artifact@v4
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
-- 
gitgitgadget

