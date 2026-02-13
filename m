Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041C3BBF0
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770981975; cv=none; b=AFTgnR7PFSA8iUQ0bzowzUOk1DkhK3u4NX7NzU2GNz0gyvPUaN6vwT9R4jfQJolfVclXZIoAj5bhbk2HX7jyMGY95vB8jPTM/D4+2DbliDV2Cupjb5K3NCOT7FHV9kwKubA5kD5aGxkPHJaMuXaQXVKsXcL986b07afvV40FJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770981975; c=relaxed/simple;
	bh=hzNFfmxJ1+HSEwm6rsEYFLry+ZUMQIDKIzNh56Co0nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFc9OAs/h/EGxuQShdvJpNbs902qibm/zddO6CbeyULpabOViNBMM9yizADdleSN22+njcLPpJuXDBpGN/aZxgaJDVXyFISziHZxbVZ0A3gqlg9Zjx0cFbDU2o9JnQckQOv3IYVYgDEKWMaWNjNcBi0AgfiDCL10ApScnov5Lhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dxM3rOje; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TXclJzFa; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dxM3rOje";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TXclJzFa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 90854EC055C;
	Fri, 13 Feb 2026 06:26:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 13 Feb 2026 06:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770981973;
	 x=1771068373; bh=GwXjomScheIB37L5dBmCQ9x9GL1IxTpdXMbjAG+wYDs=; b=
	dxM3rOjeIt1bSL4rouau5jNxoPlz9CAWgmcmSz6NzMOix3LHeu4uHe5n3VqBb3Q7
	ZMTGEK+CLeA+zNe6m03HdC3f2vGcNWUTbHl9lEgmzJLHMBCEATWbU8YBmXQJSXFX
	0tJay6Gpbjr18LfFbk36g2YiMM+6PON6GRauoeAM4r7t0D/7WEO9xYRWS72Ya2Zv
	AZvMg3b5lr0gNpdpa5Od/xyB5xfZYDAKqp5cF2/dhs/RHT8ciSY9ARnN1U17W7Lg
	BVvOcueTErJaQIcvVvsGUemJc7rLsoExmE0KHBiQrEfFga4znbEt6vwKOwuyTcH3
	pARnQBRmplUIkawlN2NMMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770981973; x=
	1771068373; bh=GwXjomScheIB37L5dBmCQ9x9GL1IxTpdXMbjAG+wYDs=; b=T
	XclJzFaqtgQzko5Hs0whXNiIAK1JrTh93rnCRSryiCB0asMcM9VuKk0FmXpCeW6N
	I2CqytnnsS95RDIw/hklbDYT9GmYeI0HJgVgWhG1XAC1aK/kETZGq84sC0c9H1Pc
	MvH6Ny07onLZFK6bNKlSENDYVCyIKGD67eNGeJRi5fs4mvLmsYRNCmnbgCwW5tcd
	H1OIRU1nikmwYOWblS8kUZnp1vkt46veL1sRcq3s9aH3AsA37EaHp/BnuI7HD20d
	LDtIjNaAVF/nODQkSKC7GE999LP5xQMJHeO1ggI/9DrLLfQJx1lPTjYqltWWCH+N
	+rHkteM3Hla9hba1FrehQ==
X-ME-Sender: <xms:VQqPafwE8KN76Mq1nlefknKWiaQOQ-WK3QhK-qIHiExme7mTM90n7w>
    <xme:VQqPaU1jQH2RPVkOlTc5X6xZHSjNhoitdoSSNVzNbG9bGqaY_R5ZIWZNnEKDca11h
    uV_uIh-YMKl6ejYitYn_6GpeS1GQ0V8tcfEtzSynu9psZcRwOeFcg>
X-ME-Received: <xmr:VQqPafzjTA02OpzENTbrNsZDa1f9HNR-pEhctg9Z5A4a7FlelofxLhIJb0ARg4TF4AVwNTTrnUJ7eeT34DS4fs9pzrIQEfjf_QoScY_x-DgV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopegrvhhilhgrrdhjnhesghhmrghilhdrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomh
X-ME-Proxy: <xmx:VQqPabFOlrodl6pj9MQFjGUfY7dtI5RkN7VvETY-LQ53UTuohC6ZvQ>
    <xmx:VQqPaSbnK9gtE1OK3Uda371LMDcHvIYNupLtMaOFBRLCKhxp6r8NNA>
    <xmx:VQqPadDqP_vIEUe0b-i4pfQtUPisGStF7fYZh9qePGZLI8awMScnTw>
    <xmx:VQqPaanVVs300v_i4mn7NkfsgL3d-vrd98oqc9t4BDNiwAuYacNQog>
    <xmx:VQqPaRNy5pmwnyV1PiPGd-QqnEo5O9fvl46EIfKQTcSwssHsMJ8FjObc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 06:26:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f4ef1b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 11:26:12 +0000 (UTC)
Date: Fri, 13 Feb 2026 12:26:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
Subject: Re: [PATCH v3 0/9] Implement `promisor.storeFields` and
 `--filter=auto`
Message-ID: <aY8KUXRdzniPuiNu@pks.im>
References: <20260204110818.2919273-1-christian.couder@gmail.com>
 <20260212100843.883623-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260212100843.883623-1-christian.couder@gmail.com>

On Thu, Feb 12, 2026 at 11:08:31AM +0100, Christian Couder wrote:
> Changes since v2
> ================
> 
> Thanks to Patrick Steinhardt, Jean-Noël Avila and Junio Hamano for
> reviewing the previous version!
> 
> The patch series has been rebased on top of current 'master' at
> 864f55e190 (The second batch, 2026-02-09) to avoid a small conflict.
> 
> In patch 2/9, new checks have been added to the "clone with
> promisor.storeFields=partialCloneFilter" test. We now check that a
> subsequent fetch can update the configuration.
> 
> In patch 4/9, a small change has been made to the arguments of
> `backfill_tags()` in "builtin/fetch.c" to fix a conflict with 'master'.
> 
> In patch 5/9, the commit message has been improved.
> 
> In patch 7/9, `captured_filters` has been renamed `accepted_filters`.
> 
> Patch 8/9 is new. It changes the signature of
> `promisor_remote_reply()` and allows this function to not assemble a
> reply string if this is not needed by the caller.
> 
> Patch 9/9, has a number of small changes in "fetch-pack.c":
> 
>   - The call to `promisor_remote_reply()` is simplified a bit as it
>     doesn't require a reply string to be assembled.
> 
>   - A comment has been reworded for clarity.
> 
>   - The call to `gently_parse_list_objects_filter()` and the check to
>     error out in case it fails have been simplified.

All of these changes look good to me, thanks!

Patrick
