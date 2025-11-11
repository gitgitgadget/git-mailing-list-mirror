Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A902C324F
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887546; cv=none; b=q6vrd4iCV9fXHtEvffA2zvtm6I9z8LSWyiOUdNSgrm7zPZ5DZSnKZG09cHYy/FSRK+teWNkIRg17k/D8eUMLuDmVe8BHHgkUhy6AfmGUPWdfIn6cqY8C6PYVoxAsJBBls7Het5ugK6c7bhY9PUImswSZVHTsqhFHgCh47nDq808=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887546; c=relaxed/simple;
	bh=SIcklFKLShf8h+8E5on+megqpbrm/jTqI9DX/Woh3mI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fUhxEGchG05loTtMub90wPsjwvZxkNQZ8BdH89ESMY8uTJA3XMd7OGJkeGJS7WAotEJjfi8ffnbcxUQ3/XF49uLawjqpMTa7zvsyJw4tsofKfAM5kCH5qaYjwemTTw4jyeJrOApWf8HZRpLpq7dPDF+UazW9Q+Xkdp4DtT+wMJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CavguEv6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sVIg4654; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CavguEv6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sVIg4654"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E0BB7A0161;
	Tue, 11 Nov 2025 13:59:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 13:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762887543; x=1762973943; bh=QZ8EPUsmPa
	QhzcCsCRJFYHiWy83vXbyer+Cn8YrdO2k=; b=CavguEv63nIoF/n2Uon+Ncz0Wg
	IBn0JK11sbiIbLmMog24O0TlMDbTRTdBjZbCNsYZcT0xTOMSrEWGN0Yh3m+f6WMk
	cXNjbL3rgdrPYkxfTUeUG4Lf36ARBXcgZuosKwtENbUnUx9fL+6ZhN+daYyTIhNt
	JqKJolfkw0yK4JaLPIJeMNCiecHstXL9iHTu9Z/hAHVcRPPeOqziO1k/ois/X6/n
	IfD0eS2/8RdVoORZG0wzRC7IT28d/Z84JOWADDVAVf/TI2qxH4TawbK5VEManEI1
	Mi19cRDX5SnnySvPLRlseEAvdpBd8+OUjkSsrUE5tHwsEZTZr4e/iJ+b/BHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762887543; x=1762973943; bh=QZ8EPUsmPaQhzcCsCRJFYHiWy83vXbyer+C
	n8YrdO2k=; b=sVIg4654zkoZnDdu0YmI1UARkEgnJjZEwO+SvsvDcRVTn3+/6rM
	Q725rD/TTQdkb/l6zXc8wtX2X+6knh2r/mnJU0HNeOy30TCVNgqtXalZ4FvHCnJm
	hwTChQ8nEp/iLBQ2TS6HkBMcq4X+I4ve8huaOqm0AT8qrB89EjrPUp3Kyv9WxhQz
	29+J6Ta7jvnT0fjX6V08iiXFBVjk8i6rNGkNYqvxRWPUoo+h7/hSFu0BhlGqVDqL
	wz8AystoEB0QjtH9GqyVTuHXxywiV70Qh8p4+fQJ0VUG594UaC2hyKTQRxXhHzxL
	lLNCRfBE56WV2OucHpCLZ+kwsgbE8CArBYw==
X-ME-Sender: <xms:d4cTaZJiaeI6_9QDUi7F9YB0Eko4-xc8qpzDRFYAycW-hvSUf_MXSA>
    <xme:d4cTacLkNPOxTJeEZDOJPVtEY2hGOquLHTe8nZJ2KcX78JQmPOjz7JuuaqjzdSeTy
    _IaIa2Kqw_7Sg3Guvkw2McOQ4ZcHJJfIIhmFnsXCvJRLjTVy9sQ2g>
X-ME-Received: <xmr:d4cTaWvAzZ9vVecvCqcaTQynWk0-0b4Ni-XjdvQuRjN1oNOE6783rkoj2A28DyKfyYj5TJ2YQrYRp8kl00bz3crxENFC-4_XKtBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:d4cTaZQdP-t5GTDO2UqQ6NZlHoOtMFT78DSqla6-UgA0fR6Bktp1NQ>
    <xmx:d4cTacPFIyh1tIP8NVETZI9NJEHV8QV_B6Kl585Cn9fGHir3G79KLw>
    <xmx:d4cTaeazQvPjNXZPN8NPKuKrYTfRX-Og-JheK-90BNhkUP4gpvziYQ>
    <xmx:d4cTaWxQ-lSW8mq6d-GUJfVUCD1uRJTSrU29Rkb97jOepXeywhGJIQ>
    <xmx:d4cTaWN6sqNnLst2hqgdSieTeUwCbKihN3p4V6gLm3drZJP6G3880JAr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 13:59:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] perl: also mark git-contacts executable
In-Reply-To: <15f07afcb66a900e5391e6b07e0701ce84236f04.1762820188.git.ben.knoble+github@gmail.com>
	(D. Ben Knoble's message of "Mon, 10 Nov 2025 19:19:57 -0500")
References: <7fbb341e8f05fcde3a1543e3bb4e5a3ec1101692.1762280097.git.ben.knoble+github@gmail.com>
	<15f07afcb66a900e5391e6b07e0701ce84236f04.1762820188.git.ben.knoble+github@gmail.com>
Date: Tue, 11 Nov 2025 10:59:01 -0800
Message-ID: <xmqqqzu4wg3u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> When installing git-contacts with Meson via -Dcontrib=contacts, the
> default Perl generation fails to mark it executable. As a result, "git
> contacts" reports "'contacts' is not a git command."
>
> Unlike generate-script.sh, we aren't testing the basename here; so, glob
> the script name in the case arm to match wherever the input comes from.
>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>
> A small typo fix for the commit message, thanks to Patrick.
>
> v1: https://lore.kernel.org/git/7fbb341e8f05fcde3a1543e3bb4e5a3ec1101692.1762280097.git.ben.knoble+github@gmail.com/

Together with the html one, these patches match what I have already
queued with local tweaks, so I won't replace them (they are in
'next' now).

Thanks.  

