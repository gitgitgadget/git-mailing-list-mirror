Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCFF1C5D51
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741517577; cv=none; b=NGt16kbP9+BNI+Q3R+Cl9+adhW7hJPTCVYWal+LJUnRKHmRCWphF48HvxmTaBeml1Pmrj+r6nlHWe5YENBWMVES+jctpEhcTWm0TgHL4st0IOsmT7Nuk2Rs5JkrS0+BBNS7d4+VcyTQK+CC5T3qeP2nl5slzTo9Q9ELL9Zf2Wt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741517577; c=relaxed/simple;
	bh=Kp+ZpX9USS9RZh+/BQn6kkhOWTTrQM+ME9xv9p4xN5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWXjr1a88Q+BS8Pu+bexu17DbP0vnqhiIZLVOseOwxE4xsqLnnHAyXdgEGsBucY1hyTW2oieKHIVzcdI20XqsNx7np6YMndCEhKjCAVcQj6Xw6U/KR3R7yHceQEQ84byMZo8a73tTGMlPjAFPz24QSkE2duogGf3u3lbVAGGZXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOwCoubk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOwCoubk"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso1563451f8f.3
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741517573; x=1742122373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YigvYsG6+22fEdzxYk6BH6Wu0dV/Lnp20EZ5NaUm4gA=;
        b=JOwCoubkPIlD2WWNBHP/5+/5qkci4ysSasuhDqMC6/XxlPgnEjoqBwsv+x0g81PzQH
         5yOrwc8DiyEDTmFvAPx2/dyZenPD49rBLOVNvyYS9E4QC1CXVQtmNIwSZMVNtvwza2ri
         6RvSTfv07p5TsObh2cTol9ebOXNRGrB42H/nTmw0gvSrtTkl+uG9vzr5ndEEg0Gi64/R
         aSENLAt32t0EJ5OEQI+K9Sd0XSyhIC/5cXy5XfNa0csTuTVz+73SWc9g0A+sGRMiPd3Q
         FIYVBSodPUpVuJUqbNkHNKhTEb3slU3T14zPr+nscKK29rWsQEuSH71vzsxbRCNom4E/
         +/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741517573; x=1742122373;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YigvYsG6+22fEdzxYk6BH6Wu0dV/Lnp20EZ5NaUm4gA=;
        b=U93eWE51q4D9zZHCeox5XLT+6GJdC6Kg9l1LHe06wDHOn8OPN45SGYcjcgnOtgaHJJ
         wDKa0sXJm95TA7eY3BXfGaZpyv8msF/iAGlN0NfF3EJSwEf85Ld1FqcuU21QZpVrgTTJ
         cRo6IWQgSx26mFmbG8XUwJrym/Lq8epS27jyklPtzZRZXFtZRvPQ4lU9miUJMVNGtYM6
         VNypwC02oD//mv3pExZdhm0PenGZz7t/YHlTuCV4hKF/GI0ccxu+ZRq9vvAoZv6cj0ac
         Z1zn1BMhsFgd6pe+Cr8xrS1k/rZRgaNKuJh05jdNFkWkXJmhkfAOEtxdvIZbXvT+A1jZ
         +VVA==
X-Forwarded-Encrypted: i=1; AJvYcCXqq/z5L2UkXvC2nMjrwpiVOQwcVR+AyHcGhuRpC+jkhTojMbdgZpK+vhl6I2mvItMmuRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Q+o1QQFtzf4Nm0VhLkLMRWs/dy3UKZnGjHotWsZlaF2zx3LT
	lohLrzfkHGqxMrjH2smbAjnCJnxcamPHOXi6rsLnPRWqCrA62IxV
X-Gm-Gg: ASbGncu/l1ErKSkROPlibWKW1QB0PKtD2O0B+52U0E+ftDrREturBCSmhbL81wYMQY2
	HLZ/u4bQBdO0t+zGbbr+jol39/mEd7uHeOv8JKT04CJTOFtKVLd+7In8sX9bItPILUgiKf+vHWk
	cwy65suDpQNxxJ0qq3o3OFyiS8KTALtl0nEzvc+693oWwTdpv6k2fu+z3FPTV2DPAUY4O0gRaze
	mm0Yy/ssqPYTrjGFWp0i+vQWBLY6kaebq2YUbswibP3g5t+hhiEkS/O+G5vqdL2jAvTZ4N5tXb8
	U0KoWxpEoO79B1U4lKh9UXdygtqwua2+oU2cCGbCcbkCkpHpMGNuVj4nB+zwoVlr1+jhhHHmSQk
	CofFumXLURkiiIDGRZBGXWh6JAKQzb9s=
X-Google-Smtp-Source: AGHT+IGhM7CnuIfEH9oJfZ0oShEsb2xq5Jgp11GUvprA6ce9DjB+t/Wp2FFMo1SNetljBQpY5ZqLgA==
X-Received: by 2002:a5d:6daa:0:b0:38f:34a7:ebfb with SMTP id ffacd0b85a97d-39132fd343amr4695506f8f.55.1741517573513;
        Sun, 09 Mar 2025 03:52:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103035sm11358990f8f.88.2025.03.09.03.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 03:52:52 -0700 (PDT)
Message-ID: <1d9ab1ed-54bf-4359-85c2-28060cbf7198@gmail.com>
Date: Sun, 9 Mar 2025 10:52:51 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] docs: fix check-docs with WITH_BREAKING_CHANGES
To: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
 <pull.1871.v2.git.1741171357627.gitgitgadget@gmail.com>
 <xmqqzfhzlbie.fsf_-_@gitster.g>
 <082af6a3-a7ba-440d-af84-6c59827a2929@gmail.com>
 <56cf842a-7c1f-4354-b191-35bcc1e139bd@gmail.com>
 <CAOLa=ZRdqk-VXX4LWptqx3C3ABxNcxU+5cDTPxWt3k9UW1m3OA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZRdqk-VXX4LWptqx3C3ABxNcxU+5cDTPxWt3k9UW1m3OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Karthik

On 07/03/2025 22:42, Karthik Nayak wrote:
> FPhillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 07/03/2025 10:32, Phillip Wood wrote:
>>> On 05/03/2025 15:53, Junio C Hamano wrote:
>>>> We correctly omit builtin/pack-objects.o from BUILTIN_OBJS, but
>>>> forgot to add "git pack-redundant" on the EXCLUDED_PROGRAMS list,
>>>> which made "make check-docs" target notice that the command has been
>>>> removed but still is documented.
>>>>
>>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>>> ---
>>>>    * The command is still listed in the resulting "git help git"
>>>>      output, as cmd-list.perl does not yet know which commands on the
>>>>      list are to be ignored under WITH_BREAKING_CHANGES.
>>>
>>> Good catch. It seems the meson build was also forgotten in 68f51871df8
>>> (builtin/pack-redundant: remove subcommand with breaking changes,
>>> 2025-01-22) as we still compile builtin/pack-redundant.c and build the
>>> documentation. We should probably wrap the function declaration for
>>> cmd_pack_redundant() in builtin.h with "#ifndef WITH_BREAKING_CHANGES"
>>> as well though I don't think that is urgent.
>>
>> I just had a look at fixing the meson build but it seems to be tricky as
>> the manpage sources are stored in a meson dictionary and meson
>> dictionaries are immutable so I don't know how one is supposed to
>> conditionally add items.
>>
> 
> But dictonaries can be combined [1]. So we could probably do something
> like I've added below.

Thanks, my web search took me to a different page in the documentation 
[1]. Looking carefully there is an example of adding an element to a 
dictionary right at the end of that section but it is not mentioned 
anywhere in the text. I do find the meson documentation hard to use.

I think it would be best if someone with more knowledge of meson than me 
took this forward

Thanks

Phillip

[1] https://mesonbuild.com/Syntax.html#dictionaries

> [1]: https://mesonbuild.com/Reference-manual_elementary_dict.html
> 
> -- 8< --
> 
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index 0a0f2bfa14..fcfec63e9b 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -96,7 +96,6 @@ manpages = {
>     'git-notes.adoc' : 1,
>     'git-p4.adoc' : 1,
>     'git-pack-objects.adoc' : 1,
> -  'git-pack-redundant.adoc' : 1,
>     'git-pack-refs.adoc' : 1,
>     'git-patch-id.adoc' : 1,
>     'git-prune-packed.adoc' : 1,
> @@ -205,6 +204,14 @@ manpages = {
>     'gitworkflows.adoc' : 7,
>   }
> 
> +manpages_breaking_changes = {
> +    'git-pack-redundant.adoc' : 1,
> +}
> +
> +if not get_option('breaking_changes')
> +  manpages += manpages_breaking_changes
> +endif
> +
>   docs_backend = get_option('docs_backend')
>   if docs_backend == 'auto'
>     if find_program('asciidoc', dirs: program_path, required: false).found()
> @@ -475,7 +482,7 @@ endif
>   # Sanity check that we are not missing any tests present in 't/'. This check
>   # only runs once at configure time and is thus best-effort, only. Furthermore,
>   # it only verifies man pages for the sake of simplicity.
> -configured_manpages = manpages.keys() + [ 'git-bisect-lk2009.adoc',
> 'git-tools.adoc' ]
> +configured_manpages = manpages.keys() +
> manpages_breaking_changes.keys() + [ 'git-bisect-lk2009.adoc',
> 'git-tools.adoc' ]
>   actual_manpages = run_command(shell, '-c', 'ls git*.adoc scalar.adoc',
>     check: true,
>     env: script_environment,

