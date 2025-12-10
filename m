Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAE1326920
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765385373; cv=none; b=R+KFbrppwuwmpJbLSyNLXzXaRWDXXH3hVN9WWSuF9HNTGlFMhaArDNEZoHScB6blkSw33nXYzCUweyYF4JX2aY+LMuD3NAgtwEb+n1n9OQVit1EJgN1SGAgELsO6kl5o7eK+qwupVFyeL1JNlhpy9Hvfs7vX+B7Em5mOjIwM62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765385373; c=relaxed/simple;
	bh=IqrItFiVJSv3FgFB26+VPIa5Dz6smgBoTysd5B7b4FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6xlLpzunnfV04cCxA3imqmFrWfeSLTME+I+DsjQSkJUV/+N/YRwKOV4ZCEP0A9GZ3QwTu6cotgK0sfvC1DbxeYOUTmqol/pSfvPNQzeVs/3H2buLBa80ECBS0bCFl9Gh65/Yv4kI9ug5UKHpBw0RnJcRD3fM9YKfcFqJgnCRQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UA+IGiem; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA+IGiem"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so59373a91.0
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 08:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765385370; x=1765990170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4cMt2vcx7qCj/fzO6M61pTxpEePayDXFv9LkprtEuQ=;
        b=UA+IGiemxT2WLS+XTq7kVKPS8R7O+XYP62jo6X/Z+sDR5Ycx+JPy7J0tAz3QVOPFhD
         x4YfwCaidPbWrSOG0Vdx1f5Y7KEZYQ6HSQkwJwN7zhL/uRZEgx82MeLB07IDXeaVjx2B
         819TNTk3D5glPdCBzNVMb2O6Lx52dMj/gVmv8tJ9Fuvd1IeenApbRCfGtUGUt1TltZvz
         R9WYSPeytrNa+c0PSoPXpwBe58CV0NCaIzbLqijGrRLnaGjy2JV7081JMzM3tlfoM2Ti
         q0muR8Cjl7HnpZjEdVpWxYRJ1l1rmkZX2l82NjaXaxg9XYl4AMtIj1/wkq1jF2Il1sDP
         3scA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765385370; x=1765990170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L4cMt2vcx7qCj/fzO6M61pTxpEePayDXFv9LkprtEuQ=;
        b=r8OzCRsh3BdtTA8guCgYhIm3UyMEwoieVcvVHENwmjSvaf6NpJHYmGmgmzwOcCMVcq
         DH8YhhKmxpyNosmT4SYxu682a9I7HYF0bxUYtLHqlz5bUre2v/oK5GmyDw2p6DPm+A6K
         WG8Iwd7RDMrvR9jZhSWnoRDtpntJY6LQ9ZfhYDoe12ZzGxyfQv45W0k4QOYmWW9O2yHF
         tcy3TgAq1SeM2Ih18s1ImfiXYrbudAv/Yd5rbgTO7NTKt2dfHP9Ge+rGBfEuIjnCPpv8
         6LBOOW8mgj1asgSvLaw7YCHVOewtgoWMFPrCSPZfxleIkNXMFlsKV9jJ70VGM2Vt99Jn
         LN6A==
X-Forwarded-Encrypted: i=1; AJvYcCWTG6SWS9U5EMfPuIm11IR1HTDVHJaTry06LTNmZYMwtElyHbNlWsPa3rD/vEdzSOvNylU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZvJ5KiijpZHSFTvimTtkP9pN63O1AAGyWZIrwEzfBS3BhCvW
	x0/ri8X6dnlFaXpC3QqgtrvvIQKrXvR88MjGKNutsxhHJ12neeye2c1sUmpwl8ZMFUveKZEB/Vm
	ztfuFKA3qLawrWQBXm3DKQWkOBaC36ZM=
X-Gm-Gg: AY/fxX7a0qFDu47Ku7lmCqtLdtOdQ3i72+5hjd4wm0tNlkijVPEqizIx1qwMeD8rOwe
	pwHwuhMfBiTyZ/DfjwTPkn5ABNf+uZl38MhoNbO3EJ7R2hfmI4hH0hGsqwe2CwWtZvuT5ceovLg
	KnCUufyZKfNKpwHxYNUDzg/hTqFJjqpzAj6FKYYBw/SekXXGPNMfTlIT275C6b1IIYdqilFSl7U
	t1PuuzOjKpbl0FnYun+Fm3RAtapyDnLk9TfEYy3/xDrpZI9BybRHbnRBZ4cnf5qj0tBcOuKgW4/
	ug0HN1LAO7aKDTLfJu6nMN0yR9Ku6ObIj4Xn
X-Google-Smtp-Source: AGHT+IEer0kmx0aKVgMYp91SyhBMo7HJpRkM4hKsjRGhYWZG+0JwsOYWBQM4Semag42cIZZB5cE/VZ6Icjw2UxGAyMk=
X-Received: by 2002:a17:90b:2808:b0:343:6611:f21 with SMTP id
 98e67ed59e1d1-34a7285c257mr2801980a91.1.1765385369798; Wed, 10 Dec 2025
 08:49:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im> <aMsWL2cSoytbmRjA@szeder.dev> <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com> <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
In-Reply-To: <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
From: Martin von Zweigbergk <martinvonz@gmail.com>
Date: Wed, 10 Dec 2025 08:49:18 -0800
X-Gm-Features: AQt7F2o3wjafVK4WfIxzck6UDxUxwkNQYCD4AoojzI6HJUxgJ4hESRlXy6UX4_E
Message-ID: <CANiSa6hwaQ2zLsvw=uiJNgfVYAVp2RyQtgVeTevZ5NO5p2Xmgg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
To: Matthias Beyer <mail@beyermatthias.de>
Cc: phillip.wood@dunelm.org.uk, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 2:38=E2=80=AFAM Matthias Beyer <mail@beyermatthias.=
de> wrote:
>
> Am Wed, Dec 10, 2025 at 09:58:13AM +0000, schrieb Phillip Wood:
> > Hi Matthias
> >
> > On 03/12/2025 18:18, Matthias Beyer wrote:
> > > Am Wed, Sep 17, 2025 at 10:12:31PM +0200, schrieb SZEDER G=C3=A1bor:
> > >
> > > > Let's suppose I have this piece of history, I'm on 'branch2', and I
> > > > drop commit B.  Which commits will be rewritten and which branches
> > > > will be repointed?
> > > >
> > > >     A---B---C---D   branch1
> > > >              \   \
> > > >               \   E---F   branch2
> > > >                \       \
> > > >                 \       G---H---I   branch3
> > > >                  \
> > > >                   J---K---L   branch4
> > > >
> > >
> > > Just speaking as a user here, but my expectation in this scenario wou=
ld
> > > be that rewriting B would be denied by default here, as branch{1..4}
> > > would be rewritten although I am at branch2.
> > >
> > > In the scenario at hand, I would expect that I can only rewrite G, H,=
 I
> > > while on branch 3 and J, K, L while on branch4 (without passing some
> > > extra flags for "yes, please also rewrite the other branches").
> >
> > Is that because you have branches that you don't want to rewrite becaus=
e
> > they've been merged upstream or is there another reason?

I think that's a common reason even if it's not Matthias's reason.
Perhaps one way of doing it would be to have a configurable set of ref
patterns that are considered immutable. That's similar to what jj
does, though we use a more general language for selecting revisions
for it (https://docs.jj-vcs.dev/latest/config/#set-of-immutable-commits).
I think that has been well received. As you might expect, the set of
immutable revisions are respected by all commands.
