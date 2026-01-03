Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73F2290F
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767440111; cv=none; b=icgLpkI9VQX4LJ5jRVZ/L/hAMxQg8Xdt/54Pg0SY+hHbOyGNOYHwd4f+A0zWdmY6HJ/GlLvlkfURVnG5V1HyHJSHExXp6qwdRvIz1wNgKNhG60xlq0yPKRoTxUyv7ag5OXNDYCGgitiXOsfAQwMlTaTTKnQG6dmGVcBlyYov1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767440111; c=relaxed/simple;
	bh=SVu7R3vq4n8/4OSQE+InG0lxa4wy+zib8HUbsbqFiUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJffLxUjPFWKYOoHpTXQJ/PEkvlg8quAhRhqiWQlRD3V+sANw6E1OqEdmrblOh7JbcZKO8lMD2N72ILdVGsdWD4Rvn+3XE7qeOeQ6ChOJc8fz4sDA5R9NOFjFTRzSk2MryxHqFZKXABPKMn4N5M+iN+bZm2eoGUE469h/pK1ZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku1EMMbn; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku1EMMbn"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so10980091d50.3
        for <git@vger.kernel.org>; Sat, 03 Jan 2026 03:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767440106; x=1768044906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxPn9b3ZsIwCdt/MW8Dw8wc1JOouewEfELcYNpXSnw4=;
        b=Ku1EMMbn8dHHMQ5/WbOcoI2TOq4GAAXkTviheYwNUVyTErtGZqRjp03LH4xAnktScX
         oksOgvgtqxKqn0ZBKWmNhyz2y60qZG38h//rqErmEMbRH6UF/uR54TXK+bklZiQYI30Q
         CwswhRaTpxXBmj+C7Fa6c/u7s+oOJ++IpQ1UcpNoRvSnem8qNPHOpFKxcHKUp0hynB5C
         PcrBo0Ptvv2jIJAE8eDTIyoM4JkZsa5PUnVzuMAq2O+n/oMx4ou/0qcJ9PC4A9HRhuFb
         je1hTSLWxG6X7GDawsqtJmV3krSHDkhG4MnYIk2B4W8pIert11Gs/QFQhrXpAuMrSeMI
         Az3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767440106; x=1768044906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxPn9b3ZsIwCdt/MW8Dw8wc1JOouewEfELcYNpXSnw4=;
        b=PB18boMlFLoMNacCUieHV/RZqSD9lMoveudVHpswr3oO4NZ3ynO5ONp8CxbTwgkqHN
         bnIf7EimKTproJ7dXgzWeoeFQY51DC28tsqfFMcigZAkd1lyTNKmvTquglaeOlD/1sLT
         b+wpRSpghemaQ+2ZoQJMYhfn6MWhx6cBXtkGgg7sfxCk/AXADkizVcy9N5Lyon/6tM26
         JxrDsphUsT6FsZ7VvubajBu+RuCuSwyHSVTDHYlICqYs8yDGwmA2T5LTWHaZqwO8gKcN
         dDurygWvc8/Z64mOA2pdpRrzreaaDZFF42Yu0biXXw8WRVOu1ojlRHMGGsfsOe5zW1Df
         eJpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTQgpn/nxr86TKx49K14crfsNFbyMnS3UPhOerpdR7n0zlPzbwlEgg9jkRHtegWHHvS3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzC6LtWHea3BtTnoVnATJwT4v945FvBqiFK82mxtEmmJi/Mqwv
	glr+RtT/uasKzoWJ2srCMZvdqKWR+SAdssEWTCqI2WNMGJJF3HpmUfFFLJY+FIBe2nTJ0i9I1PD
	eL5f5A5EgZvg8eWoxUnXonlfTkAfeMSI=
X-Gm-Gg: AY/fxX7/E6k3DBZ4B8i7J0a65MwTrxpRLU+aojWiBgHI0oPdbv/5kuPkP2epxlrrw16
	rTKsBurp+YwDam+ILcY6Cqm8K052loj4Edg8XyK3V38zKXS+rKbtQv7SsmfFX8yksaZ5PAf9Ayo
	+pcUbSb9oZ3+Wb26UqeGhotswNADj1pGWI+51kPkf2//MXxg8t4ibmLVZMfEo4gA6HtwGggUPCj
	li7cgfBz1sQoFQBnCUZyRG0n3uRq1SY656ulG/5gRD67vvswIINzsw8VB5Kptk4Zwg9LP8=
X-Google-Smtp-Source: AGHT+IFu4ahVshQELc0aCCrxSLmrsh7NC/YIRzqDNjAJlCdm2Gf5Mo8B4K6ruOCHpcmfSoj1K1m9Lt5TXrrACp4FNv0=
X-Received: by 2002:a05:690e:144e:b0:641:e6aa:583f with SMTP id
 956f58d0204a3-6466a8375eamr35909288d50.15.1767440106501; Sat, 03 Jan 2026
 03:35:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALiS03_X4kA47-bimcovqAsTDXOM-KbKUAApM5xHdYzk9kqkbQ@mail.gmail.com>
 <20260103112642.GA2706421@coredump.intra.peff.net>
In-Reply-To: <20260103112642.GA2706421@coredump.intra.peff.net>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Sat, 3 Jan 2026 17:04:54 +0530
X-Gm-Features: AQt7F2pdNrg3GcInyUsAGHJL76ioO37gMJXGcKOlXyzhpEBgQEB6smDRmbjqFaU
Message-ID: <CALE2CrQ9OmCprNckT5qMwx87NZZfKTe0C6bfD76d4tyUFDgJgQ@mail.gmail.com>
Subject: Re: bug report: git status -z doesn't respect status.relativePaths=true
To: Jeff King <peff@peff.net>
Cc: Artur Pyrogovskyi <arp@letterty.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

Thanks for the detailed explanation. That clarifies why `-z` implies
`--porcelain=3Dv1` and why `status.relativePaths` gets ignored in that case=
.

I agree that the `--short -z` behavior is surprising. From the
documentation, I would also expect `status.relativePaths=3Dtrue` to be
honored there, so ignoring the prefix entirely does look like a real
issue rather than just a quirk.

The `--porcelain=3Dv2 -z` case is interesting as well. If v2 is intended
to respect the configuration, then the inconsistency when using `-z`
does seem like a related bug.

If it would be useful, I am happy to help investigate further or work
on tests once there is consensus on the intended behavior.

Thanks,
Pushkar

On Sat, Jan 3, 2026 at 4:56=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Sat, Jan 03, 2026 at 02:47:36AM -0800, Artur Pyrogovskyi wrote:
>
> > According to the man page of git-status: "-z Terminate entries with
> > NUL, instead of LF."
> >
> > However, it ignores status.relativePaths=3Dtrue and always shows absolu=
te paths.
>
> This matches the documented behavior. In --porcelain=3Dv1 mode, we ignore
> most configuration options (like status.relativePaths). And -z puts us
> into v1 porcelain mode by default:
>
>        -z
>            Terminate entries with NUL, instead of LF. This implies the
>            --porcelain=3Dv1 output format if no other format is given.
>
> I do think there is at least one bug here, though. I'd expect from that
> documentation to be able to do:
>
>   git -c status.relativePaths=3Dtrue status --short -z
>
> and get relative paths. But it doesn't work. The --short output code
> that handles "-z" ignores the prefix entirely.
>
> Something like this would fix it:
>
> diff --git a/wt-status.c b/wt-status.c
> index e12adb26b9..22797371a6 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -2005,6 +2005,13 @@ static void wt_shortstatus_unmerged(struct string_=
list_item *it,
>         }
>  }
>
> +static void print_with_nul(struct wt_status *s, const char *fn)
> +{
> +       struct strbuf scratch =3D STRBUF_INIT;
> +       fprintf(s->fp, "%s%c", relative_path(fn, s->prefix, &scratch), 0)=
;
> +       strbuf_release(&scratch);
> +}
> +
>  static void wt_shortstatus_status(struct string_list_item *it,
>                          struct wt_status *s)
>  {
> @@ -2020,9 +2027,9 @@ static void wt_shortstatus_status(struct string_lis=
t_item *it,
>                 fputc(' ', s->fp);
>         fputc(' ', s->fp);
>         if (s->null_termination) {
> -               fprintf(s->fp, "%s%c", it->string, 0);
> +               print_with_nul(s, it->string);
>                 if (d->rename_source)
> -                       fprintf(s->fp, "%s%c", d->rename_source, 0);
> +                       print_with_nul(s, d->rename_source);
>         } else {
>                 struct strbuf onebuf =3D STRBUF_INIT;
>                 const char *one;
>
> but:
>
>   1. it would need similar adjustments to a few other printing
>      functions; and
>
>   2. it's not clear to me if we want to change this behavior or keep
>      it as a historical quirk and document it as such.
>
>      I guess nobody noticed because using "-z" with "--short" is a bit
>      of an odd thing to want to do.
>
>
> There's another oddity, which is this:
>
> > Repro steps:
> > $ mkdir test-repo && cd test-repo && git init .
> > $ mkdir subdir && touch subdir/test-file.txt && cd subdir && git add
> > test-file.txt
> > $ git -c status.relativePaths=3Dtrue status --porcelain=3D2
> > 1 A. N... 000000 100644 100644
> > 0000000000000000000000000000000000000000
> > e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 test-file.txt
>
> I am surprised to see that the v2 porcelain respects that config option
> at all. I don't know if that's a bug, or a subtle change from v1. I
> don't see it mentioned in the documentation.
>
> If it isn't a bug, and we expect v2 porcelain to respect the config,
> then this:
>
> > $ git -c status.relativePaths=3Dtrue status --porcelain=3D2 -z
> > 1 A. N... 000000 100644 100644
> > 0000000000000000000000000000000000000000
> > e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 subdir/test-file.txt%
>
> is another bug similar to the --short one.
>
> -Peff
>
