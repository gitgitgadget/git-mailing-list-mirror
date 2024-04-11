Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3B1C2FFB
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849889; cv=none; b=I3c8dGeiPhjMfU7fC6QnIG6ZdOrD28EK/wYGRKMxPzRKmRG2aqAqzApINMjHZUoZaLGkgxv54XNnpKAGXm8Lrbk1hZLKM62Suv1HMkzy4L/p1Wfs0KZXo/UGjkb55fX1d48Ol3z0K17I54lPO+gX49ncTe7n5eK+oCOjGHBs9GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849889; c=relaxed/simple;
	bh=P5gVl4qfsPpEjzPKvUM9alwU5+fN+sNJ0PtGvOu45xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rd69m0NFDH0iKWFHOD52YOWQBqmD1EpzWT/jNjD0gwv5YHfybKJpgqaTw1wFDJXAFhC9WZlmuOBnEgkQ8P4GscYh+brXdO3Ln/5C3/GHMytqP3480yMlouaT7YPmMrSTk+RYXu0FNki/xQoOIicJ+pAhdBDTiJCYHSwXpcWJEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwylK78g; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwylK78g"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so75646451fa.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712849885; x=1713454685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp6mMfR2zAVZOqQa1XNGHGHNfEoQJayu2EiJRqWYO+o=;
        b=TwylK78g3E6Dw3huLAs/pVkOBzQesNFZUHDd5rKOLk/4JOe24XNVw4GxR9sUSoEWjE
         l0EpS2QwEUthZrKFhVq3ehisu+dDdPGHWrzJ0COrbWEFnS9qdR+POOjw76yVxedyw2no
         RTWeTPCpQPXj3AbFDX5mdXafuIChEdQyE6MpZslEgUtHW+rnVeloNSIFqI0CrxgL5run
         5AdqT8gSUSu885++45KqjVO4s8AFUnIlUTdoyBoW9f6ahYLNXMHjG98MNRqPxM/RCW7t
         ZVDNYkBy9/cNXZl6OZJvnSDmlRb8RZ/nCaC3fv8yy9N4mzE7HAmrl115Ptbm+grPuevX
         beFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849885; x=1713454685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gp6mMfR2zAVZOqQa1XNGHGHNfEoQJayu2EiJRqWYO+o=;
        b=YpJpu9eiY5drPy0rVQe/eHCkzkwCQAR22k/omKZEmuBzN2+hTIjCSTkpPhsxAGb0Eb
         7lEgjENRb94OWCOXxF8ZPBKj7tFbD0vrfeuz7ztGtpo9nLLDJeKCF/Lgt08CQ8YAi27n
         TyPnBBHjpvKI+rUH9rG39fcG7R/WaQ0r8Tu2/iLiY9d3dLu4klwgRI07+ksMB1P4C5mD
         nn/N6/GZkAErJK6Ht+pArMvInUpSG3+0qqjTFajjC7sG7GEOQw75443C3t2Dos3YqTlh
         YldR2RgolLt5zE6s11Ho0xFgYbqOCSTsO/nSpZ1OE+JzZ0ySvyNijxrsrAlvvhQz33ja
         dCbQ==
X-Gm-Message-State: AOJu0YzNaqVqAGo1bjHhYnRqkI4BA5mmqAhxWZTk3WiMzST24aANy5Cp
	QXawBhbVcXwExrjWT06QI22D61UjddKKT7e+0ctwgcmSvTWFhs/f9LVew7JAkd9q7rCHCDl2yM7
	5FxTLUhK4RllSo/dOUcnVwN8hBGw=
X-Google-Smtp-Source: AGHT+IFHaaTAaeut6vKACemrP+RpUGRCNUmgq6i9vkF24IPU9n10UEtEa2JB6GSbj/9KqfC+fUxlxmvaeQv6e6GD3jU=
X-Received: by 2002:a2e:7408:0:b0:2d7:1f9e:670 with SMTP id
 p8-20020a2e7408000000b002d71f9e0670mr23652ljc.0.1712849884965; Thu, 11 Apr
 2024 08:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhcBJSP4MxX0AMFM@nand.local> <A7406B15-8DF1-4B3E-80F3-BC56A9AC4D85@gmail.com>
In-Reply-To: <A7406B15-8DF1-4B3E-80F3-BC56A9AC4D85@gmail.com>
From: Scott Chacon <schacon@gmail.com>
Date: Thu, 11 Apr 2024 17:37:52 +0200
Message-ID: <CAP2yMaLpJqZ+aC=rNPjkw2ybW7PjfbW5QuHnZ9mYs1NhJ1L5mw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Virtual Contributor's Summit 2024
To: John Cai <johncai86@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Heya,

I was about to come in and say roughly the same thing. GitButler /
myself personally
would be happy to help organize an in-person, recorded talks Git Merge
style shindig
in the fall. I'm also happy to help with some of the core team /
speakers with travel
costs if needed.

I helped organize the first Git Merge in 2013 in Berlin [1] and would
love to do the
same thing again this year (my my, have 10 years gone by since then?)

If everyone would prefer Chicago again, then I'm happy to just attend
and help out
however I can. If we think it might be nice to bring it back to Europe
this year, I would
love to take care of it.

What does everyone think?

Scott

[1]: https://marc.info/?l=3Dgit&m=3D135896927120693&w=3D2

On Thu, Apr 11, 2024 at 5:18=E2=80=AFPM John Cai <johncai86@gmail.com> wrot=
e:
>
> Hi everyone,
>
> I'm grateful for the chance to gather virtually like this, and for Taylor=
's
> willingness to host these each time!
>
> I also wanted to throw out the possibility of an __in person__ Git contri=
butor's
> summit in the Fall!
>
> GitLab might be able to host this, which would be an awesome chance to ge=
t together
> in person like we did in Chicago a couple of years ago. That was a valuab=
le time
> to talk about cool topics, but an invaluable chance to get to connect wit=
h each
> other personally.
>
> It will likely be a two day conference in October of 2024. Location is TB=
D, and
> depends on the level of interest and location of those interested. Requir=
ements
> for attendance will be the same as for the Virtual Contributor's Summit.
>
> We wanted to first gather interest before determining more details. Pleas=
e fill
> out this form to express your interest: https://forms.gle/hTcsYM4fomEqaKU=
59
>
> Feel free to also email me off list with any questions
>
> Thanks!
> John
>
> On 10 Apr 2024, at 17:14, Taylor Blau wrote:
>
> > Hi everybody,
> >
> > I've been thinking that it would be a good time to gather informally vi=
a
> > another Virtual Contributor's Summit.
> >
> > I had been waiting to see whether GitHub was going to host a Git Merge
> > event in person this year, but it looks like the answer to that is
> > "probably not" (though I am hopeful for next year[^1]).
> >
> > In lieu of meeting in person, I think it might make sense to meet
> > sometime in either this upcoming May or June (though we could extend
> > further depending on folks' availability) in the same style/format as
> > our last Summit [2], the details were as follows:
> >
> >   - We'll host the Contributor's Summit on either Zoom or any other
> >     conferencing platform that works for folks. (I spoke with Emily
> >     Shaffer off-list and they mentioned that some Google folks were
> >     interested in Discord for a few reasons, so we could do that, too).
> >
> >   - The schedule/duration is not fixed, and there are options to vote o=
n
> >     preferred days, length, and timezones in the form(s) below. Last
> >     year we did two four-hour days, so we could do that again (or
> >     anything else that works better).
> >
> >   - Like last time, in order to participate, you must be either (a) an
> >     active Git contributor, (b) planning on contributing soon, or (c)
> >     working on a Git-related project that has interest in Git's
> >     internals. If you aren't sure whether or not you are welcome, pleas=
e
> >     ask!
> >
> > Participants should fill out the following forms:
> >
> >   - https://forms.gle/VVrJ7RbHVxurxZH99 (participants)
> >   - https://forms.gle/iGnfexF4hDuK6MQe9 (topics)
> >   - https://www.when2meet.com/?24557185-cHKWv (When2meet)
> >
> > New this year is the When2meet, since this seems like a more efficient
> > way to collect which dates are open for folks within the next couple of
> > months.
> >
> > The participants and topics lists are being recorded in the
> > spreadsheet below, and this is also the place to record your vote(s)
> > on topic selection.
> >
> >   https://bit.ly/git-contributors-summit-2024
> >
> > Please feel free to send any feedback or suggestions you have for this
> > year's Contributor's Summit to me on- or off-list. Like last year, my
> > hope is to have a small, remote-friendly, diverse, and efficient
> > discussion.
> >
> > As we get closer to the date, we'll finalize the schedule, make sure
> > we have volunteers to take notes, etc.
> >
> > I'm looking forward to seeing everybody (virtually) soon :-).
> >
> > Thanks,
> > Taylor
> >
> > [^1]: Coinciding with the project's 20th anniversary!
> > [2]: https://lore.kernel.org/git/ZMATKIaU1A1D0wJg@nand.local/
>
