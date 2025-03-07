Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99821D58C
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362279; cv=none; b=XrYCW0uPqfsF+2wJS2l3uToNG7qnuS5LhRfJqyjhI0z2WZpPuQ9Rkn00VI9pNpgnRG43+BBgqZ6jVYb+q5ZuqzsJqf2CTn/Wz6l++cJmIjRukhxloWYYsWStG3H82HPyRV8tkedemHJuh7WRSqWjyj9RiyWi5dlSlHE4Kr1YnXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362279; c=relaxed/simple;
	bh=RqNZHITLW7wqJizTLG5wQqpVsqjo2863Mtz4zm/la74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsNPE+3gST3WoOOltJeN/SSTEhITmX1NDy5yaVPU5YkkB0Q7DCcqpAv8pcqyYpZo2P6R+2Ah9nTn6y6H3oUK096j7a9e+G2QkwyAen1DgH1p0S7LPQC+9EWnNu7MYj8BtbUIzVkgmGoPgnb+NXgkPZF+C8IweprEtt7+tcNyaSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvnGatOP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvnGatOP"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2feb867849fso3225677a91.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 07:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741362277; x=1741967077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kie/GQQrLD57RYQ1RIMSCmNHb5gqxBz/GVU7qNMYVTg=;
        b=KvnGatOPZ1AMO7YYfNUFoHNli81AYS8246MQAqsrLjMik5OfARl97o7AJjeQts3kJ7
         CNNeTEhgCjpToToqUZUxPWBi8IacueYgPuYOldDHb7OkqogD8PO1kVceATQwhTHWnGYK
         ph4YIlb634nPFZ4DP/hcjJmgfI7flZ9ajqzWubVwKqUn3Br5nlm8yUd/4onBiS/bfZmh
         rOwIwLfx9+fFyIIX2MWVwknxW4R+3DWRoXybN9Dhqj42Z9Wtx+JbYEtDL+akxOiFhZRB
         +Bt283hM72YqXbDb0kit/AfcfzXunnw0PsQ/rgzkwLhm41OpSaZs5t0+sWeu9sOWI9eu
         BL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362277; x=1741967077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kie/GQQrLD57RYQ1RIMSCmNHb5gqxBz/GVU7qNMYVTg=;
        b=JEvdkigtw+wp/0liWYvEMw94xNNW3OWt/3dSzxXVOpvatqLGm5/hzXZ/r6yo8pAKr7
         Qwsm5FBPmkM/qlpYVBkxKI+3b2PtD5dMByDCzVmGfaRlAks/PdRYeZ3nrSQgudvhqcFP
         6D7X5JgktOWPXr487/CHTVxCFqEwKCPpVPy3fqXFX+88zjrOj+dtqcfgbEwasIojuo+Y
         /0mlb22aZPahS3GZ30qgXrZPT83sx9h91IUp4AITZ4LR/gd33nn+aMB2DUN9+6uAdJ+f
         diIm18RMtMOMpw7fFlXZw3ayxPvtTd4A+cuAQH/mCSB5BYf80n31CAeVql2CCC8MxqHQ
         ZpAA==
X-Gm-Message-State: AOJu0YzMeuKY+uuWsBz+iqMubeSt+Fb3rgyoWVUwxAkBhMt4wV3/U3Ap
	Q1KEAaEibDDDwm7IOGA17sTDFwNSC0y1W3ufhTFEL3zOjXpK7bUyAH6gZexogltQRLW3AeXfdln
	PVUm0NdriIYZELUNYV1OJqT0OATOxymH1Kll2yw==
X-Gm-Gg: ASbGncs/vOn+fd8s7IJ0f9fvLbSTF/qQqql6zyBGEquzkFmzuIKhrn6r906h/Gytl8p
	HUxAaH2JodgRQgkAyxpH+ZIXT9WlB9IzbxV5nyNSvWwOsdsHTBavg0HIS5oGoy0WqLuhb4vxWOh
	WqBB+P/oislyiL4k0cNiNNKR3t1Xw=
X-Google-Smtp-Source: AGHT+IFz0NbDtokUylQahiqiH+tn9kJSVlk3eq+PkNTdUdjT32AY4ctAh6t2vON5KrzPvS2pb3NEvCS/80jMog+ZaRY=
X-Received: by 2002:a17:90b:52:b0:2ee:863e:9ffc with SMTP id
 98e67ed59e1d1-2ff7cea6e4fmr5666355a91.21.1741362276631; Fri, 07 Mar 2025
 07:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305104650.238392-1-ayu.chandekar@gmail.com>
 <Z8g4dTSFQDTi9ueU@ArchLinux> <Z8qpxj2i3vFjJe4l@pks.im>
In-Reply-To: <Z8qpxj2i3vFjJe4l@pks.im>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Fri, 7 Mar 2025 21:14:25 +0530
X-Gm-Features: AQ5f1JqqU4LrHylJ4cDx1vURSEGr0-7J5C9d7DyWNY1cWwoiR4UDhfxsmjZHWu0
Message-ID: <CAE7as+a+z9EgBnws-a4250TN_hDgWgapefxVAQHvpmUEfqKeTw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Discuss_GSOC=3A_Refactoring_in_order_to_reduce_Git?=
	=?UTF-8?Q?=E2=80=99s_global_state?=
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, shejialuo <shejialuo@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Thanks for taking the time to respond!

> Yeah, things depending on `startup_info` are definitely a more involved
> thing to address, and I wouldn't necessarily recommend it for the
> initial batch of refactorings. I'd recommend to rather focus on some of
> the global variables we have in "environment.c" that store configuration
> values, which are generally a bit easier to tackle.
>
> Also note that `local_repo_env[]` is nothing that we need to adapt. It
> only stores a couple of environment variable names and does not have any
> state, so it's perfectly fine to keep that variable.

Okay, got it.

> It would be a bit more involved than a typical microproject, but I don't
> think it's particularly bad. It would involve a couple of steps:
>
>   - Investigate all users of the `git_attributes_file` global variable
>     and how they interact with the variable.
>
>   - Adapt `git_attr_global_file()` so that it knows to not only handle
>     the fallback value of `xdg_config_home("attributes")`, but also
>     knows to first read the value from the config.
>
>   - Adapt `git_attr_global_file()` so that it accepts a repository as
>     parameter so that it doesn't need to depend on `the_repository`.
>     This will also require you to adapt all callers.
>
> You _can_ use this as a microproject, but as said it's a bit more
> involved than what we'd expect. Which isn't necessarily bad if you
> manage to pull it off, but might make for a bit of a steep learning
> curve.

I already submitted a patch quite a while ago: [1].
Thank you for clarifying how to approach this! It looks interesting to
me, and I'd love to give it a try.
I'll study more about it and hopefully submit a patch soon :)

Thanks,
Ayush

[1]: https://lore.kernel.org/git/20250202120926.322417-1-ayu.chandekar@gmail.com/
