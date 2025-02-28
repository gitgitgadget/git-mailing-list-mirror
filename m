Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634C1CD205
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787030; cv=none; b=Ny8Ho6tkfRf+EogwqmVK4/L7FOdMPffbM5+medZcXyDaEHKDy/vJngAG/pVeAN6Aj7zcGvuwiR2YSj/zYD/AZq8CK4Git8NTQrFbU3VAv9qeWeb72hIlNBdnVGHCgOQAbYyXTMn8Pa1FwFaAfPjwXYzWukhfqqEU+zeQaU7RRWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787030; c=relaxed/simple;
	bh=xS82FGg+QTzLOng6F1yg3xafCNSwkgtvzZJl0aDhxCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpZ2WSRY5HRYlk98ztueX0F2Drlrz3YLxBzthUbs6YykSmycjV0/HfMdqfd39SwaYmRTXu5tQMgpbMH4DyyFZRZj5p3ec+WJB4itMujDtM58M4LWU+iagTmH1IFPMWR17FrPkdmGrETAmnFQjQzUmsemNRU85G2nj3il5cSiOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6HW9pEL; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6HW9pEL"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86b3ed5fde5so1960466241.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 15:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740787027; x=1741391827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2pw/2DHzXoGUhFui4X+H5VhsKj6pETHAJr7jHrcwj8=;
        b=X6HW9pELvlanXmpf3VR+x40sGOQ0NimkZrWv4YRWh5FlJv5+vAdIgRlueN2v9W7JOk
         nKb7zAJCTsIcDGuvMLV58sPU81u0rnCnlXAR2ehLuKkFoD6sgULQ0zaWMZ9VCn2Ug0Ck
         ariuqdlK7u3xY6dNEU+8VTaMQothwKLobCIkgnODZm+/UKr502c4JZGNKrMKtcdRoCCE
         GyjZe9QcqgvnlvZxHDu1FdirYYSH/6vQGFrRmZ4rMz8CqeN8qN//tZTVghdrK/O4Wq7X
         8R8CsYeWrz/sE1WExLySusfmWQp2kv+h5UsqhGD8oQVALqSSBkEbe+m2VOAxntCfoMPr
         x7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740787027; x=1741391827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2pw/2DHzXoGUhFui4X+H5VhsKj6pETHAJr7jHrcwj8=;
        b=iaWciGd5DhydE0tJZehYN4N82HxcAqVFDVGGDk/JlXu45Qe/5dEb9jX8EeOCmde/6m
         QYl+0HaYCOmd8VTYNOohUuaolwEASX/YMIuVn0qS2gsgcxMrzV4o6FRsBv7R7UovEe2a
         5anS5cT1NaSNVcIA+zLNzFf9I47TFSu05kwf0F5oFevn60z1nUIZznMzYlexTlHD4mNc
         mLJUZOz6auaAPSl0GjQQYLDpPlreBO3dL2jIAn9rE+wCmBWJhFzvv/185dL6ghLsdkO2
         I4GK5za/V/pzDi/RKEBgaj6XKfqAKMNwwPuGKiB/sXoovALXytA4aj8FNPz6hoh+qn43
         L7Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUOPTXjcPr1unGqfCwDbWRwA3xrXKGl2OKgSZaY2oYJ3Ij3NZQpCJ5aLosdTnzAsMXTTh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVM7k7/6Z0NPxVxLn3hVQcLWzGbt3mNObB7cSC4gED5wX8aSfL
	YGrSE89KGzjrl3Mb8yfKn6DvleIGF+dc33f8JXU4TPa4FY/8GzPtbW5o0UE+f+WqTG63v7xNH++
	6hlvjK15QROMGxBaZXegXwBtu+34=
X-Gm-Gg: ASbGncvsiWLa9OHyF/EIzh7/tfYAFNC5dE9hyPrNORifuQFktQx2+huBiNfkrIVHVkB
	UetuZvAPZqTqqcFN0yHzVKecLBUXbGg0WvsJacrQtsJz6hkYAwq8UkVEhWdnFhXoug+pfz2QQRo
	azxtnRVus5DfNAaJ/whHLTlehW/Q==
X-Google-Smtp-Source: AGHT+IHHK+d5GRXnBU7v0CSqFxDHdjSCjtO3C+OFgHkEoW8Xz1k0fa7Rtl6P/TM3QSH5wo/Hwq7Nl1HNarc8OC/dbyA=
X-Received: by 2002:a05:6102:5549:b0:4b3:fee3:2820 with SMTP id
 ada2fe7eead31-4c0441c83e1mr3915641137.9.1740787027410; Fri, 28 Feb 2025
 15:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227175456.1129840-1-usmanakinyemi202@gmail.com>
 <4e21312d-0d9a-404a-a2e0-0e2fcc681ad6@gmail.com> <xmqqbjum2ayc.fsf@gitster.g>
In-Reply-To: <xmqqbjum2ayc.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 1 Mar 2025 05:26:55 +0530
X-Gm-Features: AQ5f1JrAsMAqsh2ty5jEKYytbJxZ6WeXbLjMTwDpPvwCo38wajteDm0UAAREYfc
Message-ID: <CAPSxiM-fzKUtvvf-DB2=VaGznr9utyb6zaKU5onxpy49KPChUA@mail.gmail.com>
Subject: Re: [RFC PATCH] config: teach `repo_config()` to allow `repo` to be NULL
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	christian.couder@gmail.com, ps@pks.im, shejialuo@gmail.com, 
	johncai86@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 11:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Thanks for working on this, I like the idea but looking at
> > read_very_early_config() it sets "opts.ignore_cmdline =3D 1" which mean=
s
> > that this will ignore any config options passed with "git -c
> > key=3Dvalue". I think it would be better to call config_with_options()
> > with the appropriate options directly.
>
> hmph.
>
Hello,
> > For this to work all the commands that run outside a repository would
> > have to read the config via repo_config(), and take care not to call
> > any of the repo_config_get_*() functions. They mostly seem to do that
> > but "git for-each-repo" calls repo_config_get_string_multi() - it
> > should be easy enough to convert that to a callback when that command
> > is updated to stop using "the_repository"
>
> Well the only reason why we want to allow NULL in repo_config()
> calls is to accomodate this pattern, if I am reading the discussion
> correctly.
>
>  * A command that wants to run in a repository (i.e. marked with
>    RUN_SETUP, not RUN_SETUP_GENTLY) is invoked with "-h" and outside
>    the repository.
>
>  * cmd_foo() is called with "-h" option in argv[]; repo is set to
>    NULL.
>
>  * The typical start-up sequence for any builtin cmd_foo() is to
>    read the configuration and then call parseopt, and the latter is
>    how "git foo -h" is handled.
>
>  * Historically, the "call the configuration" was done by making a
>    call to git_config(), which used the_repository [*].  But recent
>    trend is to use the repo passed down to cmd_foo() instead, and
>    replacing git_config() with repo_config() blindly would break
>    unless repo_config() is prepared to take NULL.
Yeah, these all are true. Also, "git for-each-repo" and many other commands
seems not to make use of rep_config() or git_config(). I think this change =
and
functions are good for command marked RUN_SETUP since their behaviour
is pretty straight forward. I think, we might want to use another approach =
for
other commands that are not marked RUN_SETUP if we decide to remove
the_repository from them.
>
> So, any command that requires to be in a repository would not go
> beyond its call to parse_options() when called with repo=3D=3DNULL.
> Either it would have already died inside getup_git_directory() when
> "-h" is not given, or parse_options() would have gave the usage
> string and exited.
>
> For commands like "for-each-repo" that itself wants to be able to
> run outside a repository by marking itself as RUN_SETUP_GENTLY,
> they do have to update the code after the parse_options()
> themselves, of course, but I view it as a separate issue from this
> "we make git_config() as the first thing in everything---we want
> to replace it with repo_config()" patch.
>
> Thanks.
>
>
> [Footnote]
>
>  * I personally think that it is an unhealthy fundamentalism to try
>    eradicating the use of the_repository even from the top-level
>    calls of cmd_foo() functions, which are like traditional main().
>
>    They are never meant to be reused as a subroutine that can work
>    on an arbitrary repository from any arbitrary codepaths.  The
>    special repository instance, the_repository, is set up to be
>    suitable to work in the current repository, if exists, and gives
>    a reasonable fallback behaviour when we are not inside a
>    repository, which behaves exactly how we want it to behave there.
>
>    The more library-ish helper functions (I am talking about
>    distinction between what is in say builtin/diff.c and diff-lib.c
>    here and referring to the latter) are totally different matter,
>    of course.  They are meant to be reused and they should be made
>    to work on an arbitrary repository from arbitrary codepaths,
>    hence reducing the reliance on the_repository is a good goal for
>    them to aim at.
Yeah, I understand. I believe these change we are trying to make to
builtin commands that are marked RUN_SETUP is a good goal due to how
they work, what  do you think ?

Also, about the testing, I was thinking of using the clar framework or the
test-tool, do you have any in mind ?

Thank you.
