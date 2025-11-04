Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435E1EB1A4
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280584; cv=none; b=YlL3c1+FRnB3AfXk/2tr8ro6paV/4JSuGKp69cyuuVlFUvtwH6QuDGKtmS4WOQn43yYqXx8D5vNa2w4hKnBZFpecC2uXxox/Hp5JUjuOnkIbny+DutuRDVdktGmbpnfw+kzE3MyCI3C5NgXqYWFaih+SA6LnBqK6M8Le1nfi5ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280584; c=relaxed/simple;
	bh=e1DflJ5ME5zwYIplN2twYgkTpRct+bW+sFSiJqrYAnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7zS36LfsvhiioVPhmf2TFydzY4MpeuL8uv30hP3yIQImYufqcMuF7sSZXfgKfIU0M/pIu3t9c39jC59HFFQ8sfILfHTtvOMUJ4ztd+lN2aEeVHWOKXpYIBltnjUGpJp+WZGLmgZsaMp8MlY+kogpjveOoyibH+jY48hbs5nERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nB+D+erK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB+D+erK"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b710601e659so373072666b.1
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 10:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762280582; x=1762885382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDXYbN01oVU3xKTzHtbzkWld3oom/1hXYvu/0OO/sQg=;
        b=nB+D+erKNJTJPruxr4k6bzi7Y/uTxXRHzUcUJubkAtExuEFBT4VxEkVpQecVtgBZXD
         /MnRQBl3vXKD76WATATn7+fXf1EzMFs9wtSdQWIqbVbK3FXWjhsdD7gR0b+PMvKsme7C
         Ix8r4uNRpMWaOIYniPHpAREQc3RGN766lC5geg3eoE9tajFx9TcLcHrvQcG7R12PgzVX
         mhYCVx54kiWqfklJsUmHU3Ayfd7R1wGdXZORQ7ofNboALW4vqJSgRjOqjW+ifhE4R2Ie
         v2QM2lRhPkB8L7dOAipWllrMDEHyJqQmeyRC152D8huhH0GQKhxmOGGNfs+Gj7nJFYmy
         n2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762280582; x=1762885382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDXYbN01oVU3xKTzHtbzkWld3oom/1hXYvu/0OO/sQg=;
        b=WZcNzCCbGx6zwaZb3E9hMTdzAV2HNjNkrhCmzvs1TUI6wjiasVl9GH/u4eYkxmJa0o
         f+E68mhc7TtGWBvalRTMUo2zOoDWwc/Dg472r3M0gB7dyR760fj9jxBvEem3AVz3OCq7
         V7FGkMqVDG2sLsECROljh2pDYVoSn5hajcZGqcMPLuwEo7Bo/mAS8uRJq74v1ivV1BKi
         iMZZavSWlj7xi8I4jNsngDi5jQze4XULGlXiJW6U1VMQsu5iGvxdLW9Gc8L2V+BKzUpj
         JIj5IxsQICulCoYqBW4VEfjb8vKwOM6K54sDwop/5t7sj+Jrr/0zPlxVCB6O0V8TUppS
         Io0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2hGexSW5fW8PBPX9j0hjO6815b5bDXWEThK0wpqHrbRROQKWkDR4SmOZRK4ZPdtfOReI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcSH2W59EeXy1ToS7v1T05JGuFpxdBSjdTsFB5mBllrpie2Zjv
	vavDljqKWy31YdjNJmPchBkaRA7fifc8wlrgDe0Kzc1RzZ9RP6SK9xtgleyV9C7CVP3QAsAK2nG
	ClzPcYG8Xp7p0VMChZLeQRIxQOdYOXdo=
X-Gm-Gg: ASbGncslQcJ1xxxnxYWATP+8dRC3SLqhMkmVX6wvAMFJ5eavbczQ6BPUrrJtb8cKmOK
	jy2uNilv4TY3znLnrOMNIOjy2u403Z6uhrvJEBDzsBVXXjHGb+fqIm80B733PtGJVyXsXF5FAHJ
	pVcI5+Vy22VW+Zgpe9Imzs3unr2if/Xy3wRnjRX0BFceUnvzRimF9aDtKnKsUMnDpyK9vGb+35m
	5MZr/wmqnGWZSEbK8FMUIRr6dEeybsaFH8LS56YIPnkRtCnVuFmztoogf4Wx37d2bcRJNKIv7yV
	vOdBnhLTULSsm4rtpLGAwzHDqhLNPw==
X-Google-Smtp-Source: AGHT+IEPZT22gD5+QaYPvQHfWuvT+iW47OhVEPNSvvBR7IG/d2Meun4jzjmwnv4JyQbJn0qhpZiFpbIetkdVcsrC7Hs=
X-Received: by 2002:a17:906:f59b:b0:b71:51b:bd4c with SMTP id
 a640c23a62f3a-b726554bb96mr8921766b.50.1762280581640; Tue, 04 Nov 2025
 10:23:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762100242.git.ben.knoble+github@gmail.com>
 <10d531daf2c90d1bb53c07f1d72b087ebc1dd9c8.1762100242.git.ben.knoble+github@gmail.com>
 <xmqq5xbrwv4t.fsf@gitster.g> <962654fc-02ea-47a9-a2ae-913101281240@gmail.com>
In-Reply-To: <962654fc-02ea-47a9-a2ae-913101281240@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 4 Nov 2025 13:22:49 -0500
X-Gm-Features: AWmQ_bnDHkGtM2ZM9X27k_6aJruJZISuS8jl6KSTgYFJmsZIE7-Oe-Dw2VN3NOg
Message-ID: <CALnO6CCLUfQyMb2DU5OXowvO6SLhdso4mOr4ukQe_A_kAL1t0Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] parseopt: use boolean type for a simple flag
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 11:21=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 03/11/2025 05:19, Junio C Hamano wrote:
> > "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
> >
> >>              is_optional =3D skip_prefix(value, ":(optional)", &value)=
;
> >>              if (!value)
> >> -                    is_optional =3D 0;
> >> +                    is_optional =3D false;
> >
> > Whether it is spelled 0 or false, I do not think this makes any
> > sense.  skip_prefix() either touches &value to point at the
> > substring in value that comes after ":(optional)", or it does not
> > touch it at all, so there is no way value can be NULL here (and we
> > know value is not NULL before we call skip_prefix()).
> >
> > Shouldn't you be removing the entire "if value is NULL, it is not
> > optional" thing instead?  That is exactly what Phillip pointed out
> > in his review.
>
> Looking at this again I wonder if the intention was to error out if
> there wasn't a filename after the ":(optional)" prefix which I think
> would be a reasonable thing to do but that's not what this code actually
> does.
>
> Thanks
>
> Phillip

Agreed both, will reroll
