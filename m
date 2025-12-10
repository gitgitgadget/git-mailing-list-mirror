Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DE7221FCA
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765349717; cv=none; b=X3NlOnAnlgnKEgGA2yd1vBW4j0SVP4NGL3uUWWk7eZ11WF92Fr45tCyluFeGe1WzF/oLWW7xGX6gfS/BB5W1xfS/HcBWR1UKI1rUw6KjZYeU3T9vZ/QzgyjuVLbWF4wvtAcPHxBvHeA/ceOPvrjqhUEvgKcA5HA39oDrTvZQ8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765349717; c=relaxed/simple;
	bh=K9xCD7r3KgGYLplKo77XHxcF8kBm4zG7/M3kyMHMPs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pbt99l0JFJmUjAbCVV3Z7W21/LCqHKKlOeVyJWefCxyL9KCJbrF09597cD5w1oC/t830opWUXDdDkP7U8QlkODAzTOe98h0XyUEfM2pEdHd0JZziTx0SqzToiGU9h9MYZ8ll5FVevE6JM1Qk5UqzlvX3uin6vATFkMSFeZHDCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfozN1SP; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfozN1SP"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3e12fd71984so4529912fac.2
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 22:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765349715; x=1765954515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERKO2E8dUe7sGUN/SVpzd0l1EEuP0Z6jIAQAqtMw/mk=;
        b=HfozN1SPk70rxkH5lqGEPUlwn7/R6voDzXAnx5YlBIrDy83qn8xc7IvvJsAaWvYNfh
         0Atkhw+40QczKnYsfsAgrJVKTpcSCXpiFqDCE5TRP6chz/Vh5+uS2zn5kzXOtvD3JsW3
         2BKX/qFreAmL9U4AyunPkOWqER3hZ1qigXBWrEj+cz4BUH8pWEYKLXu+yQDWV/VD65B8
         sNljUOcodp3e6Go5pjDw+XaI2+i8GDismdjS7RyZz2cYY1mQvDoCJFiovVYD6FGnVQcm
         VP/Q/zOsUFPjLrOCUhquRRvLurx/MGnNhOvdv3cYP8JrxgMIe//NIWWEdQCKRjsoNs+x
         72BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765349715; x=1765954515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ERKO2E8dUe7sGUN/SVpzd0l1EEuP0Z6jIAQAqtMw/mk=;
        b=FtOlLPD3jsoUt27Cc7cejhlGtZJUvKYUUENCm95vD4xmty4Vlyq+FvgXXNlRUMi0nc
         mdPvIth3aCzPjfdHKCO5PxTOTczNGh+qOc8zF6cEwaym9Gx1iVwvO1R/F+96NC5iND+K
         H8GkdHoMBiHBTu4rT6UJ9zbT/ozX35nTrfJkUs5pQd7bqd1aJewoM93ZZeeRjQwES2MD
         I6VasADE3o6lkvTP771mbBALzwN6fTquYjENUXESgdefrCyc0vzAHLSKkjT1SNGqyTif
         HSrOMtNWDT8YcuNWiAmxHneLMhEfZ1tJoalF4L02kfFA6LX1a7dmQ3ciGskvlLhOvHpC
         PRpA==
X-Forwarded-Encrypted: i=1; AJvYcCWSFO+Dhe0PBNMp0CgeRpYISrTUW3b1hhFqA+/ZDPg5zisOYx5ObM1LnFrBecJWKs+WTms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2fvVvy7Yktne3wOiCnh+CVHV1hPMLdRbsLK2KM9YwY6T9fFka
	arCLW6h4BJ+TlpbrPfn/BQ9a+wAqYvwJHmKdspgvQbhV7sirV7XSPpVc+f11Rqu5sUysttosLaw
	UYmHV0g4rsKsosJt4+y8lYAGtBGjdOjs=
X-Gm-Gg: ASbGncuUG+C8xBqovXdNbvfiAIejFCBCxADGupcNE2Rpyi4wU5Zuj0P02i6s9j3+hHK
	+E94yF/a5YcXKac84upqOhdd/yUFpPaCaWITvy5tKRSrxBfZPs9szDqQkUgS/UO5ShaDxR3l/uz
	1PHx2UfgILh68mcOc2wlLAV6iqdpMWfGFUFi+81LkP/qFhmBb2PdMWYaVcJ0TX9C2BoEnsgmgPO
	99ynho+T838j52Ay7hQfDsUIfq9v/x4NH0JziUwwfep3/LQdAzHDC+W7ovkAauQBPpMa37AG2Gl
	0rT8lrRybzCSDePRDLkGqD0Di6lC
X-Google-Smtp-Source: AGHT+IENxWMLaw9acBzQ882h0J7VpT+UNWiucbM16UlWbATFR6UqCl+ejpy2kc0i9fYe8CTtXROBfAHawwfkM0svMkA=
X-Received: by 2002:a05:6820:a0e:b0:659:9a49:9021 with SMTP id
 006d021491bc7-65b2adab98cmr964696eaf.78.1765349714309; Tue, 09 Dec 2025
 22:55:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
 <xmqqbjkw78jj.fsf@gitster.g> <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
 <xmqq7bvk77lr.fsf@gitster.g> <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
 <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com> <xmqq7bvj5q8m.fsf@gitster.g>
 <CABPp-BEVX85xZ7_1fSfW4-xJod13p2-HvQ-e5ga+m9-Sq7mbdw@mail.gmail.com>
 <aS80z0DxAEBLba-M@pks.im> <CABPp-BFtx7-vLFbVqbHar=UZb1CGX5=ufMA4hrJRkSYuB14_Tw@mail.gmail.com>
 <aTfVfenbwY685fDZ@pks.im>
In-Reply-To: <aTfVfenbwY685fDZ@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 9 Dec 2025 22:55:02 -0800
X-Gm-Features: AQt7F2puic5D4hucwKv1bPB1UltNSndUxb6UFbXFV5cs1uAvF8cg0qezJ4ake2U
Message-ID: <CABPp-BE+Tu=TCjoNOo7aMAauGi6KAJRc_FPswdxgSU6-zPR+ww@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 11:53=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Dec 05, 2025 at 12:49:04AM -0800, Elijah Newren wrote:
> > On Tue, Dec 2, 2025 at 10:50=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > > Consequently I'm leaning more into the direction of doing nothing. It=
's
> > > not really clear to me that this is a bug, and we still can introduce=
 a
> > > flag in the future that opts into the behaviour of rewriting relevant
> > > branches. That behaviour certainly can be useful, but I'd claim that
> > > it would be rather surprising to the user if that was the default.
> >
> > Well, as I stated above, this is basically copying what I view as the
> > fundamental design mistake of git-rebase.  The many other points of
> > feedback I had on this series (e.g. extended headers, reusing replay's
> > walking, etc.) are things I could easily negotiate on; this one
> > bothers me much, much more.  To me, it ruins the command and makes me
> > feel it is unsuitable for inclusion in git; this is, after all, the
> > kind of thing that made me decide to write yet another command to
> > workaround such a flaw.  If the series is merged with this behavior,
> > I'm going to be in the awkward position of feeling I need to actively
> > recommend against its usage unless _and until_ we either
> >
> > (a) check that a commit is only part of one branch before proceeding,
> > (b) always require the user to specify with a flag how to handle
> > commits that happen to be part of multiple branches (even when a
> > commit only happens to be part of one branch, in order to allow us to
> > not bother checking whether it's part of more),
> > or
> > (c) rewrite all branches that contain the given commit by default
> > (with an option to only rewrite the current one).
> >
> > That said, obviously the choice of whether the series is merged isn't
> > up to me.  And maybe I'm in the minority, and others don't care about
> > this issue at all.  But it's how I feel about it.
>
> I guess it's a matter of workflows and tastes, and there's never going
> to be the one correct way of doing things. I don't think (b) is a good
> option as it makes things more complex even for the simplest cases. But
> I wouldn't be opposed to a combination of (a) and (b) if we can
> implement (a) efficiently.
>
> Do we already have logic like this in git-replay(1)?

No, git-replay was written from the beginning with the idea in mind of
handling multiple branches (e.g. letting Junio edit a single commit in
someone's topic and updating all the subsequent commits and merges
without having to individually fuss with them all, or similarly for
the Git For Windows or Microsoft Git forks, or at a smaller level if I
have multiple topics that share a few commits and I want to update one
of those), so the idea was always (c) by default, with options for
alternate behavior, which is kind of the opposite angle you are
approaching from.  Anyway, because of that view, nothing like (a) was
ever implemented.
