Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287D2E7BDA
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231396; cv=none; b=O2dQfs3ynabCoEpx2z3e8fl1BjCdHswGFXXNDBI0eW690Q0nwG6qsQDjwRkN/9lpHhZ2CzRhG1GBhtualz59uW6HXiMb5kOUArdEGD4i4a8IfzkEpMQRu4eYuC7c/qcUpof6exC3vkfOLtIN7ADIWCY8T+dmmfRCqDSrAIPpd+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231396; c=relaxed/simple;
	bh=QlTAN5KAG1RfS3Tk4MDsvueuFizKzZEp5EPF6tSjlQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a80qd3Z/+gZVZuBIkmI39I589pjL1A+yGoOLPH9/We1HRg9/L2wmJzXfISIIqzBHvnVC4Ou8NTRso/M5gUbsQAj7Skv25/dZyGZoAPrkcPyfXEhRQ7UGkBRxzT+iJU6bMTN1AFS4rkoMIGCI4RrskRmx2mI0FBAqOZCdo+oWHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HT71BPM7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HT71BPM7"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f3533fd05so4139084e87.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756231392; x=1756836192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVyxYGJASu1HLM7StefXeSFUyDYAy3LqG74Z4LW/3zY=;
        b=HT71BPM71oFAQip9qzxY3w7P5ULGpgOqNYP+wZV6BZ17bph0s+pEEvwV2UvMNGgcmm
         PQygwFudN/syJWiN/plqvP/B4TFNuRk2kLVIsFTWA3Pl+grD+2qXiKA3+njtmyVHkZlG
         6gy9Rg2tshYvcby6WnJBG+Sa5k5C8cohlVmbvd17KlVdMllS4lzMwaSR6597h0kyg5/p
         xOL5wiYDFvpHXFXOKUyNFCAVFWteWHQdKG6oLau0iz9QqSwdWPyfGUt70JeSGLVwb7oW
         JffVzCvgG0p7AIqzEIS/Gd6uqBMp6QVEQb0vnDTLWovXOfUaZdgrXtg4Wxd78vMhM0wU
         3FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756231392; x=1756836192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVyxYGJASu1HLM7StefXeSFUyDYAy3LqG74Z4LW/3zY=;
        b=L0pz4YfiDpEeaPhNBAWjObMxb6x5KQ3Zvg4F8CrK8YzpPF6SI0DMAh73jB+J5ejdPq
         6NHy4+OmUg8ck3QRYpGocfnd332mlLcjqhpwxLanYrZumswU3Uwdflq7OPKHruUre+8o
         5afvUY1a9PwRQwaQTo5K31rI36kMSVYbXFpBlgZNh/kn+ktpunqOFcrkMbiEtfmBdeYY
         j2xGJ7xunB4K8eHDzO+jhYecKy0Pat4gmi4Wq65qIF8LgQqzN036ChdTcPHh/kuL68MD
         lBwEPQLlPl1v1fF03HgroR22xqmyoL5qVDr0leOWRfveTysBxTinoDuSBj/lloRB7VqH
         HD9w==
X-Forwarded-Encrypted: i=1; AJvYcCWQCW+O9cF5Gv7ecKycoeYHNrX8Vbhm6s+klGYFvamuywx3N+crjxoEvjU1lEd3Hbp2RcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy69NfeD1+QYjLdLX/Ag/VyBmdBNRpRCNX+6UjZyFo1WhpEQPZd
	+4GWJWUmQluTmApG6cbc4NLAnJbwSapLSzlEEHs5VQ2BdU2yhGswA31r02p2IONMCVsBUTv+UyJ
	A4EWxew++xyOrRRbjzVCA5k2ugdB5VVpIlRmCuoqr
X-Gm-Gg: ASbGncthDX8L32Gxfj9F9joiuAzkV7UYakOJ98c3HZ0LIRD8M1rKfF2X2vjHatxtzOw
	g5nXwiA5l55uxD3mCR4CkhP/tnCRlcCcXxjQenhjsOTqRlhgUV/u51cFypms9FAfsueeN7vAsGn
	V6eJNf93TwyrswALOoxB3JtKxpy1S+ydYbZWJezIGpU6/+GFXVVfx0YVYcUEkmRTu4olvlHOU1I
	eoqAdvZgJrvYv/f4QSMatEWP2lz2x2qouea2Y+4YBwL
X-Google-Smtp-Source: AGHT+IG7y266iLKQt/Y0abQWBMizO9j5pJND+Mkqn9st2O/ydFoWPK9Elngs0bw4xuDq2agqKNBcW5cjaICzC82qDX4=
X-Received: by 2002:a05:6512:3e18:b0:55f:5195:924f with SMTP id
 2adb3069b0e04-55f5195943bmr519780e87.31.1756231392164; Tue, 26 Aug 2025
 11:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826160437.2539113-1-davvid@gmail.com> <CAO_smVjviMdpZyHFp4zJc62DJYAZxLAc5yw68C3U+c5wbwRziA@mail.gmail.com>
 <014b01dc16b2$4a1dd0d0$de597270$@nexbridge.com>
In-Reply-To: <014b01dc16b2$4a1dd0d0$de597270$@nexbridge.com>
From: Kyle Lippincott <spectral@google.com>
Date: Tue, 26 Aug 2025 11:02:50 -0700
X-Gm-Features: Ac12FXynCnO5j3Oussobi-BueoHtXWBwBfSBjfJPk_twV4Aa3zV7Dl3qSQKN_gE
Message-ID: <CAO_smViKBsfzvqAfu587V_FXp=OPgu3yeO-P8qw19jgwizuUhg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: build libgit-rs and libgit-sys serially
To: rsbecker@nexbridge.com
Cc: David Aguilar <davvid@gmail.com>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Ezekiel Newren <ezekielnewren@gmail.com>, Josh Steadmon <steadmon@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 10:53=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
>
> On August 26, 2025 1:45 PM, Kyle Lippincott wrote:
> >On Tue, Aug 26, 2025 at 9:04=E2=80=AFAM David Aguilar <davvid@gmail.com>=
 wrote:
> >>
> >> The "cargo build" invocations in contrib/ cannot be run in parallel.
> >>
> >> "make -JN" with INCLUDE_LIBGIT_RS enabled causes cargo lock warnings
> >> and can trigger ld errors during the build.
> >>
> >> The build errors are caused by two inner "make" invocations getting
> >> triggered concurrently: once inside of libgit-sys and another inside
> >> of libgit-rs.
> >>
> >> Signed-off-by: David Aguilar <davvid@gmail.com>
> >> ---
> >>  Makefile | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/Makefile b/Makefile
> >> index 29a53520fd..286d3ba3b2 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -3989,7 +3989,7 @@ libgit-sys libgit-rs:
> >>                 cargo build \
> >>         )
> >>  ifdef INCLUDE_LIBGIT_RS
> >> -all:: libgit-sys libgit-rs
> >> +all:: libgit-sys .WAIT libgit-rs
> >
> >I'm not familiar enough with make or with rust, but do we need to depend=
 on both
> >of these here? Wouldn't it be sufficient to say libgit-rs depends on lib=
git-sys, and
> >only explicitly depend on libgit-rs in `all::`?
>
> Not all platforms can build libgit-rs, so inserting it into as a required=
 component is not
> a particularly friendly idea.
>

That's not what I was suggesting. This is already in an `ifdef`, and
the line I was quoting was changing `all:: libgit-sys libgit-rs` to
`all:: libgit-sys .WAIT libgit-rs`. I'm wondering if we can instead
split the `libgit-sys libgit-rs:` from a few lines earlier into
`libgit-sys:` and `libgit-rs: libgit-sys` and then change this all
line to `all:: libgit-rs` (still behind `ifdef INCLUDE_LIBGIT_RS`).
