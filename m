Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7778D2627EC
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757876626; cv=none; b=XRP7pCOv4j3r9SUKGWOhPSJCA09zX0QMeD2RhOrc+VkJ1AgmOiyQOG0P+JCPnQWEFM1zb9PaX4GZ8XPv+0qY3WDq/o/R48Tibx3sCoyh0lcSoOwAAZJlFdn36V64UtizZfN+ZQqEo6XOW4sDWOuUoK/2itFjURcG6dUmvHIvyL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757876626; c=relaxed/simple;
	bh=4iOSKi8hRDxKHU8X2pEGJto0nQEGqj0Nj2SL/ymIG4Q=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=DMxxvkbnBaEbilq4n3vtCyclYs1ailzW6RMaNiGoaD1nY6yOCoe+j7tq1rzmfRD3gDAcbzFpLwkgA/11tvMvRR4aNU5B9Kt141uJ53Hlf3Qbe1s2ci6Y3LsNguK3lh2q7eLcJ/Lys74r3oWrPpd4q5lM2UkTKwZ+Jf3YLNw9TO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=friF+zsM; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="friF+zsM"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d71bcac45so22948807b3.0
        for <git@vger.kernel.org>; Sun, 14 Sep 2025 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757876624; x=1758481424; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qdJm6108FjHM3ssa8Maskm28d7My0Lz3NwaJphMvKI=;
        b=friF+zsMZI6Du6rWWx2INsxkZ3ZZKlYicvcPPL4fNtV+/7DeNTGm0bX0eBd42w+p6G
         KnPzQ6yTpv7F9htqy5iZ3NpnwDdHeOUkpOWLpJjaiWnqFA3khQ9bo52xTNDqKiX4du32
         FI5ik1I7j8ESkjl0NxTLsa1/lsqczWddKhxDxfm7fyvDfYYi1Fi1zeeZlPAfxxfw4ZRW
         3pK623YOnt86qYDe9FtaAtLr2j63An9yDRlvEn69rSioHwksdTbMR//b9MFBir6+S4PX
         rdQBZPv2gPGRHC5YuHGTVI+l2OqnOXgWtR0e58nsL5mHlgy7FFawBlSFHeaonRCczrWf
         5pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757876624; x=1758481424;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qdJm6108FjHM3ssa8Maskm28d7My0Lz3NwaJphMvKI=;
        b=ekfwbgAZkdlpVJrQrXjnkhz6RIJfnRmAuo4KVFwzdf3wwEbBhOnWRfkFq/RB0dQwts
         SSJGYgOHLUSFmqe4zgkKaLZ3bcI+WtSAlw4FIwb0/6TohOt+sAYcyCnk/umRzRhmwZvv
         EdbJ3hAoUjN7C1xXCqA/1Xwb5qMvWQY1oyA/0auz0wWrFw5UpbJxs8xy0pvtoX6IgT+1
         EcPMiCw2LplaQeP0XU3c6wxLb1Qcpwadl0B+J9XfDieAz6WzSHu5O8J2r96tlfBVdg0u
         Ji6UghOmVpslXdtWih5NIPbni6b1S6uhCzcCbsGn+0Y2+4I/VUatA6vbinfKJnuD4565
         CaQw==
X-Forwarded-Encrypted: i=1; AJvYcCWjVgAXmKD1Dl98d+OHIWgrKz7SM7Uuu2caFjBpr8mGgjMTig6S+y6YtUFocXIKKDEYJp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/usGn6P0KeGUh4GA62EQB+ibSuuULzU/gy5rQEjxFy+76g1G
	HAECz5v7mrVAdRG0FXOSUeoRuK9wL9nAvY4Fop/LaEdmREuFw4EocV4I
X-Gm-Gg: ASbGncsjBzE0hZVREyZv5mi/3fVnc9M9h6BbXPMkmap2Dm7WToh1AGxpi6D2mwqg4CW
	yo0u1b+eHhtW19Lql2/aYnF+R0AYROedIROZEcgzhg+ZBAGxDFf+3U/QRvsAehJTOU5WQII3Gm3
	cbhjrTOMHtF76+wmMIUP5joSqaCl/5azFt8w6nDf6RBMyuBcmP2Ox5R8+eHzT831iie6xC1qwao
	o19cTS9GkQXYx/jYDy2p88CXG88TunoyTd2Qg9cX/ZS8plWGiVE60Cu++kgTwLaLWrJKPf70xJx
	h3wdGzAG6Ic49bQHS55OUojcTO/MalHkbXgkGDu0g1dJ/Rgq4N0T5MLm2vlw8CFnUzKHZt1fIhw
	8DLR0bg/PrMy4VjtlOK9O8HyYfPXMa69MhIPPf/Da+4mRce5Ypz8vjeugxHNFb25agcafaQ85xc
	UFDC2pXy2Yrlh0lRU=
X-Google-Smtp-Source: AGHT+IFjiRqHuE4BIkiJHvfkuxDfnqN0+sQOtLpEOWxxn8F2a4a4hVaPwLyKbqPjMaveSjDClOQbUw==
X-Received: by 2002:a05:690c:7086:b0:71f:b871:da32 with SMTP id 00721157ae682-73063674654mr99637847b3.12.1757876624233;
        Sun, 14 Sep 2025 12:03:44 -0700 (PDT)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f73353c02sm26571937b3.0.2025.09.14.12.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 12:03:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/3] checkout: provide hint when failing due to another worktree
Date: Sun, 14 Sep 2025 15:03:32 -0400
Message-Id: <6B2DF1C9-8745-4733-8082-9C37BEF12150@gmail.com>
References: <be510685-3be1-4f71-806a-6b580bb1cf21@app.fastmail.com>
Cc: Gabriel Scherer <gabriel.scherer@inria.fr>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
In-Reply-To: <be510685-3be1-4f71-806a-6b580bb1cf21@app.fastmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 13 sept. 2025 =C3=A0 16:56, Kristoffer Haugsbakk <kristofferhaugsbakk@f=
astmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFUnrelated: I found it confusing that my `co =3D checkout` alias d=
id not
> work with this fresh-off-the-press Advice:[1]
>=20
> ```
> $ ./git co master
> fatal: 'master' is already used by worktree at '<path>'
> $ ./git checkout master
> fatal: 'master' is already used by worktree at '<patch>'
> hint: Use --detach to avoid this restriction,
> hint: or --ignore-other-worktrees to ignore it.
> hint: Disable this message with "git config set advice.branchUsedInOtherWo=
rktree false"
> ```
>=20
> But it did for this older Advice (which is in my installed git(1)):
>=20
> ```
> $ ./git co -b .. @
> fatal: '..' is not a valid branch name
> hint: See `man git check-ref-format`
> hint: Disable this message with "git config set advice.refSyntax false"
> ```
>=20
> It=E2=80=99s because aliases are run as a subprocess from the `git` in `PA=
TH`:
>=20
> ```
> strvec_push(&cmd.args, "git");
> ```
>=20
> [1]: Chain of events:
>=20
> 1. Try to trigger the Advice in this series
> 2. ... but it doesn=E2=80=99t
> 3. Is the code wrong?
> 4. Wait, I=E2=80=99m using my alias (which I always use; I don=E2=80=99t t=
hink about it)
> 5. I test with `git checkout`: it works
> 6. ... so aliases don=E2=80=99t work with Advice?
> 7. Test an existing Advice that I know about
> 8. ... but it does work with aliases
> 9.=E2=80=9315. ...
>=20
> It was part of the process.  I didn=E2=80=99t *decide* to get hung up on i=
t. ;)

Using bin-wrappers/git should set things up correctly, I think?=
