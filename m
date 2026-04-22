Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21A53CF68B
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856567; cv=none; b=AqeBwuRTL81BnoyNrJFlB9k3HgIeUB2SL5oaxQHZ/3HqAt1Qs+eakicszYIjCpr19+dA7cY1yHEnLZTs/vm09FgwGBgYfYcbrzx+ih/V6XipnYxbDAKdK1qtjJ2i/rO3W0DOWMYIrhifRvlC2Rg7aY9TkQavyXEc6ooO6zu2D5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856567; c=relaxed/simple;
	bh=2DhsN9GKcTGlZ3scwZ6B6foKk0LH+C2vJqkAgOnWQsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbKj3M5Kh3Iq7CFURTDCkj7hNZTJZA3K0Ymgh2uITelf9MLh3q72ro1QVb0xrEQjAfrJA/ZUNTvQbp5QB264oaYu30aIQbeQNWgkyXm8Fg02PRuWPKCNhM2GsRtSToXm/Jb8YWKfpiPebv6AbqlZ9CXvbkHOkHQPcNXk41iG6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sslPdIcu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bxCTkbRR; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sslPdIcu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bxCTkbRR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 822C47A0038;
	Wed, 22 Apr 2026 07:16:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 22 Apr 2026 07:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776856562; x=1776942962; bh=OoYpL1e++g
	+BU3sGsXb5PLRZir8FlqQltegf9lxTexo=; b=sslPdIculuQ3f0pFPfqwDyRcko
	De9RlRQ7V2l/cRsByceRBU20kLHqgdqo4Qz0YMqSX23W/ENetJmDinCqp6yzVq5K
	f6TibFw5rZF6gi5Eg/JToRqMMAEJfpnxBfyYYHrLPuTE5KA4XN3PBhmqb8BtpgnA
	lCNhcxNC0gWbsxcokIk7He+DiXYYDoVgL1WClmTZrMLttrUumQ+g/D4SBjb71GWf
	eQIBS0aW1Vijz3acbVLOZsyR7M9ySgM1mEKDAoKWpXunkvRkgqKg8T2k6Jwk9AjV
	g3yVISlN+GbcUAe6cxie4BM5Oji8c7lOC6dqp/f8oeFkNnH5DKRt6j+y20Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776856562; x=1776942962; bh=OoYpL1e++g+BU3sGsXb5PLRZir8FlqQlteg
	f9lxTexo=; b=bxCTkbRR7KlEi7UyVukfOiMnV5/8b4JRK6w0XXkSHvz9Wqh+05p
	uQ7m8OK8MXPAaKpV2h8Qvo/lpdi6F5wTII8tIHD4ADqiKl0Fz/zmvacmkIT1Xsmn
	wvLr+Dc13sgvd4W9GJLt+EteEast4PaQQMlqy2i2hBmT/X9bKTWKM7MS7y7OnS1P
	WWJFYSyVqsZHZFFq/vSnq8OE3OOHEfGiPpzwAXDKGJbeLAuplfFClYAZTXcBcy4l
	KY2hbRp9Wsaxz05tTjCdXn/gDbAd2MxV4gG4wjqAQVMD8WcGpuux15yv5NQzAjf2
	YxLBXTBFOjrFWMIpdrvPQ78KFhh2gPoqGAQ==
X-ME-Sender: <xms:8q3oaWx3RTlPaqno7mi5XdYqEryXhW8xFOUO5-Jh9APAXBvFLpC1uQ>
    <xme:8q3oaYSAAmQFCL5NeuKz_K51uULEhIVw6mEtrltzS6kfGpBlUz7E7HRkAitP6hBpw
    wC3B1bDwmao6YrsMOvkJHeLH-z-IDmaQdXu6yoiP6IlK2qOuMBnOK4>
X-ME-Received: <xmr:8q3oaV9GgPq6O13NHNb4HXA5Z8n7PK8IcChoIyXk3L_JzMmpPFJ5G0RH6XMCRv2xY2b-QGNS1o4w5ZPu2oG0yxi94Npd19cQ4IhQ1KHbfLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8q3oaXqZRVEjfgpi_82iSrMswAVOQu73piMyrnKF8HMs6ck6e_uinw>
    <xmx:8q3oaalyxFRYrVL_FE9j-6_bTr25gg67EXHesdX9lL04tU58BkzBhg>
    <xmx:8q3oaWKTDHYDPyk_FoaH1NYyF8BWRlIeMNp5a2Vuh6vbVSGXZ14nyg>
    <xmx:8q3oaXx_sUUPGTa3ihP1XjsVve-i0Z8aX7cUueljV0covf4EMP33oA>
    <xmx:8q3oaSgJIStPVYDm25ATE0nEka_t2APKU3BgwKugbIp95nEpl1r0rLOq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 07:16:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d0e7a460 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 11:16:00 +0000 (UTC)
Date: Wed, 22 Apr 2026 13:15:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] refs: move object parsing to the generic layer
Message-ID: <aeit7X0Q_MlxvPas@pks.im>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
 <20260420-refs-move-to-generic-layer-v1-6-513e354f376b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-6-513e354f376b@gmail.com>

On Mon, Apr 20, 2026 at 12:12:04PM +0200, Karthik Nayak wrote:
> Regular reference updates made via reference transactions validate that
> the provided object ID exists in the object database, this is done by

s/this/which/

> calling 'parse_object()'. This check is done independently by the
> backends.

..., which leads to duplicated logic.

> Let's move this to the generic layer, ensuring the backends only have to
> care about reference storage and not about validation of the object IDs.
> With this also remove the 'REF_TRANSACTION_ERROR_INVALID_NEW_VALUE'
> error type as its no longer used.
> 
> Since we don't iterate over individual references in
> `ref_transaction_prepare()`, we add this check to
> `ref_transaction_update()`. This means that the validation is done as
> soon as an update is queued, without needing to prepare the
> transaction. It can be argued that this is more ideal, since this
> validation has no dependency on the reference transaction being
> prepared.
> 
> It must be noted that the change in behavior means that this error
> cannot be ignored even with usage of batched updates, since this happens
> when the update is being added to the transaction. But since the caller
> gets specific error codes, they can either abort the transaction or
> continue adding other updates to the transaction.

Right, this is what the preceding commits have allowed us to do.

I think this is a good step. Being less entangled with the object
database in the ref backends is a good thing.

Patrick
