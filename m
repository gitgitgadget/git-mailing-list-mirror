Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647CF12DD9B
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448947; cv=none; b=QJBk/LW3snuMADdrHGlAkzCgVqKw1T8GSu5DLKZ69h8X5vgdN1qsK1MFisPwvoGq1+/3vAM7bYxum0pGx8d25xsXih8xfgW+tRIrtyqn3gx8MaZWGaiF1tXCFE3o8zBHG02HCGB6a16Yt0iYZFEenwQWWMKpZydXGBQRLrMz9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448947; c=relaxed/simple;
	bh=PVdWyYnlpGyEWG4jx9xRe7WVkMm8KFDlG/bcrwXfBE8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqbNxroIigkGv3QQ0LirzNczkH/gkhzUiv8j5G/hqJPY8ocfjnyV07c5BYZwP7XlfewTNCJ0r5Kjphpo+LSrmdzbX06s2nsbAvMssVe3OoPWkB97V7z8qx5wGCOJpUoF5BUlUyWA12C0Sy/ryhc5GxDEZdwzU8pKsnSWwzgTWyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HelIFy7N; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HelIFy7N"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f60a502bb2so3103275ad.3
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 14:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717448946; x=1718053746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q1khbvJ8OR7e1pml/huqwTvgMAXsDONjzDMr259G24=;
        b=HelIFy7Nxus+lGY/UM9Fnu03IOdSwGfmIxxyTTE4Hk8SjaMcOI+Ic1KyVkGzW1xZmD
         KvDWRL/qwiOG/HfCTM8cYGSNzHF46OU0lio2qH5+WITbr88k/ps/WfPxwS8SlWrEjemV
         sYXt4WHUFige7qu38fUZ34320Z7jYeRss0nQ4e4U2NjymVHpLHHi6kxAqI0NrGkSD7Lp
         jsW6cj9N94go9vOA7PWcdT4hOE6o+Wa5/Ey3YjR57lmgi//H9EsLXlSZ3WZywgtEkx5x
         hwRplocIzVpRNPcS4P4qiHuV9AOHMdfZc7f3RTGzGM56o32HA76xy6eOU/ePean61E8M
         Aagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717448946; x=1718053746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Q1khbvJ8OR7e1pml/huqwTvgMAXsDONjzDMr259G24=;
        b=A9M/mLOMfOclKI69MjnqdRZCtHL9zVvkM5m28duSXnPcsMqqit8qxSpVdyWHfYFy1k
         Omnztgo6IRWFrjSV8RCgdH4stROhYjFx7aIsISIAbHTwY4PsZJfEjKEM//vjH5r8kist
         mcfGp/lKgx5wOyZC4swJwpZ8ahp8FhRJe0hIllR3jVMVTBWvmrsKe3HLhzoITLNXtnRS
         JItvJSh/+njDpxcV+TFHV1RjQITe4k9oUpG6dS/55/r2TrILH0wwV4RpG9PXD7QMo1XW
         kLrWUsSCkJnQchfA03PLe7w0EfRYBlW3zU5u3nndE4lznIRZH5vbGj3IZO2i6smgpdCW
         /MQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlaRlQ0aqWnhTWsetyAv4IoFoSJLZqu5HsQPnL8NdHhs++tXaDtRNGAT7gggoOaiFbGBQ7JjV7iLgyx+hAkgYPQDth
X-Gm-Message-State: AOJu0YxHxHaiG8tlJ1kwhkR1hZy3VbKGYycw+E1bNvuQ2gM+69s6ifti
	Wdb6J+C2aIKCUAXVNTPiMwADwAks82yc74QVQNSHnN4bhSnmh4tBmz6/YBCob2c=
X-Google-Smtp-Source: AGHT+IGtB48+bp7C59+U74M6SshLRH450SYXd0Hz+n7b0NEvvYagX7Tcgdfj2HC+t6e106s75zEoUA==
X-Received: by 2002:a17:902:d2d2:b0:1f6:3b03:6fa1 with SMTP id d9443c01a7336-1f685743c6fmr26395265ad.56.1717448945464;
        Mon, 03 Jun 2024 14:09:05 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63237d9c3sm70103755ad.116.2024.06.03.14.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 14:09:05 -0700 (PDT)
Date: Tue, 4 Jun 2024 02:39:01 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>, 
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t/: migrate helper/test-example-decorate to the
 unit testing framework
Message-ID: <dsdg4jeoog2awxtry64joaxt4dawwq3ajmm4pksy733vwbsvp7@fgkp7d76pp46>
References: <20240528125837.31090-1-shyamthakkar001@gmail.com>
 <xmqq8qzsuwh1.fsf@gitster.g>
 <CAP8UFD1YVyZj-uGfGXp6UxMfj3kZC5XXNed-5s-jj=ROx4URnA@mail.gmail.com>
 <tubjmjeczh6iigem32ulffvt2ucpygbm4frsr3jsps5tv2i7v5@ly3wge23zn6f>
 <xmqqjzjbqoqc.fsf@gitster.g>
 <zeenwui37wk5ascgqw7kl6si7oyebn6kojidpevxuy2q4e45r4@sdxjxwn4657s>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zeenwui37wk5ascgqw7kl6si7oyebn6kojidpevxuy2q4e45r4@sdxjxwn4657s>

On Mon, 03 Jun 2024, Josh Steadmon <steadmon@google.com> wrote:
> On 2024.05.30 08:54, Junio C Hamano wrote:
> > Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> > 
> > > The latter provides much more context (we almost don't have to open
> > > t-example-decorate.c file itself in some cases to know what failed)
> > > than the former. Now, of course we can add more test_msg()s to the
> > > former to improve, but I feel that this approach of splitting them
> > > provides and improves the information provided on stdout _without_
> > > adding any of my own test_msg()s. And I think that this is a good
> > > middleground between cluttering the stdout vs providing very little
> > > context while also remaining a faithful copy of the original.
> > 
> > If so, why stop at having four, each of which has more than one step
> > that could further be split?  What's the downside?
> > 
> >     Note: Here in this review, I am not necessarily suggesting the
> >     tests in this patch to be further split into greater number of
> >     smaller helper functions.  I am primarily interested in finding
> >     out what the unit test framework can further do to help unit
> >     tests written using it (i.e., like this patch).  If using
> >     finer-grained tests gives you better diagnosis, but if it is too
> >     cumbersome to separate the tests out further, is it because the
> >     framework is inadequate in some way?  How can we improve it?
> 
> I'll try not to speak for anyone else here, but I think the test
> framework isn't causing much friction here in the decision of how to
> split the tests. [However, neither is it providing much guidance. At
> some point we should review the unit tests and see if we can extract a
> helpful style guide or best practices doc.] The setup for the cases is
> minimal and done through the main function.

Agreed about style guide/best practices doc.

> I think the current split is reasonable as a first patch, as it mirrors
> the organization of the original test and makes it easier for reviewers
> to verify that it tests the same behaviors. If further simplification or
> reorganization is needed, I would like to see that as a separate patch
> on top of the more straightforward conversion.
> 
> The only part that bothers me a bit (and this is really more of a
> complaint about the framework than the patch itself) is the carryover of
> state between the different TEST() cases. We can't skip t_add and expect
> the other test cases to still pass, unfortunately. However, I don't
> think this patch needs to worry about that, since the framework doesn't
> restrict persistent state. [And we certainly don't restrict persistent
> state in the shell tests either.]

I talked about this in private with Christian, and we came to the
same conclusion that having independent state would better. But seeing the
original test-example-decorate, it would be a bit more boiler plate to
produce the exact same checks, without relying on previous state. And
seeing the lack of convention (written guideline) about independent
state vs dependent, I decided to stick to having the tests rely on
previous state, similar to the original, and see the mailing list
response about what should be done.

Thanks.
