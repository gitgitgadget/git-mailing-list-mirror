Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8628D11182
	for <git@vger.kernel.org>; Sun,  5 May 2024 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714907028; cv=none; b=AhL5/7kzmMIY/gjrNrTbEfogL94Gd+ePtsV2d1KNdUw65849+IUJ/gYLvZ6WxvJFJbNXtvJNoeLm9xnJ7n5VTiRp/GjWRGlWoaPTdV6vm4PoErA228W0xrN0N6cEcSX5QjeQ7bxXqV6XRwuslhY4cgbHGC2UwuDkYK2rdQ8XSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714907028; c=relaxed/simple;
	bh=7Tfgh1GE67CnMG0UnwKit58FaOv9BCALitbqDTx7yQo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ju+nZ1DNuzBk5CT57urSm0RXsA6NjZA/G9g9PYxELvEbDBZf1RjjcmnV2ZdxLBCJCqqArUBV8XNN6AdALRzNmP9I9iv5TBq8cgchPOlBrtO7zMtek+ZMtUYXvX3sIj32vbjqpnWZqWa1meH8n1z5vepvfdfSzFgef4au9dOh0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ORhizMzZ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ORhizMzZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714907018; x=1715511818;
	i=johannes.schindelin@gmx.de;
	bh=c79EGMoqlEbsWm7ApyHRm/SvPzfgomRf/E12RuZaj+Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ORhizMzZ6hFlDm/8uDVI4UWcNAYz46rBN2uU1PhCOhU/DEQ+2HT06hMRenJWE9yX
	 +ocQyfEhuT73IZzGk8G/xX4g1knklg9AqEkdcpyyD8yYcSXfU9bHG7HbABM9zsCUg
	 ZbAYdxGJq611KuxvLU07w6eUS/f9r8J8TaauIUbnonIc8bOVeOnuqxaLoYBALXSyX
	 VhnhOl7UnH/tgi9SkuuE7RYpASmN8eIQZA2cSYPmnM/UYGCbqMCpqMBsFvzXTGxFe
	 aiN69g0gFzUp20KpU6RtG40WPoHxaFaltqJUgyqp0qZCfeZQIRs1PVZKR0ACv7dq1
	 uPzWKuFrdtZvvx6Gig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.216.58]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybGX-1sqsvE3YpJ-00yyoX; Sun, 05
 May 2024 13:03:37 +0200
Date: Sun, 5 May 2024 13:03:35 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eric Sunshine <sunshine@sunshineco.com>
cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>, 
    James Liu <james@jamesliu.io>, git@vger.kernel.org
Subject: Re: Re* [PATCH v4 0/3] advice: add "all" option to disable all
 hints
In-Reply-To: <CAPig+cT-xk13jGEUmpT5QmwVYTxKNUZsu9xJ=Ph3h4AzKHg6pA@mail.gmail.com>
Message-ID: <34d77e4d-6edb-99d0-7fc5-fea5224654c7@gmx.de>
References: <20240430014724.83813-1-james@jamesliu.io> <20240503071706.78109-1-james@jamesliu.io> <ab604f4b73eab1d9aae4e2a20ba0630e@manjaro.org> <xmqqjzka7p2t.fsf_-_@gitster.g> <CAPig+cRZEQjwhnMYvQ_0BjvXaR=3x=LQeJHzFOxC+ZPyOy9yJQ@mail.gmail.com>
 <xmqqbk5m65i8.fsf@gitster.g> <xmqq4jbe64l9.fsf@gitster.g> <CAPig+cT-xk13jGEUmpT5QmwVYTxKNUZsu9xJ=Ph3h4AzKHg6pA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1300807736-1714907017=:516"
X-Provags-ID: V03:K1:5sDzXn+EG/ROjwlhNmvcQueoF2rp1mVBPAy1NJrPgmGY47zbn9c
 4xbZqBzEbsMEIMGS3ws3iQMjC8esGJx+y41pVWinHrOfWE4ONhkx6sc8+ruxqVZGzWuYakq
 Bj5x5gvRAKqb5eRUFHE/amzn19GM7mjEwANKEV3eHIEwcEC/u2PYTCzbRs4/PxWQcVsLe/K
 CYbCQSQodUyj8evLRCDaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zWGmJhUxkvw=;kBTuJzJ1XppV13CeWrwprUPEJ4h
 RBVU5vcnM9DwZ75ez7jrnKAe5rk+6ZSQ5B+z7Vm8gFLOWyVDzG5h/DQH0NevfTnBNxXYgLntD
 mLehzcZBd+4D2ZO9Ds9q3vPXZRSDgvbGlIQUya5i/4HR3Tg6w//sS5InRjnT46BHh6tBOv/zT
 bOSnWzHbCYS91d1JhLmlvu28CDP6JYO0OfiNkkU8kHNWhAxeh6ZyfzxMdPlqQsiXZdakJMkey
 zBk9dGli/esyU5vwmpmbNchugi/2w0K2jJPDU7gkA3rygPKlXwi/Be5ssMyGmNzaQt2eByiTX
 fINPYKfCFlOsJng1Iiyy077famSQY03QYi2C/xFx4fOjSFhu8y/TpSmlwdG/n1yPtqkRSBtqr
 CSWUTpnxrF7+k5LASbA7l0X5uCL/59KLvOwXD5E3WzlsBluOp+2XGvK/DtreSyC4XToDhbOQU
 3Ru5tjELjoqGQmDzZDzKlBL2QRCmjlJnVK5RW0twYUjNiPD9V3uORJgInwzzefDba+3aIyEF+
 ar1oTuFGRDqcLKNLKy0jDdpVsz7gHr1ANGIq7mvxQqPX/KKJtRXrLXtEUg6YwyBUuTkjAlbvB
 +VaYW+JsJtHJL99PvlzmOr9fZ9nAXYLRW69e+0DCA6B/C48ww4ytWSBZ8l/775uSqKTVua6D1
 RFr38YcNDZHvPhXnF4Q+tUMHfYB33Ynbz2hSvnZufnm6vwtu231vKYJsOvwjrUWJlPAHnSds0
 odiBo9S+nn43z+70bsTzsE31l+N3UTVBAhrucDDzq5i17LmJcXIxWR52vs+rBN4JG65XteBIc
 cIPs5hX3YpI8Pr04yTlpNoFEOFknCNRRIZCtpE8Q78SK4=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1300807736-1714907017=:516
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 3 May 2024, Eric Sunshine wrote:

> On Fri, May 3, 2024 at 4:08=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> > It seems that Dscho was in agreement that format-patch's use case
> > should try to be more aggressive at least back then.  In the message
> > in the thread you pointed
> >
> >  https://lore.kernel.org/git/nycvar.QRO.7.76.6.1903211209280.41@tvgsbe=
jvaqbjf.bet/
> >
> > he does not give us the exact reason why he does not think the "more
> > aggressive" mode is not suitable for other use cases, though.
>
> Having an answer to that question could be helpful.

Sure.

The `creation factor` essentially tells Git how confident the caller is th=
at the
two provided commit ranges contain only matching pairs of patches, no
matter how different they look.

When calling `git format-patch --range-diff`, we can be _quite_ certain.
Not necessarily 100% (in which case the creation factor would need to be a
lot higher than 100), as it does happen that contributors have to drop a
patch or two, and add a patch or two, sometimes in the same iteration.

When calling `git range-diff` in general, we can be less certain about
that. In fact, users like me often call `git range-diff` to _determine_
whether there are obvious matches (for example, to see whether commits in
GitGitGadget PRs have corresponding commits in `seen`).

That difference in certainty is the entire reason why I contend that
`range-diff` and `format-patch --range-diff` need different defaults for
the creation factor.

> > A similar thread was raised more recently:
> >
> >  https://lore.kernel.org/git/rq6919s9-qspp-rn6o-n704-r0400q10747r@tzk.=
qr/
>
> I think I missed this thread.

Heh. I had forgotten about it.

Ciao,
Johannes

--8323328-1300807736-1714907017=:516--
