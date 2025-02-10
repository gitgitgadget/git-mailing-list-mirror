Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3C25B67E
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209899; cv=none; b=FxGY1tasSLLWvarYy7D8mAqSS5stcmLcw1jLbCZUuqzSekQax0HmVZ/HkyGindQyEnoM7nnAoMnPiXm2GSjcOb7MwD+GLHfahKntZDOdm6+okpCD1secia8i2fWpVZZqAYhAPi2gCOtl8CCwONmYkbLJ9P3kJk5rSwykXIIN/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209899; c=relaxed/simple;
	bh=dwF0vvemD5VdR30vfJuz9vH9ZxQY/HiNZ+gmnkYA2sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=glVAiyycna6Y43fSELIkhqQnrYnAxfUYq1rliElXijMxILxC0ZVUwvy4fNCaGQXQPYt5YR8iMCZAgzu01cEp2CnoMM21gfhi1nkmFklYkAX6Qyb1hgxEvwNAayyHsznVb8XN0YQA/E/+1sDI7q9d818MuVhK3JKFHcesy3B4Uzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el2N4ylC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el2N4ylC"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7b80cc3d2so206223266b.3
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 09:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209896; x=1739814696; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGmnEp7UEbdNcyugf9FG4fRiMoF4BYMqt7/vZ7HOWeU=;
        b=el2N4ylCJ8NmDsQmPOAz42qMy1uGSFEeXKORc+S36HoG4TeUNBmqmqKe8rgHjV16Gp
         8H6MBHMTc8Cl/0zxIFMr2Lu1bimZMyMUL+00cFPBj6rdbMaUCnuJFcdakSTco2/EOcQ/
         LHLGfJVlw1rzKImGxEXUAuOpRP2/dh+LmGk2bIw9nUPbSpjd4rl2y9YK2cpjf1CFUMoo
         tXo/v32JreD8oJuxuP4nacrt5g/mB4vXOGiw+grl+HxYrjUMK4f2+O52qk2Amr9Tdtpl
         f3k/L6oL2jDNvfWoQnx3ghlDzQyuhhugJmX/7e0ZcOt74+7pxc9OcwCswa4FsoU/TRfK
         3aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209896; x=1739814696;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGmnEp7UEbdNcyugf9FG4fRiMoF4BYMqt7/vZ7HOWeU=;
        b=oRXPe/dhIHcjlNkTDwBTAdsTgRNBknz1SDTKGJufyyF+KUvqKFELBh4i4S66DYudmd
         thelSuxdmVC8MnjtIvN6BQ4X1Wzjk90PM649ImH2cMHOtAB3S25iUeW2wURxoo6e+2WH
         K3CZu5znv+1LL7K+EpTjWV504l3mAYzbinWrcmlot+ZOVARZQpXIR2qsBxzSCu6Ha1ds
         Nk1lemKrG3tSXLMmuwvt07bUzhGk0knO6NnTR0Gm4xjDJaUtVh7+OVs+tdahRhG3ByVy
         Rlh9qy8unaEzTZScjLMARmUMOoOeDHHQTUoAQ/HcUs9laU1/MV8buPFOC12QkGITLeuW
         mv2w==
X-Forwarded-Encrypted: i=1; AJvYcCUlhJkxiNs4Ta2ETj4Wv11zPMxxIizfzBsJ0yOWjeYCLB18j/C5TmInKADsupCH/ZJF9wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaDvIBSaT+L0UW61ZU+A7E+xlrGmVmNQDTW6V8LcXv9XyJj970
	wbrb2oO/LLFZ9x6cVV1MAfNX6aOOtwV2hc+igEUbbskPzI9JUo34Q9MuEVPDXP6iL3c0Fmpevmg
	CXZn+MGK/ZzVRFZWxkGmjxn5P1KL9utFP
X-Gm-Gg: ASbGncv0jDRtdJ9cvSVRp1IW/U/8k31pIZKNXrFDxXEtbBmDe15lPWoNU62Lb+u1RnK
	+5O7KPtQhWycFaJwBaG2Vp/Z73v/kRYzcU9CVc7LO9E60ovlFg0UtrSUb7jc+PY7Z9DKo5qrzqI
	mGhxJD21LYhBdWo7sjTddW2yE0Z5I=
X-Google-Smtp-Source: AGHT+IHdMtkvx9XYn2stsP1r99hCl+avhw+6yiudf5JiK5OzdCsm94la/NUjRVv/gqgOBkzCJL/sZCkOsTaSbl8YhNs=
X-Received: by 2002:a05:6402:2383:b0:5dc:9589:9f64 with SMTP id
 4fb4d7f45d1cf-5de450036dcmr40005032a12.13.1739209895832; Mon, 10 Feb 2025
 09:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de> <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de> <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
 <ba65ce17-8768-4d60-aec6-badd12930b81@gmail.com> <CABPp-BGwZ029Y8Kfr2kkGiUDZ613kxS81JXzk36V85=77KcYfA@mail.gmail.com>
 <20250208232651.GJ30202@raven.inka.de> <CABPp-BEzOWVa5zqOMuUSH5xCJ+CUk6sJnLhE5OdnDiNR0U9jfA@mail.gmail.com>
 <20250209085756.GL30202@raven.inka.de>
In-Reply-To: <20250209085756.GL30202@raven.inka.de>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 10 Feb 2025 12:51:23 -0500
X-Gm-Features: AWEUYZkUWjSqcAwA0vcuF85eYe6mysOEKPGGwpxteh-QRNDr-nqgeMHo5S22C68
Message-ID: <CALnO6CBh0UDSeR4Q1VfU7vdSvHFYuO=j_rijVpAE-YH9V=Cqew@mail.gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 9, 2025 at 3:58=E2=80=AFAM Josef Wolf <jw@raven.inka.de> wrote:
>
> On Sat, Feb 08, 2025 at 11:21:12PM -0800, Elijah Newren wrote:
> > Yes, I was surprised Phillip's command with --attr-source on the
> > outer-level git invocation worked until I discovered that the code
> > indeed sets the environment variable (which subprocesses, like those
> > created by the --exec/-x switch, will inherit).  So, yes, the -x
> > switch stuff seems to inherit that environment variable that the
> > primary call sets in response to that parameter.
>
> Umm... OK... This means that specifying --attr-source to the commands for=
 the
> -x switch is wrong, since they have a different HEAD?

Not quite: the command actually did

> git --attr-source=3D$(git rev-parse HEAD) [=E2=80=A6]

So the subprocesses will see the attributes source as a full-length
commit hash, not "HEAD"

--=20
D. Ben Knoble
