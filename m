Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7551D29A31C
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921509; cv=none; b=BjYxYaAZEt0bX6kYZVUBQg9hlmOIKmhr9f2/UVIsqo8Y5v7MQoMmc6k2hKwkmjF40Kxf9GNf3JxtnCXTaQ0LeaQCxU5ANZjeaiUR5H7OZ7gLag44ytWqoKrGUCPUPYAxdXRK0oBoalgzDN45c2/Y6H0LFILGzDwsC4O7Ij5OuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921509; c=relaxed/simple;
	bh=wSaqG0aPqzS7xJI0r8CWrlX0kuXqLfE6hoSm0PY74Wg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Q8WyRXwSLBI4iG+qZfFuT6kFXBjqpj4RuWUGn4NCFkeLI0dDKBTpWOQOyXIpDoJh7XkUc22ERWF1rZAvRMScTSr/P1Ok6RcTe+xPth8Ou4Az+IyUjQ2CCIdlAC4Ipry51DmBS61tvl+yMX0lHtRWTqEp623ntbX9Hya5ZikTtMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=N8fudLAY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=evgQKHH2; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="N8fudLAY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="evgQKHH2"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 891B17A0134;
	Wed,  8 Oct 2025 07:05:06 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 07:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759921506;
	 x=1760007906; bh=wSaqG0aPqzS7xJI0r8CWrlX0kuXqLfE6hoSm0PY74Wg=; b=
	N8fudLAYS7H2rKKKqBVR4fOD2r5jsbMNkUTWpXhzN2wBP68AlxN0iwwjuQD3zGJS
	x2O+dHlEnw/bwUondkRYckJlKlixl+wHcR5UuxVTNgPNqGl7c66hVsKj9vb4CTnX
	c7ZElPJ3MDQi/mGxIME3IEsnauArrBHFzc71PZAbSnKK8PNWKee6jObfqP6MfcKX
	SXquM5vFUHJLsdyftpWJNyNm/tSPABICjhmAP8uI+tV/9f2gNRqP9jITTZNF5q2G
	/5fsSy/rFQEpNzQQIokQkCoqhmAxqtJSCg/Hea0onv/BIaxtiyKFFJZFkvkKgImV
	/QOP4FuQxI2vHKr3+K4CrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759921506; x=1760007906; bh=w
	SaqG0aPqzS7xJI0r8CWrlX0kuXqLfE6hoSm0PY74Wg=; b=evgQKHH2qPDulk7y/
	oOrtKtdPA2SpboraR2txQBekNqKIeUKYAfIBNw+SeUiHvIZE2Wk2bnvyW1YxHjZu
	c8o17auqAuq5jhjtppVYb3za7lJ2w6ZVJwyROusAS8jaSrX88CfeWzU6cNNColNB
	fNOMGVmktmA1X+pY7vH2gh5EL/NSX0R0JJmjoJfU3ZXcxA+kCCjnofp3wpu2pBMu
	HBxr3LStz1ZXKPaMIYeBpRDruofsRQCthG+6kJj2+ydkRETLStyj4SU1BxuPbL3f
	uGS48i2GqCg6bfw6SFFmnAGuOtjzBgd92znli2BeFjz1yygrFlyNlkdH4zjig7Pe
	RV80A==
X-ME-Sender: <xms:YUXmaGfvxHqUVoyEHFqlH3RcW04QRcQOm7751V3KxjXLnAriDUwGxps>
    <xme:YUXmaLBMcxVUkFnpj0d8dvunUJ5Uy_DUT6-_8G1RVFgoZH_GUr5_AAurm5t44Fsab
    18ka-7CeZymRwVCNhy8U-907WDb10k8tkqnAod-HUi6an5ZtKGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeg
    hfffteetleduveehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YUXmaFL-1cu4RHRXCjyuQmupCvEpsgYiysgL182ojUkklClcrb2wvQ>
    <xmx:YUXmaPE9DcSTF5wpN7cK5HuHGJfuPfgfMsEBdKYfkSJDmOaWkqh8yw>
    <xmx:YUXmaFRjPGF5Ee0BTfCPaqy6UjNrmJG8Ao9gDeErAWNvOdqfiPINOQ>
    <xmx:YUXmaDGu-64g3ZVFK0lU-fpFrK47d4NiG-toB0TixG2fsr8ZtnvtlQ>
    <xmx:YkXmaAxIO1tCaCRTViUxJ_0_Ie0SSC2C_tFdhBPssm2i3vkHiA_sD6Yg>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CC9241EA0062; Wed,  8 Oct 2025 07:05:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_dcq5bOJKWo
Date: Wed, 08 Oct 2025 13:04:43 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Message-Id: <e4de781c-406e-406c-a166-5a48b6de42ea@app.fastmail.com>
In-Reply-To: 
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-10-916cc7c6886b@pks.im>
References: 
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-10-916cc7c6886b@pks.im>
Subject: Re: [PATCH 10/13] object: add flag to `peel_object()` to verify object type
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 7, 2025, at 12:58, Patrick Steinhardt wrote:
> When peeling a tag to a non-tag object we repeatedly call
> `parse_object()` on the tagged object until we find the first object
> that isn't a tag. While this feels sensible at first, there is a big
> catch here: `parse_object()` doesn't actually verify the type of the
> tagged object.
>
> The relevant code path here eventually ends up in `parse_tag_buffer()`.
> Here, we parset he various fields of the tag, including the "type". Once

s/parset he/parse the/

> we've figured out the type and the tagged object ID, we call one of the
> `lookup_${type}()` functions for whatever type we have found. There is
> two possible outcomes in the successful case:
>
>[snip]
