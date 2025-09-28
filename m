Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453734BA2D
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 01:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759021976; cv=none; b=dgRtGuwbyUpmsGve4wGcrIkXGZIby9mKZRMifTIY9CqsMgDYU5FgGt4MZwmsbcQHUz9JclreESnnVs8JmXGUj99bI3cU8iFPkY2gPBXXeKTRCVOtlTcWMvRfbrBojUr0rSJ4t06vDRyxPkS91PlO5EuIHWFJ/CuHJyDSAnTbXt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759021976; c=relaxed/simple;
	bh=j2y8PadhLB/h8mTXZy8dBYSshhFa9zo7IOGSbLxk4BQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2kY1Q9jXcF6cMt14nzdApBr9Uf0gJZsbQA8fOoayDLO27UCDzKTtI8gNBag+KULrM60oIbD9l9sswQswy/aLG9aV24/xyODyYGidH3XjnvgEPrHC46E6sFFQUTTyOhkDhgY+1CiMCu0bswiNhbW48kXA8Jw9aZ/rD9dY6oBgcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf9lpw+I; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf9lpw+I"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-911520e43edso66574339f.0
        for <git@vger.kernel.org>; Sat, 27 Sep 2025 18:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759021974; x=1759626774; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j2y8PadhLB/h8mTXZy8dBYSshhFa9zo7IOGSbLxk4BQ=;
        b=Yf9lpw+IXTmiSdic3+uR9kQZeeTmt6TC7dPTnLOsYD60jvS/NFw6+E7YzNX31dUUia
         ERBb97YUw/qwTJ1QYOyrw59ObPSY57lrOu3LYXWEXMBQS42X4Q1GW4Gp6/yJcg01Ojht
         AvuPHCVbgGu7dwY3TYYQbLTL/6op8I8LyXoiK4CSExaXHwev2anIBZSODEkf0LppjC7I
         ZaSv1ZmNuXbZZRHRSkvqFlSkoWbddTH6BylIoL69+wgpWy4+831Obqr8DMC6C4Y61xg2
         3c3jSb+wkiY0PyIzsJPHGOS8k4DiKPqAmyugK18SwOFuuKFhfgx3RLKM57fw9bjXi5Fr
         WV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759021974; x=1759626774;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2y8PadhLB/h8mTXZy8dBYSshhFa9zo7IOGSbLxk4BQ=;
        b=D0RmXWdFARWzhIHqs+By6YxTZkBpve/yd+At2MfUIC9bhyLnythTtrth8Oq2WISSuw
         kxMlGE++P47p+hy1QWC0nHfCoB3KtPVN9lRvOqqjqOnqluRjnT4lcwbEnBahZ9YZWf6Z
         rD9qJwt0bnBcZ92FDig1q/Gdb78npkq5dfIk4YFx4BgUSTlGTiKW/LAnx5dtdboBZKHZ
         N9JNIDvG6gpScpFkHgitQ9DNAaBYmqHyc9yrdeXS1MFXL4TaLi/orv667QEZL4icDc6Z
         PtM+rRyiXCdTaqCmVvrVTZOoObRDgPzjXUFc/99MMOEdrdSV+fENMsI8Bm+JP4OFqX9x
         +pIA==
X-Forwarded-Encrypted: i=1; AJvYcCXLDJNubHsI7OgH2fXETZu+uP/5BUGcxHAu1n+Z56QBP0YNVWiDD6rzD6DkhtcJ8IHdups=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6OWBrseiyOnSamUGv++c1n3+q6bcQTTVzPjRJurSTb6QZEKQl
	7ZIEYdRuG9p0p0HvhJaUIRPIfOa0KM7t6v/r3ZMqOZj6TEdr9aY1BxDi
X-Gm-Gg: ASbGnctGf8lfbGGJ8YFC4Vl9gw+Eu7DOlArasl55o5hBk0OQNCLtcJGP7gumsj8t9J8
	aKQXlVmuDcIH5QUxG9O9FvVPwDPd71HdqgyJ2T49JhOz2+oAs45h6QWjr7OaAfGB6nheSIh9yb0
	eXW8saEAvCJU6PAcMqfD8X5WDbCcCpVbhJtya/hqGeDS/sRd/S67NIeB8LtyDDx2iAW1IHgDe9a
	ip19CoRuNzi0l/G0rOjB4RnUF7s8kLI6S0gyZsp5g27+wOZYEvOZP7tWf3k1wgUkOj5bEJb1V0L
	tDkkBmhleuH6QB1G2e51b4FIm1iNqtrknCXgxZboiQe8IDkp3CDUVNIwYSTC1xoeEdd6PgZNYAi
	X9CYl5LCpiCR07+XizrydRWyolqd51M7UTEaNs8Ym3DGP1cW/paHgehg5gQpdFa6PVQbGm3bp+C
	zrYw44/ZCEag==
X-Google-Smtp-Source: AGHT+IEsJSWwoTV7ziphuEy5rnw4b2/JG5GvDqzRP0bvq8Gaz2/QeSF+ObCAVrNbfbMABZLj9wHSkA==
X-Received: by 2002:a05:6e02:12eb:b0:426:9b32:d156 with SMTP id e9e14a558f8ab-4269b32d198mr139684275ab.26.1759021974277;
        Sat, 27 Sep 2025 18:12:54 -0700 (PDT)
Received: from [192.168.0.171] (h135-135-197-41.abdlwi.broadband.dynamic.tds.net. [135.135.197.41])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42644dd4281sm36717215ab.40.2025.09.27.18.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 18:12:53 -0700 (PDT)
Message-ID: <e41c0aa427d45e922c86cd88b3ba626054901bcc.camel@gmail.com>
Subject: Re: git whatchanged
From: Neal Miller <meltdown03@gmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	git@vger.kernel.org
Date: Sat, 27 Sep 2025 20:12:46 -0500
In-Reply-To: <7e3a5da4-0ac2-40ae-a96e-0e9a88a68d7e@app.fastmail.com>
References: <19a81573bf1ef7c544106e8fa7dd3b2db304c4f7.camel@gmail.com>
	 <7e3a5da4-0ac2-40ae-a96e-0e9a88a68d7e@app.fastmail.com>
Autocrypt: addr=meltdown03@gmail.com; prefer-encrypt=mutual;
 keydata=mQINBFnLCSkBEADELqmI8SzCYyZjwjnj3SMT/aKHSWCT/xuJlkYRBGOVakFEYMxBHxw2H
 HvVgVS5QbEIC3GAfmdL4HkxAIxlsVXtuNsWdOM6SQQJA/RTekf6Ee8+1qk4kqwPuu7JNayAL4PKy3
 napZhLAu1nUX/+noJTPDICKXw2H6VTirvi5w12WWJ4PTIWVlI5f4bjniZy0wqwu+SSLG+9gQPcNnq
 /FtXzQKeuz+sH3mVSAx1iG9RFZsM28bTltbo47s4k4hwAUZpgQXuxX13IO0wTVzVCBxMUmMTSTWiM
 1C+nSPnjwsUblbHkwdkUf6DXnrdKxoL4n1f3nSUPX7Ey+KVXyThx2SCdkU22Qi5alssYkOSMvN/T+
 Rmyc4l2fR9/oI1M7WUsz5Eip6G5jlbkJ1WHAOteNl36+yj5XYErPlf8L74LgkgRp5YeeUlqNoWwF2
 Sw73pD7C8NsjnknFcIG5E8vWgWgqXm66eoVKNxd+aV9a16gjOJQ+SSPqO1wHM/AiVuAYHJPAFGjqW
 3ZzqmQpetdgclrZgEHIfcdNVd8Uf+SSVeEB7ty0ndPo8G5Drdt+1upAxO2ffXmahI4iBs8OOAloRi
 lX9FUBHiWJetSHCaeOLxMvBpRDls2X4wSdQAQ/NeMSQX8zVuyNsmOsk7d4s949tONGBp6/nhkDLkT
 sS8GwCPeRIezQARAQABtCJOZWFsIE1pbGxlciA8bWVsdGRvd24wM0BnbWFpbC5jb20+iQJOBBMBCA
 A4FiEErYqSfL3b5eA6ZvbjB9s6hB3b8q0FAlnLCSkCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4A
 ACgkQB9s6hB3b8q3G0g//f755fxY1/ONx2YBzG7efVu+6t3Gczk7H1fpBO1WLk1Q4rhCuFHhdtMbe
 lf9LkTrEeEdet6wgi/OdwIFEZCDHhmM+LFVpd/Agu3jC79ae1kVfIp1au4fKc/38w491rljRIMjif
 yi/8AEgujYlaU55j7ixDUkvlYoIwM11UboV1NYeaidMRSP3vrE7qNhLh2WLjSZLCDWO+j04/XwHu9
 16AwyLUEUcI/QEZZQ8tildBhLidaKCZ4Erq8AD7hoFlhEWUMW8JtJ5eY8OYjXEVzg0Q5vmQp6vd54
 957dfiWaUeiJnOcjVHrQp2EXPKRLLN05iuWHNUVdevc2BVanCWsVGN78Ssea1GEINZjJMyfgnhJJV
 k8KcHA6EEAaWg0c/+Ojk5nDa9IuZoI3uemvGb6fdDqYdkv/VdTIBM+sLNeF+IAEFRbUfyOLTkN/HN
 bDAGrTSXw/MM0JgaMaxt2LUkEcCR+TIjXqYoImtaDpwRbVXntC08tzVksboJW0O1h0sdCWgkPDpdm
 ZdbvaZPbO9wPyTJdcthtevIwLUeZwC8V0wuKtTgdBBdpPkK0nTPI9/x5LGLmzcq5Lkfsvm5BEtmPu
 ABfMch5Imbf7u3SJwpB6SnGvzPPSTmLN7DQOtAeqf+wznvjQrWSgG/W8ZGbC92hYbuzaqnv56KPpw
 i0pfqRILEXM=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Vs36KmqMcKWuK1pPlIk1"
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Vs36KmqMcKWuK1pPlIk1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you, I found that 'git log -p --abbrev-commit --pretty=3Dmedium'
gives the identical output as the the 'git whatchanged -p --abbrev-
commit --pretty=3Dmedium' command that my alias, 'gwch' was set to use in
oh-my-zsh. I'll just set my alias to that now instead.
On Fri, 2025-09-26 at 09:13 +0200, Kristoffer Haugsbakk wrote:


>=20
> > Good morning
> > On Fri, Sep 26, 2025, at 03:00, Neal Miller wrote:
>=20
>=20
>=20
> >=20
> >=20
> > >=20
> > >=20
> > > > --i-still-use-this
> > >=20
> >=20
>=20
>=20
>=20
> > You can replace it with `git log`:
> > =E2=80=A2 Given: `git whatchanged <opts>`=E2=80=A2 Replace with: `git l=
og <opts> --
no-merges --raw`
> > Additionally for the sake of readability, you might have more use
for`--stat` or `--name-only` rather than `--raw` if you are only
reading the output.
>



--=-Vs36KmqMcKWuK1pPlIk1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErYqSfL3b5eA6ZvbjB9s6hB3b8q0FAmjYi44ACgkQB9s6hB3b
8q2EPRAAohWkMSxg/NyrJL1cQUVvDsFax6gDazKfD1WnTjmBwSatZpNf5banEPSu
jVZqo2GTtidsZQTeDbUIu5+uMeGgSGVKbUQBzAxyl0M1LY2jTfLHmL6Rk+SOfua8
kJv6hKL2M+x0o4hd87d6JMBTEVFpiNaAKQFd3SaTujGMDQIEH2fuKWzKawVNd8cg
ffFCYcmwM+ieAawP5+l3Cx2g5V2vK938JSnGvgs2ViBBsepapHwWopB43U0RYiHg
gaAEO0PyWB8t2IRAUlzsRWKsvRRrTAkQVBF/897grnt4jOzIMR/kEMX+q4rwyw8V
TGaXbS4ZhIn7WPSU1V6DRtDPLGsb9oz61a9RwnOSa3ko48z3I22ljuTTOJj5iPKM
YLys0qSii7rdSa7HrZyCmm+pPi1L6tGY4rIi8iXSTv3Uh7rzgln5jgt7gCjNe9/A
ifj5ghvjsLg7wS67JS2zAdLQtHm/AnXFLjxbmroGawQwLGoRrfN7u5lDviqh4Qic
NyK+3X2WiONzfVWNkFQucXJSIVMGxlWpzDHVYZBnxsK4ykBf05ebtkjrPhf0kTar
5iAx3e8YIgsGPTqwq08fa12KkQLgpQV6fjxSM57bvB4gDhWZnRWl3AkpyfNngiJ/
M1hR0v49YBQ0NO1+T+V9A4QVFkxE6J5g5S6DLHVF6wQOZy7oif4=
=2D7W
-----END PGP SIGNATURE-----

--=-Vs36KmqMcKWuK1pPlIk1--
