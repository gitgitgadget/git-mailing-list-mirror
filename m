Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031475695
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721818124; cv=none; b=NUgz0G8BqCsVIgRoonfIeemLpshQyUxJ3Z6W8T8Neq5LsUqQv1BmFOoP7XevxOz6kebTihSSiD/Sqd5DI2/Hu9IcD6iytTyc5Y0K4EFJqxNOtkYHe7aEI5tGwh2f0QRjGsS338+JBQgB6vKkKBV6iZjUel+NDyAB2YSJ3/glAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721818124; c=relaxed/simple;
	bh=5MvjozP+nyZxQEwCZlcvAtLOI6f34RtZjc1jl/rDYlE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZgXvzaZNNpJdGHVtkroIOs4Dh9E8tV70Omh6u7SlWogvso4Mxh5InMG8h1ED0wPTwPVigY58QICf4d3RjSWR0KmRVOKt6eR+ZTOmfivTAWzp57qCbRmFUxx6sEGO7R0C0fXAAaekBMutqxSMZsa6Y11oOoerQlTu2cfrettylgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Wt8VGmMb; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Wt8VGmMb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721818101; x=1722422901;
	i=johannes.schindelin@gmx.de;
	bh=5MvjozP+nyZxQEwCZlcvAtLOI6f34RtZjc1jl/rDYlE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Wt8VGmMbgC69xyioxfo2dWwrSPtSZIiDTLGxYzfch9UHUE4SwFnu18o9/oB5JLxV
	 kQQr7CNsd5qgS1C0IleBnE15bFS9Szo5cB+lByWHT5e6pl0rIhaUqVoSFhld0qaKi
	 iBXQVTwb2pDygxdhwbCMNl7sNKTVN80kQpRqedxBvVWi49WL/jX2HqlnC2rZMzKn2
	 nGYaVsKHCT+FBcUDaV+VjekXmL+oRDBWg3+X4muO6Rx+MBCLmqXewzs5satl5JFj9
	 j5xVhvbvc+Kk76N6sQKgtdvHgpUSlhN+0eBZQoQBAxb7qn6rROrNUg47ViG7ylYEU
	 AEaX0uXRfBrOgh+6gQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.218]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLR1f-1sovLC2wxX-00VJAp; Wed, 24
 Jul 2024 12:48:21 +0200
Date: Wed, 24 Jul 2024 12:48:20 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
cc: Junio C Hamano <gitster@pobox.com>, 
    "Randall S. Becker" <the.n.e.key@gmail.com>, git@vger.kernel.org, 
    "Randall S. Becker" <randall.becker@nexbridge.ca>, 
    "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/2] Teach git version --build-options about libcurl
In-Reply-To: <20240624235557.GA2727@coredump.intra.peff.net>
Message-ID: <402c12c2-7ada-4d9e-c3da-1a78827e7496@gmx.de>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca> <20240621180947.64419-2-randall.becker@nexbridge.ca> <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de> <xmqqed8me36c.fsf@gitster.g> <20240624235557.GA2727@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Dvl9aV3A8dfpxQHX6GrVDNMwhbcsMpPIUV6YQEeWlVjvnmDx74k
 v6Vk1V3Oy5X9T8GRkYfWw8HPFW/2gebunIl6tlWUdEkzJH78/cQtozSiTTPGvtOV3268JLR
 pe18feSnNuq69nN6dkZjnMaJ9YFgv3BNEoKVrdxdPA/TpKvuz93fMI66WnicxsIt2bLxMH1
 jVVgAOW32xzUR/Og6MCMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bhhdJwUAqgA=;E5NMBYljG6dw4RlWj7WAYsiP75d
 5AeNZ+M4N73fcsbpATYQlas6dqwCELvtKByBjmiFq9TKUlp7qSQpDiZrt7QDE9oZZmYWo/xAn
 ItaKfPhkuhP0fQARaXWvYtdeLIaoxgweAXwhC5TWuZRENY0xDwoj9uKiE9+icqhke4eF8jAYT
 rCmy524YJdfhkpQMYmxvpLOHzDuoEYjCGsp411o29qOIiPGcAcejD1nextKTIQTAmsB8U3FWt
 xRKzFxDJQD2l0z9TmaLnL9B7Lhhr6TFes5IK/G/fpNvj9CCJc2bsputGb8VR3LmYP2FZHOWGj
 bL1wqaFtDVCzQby0+/jrQ0zuCLQ4toV+BdhCrkI1+CT8kIUvRuDBvpOG5NF7I8O9jYjbm8Ex3
 JDZ7vCCDCdMrYwbM0EkwIDh6fa+KUxeo0sPSwuMgsT1UcnKuWcmxkRJpbbVyaWslA6D9fgmJc
 m9lQ/o+VFoEU/idFz1rYinRwGTu8s0fswE3Do6V4WVqMSDFNOzYa8pYYJ1jwBKiibKhvfIhDf
 SSLaVZ0tb2muusIRQB1QjowOG5nvNyyS7IePDImcAShFmA//OYnxnbrr/kIPgt6hs0MIRYuJQ
 mJvR0vb3H/4g7TwKjj5Dym0Mkmag+VpRInmAkeDDTbr9Mm23rCN45xd1DRAlq0MTtItSTmzBe
 pJd0ndoJ2gQIxGg13O9LEjnc+6BvnBlLcWEglJJLbY28lvUFsbn/x0usR1HEph6gLUzwcx9UY
 FP3Cb9n8eEGymtqI64ImWUqz0alNONoMrCbLSCjtgURxhn/1CEg8B+y0W2FjoZt7wh1pod1Ww
 r7IKOxnrfyfzl1NDSzScQa9cqCEMFCl/KDz6F5CmUn8EI=
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Mon, 24 Jun 2024, Jeff King wrote:

> On Mon, Jun 24, 2024 at 09:06:03AM -0700, Junio C Hamano wrote:
>
> > > Wouldn't calling `curl_version()` make more sense here?
> >
> > I wouldn't give that question an outright "no", but unless "git
> > version" is split out of the builtin suite of commands and made into
> > a standalone binary, I would *not* be able to give an unconditional
> > "yes".
> >
> > For now, let's stop at the simplest solution---if the library
> > project gives us a CPP macro to use for _this exact purpose_, let's
> > take the offer.
>
> Here's another point of view: libcurl is not a dependency of the git
> binary at all! It is a dependency of the "curl" remote helper. Would it
> make sense for "git remote-https --build-options" to exist?

I preemptively agreed with this approach a couple of years ago:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.1911200027460.15956@tvgsbejv=
aqbjf.bet/

Even Junio agreed with this, in a manner of speaking:
https://lore.kernel.org/git/xmqq7dzebq4j.fsf@gitster.c.googlers.com/

And there is a patch by Emily already that implements it:
https://lore.kernel.org/git/20200214015343.201946-8-emilyshaffer@google.co=
m/

This patch seems not to have made it into Git.

> I'm not sure. It resolves the linking problem and matches how the actual
> programs are structured. But it is also not something that normal users
> would tend to think about (even if you are having trouble with https
> remotes, you might not know that is implemented as a remote helper).
>
> But we could also have "git version --build-options" call "remote-https
> --build-options" automatically, and just let it dump to the shared
> stdout stream.

Teaching `git version` to show the cURL version may not be the best idea,
especially when it comes to the version used at runtime and using the
command-line option `--build-options` (with the option being specifically
about the build, not the runtime, version that was used).

Wouldn't it be better to go with Emily's approach to surface this
information via `git bugreport` instead of `git version`, potentially
enhanced to show both build-time and runtime version of libcurl?

Ciao,
Johannes
