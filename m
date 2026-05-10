Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3513659FB
	for <git@vger.kernel.org>; Sun, 10 May 2026 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404491; cv=none; b=VQx40Go+oAx/kHT8b009klO9qX/q5PXzi7+LZ0YulV9MYIrhnBHqZNmZrXAAQ6bGmft3UAkqnpVwsBS7rzL56obIloHN7FnYQcFU41VIBAeVSzvkjjnLJMt9aFdrKFKVHB6XHNljVMxbIMlvqmk/bfovqdg0s4g71lYAGTErFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404491; c=relaxed/simple;
	bh=fOybErquORRkf2blE0NNr5P//RPBR6XuTjFmHRIBHjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBFR85WVI1QMDMpy1ZeSLSUI6CmNX6Yhz6Xo1WmnjdYWJKF+rDIuLf6J5Ko17U3akklhzDEj6RKkY7q38QtVWphWaEU3zoWD1HdMOl2vlHynxOM49jF3r7xUf5PErOnGph6sXa8w+7hSZJ4A77p6DGMXUQLyBlKSTpmz8m6t59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=VaeseAJ/; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="VaeseAJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778404477; x=1779009277; i=tboegi@web.de;
	bh=uTCmHgh+13e02J563y+Q1eDIsDfJ9nPw4H//OCkoGns=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VaeseAJ/QRYoGuivdWJf/nMxu0vzoqrIWDF9wDvvPjRR/Glm4u1aYpycQ0U/Mqei
	 GU+X+Htd1ISJFhhu9FkZFM/lWELS/IjkWA3+buI3owFcbNZRfcc6vw2vxAwHCW249
	 wiAQyv8yDWYMfrLgTi10JZoWR7fx2V52df5kTVfgbkTLU673ethBSaDcsHMqVA84U
	 uGztq2JT3Sk6DMQhpxtP8raHtYEKO2248le7jXqypehh+OgDa5I8rHcqBmucoEWRp
	 5/SiNC/18TfK/EFDAyIZlJRzvBlDDCR2rUHlIJZOsmi7cm469stWBDUhVquK5tfI0
	 WdtA0fhi5th48Fxbng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYu16-1wqmcv2A5Y-00KcFY; Sun, 10
 May 2026 11:14:37 +0200
Date: Sun, 10 May 2026 11:14:36 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 01/11] index-pack, unpack-objects: use size_t for
 object size
Message-ID: <20260510091436.GA5880@tb-raspi4>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
 <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
 <dc660106ea8511e6adc44d2b70e9a4ae8b18090e.1777914508.git.gitgitgadget@gmail.com>
 <20260505191100.GA12275@tb-raspi4>
 <fa39d84b-ddbc-3943-5cca-078fb18db80d@gmx.de>
 <20260508190947.GA25792@tb-raspi4>
 <xmqqik8w9eb8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqik8w9eb8.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:a0+ct9lIrxKFvUZTV5y4fT2fwOsScKBXHqTU1xisAO59sYo9GKb
 CciqIMaDcoaLI1cOaWRGd/FNyBV0ltSeMF/gGHxYvC56x16zi3PYv5kDCEQkTa/s+5RowjJ
 JBWtmL/UaJhqdP9bKFk9kg/WjNp7XoD+7gnZdNJvIxvV5k8NoqJjRLfzql7PM1hn/rj5+I/
 5coJFBoleJw0hShUnNRrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TW7AIQ705Ng=;KIVnRBbZWpkvr/FYGBpQoBn/V24
 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
 E/DFKqzLPBBE/XQ==
Content-Transfer-Encoding: quoted-printable

>=20
> Hmph, I do not think there is "up-cast" to keep.  And we do not
> dereference a random pointer that would be suitable for unsigned
> char * as if it were "unsigned long *" or "size_t *" in this code.
>=20
> This came from commit 48fb7deb5bbd87933e7d314b73d7c1b52667f80f
>=20
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Jun 17 17:22:27 2009 -0700
>=20
>     Fix big left-shifts of unsigned char
>    =20
>     Shifting 'unsigned char' or 'unsigned short' left can result in sign
>     extension errors, since the C integer promotion rules means that the
>     unsigned char/short will get implicitly promoted to a signed 'int' d=
ue to
>     the shift (or due to other operations).
>    =20
>     This normally doesn't matter, but if you shift things up sufficientl=
y, it
>     will now set the sign bit in 'int', and a subsequent cast to a bigge=
r type
>     (eg 'long' or 'unsigned long') will now sign-extend the value despit=
e the
>     original expression being unsigned.
>    =20
>     One example of this would be something like
>    =20
>             unsigned long size;
>             unsigned char c;
>    =20
>             size +=3D c << 24;
>    =20
>     where despite all the variables being unsigned, 'c << 24' ends up be=
ing a
>     signed entity, and will get sign-extended when then doing the additi=
on in
>     an 'unsigned long' type.
>=20
>=20
> You could rewrite Linus's example to
>=20
> 	unsigned char *cp;
> 	unsigned long size;
> 	unsigned char c;
>=20
> 	c =3D *cp;
> 	size +=3D ((unsigned long)c) << 24;
>=20
> While I am sympathetic to that position, I also would not mind
>=20
> 	unsigned char *cp;
> 	unsigned long size;
> 	unsigned long c;
>=20
> 	c =3D *cp;
> 	size +=3D c << 24;
>=20
> all that much.  In any case, such a "clean-up" has little to do with
> the topic under discussion, and itshould be discussed separately on
> its own merit, most likely when the dust settles after this topic
> lands.  Let's not contaminate the patches that is "a trivial rewrite
> that is so obviously correct to fix the assumption that ulong and
> size_t are of the same size everywhere" with unrelated clean-up.
>=20
> Thanks.
>=20

Sorry for the confusion and noise.
My brain insisted to read
c =3D *cp; // fetch 8 bits from memory, upcast to unsigned long
as if we have written
c =3D *(long*)cp; // fetch 32/64 bits from memory
which is a completely different thing.

In short: all is good.
Thanks for digging and the patience.

