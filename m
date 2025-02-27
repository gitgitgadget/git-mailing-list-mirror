Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273426E948
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689796; cv=none; b=fZRCSg/d3Ll5CAKHiNkl1GqTiPkZMkEdAg52QipN5CWwEyJ6TuMH+2lKoFX4k+njh8vNzWxL+tKkU83VVMkCLAtSe1PASTmRqruIQOaQZqxjxsD9+WSnmkl1E5w+T8JpqzOFgjLmkNn9wCW1UUeown50qkvqEWTzQOGvpLwmdHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689796; c=relaxed/simple;
	bh=teTVIGyuznRrYko7y06qhQinfStkQX40QTrmeEAOeQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DHq87XYoqz+7AK6QnV7zuSDbzGbJ13JQjmQaVukxisSaiV8OCZUOvFqhOwFZFzCYynt8QyPYNNHnUUPU2+Wy3vC+0K0EwNR8OVltnSAtgAV9RWYfb7ymc8pbQ69s9MLzQtNoPdjrFo71xeH0vsp+HlSKoy/SCYr7tQPz7J+GRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KBw1bVJ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uD1B3SlJ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KBw1bVJ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uD1B3SlJ"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B675725401B0;
	Thu, 27 Feb 2025 15:56:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Thu, 27 Feb 2025 15:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740689793; x=1740776193; bh=eRcMkN0oj8
	2jDjcW0Afa6Cys6M5jXC4enlkhFybB0xo=; b=KBw1bVJ/wYOmmjx/NNqwy3liUh
	jJdU1KdCErEyPEUAQeToswqTbeHqahlIT1FxysZS6SUGqBzjR58jvIZe312LFvFg
	Xov3gkGbg4cSNhKdfjI0yYhE4e08rKIrCy0z3/wGpAt257roBtP/+7niYN3B1vT8
	uMvh7ihKJhhy/6uu5QR6Z3Jdt1mV3ZSfUK4NmqX1E7tout9JGIngPsrBfdxrqK+8
	sq1XJdkkA0KaXUXBtX+XTJguEdGM+0ioipqbMC485Xn6OvB6K/nEbQdH09WuejBm
	V9w/DSq4BOKvHnBJgCHZTThlRcWvgj6X4NF5H8iBqcRbw/ml8VUfDqM8F5wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740689793; x=1740776193; bh=eRcMkN0oj82jDjcW0Afa6Cys6M5jXC4enlk
	hFybB0xo=; b=uD1B3SlJla+XTy+q6Fg8qYhJ7GhOeLg2SaaLqCRWHqBq8/MZv9X
	K/GSQPQcHuwy5jwYojO6zw65spdhegI2mAdayvANqC7k4kLTHRN9tkvsTd0WIFRF
	aZ/kl4C1UgDWFUGU+kIjGFroOZ4s8LMhpCIJDJi3vBHOKFddt27Q0cdu/9VvzYRD
	bxk17pzWWWUgVzxRYx9cCer72KBjIex6N/cto1loFzrXelDz3o60jzjHbIJp00aS
	awc6hKq8KmrW8jYweCyAjqycLGjlJ85TAVB734FcfJrf7zg0aUum5vB+VXcIiYJt
	JZ1MxcomPtuGRADsWko+wykojYKSjsYzLtg==
X-ME-Sender: <xms:gdHAZ9NFRO4izlzdrku2pWnKeYLhOkxJBjTthk6r3BLI-kDH4tWsNQ>
    <xme:gdHAZ_9oR2rMprtD6MjsgMPE6RdHNMn1HAcfGOGcEw3tE0cYnWjFD6IaRV2BG1s3Q
    6nUmHC_TwfJqOVcRQ>
X-ME-Received: <xmr:gdHAZ8QmMU23fU56-YJO5ceAGZd2ffg6H9q7pyaZQ75T2SkSD5h7-hRgKkm4tNfsTHLzsACXYlngWJyYtCjexDl-EvuKiT9xv3oo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeef
    hfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidr
    uggvpdhrtghpthhtohepghhithdqfhhorhdqfihinhguohifshesghhoohhglhgvghhroh
    huphhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtqdhprggtkhgrghgvrhhssehgohhoghhlvghgrhhouhhpshdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gdHAZ5sFVQBBXWa-RhfG_XBJEFfiQtYiifAi4CVMl7kIYtzC4Bguuw>
    <xmx:gdHAZ1dpZFinUh0OZT_cUMsbT8ONDxPtlskrEnIVJZjtun5HbzjSCA>
    <xmx:gdHAZ12gf-hyiICRuxNQXU20SYhg3Q5babfI4LIkOWzOvWlvc90pog>
    <xmx:gdHAZx9nxJat2tK7Ln0AB_H9I5a2QFiVu2lVB7tLXwN1Fx8KzGzskA>
    <xmx:gdHAZ-FzU0BuTuVn-LRaenedhnJj6BmZy48iJlWA32Rzm9eBFFswa8HK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 15:56:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git-for-windows@googlegroups.com,  git@vger.kernel.org,
  git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.49.0-rc0
In-Reply-To: <1N33ET-1tJMWa2VAL-00yrx3@mail.gmx.net> (Johannes Schindelin's
	message of "Thu, 27 Feb 2025 00:30:33 +0100 (CET)")
References: <1N33ET-1tJMWa2VAL-00yrx3@mail.gmx.net>
Date: Thu, 27 Feb 2025 12:56:32 -0800
Message-ID: <xmqq34fz6r9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.49.0-rc0 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.49.0-rc0.windows.1

Thanks.
