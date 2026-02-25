Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9183D666F
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034300; cv=none; b=F9QjGLZgmeqDNog6t6cMizk3jJozUclJL6CGe2FiGesu04JZddxfa8JEKscdhevVRDfoSt8jXRMTVyjRz74LvtrmTIHZJefNMyIpL/IGUxdVb4lTU5nhsgwplgh3oS5S8exk2vsnF3nE8wB8BdDu/EU977FY9TCYk5CNH/s+8yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034300; c=relaxed/simple;
	bh=M9QigM3YuI0O2xy4i2/yoErrfhjgXgmDMWFDA6DxHsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OvwiVPdFYJjUQGldljiz+xQrA1qRd2k+seiAHznyBB0sbXoSvLaolhHb+DEykOG4bEd7Tl4QlCp6hAE4PSe1aLzDFzKr3dYOvn5PFD73dlLkWqa5D5FahUzvaJNkhFyVjsNUCTaPuIImlp9qOZwbuDzogDZz0pBGn5riWRaW1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MCld57aZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VOo7tmMy; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MCld57aZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VOo7tmMy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 35662140021E;
	Wed, 25 Feb 2026 10:44:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 25 Feb 2026 10:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772034298; x=1772120698; bh=+IvoFGsVaa
	bgBimtIm5xAMFUKOA9bSj++oDFoFV3dUE=; b=MCld57aZbutR6ZeCcDs0mAk3Yt
	bNcSLUGp3YJ+GWYPHaNb8YBQQdMYAO+9V2FbcCgZ9SqL5LfpPjv/vR5U8PJ1XtZ7
	U+emxLr40+t5f8i8gXIMUYVnq4+XmEfePNuKVNs8lwNHn4HfgLZM2t57Q9ltQzJW
	XcLWXxsZK8LUOahewDX9KRZYd6BVYd3lm+zWcUIyF3MoiS7+gYdbri9rVWocgfcj
	0TiI/sYTOWT2NT1ogCPNJP8HA8u1W2GrBLXdk1ns2cWRjQvtkznwvGKDOdUyUeZZ
	43HSJoEm5N1IqQV78nZzrcGY32koQ1JmEENYWzG0kxWZpZwq4m91Zwx92ZlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772034298; x=1772120698; bh=+IvoFGsVaabgBimtIm5xAMFUKOA9bSj++oD
	FoFV3dUE=; b=VOo7tmMy48accS7yMYxNxBN18R390+PlWhSR5IoxwDFrpRKX/7k
	IwnpjdKdB3Za70isehaFaqhgjm0EW6wO39dAMMFpkjnoocQQp8iYoxHxYSuoQZiD
	8ZRBpMmbU5Wm6I3A3e6hzUp9sSY91Nn0aSyxv7yzOWG8XCrQ72z1I/ezwYQAzzn9
	jkRkhdNVpNCDKITjx7C9cwfeDDHr2pIbRTOhDdthIW0YsYq55dhp6ejP5GioXjPA
	N+iyucjJT4RI8R9Vb4dc9BBX7DQppYnpsgCbIh6D8+vmX04VfAqMjYJCeyV3m5Yt
	1ehn0WOW8RGFncForh9I5Kb9j3aGORSJgiQ==
X-ME-Sender: <xms:-hifaT5RR1rUzEROPj8JjhChMqYt6ae5GOHrv8VAOSNEfgsIFpd48Q>
    <xme:-hifafwxsEco_oxHiskRQHPLsJ2lyEprs9d1ZuFCeiOpxxyEzUc_doKlZEk6D-nhh
    K41WmfK8RKCiJU_fHzkuqmZNwhNq7EJpjv4rYhKi7IWhQpL6hDhTw>
X-ME-Received: <xmr:-hifaSxDUBJxSHTIDV31hbjB1g8aH7IYKk6OeLlSEfu87AGvVIoGGvqlPR9fupCIfjoMrOH73sAX5gCnS5ZYh65W67jk9PTm5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:-hifafxLt4IpAT5NS2dCr4WF1uEtBC4pSYaQd5hSIXedkAr4aTlHVw>
    <xmx:-hifaUZ_tR_ZkKh8UYHWS1vDRclS-q_5LlBhR_4BqWWbydL__x7hEw>
    <xmx:-hifaYVuJJ0Cdv4-NF0Tkzi0veUcruWmT4UkNBSn8RCymBdXe-fHVA>
    <xmx:-hifaajUozKn0ZcQDMqdav38DfZAbSFQ5ny1PQeKcz_t7Lur6tYAFw>
    <xmx:-hifaYQ8unhFeV0LDCSQTLebOneJ8w8ULVGF7v6AsWbYI1BGb4pRdP2e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 10:44:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com,  peff@peff.net
Subject: Re: [PATCH v28 2/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <20260225102228.95152-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Wed, 25 Feb 2026 11:22:28 +0100")
References: <xmqqms0xeqaq.fsf@gitster.g>
	<20260225102228.95152-1-haraldnordgren@gmail.com>
Date: Wed, 25 Feb 2026 07:44:56 -0800
Message-ID: <xmqqzf4wbzev.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>>> So what about this. We add a config option that takes a list of items to
>>> compare against. But it _only_ supports @{upstream} and @{push} for now,
>>> and interprets them as branch@{upstream} and branch@{push} (but probably
>>> done manually, not via dwim_ref). That limitation gets documented.
>>
>> Sounds like a good way forward.
>
> So if I do these changes, are we ready to merge then?

I do not think of other things that needs to be done to the design
at this moment.  It of course does not give any guarantee that
others won't find flaws in what we have discussed so far, though ;-)

> I worked on this feature for 2 months, and then it got marked as stale
> instead of being merged. Will this time be different?

A topic becoming stalled is something the original author can (and
has the primary responsibility to) avoid by keeping the discussion
thread alive by responding to reviews, pinging the thread with
comments similar to "now I think this one is done, all comments are
addressed by either updating the code or replying why we would not
want to go there (which the reviewer who made the comment hasn't
responded yet, so the ball is in their court)", etc.  Even though I
try to help keep the ball rolling by pinging discussion threads that
smell about to go stalled from time to time, I cannot guarantee that
it would not happen again.   But you can help ;-).

Thanks for working on this topic.


