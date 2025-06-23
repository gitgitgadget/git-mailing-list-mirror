Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621A2D540A
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750710519; cv=none; b=F+JFBsOuDturzXPL1gBrRrQsA2DeoSb8ecLi+AeE8DOM3XwRajokqA34ulqPkb1c5usJzUMTrCutoN8yRUhvt3mxCAoOpsYKhen+I4nWVgy3Kqc1TX7uJoKL/KIx6jTUOsZXaViMn4a7A9V/Di4fOIhbFy8+CFttqvbVnfAgcVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750710519; c=relaxed/simple;
	bh=RgBvvG8H9xCVMkhfkKYGMbar0UHDZNyyh0pXSizZvS8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=orDRKK/f5KeCaUDS11FHB0hyCOKyN+v9JCzdx0Lqjm0siaHpi4V/dMmuDmOC/ceADWuuZQX/cjjCFsyWHYkU3eLOlAJBEmf8NJ1N/7zFTWukGOhFjOQ5+9/8wexebGrrkWxvBfEH59HdajkSycghI9/LdpMY5I9FxW8VDhoY3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHv2Fc/O; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHv2Fc/O"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-315cd33fa79so171646a91.3
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750710516; x=1751315316; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfrvmbuUBEJCaC1q7hWznWcG920CcJy8QGVsRjKAvXI=;
        b=NHv2Fc/Oq2c6uyST+d4nvb9WAFDPY/SbN17jKOakLnmDok5L++QdX+YVgYfgvcZubq
         bZmHHQshv5ZtOK2XYdjFhexUrpHIJmHwsD1FRJtmunbSS5rpPhDiu7GvXcOsshqpscql
         Fvf7Bs2RcmIigpEAqF0ld+uT1zhrjIE25tnRzcWhu1GN8w8nV3nA/imlP19xzrfLeg9r
         BZWfYGbBNt7Z0IzRz+gKMo5SEVeStWOZGQULQz5bRvB7tF2xrvKApYckmLTJWkIydXqX
         DG5egImjQcn9wHVAQHlT2Urs3MR83qdt9g7ZqcdZqGf06sq05XbjFQXjtm7b9Ah1E6fF
         HWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750710516; x=1751315316;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfrvmbuUBEJCaC1q7hWznWcG920CcJy8QGVsRjKAvXI=;
        b=pADFGWH6KrfCColKxScNo2r9VK6/G5JSrdrF/7sZ0EGwmr2RwGLKe/2zdf9jetxbqj
         Fvoiu5atTf8ptQKQMfCRYMqfT1ThAnCZ79pR1ES3QKfnh4zQW2aVKOpYJwPuxUtwHOGq
         FOZFyTnNc4nfqsol98DcsZYPgwMTQr3TS6KTcy7ZVsxo/hn8cIfuf3LWHtpkys/Pd6wM
         mtIdVcgxlxe3B5FwEEG8AWURZgEchfOx4AcUOgS91ncmzDL8qs74Z/mi1k5ldaJs0Eov
         3GNt0HbDOG64aqtyC1oBl6gUcYX5amqs6UU7boq7TyMLUpea4JBfrbRRHrqPNAW3aYnh
         xZrA==
X-Forwarded-Encrypted: i=1; AJvYcCUGf+8PAQbkBFUMRip7f+Jc373YKcKmQuwL3EchdmJp8XLZF+/n9x7eqouryhorQMLEQ5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzKex4IjGu7bscdKgPMqFBcsLWTgZ9kXgRxYZcdwnWdPIXdWd4
	yjBOk9ZvJuItnqQZxQnZawKQsuteEnEAcxrclrUcNwHPOr8u8KYGYLaS
X-Gm-Gg: ASbGncvWpTSj/UJeYmTJyjoA46Tu5AJKn6SJfPc34FvWaBFJeYQ3p6d99nZ09gCajTz
	Mz92BJ+YcPDeO8rYgsGH7Y86oL9ISQ2n7l8fzbd1aaFLu1TnLQvonWg486yaPyxYJyzdjM9ZxHN
	2k3NK13oMWdBLnOKilJVn4SLTVZPor3j4ncA78Kx3mfJv1FTmZO59A3FQ1fpoNUIghwELS904u5
	OZGvwo/5S5RwYqiO9b39hOZVculujSZe2nzxruEs/GFZWF6hlvPiB4T+y0yM8jurkKDuc//7aKO
	3KehdKwf2twibPuYyNTaT17nQmOMRgLiuReON4THYXvD8AN1VjB864B2dbwycL9EDkjJbvPB204
	KUh2HDvmgo5GIp/TAr0IC
X-Google-Smtp-Source: AGHT+IFI9sVbMaZ4SecoyGZwtaH9Sf9u9YlxXHvLz4OfZT8cD7HnLJ8Ur/0LN3Hla/SEJky/OYE9Cw==
X-Received: by 2002:a17:90b:1c12:b0:315:af43:12ee with SMTP id 98e67ed59e1d1-315af4331ecmr16967559a91.16.1750710516372;
        Mon, 23 Jun 2025 13:28:36 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159e07d45fsm8888690a91.47.2025.06.23.13.28.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jun 2025 13:28:35 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH v2 4/7] repo-info: add the --allow-empty flag
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAOLa=ZTCoc9vfeMrWxqU5psmbxGzW=B-QULeSR+uvF9kQi9WzQ@mail.gmail.com>
Date: Mon, 23 Jun 2025 17:28:21 -0300
Cc: Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org,
 ps@pks.im,
 ben.knoble@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E8D7078-25B8-4036-8961-A1758C17FBDC@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-5-lucasseikioshiro@gmail.com>
 <xmqq1pre14ae.fsf@gitster.g>
 <CAOLa=ZTCoc9vfeMrWxqU5psmbxGzW=B-QULeSR+uvF9kQi9WzQ@mail.gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> I thought the idea was that we would show a subset of the fields by
> default when no user input is provided. Which would mean we have the
> following:
>=20
>  * `git repo-info` which would show a subset of all fields, giving
>    important repository information.
>  * `git repo-info --all` which would show all available fields.
>  * `git repo-info <fields>` which would only show the requested =
fields.
>=20
>=20
> This is also a good time to think about if we should make the default =
to
> not show anything as Junio mentioned.

After this review, I'm starting to think that leaving it empty by =
default
would be better. Specially after the review by Phillip Wood [1], who
has a good argument for it:

"""
  As this is a plumbing command I think it would be clearer if the =
caller=20
  was required to specify the output format and the information that =
they=20
  require with an "--all" option for "show me everything" as Junio=20
  suggested. If we were to set defaults for the format and keys now we=20=

  would be stuck with them forever.
"""


[1] =
https://lore.kernel.org/git/af27af92-73d5-4f0a-84f4-9c91de6ab6e6@gmail.com=
/

