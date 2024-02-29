Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA57A71D
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204465; cv=none; b=O5GbCpaKHbUVO3Ro/pq6tvpCjs0xHOKiiSHBZGJkkQ1ER2eBcLI28SdUmPtDxZNZ3e/4rtk8UhAdgT4dSKDpUk5uxzISqjB/vfpaO+NGUQmlJhJAjlFrHxOuAGRqVwsfKdZ25haL3MFddPpTmI7aKffu9/uQkJLRld711zpfcls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204465; c=relaxed/simple;
	bh=wIah4iRYRikTegOAjZBSegj6J5ya24VXB21hL4wzdEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYWwcr35bDp269c3dsPWYUqgMD+GaDJHzC9fztCFRKmrtGv7sL+VRXrNfzSijcIZKDQ3/FMLlCqUC/u4hORQVA9NEnh+3rXuDasNzCYpRcySeo83O5WHXOQTJ6r6LB72gDDapnUsndXOp5PKPdlo/HL3gbHAumfArT0f1zgMzhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5rLpRmI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5rLpRmI"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a445587b796so42466766b.1
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 03:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709204462; x=1709809262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIah4iRYRikTegOAjZBSegj6J5ya24VXB21hL4wzdEw=;
        b=b5rLpRmIyi5WoZrs8BjUdoYqTLn/MuwV+qNAYxejcJCYexnpKjcO1KeojK+uXprqi0
         8Mp1VteriFpFJ9sPIMLX9iWmI+tyJ7MFS0HKgqvhwhhlUtczyLHs9j9YjezKCA2lPoMz
         93YRryxKkDYl24yzd0D1WwQ1LhLsbnl2bTYyU6k9GXbm4job0YTyon9E6ewjcgdmj6mW
         k1nPbEAC11F30IClBMWUAywyXOjEt020EPo2f+z+fsuOIkfDukLvzjXBzbSG3gjnfzuZ
         zBF4yzwxjzKTe6ITCc85qRc4EvlBEW+FDKnkQEo0gDmAgM4sSG0Z/HAUqRV8t9CHY3Bp
         gOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709204462; x=1709809262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIah4iRYRikTegOAjZBSegj6J5ya24VXB21hL4wzdEw=;
        b=YhW9/5LXvcCY59z5d09HeKDH2GoaxDMObbHOIuBtJ12a0ZA8bEdIQ9RW1PG5Q7ciHo
         AQzY/icIKDiMqEjQiBUdmOYPW3EeB75n87lAzYIts9RRBwfQXNpX53JyXe1w0Y7BtwfM
         qox+CRtG2CuqcqF5mESFh9RQDqAVvvdarjz0o3MqDRcwm8jxfooQ3I/wTOe+khZVNHUy
         AKui9z7azQhNuUN80V01+XTXHToSs6fnevmUw6tzsiTx4raiOsFpQHxghleS5xGvjf4O
         LIrPXk/dpXSlaQ9J0uf2nq2XYI/pjGclBks4jyxEMpmG4M4pmZ6m/c/DqSZkUMUCNFfn
         fidw==
X-Forwarded-Encrypted: i=1; AJvYcCV4SUG1Qfp0S3oVu9NPCs6d3U4vOjbXyBNauVcl6Rl1KgqbSae48q/bgZPdV9sDoEI2RV6CEgu7FG5gKoknbI2S10z3
X-Gm-Message-State: AOJu0YzknPLsQDF/ST5wJuxMVzZQaB7HU5IqC8BtaX0u+IwtfapTbYMp
	TYEM4lz44LuID29KDBn8Ys/IPbI4Cs5oD9mPIh/cFqq8xxyGq4LPqqrMUvT107rgCu/BoQ58pTZ
	Iyd67ERahV1kMKnaq8Tw2AQ+OCu8=
X-Google-Smtp-Source: AGHT+IHveZ1AfvjKiUxIzBMWW/AR4QT8VSrQ0ZuE4BZEjp3zuPanOGDqMmgKbSzC5GnWow1Zy8KEPPzwsAf4MRj0V44=
X-Received: by 2002:a17:906:f187:b0:a44:55e8:53b6 with SMTP id
 gs7-20020a170906f18700b00a4455e853b6mr534927ejb.32.1709204462267; Thu, 29 Feb
 2024 03:01:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLTT8SQyBSWC=aqB2SRYmp3kR6RZ+L_-9yckWQf-X9rbzeNBw@mail.gmail.com>
 <11783b8e-472d-4b75-bb48-88138daf16ae@app.fastmail.com>
In-Reply-To: <11783b8e-472d-4b75-bb48-88138daf16ae@app.fastmail.com>
From: ZheNing Hu <adlternative@gmail.com>
Date: Thu, 29 Feb 2024 19:00:50 +0800
Message-ID: <CAOLTT8Sn89Qq68YpTCsiK+_WAPdrsTN1xWxpkuEbhwBWpZgK=A@mail.gmail.com>
Subject: Re: [Question] How to parse range-diff output
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Junio C Hamano <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kristoffer Haugsbakk <code@khaugsbakk.name> =E4=BA=8E2024=E5=B9=B42=E6=9C=
=8826=E6=97=A5=E5=91=A8=E4=B8=80 21:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Feb 26, 2024, at 08:25, ZheNing Hu wrote:
> > Hi,
> >
> > I am currently looking to implement a service that provides a version
> > range comparison based on git range-diff. I can easily parse out
> > commit pair headers like "3: 0bf6289 ! 3: a076e88 dev5," but I am
> > unsure how to parse the details in the subsequent diff patch body.
> >
> > It is not a standard diff output where one can parse out the filename
> > from the diff header, It should be called a diff of diffs. We can see
> > various headers with file names such as "@@ File1 (new)", "## File2
> > (new) ##", or "@@ File3: function3" in different formats. This is
> > confusing. How should we correctly parse a range-diff patch, and do
> > you have any good suggestions?
> >
> > Thanks for any help.
> > --
> > ZheNing Hu
>
> Hi
>
> Note that =E2=80=9COutput Stability=E2=80=9D says that this output is not=
 meant to be
> machine-readable. It=E2=80=99s for human consumption. It=E2=80=99s not te=
xtually stable.
>
> So a new version of Git might break your implementation without warning.
>

It is very regrettable that some crucial metadata from the range-diff
patch cannot be extracted. I can only hope that future range-diff will have
the capability of being machine-readable. Thank you!

> --
> Kristoffer Haugsbakk
