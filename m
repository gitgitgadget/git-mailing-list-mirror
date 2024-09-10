Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A241A76C9
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985905; cv=none; b=qJBgLpxu1BwG8OiAnDXWHtK1T5McvMgD0u1+2ye5LXZJFW/AJWKc+KsdZX//oQ9ktiXkvVwK77jBisLB+a4Zej8L9NUcEliZIbOzxUUdnLhrIOBq61Py6z/zCcL6PRlmsY0VWT/VuEjs3FtvTq/LObt1OR40qjIY3ZGHOkNh2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985905; c=relaxed/simple;
	bh=YQQEvCL/rzgU+28biSjtsxmC3SGBlzwXNXUW+6ObVrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulfMNithaOcSHdue3sjzRlCE4yPfuXo3uFllSgCxHt+657x2br/O+adcowGH68maNXx38ykKHgYQbbWe2q7qi64mIwDpMVW1HvvfZnR0+MpeaJY7gVjZ2TR9iY95SviXeDdx3D2JX4tQlhXM3bAVtDTClWSV0KpaQopSGPUkVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFcclWJL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFcclWJL"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c3ca32974fso6528656a12.3
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725985902; x=1726590702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5BHsaXOTTVTUtyyWCgIQFWoCFxr0AP1lxWWYUnbt38=;
        b=QFcclWJLUfnM1R3gWH2glyaWlmQKf0jsFcc+N6rEft4S286qKvEgRiwrVXOngDTq6l
         +eLrJq0/a07KkUUgUy+7PwwPlCkql8RBWBP+hYGVroKIcv8F2BZgH9lmc89FBnB655Ev
         vvPNXE7bOPwQMZFjtyEYeQCunhkjN1bYDxyvyYvTmJHclOVM9PEsqujVzlVQvj71s1Qe
         BLvp9Y63aep4+1EGg4axTsWbS/MRbs0MDoBxceqSETSNZosQorRVvwe07LVC3pC6WTqg
         yFdW0+g6opjHUlketuaqMUymXVrttzC5MdLV/RjqKO+iRBLUHVtUSiaEfSy4Me0qdyBb
         n3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985902; x=1726590702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5BHsaXOTTVTUtyyWCgIQFWoCFxr0AP1lxWWYUnbt38=;
        b=NqgpHiDbK9rlZEP4zzJlH/uOmYZ4UHFzCiC4yAk6D1OHT3DaryE1Ch+BZ465ShXjor
         oCz1XQ1pZZ+G8iobdBRp5yfmtEVkKWOrJvyUWOoEGAJmNqPt1iWTeaiVaSsF2DsfLYLV
         zIBRv9wBPZc0g0Ex36om8sEe+6g45ZSjhftEol4/RC54GBPnlYKoJKpwJ7xbaxKluItJ
         zdeH0MH+IY2qR5r92zg1dXfU0gZTjSthAQmTn189xSitxDpJOoLiMr/P+I5AwJNDSprb
         qW6Cjje+1hPwd9qB/KNAoc/C7PJG0Lhvzq1ORHCDLY66rhYV3oU+jGy/jCbsxyggD2Cn
         LiVQ==
X-Gm-Message-State: AOJu0Yyi4RWdnrMB7RA41FyTXmYlg6K7YzQgiWcfdIV8z8ooJA2a/jFi
	pQ54PXq0o/SIDlf6yRM0RaFqyQsUWp/pfsaiBt+p6loxwalCZMksKZTxaDLTRVcp8Pjj98Rtzs/
	eg9CSj5tGckap8t17Dn+I3F5p40GRCQ==
X-Google-Smtp-Source: AGHT+IGvRd2d/a0xLUzKVJKOxE/AanWjf05BAAqbPkIzBVzJjnmhcKXlSY9t+dJQhOloJsSsYhvkHdM979eU9R1Bfp0=
X-Received: by 2002:a05:6402:5203:b0:5c2:6311:8478 with SMTP id
 4fb4d7f45d1cf-5c3dc7bb4e1mr10553354a12.25.1725985901723; Tue, 10 Sep 2024
 09:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240731134014.2299361-4-christian.couder@gmail.com> <ZrDYIFolRlERFdUT@tanuki>
In-Reply-To: <ZrDYIFolRlERFdUT@tanuki>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 10 Sep 2024 18:31:29 +0200
Message-ID: <CAP8UFD34FP2CCaeeYU5maUiNB5m5pD3_neyEYFtf8GQ4xCZmvA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 8:01=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Wed, Jul 31, 2024 at 03:40:13PM +0200, Christian Couder wrote:

> > +The server may advertise some promisor remotes it is using, if it's OK
> > +for the server that a client uses them too. In this case <pr-infos>
> > +should be of the form:
> > +
> > +     pr-infos =3D pr-info | pr-infos ";" pr-info
> > +
> > +     pr-info =3D "name=3D" pr-name | "name=3D" pr-name "," "url=3D" pr=
-url
> > +
> > +where `pr-name` is the name of a promisor remote, and `pr-url` the
> > +urlencoded URL of that promisor remote.
> > +
> > +In this case a client wanting to use one or more promisor remotes the
> > +server advertised should reply with "promisor-remote=3D<pr-names>" whe=
re
> > +<pr-names> should be of the form:
> > +
> > +     pr-names =3D pr-name | pr-names ";" pr-name
> > +
> > +where `pr-name` is the name of a promisor remote the server
> > +advertised.
> > +
> > +If the server prefers a client not to use any promisor remote the
> > +server uses, or if the server doesn't use any promisor remote, it
> > +should only advertise "promisor-remote" without any value or "=3D" sig=
n
> > +after it.
> > +
> > +In this case, or if the client doesn't want to use any promisor remote
> > +the server advertised, the client should reply only "promisor-remote"
> > +without any value or "=3D" sign after it.
>
> Why does the client have to advertise anything if they don't want to use
> any of the promisor remotes?

I have tried to explain it in a reply to Taylor, but as you, Junio and
others seem to prefer the capability not to be advertised at all when
not used, I have changed this in version 2.

> > +The "promisor.advertise" and "promisor.acceptFromServer" configuration
> > +options can be used on the server and client side respectively to
> > +control what they advertise or accept respectively. See the
> > +documentation of these configuration options for more information.
>
> One thing I'm not totally clear on is the consequence of this
> capability. What is the expected consequence if the client accepts one
> of the promisor remotes? What is the consequence if the client accepts
> none?

I have tried to improve the documentation significatively, especially
according to Junio's suggestion, in version 2.

> In the former case I'd expect that the server is free to omit objects,
> but that isn't made explicit anywhere, I think.

Junio also suggested making it explicit so I have done that in version 2.

> Also, is there any
> mechanism that tells the client exactly which objects have been omitted?

I don't think it's necessary. Agreeing on which promisor remote (name
and URL) to use should be enough security wise. When using bundle-uri,
for example, the server is not telling the client exactly which
objects are in the bundle.

> In the latter case I assume that the result will be a full clone, that
> is the server fetched any objects it didn't have from the promisor?

Yeah, the server should fetch any objects it doesn't have from the
promisor, so it can send everything to the client.

> Or does the server side continue to only honor whatever the client has
> provided as object filters, but signals to the client that it shall
> please contact somebody else when backfilling those promised objects?

No. Options to enable things like this could be built on top later if
needed though.

Thanks for the review.
