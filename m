Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087F2741CB
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643655; cv=none; b=PYVgQKhzKir1tmh3myZvJ8liR31UBxZu1nFRO31XzdHJSKKPQ0ThkYfxfIDOB2hKzC/lO/Uz1xQu65NectyQSiwZyk/zkI++VH4w6gGGC3pcK/GZCBlPn3NMQZH3pbv8S/iTf/sKdh34r7YwuRtzBhWZqz9uZw2Ubi/tpzx20MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643655; c=relaxed/simple;
	bh=2T5o/YcHSnxddI+1eh8TJk3IphcObAq2EfM/F1pcDxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dMSn006UVxeixUvqLnYOhheHhGTjQH3kgzmtP2/hHmEozAzxakQnz+SGkaYxOzuqUl2vqyRlD7JpKS1BzQTSzvdc5CJbs3S2WcvEY4A7NKDt/T2iAHbOkbBS3pBTAAZk+7KgQRQimI2GcmzGaxB+LN6d8PDCWeus4QYIcJ/NJdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CFe3DFvL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kxF2yB0B; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CFe3DFvL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kxF2yB0B"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 02DD825402A8;
	Mon, 14 Apr 2025 11:14:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 14 Apr 2025 11:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744643652; x=1744730052; bh=AM+ZL8ieTx
	r19qx5kU1DVmiLTMAl3y1YWX3NAQi37o4=; b=CFe3DFvLQZbOGm2tS0jN7li2n4
	BZxeItS40vK+pCBFp0T+Oasrc2fSZ/LQq28mIweouQdwaCXEzEgTGbOWqWaTqYDj
	wt8YKB5I5rZc5o5f+lW6m1T4BFVxT4Hb2BtkpF6e+c6uFynEFkztKBcmlBaDQPnI
	fyNdoRi6x7LMYHk8jK5pNdmDC8ggHEIpexMjV9LbK1hATuRx6j8OJqTdgsnXMWDc
	mAIITcwxt0pJxNuuHp1k0SQuSVYi3WfcRuEpBi1Op0BxA+Z4geAR0/LmSqlVO2qb
	+TY/hpJ2OskI+ThI8ZlqI+nzZxInl1JLVJEDKYialpia1iXqF66aIVfJR69Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744643652; x=1744730052; bh=AM+ZL8ieTxr19qx5kU1DVmiLTMAl3y1YWX3
	NAQi37o4=; b=kxF2yB0B/msrXegl1mN03yZZus8p156zb/H+k7CKJW3jE3Redjy
	VBX/KFpAMkYFp0BadfPypJekCchPOZ4Xr9DcljNMavsAhUv301fpMA/quTk/gikQ
	CjSPpTqZmuhtXYjFru1+cP9kXHC8BW67MvA53EKp8KiuIXJma9IlqkNjatNJeRDF
	DGPLSiX7Ovo+8tkkZh7nJpW0WLeQavgSW4dACvbLBd8lOlp3wl4JzWnO2ESAtyUe
	YzxxhitXV1OaEb/2mopU5xuWkdbEJkRGqZ21hOURsLxih7IAyLHoMShUP4Z5KQVn
	79wHRW+OsW6SOZtWFpcKEPU2pQbhNJJ6f4g==
X-ME-Sender: <xms:RCb9ZyBROwiYoYa_a_hdXar2Q1T86170P6oS23svWhwBkCxTTCMyGg>
    <xme:RCb9Z8hmmp2hVYVkn_OqgTl_C8elQWtRtzdcoOxOFujF9Giugpn021cJmoyyQk8C3
    Rh9l3alrHa0DWivTA>
X-ME-Received: <xmr:RCb9Z1nL1fryDHIqXiiBIZPGoAXY2-DS43MD_a5qOWWU6-xHSDF9hZv4pO3e78xdzY1pvdyMvEcSpixK-qUyv6R74_UIFSeTUei4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkohhnshhtrghnthhinheslhhinhhugihfohhunhgurght
    ihhonhdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RCb9Zwz3qMoU7OhHBlNfjScM8-OLNE_4AoZau26--ZPo9DQBb8r7nw>
    <xmx:RCb9Z3S8OXsevjEvWg9QSAB-oNKSM8co7Gd_1U4IY5bRjdDlILwWoA>
    <xmx:RCb9Z7YRvCqNIti9oz5Fz-mXw-1UcfzssZGFRGHvzZA-4AR2CAlAPw>
    <xmx:RCb9ZwSgYsSIejmUxTQwGCU7b2qvmznxUyJytiMuhwXRkxMYm2lYkQ>
    <xmx:RCb9Z4McFwqvQBbjk-PpfOZPyzKJ70hjvZioZ4mUFAsavXtTKUYt9znz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 11:14:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: git@vger.kernel.org
Subject: Re: How to gpg signed email patches?
In-Reply-To: <20250413-dancing-acoustic-marten-cc7a7d@lemur> (Konstantin
	Ryabitsev's message of "Sun, 13 Apr 2025 21:34:56 -0400")
References: <fx2ofmmhkjmjqfqya5e3qvmovvmpnjepteqobcz4eia5sw64bg@yquuljpwok3f>
	<20250413-dancing-acoustic-marten-cc7a7d@lemur>
Date: Mon, 14 Apr 2025 08:14:11 -0700
Message-ID: <xmqq34easrlo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Sun, Apr 13, 2025 at 07:17:26PM +0000, Klaus Frank wrote:
>> how do I get "git send-email" to send the patches gpg signed?
>
> You have to step back and ask what is the end-goal? Do you want
> repudiation/attestation for your own patches, or do you want to be able to
> verify that the patches sent to you by contributors are tamper-evident?

Excellent question.  These are probably both addressed by signed
e-mails, but quite different from what object-level signing
(e.g. "git commit --signed") aims at.

> On the kernel side of things, we've been using patatt [1], which supports PGP,
> SSH, and ed25519-signing of patches via a dedicated custom header, a-la DKIM.
>
> [1] https://github.com/mricon/patatt/blob/main/README.rst
>
> -K

