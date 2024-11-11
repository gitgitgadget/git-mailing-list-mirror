Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF5149C4D
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319787; cv=none; b=cDmepWTxsKavQhBSGc3CEtmbhOqZAM+LNExw0hM8riVQD6TqxqJz3bGfK9EgrpH44Oyrdu8dn+T+vYMrZ/x4rIOU/xioMRSm49En85V9AYakgsEvZGAgpMQO2tLhDA5N3DHvOBxP0kR3lLN+itgf1nwiSEkBg6iM4bW2/e6WWv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319787; c=relaxed/simple;
	bh=1Rvo1Lq/rgO47XyHtlDtsz/FZV+dXlHUN6TTTjng5is=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IoTA069FFjbEFxYop4/+o4YBJal0xyHDGTUCgC1crs1vaTDK6VNQQrByp5L1pWomsVlqT5Di/wuitAM+tp35ZskS4XLosN3nKelqZe6fpStm576/YM9t/V+k1em16ApAbUvgO4EftUH7BF6T8z9sQrMuHn1BdIGCeqWP6x38uJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRS34kGN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRS34kGN"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso33195545e9.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 02:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731319783; x=1731924583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3xY5lorm6Qfyu3um4RNDJXIGnbvtft5cvIJh9G4fXCU=;
        b=SRS34kGNEDy+ro+vTSk4oFStD01UxTz9NjF9ATfbGNG+kA+orHCwwkEEMG0dY8m4nJ
         ZwhooXn01OvObZPl+Gstkhd+6WOAISkGTBUwnnZdzq+PBod52TLLWpaU8yS8tuCMdXGW
         RABUHPO0Jss7vTljfEx3IF/gUKSu0lE0zs22Q1WvtnrZ4bcWuj0lMQiVUraH1OC+Dxdm
         XvmHcZGnOvUENKbn5siqKz6GL94R/W6Ptcm0cP3q4DGeWrfDrYWOmYgzidAzV48WDqsm
         f8Qii8XwLSqwA98045kt9wGIgOHgkxezdxcxJzuxRQ+QZsBJrDw4Zzs9QVTRSaaEJb7L
         k2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731319783; x=1731924583;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xY5lorm6Qfyu3um4RNDJXIGnbvtft5cvIJh9G4fXCU=;
        b=tpRVYA+WzJC7Ap6NJaw/XeRdmzAkvYaR1/4dFNmpXDXYQjflMlBS3ATYItzFDnIbU2
         IkCxKW4j72m3Rlj3Doj+Mkb3vnyW0Y30PlBARIYD+A07zduK6r0/tr54vxAsiCGNI4OX
         tLrljoow44yowDhgVwgK5m9L0oe1HYIh9RlnK8/XwETdPgy2hOZsV+L+PoKbL9i4UQT6
         1IG6uTXSAffcEMir72zI3jCwB7WUpzoIYcRyC1hRH9nYeCtJoKdj1Kuz/KZCBVgAA4cm
         3JgXqPtc4SWIYgmQPYOaWfBZlqIDvLjnpnE30VQt80ofakpCobBy8IjnRYdYTn+I9+xO
         TGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxDCU9YWBqzlJaOP3Jlb8kWJmMrlpFuhT3dsB3yC9WOZZ63Z+x4JLnGUqsGD2J9wpPnXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRz7J399VG5deRekmoFieQlQ4V/+poC7BNPRB3XS+SSiwwd5S+
	egLD0ktMzxp5r8QGX6hZXBnjAZd5h6rR/0bhKjKfRTQmkPPVB8MTRpGptQ==
X-Google-Smtp-Source: AGHT+IHi57dhmqO7R6F+w+ez9i2wGUYzT1zljU/XuAGVzuK+jFsF2C1C9jb3bX66RxmqzAjgCNkpdg==
X-Received: by 2002:a05:600c:1e18:b0:431:5d4f:73b9 with SMTP id 5b1f17b1804b1-432b751826fmr108178805e9.26.1731319783149;
        Mon, 11 Nov 2024 02:09:43 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158? ([2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5e56sm212055805e9.2.2024.11.11.02.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 02:09:42 -0800 (PST)
Message-ID: <2757e5ab-6fce-40db-b11d-af9577a66908@gmail.com>
Date: Mon, 11 Nov 2024 10:09:41 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/4] Build improvements for clar
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
 <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>
Content-Language: en-US
In-Reply-To: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

I've not actually tested them but having read through them these patches 
look good to me. While it may be a bit ugly to have an awk script 
lurking inside a shell script it does mean if we ever change the 
implementation of the shell script to process the files in a different 
way we wont have to worry about updating the build system(s).

Best Wishes

Phillip

On 11/11/2024 08:24, Patrick Steinhardt wrote:
> Hi,
> 
> Dscho has reported in [1] that the CMake build instructions for clar do
> not work well on Windows/MSVC because we execute the shell scripts
> directly instead of using the discovered `SH_EXE`. This small patch
> series fixes the issue.
> 
> Changes in v2:
> 
>      - Wrap overly long lines in the CMake build instructions.
>      - Add the VERBATIM option.
> 
> Link to v1: https://lore.kernel.org/r/20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im
> 
> Thanks!
> 
> Patrick
> 
> [1]: <3b2cb360-297a-915c-ae27-c45f38fa49b9@gmx.de>
> 
> To: git@vger.kernel.org
> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Cc: Phillip Wood <phillip.wood123@gmail.com>
> Cc: Junio C Hamano <gitster@pobox.com>
> 
> Patrick Steinhardt (4):
>        t/unit-tests: convert "clar-generate.awk" into a shell script
>        cmake: use SH_EXE to execute clar scripts
>        cmake: use verbatim arguments when invoking clar commands
>        Makefile: let clar header targets depend on their scripts
> 
>   Makefile                             |  6 ++--
>   contrib/buildsystems/CMakeLists.txt  | 16 ++++++---
>   t/unit-tests/clar-generate.awk       | 50 ----------------------------
>   t/unit-tests/generate-clar-suites.sh | 63 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 78 insertions(+), 57 deletions(-)
> 
> Range-diff versus v1:
> 
> 1:  23d84e6c50 ! 1:  832222f7f5 t/unit-tests: convert "clar-generate.awk" into a shell script
>      @@ Commit message
>           may otherwise be a problem with build systems on platforms that use a
>           different shell.
>       
>      +    While at it, wrap the overly lines in the CMake build instructions.
>      +
>           Signed-off-by: Patrick Steinhardt <ps@pks.im>
>       
>        ## Makefile ##
>      @@ contrib/buildsystems/CMakeLists.txt: add_custom_command(OUTPUT "${CMAKE_BINARY_D
>        add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
>       -	COMMAND awk -f "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" > "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
>       -	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
>      -+	COMMAND "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
>      -+	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
>      ++	COMMAND "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
>      ++		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
>      ++		"${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
>      ++	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
>      ++		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
>        
>        add_library(unit-tests-lib ${clar_test_SUITES}
>        	"${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c"
> 2:  a41b1f4746 < -:  ---------- cmake: use SH_EXE to execute clar scripts
> -:  ---------- > 2:  38601f7bdf cmake: use SH_EXE to execute clar scripts
> -:  ---------- > 3:  146ebd3841 cmake: use verbatim arguments when invoking clar commands
> 3:  01c1c51e6a = 4:  341c831192 Makefile: let clar header targets depend on their scripts
> 
> ---
> base-commit: facbe4f633e4ad31e641f64617bc88074c659959
> change-id: 20241108-pks-clar-build-improvements-1c3962a9a79f
> 

