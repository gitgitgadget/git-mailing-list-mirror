Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D50D28371
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045327; cv=none; b=iMI3YX7v4WB2M085py9noPH3hZQVo9eeKiBP6MUTsEEg96poc7nuC0huZN7DV+LMsos9UXPkt9nyLGhEZ8SjKG7MQb05J9uj0T49f+pjPq0Su37uUDd8RShj0QiZ7u+g/yblASy9koL71uPZRnehW3l2ZyyxuTBEDXNcQwSOyAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045327; c=relaxed/simple;
	bh=HsYTsHMd/Hp0v9+WGmvTLRANHoHqN2l/aFc321Xvypo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OS1/Y40eOqoEmFkQO40kg6Gpa0iySVjlUPipti2g6Z5TE9Mr5c+DIvLmFSiw7y32mdfdsOJxLDNnD8MAGm2xoQr4s0CTIYxNHTs+JICW2h9vngM/G9yz45wMoc0oHpFhZt9p6u+wppZ1olcZkcro+i8U0MJNGoREFJLyRNWSL7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FrhFg2bA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iR7yBYPk; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FrhFg2bA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iR7yBYPk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D4D2EC017D;
	Thu, 18 Dec 2025 03:08:44 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 18 Dec 2025 03:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766045324;
	 x=1766131724; bh=KgVU9ehbPXwx99n33Ss4TW/ZdQdPf/LJ+yAxQgw+bqI=; b=
	FrhFg2bAYocN+cUeCT6WP9jDw93FPvmpbdB9yZrECuBbvZ1xY82OjVNnlw2TTanK
	hJn4PsA7t0gdF8b7CT4nGe7o3pOF7aJadBMAKeCvSTiEaMbePHyUFDbi5TVmm435
	wfmcVZcHHkmR/WSxrDtCdj0uv92X05q/+MyagQWa5lPciNYSOxFbKfPj+YK2JULK
	ViURquEISjx9+o09FYa998mvf3/0DilPbehLD8cGo8gRvUqxPVs5LDS5FhD5nn1u
	a/+TzdSWXW8Mw39TfPC0C31rP1zmKwFIhdxLHmIm9bzpNn1BLiLryx1naxqWXAaX
	7BQSIZmybhvT/mhpTiuh3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1766045324; x=1766131724; bh=K
	gVU9ehbPXwx99n33Ss4TW/ZdQdPf/LJ+yAxQgw+bqI=; b=iR7yBYPkrfaq0zHti
	x0yXp2hodgVDdx0y2CZhmmt0M4H9OwSda4KqLPItPL6D6T3OyLbqU217wqIxNn0r
	cbjqYwY/0gLrcrRmVR514ior6nuvKNX2f3aWc2fJCbnsLiRJIYtvUUsdOaKTS7Ns
	wAx0UNXmf9JnrdEmz3qB4gkJGzaniT+oafh/gBHH/MWq8K7aEib6tPS844vvHDRl
	qrc6Jf1vhHIlUrmTdTOqZ7Lz6IED36WApLI/gQGJuvGkxgpJX83/nZxmjWsdHXdP
	Oaz7j+QvB7Hk7ZXgHbAmmo4JiSeTcVEuzaJ6C7qyXi1Q9fZK4a67ieYpoeWCNQpq
	Wpngw==
X-ME-Sender: <xms:jLZDaWezaxkCMMUpFDAqKpnehI7IbMhHf9EzRSgt2GDj-OJLRLjWwFE>
    <xme:jLZDabDAjCa-fcRjggMgNBTmsQwCT6eyzGMKXScJQhEGDTcw20uu8aC0p13iTb1rl
    LIP2_F8FV_gY1cCMhRBkstxN37iJ5gDPM8X2o7fWSPTqUhQpLLt_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveei
    ledtkefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:jLZDaVLCtTEngcofi6in1vEIukqam3b0JaumZvjVt4_B4mbVaX4Q8g>
    <xmx:jLZDafGxa96q1-2-LAJERZY98Rs60YLNrlAhnYsy1LPXY9xxPn9How>
    <xmx:jLZDaVTHq2c7H4o-7OGkomp3DoJ4aGqZzlzpVpcL0LrBOYcROAgGlQ>
    <xmx:jLZDaTFCQbCudWBOvtqY4BCY042tRJadjkcUs-Yzm0ZTykElg7TGAA>
    <xmx:jLZDaR11rw6SRBPYN_FdmdXGS33W0VMn3kSFsDZOcdaywJOIo79HtQcp>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 707CA1EA0066; Thu, 18 Dec 2025 03:08:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFPP_qj_t7ZN
Date: Thu, 18 Dec 2025 09:08:24 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <fc653182-08cf-4dd0-87a8-ad1e58b1e929@app.fastmail.com>
In-Reply-To: <xmqqsed91lwa.fsf@gitster.g>
References: <xmqqsed91lwa.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Dec 2025, #05)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025, at 10:46, Junio C Hamano wrote:
> * ja/doc-misc-fixes (2025-12-15) 1 commit
>  - doc: flock of small fixes to various documentation files
>
>  Various documentation fixes.
>
>  Will merge to 'next'.
>  source: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>

Jean-No=C3=ABl replied to my feedback.

<876ee36d-610b-4df6-9297-96b38f106c6c@scantech.com>
