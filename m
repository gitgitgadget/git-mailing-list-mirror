Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC502C6BD
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719742351; cv=none; b=YGnUiTGLSsw/xd9zDnoiBV3Vqi6RzDrfA5xtFbg7bmrxrKIoKfw4cWoIy1ayXnsvaPDOCpgWlvZuuckNcW0U2AzP/4OCUK+qIi8NFpxjjpsEY8PhLx9e97NXlxRNMHi3TbDJ1v8oS9S7KfwNMEmavR2TfwWcJ0Fju6t58bBogHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719742351; c=relaxed/simple;
	bh=zKquGGMTm8N6XpNTT2bJJDuceDIjh23PrdnQKiR5No0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7rKhPCb3DaVWqtJ0BDQo5nVl+YqDNl6L++sDUB17p+1BtkBaxYsSJvqR3rJzrVWjEC98UDqaVgRVySMv66BFCqu5F8DAKxBopyeQDh6LSvJrM9OK71E50tfKd/qzeTUxA6e2ehDUY/iXreKYLGVxmaNiI3qHp26JPqOu/2wijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amw8OXeA; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amw8OXeA"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-71884eda768so1013252a12.1
        for <git@vger.kernel.org>; Sun, 30 Jun 2024 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719742349; x=1720347149; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F9xUoqW8p10I8zbLFfXPmsw9IQvYZBjWAKQEpEPIDDU=;
        b=amw8OXeAD87+kAHp6M2kOSXjnS7mDL866AD4DXl5qWwrZPHdL2QdMnUlg/8bw6ZAyL
         sGPd9t/gFyZH1fpNqhEGse4waDesp6DLdJMi7T1FXyourjiS5RS/YcfrLZu6n1Dirk4N
         5+83Ti+0y4ZgZDa4PQKdJ9MMj+mC525+YF2XHKkeNVtZzjz+2qnz2puu0KjLxDUQIdDC
         gMBOsZ6BpkrgkxFn6Qi44Ll+W9mKTxpRKd9xaZVq+PbMu0TGC+orGo578Eg4I0LPKKMw
         ay5zHwUAcQVpKw5Fov5E9DBImG8KIZgT7WkWDSsSLk+B1Ve4fq5y/i2QX6zse5fCpO5g
         Nc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719742349; x=1720347149;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9xUoqW8p10I8zbLFfXPmsw9IQvYZBjWAKQEpEPIDDU=;
        b=GsZFT6Rh1FowYewFKjqHZRMbUnTNdhi+IUNUjRs/nrstoYe+J/f7ADmbWkToT9nx7n
         DldgyHGRcDL8BOZbMRdJrAny8/ANjA1qNuIJziQ85/8XI5rrQK5+u0z5uwrpL/CUhXRc
         c+yrx3k2oqXE4qbZI4TGMAQzVXwL4u0/7c/JBF0ciNxDUFRrB6t30mE63E6gu+hHZO8N
         1qF4M6zvcCd32TTLOfZ6Iwf8BOXFgXsXyRHfLNY4eMg1UKSWoRCrcAw+guDnPgbQCgDT
         tzLUVWF6d56tSGZADeew7J6qYFMmUXPP8Ax1Iq77JO/U1S7LGKoh5SyxAiCiRWNs1Us+
         blVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzaUqb4nFESuGGM6VbE69qJ0MV9pBNptSsVltKKIVz87jXcNd7JdlBdkMDnYIWTNMgP7P06TVLi8d2Y/BGlriaoCAB
X-Gm-Message-State: AOJu0YweLgvL0guu8IlUuCRYsW9n3vjT1Pzsv1Ujy9lx4UyRM2RwbajX
	+JZHQdnhIpp/ijw+duzmqUvP3ClesPVhVaLs62lL3fI4V1BrZACpcXhl8tLoK1F/+NJaXbva2m3
	yHEyfQ/qQ72A/T3HtfDRJUxNKvq0=
X-Google-Smtp-Source: AGHT+IGS9AnQWmujqtgEz8vooeLF6pqIdyCV0UYTcsn4UDFVq68oeWymOI+ZUsje/80rnohIXnmKQO09pGmB3gL3tdQ=
X-Received: by 2002:a05:6a21:99a5:b0:1bd:1aca:2b39 with SMTP id
 adf61e73a8af0-1bef60e3bcdmr2201527637.8.1719742349069; Sun, 30 Jun 2024
 03:12:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 30 Jun 2024 03:12:28 -0700
From: Linus Arver <linusarver@gmail.com>
In-Reply-To: <xmqqle2o26jy.fsf@gitster.g>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
 <011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
 <xmqq34pqlyou.fsf@gitster.g> <F64F4F3A-EF82-4281-8A75-0DDC8FA65D4B@gmail.com>
 <xmqqed99k7xo.fsf@gitster.g> <f6abd59c-ea86-423f-9172-79779932418b@app.fastmail.com>
 <xmqqle2o26jy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 30 Jun 2024 03:12:28 -0700
Message-ID: <CAMo6p=FMhw2TZ4MdowMjQM0wgb90Lkqa17AENsxNqj-eJk_5WQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] refs: add referent parameter to refs_resolve_ref_unsafe
To: Junio C Hamano <gitster@pobox.com>, Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <avila.jn@gmail.com>, 
	John Cai <johncai86@gmail.com>, Aryan Gupta <garyan447@gmail.com>, Linus Arver <linus@ucla.edu>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
>
>>> ...
>>> https://github.com/gitgitgadget/git/pull/1694#issue-2187804953, it
>>> carried over the email addresses as Markdown-formatted hyperlinks.
>>> Currently it reads
>>>
>>>    Cc: Christian Couder [chriscool@tuxfamily.org](mailto:chriscool@tuxfamily.org)
>>>...
>>>    cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
>>>
>>> when I click on "edit", where the last line must be from your manual
>>> fix which GGG picked up. I've cleaned up the PR description manually
>>> now, and for this message I'm also attempting to clean up those square
>>> brackets.
>>
>> When I read that I assumed that Aryan had made the same mistake.
>
> Ah, I see.
>
> I wonder if there are things we can do to help reduce the pain in
> future users of GGG here.
>
>  [...]
>
>  - Or the welcome message GGG adds to the pull-request that begins
>    with "Thanks for taking the time to contribute" can mention
>    something about this?

I've created https://github.com/gitgitgadget/gitgitgadget/pull/1644 to
address this for now.
>
>  - Or possibly the handling of Cc: addresses done by GGG can be
>    tweaked not to cause this?

I wanted to do this first but was deterred by my lack of familiarity
with TypeScript.
