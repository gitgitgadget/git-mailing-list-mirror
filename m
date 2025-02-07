Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DE02417F5
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738916239; cv=none; b=pfEg+32QSvuoR0IPU2RLfcRIC7aVTgnjIDaX8BMltX+7ZtPiW7Y1zufOnLVNyKXM3H2F2noQjwQugtqU6GLyICh3HizioEN+I8oDpQVj+GntyApd4jU2ajztJbpfFV9hfB8u0hCZ8fhDFvziZXaboEq/INbnTDs1G9qq44DVm1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738916239; c=relaxed/simple;
	bh=8jX4dI9i/2usTOptbZeLzQwmnM7KmMfvZURkLlvSYw0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Vg0OgbVl0GGUv+SSpDqoXNAplgO1UN4eLo8QajVtEB1VS+MCoGVn1SJTXJD7NYOPBL88MYTruH597Ms58ID6t4vHc9d8V28p2OqNkjDRP08j7dP/dPbHDYjRRasqPbQ3scrK3TrUK4K5KWweA2CX3mQOd0ECC1VpzyqB3M+ih5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOZVXx/w; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOZVXx/w"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-866f2f6ffb8so480527241.2
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 00:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738916234; x=1739521034; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzy7IHyYGfGzMlM2muY1kJYgAP8eE/bgxzBXhXDPqyg=;
        b=gOZVXx/woBM85YGcwh78bL//4cPJ6oW+kxGJiMgzZ2SHE5bqInKJFVpMaWDkc10No1
         1Zp3hPCBFzh4WOt8KhYEh96ESCd2NVAW0PxUHmvZgu/AH6nX0vxvXmF+mHiIRJHGJrGl
         jmt90s87C7TqWH5sqdtlF9ac3eCNnxIPIiq5DFjm6W+1NwtSP8TmlFSg/G05HkXJDaqQ
         iWabWhihrJDwfLsIklJA28hCbYHobAeTvWzizX/8Q2Y43UX1Q5hlun79uSvFmY6i4t3x
         R8imbHQXcPivBwOb7ACqYIOIeL403hn1lvZNJT05KqeRu+B2JRClIw8meeEvpJba0l3t
         x1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738916234; x=1739521034;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzy7IHyYGfGzMlM2muY1kJYgAP8eE/bgxzBXhXDPqyg=;
        b=CaLwtQJtktgZLOTPPnU7BY4Nj5CSVEie+BS7Rn1ohW9p9bFYQg7NNgUi53sBQyDBn+
         z9lbiVqYLg2S+umZino0vwDB6dL9RwAE5Dfr3W2TzVfX4LsLPSP6eicrtZSVizI6JaVY
         FMQHkSKz1V7Pk9XubKC2zaSwbxrCq+I8zlEwiF4YzT4iVKlyz/8xwdQtFL+6BBuekQpE
         KHkOoUft+eCvPRV9uDjbQIID8a/p/QUUvVe3NIU7PZwq26PmR3HpqEX7H3Uoa9sr2ubq
         4rIiPyUgphjUB8mxsGzxSzzS5bEv/rFmhctM4AgOyaGKCu1P8lEZDjZS2I+YEZwelQvF
         Lo8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHs5ysPEsQpDFPoB9AeHyhnLI/nZf0ZAU/OVMrz+20lAsJsPvBN+eYwz7BBEHsi4si/gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7bj0fje84on57JHq8MV0L+0aNyl6KRl3d9GTB88Y3TS5h4rsE
	U9odXtzQ7omWiiuZphXJs3Qih8pzBlFzXrbI6RLM4LBVBqIefuE3LX3EE7BEMIcx4pqJhUGVRkc
	p3AmUKwm0VNBkUKdkuqWmWsR4pl4MbnIK
X-Gm-Gg: ASbGnctxY00HTYpNa32YyEyhLyg4TjqWMtTrrYVN+rT1utTAMwKZh6+wlBfdxW/ZZzP
	B9GER2ZgIhBM8ACtxciOr0WBCB5+Mu2qx9cFcfWrUKN/x2TCNc9p7kveuLJOOjf7fcVspmhNFmq
	NjlF9mSU29cJyIVH3/lM9cX3lDKBfctdo=
X-Google-Smtp-Source: AGHT+IHESXfaFEI9A4plDC1cRF5ChnQEDfQn2oxfVtyFNJ3ns6ZQ0OKT36NafeCEvvcvTREcGd4qxetuQ9/lKBAIto8=
X-Received: by 2002:a05:6102:f0f:b0:4b2:5d10:29db with SMTP id
 ada2fe7eead31-4ba85dea287mr1286314137.7.1738916234536; Fri, 07 Feb 2025
 00:17:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Feb 2025 00:17:13 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Feb 2025 00:17:13 -0800
X-Gm-Features: AWEUYZk7_BZKDeZF4TtFX8GDmjof4dNn9ad8GsIYjhav5aWNEZPJIBWHDyWl05E
Message-ID: <CAOLa=ZSScTrK1RH6+VgHv+P-eLsQ2uXwP_ZKN-rwObca1aTa=A@mail.gmail.com>
Subject: Re: [PATCH 00/16] path: remove dependency on `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000074cd62062d88fceb"

--00000000000074cd62062d88fceb
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series removes the dependency on `the_repository` from the
> "path" subsystem. The series is structured as follows:
>
>   - Patches 1 to 5 unifyf the interfaces that can be used to retrieve
>     repository paths (gitdir, commondir, workdir and submodule paths)
>     and adapts callers accodringly.
>
>   - Patches 6 to 12 drop repository path functions that had an implicit
>     dependency on `the_repository`.
>
>   - Patches 13 to 16 refactor "path.c"-internal code to stop depending
>     on `the_repository`.
>
> Thanks!
>
> Patrick
>

I've reviewed the series, apart from some small nits, the series looks
great. Thanks for working on this.

Karthik

[snip]

--00000000000074cd62062d88fceb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6ef7b83f4b50be63_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lbHdZY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEw5REFDa3hZZnk5QkVvQnpSdDZpYnFnZGtiZ3E5Zwo2ZDVTc0k0L29C
QUJuUkxNUDZZaUxKOXBXeUxOQW56NzZuSmNYaUNZVitFNHI4R214T0JvUkN2bUU2S1phK3dLCkpO
V3k0WVN1dmxLZ2FpcTRna1ZMNy9STlhyNTQ3R3JaZE5OWlB0RWNIVUpxYnpzTjdjd0t6MVRzaWhT
di8zZHAKVmhIaWZuZlNnY2loNDRBcFdTckpyUXg5NUR5dlkvQXBqTURPcXhVY2RNbGxKQzlOUkZU
U1lkbzJHSHFxK2h6NgpJWWtmQWljd1VQSmFONXBid24xNGNsRDZxWm04T3NJNFFwWlI4ckloZ0xJ
ZjkvWWNZRGZ0UmlXaVR1eWRPajhqCnlCV1NVVkxNaldoMjhraksxRnd5K2VtTVBqTFhOK3JuTngr
aHJZSzBkQ1RsZmNWQWg1Q2RaREhxaVVCMWVJSmgKdEhBb1BIVmwrSGhJT3JGdVkrNnh3RE5mZDBV
dmVSTmExRXVzVHZrWHhuK1NqQ3BDVWhZYXpXMmZVU1owUkV2UgpoRFBkc1JTQ3p1MGQzZnl4TDFV
d0J0eVdpeHRxSkNjZXBoSHlPSlpDRE1EWXhHRzRRRmRKckhIREZLaUpac3U2ClVjZ0ZMaFRBcWJt
UTNZWUlqMEl5Vzk4bVhqTm16SFVMajZJN1Zxaz0KPXoyTEsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000074cd62062d88fceb--
