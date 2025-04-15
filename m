Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B4297A67
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723728; cv=none; b=Lp2zmhy5ngK38J1PnzNdDjiuq0M7dPzUGxwNg8Q1ZLbdkx1RrXkrKs+hlR550xss8SXC0sFO+vZboQYgA1XnPuNP2TLLBis1mCcnnEG+vygRVUDcQwHjxj2kboXJN0ZxuLbbHfgDW6vsdRoCHxWRpBKLO51wtobTMT12p/pdWL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723728; c=relaxed/simple;
	bh=q9IQJ+P1fO5SaSVOHIIDFfRPHzQUo62RaXVGYpwMF3M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kTQIpJDkiVgurx2YWV2gL84C8lHF7AgRDkwiLmRRe3CuqfpqbihyrQiJLA4Gar3u4JuGQURsEl87vwaif4NPQ13PQQOitnd92E0DOuT5ec3Vs6kqWCB6eGIn7yurA+PnMlfc3OyUsIBjCaTmAwrg/0SzkcWdHBg84amPHiIQ/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApYO0oAc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApYO0oAc"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-399749152b4so3193633f8f.3
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744723725; x=1745328525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpeaJN6dcGndJYlsyWHCFiRFduk3EiawyhKDxXkXWmc=;
        b=ApYO0oAcU852sr7MONRjrJUHIw20RwOD/nPiCqs7hl7ObNWgiL793DxgrxwdITdmHz
         EGJJ33FueN5B0gLCaTXUduSn3xKkr8BKmjS8GgvUx+7aRuZMiHvFN1OACwvyHBHTGB9a
         dFJoyO9oy2K8uSzPLrBKtdklSfhtvGUslebiKV36P3qPap8uPt/79GSyQO+hw5KDnJMC
         Fh3OQrYLsgetOJoreydK2ggoOE/yme7Eqkz4rmOw6pnc9W7rdZgDJHJjKC4Tky3WmdbK
         mM4oCGRUwvdWat//lyhaosCldmwcBJP/H3yAgrr1oYXXIzTFCrwLJWT/FzQDmB58toYf
         5V/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744723725; x=1745328525;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpeaJN6dcGndJYlsyWHCFiRFduk3EiawyhKDxXkXWmc=;
        b=cBhEa8rVlLzg9t7Awvc8Iamyb4JClWpo/CkN7Tlth9MX21Ix7tdoj/F3Kx5kM4a1/T
         vfld2prdKOHOUmB+vA+aQhbYHTTYd1lPZYkK0K+b8N2Cldh5d5Qm0kWm+3MNj7saf+su
         5zi/X0ac7TrIfh/Enr5VPlqavTC9j8Hd49pu61AdtkA7ZxPac+QPcdAuQ7L5kDHgaVEb
         bQqtxegGbxs8nq3QLtcraAPLiEcc2aDmrOQW7tLQ7D9rnLKJt9+QsqzghbyOYgK6i5cR
         fAW+8661JelyHqvJRRkCqh6FbbaDaJ7QfQj1l154dezjjWQnYc2k9osQuZl3zFLPezIp
         +OzA==
X-Forwarded-Encrypted: i=1; AJvYcCUN78i5xsoZoZ7Fk7pfbBb4X5/Jyaz2FxOoS4Bibw/+87h7lOuiL1buqxxNibfBgrDsNzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcMRvh7k1rNy4xLcPkP2aPiz8R/rPvRNxT0u/fUrgPANiI9m/7
	CHt8cKMu2PUbaga+96M5qTPko3gldhBEoGk3dtqx4wq/KhWsVLSh
X-Gm-Gg: ASbGnctIGWsToC1RJhgSXYSqHtt3PLDGc9QSAi1AZlTYm7gLfBoUJ+HAYOKvu+eo47x
	Is750l18eH/kfP1sP1Fk8erFFQGi5VaHrxfZagMIrKZXXT8aEC+nWYX1qsNb2KamC0zHYlWs9cL
	4Sts3HmSgjAPyUhSqe/xt/Dpnwj9HguUSkTuDvqY1335+71N2WZJSKutrr4rIcRfy8mU7XuVwdG
	K5Rs4FM6VKu3ErscyFXo/qAojAoS/GQbmH5vONs7AFRDGg6jb1MHXL+PvuLMl8kTeZHbJZjtAbr
	qDHt1HQqeYnL24yjdlXxXA/Gk91STEydlU2PRkhEgujcXqF9MlLbKZ0CflAFzVA/Reyym/AYVXM
	J8GfMVqk3GU9nwlN8
X-Google-Smtp-Source: AGHT+IEUvXT/XffQDXV2WRPTO2mmyeyoHCyYERGnXfXGCg/e7Vu0MWJKN9zpw4vaNN5xsMMaADzXOg==
X-Received: by 2002:a05:6000:21c3:b0:39a:c9cb:819f with SMTP id ffacd0b85a97d-39eaaecdc4emr8360727f8f.37.1744723724869;
        Tue, 15 Apr 2025 06:28:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f23572c4esm212009245e9.26.2025.04.15.06.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 06:28:43 -0700 (PDT)
Message-ID: <958aee61-23eb-4562-af9d-48108e6fe581@gmail.com>
Date: Tue, 15 Apr 2025 14:28:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/4] meson: add support for 'hdr-check'
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, ps@pks.im
References: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
 <20250414-505-wire-up-sparse-via-meson-v3-3-edc6e7f26745@gmail.com>
Content-Language: en-US
In-Reply-To: <20250414-505-wire-up-sparse-via-meson-v3-3-edc6e7f26745@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 14/04/2025 22:16, Karthik Nayak wrote:
> The Makefile supports a target called 'hdr-check', which checks if
> individual header files can be independently compiled. Let's port this
> functionality to Meson, our new build system too. The implementation
> resembles that of the Makefile and provides the same check.
> 
> Since meson builds are out-of-tree, header dependencies are not
> automatically met. So unlike the Makefile version, we also need to add
> the required dependencies.
> 
> Also add the 'xdiff/' dir to the list of 'third_party_sources' as those
> headers must be skipped from the checks too!

Doesn't this mean we'll skip all the xdiff files when running coccinelle 
as well? If so the commit message should point that out and explain why 
that is an improvement.

> +exclude_from_check_headers = generated_headers

I'm not sure this is necessary. The list of headers that we filter is 
generated with "git ls-files" and so wont contain generated headers in 
the first place.

> +exclude_from_check_headers += [
> +  'compat/',
> +  'unicode-width.h',
> +]
> +
> +if sha1_backend != 'openssl'
> +  exclude_from_check_headers += 'sha1/openssl.h'
> +endif
> +if sha256_backend != 'openssl'
> +  exclude_from_check_headers += 'sha256/openssl.h'
> +endif
> +if sha256_backend != 'nettle'
> +  exclude_from_check_headers += 'sha256/nettle.h'
> +endif
> +if sha256_backend != 'gcrpyt'
> +  exclude_from_check_headers += 'sha256/gcrypt.h'
> +endif
> +
> +if git.found() and compiler.get_argument_syntax() == 'gcc'
> +  hco_targets = []
> +  foreach h : headers
> +    skip_header = false
> +    foreach exclude : exclude_from_check_headers
> +      if h.startswith(exclude)
> +        skip_header = true
> +        break
> +      endif
> +    endforeach

This part looks much more maintainable than than the previous version

Thanks

Phillip

> +    if skip_header
> +      continue
> +    endif
> +
> +    hcc = custom_target(
> +      input: h,
> +      output: h.underscorify() + 'cc',
> +      command: [
> +        shell,
> +        '-c',
> +        'echo \'#include "git-compat-util.h"\' > @OUTPUT@ && echo \'#include "' + h + '"\' >> @OUTPUT@'
> +      ]
> +    )
> +
> +    hco = custom_target(
> +      input: hcc,
> +      output: fs.replace_suffix(h.underscorify(), '.hco'),
> +      command: [
> +        compiler.cmd_array(),
> +        libgit_c_args,
> +        '-I', meson.project_source_root(),
> +        '-I', meson.project_source_root() / 't/unit-tests',
> +        '-o', '/dev/null',
> +        '-c', '-xc',
> +        '@INPUT@'
> +      ]
> +    )
> +    hco_targets += hco
> +  endforeach
> +
> +  alias_target('hdr-check', hco_targets)
> +endif
> +
>   foreach key, value : {
>     'DIFF': diff.full_path(),
>     'GIT_SOURCE_DIR': meson.project_source_root(),

