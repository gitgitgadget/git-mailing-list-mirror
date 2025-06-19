Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5067621D3E7
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352840; cv=none; b=CPPgs8xnckRQnvSYzsGQlo7E7ORv/USniuKojdzGgrKz8c33HojkzYOm82i2IkJoBj/4NtsNdicW7YBOGbL3Dy0kgmk2p2qJZmsn5d/y59QoUms7h8ESF8fYMOJSqiOUL4kmr/GabXf4FCvM0x4CjAxtrO4zmuBkmmWeVMF2L/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352840; c=relaxed/simple;
	bh=CQp8P9u2z74acqqd/HKXV9cZ5/lx90xg6KCnklPK/cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HAfJSZCU/9nHLL84FdbSp74+5Bj+gPHMKT0tYI5k8gdD0iTJVhimkPqL3trO7/16gSWiyGOkOABY51vb5jd141Ql+8srFl1HJjMSUWxHYLzszN6es3fdR5LvYlBeQM6h137QMe+lebnb5+P4segGteYsRqU1mqhMd+WpIQKC+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qHaGE1Wz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fdXXBZ3G; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qHaGE1Wz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fdXXBZ3G"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B3822540139;
	Thu, 19 Jun 2025 13:07:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 19 Jun 2025 13:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750352837;
	 x=1750439237; bh=HV/dPcHCWK7RUAxOmvYVjs4LYl2AbSrbuP3GTDWoghs=; b=
	qHaGE1Wzj8qqQJRZYGx/wKidKXk4LtmITfFmmdq7pgK+vMDB8lwJmuTfLz1qbMmw
	lzmgrBfWe4VWgf68/HocIBVf0euZZve2gimkMnn5TQrBP4zMFF5UJktANoBHas/u
	YtnDcJWXxyZq+/u2bxiGa+018VnNfkUzKe9EBr+YA9iRwjeG9ojmxraA7lkl24O4
	JEEHEAy0HV1lzpYQ5FSwjd46hYS8o/tyBao1GBMwQpmB4ldY6aFZHnkCqm9vPGmW
	R0ZCDw2gS/sU2pfSoz8TEQmqw0Oye5kfkGfJvOXsxl9OzkdnqR3KEgwFsdWvha6T
	SCHVRxLTQOtpOfQ7qgQCxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750352837; x=
	1750439237; bh=HV/dPcHCWK7RUAxOmvYVjs4LYl2AbSrbuP3GTDWoghs=; b=f
	dXXBZ3G8MFKZDSUAZuFdMfZmYDtrT1IaiTS6sYE1BELuCDFs2qIrS4EAnwcQtTX3
	fcEWU9j0hzFRUG7P7cD1VhllA8wapExMzllXINGNqJ3FjEZUYYuQPi8+qX3Q7MXW
	x4sHeoXJvldPGbZBXKkkOGV6FH6Fe0PlJcUtLFRXhky0SaDIAMv3Hbayt87pPPNe
	354GInt+t5WTXiI2nMt/NAqW4Qhsn1tB15xIg8mUA8rD3LyGwQQDg1RVtwgQGUXh
	Fv5xpTqlgTAdOAsbv0vV0XEdWxaf/u/rhekZdJ3Ie7KrciIcpMjKnRKYJEd1uI+X
	DHg75TEyfr7vg4i93Na6w==
X-ME-Sender: <xms:xENUaMxNIXmnK2JlqiqmZjYL8sfVu8ZMtaX5SYIZQxn0lvOOqqzdvg>
    <xme:xENUaASEGWfgYdPinX5W0kG34V0kypVkWbuHg8knoR9tIbfZiRB97ebs5CE0lIewY
    Y0YQ9bKzpDGAyOQBA>
X-ME-Received: <xmr:xENUaOUlifU3F_rrA2s9hvVQOL3kR8uMUNdzgslKqbv8P7Hdf5QMsBoSRPxVSkQHZ3UfZHTBxIODIII7Rq86Fkf3HbFJ1d7iSL2L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeitdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedt
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xENUaKhMcI1c_Ms_WAHfA4NnxJtPSzsWGNMKA3GqJHcesK3v6-9YTQ>
    <xmx:xENUaOBX07SL8_97I1qhh1LEQWxCEAs_2m8W2-4svPZiIxrK1203dw>
    <xmx:xENUaLJGVqKhvEeYPfY8WKClMJrYtsQLr7CPz-6p7ppYUAOJPRLVCA>
    <xmx:xENUaFCX9ZwgWCjdnDaAlXYedxfM41oe8nZRGKhbpLT2MaNRPqiLVQ>
    <xmx:xUNUaCJgVPvZ-BmhVyqczqc7-hMtSE_D4XEMS8ZCiYDu_64WPTJv_Wev>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 13:07:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  newren@gmail.com,
  peff@peff.net
Subject: Re: [PATCH] fixup! repack: exclude cruft pack(s) from the MIDX
 where possible
In-Reply-To: <20250619130807.48057-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 19 Jun 2025 06:08:07 -0700")
References: <52a069ef48f5a573c58a369b69827a40c7712247.1748473890.git.me@ttaylorr.com>
	<20250619130807.48057-1-carenas@gmail.com>
Date: Thu, 19 Jun 2025 10:07:14 -0700
Message-ID: <xmqqbjqjace5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> In a previous commit, `grep -o` was introduced as part of t7704.
>
> POSIX doesn't have that flag as defined and while it is a popular
> one is not available at least in the latest release of AIX.
>
> Use a sed equivalent that ought to be more portable.

OK.  The patterns are not exactly the same but as long as we know
$packdir does *not* contain a substring "pack-", it should be OK.

As the topic is not even in 'next', perhaps a refresh can squash
this change in?

>  		ls $packdir/pack-*.idx | sort >packs.all &&
> -		grep -o "pack-.*\.idx$" packs.all >in &&
> +		sed -n "s/.*\(pack-.*\.idx\)$/\1/p" packs.all >in &&
>  		git multi-pack-index write --stdin-packs --bitmap <in &&

I do not quite see the need for temporary files or "grep/sed" here,
though.

		(cd "$packdir" && ls pack-*.idx) |
		sort |
		git multi-pack-index write --stdin-packs --bitmap &&


Tangent to this discussion, but I just noticed that

    $ git multi-pack-index -h

lacks quite a lot of information.  Perhaps it needs updating?


Thanks.
