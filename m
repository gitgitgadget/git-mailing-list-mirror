Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED937235057
	for <git@vger.kernel.org>; Wed, 21 May 2025 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809247; cv=none; b=Jyq5D+XAcV/b5XTusqfd6mRIrqW4NVuWB1hJbrULC/BIzrGDmdS8MxTbv/Ef+bYTTsXAZLuGlsKiOlaPnzmNPfC4+X3moi9yeWrI/ZC9pEr9t5PcCcvMZliuAs5ZRMx6DXvK3Pnv7A1zguj00P+UkLUg4suiYX/JP1u9HkyWfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809247; c=relaxed/simple;
	bh=S+H7r2E0gV77habZLlXc6/8NJB5QII66rXGNgFtN7PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzyB2q3kcq6PkNZGKIr6f2g6tTJL57dgK4rp6AQwNwSKz7nKqfhJAuQCF1ByL3uuzgBLpAQ660lyas+BIfYmnkGqokdCo7lG72JkGEGZfxtKXV0bEUbo/obN/3SiixT6ENbAhtVG6PFvezFV+cZ4fXf+JEmKwA8tiGmoUGj7rYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNGkpijT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNGkpijT"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad564b7aea9so622494466b.1
        for <git@vger.kernel.org>; Tue, 20 May 2025 23:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747809244; x=1748414044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN0225G/5N1uTkoAJu7qKTW+jo7H05Z9m8Vvj6uW3L8=;
        b=CNGkpijTc302fMCiRqHdE/JVT1L1vfirOxEMnrLk610amyRutc69gNPD2d0J/TeSAD
         WoFIXEIVfm7a3aansG2RDJpwz38GuZ3C2bEH11p+eweTqky/yfGDKUK4c7uwalYYohG9
         hrHc9Ikbr4+ak+TDMGNAthgB87q2DdHHWZEpzf6XDw/aberf4Jja5mr2bz4DcgvejjiY
         hz/DdalUWxdRTbeqlXm4RZSjtvrQYSw7bI0elwTHC4ApOb6f9iDodagMH768i6kmK7P6
         Uq7hcZdBeIgqmnUSBZrNUJ4nAEpGeFPRJQqqDGnix0OT5BaTqcYT4qrrCgAxQwSl4DGE
         RKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747809244; x=1748414044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fN0225G/5N1uTkoAJu7qKTW+jo7H05Z9m8Vvj6uW3L8=;
        b=pU+WNyC9xo2atptNGIt4aNuXZX78ld/pEtL+t+VleN+YPnP5zIiGWs1/6cMBNN+MyA
         yPXUbFDbRkNtpS8Ltl4LtulHWXW5t0+DaGQplfRYnfmig36prQEjUGCGxhXMYq0OejvX
         fd+YZ+y6WOhORZqa25qAR4GktiKcsKGKTdc/gethcbIbypQdjKis+JjT7StJjSrgvdPi
         yD84y4ZGCrl+G5bdTVi0V7+6VIUkD2Z/x/PaOrkmE7V8PrHTdbjJjphKq/J+J9xk7zTi
         ml8FGyf8LAG7DjDXEyI4OBI2VMsnBo5Eht2b7wiVVji5/9ovCGk3XDmohp316eA2EVmk
         Rwuw==
X-Forwarded-Encrypted: i=1; AJvYcCWvTL5pFFCpzlUGrq6mGDHAPV5NIlnqs9u7VUAvd/mQpk0z3IBxH8dl6diedaHv/XtSPLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYB3KsG1dqzg7I2m/cwWK+C/vVwQxgrip75rd5zwdXkXYGG9Rx
	86iVpnWyosn0NN/EMrlWO5LMjE1rez92bpjCbUn/kj+/4EWB4lSfXnejGedg9ldTDQDHfmb//Kq
	8ZGwrSK405aJbZaT1FzcC0UKkLQZtnKAYgLtu
X-Gm-Gg: ASbGncsuJLyIMNnnjqWJ5XY+M4M8UqjH220cA4Q2/WcH01EUmjE7Hsq0NWLprSQVA+z
	xa7N+091dViHlkdOVe2aqpLOZxh01pIKw15CtBqfs6UVuyKU9rDETkWtjCOr25lIjTgMrFbLoPl
	oWagHpICHk2rUpD9bkT+liunQ3nG5Twt8iYPU=
X-Google-Smtp-Source: AGHT+IEJAX+vrJQA2DtzIUYrqSHWpABrkVHKzKVbQw5aN2wrFpSjD1xXeIB/7WW01CiahCdzvRJmeA+vAFMlZod+FR0=
X-Received: by 2002:a17:907:7ea5:b0:ad5:61d1:d8ac with SMTP id
 a640c23a62f3a-ad561d1db3amr1294613666b.6.1747809243923; Tue, 20 May 2025
 23:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429145243.992252-1-christian.couder@gmail.com>
 <20250519141259.3061550-1-christian.couder@gmail.com> <20250519141259.3061550-2-christian.couder@gmail.com>
 <CAOLa=ZRnL_PLVpQrmHPMXtJd9e965B5iz8widkk5GNSDvh21Pg@mail.gmail.com>
 <CAP8UFD2XtyPD7b=sE+t9d-kyXDt4hYMqVotwz7hJZEO+5TfXGg@mail.gmail.com> <xmqqr00ji63l.fsf@gitster.g>
In-Reply-To: <xmqqr00ji63l.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 21 May 2025 08:33:52 +0200
X-Gm-Features: AX0GCFt8YR_j2gIP0ale0kupb8-txnydSkwrU3ZjFukSOEePAzmVY9LTHv9sCMQ
Message-ID: <CAP8UFD25fF6OdYmP54JFyY4Znpij=MR1ifdWk+cjca5Hes739A@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] promisor-remote: refactor to get rid of 'struct strvec'
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 6:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > Junio suggested this name in a discussion of a previous patch series:
> >
> > https://lore.kernel.org/git/xmqqa5bbq0nb.fsf@gitster.g/
>
> Don't blame me for that name ;-)
>
> The name was for a hypothetical variant that took "struct strvec *"
> as its first parameter, and the name was given only because it did
> not make much sense to call the helper after "strvec".  A function
> name that signals that we are finding (something) using "nick"-name
> was a much better choice.  Since your final one finds in "struct
> promisor_info *", not a generic "struct strvec *", I wouldn't be
> surprised if a name that is about promisor-info (whatever it is)
> more clearly describes what it does.  If this is a file-local
> helper, promisor_info_find() or find_promisor_info() may be
> sufficient, if "by nickname" is the primary and only way for the
> application to find an instance of promisor_info.

OK, I think I will use promisor_info_find() or
promisor_info_find_by_name() in the next reroll, as it goes well with
how other functions related to "struct promisor_info *" are named.

> Is promisor_info primarily be found by their names before its other
> members are accessed?

No, there are different ways the promisor_info instances are iterated
on or searched, see promisor_remote_info() and all_fields_match()
where we iterate on all the instances and then either use the instance
members to generate an advertisement string, or check if some of the
members match advertised values.

> If so, I wonder if a strmap or string_list
> that uses the nickname as the key with a pointer to a promisor_info
> structure as the data more appropriate than a hand-crafted linear
> linked list.

I don't think it would bring a lot of benefits. Using an strmap or a
sorted string list might make things faster if there are a lot of
promisor remotes configured on the clients, but I don't think we are
at a point where such an optimisation is worth it.
