Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6C26ED25
	for <git@vger.kernel.org>; Tue, 12 May 2026 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548908; cv=none; b=HLsi9i05WcT+uCB8z9HnYa9Gq8/1ObWNrfZjV76WbcU7LDled2p7W7I1GJQAmtwoKMUugL2ElBqBTBju/y1H9ePJMJE++cecHe5vGUNsqzbqNJ4HlxTIfw8o4lO6pkT3vJUcXGmUM2CeHVCaBFzsT39uUW/3MYDveKNzzhDLxc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548908; c=relaxed/simple;
	bh=w+E7NT671xOG9jui49NNDYdR9ePiijIaLBlPSZDWpLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IyVUvp9OibvgRIGxV1zx6h2Grg9/M1DYta4VXCafRAv0q69017mhEolVRwQpzCkFAE4SXRtJ3Pjzfq+liGiCFZr2+K45wlkM8iShV3kHGyAnPGm0Ppp/Aqnv2cV4loinOaqRv+zHYOZWBHRCAahMGa67wN2TIBmHlKX95Y5excU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LeMd9JxQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Va2BOmDZ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LeMd9JxQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Va2BOmDZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3F0281D00106;
	Mon, 11 May 2026 21:21:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 21:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778548905; x=1778635305; bh=GPsiw4waKr
	QnHu8e2VVLusb92v9M3GjBRDQH1Eujko8=; b=LeMd9JxQjXtcJeT3/ottHSHlGx
	6uGuahXHhOnkZ1Nm4uE9wgYUhAvgP4qmpaLaAHCoGcEGl13wl2+DYdl3sCQGf5UL
	IMW4eodJX82eFr4qhmvaSktlKCI6k2UOUnvmOXuo4fWKLq16+rogqFlMS1SBayNZ
	OAJhHFf69cJRChxw1G7m01vcgxpPP6nCDdSS1cTYT5xmuQ0vVUifBSk7c86uDRvf
	0bj0kLMOh+ZNogJgSoNhcQCX51galgB67IzPm3iu/hfmfJFkJe5Wb2A9iyThHQxJ
	G3GW0BOv1bnqi9BCxkQQhPj/jT+VEUR3upIS5YTR3Q5bU69w4rZFDPzxarFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778548905; x=1778635305; bh=GPsiw4waKrQnHu8e2VVLusb92v9M3GjBRDQ
	H1Eujko8=; b=Va2BOmDZ/9mEKx7TzAG2KNiKDcrT/CmljWmR0k/SaegTycSDCF5
	jTuXMFwzv+MeKV/VGMmzPBLeCwFf3iMRefG5Ach3a7EkqmAt+V1gYEAOAeBEBwjr
	HB4/9RVW4wGUZAvZn8YRZCjqnXAazdRMZkOuXF9szbkGA61jAcLHt0cgMkzK+DCb
	MGESgONf1w0HxrqcBC7WvK1XKmFsU7ZZ7Gy2pcc0JdwuGOXEFS79dDHmMnwFIGtB
	hVXgXocCAJgkR5OQuZT/V2EFUIjxIP+bVsvXEFDsbQzsJDraEEDfrpHV2SRvBPu6
	D9iA9ABeyogeGdaSmx/yFN3Q2OISJr4s2WA==
X-ME-Sender: <xms:qIACaj1Y7Ub0Zgphse9DwnWA04zFhXvVZKvBjECwuEUn8nvjnb7_OQ>
    <xme:qIACahJb-jyu1inxEPi1a0Z9WZlZE6L3ygtspoJvCX8M_RQVE6VER_F5pv4nQOPYg
    1kBG9yH6xFrXnpODn7-WEAELUQ0gFZuqABdqXDutVc1iuuWm2tPZw>
X-ME-Received: <xmr:qIACaqGwjwiQdEiGDQhRhT3ZQS7BaYkhnxJs0sjJQdlZkDgKJDxl9mgK8PtBEEKXh2uWn9IlQZp-ePRaZFtXKYC6UetY2TD1Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrtghtihhonhhmhihsthhiqhhuvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehmihhkrggthhhusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qIACalX4M6WRluFmo_5n3WZpkR-XCqDjcbqMRy8apSjmP4xfjO9c_w>
    <xmx:qIACaqyo19SmUCXS6MxhJurI_V2JE5q4r-9TVkoK608NWxFQkhhd9Q>
    <xmx:qIACaiRXpegUP_VpsTt5VU4D4I-kjGUaj43Pzt_JOhhDDzLlnkf1fA>
    <xmx:qIACaujCo6qO9gGs_3w2zmDsFrN06HO8sai6nmUqjq_ig2VEPtmFOQ>
    <xmx:qYACaiazq4szN7DxN60V-PlJom6dIIZxvVoqgjqcXcNlN5Ea_vTNNU6r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 21:21:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jean-Christophe
 Manciot <actionmystique@gmail.com>,  Mikael Magnusson <mikachu@gmail.com>,
  Taylor Blau <me@ttaylorr.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/2] run-command: honor "gc.auto" for auto-maintenance
In-Reply-To: <20260511201800.GC22912@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 11 May 2026 16:18:00 -0400")
References: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
	<20260511-pks-maintenance-fix-lock-with-detach-v1-2-ccd7d62c9a40@pks.im>
	<20260511201800.GC22912@coredump.intra.peff.net>
Date: Tue, 12 May 2026 10:21:43 +0900
Message-ID: <xmqqzf25pgm0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, May 11, 2026 at 02:29:56PM +0200, Patrick Steinhardt wrote:
>
>> @@ -1946,8 +1946,10 @@ int prepare_auto_maintenance(struct repository *r, int quiet,
>>  {
>>  	int enabled, auto_detach;
>>  
>> -	if (!repo_config_get_bool(r, "maintenance.auto", &enabled) &&
>> -	    !enabled)
>> +	if (repo_config_get_bool(r, "maintenance.auto", &enabled) &&
>> +	    repo_config_get_bool(r, "gc.auto", &enabled))
>> +		enabled = 1;
>> +	if (!enabled)
>>  		return 0;
>
> gc.auto isn't a bool; it's the count of loose objects after which to run
> maintenance. So "0" works in both contexts, but will we complain if
> gc.auto is set to 100? I think maybe not, because we fall back to
> git_parse_int(), but it feels kind of fragile.
>
> The gc code uses repo_config_get_int() here.
>
> -Peff

Very good point.  I was about to send the same message ;-)
