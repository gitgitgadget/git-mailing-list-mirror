Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AB3361670
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399596; cv=none; b=l3V29bU0aKbCbgUaBjBOizxVkzjfyuuF+3wZ8KXl1qsCnQQDwLAEkjg/T/sy8oZL20c1fZDWHyS8p0xtEeRiLZA7mZ4zgsv/9LZu9Vg16uDGkLV9B5StnorIvddWnIBeWgJV6Z6v2N1nZtPbu25NSnSqd25a5PWiP3qM/haZryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399596; c=relaxed/simple;
	bh=UYA2F12Ha+nDVXgxI2pCPmcpEjercaMXN4PQjvRj8rM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t6zt+dvxdQATKX0U2pyTJ1wUIxVZNbGaH0l7WZt77AfIsfgmv2DGhJRnuiA5vdhUOVg/tYNSf7bmVdjCvDfhOwtXh7UHuqLzsQeIAiZ1ptBA3G++CGVw8hoAWLinmGluo4LU26Ah6R4z0iyZ97q1HC892NAfSn/ZcLsWeDBY+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gZof5y26; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d9L69WPh; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gZof5y26";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d9L69WPh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C8B12EC0084;
	Fri,  6 Feb 2026 12:39:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 06 Feb 2026 12:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770399595; x=1770485995; bh=mnD1Olw/wh
	x/yT3Fu8JOWi1CeXH7Hdpg5ixGkICj1gY=; b=gZof5y26c4qubrQzQqIhr33PVY
	qTx+Pn4wOj21I4sJi9YqElRoUp6ocO45AaxVrAt2hfYFme2pE5I22uwvqlMB4S9F
	6XWFEVuLMYDQhev8LvROWVHNrHF66o2JYx1HpcTWi2JJSsPTDBIT0qOGEr1J3Zmp
	8a2/+VlDvvsWHZOr/wzVvKl0PmFIEP9XdCS8AfvJsZ3XrWTJHP8EVcXEQ/07stHu
	CRtp9JKMkmyWeHHaI7FYbFwIu9Ux2F4vICDs+JU0ebznYuxDNyMvRHnJFxCuQFA7
	djvbsr8++5p9AkVx4crDQ+MfC4l3Gd1dad8uS+lfp1wrUBToQyI5R3vlnc4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770399595; x=1770485995; bh=mnD1Olw/whx/yT3Fu8JOWi1CeXH7Hdpg5ix
	GkICj1gY=; b=d9L69WPha7JG8s67BMXR2N9gtV509Uy2UG/iB+SpIQVOyN2Jzrr
	F0gzeqb3xVKbjbxQW8cNnIwEi7Es2UGiwW0r5oe20+313zZ6Hfc433vkf59/Bc3Z
	B2x7kOpMmvVVoyjib4jtPnxZNVsh793rDh/Af5wccUPsG4TYvfT97ecCpSETB6Ff
	ijhrA1kGFhPOGra0YPU8dEM9XtiJlSWgPbDROKfxHwTHOhW8WOQ2yqMAPRHKm+K+
	fKKWU8Xj5kKSH+6UflNyZpYlxTZ70cEL6yMq4SQvVNniXg57vi5iBPNUsD33j40P
	Rq2OAbhald9BVLt8L0fzwjLkt+nihPlf5Ig==
X-ME-Sender: <xms:ayeGaVc9kp5kEHaw-sYAq_xuDz2lNtuOZUaefv7LGNlICl6L-rUqfg>
    <xme:ayeGaaEuwQC6YwPK43aQPhgWpI0r-2yxltUO_TcN7us0mVOWuByXK3AMHBvLtmnyO
    aINZUDPlK95LzakyTdt4gf7STtbOK1YTDobM8h6seDFFcUmuqVTBw>
X-ME-Received: <xmr:ayeGaW0TpB-ZhTB_jEQMYsP5TwQWc8XI8CJpiZV9HBV5FyOVtdeWkVJyR8tOcXvSz4F-zqbtL6DYz7-iUpvU1MS9may3luhatA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesrghshhhlvghshhdrmhgvpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ayeGaaldbdaimX6SI_ND8RcE7Hg07tdKHS3Ib0dasqF4in30cc7hvQ>
    <xmx:ayeGae9zmKlDV8rTkdTTdkD7zE3AQwvp9BkD097E0smL6NaeIYTUrA>
    <xmx:ayeGaXpwYlSTOGjv89J1sMhQ96nZCoasQu_lxcePOM8JW9erZnLB1g>
    <xmx:ayeGafnHqDGNQk9aEautz4DkpKU9Sa1qJi30GSZjM0ztqztpzp21Rg>
    <xmx:ayeGac7KxBrOSNsyeQFj3VurWvgxD7DQrz8od-H6gOSb7-1DXuFR_qem>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 12:39:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ashlesh Gawande <git@ashlesh.me>,  git@vger.kernel.org,
  sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] t5550: add netrc tests for http 401/403
In-Reply-To: <20260206093840.GC2761602@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 6 Feb 2026 04:38:40 -0500")
References: <20260106114029.763351-1-git@ashlesh.me>
	<20260107074724.13165-1-git@ashlesh.me> <xmqqms1mihqo.fsf@gitster.g>
	<20260206093840.GC2761602@coredump.intra.peff.net>
Date: Fri, 06 Feb 2026 09:39:54 -0800
Message-ID: <xmqqtsvtg49h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think it is fine to check the 403 handling, but note that this _isn't_
> how GitHub would respond. If you try to fetch from a repository you
> don't have access to, it will return a 401 first (so you try to log in)
> and then a 404. The idea being to avoid revealing the existence of the
> repository to unauthorized users.

That is a sensible thing to do on the server side.  Presumably when
we talk with such a server we would report 404, right?  It is not
like we behave all that differently with either type of errors---as
long as we just give up and do not fall into an infinite loop of
asking "oops, that password did not work, try again", it would be
OK.

>> Just out of curiosity, do we test for these codes with other
>> credential helpers or is this only relevant for .netrc users?
>
> The netrc support here should not involve credential helpers at all. It
> is all being done internally by curl.

Yeah, I phrased my question in a wrong way.  As the code paths
involving credential helpers are separate, I wondered if we have
similar test coverage there as well.

> So really, none of this is testing anything novel in Git at all that is
> not covered elsewhere, except for the fact that we pass the flag to curl
> that says "you may use netrc". And so there's some value in adding it in
> that case. But trying to answer your question about other credential
> helpers, no, they're not even entering the picture here.
