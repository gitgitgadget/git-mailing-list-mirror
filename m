Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE4F2E0B48
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733351; cv=none; b=KTZRmRB5ohD82BXfH0c2gu38pHWQ0iBzCgdv/0BjjilOBEUZc4bNtMjYQn/r/jp42wxFunTKYMn8nuWKRpoQBhSF7IK+05PtP0yXPPVILLFwrINatr6nClBFgoaVEqd9Jvm9gagDC+IHC6FIR7qURSEbhgTOCy9ZeZ9f+fvvFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733351; c=relaxed/simple;
	bh=mH9u8zOnRc/28aWK/MPMk2PBqmypI3LfXMOGX5jxHUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aB85N0eZnlOpVYu5RF//YAj8WVXX+B3h65EEMygJfZzG88ytkUQyBksevbOB/u+ktEvsvfjncj7aaPEIxaDD1PrKvO6J6V+LdNFLk2v/OtivwyePv2XYUmW8YKqEyhrC/y3ueMuhZ9b/1/jNYHWXymVvKrBi5xQBcEhO3g0jT7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAA+2kav; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAA+2kav"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb78e70c5so67046866b.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 16:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755733347; x=1756338147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrWRlPU4OuqwhWDxYAA6pLCpjMUfTKCTFzwQsrhD4rg=;
        b=NAA+2kavGkJklrOoJ+n/OoSrmU+zuR4iu6tanhYRYnIgwgClyKUeRLF+TQeuGC77jI
         bYmlZAm64qYzDXpZ8TEiEifL6nqEAR1qlvLqdaAWa38rww6zHLkYGCvFVRXrWzF6Q8zV
         hdCBqA5WeBUJo+M9+4oCRCIK6+U/SsiWFBdtGdRUs9LHiDq1XwynZZfiLjaBzxQaQOID
         tBYfcVyR8VpMov9asDLLS/39hwcRvDyxkqU+HUtN65lQGkZnicUS5i9LwAYHqDH8/PaW
         Ig7cgl/C4sOZ405vjWUshJr5sIuNz8kfCl2GJ+o+G4TLn+gjPefXRFOsIdcdMMBtwg/h
         +o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733347; x=1756338147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrWRlPU4OuqwhWDxYAA6pLCpjMUfTKCTFzwQsrhD4rg=;
        b=khXvzpxiuZVFWMzjKZawrPjYGMv7eNmx3I3SdPJOUOPAbxyj1FbQA1ezZ5lDpijbRJ
         JbRFwOW1rQQszXBH0cxrsNPYmWhkZ65kSYpl0S7M8Oz9AhS9fnz9I9/r4AoyFaBr9RqE
         jYEZmsl2rBsCsIw9ate7V1HENccTx4u0TqI6Uv7GBzokOjDCCTpQpc6nwb0BFtGwFors
         5BTkZyu6XBhwP21t0P3blvBY1+5K8rV3+7TkP8BkC0xtu5GwwWregBYZLv3BybISxwZe
         Sji1heiWpWXD0m17YJRMXAr2BkKndtVruCaNhu0Esixxbca0pKYPTejWzke9nYTVXUpG
         nb6A==
X-Forwarded-Encrypted: i=1; AJvYcCVQqVFS6nbOKWNgqlipjy3vD16+Dp5ijUNHW7usDtaj6GiG559GBaLaGCeiUIqJJvQdcb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7p73Zar2htO151zsLiWcbflOaWuooIxU/fR3FvY0vT0FvEK8z
	cHU2Pbk+pXilau+nujL7o1ynNu8CnMOgNjOB10QOZRrSt77f0Zdtus3A/fg37E54KA+oeTb5SdL
	+MIw72PExrlRITCdfka3EkipZdofeEwI=
X-Gm-Gg: ASbGncsdS04aB/rcoRLVCt/Qo4lE4q25d6Hwv+QwCSFinN1SqoiduO6KVtvCFhRGqIK
	FqRh9MabM+PZ1zp8I97B50w0cCGPsEWzYr4MM/owmgqrhCpINjyVj8PBp3HTYFSMEHlPX05gr+h
	biiauWTT24xPc2Rb9bcJf5UZ6mzoPExMGC33XybKFopF6uDo3tWcsSc4sF+3uscMoikH68ysU12
	zBCGyjJzs1LEvl3jjrngaAceDlH2npoI3OeZP6Ni0mtPu84Myxl
X-Google-Smtp-Source: AGHT+IF1M7Ee+Ahr414lXkeIjvnV7PNGerjklSSWSgYbyPteG3tkTVVyndFlhsEnjnqf9Y6V+PVg+YPbuG0Uh7lpyRc=
X-Received: by 2002:a17:907:94c5:b0:ae3:bb0a:1cc6 with SMTP id
 a640c23a62f3a-afe079adc2dmr57236066b.16.1755733347377; Wed, 20 Aug 2025
 16:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820195229.45943-1-rappazzo@gmail.com> <xmqq349laeyb.fsf@gitster.g>
 <CANoM8SVTROfaQpRNBfwxU9opjXFPLzxN1W-xXTrA2bhx9KJ0LQ@mail.gmail.com>
 <xmqqldnd8zpc.fsf@gitster.g> <CANoM8SX7_uQV-ZRAim55UaiHYCKTgKN0AO6zB1O7Ux4deiCNaw@mail.gmail.com>
In-Reply-To: <CANoM8SX7_uQV-ZRAim55UaiHYCKTgKN0AO6zB1O7Ux4deiCNaw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 20 Aug 2025 19:42:16 -0400
X-Gm-Features: Ac12FXzjhchVUUjgXXNcDK-XzZO7ua1Gn8Qxm2wp8INKYryT2BX8AmLWwp_pTUk
Message-ID: <CALnO6CBznUApKLv2pQbX9QJBU=O6R3MTo42AePp0kp2X-x3Vag@mail.gmail.com>
Subject: Re: [PATCH gitk] gitk: add README.md with contribution guidelines
To: Mike Rappazzo <rappazzo@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, j6t@kdbg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:20=E2=80=AFPM Mike Rappazzo <rappazzo@gmail.com> =
wrote:
>
> On Wed, Aug 20, 2025 at 5:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > Mike Rappazzo <rappazzo@gmail.com> writes:
> >
> > > On Wed, Aug 20, 2025 at 4:57=E2=80=AFPM Junio C Hamano <gitster@pobox=
.com> wrote:
> > >>
> > >> Michael Rappazzo <rappazzo@gmail.com> writes:
> > >>
> > >> > +#### Creating and Sending Patches
> > >> > +After committing your changes:
> > >> > +```bash
> > >> > +git format-patch -1 --subject-prefix=3D"PATCH gitk"
> > >> > +git send-email --to=3Dgit@vger.kernel.org --cc=3Dj6t@kdbg.org *.p=
atch
> > >> > +```
> > >>
> > >> Just being curious, but does the project strongly discourage a
> > >> multi-patch topic?
> > >
> > > I don't believe so.  I think most people know how to submit a github
> > > PR, but J6t has mentioned that he prefers the mailing list (as noted
> > > in the readme).  So I wrote a simple example to show that patching by
> > > email doesn't have to be scary.
> >
> > As the original assumes that you are on the branch where you are
> > taking the patch(es) from, perhaps
> >
> >     $ git format-patch --subject-prefix=3D'PATCH gitk' @{u}..
> >
> > would work?  I was mostly reacting to the "-1" on the command line.
>
> `@{u}..` is funny, because that seems to assume that you haven't
> pushed your changes to its upstream yet.  I could say `master..` but
> that assumes that you named the branch that (as opposed to `main` or
> something).  I will try a few different ways and see how they feel.
> As I said, I just wanted an example to demystify patching by email.  I
> think if I add something above to clarify that this is just an example
> and not verbose instructions it could help too.

It is less funny when @{u} is the branch you started your work from
and where you hope to integrate to, as in

    git switch -c topic origin/master

or something.

Then, you might use @{push} to refer to that "somewhere else" you push
to that is not the place to which you hope your changes will go. It is
certainly different from lots of GitHub- and similar tutorials that
encourage "git push -u <remote> <branch>," which sets @{upstream} to
what I prefer to use @{push} for. Granted, those tutorials use
something closer to a centralized workflow, and what I'm describing
(what mailing list flows are?) is more triangular.

> > >> It would be really nice if you add "review them here before you run
> > >> send-email" step between these two commands ;-).
> > >
> > > I can revise.  I will wait for more comments before sending a v2.

Linking to https://git-send-email.io/ is probably the best advice on
making sending patches less scary.

--=20
D. Ben Knoble
