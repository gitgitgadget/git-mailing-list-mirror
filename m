Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A094EA36E
	for <git@vger.kernel.org>; Fri, 15 May 2026 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864792; cv=none; b=LRJrlapa4F3ZJ7WPZf2VXdmCB0UJF5UZvjoHY9BfeANp/lIXq9rOlqfbjljF+LN2Pw+hDf3KTZDjGc+NUEl+sB7oj6ZTVP2+ujCX9CQVstKbSCgKd9d4yEnLPULMDB/Wacvf8tqhcXK2H301/AuLxAa7HvNkp81c4SsVR66DoSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864792; c=relaxed/simple;
	bh=y9zbkloWio+6rjiHq6OFfppyuO61zJ6Ek22OYhDsClI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UTrFopRRUKWGm2GMiOSaz7cnXI65wcm9nO48TybAECtJMXei2xG4PlAkBuevJo+Q6EUCBtvpb+ThRlfIF5csuDzSB+VdOS+CtLL4tmWIfE0uyZA4Xmp9z2D0xbG4JnEUKWGwVI0PmrYHSF+px92UMEEdp4lHWJizrSbjBGymuc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BUfHS5UD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nT0P4Kle; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BUfHS5UD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nT0P4Kle"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3AFAB7A0048;
	Fri, 15 May 2026 13:06:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 15 May 2026 13:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778864789; x=1778951189; bh=y9zbkloWio
	+6rjiHq6OFfppyuO61zJ6Ek22OYhDsClI=; b=BUfHS5UDMAUFpdTrV4sKUvL1fI
	vsuRqZ2PMDcmfotqXT0D6KGQVRqJ0A7k9sPt3Pq9W2xqlutoEXkUVehYEYeryimT
	Q9KBf9S7O9yCc6BPwK8TjoffUjmyxjzW4K/Wj7VVx1xEDCOYzJtMjFIBvO+dZd2j
	UliAI7289tKiSp5Wa4QB+ddkzP62YM1maBBrHdWwm1vsTqOyL1BsOy4rVmwKlVbB
	mRwyP7qajccQWztXGFI76eEUhzW7LdtAoNil6IBBKGW9ClIx+L1kL0wOWblMXW79
	CbT7fFGApYjRgcOyN9fl3gB+uHFwKejEqVvW84Yrgs0f5AKcljv2eEF9nkzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778864789; x=1778951189; bh=y9zbkloWio+6rjiHq6OFfppyuO61zJ6Ek22
	OYhDsClI=; b=nT0P4KleJKfSUYQ4MosGAC/VIn2ou+XiS3vRcWpjDa9V1qlCsBl
	9RFr7HdU+AAXYgxW7DiAEETSgS55xWjv0UKP+leTId6PIh9pOYXAwOugi1fxRkq5
	ItF6j7splCvDSrvOMKRM/uYf+qKIEfmT+LMESgEUGsdog4qLJL1jbVdqlLqHkgkk
	xTgZIUq5FeCmIEZrvKJQsnhe5q7Id02RNaWJf7hcdT1pQYv3+t6h6zMRFz/yRWZd
	KA3TGvsOPlZe/v/yD1pFZpaR5xTKuH/rDsmXTLkx5bllnG38d7Wcf0Nw1UvWVv2w
	fyBBXEsUy4oPzH7bxgutoOLIml5uBY7Jetg==
X-ME-Sender: <xms:lVIHaiJQANj8zELHjKoH6fAj99EgzusHcOjz3gbRQMraBNYtW2QsIQ>
    <xme:lVIHahmiSk3lYqkvMz-sanhXDDWVsTaiYokNATB2vFvW2BqZZEd3AUGCE0iMwQ9YJ
    zBbd6I7LQDi9b6PDhK9VxKdrJZgVxkdUYCoKEwctd1ikxAJqXFA>
X-ME-Received: <xmr:lVIHagGD80crB8y37pFCif82QcENTVSnEfnFN4jrGUyYHunklLum4febSysA9K91KSPiorO1gUMX5wS_0Nj89AlMDleFYnsawQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:lVIHahExGPZbQ5ud1cBiwy8GWV6SgA17WLDzzWpbWM2jxo9TD0wsBQ>
    <xmx:lVIHatOlb-gFdqoKOHLIHYzEszWocmZnHJnGXebq6Mm2MF_T2zghFA>
    <xmx:lVIHagGumimcW1wzf34koMK8SMGsXx3P1qY_P4m156oEkV4o8AfM4g>
    <xmx:lVIHakMG8GPBSUbJGJwUyOafkkxohgOsrpNjZb3F_Ft5gQsNNUQ7Lw>
    <xmx:lVIHapmFlSb9NPAFJPl_VnSCxyPaB1tckDD5Gx9t7wTR4NlbHmTlRwdw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 13:06:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2026, #03)
In-Reply-To: <CAOLa=ZS8a2R79+8hD-r1JpJmHUatHo4VEC=ybjf02jLEHWsRoQ@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 15 May 2026 04:49:46 -0700")
References: <xmqqik8tm16n.fsf@gitster.g>
	<CAOLa=ZS8a2R79+8hD-r1JpJmHUatHo4VEC=ybjf02jLEHWsRoQ@mail.gmail.com>
Date: Sat, 16 May 2026 02:06:27 +0900
Message-ID: <xmqqv7cod2lo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Hello Junio,
>
> I've not been active on the list past few weeks, did we reach a
> consensus about
> 20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com ? Or was
> it missed, I thought it was in a ready state, but happy to reiterate as
> needed.
>
> Lore: https://lore.kernel.org/git/20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com/#t

I've not been active on the list past few weeks, either, so please
don't expect me to know anything that happened during my 3-week
absense ;-)

My understanding of the status of that thread is that after

https://lore.kernel.org/git/CAOLa=ZT1zE+MLeaYE_5jWmNzSvtTTBw3ZAopai+2Ei27kmYm2g@mail.gmail.com/

that said you "Will add ... locally", we are all waiting for you to
say either "after waiting for sufficient amount of time, there
wasn't any other major change necessary, so I won't add it locally
after all" or "we have waited for sufficient amount of time, so here
is the hopefully final edition that includes what I added locally
following Patrick's review".

