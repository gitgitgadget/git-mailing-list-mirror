Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C191DE4ED
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168924; cv=none; b=NrNY9y2oU6UxVnL1Hd05yuXX3UlIGs6J28NyQtLwUCB4HCt+3KbQHrHaiEbBulWmXuGSl2yf+knFo93tNu3yCsXy4CSLrwA4Wn+gTXPm37uKPhQTKCiAaNarLAKBiX+0MeH4QHjMp27XCEOO4E7VxbOOQtrQpPWOwSA2xeoUyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168924; c=relaxed/simple;
	bh=5f1/vtNdxwf4fSdw+zWKj+jVPyQmejzdCnLNoJfiUvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A9xfqw1lJGQHS2uBHDxsFjsAL4sQUFylFnub1mdus56CoLXbdW1z5g9zPPy06jksRgW7lNKoQ2v0Nk4OqStvX+S8V9BGoglkWYsDCOfvv205CLhtdBU8SeC5rMjB9CiWIhXjCAbTTHVpQNmKXoSVimu92NGrOiyG2oIy9MYYLz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O4G0QV5M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xdbco+mP; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O4G0QV5M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xdbco+mP"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1DB9C11400BF;
	Wed, 29 Jan 2025 11:42:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 29 Jan 2025 11:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738168920; x=1738255320; bh=kHhc4ZYwJB
	KufraMl3wBliOnPNs94LcIqJVHM2G0ZFc=; b=O4G0QV5M2R9YqE9bXVRhmj4/Q7
	O4XNrp+oXFl+rVVfZeDJYmkiiKXpCwM2ynquDAb3Qf7I+WyaN+GOIFMJsI10XsdL
	uTKG/Q3clGMeMHTbzR4yw51bz8rVqYa0qUJCqWXSeO8fM7C/E5NSBmL2G6E7GUDC
	1LGy7w5YwLBbrT3OH5cSAdUqxKsAxPrFpJI0eRwvT+2yVAE6tKab8bmLq9Stzt9w
	y4YfBKB5sn+3vREdDpBE52oapLChz0huGPbQfMrLQKjFzAJUr4wEeEzPDf926j2r
	3UxQL0TPREt2mjZQr6iph2mCMhYsT9UdqqLshnmvHNyOOT+9XOG9UTCzm2Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738168920; x=1738255320; bh=kHhc4ZYwJBKufraMl3wBliOnPNs94LcIqJV
	HM2G0ZFc=; b=Xdbco+mPtXkKkgWMzux5rvcrH/X87iCVmBQ4ajkWOFseEsU6Bsj
	ek3qEFJJuMR/3Z84TsOWlFnML/6Om1JtBSGpsBZ3b73hep86ftpCrlKIUXrxjcPy
	JRLAR8uy70BJecELcJFeRv1QXiPK7ynzIwS1i9WdTmTBQIJL//td0JBLr4IOxxWg
	65/c3QCAQ0o3QCYCbZTHT9rQ01JKPS3zzUEvlvHOXvL5uDo7oUdcliz17puUYeej
	Cd9u7nhIHEpFPXOe3D8Dx2GXf5ZMkGACbqC0Ex/1g/s5/MH8V/ofihFlMCxtQ2u1
	tUzgkDPdAU322+S93RHA0lZitdF19wRhCzw==
X-ME-Sender: <xms:WFqaZ9cXdJj7fIyHvtZ5bxYhwz8bosgJlR72SO2A-XfzWibdvSaMAQ>
    <xme:WFqaZ7NsA-viEWqRt8SI35OzfGreCELW6gKguuFJxxFmTYI3FBYWl_uBMOGB9pSHH
    Dp4b_-9ArkbKxZwQA>
X-ME-Received: <xmr:WFqaZ2hygorYvsHW-XyWoZYf6ErS5V8O_Cb1SSy3kA2F-RUK7EEsEMOSXQi4ZYxbwZ6D8NF0gNBR4ygCCnMgY9qXSmqzujZOEbF6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WFqaZ2-SFxlE6alTiROd3-pf5xoj1KLf8g41zcmg9kHoXiDYdSn-Bw>
    <xmx:WFqaZ5vXMFkvipH6czt63Djk38KZZ7x-mnnMxGTYcyYzgI4r04Am6A>
    <xmx:WFqaZ1GrS4ktYDbndupj8PWRQTlPxPrdl-StIQwHt-GfznZa2T0h1Q>
    <xmx:WFqaZwNJbBCMfijGamxD9Odt7fe1CuhHLtCbKBrqet6VHvIvSyBaWA>
    <xmx:WFqaZxLKhan8yA5XR6i24idaQA-g69urdaHLkyGsAjXq_H_e96na_47C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 11:42:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [BUG] PREFIX environment variable ignored by git config --system
In-Reply-To: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Wed, 29 Jan 2025 11:34:26
	-0500")
References: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com>
Date: Wed, 29 Jan 2025 08:41:59 -0800
Message-ID: <xmqqbjvpk1wo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> Thank you for filling out a Git bug report!
>
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> export PREFIX=/home/randall
> git config --system --list
>
> What did you expect to happen? (Expected behavior)
> Git should use ${PREFIX}/etc/gitconfig instead of the build location to

But that is now how PREFIX works, as far as I remember.  PREFIX is a
build-time thing.

Perhaps you are looking for RUNTIME_PREFIX build-time option?  I do
not know how well it is maintained these days, and if it allows you
to futz with the paths at runtime (without _moving_ the executable
and all other installation material en masse), though.
