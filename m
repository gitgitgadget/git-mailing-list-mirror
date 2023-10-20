Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32731369
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcttQZQj"
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57D8BB
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:50:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so375123b3a.3
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697770217; x=1698375017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+XAgYFT+r1G+LEWvYVpHxVwdSR92NsgduKo76lUqQ0=;
        b=CcttQZQjy40ggpJeQqxoUAgz01luEPn1D7USNNkGzqDQScKAaEAhh+Nc+9yYTuA/4q
         8KFwQHg8qmA5mEpOueNsp+DQIwdU6+69O5qt9afI5NgoNSMxw4MGUG7+5Vrm2eA6yHfn
         0e2MIPUVucaTkMsZCqOPKe99zDBm5lgiggSzkXll/7WcrFuI9EhthwpRw4A99id2haNj
         L/WM1h5hFg70raLQYI2DPYvDwkkVZQdj4xB8kmPBWWGNGbvXR2QIb68kt23dZ/Vy+YTd
         hGtN7YRal5dtM8ZLiuxx0kfD/vwuy94aCXcO4sjxH+SoJyjBdvkkVYMAU+5B1xmxRVKO
         ZNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697770217; x=1698375017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+XAgYFT+r1G+LEWvYVpHxVwdSR92NsgduKo76lUqQ0=;
        b=utASoPY4XOKb8AgSnu09KhtQX9F1EBMwqAK/OHOjJnE1NcDCH8Z+te7C5FdFIPYowF
         90+cHyMGcS94u717mRkFvgddQgFgtxw3baqf4STwzVrQAuDgJ9xdI1qCmLSssbHUn4R8
         KFP7qoEfxMkjXd1FnZsnv+DUjhstrYRCwKDXZoGA52elPnIeCY5lPXvSGDqUdVzKiELP
         7I/9puPY16WFcAlqXtA/YXXBnJI30XYseHUiCPeDKCtpPhCtg2iLEMAPAccOc8v3MOau
         BDIqPiC2xivi8sCz86VoEcKWim9+BUjvgTQ+u29M6lhMLv/61b2DiJw001WhR8hw0BiE
         57pQ==
X-Gm-Message-State: AOJu0YyonOp4STTN7lFUUkFalqbJaNhManXVsjF5OGbPiKnKAbbCUpFA
	HhaQRNNQoK2C02tHGkFoljbUa1VhpGk=
X-Google-Smtp-Source: AGHT+IH/8awhSTzajcV7XPUTrN887t0WK705hlY9gHguJLiq6HoacaY8jbcSciUcC+F8DIltIBzFbA==
X-Received: by 2002:a05:6a00:2d1d:b0:6b2:7a88:7128 with SMTP id fa29-20020a056a002d1d00b006b27a887128mr580134pfb.22.1697770217120;
        Thu, 19 Oct 2023 19:50:17 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y23-20020aa79af7000000b006b5922221f4sm465262pfp.8.2023.10.19.19.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 19:50:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id BB77192C74B5; Fri, 20 Oct 2023 09:50:09 +0700 (WIB)
Date: Fri, 20 Oct 2023 09:50:08 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Michael Strawbridge <michael.strawbridge@amd.com>,
	Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, Luben Tuikov <luben.tuikov@amd.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: move process_address_list earlier to avoid,
 uninitialized address error
Message-ID: <ZTHq4GHpeGq7D7zZ@debian.me>
References: <ZQ1eGzqfyoeeTBUq@debian.me>
 <20230924033625.GA1492190@coredump.intra.peff.net>
 <ZRE6q8dHPFRIQezX@debian.me>
 <20230925080010.GA1534025@coredump.intra.peff.net>
 <ZRGdvRQuj4zllGnm@pobox.com>
 <20230925161748.GA2149383@coredump.intra.peff.net>
 <ZSal-mQIZAUBaq6g@debian.me>
 <95b9e5d5-ab07-48a6-b972-af5348f653be@amd.com>
 <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bJApmmLg1GARJJWu"
Content-Disposition: inline
In-Reply-To: <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>


--bJApmmLg1GARJJWu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 04:22:18PM -0400, Michael Strawbridge wrote:
> Move processing of email address lists before the sendemail-validate
> hook code.=C2=A0 This fixes email address validation errors when the opti=
onal
> perl module Email::Valid is installed and multiple addresses are passed
> in on a single to/cc argument like --to=3Dfoo@example.com,bar@example.com.
> ---
> =C2=A0git-send-email.perl | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 288ea1ae80..cfd80c9d8b 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -799,6 +799,10 @@ sub is_format_patch_arg {
> =C2=A0
> =C2=A0$time =3D time - scalar $#files;
> =C2=A0
> +@initial_to =3D process_address_list(@initial_to);
> +@initial_cc =3D process_address_list(@initial_cc);
> +@initial_bcc =3D process_address_list(@initial_bcc);
> +
> =C2=A0if ($validate) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # FIFOs can only be read once,=
 exclude them from validation.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 my @real_files =3D ();
> @@ -1099,10 +1103,6 @@ sub expand_one_alias {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return $aliases{$alias} ? expa=
nd_aliases(@{$aliases{$alias}}) : $alias;
> =C2=A0}
> =C2=A0
> -@initial_to =3D process_address_list(@initial_to);
> -@initial_cc =3D process_address_list(@initial_cc);
> -@initial_bcc =3D process_address_list(@initial_bcc);
> -
> =C2=A0if ($thread && !defined $initial_in_reply_to && $prompting) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $initial_in_reply_to =3D ask(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 __("Message-ID to be used as In-Reply-To for the first e=
mail (if any)? "),

Thanks for the fixup! The patch itself is whitespace-damaged, though, so
I have to manually apply it. Regardless,

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--bJApmmLg1GARJJWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZTHq3AAKCRB7tWyQc2rT
CKxGAP0f8s3qNpIP+Ep/BiBOK8y+TkN+gkBG+E76+K767W4LUQEAhdJMnXfUsf/a
xtL4tSKsTcHdwB2lnwZalsrRMWA/hAw=
=cqTG
-----END PGP SIGNATURE-----

--bJApmmLg1GARJJWu--
