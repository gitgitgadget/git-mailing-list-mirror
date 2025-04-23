Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151667081C
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419476; cv=none; b=cX54hHSSb6P2CQdxLJwUOs1qhan0oYOli0YTUEHrl3N53WtFeTKhvoApzje+/aYwOpnSeszJXgwJ7wKxlhHueveVH6WkGw0dChAkHiUJhP6B3xrvl+1XoHPYP1DB7VR0XY+szXUDxc64pYYVGEOXeHLG2TlLFj57T4tkydNj/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419476; c=relaxed/simple;
	bh=lhgcy2dwXAWnRer2EClIMfesxPrjx54Q+byQjYk/dKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+f51UHxDrmRLxB0D71zaBa5OmsgKQBdEtUfC/ozBoz2stu1Zy/WDczVb+i4NvdFASaPSOm4Xxc4F5aCfS52h4Nb1YrSqyZYNqq7+F5/FjrCrwUcMkGGfjuxAPIYbEplJnt21/KHOpX/2frVtsPH3/sMOkZa1HunGaI6IptQfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtecIaD0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtecIaD0"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so925115866b.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745419473; x=1746024273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnzKmdsSfrgQDEdr+9pHrTxQY4+6rSHuZWTpN2QYJTE=;
        b=NtecIaD0IqvR1lZNPvrON0QyHqBZadgfWFOGlkkGZQmX/Q5I+hMRCctUjrbJYbIfPG
         moXYC3ougnfDWTVH8EADTkJD+ShS8Z9RlJz7zlyIFJGX/S/0mInrtHNDiWSVa+/vSoH9
         U6d5t4XIcryYR97wI3d/37lK8Xpi5Niikt5x4WKyP9o9Mf1L6RjlaMDLWVC7CIX10dnU
         7CLWnndqc2t2FSs5suHGW40sgyLCRNtkhKjZRLW/UQvoBKEzsUuJ65Kbi8FwKhZkGtdR
         znMlJj0uFssvEvntE4IN7ZgRU6jtz+QEQIAb4LqLh05Ext+5U7QIvKlgTht5cg6zSHbK
         K7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419473; x=1746024273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnzKmdsSfrgQDEdr+9pHrTxQY4+6rSHuZWTpN2QYJTE=;
        b=Zb1LqzzxXpkKpIYnPSe4nZpzzRoSm5Xg+tIhEJpqVCPtsngLc8exy1VzYGZDmlMZSN
         3cjLiFCkjk29ITfVAMTE7ajswTFrmq2WFvmyU55pfB5KGejE3lrDjDhg5q7P31fk2JYq
         A8nR2IZsLlM/3r9Ss5ZAnawX1rWLCW+ShkQ7dvLNXTw8NkkxMNI94O8y+YWZYJ190y6f
         8UCcLhYmEFxCr/CnfkjJk6zIpMBSxWlpdUyqt/tBXHBnezcJBgkqiCUayca+tB6ldLkh
         JLcIck8O0SS3vzo1F8OIl+tCdXPZZxYe6Swq/L9z2t6G66bu8nJN+Fc3oiQpD0BOxlyF
         dBoQ==
X-Gm-Message-State: AOJu0YxRLbvY8U1AKSgC5ry2EYZxhFQwqUn9GKb4eVKjRnuRBGijPWk5
	A75xiWxgrWi/NLFdWpb4PORiggEwYA+WCQJ6G4evsyJ2Q45VRXmzJg6L+JcvmBsv/fq0idc5wfm
	9PtgTFKu8/QXYkLZ3mX+t+ZCRDVE=
X-Gm-Gg: ASbGncsxg/dPMc7t0Qm/XTEhMdpPvDpfWV2eGMigCahjeUZVhvWMcgxZ1JdnnAf56P1
	jQ0E3laDdHU/frgFtyjuUdp9WCRWDdOhIAkrWPOU42pI8K3InddGfeJvuXzaMOfok2oKU00Yvpk
	PydENbhbGkqu95cP1ntBijiqAsaGa2R30OyVuAUxUnLATKshfSg7BK8L4=
X-Google-Smtp-Source: AGHT+IHTWEQJzqRTdeJfiP90bTfDSqRM2SXGwEengsI2QbQPv+B6Pbdhh6V96UaN24wndvcqB6bK1cM43vobwFoKAkQ=
X-Received: by 2002:a17:906:ef0e:b0:ac7:ee7a:b23d with SMTP id
 a640c23a62f3a-acb74d83cd1mr1918672266b.44.1745419472980; Wed, 23 Apr 2025
 07:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im> <CAP8UFD3Nr_f7WSzjv4AEKzH9Kpsf6soOd+VSO9ng=-ZSws6P3g@mail.gmail.com>
 <aAdK9gnXOO3ERq7w@pks.im>
In-Reply-To: <aAdK9gnXOO3ERq7w@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 23 Apr 2025 16:44:20 +0200
X-Gm-Features: ATxdqUE5JHDdw6-uAIQdwAaAO5IIacn4JQ7qqamC6kj_nzK3Lt3GtryugYJrIY4
Message-ID: <CAP8UFD1zqAk1_Y0ECu4=iyeF4k4LagfLgHWkEr8iz8ZnwkVT8A@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] meson: wire up support for benchmarks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 9:53=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Apr 22, 2025 at 09:27:57AM +0200, Christian Couder wrote:

> > In https://lore.kernel.org/git/CAP8UFD2jKwYzmc40knXY7k+FQabjZbGTqs9fowF=
=3D-0OqfNYp_w@mail.gmail.com/
> > I wrote:
> >
> > "I wonder what happens when we run `meson test -C build --benchmark`
> > but 'time' is not found."
> >
> > because I wasn't sure if it would just do nothing in that case which
> > might not be very user friendly.
>
> Ah, sorry, forgot to answer that question. What Meson does in that case
> is to print "No tests defined". We could help improve usability a bit by
> printing benchmarks as part of the auto-detected features after setup of
> the build directory has finished. That would make it more discoverable
> that benchmarks have been disabled.

I was more expecting something simple like:

if time.found()
  ...
else
  error('Benchmarking requires the `time` command')
endif

in the same way as in meson.build elsewhere we have things like:

if not msgfmt.found() and gettext_option.enabled()
  error('Internationalization via libintl requires msgfmt')
endif
