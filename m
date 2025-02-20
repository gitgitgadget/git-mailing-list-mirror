Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F332EEB1
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062164; cv=none; b=ARd08qBFqZQBVRhPhJe1scpRp3UDuYuZkEDmjAWh9BvtOGVa8x21ZJMzyCMbx5ZQfCpeUNnjsqgxxsPo4erWs69lQUH7b5Q6t+WxYL2307owuzSmLug+AExzTI8rm3ZxPoWFmXqsRxMPTEZFN1qGEybOUQBCZW23tMNO4bggbkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062164; c=relaxed/simple;
	bh=IjkabXAcbJfDxEGgTg2OPuNhL+Eb4qY7QNn4yWJ3Tbg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d2A8XKULRM48iCR11kxZ5Cjp20tDZRuPgwWxS6eU1G2M6qLEQfSkPAZU0UgbnvciIRj+0XZ4hyRTJ6klOORlyZoGbWsqgHF6Suf0Qqb3L4r+GT6usDhZcR1JX335uPxLKB0+G7paEEbgcCTx2MTu5aQ26S3GBoUJyHRNtRtImqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SrqhK/P+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SrqhK/P+"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaedd529ba1so131381466b.1
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 06:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740062160; x=1740666960; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Jc9janYHAqkEBizahS2Gepw5RQD0m4YYIZjCE1NtXY=;
        b=SrqhK/P+lUDpJ57URmBxfIFXcq1z7RQtWlxwKPj0uJoC7LC0V8hhE/DIlx4b5Vp/fW
         mmot5UFXwBMmmyMjdHhpQUs5epwpK+Wx06daWBiFhl9oICob0ICS6y+Jl3LycP/lpDdc
         cQgiyiPfFChGmcnY2J1ZEEUHkpy+vBkHQg+6DQ11ReFT+ZBzWdpj8jllh4PSAcQ+K8eT
         lBtflskiwzUetFD8IyWxsxQOH3G0IYUnLeJYU/0EPyaoH/d21zmjVq8FQEbDcNlZ9xvC
         smH3jQiw3wuL1EddPTfQgpeJ2T8tRohe94h3nF1gCan60SYoWeDl3T8J3rVfioFvJ7Ou
         wARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740062160; x=1740666960;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Jc9janYHAqkEBizahS2Gepw5RQD0m4YYIZjCE1NtXY=;
        b=ieLVbfFv9pDkd0hNvWXmKL9hX86OqOFBgqR7FAGmDJjn02JcyoBoqwd/6E2v9u7Do9
         zPiZRCqobFQ2robJuf22AlR0r/m+tesXqTyOHcSU+tzzz/DJg49K1sqg4BLZVYMfQ6PP
         IqMCkJ8hlnmv8p4/RT4EzldVILi7lUE8JJpcRSKP49w2tZQL19uzEuqydMXp3QTq5Rxg
         /JWHEtnAQCkAMZGOfu3UV76DSC4LfHf3ltrkGV406cjlk2Fis3ynIymSH0H8483Sh3h8
         2f7sJgVhntohkqj9JsRBRSTxzLr8y5U33sDdMUVgkUSIk135g4oIpDN0aOpuItBdBcYy
         tBog==
X-Gm-Message-State: AOJu0YwTwHB+c2ab3+ycvb/Nr62OAcy0MPZRe7MGGAxuMVctVSJHX5gx
	Ryh25KQ0v58tZ5rBPz9/LYvFxyDddvpE0z8JiDWZvFkH5SsApYxdbmkbhx8o68XHkR+9MCTZHKw
	6
X-Gm-Gg: ASbGnctWGxgVIjm4xnmI4nDr/5Tcf6ZlinrxBNUZJdYMhCRURO3qDVPK1a07vSHR5rG
	A+Is1Opf4h+mRTN/NOaqJw5c2L7JHD/3+SN7JuIAUhoNL1RadrQ0/NBhXHLX3xutMHijnfwmsPk
	2NHrBViuEcr3A41SjRogOeqmuGLcnuq6+WkK7oiXaIpMpK+MD2spKtgrUmn2KRoFCORmJKg4uYP
	1Cpdo/mG3KQuszCCgdh/ejoTZwFXp4zCTC4WOfh7Gu+cRuIT6pOujSO7GpqD8gVHL4COE73wRl9
	iz05OU1BNcloSsBOMNMw
X-Google-Smtp-Source: AGHT+IEnZYWvYtIY9Bwu3TTbFdMamjZSGbOYEP71XrKFpq30J8Uq10xs8WLygS9MwxhWED7A3DB5pA==
X-Received: by 2002:a05:6402:350d:b0:5e0:2d53:b2a with SMTP id 4fb4d7f45d1cf-5e035ff9ca1mr59715656a12.3.1740062159902;
        Thu, 20 Feb 2025 06:35:59 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece28808fsm12019268a12.75.2025.02.20.06.35.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:35:59 -0800 (PST)
Date: Thu, 20 Feb 2025 15:35:56 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: git@vger.kernel.org
Subject: first bisection step takes quite a while
Message-ID: <arrp2ye3kid76pwghguu5z4jkpv7xsskzdsjunbfkgmwejgby5@qh4phxwzenyp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5jourxsg7nbpcfsq"
Content-Disposition: inline


--5jourxsg7nbpcfsq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: first bisection step takes quite a while
MIME-Version: 1.0

Hello,

today I did a bisection in the kernel repository:

	linux$ git version
	git version 2.47.1

	linux$ time git bisect start 09fbf3d502050282bf47ab3babe1d4ed54dd1fd8 96d8eab5d0a1a9741a4cae1b3c125d75d1aabedf
	Bisecting: 572238 revisions left to test after this (roughly 19 steps)
	[eafdca4d7010a0e019aaaace3dd71b432a69b54c] Merge tag 'staging-4.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging

	real	18m41.374s
	user	27m18.306s
	sys	1m0.565s

I was surprised that it took that long to find and checkout the first
revision to check. (That is on a 4 x Intel(R) Core(TM) i5-6440HQ CPU @
2.60GHz, 16 GiB RAM with a Samsung SSD. On a different machine (56 x
Intel(R) Xeon(R) CPU E5-2660 v4 @ 2.00GHz, 256 GiB RAM and (I think a
spinning hard disk)) it took nearly an hour.

I think this isn't my first bisection over that many commits, but I
cannot remember that the first step ever took so long.

Is my expectation (and maybe memory) wrong, or is this a regression?

Best regards
Uwe

--5jourxsg7nbpcfsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAme3PckACgkQj4D7WH0S
/k5z4gf7By24AKL2kkLUBfcYmE/RG3yqRpDBJdoKmmfSBfHfvGz9B2XTLcvyWqgO
PfLZNqYhIUEOaAgSepmH8YXVRZ4T6ZMAacjnvjrkp3MyvwTmGicSkcrUfdC/vVnB
rb9YcjgZlpTjK2i9Idlgfu6rIor5Pwh3X62ZhWMvEGLBrv/pzfdGNbGLE4l8KwLB
VxkXmkdumCEbC9Dd4+PWiCdOCRp+ntijL64+SFiY/OAMAGUDd1AjpPuQKdhAkBLy
C83K5lYI7uxKkeuEdIB6Yky5nIjzOqSyAbSytc3Q+7Slz5/lPQyX8q0SrhHb5rom
C4FDLkoGIp0bUqxzNjFIHbUyXM4u1Q==
=lWOX
-----END PGP SIGNATURE-----

--5jourxsg7nbpcfsq--
