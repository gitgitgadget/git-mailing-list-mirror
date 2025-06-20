Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90623183B
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750406181; cv=none; b=SmGbuNDYpNCEFe9bOlN7vIOyJQPVhPISJLV4+brGca9OfktaoLkSnr07ehvub7uC9n7vm+FE6+UnxP2ZSFbNDZ3NFQqxN+7q6GpGKolqrUNTcY5NHrxf6U5VQ1/lAbyH9Jls97mM6xTPrEQvsd6Z4SDY0U3+mkqwizCbK2hZjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750406181; c=relaxed/simple;
	bh=eXprBtFkKGhdQDZOAUbnYntqf6CENlGZKwrBPLa2zuQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFHUeE75CDDhquWcr/IA+JS7ABA9XT+3CEO9lAPMVrCmH3Bx7DShLvtx+xbQQEsvlDkgoXqybc12Pv92BBmdF2nHegNBn1gCbACbFb6diUXJRmemgridM3PqjjEqGFgSuegsKdthrpWLgSGykKScaJYYf09cmZscOfy8zOy3HAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLt+oVRj; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLt+oVRj"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4e9c6b44477so236778137.3
        for <git@vger.kernel.org>; Fri, 20 Jun 2025 00:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750406178; x=1751010978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eXprBtFkKGhdQDZOAUbnYntqf6CENlGZKwrBPLa2zuQ=;
        b=aLt+oVRjNSMxG2TalQfik/aMyGHzOMUeudo+B/I27nDf+Kt4+ndhyS3lACajukQbyl
         A7RWYw7spz2QG2dY3wvpSVXniruEhpLHjtE4EuAuo0bC08X/RoiRUjAuw8c1zjWu6KJA
         1hErgEQR0jqV7xjeWbu/Tq/mgsP2kwP/I0FZVP8DRVu6ej5NdcF5+qei7LrJLXNOrsYY
         zkDtlOhci0MZzub5Cta7LOT8m3ZBzbuqWBrqRf19JL4bbIInUFKJWorYsruM4h6mMO/h
         Xa4qJ4z2cUUpgUcV5K6enTlRTEcZk99edOHSVZqRMAhrzmxzrridhgdltpboNgC/g1jo
         +/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750406178; x=1751010978;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXprBtFkKGhdQDZOAUbnYntqf6CENlGZKwrBPLa2zuQ=;
        b=dj1niG3adqr34Sawq46tiWH+cGHoELqXHGckplqDaR9TW1Ljf14lLIZ74Y6fNgukEj
         5Krk+brqGKm25KwwtDlFZaTLPTSqlBoAAXHCQi00A3GdW2BMWiuAz9ED7pWMIB4i/WmX
         hLuj2z1iAPah/wJM2riogQ7E8XzOP9CKxxhcyWY0/xCMPxHFzggIINZ5bnhBOnZ9EGgw
         DDKxe6IJoFrNFnoQPaVXbmHtydjV6PHrfJp1sPic/b3RznrqmAwhSdoOwAWEVT5Blxk4
         v5iE8J9cvnU6urVNrwRuV6aizM2+xWpbT/tRpqN4+c7/MYYMFlDVBESz4gr88oz+ymbf
         lAmA==
X-Forwarded-Encrypted: i=1; AJvYcCWaH/bM9M/0M8mE/evfkBc/ieH4fO7HO4EolXmn+MlryXfiuB/Grk3k1gB5a2t7UC8dwZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAXLkFglP/egHoKarzmdstON6Ah7Zf3o0IDho5K6xaK/qinUPJ
	QrQz/jPkfYQWagGks5CTTIvt4sFGp4RzUHBeo9RfwSsTR4C4OmI22Y43RueiPaYzrEsd5BXGl44
	nifKdUjcC6mVSFJEJufdtMz67Y4mM4PE=
X-Gm-Gg: ASbGncvwi1ERMyoTfm9i2kNFClvPdevuDWABUt4ubeLXS/thWb/TW+uyOpjmMqNQO0n
	u/Rndd2tTlMm7DfNIoXbmGSPYKFwFEzMGQcWwePXIGy90ko49+F5qXLKCGntEx3HanIUz0x/e79
	RHYV3Hlg6aZByFaWRlnEyXtbOhCwqrUOObfqPLj6QT
X-Google-Smtp-Source: AGHT+IFZLR3tclEb7NgcJi6E91hZ3G/di42sR62yfJmRXkIhqCG2Qxa225fsirwOjqjmxf8fOiGuja2BP0lut8Z5Bao=
X-Received: by 2002:a05:6102:510b:b0:4e9:c652:6a1e with SMTP id
 ada2fe7eead31-4e9c6527961mr540233137.3.1750406178378; Fri, 20 Jun 2025
 00:56:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Jun 2025 00:56:17 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250619225751.99699-2-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com> <20250619225751.99699-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Jun 2025 00:56:17 -0700
X-Gm-Features: Ac12FXwgGU_H-q0mGV19r1ghdxYFnpyvWVbGWo59BuLOv4M9IPe_suolWI80p3o
Message-ID: <CAOLa=ZSsY-B2kxfuiuuE7drO-HueTwTvNCBQANkZP-4KxZbJ=g@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH v2 1/7] repo-info: declare the repo-info command
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, ben.knoble@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000079b2ad0637fc3256"

--00000000000079b2ad0637fc3256
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Create a new Git subcommand called repo-info. `git repo-info` will query
> metadata from the current repository and outputs it as JSON or plaintext.
>
> Also add entries for this new command in:
>
> - the build files (Makefile and meson.build)
> - builtin.h
> - git.c
> - .gitignore
>
> In option parsing, use PARSE_OPT_KEEP_UNKNOWN_OPT to allow the users
> specify after the flags the information that they want to retrieve.
>

Something I would really recommend in all the commits is to be a lot
more descriptive about _why_ are we even making these changes.

In this case, it would be great to mention about 'git-rev-parse(1)' and
the motivation of adding this new command. That would provide some much
needed context about why we are even adding this new command. Also worth
mentioning is why we plan to output in JSON or plaintext.

- Karthik

--00000000000079b2ad0637fc3256
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 884a92f681111666_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oVkZDQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWlqQy85akJNL3ZCbWpGWHRtSXlHd3NIc25Eb21PUwoydHo3TlFUVkh5
UDROREFDaXYrWXFWdE15TGhLMW1BRit5Rm9yeStuei9odEI3VDJtYlhFS0Fiek13eGZFNHYrCkt4
WFMyK0hLMjhXUlBuVXdUTHFqNHQvWE85bEdJY2xxU0ZWeVRVWlpIQkl1eldheTMyY1lCdnJwV2hi
NzYxUXYKMGRnNWlxbEszejI4V0xMTnozcHdHNi9OY28yQ1JqbVE3TEh1bnNPazhUSlN6ZUVSbVdL
RjlWbU9IMzJDMytzYwpqQ1NFbFhvN1F0UWRjYkVIZjlicENjQnFocm9Xc1dMZkFjcThqSVVTUWdv
TFdLQi92TWZkRkxYNGhQUFd3OTYyClloU3dKMWNPZnVsYlFJRnR2d0drTm5GdFUrOTJwcVRJY0Zr
dzdvNEI4eGJKd1N0RC9aZ2RMUWwyZFNOeG0yalUKTG81eE9PRlBMUm5OblRqL2Nqd2FZTlJDbEQx
bzBGUVFyWmVtVFNPQWdnWmFoQmxuOE5Cc3h2Ujl6UVhGNjFLaQp5aTRwang5QjlyVkNMMkVPcklG
YzFDKzFCZ2FFSHcxK1FFb2VGYTM4RWhOQkVDYjZVY0ZHdStHeUhaVGtLWFpSCmxyL29aSWVoMll3
Ny9RbXBXejdRU2ZiZGo1WE1IQXFTejN1d2NiYz0KPTkwM2sKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000079b2ad0637fc3256--
