Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5727038F92A
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874121; cv=none; b=h8cmy1Dh7nY/6afpmL43FgEkwaZuX+Z8QRzcjQ/PfzcaDRsHqB2mepFl5kT+s7C450wZICuRRnEpKiib9HDiBCvkPMl8UiXo4r1Z8khClNJvY6HtGW7Wd/PU1TaQ6YFGK1nXvGNA9V1i4yixLdQJ7917ocAiEvWF1Y/rWkdsjrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874121; c=relaxed/simple;
	bh=oQeCbRF4Hn8zLrIqb6DnNSgAQS+r2BUC1ZjoS7aLL28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGh6G32xxeitfRgE28MIsnCcT0Td5i+oXfnniTSl9nG0rGzcHoZnNnRuq2HY10wanUFj7goib/CtvDKGcOYzUPGKZ+VaNOcAMl7g89UnK+YHbDqiFtVh82I7fm9wKlK/O4xqnT5jarHGfp6Cc8SIls7fIKXHnjpKV1pc4wRmepY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Kbn4vmdT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Kbn4vmdT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so9669005e9.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781874117; x=1782478917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQeCbRF4Hn8zLrIqb6DnNSgAQS+r2BUC1ZjoS7aLL28=;
        b=Kbn4vmdTcgbEvY27tVAEbbAbBaM6QiO51Z9/v0xP+iggI3nERXGPHB9ls3iwxkXEv1
         eQWvYT7nvH0EeA/sJAgrvicZjili9K9Q9CFKavOsAQbEqgFr+YUGbCJ0k1GMUNp7IffX
         QEvGaLFc01SVixf9QEd7tbU4ajPCHqRhqUmtLUqXRv7vCVjbCa8QbfSiOeCcFz3Cbhjb
         GYmSJmzoFplg6eLmQHucDE/dNc7h1MIHS1ak2tLULYDtr1l3xseFqch0enwl55//DyLr
         WcE8Vag1iwfjUAZBhH+8R5qzZohY6uAs7u5lZlV3ObEDJo9EXDK2LyaosyS4FkhjRGTr
         brUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874117; x=1782478917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQeCbRF4Hn8zLrIqb6DnNSgAQS+r2BUC1ZjoS7aLL28=;
        b=oapKE4a0exQmZbBG8Ru7DUDpnLhMk86qiT8pVFwv39L8ukbpWYmEmI9baQ67W22R6y
         xxcbwQhQX/uT0V+8cac2fsunoWYkwxPL+aHicw7mXSKqP3bYoZMr16gKu95MbDRHmxKR
         guWqY3klcn90l1imFJ5ApJytt3dXGrvAyKmW9JM6QTxFzpKVd+w8L8MJoutIvJndg0gw
         0lTgOvINWPjLnrA0O/+ckcoTkgs3SqHKmYVvRxcZlPG/TopPkl9m6g9/bbBQEFjhLGIS
         dyyDdanuNIG5RduS7V2CUk8/i1jB4cUFIR3qAZCtWazU+IS/5qjt+Y6kXPNmHLA4gNgO
         JY8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9A+lNRQEG5IT2kiZxWNLMsIeSbm6a6xAJve5XJLcHzSKpb6Zg9u+TGE+vFnGpA9/GQZXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCpmbxE0Qqo24osRlKi7Upd8XUCWlwKLsf0GrS2Eb2eQiMAcQn
	9x6MJ/eXO7cyvLDBdq/VAl3abBFauK7BBqQi3xr6KF+3spRaiZxlu8Y+4tntFT++CiY=
X-Gm-Gg: AfdE7ckJMZr7kC+P5Y32a11Ji/51J2iwZ9u8PFlW4GufQY2S1d99+ipHvYXl0nF9aKZ
	iACAZ05Wz28tqj5zrSPeIGc3d4P/ZiUicDXUfLH7IthC72Pp7KJXl0tXXfMdkdO4nYTgzMz/gn1
	EoL2PCHrZk3j9CuLqmYZ+8JxrOeqSZa9iyPNxCTlqgnpf0FLKUe0l4lXi2f07LBXR3BP8HGAjH6
	T8cXzGHIXUpddDph5dO4tnYuD95EF/7QdEKppGEn+zVN8yJruyVJ+7WJx8Pr4kvkBIzMs+w5xxP
	xKOPDuUAONQQGq9tZlfYTkCj0fOYJTDQ9NbrzX5e3fg1ufFxxt0zp6qXKTFCPfHAgvdoT7t5MCg
	j6VyAd8OhROdYNnJXD57iYdBPgMfgMvkPsTSlCtW0ZnuWy9ST5f4nQgs5ucP8bjS0BjzpFk8YgY
	uXNUySO6siY9kBdg0z7kReymNmY3gksN3jV90aQLTwtGvdnisENAMA8+R7iLgwqBSisYTpxVfRO
	Ec=
X-Received: by 2002:a05:600c:5290:b0:490:bcf6:469f with SMTP id 5b1f17b1804b1-49242189b1cmr44694995e9.0.1781874116260;
        Fri, 19 Jun 2026 06:01:56 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4923fce9561sm63533325e9.5.2026.06.19.06.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:01:53 -0700 (PDT)
Date: Fri, 19 Jun 2026 15:01:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: Skip copying notes for commits that disappear
 during rebase
Message-ID: <ajU9ju4jUpMCfksJ@monoceros>
References: <20260616174012.601651-2-u.kleine-koenig@baylibre.com>
 <xmqqzf0txpu4.fsf@gitster.g>
 <ajKimV1TDCgE-GzK@monoceros>
 <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l3h7difytd7gsqpe"
Content-Disposition: inline
In-Reply-To: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>


--l3h7difytd7gsqpe
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] sequencer: Skip copying notes for commits that disappear
 during rebase
MIME-Version: 1.0

Hello Phillip,

On Fri, Jun 19, 2026 at 11:13:32AM +0100, Phillip Wood wrote:
> I'm happy to take this forward and try and fix at least some of the other
> bugs I've listed above. Uwe - if I don't cc you on some patches within the
> next couple of weeks please feel free to send a reminder.

Very appreciated! Looking forward to test your patches.

Best regards
Uwe

--l3h7difytd7gsqpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmo1Pb4ACgkQj4D7WH0S
/k4bFAf8DorwACV0D2azcRaGMX0yTcWXCyezf3s7ztf88zzvdsNSzRo9LGEio9Df
yk3o194V207BMre/UxEbBfeWbqwLtm2VPesjvVc2ykBzyzPGIhYnOyq2DIpSjwBn
v5U8t20EeaAbFQoa6jY9zcJQ/uMhVm3GQOXB6GBZ2lyInobdpGXRwm1niozdniiU
ClSZJKkpEtONXAWQ5kYCAEZNhMPgy+IVVGAr/HEneGTxAZoAn3KYEco/zmS8S7jR
u2lVqssH3l+6zL6zxY8WSgqN0XRYrF2Cz07SJ2SqIO4NfMGY7w9ZDE70wtDnP19V
Qd3uAry9FQBOwUbk8zvzTArTGN868Q==
=0ctJ
-----END PGP SIGNATURE-----

--l3h7difytd7gsqpe--
