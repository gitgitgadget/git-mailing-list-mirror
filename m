Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233316EB76
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315031; cv=none; b=Bd2mwk6LF2163es3mNCGb/P7zuT1uqdospcONqHn0rFdrQvacbi4eiM2TZeqOaTyJwzgXzzlyQEdtfKXsSYKdQtL3rt0XykOBiNlMMZRSG2qAql6WNqDU/HTLu9TOY1S1p3QZt9k5f1tpMWL+7oC5utxZgv1GivJHXB+yDheQP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315031; c=relaxed/simple;
	bh=ey6lzr9ylTfLzJ6pzIekxQskNBCM+LO20CMWGbUEDF8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLnAlGCDAOiBSt+gTW87lqBcvhGKN0TkCpITBUCBxJQ8JGMr334Y2TtCy5fuNjb3S74RKjpmigmmvlOVTM7Mo2xU+Z4yYCUBd7jm4aeU2h92zWqDMY3TGvaCHF0059vxCLr8S386lbkNxLyN0135PPSClvw9Brxhne7jwffq0iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fodiOfeZ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fodiOfeZ"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5daa4f8f1c4so349197eaf.2
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 01:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724315029; x=1724919829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ey6lzr9ylTfLzJ6pzIekxQskNBCM+LO20CMWGbUEDF8=;
        b=fodiOfeZS0/mQyeIeodIK9S7z3D2eO8x8KBmCRLIQGX2mGkBJtm5A3TIkjg1A+o6Hp
         ayUh4+Bn0m2atJNQs0Cg+KbHEbnisQIN5IDSSL4HtY1uBtB9Xsg0mpagvX7/gOAsjwmH
         zHbzLenVGbuWl+UDpSXX0S75bgcfo5ygDjvrpdW188p5bGJ7pyJHBhKaQieWBmmOjjEC
         cwkwizyG+5RsQY59jTVaATE4aDAFm0CL/2m7GOiXfjxNtmlb8SQuiZdhhrneEjuyi12Q
         HKdDloPPkJfiWqFPC+UFKj9roaNH29wtRO0UNxwd5kOWBdDskjyhxtkRpVxvCdefoV5R
         sEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315029; x=1724919829;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ey6lzr9ylTfLzJ6pzIekxQskNBCM+LO20CMWGbUEDF8=;
        b=nUSNtqefvGOUiMtx0Oy148U/3BUaRBN2ljzf9TbDwEPhRgBxO5eM5+IC/Z84raab+a
         s1wW9VPJBNObeFqazP4Jy6he0j2SHJDD3k7SjBI8SUV45VPjt5pkaCL/rQq2+Ec4oeI/
         dturIPAG6VOLHLQZQ0XHyV/Cd01XLCPV7nPvthvXDMp3fsIu1c7HSgzYLth4kI138SQr
         H0kHm9p+pcEKfpHZIHdSbWGHet18QhfunM3RukgTJl7Sg9CgyS/Q5G8QpsigNPNS+WAK
         IbBDo+MKjKvaOz+T/4YnZ2uDBKFpXCk+/Se9XrkPDdHSnCFflgGaQSIVqx2eHZ/G9k/+
         4YkA==
X-Forwarded-Encrypted: i=1; AJvYcCWib8SJKugnjWY84z5H7dATqnHkDMJVWKvzFPz/DoGzwM14qP1e0LhueoUTVlkDJjf3EM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6uhW5EzeD7PddfUf+AI33wYyFMX3W2C9ddDWyn9Qiyho/6nOC
	30oavAQSHRcvgpesz/qMQanUen5wEZA/kjxpirD6cVEZmsERD1BmpskSoQLCVrHC/+Lh5F8qXsi
	vil0nQ8HGBj0qcwcNMG/+zfin0iE=
X-Google-Smtp-Source: AGHT+IHpwskSSC4jNK4u744g65pF/Sqn4b84y8VrY3mX8F2APfFcu/a6bjntKKkbx2ockOcXHYyrqTDKqqhcFY797Hw=
X-Received: by 2002:a05:6820:1c95:b0:5da:a26b:ce6e with SMTP id
 006d021491bc7-5dcb67f1272mr1508285eaf.3.1724315029044; Thu, 22 Aug 2024
 01:23:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Aug 2024 01:23:48 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <3c0cf2bf46f4106d7c0b30c863946262639b2351.1724080006.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im> <3c0cf2bf46f4106d7c0b30c863946262639b2351.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Aug 2024 01:23:48 -0700
Message-ID: <CAOLa=ZQNArqiSaaNHfp_jd1CRsX7-iV4iMyaxG+JUVA5gGj2VA@mail.gmail.com>
Subject: Re: [PATCH 02/10] reftable/stack: inline `stack_compact_range_stats()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000c9b26f06204160a2"

--000000000000c9b26f06204160a2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The only difference between `stack_compact_range_stats()` and
> `stack_compact_range()` is that the former updates stats on failure,
> whereas the latter doesn't. There are no callers anymore that do not
> want their stats updated though, making the indirection unnecessary.
>
> Inline the stat updates into `stack_compact_range()`.
>

This also ensures that we don't have users who end up using
`stack_compact_range()` because they didn't know about
`stack_compact_range_stats()`. Which was the case before, I think, I
remember one of the compaction function calling `stack_compact_range()`
directly. I see it is no longer the case though. Nice.

[snip]

--000000000000c9b26f06204160a2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e4bd34f7ce337595_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iRzlaSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mem5nQy93S28zRTNrOXVYWWxaSDRhVGI0cE5qZDlydQpaQ3g3T1dTVzNR
SlMyTkZ1dllhQWY4aDJpWFMyS2FVWWtLb3VmKzlzQW9nbitQY1daeWsrSFRHYjZ1Z291TTczCnpy
UFYrYitYYXllcXdldDJTekcvdnV1MXRGOHdLOVkrVjNzcXh3cXNtUnlWbjVWTGVPbDkzT0hoaS9T
RzhVMWUKcnF3ZWNKTlRrc2lRcG1XanIyM25uMWQ3TkFOcGVFS2xQTTlnTHBtU3d2T1BQVHZSZDRa
NXlERDkxbVdCU1JtRAppNktEcTg1RGNCZVdKSTJOMDcxcDRmVDMwUWZzVkRvMWRTRFZBTWp6Q0c5
WU1ZU2cweklPbE8xdi95Z3JqOXA1CkZhbU5xbHZJSkNISndHN3JEOWszeGQ1enFpYkcveGtVNDZI
TDFlTUZ2cUZjSzhwZEdMc3RCc3o4eW14S2hHbGMKanB0NXp6ZktqZllJRUhEWFMrZlVna2lqOFlV
T0Rxbnowcm5lRjJzSlF5YWFjQ3JDRFNsSEg4bXRVNmdrRWljRQp0NW9hRytOWHBMN1loeEtNQzB0
WTdmYXpIWHRBZ0k4cW1IVVgydEM2SmZTMUVlVFBkajg0aE12b2YrQ2ZCUlhaCllKSEtySGkyeWV4
alNxaFJuMVhyU3RsTUJDaXZQd29yRERvQWdQQT0KPWFlOWUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c9b26f06204160a2--
