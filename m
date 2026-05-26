Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC53BE646
	for <git@vger.kernel.org>; Tue, 26 May 2026 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831310; cv=none; b=uVRyUZ6wjNITFUmIyz12XA49yia0Igmt48Mrr1/SC3ZmlhWf40RHHS9uHuApc3peoIH9NGd7MH9+e4UYVyqm4mpzv6g//UoH6qeK8EzCatqIZXU7bFs03vhTPqTITU8MA8EDlwqdAPBdc30VCrfKkr0zBNaiH0wfJjYc4q86f6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831310; c=relaxed/simple;
	bh=kqgeMrHdcApyb7JJFdIidkKIAx/SzwgCNh0QKNlXrvU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=pWnHd9DljqWox51POHcSS1Clzgu0ErM5nSyT+ALr4fwgbgjS1bSL6ezRRVZPagzFNMZLk5l19hlutephPt+g7D40zm0bODMfs10sIWRTR/bLhwR+PbaskiV0gZOlsc2ZkEluJGopGrePbVD4GVKx5q6VZ7U+mfatSsc/X1MNSz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/7P7cOs; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/7P7cOs"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65c7efdb7d8so11606444d50.3
        for <git@vger.kernel.org>; Tue, 26 May 2026 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779831307; x=1780436107; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnMbiKt0TPjIyMytnly+JFdYPdVH3NyaVhSyB4j1yzk=;
        b=n/7P7cOsVvsTM3Sp/TIu45nQURlk3b2wlDi7GHTlIrppTCmImDWoo5T9kk2D2g608Y
         RQTSTq8Oax+ajnL3Hzlo8oT4MEivjYfGKsfLZ+lOKpk2TDSiJGa+xajV5xhKs+S2uj+J
         MGx++48WM34PDuatT62USwNyaMA70zxnDMEFGaGLPxAwxxSPGGhH93e7wsahepuJ+Rqd
         N47ZVmi30WsHsxuNGaATBNvQWMUvNoBZVa58V9U5CysAed6BEhGMhbT17mETIhAnaoMP
         TGaCppTbvXk/MOJJXOMT+PdoHqqHJmZiGKaVgO5sfd+Eku3q1JNgz4/YYWSkD2fVsIyH
         cquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779831307; x=1780436107;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NnMbiKt0TPjIyMytnly+JFdYPdVH3NyaVhSyB4j1yzk=;
        b=IeN0Pdw5tPfQkz6YBhoZDrTfOoGQmRcE7ncdwhIvt/OaE22x+itVxJprjTtzBU6QiO
         Kjb5G7LnUXh8ViZyKhC475HC/rex8vtHSxPAoc1fSXQYgJlNVVTbiF/cTJxOZD/PPg8t
         vQsWdcZ6Jp1EiBN804hYl1e2nMoMCmBC+i+WXqghjb1QwEMDTkH+SrgQfLXwwNYhXN7E
         i3MbRG5eJ11TES7B43ORu+wMN+qILoRQOTFxNDJSCfXvCWMCaqgiDNqAtANy4bMgU510
         LFiX3WIwOtypEV77bbhJNixAE60M4Hk99qAI+603kDmtddvp49MOxlmfUV/+hWTkuDUH
         PpEg==
X-Forwarded-Encrypted: i=1; AFNElJ8UAY3qG5GVlfcSBw9Awh+rBA7Bm1pa0/rVFcligG+hi2Wv3vAJGhQng0C4uQXsZrNFhxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyruScndqi9EZksViZaYnnoWqko9Fk6mAUTgG6+IGVdrvcZubqZ
	QfN77tJ6sGwHnwUZdZCl1pdvQ7gR4cpzbP8YFRcOT04nvyDp3QlBpYCJ
X-Gm-Gg: Acq92OGJYeZhkubwvOepWvaeUboTBnA7hSK3VW5QLYQXdsoUNzer3R3HVd4PmLxwBqq
	sQQvdjowjLpA/JvqaZ6GEUn4aFOlHS8HfzqVd7yZFLMSng4M4srfuB1BsTEoPH6Co4WlpOb54rc
	QSRgWQwFgEb7RR0ujMd+qzoLMV3E5km59PQwtO+bp56sSFZrETIZXnX/TMF7aM1hh1HVU3cxqom
	DqzGFMhAlysgzXmxO6HjLbPny1avP0gXvcZzbOlwpxppecpzYeUnZcrgZwohJilkzuuEwbwkz+E
	ie+bgKJ0Ocb2uIkHxayS/PgwyqAbjoclVT+Fnuwj0lLUty/HUjdOeYWwRVsKiThJRdXIaFSPnWc
	sXEtC4vwtJ6D48ScPOLz8KcM6gDmLZzybi+Wh4XJw0iTJnUhAM2gwRmp+iG2n83RS+vN8MUEITH
	Cnvwy1pTiCuZypSK1dex9K1lp8x8lestmZiTIiF/qPuvPoklzev6jqnpdLbNWq3jM7PSKA6ephG
	ARlvjrMgkJaO7XRe7Pa3u1I0YDO9Tot637n9beHUlXQgNye8BlpLNTO
X-Received: by 2002:a05:690c:360d:b0:7d0:1583:4cb7 with SMTP id 00721157ae682-7d3353e09a5mr216174007b3.15.1779831307139;
        Tue, 26 May 2026 14:35:07 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:f59e:7784:8709:5b6f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c435b54sm66324627b3.40.2026.05.26.14.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 14:35:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/9] doc: interpret-trailers: explain key format
Date: Tue, 26 May 2026 17:34:56 -0400
Message-Id: <4DD440D4-145A-4A9E-ACBA-8E6ACFA231D1@gmail.com>
References: <fc1f8149-98c2-48e5-9725-08cc21696cb2@app.fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Christian Couder <christian.couder@gmail.com>, jackmanb@google.com,
 Linus Arver <linus@ucla.edu>
In-Reply-To: <fc1f8149-98c2-48e5-9725-08cc21696cb2@app.fastmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 24 mai 2026 =C3=A0 08:41, Kristoffer Haugsbakk <kristofferhaugsbakk@fas=
tmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFOn Mon, May 11, 2026, at 21:23, D. Ben Knoble wrote:
>> Overall looks good to me. Repeating a few points throughout the doc
>> might create headaches if format restrictions are changed, but I think
>> they are essential points worth repeating for now.
>=20
> Thanks for taking a look again. :)

Thank you for working on it :)

>>> [snip]
>>> @@ -81,19 +87,25 @@ trailer.sign.key "Signed-off-by: "
>>> in your configuration, you only need to specify `--trailer=3D"sign: foo"=
`
>>> on the command line instead of `--trailer=3D"Signed-off-by: foo"`.
>>>=20
>>> -By default the new trailer will appear at the end of all the existing
>>> -trailers. If there is no existing trailer, the new trailer will appear
>>> -at the end of the input. A blank line will be added before the new
>>> -trailer if there isn't one already.
>>> +By default the new trailer will appear at the end of the trailer block.=

>>> +A trailer block will be created with only that trailer if a trailer
>>> +block does not already exist. Recall that a trailer block needs to be
>>> +preceded by a blank line, so a blank line (specifically an empty line)
>>> +will be inserted before the new trailer block in that case.
>>=20
>> [not strictly related to this patch, but while we're here=E2=80=A6]
>>=20
>> Even in context, I find the original (and new) paragraph somewhat
>> jarring. In "the new trailer," there's no antecedent for "the
>> trailer", so which new trailer are we talking about? The previous
>> paragraph is about "<key-alias>es" for --trailer=3D"<key>: value".
>>=20
>> We _could_ move this paragraph up one, so that it follows the
>> paragraph on trailers being appended when given with --trailer.
>>=20
>> Either way, adjusting "the new trailer" to "a new trailer" might feel
>> better to me. Other suggestions welcome.
>=20
> The paragraph about new trailers originally came right after the
> separated-by sentence:[1]
>=20
>    By default, a '<token>=3D<value>' or '<token>:<value>' [...]
>=20
>    ------------------------------------------------
>    token: value
>    ------------------------------------------------
>=20
>    This means that the trimmed <token> and <value> will be separated by
>    `': '` (one colon followed by one space).
>=20
>    By default the new trailer will appear [...]
>=20
> =E2=80=A0 1: dfd66ddf (Documentation: add documentation for 'git
>     interpret-trailers', 2014-10-13)
>=20
> Nine years later in [2], a =E2=80=9CFor convenience, <token>=E2=80=9D was a=
dded to that *existing paragraph:
>=20
>    [...]
>    `': '` (one colon followed by one space). For convenience, the <token> c=
an be a
>    shortened string key (e.g., "sign") instead of the full string which sh=
ould
>    appear before the separator on the output (e.g., "Signed-off-by"). This=
 can be
>    configured using the 'trailer.<token>.key' configuration variable.
>=20
>    By default the new trailer will appear at the end [...]
>=20
> =E2=80=A0 2: eda2c44c (doc: trailer: mention 'key' in DESCRIPTION, 2023-06=
-15)
>=20
> A little later in [3], that part was split into its own paragraph=E2=80=94=
and
> expanded into two more blocks (source block and paragraph):
>=20
>    [...] <key> and <value> will be separated by `': '` (one colon followed=

>    by one space).
>=20
>    For convenience, a <keyAlias> can be configured to [...]
>=20
>    ------------------------------------------------
>    key: value
>    ------------------------------------------------
>=20
>    in your configuration, [...]
>=20
>    By default the new trailer will appear at the end [...]
>=20
> =E2=80=A0 3: 6ccbc667 (trailer doc: <token> is a <key> or <keyAlias>, not b=
oth,
>     2023-09-07)
>=20
>> We _could_ move this paragraph up one, so that it follows the
>> paragraph on trailers being appended when given with --trailer.
>=20
> But going back to commit [1], there are two paragraphs that talk about
> how =E2=80=9CBy default=E2=80=9D the new trailer will be appended to the e=
nd:
>=20
>    By default, a '<token>=3D<value>' or '<token>:<value>' argument given
>    using `--trailer` will be appended after the existing trailers only if
>    the last trailer has a different (<token>, <value>) pair (or if there
>    is no existing trailer). The <token> and <value> parts will be trimmed
>    to remove starting and trailing whitespace, and the resulting trimmed
>    <token> and <value> will appear in the message like this:
>=20
>    ------------------------------------------------
>    token: value
>    ------------------------------------------------
>=20
>    This means that the trimmed <token> and <value> will be separated by
>    `': '` (one colon followed by one space).
>=20
>    By default the new trailer will appear at the end of all the existing
>    trailers. If there is no existing trailer, the new trailer will appear
>    after the commit message part of the ouput, and, if there is no line
>    with only spaces at the end of the commit message part, one blank line
>    will be added before the new trailer.
>=20
> These two seem to overlap? They both talk about appending. Why does one
> talk about how specifically <token>/<key> and <value> will be treated
> when appended, then a later paragraph *also* says that it will be
> appended?
>=20
> Here is a draft of this part of the doc. I have tried to consolidate
> these two =E2=80=9CBy default=E2=80=9D paragrahs and be more explicit abou=
t what =E2=80=9Cthe
> trailer=E2=80=9D is. I have included one unchanged paragraph before and af=
ter
> for context.

I=E2=80=99ve read through the below a few times, and I don=E2=80=99t really h=
ave much to add for now :) I think that=E2=80=99s a fine improvement.

Whether you roll that into this patch series or wait until the dust settles i=
s up to you.

> ***
>=20
> Some configuration variables control the way the `--trailer` arguments
> are applied to each input and the way any existing trailer in
> the input is changed. They also make it possible to
> automatically add some trailers.
>=20
> Let's consider new trailers added with `--trailer`.
> By default, the new trailer will appear at the end of the trailer block.
> Also by default, this new trailer will only be added
> if the last trailer is different to it.
> A trailer block will be created with only that trailer if a trailer
> block does not already exist. Recall that a trailer block needs to be
> preceded by a blank line, so a blank line (specifically an empty line)
> will be inserted before the new trailer block in that case.
>=20
> More concretely, this is how the new trailer is added: a `<key>=3D<value>`=

> or `<key>:<value>` argument given using `--trailer` will be appended
> after the existing trailers. The _<key>_ and _<value>_ parts will be
> trimmed to remove starting and trailing whitespace, and the resulting
> trimmed _<key>_ and _<value>_ will appear in the output like this:
>=20
> ------------------------------------------------
> key: value
> ------------------------------------------------
>=20
> This means that the trimmed _<key>_ and _<value>_ will be separated by
> "`:`{nbsp}" (one colon followed by one space).
>=20
> ***
>=20
>> [snip]
>>> -a group of one or more lines that (i) is all trailers, or (ii) contains=
 at
>>> -least one Git-generated or user-configured trailer and consists of at
>>> +Existing trailers are extracted from the input by looking for the
>>> +trailer block. Concretely, that is a group of one or more lines that (i=
)
>>> +is all trailers, or (ii) contains at least one Git-generated or
>>> +user-configured trailer and consists of at
>>> [snip]
