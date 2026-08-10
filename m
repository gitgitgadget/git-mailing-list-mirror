Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D813955C4
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360634; cv=none; b=coCdSEWVtTfGXcsv8B57GZcggsI/Y7kKHePel6YY8u3dsLzAGKzEmhbScli0a35dbhb7idsU7DFKVHM9BuUWiUqBrniqhg3wg0NRryLw5rSH6Q9Rl010Z/nFH4TWoT7O8gEn320t3BeZqZMVbyQF9OlKYD1IzT5NpwHp5nrSoX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360634; c=relaxed/simple;
	bh=0JDEnysb73jJfMBQDkutY3q+7/vf03qN3P70bo6a5xw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Z4r5Tb6EVV1bGvIQQrXP5rGNZKzqkCF2xBZoG/afDxXoDd0dS2YXPakZHzmYjJCVOqsFiNy1FVrIgKX9hwhzyo6S0ZqSNrPYiRGVbU9ICvjO2DQgrZFRL1mNNkTbYkwJKSVM99HMPp+j6ROiN2diQ/Jeetf4xc0Wv/Dq8F4yoPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkcgSUNz; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkcgSUNz"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66896892b6cso2456710d50.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786360632; x=1786965432; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tsiVLjXESU8/TRsfSIFKbqlpntS6M1OeKUEfY5SeZG4=;
        b=VkcgSUNzrIml35Wp0ppT9BNQzJFOnQpnGSjXRj7twATNMdFwz+1K7ppesnkJcjWC3Z
         oienu8NgKqhfSe0mbR+oL/bZU8RLePtaOeIJN/j5oIPHahcwXtygItgfrZDD9nH4SnMg
         VGpLYoISP0r097IGeClrSOZF0u2/XgnF5YXIpEGH0QkcY+ht8H9RvczCyD4dscsaJkgW
         VATMmbEgQAduosg7+QEnZsw1HFb/zcvmKtptVf8faXYLi3XIvhDlYfIbPCLUEF7pTSPV
         C9d9yMoP2L9g53Ajhhs2WQ+SiPLaHAbmEKXrxNOKm7U7MYfWq4k84IgaE0s3PZvi/wI9
         0i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786360632; x=1786965432;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsiVLjXESU8/TRsfSIFKbqlpntS6M1OeKUEfY5SeZG4=;
        b=c3wbAAwf+cc0HX55Bqq+rQ3HWtLXhD2QZX/3vqtfnwUtF5dCCLBSNBtDPT48fKwSnT
         wLu2p6rOvQ/uUm/jEuPFlTN6Ve5liHePomFqk0A1mc/wjSuxTza0EaEqKp0e0vCzcBVQ
         SvnAEygiTYEjI3+rkcp9aowelZEeoZJwh+88k32nLnXBixLBE9vdQJM6kqeY02OQ/Ch2
         psT5DzcftP/QXdwS0gveDOFYg7xyY+yNWZvvhzJoTecOmk7tbsVw0S3rUvA7+v8Pi2Cq
         zdZMSPWPuWzZ/MYMtNdRjWT1k5cWOpF/YsP6nRus4DEygVgGPfEv+x6j8YiiHqNrh/Lx
         /tHQ==
X-Gm-Message-State: AOJu0Yyj0+Klxm15sB4ePrKSz9FdJ9l01V6t5pe9PhrtVN42BaYBm2Mm
	/FwwD79bLa+wsClxuW7gCar2H0P9XyFrKtxuq8oRAH99vmoQDrNXuCOTNLuV+GvXyZ8=
X-Gm-Gg: AR+sD13Y2TDgzZPV2Mvgk9fj0KR1apO3Pu17OQDTsi7gMFZ4ZdBbIh8JQaXujpzsiW/
	acbV9Y6QOADivc1FAxRHI7UEd9gTwaelZ1AVoP9yruaQkbIpqr0F8OdKJK9lfQp+RFCrE9V2cnp
	7J65psJy7UXkUZjjGTFy4wrq4p6KWc190co5ibo3l+yfRLLs8s5Ar3sNG6HYTdUqJnevWAz3pT9
	FxvLn58NVlx9CUxFrBiV3TweUVJY4BUNQLL5nP0ROKEr5zzDZePAFJhSeQV6dJTuMFIWXS3MnM2
	g1O2uOkZiSzfO2YxOEGhMjnW4rQPtQG1+e8hWs629h34+8fzweCBy5ldFXcg0+f6XfalLm416jS
	Bql5A6XLsjXLV8kTaWk7++8SniSGy7V5HhdzFRBTRxnEivlVvTpm4VsaUbZYK23cGCK7okhwabZ
	OIsY64VQj1mQ9d6qRp+ys2CK0j9GqvmCMldPlsHJNLnNe1L6z2DKeczJ5RDuSt9rik03ESVAXGk
	979fqgGP/kDTFBAz68sgKRW6r9BBY8nLgtqtzekdR0MqM92dLo/JJf3k0JWiHd1Ebh6Svj5lYeJ
	OGAyqdGb9pFVZe2fNejnJBucPKa/9rzSe4wY
X-Received: by 2002:a05:690c:892:b0:81e:79f0:48b8 with SMTP id 00721157ae682-82d29d0a3afmr3248067b3.7.1786360631976;
        Mon, 10 Aug 2026 04:17:11 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:c44:77d0:325f:ec73])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823efbf208esm53756617b3.10.2026.08.10.04.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 04:17:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5 00/11] doc: interpret-trailers: explain key format
Date: Mon, 10 Aug 2026 07:16:56 -0400
Message-Id: <0687D60D-DF6B-4547-868C-FCFC5B27ECAF@gmail.com>
References: <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
 christian.couder@gmail.com, Brendan Jackman <bhenryj0117@gmail.com>,
 Linus Arver <linus@ucla.edu>, Matt Hunter <m@lfurio.us>,
 Junio C Hamano <gitster@pobox.com>
In-Reply-To: <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
To: kristofferhaugsbakk@fastmail.com
X-Mailer: iPhone Mail (23D8133)


> Le 9 ao=C3=BBt 2026 =C3=A0 16:07, kristofferhaugsbakk@fastmail.com a =C3=A9=
crit :
>=20
> =EF=BB=BFFrom: Kristoffer Haugsbakk <code@khaugsbakk.name>
>=20
> Topic name (applied): kh/doc-trailers
>=20
> Topic summary: Explain the format of trailer keys (alphanum and
> hyphens). This is important to keep in mind so that metadata is not
> lost to simple syntax errors. Also replace some terms and define the
> important ones upfront.
>=20
> Here one change lead to another in order to make sure that everything
> stayed coherent. So here=E2=80=99s a linear overview of the changes (as of=
 v4):
>=20
> =E2=80=A2 Patches 1=E2=80=933: remove RFC 822 mentions, =E2=80=9Cmetadata=E2=
=80=9D term
> =E2=80=A2 Patch 4: This command is not just for commit messages
> =E2=80=A2 Patches 5=E2=80=937: Explain the format in the simplest case, ex=
plain
>  the =E2=80=9Ckey=E2=80=9D format, and add a new example
> =E2=80=A2 Patch 8: join some existing paragraphs that are about the same t=
heme
>  since that makes the text flow better
> =E2=80=A2 Patch 9: Also use the =E2=80=9Ctrailer block=E2=80=9D term intro=
duced to the doc in
>  patch 5 later in the doc
> =E2=80=A2 Patch 10: Rewrite new-trailer paragraphs (relates to patch 8)
> =E2=80=A2 Patch 11: document line comment behavior
>=20
> Thanks to everyone who has been reviewing these so far. I understand that
> these eleven changes are very incremental and piecemeal (see =E2=80=9Cvery=

> cross-referenced commit messages=E2=80=9D). And the commit messages can be=
 quite
> long, just to explain (again) very small changes. See for example patch
> =E2=80=9Creplace =E2=80=9Clines=E2=80=9D with =E2=80=9Cmetadata=E2=80=9D=E2=
=80=9D in this version, where I explain why to
> write =E2=80=9Ctrailer metadata=E2=80=9D instead of =E2=80=9Ctrailers meta=
data=E2=80=9D. But right now I
> feel like prose sometimes needs all this ceremony. With code you get
> restraints like coding style, then you have all the years of looser rules
> about when to use certain data structures, when to make helper methods,
> etc. But with prose it seems that you bring much more of your individualit=
y
> to it. That means more choices, and many of them are not obvious to the
> reader of the document, which means that you need to explain it in the
> commit message. Then you also have to consider the writing history of the
> document, and this one is twelve years old at this point; see the history
> review in commit message =E2=80=9Cjoin new-trailers again=E2=80=9D, after t=
he thematic
> break (***).
>=20
> =C2=A7 Changes in v5
>=20
> Patch =E2=80=9Cdocument comment line treatment=E2=80=9D: commit message: a=
dd missing word:
> s/to/to be/.
>=20
> =C2=A7 Apologies for very cross-referenced commit messages
>=20
> (see v3)
>=20
> =C2=A7 Cc
>=20
> (see v2)
>=20
> https://lore.kernel.org/git/V2_CV_doc_int-tr_key_format.613@msgid.xyz/
>=20
> I have also added a new email since the email jackmanb@google.com bounces
> for me. There is a Brendan Jackman who has posted messages under a Gmail
> address. Hopefully it=E2=80=99s the same person.
>=20
> =C2=A7 In-reply-to: v1
>=20
> The recommendation to reply to the first version/cover letter is from topi=
c
> ps/doc-recommend-b4, which is in `next` right now.
>=20
> =C2=A7 Link to v4
>=20
> https://lore.kernel.org/git/V4_CV_doc_int-tr_key_format.ae2@msgid.xyz/
>=20
> [01/11] doc: interpret-trailers: stop fixating on RFC 822
> [02/11] doc: interpret-trailers: replace =E2=80=9Clines=E2=80=9D with =E2=80=
=9Cmetadata=E2=80=9D
> [03/11] doc: interpret-trailers: use =E2=80=9Cmetadata=E2=80=9D in Name as=
 well
> [04/11] doc: interpret-trailers: not just for commit messages
> [05/11] doc: interpret-trailers: explain the format after the intro
> [06/11] doc: interpret-trailers: explain key format
> [07/11] doc: interpret-trailers: add key format example
> [08/11] doc: interpret-trailers: join new-trailers again
> [09/11] doc: interpret-trailers: commit to =E2=80=9Ctrailer block=E2=80=9D=
 term
> [10/11] doc: interpret-trailers: rewrite new-trailers paragraphs
> [11/11] doc: interpret-trailers: document comment line treatment
>=20
> Documentation/git-interpret-trailers.adoc | 88 ++++++++++++++++-------
> 1 file changed, 64 insertions(+), 24 deletions(-)
>=20
> Interdiff against v4:
> Range-diff against v4:
> 1:  2419b1a6863 =3D  1:  2419b1a6863 doc: interpret-trailers: stop fixatin=
g on RFC 822
> 2:  859ab42ac41 =3D  2:  859ab42ac41 doc: interpret-trailers: replace =E2=80=
=9Clines=E2=80=9D with =E2=80=9Cmetadata=E2=80=9D
> 3:  ab5b4af970e =3D  3:  ab5b4af970e doc: interpret-trailers: use =E2=80=9C=
metadata=E2=80=9D in Name as well
> 4:  b79ddf3b13e =3D  4:  b79ddf3b13e doc: interpret-trailers: not just for=
 commit messages
> 5:  e7101eb1fcb =3D  5:  e7101eb1fcb doc: interpret-trailers: explain the f=
ormat after the intro
> 6:  557b5b5564a =3D  6:  557b5b5564a doc: interpret-trailers: explain key f=
ormat
> 7:  eee81fc99fa =3D  7:  eee81fc99fa doc: interpret-trailers: add key form=
at example
> 8:  cd3e47459c7 =3D  8:  cd3e47459c7 doc: interpret-trailers: join new-tra=
ilers again
> 9:  c50b6d25170 =3D  9:  c50b6d25170 doc: interpret-trailers: commit to =E2=
=80=9Ctrailer block=E2=80=9D term
> 10:  c11a116605e =3D 10:  c11a116605e doc: interpret-trailers: rewrite new=
-trailers paragraphs
> 11:  7d20cb7528f ! 11:  cabbb05a1c4 doc: interpret-trailers: document comm=
ent line treatment
>    @@ Commit message
>=20
>         Comment lines have always been ignored but this is not documented.=

>=20
>    -    The primary motivation here is to reasonably complete in the
>    +    The primary motivation here is to be reasonably complete in the
>         documentation of how trailers are parsed; this is after all the on=
ly
>         documentation page that documents this format. However, and going b=
eyond
>         that point, we could imagine that someone would want to use this f=
ormat
>=20
> base-commit: 5361983c075154725be47b65cca9a2421789e410
> --
> 2.54.0.22.g9e26862b904

I=E2=80=99m trivially satisfied with the range-diff (note again I=E2=80=99ve=
 reviewed primarily the end result, not the per-commit history).

Best,
Ben=
