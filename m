Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954A157C9F
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751663502; cv=none; b=Nqald7aMssUTCrUrRQZipKsDckRj+Xwy/KTjV5vswNZnTONE85F2LfJEPRmJxXGGak+FzBSslN6t495K7SuQeTQwSUNa3OoctJTbr+ll/VhqO5p+P0Be9r6Vf3Ivjqx94LIub/SbVwf/2eOTLo/ZqkCyKKKquFEgFpcCfQYrGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751663502; c=relaxed/simple;
	bh=nWTZGML9S1hfVTFqYiaz6Uwdgo3Z+tNcVnlA6tGxvZY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HfaIK6wPzSmwyxLidEWBa4uSD0gbHBEKJhKUpdG2icbSs0I06RtbWDjSgxH3t6PE3Xam43pzsws4ma4hZvWu0AiQBEyoscAvm2qnG3UMKTzIqk/g9TQGdiSqeVveEOiZKNw3Vxqk+nJEQBCyu1hLxV9oiuhWtet1Y/GuQkZZnR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2z2TvwW; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2z2TvwW"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fae04a3795so15949726d6.3
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 14:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751663499; x=1752268299; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QHYUeMN0wXVxCUjpTrnXfsX3kF8+KePgX2qI5MUOPI=;
        b=B2z2TvwWiCC2QdC4o8aC5Aool/IOc1OiOBs96y2J/4HAmvj0RKpJKm3o99n9/QRdG8
         MJP+jQbgJGkdhuUK2Fm8eo37JA2dIch4nbnRXJoSEoOBw/JjgmZiTn863FgiXiMZk07w
         O1E8CdApr7TLFCtTbclm0QCxtbChNTd4PbgQrAsegxet0ZxpjUdavhRnHkC1YIXI338w
         nCnRajuULeGtY/Di5puKDVmVk3sTu4bmcQX9ju/VZ3JLvf/wdITjMXNFB2P5OZD0zboP
         zfKBz+UYAFhdWBKI4ZfWfZ6CYZCpK8YBIECEDc/7mCDBSjoozwEPtS3QFb0jZYRqYbIz
         VMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751663499; x=1752268299;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QHYUeMN0wXVxCUjpTrnXfsX3kF8+KePgX2qI5MUOPI=;
        b=rlCH+ou/4xEqQSbGyuDwZXWvf2p0pExmQvyH1tG6jXcLA+PXpHklv55A8XsO2H4lgg
         IEn08FaUobSFrIL4d2ooWujcEtLuk5gF289uI8CNZj7951ppHcx1ZvipmDvEWp2EHTCD
         h0IgPfS/7m+QNkVIa+kLOjlZ7ulaudLAQEnv/NStBp0WsrrTRbIUJ0FeYvEDjnzUnsWL
         HiUpl4CxVYpSzbvhONEGAO7ijS3GjfD5ixi39T3xE8CxUqkI4sCJI32r8ieoW2OuREsm
         GdGi+EWkzZr8i/O0ACRbUSwrWFzEiOSTlf4Y4MGGNgiIlGnIxsbMhxaIP1Y2HN5t2pcc
         JyHQ==
X-Gm-Message-State: AOJu0YxIkZ1NL7a3H0fIpYWl1AT1Vrd54+bcPZv6r0l+xB4MOxQhdGj5
	wAP9yHq0lc6oxwWaygLvRTtbiX5MK+uD53od4BhYfRNu/33LNeaJbw8M
X-Gm-Gg: ASbGnctyks4Z1SgCJ8xGNt06r31esGRs79vZGPPt/DAP4WRLtJaEGTRrbIVI9V59HLx
	IIBjegZOK4CbuqpCpug/G0K4EL5z3VOTMAp3BAdT8xvxwsGTCfTHPTaKVoeXq5eiQaiUPD294nM
	ouvD5ivYZmFbbgGkyLDltmPm/bMbu/fv24AA5d8YM4JpnJqtZ/77H58Bh5QZ/GdjhcTlMupvS1O
	S/2Cd1vlCVLDD4n3eAEeLH4PFxkPDsxBNY3ko/jDUXEfeGoidlwdnMBLEo8/WVGEmmFVGJiriSh
	UbTl0TYAb8inLCYRUmTGtheSaHQ6CQaNcOhfC8zs+VqhLeL1Ocf4tHPkdEMEPR+J4YU+tlKKufM
	EoCjqRSEA0Qo1Zsck3KQ=
X-Google-Smtp-Source: AGHT+IGlDx/2sC5lo3CVY5WTO7Yg1AFn4DwXr4qnZsofSa/0YjWNjbV9XWM00ZSup18aU/eIRM8vNA==
X-Received: by 2002:a05:6214:f65:b0:702:bf0a:b9d8 with SMTP id 6a1803df08f44-702d169572emr1458446d6.13.1751663499321;
        Fri, 04 Jul 2025 14:11:39 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:934a:f0e9:50b4:12da:e6ee])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4ccd6a1sm18499856d6.39.2025.07.04.14.11.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jul 2025 14:11:39 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH v2 5/7] repo-info: add the field
 references.format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aGZqN-oqctJ79Chz@pks.im>
Date: Fri, 4 Jul 2025 18:11:22 -0300
Cc: git@vger.kernel.org,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FDFCF2E-1148-4531-B957-FC61F42793F7@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-6-lucasseikioshiro@gmail.com> <aGZqN-oqctJ79Chz@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Hm, okay. I guess later patches will add separate enums for each
> category, so this saves us a couple bytes as the number of categories
> grows.

Yeah, that's the idea.

However, even though it saves some bytes (we don't need to keep several =
empty=20
fields), I used a union here mostly because of what it means =
semantically. In
the print functions where I'm `switch`ing between values of one of those =
enums,
the compiler complains if I missed something :-).

> I wonder a bit what it buys us that we have the difference between the
> category and reference format. Right now it feels like it can cause =
more
> errors that it prevents, as we now always have doubly-nested switches.

I reckon that my solution was a little hacky bit, but I tried to solve =
two
things:

1. The plaintext/linewise/null-terminated format can return the values =
in the
order they were requested, like this:

```
$ git repo-info --format=3Dplaintext layout.bare references.format =
layout.shallow
layout.bare=3Dtrue
references.format=3Dfiles
layout.shallow=3Dfalse

```

2. The same is not applicable to the JSON format, where the order =
shouldn't
matter and we can't have the same key repeating. Then it works like =
this:

```
$ git repo-info --format=3Djson layout.bare references.format =
layout.shallow
{
  "references": {
    "format": "files"
  },
  "layout": {
    "bare": false,
    "shallow": false
  }
}
```

but not like this:

```
$ git repo-info --format=3Djson layout.bare references.format =
layout.shallow
{
  "layout": {
    "bare": false
  },
  "references": {
    "format": "files"
  },
  "layout": {
    "shallow": false
  }
}
```
.

I'm still open to changes here. Perhaps keeping the same order in 1. is =
not so
useful from this v2 as I'll always return the name of the keys (like, =
for
example, git-config but unlike git-rev-parse).

> Wouldn't it make more sense to only only pass around the fields as
> `repo_info_references_field`? We could then have two arrays that we
> define globally:
>=20
>    static const char const* name_by_field[] =3D {
>        [FIELD_REFERENCES_FORMAT] =3D "references.format",
>    };
>=20
>    static repo_info_category category_by_field[] =3D {
>        [FIELD_REFERENCES_FORMAT] =3D CATEGORY_REFERENCES,
>    };
>=20
> So `name_by_field[FIELD_REFERENCES_FORMAT]` would yield the name and
> `category_by_field[CATEGORY_REFERENCES]` would yield its category. But
> the benefit is that you only need to pass around the field enum from =
now
> on, all other information is implicit.
>=20
> The reverse information can also be obtained easily. To e.g. get all
> fields of a reference you'd iterate through `category_by_field` and =
take
> all array indices whose value matches the desired category.

A downside that I see is that it seems to be make the print_json =
function
too complex. Currently, the complexities of the printing functions are =
(if
I'm not missing something and ignoring the complexity of data the =
retrieval):

- plaintext: O(n_fields), as it only iterates over the fields

- json: O(n_fields + F), where F is number of possible fields that we =
can get,
  as we first fill the `<category>_fields` variables and then we iterate =
over
  each possible field to find if it was requested

In the plaintext format it wouldn't change too much, it would be still
O(n_fields). But in the json format, it seems that will be something =
like
(in pseudocode):

```
jw =3D json_writer
fields_to_print =3D array with F values set to false

for (field in repo_info->fields)
    fields_to_print[field] =3D true

for (category in all_categories)
    object_started =3D false

    for (field in all_fields)
        if (category_by_field[field] =3D=3D category)
            if (!object_started)
                jw_object_inline_begin_object(&jw, category)
            jw_object(&jw, name_by_field[field], retrieve(field))
   =20
    if (object_started)
        jw_end(&jw)

```

which would be O(n_fields + n_categories * F). To be honest I'm not =
exactly
thinking about performance (which would be in fact negligible in this =
command),
but how complex the code would be. If I understood it correctly, I =
wwould be
trading nested `switch`es by nested `for`s.

But again, I'm still open to change everything again here!

Anyway, thank you for your time reviewing this patch, seeing what I did =
in the
past weeks and joining again the discussion! :-)=
