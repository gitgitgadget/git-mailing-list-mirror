Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A32324B10
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969807; cv=none; b=rKDv/55o+bo8BJDk+5GRhrFpVbgfZSMewQm6oTSv4ZFJN1uXQyCzGCYGAXOVqXhT9WGFUkRXt0508pIlCs+IZNwa2gqqqpyupyMBRLgq1RodlcSPbociDLjRUlR3TsMu6QIvbUGtUMimYRNmYNq0nPGEXDJ9zdsSn69oXZKtEI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969807; c=relaxed/simple;
	bh=wrIcBGzglUPFrT+/B575uyjJo7c3yQ3jLIROwpsZvkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rt0w6UUH+Iv2lAkBh4yJLBzG3sSLzNl/UAz1PSR1qc8wpAL95AN4wtyebYe79UzwkVQkH6unBRii+7hcEvy5UIiJWkWu5xakvEGkEIxX+F3+JJAjyYFLX74OltdNg38e0QhKEaIMoZ+7rN2qydiF+Mr1CrlXwgUQ+BqJL3JZ4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0fHecgj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0fHecgj"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-795be3a3644so37146236d6.0
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760969804; x=1761574604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=snCZiOuH6DG54r/c79nfSVBO5d2DTgsRvWmHaMn2e8U=;
        b=f0fHecgj1Do7+aw4WEE4VJ91ylwX2NRCTvDkpdH/WGxuZYmyYX3nlfI4xZ9KZACTLg
         EpHnJY5rmnNmJfZzIa9Z93F70/8gOFzSGNa4Y5/aNt8y+F1rM/b6vxg0DmNWOfgdh3Vo
         MFCtvZWFSBlT8AQ8rr0E2d8Bmy8Fun2K5nIoy3DJXBdwY/x/9EVVfyLs96t0sjnaSgn3
         g7iiCqBEjmo4uOKreOSZa16rp5gHpOn5REvn4YEhs3JyYXG69Ijgp+6H5aTHzyBQeIHJ
         X+xiiytOkwyKim7KZd+1ABBXKmS0fA8U4sLT7gclHhSDJGfVNuC5aO7HDt/mFqV/FadT
         ttmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969804; x=1761574604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snCZiOuH6DG54r/c79nfSVBO5d2DTgsRvWmHaMn2e8U=;
        b=UsAgeFsJPfVfycngWhz7cDqcboJcZN0sKb4NdJyLHUOhOeYNGvfWf/wpKl/q99HMZT
         7l6aFN2+dx5r+ySm9OFyTcfMetUQ7dBMbzLx22bTKz7MTJexg8/xf+X1FvsOlXzStznP
         HBZaMBqgK2/vgQRgbRNsmeX1C+JvMpwPnlfEOl9LbVigizXwAox3NFlWUGvw7VjNR0Ss
         SRn2iikm6HCgv+VXcjMUSgaqIfWP5oveISoScQvjjcdHlLhkMPk79rY+9to0oCTkNTij
         vDIQ0R+XP198AdRjDhATSIKVmoySDN6Ph9uJmPZ+M768T2l/0tU9L70CNI1ZCf4ypbxo
         ysXg==
X-Gm-Message-State: AOJu0YxQPgOTYI6f3TK9Q7BFdLsJAQHc+RYoV3lvsZ5x14O+8JCF5JGv
	uHEdIkXaXLc3H00RUh7h7LLrmSrFfC2kMAInE8yiAiXJvoVaLvmKngzaCA/aAHmb
X-Gm-Gg: ASbGnctg2EuDNI5Z2OVTUnEWlX0i51kROQMq1mJ13mN5bmpvgxgYpMA3+TNXnXE3/3s
	Ex9tDzhOhIdvC8geyOdjGiSYZpZRDStytWa1uFRYb0yeT1q0wTunU3DGCyrDaUIRrQrsiXHs2+M
	MpRD8VvH2j0/zYWzlhlw3vjsPi6XlQMTn6E8UPxrQUsXqKCv/Norhdg/Yc6SBZNhpnuKbjEiRXi
	3M6G2N1ilC0eVIeSo5QQecr77BOCbbV+iIOS0wBOdOZGzmszX342X7o2qcUvw8RTiz9Ih1SVBDG
	rKBvTFaGrV7KqgopATUa2Lu6W0Ocf2HAOuMm7UjD+U1LmR7GLvYLIuj4mh6UwSWbgL5borbxSQ1
	LYOYKi4iyQkhaNH3NYTOiqmPJOFTZk5QAu+7XhxJfA0x/GC4QCZDh568JLrWOw99HDJjp9VgEeL
	lOPXilBne9BL51fzt0J77tgJmsU5pkb3cwHyWh282/HjXdS5CJp0NbUaO0Uc7p12gos1IxtELZ0
	A/oC+yFIj5VDztx5vU3OAMEm6hAXhA2qg==
X-Google-Smtp-Source: AGHT+IG6Zdu5AdVzM3bdD4o/rQMmwBHmdXZoWkGwnHwmS2SVPyPZxC91zwuunut1j2jqiRyHm40enA==
X-Received: by 2002:a05:622a:130d:b0:4b7:b010:9398 with SMTP id d75a77b69052e-4e89d3dfbb4mr164058241cf.66.1760969804215;
        Mon, 20 Oct 2025 07:16:44 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6b1:2f00:3d56:be00:69bd:1efd? ([2605:a601:a6b1:2f00:3d56:be00:69bd:1efd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8af0126a9sm50588031cf.12.2025.10.20.07.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:16:43 -0700 (PDT)
Message-ID: <0f517519-74bb-4f46-b7df-5e25a780a536@gmail.com>
Date: Mon, 20 Oct 2025 10:16:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] sparse-checkout: add basics of 'clean' command
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
 <a1564f74cfa19eee528a1a0c54b87ac52d1e8975.1757673011.git.gitgitgadget@gmail.com>
 <CABPp-BGJ66e=znwOxvU0fLiw=KXwMg8FZxa283Jr5PXut_ECWg@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BGJ66e=znwOxvU0fLiw=KXwMg8FZxa283Jr5PXut_ECWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/7/25 6:49 PM, Elijah Newren wrote:
> On Fri, Sep 12, 2025 at 3:30 AM Derrick Stolee via GitGitGadget

>> +Some special cases, such as merge conflicts or modified files outside of
>> +the sparse-checkout definition could lead to keeping files that would
>> +otherwise be removed. Resolve conflicts, stage modifications, and use
>> +`git sparse-checkout reapply` in conjunction with `git sparse-checkout
>> +clean` to resolve these cases.
>> ++
>> +This command can be used to be sure the sparse index works efficiently,
>> +though it does not require enabling the sparse index feature via the
>> +`index.sparse=true` configuration.
> 
> This expanded explanation for users is nice too.  I particularly like
> that you called out three things users need to use in conjunction with
> this command -- resolving conflicts, staging modifications, and using
> `git sparse-checkout reapply`...

These cases are about 'git sparse-checkout clean' itself...
> [...]
>> +       if (convert_to_sparse(repo->index, SPARSE_INDEX_MEMORY_ONLY) ||
>> +           repo->index->sparse_index == INDEX_EXPANDED)
>> +               die(_("failed to convert index to a sparse index; resolve merge conflicts and try again"));
> 
> ...yet the error message you give to users only lists one of those
> three things even though the other two may be the problem.  Could we
> fix up the error message?

But this is specifically about the convert_to_sparse() action, which
is very limited in what could cause it to fail.

I _will_ update the advice later (added in Patch 6) to include the
more detailed set of actions.

Thanks,
-Stolee

