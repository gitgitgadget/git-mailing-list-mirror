Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC7370AC2
	for <git@vger.kernel.org>; Tue, 19 May 2026 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186910; cv=none; b=MpFpofZHn84rvbF6trSDhAS/gLT+vNFND3XdcmwXQZswlaITI+KB3Qx3jm1+deflV8Hed6hdzp/v/JtQodh8U6rzLULuKJWdnGsXyPlbWqZWKohtS0f09vK65K9LXlRJviFs31Vrge7esDVQHUUKbnajohmnnOWGgfTFq5YuarA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186910; c=relaxed/simple;
	bh=erSNiHO5iRlbspo+BgckwG0e5JXnkEYSjtGRsgM1dQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a1n43rcliqJSGh2wpuvbKhsmxzC36g9jEKSF1IRysxArWgqHQcvtYsnepKBOFhfxzv954vqtrOb+Cx1VQbX54gK6eovXhBXx9aZ4/9J4rzt0OuAbWiohiXE9I4giJB+dUl4Z5e6WxoeBUzzLh15OGA8R0RiKOhKfQxqyGS3lfCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IJPx4YTd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fyxkVY++; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IJPx4YTd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fyxkVY++"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 47C167A00D1;
	Tue, 19 May 2026 06:35:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 19 May 2026 06:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779186901; x=1779273301; bh=hruvgF/mo5
	B/TP0378iimbFfzyS4DRsTwdH7h4H7BgA=; b=IJPx4YTds1DgpE4JVwQQNLEm3z
	34grX/CyVMsn3UiXtUnA895j4/HMKnwIAia1WLeElbaG2GULAEQknbTqG8rQr0eM
	RWW6WF5FivIP1cc3ri13EGc77l3sQRymMpBaqzCiIb21v4oEDQ2VrlMCPX8HL9j3
	RN9BQoyDTebsCU/7zmUeyr2KzMnAHNz16kw/PhR7Z7zZJMoHxgSDxOoVd1KIuBmm
	ZVin5ZI8tpcomVrsVDSRjPUyR2bYp3M54Aob7igaQFCyL6JCAZJE7b4XynzgOvUV
	Y+6x/Tr+goqHrsMw4R/YRgGvlfnIvXOMUw4xA4/uO2OR4jBphUbdD9a/Gl8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779186901; x=1779273301; bh=hruvgF/mo5B/TP0378iimbFfzyS4DRsTwdH
	7h4H7BgA=; b=fyxkVY++TsXyvliyByLCvsL6AhuLapLlano6pQ//4kugU23aek3
	1ZGPFmqbtBDdk5osQUrP/cURb98t+PV7eQpNQAJToXc5NMuw5aAyADDvA0ee3S7Y
	UtPas7MxQd/cDuZHv4W1DkxGp5gFb9fl/mzDxvI/99/blxq465PprBHiXIVm/kt1
	Sn+LkmFdG2kShZcssLJtRnT3WiNb9eAphknEFtEMZJ8aWj7bHqcEEO18qPbD5p2Z
	qMKVqLuvPv8KQLw/u3F7C1ByZXwoP4+jDidFSBdnHGNaoIUq5zflXlbTi68hWvt4
	gADuoDD1EP7XYDDSb7S8jGqcaG8UpG8B6Ag==
X-ME-Sender: <xms:1DwMau0BbIvQjUkObMf7868RNGnouI2PtUhAnuv0PNnDmtrFoJbd_Q>
    <xme:1DwMamB1wMD0jfJ_CMad0QUu7J622IWHXfBuKXTlDlMeiJGUiJD9t98QHajC60WGa
    ARRErLmBmGyZcKCHnGNnO2DpUL8cQw0lni-SFO8cs15cWKrRtBr>
X-ME-Received: <xmr:1DwMarJpZvFxm2GFZEqgQXOW153ht3MOedpNmBbOiK27uKc2eAiIqtTNAFEEXmmr4N4_LDxOH6vKg94zLjOQpgscv29W6wWO3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeduhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    grrhgtnhgrrhgtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehhrghrrghlughnohhrughgrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:1DwMavmiSqnA0Ia5ZRCK9kHJaWNmTONidgIgTFgVCF5ejgjBYEihgg>
    <xmx:1DwMakYWxhf-pV6DuCX2lS6zgUZ5JDVN5z21DlaYZrWX4kC94yKi5g>
    <xmx:1DwMar9GrsuwAUQiJwuErRl1zec0EKB3YaOLqt0nxzUIVlR6f_SL_w>
    <xmx:1DwMajbyfZqJvmcgHKZ8BEiR7E_4n70-Oe6gIbB6mdMcCpoZK6GyhQ>
    <xmx:1TwMauOe8qq-pdOSR6rJnJbC6GabCJ0C4upzk22_mDtRwt0-rTExzUs8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 06:34:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Marc Branchaud <marcnarc@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v11] checkout: extend --track with a "fetch" mode to
 refresh start-point
In-Reply-To: <pull.2281.v11.git.git.1779177508772.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 19 May 2026
	07:58:28 +0000")
References: <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
	<pull.2281.v11.git.git.1779177508772.gitgitgadget@gmail.com>
Date: Tue, 19 May 2026 19:34:58 +0900
Message-ID: <xmqq1pf77kml.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     checkout: --track=fetch
>     
>      * Find the right remote by checking which remote's fetch refspec maps
>        to the user's start-point, instead of assuming the start-point begins
>        with the remote's name. This fixes cases where the user has a custom
>        refspec mapping into a namespace whose name differs from the remote
>        (e.g. fetching from origin into refs/remotes/upstream/*).

This comment is even before looking at the patch text.  After
getting one issue pointed out, I'd expect you to think about related
issues before sending a new round out.

One.  Have you considered the case where the remote-tracking refs
are overlapping, e.g., where "origin" and "upstream" point at
different URLs but they both store in "refs/remotes/upstream/*"?
Perhaps their URLs may textually be different but are pointing
logically at the same place (e.g., one ssh:// the other https:// for
example).

What should happen?  What does happen after you apply this patch?

>      * For a bare namespace name, follow <namespace>/HEAD first to figure
>        out which branch to fetch.

What should happen if HEAD does not exist?  What does happen after
you apply this patch?

Thanks.
