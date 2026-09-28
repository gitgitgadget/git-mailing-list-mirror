Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4550C28686
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609934; cv=none; b=jA8nZQLSFbC9y5544DnlgFXQowv8kntTFAH2LibBq9GqtTr19YJXzt1rMjKltnnUw+gZpIXQ9UTBOde8oZvGezGPLheqlNCXmP3Vyl2rpdEafqABzr4HMT4SrXokYCBjsZnzlCEuWqOwGEPUzEXJ4FyqRjYq2v573eTHwIOzSmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609934; c=relaxed/simple;
	bh=/XWuK6ZeMx12TeDQjdF5FhDl656/OXauuHCvt07OXjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s0CuTfVfu4e72FsgQ1rVqkiaqDVaIe4+sa5p5P0QwscgCZxcWN08DMvN9GTmcoLc0zzZ3uuYahwRr59zTv8pe9+peFZZW2N49XosECis/nc+SaxGGGUHb+RBVJ9Yf8PjdNe4MENWoPJF0LaQj/nmrdeNb8moXBPEltdZXhrUL48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NQevyrui; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eh1hzi/2; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NQevyrui";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eh1hzi/2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1B6D714000E8;
	Mon, 28 Sep 2026 11:38:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 28 Sep 2026 11:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790609931;
	 x=1790696331; bh=Pzk8WebP2/ee9exWoGbEwzvvb9l7QOLk0zQGBV1CsrE=; b=
	NQevyruiJACVsYsVLnmVu/tFsuSrZC5KPZjzeIB0wfIcSsLmflgbCVQImu4ayCVx
	bda7acGo7GX/NxPU9BRa4qDEEEIajs96Z62RAup5uCpg4xV1fXrNFWrCyVe6DCJc
	xAWHYC1joObqDL7GavfvZHC1hPE5Mum2YS6rnHWKM4z9Z8/DpVjo24WkIbmaqBVW
	rc6tUQDC4ON4vgtGbd477qIwodQOqN6lwD5JRdJG/OeSiTwH77JaqwDgVf35yWfV
	hsos4pPjaai0V3bNKT3ZO4pBFUwQT+9j75obor4BX/b1M1wekHJqgi87Czgjc7tb
	f9wHkrOIKKV0iBVnMKFJkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790609931; x=
	1790696331; bh=Pzk8WebP2/ee9exWoGbEwzvvb9l7QOLk0zQGBV1CsrE=; b=E
	h1hzi/2EMaLT1bME5t1kyq3whW0PPQRUDuD8fN6VA0J1av2nZA04JN6xaeY52yH8
	sX5MRREw96/R5mGsx/ZbdyH7PvVGzERZiGHQKX33OwVnD7ElBLSEyUIm9Otz8eXV
	COshOTG41EI4pY951o9wNbvj3hQsHzPCy+nTsI+ZhNUvRTPmkmFxGZ1ZydalFFvq
	oWr5OyrQ6YKp5KAEL62k4vH0R3/sdrrFBMhz7CCCRU1el9acGaItu4Z8aFMoyQgf
	hO4h1s0qTyCZ3LS5jg1SC08j/dsnCBWPEr1fM8QUoXIlzaXNszCcKfeZpCxRZOtn
	Hc9hyysw5eEeWF5VaOi6A==
X-ME-Sender: <xms:Coq6av1c1p_OsovCNOkJm4efKDVLG4nPE55PsNohkcj6bn3UBkOx1w>
    <xme:Coq6alGmOyiVHl3AACabPKMIjD2Maa3D2EgEyyokyauv_2ZLIqxeoTgzHg4GUKfJd
    3-v6J1DnJhqhiP_0hmR4y5gmBMkEaJ3u8N3opmmfQ9RkuC68FApKyg>
X-ME-Received: <xmr:Coq6ak6kaLck_PDiqBHN6Xq6yFTay0IEFW8QE150LHLKqsW4UZjwTVbRhTjQJVHOeIr-a3HtJmMkzsKQj6EgipgW3EOdPjfkbPOd>
X-ME-Proxy-Cause: dmFkZTGGxtHliJ9QcxqqUsIcs0T3dtFhXcFvoxP7cLdOdM95Yiz62eZDwc3I6F1ZI0zc9m
    TG2B6ckovLTB7gFaGoJTa4xrePW5kYee2XVoIZtK4+sVXHEdjHQpaHn3MyYOSowlZxXWHd
    S2sFHjaBToCvCToLQiafPXVd9sqGpXQ4YsuZuyMWttNQdETr2YBe7dg4OwcePKWJo97pCm
    glUJZqFf/i6fE72VNCaOEjhv7iQWME+toO8uCndWllCjbubBXx+E/XxPnvnhuXCRsZDaJt
    Iij786c9tq9yuFmQmA8KgPYswT2UPBbSEKVzLo0GdnhKGvP6PPKat4TARI2Ztdvq6sEnTK
    lBmv6iuFqVrfEx+wBTI3+/TKa6PBiaqnIc0no6aVYPxQmrkt1lKLOHbN54gOCCpRgB8tDn
    gLJDuRVMqCq7hMciQbeItBOV2MdoAWiGtCfbbi6LL/8YTHEpsMf+cWaBDLZBkkYrEGf4Ws
    jFOhZ7bWfpb5Q8fl8MAS6S78OR826+XXDqHC5g37jiklK17mLKpFZBbpya/msebTzj0+Jo
    4wCFHz0iBYuL4YTPSZEDaZIcOxL+XcaxRT7oDujyhRRrHPbMzMDPMAStSYYIbJURVA1/Re
    Oade+w7T3uQ6hJUplEmiLhMpNpBUsR79qLC9f84FZH6AMJ/1ux24kgx4O1ew
X-ME-Proxy: <xmx:Coq6ajsXNBCDvzdOdJzfi4cCpmyC2L6445nzdIil0Ac8lFBSjrxxGA>
    <xmx:C4q6at4bsvS9z3TTnHv5P3F_XDOFwBmm9elpi462JQFgTmSq0t4esw>
    <xmx:C4q6amWfHbi70eO9udX-L2jTMXTmYJd7kQq96bwROtYodXydUB_KTg>
    <xmx:C4q6an-v2BA7Kp9wrRqfh9cFf-4ZsNpZBJTCFvFxbzwbOrZFXsYFjw>
    <xmx:C4q6arhXpN7p_zRVYM0hFJ7fcTMEFMQ8ENWE0Z_buN3x9xtJJewMOYyI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 11:38:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] .mailmap: map Kristoffer H.
In-Reply-To: <mmkh.cde@msgid.xyz> (kristofferhaugsbakk@fastmail.com's message
	of "Sun, 27 Sep 2026 09:15:20 +0200")
References: <mmkh.cde@msgid.xyz>
Date: Mon, 28 Sep 2026 08:38:49 -0700
Message-ID: <xmqqy0clmlme.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Map my email addresses for Fastmail and Gmail. Fastmail has been used
> for some trailers and Gmail for my first four commits.
>
> The `code@` address is my canonical address here both for commits and
> for trailers. I recently posted about that preference.[1] But I can do
> more than state my preference, namely to make it possible to look up my
> preferred name+email pair:
>
>     git check-mailmap 'Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>'
>
> Which one can use as a trailer command via `trailer.<key-alias>.cmd`.
>
> † 1: https://lore.kernel.org/git/add1abaa-5d51-43dc-9907-d6d3851004f5@app.fastmail.com/
>
> That’s the only motivation for this change. The Gmail adddress is just
> for completeness.
>
> Although the proper long-term solution would be to fix my domain so that
> Gmail doesn’t think it is suspicious anymore.
>
> Assisted-by: GNU Emacs

Is this an attempt to render use of Assisted-by trailers that we see
more frequently these days less meaningful?  ;-)

> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

> ---
>  .mailmap | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.mailmap b/.mailmap
> index 29b48905327..3aec9edfd16 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -157,6 +157,8 @@ Kevin Leung <kevinlsk@gmail.com>
>  Kirill Smelkov <kirr@navytux.spb.ru> <kirr@landau.phys.spbu.ru>
>  Kirill Smelkov <kirr@navytux.spb.ru> <kirr@mns.spb.ru>
>  Knut Franke <Knut.Franke@gmx.de> <k.franke@science-computing.de>
> +Kristoffer Haugsbakk <code@khaugsbakk.name> <kristofferhaugsbakk@fastmail.com>
> +Kristoffer Haugsbakk <code@khaugsbakk.name> <kristoffer.haugsbakk@gmail.com>
>  Lars Doelle <lars.doelle@on-line ! de>
>  Lars Doelle <lars.doelle@on-line.de>
>  Lars Noschinski <lars@public.noschinski.de> <lars.noschinski@rwth-aachen.de>
>
> base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
