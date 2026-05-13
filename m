Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F587357D03
	for <git@vger.kernel.org>; Wed, 13 May 2026 01:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635016; cv=none; b=rzwIgx9RTa8Ny8c6yXkZRGmDiai2EeDF2fRjRyKA4TOPfcTbZoxO9X8Bb16yNY09uGwJXViY77itEGWkFaqN1U3uQTUslWryH8dRmXf6iBk7XfCgfSic7xOTzYO0CrawpawYHxQ36wthwKfGcbrz9HVSHzxom45QoRM1/iWgrEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635016; c=relaxed/simple;
	bh=U09SCMfjk//e5Xn2vFqeFO3rPpIR8nLTDqmQvHwSw4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IYpa/3xMUV4fcI8wThUK0ikO1QshqJQZWHzRFTzBYbB1+kc2W5S7olCsjfsZxKnApiZnedpaFEAddxWPj1EedKgff4aBdyBU02kfnj/ukm8aqQxrexM6nBQjsXNOZiQq2jsZenqFIwUHWmKnoZoQ5M6rFgC/e3jJTld+wuYNP+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xcMFN3jo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CY4n+BfI; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xcMFN3jo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CY4n+BfI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A010E14001F4;
	Tue, 12 May 2026 21:16:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 12 May 2026 21:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778635013; x=1778721413; bh=GpGFYxbtu5
	PVR5vGre3eafOB/fFP8jxgNO8wRQOz4vg=; b=xcMFN3joqftVUM82rWsPFM93AQ
	1BWxe4nrCH9xksTM5HTKAukJfdv/Wkby+yMmWwzRfYhU3O7/JCovYUPMUeUMmVAB
	058IpMVntWvzxbylUZm8ImQorHdLw2buxlkPhx0ED35VrrBypD0eYMgGqp+cH6fy
	YRZECSBQyDSROh6REH8Kq4NBEdB51oJ77e7Jb43D3t4WbGCr77icqLkT8DISLF/l
	XvoCoFbs081wjtLVxNPiVwcLwISdn5HVHRe/83ww4CtxTzAqwu8gnbwTwwd2OHfx
	c6BJ8fVweayHUxYudEVdY82+Rn+wJ/B4gRD0RoqQ0Veg+D63Xy+cAl8Y6ebA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778635013; x=1778721413; bh=GpGFYxbtu5PVR5vGre3eafOB/fFP8jxgNO8
	wRQOz4vg=; b=CY4n+BfI76e8L1akx7FscW3hnbGt6RsspIQEKrSnbw12ItT8RaQ
	0jd8N/keV93WRaM6i4j9624eDQYQlKbIPO4Z6APYS7QAstcthARlO9EMp8aW2ahO
	cLMDm0FxGQc+FgZQt34JZNWrDuHK5AmlCtogeDLOu5rgMGXHHb1PWYXX1XGqPI63
	weJePnFiJF1lw2Iw8FzKRrPLFjqJ5CHs1M78eok9AZBSi+OLZtV5qQD0gAI/YVYd
	aGDiM/VKJ/37RWFREA7asFOe7nX4kZ9Whpd7tkZ30+eh9qTC0JVrxZK/Oem1PHpc
	HkJEMDKrype8WCcQL7I/nvaUEmpdItjOmAA==
X-ME-Sender: <xms:BdEDajZUqG_HSg5dTkQErHUFtdONWUeMtA6bJuCWk3GceR1A2cHRXg>
    <xme:BdEDapYfS5-oQygW2iBHziRXwFdcD3ozh70qufwU9nNmwXjs6nasPTuMIyfMMV5BA
    rh9Br4MpaGthl1M0tdlsKhNrdHF2G26os2rbydurRQyvkmYzXaNhA>
X-ME-Received: <xmr:BdEDaq9Ej_HKMNoyPvdZmxLzcCKYHGqtccK6ZWAyLa99OVuDO62Cpt_OCMWDYMzD55y2HH-wv2mXP08dNO5sWTeHrBLfHnc-Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdeffeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmmhhonhhtrghlsghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:BdEDaoiGKX6cKVI1VKLxAv14cIstUmuJfS3DDqEp_Oz5sqGqE99l0Q>
    <xmx:BdEDaqetLalH6Brr3RNutOmYOcJbbVOt6evIkefnBWl0hNLTfshdoQ>
    <xmx:BdEDavpHAUkWMt4lkiAr1M8JeORL0MxSclKyp37wA5X4PDno6-oG0w>
    <xmx:BdEDavBUmeq9-MVNivLBXPdeyU8yIqdwIy-G513NjiOV4rbvVq4OhA>
    <xmx:BdEDaqd7Ju5AQVCERrBSWw85BHO7GhrCJ-kzn6YKbqowEO4v8DzrT_jK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 21:16:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 0/4] diff: reject negative context values
In-Reply-To: <pull.2105.v2.git.1778609423.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Tue, 12 May 2026 18:10:19
	+0000")
References: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
	<pull.2105.v2.git.1778609423.gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 10:16:51 +0900
Message-ID: <xmqqik8sjegs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v1:
>
> Patch 1 and 4: Rewrote commit message to not imply NONEG was related to the
> bug.
>
> Patch 4: Trimmed to just clarify what "negated" means, without documenting
> what PARSE_OPT_NONEG does not do.

Thanks.  Will queue.  I have nothing more to add, but I will hold
off on marking it for 'next' to give others a chance to comment.
