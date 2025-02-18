Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359D270EC3
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902093; cv=none; b=b/hiGN3ADLbFIofHU0QLCFp9OBgqzd7tYDRjs9gIf9N2veUqd5alMNu4sBviL3r6TmHRjLgiFhKCDmPzFR22WESZQD5VEMW/wOYJ464pa9k04mMU9Y/X9rhqwHxNiq11nZKxnTBoi3RBklTR8pOwiwacnqbLxPeSr/WNiukWIwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902093; c=relaxed/simple;
	bh=TVvTo4NIf0ucQ2mmHMr+JILAAhSS2iaMIDiwrq7Yx5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EHDKVyck7/DnJythuUBYisd4KIRJJFsDbqN9FMPK/cTDVf5CkKRrN3kPTMAA7kE2eZ1r1H8gBTChKpnU5eCS5rSHRgph/Aa58b/72o2QS6jZslxJ0garAj6bD0Uba2W/OWwCKRB2PpZvQLW4/fUHo01I+Qxgz2BLp9esWr6yPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wsp1N2Lj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MgFFJB9c; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wsp1N2Lj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MgFFJB9c"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 32383114016C;
	Tue, 18 Feb 2025 13:08:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 18 Feb 2025 13:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739902089; x=1739988489; bh=16KMiy6kGP
	9eBl9JY/kjNHDp2D7yRnkc98jjh71HACE=; b=Wsp1N2LjwXjsOhXTPHqnCnQ8wo
	5FlDvXcv2lWMKUz0bNf3SymuMGMl10HBLmycid6fsS3GvBvKTqkavkgLjRbS9qNa
	0kIopC4BXB7SYHaxPHiWKoq50mJsA7Ynw8HWmPINfjqWoE7Rwi+2zNhn/JhHm1uZ
	RMjnLyErZb1eQVMxqMJL054HtwAZpzwNzmZsfRL+jZv1FPd8U6bTlo2tlQR9X36W
	cOcgZhI8ZGv2Ev6mHHM6jpnaNvtmE1r6aZOIaL7TQgx6CnwcpwvRxjQWHE0/88YN
	hIaRB3kENOmubj4CJwAZltTM3gLEUNTRRHHoNa1aX+Df/OflvvGLFPiFD/VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739902089; x=1739988489; bh=16KMiy6kGP9eBl9JY/kjNHDp2D7yRnkc98j
	jh71HACE=; b=MgFFJB9cf//u3xGwpWXY83N4XPhcAHcTtRlNHHyJl7DjWJQnfKf
	pYMFKksFu7EoWWoUQfzYWKldca6xfZ9trKRSrQBTrt8wpaYgN3DwY3yK8fGd6EeW
	5h5zPAkQL46KV2wQBo/sr3zy2FFUXIGq79sa0/ZVeWrTTy6F1jrkK0Ikfk43WvDh
	AyPfd9GuGShlC6MsVqAKXddGxW0m96tOi+REtpIGkdMx7K1Q3pbN21TnF49osoNH
	gmJNrzIwYKxVvICsKzzDXfwinukzgwWk2j/3pbgjhosWRy982dMz0PVGbkTWw/CY
	0WxiDiUZ7g0YilxN5qZLP1qKoCo4BdRgvdg==
X-ME-Sender: <xms:iMy0ZxskUDlUodDi0dhLr0djTiP9JbMqGC2lbjUCWcUhhdB0cYzQtA>
    <xme:iMy0Z6e9aWImEynAqvJUntlz2_MDM2SklLP4T30pAzvqFp6KbnjvnSRwc_p48IUuS
    cbTp_V__0iqh_wt2A>
X-ME-Received: <xmr:iMy0Z0wivoZ0TD92GO55uLxzrh-9Tw9L7y5P1OMvoR0wDUcvNQurMPfOSSQUTVOjGvtRErvChZF90p1Qj_BQJrFsN_Sm-3pf8LdQU1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhgvkhhsrdhtoh
    guohhrohhvrddufeefjeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:iMy0Z4NOuPwbb8qfB2FPrx4cSiBf2bwKvrVd6hU2ibyA-V5xzaIPpw>
    <xmx:iMy0Zx_kCmjC9HKtcHHj9LGKOM_YbGmAhI7SAA9Mcy9bb0ZYdwgvZA>
    <xmx:iMy0Z4WXEcXWOjd-4bjNRKi8ySRSOrK6_R_pBIjRcGgsG51Vvb8lvw>
    <xmx:iMy0ZyeT2C1EqzmxnQZiEaiLucmL7EjaFfYOgr9S-IrhwgAltF-B1Q>
    <xmx:icy0Z8aIQbuJw9ZwbKGDNRrhIscceh8dMIuen3416aKK_uSieeyA7-w1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 13:08:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aleks Todorov <aleks.todorov.1337@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Add Commit Summary in blame?
In-Reply-To: <CAO0eup=6NcCdBASxvAxB8moku74zpxAr+MFiV-kkXVfjY1UF=w@mail.gmail.com>
	(Aleks Todorov's message of "Sun, 16 Feb 2025 21:13:04 +0000")
References: <CAO0eup=KqHe68OkHqYWtDgsTx0cAwg5Y5HSqK4s_BNbZhr8hVw@mail.gmail.com>
	<xmqqzfu7s5qg.fsf@gitster.g>
	<CAO0eup=6NcCdBASxvAxB8moku74zpxAr+MFiV-kkXVfjY1UF=w@mail.gmail.com>
Date: Tue, 18 Feb 2025 10:08:07 -0800
Message-ID: <xmqqfrkbxh14.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aleks Todorov <aleks.todorov.1337@gmail.com> writes:

> ...
> however if the implementation is shared, that means we need a way to sanitize
> user input to ensure they are not using flags which are not allowed, and we
> will also need to pollute the implementation with length specifiers everywhere
> since each field in the blame output needs to be width-aligned.

I was imagining that the aligning is responsibility of the end-users
who give whatever random format strings to the command, if you are
to reuse the existing helper functions out of the implementation of
the "git log" family of commands, as %</%> and its friends would be
available for free.  I admit that it has been forever since I looked
at the code paths that implement wrapping and padding specifiers
last time, and I do not know offhand how cleanly they are written
and how reusable they are, though.

If you are doing this to feed some GUI implementation, however, I
suspect that a more productive way would be to make the GUI tool
read from the "--incremental" format.  But as I do not know your
motivation...

