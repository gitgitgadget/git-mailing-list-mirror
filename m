Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAD11547E7
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766210593; cv=none; b=WJC8VPCbtzUPeCIqswy90Ena4XXoxECRl9YHd0y/wym1IuLwPbgRNCdGwHxl+AAE0vDEpqeqQIaudVtV8XgC/kvnWFc76QwbUBNEc3dUwOvB0uuv/InBYpuHRIaBc0jFPl0zODgo1UTbZTbuIzlPkIcw3BsI3ayqScBJu0gqc0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766210593; c=relaxed/simple;
	bh=xZ9TD+k/0/Gz0d7KlP1NRFOq1n6xYyS+lPH9xehceTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EgenGCDNIu72A4et7Mf6fGzsf7Cw5u5YbEuifZHqt6HhHcgkE43OSx7ioOoX411u7iLdhVVaevhIXz/U/0ZeAwm7E0F9NXus+0MqE3cmOtccxqo2mmlOtnVtAF1s5SVFzfmOeJX6j98DAvxeT5E/mGmEDoui3/XIhm1Nr3rnMno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NiFANB4y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WxvRGGwR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NiFANB4y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WxvRGGwR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D724CEC013B;
	Sat, 20 Dec 2025 01:03:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 20 Dec 2025 01:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766210587; x=1766296987; bh=Sdl1l9seay
	cojD8RZfuNef6bH94o7PGGLEhDFwvVzho=; b=NiFANB4yRyqeRF3UuryL1oOSsB
	W5TCPZHL37YLgiqNueJxGy3ohnAutI7KxuNUfvYvV1jHolCPVdwsxK3oI51RcRPZ
	fsBp8CmRf55LGbdG9ilyF6GnQxjSTEijOOyrGhwUfmeiZ+UO8Nw9cDmYRg9wGK2f
	yREp6SAlxwlUo9DnIAzU63wwUoQwatVqojbU596DeA+JzWfHa+t94WDNI7TT0I0f
	WKdOHpAR5ZDVOGZpZwXwaw0QRMddKkJXCiI6swfc3hw/kM/J0HVBgNYG83M1IpKq
	2H4S4DWW2vBdBGTIORC/hQ6xZhsvps+lDOdDtoq0LK1mpQUn8QZd7Hd0ThBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766210587; x=1766296987; bh=Sdl1l9seaycojD8RZfuNef6bH94o7PGGLEh
	DFwvVzho=; b=WxvRGGwRB5rT9g+Yps5EwELUW0ZZkccbJAOV66CJi5ZnELLDg4F
	89GhPGIk3MAaj8gAd+9LZncQRexLgI8U3ecIuV8vIoIvjCyVylmacO9UDtdNSp1e
	YwCaZ6oqnTrKSAPjLX7Bdim2JXOLB+0TNyuypWp4U6TsUWwVuBoDD9NG+llRfl7V
	TMpgfNZtK3Fr6PpriqKXwV94m3Uc7C6baUVrqFdCmMqsRdBXmK5V50JBthtzEIUp
	FgYBhknj8A8BM8yfIW4SeEQyXQ5QNldL49rSOa7kIJhYWq8EiZvno0vtkhr4yGDN
	moQBbnMwuDvfFjF3Bd2yF/b6j6xE+WyRzKA==
X-ME-Sender: <xms:GzxGaTS9EgsSkpsueirC708g34_SXlxGsDlFRIaoiTlNaYy3kNx97w>
    <xme:GzxGabwHFnTf0oLc3SrQCthG5igbmLSbwR_kGEn3WkmcD9m8x1_Ys6QIQno7lc68T
    X9XhlkLGGVfXSfnVfNEuhUL-dOuRhKzLsfvjv_KVVN-FxGuf4xRrbk>
X-ME-Received: <xmr:GzxGad1Ajs_4vSVau2jUE7MImrCQzi5Ml7-mJWB7O6aalW1rBknf7cfc6le182Sa5SwSMNf05asWoO9V1WgAzNFQkF4ueqG8Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehtdegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GzxGaR46tHgrMAj8h6JwUELlC-ggRgxuNXEuzN84lTzyiQHva3Oo9A>
    <xmx:GzxGaYXo3JUw4DbKfSOWjCCb9c0DJp4l1XSH5lW2cAf950gLTgosVg>
    <xmx:GzxGaYDMKEf_L-xTMbDJ9mnsHfe7D1OD06QOSRUpmBAwluEJweMTnQ>
    <xmx:GzxGaf4lBQJSU8an24rAP5udMul7Pviz1CtcvbdoGwhnGxec-vWpNw>
    <xmx:GzxGaVU9O209N-kVEyEot8Te410UxpiT-vn2RC2mh8glDtUaxZcnOVPq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Dec 2025 01:03:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH] diff: add --no-indicators option
In-Reply-To: <20251219190828.50839-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Fri, 19 Dec 2025 20:08:28 +0100")
References: <xmqq8qeywuno.fsf@gitster.g>
	<20251219190828.50839-1-haraldnordgren@gmail.com>
Date: Sat, 20 Dec 2025 15:03:06 +0900
Message-ID: <xmqqzf7du1ut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Maybe I missed your point about GNU or BSD, could you explain more about that?

When I talk/think about what "git diff" should and should not do, I
remind myself that not many things under the sun are truly novel.
After all, long before Git was invented, people had used "diff" to
compare old and new versions of the same thing to extract the
differences.  When proposing a new feature X in "git diff", it would
support the idea very well if these implementations of "diff" that
way predates Git itself has a simliar feature already.  On the other
hand, if the vanilla "diff" used outside the context of Git lack
such feature X, it is more likely that X is an ill-thought-out
misfeature that they didn't want, than people who have been working
on these implementations of "diff" (not "git diff", but GNU or BSD
or others) were dumb enough that they did not think of the feature X
themselves.

That was why I asked if there are precedents, either in GNU or BSD
implementations of "diff".
