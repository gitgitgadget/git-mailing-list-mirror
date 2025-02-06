Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268E01F1537
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738829233; cv=none; b=sPkZPGT+5Tt2TiFilPttqX0X8vN4tF5wLfkqMMBXhUN5lj1JXLdLQ5/bWoHAvyYZctN3ZL3b/EpH5QrtYWPhGPmEbGqiySbwfj6zlq0uiA+GF5u09ta1re6bha/LZ4e/EVc2SGhrgztWFV2vCXrCr2BcagO2HVKyqoi7xjQNftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738829233; c=relaxed/simple;
	bh=Y8r3wni4iiqDwKrBj1UjOkqSTZ8LY9PLqk+qQ+JltNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=L8isKOqMtg+Kf0aX6jZocqfARVj6OJUv/PKCZMkuwhbsALq9tNfYJQObDEiWkvvelYYe+K81Tvq+Z5r8mGudm+fwL3o8YkjNBG6Qdfn7zl04FQZXUXmsZfUvAyIhpTrPCV/BsV7lXorO3eR9qrtygSGYO/P2d11DfBQjjd4h2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrqTMaTm; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrqTMaTm"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-854a68f5afcso16765039f.0
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 00:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738829231; x=1739434031; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAgrREB73a+qEOVEEsU5SCUxEWq0vAEna75+JFYedHg=;
        b=MrqTMaTmbuEDzQ1XNy+Spq5MTz9ZbveCQzSD98s/nQ9iaj3QUWWHxjSs2d2R6Ax4Ws
         YlfZF8YRWis4ctkIZ/Y6kWqf15InSdI/TUsWEsuQ94lIjOrhIUTNXh6k0359HLTAwtkY
         EvwTVSXHU6yQ+155FAcX2fLaGqT2bK46vdX8vBKa621pvCuHeerxA6WQEH4abN6pXe5c
         ZDh3puyAxS4U2EcATdJo7wuBf3aL1OJrwotanvN0hVq4eZOjmM088XHHtegokDJCUkaU
         5Wt0vGM2YlN/Wo7Hzju5rdxqmis+eHBLBNKWEuV057eOK0msK8kq7buaHLqMwbACnBFT
         F7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738829231; x=1739434031;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAgrREB73a+qEOVEEsU5SCUxEWq0vAEna75+JFYedHg=;
        b=dO6pPStKctNpsZQGNdb4hu2TMr2qMVPcWVHgsywtrI70J8OLX0hWaOKwZbteV4DVJt
         JYRgcu+Q+S2uyt5/5F/4W3hK3wF1t8Ga4PvTLHZIP1RFcQn3qSqqqKL3opNqdor7MW4c
         ssnjKmAI5Rd1VBss1Yx/E5tcknyFVttvguouImUz/KbQCOu68+J2FIILDL/wl3bIOG2n
         3ZbgZmxwWJNV0mTlIjQN7WFqLAf9vZqgKgYKqA8eGDGPC6RpFiQ3V3ZAduZB+cZx2TMa
         Bl1Osg5pG4VD+rqdsU/pUZ9hVi1vgK5eDuac6haNOvEPqvurQ7EeZu3os/hw1k9TGaHI
         qQpA==
X-Forwarded-Encrypted: i=1; AJvYcCVPx65Bj1kMxAvfFI9gPsfNCbaPMcoi5pOH4MNEr774TItmR+Z47otJ224BtAlueXJ1sxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2YXktroQpd4N167PQJHe5cX7Z/Vv8koH1eAFIZHC5w5MF4jL
	9zYdRPT8ZQBMCYtjQAcTQLMtV1uYFTePEXaVX+0/+6TTzMAU25Mt5iDND7iKjYCKMexsD95We40
	ulJRE1Kk+ppDmHH3HLvuDzt4zIjU=
X-Gm-Gg: ASbGncvsCWIxuuPe6P67PSW5SHeFtJ7fEaM+dhM46UjUJ9HRmtysnyqR2tIWGXO1pSB
	2grawS0+yVEO13HhCGKdonLWO1Ql3wzHk/UqxXnedfD7Pbgy8xekizLCGBTSYU/VCi1vhY08xEX
	q2omVviu2Rlew=
X-Google-Smtp-Source: AGHT+IF3iy60O6EK7B602Q7jXVmblyaL3bYpTHj+DkzDw26SXGHFdRAMC+DpixHRcbqm0thPrboOckR3VhL+76Km1c4=
X-Received: by 2002:a05:6602:4192:b0:844:cbd0:66ca with SMTP id
 ca18e2360f4ac-854ea411c82mr614542339f.1.1738829231212; Thu, 06 Feb 2025
 00:07:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205214726.GA30202@raven.inka.de> <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de> <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
In-Reply-To: <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Feb 2025 00:07:00 -0800
X-Gm-Features: AWEUYZnNWbGkYFmLoQrjv8Gc3p0a6CejvXIZlJij04zS0MaILflw3z3q4UWBFXU
Message-ID: <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 4:29=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-02-05 at 23:59:31, Josef Wolf wrote:
> > > > BTW: It does not make any difference whether I add "-c merge.renorm=
alze=3Dtrue"
> > >
> > > That option also does not exist.
> >
> > Well, this is described in git(1) manpage:
> >
> >    [ ... ]
> >    SYNOPSIS
> >        git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<val=
ue>]
> >    [ ... ]                                            ^^^^^^^^^^^^^^^^^=
^^
> >
>
> The -c option does exist, and apparently the merge.renormalize option
> does as well, so I apologize.  It looks like it's only used in
> merge-recursive and not merge-ort.c, so I'm not sure if it's still
> effective.  Elijah would know for certain, since he's the author of
> merge-ort as well.

init_*merge_options() are defined in merge-recursive.c, and these call
merge_recursive_config() which is also in merge-recursive.c, but the
parsed options are shared between the two backends; you'll note that
merge-ort.h includes merge-recursive.h to get all these.  And
merge-ort does have the necessary code to use and understand the
merge.renormalize option.  (Of course, the fact that renormalization
*requires* an index made it a bit nasty, because merge-ort was written
to avoid the index as a data structure, so I had to do some ugly
shenanigans in order to support that option --
https://lore.kernel.org/git/CABPp-BE1TvFJ1eOa8Ci5JTMET+dzZh3m3NxppqqWPyEp1U=
eAVg@mail.gmail.com/.
But that's beside the point here.)
