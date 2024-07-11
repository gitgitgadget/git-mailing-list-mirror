Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0292200A9
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722410; cv=none; b=eMhFbqLikuCbaJIS0XyMC1IOq30eXnNTbQ5Irgnekhinj6/3hiWZ302IlMrUiM8OAYJAs93+amIWTV9mrIzuPEQt0R62gKImOdkthHlnfQvDthgQF/Lbcqc0wmo9lNy1v0H6tiGbfpRhMF0xT04Ui7JDM1s9sxoUwZcuC5Df0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722410; c=relaxed/simple;
	bh=uCAha8EPirVoGG4/JubvNGlc6zW8KTFurVrdlABrHlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMlg5nUrhlVDiqrr+7R1aUfdJSbdOMNcjhydNIh808U1cpfHu9D66Wh/wWA5iTzdMXyHUOB+kQ4JhSAFS2fVBrfV4UOdcCjylP66uaB3eIA3GoO18WGK29Rti8ftQgMIik04SmMEWEnTfcxiwsyyumXgM5IU5Cc9Z10Oxhc+2pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0TElhI4G; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0TElhI4G"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-447df43324fso38461cf.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 11:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720722407; x=1721327207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL7xwbCUwAWRktCHr+Jnu4cT3lCg1yBUnaUVuC5y/6o=;
        b=0TElhI4GkPf4UgJUrSWeBvGKHQQNAotsc4t1/NeovhG807gnqpCVgsawLaHlLmwF59
         4awi/V19np/yYIUikES+zsg9+AqCs+9vwD4R5XdOWATx6BEQHAVAEXzpq/fWF9fartyQ
         GkNJhRfLd1p5iaMFs4tQAKeJuPdu0KYppHbu7gNRC/P6X7dst/pbe1UxsVKEylTo74SU
         50H4f8AU/1TJK9iU6T1R79hOUxJlIG14tfHk2JgO/8BNHqBxNtj1JEA78uHV2l/+IJ2r
         iKOh7Q8L0i9cu5TgPef8FdQ4PKLVXIAbMwdaSekYAAoPB6+xV7W80ZguMaweFqz+8prL
         JZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720722407; x=1721327207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DL7xwbCUwAWRktCHr+Jnu4cT3lCg1yBUnaUVuC5y/6o=;
        b=guEeW+P0tY5xi4OesXDLf7MKXkOlz0SpTieL1zH07iwcY3awAuajUQhN4qQk2gUW+N
         1HhXw6fbKgNCSyL0wNzBJUzktn/MxtZfqUcWc4y08SZqeUZSqQNhou36QkBocOIS1JYs
         9H1cIefnziLwILL4JeaGi19WwagMofQdipeDqeD3z2FgZ9EXf11FzQITsQ0BCVnCSNdp
         F2ypT1eo8wQGkvpghZe+TWh59GZl58pfgjw+SF6o/u6bZMNUK7YqCZK0Tph0Go8wpApW
         BawfmhHMmN0KTrD7jBydkvdNRbQdq55ybnCcAPXuK5kTRYu5KCGWqpHBVjNsLlEbs5Vo
         zkyw==
X-Gm-Message-State: AOJu0YykB8Ce0+qHNOYQSyqF1hRkm9+Ko8f3GoOVh5f9zbOc4rN0e3Bd
	9sLPg7X0lcuddn82pO6+ik0FMbxVR7UiFbI/J2gGsc7OW1qaM3LKejEbt23dqjdjknouCe/+uXF
	+uEnmBCKMXanjli5h6VqTx7Moa+hTLO3Fp4ryO+cxiD5Kuyb+S/VZ
X-Google-Smtp-Source: AGHT+IGLSWJsWvveKkL234mCKp1dTE+EgWkJEXPgUE1z11P8ddH6N66JdRJc8XvPpaNsCC2shTAHulrkdnbLeW4vrGw=
X-Received: by 2002:ac8:4550:0:b0:441:5e6c:426c with SMTP id
 d75a77b69052e-44e798b8f88mr164621cf.17.1720722407414; Thu, 11 Jul 2024
 11:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709225042.2005233-1-emilyshaffer@google.com>
 <xmqqfrsi9i8y.fsf@gitster.g> <CAJoAoZn6zB+e5x6FEvesu173dHhgWBt7ZQ51H8ebp31kQKFCgw@mail.gmail.com>
 <xmqq5xtdvwdm.fsf@gitster.g>
In-Reply-To: <xmqq5xtdvwdm.fsf@gitster.g>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 11 Jul 2024 11:26:36 -0700
Message-ID: <CAJoAoZmJVtu1+1K_B8NcsYKiw+6D9GhtXZcZ44VV-Xp3T5mKgQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add platform support policy
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 1:13=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Emily Shaffer <nasamuffin@google.com> writes:
>
> >> > +Compatible on `master` and point releases
> >> > +-----------------------------------------
> >> > +
> >> > +To guarantee that `master` and all point releases work for your pla=
tform the
> >> > +first time:
> >>
> >> OK, as most of the changes go to `master` before getting merged down
> >> to `maint` to become part of the next maintenance release, actively
> >> protecting `master` from bugs is worthwhile.  What about changes
> >> that do not come via the `master` branch?  Should they also join the
> >> security list and have an early access to the cabal material?
> >
> > Good question, I actually am not sure of the answer. Does that make it
> > too easy for anybody to claim they maintain some random platform and
> > therefore they'd like to see all the RCE howtos weeks before they are
> > fixed? I guess that we already have distro packagers in security
> > list/cabal, so it may not be worse exposure than that.
>
> Stopping at saying "You may want to ask to join the security list"
> and then leave the vetting process out of the guidelines for the
> contributor (i.e. out of this document) may strike a good balance.
>
> We will obviously be careful about whom to add to the security list,
> but that does not change where people hear about the list and apply
> to join.

Thanks, done.

> >> All of the above are actually applicable to any active contributors
> >> on any platforms.
> >> ...
> >
> > Hits close to home ;)
> >
> > Does this mean that this part of the document should go somewhere else
> > and we should just use a pointer here? Is there a guide handy for "how
> > to soft-fork Git"?
>
> Once we have a contributor guidelines this is a good material to
> migrate there, but that would probably wait after the dust from this
> document settles.

Ok. For now I'll leave it as-is.

>
> > Maybe something like this is better?
> >
> > "Work closely with the developer fixing the issue; the turnaround to
> > check that a proposed fix works for your platform should be fast
> > enough that it doesn't hinder the developer working on that fix. If
> > the turnaround is too slow, fixing the issue may miss the next release
> > or the developer may lose interest in working on the fix at all."
>
> I think that is a good approach to take.  "We will not promise to
> wait for you if you are slow, and that is not limited to those who
> are working on minority/niche platforms" is a good point to make.
>
> >> > +* If you rely on Git avoiding a specific pattern that doesn't work =
well with
> >> > +your platform (like a certain malloc pattern), if possible, add a c=
occicheck
> >> > +rule to ensure that pattern is not used.
> >>
> >> Sorry, but I do not quite follow you here.
> >>
> >> In general, it is a bad idea to promise that we are willing to tie
> >> our hands with coccicheck to satisfy needs by exotic platforms,
> >> without first having a chance to see and evaluate such needs.
> >>
> >> "if possible, add" -> "sometimes it may turn out to be a good idea
> >> to add", perhaps?
> >
> > Maybe it is better to ask them to discuss it with us on-list, and that
> > the result of that discussion may be that they should add some such
> > test? Or, do we want to firmly say, no coccicheck restrictions based
> > on platform, give us a CI runner or bust? I don't feel super strongly
> > either way - writing this section I was trying to come up with any way
> > to get on-demand ~instant (<1hr) feedback to any contributor, and this
> > seemed like one someone could do. That doesn't mean we have to let
> > them, if we don't like this way.
>
> Yes.  If you want to add additional constraints on how the codebase
> does things, discuss it on list first and work with us to come up
> with a way to without forcing too many unnecessary constraints on
> other platforms.  It may result in keeping the generic codebase
> pristine and free from #ifdef and having platform specific code
> somewhere in compat/ but such details do not have to be spelled
> out---they will be different case-by-case and we will hopefully
> devise new and improved ways to deal with them.

Ok. I've got a rephrasing for the next reroll; still thinking I can
get that sent by tomorrow latest. Thanks!

 - Emily
