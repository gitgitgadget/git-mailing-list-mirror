Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3EB25D527
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965986; cv=none; b=aN3t4MvAl6iNV5mgsIwyFiUnmI/uagPFr3stEbilzeNbCKJwQj5bnZY4IA4lVa+9UHrFU3n2tlc7xo912pP5UBSd1HFiey4SXtgu+IEZrQILVPrYJ0YuRx2QmvoDo91V73fnz+7H03l4eMTZ0caXRPJIgy76JwkwbgZVCRbSWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965986; c=relaxed/simple;
	bh=cYaKUg8O2kFdRjnZ1yLUhPOJLbuuorpWVwFsvvcO4yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Firf2FZmoaCQWtJ1xY0PBN9UkQoIx1cpfu4csvwn8fUHtgHUlOhpcuv7XMpU/J1dv04Yxsbh6/cQKVvbDB0Osp+bXpjOOaHeX5mFu1xTXoHH++uqTW/ykAPVJLzzUn5SdbAT1jlT/01cmuAqGYyB8PYwwcOsdO8WhEazGv1LI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmOrJ5og; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmOrJ5og"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297ef378069so9932595ad.3
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762965984; x=1763570784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=domCEMMkSd9+exwqizvcwBe+PhzQ7cA3L3oNbOR7HZc=;
        b=nmOrJ5ogzydttXl2kF5OchPA5Jj1Gtt97BGVpL/mOKpseAUDK1K+ZPbrQLNyWp8zSl
         oTmLmVEcYEX/2IHZY4TOPMZickWmfc/YhPuZyxR+v2jfd3Swc4UHneVIaSiVP7dCQoqh
         9hZjH/wAeituBaKObPeCiCXTqgEWuDmNUKzaiJcovCdKZV0xSzistGU8aYeEIL7ZGNJn
         pY2cb0SYfjEOH1faDq961za1aKS9EGJvlcMs+tTVGw1xwhdfVE1Z+VU3wsuY/rYN6n2n
         1ob4Io7QqRjLmozbDvY4G5tQ1tePDP9fDatOAeZronrrcuFQtM9OX2fnfjsr5kC8+spv
         IeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965984; x=1763570784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=domCEMMkSd9+exwqizvcwBe+PhzQ7cA3L3oNbOR7HZc=;
        b=g3yIrLGiohtomBheP5EA52VXUQsbuKXnNgalra2hu0si3awm1rQcGSThBkLgw/nq57
         wfrtDh0Z6ZXdUtoRJrFxVyxT5MyLVIV799ic28Q53pvkDBFFUM1niNO2eJNK+v9oAYtt
         tj6FpjzOkms+UNAw65huxMDZ7BL4NSpGo14c1xeYT6sP9rbaV8FliYGmHoTuHuEDqpVW
         4JGsE/iIgObKakGZa7PvgUoZU8ghF19ofVOgECEwM+/nbnek1c0JTJ33lhOV3ld3wXXq
         75PsZsTeKmhwTXkq/c/W9wYhaxtXdwbw/mSahWq9GVEQCi1MToHpv2XcfpLVCnYEHRUF
         XxHg==
X-Forwarded-Encrypted: i=1; AJvYcCU5kwwZyvcCkRqPFIUvkK40zx2r4r94EE5QSX3ik1biYooxIKidYbJNc2MtHc0YD15Y6Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQJfuv2gt5J+FZz7/Sd+W6b33m0pWpTsEjhOOrtqR1UapzDvEa
	xlvqIl18bNCQGJOUfY9rWNd/Pn8oi5JbIIu2H7MuSnUnruLY7pqE2Yx3SnGH8/lXTrZ9gL9M4qy
	sRlpAvDAW5/tEJnq7TujqSkuxav+vvIc6EqaWPhCHmXBX
X-Gm-Gg: ASbGncuAllhKZL9nROy4f0/DlRza+fwDU7iFDwIfbQjcu2wkl7iwWBzkdsTn9bEKQCg
	iMRjh3HPvEe4nCtcelnDxQXhas/Unr7T9dQvtVOLHFVivdDMZoJGpTFsQqGR7rtmdrmEflowaBv
	fUC/sHzf5EfZbSriKhuQXF1gka+BkHtjDU5eBDoKzkeivKTFERY8FTLvzdOfrJ+QpLbiW8yhCYC
	fWt0/9+MjaqI4oRWKEDWmtGlX3v7BiDAulyhlpoZznmqNMtOhR/P/U/M0LthISh32Ttwiz9aFTl
	dD9ahVTbr83i
X-Google-Smtp-Source: AGHT+IGuGcYT2edpxUjaZ6PPkKHAXJ8fDstc8CM4a9Y/0YIdehAsl+bJW+FuvbKkMxMnhLYbiSb/RNyYQbeE8e7tCZo=
X-Received: by 2002:a17:902:ef43:b0:295:223b:cdee with SMTP id
 d9443c01a7336-2984ed9245cmr46825905ad.14.1762965984044; Wed, 12 Nov 2025
 08:46:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com> <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
 <20251110201136.GB127132@coredump.intra.peff.net> <CAOLTT8RweGOmxNK=vKDv8w-8AJM7QUfLBw4WOKeY1EpSVeB6iQ@mail.gmail.com>
 <20251111191508.GA1907007@coredump.intra.peff.net> <xmqqh5v0wcif.fsf@gitster.g>
 <20251111213339.GA4053071@coredump.intra.peff.net>
In-Reply-To: <20251111213339.GA4053071@coredump.intra.peff.net>
From: ZheNing Hu <adlternative@gmail.com>
Date: Thu, 13 Nov 2025 00:46:10 +0800
X-Gm-Features: AWmQ_bkAVA5zT44cXLyzMdeICgl7ToBdTqowbjfYMLECjz7jgNp_oLUHA8TQpaQ
Message-ID: <CAOLTT8SZXooypwP27BFXaQdETTPFqOVxGtNtO6j=p7WgaBeLgQ@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	phillip.wood@dunelm.org.uk, 
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> =E4=BA=8E2025=E5=B9=B411=E6=9C=8812=E6=97=A5=E5=
=91=A8=E4=B8=89 05:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Nov 11, 2025 at 12:16:40PM -0800, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > >> Sometimes it's because I forgot to configure the repository-level gi=
t user
> > >> config and started development first. Only when I tried to correct t=
he
> > >> committer did I feel the pain.
> > >
> > > OK, this workflow does make sense to me. Fixing up an earlier mistake=
 is
> > > inherently a one-off thing, and a command-line option is more ergonom=
ic
> > > than using the environment variables.
> >
> > Not very much, at least to me.  Fixing up an earlier mistake may be
> > one-shot thing but it is to correct multiple commits in one go,
> > which would be error prone if you do so with "git commit --option".
> > Either "fast-export | fast-import" pipe, or "git rebase" (which this
> > patch does not give --committer option, but it already knows how to
> > honor existing environment variables) would be used for that, no?
>
> I usually lean on "commit --amend" for this, coupled with rebase if
> there are multiple commits. So I've used:
>
>   git rebase -x "git commit --no-edit --amend --author=3D..."
>
> or similar when fixing up incorrect application of somebody else's
> patches (e.g., if I ended up using "git apply" and tweaking the commit
> message myself, rather than using "git am").
>
> > > Two small thoughts:
> > >
> > >   - I suspect what you'd usually want there is for the committer and =
the
> > >     author to match. We have --committer-date-is-author-date for reba=
se,
> > >     and conceptually I think something like --committer-is-author wou=
ld
> > >     do what you want here. But obviously it's less flexible, and I do=
n't
> > >     know if it's that much easier to use.
> >
> > I am not sure how the user experience of this would look like.
>
> I just mean being able to do:
>
>   git commit --amend --author=3D'Foo Bar <foo@example.com>' --committer-i=
s-author
>
> instead of:
>
>   git commit --amend --author=3D'Foo Bar <foo@example.com>' --committer=
=3D'Foo Bar <foo@example.com>'
>

If I wanted an elegant parameter myself, it would definitely be
`git commit --amend --user=3D'Foo Bar <foo@example.com>'`, instead of `-A -=
B-is-A`

> -Peff
