Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74118254841
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753789015; cv=none; b=XSgRUtybDUjNGqVuaRfc9Fd6m4C0W0peJfcT5yV4z1ZcbSoDSwwz5XNMTuD6wl2FVU3nPXyfdxsdePVdT357sI5sZh7nopYXPYoRvc73TCH+ocej4uKMdXQHMUR+2XpaF2o13FMp6GnQua98/gRfTUvmttUMVhHDA9lxPrmQp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753789015; c=relaxed/simple;
	bh=uaXr09hqLrV1Q7nDlx7yeRShxultmC3A0zRPs1HG4hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmpPvndVj4ooMPoH3gDtQbUlNaehZhcgVRP8LN3LsdnIJ1N0Q/jKOsD9kamRPjUk+gmx+6O/RPDIflfUpJgqOMS5tzlytr4CKI0o//qEVr2LwMPcPbscFugctSNazwfkfL8R+OnW1oUZUO1oVXDhzSaTNUciJZp4F3w8bW1TQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A11LfLto; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A11LfLto"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313a188174fso716827a91.1
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753789014; x=1754393814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxeJwbbvlUW7B6TRh0Bmx+u1iu1QUJxggaqXmL37lgo=;
        b=A11LfLtoyjr5I/s1JTIXSPuKnBnSIPOcr3/ZV7OYi3YAACZ6EhJYDPYk4RcQ8u5zx0
         A6WYEGfWxnIVp3d9DP2Plx+gy7N486xcVR8Dmw/Jt0A/fzaBqEvZIHkfPku6szmozvQC
         RYD6XVW0EYwFp4v1C9lh5j1YW8wTZ7DCUZy/zW9ZovWsznzAQ1pv5f1oPbnCDmEZstX8
         RjHH+G0J3+MYs5d5Q4er9luwrETu+hNk56k00ALUVwKn9ekTmJ/gRyuPrpSvlPSSoraA
         +1m0JFWgf/nqKDPLkdqjQDWPG8RtwI2nr6i84ufqXfACOQDt9j7JFUK60GATXaM1t+rO
         Vosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753789014; x=1754393814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxeJwbbvlUW7B6TRh0Bmx+u1iu1QUJxggaqXmL37lgo=;
        b=tTLeQ+u+CrGAywQuscw9ShCJmBLBpZl4RAZrE4jx1HQ3TDHo/zVLzVG3wIYWR7wnNk
         oM5OVvdLqahTWONDeoImZun5q4NpWGdENWIlgWnvfPE65Huk/pvROYBqqBFFV5J5Xd6H
         SG2CWKCQh3jChvvC8gTnpSdEzIjnUHB1gKosDa8q8pKicf1ic/rosW1O8jFbrexS+++H
         c36p7olM69KoJ81/xuWmD2VNDKj1p09gJ/2rul/ji5wqZOWRpOxPIAF9H7wLUbgGYUsM
         XxIk4QpBJtpF5uHKOeoX+bXjoUwbUVE3guDyZ4s5JgCqN6qOk9uoDt4XPfvGAUIB9A4l
         R/bw==
X-Forwarded-Encrypted: i=1; AJvYcCWRkxma0X+i41lllZ+lmXC5iWPkYbK2Ufut67J6HDQqUZVmAoC83UArLW3vUmyKlTFq8RM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvc/ouGNeUj4fw3OaPPiTqH9Dc54uFjmU8wNBKI18DIPMl/inJ
	lDNVCJXYn8rNrsoaNmkKTLexB3/RyxQc8fQ+BKNjlcDn9tUXSiwvCxXniIqZwz989taWPbhdYzk
	7x3sPlldfFAHVKAjDwtgPQuvRaM9/o0g=
X-Gm-Gg: ASbGncvW8WH61RESkAVIoryyovcz6t495TR4jUMsK3trt9aiqvFMooAW0thXdxzmvL3
	Y0NnvlxpUsPx10icvosoR3YKJggwDReTi4+pOGt9LmD7a881vOmEkVt6l1BQd1sEfiZW788YnZb
	Y4cXpozEVswZwg9BjUiJJyhVodqc8ppRtIoril+CCtC3qaOCLZin574+2k2lw6Wpw7n2QaS5jPS
	7YvWEvTkwSacEz5qSg=
X-Google-Smtp-Source: AGHT+IHzRtuDCA45QXyBMID2VYZAFCDNHAHD9VxGhHyfx6vJojfR54R7sNQAwXgCMO81G6e3lFbW0wG1IyVLB0MIml4=
X-Received: by 2002:a17:90b:3b8b:b0:312:dbcd:b93d with SMTP id
 98e67ed59e1d1-31f28ceb59emr3920818a91.14.1753789013437; Tue, 29 Jul 2025
 04:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
 <cover.1752882401.git.ayu.chandekar@gmail.com> <xmqqcy9qlfm8.fsf@gitster.g> <43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com>
In-Reply-To: <43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Tue, 29 Jul 2025 17:06:39 +0530
X-Gm-Features: Ac12FXxwmEGnWAzewekBlRRbdEzNt1-X4sIZ6MaMNRzv3GiuY5cWsnH4J_AEie4
Message-ID: <CAE7as+bnG6KgA8X_n36pqP15bmyM6re+xEb1MOXKvZSUdJ8Arg@mail.gmail.com>
Subject: Re: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related
 global variables
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com, git@vger.kernel.org, 
	shyamthakkar001@gmail.com, phillip.wood123@gmail.com, ps@pks.im, 
	ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Derrick,

On Thu, Jul 24, 2025 at 6:55=E2=80=AFPM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> On 7/23/25 6:14 PM, Junio C Hamano wrote:
> > Ayush Chandekar <ayu.chandekar@gmail.com> writes:
> >
> >> This patch series aims to remove global variables related to
> >> sparse-checkout from the global scope and to remove the definition
> >> '#define USE_THE_REPOSITORY_VARIABLE' from a few files.
>
> Sorry that I missed early versions of this thread. It's an
> interesting topic to me, but I've been distracted.
>

Thanks for joining the discussion!

> >> Discussions since v5:
> >>
> >> * For 1/3 and 2/3, Junio told me that it was concerning to put so
> >>    many calls to `prepare_repo_settings()` so I tried to minimize the
> >>    calls and made sure that there's no useless calling.
> >
> > I didn't mean that the number of places is the problem.  What I
> > found troubling was that this is not done in any central place, so
> > it is hard to notice even if some random cmd_foo() failed to call
> > the function before doing its real work.  For example, shouldn't we
> > be able to, at least for built-in commands that have RUN_SETUP bit
> > set, centrally call prepare_repo_settings() somewhere late in
> > git.c:run_builtin() after we figure out what should be in
> > the_repository?  Now historically, setting up a repository may never
> > have involved opening and parsing tons of configuration files, so
> > such a change may be incurring extra overhead we did not have to
> > pay, so it needs a lot more thought than just trying to minimize the
> > number of calls, but some performance measurement.
>
> I think that the core issue here (and probably causing the issues
> that were seen in the user-facing issues) is that the repo settings
> struct was intended as a place to fill config for some one-off
> "feature flags" and not to replace core functionality for a repo.
>

Oh, that is the complete opposite of what I had understood. I assumed
that repo_settings is used to hold some core repository-related config
settings, especially since there are already quite a few stored there,
and shifting these to the struct repository would probably clutter it.
Given that the existing configs in the struct repository are mostly
'repository_format_*' and having Patrick address that we embed the
repository_format in the repository as they were increasing[1], it let
me to think that we should try not to use the repository to store
these configs.

> There are two ways to change the approach here to fix the problem
> of needing prepare_repo_settings() everyhwere:
>
>   1. With the idea that these sparse-checkout variables are
>      critical to the functionality of the repo, they should move
>      into the repository struct itself and be initialized along
>      with all other values there. This changes the patches (and my
>      follow-up series) significantly, but mechanically.
>
>   2. If we are going to change the intention of the repo settings
>      struct to move from "optional one-off feature flags" to
>      "important information about the core behavior of a repo"
>      then we should prepare_repo_settings() when initializing the
>      repository struct.
>
> My preference is (1). The only argument for (2) that I can think
> of is that it is sometimes helpful to share only the settings for
> a repo without sharing the whole repo. But that seems like a weak
> reason right now.
>

Okay, I agree with your points. I can maybe send a new version to address t=
his.

Do we also shift settings like index.sparse to the repository then?

> >> * For 3/3, Phillip told me that it broke user-facing as it will be
> >>    parsed quite late in the callchain and might throw an error mid
> >>    operation which we do not want.
> >
> > So has the behaviour change caused by 3/3 been resolved?
>
> >   * This throws everything in repo_settings, but these settings are
> >     inherently per repository and they are meaningful only when you
> >     are working with a repository.  What makes us choose to make them
> >     new members in the repo_settings structure, not direct members in
> >     the repository structure?
>
> (This is the same thought I expressed earlier in this message.)
>
> Thanks,
> -Stolee
>

Thanks
Ayush
