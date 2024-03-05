Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966471292D7
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673127; cv=none; b=KXKndJsemyXvB6ZCYjlrWUv0uDsNV1WNXbyPeh0mqSqU89RD6uNIwHitHEyn75k9V2vWTg1q/Co9umb5VSX2p3yVbZcCP3suvAJZhfa7W8cXHdb9FaZw2IVGkiRRDMzjTgBA/AjL8/e6138HmHj5H5RYoeIozlwe0vpkh0kIZb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673127; c=relaxed/simple;
	bh=V5fZIdGyAGDZjW0fbmRAx2NXnDcg9dXu8FQ5TFCyiXk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pEb337d4v+/sScvscbhylgyueZjAuSuCPUVSGeOuC331c/sERbdaTjafYz2TqIlOi81GcD+9ZbKxh+E25JSJZaFESuZJMx4qqCxq69qRAUNbHQnLLeP2wD6BNOl35s6h2s904VhHXwoD3ip6As3gBd1ejItDbualEKl6HiFzUTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EqYcXKLw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqYcXKLw"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so9618120276.3
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 13:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709673124; x=1710277924; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JoDUOg6wmjp3/iVdoBlMh3b4WMqNmr04zrXUnpZzX/o=;
        b=EqYcXKLw63+sT3WuttQvASFMGC/s3TH6Q+mGgHvynEtk5L/eLoiftY9LfyQ9dDmejI
         KtFZPFveMMgwN4sv21+aMIZbTXUELOhoxLgpJ8G9aki5TW7ivmKMXeR19i4Fgj89I5AK
         0ETWqE9HCbttKtbnndBSJm4n5uVepOko8jj9gT/UaY3ujYMSyH0RdyDJABC8hnPx/Pr/
         39QYBRtrcjWQkeLTDb4FD/HP6Y51SKPwUrVNKFhhSswe9PTGrzeFLsJOnnP2pQgMafsG
         RQDukrQpm4+v6jqpTbCCwLv1yUkC384k1ubmQWJGj8mraGV0+lP5P6go33yIA1/YdgQI
         ZSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709673124; x=1710277924;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoDUOg6wmjp3/iVdoBlMh3b4WMqNmr04zrXUnpZzX/o=;
        b=YSXFVWh55dxAR4pvHcHgKV/G49D7mLPi33uCpWtUjb6+w06WWgSTm356sCBv1idciZ
         l1GXDyjQTls2UPIPKP/dq1sN0GTiOvFqZist9t/e83TTaJk4s9iNqdju01Y86Sfrevp4
         vIIBsww4GalSuIoEqyguopGEzEOBQEdEdNXj0sm7p+Ur7sC6+3CNu2as9OzvaXI+jIyJ
         EclISEfj+ycLG3kvDv++iQ06zZDMpvF2hWO/idsI58y6DyM5XaQL/Re81Ax4vGgTlANe
         IMcEOPOlradMWwfLahkt+Lcefn8MRJHZmRtoKpQXtmpPaYskKv0aFZ5Wjp4UFDotlNxu
         8Agw==
X-Gm-Message-State: AOJu0Yxo2pl+OzO/waA7C8y46Lt+u1ozAdxZOV7XsN5gLpsZkb5EsztN
	LE5knuKSy9DctLFAAekc/N4n0FDXPJHRpD0WLAgwWC7lWDw1KzfO5Phqx78yMWbjpeKARw6D3kx
	td7KPTAmr2c8r7YRVrHt/771a8j2f+cBWDALMvIRutrGNbYwOpl7IjiCnCZkcnr2ELvbnMA72uR
	WtLVrSLcXAXOf9Z0hfC+kXUQqSe/OT6c5MfLbo8/E=
X-Google-Smtp-Source: AGHT+IH9adYDu+xLkeVu3zvAhLAgNQdSIvN+7igBXIWZrdcmxWVXZnGz0GQMIX76vg7dKU8tgeImMz0Bk8eH7g==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:f9ac:5d54:eb54:107])
 (user=steadmon job=sendgmr) by 2002:a05:6902:2187:b0:dcd:3172:7265 with SMTP
 id dl7-20020a056902218700b00dcd31727265mr2645685ybb.8.1709673124541; Tue, 05
 Mar 2024 13:12:04 -0800 (PST)
Date: Tue,  5 Mar 2024 13:11:59 -0800
In-Reply-To: <cover.1709673020.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1709673020.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <75f98cbf98005b0a069977096ec5501f2f7830fe.1709673020.git.steadmon@google.com>
Subject: [PATCH 1/2] ci: also define CXX environment variable
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In a future commit, we will build the fuzzer executables as part of the
default 'make all' target, which requires a C++ compiler. If we do not
explicitly set CXX, it defaults to g++ on GitHub CI. However, this can
lead to incorrect feature detection when CC=clang, since the
'detect-compiler' script only looks at CC. Fix the issue by always
setting CXX to match CC in our CI config.

We only plan on building fuzzers on Linux, so none of the other CI
configs need a similar adjustment.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .github/workflows/main.yml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 683a2d633e..83945a3235 100644
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
2.44.0.278.ge034bb2e1d-goog

