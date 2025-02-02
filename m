Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB0517993
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738539568; cv=none; b=f4zSokFM+wLv/RJC4glYzVym1Vs2gIVEGFN8/9aIqPU6FGCyActy0NAKEKuzAQ/uxyOg0cX6yVz2x4AYvJSh///odDsQpkVkdabMyrGlmZaoE8d/Q1tamJlBPLQayVU9V1/22bAXwaTVScz3+xN5F6wH5NQoi0kwRSZ+9t+uZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738539568; c=relaxed/simple;
	bh=ZI6TQk8nynxXSunW2Tkzff/J8utA30lN5VqjTvmDRAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EeOS2jNQ8XWKlw78JUpPBuUJ7OEwMuR3E+neeD//6WLm/nYbeDQ3y02x9gZT4fYLCemXEj3bkf4iNA9LAMm+8PopVchZuDNo1zVwmQa81n0rZpeDZ0tr8CqKbQ9j1yHtPye5Tb5VqkqdElHhFyYUbYEjMP4EgOSzeLmaDME+tXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CGHxcohn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lZTcXLrw; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CGHxcohn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lZTcXLrw"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 917C4114011A;
	Sun,  2 Feb 2025 18:39:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 02 Feb 2025 18:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738539565; x=1738625965; bh=ZI6TQk8nyn
	xXSunW2Tkzff/J8utA30lN5VqjTvmDRAc=; b=CGHxcohnm7SjuKX5EFrfcfcrnD
	vcpFJNcsOyvusHpYApN5Cd9XFVZSrTw/7eFJnl9HkwHDGtzWsKc43rwWRF0YapAr
	4kwZxZN81xwNeVQ7WoJRFF3k7gnTU5WFd9ahiqImobYwY8qac6hX7mCxczhrjJjm
	90ZGBBbc+g4U07hW6za/kQUi2YwTkdJarLbXNbE/1tJYbuoZnKndGrNgmiqMMcnw
	ZCb//+KeUJ9IHy/noTFWrt0OloPZqMVIWuYg99/etaXVWFWP5Ip540Mk2u/tLAyp
	ZV7wABIsFhiqLRklD8VcFvLAKCKulT8T1/5CbCKWtE2A1N6RWjdwSWpDnaNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738539565; x=1738625965; bh=ZI6TQk8nynxXSunW2Tkzff/J8utA30lN5Vq
	jTvmDRAc=; b=lZTcXLrwsUVx4A2bZKwHxBzjWIWLE+dllfX9qT4OJDM0yb0iAmL
	uFJBwZGPwXuWfJwoSENmv2OoeBBaVq6dw5IijWl2/Gk/69117QTL3ahIsrGWrhQk
	gc/DOa+eJAReZsbOLB1XurBQtdm43xrChUB9ccw19tjLiAoMzOtjyvhP18vC/E8P
	oPTRP74PO3r0HqI8nN3gATt4EluFxXt7E0Or37O/Z8Csrr+LKu6cWavpdrMbMxfF
	6osOfKmQmTyevkDK4BsdJOVxk75UGjXQwgFmQMjUoth2d9IkxG5/vBW5WmIvynkj
	kC32z44GlPMrGF9CJ3nbrSWf6Y6qFnuA/EA==
X-ME-Sender: <xms:LQKgZy5lxhHei1LjhxQx8aEy20cNtLnBE7fJey5aToCTCxqkBJUxwQ>
    <xme:LQKgZ76EvkLjtNt6AVQXW-9APkkkkNbojvA1aHCNlB7NAOahUbX-GyeXRuJD4zl7K
    PGQoW-V5jPraGtTZQ>
X-ME-Received: <xmr:LQKgZxeR6bDzedl3gqWWFwTxD2ubTrapsmCYzxbpgXHPG1jKWQhURwxsXjKY_cU1cv8uG8mISXj7TnvNj75RuHXR1-LFhx4nsk30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LQKgZ_Lc5CNBaa3hSvfeiUf52-gLoUA5KRSTVjyfKw8wxY75H1qyeQ>
    <xmx:LQKgZ2JDT64I_zGUNXPOh-Vu-6zj_cXtWC4tYeQOVD1SqKO_PSGOHQ>
    <xmx:LQKgZwxZiAlvY1duN5p7udkcNJ6jpvEzUzoDeh9OZuca-5yCrwp6zA>
    <xmx:LQKgZ6JDvIB4vDJ3xw2fiuBTtfBaRCksMBR0r7fJxuKV727dudJ4pw>
    <xmx:LQKgZ7HkoT9s0zxQrFRQjwkK6UigLe_BPyLi1cCPtJ8Hma4pHBJ6TQei>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 18:39:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
In-Reply-To: <20250201022946.GA4088801@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 31 Jan 2025 21:29:46 -0500")
References: <xmqqbjvyv510.fsf@gitster.g>
	<20250123003613.GA3900660@coredump.intra.peff.net>
	<xmqq5xm6uwip.fsf@gitster.g>
	<20250131233452.GB3544301@coredump.intra.peff.net>
	<xmqq1pwi5yt9.fsf@gitster.g>
	<20250201022946.GA4088801@coredump.intra.peff.net>
Date: Sun, 02 Feb 2025 15:39:23 -0800
Message-ID: <xmqqseov3oic.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But I have a feeling it is just putting the same on
> both of us as we see the same CI failures and poke at them
> independently.

Certainly true.

> I dunno. I'll try it for a while and see how it goes.

Thanks.
