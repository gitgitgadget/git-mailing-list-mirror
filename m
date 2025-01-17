Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB431D932F
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737153909; cv=none; b=OebDzcWoupwInSQBx9Ebe0cvNIC7WpEWucSJ1Aqm43s/tHhnvLaevAk+EwNaI9pWvXWQB2rS0hAf2CSX5ArRvHeWaNow1ZOYU59DGmRlk54u1DiXg3E0LV1nkGTaMoo+hRF3L3rR08vGu2PojIQSjZVo/hIAgiDg85crt76NN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737153909; c=relaxed/simple;
	bh=JcuVhFpjS7pcxbR1gXcj9AdsWYCUxKhHTZp0OYCctFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NS6WY4nQ/cAGhZv80ymExVJImpN55sLjc9apI/7V1UxRoP8kr8gS1dgrhuZy110FdzrOusrnQVPgV+xVJ8EvJ3iue9muSYphHiENSXqPPy0nREz9br+C4bpSUD3gaEcoVr11ocr0eVO3NIZo58sy6BnI+kS06KkZ6Iy05gpRyME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tTziburp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNTihpOP; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tTziburp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNTihpOP"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 337661140118;
	Fri, 17 Jan 2025 17:45:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 17 Jan 2025 17:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737153906; x=1737240306; bh=hPBqCO1nc2
	QEJ9KqjKuxNjc+DNr0DKxHVputir+/ed8=; b=tTziburpOO50/MpPLvRwcWqcQe
	X48aUCL7ou/X7buoHcQBxjz7JHVPbkeMi5tThobrUpFl4i4pOWVHyHwc7ceTx2s9
	2mHubFE99ULuNqQNosHXJSOx+KqJp6xXa6iCX7S3svrnnDG+dzzNi+7D7kds/qRc
	xd6PfD8WrBlZZO3CDkh+9rrR9JsxCJQVJyoAYpC0vy3FzySa2PmzB7+L3X2wPpLA
	poMfUk+bAgl9bXdkg80AUE8MdmFH1gFkHPJkY6LC9lkyj8/bXmNq6e9aJJ9vQS1h
	6JML7+7k3QlsKExhrih2wtosg+mgJOofdL8YBp2Ig4tfbpWLy2FbZP8gWO9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737153906; x=1737240306; bh=hPBqCO1nc2QEJ9KqjKuxNjc+DNr0DKxHVpu
	tir+/ed8=; b=jNTihpOPEfCx5fPimcNi5B3JzKANkkDNGrE59DOMZRvt1dLC+lp
	YXj7dz0TgiOFS6SBXgnGK/H7+Vx8gdPLduFLvNorG5C5kWmiGW16oyGgWT0vqvrH
	udEEWT3VOL1yBSm7r2rJQyyTpNjiUwtN6Mn8xzlwv6aYHxEIOUwzwYLOHOZwOAC7
	EpUn3Y0Xru+gvVTnbylUnVn7oYaUU9KVq5Emm/QWvG12WbxLiz2cD0TwvVNuM66z
	Pht6OrdaB6Cqiw1nuvYA9DYdZ2MkkUYtuUA0712Dq5/vJ3+9j7Vz5k9rcurXYD+F
	gH/81xb0QKLF7mhmKwc4pIzK1S+jwYyXkkA==
X-ME-Sender: <xms:ct2KZ24ubGMSqtVc6qMhX_xSLAqCirnKxTRtVXvopA608YJmsLladA>
    <xme:ct2KZ_60JAActyxIXUEKHl7q56YBqSIoDuP2ur830Omw32INBHnkIEVvCg8fK7zLH
    s1NUKJpaKo7vxLzOg>
X-ME-Received: <xmr:ct2KZ1ecxR8K96Kn9trtAY1KfJR06OacUF8JAD0xG7UJHJfq9QRFsJgimrq_ebG9a4N1Zg8G_K58ZkFjAZDIYbsVtHTigx-6plb_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhhorggthhgrnh
    esphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ct2KZzInsejONqGcNmUIznuJoTU4zcggkGkHF5NCJCKI6DwI7rgi_Q>
    <xmx:ct2KZ6JgAPd_JP8cTv-hteBv1-bB_YGXPCyXtsdDzXDo3FnSniqyKg>
    <xmx:ct2KZ0xNOZRtkcYEFH_G50EHfXDUroS6LWCycyApGfNKEBLTloDT4A>
    <xmx:ct2KZ-LChTQrUxN9NRaTaMiIk9rV6C8UNqM5Bz-9XKOU9Ej1I3ENjg>
    <xmx:ct2KZ_EL5LasYCXG2OF9FYCLX2QXqF-t7Xo2i_wzAsvsHCX9nXhW5Dhh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 17:45:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Koakuma <koachan@protonmail.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] packfile: factor out --pack_header argument parsing
In-Reply-To: <20250117125459.GA2893666@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 17 Jan 2025 07:54:59 -0500")
References: <20250117125207.GB2356599@coredump.intra.peff.net>
	<20250117125459.GA2893666@coredump.intra.peff.net>
Date: Fri, 17 Jan 2025 14:45:04 -0800
Message-ID: <xmqqo705hxfz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>  			} else if (starts_with(arg, "--pack_header=")) {
> -				struct pack_header *hdr;
> -				char *c;
> -
> -				hdr = (struct pack_header *)input_buffer;
> -				hdr->hdr_signature = htonl(PACK_SIGNATURE);
> -				hdr->hdr_version = htonl(strtoul(arg + 14, &c, 10));

Interesting.  So the file-scope static input_buffer[] sits in the
BSS and happens to be well aligned not to cause the problem, but ...

> @@ -645,18 +646,9 @@ int cmd_unpack_objects(int argc,
>  				continue;
>  			}
>  			if (starts_with(arg, "--pack_header=")) {
> -				struct pack_header *hdr;
> -				char *c;
> -
> -				hdr = (struct pack_header *)buffer;
> -				hdr->hdr_signature = htonl(PACK_SIGNATURE);
> -				hdr->hdr_version = htonl(strtoul(arg + 14, &c, 10));

... the same file-scope static buffer[] that also sits in the BSS
was not well aligned by chance?

Otherwise these should be identical code.  Very interesting.

And of course the fix in the [2/3] is absolutely the right thing to
do.

Thanks.

