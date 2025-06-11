Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4EB2367AF
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650559; cv=none; b=K2pWJbjf/0XWGXFYy71riAgkuWZZGDrQaFxJulM4tjbS2t4rmswtCeoj47DVpwS/Y5QVeM8gWCPSycgGW4fcnK+eCSPI21P1ODavPNwpi/j8acVJZuNq+/B3ju4iG+mDNr98EvrtQHwpubT1FqVGBHSzqgzCqYerm1IeWI3QwSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650559; c=relaxed/simple;
	bh=mKlnQ7zBdp+l9mzYlodtlf8FL6mHjbeuYbvDWgK1uBs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bbtgCUGYsGThC+k+60a+SRjdaKI9lWbnqsmdsJ7EfVM2eb9fUiKnvctKGsap9kUkA/MrRHvb+byKmaTFMQhsC6Ja2jesfK6DI79vEd4oWoe3SYPhdHkcpXykCaFinlkmvySYce+MuYZhcymtCEVjjoXLXYZPoOPEDCe6MuK0gEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiY2gz6S; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiY2gz6S"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so83718365e9.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749650556; x=1750255356; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myf3Bo98XL6+wcHxcRzmyHnzC3x7qFWWRojys6yaKhA=;
        b=hiY2gz6Sgp435JKiBOjo5FQbtSR2ON3JwfuVSPA4cXAzuTQ59RJyBVy+qQA4pugk1E
         S5iwrtRbVfglTMSBUfev7eDtR+EUNVxJN0dTBgbNGA2QaAAUogijeMaEBwbZYuwAQEz3
         6Qi63zViodxZmD9ZrMBYIcDPcnB5V+o3M91TkqnKH/WESXxq3v6MFqN0iXchMLaVmwNW
         PSRjTm7ZBL5gGfr4ooAiD2+HZSRtWU4r3Jlvi4mxnHLc0h6mQdlq0Itgn12h53NxQ3jZ
         3ftV87HOuQfMfQUAgkZ5nKomqiDfhpKJ5DDXLiBu8OQXUB8aXMari6PJ64PUh0/iem00
         FWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749650556; x=1750255356;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myf3Bo98XL6+wcHxcRzmyHnzC3x7qFWWRojys6yaKhA=;
        b=N91aM2lXwi9b6EmVJBzXFPO1eR+lrpo1ernxhmcxW9xTbebLF65OpZ2ixyJaKgTqSK
         Lpv52Z7nRipyRFhFT+ZSmbJLaMCBljZ61lSMmWCvkWfAP3LR6R9dgcgpRhAxeWFeIJrx
         FO9KAxctOsCjTOdlZcXwrywIz6qmMTLk5oJDUQegxbRm7NgzDGsxkQl4aBsLI8FAr+g8
         TcVqeWQb3//v/PToP2E8rG5JtPRKKqBdnuxax+UMy4wfDnDnJmcv5VlSTObhl1+RzcLp
         niS1JU9+WxLydDNB78TQVB+0CmekPg4q/0ak9fI4o75XlSWD7Oj1dR8XYI7kq8MtTqUk
         TOiQ==
X-Gm-Message-State: AOJu0YwZQ1jxHj8kteattFLY/BzdOLmwYSHRZJrmkoQ3rHlP9hx6NJHq
	vOdt8DsCIn9UMpDGHaPnvikw5OyZ7Pzt8CszB2tpaaPXMyCAsnLSGsiqUiOuQw==
X-Gm-Gg: ASbGnctMkG6V1dRntNWgbg+Lt+Uj/gWtjScjU60y14LVzEetE7Fc2iBAwuDBQosCv/i
	eevEMbI+yMLEAfG1O2LIy/Is6vAvruhMcVOsvyWvjJnMABPaoyUjWKL84jshEs63ALyZnKg3zpa
	t8yu0Lq1u1QmQJBpJYYkiZfYFaNOfmS36YpzWFmaeqNgX4+IkUQmc24LK8AMKs6o3u5FjBsflHZ
	9F0MS3V0VtM4R7J5hSAPLkBa2QpJBKOU3Da4wPJNZ2abTcXMcbY7xgwaUH7IGOQJbfzafc9s2oD
	7Xtxvt+kYT1OWL9mbbNg5IurS7ejMj+iEMes1/HNW8x8ExH9XwK55DHEsY8hrqk=
X-Google-Smtp-Source: AGHT+IF4VW3fpyQ35gn7x1jalERyQv9XgNWlsNLX7Ld1bfM5TthDr1zUfSDUt99IZkg6XVXx0gdN9g==
X-Received: by 2002:a05:6000:2384:b0:3a5:2a24:fbf5 with SMTP id ffacd0b85a97d-3a5586f279emr2533154f8f.18.1749650555216;
        Wed, 11 Jun 2025 07:02:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4531ff595b7sm30862675e9.2.2025.06.11.07.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:02:34 -0700 (PDT)
Message-Id: <c65120f25704e9725c317a62b9a1231bd19f3e25.1749650552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1934.git.1749650552.gitgitgadget@gmail.com>
References: <pull.1934.git.1749650552.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Jun 2025 14:02:31 +0000
Subject: [PATCH 1/2] ci(coverity): fix building on Windows
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When I added the Coverity workflow in a56b6230d0b1 (ci: add a GitHub
workflow to submit Coverity scans, 2023-09-25), I merely converted an
Azure Pipeline definition that had been running successfully for ages.

In the meantime, the current Coverity documentation describes a very
different way to install the analysis tool, recommending to add the
`bin/` directory to the _end_ of `PATH` (when originally, IIRC, it was
recommended to add it to the _beginning_ of the `PATH`).

This is crucial! The reason is that the current incarnation of the
Windows variant of Coverity's analysis tools come with a _lot_ of DLL
files in their `bin/` directory, some of them interferring rather badly
with the `gcc.exe` in Git for Windows' SDK that we use to run the
Coverity build. The symptom is a cryptic error message:

  make: *** [Makefile:2960: headless-git.o] Error 1
  make: *** Waiting for unfinished jobs....
  D:\git-sdk-64-minimal\mingw64\bin\windres.exe: preprocessing failed.
  make: *** [Makefile:2679: git.res] Error 1
  make: *** [Makefile:2893: git.o] Error 1
  make: *** [Makefile:2893: builtin/add.o] Error 1
  Attempting to detect unconfigured compilers in build
  |0----------25-----------50----------75---------100|
  ****************************************************
  Warning:  Build command make.exe exited with code 2. Please verify that the build completed successfully.
  Warning:  Emitted 0 C/C++ compilation units (0%) successfully

  0 C/C++ compilation units (0%) are ready for analysis
   For more details, please look at:
      D:/a/git/git/cov-int/build-log.txt

The log (which the workflow is currently not configured to reveal) then
points out that the `windows.h` header cannot be found, which is _still_
not very helpful. The underlying root cause is that the `gcc.exe` in Git
for Windows' SDK determines the location of the header files via the
location of certain DLL files, and finding the "wrong" ones first on the
`PATH` misleads that logic.

Let's fix this problem by following Coverity's current recommendation
and append the `bin/` directory in which `cov-int` can be found to the
_end_ of `PATH`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/coverity.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index 124301dbbe2f..a5d99e59d4eb 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -147,7 +147,7 @@ jobs:
           key: cov-build-${{ env.COVERITY_LANGUAGE }}-${{ env.COVERITY_PLATFORM }}-${{ steps.lookup.outputs.hash }}
       - name: build with cov-build
         run: |
-          export PATH="$RUNNER_TEMP/cov-analysis/bin:$PATH" &&
+          export PATH="$PATH:$(cygpath -au "$RUNNER_TEMP")/cov-analysis/bin" &&
           cov-configure --gcc &&
           cov-build --dir cov-int make
       - name: package the build
-- 
gitgitgadget

