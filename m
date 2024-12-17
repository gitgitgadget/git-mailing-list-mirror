Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE01F8F02
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456732; cv=none; b=s5TSH1HTl0jQJ3pHOgNBV0y1cS0SrfSEBTHIfBwLWX49igzeQdTdsIhrL2JFS89uy+jYOfpaBCPqpkFqyF8VCsJvjknX5q50N9FzMwFWJu2jgWPuX3NPLb/4EceH0OUlo++UgM+J15aGX1FZqv8t5V33VHtkDiLsYdCu8om57uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456732; c=relaxed/simple;
	bh=C2cESSgGNnQgEaWwKXEfkHQO6Aeor5OmO4Jh1oJ5tYA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V1z3KTlE/xEUsXQ56Yn+u8wWD4K2Ozk64J4udnEfo0W32grkYAL+pyE2Q9q0G3lAsV3tCFa7CBRpHq5nyl8ULKg1ug33v2kCwY0BOCjgtLx02U65zQtPs1Q6nj3RAvS6YI7o5gDOilzT3I4UIOb0KSQMElY0eA0Q6XBoHcclzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXe5tt3V; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXe5tt3V"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43634b570c1so27881945e9.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 09:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456725; x=1735061525; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04q9NqqvW3HGbGsohWhTVicn0hqFEUGD2yemBcvOq7A=;
        b=VXe5tt3Ve7L0LZ4m2PNKaDsxixfVfv47PmHsaz9vNuJ4VdKX1PulDWWThlZqD5IROd
         GVFsZgrdjfd45L5/ZFAsl62kHwMxxiNafTwziqIlyL+YqBAZjgm/J0Uz2Q6R/jOMBPcu
         cwA7kfLruYD6DTSIM7PLKtzW3XmDK8GymEb7sY0g4fvZwlrYak8Mq2ODX0JRH5StyHsx
         naSYI5UJAMXY8iS4CKkadKb/BUm3nhxTWFIUyL/kCfBmSoraHvGsT7HiE+aLmLvDYHLL
         jPIwtnGJdTXg/W+u8OcNRT9IRA7xoFGTyDhZScBq3JV+COV+QoEx3toBxJNfCw/BnLm5
         ixkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456725; x=1735061525;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04q9NqqvW3HGbGsohWhTVicn0hqFEUGD2yemBcvOq7A=;
        b=uviOTq59wDzFpoWLIdCDNS0Y6TEnYftMbNF4b4BU91qnoPtZI18WP6PszUp2b99sam
         ncG53hEYKRw7bDsy2C5a++YL8zaKxO6j77NqjqqX1GUzq4jxXTJ4mu/eKWD61C5cvnQS
         TIcCfJkymn1xE6w0DfA8jq3NAW/vvFXp4QVlOrGCBcwOStNwAe8wNFjNOxLZWzWJZX1Q
         u5FfgXCScu7RJqQFkNYefI3U3K7l10nSWb401wLevLmSjPYSmuniKcFXfzvKFwRtSetp
         xQ5I2CvqTZA1iZYrLyf/OBsE526lmb/GU+LhRaEuOjtcn/rG1FIBl5YADKy/IE9FQM6A
         u02A==
X-Gm-Message-State: AOJu0Yxrgi3AAteKztWA28dOyrYwk7jIu/kw/elYQL6stA4/V9duxM8a
	aJpw/SVQxraSgpd4S/sMZGqsLbb3wSpG3sea1Sq7P45WyicNCGZQLd5YnA==
X-Gm-Gg: ASbGncsy1j6TwRVCWd0zO3gElM0prSIovF4zcpz9PiUQ9uSYk0HjvlshsP9if3ADFUH
	GzAcpERtkHA49Lj33jlFnKyIyFvADfimsHySTDt1+waR8DLMikSmDrsfSh+Z60+xsRBV2Na3XF3
	BysfU/ty4YY4uGAHfM5J6YjNy7kLyBOOp8Qo4kLHpBKDZZvxczLdxBMEmALuaa2961v+3ocR2NJ
	FY+ifObasxmZZJxSrc3ynqUBueMMAbcWC+gUojF08GW7IuiHFUAj0LPjQ==
X-Google-Smtp-Source: AGHT+IE+aRua32MlQeG7WhWJBz12/RXnFxx5QmnP4otAV1LyfWU9wKT+HPcKRpKvgdBG6w0ZwyZ23Q==
X-Received: by 2002:a5d:5984:0:b0:385:fc32:1ec6 with SMTP id ffacd0b85a97d-3888e0c081bmr13580835f8f.50.1734456725275;
        Tue, 17 Dec 2024 09:32:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c7fac5bbsm12114031f8f.0.2024.12.17.09.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:32:04 -0800 (PST)
Message-Id: <e687da666eed9a25a717ef6d09cd0f471610b835.1734456721.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1840.git.1734456721.gitgitgadget@gmail.com>
References: <pull.1840.git.1734456721.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 17:31:59 +0000
Subject: [PATCH 3/5] cmake: use the correct file name for the Perl header
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In e4b488049a5 (Makefile: extract script to massage Perl scripts,
2024-12-06), the code was refactored that is used to transform the Perl
scripts/modules to their final form.

Even the CMake-based build was adjusted, but the change used the file
name `PERL-HEADER` instead of the file name used by the Makefile-based
build (same name but with the `GIT-` prefix). Let's adjust the former to
the latter.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 3dd6b3a130e..6f35cd66f39 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -867,7 +867,7 @@ list(TRANSFORM perl_modules REPLACE "${CMAKE_SOURCE_DIR}/" "")
 file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
 string(REPLACE "@PATHSEP@" ":" perl_header "${perl_header}")
 string(REPLACE "@INSTLIBDIR@" "${INSTLIBDIR}" perl_header "${perl_header}")
-file(WRITE ${CMAKE_BINARY_DIR}/PERL-HEADER ${perl_header})
+file(WRITE ${CMAKE_BINARY_DIR}/GIT-PERL-HEADER ${perl_header})
 
 add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
 	COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
@@ -888,7 +888,7 @@ foreach(script ${git_perl_scripts} ${perl_modules})
 		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-perl.sh"
 			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
 			"${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
-			"${CMAKE_BINARY_DIR}/PERL-HEADER"
+			"${CMAKE_BINARY_DIR}/GIT-PERL-HEADER"
 			"${CMAKE_SOURCE_DIR}/${script}"
 			"${CMAKE_BINARY_DIR}/${perl_gen_path}"
 		DEPENDS "${CMAKE_SOURCE_DIR}/generate-perl.sh"
-- 
gitgitgadget

