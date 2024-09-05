Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12EB1FDA
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725504717; cv=none; b=B7++dpKB6se/RENZpH3/F/eXzGBWI1pzk3SVdc5W+Hmh6FyJ+Dfl1D2+2xRaPvH5UZfaZjfk24047Z4StFXcCZ0HmaTu820TNj9d1fFWTZemqRrEuW8CC1QeJrHpdSxN551P+rxjYxbVpDZ2mSgjx6pv7rS0RV/eMWkQIHLzlBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725504717; c=relaxed/simple;
	bh=2OjLkpxattkyw4u9fruz7e0qoJZ6hH94bvkqp59AZjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBMiEHjxN4TKTCYXduZp8AaK26q704hYbmnXp2Vqk0w7bAa/Tcn4tODoc+Hq8E5LYmIqlj0Ni2ndKQzgRZNfLqr+Kuys5YowR2rlZewbQ2lZoEUR3nUFFY2vPv/72laPFiVO5SdAWdp+kxLdEQhTItYj38ythrM83ehkKdB2ENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn3uj0gA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn3uj0gA"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-205909af9b5so2659035ad.3
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 19:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725504715; x=1726109515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdxeCCFBkwpRlXsP07Dbja05nfybbvqRnM1CVLDzALA=;
        b=nn3uj0gA2caD4TV+d5D7+mFNTaPyLI2EoiheQcrOEFSU9cHpyUPeTGnbyABGXAcA2+
         /0VohMdvlYTQVz8ao4oXurc+nJzxJPFc94WHyOGoZZGj+LQ3NK72BK7VJwlwrXYkZu12
         T6jy9868JbAUUMuNoqf0/4y7DJItpm+DF1f4LytcdXKy+LeWiMBCr0SP5YR5P0NozOhc
         iBkSt5wWc8FJCgOcyYUG3mzltKAj3pkOuxxqZKThuXvc+eOnOiEAulsOuUfBDgmsMjX5
         Jjfi1xO7Eva2qC/uFoUZX32Ucfl225vnEdhfmNWN6tF+3ADB3NqI8aLjxF9flOZIzyzi
         I7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725504715; x=1726109515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdxeCCFBkwpRlXsP07Dbja05nfybbvqRnM1CVLDzALA=;
        b=Re+Cbc9ByLZjeVup5BAohDSVvfsUdMW5HuaU1Wv4jV0oC+fuYGptCrBl6wUh4MBzZ1
         6M71TAlBYElpoVjuf6nyNnjIOKmKjr3SuGJlqZ1tvegRl8NQdKeF7zGBejeR5w9bLicG
         l6BhQwxivrgiiAA02XcJBio+4iB6dk47rGh8NnMkJKEMvnlvcoSYb6uj8tGb+0B9iMDS
         Bq7TfcTOQesgpmnLbUr79kb3TL8A0zJ0eHHL1uZxakzHIvXZyEgKuC7zyfVQrPl4XzPF
         gh88Ifiu4aLhYEhjm0oAzD5vPYFrlykmrHfxdD+9tGoOL2Y7hnSNXPLy2WLfeAV6coIh
         +4OA==
X-Forwarded-Encrypted: i=1; AJvYcCWYR5yiLK1pwKlAU7duL09VK7MQlKBwUCki/JCEe0e+3/YiUHq4mLClOKvfUZBX8k3cE9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf4ByCu2GSx9qrwbsz7HBil7g8x5ynT24OkBT7GDapQw9pZT1j
	5zaFWFr8Xurx4Kw0kvv58JUHuNOohVLXWs4adl7KUDqv9GSYlNqfLAI6aXnk++hw45lhz1C5h/X
	8/R9KRTGi3X5TQlWXKxfnMzMkLUg=
X-Google-Smtp-Source: AGHT+IFQ3j/T/8rq0ndljyaNMnOjdIpztPcDPUvOv94R/YB6YHEuW542BaqT5vmPeArVT4DtepiRq8BWE/TTB0buxIA=
X-Received: by 2002:a17:902:e550:b0:205:5eaf:99e7 with SMTP id
 d9443c01a7336-205841c2d1emr118955095ad.38.1725504714812; Wed, 04 Sep 2024
 19:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1779.git.1725472799637.gitgitgadget@gmail.com>
 <e8232cdc-7a5d-485e-84f7-2c05e17f9907@gmail.com> <xmqqfrqf87gb.fsf@gitster.g> <52f6da10-e39a-4a2d-bd9a-5739a49235c2@gmail.com>
In-Reply-To: <52f6da10-e39a-4a2d-bd9a-5739a49235c2@gmail.com>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Thu, 5 Sep 2024 08:21:18 +0530
Message-ID: <CAG=Um+1P8+SJa5aYhuuQ0fVgB0kis0MzMA94oRoBm=SNtROi+w@mail.gmail.com>
Subject: Re: [PATCH] remote: prefetch config
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Patrick Steinhardt [ ]" <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 7:38=E2=80=AFAM Derrick Stolee <stolee@gmail.com> wr=
ote:
>
> On 9/4/24 4:55 PM, Junio C Hamano wrote:
> > Derrick Stolee <stolee@gmail.com> writes:
>
> >>> +           # Run maintenance prefetch task
> >>> +           GIT_TRACE2_EVENT=3D"$(pwd)/prefetch.txt" git maintenance =
run --task=3Dprefetch 2>/dev/null &&
> >>> +
> >>> +           # Check that remote1 was not fetched (prefetch=3Dfalse)
> >>> +           test_subcommand ! git fetch remote1 --prefetch --prune --=
no-tags \
> >>> +                   --no-write-fetch-head --recurse-submodules=3Dno -=
-quiet \
> >>> +                   <prefetch.txt &&
> >>
> >> I'm happy to see this use of test_subcommand to validate the behavior
> >> of this patch!
> >
> > I found it a bit disturbing that the pattern is overly specific.
> >
> > The only thing we are interested in is that we are not fetching from
> > remote1, so it _should_ suffice if we could write
> >
> >       test_subcommand ! git fetch remote1 <prefetch.txt &&
> >
> > to avoid being tied to how the current version of Git happens to
> > pass these command line option flags and the order it does so.
> >
> > Looking at the implementation of test_subcommand, it seems that we
> > cannot quite do that (it assumes that the pattern it assembles out
> > of the parameters are to match the full argument list used in
> > invocation, enclosing them in a single [] pair and without giving
> > the caller an easy way to sneak wildcards like ".*" in), which is
> > sad.
> I agree the ergonomics of the test_subcommand helper is a bit poor
> (and not this patch author's fault). The trickiest part is the
> negative case, as in this highlighted one. It's hard to read from
> this if the subcommand wasn't found because the argument list is
> too specific and doesn't match the exact arguments.
>
> It helps that the same options are given for the other, positive
> tests. But maybe that could be a hint as to how to make this test
> a bit cleaner: make a variable describing the "uninteresting"
> arguments. Something like...
>
>         args=3D"--prefetch --prune --no-tags \
>               --no-write-fetch-head --recurse-submodules=3Dno --quiet" &&
>
>         test_subcommand ! git fetch remote1 $args <prefetch.txt &&
>         test_subcommand git fetch remote2 $args <prefetch.txt &&
>         test_subcommand git fetch remote3 $args <prefetch.txt &&
>
> Thanks,
> -Stolee
>

Agree with both the suggestions here. Updated my patch.
