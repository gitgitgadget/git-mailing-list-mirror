Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AF711CA0
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731249413; cv=none; b=Ui2ajn50b7gebjAIwBRcRQhCRlUlOks1pVUSelEHj/5/g0sc9Ed+PA8Y5785zQEoXCQSLw+k1fvKJbR5m+RGn/kGngNKSxnR12NRKnQJKvazPtd2KJoP9z+SMhZPx8gglhjoaIJzs4HIPP0j6HzBszfgSRsi79mjUZ/qoagM/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731249413; c=relaxed/simple;
	bh=oj+CcXutlBgID0wD6lZ7Tsh0QBXTOmp3y4lPJn3EiYU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XieCFWoR4GRnPdLIbViFQdtED/PI6FXc86ReDS3w8yPlO7oaEZUyTYJ3fRCao7EFihaWZ9TMhuoDTMw3Bo/p3Vs48/U2nfRf/2zBArnmi1Dc/ET4ncVGfLzQZMgoVkZrThJdOl06Nob4aM4q1IoMo7L2kxfu2rOhRbxu8jhTbdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjVm1yMV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjVm1yMV"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so2223966f8f.1
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 06:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731249410; x=1731854210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJp+mnrzp1haPKIAnhTnc7sFSV9C8zfpjgmSyVNjvRo=;
        b=EjVm1yMVazHUxRiJaDD/gzn+9+x2R+aCQNnHuzG3yhf4ohcxsw5S/trV0tRZBiB1sW
         gO1ViXU0OhqpsXWj3H/g5DjfTeiKghD2ehUpjW/i/W/OYoLsydZyDuHCdAPJxSQLuoTt
         8mFrwPlvshPjsUrNYzJ2Y78Ntz4BD3Kkntc9iKSgRcRXU4yzQqtP2qKYCaHOslSrwOyT
         Zqh5kMdat2uN1Eohxa9e5eRFSlotveYr4sTES3KLI/6LAo1iqxBv93qtH3A0TsQgxDIB
         R30PpfjD7wubJMcn/s28yCqzy/z3AqgotoUTl8UcQPD61GSfLHBnarhl4P/j1maSs9K2
         HCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731249410; x=1731854210;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJp+mnrzp1haPKIAnhTnc7sFSV9C8zfpjgmSyVNjvRo=;
        b=rI88KoM4QSqsOzsR1U8HeI/+DYFiksuOBL8pSilh5Z3mhRNx8nDFmxYo0RKxPwoC0E
         9qNJILakTtcuOkJAPL8MQFzgWyAt1b7dv8gx5o/pryHw6uwC+OWV27kJxPImBMqhSgoF
         1w7Pb5VJ0qOkcEqpf3guwNn/z7nP0AFj/fUuoTLtpSt3FABoDoV2sqVhLVCxpuaqIOn7
         4dgkWPjVfYXdsVlioZbvOTm0JH/K94q99IMy8zKlHB2dKsiToZyq8QXn8ztDfmzm4CYN
         3OA5ujD3f7xK+MJlL4osal9boC9mlVwdxQAZfPr4mWD4e2f0jTCoBFlwhneLPdLGBUcC
         Y/fw==
X-Forwarded-Encrypted: i=1; AJvYcCWCl6GdbTm4745PW9MM5Nmu0qcu2WCVmNTaCJDJVecu9kpHAP3ZPC/5GWDPdIeMPpFpTvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4WgZcW9iUNNArj/npZGHB85jhYDSoMaLHEROpPIR0Y55giT7
	AxclTjZIIsn3ZbhCtS10ym7KXSaFMIKz384JnSwrBhF2QuvDVBPl
X-Google-Smtp-Source: AGHT+IHNTM6uMOdOZicSi3SmPJp2o13kFV/DeyliwOUZHLZ+I2xb86ldNJsfyMIeNntiDab5h7iiWg==
X-Received: by 2002:a05:6000:1fa9:b0:381:cfea:2818 with SMTP id ffacd0b85a97d-381f186d156mr8158455f8f.30.1731249410227;
        Sun, 10 Nov 2024 06:36:50 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158? ([2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b04753d5sm148940655e9.0.2024.11.10.06.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 06:36:49 -0800 (PST)
Message-ID: <c2508eef-bedb-43dd-9d4b-7e980d4ade37@gmail.com>
Date: Sun, 10 Nov 2024 14:36:49 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v4 04/19] Makefile: extract script to massage Perl
 scripts
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <50b607a412afea051a7839b9f3f1b4519b58721a.1729771605.git.ps@pks.im>
Content-Language: en-US
In-Reply-To: <50b607a412afea051a7839b9f3f1b4519b58721a.1729771605.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 24/10/2024 13:39, Patrick Steinhardt wrote:
>
> +	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/${perl_gen_path}
> +		COMMAND ${CMAKE_SOURCE_DIR}/generate-perl.sh

This is missing ${SH_EXE} in order to work with cmd.exe on windows when 
running the build from Visual Studio. Also do we want to quote the 
command arguments in case there is a ';' in the path - we seem to be a 
bit inconsistant in about that in CMakeLists.txt. Also we should add 
VERBATIM so that special characters in the arguments are quoted when 
generating the build rules.

Best Wishes

Phillip

> +			${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS
> +			${PROJECT_VERSION}
> +			${CMAKE_BINARY_DIR}/PERL-HEADER
> +			${CMAKE_SOURCE_DIR}/${script}
> +			${CMAKE_BINARY_DIR}/${perl_gen_path}
> +		DEPENDS ${CMAKE_SOURCE_DIR}/generate-perl.sh
> +			${CMAKE_SOURCE_DIR}/${script})
> +	list(APPEND perl_gen ${CMAKE_BINARY_DIR}/${perl_gen_path})
>   endforeach()
> +add_custom_target(perl-gen ALL DEPENDS ${perl_gen})
