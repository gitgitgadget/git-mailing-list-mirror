Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EBA4C97
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772344755; cv=none; b=MSfJedeirJ2X1R0FREKi68RawhjG9BHO9kwf/VcU2gPTayUCEb8XOu74Llk8eCoIUouzPfFMcCIEfHzD4fKKlSexhHYn197+ILJF4VQkPmo3yeXhffbu4M/uw1ql/3DVhlqDgO9bHTX8coGyHUWMb4uDslG+alfSN7pqIti7Qs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772344755; c=relaxed/simple;
	bh=kMfFhqNzgjJMiOcZQFB3zSfhum4TSOdrmbkk1AKG1w4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jgU7zOXPcAF8KV9qpWqMbr6T5vdSjKQNgESuDLOE+aoGBmc2rxLeQwUWeHmagtMD30jlyVtVJxiTHtd36HX7ou4V7hn2tG9U8hkHXJnQ+rOS7FdMzOdCnlxuIbi8l1HbrzEHvusd2qN5fuG8PGv7jlhfMeOQnQCk9uZk2TR4UT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ca74SsjO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZtngNfDh; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ca74SsjO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZtngNfDh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 13B761D000D3;
	Sun,  1 Mar 2026 00:59:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 01 Mar 2026 00:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772344751; x=1772431151; bh=mTwZ9lCSN4
	qL89x8UBvWQrR7HW/G3RZitzFfa4aHBGI=; b=ca74SsjOBjlapKdy6WIO/alXCE
	uDHVDRFVdf2t0BQkvQ72ohFKSc3Aq/HOd4VI0SveuMOeCVXUoBY9mY76UdS8FlDn
	FUGMeq7/vGaRQjMg2sVYcTAYUEniYNQ54USIulpyVapcIxaqOL1SBIoM92EARzSY
	kRoXPj0IZ5OscZMyj0Z8SsKtZkXVqHR/yNc2w8vUCIyckBrVGpaqebi7Qg377nYp
	U7kYXg9m7UcxfcFstf7zhoJh1LW7YvaKtQlDIbdCb2YTGFrefRPIuNfhc49TTxYM
	CSvOhnR696TYDiOpyp0zic95/5XKL5oX7ji1nzK8nJUzm3dNFMhXq4Tc4bRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772344751; x=1772431151; bh=mTwZ9lCSN4qL89x8UBvWQrR7HW/G3RZitzF
	fa4aHBGI=; b=ZtngNfDhgbTvnD66FFNMSkodCyrC7sQdLf79Jr8rFsjQjmZwQqu
	QXUQimfKPKO9doMH4WMVta+DfQKjTZI4UdFV34HJBVus0/jUxbS6bOhfY3iAKMBc
	VgKyVS4nZxl5oubVonrMUt0QWCg9XBlGOHE/3Fbkp8+554bhblsVFPC4gjPBL9NQ
	duhnkbeuM90ALTCdCHW/JBoL/2Kuofp61WWpSxhJFsvJyWVMTpZ5sqb/arCBEoxd
	yZnQZeYv7Mm5/qO/7E2dSniexjMaYGm83wKDW7tUHpVH7PCOM5GUG2+s/oBo7i0N
	hcYjitBQQsJYuU84xIgcAbL6vMzWAeMVwMQ==
X-ME-Sender: <xms:r9WjaY2kXLXE-c7oujA7lA7NilzLd8T0MMojAwwuNzq5su9Ine9LZg>
    <xme:r9WjaaF-c89fPARERFPUyJonWW1f0xAFDuIPqsHOsYYDw1b36hr0OSwHHwZcfQGBw
    8OaQWJ0ZnWtvvKeiTjYG9m_4JUEsaC_tPOXg3WRvtpiF2Tp1scf1A>
X-ME-Received: <xmr:r9WjaV6eR-CkLY_gzS0VCQKvLJCpfDPifMrC-eIH5Jjq22hYBrX7Xl08N2KRgunavlBQcYt9tMFtcJwS1vk0fornL5uwWh1PIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheegtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtghn
    rghrtgesgihiphhlihhnkhdrtghomhdprhgtphhtthhopegrlhigsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:r9WjaQvwjjIHed9poFvn5TP0179e0cyEashImodVV65pjgbZrJHZtA>
    <xmx:r9WjaW5M63NU_SVFAsKmdGVSCMu0iiBM-Y2SDZy7rcfY4-ZCX4q0bA>
    <xmx:r9WjabWs2OlikZF-8n0v9EHBaEADXXb8yrrg8Tiu4VxEcJMFuHfMRw>
    <xmx:r9WjaY86M_EM6JgLCvbXtm0V2-WJBrSGfncRvS3vHwfL1LkGMNtH9Q>
    <xmx:r9WjaeMhmvFwF_vgziIGxzqw6IB4tg1_9n_HaiPcEqCF7XS3E65h-8vC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Mar 2026 00:59:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Alejandro Colomar <alx@kernel.org>,  git@vger.kernel.org
Subject: Re: --no-decorate and %d in git-log(1)
In-Reply-To: <cf3d274e-7363-4557-809a-a649b1d304ad@xiplink.com> (Marc
	Branchaud's message of "Wed, 25 Feb 2026 14:46:10 -0700")
References: <aZ81X6ERyx5fcm6L@devuan> <xmqq4in4brt3.fsf@gitster.g>
	<aZ9AuD3dYzCKtI0s@devuan>
	<8f6441ab-5c9a-4b42-ab2e-a670d462569d@xiplink.com>
	<xmqqcy1sa8mx.fsf@gitster.g>
	<cf3d274e-7363-4557-809a-a649b1d304ad@xiplink.com>
Date: Sat, 28 Feb 2026 21:59:09 -0800
Message-ID: <xmqqwlzw5bv6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Branchaud <marcnarc@xiplink.com> writes:

> Given this documented connection between %d/%D and --decorate, it seems 
> reasonable for a reader to assume that --decorate=auto would do the same 
> thing regardless of whether or not a --format=...%d... was present.
> ...
> I note that currently --decorate has no effect at all if the --format 
> doesn't contain %d or %D.  To me this bolsters the argument for making 
> --decorate=no suppress %d/%D.

OK, that's convincing enough.  

I no longer mind cooking such a change a bit longer than usual in
'next' to see if anybody screams, and the have it graduate to a
released version to further see what happens.

Thanks.
