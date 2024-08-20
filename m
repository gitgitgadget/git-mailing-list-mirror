Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3B18E054
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153410; cv=none; b=X95/Qalqj44Y50fLo408NtYJqlE2qAkv8gefX2PYMMUtE5eRfgEl/a1da6NorDJ+WCKmpx38pEKgaDJkptOOI7/W47ReMHkgzinI6LAWIYoWbd6bUzLGSkTIgBLBTRhf7oi3g2cW99j9Rpp1/clUZalXshLBk4N2ugPuBjXN2EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153410; c=relaxed/simple;
	bh=+LRQ9U6zN2cX8CQBfOAsKdUuqGfSp+STATaJLQAW+hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSls2jbHPKUobNBnSdoQllinCYv7NWGtjptjfEEnQiDSIZ9wG4K/fvdDiQbyMS3Fy6Pne9MtQX/X9T5B/Xk001My3xJhYFpp5qORmGGHRrROU3a/GfoDWHyETz76BoTNqBXckpVCnuQlhM6GPggYLhKFXyHhOp97oJHqXXX9PiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjuymb6k; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjuymb6k"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so741256066b.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2024 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724153407; x=1724758207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LRQ9U6zN2cX8CQBfOAsKdUuqGfSp+STATaJLQAW+hk=;
        b=gjuymb6k6TyEdEFmvZ8zLrm8M17Cy2IoAByIPqRyjZRsaJeppHzB0kHgUylI7dGIYT
         oVhq1L/QrPJ89pqTf+54AbopKctjS4osUlO2znuXY+SiHFxuEsZ3ifije7zzom9M+Ol9
         yv5jnLFPytZla8DS2SG3Rv849meZZrHm9BB8LCm7Gk4EOtrTWYlmnvhvOmLqtB3YrkWT
         Lh0ri3v8v2xGBhHOuINGeLukwzFF1X9JB5Se0+yoIWkv874/A8z5KJjZWAMZtr8XRF7d
         Bc3tsnw8XwaGrI0RnMX0tEvqoFU/uEHlSonOsfanVr9+bRcAiOz1N/QS9SNEDhUjRH/6
         /jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724153407; x=1724758207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LRQ9U6zN2cX8CQBfOAsKdUuqGfSp+STATaJLQAW+hk=;
        b=m85LmGPJ6VCU4dkChUplQXNsmC5U6es6iZBJMF57nmLXz6DAvwkS8b2Lr/eDkRnsvE
         lSppP2Y8VXkNrUZtmWeD4AXSR/XYcSwVSGc5m76Hc7sdNfGDikPu5Y3kUq06+Xss9RaA
         KG3h418tFtvv//9I3RGi/Wj+5YJCAyD0zNmfQPnkog5fMueYEqSFg06ALTrLQ5Y3FKxG
         Gl7vpABBFjWroEbRr2Y3J/9BjfovwavDnHHS6AVaDZfzPDL76OzqBXNJ+6qW1ocAbdKe
         AuZTqS5LB/ntAa8366F6R4ZNkNPtGE5NQZxnrAD+gB6YP8qzTBtF+Dy43XDHtUD1LUAH
         /0aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLQfNYJD8GoMNO9Q//dYKK4YNAXE8uN77adHoRadTBwAp/wT8v+m85c620x5WPaVXG+2UV7V0yf4KHHZ257my8vlZB
X-Gm-Message-State: AOJu0YxTUpIUzAxSuWQ1wpC7LHqNio5EJjyCWaEqIHUWkXAeHKhH9yi3
	s+CHGM8gej80rCam+SRgRgN1WCzHKUleU6gzinQQlHNgeYitQlVEeWVt/I80YnhkfMWacNByVBl
	Sru1TZrHAuBCbsBS7G+G4qSZfg4U=
X-Google-Smtp-Source: AGHT+IE8+B2RlLMHM7oiQLuTUpQ/waw5HymGMlODr6fNmsZBBky82vekHn5aX9EwEUNsAgOsw3n/m8NcCTYqFPftdPM=
X-Received: by 2002:a17:906:6a07:b0:a7a:a212:be48 with SMTP id
 a640c23a62f3a-a8392a47114mr1020975366b.56.1724153406645; Tue, 20 Aug 2024
 04:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240731134014.2299361-3-christian.couder@gmail.com> <xmqqle1h5v37.fsf@gitster.g>
 <Zqqxe5p79kt9yc2n@nand.local>
In-Reply-To: <Zqqxe5p79kt9yc2n@nand.local>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 20 Aug 2024 13:29:54 +0200
Message-ID: <CAP8UFD1TeOv4wp0khWTNALDQLS8+iV=9Bxsujaws=Wc0+JyApw@mail.gmail.com>
Subject: Re: [PATCH 2/4] strbuf: refactor strbuf_trim_trailing_ch()
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:49=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> On Wed, Jul 31, 2024 at 10:29:00AM -0700, Junio C Hamano wrote:
> > > Let's introduce a new strbuf_trim_trailing_ch() function that can be
> > > used to remove any trailing character, and let's refactor existing co=
de
> > > that manually removed trailing characters using this new function.
> >
> > It is disappointing that this new one is not adequate to rewrite any
> > of the existing strbuf_trim* functions in terms of it, but that's
> > probably OK.
>
> I don't think it's possible without some awkwardness. strbuf_[lr]trim()
> both trim characters for which isspace(c) is true, and this new function
> only trims a single character (also from the right-hand side of the
> string, so strbuf_ltrim() would not be a candidate[^1]).
>
> Likewise for strbuf_trim_trailing_dir_sep(), which uses the
> platform-dependent is_dir_sep(). strbuf_trim_trailing_newline() is also
> complicated because it only removes '\n' or '\r\n' from the end of a
> buffer, but not a lone '\r' character.

Yeah, I agree with that analysis.
