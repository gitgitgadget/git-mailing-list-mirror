Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E44437A496
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656898; cv=none; b=G3Et4whBTL4N4we8RpXhtBABtQKQqNalOSZgeJpp/g8p2cx1RL0+6xcrBD8l0BuayyD0x+uGqpWj3+oM+bgsXY/ZMzQTwetgwZRBDY8FRghGVX2lPTq3g7zZFcWi4aclbN/xt5OpPXRa5AWDlzI6Yi7fzjK6LEkmLnVf6AjSM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656898; c=relaxed/simple;
	bh=I4PMgGjl4UBgz0lEPEUhSP3Z5w8PlDqPDBpaPd8IAao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u1phUXSnfSv34E+vpidLI6OjMi0WEghCFNXhU3y/wgIPQEgR+N4P6l3OXIbK5YDlO/jVIAPTmHC3NO1HjsaY1IVRqZp9EYd6qDL8qAc0cr5Bltxcem4gLKd8CIAbz3tKOziaDg4m1HQfxjqVjS0vipOfwepJGOkTGiQzKD4hz2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nr8ZqNun; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MtRZQByW; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nr8ZqNun";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MtRZQByW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B5B151D001E3;
	Mon,  9 Feb 2026 12:08:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 09 Feb 2026 12:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770656897; x=1770743297; bh=lk3l6S55Dt
	GSr4c1hldtTTXD3LqZKKHUDJFu6gPnNmU=; b=Nr8ZqNuneBBMZjds212g+Ir3dJ
	L018j3FGmFUdP8WMX0NtM0vNGkYRjm29LVpASZilKLTvm9ESx6tWoj3GvoYympXn
	OZSgM/cJaJMig4242O79b7lX/GWR6qnKI5HoazoSivCZO32abjWtPnU0IrvuBnPh
	n6h/HRyiw9atDOV08T1NzfJWc4E/ffVoRNiwppb6Y2reJL8zJv2lLBAXT8ytwxtb
	oCAZGD72IF46NdEz/CA+Mv9ybJX366YYigI9wAUwnhsmLq9kYS5rkNM93ggSiyxN
	8P3SnoSJ55awPRFOICTadoNgCIdxV9lB2MQ6iV4whUjQ2pJaLfXighZxiQ/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770656897; x=1770743297; bh=lk3l6S55DtGSr4c1hldtTTXD3LqZKKHUDJF
	u6gPnNmU=; b=MtRZQByWptx/qfLWRtOCdHAD8D9OKAnoLbSlKwmBI7YFk0dy+CH
	gfMKvrTS6a+5hFd8aQMsPYJbVSz6/fJjOqDkmxs3mOtsuf58dDFZagBGMdbogxrZ
	lQCTAyj3zITP7gcALJo594gkIxs0Y58JTpsrqYFq0Wa/F4W1nKXegRrx0RTv6KzU
	aiG+eZwzQHoQPZ4zPh0kC/7O+ZHo1qejFnejrzCfR4KQiJTNj8jAFUa+QXWcp1T2
	JG1gm4Z/WAtb0m/d8TUqMVBcgoiOo16EEpweajIViMhWDaaHv2qrFxWoNRBU2Kqf
	vq++9gU6YIcu5Oh9mpC3V3Fo/VCIAOlWoqA==
X-ME-Sender: <xms:gRSKabspntH94Zh2BQut36h_eLbuLmsUT39fzTiLJKRFjGuuDgNZIg>
    <xme:gRSKaTeHaF_ea0_nsb5p_JLgcZD1tJTBmSlfiPW4Xn8ZvhCwAAn30JBZmj7oy2pHH
    RCzjc58aDTGeM45aV29AH3HxnqHXtu-9qTPKvrGxehegsd2S0v1tQ4>
X-ME-Received: <xmr:gRSKaTwKm09BVzihsFuMFZx5yAzpbhIWCkwWHeS8QN4BwuvtZV0x-Zl9DRX6lHHeMS-r-y64T8kFdB7A9FurCKT4i3w78A1GQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprhihrghnrdhjohhhnhhsohhnrdgtohguvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gRSKaZFRpYAxPMthrkaAR9ef7zS5ksXYun8vYh-CCr3bToj5CHcpzg>
    <xmx:gRSKaXw2mepz1gdTNkYcapi83M1Z2LGHjSW-pb2pW35pw-GdFiRBYA>
    <xmx:gRSKaavoFZtxrjDHBTYaGBGJhqGL8j03M7OIGAC-rTcrS4ntlOlUjQ>
    <xmx:gRSKaU3G7AZUiKGE0l2cTfzFsYxSJq-OuKS_AsVI4FzC9iIw7OrSCQ>
    <xmx:gRSKaXTT3q6Q9B3cIyQRRPt1qpCI_uBajmFRUxI-ABgP8nL1M_S8Ku45>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 12:08:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Ryan Johnson <ryan.johnson.code@gmail.com>,  git@vger.kernel.org
Subject: Re: git branch behavior after git init needs fixing
In-Reply-To: <D1CA4E13-B279-4931-81EF-364169564612@gmail.com> (Ben Knoble's
	message of "Mon, 9 Feb 2026 09:54:25 -0500")
References: <DS0PR03MB72900848B03D2B87A6846DCAA365A@DS0PR03MB7290.namprd03.prod.outlook.com>
	<D1CA4E13-B279-4931-81EF-364169564612@gmail.com>
Date: Mon, 09 Feb 2026 09:08:15 -0800
Message-ID: <xmqqjywl6e0w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ben Knoble <ben.knoble@gmail.com> writes:

> You are probably looking for init.defaultBranch and the 3.0
> breaking changes plan (which will make main the default).

In other words, run

    $ git config --global init.defaultbranch main

just once to live in the future?  That sounds like a sensible
suggestion to me.

