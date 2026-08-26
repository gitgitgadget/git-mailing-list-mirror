Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D845DF43
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766336; cv=none; b=hKH+T/D/TsW7GYOBNL8qTzU92+9UVGtwHfUGuG6+ON/lujGlF2hFJJoJbTYsFkq9OgUVOL7/1IkD/c3H6MS88i1S5JqukfpygpU6yGwcrFrHsGVFmb4uMtY6huDzLD5OK//rSQBhk3M7GZSnt5h2wE6y+JyfhicKbdkOeplNsL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766336; c=relaxed/simple;
	bh=LAhdqF0hdw7mbZDSgu96KGBqDjcYGUdsZuS4aqfgLxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aRwd4vpTKhnSk8ckyaaAvnIu6/0gYQm5jJ+mfThm5Ya96JrVWlbZ53R0OIps14P9fvumF1kiXZgQOR9iFM1nnoUX5HfwFzmOC9PWZuP/hc6KCIiUhojGhasGhBbIr19YDGV3drfwKNFa1nDs7jmnvIFCXnzn488Kh5p8m6wixJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eG2fbxpp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IYooeCMy; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eG2fbxpp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IYooeCMy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 65C3D7A00D3;
	Wed, 26 Aug 2026 13:45:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 26 Aug 2026 13:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787766320;
	 x=1787852720; bh=ATKgNVfb6UXbErC5jxYunHrn4r8l75+cbQRarFHFyAE=; b=
	eG2fbxppK+qDovYqW1gdb864aaRx1RK+ejOsYMijuYBS5/5C4CaKKOxj3lUgVXiP
	86nIwArX0zGDEfU/bxHqR+PPA5yKTHjxAxF269+/BkiWAfLIWDtyd7QioVqz1lyG
	wsMQ5jwtbw+Gzwoz9WKDuxado0exxaZHdfXdi4jCs0fIymn+zEf7TTA0MkVhig7w
	jFuJpoLYAu1thil9MhaT6S3/XyUG1OmvYRuvtHwNaV/yRKiUxO+g5zJe9f0jjpuF
	QRY8LXVsM6eLIuDVHj+1ti+sZnKorgd2FHRmQjnREqqrr6Fwbpno/ZHkPaOKzNVv
	/fkQCKJrdCoPFMACSk5Ucg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787766320; x=
	1787852720; bh=ATKgNVfb6UXbErC5jxYunHrn4r8l75+cbQRarFHFyAE=; b=I
	YooeCMy17wZl80pY+V8yUMHZZXb1Z/qUpB50jPy+GdO4ehqEP4qpDq31fRTUc8IJ
	DNJlWqbss2jdrFvm3cU5tQPhf/Q0Q+2qp9Zf+Z06QCLZzHq3BVeGZfgD3+TOQvTf
	cCOsJesGzwEILbP335Gj/zIJ6zlCC6U+NXI+qi6fm0P9kpeHtdiTUCbexsZ8J7Yw
	ZYC30HHaIyzFwmwQ7uUNi9Cxtu7TN9HkgKXkdR+c/L8Q81H1nYnnrzmzhsA64CyR
	rRSjy1OAJgUPV5y99ZaxOV3xV3KR0Yt2hQXfHFVPnmvVlFKkGm3ctJQjs8TcaZGk
	QcVTX4sbBud1bWRMY0LDQ==
X-ME-Sender: <xms:MCaPav-c9qErwOt_5lWbr02bWXWLGoKmjt_-Q9n_rNFBiUaNeXtYLw>
    <xme:MCaPajLq8xXN2CZKITa7c8r3R2_JubSyokTv8oqV1LU1V_y12_Xw9GIYKxlMNQ-Ym
    bvYyhjYsVprod6uxdPVnqBbjCBSHujfk4-swNP1bcQt6aEto1cS>
X-ME-Received: <xmr:MCaPaqar2fPD5CR9vwkIfgGRT-sefz_Qvvw05GvNVeH-czz_fWQp6HImBK_XFfEvhVHliMdtL9YD0GwhU8XTKNPrSgYo2IUiSg>
X-ME-Proxy-Cause: dmFkZTGleONRcJaZ7nUlPgyjK+PyXiL8iTpUf3hzAwDBCVX5Dei1AL9ISJp7h2oqN5WuXM
    J/zmUhKxJ8YN21wD8/fmUfi+D16vhfbY8AXHtWtx9ec2jJbrSUtwp3xvmK9Z92BzLrnglk
    hFCsWE/P68MidCrGPvN44osh2ZkBauugpWRW9H7dDCy2nEdqy/x/we9LZgUE8JohYbkhFC
    k2IiNaYpBXmq52WlrtAGBK4yPh1cp7Nr6fAGRw5Si+OHC6aeJav/dlAIF0ets3k1WNaWQ4
    k5BYSLMvNUqv7AY5ZTQ+/wvF55heZgPowpuHRpkeYRf5X9WMnxOOcjfMj7T8di5zNcgQr7
    e9ZbkJc+W08ZT2Zai+OEvEhn2C0RvKXiYYY+lz38HnGgXpPeybCzGmKFBQEs4DdZcdKijG
    hHB9ABk5CjvPW8Ru/1JKCEUY2nzf3Y4peKQTqnRNpgqbLsFsXfArvxV9+39dR8oESIsfxr
    fn0oFFdwP2bOew52apg7Jme1+2eZGhc1bN5af+/SeMEgizmcyQ+3dD3s1bD63mwi0B+4IA
    lEy79Pm4OGZ2l7il/zp2Bd838Z1UpthsXv8mPL33Ku7OcbVP72nFZpQWhFPISnPdjzJxhc
    5FgKhKAgPSIxNeX3YxU6pbz2nBeLwDlj0AfQ6Y17S2HBthRm9IkSO0JI015Q
X-ME-Proxy: <xmx:MCaPalK9t32yUFboXKigc12ya0pFeOvNXjQCtm7TWraBKLItBOGjRg>
    <xmx:MCaPaoDDTKmgx9PQbk8bSN0-NSQM_fPstSsOvE4DTJROsJfxu4_mjA>
    <xmx:MCaPaqq-5VFelGFkSH_XTDGbo059-VC2JgNXbNJuGKwejH-3WpQO6w>
    <xmx:MCaPajj0qeYFd_uYdzAYylR-Cizlh49kfP1GXdkhW4j2LRvZXRAqNw>
    <xmx:MCaPavKG5_o5oB98p767kbzl-EnLcM33W0L1OzbyRUrYyeWsnTnFrgJU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 13:45:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] you_still_use_that(): reword the instructions
In-Reply-To: <CAC2Qwm+Dx1UxLO3EOkQ-9uBokxacVfgrs7+XCj3BeM9vt8HcPw@mail.gmail.com>
	(Michael Montalbo's message of "Wed, 26 Aug 2026 10:12:13 -0700")
References: <xmqqo6epj6is.fsf@gitster.g>
	<CAC2QwmJ_fjNw9z+8an9Doq6Mx_29R5mcGXT1=NnVvu-g71QByA@mail.gmail.com>
	<xmqqik4wizqf.fsf@gitster.g>
	<CAC2Qwm+Dx1UxLO3EOkQ-9uBokxacVfgrs7+XCj3BeM9vt8HcPw@mail.gmail.com>
Date: Wed, 26 Aug 2026 10:45:18 -0700
Message-ID: <xmqqwltchj2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Michael Montalbo <mmontalbo@gmail.com> writes:

> On Wed, Aug 26, 2026 at 10:00 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Michael Montalbo <mmontalbo@gmail.com> writes:
>>
>> > I think this change makes sense.
>> >
>> >> +                 "- Send an email to <git@vger.kernel.org> asking for help, only if\n"
>> >> +                 "  suggestions by others do not work for you.\n"
>> >
>> > Maybe a slight reword to reinforce the idea that the command is not coming
>> > back:
>> >
>> >   "Send an email... asking for help, only if suggested replacements
>> >     for the [now?] deprecated command do not work for you."
>> ...
> Adding something like "[now] deprecated" or otherwise more explicitly
> suggesting the command does not intend to return is my main feedback.

The same function emits a message that says "this command is
nominated for removal."  Perhaps we want to strengthen that part by
saying "will be removed" instead?
