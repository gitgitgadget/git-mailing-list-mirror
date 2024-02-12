Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720854DA1C
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779795; cv=none; b=DU6IMMaOkj+93uobiJTLQ1HTJigNNv9THdvc96tbQIbF+LAL/faOY+vRf29yV6KhP2QoPHQex4aogNjohNIlhGHsn47IsHhjY3prREg+Hd4CODyRL3Rs46E9U3NWF8un9mS44IsKMqLB2O9EUNLxaVN1bbhNfIrv5Ifv6bBEOoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779795; c=relaxed/simple;
	bh=vNVWrJClhu1xz/Km5rhghW/d23ENnRtRWT8SV3jEkrw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VJRO3FQ6/ZhPu/wJNhFwE86p1s608+9mz0IQUpIsAbN/YVmfPkNfhxIG3SlrSFE7i+iLU2kLixLBftZVU50uRTdiyEz2O1Sq5KUQs8fQ8Te0o4eYrF71iw9WEaDVQldE1386wiZ42n4uJu8U56iX9+i8F6p9+mz+1B4CyDw22pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=KFG9dMsJ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="KFG9dMsJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707779789; x=1708384589; i=johannes.schindelin@gmx.de;
	bh=vNVWrJClhu1xz/Km5rhghW/d23ENnRtRWT8SV3jEkrw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=KFG9dMsJ2KBI0cMUGmY4thTRJSkK1okeyESFgEiiG0IVRMZ55AhMiI+rJ6G/dzxt
	 hp6tv0tnqmcvActppCwV1ZuI0e0KnGqVNd3un6SlcXBCthNXAnfhpK2w9bd6RmZDo
	 tKboYbMGVS4aiY+q6eZN6A5tQBI9jGqNVtJKLeaHKKcUmJxfTBH0aUT1GV/wd15fK
	 OxMUlUH/j1RZJxqXurklXX8F/5kroYyR+M6MkoyuqppKiGHE+nZ5RI7TZlb1dAAkn
	 /7/yDOYktzgtWKJjxg3T+v8fEV6czNdLUGw52sjHaSCLNkcV8QI4zTaUvLDnm5Tdd
	 6BcpSn3IIbBUHN7U2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.133]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvPD-1rSH8a2DHZ-00RrZY; Tue, 13
 Feb 2024 00:16:29 +0100
Date: Tue, 13 Feb 2024 00:16:28 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Karthik Nayak <karthik.188@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] Always check the return value of
 `repo_read_object_file()`
In-Reply-To: <CAOLa=ZQOALZRNqp7dDH0qDWoHwo6_3G8VgVuMbb3C20UdJ4C5A@mail.gmail.com>
Message-ID: <805cc537-a567-e261-860c-5aba826b9e0e@gmx.de>
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com> <CAOLa=ZQOALZRNqp7dDH0qDWoHwo6_3G8VgVuMbb3C20UdJ4C5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:w+KZFBcdnz3f7k3JIp97ozjnh6F+V2rxA4Ds5+8ItKg1kEcqnX1
 F9UNcIlW+eBJY09lpBjV7kYQx8LjkZvSSEznumgEMB/8FXoGP4VzZJcUdnV9MGL4iSemf9H
 5NWqCkk7GCMp8TQvjVmA+6WGIQSYrbqOisTkFkthDLPdIMgCH0Qg36Sz0+BwkFGjK0sLR14
 YqtjOBg7e1bm78pem0UDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pr/K0k2OSOU=;JbjOGKqgD3EmecSaYJx/szZuZdm
 3aXkPR93NqDzmho1m1i56x+Sk4f38bV3OqOuYnETR+ght0O8KbLseO+k2QAFDjKaQ7AVPUcWO
 /w1M8uXyEenC5EKHTGbxQngIZMetnadoLzu6Ao2qYwVpQI4Ize3c7K3Oxueqb+m/pbwjnIj6t
 WVmeFrCoiy9HH8zH6fSmpEw40s+ApYYY/nNo+nDfUqPLXN+eHbJogqo6KCGmOAPRLDziFaJ4s
 i2tNdxnNJKRLkzjxWPTd98+K98b7k/CCP6hmgbABoJ5sQNYkf3nsLRj7WskSLeDGcnG+xJ4OV
 bexJmtzSYuXPViLQr08C9XD5/rTGSiQdPmjPDLmmc+1jA6Q0oKlNuEawq14tg+cLEGb9sOQnf
 lhWlHwfhSlDc6Vzm4g2mBTNuZZuTsiiirxxmsoKsbiX99CjfD71BL67WAOz/2j42pJINjebNu
 3HzRbpMh+Q3FOR7FVOFgkSofC1rlWyAT60FYNdYf5qwRpnduU4pVrpzdkhFQkd1nd6voQ5675
 2Ut0bshHNx5SHKGln5F2YUd88aoK7IEghF6OKE3emKjKYFkP5EPjAAb8MOETnnBEwfVYHVruV
 /4TPgCjuP1SxiMSMYYWipr3Q6N9XqJFMz0Wu618Tw+BwAHiPYa6IqDOMGk7pFbzBrw3JwImXm
 FP6heVPpaFA2Jnjd+VvkMgVBHeNki2Hswx2YHOd4RDbig+vy2ZekJcN6QOxf6B477hbJaKXA6
 h1yefwhNQUkZVa32JdyTyACLJvufCTT/M6nNnDtxZFbj9B0seTtIyWoSdIdUCt9RWC2zAxiUB
 np5JB8QC66SZFYQcIXZc89xjuAUEBEkqJ1/AValeNGNfo=
Content-Transfer-Encoding: quoted-printable

Hi Karthik,

On Mon, 5 Feb 2024, Karthik Nayak wrote:

> Hello,
>
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > diff --git a/bisect.c b/bisect.c
> > index f1273c787d9..f75e50c3397 100644
> > --- a/bisect.c
> > +++ b/bisect.c
> > @@ -158,6 +158,9 @@ static void show_list(const char *debug, int count=
ed, int nr,
> >  		const char *subject_start;
> >  		int subject_len;
> >
> > +		if (!buf)
> > +			die(_("unable to read %s"), oid_to_hex(&commit->object.oid));
> > +
>
> Nit: We know that `repo_read_object_file()` fails on corrupt objects, so
> this means that this is only happening when the object doesn't exist. I
> wonder if it makes more sense to replace "unable to read %s" which is a
> little ambiguous with something like "object %q doesn't exist".

I specifically copied this error message from existing code that already
deals with these errors, so as not to cause unnecessary translator
friction.

Ciao,
Johannes
