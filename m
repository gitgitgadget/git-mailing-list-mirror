Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0D21CC68
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397813; cv=none; b=XFtpAd4+w0rFUbqQbkD9oSBB6RBQwKTVOtYCtC5rZZ5sH9bdoK96iT85vZ3PIcT4PIobwSopMr96ZFZ91ze9StGQ/6CH9d5iKOkkVfMEXocU2cmjWhSoVr76duZ6FBpq+DV3Qu7DF0NHMup61cvDwI34CPDSh/FYKeQ4cdCc8Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397813; c=relaxed/simple;
	bh=+YqDVHI+n3gVIMRHU1W+svbVtK7+QszLjfKDeY+GXBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sNV4Nu4bxVALC6tPTr+oWYxqetfiBDKM+N7vO7yNm0Gc+70mwFkPksclRB7DmEM52ol0fQjvFx2HQ7L8iBb7aFwvaXwtRIgFeMpXA7qd4qsXFafwVWoVt9Bkr4rkLNPpWuYi4T/StogHZZiye4UhkQjQUslS5CQfbjBoGoL73H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ifiPBMMU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SkpQMEOx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ifiPBMMU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SkpQMEOx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B761D1D000EA;
	Thu, 28 Aug 2025 12:16:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 28 Aug 2025 12:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756397810; x=1756484210; bh=MiU/8Owi1/
	gCVFfAsWUNlThO5tuvgqwuiEUu08DaY/E=; b=ifiPBMMUv0YoHMpjFPx0gxbJ0x
	YmUFziCPdbAta0nviHPt1Cr4vnM9OzQRUs/jb5mAxXUlmiUrYq0r4O+FWR1sMy3e
	Y+eLJfe2sOmYbLVnpzxrS75uN5PH3P/Hfa9L0uogCDDUVr0JffDhAYVwx9i5Zg9o
	Yw20LYVVdtj/Kh1XODaaj5g7pzLOtVM9pyt4anW14rJg2feetgS7KFs1/exVGECG
	XHhnQfeY4j8oqSUQ+q311WvpHkiRMUbmX9x2WK7FiAxbRCkwDzyOF03SpPgTTuet
	G9/kSUUB15xXaAmBrTDE0eZ9QJ1FZNUPRx67pCxUW0UJW0gkjxtHX/l+B3pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756397810; x=1756484210; bh=MiU/8Owi1/gCVFfAsWUNlThO5tuvgqwuiEU
	u08DaY/E=; b=SkpQMEOxkKEJcGxqU9TiF4pqXR+LzprIVz7eUynRUsI6EQZySOg
	BCSe5tAtRWhW1fBizLmlXY8bkijRsRQGGLkg5DaPEB7xfWtQYBXcojmw+mLy8k/P
	pEi5UXJUWiKG4CryEuPCZKfoaKP1mb30aMuC9MePfhwH4iboVCqTqoAzmTV4laO3
	OiYfMrf6WTfvNUD75cJzmamY3Uj0vVFpdo3+jJklWP2TB2p/wepMvG64XbOWFVNC
	AGDOHOymu5mMrk2+m2M72ZHfHU3ITSWUSuhs+S2jG5ZJbdbedgVsrH+TMtuXxRnt
	gaaisBZYsQfCSXgD69VYHmPpa6Rl6ycrGNw==
X-ME-Sender: <xms:8oCwaD19QdpfdOjQtE2FDdeB3T5QxaK_evcn4l12_tQu_HMDopy0Xw>
    <xme:8oCwaKh7ZmeKigJjWh2qaYEcNSJyTqz_MjyDRi1O121FteAaRfUPiJWWIy88VF2i3
    kX85-LTyQXvTt0ZXA>
X-ME-Received: <xmr:8oCwaEUGiazGMoRejZIP7febw7-gPQ71Fnjb5uNUN0-0imyIXe2BLRdgp7B_TnOhpscHDmuTlAkYH7nvm6vc5aJrZThpoPfNaewi92U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedugeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehjohgvrdgurhgvfiesihhnuggvgigvgigthhgrnhhgvgdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8oCwaJV4C5bYXcwxjMXtcwZsEw1qU24phTQwIdgRCusgZyk2X2dWWA>
    <xmx:8oCwaEhUxB9hVdfKyhPZBvZYbmXYeBgXLyXFipM8N92sbd0TKReqLw>
    <xmx:8oCwaEYJuRqqrTj8lE8SdeZkvVtQrVRLWc0aE9T3aIm4IHeFCA4__Q>
    <xmx:8oCwaBrbc94IMAb3U772I6w1nLZwq17bywRf6aQO9T4FMTdvqaHsLw>
    <xmx:8oCwaPTEvp1SHOLj-mz2bxES0x0aRG7RDsJUs30X3P2kiI4CSeoN5jOB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 12:16:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  Joe Drew
 <joe.drew@indexexchange.com>,  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "lock file exists" when fetching in bare clone of repository
In-Reply-To: <CAOLa=ZRizMKRsP2wo-RJUksXAv1Hgx3XDGCO_ZGOwKpf6kAbQQ@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 28 Aug 2025 06:51:18 -0700")
References: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
	<20250820213323.GA1667633@coredump.intra.peff.net>
	<aKbHozlmDIqfgkg4@pks.im>
	<20250821072706.GA2390046@coredump.intra.peff.net>
	<aKbwabLZiWasYoBC@pks.im> <xmqqwm6w3bjp.fsf@gitster.g>
	<aKgKmLvaHAuueJeb@pks.im>
	<CAOLa=ZS43w74tWjD47h2mnGiyaQWrGEY-UpL8kdXJi_zD0ASmw@mail.gmail.com>
	<xmqq8qjbxn8n.fsf@gitster.g>
	<CAOLa=ZRizMKRsP2wo-RJUksXAv1Hgx3XDGCO_ZGOwKpf6kAbQQ@mail.gmail.com>
Date: Thu, 28 Aug 2025 09:16:48 -0700
Message-ID: <xmqqy0r3whe7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> This error type is bubbled up to `files_transaction_prepare()` which
> tries to lock each reference update by calling `lock_ref_for_update()`.
> So if the locking fails, we check if the rejection type can be ignored,
> which is done by calling `ref_transaction_maybe_set_rejected()`.
>
> Only during batched updates would errors be ignore and only for
> non-generic errors. So this change would specifically only apply for
> batched updates. Currently that is used by:
>
>     1. git fetch
>     2. git receive-pack
>     3. git update-ref --batch-updates
>
> And for all three scenarios I think it makes sense to add this in.

Thanks for an extra explanation.

These pieces of information would be necessary in the proposed log
message when it becomes a real patch.
