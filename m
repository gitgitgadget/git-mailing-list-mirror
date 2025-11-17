Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814731A07B
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763371257; cv=none; b=Eo7daYGxQHhtvDk0sCZlejBVD3bSncoJSZo0ba3L/pDYJRekOuo5ofgu/o07x5Bo28LdfmGdhvIyMm7+9MBGSuNZfXfdrAEm/eKWI6poZKRDS3uUulLPCeUnH4a9gZF90NIAAOusX4L+kEJBaCMAQINFJ7IBUYCp8hb49bBwqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763371257; c=relaxed/simple;
	bh=rv8HbGeSkx3J2TfgSzSBRSG+bvF4oKjn2bxuujvwZBk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q7WRErOcWWTUzMOgrbmPTZyOlABZuLk7Kl/5fDVcl9f4cA+SIgHil0my1/7LC43mcS9aRtbZsTmQAIZBpS8Z7MtY/5q7cv73jOd7los3VJk8ebQF8qoLLh+FqQJ4g8t4shT/u+eJk9dA97Cm+PbbX6lR6u99VcXsmcGeRKiYhok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q+bp8Cqm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q+bp8Cqm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779d47be12so11146315e9.2
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 01:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763371253; x=1763976053; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5eNGcWDdnLjgHLqM8xw7yEap2GGOv+l5bbeuuYqoXo=;
        b=Q+bp8CqmEcaUqXp2/oTSxo5Pw2f861D5EMLo1qNX5Rrz901vRHROo2EH6gv3FCtrRJ
         472K0Nb8CmrV4hQURMd1XKj/npL2m0PMjeK/cXBYL9Ns5w3b0wMvbknVAa1yx8gZqyCe
         8wmVbjsLLGW70f02E0aKfwUK+j3TuFfG/FfpMuHOZNKXrCdarmQbw9pYMeW5TuXv2o9a
         4KpEwKE4MTjgd6+Iqm8fbNBls4/wmIqHA4GGq7IkV6l/fpNBax61aQaj7o9olDkyqxge
         Ta7KK5FeWQlMb3FSGmUpw63nwWg5HRSiFN79QnVds9bqC+8nqDVmVjWUjUlfcWlX8nq5
         zr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763371253; x=1763976053;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5eNGcWDdnLjgHLqM8xw7yEap2GGOv+l5bbeuuYqoXo=;
        b=eq1HbuTRQpDkus1xzBDExaOWrS1suI5uuV+3Zs70Zsq+lwCXY8xq6ykk75TDUH4Mjv
         TiAH2cUHj9DHjgMTuvWGPDmAp27Csp3plnrt2i9n2Su15+OdtaW7IbxHXq9WAogbJUD3
         2eGbqps6/+Ijf6SjkCE0bfjFNVF5EmTgeED+1O8GnwaKo/KMsBch+LCU1IXQZ6Vpm3EM
         DZvItBL2k/ZZUbukEPwmoOczYkdwK16hFtTbue5U30T8A5qmtdrvcab2tsE4LSCMxrp7
         l1iHavpCZOVLATMG+LGVNxQI6o39PfncF8dMVVp+DL9f86W4lLSFrxcPfVZHmaL7YDBg
         NhHg==
X-Gm-Message-State: AOJu0YwqGCi74Oam38gYtRulZZHqhEuDG162Km9CEbRY328TaaBLbqV9
	tbus/OQbKineFU8Bqmc/Ur0cb4atjuIkIKSLTeeKpj9hWLBJsnR1gtEHFYGgJp/G95Po+7NNlEu
	fOU6r
X-Gm-Gg: ASbGncvg6Mkxl6WMNDdVqziHMuIvHQ1MKyJMcRG+8shlehs06zYeaLBYpQqGjjnurpb
	omg7Ao+Ng87jSj0Ye7bRfIOeMEwkwb2fjPDa9WNaJe1tkjiPqZCBbViaO/gb9TgaFrqcd61UuB7
	HAJ9WzVB6A0XwA0ctzlYGWKrqD5y1CJcN4GTEIANRDnygPt0T5elYfkq02z0DSmkZ16+pqOWBUp
	omvkfhvGPz3ko4q/LC921kl//TzdKu1H5lCTEnTcqCKTJdoESHe6OeBq0GoGRgCuoVMVmgMCqfn
	zajAfHRiik071dpFqmH0DWa/BE1gQW7yVi4NNMTJMtZTXdK7Duv+Tmd5HcsVoFVs/Fjxhypv2gh
	Nbk9ps0vfj+yejUbdl/fbR9qlLD/t1PdKsj3m4tP60rs9nNrUvmabZ2xGW/7cAZQcjG6vwDKpBK
	fc3dWeedVqvyj/x1Nw7Y2UDXk65GwzPH4D3dnTLnI/XQfklCcrunLBMRNBXxUza0A=
X-Google-Smtp-Source: AGHT+IGeeul5UInDpPVINmkO/d6iAIkcEXXAxbo/1tMSvhK67B0ssS/HBpq26DOG9UqugREkoUxkXw==
X-Received: by 2002:a05:600c:4703:b0:477:7b16:5f78 with SMTP id 5b1f17b1804b1-4778feb2569mr101927765e9.37.1763371252899;
        Mon, 17 Nov 2025 01:20:52 -0800 (PST)
Received: from localhost (p200300f65f0267084b5b83b709547c98.dip0.t-ipconnect.de. [2003:f6:5f02:6708:4b5b:83b7:954:7c98])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4778bcfa2e9sm108025145e9.12.2025.11.17.01.20.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 01:20:52 -0800 (PST)
Date: Mon, 17 Nov 2025 10:20:51 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: git@vger.kernel.org
Subject: `git submodule update --single-branch` tracks HEAD instead of branch
 from .gitmodules
Message-ID: <xmkf25oq2vka2kipfqfybngkqffbljqygmtrtiujgsrao7g2wq@k56wxix4oism>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="krczbyzehoefmdtn"
Content-Disposition: inline


--krczbyzehoefmdtn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: `git submodule update --single-branch` tracks HEAD instead of branch
 from .gitmodules
MIME-Version: 1.0

Hello,

for a project I'm using several submodules, showing my issue with just
one of them

	$ git ls-tree @:layers | grep poky
	160000 commit b33a8abe77081a2bdda0d89c61736473b2f9bb8b	poky

	$ cat .gitmodules=20
	...
	[submodule "yocto_poky"]
		path =3D layers/poky
		url =3D https://git.yoctoproject.org/git/poky
		branch =3D scarthgap

	$ git submodule update --init --checkout --recursive --single-branch
	...
	Cloning into '/home/uwe/work/sri/poet-server/layers/poky'...
	remote: Enumerating objects: 8775, done.
	remote: Counting objects: 100% (3119/3119), done.
	remote: Compressing objects: 100% (158/158), done.
	remote: Total 8775 (delta 2974), reused 2961 (delta 2961), pack-reused 565=
6 (from 1)
	Receiving objects: 100% (8775/8775), 3.24 MiB | 15.45 MiB/s, done.
	Resolving deltas: 100% (6158/6158), completed with 391 local objects.
	From https://git.yoctoproject.org/git/poky
	 * branch                      b33a8abe77081a2bdda0d89c61736473b2f9bb8b ->=
 FETCH_HEAD

so far so good. But:

	$ cd layers/poky/
	layers/poky$ git remote show origin
	* remote origin
	  Fetch URL: https://git.yoctoproject.org/git/poky
	  Push  URL: https://git.yoctoproject.org/git/poky
	  HEAD branch: master
	  Remote branch:
	    master tracked
	  Local branch configured for 'git pull':
	    master merges with remote master
	  Local ref configured for 'git push':
	    master pushes to master (up to date)

So in this submodule master is tracked, while I think it would be much
more sensible to track the scarthgap branch. The further consequence is
that

	$ git submodule update --remote layers/poky/
	fatal: Unable to find refs/remotes/origin/scarthgap revision in submodule =
path 'layers/poky'

This happens for both git version 2.47.3 (which I typically use,
provided by Debian), but also on current git master
(2.52.0.rc2.22.gc93f1a0fa3eb).

Best regards
Uwe

--krczbyzehoefmdtn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmka6PAACgkQj4D7WH0S
/k7kNwgAi/EgjioGrBg589zeNJxg5JXz+rosinDnl9T0DefgRbabXC3g/II/d2Kl
ER094R3riud2IeDPLd+XybitvDk3zGjzA5W+oinfpQ5v5UyIFROg0uYY95ELZ6PK
TzyszzaMsIScmOtpZo1cp93ZeQZJAumO7uh0/59X3uKY+l/vxwq8skqB0+K5u6MH
aCOOLQa+fercsmEJzTMW9h1NXkicySjIMgSjJVVrftZ90KGFbTO6TLIvyrqoyDl7
3KhzB+/9U1TZCJXBbm/l0AYJ2yZh+YhwTGosZwf8oIlUJ5gn3CurGXZ4AWpvlXXd
umHXp9d3IwTQ9Wc+QsDHoF3GP51hzw==
=OY0W
-----END PGP SIGNATURE-----

--krczbyzehoefmdtn--
