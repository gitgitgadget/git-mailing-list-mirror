Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06E91D554
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731249065; cv=none; b=OY0HzdOqwoLXhc1+mQpZcB/TPwIauYn63SMS0ViuEjOTOUXGVgbaW4mAZnWZ7W2DmA4AE6oOSzjs2AE2zcbTuEOvA4QqyMZAHBfg9JKZPmCX5CBsw5yQjArt9pim3hH2nwG2kLMDPrjqCVvmqLQWJ6VeYg3koojPLJ4w+JrEFnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731249065; c=relaxed/simple;
	bh=a0E81GlhhMCwcoKRpd0ltT+9/CuAGbmvzv++DTjNIVw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GY6woEJ+Cys5HpYSupk2ebmmJPmPRKsn3pxIFB8jcXOCUMDtxLvzJr++LFZHO7SISpkBjnHhxnvBCuAENku1pVqTxhiKOqmfygcyV/ypXdTGN1Ws9/NmhhdxtXi+3rGaWmf56z1nFxvYOMDlCpRaWOp3vgw8UR1CD2PWQuk7pFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOsV2/2p; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOsV2/2p"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so32358305e9.1
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 06:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731249062; x=1731853862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7b9dwfKmpFTnAlq8G+R12cAfyGXrtX/T0dCWY2oDKyE=;
        b=jOsV2/2pjDQKcik5kgJ9o8BHi8HXMEc2cS/RR9NMcrxbKz03GhYPZiKg/FK/cOOD7d
         M6stR1lxqlcw7S6HobdZunbBLupS6yVQlJpkLUJCmRgTNZmFhMe/jaYOX6DfbtCaQusP
         Y8ptdjkXnlMB7ONr9Go/LR91x9PMpF9jC9aMHIiP2IHJ1uVxsexK903wLShhyo6FkHYu
         TSkUUWODceINIj9VTnKeGnydkSzWNdQdEAyN3Y373sZpIOZEqjfcQs6Qx3CqxeE7fGpG
         ZFuXr7op//m0FNKSx8B2qNI8qRfAXhrz4oR4tSZpiyV1rFCVrR5O+f9pjPYh8vXPXz7V
         7+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731249062; x=1731853862;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7b9dwfKmpFTnAlq8G+R12cAfyGXrtX/T0dCWY2oDKyE=;
        b=xUjvlwgmshW1mXvsYkdk1YHig01msNSUzpTRS8R6vYUcnHiMdwhkEQ60UyEc+tNXUu
         FLC9LOBEWpZmG5/ZLsdnGRh7wrk//ewiXM0YRpKQtBSQyUIpfZ/8MDZHlpSgUrAMG6Ve
         DLHeEJbUip72f78+34BEPndljlX78Nq5eF/B1YSlo3CGDA6RZWBz04gEK1pWCmsk4G2W
         7+IOky1yc2RHhOHBaurKdN7hcF3kzR2RZJJl0fGe+Q1XC5RydNlxFgrQJ9JmVAKVppbg
         xQQInKrWx4FHcCrl2z3/NFa+301TiaQaK9MOR0f5ijnHoyp3VHZovSO/fr7VaGqRkIQo
         7WNA==
X-Forwarded-Encrypted: i=1; AJvYcCV/6/NiX8/aE8l816Q2bJkS8lmFMEJMiZXJKe3RzoA2V3VWXVMk47b/S0Ym7LDciQwJP8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrgOW7NinMigv94jeu4d9TZBv8GJVN95nQGYb+Nytwe1QHzF76
	DFL3C6f3j+14lcGwDFglfDu76+0N8KpPN+KenMs5vEZSvOi1MS4BX83FJg==
X-Google-Smtp-Source: AGHT+IGx2s6NBToLAPpPzTZ/a68JaF5VIIZCK22SNAoU8vAUuIt2YMZTeKld7JPi8ocDiDGKEQbdCQ==
X-Received: by 2002:a05:600c:4ecc:b0:430:582f:3a9d with SMTP id 5b1f17b1804b1-432b751b68bmr85613345e9.26.1731249061535;
        Sun, 10 Nov 2024 06:31:01 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158? ([2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b053051fsm141188405e9.6.2024.11.10.06.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 06:31:00 -0800 (PST)
Message-ID: <890b423c-9756-4e1b-a6d0-3990f1091f5b@gmail.com>
Date: Sun, 10 Nov 2024 14:30:59 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] Build improvements for clar
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
Content-Language: en-US
In-Reply-To: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 08/11/2024 13:16, Patrick Steinhardt wrote:
> Hi,
> 
> Dscho has reported in [1] that the CMake build instructions for clar do
> not work well on Windows/MSVC because we execute the shell scripts
> directly instead of using the discovered `SH_EXE`. This small patch
> series fixes the issue.

I've been using the CMake build in Visual Studio the last couple of days
as my hard drive with linux on it died. I ended up with a slightly
different fix using "sh -c" rather than putting the awk script inside
a shell script. See the diff below. I don't have a strong preference
either way but it would be nice to fix the line wrapping and add
VERBATIM so that paths containing special characters are quoted correctly

Best Wishes

Phillip

---- >8 ----

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index f0a1a75382a..b8a37b3870d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -989,11 +989,21 @@ parse_makefile_for_scripts(clar_test_SUITES "CLAR_TEST_SUITES" "")
  list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
  list(TRANSFORM clar_test_SUITES APPEND ".c")
  add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
-        COMMAND ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" ${clar_test_SUITES}
-        DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh ${clar_test_SUITES})
+        COMMAND ${SH_EXE}
+                "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh"
+                "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
+                ${clar_test_SUITES}
+        DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh"
+                ${clar_test_SUITES}
+        VERBATIM)
  add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
-        COMMAND awk -f "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" > "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
-        DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
+        COMMAND ${SH_EXE} "-c" [[awk -f "$1" "$2" >"$3"]] awk
+                "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk"
+                "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
+                "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
+        DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk"
+                "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
+        VERBATIM)
  
  add_library(unit-tests-lib ${clar_test_SUITES}
          "${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c"


