Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41FB309EE3
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626890; cv=none; b=jHbFnjOLVyvcTDusBvUP692qCTy6IkA6EZIUd9Zno7E5VWp/8Rzyce5B2TuzG7goa/nDuMTo9pQ64n7wztALZf/Hrx5gaEVgMpTJ/biwHfPzfgboNJMQvaHcRmFO52SO2DFgTvv1tfqXcTnHjQ3otBSkGmjz/lDc+H7/SL6AyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626890; c=relaxed/simple;
	bh=qHU8+TNIFxFdbObvpqKhI5bCnuaB/2KsOYqDlB9MJ7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pP5izOGjn+veWFn8Tl5O42Me2Js5Iq6OhBwZR++conIivQVEe4Ti84C28RbRC2hI+8EKSfD5ZXjRJ61uG3rJl+RMnzJOyfVWIjJVgin9jM7kbszARJec5KA6GNQTgFzsDXXDXnWuWoEgpTJlP21cbrkIAUMwxXlw5sTlvz2RS/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dz136xBy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IAznsAMM; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dz136xBy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IAznsAMM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9937E7A0128;
	Fri, 20 Feb 2026 17:34:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 17:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771626887;
	 x=1771713287; bh=YS3lDNYcGj4EtdWBufiiYijyhwfU6DBaOHTdFSKaxUs=; b=
	Dz136xBykVWslUuoxhEyqWtjO74CoUcHV5oPt3TwczZ0MfNU+grTPO7ZkzCXpi5X
	iBxmjFMHaRK+9icL+HKlLpg692jdYgjUJJhVQv4OtCDhXtSpTKzhn/d3HU44l2DP
	aChXFHLpz/4+53YDhekkJRJv2k3R63GtV2/bGslRayVqcXUJZ+eYQK43Y3j2LuxW
	/6iwPDypJRUy/F5+P1oaVu2SS1+p7TkXjqcWanXrGQbTyVyVJbaRSZVDnlMuw4p2
	CRPaKdrGdWamNlxjNI4rP7vqd533ATT+XNKvqKyJ7wdDOhme384kUqu1cMlMSU63
	k7wRoEqBtA6QwZZuk4TpTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771626887; x=
	1771713287; bh=YS3lDNYcGj4EtdWBufiiYijyhwfU6DBaOHTdFSKaxUs=; b=I
	AznsAMMVKg8KZijBHGgSawh2TgM5EOasj5v7g6svlFk3mrSv7loyqRQauuIvIlyW
	lDexYcVQ67f90o5K+8QZ4nGnhJVxSTgsWl3A0KccfQwglW9of2oQ79kCKY9xvi2o
	rslItj7pojVk8y7TcDmS0CoJM+JpAIafG9/e2TR1PAauO9cWlMmzl71JM2mC4zZb
	YgrUmx9/+jfQs3v2ChGP+VzhMUjC1cmzdI6qkzdkME1x2mjpzkGCW3xl3g5eTTxb
	NO2R+c2Mpw4zMfqlrA0XrJ9RuQqqH6JBQcudiGATaNWZnsaMWgjIBR11gQ4iNbo7
	6NYRn9kVeD9o5Ww4alkTg==
X-ME-Sender: <xms:h-GYaQzRuIVKOQnOx5Uek5VjukiIkRdqzXVTXzirUHSrK-28GEVgWQ>
    <xme:h-GYaX8LAxLjrSd5S3N9U9iZFldJz3XnCqt_7XjoFUzQK4NxTH3D93DoYDrLrOcxy
    1SeEWo3E2I5ZsT13Y5Ylbzw4RXZ9ZspxQdvQbwzfglC1sXuAq2yvQ>
X-ME-Received: <xmr:h-GYacJZd2sOE9eFxmUE4L3Io5hZzjd_nvVHxlNTc_AQjB_mf4pY8HMSADrU6kY9_ywqe5g_in58qh9B1TtSO_aOB2ffr809Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdelieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedt
    gfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsrghmohgpphhoghgrtghn
    ihhksehtqddvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:h-GYaVfzOts65esrhUY_0Mz7fQdK7HA3orSsCeArfGgwgoOArieLrw>
    <xmx:h-GYaT-VY3tLYRh5AK-J9sL1EsAId8P9rOIELpR2A7ZeNLdUtrEtBQ>
    <xmx:h-GYaapEwcjdxJLhow160YEgs3tu4-MAnWa7f6oNjAyCTX3ycEh5Eg>
    <xmx:h-GYaQBvu-TSwVnRBXZJIOklXgIF_DofbjZIpjaeknHtZyhwB3vlVw>
    <xmx:h-GYaZ1GY83K9c5RnyJPvEIW6umqZfXw1Z0j5hMH9xWTkNOygBbdGDm6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 17:34:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Samo_Poga=C4=8Dnik_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  Samo =?utf-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
Subject: Re: [PATCH v5 0/2] shallow: handling fetch relative-deepen
In-Reply-To: <pull.2121.v5.git.git.1771186316.gitgitgadget@gmail.com> ("Samo
	=?utf-8?Q?Poga=C4=8Dnik?= via GitGitGadget"'s message of "Sun, 15 Feb 2026
 20:11:54
	+0000")
References: <pull.2121.v4.git.git.1768602661.gitgitgadget@gmail.com>
	<pull.2121.v5.git.git.1771186316.gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 14:34:45 -0800
Message-ID: <xmqqseavujqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Samo Pogačnik via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When a shallowed repository gets deepened beyond the beginning of a merged
> branch, we may endup with some shallows, that are behind the reachable ones.
> Added test 'fetching deepen beyond merged branch' exposes that behaviour.


We didn't see any response to the latest round, and the comments on
previous rounds seem to have been addressed.  Is this ready to be
merged down to 'next' now?

Thanks.
