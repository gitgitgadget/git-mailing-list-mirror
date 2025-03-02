Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B923F36B
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740913904; cv=none; b=AFZdF5nVULfRgcAJysR7gXJKkuHnRftQoOL+iRV24IgdrUTlPfNe9sYgVOgoMZmTCnVyyj2oqBLfkplPvJWv0hCeUDzuVzUet7FhTd8y7OxcpDqSlMJwfk89R1ow1OOj7FoHDkjyyHg42aC30Ne+aIj9ByYL5+8Rx30AIcnrecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740913904; c=relaxed/simple;
	bh=S1BLDHnbooHosnztnmPermc9nYVQAewI6IvwpbRoEgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCfbJyuakyhipAIAGeG3/jljcM3ddAh6QI8f+v/4NMzqRDfS75DxCYAoSOyGgNrCqvaJz5dC/8HYDEFzQngoKyqqWO22dYRmP4PRzJfaAkn5zUyE08eQGo7Mi9Z7gS8JEZuspwpTDZ12Pt2Cbf3Yc84D5gyicYBYCPSISr4aV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVSX11ya; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVSX11ya"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf4802b242so252983166b.1
        for <git@vger.kernel.org>; Sun, 02 Mar 2025 03:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740913901; x=1741518701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1BLDHnbooHosnztnmPermc9nYVQAewI6IvwpbRoEgs=;
        b=UVSX11yaoQxttfEyGHXDoZskeTrIa6kAuP4b+RpocQT/cZPco493o4XqYOEXfaIxm5
         UUq2QKq6xoWDmIMMlVdEfoibTO79BuXf9qVUPJw+r4qx9ErXBGy2KttXhXRSRpij1bPG
         ZfZLLobF+6a79FlTcsZ+qZMrorTbfvlzgcQUPplRQ3iMAqDFKZgjo9yhMYc2BjPG68Bk
         +jDqwlyKd1WGonfwbC30c/fbxhVdxGB8svLklcdogfUmHSCArqjpLeYmKsCewx9p3QpO
         QskE1poSg/+pbw2QwtO4wYigoY21Fj/JnJs4FlKgtoHocqS4WUKSHr2usmemeAHhNbgE
         qvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740913901; x=1741518701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1BLDHnbooHosnztnmPermc9nYVQAewI6IvwpbRoEgs=;
        b=ds5CGH+3gB4u0VszYVU2CA0XiXlk8Ufb5Y++IG+gDS2u1Ungi9P8K+jiEx96k0Q7rs
         g0TA0BnWuBVWbLNd368L8OVXEpPLReBiALnXgw3Q5yyOyLBC/9CF9Qbf9NMs6IO8pvfy
         veMCbJy7EZBeyCUzipm3s1a7RdNVu+a+VLVN7cw0Zxj6RmL/bEN5B1yL2GS906A7yIAK
         sgkWtxAQ+/pfFONIUHDoTeDFiBUfWaQab/MJMAohOE7MbiYXyrdCG84P4m40dRsd42FS
         iKFb1DGmCVZ8RNIJidsMjSpRn+uN6xYSMtjqlNgsuMhBWieY8Ab9mml+kTT0MfbIKTUw
         IEsw==
X-Gm-Message-State: AOJu0YwtnjrEMKG6Q4Dn0Ze72COKhrwTHUa+bys0P4Jx8RuP3fDVKw1D
	3vvE71qwv/K/5WEi9J4DNfovpt+tDN4mwbJBpZx3ax9rIjw5aQgexZy3G3cKimsbP3CgMycpCgT
	53f8tCRAHKTGRNuig1LnGT3AMsi2lJoVw
X-Gm-Gg: ASbGnct8ZTfjVmF2f+QjScsqXALgZX2/4JeU/njSso/QLZoy2dSjPeZTxbKoHiHdYLF
	tBTbZELZxf4pQpeN9ITWsnvHiPlQIeAL+R6ncCIEkgoTwpQdXBxQAfb3T3GMc8xRVs7xNeklblr
	pHaYyh4p6ILXt4ICj2r/w8I4b3Wba2
X-Google-Smtp-Source: AGHT+IEVqt3KRt4f6lca7FJ2IX52H1eEzMaeI3wxOhmyZLTNpO4aduaWYHpw3BCxBX2AAoLYx+9nIk/+y5d/fqYDESQ=
X-Received: by 2002:a17:907:9801:b0:ab3:85e1:f11a with SMTP id
 a640c23a62f3a-abf25fa851emr1298602666b.13.1740913900824; Sun, 02 Mar 2025
 03:11:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJoAoZnk88ZFZFdEtUxMnUa1OZiXYOgcw8DSbB+A0LzyCPFugg@mail.gmail.com>
In-Reply-To: <CAJoAoZnk88ZFZFdEtUxMnUa1OZiXYOgcw8DSbB+A0LzyCPFugg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 2 Mar 2025 12:11:29 +0100
X-Gm-Features: AQ5f1Jot1FZN5H8ZxDptobmIZHbJLrtdAXuShy_S9gixrAmbypBawccmqp4bSDk
Message-ID: <CAP8UFD39TsG6zzyjGbJyg20EuhW29u1QiQerAMcGUkToL-A3GQ@mail.gmail.com>
Subject: Re: git-mentoring Google group replacement?
To: Emily Shaffer <nasamuffin@google.com>
Cc: Git List <git@vger.kernel.org>, git-mentoring <git-mentoring@googlegroups.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emily,

On Fri, Feb 28, 2025 at 11:43=E2=80=AFPM 'Emily Shaffer' via git-mentoring
<git-mentoring@googlegroups.com> wrote:

> Because it's not possible for us to push back on these takedowns, I
> think it's time for us to seek an alternative and shut down the Google
> Groups list.
>
> Dscho proposed shutting down the Google Groups and having people ask
> in the Discord chat instead. I think it's reasonable; we've had a few
> newbies asking for contribution advice there and they get answers just
> as quickly, and we get a bit more moderation control. Discord is still
> not scrapable by web crawlers (which is one thing that was appealing
> to us about a closed Google Group). It does require account creation
> to post, but of course we still have git@vger, which does not; this
> mentoring-specific channel/list is supposed to just be an alternative
> for the especially shy.
>
> Thoughts? Alternate suggestions? I'd also be happy to host a list with
> some other service, but I don't have any personal experience on which
> services are good to use or not.

I agree with shutting down the Google Groups and suggesting people ask
on either Discord chat or the #git-devel IRC Channel or the Git
mailing list.

Thanks.
