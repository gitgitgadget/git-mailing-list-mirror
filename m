Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7642C2C0F8E
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771628366; cv=none; b=V/YRLUFu8Ds7bAWXVxl1DzAPjEltjEMFNTMdRhfsKqIp8dCN0/dyjr2CbIEYdaH1Q208PZZbH21RqeHGfLpsQWMpHjMFL44O+66lBYEjgsCM8e0jkOldD6XmhiBm4Y1JuNRMd5/5KHOfrfmKY7q5GTmBCGMtqV2pmRhmz5rw3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771628366; c=relaxed/simple;
	bh=vgqRKVgPFsCVQjEZgl0Dv7IBVdYYg8mCtusvG0DMG/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EgIUDkGTxl6zgCBPcyH4rQThMRAGp/q3TX2R+XfGLC6ANf5OKbYqEH/lpmNNdBhUd92U/e4+zLyXIfwbOFrJ4CfjIbvVVfELGUumvktI9+A66weEwrSEUp/6UVMxu6i+BraZ/nz5ja91dhXg+mCdruoFhMbfVZuojIH3Pt95u54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VoUOE0G7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w9f4VKwn; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VoUOE0G7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w9f4VKwn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ADADF7A00BC;
	Fri, 20 Feb 2026 17:59:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 20 Feb 2026 17:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771628364; x=1771714764; bh=kzPZe5eaX9
	/AVwHe0SSStb6I6O2Q2X8pt6N8qLDl0pI=; b=VoUOE0G7AMaEJ25OwiGznoLqv5
	cLevMPegpOZ2TH20lVaGMraZUWqW1O486h8j300PYk7l06xlUjefCL/7XjgKnUZy
	XvElWKI0p/QPd72s0Vqqxu0KVGaPgkxiEpD93gIal+MzX/omGpKEDCU7LDl9auwV
	kiDluuqPuSiHL9QPbyBTweV3Jz2xR+YJDinMtyhOEv8gNZMvy7iCcHKBOCW10JMN
	7hoTdRM76WZaRCWgvQbaEaJH6yCTM8Ww2VSTXPWoCz2A3t7Bs/ByI535gZwrQBjW
	I8IhsyHWjSUyOaGmdfxvD1nWzvmDVLKs7LV5zX4MPbbt+vuzqxsXDi3zLeag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771628364; x=1771714764; bh=kzPZe5eaX9/AVwHe0SSStb6I6O2Q2X8pt6N
	8qLDl0pI=; b=w9f4VKwn/Jiblr5iJ5mRoVivv50nVt75s+m2Io1Vd7nCHZUdc4x
	5gZc7iTKMpZ7quPXwB23FxrukaMqJL6KKxk4lm60y3X3Uc/XsB/UV955hRqFGmEy
	7ppSnDOpsOMuYafYnxBumdpyYb0uJPoDmttwjPFz4uw/HP4XAhXX/jcX+vS/htdN
	6fpgxwexIDq5fTWOD+8DiQACeq7dJmOyEvB7UNO/aD3Iqp05niumdyf8KUYEY7T4
	UplvMZiQrElZgGBOlpA8DA60Z5hUgkWE4Kid0mhvl0vSCyTHeLEzCEJ5nSCvBEjQ
	aTU6GbghDYuj/lbd8dU4U3dFZMqC7XZ+nzA==
X-ME-Sender: <xms:TOeYabyZMO_Vp95DjMqiyWfw54I8fMp25wZZN5BOTuq1RmukApSCng>
    <xme:TOeYaaJDTV6d8veo69VvYoXMfaaBq1PXHJsOaKTbKzdCulMQoxxZtf1R3EYQj2_ug
    5oyGMqb9Ek6r1hdoPYtfJ4mIBZuzBIocj2E5nLVb4KSepaJvYt-eg>
X-ME-Received: <xmr:TOeYadrqEwpTINAuTm6Iwd0MPDgcrpcOFPCtT1_wv3cnoouQFLZKZ0HzgYd6YLhFSHL3FXDia7U7NMbQKzGOkobB1RdmeK161A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TOeYaRIFFEKVpi5uTDBB_SEWUVcJd0kJDvscjlNV6kB5oUlvF9mgXA>
    <xmx:TOeYaaQRwpwBQgY-Fi5AGUGLKDIcncr6YB1SYDHfkic9Dkp432lBhg>
    <xmx:TOeYaYs0p5nNYUHH502Xg9ZjG7NPi-Ar9-scRhL3FKpQHVYI3v6vng>
    <xmx:TOeYaTaJw_XpunlTOzPFICIr-mXDAxhgS8F-JmvNuuVfumklPhQs1g>
    <xmx:TOeYacaxMsgvBquYrJp3ZFCqpUsXOr_yZKRlPnPMXh7X3uv9a2kMDwvM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 17:59:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 00/14] odb: introduce `odb_for_each_object()`
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
	(Patrick Steinhardt's message of "Mon, 26 Jan 2026 10:51:16 +0100")
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
	<20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
Date: Fri, 20 Feb 2026 14:59:22 -0800
Message-ID: <xmqqbjhjuilx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this patch series introduces a generic `odb_for_each_object()` function
> to iterate through objects and adapts callers to use it. The intent is
> to make iteration through objects independent of the actual storage
> backend.

This topic has been dormant for too long, but we saw quite a lot of
things changed over the course of its evolution.  Perhaps we are now
at the sweet "good enough" place?

Let me mark the topic for 'next', if that is the case.  Thanks.
