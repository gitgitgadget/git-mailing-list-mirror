Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D7021D3CA
	for <git@vger.kernel.org>; Fri, 30 May 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616523; cv=none; b=nSWyegwRuNUBnA0nc36QsgNSTeIX7HnMkZCoKB/1PFzMURaLSz72Pz90Scy0LSfKmPTotcQ4O3Q+gOzRuxMzeJ5oiXr6Gsell0Z2aJoL24KNYCnKbODKwOcK/4tK7zFAZIDJGkDEo+x9Yqgb+qe/6wOH4oe4JjJla01SCsE4YsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616523; c=relaxed/simple;
	bh=K81B0Zh+YcpcwAkZS6b12As9zWZIQAUJ+CQ5NiR1rAU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=clmbj91pw8NVOHpAqUNEwtYAJjh3OQ+QNZ+f2HGMbfwGEmW7ig+RoxXQTfGVl5pT9V2QGxW6yWvP1iM3zLUY1e0aVExew/pzMJBdDBnsss4sB6Ns5ptioS103W3FlsmHrXRnigfOK7nIrs0SH8sVGzuTgi/jmxm9BPfO5cxM1n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjB90Bch; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjB90Bch"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c559b3eb0bso137133785a.1
        for <git@vger.kernel.org>; Fri, 30 May 2025 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748616520; x=1749221320; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wI+yjpYROFb+uPlCmXoZi+aPtnqEbaoUTrsTcovWXv4=;
        b=ZjB90BchzSqG3xJgj0JuglkJKWtIQ/x0Vv6I3Uk7hx0EFr7hWvzyB8i1IDi0D/OHpB
         og9c9Rhi/ANFJyUSMqtxRZH3YoQqSjFR3/vKCgW+adzAUWLfhFAQADyEywKHph2IGCvy
         CprUGPlof4VMRnRg+IJmsVgcwi4PckLP3dD+37+xaEw0S0mpSvSVX484aef37X3dLsYM
         QnKA/rY1wDva9UuDdXbqZWdv1di8DZsR3YUxmXSD19nTmZKx/lU5ZrqgnDH8Lvj0gHBE
         zxC+OWLLC2OktPk5GkXeeQsOf4/rwO/WNWf1if7GhDPkUYdklz4zs/1We2P43phErqDh
         9RqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748616520; x=1749221320;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wI+yjpYROFb+uPlCmXoZi+aPtnqEbaoUTrsTcovWXv4=;
        b=FHX/tgSH+VVDCkPnfO8tQcaIlVxI98sxdjgV9Ryl/H/2kgziRLQpj5EXKFToLibHRz
         oIotMdhwJkv/Km3elzgYsSbH9y54v3tLREoyPywJvmX1vbUx/4u8aUKJvv+SvlMPmQAb
         8LfdMpM3+YE+mtmJmFBC5ZJxsgqgizPmUE+FhEhJCeFdb5WgptPF6bIyIjbwYh+3mGMh
         ot+UTFRUDm9GKvnKoENtLe4B+XjlfxHg5b0JN1szmWOaTqXI2HHMHZnhN+hxUecaere8
         wa4V7i5jUcIRL74/BygkjNLt7P7yyjtrBmQkqrEMUTr7Pn9IV5QrTtE20W17Apt8yyB4
         DkOA==
X-Forwarded-Encrypted: i=1; AJvYcCUv56RIWdnz9ovc4rnH3dIMGoiXOkQeZqbZmpnO3FLGk2ChLrISwnUjMqFaA1En6befLMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPsneQcJS26WUZm5tT4ISAnOz8FNL5pVUDijbUXHkX8B7IVuTD
	AyY2HhXxoBiW/KrSmhkOWwGmeZKL2U1N1QotETFbpLsDkxz+TqQAqEda
X-Gm-Gg: ASbGncsr9TKUeF7e0F2SMSZaPc/D0lMBTQc3AFo53fqNHIAs0Y4j9BzopD35H0pFvqH
	SfFuq1oRXdmAwXmZNRAJqOTZSMPFCQ6vE0jAmRpEY/Da2E6ZRRGXUqAw2QQpltJKbFiywoTCxFm
	sPwaliNPWx0QNT5NjbQHklPQKRxTBvgCsfvOAz+HMAD4YvEnZCa+EW3ou+tl3gp9s5EEodMz7wr
	Z2Ol49pqVcXkefJ5p3S5OG69Ue0ueqZallX3w/lGQy8og9jc+NPq7hhgwDE6i5FM8GlXMuYOyCf
	yUn6yWg9UAVNBoQtQzZ/gs0G9DSbXgQaKFL5s5OSfm9+U52djdHJxcYF8fCii+pOlgdq3DRfWmL
	QFg0=
X-Google-Smtp-Source: AGHT+IHfB7gFyxyGrGMHkGEu1mj8Ud4bC2UIAEA4ptHOk5711K/wLBZdW/RySwRJZi0F2mlHXyMaJw==
X-Received: by 2002:a05:620a:1928:b0:7d0:a101:f33a with SMTP id af79cd13be357-7d0a1fed3admr605800285a.27.1748616520251;
        Fri, 30 May 2025 07:48:40 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b113:7ee:3564:854c:29ec:6765])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e00dcfsm23728796d6.87.2025.05.30.07.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 07:48:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5 2/4] docs: improve formatting in git-send-email documentation
Date: Fri, 30 May 2025 10:48:28 -0400
Message-Id: <C1E8439B-7666-472F-9C23-C558BA9ED53E@gmail.com>
References: <877c1yb53w.fsf@gitster.g>
Cc: Aditya Garg <gargaditya08@live.com>, git@vger.kernel.org,
 Julian Swagemakers <julian@swagemakers.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 sandals@crustytoothpaste.net,
 Johannes Schindelin <johannes.schindelin@gmx.de>
In-Reply-To: <877c1yb53w.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 30 mai 2025 =C3=A0 09:28, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BFAditya Garg <gargaditya08@live.com> writes:
>=20
>>>> -When `--compose` is used, git send-email will use the From, To, Cc, Bc=
c,
>>>> -Subject, Reply-To, and In-Reply-To headers specified in the message. I=
f
>>>> -the body of the message (what you type after the headers and a blank
>>>> -line) only contains blank (or Git: prefixed) lines, the summary won't b=
e
>>>> +When `--compose` is used, `git send-email` will use the 'From', 'To', '=
Cc',
>>>> +'Bcc', 'Subject', 'Reply-To', and 'In-Reply-To' headers specified in t=
he
>>>> +message. If the body of the message (what you type after the headers a=
nd a
>>>> +blank line) only contains blank (or Git: prefixed) lines, the summary w=
on't be
>>>=20
>>> Shouldn't 'Git:' in "or Git: prefixed" be marked-up somehow as well?
>>>=20
>>> As these mail header names are all literal parts, shouldn't ehy be
>>> marked up like `To`, `Cc`, etc.?
>>=20
>> I think its ok to let these remain in '', and deviate from the rules a bi=
t.
>> If backticks are used, it will be a mess when rendered on the website.
>=20
> I do not think I agree; bending the rule only because the density of
> literals in a single paragraph is too heavy does not sound like a
> good application of a rule---it is hard to justify such an
> exception.

To go a bit further, rendered HTML is also not the only output format, thoug=
h I don=E2=80=99t think the markup here affects manual pages substantially? S=
o using =C2=AB the website =C2=BB (which? presumably git-scm.com) as justifi=
cation prioritizes the look of one output format over other concerns, no?

For plaintext viewing, consistency is probably helpful. =20

>=20
>>>> -    by 'c_rehash', or a single file containing one or more PEM format
>>>> -    certificates concatenated together: see verify(1) -CAfile and
>>>> -    -CApath for more information on these). Set it to an empty string
>>>> +    by `c_rehash`, or a single file containing one or more PEM format
>>>> +    certificates concatenated together). Set it to an empty string
>>>=20
>>> What is this change about?  grammatical errors?  non existent links?
>>> cpan links?  It does not look any of these.
>>=20
>> Non existing links. Checkout the website.
>=20
> But I do not see any link in ...
>=20
>>>> -    by 'c_rehash', or a single file containing one or more PEM format
>>>> -    certificates concatenated together: see verify(1) -CAfile and
>>>> -    -CApath for more information on these). Set it to an empty string
>=20
> ... the text that was removed.  The reference to verify(1) is a
> command in the OpenSSL suite, right?
>=20
