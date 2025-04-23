Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF562CCC9
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402728; cv=none; b=uNf/WMLVKzeAzUtLcbvQKo0lyqsEKa2FjsbmAS1AS4YivvgKADApOSllbxCfKDHcTu1H3np5gmw0WPuv8kWjSG4ZvwwZbDWYqT9LUw6d82ri6iVNwztlpIGeJxPbwU1FVu7MODtNEDZRM7mMg9IyHT2nnT3294IpG53rVGZJ9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402728; c=relaxed/simple;
	bh=D8nk2AhNjPhy5YIFHFBwPareVq7rEuvmgWdn/a2/zLg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=b823X1CNUJSPdg+8nNdU6SkPhQUL8fpK+GlVBeIrMBuNjb38eu8bimjLJCJ+gt2KN2VAT5lW0KOy+pFPVX0JUhXpqMFk/3EY5CpQEHYOTH2kH6Banmjedt3eAV52fqeR6DH7C6blrmf+kYGMWg0B65gsg+xaWNsNWCp0mHKCzZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVRx8FZa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVRx8FZa"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso39252515e9.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745402725; x=1746007525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=taOyEAsIheYZwHI78Q3ISqZOVM5IWWdHlfkJcMYqLLk=;
        b=eVRx8FZaOrTDhpfgicOs8NFu71Xm50qN3hZjEFdbf79xqIqpTw7oKU9DMm0gYuKke1
         iEnLa8Q0NloFwEceRoMGESEq3OowWfyEWjlHegWavpxpH3g65/2jEt/hiASQtrmfGM5y
         DguPz1ZvNKZ77FEGH1PEUCaTJhin7v6iIQLTFsiReCHqVNJsWxQjQYS+Xf1a5l5Mx+oL
         WRMvR1CnaX9wyUOHqbkFUG6EEMG8qH3wR+NWgi6aO8/S5Ae2Y1KmHf1s1UWlhRqoNhDC
         THZOws0uPrTsLQmDZpQ4sobmLfs6vCGKQFeIhP6mvSA3i2p1igHLOo0JNi0zMXQAAiwt
         iKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745402725; x=1746007525;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=taOyEAsIheYZwHI78Q3ISqZOVM5IWWdHlfkJcMYqLLk=;
        b=dtzx0kRnxSibweOnpq9xEHFHf2j9puZP+TnhbKm5QHWw+Ebiao4Xni+DR/s3OWkdr9
         /cyHGXkE4/HctQUrr4RMKdgVC5e7y8nlQs0QbJaPwiwOy4CC98yajXJBs1C8K6w9qGK1
         VR8WwMQl2kizzcjI/ekre19qg70zZFM16K0kafoY3eMwnlnVm7Z3sCxz7hTJBjgf5L3M
         21CwMAs8HFINpDv/eDmPZ9LI2RXfZu27g9gfyuUiuwW+jdB7PwygL/7SB3vDLBE/gdK3
         bRSYu2GVO/CnxKQ1Z7wU2EYC4y+bDwQI+s7IxPtZ+Uy6A9h7QsTXx4gkDCjBHxePewZA
         DzgA==
X-Forwarded-Encrypted: i=1; AJvYcCVSKIxVTZs2njwO9scbhrQ0fsFarF6nHG/NaWm/a+4JajMmiYi+mMw0xmAjyY+r1xFMlfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7XErLcBv2+tJinnGpIvIzSU9H0NVrHV3tfN/IpT0jOgzdPhP9
	QiH+pboKBWmT2a1V7p/ryw7wnOagZKoSVPzULk+ZxN/3Udi1hEVZV68DBQ==
X-Gm-Gg: ASbGncsx/tJwI7oq93Bt9Z70Z9hEUimD6hVSDvuYGNFlSKe1L0+ydsYe0vfbG1sGNBh
	Eq5EsMyWNuhX9SzWBmVBqE98kBfv+ROoYtqzFTKkOu1aLejZrcrOGv4rbJvIk3EjdJMyYtFtD3l
	v1zMNIPZmii1Q2NDUnzBRplW05uYKBvY5Ag8kFmgBVXNgKPCv+LTv0HZllym+QKQbyUHV2DXSa0
	fJAMVP6muSnpwOL732K+31NKMVcIR2qLm/BTEErGtJfkmx78e8z1A/3iWldVDm26UVG2eVTSrTr
	A5B/8uprEB00E77J0F7NFWiAUFaUDKQHZoS/DNDJg2Co1aw51MUTgZrUHZohLqFWDCTx+bt0REh
	OHclI/EwTOAmGfpbJ
X-Google-Smtp-Source: AGHT+IHGlATbl/XyQizMWIyBjsc7hTnuaxjmqAJF3HP9w/2Kf21ABU4hohNRv7JeZw+BwXVYjlwU5A==
X-Received: by 2002:a05:600c:c88:b0:43d:609:b305 with SMTP id 5b1f17b1804b1-4406aba7cfamr174475485e9.17.1745402725183;
        Wed, 23 Apr 2025 03:05:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa49312fsm18202538f8f.70.2025.04.23.03.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 03:05:24 -0700 (PDT)
Message-ID: <2a25ca04-c824-4bec-a5e7-95ec32556cf9@gmail.com>
Date: Wed, 23 Apr 2025 11:05:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 5/6] meson: add support for 'hdr-check'
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, ps@pks.im
References: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
 <20250423-505-wire-up-sparse-via-meson-v5-5-d1e2be4b2078@gmail.com>
Content-Language: en-US
In-Reply-To: <20250423-505-wire-up-sparse-via-meson-v5-5-d1e2be4b2078@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 23/04/2025 09:15, Karthik Nayak wrote:
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
> headers must be skipped from the checks too. This also skips the folder
> from the 'coccinelle' checks, this is okay, since this code is an
> external dependency.

The xdiff code is in a kind of limbo as the upstream project is dead and 
so people who want a standalone copy take the code from our repository. 
The Makefile does run coccinelle on it but not hdr-check as that fails. 
Looking at the filenames in contrib/coccinelle they are almost all quite 
git specific so it probably makes sense to skip the xdiff files.

Best Wishes

Phillip

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>   meson.build | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 4618804c7a..22fc65ec80 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -645,6 +645,7 @@ third_party_excludes = [
>     ':!sha1dc',
>     ':!t/unit-tests/clar',
>     ':!t/t[0-9][0-9][0-9][0-9]*',
> +  ':!xdiff',
>   ]
>   
>   headers_to_check = []
> @@ -1994,6 +1995,68 @@ endif
>   
>   subdir('contrib')
>   
> +exclude_from_check_headers = [
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
> +if sha256_backend != 'gcrypt'
> +  exclude_from_check_headers += 'sha256/gcrypt.h'
> +endif
> +
> +if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
> +  hco_targets = []
> +  foreach h : headers_to_check
> +    skip_header = false
> +    foreach exclude : exclude_from_check_headers
> +      if h.startswith(exclude)
> +        skip_header = true
> +        break
> +      endif
> +    endforeach
> +
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
> 

