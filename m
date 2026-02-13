Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093EC3164DF
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001834; cv=none; b=bnXP8mO918WV1M25eP4HA9P3J2fEaO2oio30/2EoWBENY+HL2Fd6DALbyOz2RP/bakLOuKL1O/kcEBqTkJZOTGAfOSFVCFMmiqV9i0lArPyBTsmxR7LEh9X93IB6wQtcgbOb3I0ULkikkPZ3AEabJGXBgFXdmu2Z3MzOqFABlKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001834; c=relaxed/simple;
	bh=k947Y8XHiM588yD24I0nU+Ji7dl80dkSqJKM0OpgdXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FCLj7KD3SiKCHEitrEByyWk4f6V7u9OyOYFaegnuYpWbYjyckqmYOMw/f22EPpsVtA5Ifeq3WxKlNB0tkBW5fkq/3QxFWNdcx9aO8n6ZACQ7RHQ/asxm5XV31pnmzw6mmU/v6Z+g/iSibzyf6gu8yOkpQxl3d/GCkIzv7kRPgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ubrRVu7y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oDtbAfcn; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ubrRVu7y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oDtbAfcn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 03FCD1D00151;
	Fri, 13 Feb 2026 11:57:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 13 Feb 2026 11:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771001831;
	 x=1771088231; bh=5viqiqN3OIGMj0G3NKuoV2dL7M59H9mIS+mh+hoL1AQ=; b=
	ubrRVu7yHiqujEGQIiPlN+1Tz0E3Boe0hlsQOOy2Wx6nwUDA4EjGKFfv/q7kUkt3
	MhFSIYQ6DUDA3nq6j5+EfotlefxECp+Gn66FV6IDtGphkvGyZcqB5M5SXJ1o6P6e
	hj+TOnyg4rbb4zmMGsewXFNIu4zN2AEHmpMFZsPXq8dcJvm63v1XE5GXHNhqu0XY
	zH0BXGNXUNq+ohCE7kItTwABKsoJy4KzWSIJHpJisJpR30PSER+RNjQUkmP0sr8q
	Jr2YDX3/RcyduYEdT3zQvjz0HeARdZtAS9aP31DiejY41Rmxj8ZnAm1gPg25NvPK
	twaE2IIvDXYkmu0sJKbSPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771001831; x=
	1771088231; bh=5viqiqN3OIGMj0G3NKuoV2dL7M59H9mIS+mh+hoL1AQ=; b=o
	DtbAfcnCv7hs5f7LUQrvhd9+X6cjPe4bPe2nvHP3thnYN/ubl1s5Pau0/2jcY0/d
	XgX3y4P14dU7M1LPqMuGGLRfeWorI4Ny11m9tv5zpIMacxA1+IEiqPdRiH2PQ+bB
	3EfbYq4CKPA4p8V4WqZXnwMW7C3vKgVyomaDrCBy8f/hGIYW2l6wHbcGCyaSPNq1
	aE5/Q39nA8JFdI5Z0rClIGdDmBaGH2p96F0L31GsDdSZAqeNDV+ImUlmaordc5ai
	1u2302XKojfFJgJmHtQ5BkEs9yqvs8wqfXZTSWBMTzJ6TOFOSxShch/gNcUiTr5O
	YM7l6YHWBQZAYYkxGH8XQ==
X-ME-Sender: <xms:51ePaciPa-lfIkacNOURkcNy7H5ub8dicNBkKgAkX2pQzp4yQO5Scw>
    <xme:51ePaYspy_nk7bRQdec-5AZhHmCr9toZgtvTcxHDvmjZUS7y4GOLRyMlAU8msrGNq
    OetaYvBjDYT99DV1xLrCHGv8Gvj03G2c66RELBmeoaTsxx1B1iAKQ>
X-ME-Received: <xmr:51ePad7sugHVH5hjj9t6TCCfKfnOAy29mdPxEy59rMFG8-WNpL54zDp5ld8C-diKjSrl6jSFFce3sBSmK8doZZ-FVs4opEFvyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtoheprghmihhshhhhhhgrrggrrgesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:51ePaUO--3GFYMT4SprjVtWI17YpfvJz9cSLhN58F8CnA-juAf8IIw>
    <xmx:51ePabsDWpsmt3jkk7x25EN_k1iBDOWRaTX55BpXTLpOYzkMDc1bSA>
    <xmx:51ePaXa3QS4kBWIu62x0qCoF76HVsqeDtYIVlMkCqlsXlfhfbsIAzw>
    <xmx:51ePadyXnz_u-iEdVCgkQWcywdYDyzU0QTA2-LG3N6jy9JLmczS4Tg>
    <xmx:51ePacz-Iy104tLDNuKTCii4w_fWV5QcuvrUhxaWX496G3OWCkDqDDgN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 11:57:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Amisha Chhajed <amishhhaaaa@gmail.com>,  git@vger.kernel.org,
  stolee@gmail.com,  peff@peff.net
Subject: Re: [PATCH v2 2/2] help: cleanup the contruction of keys_uniq
In-Reply-To: <CAPig+cRciH+qvjXTcW-32b2-QtK41rYXZosjNXy2mC0AijajKQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 13 Feb 2026 00:02:25 -0500")
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
	<20260213033729.50208-1-amishhhaaaa@gmail.com>
	<20260213033729.50208-2-amishhhaaaa@gmail.com>
	<xmqqecmpnu3g.fsf@gitster.g>
	<CAPig+cRciH+qvjXTcW-32b2-QtK41rYXZosjNXy2mC0AijajKQ@mail.gmail.com>
Date: Fri, 13 Feb 2026 08:57:09 -0800
Message-ID: <xmqqa4xcoa3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Feb 12, 2026 at 11:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Amisha Chhajed <amishhhaaaa@gmail.com> writes:
>> > +test_expect_success 'git help --config-for-completion' '
>> > +     file="$GIT_SOURCE_DIR/Documentation/config/add.adoc" &&
>> > +     test_when_finished "git -C \"$GIT_SOURCE_DIR\" checkout -- Documentation/config/add.adoc" &&
>> > +     cat <<-\EOF >>"$file" &&
>> > +     aa*.b::
>> > +     aa.b::
>> > +     EOF
>> > +     git help -c >human &&
>> > +     grep -E \
>> > +          -e "^[^.]+\.[^.]+$" \
>> > +          -e "^[^.]+\.[^.]+\.[^.]+$" human |
>> > +          sed -e "s/\*.*//" -e "s/<.*//" |
>> > +          sort -u >human.munged &&
>>
>> Dedent "sed" and "sort" to the same level as "grep -E".
>
> Also, don't we usually avoid having both `grep` and `sed` in the same
> pipeline like this, considering that `sed` alone should be able to
> handle the job itself?

Yes, we often say "do not pipe output of grep or awk to sed".  I did
not want to burden a bit too much on a contributor who is relatively
new to the list.

Thanks.
