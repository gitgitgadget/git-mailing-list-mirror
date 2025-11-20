Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA43182B7
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763676662; cv=none; b=nyy63J+OOP9ERQB4daleSyxAWgza50Iq+rq8aFhUCLb01VB8vbure0GF4ODzCN4CEig9QPbVsG79E44Clke6ChCmdpkG2utZZTGRiX1GTZh88pzqAnm3oCysHcZkgU1XiAjRg0DVjlQvLjy03gwlwlOWMwuqif8GAcjn0a3g8Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763676662; c=relaxed/simple;
	bh=8CNwor6/77PPKbu3tS0ZoCyZT2BiEe6etTxcNiRomN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=He+ieHZj9R7IsA23UljBuVArWqaNRBMrM2z11YK+N0pLInw0Qnca6BJmi12zf15w2yL1bGLBZhu1BZg9ptCAQm7D+at7JBgJEPolKAb6FUBmahkl+OnjXeAow/SeWqKbT/U2BFWGk6tNShvf6JMJXslLzC4N3YMUojEr21sE3hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAQpD6r4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAQpD6r4"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29586626fbeso16526785ad.0
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 14:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763676659; x=1764281459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anYERnCbTxcGtyVs2DucGvKHo7Ykh/8TCj89JHgeJKs=;
        b=IAQpD6r42469QQReaNBBDvmDquIXrHNqCQJlxsdgm4Smk+ivznBTVu8+v/aHBx1Tvl
         miL2VMpOt0/W7Un5xFpXhOEPrQXDEirieOTV11jv6aE3Zx8pR0s6zEO4BkPQmDR7NiFK
         GpMZA66agqW3QGWp+5fj+wnv690UfhXcbpIYyNOOlo2hslH/1yidB51YeRA4di60e+x2
         ge8Y6O7QA0mDdf+cfFgEUy/C3L2m1SljVqqrspegfWiJuCyoH0sbgXr0PIaxG7bQuTa0
         eyhThJLOP42u0GQma+L6eKOJW8FOtCkBi8Twl1+5REsNY6r3u+itQ0P6u1cXoTSoUreD
         hXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763676659; x=1764281459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=anYERnCbTxcGtyVs2DucGvKHo7Ykh/8TCj89JHgeJKs=;
        b=QBMfXCL9mOSrmzs8Gxz5mBLG0WYZazfEPS25ca5xqs1RfleQWaxB7a4wrwsLVdlwO5
         D+zfByR88ksWvUDXe4qghv5pNHKupJa6BwGWMeh0wMIZo8VAaIroUmbT5l8Lf3VgKWbm
         zV6vFrsgd7C8pckQUMcOwBUOKIFDRjPSWrtyLfUyClMMhJEW55+gnM//25otVR24yUSR
         ADKl18sofDUncIOefM9r2ou/lgCB/2CcTt2xoEfDjUEy4gyXngT1SW0+krNwDhfld7uf
         yCBRxsOnAE4pOgxGkyMZU5ikyZLqbnN9Ga5Z/QXCn2+MEQkbkQhahFjysySbayvO9eVX
         so/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEE7dlQpzNt7xIcB8jKIBgwXFnAgUdaXI73KZpCRLzeINGr4AyI3FI5VNiO4Aa/CVZbck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdXDZpTcrXQL3Wl4PhVSpDhtOLKHTqhchH6QWu2RgRPuyuaoa
	PwQO4UqTKcjPFSsVmTAlNRGG/Iy10I4ejDwIAEpm5+s+8VsRDOydfhp5HXWvtVsdYa8rx5FbYPm
	gutZAQUTD1ca6yKnetL4cI8VlqcCKKDn1f4wDzX9cHw==
X-Gm-Gg: ASbGnctR9w1DqBGTY+cTlxD7vDKr8kj5cesJwyVrp2l+g5PQj2dtPjuGaTQzqSiCuEQ
	a8UZWUKM2u2yKLUVzrW4C4s4llDGSPXwoGnatBaBSn91y4msDAcMnPq76+JvHujRqcLh/lxQjwE
	fqtEddv/nhW6ClhUeiFZYrehtYjtq6xHzNqh+9gQHl1vT14XvA4bchL/ypz0KWayQX7JOda9cf2
	OKEb1PXDaRRp8UHf04mM3Y8lI2RME3GOEhL448KUWD1i05yyd6lR5u1i/tLR/ddMJU/8K4JnODB
	HO6saLo=
X-Google-Smtp-Source: AGHT+IHNFLNIgJa1Zx3f14/LGRF+qJchFeo8WQiiDqZ2OTMA4YDD29wNO+aNsR/KiAyOsRMRINzShpB2vLduAr/qKTM=
X-Received: by 2002:a17:903:90b:b0:298:2af7:8d26 with SMTP id
 d9443c01a7336-29b6bf83cb4mr2147525ad.54.1763676659437; Thu, 20 Nov 2025
 14:10:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL4-wQrgD3nnW2BfNf6e9d7tDANE60dYBRRP_0FW3Z-LvQrZmg@mail.gmail.com>
 <0e971281-d1c4-4030-9297-f5e2c0765431@app.fastmail.com> <CAL4-wQpeYc8-FfcZGWcs6KmR-oswTs3Kjcc7xAb34cFX7s0c-A@mail.gmail.com>
In-Reply-To: <CAL4-wQpeYc8-FfcZGWcs6KmR-oswTs3Kjcc7xAb34cFX7s0c-A@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 20 Nov 2025 17:10:48 -0500
X-Gm-Features: AWmQ_blixeEtjphMFg1KI_GeQOwaK0WHGRWyOavwJf-_1t3vHo3hdYnALSQyKbM
Message-ID: <CALnO6CDpBpRdbpXy26v5ug5n5opqzn-Uos+Qr=jx9mA-5wR9Ag@mail.gmail.com>
Subject: Re: Feature request: git cp
To: Martin Guy <martinwguy@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 4:24=E2=80=AFPM Martin Guy <martinwguy@gmail.com> w=
rote:
>
> Thanks, but that only seems to affect "git log" retroactively, whereas
> I'm interested in it being part of the history so that "git blame"
> knows about it. At present, the blame for a line would end at the time
> of the split (when the file appears to have been created ex novo)
> though I suppose people would end up at that break and could then
> switch to tracking the old file instead.
>
> Maybe I'm expecting too much of git, with all the truly wonderful
> things it does already, but the idea seems to fit into the current
> scheme of things as seen from the outside (I don't know how the "git
> mv" line-based trackback works).
>
>     M
>

Please avoid top-posting ;)

"git mv" doesn't track the movement; Git reconstructs it post-hoc. See
[1]; while the tone obviously leaves a lot to be desired, the
technical rationale has stuck.

[1]: https://lore.kernel.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.os=
dl.org/


--=20
D. Ben Knoble
