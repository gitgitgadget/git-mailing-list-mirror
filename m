Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668E265607
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340307; cv=none; b=LomXLIc25mAM9qR0a4CSZ5qU1Wz6dfY84Eq+BHSFWL0E9o8YdBL0x+qjMloYG1736vCoj1XNtw+YyxL+R5kM6QtmXWVmgHnqL2ocSMjPyyY+xe0IhGinoFX9d0qFH+bc/F0Jh0X9enTRL30w64/d0zpp4gByPLBOkRrjMyWMScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340307; c=relaxed/simple;
	bh=tMGbiJjLw6zE4df9oif5N49UsZPL6pQd2YbnyMSGp3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcrUBBJe269YabGb5jCckiZd1DCCd8TuPuAlpRQCqL/ql/QywcgF8ooAmMhIgtTnZhqNQyG+gcMwukb1/dTfo5aFzyuY/6MQ+bR42x+rb60SSfULo1oqpzPtOd46m5iLZ+ctc3vMNFQay5Q/xt3i+qpoeSmM37B18K4z4e5917U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsIiAS/8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsIiAS/8"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad8a8da2376so123069866b.3
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 06:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750340304; x=1750945104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKudSSnT5MJgefPFcwhg53ZhopRx6/to26xDQTmmkdQ=;
        b=UsIiAS/8RH+QE/T8MVM8iWxTdRwJVKK1wdT/6d2bzQAONTGgi7NY2uL3O8n7uW+h3U
         1CGO3SIu2SDTDXFlInALI3pCNYIsoVO5aQf6GgkiQ5kcIUuu8Sknam1N2xdD+hy4eGEL
         UIC0TpBtbfDDdqrRRku4u06KzwYplLPPZPcDcaZ5YVZDr1Jb8/gXW/ppoRwxbFcv7KJz
         hqnP1t66uHlb2xlxiB3x5jA9Pr5Kv4eHGWBistwpGwYZ2iVPcDcfx64av7Fc52KG6NHy
         6klCDQU5kOOyyQ4QJjpqV9/E104WR28sC+Oay/LhFDWrNagKm6WxsA8pvIfLOaLXVXFf
         o+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750340304; x=1750945104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKudSSnT5MJgefPFcwhg53ZhopRx6/to26xDQTmmkdQ=;
        b=TgPpc2+QCJO9HGc5yYMaG50bGAUCzOYZU3q5MhIq3EsX5jKsvAvjKQKwxj7la+IAZc
         XSoddzbJUgsUEw9isPTk4NcVDLrJQeQELp04bjbHgQgXC90qQO24T9CXn7Yaq5TLjMsm
         5zFX2/oOt3uMG2YXtuyN4Vc0Z8s6riE4Uy20s7dp+VxNk2iqGnCdkOdkfHpJgxM/JpUz
         9XFc6qMUb6M6qVuShviDFJMNZ9S7j9VW4LVTBg8qzDzHesTy54rXAX4dZ5ivtq/ZIO5Y
         ydVIcDRYoS1iuOUT1rniEOUdf0IqRkRFlMOCXMU4y+ulxr1Yp+Tp//+xEhR0/l0kFcro
         +MqQ==
X-Gm-Message-State: AOJu0YyPL38XlkFruqYot1RCwYDDcEcAJK6WnnE/kHk/PsTULY9m7h7k
	51hFY3fXgGn3Jk7VuOwkIqsxMJta9lAzSRYrBs5hcs53S4dA/oIfWtfB0EF9rbA9OZXGQfVPh4L
	4HGFRWAjuTqzxNkGlnd30D9xkrOk0WdE=
X-Gm-Gg: ASbGncvDGEZzaDs7PyHIsaCgsh/SSEnIZTBczftgR7lFVNnl05Xo68twJF/ABFSxBCV
	uixmOF2OBKSicwfFBbZkMLdbw5poK0jiCoGMblhQ1q1NPhzq+eOGJnVZxKOmzbRNXyRtnmOPvTu
	XrMiGh77GAqfFir9DmBhQbR3iARCz1by1wqf86VWL98a27pQ==
X-Google-Smtp-Source: AGHT+IEW+qdeE/XKCo2LXX//KIRFO88n+ZYkmdr71q642ppwF6A5stO1pIibMJ8I6K6ETJ15IVo5JuU3wKR8Q3hWA30=
X-Received: by 2002:a17:906:4fca:b0:ade:3b84:8ef6 with SMTP id
 a640c23a62f3a-adfad3748b2mr2069327566b.23.1750340304120; Thu, 19 Jun 2025
 06:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424203904.909777-1-christian.couder@gmail.com>
 <20250526103314.1542316-1-christian.couder@gmail.com> <CABPp-BFbF=rp6FZjyL+Fm5TqNZZdhfjS1sK-CBQ_=wtvFmfdLw@mail.gmail.com>
In-Reply-To: <CABPp-BFbF=rp6FZjyL+Fm5TqNZZdhfjS1sK-CBQ_=wtvFmfdLw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 19 Jun 2025 15:38:12 +0200
X-Gm-Features: Ac12FXyB3qsjwAOkbhUAfvc0br4BLws-fmzyNIRYcois74wtdKQpwEoAz_JkJag
Message-ID: <CAP8UFD2zO0Apy5jOrbFdBjq2F73mo3dbESaBqYCG2hsKBamFPg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] extract algo information from signatures
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 6:03=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Mon, May 26, 2025 at 3:33=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:

> I'd like to propose that the following are the possible uses that
> users might have regarding commit signatures with
> fast-export/fast-import (if anyone has additional usecases, let me
> know):
>
> (A) Make fast-export include signatures, and make fast-import include
> them unconditionally (even if invalid)
> (B) Similar to (A), but make *fast-import* check them and either error
> out or drop them if they become invalid
> (C) Simliar to (B), but make *fast-import* re-sign the commit if they
> become invalid
> (D) Similar to (A), but make *fast-import* re-sign the commit even if
> the signature would have been valid
>
> Note that in the above, there might be additional processing between
> when fast-export runs and when fast-import does (e.g. by filter-repo
> or a similar tool, or even the user editing by hand).

I agree that they are likely to be the most important use cases, and I
am fine with working on these use cases.

> > To address this, I decided to focus first on extracting the hash
> > algorithm from OpenPGP/X.509 signatures and the key type from SSH
> > signature when checking signatures.
> >
> > To test that, I thought that it could be interesting to add a
> > `--summary` option to `verify-commit` that shows a concise, one-line
> > summary of the signature verification to standard output in the
> > `STATUS FORMAT ALGORITHM` format, where:
> >
> > * STATUS is the result character (e.g., G, B, E, U, N, ...), similar
> >   as what the "%G?" pretty format specifier shows,
> >
> > * FORMAT is the signature format (`openpgp`, `x509`, or `ssh`),
> >
> > * ALGORITHM is the hash algorithm used for GPG/GPGSM signatures
> >   (e.g. `sha1`, `sha256`, ...), or the key type for SSH signatures
> >   (`RSA`, `ECDSA`, `ED25519`, ...).
>
> This sounds like it might be a nice feature extension to the
> verify-commit builtin.  I don't see how it helps implement signature
> handling in fast-export/fast-import, though.

Fair enough. In the v3 and v4, I changed the approach and dropped all of th=
is.

> > If we can agree on a concise format output for signature checks, then
> > maybe this format will be a good format to be used in the `git
> > fast-export` output for users who are fine with signatures being
> > checked.
> >
> > What do you think?
>
> Maybe I'm missing something, but it seems to me that checking
> signatures *in fast-export* would be a complete waste of time.  For
> usecases (A) & (D), checking signatures at all is a waste of time.
> For usecases (B) & (C), checking signatures in fast-export is
> throwaway work because whether or not the signatures are valid at the
> time fast-export runs, and even in the rare usecase where there is no
> additional processing between fast-export and fast-import (such as by
> filter-repo), the signatures would still need to be re-checked by
> fast-import anyway.  (Note that a simple `git fast-export ... | git
> fast-import` is *not* guaranteed to get the same commit hashes even
> when there are no commit signatures; that only happens when the
> history is sufficiently canonical).

Yeah, right. In v3 and v4, I dropped this in favor of something
simpler similar to what was in the v1 patch, and after that I plan to
work on checking signatures in fast-import soon. Thanks.
