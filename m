Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC6E37BE81
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426763; cv=none; b=AYLPUnddJw9y5wL6s1W5XOpQlUY7lIRMZyxJshqTnU2wFNrpBOMsgKX/e+Ni3qHhD5fD94UYwil03zBq2UggfOKBy8YqmLwpNMnbTzudMClyXKaUY1fgN3CxG/7IjVXFL02kXuasidrqqoWYynJlj1tjl1vYSrZX8Hmr2QmSW9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426763; c=relaxed/simple;
	bh=FxCw4fm+nPtN6ht44ep+M0oWszuTECrcwNcbV2i1qnA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=L7zBOds029C83az0FJqX1Re1pmEKY0OS02x2Fk2SD0IZfgdZe6EbzDiSp3rOvgZ2R3JkdtW1wZi6/MTY6WL8/2lK7z2a/UBXWSFKZn3fmxqwAppyau9Bt2xYcIKflBYnDpI+dIzcJT4i7huAUFKZz9nUzVmBYskML2T3JtmG7qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wb6+rTXF; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb6+rTXF"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79018a412edso2324317b3.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 13:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426728; x=1769031528; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4qxx08/9Wu4E5E7U+Vsan4C5ociP+ZX7QBYSGmOiY8=;
        b=Wb6+rTXFzdvknCb/N0+wTT2OrnGXGFim9dvoX7q+zDvmr/tzU8kCiFQdOAYElGxt4Y
         ktUq6HbLSdXf+YkDgz9zWkqa0nDEc4+e2ZYdZfXj/zLBP5GnuyGGR8OHvCgiNJr+fIPm
         peOKSfFuHvOsf1pG0JMQU3EOS2vsU8PnMmwXWACWhLCJawvJJF8pQVbPVDeL87TbV0FY
         GMt3+OcgKHV5pTB0UnZDKsWQanKkxMkBQSUd9O3C+P+OIl+QzNvohDoo3yTXLD7bC8/4
         m+/t9U0WKfwkxy2oJnxY/PG9pxTTVcCDJO6KeICRYUrAZvlIOuVyvelLzrm5dMPrFdY+
         4j9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426728; x=1769031528;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4qxx08/9Wu4E5E7U+Vsan4C5ociP+ZX7QBYSGmOiY8=;
        b=puhB5v6UrztUsOrwDykLqXzgfGzZIYMAjkdMGQhFkQyvKlei7vnq2sof9RcjQI6X9I
         H+ttwdjwJ2gP6s20fBPKB97DGbJG10ROPQw6LhDF6ZWRgFmI64XXzUzDuvINcD2TCydK
         jpJ4kLsbrPy9rm43UdcGW8FZL/UYSiztcZay16hoZ9H4S2VaxqKYp5c3+iZIbwdO2jX/
         qJ9W5mGgKeIrJAQxA50kpjWgmxUDVkSHH/PtgdQ8E2vDuMaRgDLNQC/TXn4+7MwOSUbu
         6dpVLfTu5J5PEje0/DARQhX2hjBhv+NqFqnSsnZjuxkS9hO7gyvVhjL1U4Bh1/57S5yu
         1uBw==
X-Forwarded-Encrypted: i=1; AJvYcCWR2yQuYXtkbNQBifi0Xp/kc/IlSpTEOrVFkYT0heaY/WwHTqjjE5/Eg1mD6iMWWaTp+4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyKhdspT6cISJVWc8qnJ6ecB6PrYXST3lKejAkfd8MCSB9XS5E
	v19P2d5GYS7MhcHOeIXjlDujV9qXsbH5HW+5mFVuDE6sqxPm1RmxwOdu
X-Gm-Gg: AY/fxX5olR2e2BYJuM5Ix45ZRxeN8Q0dWOEkXQ54emm0Ru96c2DY2yOzwxHUKEHud38
	FbTBX55w1I447nYn9fItFgpC5WN9yuuWbcui4cSN1s/GOQ/JwIL69wGWK8ucI1Pm1mx6s8vUMoW
	X10lKjzyF/IpUDTBgVaANf8EE8KzHitVYv3pz3NEVyh4QVcIofXS8+BAqu+QH/p0I71Y3/bDrff
	8zUlWfRYMG5y70lTSnOjWm0chYV5NWLKP4palizb45hKajqQjp06/3NPC5gTMNyWkuOjXqO8S4Y
	mo6HFJhfpJZYaQZkkLJrso160xfCQARH/hCF6VeDFmIvBLAP4jOlPxCGSAMkizz4Ve7zMUaPQnA
	zz4mm/KxRJ8uzIVV3hPzPqEqR7/VrIe9491Ef5I6yAslXY/vMUcu5Y59AjF8TJzXy0W2Yh2nJnv
	tlcvTNE4OwgDLCKgMVs3A6xQwg59laU9EduXTRsheQMZFOb/GqyEM+ViTxHhc1b9W4PPYKBKpie
	BWk1iEXRmSEBZjRB4o0RCDf3jMO
X-Received: by 2002:a05:690c:3501:b0:787:d1e7:e75b with SMTP id 00721157ae682-793a3aa5b2bmr26566177b3.64.1768426728403;
        Wed, 14 Jan 2026 13:38:48 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:18f6:dd0a:cf21:e611])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6a4d00sm95462007b3.41.2026.01.14.13.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 13:38:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Triangular workflow
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <20260114211013.GB1008851@coredump.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org,
 gitgitgadget@gmail.com
Date: Wed, 14 Jan 2026 16:38:37 -0500
Message-Id: <56D0BADB-43C8-4E93-A871-6E6B11B59DCF@gmail.com>
References: <20260114211013.GB1008851@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: iPhone Mail (21F90)


> Le 14 janv. 2026 =C3=A0 16:11, Jeff King <peff@peff.net> a =C3=A9crit :
>=20
> =EF=BB=BFOn Wed, Jan 14, 2026 at 10:54:53AM -0800, Junio C Hamano wrote:
>=20
>> Jeff King <peff@peff.net> writes:
>>> And having the extra output from "git checkout" is just extra noise for
>>> me, especially because it is easy to see only the second message (which
>>> looks just like the upstream ahead/behind message, of course) and get
>>> confused. The first time I saw it I thought I had misconfigured
>>> something with my branch.
>> It now is clear to me that this should be _optional_, so that those
>> who do really want extra output from the command should explicitly
>> opt into the feature.  After all, any optional new feature that you
>> must opt into by definition cannot regress end user experience for
>> those who do not ;-)
>=20
> True, but then it also cannot pleasantly surprise people who didn't
> realize they wanted it.
>=20
> Having your user experience regressed and then tweaking a config option
> to fix it is not too bad. The deciding factor to me is whether more
> people will be pleasantly surprised or annoyed. ;) I don't have a strong
> sense there.
>=20
> As a general principle, though, I think a reasonable path forward for
> any behavior change is:
>=20
> 1. Implement the new behavior, hidden behind a config option.
>=20
> 2. Wait a while to see how people like the new option, and shake out
>   any bugs.
>=20
> 3. If people like the option and are puzzled why it isn't the default,
>   then flip the default on.
>=20
> In other words, let the utility of the feature be proven in practice by
> people opting into it. There is a chicken-and-egg problem if they don't
> know about it, but if it is truly solving a problem people have, then
> hopefully some of them would look for a solution and find it.
>=20
> End philosophical rambling. ;)

Agreed generally, but the chicken-egg goes 2 layers deep here due to triangu=
lar workflows ;)

I favor something similar to what Junio described but also including @{push}=
 by default (and ignoring it if non-existent), so that folks discovering tri=
angular workflows for the first time are easily able to see what is happenin=
g.

Us =E2=80=9Dalready triangular=E2=80=9D squares are probably well-versed eno=
ugh in Git to find and tweak the new feature if desired.

Idk though. I think more folks at work should try triangular flows, so I=E2=80=
=99m biased :p=
