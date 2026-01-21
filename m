Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC9F348465
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019153; cv=none; b=nZMPHpoo6/jRqw5Cw9i+D3ReNGAiO2DS3Oqm/cMVUITcGekUZOl8/6hWm5jZOQzWf624KrT45h/TwHRr8ruqcFveItphnBNITvSVlT2QDHa2C/61DgSdWcGCu9QhQM4xND4J1ldsYrgiWiQB4MgjDqOIdbRwjRdEoIy1Dh/PBdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019153; c=relaxed/simple;
	bh=7K8tiPH4EqeCFyB0vAP3+lDHsXFVEKK3WZybD6LHL04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QkutQUWv67hVcMxVbuSb91iRJOO7aLj322r86fsbU+TQ9zTKJuhVkL4IwgtRVzVNOeSpKv8hPnKUkt3O2Ej1D3En9c1eWK5Fe1pPiASdfhBYtPTyw4Yf8hxOdhbqrWltxX/pjp8QpqTvtiEJAQvzvYTYsMELCRQYG4GFrATFMtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FEI4nmBS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OagsTSBa; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FEI4nmBS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OagsTSBa"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F9BE7A00D1;
	Wed, 21 Jan 2026 13:12:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 21 Jan 2026 13:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769019150; x=1769105550; bh=v+cAZgtvou
	HdDjTM/SRzoipnAt7xeMZxBhKbLVv3DKE=; b=FEI4nmBS23/bJoDmozcq/YqyYZ
	VXlS42ViBXUg657Q0s7QlV0ZEyoUvkIb5eP1YEds+rTJFiGngRvN9d4MEJePO5XU
	RaCxpmHi2zSJVKYJ6zSNik4Yx76kFncz9dgxf/TMzEnRCZooSzqLCwJxusnDjB8C
	5nAE4SQSgRF9EiXFcdUFbCFhleNlhQK+UMp1jwEXfYN0O1UWzi6IpAvxMKWshzkN
	eVXwGPPUereMqI0nDIC5QI5K2rlTLIbL407cPFEHVq50YLkh0X+IffX564PJYFdV
	DVkH8jT1zpUSHBaObUcAz6Rk97iDLduvlM+RJQMc/oeidWxOuF/luvshiW5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769019150; x=1769105550; bh=v+cAZgtvouHdDjTM/SRzoipnAt7xeMZxBhK
	bLVv3DKE=; b=OagsTSBazEulUl6XaUE3zfxV2G49PeQXrdb1a5/krkpAz2D7mCV
	ZOAK5KsL6Ev8Q9rXnMkNgOEpk7BkYUCwAqOisIcih5ycJ+GHR05Z5+odBHjg7ZBD
	rMwIMkZCZbevYl1HB20xwb31dCyn6FSpL12G152SLuinO0OOzsqzP88Mr+B+ZeP/
	CRY+UCOrhjUSguiCdo5hSneD0Ys/LQPiAUAvgmKks+E0g5fAC/Bz/dIUWda1csPI
	6KeZ9VA2PyFH6E3L4pyf3jYob4PEVBcAYcbBlUXaKB4iq13TnL26I33II5DMmJgs
	WnIhyKXVz/wXSLkq4JIg6o4MIxMIe33gxXg==
X-ME-Sender: <xms:DhdxaazQJulleJcxRXZKX32edHRXWdGefQOiqXlDDZFNQmSV1YtWtg>
    <xme:DhdxaZ-iAqM5I5gSsKi_hjh75oWOWKbFzLpkYLKxCBNhfSgYaJTgiE-3HHyVirZbu
    OBxD7OLt0z4yP7QzSprAtkZbMDF5378_sAxAzr5Q7K1hUp_OYGotQ>
X-ME-Received: <xmr:DhdxaWJykduGo6AIlNwG0pPoAoUutug47ouxQWWgOxstnMi-QsojC-W3gQ4YT6PkFcidsOt6BTzqvFVV3dt6VI5UGrceBjzZRKxVqNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephffgudejgffglefffeeujeffueektdeggeejudfhtddvieegvdekhedtieej
    udeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpmhhsghhiugdrlhhinhhknecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DhdxaXcv93sdYREkrDOEUFv_TXtB1OhkVmS452oDdzNWbozFrx1z7w>
    <xmx:Dhdxad_uDTcvQ6TDixptwblUo-hpBx6hqI3QLYYN68pZoYOl6O0aeA>
    <xmx:DhdxacotTxxIi1hzOwt5vqWtYxC4MY8wc9oYxGlM17DxsecGIDIfew>
    <xmx:DhdxaaBxGqEYUP1jMagz7uNebZHHQtzfJNoQt1qZ-YWDea5BfPlC9A>
    <xmx:DhdxaejkV3b6RWTXG246ZYoaakpnPBloa73zFV--3Ma1pCqKDabKZhrs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 13:12:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  newren@gmail.com,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/6] refs: provide detailed error messages when using
 batched update
In-Reply-To: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
	(Karthik Nayak's message of "Tue, 20 Jan 2026 10:59:18 +0100")
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
	<20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
Date: Wed, 21 Jan 2026 10:12:27 -0800
Message-ID: <xmqqtsweu96c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The refs namespace uses an error buffer to capture details about failed
> reference updates. However when we added batched update support to
> reference transactions, these messages were never propagated, instead
> only an error code pertaining to the type of failure was propagated.
>
> Currently, there are three regions which utilize batched updates:
>
>   - git update-ref --batch-updates
>   - git fetch
>   - git receive-pack
>
> While 'git update-ref --batch-updates' was a newly introduced flag, both
> 'git fetch' and 'git receive-pack' were pre-existing. Before using
> batched updates, they provided more detailed error messages to the user,
> but this changed with the introduction of batched updates. This is a
> regression in their workings.
>
> This patch series fixes this, by passing the detailed error message and
> utilizing it whenever available. The regression was reported by Elijah
> Newren [1] and based on the patch submitted by Jeff King [2].
>
> [1]: https://lore.kernel.org/all/CABPp-BGL2tJR4dPidQuFcp-X0_VkVTknCY-0Zgo=jHVGv_P=wA@mail.gmail.com/
> [2]: https://lore.kernel.org/all/20251224081214.GA1879908@coredump.intra.peff.net/
>
> ---
> Changes in v3:
> - Drop the first commit.
> - For the last commit, where we delay 'git fetch' status information,
>   delay all information to the end. Also use a list to compliment the
>   existing strmap, this ensures that the order is maintained.
> - Link to v2: https://patch.msgid.link/20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com

Thanks.  These look good.
