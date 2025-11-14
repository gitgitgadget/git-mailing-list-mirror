Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB42DC34D
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100152; cv=none; b=gbEPzrEVmNqet6+P4NK4sxR5jJudsJAfMAgxdAgk9+A9lbPyQoK5uVdUKfU4VmAqjCKiQZWL7ukT1c1Yfh1hnJCT8rkDzRnoF0HfYZaXb0Vr8Joi7e9BNVczAZZzPQxx68fNm3aymyhcLcQBTz4F79fD9AbAx9Ico5RM77BzjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100152; c=relaxed/simple;
	bh=F0oOZ5IwBR+dMbJgAHv7T1plj28ICk/tHSvHZmTYT4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPBDMJMZOeZguhxe+hPpltZ8Vd1MiN+yKR4OCfxEc4nG3PHtY2sDT9u0tvYtLQniZVRBXaPKbf0qXYF30bgWn9q6DFVyb5GHLwX2frUwZS3uqPy34GLDzUGdZ3FKXtMGH9/kfVPrGGIQ0I3/qmvJgtXAhPeesXbwPUJ6sxVd/ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crOSMYT9; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crOSMYT9"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37a4e329a90so13126151fa.0
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 22:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763100148; x=1763704948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lod9J170nljnNgvNW6pTADvvlcTu8UWnDcbnpjIs3mQ=;
        b=crOSMYT9sPaEKRpvHGzKMWays5oAIsZZQiR8pKi/I4WgbZC5goBXSzfsvK39pXEKFs
         dEQB77xnS5l8vdcGZmqMSjaZIqXUR9qK15juB7bfgaTp5Eqo7c+pwDqNpZhSUx9OYwi0
         ZvvQ3+7BmJKJ8i8alVRze/t3kIPfTIW/b8gBTrCggdQ88FR60wViQ/EmBGTmtNtAp1T1
         /ySspZQ36Y/bqDZPStgfW93igPks0J4c9a/aAzL/sSEkDylMfJhvF2ohOXX32Umw3Jcd
         vcyLK5u7H3FvCsZBKKkhhTZb7IjkXxwjCChApEYdM7xk5WRPC7ua0/y4siec46S525NB
         b0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763100148; x=1763704948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lod9J170nljnNgvNW6pTADvvlcTu8UWnDcbnpjIs3mQ=;
        b=cQanFTm1/+pxu20m+64CRTidRws8t2ionTpszUh+0q7S30cH8A0vq/HlgRBUeSNVh4
         MHlWousU2uYSSvlFP99I55SO3U6Lp/bxcKLI2TVFn2NHUTWkJWHJHCo5PyKGYcId4sSe
         rISvmrizGTTbnv90C0VeONztd2hDqDEHl+Wbc3KZsFusJI95gUDuXvDw5BomY/6wN6rg
         SApwlzVXawMiDbLMS4WqEUcPva1h3Avn84ldY39OeL+G3V7C+5i7K3hbyf03hE9Dpox5
         DUQ49Xav+7z6qob5/KPejzXkx+is03y5SUZqlZJM82Ttm2IS6O0PSNL6/gKoE0pp0QzH
         zFcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQUCJ05iJ9CgLpx/QXfZQf17ndmNJTG9xd5vtab8FGfs+UbxsyUrCjqzNG410JSPTdBZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT0sMqQLa4jqAFDZ4TCadUPmEVUqezNF9dU9DARKqJY6fYfZsh
	BUzuwd+JQt2gwodG7+bxOnwA7/x2SNXagMWH6lndrjJDnS1s7rT6Np0a6vN4wT/RVkRII4ZVndZ
	C5czwH0Vrl+gudGXD3hZRllwTdAewa6s=
X-Gm-Gg: ASbGncsgYJraVENFUpRNdPtt65kEOCXUYV/OSHl3cHvwUIrwiN2RFU36kMXLAN4Qzxm
	mODBn+88Ccv+Hoag8e50f343MlXI6Kb0NIH0pcKMW/TlXEOYVA6HUF3gc4pI6/bYJ3SZkRiTXVf
	1ddZeCp/uPE2ssTHFIgJKMZeaHQAtCnBNsfSd5hdxX6s4tetwjWN8kUJM5g7bq4b5GOI05CEtyv
	aObZ1UfDfgHxG3wsI1rhOoCTc8VH8ovylEg3FREXrtuy8h0DNZLpmUdXbJ3d7HHuixr9HZDn+0+
	eiQ4vDSBm5cy7jpTkg==
X-Google-Smtp-Source: AGHT+IHmyAw82SX845jr+JN/u9Ro0o46Sq0s400Y8o9LIvzciE9bL3argrh/EHM6DONuuxS/noxl5c1hp4e7yKbmOqs=
X-Received: by 2002:a05:651c:439a:10b0:37b:965e:c149 with SMTP id
 38308e7fff4ca-37babbdc080mr3291371fa.24.1763100148026; Thu, 13 Nov 2025
 22:02:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
 <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com> <da2b80ea0be3470cbfe04ff4d39727e6d5921a9a.1762890152.git.gitgitgadget@gmail.com>
 <xmqq346kupzm.fsf@gitster.g>
In-Reply-To: <xmqq346kupzm.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 13 Nov 2025 23:02:16 -0700
X-Gm-Features: AWmQ_bk-kHPdHmCiODhYCXhG0v5n4m7YBbbDZcV5v3MT6e08GqgyZt4m-ZtE1z4
Message-ID: <CAH=ZcbBNSNqU3i4DSruVixvYzCEs_MxLCvX6D5W7FsXRqpvALw@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] xdiff: use size_t for xrecord_t.size
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:08=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > size_t is the appropriate type because size is describing the number of
> > elements, bytes in this case, in memory.
> >
> > Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> > ---
> >  xdiff/xdiffi.c   |  7 +++----
> >  xdiff/xemit.c    |  8 ++++----
> >  xdiff/xmerge.c   | 16 ++++++++--------
> >  xdiff/xprepare.c |  6 +++---
> >  xdiff/xtypes.h   |  2 +-
> >  5 files changed, 19 insertions(+), 20 deletions(-)
>
> This step looks mostly OK but it is messy in some places.
>
> > diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> > index ead930088a..2f8007753c 100644
> > --- a/xdiff/xemit.c
> > +++ b/xdiff/xemit.c
> > @@ -27,7 +27,7 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, ch=
ar const *pre, xdemitcb_t *
> >  {
> >       xrecord_t *rec =3D &xdf->recs[ri];
> >
> > -     if (xdl_emit_diffrec((char const *)rec->ptr, rec->size, pre, strl=
en(pre), ecb) < 0)
> > +     if (xdl_emit_diffrec((char const *)rec->ptr, (long)rec->size, pre=
, strlen(pre), ecb) < 0)
>
> On platforms where long is narrower than size_t, we'd tentatively
> leave things broken until we update xdl_emit_diffrec() to take
> size_t, as it would become too noisy to change it in the same patch,
> I guess?
>
> > @@ -113,8 +113,8 @@ static long match_func_rec(xdfile_t *xdf, xdemitcon=
f_t const *xecfg, long ri,
> >       xrecord_t *rec =3D &xdf->recs[ri];
> >
> >       if (!xecfg->find_func)
> > -             return def_ff((const char *)rec->ptr, rec->size, buf, sz)=
;
> > -     return xecfg->find_func((const char *)rec->ptr, rec->size, buf, s=
z, xecfg->find_func_priv);
> > +             return def_ff((const char *)rec->ptr, (long)rec->size, bu=
f, sz);
> > +     return xecfg->find_func((const char *)rec->ptr, (long)rec->size, =
buf, sz, xecfg->find_func_priv);
>
> Ditto.
>
> > diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> > index 75cb3e76a2..0dd4558a32 100644
> > --- a/xdiff/xmerge.c
> > +++ b/xdiff/xmerge.c
> > @@ -101,8 +101,8 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i=
1, xdfenv_t *xe2, int i2,
> >       xrecord_t *rec2 =3D xe2->xdf2.recs + i2;
> >
> >       for (i =3D 0; i < line_count; i++) {
> > -             int result =3D xdl_recmatch((const char *)rec1[i].ptr, re=
c1[i].size,
> > -                     (const char *)rec2[i].ptr, rec2[i].size, flags);
> > +             int result =3D xdl_recmatch((const char *)rec1[i].ptr, (l=
ong)rec1[i].size,
> > +                     (const char *)rec2[i].ptr, (long)rec2[i].size, fl=
ags);
>
> Ditto.
>
> > @@ -119,11 +119,11 @@ static int xdl_recs_copy_0(int use_orig, xdfenv_t=
 *xe, int i, int count, int nee
> >       if (count < 1)
> >               return 0;
> >
> > -     for (i =3D 0; i < count; size +=3D recs[i++].size)
> > +     for (i =3D 0; i < count; size +=3D (int)recs[i++].size)
> >               if (dest)
> >                       memcpy(dest + size, recs[i].ptr, recs[i].size);
> >       if (add_nl) {
> > -             i =3D recs[count - 1].size;
> > +             i =3D (int)recs[count - 1].size;
> >               if (i =3D=3D 0 || recs[count - 1].ptr[i - 1] !=3D '\n') {
> >                       if (needs_cr) {
> >                               if (dest)
>
> This is messier than I expected.  Before the precontext of this
> hunk, "i" and "count" are both incoming parameters of type "int", so
> the same "what if size_t is wider?" puzzlement applies here.  At
> least, the reason why "i" and "count" is "int" is not because they
> want to be able to express negative values, so it shouldn't involve
> too much hassle if we later want to change them to size_t to lose
> these casts.
>
> > @@ -324,8 +324,8 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, con=
st char *name1,
> >
> >  static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long fl=
ags)
> >  {
> > -     return xdl_recmatch((const char *)rec1->ptr, rec1->size,
> > -                         (const char *)rec2->ptr, rec2->size, flags);
> > +     return xdl_recmatch((const char *)rec1->ptr, (long)rec1->size,
> > +                         (const char *)rec2->ptr, (long)rec2->size, fl=
ags);
> >  }
>
> Same "long may not be wide enough, in which case we'd need further
> fixes" applies here.
>
> > @@ -441,7 +441,7 @@ static int lines_contain_alnum(xdfenv_t *xe, int i,=
 int chg)
> >  {
> >       for (; chg; chg--, i++)
> >               if (line_contains_alnum((const char *)xe->xdf2.recs[i].pt=
r,
> > -                             xe->xdf2.recs[i].size))
> > +                             (long)xe->xdf2.recs[i].size))
> >                       return 1;
> >       return 0;
> >  }
>
> Ditto.
>
> > diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> > index 4c56467076..b3219aed3e 100644
> > --- a/xdiff/xprepare.c
> > +++ b/xdiff/xprepare.c
> > @@ -99,8 +99,8 @@ static int xdl_classify_record(unsigned int pass, xdl=
classifier_t *cf, xrecord_t
> >       hi =3D (long) XDL_HASHLONG(rec->ha, cf->hbits);
> >       for (rcrec =3D cf->rchash[hi]; rcrec; rcrec =3D rcrec->next)
> >               if (rcrec->rec.ha =3D=3D rec->ha &&
> > -                             xdl_recmatch((const char *)rcrec->rec.ptr=
, rcrec->rec.size,
> > -                                     (const char *)rec->ptr, rec->size=
, cf->flags))
> > +                             xdl_recmatch((const char *)rcrec->rec.ptr=
, (long)rcrec->rec.size,
> > +                                     (const char *)rec->ptr, (long)rec=
->size, cf->flags))
>
> Ditto.

mmbuffer_t holds all of the bytes of the file in memory, so the number
of lines referenced in mmbuffer_t has to be less than or equal to
that, which makes the point about long vs size_t moot for this patch
series. Maybe int vs size_t is a different story, but there are many
other places that use `int` that limit the number of lines in a file
that aren't touched at all in this patch series. I will update these
types, but in a future patch series because they cause a refactor
avalanche in many places.

I don't like the current state that Xdiff is in either. That's why I
intend to keep going with my xdiff cleanup series.

> > @@ -157,7 +157,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfil=
e_t *mf, long narec, xpparam_
> >                               goto abort;
> >                       crec =3D &xdf->recs[xdf->nrec++];
> >                       crec->ptr =3D (uint8_t const *)prev;
> > -                     crec->size =3D (long) (cur - prev);
> > +                     crec->size =3D cur - prev;
>
> Yay!
>
> > diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> > index b1c520a378..88b1fe4649 100644
> > --- a/xdiff/xtypes.h
> > +++ b/xdiff/xtypes.h
> > @@ -40,7 +40,7 @@ typedef struct s_chastore {
> >
> >  typedef struct s_xrecord {
> >       uint8_t const *ptr;
> > -     long size;
> > +     size_t size;
>
> Yay, too!
>
> >       unsigned long ha;
> >  } xrecord_t;

I agree. It's nice to see some clean code in this patch series.
