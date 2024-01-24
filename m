Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BE17A705
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106205; cv=none; b=fM4rko4+ehMG7Zw/WLNO51m1TjCorG2UKFrgXcedKmCGySgusIth6zbn8mWyPppda/ic7qTsO4DyfCRC6e0Xw3e6NW0iG8BgxWqROtWNt+kQEEllRwvWn0MoQ6dXOistt+x1YdFcqUbUlCkW7kmThqvD+c9AOiKzrF5PsGTdXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106205; c=relaxed/simple;
	bh=GjW8HdYLS2wQWGyGTTOG76NB7F9l7f0hbmcu23juW+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rhm7Lp9b0+Gxltb9OeRvzwD7EmjwiuPi2XNcrlMSoK/sAQQfpTm4Qg8Xl0oY5edbHmueJ7aHhUSGYT/ToT3P7nfVXgFd+CFfkcj1y5FpZkhw7gEYX4ysny7BufQf89atarvvZomAFzHQXf6W33eIsE534wMMm/kQxqSBaWRsNV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx7fm4s/; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx7fm4s/"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbed179f0faso4985575276.1
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 06:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706106202; x=1706711002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ze0ZQygXI31w0ZsCMxxbvnZunMrE7NV0AWB80njbPY=;
        b=Jx7fm4s//65IKLIGmmicBBSAnJEBug5cxOgaKXBezBLkj4rGbpVnpCN7pNZNcj5iF8
         fHXfsSyCWdXaTk9NKyxo+ZgoiT+Y770LxsznywIFUhrlJ2qgHJCUI5DMxI3KbHFUSGGm
         PIp0uTFHpTqX0YmVCm1COe/lolf5WGVtr0MSeZu2wGAHwyoVsW27rV48uAOITB17XIPB
         QN945NBrDcGVwJ/SDGVGsORA+dg/N6yBIEm75rqAcQwgMP96rTzK1QGfRtHABchabo1O
         nVAE9A5oBCcMz0+nlpd7r+qn2WGUFmHajGlHw6IMWfpP2NUI9nadgwaQLkhKvfI1e72K
         rHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706106202; x=1706711002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ze0ZQygXI31w0ZsCMxxbvnZunMrE7NV0AWB80njbPY=;
        b=YN2lqC0PkbISvBgQZoYbZRBWqnLg/iDgG5NOyoq1wTmew330/OOM0vJE2I3dy/9noY
         JzdCrcvBSjdfzk6cnabNHWrkJE7cwYXZfr27UCqO+Q4POAjJz/dxduUcYRRyT+24Dm5C
         0CVP+clDwnKyhZzbMzVJvNgQf64Qr0UPn5/mt0rq5oAu3gJ02smfKoGLdR3bKJJ03koo
         gI0X4UGaDX9IAUAbbHBfWxTr+dNIrHTzTTUTBvBcIdlam689cL16DCPPb5+JJidL/gFP
         xDtyRc/zjdKcqv44d+PqK7NOhZ7Gs7ZuA2LBY6adUNv9PaRR5i0gtaNr5FFp79uCjreR
         /Beg==
X-Gm-Message-State: AOJu0YzXZHXEtTN+iZNgfFXDSDbWZJzRAwRyTvgWkpYfSB5nc+3GxD2y
	d/l3YieRIpRbrrcpU1x7qyJLiEjwhPtMbnhSyItrgD0Xb6aIEdrT9jK9GH9+76mfPGmFNx6mPSj
	73i+oHUW1fWaOOSY+T+dpfXz6Un50j97G
X-Google-Smtp-Source: AGHT+IEGMSFzu3bW+RIW/EMLQYvwxKR0Qy2yEXhyfdXDkTgufsPwTM4DV4zZiy7slIdbvh+54VJsAXkQZEdv9JtGN2c=
X-Received: by 2002:a5b:482:0:b0:dc2:2edf:ffcd with SMTP id
 n2-20020a5b0482000000b00dc22edfffcdmr527356ybp.42.1706106201987; Wed, 24 Jan
 2024 06:23:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
 <CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com>
 <20240122213410.GA811766@coredump.intra.peff.net> <CAGF1KhWaOrnV8d2f_vajOT0hFK2N_8m7-p_vnZhw92ZdhXfsag@mail.gmail.com>
 <20240124010924.GB2603087@coredump.intra.peff.net>
In-Reply-To: <20240124010924.GB2603087@coredump.intra.peff.net>
From: =?UTF-8?B?UmHDumwgTsO6w7FleiBkZSBBcmVuYXMgQ29yb25hZG8=?= <raulnac@gmail.com>
Date: Wed, 24 Jan 2024 15:22:46 +0100
Message-ID: <CAGF1KhV1Gh6WPG7XiQFfEC+G6VY_9AyH3XVoO6VVhMA6za_y3Q@mail.gmail.com>
Subject: Re: Fwd: Unexpected behavior of ls-files command when using --others
 --exclude-from, and a .gitignore file which resides in a subdirectory
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff!

El mi=C3=A9, 24 ene 2024 a las 2:09, Jeff King (<peff@peff.net>) escribi=C3=
=B3:
> (I think this also gives an interesting use case arguing for continuing
> to support those more-specific exclusion options for ls-files).
>
> If you are mostly just using core.excludesFile (and not
> .git/info/exclude), then I suspect:
>
>   git -c core.excludesFile /dev/null ls-files -o --exclude-standard
>
> would work for you, too (but it sounds like you might also be using
> .git/info/exclude).

In my case, since I'm also using .git/info/exclude in some repos, this
won't work as-is, but you gave me an idea, and I think I can get what
I need until the "precious" mechanism is implemented. It requires a
bit of hacking in the backup script but is not a big deal and it will
work for all my current repos.

Thanks for the help!

--=20
Ra=C3=BAl N=C3=BA=C3=B1ez de Arenas Coronado
.
