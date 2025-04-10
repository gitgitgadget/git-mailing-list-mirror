Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4F28C5DD
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296655; cv=none; b=dkFciHCfy6fNayurDFgksO8j/FRY18Vy+Na/w6GLYHKPiBco4gfHlhNv6MpXVaz/Vb+jy1DSI1VDT6zwFCQeN9m0nrvQ4VvBQ6XkrTJx6uRFpM9HjMFq5uGFZUtp7ZpW7n6rHXNCFowCSskn99rl1j8XuvJAomiLVo7QIgrU/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296655; c=relaxed/simple;
	bh=REe5WUoyUeAS26chKdY6QvfwON1Q5fYFu/Rwtd1cu+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhgjlzpXeSQ/pEv7X1v+J5uZew55AXZNXYiEFnq4UD9Zr/HSdmp2CrlrbOGx4KxETO++BpUy7e9HNexoRVqKJXhcopKiUeues/T235mP8xiqEycojHu/p78ZDpJ8T0bGPtIM7E+w1dZry9KGQxKz0tGchSlozJd85mMHoOXrPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFRX7X+L; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFRX7X+L"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so8423295e9.0
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744296652; x=1744901452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g+3VCnFW4lzXY9RpgeEpf7bBxFbfnAthOigj6dxC/eg=;
        b=fFRX7X+L3Gd4RrONls90VpXVXXwjD0ngFiMW3N5hpZ3dSM5Fbb6IzPqXXHLI15k9yk
         Oa1qctbcE+X/9c+hn3X+o3BHoJ7UcYAX1hJ6SLuYQO3kHTbBPUt5syAASiHYbMPxhxa0
         sClD9OFkBKEoxBJg1KNL9m7r0Uozt2bVqvj63DmRG5JGtc3MS+REidqxsoE3mpMAY54m
         jLX+qZMyLZ+x1ZBrYrqkWH7WqTtgQa1iXjrhcUpzAd09DoYTKI7J7WhFAUmEkGaBbnlY
         HupjCDnimBfioNSzNCPccPFRnFfybgs7slrSqMpjjPEfDrQY1qyBf/Zv9Le5fche4zsj
         hruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744296652; x=1744901452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+3VCnFW4lzXY9RpgeEpf7bBxFbfnAthOigj6dxC/eg=;
        b=TwaEqDGW2dgqFUkYayaV3MuZs4nHryqOMztw25SnVvx84tB0dNAbQ7MtTfp5ERCDSS
         rCncH4IDWS7TW5MNMuPhdPPlVEIG8uZZqIRvwFrHT7w+lOoGVsIobpf/OwmTqoRplfeb
         WjoZiAtyaQLg1c1ZqYVokCrAjA3YvZUSD8LQ/fzCBnDdoK3WvU2xtIDnWKHsOo12nm9x
         2D28qIDvdZudqQjaf60JJjBJby/8VSRBFEHN6OxHFVgm3eZbC1edNoULIxme9FOUYGSF
         cK0gp14UWeeqOseOXwEwPWNNXVoAbmcnnk7+vL1xBBOOfqQl2I267YGC029rf5ZeWWu5
         vApA==
X-Forwarded-Encrypted: i=1; AJvYcCVzHi5Bf+kLiJcDUA9EpKNsQomxL8lLKG0fmlvjlWS1o6gkO3tHhL1TtekbnMh6ccdfE34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiEZBz4oQ+lSdVSzV2+KiAoIpQLSjgFtkUpv/LUOWQWTd/SuET
	PkDc0avOZEwbWI4TPSKbOEG7hP6fu9OrpKf8DtPx1I7U6MIO+eZtCyvjhw==
X-Gm-Gg: ASbGncuSqQijSj4fXL9l3xCkdzl0J1UomYSnrD3moRXu6o3V41/8//ZRw3dD+VA5LEJ
	YspBpxBBMUzvsEJ4bLwwCU5LRR6+nOpxHKoUF0G+51QtB91t1mjYEaq+4WyKWi2y48hzbd5woNo
	QLFB+Y/8BMDu9mROZlqcc2nj5evl4/kNcLzlpMqNpq/zLGlilOJdGRcK0gQKWEm7uZ+G2yhg3If
	DTZWA2SszYOwZBRlG+sZ0Js/SKo1sqKmNqpynaiNkb7d7wuOGPCINQr5d8YSo+RDufzYv/qQJEa
	K5HCLdKJhoADTStGTWNg0Ta0EWvJomI5DOVxqkeuaTH8krLBNggLm7IZXEdnT+baszo1lbGnv5u
	BRUidWcS4BXqQz2kD
X-Google-Smtp-Source: AGHT+IGvRLEKnUdXPrLraHchvm9o5gGW0xXHltaoIxP1Yd083vm7DEbPbBpYEqtvzMVU64LN+/qgOQ==
X-Received: by 2002:a05:600c:450a:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-43f2d7bb517mr28787725e9.10.1744296651476;
        Thu, 10 Apr 2025 07:50:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893773c1sm4942936f8f.24.2025.04.10.07.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 07:50:51 -0700 (PDT)
Message-ID: <dc0d6acb-bcf1-4a7e-bfc8-7c2e7793c72b@gmail.com>
Date: Thu, 10 Apr 2025 15:50:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] meson: add support for 'hdr-check'
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: jltobler@gmail.com, toon@iotcl.com
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
 <20250410-505-wire-up-sparse-via-meson-v2-3-acb45cc8a2e5@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250410-505-wire-up-sparse-via-meson-v2-3-acb45cc8a2e5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 10/04/2025 12:30, Karthik Nayak wrote:
> The Makefile supports a target called 'hdr-check', which checks if
> individual header files can be independently compiled. Let's port this
> functionality to meson, our new build system too. The implementation
> resembles that of the Makefile and provides the same check.

Thanks for adding this, I've left a few comments below

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>   meson.build | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 107 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 790d178007..6fce1aa618 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -655,6 +655,12 @@ if git.found()
>     endforeach
>   endif
>   
> +headers_generated = [

To me "generated_headers" would be a more natural name and would match 
the style of "coccinelle_headers" from patch 1 as well as the equivalent 
in the Makefile.

> +  'command-list.h',
> +  'config-list.h',
> +  'hook-list.h'
> +]
> +
>   if not get_option('breaking_changes')
>     builtin_sources += 'builtin/pack-redundant.c'
>   endif
> @@ -1995,6 +2001,107 @@ endif
>   
>   subdir('contrib')
>   
> +headers_check_exclude = headers_generated
> +headers_check_exclude += [
> +  'compat/apple-common-crypto.h',
> +  'compat/bswap.h',
> +  'compat/compiler.h',
> +  'compat/disk.h',
> +  'compat/fsmonitor/fsm-darwin-gcc.h',
> +  'compat/fsmonitor/fsm-health.h',
> +  'compat/fsmonitor/fsm-listen.h',
> +  'compat/mingw.h',
> +  'compat/msvc.h',
> +  'compat/nedmalloc/malloc.c.h',
> +  'compat/nedmalloc/nedmalloc.h',
> +  'compat/nonblock.h',
> +  'compat/obstack.h',
> +  'compat/poll/poll.h',
> +  'compat/precompose_utf8.h',
> +  'compat/regex/regex.h',
> +  'compat/regex/regex_internal.h',
> +  'compat/sha1-chunked.h',
> +  'compat/terminal.h',
> +  'compat/vcbuild/include/sys/param.h',
> +  'compat/vcbuild/include/sys/time.h',
> +  'compat/vcbuild/include/sys/utime.h',
> +  'compat/vcbuild/include/unistd.h',
> +  'compat/vcbuild/include/utime.h',
> +  'compat/win32.h',
> +  'compat/win32/alloca.h',
> +  'compat/win32/dirent.h',
> +  'compat/win32/lazyload.h',
> +  'compat/win32/path-utils.h',
> +  'compat/win32/pthread.h',
> +  'compat/win32/syslog.h',
> +  'compat/zlib-compat.h',
> +  't/unit-tests/clar/clar.h',
> +  't/unit-tests/clar/clar/fixtures.h',
> +  't/unit-tests/clar/clar/fs.h',
> +  't/unit-tests/clar/clar/print.h',
> +  't/unit-tests/clar/clar/sandbox.h',
> +  't/unit-tests/clar/clar/summary.h',
> +  't/unit-tests/clar/test/clar_test.h',
> +  'unicode-width.h',
> +  'xdiff/xdiff.h',
> +  'xdiff/xdiffi.h',
> +  'xdiff/xemit.h',
> +  'xdiff/xinclude.h',
> +  'xdiff/xmacros.h',
> +  'xdiff/xprepare.h',
> +  'xdiff/xtypes.h',
> +  'xdiff/xutils.h',
> +]

Having to manually maintain this list is a bit of a shame as every time 
a new file is added to compat we need to add it to meson.build twice. 
The Makefile avoids this by filtering the list of headers used when 
building git based on their path - can we do the same here?

> +if sha1_backend != 'openssl'
> +  headers_check_exclude += 'sha1/openssl.h'
> +endif
> +if sha256_backend != 'openssl'
> +  headers_check_exclude += 'sha256/openssl.h'
> +endif
> +if sha256_backend != 'nettle'
> +  headers_check_exclude += 'sha256/nettle.h'
> +endif
> +if sha256_backend != 'gcrpyt'
> +  headers_check_exclude += 'sha256/gcrypt.h'
> +endif
> +
> +if headers.length() != 0 and compiler.get_argument_syntax() == 'gcc'
> +  hco_targets = []
> +  foreach h : headers
> +    if headers_check_exclude.contains(h)
> +      continue
> +    endif
> +
> +    hcc = custom_target(
> +      input: h,
> +      output: h.underscorify() + 'cc',
> +      command: [
> +        shell,
> +        '-c',
> +        'echo \'#include "git-compat-util.h"\' > @OUTPUT@ && echo -n \'#include "' + h + '"\' >> @OUTPUT@'

This line is rather long. Also do we really need "echo -n" here, the 
Makefile does not use it.

> +      ]
> +    )
> +
> +    hco = custom_target(
> +      input: hcc,
> +      output: h.underscorify().replace('.h', '.hco'),
> +      command: [
> +        compiler.cmd_array(),
> +        libgit_c_args,
> +        '-I', meson.project_source_root(),
> +        '-I', meson.project_source_root() / 't/unit-tests',

Do you know why we don't need to add these include paths for the 
equivalent rule in the Makefile?

Thanks

Phillip

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

