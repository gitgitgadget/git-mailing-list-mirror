Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95661BC3C
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961407; cv=none; b=TmRqCqJOdCgk0H1tF9X9rbjBsQmiYRs8WV/JKGR2JjRGDItrAffS8MgU002qs8C/ne+/E9tX2Pf97GU6jPYYoP34CJTmLmRx3up/W50+94m8Q43g/crXbr4G+D/I3IM7sAjDZHvwSyi41/Y5al6lu4Md7sSEmegkca8hle1fJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961407; c=relaxed/simple;
	bh=rKJQN3tu0iRAkPu6ia6K8LKP8+dETv3UPAlmKNvlfxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OL00dXKdpFu7N4DBTqf+Is+6PrRcekjWOJF/Syvy/+0b8QIgAAZE9qqmEb7cUtolbIpo7ptTulr1LNWash+17yjZa8JCOFdBxJtdgqYBOc4CCW7kWEylU2y/OtD2drFV+pZFoTuu4xy1ocpSegbGf6AQx1sU4dkLVj2TfTZTQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C07K9xpQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C07K9xpQ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so3195906a12.0
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741961404; x=1742566204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tl4H87Mu7TXzp2lKLasM0UOkrZyoOAKcXbCXU5JbXsc=;
        b=C07K9xpQUBDPbc0T3F+iw87Yu4yRT0sNGAGC1jAO8o5sVFapHBpZLG219zwPmBfBHl
         PqsrVwuuys+aVXKdImTrEq7fLppclcElzDeYazXmuMZt4P9E2KevxoZwpyZ2ug/QEKYk
         H7pQ1o+h/GV4+t+4eqmLPejb+Va8njPFJl8LUtCYnFAf17YPCQGkysNmCtZs680h6Sm8
         RHn5csF+Ui7V+VLlcgw45wBDXbobP1ik7e2gl9um4c0297QY4UuyTf8pnxNS+Ie1TnE8
         xOayZKM75c+KpKKyiQgrOG0TL5hSp/aWztmG8bT5rbiC1AgDGVGpfveiUjgL+tzgUmWz
         B2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961404; x=1742566204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tl4H87Mu7TXzp2lKLasM0UOkrZyoOAKcXbCXU5JbXsc=;
        b=cpTrR/xZ04d7WADB1g846MywCVlg5z97J39hPs1DVO3+HTCiQgso98FlVHNwAwiQI/
         OLysZwz0OmQ+ZUssqosIdijl2M/TDzERfQuaJbF0wZatdr4tF0mt/8tLtkSF1i/+d4sg
         0HNFtTwarrwWEGO49aIynFBEJrI2Hhi+9HvPvfSHPEjfqAvfUP+fzgjngzKAGz8BCK28
         q0fx0V0eWT8FiIjnLKGPomDXofiiXVgIy75Ue3/akj8eG7XzmMaAbGAbfSE/UB4wkA1u
         8GlwU0MYAdZfIcQ2wDMG9iMm7m4kVdnGlGZuRl8tebD5G3JzjlysCR9vbtt0NZB07RR4
         2uGg==
X-Gm-Message-State: AOJu0Yxq/aBcexRqeuPzOJ3KMuO3STsuyFyw4A+KXA9ZKzrGrt0vVjAW
	p5jSyAMubnzvAmPXIEo1HJwF3CV5uwgws2IiqO4fiYGE8DmMlMghCbWVeNL1V0DSH/WyJCtR1ue
	eFDwSfVSMTGOYz4v76cTl+m0dXQ4=
X-Gm-Gg: ASbGnctD7SmWpSFaT+AdjrMCA2uN7jHT29JajMTyNAP2S2xwNHU2nmKOlFC2z2xhE/Y
	02a+BZeUafdJ68naYkQwgGn/vd5NtjQ9/P2QDVIEPNHLK+7x6EHHtU/2w/1o+iCIRwTghpJNWcK
	HO7QOaoAueH+e3soZUgCHE0abLd9OC
X-Google-Smtp-Source: AGHT+IF9WtsBGnOuNU2TQfehAJ0CAv2l5/cjcPI/au8F2RDHELrjCKI2pFzrtGbzdAqb4GMQB/ZjiLHNUeuoFEHA0N0=
X-Received: by 2002:a05:6402:2551:b0:5dc:c9ce:b01b with SMTP id
 4fb4d7f45d1cf-5e89f150f7cmr2670184a12.8.1741961403513; Fri, 14 Mar 2025
 07:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311152413.1059343-1-christian.couder@gmail.com>
 <20250312114628.2744747-1-christian.couder@gmail.com> <xmqqecz2yyg2.fsf@gitster.g>
 <CAP8UFD0QqUG5Gu-XxKi58sEA7VfSJk4gy9hb_93dCw+2QMABYA@mail.gmail.com> <xmqqfrjgq3ye.fsf@gitster.g>
In-Reply-To: <xmqqfrjgq3ye.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 14 Mar 2025 15:09:50 +0100
X-Gm-Features: AQ5f1JqI7OhT04Y1C4PPokzjgxR1ZhlE9q1dXaifbaz3xZpktGR2D0Ymu4DYN4k
Message-ID: <CAP8UFD3HtG0QSZ+89K79ZKxfFkdDUjfbTbF8zTvquwRWU8c9Vw@mail.gmail.com>
Subject: Re: [PATCH v3] promisor-remote: fix segfault when remote URL is missing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Karthik Nayak <karthik.188@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	"Randall S . Becker" <rsbecker@nexbridge.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 5:40=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > It could happen that the server, the client and the common promisor
> > remote are all on the same filesystem. Then it would make sense for
> > both the server and the client to rely on just the remote name,
> > without any URL configured, to access the promisor remote. So if we
> > want things to work in this case, then I think the server should
> > advertise the remote name in the "url=3D" field.
>
> Meaning the server and all the clients share the short-and-sweet
> string that is suitable as a remote nickname (i.e. something you the
> client driver would type to "git fetch" command) as a pathname that
> is relative to the current working directory, and because the server
> and these clients must refer to the same repository using this
> mechanism, this in turn means that the server and all the clients
> share the same current working directory?

Maybe they don't share the same directory but there is a symlink to or
a mount of the remote directory. I agree it's a rare case, but the
case with no URL is a rare case too.

Also I just tested the following:

$ mkdir test_git
$ cd test_git
$ git init
$ git config remote."../git".fetch '+refs/heads/*:refs/remotes/git/*'
$ git fetch "../git"

which works if ../git is a valid path to a repo.

So even if `git remote add "../stuff" url` is rejected, one can
actually create working remotes with names that point to any directory
on the current filesystem.

> It may be possible, but would that make _any_ practical sense?  I
> doubt it.  I would understand perfectly well that the local single
> machine situation as a good justification to use file:// URL in such
> a setting, but not for the r->name fallback.
>
> >> What other uses do the name/url vectors prepared by
> >> promisor_info_vecs() have?  Is it that we use them only to advertise
> >> with this code, and then match with what they advertise?
> >
> > Yes, I think so.
> > ...
> > Other call sites don't use promisor_info_vecs(). It was introduced by
> > the lop patch series which doesn't change how other code gets the
> > remote names and URLs.
>
> Then it should be simpler to remove r->name entries at the source in
> that function, than having to filter it from the strvec whenever the
> strvec elements are used.

I am fine with this solution. The case with no URL isn't likely to
happen in the first place, and if needed, it can be easily worked
around by just specifying an URL that can be the same as the remote
name. So in the next version, only remotes with an URL configured are
pushed into the 'names' and 'urls' strvecs.

> >> ... would it be so different to pass an empty string as to pass a
> >> misspelt URL received from the other end?  Wouldn't the end result
> >> the same (i.e., we thought we had a URL usable as a promisor remote,
> >> but it turns out that we cannot reach it)?
> >
> > Perhaps but I think it would be weird if URLs are matching when they
> > are empty on both sides. I think it makes more sense and is more
> > helpful to warn with a clear error message and just reject the remote
> > if any of the URL is empty.
>
> Smells like over-engineering for nonexisting case to me.

I am fine with not worrying about this. Then I think it's just simpler
to ignore any remote with an empty URL and not even push them into the
strvecs in the first place, like we are now also doing for remote with
no URL. So I have implemented this in the next version. It just
simplifies a lot of things.

It also seems that when an URL is empty, Git uses the remote name to
fetch, like when the URL is missing. So it makes sense to process
missing and empty URLs in the same way.

> >> The 'i' was obtained by calling remote_nick_find(), which uses
> >> strcasecmp() to find named remote (which I doubt it is a sensible
> >> design by the way).  This code should be consistent with whatever
> >> comparison used there.
> >
> > I think comparing remote names case insensitively is fair. It's likely
> > to just make things a bit easier for users.
>
> Meaning it makes it impossible to have two remotes with nicknames
> that are different in case?
>
> Because the "[remote "nick"] fetch =3D ..." configuration variables
> have the nickname in the second part, the nicknames are case
> insensitive, unlike the first and the third component (i.e.

I think you mean "the nicknames are case sensitive" here.

> "remote.origin.fetch" and "Remote.origin.FETCH" are the same thing,
> but "remote.Origin.fetch" and "remote.origin.fetch" are different).

Ok, then I have fixed this in a separate patch in the next version.
