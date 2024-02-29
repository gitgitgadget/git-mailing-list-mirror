Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B53A28
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 00:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165084; cv=none; b=YJxYTM9JYDzRsjdjgri/qBDHXnZ06L49qGXHTgjBXq1QGL/Ny+VMHKoPLt2EDXsUHi3L48Yay6+ubZpMG31I/qdbf1l9BkAnbiv7ZGxR7EpLT45AnjRRn8Gf/4y+rAdkQXGy9KETtisqPtAaF3hIRITQpcTyQ3nzGSsO7ft2MVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165084; c=relaxed/simple;
	bh=uHkza/mc33cMPfpQvvPUjonkBfCD4QjDiHcwTKdA9/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jO7eoDzO31fAQM5kNneqArOxkJQCTu7PeG9lrVvz5WizAr6mmu+vLuYnr8lxXDAYrYWWaSU2vYd89S6BNUynUp5p6ZxEcfBe+KSzbPEsiSRBCaELIpsZdYF/fb0p/GzIjRXaHpCiqZbgJj3NRaZ0zt7+ahIpVjm2SMxCQ6ipLuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnSPo5aK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnSPo5aK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412b243926aso2532455e9.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 16:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709165081; x=1709769881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHUUpewN4U5rXkonLYdN40WOJRu6zHmoHOCaytcX5RU=;
        b=gnSPo5aKiEhQgsgLk1FvtTsZwWL2EL6HCxGKH00nhZyD0Kowa9g93VTI3x0COu3y8H
         U0ITMJejYK9Oql2/0Jq7m6D7vI9Izq9qdIvI2x63Ztbm+haUm7IlfaTkn0PqxgdL+aQX
         Zq1Nh9/2f3lTiy0RZCbiidQrHRlmDROP5VjEMWQ5ZDGD3MuQpkoAjqntiO1rUJeN7fq8
         dkyYSlHrRQAGfL6A+fI8NShAq0rC4j1bVUx5mvQhTygT4Tw3ZKoUDR+Y+G7gfM5AXLLT
         Sz/BKhlJt7FVbcV2ObALhTRwiUtmd1vS+D6E+nMT5Wvd5OSJcm/hgSqX+5ry3N0dYFR9
         Vx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165081; x=1709769881;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHUUpewN4U5rXkonLYdN40WOJRu6zHmoHOCaytcX5RU=;
        b=bO0WOXbEkQYH59aHZLDXnjRlVhnRWDC8TLUQ3KCtL5s3RagjQWxLSbp5UKxENx7VH6
         yEXP+3jmJklHSRvW7fyjAp8rMR6sKIOsLe1fq6s1igmxIY4JXCflg75KvHYTuNcgYK8i
         nm9wQWST8lMOCwYs+NZQvnFaoNBu0mgHt2A2TfPWKXO63aqWNHnkuDz7eOnwXYP1EvhB
         TD4au927Z7XPohgYGw+7/0R96uQ66JSzZ/bkScZE1By99r2h6jUxx0AEqekxCTKXJMQL
         mdJbBkDOYv/nc5902k5Tfg3EM9q/9L1LWYpSxhp6RrhSf6I7LEzuSuXy6Q95p4lidHDm
         5uWA==
X-Forwarded-Encrypted: i=1; AJvYcCVUg2myG3VUYYQ+SZTVSyWC8iDu4MmZwYG/Thmj/rmYzmqwZh2gDwLjrzCOWXzwgJoaE1s9RpXvSYAHbFxoaNTSwl0A
X-Gm-Message-State: AOJu0Yx8NwTEmMDlTtncWEYJ70K3v0PZTMy/+XTtKOsqNJ+hvX1RKftV
	m8xj3HEv5QYZ0Sw1hetQxcePT4IpPMbRIlBV+Fza3g0iF8XSh7vK
X-Google-Smtp-Source: AGHT+IF9mV4ZHjobk+iT6vQid5JSosAbhamIPqJ7WOPJh/+SyGhPsqfMovrnXTim9LFO5c7fkSV8AA==
X-Received: by 2002:a05:600c:1daa:b0:412:b623:bbcc with SMTP id p42-20020a05600c1daa00b00412b623bbccmr477715wms.10.1709165080996;
        Wed, 28 Feb 2024 16:04:40 -0800 (PST)
Received: from gmail.com (243.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.243])
        by smtp.gmail.com with ESMTPSA id f15-20020adfb60f000000b0033dc931eb06sm156783wre.0.2024.02.28.16.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 16:04:40 -0800 (PST)
Message-ID: <6683f24e-7e56-489d-be2d-8afe1fc38d2b@gmail.com>
Date: Thu, 29 Feb 2024 01:04:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] completion: dir-type optargs for am, format-patch
Content-Language: en-US
To: Britton Kerin <britton.kerin@gmail.com>, git@vger.kernel.org
References: <4714b88d-df5b-4e37-a5d7-af5033cfb861@smtp-relay.sendinblue.com>
 <20240109005303.444932-1-britton.kerin@gmail.com>
 <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>
 <40c3a824-a961-490b-94d4-4eb23c8f713d@gmail.com>
 <CAC4O8c9z4s4fFU6_h6ZRBnDhZyiTp3XR8j0DrARj+1SauLbQEQ@mail.gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <CAC4O8c9z4s4fFU6_h6ZRBnDhZyiTp3XR8j0DrARj+1SauLbQEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Feb 12, 2024 at 13:52:53 -0900, Britton Kerin wrote:

> __git_complete_dir ()
> {
>         local cur_="$cur"
> 
>         while test $# != 0; do
>                 case "$1" in
>                 --cur=*)        cur_="${1##--cur=}" ;;
>                 *)              return 1 ;;
>                 esac
>                 shift
>         done
> 
>         # This rev-parse invocation amounts to a pwd which respects -C options
>         local context_dir=$(__git rev-parse --show-toplevel
> --show-prefix 2>/dev/null | paste -s -d '/' 2>/dev/null)
>         [ -d "$context_dir" ] || return 1
> 
>         compopt -o noquote
> 
>         local IFS=$'\n'
>         local unescaped_candidates=($(cd "$context_dir" 2>/dev/null &&
> compgen -d -S / -- "$cur_"))
>         for ii in "${!unescaped_candidates[@]}"; do
>                 COMPREPLY[$ii]=$(printf "%q" "${unescaped_candidates[$ii]}")
>         done
> }
> 
> This one works for all weird characters that I've tried in bash 5.2 at
> least, and in frameworks that do their own escaping also (e.g.
> ble.sh).  Since your advice so far was so good I thought I'd ask if
> there is anything obvious to you that is still wrong here?

> If not I guess what's left is special code to make it work better with
> old versions of bash.  I'm a little sceptical that this is worth it
> since bash 5 is already 5 years old and it's only completion code
> we're talking about  but I guess it could be done.

I don't think you need to dig too much into old Bash versions.  If it
works with a recent one, it's a good start.

Have you considered adding some tests to t/t9902-completion.sh?

It is desirable to see some tests at least for __git_complete_dir.
Perhaps it would also help you to polish the function.

Sorry for the late response.  I just found your message while reviewing
the topics in the 'What's cooking'.
