Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977313AA2A
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859271; cv=none; b=awvSqgvWb8Cshu/tZdU/GT0NY6Dix4tTGBBMTBJj1xl/Le9Y68SrrSFg1f0JkdCpHxQF+E6ACD6T4qutXKtE14gPQkXUfXp5lacpmZdXfhOon3qCCps8kKfEc5SQUDM6ZVEvODbCd+99A6MC7d+JtWKoWPoH4THc3Of9ZOnxABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859271; c=relaxed/simple;
	bh=HHLfIvMq0YlJJ2vb6iuWbtnEXmXfhTWtZ+HIKbZD0i4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YLQ6lCf/5H32N8ZFy9+xdzR/nUOnczv7qGJk93x6lqowgC0ACqCb7FTDw0z5xLvycc/oDhMob6sddQObsn2RG47B3v3QljKK+3/Tz+wEfikzk0tLUYtysWy3qGAFEXr/GsXMm70k7sIIOhNpFKLLqhSR2/ty+qeBe1wo1Lb1SU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IdzeMUXo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IdzeMUXo"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6180514a5ffso2021487b3.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712859269; x=1713464069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Geep4w4pC+uY0Qh8hJylMseeqyUBlhZmYVzdP+eCkEs=;
        b=IdzeMUXojFPk/U7f/3+yf3Upakz9NCZbs2jKApM+BQZp5AqihuUsicysZ+4C3kbM97
         Agqzax0Ebg1B6AF+4pDeqNVyuBboPKJMWUmr1yhA9esSa7q4t9ZffuaIo4y1E5IU0tvE
         HCvJFVCkFksaXlqJcs0jTG+rFXBAeQvtepdKafWL381hl9crLM3+V7HvkI7D2vuPDV1d
         08XXSVKoBtgg7eF8HTsk7ZoGHhc+ZuDxARV7P/2Ap61FmPF3db9C/2HsrGCdMD9hAfkY
         86KN1X+0Vk/ZUh3WAX+m8iirh4NeJ///kNyuoXmXnbi7ELTrOkO+jhgv52DWa1oCK90u
         ST3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859269; x=1713464069;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Geep4w4pC+uY0Qh8hJylMseeqyUBlhZmYVzdP+eCkEs=;
        b=tHBl3ZxWBAy2PcUkeYN0NDXsnnoJnyDjZo+CZV6MKJ2UnkrptGN2x8IbgvrOa6B3yb
         km5QQBMvGkqAuUFyqXmYcnqXygVcfnLxWt/WzuBW7Cy319SPf4B0FsdsFbVniqtTSQO/
         WHuOI2cEM04HSqi2KJAO+nn1+TWm+8jjNYuLC/Lu5VQAEXF5wcW+LwIxieNUAiuAhTzV
         yT8DJdZgbfOQrqybaMBRbax6TSmszI3C+FgVJaL8XVDru6EGFOHjsakUUMMx39Rx6JLe
         J43m4gn5yCGSA+JN3KV40bnFTADOpQOVQHpvnr/imPi8qPYh1mePVB8DbJXn30hjrGGI
         hcHA==
X-Gm-Message-State: AOJu0YwiUIi0Rim4EoivGORKzOPJ8nAef6E7QLaqy78PBd8bfrndVO02
	QIDavyXGENtXsszApVFqVVEq6ryww/pNP7NgYWXYHQFKqoIU4XiDjrvf6p0tpccwDpKfP/kOhE2
	/APFyqSI8HAAfQGJMzRqrwHySHsUB7c+dV0B08bgMiIDHGu/d5RhUpr2vJ8ZpCfcurQsxHYWGom
	3xtKAcr2orQzLMKu9WVy2lboSQpLEOVwmqT0G+ZXI=
X-Google-Smtp-Source: AGHT+IHuN+BSscvMj6MbZyhyp5eDi6V3hZR9YfN58QlPq5T9hGCJoHk8HGsuhsRDXsKrulEflcYYTusuZPVO3Q==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5d8a:5a85:8673:4f76])
 (user=steadmon job=sendgmr) by 2002:a81:4c55:0:b0:618:3525:2bb4 with SMTP id
 z82-20020a814c55000000b0061835252bb4mr794155ywa.3.1712859269112; Thu, 11 Apr
 2024 11:14:29 -0700 (PDT)
Date: Thu, 11 Apr 2024 11:14:24 -0700
In-Reply-To: <cover.1712858920.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1709673020.git.steadmon@google.com> <cover.1712858920.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <e55b6912725fa478134c7a67a9e4aeab7dca2c57.1712858920.git.steadmon@google.com>
Subject: [PATCH v2 1/2] ci: also define CXX environment variable
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

In a future commit, we will build the fuzzer executables as part of the
default 'make all' target, which requires a C++ compiler. If we do not
explicitly set CXX, it defaults to g++ on GitHub CI. However, this can
lead to incorrect feature detection when CC=clang, since the
'detect-compiler' script only looks at CC. Fix the issue by always
setting CXX to match CC in our CI config.

We only plan on building fuzzers on Linux with the next patch, so for
now, only adjust configuration for the Linux CI jobs.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .github/workflows/main.yml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 3428773b09..d9986256e6 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -265,42 +265,54 @@ jobs:
         vector:
           - jobname: linux-sha256
             cc: clang
+            cxx: clang++
             pool: ubuntu-latest
           - jobname: linux-reftable
             cc: clang
+            cxx: clang++
             pool: ubuntu-latest
           - jobname: linux-gcc
             cc: gcc
+            cxx: g++
             cc_package: gcc-8
             pool: ubuntu-20.04
           - jobname: linux-TEST-vars
             cc: gcc
+            cxx: g++
             cc_package: gcc-8
             pool: ubuntu-20.04
           - jobname: osx-clang
             cc: clang
+            cxx: clang++
             pool: macos-13
           - jobname: osx-reftable
             cc: clang
+            cxx: clang++
             pool: macos-13
           - jobname: osx-gcc
             cc: gcc
+            cxx: g++
             cc_package: gcc-13
             pool: macos-13
           - jobname: linux-gcc-default
             cc: gcc
+            cxx: g++
             pool: ubuntu-latest
           - jobname: linux-leaks
             cc: gcc
+            cxx: g++
             pool: ubuntu-latest
           - jobname: linux-reftable-leaks
             cc: gcc
+            cxx: g++
             pool: ubuntu-latest
           - jobname: linux-asan-ubsan
             cc: clang
+            cxx: clang++
             pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
+      CXX: ${{matrix.vector.cxx}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
       jobname: ${{matrix.vector.jobname}}
       runs_on_pool: ${{matrix.vector.pool}}
-- 
2.44.0.683.g7961c838ac-goog

