Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C46123C8BE
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019861; cv=none; b=FBKUZWrZtk7cJX5rNAQvYI7losAx9EPPSZMo9KKkqFg9eFoRUC/PxRttJBqoB69f00d/Q0wGBx7foclp2aP7qH8hvVMdR+jWRJ4iQqCVI4Y4/5ruIPe9TNgxutLI4ZMyZ98mKwOnDu2BZGGICDrychuPjzvBxT3RfPoWkv3pfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019861; c=relaxed/simple;
	bh=lQeYVT2hSJyEZyg31b0sl/w2hieGP+x4ZHOI7HzzCBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rcJRoiC56niPv3gyiMt4457T2q/huVfzGXYbiTh6MyrIKYMZ3PRJatmmzxOonQs8fZS9PZ66b6Pvnd7ZVflat0bWTTPI9zX0mm7snKg7z7lzaKVUmnr2Lab6lA9q7F9ALTShj1+hglJHjJczsGAza2CCl1mcyr3g+DOkD3ewfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mhuiWbeS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qVeWnGf/; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mhuiWbeS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qVeWnGf/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90C2025401C8;
	Mon,  3 Mar 2025 11:37:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 03 Mar 2025 11:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741019858; x=1741106258; bh=gv7lXZN/Gk
	OxC0mJ/m9+m8slUzl9iqPQex66+AlVrPQ=; b=mhuiWbeSwf057+j/a95BHMzJKN
	XG3I9Z+sSmpTvRXcqH6yQCDRSq8DOduPvsKCZ0tVxnaxcP4McYeZ+KaZ7ki5TseO
	+b5lJBkUqPv68P1ZCNwf3LCJHukXGHfS5VlN8htdQGKURBYC74KSltVMLhERL558
	V3d9kJUEc/gr1yhb1XUTqVoE7wWQRmNjZWUaRN0VGoU4zLRBXbR87AuVcDj/4E1O
	/SdYETXDlPOfuXm7nNEOVGxHnU4F5QeB/84nJ4xVr203iOUOpbrYusNgqX1YJgT4
	yhzE98nNPvGn8kglwhwBfQ+Myp6gstFETTSE0r9nTtvWzE0EinAN2lRGBpyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741019858; x=1741106258; bh=gv7lXZN/GkOxC0mJ/m9+m8slUzl9iqPQex6
	6+AlVrPQ=; b=qVeWnGf/1RQqmGiGLtV7LK0T8D/cMQht5QHTKk4kwBXgRcCTA2i
	cPdmilSEBPghRu3Z1q3T+eCWssJ+6/caKipYSL4rhecdJgjva2D5m5z1SkckPNwd
	/9tgXnmbJvc/ChCai3OH48OdobBZTLs4xhVfa4xEcU3QGI9buHGJngTXWiEu6lOQ
	Jvwe7LKEZbdtdiQHzG5jH5y5wt6xS9ZsFMcObd8y53JYPrAB24VWh1KTr4lxIdf9
	zpuYxh4pX/Q+E0wrfzMhWz3sg4Gl/IyfEzuB9lsHLKPgIcFj3Y0sFk5eZCUfh4Gh
	9dSQShIJS8ugm7+lrGIQooHhfOCPgoIllZg==
X-ME-Sender: <xms:0drFZ-PXRNaZg-z0G_L01I1ur3r8-VjYuC4Ia7LA7NJMWzXy2dGbDw>
    <xme:0drFZ8_5fzx491NlmJ8Oq-Knz-Mr2Terw-ujPKlNfl8blTHKBmvDF0dCltl4lU0xo
    dVntbLchGo4rM6NZw>
X-ME-Received: <xmr:0drFZ1SvIYGKN0cWuflbcUPneXefBlv-sGrK0Rx2tzMYBf7d2X1kwxjQbQCblsR_uA108cKkr71EanmFd6mR7bItuFi9iEyUiuBs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:0drFZ-uKMP20H8_SoYLwWg-AHJXdVkrUqDxqISZgpF42kdMrU2NwEg>
    <xmx:0drFZ2cMYoH4YUitE5HgbEaY2FNxTOW9iyrp0Q7sfFhzy35VBPHgHQ>
    <xmx:0drFZy1uvm8LOHrirnCWOkmLmlXh3WpXS0EeNUGBUYHGMFaNt9vrBQ>
    <xmx:0drFZ6_oKrWnEpP3pQ65PPGnTxgiH-U6chkgxsVZ6uKz8rKRxXch5w>
    <xmx:0trFZ-T7c4-Y2faXNYeuHcTpHdfo21TAdBnraXfcS_7lUvO5eVYuIaUl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 11:37:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Phillip Wood via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] meson: fix building technical and howto docs
In-Reply-To: <71b5dec1-a50b-4624-87a5-b1ede8767166@gmail.com> (Phillip Wood's
	message of "Mon, 3 Mar 2025 14:32:57 +0000")
References: <pull.1870.git.1740931350451.gitgitgadget@gmail.com>
	<Z8WBw1L50zVmjGIs@pks.im>
	<71b5dec1-a50b-4624-87a5-b1ede8767166@gmail.com>
Date: Mon, 03 Mar 2025 08:37:36 -0800
Message-ID: <xmqqy0xmvzn3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Yes, I was hoping this minimal fix would be acceptable for inclusion
> in the upcoming release. We can change the CI once that's out the
> door.

Thanks, both.  Will queue.
