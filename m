Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0EB28370
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 05:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729576725; cv=none; b=WC2M+XEzNSUAY/mV9CTpxfHO2awBJNwJtxQkd8xTbJNzvqGdYyV53AN8fEvdJZ5rbiHD640edgYIH9ykz5NF/ctf+y4UICEYer6cZpEQH0a9ywZtgL0halBDK2c67Gsc/wWyROtIVMgZLfw9QQZ2Mcj/LKzU/lZvgi7ksTRGOsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729576725; c=relaxed/simple;
	bh=gp9LU+Osp396WLI8FTLWMt5hLFJLutnuIyYSbZQYL+Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HAygTGR/8RkYO4PoulBZ8vEwNme3NrHttsjPgnYMY+MrI1N4aAcK0q7FAOfOGO0sJl1PJ63ry3S8cnpmdEoAfvmOYlVN/CrZ5pYnrLUxtZ99nz0x3NqCDZJ8TV/vWE1Be21RYCd9Z1j4IBXsa7LwssNh/wzw7AhNfqzbTd0yP28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=a2JB/0pq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="a2JB/0pq"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0c40849cso817226266b.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 22:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1729576720; x=1730181520; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwOCOn4Zu02rBLZW+cbN0Is02cKRpWoMK5jszRt0luw=;
        b=a2JB/0pqJwNhyxMGiFpBKDMElk0JF6pMYes7BGsu4nbQm3OLkgBz8ybca91pujEHxu
         rmybeqCsTWOWSGfG9/fmD6OlHOuKu46sTBifSBw2qov/hN6/uKOmSrM9nM8SYV7kU14D
         WawaYnaRa70QY23TJNAI7z7YuNtH7moFHqqmDtTnEiHDbr4DHAGf+ZHIlTdD0q05+M0N
         /ZaUvxHyhKTzkUOh7zyfFrfgxCK0FiEp0e8uFRB9NvR/voVdxh0HtP4EV+N96Y6vR6wJ
         GC7DTrUZEdp9kngLWdOXOyfRWYOjtgZ1L5f88FizGfw6y+CQdlN2I0Ll+3aTgA3mzQq1
         /0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729576720; x=1730181520;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwOCOn4Zu02rBLZW+cbN0Is02cKRpWoMK5jszRt0luw=;
        b=rjeZBFaBCmZVQdD2Q9QgF+7wgibDvi4YSJuS/XnWi9tZfRf/f3205Hg0/xPhWmM19s
         VBN6Zs8CKL9nqL33JEXbN7JLwmfZHNpDoFP9kNZxQ5ugXdsscJaG4Na6T0iCKBt6Xan3
         cYV0SMR5pxGyJ81xluJe3vnbCGOv12WD8J9NSBI6zlm5xd1K132seNVihTLRtO0wZIPw
         CCElo7EeDSCk3uifYCDqtHUfnxuNqt48XRhgbactXfsOAbH1RGvZ405NpLbTgZZPkdje
         qaWrmZOs9K/75TP37icc3L/cMuUM8U7Y4mV8lMYkBcrf5FgKpyzHmY2hFF2XRZhiQD8h
         LkyA==
X-Forwarded-Encrypted: i=1; AJvYcCWYsjR8fmkg2a+fJD+kB5E+avMvVVC7KHLfVIU2RfnJIpKwt39bPaUp11tjO8xRB1qefgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0qEgvz3GDRj/nd1wl+bdkaX49yKKWc8D1zQJo2Z419RJqQqe0
	rPohb2jbwqbN/rO3q89qB94sELnSLxeTWDDJWH9FrTYK6nSUxeIQUMF0RkRsY/2Lg+WKT2yeuSt
	s
X-Google-Smtp-Source: AGHT+IEhtT1PrSPtE3H/43UAlaD+aaydq0NOy47zgiGoLwHZ321f9MWSkDi3oPkRJdI2T0Qq16oGFA==
X-Received: by 2002:a17:907:8691:b0:a9a:16b3:7dda with SMTP id a640c23a62f3a-a9aa890a2a1mr229422966b.19.1729576720082;
        Mon, 21 Oct 2024 22:58:40 -0700 (PDT)
Received: from smtpclient.apple (17-14-180.cgnat.fonira.net. [185.17.14.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a913704easm292691366b.107.2024.10.21.22.58.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2024 22:58:39 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] grep: disable lookahead on error
From: David Gstir <david@sigma-star.at>
In-Reply-To: <7a51a68e-5f9d-4444-a568-9ca180bc4c6b@web.de>
Date: Tue, 22 Oct 2024 07:58:28 +0200
Cc: Taylor Blau <me@ttaylorr.com>,
 git@vger.kernel.org,
 Richard Weinberger <richard@sigma-star.at>,
 Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <494E7060-B824-4663-B49D-A645A8A67711@sigma-star.at>
References: <771C9C4E-45F1-4F71-B3A9-4E8E4A9CAC1F@sigma-star.at>
 <Zw22sTxyWCbczZy8@nand.local> <0eaf6c1c-7205-4897-ba19-e5ba03194012@web.de>
 <7a51a68e-5f9d-4444-a568-9ca180bc4c6b@web.de>
To: =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-Mailer: Apple Mail (2.3818.100.11.1.3)

Hi Ren=C3=A9,

> On 20.10.2024, at 13:02, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>=20
> regexec(3) can fail.  E.g. on macOS it fails if it is used with an =
UTF-8
> locale to match a valid regex against a buffer containing invalid =
UTF-8
> characters.
>=20
> git grep has two ways to search for matches in a file: Either it =
splits
> its contents into lines and matches them separately, or it matches the
> whole content and figures out line boundaries later.  The latter is =
done
> by look_ahead() and it's quicker in the common case where most files
> don't contain a match.
>=20
> Fall back to line-by-line matching if look_ahead() encounters an
> regexec(3) error by propagating errors out of patmatch() and bailing =
out
> of look_ahead() if there is one.  This way we at least can find =
matches
> in lines that contain only valid characters.  That matches the =
behavior
> of grep(1) on macOS.
>=20
> pcre2match() dies if pcre2_jit_match() or pcre2_match() fail, but =
since
> we use the flag PCRE2_MATCH_INVALID_UTF it handles invalid UTF-8
> characters gracefully.  So implement the fall-back only for regexec(3)
> and leave the PCRE2 matching unchanged.
>=20
> Reported-by: David Gstir <david@sigma-star.at>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

thanks for fixing this! I=E2=80=99ve tested it on my end and your patch =
works. Feel free to add my Tested-By.

Thanks,
David=
