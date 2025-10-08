Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2B82F5339
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917180; cv=none; b=DNeFU7JK+Anu+kmdzu3INlvmEmOBjBgpOvwWtIt8JREx7ApFXrx4WoEMlNpRZBwA2yghHCQm8bBS83YXdmryaq0eu/6xL3XszOQ23PyiBDJrc7JFo2tbSMkWWS1llofuwBsgqNlezJGmbZYbi1dM1C5TuNj80MIbCrprYdn2eVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917180; c=relaxed/simple;
	bh=tJ9O+VHd5WN8t4iozqVt3hZZBEMip24ZQwtz5LZRw2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzMyHv0PgaNG0Db640oXV2nfFrciJFFpmcd2+VFeN0FFsZMBHJhpnlLZmCfGkOKuALkMAq7f7IEXcrZ1KvYzbfpuxqWYZV0t1lN/BuyU9h9WmICX4vbUc3iWteEBobTR+/J85cynO8YU+d+MnNs6IBRoYvgeXiBXdIb5u81v250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCJAiI+m; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCJAiI+m"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b50645ecfbbso242186766b.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759917177; x=1760521977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3rb6qTauR2kCRjyoaqkEW/ZgrwvD51GRDj7lErDrZs=;
        b=kCJAiI+mYgm2ieMni1Pb/7mXQaVZ9vTbk6PhN4pSU8KjTs67jsMq5oXSsTw4YJyxYw
         RHyxphixylzLsHDs3sAHKLMesqcVjTjmm5os8aNA4iqU8I8XubYJCmU3ecWmW8b5Nb+u
         GnbVScA22jHD6K2GnDgZn5iul2R2SoMegmyqTS7qNMFbnJyMic/3AeluZWgcsyLeyiFo
         T0SwMkHpJ+NxMPF/NKbLumCE2iqGSWVnC3a3xEI637cgaidx0BoVFuE3/Ien/niPSN9z
         dxpfB5kJuYwf5Bd1hvoD1iD7EcvxHyCwPc4pbsje0G/MV8bECO8EGpgCM8UkUop8sGr0
         ZVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759917177; x=1760521977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3rb6qTauR2kCRjyoaqkEW/ZgrwvD51GRDj7lErDrZs=;
        b=Um3o+oCiWNwkhpQZqahcVzggm2oxIT0zo7/Mt0ixzlOteL675Sp0JnsE571C8FRsBg
         t+EFpt2OCTHTB5KiAvJSZSkS9rhYo7Jx7lM/9eZEaQ56GU6+QBshAhNQHES8OTMI7ofl
         FeoavLMh9aJ1kACQL2+4QmnpVLGr/G9FqlHPH9JPbNO0FeIB7F2hi7FWHOokAnZD4/T7
         ThFUlEAGgjLZW/9t1YdTHvapv04fHWcEopZj9W9TV4h1+i/ervBHkxaFZffYQfQvAj8G
         XM8Bb0Yak/FzJnjgkZAcR6IaeOGGCUD3EAGp0M3nRVMtg/74nO6IHOvQxiW9YbiI+SBR
         Q8MA==
X-Gm-Message-State: AOJu0YylEPrIY5L+kjWg8vPiKuis/0EGzTKskB1t3Llxo5ipsCWkS0Uu
	/FPUqwjj6X68huf9gOsrCI9t3WQT8Lx+47PK8n4UCcWVHRJvdcz8SfqV1Zqs6mYIwClSnoSOYw5
	++2UbE0+CFhqAL5sgH1LCxn800EZKndA=
X-Gm-Gg: ASbGncvyWDLxReIFsoT5QO0LMiaAQ1gRoq+el8XSyxPnANcc7elvEVE4JQE2FTrLhOE
	TPXqBGX1RHQaw4K+ywkDPEZMgj5X/BzYjFKzJbI8IpK1Z2SlyAOZlN4NNpfUeLfcmEPwAkXtAzS
	LCpQBIpXdZJj05F5hGKtuzYqgtinjqcU+d4Nk4hwxemqYUnuU41d+yffOzGLOhhIhcgiXeq1GL9
	6/uVwWAtxzZH9NSmM/T+vQIljpphp8ywosP44Esfw==
X-Google-Smtp-Source: AGHT+IEOhWQJ7J8TxpV/ezQHqkHe5Bom9DtNxoZ7JoZr1coRGsn8kEJQt/viYNac/5DCCTdglTNzv8trofR1ZeXe3Qs=
X-Received: by 2002:a17:907:3e9f:b0:b4b:e419:9af9 with SMTP id
 a640c23a62f3a-b50aa492052mr308281066b.23.1759917177231; Wed, 08 Oct 2025
 02:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-2-christian.couder@gmail.com> <aOYPRKoexRtYUDsh@pks.im>
In-Reply-To: <aOYPRKoexRtYUDsh@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 8 Oct 2025 11:52:44 +0200
X-Gm-Features: AS18NWB-P5Lx19QpvUDtVE5a-mU5xFVNFc3z2ZWob7MfLh7DTEb9PqhgPbd4KSM
Message-ID: <CAP8UFD0UJt+L9Ri4VyWJ-1M4Si2q=i5xG_=a315G9m1NFvXnQA@mail.gmail.com>
Subject: Re: [PATCH 1/5] doc: git-tag: stop focussing on GPG signed tags
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 11:21=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Oct 07, 2025 at 02:29:54PM +0200, Christian Couder wrote:
> > diff --git a/Documentation/git-tag.adoc b/Documentation/git-tag.adoc
> > index a4b1c0ec05..9117754ffb 100644
> > --- a/Documentation/git-tag.adoc
> > +++ b/Documentation/git-tag.adoc
> > @@ -3,7 +3,7 @@ git-tag(1)
> >
> >  NAME
> >  ----
> > -git-tag - Create, list, delete or verify a tag object signed with GPG
> > +git-tag - Create, list, delete or verify tags
>
> This is an obvious improvement.

[...]

> >  Tag objects (created with `-a`, `-s`, or `-u`) are called "annotated"
> >  tags; they contain a creation date, the tagger name and e-mail, a
> > -tagging message, and an optional GnuPG signature. Whereas a
> > -"lightweight" tag is simply a name for an object (usually a commit
> > -object).
> > +tagging message, and an optional signature. Whereas a "lightweight"
>
> Nit: let's rather say "cryptographic signature" here.

OK, I will make this change in V2.

> > +tag is simply a name for an object (usually a commit object).
> >
> >  Annotated tags are meant for release while lightweight tags are meant
> >  for private or temporary object labels. For this reason, some git
> > @@ -64,10 +65,12 @@ OPTIONS
> >
> >  -s::
> >  --sign::
> > -     Make a GPG-signed tag, using the default e-mail address's key.
> > -     The default behavior of tag GPG-signing is controlled by `tag.gpg=
Sign`
> > -     configuration variable if it exists, or disabled otherwise.
> > -     See linkgit:git-config[1].
> > +     Make a signed tag, using the default signing key. The signing
>
> Same here, let's say "cryptographically signed tag".
>
> > @@ -75,7 +78,9 @@ OPTIONS
> >
> >  -u <key-id>::
> >  --local-user=3D<key-id>::
> > -     Make a GPG-signed tag, using the given key.
> > +     Make a signed tag using the given key. The format of the
>
> Same.
>
> > +     <key-id> and the backend used depend on the `gpg.format`
> > +     configuration variable. See linkgit:git-config[1].
> >
> >  -f::
> >  --force::
> > @@ -87,7 +92,7 @@ OPTIONS
> >
> >  -v::
> >  --verify::
> > -     Verify the GPG signature of the given tag names.
> > +     Verify the signature of the given tag names.
>
> Same.

It's a bit cumbersome to have to say "cryptographic" or
"cryptographically" everywhere though. Maybe saying it a few times at
the beginning is enough?

> > @@ -236,12 +241,25 @@ it in the repository configuration as follows:
> >
> >  -------------------------------------
> >  [user]
> > -    signingKey =3D <gpg-key-id>
> > +    signingKey =3D <key-id>
> >  -------------------------------------
> >
> > +The signing backend is controlled by the `gpg.format` configuration
> > +variable, which defaults to `openpgp` for GPG signing. To sign tags
> > +using other technologies like X.509 or SSH, set this variable to
> > +`x509` or `ssh` respectively.
> > +
>
> It might make sense to use a bulleted list here to list the different
> available formats.

What should we say about each format though?

> On the other hand, we could just as well refer to
> git-config(1) so that we don't have to repeat any of the information
> here, but instead have it at a central place.
>
> That might not be worth it though. In the end there aren't too many
> different commands that write signed objects.

I think this CONFIGURATION section should talk only briefly about the
most important config options and refer to the git-config(1) doc for
details and less important config options. So I am not sure what you
suggest exactly about this.

> Overall this change makes a lot of sense to me, thanks!

Thanks.
