Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A9E25774
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706361934; cv=none; b=bsUVt7B8L23N4nCmVIlcntaxknesksl4yTWKBDjFaPaFLoY8DDxFRBq4vhuZ54ZNtR4fajJALlX/HZ76GRQ2EFC2aZHjqleRjBCQo6Wo8nE2F6656Khj/v8kntI+LbxkcLCYSW6PqOfDeQ85zaN+udg2d3agY6Ay/ugIOAEWT2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706361934; c=relaxed/simple;
	bh=7ndOKaMbPvY2/L3j5VLMNeWIElbYHaiyI1Wz8/KRTEY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VC/f83KjfRKotgf6ZM12oiq5vlIP49DbISXGfQVPjtvmrUvAMbV+TjwCZ5hKWSVczoTErztF66NO8EJZ5SfXgO5WcemREXhGYxBuOJdPJyo5SJeZdkLLpXZB/PjT6FCTDLTqRwnM+cAzjh1xNVa6Slvdo9cUGAoxjK+3gHWeFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E09/nj4F; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E09/nj4F"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf59559b2fso1027751fa.2
        for <git@vger.kernel.org>; Sat, 27 Jan 2024 05:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706361931; x=1706966731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Oi9u7fB7pLKaxGLFDdQoZ15Cn6sPXAu4a1sj9dAIQ+k=;
        b=E09/nj4F5SDkt1s024jPqdd8FSmlC3dkoRUElE69J6Gii8C5fOcT9UmKwToXcUB660
         qXfjeB+iFa0hM86Wb3q/0upgHf9rLHIUFJXGGeyxAQPZItq2aunXmVdcSpRoUOIzu9Q3
         3pLoY9juARLIJ3kFu+ygGU3Gh5FfQSUULHVWKB60TQdBTUn6pB3AQ5ZKqSHKmqaYivFy
         NMYc9i2PMKylRUaiKUol5I2i8rwD5Aplk5f/q1t4jTye17CbEEOR02AwJtKWaOsShB0k
         xuHk/RckHmcg8x4EciLIQHLruNGRiv+UPofSm7lY5mdlF3kIu0ceOqq5mmVtfCUuGbKi
         B1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706361931; x=1706966731;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oi9u7fB7pLKaxGLFDdQoZ15Cn6sPXAu4a1sj9dAIQ+k=;
        b=DiNhzg7yHMzNn8B4Hh52QAmJtP1fYh9HHMZdMpV15sG0WIhyhz2gq3ej5OH5x8LC2o
         EGpi8yzuKzn31o9ZhOXb3fI2ccYDWxBhEQkMKbJJQ4as8BR4gEGhC5MRWYJjAYKnUF17
         G1uWFj/7DPPGdgUNDGcXXc/Bvu0tVeaUPT6Wb8CmrPKZNMIUFXHzr8TjAds/oz04No+3
         1jRmPtef5jl9HQ4v+65upUGNdKiD3vxR1RTDmJ5sHFSatOHSO1bX1+wgxtIzmyDTfEG8
         HzBXWSROemcSbL/l80kPL95R1ZLNz8bJVkxOco3OEZ3vCNgj4f/G6Hm1S2rLJ5nrShVM
         7FqQ==
X-Gm-Message-State: AOJu0YwPfIf9vy/fzXs9ShZ+c393dFcbz1hdFynkbOC+QB25Hm6nH0ed
	5EXl4UCcdaBw0JQQtcb5gbEdhPbq0YK9Cdn3cWnSEs3U/5Yjpp9h+F8P37GCLgA=
X-Google-Smtp-Source: AGHT+IFbt78ON1/Okp7xZIOi2GOqe+oKVELL41fzOvJG36BEWtX777dJtvKSOc6diNB29valYJpO1A==
X-Received: by 2002:a2e:9882:0:b0:2cf:3851:5fad with SMTP id b2-20020a2e9882000000b002cf38515fadmr1477852ljj.2.1706361930496;
        Sat, 27 Jan 2024 05:25:30 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s25-20020a05651c049900b002cc7a2f7a9asm476682ljc.98.2024.01.27.05.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 05:25:30 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
References: <xmqq34v6gswv.fsf@gitster.g>
	<CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
	<87a5ow9jb4.fsf@osv.gnss.ru> <xmqqsf2nnbkj.fsf@gitster.g>
	<87plxr3zsr.fsf@osv.gnss.ru> <xmqqa5ouhckj.fsf@gitster.g>
	<87il3h72ym.fsf@osv.gnss.ru> <xmqq1qa5xq4n.fsf@gitster.g>
	<87ede56tva.fsf@osv.gnss.ru> <87a5ot6tos.fsf@osv.gnss.ru>
	<xmqqzfwspmh0.fsf@gitster.g> <87ede4fg8s.fsf@osv.gnss.ru>
	<xmqqzfwrjdul.fsf@gitster.g>
Date: Sat, 27 Jan 2024 16:25:29 +0300
In-Reply-To: <xmqqzfwrjdul.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	27 Jan 2024 02:00:02 -0800")
Message-ID: <87il3enc1i.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I'm still arguing in favor of fixing "-n", and I believe a fix is needed
>> independently from decision about "-f -f".
>
> Even though I do not personally like it, I do not think "which
> between do-it (f) and do-not-do-it (n) do you want to use?" is
> broken.

Well, you are right, but "-n" is not documented as "do-not-do-it" in the
sense you use it here. 

> It sometimes irritates me to find "git clean" (without "-f"
> or "-n", and with clean.requireForce not disabled) complain, and I
> personally think "git clean" when clean.requireForce is in effect
> and no "-n" or "-f" were given should pretend as if "-n" were given.
> I wish if it were "without -n or -f, we pretend as if -n were given,
> possibly with a warning that says 'you need -f if you actually want
> to carry out these operations'".

Yep, then we'd not need "-n" that much, only if to cancel explicit "-f"
(provided "-f -f" feature is removed.)

>
> But that is a separate usability issue.

Yep, and that'd be very different design. 

>
> What I find broken is that giving one 'f' and one 'n' in different
> order, i.e. "-f -n" and "-n -f", does not do what I expect.  If you
> are choosing between do-it (f) and do-not-do-it (n), you ought to be
> able to rely on the usual last-one-wins rule.  That I find broken.

I fail to see where this expectation comes from, provided "-n" is not
documented as anything opposed to "-f":

       -n, --dry-run
           Don’t actually remove anything, just show what would be done.

This is typical convenient description of "dry run", and current "-n"
implementation is rather close to the description, that I'd still
rewrite to emphasize the primary goal of the --dry-run:

       -n, --dry-run
           Show what would be done, and don’t actually remove anything.

With these descriptions, the last thing that I'd expect is "-n -f"
removing my files.

Overall, as I see it, we have buggy implementation of suitably
documented "--dry-run" option, and the best course is to fix the
bug, with no semantic changes to the option itself.

Thanks,
-- Sergey Organov
