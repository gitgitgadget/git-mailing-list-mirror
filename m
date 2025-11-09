Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3254652
	for <git@vger.kernel.org>; Sun,  9 Nov 2025 04:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762664383; cv=none; b=Y3PKqHz5cQhDledrn90G9zxZfZxWJhgGeH+XV16QF7LzGNYPBKdW0xCyqzZm8AM6G8AM2t5jpbfr8lo1JPq6v5hjvnooVG0aofMqXICveMDWPYQAcQClpNn1L1f2x3sT9IIpu7J+ibeyqoB1+wyRo7Xa2CGALyVH53j9ptZoT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762664383; c=relaxed/simple;
	bh=8NqmCmG/fH2kO9YjmrFUSP3LkP1ZkBVPIR1H91gw7Yg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kdtZZeiVkQYhVFUpgEpQs09+lzoVWVlr42p5yu1YFIl9jOV1RClzLaMskI/8oxOZPMg5N6ZxCZCPk1WSbYzuWZ/KnYMiHH8fxXljtggqwP33V0ZCGH3fuFmZA2eE2lPoy9nQKHupXEieUQrzeGBo9uI7b6AuJuaZ3yEUj771xI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CONi/9a7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GExesMFy; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CONi/9a7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GExesMFy"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 0BD3D1D000F8;
	Sat,  8 Nov 2025 23:59:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 08 Nov 2025 23:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762664378; x=1762750778; bh=LSPMQAP2ur
	cWUaNEqfhbNlNuRlUNwdexDHHnYWvkG+0=; b=CONi/9a7Q+5NSpVp4AAOAGCgzA
	FGEouAuiscvI0Ol18yDoOEfT/vqin0rABoDcRZG/lL7sGT2jOBcK5B3dwcNIWqUS
	BMvt02c0frI5+ImtKVaCu7Qwuag6K1w606UVRsAPkyJlmPj9hqVmO/wrIztEaU6G
	Wilmv9of5lxwYOJAczd2t21XP43G9IAP0OFxbByluZYjoymfxVof1bRQHFraIx+y
	VH7cJ82PT6LpUVMmP0CszT4Nh2cJWI9DgGl1E+nPHJIyXTXF8Pg26etbt5EJ2c/+
	jPdQs8Wuv/wGDWpMdSvW8gF/DKYyAKjsntclQ2wNolU1Fr3IUJgDuTklYeSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762664378; x=1762750778; bh=LSPMQAP2urcWUaNEqfhbNlNuRlUNwdexDHH
	nYWvkG+0=; b=GExesMFy5jQY1qkeyi8VAA8U/cI+yOrtt5vb3nSqCU9wS4GnLay
	tDefbge5DbVsuchn3xDWYlTr8yZuApMrBwlRf4p2gHeDJCx4gsGvFypebVhx5TFp
	u1u+BWP58esrsnAsiqbsEzP4pTe9kADy5FbT5a4bg7tZ8fhwoN2LrRPViuBL76Uh
	PbmoJhtzvGBgWUvxJ24+UyOXEQ+wHNJJqXv3yCdpbJuZxL5aA4u/Jtv2UJwDG1LV
	ZOxqwP2zrGoSgtsLty/90BZhM9kwrsML7UtlW7gJSuKXjDKBKNf6xUMGQmafWRoB
	TWZG02f/iXgkMfn4yLIUgVWjHMSWRLOFLRA==
X-ME-Sender: <xms:uh8QaRQV9uEv1k4UGMLQdsN9KekK66DAKBCxHn5POxbDauFV7-VOgA>
    <xme:uh8QadD19BEVx7SHyIueyLynrwn0qwMn0nfCIkWcjUxl3kiBWvf8WVagXMKLD3M0X
    i_neQZtbVdFjE78N30ZtHyeZ6F1jPvTwT3Ar3waHtdYZ6aV3gDGTIo>
X-ME-Received: <xmr:uh8QaZFlKaHYUQ8vrJDwfQcM_fOI1GEe2cJKjH7ZO7r30ucKwc167tj2YP0jJdc3Jknn2dO4kAhEzN27nLtciX30oBXtohxx6bXd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeghedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uh8QafDyO748eX-NNjiNRKAVE_kv_jyoBLvdRSMPUI4CktRbGB_cew>
    <xmx:uh8QaZXkvjhLEhPaT6et3JDXdSZhVCbMZP2_IHisAHYS_TNVnP2F4Q>
    <xmx:uh8QaTqRTuww8tMvq0IKbdZSqYCSrNMWe2P3W0dUHPohAo7LTzBJ4A>
    <xmx:uh8QaVRNQNXnt7Esk2FMHeT-SqVjlxpEQJY5hOecViTJdrau-Gcrrw>
    <xmx:uh8Qaf1Ri3zctTGU2h-PE3DJ7QQEM_u87iqFizGGbzqJ5WdYDj1gsILJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Nov 2025 23:59:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Julia Evans <julia@jvns.ca>,  Julia Evans <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
In-Reply-To: <D50AB3E0-E41C-49CD-9407-AB60331A6A43@gmail.com> (Ben Knoble's
	message of "Sat, 8 Nov 2025 19:48:56 -0500")
References: <xmqqo6pde90w.fsf@gitster.g>
	<D50AB3E0-E41C-49CD-9407-AB60331A6A43@gmail.com>
Date: Sat, 08 Nov 2025 20:59:36 -0800
Message-ID: <xmqqa50v4x8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ben Knoble <ben.knoble@gmail.com> writes:

> My only other opinion on the matter is: what does making this
> distinction clear do to benefit readers of this document?

I care about teaching people not just _what_ but _why_, because with
vague distinction, many tend to memorize _what_ without
understanding the reasoning behind it.  "Our object names are
computed as a hash of the contents in it formatted in a canonical
way" is "what we do to compute an object name", but the reason
behind the design is because we want to be able to dedup the same
thing cheaply, detect two objects that are different cheaply, which
is "why" in this example and it is equally, if not more, important.

The refs and objects record object names, and that is "what"; the
reason why they do so is to refer to these objects.  If somebody
comes up with other ways to uniquely refer to these objects, their
implementation of git-compatible system does not have to make their
refs record object names---they can draw a line from a circle to a
rectangle instead of writing the object name of that rectangle in
the circle---and their system is still compatible with the Git data
model at the higher/conceptual level.  IOW, what exactly is done at
the byte level (like file format) is lower part of the "data model",
but what these byte level details wants to achieve is the other,
higher half of the "data model".  A data model documentation should
teach both levels.
