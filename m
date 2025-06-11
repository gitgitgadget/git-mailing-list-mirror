Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369C1DF994
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657285; cv=none; b=DW9uvDytpiq2G5v5qRrFy0cq2eHg/CWRwR3sqT8+TjtmzXsE37hvmdzcMoa0IfXPbraJz+qR1L6UKrcbU2DN/7y93by/BMb+3+LifznDsVawMJBKGs2bPC7OTOlnpCDmVQrmR+FEojIxWyjLU1y3gf3KbvjeBDqPRhxfBpx6bD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657285; c=relaxed/simple;
	bh=2Jxd2nu3wvqKnG6/NaZoludnuT7rwDD3SzcxdS5bp1k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QvVsBO6xu3Y3r9cg5WA3t1bqUgFVOZ9GXrM+7oOUqr0iB+04QrxRIVhuTpntKWg8h7FOrZIk3xRYLfubx4osByrLU0MMJlSpTUSuxluWWSpSyEoh/LOBqvv4lo9qNyT5Wy5JePaoXr8v6GB1Eh86+bKMiQ2d9vieiv5suiVls+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwnO4VHa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwnO4VHa"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a5257748e1so31373f8f.2
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749657280; x=1750262080; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0tEtY4z5xnC4Pr/PMFrpPt5i6keCJbzyfMpPNMaJFI=;
        b=JwnO4VHa+x1gnjHyWgbQ0e5ZiiJX31i/ehAbEgb5YPxqBOZwUjQsrGRt/O/5a/1UlC
         AomEbuwA8h7bmCYzbRw+cABVxVIpQwWa9WT3tvXb9zcw8vQDtgxoJtA5wkYmjgFq+qjr
         zRu+ydEAmmehXzQtl/1Hkpg8HS7PoW8RjYHfv8AGETTSx9vJjEbzLc7hswfa9IXrNyUz
         38wukx5J1L4Codp1Ko6oYp17bNpF6W6UpeeSKd6RP2yRoz4hg5GNLxHH1Rvfe+L5gFZ9
         t52SnK/4lRMHkLCV6gAhsfYv6C6lnBd5RDu33VUzjBStexwC7KgRc0QMoPKs0L66zA6L
         e2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657280; x=1750262080;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0tEtY4z5xnC4Pr/PMFrpPt5i6keCJbzyfMpPNMaJFI=;
        b=UmbF7oQCjicEOlmKdqD6uec3ZptDjPxKPUjctWwpq2aovMYJ0OYJ8NR4Sx/A3ymM5h
         gXAEG/WU8D9QnWGF0anMRlh8V5GTLk/nb69O46KwimderhMCzRS3XbPquSvvjApjj8Tl
         rX7f9OMpi9vjoTTZWSt+TC7zRpB6Wc0pGEYsQgFOanflF0voGczTiY8ZpQD7QQ9v0kmA
         i1AKoPRXNTE7kQWQBTMDElCtOl/Q11yI4/QVmVoktOmQWGxmyJJZF9noR4LpHmrp2zz3
         TnFEfhyTKWRKQQtsj6ZjgSbzdv9c9DZSqUADt7VNO+yqpVUv6IFlPCmz4ZS18SVQsT8k
         YzKg==
X-Gm-Message-State: AOJu0YyhUqUGNOvsAvsWh3KiZKyzSyK4MDplh5mXpgAIRr4WY22ws8xO
	6cH5xGBSmgn2sEK6vXmNV7pNTyzjQMp1VIRdBqOkYacdgOglZAwgAutKSV2NcQ==
X-Gm-Gg: ASbGncuPx+9Ql1/u3bd98XE6QNLAqsCNc5Zpk6+CRfzPEjYrKEYen71Mb/n9h9ffqKz
	5xfylPrTS0maLmQyg+xcsd5nepfizJC+7s4OwAzsg4QAM6odyrbghMesvu/PVlBBd9VcuAPKBn0
	6AEoHTcie2H5DtlDQ0nGsxoz7SZtF1GNZp/Ft8dJJ95LUUSPU8JIEFfMAa3DqWqd9zPfnAeIx+H
	t9V4++c/7QSx9rZyRjgxRJiu/qJVaRI7vXImG/quec7+Wq6m4VeYX55AZ2LHU+jqja1h6vkqewL
	xrn2+JmLcObuoUhF5AUF6x6JpWyv1iWPQQwaiTvhb0qgvUK1e9KpKlwOWULIQ5I=
X-Google-Smtp-Source: AGHT+IES6rJYaGsRwQrDGyj2OVe824RelKzw+v9RtNhUidrjZhZDEZSr0GlAr39qFhtoQLGh1vSFtw==
X-Received: by 2002:a05:6000:144d:b0:3a5:3930:f57 with SMTP id ffacd0b85a97d-3a558a51bd3mr3142095f8f.51.1749657280025;
        Wed, 11 Jun 2025 08:54:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323ae18esm16121278f8f.33.2025.06.11.08.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:54:39 -0700 (PDT)
Message-Id: <712602c09e451c6c95b49b74c543817fd7477507.1749657278.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1934.v2.git.1749657278.gitgitgadget@gmail.com>
References: <pull.1934.git.1749650552.gitgitgadget@gmail.com>
	<pull.1934.v2.git.1749657278.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Jun 2025 15:54:37 +0000
Subject: [PATCH v2 1/2] ci(coverity): fix building on Windows
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
index 124301dbbe2f..d8a0497d596d 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -147,7 +147,7 @@ jobs:
           key: cov-build-${{ env.COVERITY_LANGUAGE }}-${{ env.COVERITY_PLATFORM }}-${{ steps.lookup.outputs.hash }}
       - name: build with cov-build
         run: |
-          export PATH="$RUNNER_TEMP/cov-analysis/bin:$PATH" &&
+          export PATH="$PATH:$RUNNER_TEMP/cov-analysis/bin" &&
           cov-configure --gcc &&
           cov-build --dir cov-int make
       - name: package the build
-- 
gitgitgadget

