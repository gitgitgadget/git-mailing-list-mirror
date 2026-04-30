Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6F23DC4B6
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534521; cv=none; b=fCGNZX5D6IuXeqt+KHw/FRHrq4xBx7uXXwR9n/WbLGDa3f4fhtNfvsEvyo1ZDquxqV5HLZbeAqB7zMn+gtWDD6j6p6s1dFZL3fz4e1OMIm4AvPeM1CFWux15e0/LZaJvee7Fr6MbXj0zewQBKZkHgVPxJ1PDmjQODqQ4XsU1OJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534521; c=relaxed/simple;
	bh=npS15YFuEKhoJcgn7NZGntKnehRVmFgdekKgHMzz5dE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=awZInmFH34Jz3zXoUUHjc7/W1Xm+UrSsz3mSqnQnqIIOjTUxG7hqwisXKNyJF5LiEr/kNqlIENvehvuVic8i7nKvKcrgPskuSXcZS4g9W81TuePkdGdq3MDT+cpQetvtUk9jNAuK2soRrbrmZ7Lew8WiIr/BCk59r728m+7+JOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyCsqYGI; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyCsqYGI"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8eae9229110so104434785a.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777534506; x=1778139306; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJ5AQlDQO0dWrMsLT68hGbAW+P4tfvnLcvDlhTuNHZE=;
        b=YyCsqYGIfXW4hgGj0T2gdOyhXuuQUGCiiTdX+XKqO8oC1TF+qR8TREceqo/F6mlD7O
         rkWA9V6vg3O+3abfsoQsISOhyG7m215ChGyVVY13AzgVzGuLD+YF9sZAwtORQ2kStXK2
         oCEITmvmAh813S14zR1KxWL5FT17MhkOReiCWK7h508WFmGZgX3o5pwOBwnY1N4femE+
         B0B5rpDeSydKG1R7DSnYfepCmYg8gJ9Ea/rL42p7s1hT4Q3VwC8uRS2YOsibiOtXOZki
         g+RhTznDGHHIFfT1Rj3H7MdOEVzae1wD1vEWdl1H0O1JmZ6emCHtGpvCoFQlSVU0DR7s
         qkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534506; x=1778139306;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJ5AQlDQO0dWrMsLT68hGbAW+P4tfvnLcvDlhTuNHZE=;
        b=S9w0nWgspPaR/KpW+oyzzHDFTqDZWrzUDlF6CJgyDG6mwoZmpn287KkNMsYSk9Cz/s
         ShkBAyDRUTv4nSv35ZCGR5uyHKs9EHbcqBpGIhxEgm98j4NGEHpSVeOsvuntviewLimm
         fWAA/Q9ejGD0w5bRa05lukeuYUx5LUHLMBXyGYp5EHi/in/3p6aaEEEYwVejuR+Pv1SE
         UAoAotjStrF/gh2s9WQ9wT/jCXFYhPlKN8TKs08Xcadjvr+h+lw0hDWfhbgaUdFm+sPJ
         sMEdphxj9TFyBa19JAwKsPpi4DZSAYJFdlu0bNta4AOsDsRnpgFS9K+MADXHJXP6kMid
         FjIw==
X-Gm-Message-State: AOJu0YwnZEsy2RU5wh9TlnSKx7kquRiH+64OGiVSXcBPmPeg6FvPLpdl
	ABZhtIIQvB6C+XfGCWiGPlL1Xlm2GwSgtgbmoCNI5ifvD7nVB45uxXkhDEyAog==
X-Gm-Gg: AeBDieuiAMkp/wRQLrZIWL80pj1XI85K/1iKuI7YwfjXIiQMu7Z/GVo3ObMA8RcZB8r
	blGqPPFF7dqDJpq73e87pHBO9RYTTM6hpWeeugrqLM/IIgNzXSPYtL+X2J1IjvEM1qKlmSRIQAv
	z6dF3z1DPMgQwpyTNBtdx9lm8V2A+OhRDlCQ8d5WjZht/1vttWUIlo6tLmxTK/xX3Fa6BHBSnMx
	rwPJwui5wl6ETVqQiSvHgU8jTQa1BPYf02xquDPciFCjy4Q15rvizM21YSQY990asHUOTkKeP2C
	Jlk1DKS3d6U6vG9nRVjF1d6+viUgh7T1o7oYCPCvD4FuZxMmausk6vyLdJtWkWgfn1UJIRfq2qc
	1FuSXXKL5MSOK6taP79SjBrouZihmGRf04C2IuvtWEA+xMc0bVtyFTkXQkOIdPimuXb0ROmu1SG
	zoug6sTHr5p3Q9J5AfoOT+w8PBI/h2vlzo0g2P
X-Received: by 2002:a05:620a:3947:b0:8c5:3869:3f2e with SMTP id af79cd13be357-8fa88f2941amr294596285a.42.1777534505795;
        Thu, 30 Apr 2026 00:35:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f939a93224sm425671485a.0.2026.04.30.00.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:35:04 -0700 (PDT)
Message-Id: <5d719b3729e39d63ec0a1a474b0c1ff57570133e.1777534500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.v3.git.1777534500.gitgitgadget@gmail.com>
References: <pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
	<pull.2097.v3.git.1777534500.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Apr 2026 07:34:56 +0000
Subject: [PATCH v3 2/6] ci: bump actions/{upload,download}-artifact to v7 and
 v8
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

`actions/upload-artifact` and `actions/download-artifact` are tightly
coupled: the upload action writes artifact archives in a format that
the download action then reads. Because of this coupling, the two
actions should always be bumped together so that the artifact format
contract between them is satisfied.

All of our `actions/upload-artifact` uses are still on v5, with one
stray v4 occurrence. Keeping them on these versions would leave the
artifact-upload steps running on Node.js 20, which GitHub is phasing
out, and would eventually cause all upload steps to fail.

Going from v5 directly to v7 folds in two release bumps:

- v6 switches the action's default runtime from Node.js 20 to
  Node.js 24 (v5 had preliminary Node 24 support but still defaulted
  to Node 20). This is the main motivation for bumping now: it gets
  us off the deprecated runtime.
- v7 adds two opt-in features: direct (unzipped) single-file uploads
  via a new `archive: false` parameter, and an internal conversion of
  the action to ESM to match the updated `@actions/*` packages.

Risk analysis: we never pass `archive`, so the zip-as-usual behavior
is unchanged. We also do not `require('@actions/*')` from any calling
workflow, so the ESM migration cannot affect us. The upload steps we
care about -- tracked files/build artifacts and failing-test
directories -- keep the same inputs (`name`, `path`) and outputs, so
the diff is purely the `@vN` identifier. The main precondition is a
recent Actions Runner (>= 2.327.1), which the github.com-hosted
runners used by our CI already satisfy.

While at it, align the one remaining `@v4` occurrence with the rest
so that every `upload-artifact` step uses the same version.

See also:

- Release notes: https://github.com/actions/upload-artifact/releases
- Compare: https://github.com/actions/upload-artifact/compare/v5...v7

We use `actions/download-artifact` to pass build artifacts between
the "windows-build" / "vs-build" / "windows-meson-build" jobs and
their corresponding test jobs. All callers are currently on v6;
bumping to v8 keeps this action in lockstep with the `upload-artifact`
bump above.

What v7 and v8 change:

- v7 switches the default runtime from Node.js 20 to Node.js 24 (v6
  had preliminary Node 24 support but still defaulted to Node 20).
  This is the main motivation: it gets us off the deprecated runtime.
- v8 makes three further changes:
  * The package is converted to ESM (invisible to workflow authors).
  * The action now checks the `Content-Type` header before
    attempting to unzip a download, so that directly-uploaded
    (unzipped) artifacts from `upload-artifact` v7 are downloaded
    correctly.
  * The `digest-mismatch` behaviour is changed from warn-and-
    continue to a hard failure by default.

Risk analysis: defaulting hash-mismatch to a hard failure is
strictly safer than the previous warn-and-continue behaviour -- a
mismatch points to real corruption or tampering and should stop the
run. We download archives that the same workflow just uploaded, on
the same runner fleet, so false positives are not expected. Our
usage is limited to the `name` and `path` inputs, which are
unchanged between v6 and v8, so the diff is purely the `@vN`
identifier.

See also:

- Release notes: https://github.com/actions/download-artifact/releases
- Compare: https://github.com/actions/download-artifact/compare/v6...v8

Originally-authored-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 0d3e0e42a4..da31b10c79 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -123,7 +123,7 @@ jobs:
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-      uses: actions/upload-artifact@v5
+      uses: actions/upload-artifact@v7
       with:
         name: windows-artifacts
         path: artifacts
@@ -140,7 +140,7 @@ jobs:
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v6
+      uses: actions/download-artifact@v8
       with:
         name: windows-artifacts
         path: ${{github.workspace}}
@@ -157,7 +157,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v5
+      uses: actions/upload-artifact@v7
       with:
         name: failed-tests-windows-${{ matrix.nr }}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -208,7 +208,7 @@ jobs:
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-      uses: actions/upload-artifact@v5
+      uses: actions/upload-artifact@v7
       with:
         name: vs-artifacts
         path: artifacts
@@ -226,7 +226,7 @@ jobs:
     steps:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v6
+      uses: actions/download-artifact@v8
       with:
         name: vs-artifacts
         path: ${{github.workspace}}
@@ -244,7 +244,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v5
+      uses: actions/upload-artifact@v7
       with:
         name: failed-tests-windows-vs-${{ matrix.nr }}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -270,7 +270,7 @@ jobs:
       shell: pwsh
       run: meson compile -C build
     - name: Upload build artifacts
-      uses: actions/upload-artifact@v5
+      uses: actions/upload-artifact@v7
       with:
         name: windows-meson-artifacts
         path: build
@@ -292,7 +292,7 @@ jobs:
       shell: pwsh
       run: pip install meson ninja
     - name: Download build artifacts
-      uses: actions/download-artifact@v6
+      uses: actions/download-artifact@v8
       with:
         name: windows-meson-artifacts
         path: build
@@ -305,7 +305,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v4
+      uses: actions/upload-artifact@v7
       with:
         name: failed-tests-windows-meson-${{ matrix.nr }}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -349,7 +349,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v5
+      uses: actions/upload-artifact@v7
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -449,7 +449,7 @@ jobs:
       run: sudo --preserve-env --set-home --user=builder ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v5
+      uses: actions/upload-artifact@v7
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
-- 
gitgitgadget

