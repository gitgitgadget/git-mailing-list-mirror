Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBEA302CBA
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399639; cv=none; b=eDxEIr/LXpJK7GcPyc8IjrVPu+Jseg/SuRCfroyLZgKr/WlxxZHVhrpDrIYAlbBOcmxi6SJzWIN1TqoRtvWCRLFUCsBMBZE8PosdhpQFRBvrOgCEdTySf4F8ZdQMVbDZcnfcwuwkyP/TRok857NWcoTgULNtGuwmEHAmQ3D3BI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399639; c=relaxed/simple;
	bh=VEvwvqdtgRtb2rInx+6gKyP+xaKLl7nkqsZ5dKr266g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfdVzJYyGSyEldY6WOZup9vfI3KHmtTI30w/VQ854LYWefImaKWguZhAwBNYPcwrBFMYLw9zzZVBnF1O2Pqv0vMpDOjVym+9y2bYQPjDcLY55vn+GedFBpvw9iYUcTewT98zGdRj1zISya6C2QOncKrSDWYp7tSkr2cx616TfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxyZjfx6; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxyZjfx6"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3fc5f08699aso20047535ab.2
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 23:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757399637; x=1758004437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFNrilMKB119ABJVvXX5kwWl/0p3KCrNsrp0zYx51Q8=;
        b=DxyZjfx60kc5yT6HopRiGrXuq8ou8Z9YjrODND7si+1ajZvsMa8LumDIYr8lcyHxCG
         zGmV3fv3KvL5LtpJYZNtVw3P7lLy6Q0wSk8/YcPTxtltIi55lTyUJco5pAqsVgrDSpZ/
         1puGa8BHorPU4rYkaI2qvS/sdwyliq2RUZo2t6LqG8jAADGo7IKA6E1tP75ICQe7WmX4
         MUvYOpw0KPh1SOKfcojwAJlR56jgyzmC0IsGNSf4iZeJVODzpLtqfhkLUNLOoBliVZ5V
         Cjk3y8cBnhvdzMvf+qHt68ailcZJk6GUgp/Ft8pK5vecxmI1nDQ5O3LeRTsfBJSLqfGF
         foaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757399637; x=1758004437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFNrilMKB119ABJVvXX5kwWl/0p3KCrNsrp0zYx51Q8=;
        b=NMSKqaN5j8ebhZT+0degaUhoXwrsL9N+efZPIAzXz5lqfuDBkzY6mlc0yf8RVOopUQ
         IMgh07rfPHPjoR4zp993PJyAyZleFgLv4IpFAn3bN7mqerT7mquXI/SNaBhYRNC6lHVf
         jkVJmwZNPy1sGYUNcViUBeLSzVxOCphubDTOM03o2MOCgkTqKxpeAH/G5dpSr8vWhr6l
         K74d3qsCbInRk557rMQOXxNxT0z37gxpb64ApZTW2gk/dnfR+nWg4IDH85CvO/vgkhnT
         DC3+VTcL06pclVf2VnAlnuwcI4iktMTTsqZ97coWpgNZ5thHG7LAsPq+FDlHDUnsZhll
         zpRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9lA2bPN68MESxUujsc6UVh6+RxXjKEYdrO9vdz0c2dvD69MPERnCNn/3nWG0r7fUCcs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ8KUNZKnEgE+0om4LFIsh0jMk0j7q35m6Q2ua2q3pYvu7PYBX
	xba0J4Dm5zOoS35HiZFfwIh5f0EygKcJBZfgBBEKsbnNz2jy80fGEo+OiVCPdHLsKPLI5Hv3CbX
	mMDbktbBQrRi3GvP1HSftfSdvQ19qncs=
X-Gm-Gg: ASbGnct1AhTJlAUVAef+cyTt3p+otg0lQRH/NqE5yYUbwaA+u+m7234A4ojYdhEnIvg
	Ae912mci6pjp8zJvkxeqMg3qGXavukFHjBaa+07tPG3fBgG6QjKjovL1lEGxdk5vzVfaIr5NCED
	BS1+gFlujcgqoQ2vMtbF7aswPnnaazPgbdVjNY621r6ERR3W1nM+x/rAGcDhRN+jT8PqB9rfPTT
	VfPQ8a7G0Nu0Bm7BohsSWUFk5Cm8svVkyM2vjns0HX5G6MpHA==
X-Google-Smtp-Source: AGHT+IEzEgK/iH0T7iSK1Z1RrbJe1CmfEXivrRuMlfqhm7hf27gIC9OETHQ/MqA0q2/JayK5umnpd5L3b7BuelyefiI=
X-Received: by 2002:a92:cdab:0:b0:3f1:a5b9:4a32 with SMTP id
 e9e14a558f8ab-3fd8cdbdd83mr143272645ab.1.1757399636704; Mon, 08 Sep 2025
 23:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <8a5394eb-bad4-42e0-82a8-fa73123e205a@gmail.com> <aLrzqR2Z9jz5CuJu@pks.im>
 <CABPp-BGpdEP9+CTApknmGNO=b=66bFKVzWL2s3gmgCMtTBTjPA@mail.gmail.com> <aL57ONmEKTmqFhIZ@pks.im>
In-Reply-To: <aL57ONmEKTmqFhIZ@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 8 Sep 2025 23:33:45 -0700
X-Gm-Features: Ac12FXzuV1xFDOecEhzPLQPYpCEJDYhZ2W1WjUTGTTA1olRKGg8kjWcyJ9LGjbI
Message-ID: <CABPp-BEW8TYaffOED34bTy98X=CDZeA+r=X+kMR-GRwuqRDfjg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/7] Introduce Rust and announce that it will
 become mandatorty
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
	Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Ezekiel Newren <ezekielnewren@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 11:44=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Sat, Sep 06, 2025 at 09:31:02PM -0700, Elijah Newren wrote:
> > On Fri, Sep 5, 2025 at 7:29=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
[...]
> > > I have a plan layed out in the BreakingChanges document that mentions
> > > how I'm proposing to do the transition:
> > >
> > >   1. We introduce it with auto-detection for Meson and default-disabl=
ed
> > >      for our Makefile in Git 2.52.
> > >
> > >   2. We enable Rust by default in case WITH_BREAKING_CHANGES is enabl=
ed
> > >      in Git 2.53.
> > >
> > >   3. We always enable Rust by default in Git 2.54.
> >
> > I don't see how steps 1 & 2 help at all.  We now know we want to make
> > Rust mandatory eventually, and should provide distributors and
> > platforms as much notice as possible so they are aware.  But what
> > you've proposed is another libgit-rs or libgit-sys -- an optional
> > component that no one will know about unless they go looking for it.
> > I don't see how those two steps provide any incremental help to
> > anybody over what libgit-rs and libgit-sys have done.  From my point
> > of view, Rust should be enabled by default in Git 2.52, with a simple
> > knob provided to let distributors/platforms/users turn it off and
> > build without it.
>
> It helps because it allows us to slowly build out the infrastructure. We
> don't yet need answers to every question that we currently have if we
> initially have the Rust infra default-disabled.

One of the things I find very unfortunate about this series, is we
have a new contributor who was trying to send in patches, and instead
of providing feedback, suggesting alternatives, or asking if he'd do
it differently (which he actually said he was willing to do [1]), it
sends out a competing patch series to replace his instead.  (And this
happened shortly after someone else interjected patches because of
interest in the first area he touched, forcing him to pivot once
already[2].)  Further, despite him having solved how to get it running
on all platforms we run in CI with some big help from the
git-for-windows folks, this series discards all of that.  It lends to
a feeling that he might be working on important and interesting
topics, but his changes aren't welcome and it's not worth providing
feedback for him to modify them to become so.  That's almost certainly
not your intent, but that is the effect that sending a competing patch
series likely is going to have.

[1] https://lore.kernel.org/git/CAH=3DZcbBLAKaE733_2_2qbFTYCfwGq37RfF-Z3vaK=
L1ZR49msAA@mail.gmail.com/
[2] https://lore.kernel.org/git/xmqqzfbvfxs6.fsf@gitster.g/

> I very much expect that there'll be some issues with our initial first
> steps. So I'd rather want to avoid to expose developers or distros to
> these issues directly, because that might train them to immediately
> disable Rust right from the start.

I don't understand why that matters.  The whole point you gave to
motivate this series was to make distributors aware that mandatory
Rust is coming.  If they disable it early on, that requires them to
have been made aware, so mission achieved.  Making it optional and
off-by-default means they get no notice until multiple releases down
the road until you do turn it on, shortening the window they have to
be alerted and prepared.  To me, this feels like you're snatching
defeat from the jaws of victory.
