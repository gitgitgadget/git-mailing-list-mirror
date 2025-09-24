Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BCA2040B6
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725207; cv=none; b=RoUaUa482LM5fjeQ2V8nfC4pbL1XXjTt/649EJlERsKOSaod4ylcGaEKacsACQle7x8gfkc4kocm7HxTn4V2kG6ZxJlCgDjg4WBej5f1jH51AOUN6pgUbKCVJWe9OvOcTA1BOZG2JSZ/V7G7+t5/5iHJS4ul5htvawJ0raITLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725207; c=relaxed/simple;
	bh=QZFchRfKxlLZbeElVq/BEQzLhWHmdTaq0LwL3xne81I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9cf6FXnatD5CQQKxAJD86iQmh2olvVfDjr4ONN4T5bLq9TAN/ch85MGvCRINB+kvPzrA2M2UqKuJrFnvdo+IMw9yUc59iRB923ZWIOzQmjOElNleVYqe3BiVCkxwuLBlEq5bKSpkG4nZZlrygRMQeNj7H1jZZl2Tmk4BNGS7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuCOTaJE; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuCOTaJE"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-36a6a397477so42626731fa.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758725203; x=1759330003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPoWFxX2dqyww/03S9KNPYHNbohZT7lA3mNQpRhiXEs=;
        b=LuCOTaJEouRH/cAIm5gezsOMB3RDZJMAElssF6FiNaWxDiHioMRmQk2HhvhRMRHsT1
         Jm0zrtIfGs+b0PbSxmnXBOJtnBM6JJXQjEtifTHW9R6cVYnmOMFUCLPfk3QPXolPgrDF
         tdFblLrCdZtvJm5jEY45nMaebxqjjnb3scyrI37dLDNK7ZOr0NBOeJ/vq2IvzUwRCW/+
         0IICCu9mAMnLmIQESFguPRoYAPm3leX5HSAdXYFYJKO3nbojoCwsZ7OABGK2NDIRv4Ya
         ghFletfiL7JkFzB7SwGFcRkdqscjvA3Sb8+8gbT2dcwtKrDkyvTtpjVzcSByM9At5y1d
         gx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725203; x=1759330003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPoWFxX2dqyww/03S9KNPYHNbohZT7lA3mNQpRhiXEs=;
        b=tX3IJem9yNaxppfMaB2Mo+/PyCFQ7nqRelXyjoqmaaSaQA4i679mFKf6EtPcCanEBa
         y+LEQHKDLwev6qrT4pYZua9nNImokogaqd4NjKvPszjbOpBRsbv0wcd82McXdnip3gek
         ZpSHEuyRT4P4s0DgVkb5fNG8m8UCRHy0t8GKoJ5NUHA1SzvcwmmmHrLEd6NpPQt64b+q
         6Nw2vBUD1aMZ1uHI/AY/r2NYmCOEU3dcJNm+axC+mZILaN/V79buV5hufKFKLtQXehy3
         4z6ToQAi9xbB4B8D9qYwSTWEdFl6jGsslDcb5SLgO+9XeQA9fnqNHUAu6vOSUfsh8RMI
         VK/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0mktml47/McEoqBgOmENXzwB5O6M/pStu6qedAdM/ZnMk4t0xoLvRDLoRd7nwA8a0944=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVGNp6ivOLlj5MbN2nL0fMIeU6WBVtdu0B1K0qLlDVB5MEPDJX
	cmOiN58IAja6vWSc/pQ+cd8DPwpqZBv7Yg0x/lXRQ/Q6dBYiTVswt55ifjE3CvDbnmbRyzHmoU1
	Vg1kfwttYfE+K6rtO9dZG1l+aC9A0pxk=
X-Gm-Gg: ASbGncuvKcHHA8tBx3wMwDGAqUm+6no+SlkSIxQ4RF8ZniEpuJT7iDuqYHF/oY9FQLX
	o7bqFEorcu79TYH5MhrEuwFuDn9gYEShSRDugYVDukdWr+reqozBdc7gAhuBxiQ9Mvwabf9WGzp
	kHmfhAdRUYSBhAC0BA4mvVmFUt73cNN6c2WWA+m5IFa9jfFngFxlOhX/MO7zs/NvTujuzWsph6O
	gx9umFg
X-Google-Smtp-Source: AGHT+IGHfiV4VSVmhKma2En0yzY5jnWTbWgA1av7LiWwXQbnGQra7Q3RzfhYLk5cOpuDNMZ2HrhqX+DoUnMSTFzs4R8=
X-Received: by 2002:a05:651c:19a6:b0:36c:47c8:b618 with SMTP id
 38308e7fff4ca-36d15b5af54mr22426121fa.18.1758725202884; Wed, 24 Sep 2025
 07:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com> <08a0fceb72b2bd0a2803d24b9874b7f9bd03703a.1758662670.git.gitgitgadget@gmail.com>
 <311f7dbe-b970-4a5b-9d53-05f019cc54cd@gmail.com>
In-Reply-To: <311f7dbe-b970-4a5b-9d53-05f019cc54cd@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 24 Sep 2025 08:46:31 -0600
X-Gm-Features: AS18NWDhn9I26ZGLJGnFoicg1oFuptjZSHgtJuJsOetxnS-jgI8Q0U3yI-d9JSg
Message-ID: <CAH=ZcbBcEbTqQ-FpYSdr_QjSM5sKerECKsSVdTyHoSQqG-V9iA@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] xdiff: use enum macros NONE(0), SOME(1),
 TOO_MANY(2) in xprepare.c
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:21=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > Rename dis1, dis2 to matches1, matches2.
> >
> > Define macros NONE(0), SOME(1), TOO_MANY(2) as the enum values for
> > matches1 and matches2. These states will influence whether changed[i]
> > is set to 1 or kept as 0.
>
> This message also says what is being changed rather than why it is being
> changed. I think the rename here is a good idea but I'm not sure what
> "rdis[01]" and "rpdis[01]" are used for and whether they should be
> renamed if we're renaming "dis[01]"

"Rename dis1, dis2 to matches1, matches2 to give the variable names a
more obvious meaning."

Would something like that work, or do I need to refine it further? I
would love to rename rdis, rpdis, etc... except that I don't
understand what is happening or why. Could someone explain the purpose
of these variables?

> >       /*
> > -      * Limits the window the is examined during the similar-lines
> > -      * scan. The loops below stops when dis[i - r] =3D=3D 1 (line tha=
t
> > +      * Limits the window that is examined during the similar-lines
> > +      * scan. The loops below stops when matches[i - r] =3D=3D SOME (l=
ine that
>
> Thanks for updating the comments. Not reflowing the lines makes the diff
> easier to read but leaves the comments in a rather strange state with
> random long lines.

What is the reflow limit for comments? 72? 80?

> >        * has no match), but there are corner cases where the loop
> >        * proceed all the way to the extremities by causing huge
> >        * performance penalties in case of big files.
> > @@ -207,40 +210,44 @@ static int xdl_clean_mmatch(char const *dis, long=
 i, long s, long e) {
> >
> >       /*
> >        * Scans the lines before 'i' to find a run of lines that either
> > -      * have no match (dis[j] =3D=3D 0) or have multiple matches (dis[=
j] > 1).
> > -      * Note that we always call this function with dis[i] > 1, so the
> > +      * have no match (matches[j] =3D=3D NONE) or have multiple matche=
s (matches[j] =3D=3D TOO_MANY).
> > +      * Note that we always call this function with matches[i] =3D=3D =
TOO_MANY, so the
>
> especially here
>
> > -             if (!dis[i + r])
> > +             if (matches[i + r] =3D=3D NONE)
> >                       rdis1++;
> > -             else if (dis[i + r] =3D=3D 2)
> > +             else if (matches[i + r] =3D=3D TOO_MANY)
> >                       rpdis1++;
> > -             else
> > +             else if (matches[i + r] =3D=3D SOME)
> >                       break;
> > +             else
> > +                     BUG("Illegal value for matches[i + r]");
>
> Nice addition

Thanks.

> >   static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, x=
dfile_t *xdf2) {
> >       long i, nm, nreff, mlim;
> >       xrecord_t *recs;
> >       xdlclass_t *rcrec;
> > -     char *dis, *dis1, *dis2;
> > -     int need_min =3D !!(cf->flags & XDF_NEED_MINIMAL);
> > +     uint8_t *matches1, *matches2;
>
> Let's initialize these where they're declared rather than later on

I can do that.

> > +     int status =3D 0;
> I think we typically we call this "ret" or "res" in the rest of the code
> base.
>
> > +     bool need_min =3D !!(cf->flags & XDF_NEED_MINIMAL);
>
> Nice use of bool, strictly speaking I don't think we need the !! if
> we're changing the type from int. I think Junio recently suggested that
> we might start using (bool) instead of !! for cases like this.
>
> Everything below this looks good, though some of the lines are getting
> quite long with the renamed variables and symbolic values so we might
> want to break them.

I didn't add !! and thought it looked funny myself. I didn't remove it
because I wasn't sure if I should.
