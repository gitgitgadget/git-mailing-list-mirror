Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A621BC2A
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 00:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752020526; cv=none; b=AHw7m2n0uhCbQWiDDFVQ4aFWW1VtPyfjoH5caK3/ZHWY/UOQBlmQjeRlqvOdm0EssbF9qHvt/UrbZNiW0cM6rKdHuIja1uClP4TjGKxBYh0CsbEGrg21HWA3XVheUW8IVvf1JBri/uNGX34SsZu0NF0twPq/L4n7+SFzXvgNGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752020526; c=relaxed/simple;
	bh=q2ZM16vC58bxtrSTA/Lprq4Aubzg1FCsd1MBXCP+k6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePN2bvLkAkQA9ODr3Q+mrqp4VWaH2pJX6ovzCaMHqkhExEBwGxTGkC5zO/8EytWENgMr9e4MXzkYM77tSZ5tzbj/uc4Dm7CmpvQvPx92G305i3OBpXIgnl4oeyImaNpy2HbT286lVBhlCIeK0iqJBDDvFplf677s1ofcX6kelMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0Mj3C6m; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0Mj3C6m"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so385678a91.0
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 17:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752020524; x=1752625324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0ZTVrhSY3uqxMeMUEq3YU6Agk2IUUPUVWYcI/4MMms=;
        b=L0Mj3C6mwBSlpkDyKCkjGotYMPM6CRhNQiLGeiAfwUDia5MSkjNY9IAZ8Tj1/V05uS
         y8ajBxdeP6oRzgyW2ADWLrP5dgK78PY3PIZK20rMWdq/hdAwosuj0zB63zQcYajBsK6E
         joYcRmIOhfDgNoFdo/530qqjeiF7dIUa75IryGvoNlINGkiLkmqsYLClgCLrgv0kEtl+
         4GxXn5MBKEjUxHBG4utPmgkU9sbsqL5jIjnTpoHWSp5hCTO+Gt8Q5qn7mpMPyzaDEAGG
         dozAwPRuLLgdI0yoEr9GJ161mFy0P5UuOhMnXGJgIV7agnpLzknukxJQ7zz/n6cxshIy
         vaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752020524; x=1752625324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0ZTVrhSY3uqxMeMUEq3YU6Agk2IUUPUVWYcI/4MMms=;
        b=IA9GcZGcYrK6kZMiqZqnfLGfgOkSzUcJ51tM6KxuGoCfJqA91ryLyQOb0daNI0D9yg
         y03mew+XbkTbrtCBparRQJW8C6n8Uudmb5ntkvM7082xarnSR5dt54uc9OibyS6+cOw8
         Spau7FZn5Q8WLZPB0COXKvzZC5pk1v8qtt2QJvo6t6wtqlFFqXKUrD0jJxfgVmJiVqZN
         949d9Zeavk8XZVes0HhX74Y0mo6w/Fmd4Rq2r3oCDOw5rR2UZ6PcIgm3kP9nvxCdQPmd
         /ursH75ALMA5E7XcQqPBvR/R3KWjfJeUZUiFsTIHqH1rq8IUa5WZH3+5K/aJUnYi3lI3
         jM9g==
X-Gm-Message-State: AOJu0YwfxE37TeOGIfex1hrV0ocJHbWgnzFkGeAJKWuXWis8GhT8P8lH
	p19WBXw1/cPIBPA2ZFIauWrwS7mvvDkijWT1cPb4UD8t+N3K2zwIGlTh
X-Gm-Gg: ASbGncsZFMwR7WdmLjT1JwVgQwt37lzo+x7lk7UGMBI+Kj0FXIuR8pHFF94G108UJV9
	pQ2wuzlFwe6/6ARLtjW2zmNn8k4i2g47IlR6yJwvFKhvvLffQ62hITeMr/rUiqfv/ccVTkTWsmj
	7g4vAf5yImjHS/Sqvt+9pHwxVBhi0hH8ydvCY1WFBnpf3MoR4TgEoBgt2nPuvvO65Ix50k5Krp4
	71o7KtpcHmZyLivG61p0hMnL7d6O/Pb685U1uRszmoL7UBTUF71tUiLJofP7i/KaOAKwzyUsocj
	kMERLJQ+9cpocsWPqVPg9ozT+4GcX5n9ZUIsUE8GdmqLhcHsZ96Fz+iaVzyG2zRxFriuA5K2rLj
	8K5MrXA==
X-Google-Smtp-Source: AGHT+IHohXGCyXujbjvRA1tZ1mjadHo/cgZIPHTNCMfkdPUNotxuwgUCXjnFG/t1Ma54Ug49mPuPMA==
X-Received: by 2002:a17:90b:3944:b0:311:b5ac:6f7d with SMTP id 98e67ed59e1d1-31c306630c9mr607241a91.6.1752020523623;
        Tue, 08 Jul 2025 17:22:03 -0700 (PDT)
Received: from [192.168.1.5] ([103.80.119.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300b88edsm302692a91.35.2025.07.08.17.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 17:22:03 -0700 (PDT)
Message-ID: <3a8590f3-ab8d-4155-b8c1-7cd34dc9db00@gmail.com>
Date: Wed, 9 Jul 2025 05:51:59 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: locally storing issues/comments/projects
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <3e964e0d-bb90-4074-a9ae-a10fb02b3f50@gmail.com>
 <xmqq4ivmtlnf.fsf@gitster.g>
Content-Language: en-US
From: Sahil Gautam <printfdebugging@gmail.com>
In-Reply-To: <xmqq4ivmtlnf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/9/25 3:01 AM, Junio C Hamano wrote:
> It would be very nice if these hosting providers can agree to make
> project metainformations interchangeable in an open way.

it's not just about migrations, it's about a repository being self 
reliant in itself. think of some git
hosting provider blocking my account because of some ai algorithm, think 
of some disaster striking
some data center or some malware deleting all the data on the servers, 
all these are quite possible.

having git store that data means that you clone the whole thing and 
doesn't matter what happens
to the hosting provider, if you have the repository, you have the whole 
thing.

