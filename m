Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725C71CEEA3
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528794; cv=none; b=lTCeDC1W1Rc5QSe3++InopkwOP3nR2Ns46oLFBLYagOHc29oJde3fR/ZnJ7I2B1kUUdksbE4026miezAZ/4p5HHf0rcwkrVlO8UASwVMvkcBg/aoFhWIRpthg4AuVnqh1DXO4UmJIOIslW1KSRl8lTzkGt91gy3+xBDYp09F28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528794; c=relaxed/simple;
	bh=kaJgPXd9+2y2ffOW4bPYUguT3i9RTeN/Y6nP6vNtxg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ywqpmdo9fbT6CWE1l/3ooIG1MTlKiCByR0CPEeVJ3rzBTvXKkD5Zlv/a91BX3lzDSpraLO/tQdBiRlZJela7HjWUSPx7F90kvHTX7xsoFpm2PGmjpxo+VuIJLhUKtmrxZQhWaCRzti8kyzbXn29yzQB1ht27esw+Ix0GKM+cOLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVO46ORH; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVO46ORH"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e5f6e44727so2854846b6e.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729528791; x=1730133591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy25IRNbHyn4zegg+mVQPZ8myOFqNRgWDwnG8VQrHv4=;
        b=FVO46ORHZ6MGFqoeYPYtRp59lxGLQDT9lSQv10w8qebuSjvzcb9AyKNo08gzNCmmAv
         Ff0OKzr9kBrjyF/h38amypm8EjtwBfj0Ct3JuQ6mss16DQ+ZLTWRbo1KVDUb8mbZyQNQ
         dD8yh67z0wGoED3y3HjPiVHlVRHfaMdvU9SuRFPWAhQgwWhPKxUy97WfIZqpPYzky9V5
         d3fP9mJ6ZZy5Dxqe8Ozm20CEyWCK6mnAaxedXIyrc3kgzgFLsowKM6xU077fJkqSuWPH
         LNfT1DQLZlwdSDkOTQfqy+mYSFvYZ+r9r0zDS6xkfhfCC55zn1rIX/5UkZhDKtul92Ym
         kgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729528791; x=1730133591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jy25IRNbHyn4zegg+mVQPZ8myOFqNRgWDwnG8VQrHv4=;
        b=Ga5FdLVpYd+i3A14OYyEEzCO8s3R2EJWKBuS75YwylmiUscYmM4PBl/ewqWiw3c5d9
         OKWPQTKd8Z9qXL1LbyWU/cMw3W204v7OaSwcBR17C+mgQoTSbdf8+EMj6iV6ED+FH62A
         rRBAJGP279Ubl7Hux4fcP4BlMyP9AVOlqi77h3M/i/gc2hKosYLHhoBx0UksKHz430GI
         70A9TxhqsoVoAm4QlUnpJfqzYTXdqUqcf0oeUFheHgYvZ6o7oOBJ0IZ+KSHohqBzKR/n
         G3cKrzvRhRI7V/EtW+OzbnSuqJaRCkEtvmIo2SAsvppDJ5Ae3GMZZ6tpeAQ00/FRiTKe
         zACg==
X-Forwarded-Encrypted: i=1; AJvYcCU/jrhWJwVuFt1mr3VeSZctulhhLDtfU3t4dTcimKJPoqg7S4J+mOSkVAG37kaSf14Huro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiz7tBZuopa6DW1QHHXWJdtEipUDBSdeQJHgNpXTsANu6qD9oz
	4BqhAjYwyUDo4HIlEELQzrr9a/LRUCsQbqp1d2Y36TaQM3fsz8yuTjDWUAP+X7NfgqRZzn7Jc7P
	/xHOatLCMbhPQgKsAug8dreZMCYw=
X-Google-Smtp-Source: AGHT+IH2J433MjCylaHdavJP9c89y4nkzinKEF3tziy3pgfYNhN618qpTSZvfhSGUc29HzHU5y0gQxuHOUCgAXQBdCk=
X-Received: by 2002:a05:6808:2f0f:b0:3e6:1843:939b with SMTP id
 5614622812f47-3e6184398c2mr2537605b6e.29.1729528791493; Mon, 21 Oct 2024
 09:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com> <5d58c150efbed1a10e90dba10e18f8641d11a70f.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHH-oHE7g09xIR@pks.im> <CAPSxiM_BCz2n-uOOSRk3AsVp-Y7R+1XNfVRt6dH6=fWVBZ6cBw@mail.gmail.com>
 <ZxaClmjrLAJiVxNJ@nand.local>
In-Reply-To: <ZxaClmjrLAJiVxNJ@nand.local>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 21 Oct 2024 16:39:40 +0000
Message-ID: <CAPSxiM9_110YrQiNnYH8rmYd0r13CVX4_97mw_-Wy8k9HJ8cUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] merge: replace atoi() with strtol_i() for marker
 size validation
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 4:34=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Mon, Oct 21, 2024 at 02:24:38PM +0000, Usman Akinyemi wrote:
> > On Mon, Oct 21, 2024 at 2:01=E2=80=AFPM Patrick Steinhardt <ps@pks.im> =
wrote:
> > >
> > > On Fri, Oct 18, 2024 at 01:52:59PM +0000, Usman Akinyemi via GitGitGa=
dget wrote:
> > > > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > > >
> > > > Replaced atoi() with strtol_i() for parsing conflict-marker-size to
> > > > improve error handling. Invalid values, such as those containing le=
tters
> > > > now trigger a clear error message.
> > > > Updated the test to verify invalid input handling.
> > >
> > > When starting a new paragraph we typically have an empty line between
> > > the paragraphs. We also tend to write commit messages as if instructi=
ng
> > > the code to change. So instead of "Replaced atoi() with..." you'd say
> > > "Replace atoi() with", and instead of "Updated the test...", you'd sa=
y
> > > "Update the test ...".
> > >
> > > The same applies to your other commits, as well.
>
> Thanks for noting, Patrick.
>
> > > These are a bit curious. As your test demonstrates, we retrieve the
> > > values from the "gitattributes" file. And given that the file tends t=
o be
> > > checked into the repository, you can now basically break somebody els=
es
> > > commands by having an invalid value in there.
> > >
> > > That makes me think that we likely shouldn't die here. We may print a
> > > warning, but other than that we should likely continue and use the
> > > DEFAULT_CONFLICT_MARKER_SIZE.
> > >
> >
> > Ohh, I understand. Philip suggested this. For the warning, will I just
> > use printf statement or what function to print the statement ?
> > Also, how do I test the print warning statement ?
>
> You can use warning() instead of die(), which will also print the
> message to stderr. You can redirect stderr to a separate file in your
> test, and then grep or test_grep that to ensure that you see the warning
> message.
>
> These messages should also be marked for translation (with `_()`), so
> the result will look something like:
>
>     if (strtol_i(check->items[0].value, 10, &marker_size))
>             warning(_("invalid marker-size '%s', expecting an integer"),
>                     check->items[0].value);
>
> Thanks,
> Taylor
Thank you, I will make the changes.
