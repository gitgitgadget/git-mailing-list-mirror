Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971211684A4
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985938; cv=none; b=usaVfaUYzNK/pxDSZIGRx64ZLWJgsLys+JQaXo9EzSZq5/UpgTvDNXNAYFfAJJI4+SstJ/zpngVuc1UByXOaAPt6HO4ROPyfKIMlf1R4/Ei2oU+4k/mHvVGUHnnJe08c0JUxooHSxRdE+BVPkLFC1Umphioo9cykVbuK37lrdAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985938; c=relaxed/simple;
	bh=h2bcHr6tWE9u+TyfXkmSNDBKTOA1c58+DMl6TnUUt7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xjkh5TPze+7y2bpFscL1PkT5rOO5JOyg1iVM8lJa/RrltEEwRwViNJDTh8ptpXuRiRIAkPC4mpzjLouN+jA4smVKNmuegZ1OF4y7dPgOWQxjbdhUJggxJADCcrY8RMg2KmRmtL18ywgV1L65/RZLchaTFO+4ei0d7NkuIUUlmtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvarqC8+; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvarqC8+"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5365cf5de24so4408621e87.1
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725985935; x=1726590735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Zn2Q3nSS5czs09yo/R7TVyR/AHBP8HWlWaBFJ22qmY=;
        b=IvarqC8+Yy5UbyCjkqgAkZWuc4Cy71WlLFiTbXRHpWNrq3Gyg1LT+eqyxGpU+Z3XPN
         mK3DxVE8wslHi9YGEzWho9gg95rFTcxK7RtHzVlGRBnQqu+wfoNwL03F/IIsyK4RdxQm
         MqvpnHp6428metfcHYsM78MrxVlo0h5ZpWkex9SHGVR6sMEEoTA606lUeemZc0rdKiqv
         yC4ZP1ZBe4U0oZdXxPikiEtCo9oQ4r3YAOfySCJxT7mv1Nqq2JsxYiG1ujhf3Zwf4Rng
         FDGVn4l7U1zGuEA4K1WfQ9Sf4wGzzdze79XMZ/vXIULm4OQdFdzp5dvN6JjemFV8X6Je
         YqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985935; x=1726590735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Zn2Q3nSS5czs09yo/R7TVyR/AHBP8HWlWaBFJ22qmY=;
        b=vwKR+cphASMUXAq1c38e/a3/mukpYjL1qQK4dFyuxsBcTF2gHRo7G0vVTP1ZeZAG4t
         p/ju/S1i5QQJzpLBkuzVZ/a7E7u7O9i60ks7/P5ybfcPaPJxkONd4bJ4pu2+JLsa+IMV
         uY8GO0+80LDXBJ6LKUe6DtUB+VskYzNB88Eh8AqlEjqKgsG3W1zSqJ/E1o61xEej+6xW
         358I5gBAsZ1joqsYY3kx7CgzAsB0FXxpsmiL3CJ2s+/xMFO9hUjzqddpNVfSq9n+kiCj
         Jmq6j1TqtCTgBICn1O58FO9JnwyxxTf44QG0fE6WvUC13CwGIq6EYXE0i12j5+9QW7VC
         gvrg==
X-Gm-Message-State: AOJu0YyEBnSYJlQ9OJsSSI478KqeJmcEX4xnXv5aVpidZg65BMUgIVH/
	SSWLLiorlSqEsUpNAwmmHEZp1I1Hz58Dbgj4kVHr3y5ZRZJEpkpxN1J+EjiY7S1V1KPikyqwcSD
	CQGGd9zNiYyIjc0BSPBD3r30jr4s=
X-Google-Smtp-Source: AGHT+IEnNbIOmQRVVgbe0yS3m0R9m8r6z8X9LGgGDDyrp9JZc3O0Fc5TRjsxwOkWXqHY1i040YNSpDFi382aQ3xIC9w=
X-Received: by 2002:a05:6512:694:b0:536:545c:bbfa with SMTP id
 2adb3069b0e04-536587ac1e7mr7892720e87.20.1725985934174; Tue, 10 Sep 2024
 09:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240731134014.2299361-4-christian.couder@gmail.com> <ZqpjV/A9ZVPDiGgA@nand.local>
 <CAP8UFD2OR=5QvyFT6EGQkekFBtjRWoMShQ=_eT=ypH=FswUaRA@mail.gmail.com>
In-Reply-To: <CAP8UFD2OR=5QvyFT6EGQkekFBtjRWoMShQ=_eT=ypH=FswUaRA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 10 Sep 2024 18:32:02 +0200
Message-ID: <CAP8UFD1DQ6jGcnc_t=GQPmnfx2s63NLxyvSJ6V+vVQBU9m_MCA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 1:32=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Jul 31, 2024 at 6:16=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wro=
te:
> >
> > On Wed, Jul 31, 2024 at 03:40:13PM +0200, Christian Couder wrote:
> > > diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprot=
ocol-v2.txt
> > > index 414bc625d5..4d8d3839c4 100644
> > > --- a/Documentation/gitprotocol-v2.txt
> > > +++ b/Documentation/gitprotocol-v2.txt
> > > @@ -781,6 +781,43 @@ retrieving the header from a bundle at the indic=
ated URI, and thus
> > >  save themselves and the server(s) the request(s) needed to inspect t=
he
> > >  headers of that bundle or bundles.
> > >
> > > +promisor-remote=3D<pr-infos>
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +The server may advertise some promisor remotes it is using, if it's =
OK
> > > +for the server that a client uses them too. In this case <pr-infos>
> > > +should be of the form:
> > > +
> > > +     pr-infos =3D pr-info | pr-infos ";" pr-info

[...]

> > I wonder if it would instead be useful to have <pr-infos> first write
> > out how many <pr-info>s it contains, and then write out each <pr-info>
> > separated by a NUL byte, so that none of the files in the <pr-info>
> > itself are restricted in what characters they can use.
>
> I am not sure how NUL bytes would interfere with the pkt-line.[c,h] code =
though.

As Junio said pkt-line.[ch] is about <length> and <bytes> and it is
used to transfer the pack data stream that can have arbitrary bytes,
so there is no problem with NUL bytes. Sorry for not checking.

However I still think that capabilities have been using a simple text
format for now which works well, and that it's better to respect that
format and not introduce complexity in it if it's not necessary.

For example t5555-http-smart-common.sh has:

cat >expect <<-EOF &&
    version 2
    agent=3DFAKE
    ls-refs=3Dunborn
    fetch=3Dshallow wait-for-done
    server-option
    object-format=3D$(test_oid algo)
    0000
    EOF

to check the capabilities sent by `git upload-pack --advertise-refs`.

t5701 also uses similar instructions to check protocol v2 server commands.

So I think it's nice for tests and debugging if we keep using a simple
text format.

Also writing the number of <pr-info>s and then each <pr-info>
separated by a NUL byte might not save a lot of bytes compared to
urlencoded content if necessary, as I don't think many special
characters will need to be urlencoded most of the time.

So in the version 2 of this patch series, I haven't changed this.

Thanks for the review.
