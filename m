Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F641A79C
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417778; cv=none; b=qm2Xbu12dURfnj6JuidytmOAyOb8AHUfDPdDG3Bs+ddXINdbtvquC7neDbR2NrBN/n4E/vMmcFMpl+qLeHrqcXS6aHw/SvXD0hInfg4KJfbmH291KMU2FJE5uWTNnWvnpf1D6HDudB0ecIb/ngTt9efWWsvEhaaDF6AtFKhVJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417778; c=relaxed/simple;
	bh=W97auX8dLYDAQdChwGnDva2GfHOXzWITXkL0UeHXWBY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=N1g6oyXPNXTsq4slLvYGFQxucPxdSm4w0FP2/YRPyqq06W5Xo4WOj4C6Tl+eyLqqe/JHVSLpXTrUf03gEcI0uqUvdzrFpYm+myOy8/AlEywz+2CfZ+TO7SWprD/zGdFoEElPu5Uz/AHd0AfJ2NL9wu8/vY4MTFy+coybNwIPDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oMaP46BD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hAflvYIS; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oMaP46BD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hAflvYIS"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 856FE7A003E;
	Thu, 30 Jul 2026 09:22:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 30 Jul 2026 09:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785417775;
	 x=1785504175; bh=GFxOyWZkEh/b2ohjiKpxqfQxKaWhP7+4aTKG8wkZErk=; b=
	oMaP46BDWE5bphVP3bMpBbC7CprT/gx0oOOZqIpyazoU7/8M46jNMA4s7ZWtvbFq
	9/98QwQhyKhU1pZaI1Wvnne1XmT+WcdwrsIrbZHmVMU9dwWL3laaSukmNujonRev
	VuI4yDZqxFX+MuDU7y+VCreahPJwc/vlA93lnI9jF1ues41kh+5C8xx9OisI+WcR
	n6inOZNlP3uWs/JJxcg7QKhWPPYi0Ln9D1+bS6FJAZzCrfa3VoNUX0/5jfGv+auH
	oFgD9R0oYE0RyJle6mkuA+ZY7+Jp/XKTkrZfWruxR16O+MlrP44fYavwxQJiJmHo
	oBvKoOPK71Drwt+DLEXUqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785417775; x=
	1785504175; bh=GFxOyWZkEh/b2ohjiKpxqfQxKaWhP7+4aTKG8wkZErk=; b=h
	AflvYISDofGDHZ8Fg9Te4zgEtXwINDMoQxipWbKpkfkzSNm3lZiANjyfLjAhaB5E
	suyYAUox7uqZ1wHG1KZkY7S90DAiU4XcxjTpQ6e1plgWD9I9w6BgXtvDu2tMrjAz
	ekaOwwqL/ZZv35MexPGmfibSZ7znSTP34hFqtHl4C6h1KKK15wn0qkm6TyEGz/7N
	CSA1MzCLjhlFSUA63pazQ/MiKagFcUZjajvuT2NviKedictSzwH0maTKAz0Qr8gf
	SIRrNXjQz46tO5xRGWwnfOpNtwu0uGfVPmD10A0hNHcGK+0eScLMpkZK+F3Bfqsx
	XQEl0ZtSGwtsp0cl+SKdw==
X-ME-Sender: <xms:L1BragQz5zA_pXukJ5R5cxPH-GV0ld-XuEUPZbOnDiUtU82ZFswRMg>
    <xme:L1BralNIyLu9uI68Q2HU9fROUqbilFogGTt2xQ_j1XJS631y2yOFgn3oKv76s-ik-
    w0bxAFsCeMKnq6a4gb81MHC93x4bN8Sdo-x2LLFiGL5_J2klWpZO5A>
X-ME-Received: <xmr:L1BrarNlQ8D6t4N7WxiycmcWFEelHT9oxaHOhHW4rRtiGgqiG-W3dTd-EBE>
X-ME-Proxy-Cause: dmFkZTEL76ct5ctFc4iWUf23AMFAWfMFjHSOaXx3O+QWJHGRpbvnWh72UQYbwz4l/swJqO
    1PMvzI558rLa0q+fWhkOYkbYpymZPylGOGbNP1sOAA8TksOe4+VY7zvZ83oC4mdD7weBJW
    spZ8pqTPzXz4quuMw7wAY+WsDDQiGF3FdQgiwK3kr7vg/WJrlrYHHeDjL3PRfmRtISf8lu
    kUgUgHRymAkQ3N3ObilGuVdjRp18qQTd7W8JjirSTDGdHl8RFwH8gx9t3qhBBvElV31e0F
    JT9xq+hLrxDSI1bnZnIdsiARxBYvZw9Lp59FM1O8gj0Y+Y4PhPZTldG2U0AZSI4gDXaFgP
    66KNBYsj2MpUSq70aAjmbZLpfySmjyGoAbIQ86NRxvjnxpDgYiQo2McVhxg0ZwyR5zWALt
    2K7DpxNHn7M7K0/w1ZPSE4VSPAsHsVHuL5H2o2d/fhVdLwWXkRBxTDa6mG80WYRqBv+wo1
    mZmtVTTe1juOgFRH7Xk5aWbN8BNY9c/m72bv9gTlEOUAy2lyHuOrpnPs6IFyFuKylo/nHe
    JMM7zfjU0plsGPx/Z0P9FNWrFFXPYzNvZNnt4j8wEqn6RDarX423PkcSz42tMxBbJaUsfi
    2DEHlx/vBM61XXKt7nHNoveCM4L4P4ux2MqEg26yAhjzGq3nVD3HVuW03WaQ
X-ME-Proxy: <xmx:L1Bratui3006COxKvgm3FkIgb_qu6lH_Y8B4lw3JixwxoQbFjKR9kg>
    <xmx:L1BratWUzopRbvdkjZ85Wrbuf6i_dkpVpgdt-EcgojVIzMCFmy3MAA>
    <xmx:L1Brats9mqgt17x-RhMch4ZJQQqnPVOPolZQIyIyJ-jaeFpDjcp8uQ>
    <xmx:L1BrahUi9rqYGNDoUlgyRss5iDS3GpotDnOCjGJUHREEQYLY90fMeA>
    <xmx:L1BralN40b2xeNuXWTnXGtvClJENARW1RpsaupDsolhUqufhu_OeMxCY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 09:22:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] stash: record positional index in 'struct stash_info'
References: <20260730034108.765430-2-gitster@pobox.com>
	<AA402B97-B3DC-4085-AF53-C6D80792C3DF@gmail.com>
Date: Thu, 30 Jul 2026 06:22:51 -0700
In-Reply-To: <AA402B97-B3DC-4085-AF53-C6D80792C3DF@gmail.com> (Ben Knoble's
	message of "Thu, 30 Jul 2026 16:43:07 +0900")
Message-ID: <87h5lgtxw4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> +    if (at) {
>> +        char *ep;
>> +        unsigned long u = strtoul(at + 2, &ep, 10);
>> +        if (ep > at + 2 && *ep == '}' && u < 100000000)
>> +            info->stash_idx = (int)u;
>

> What’s the purpose of the 1e8 constant/comparison? I see we
> truncate the unsigned long to an int, but even on 32-bit platforms
> 1e8 is a small portion of the integer range, right? So my read is
> that we are limiting the valid « n » in @{n}. I’m not totally
> sure why, though, or if that matches with the rest of the stash
> manipulation code.

This mirrors what approxidate does.  An integer that is too big is
taken as number-of-seconds-since-epoch.

