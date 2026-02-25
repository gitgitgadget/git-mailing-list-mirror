Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB672236F0
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771987592; cv=none; b=I7vFrJPSJaak8TKAmE8OGtsNFC50MpTBT5o8qHD87gXgxLLiTPbYm9rOKDncrwTUlZ02LQotpyMikDtAXWS11izOwc5zCj6SJvgKBCSwU0SVj8yVw/FGnZ3rabAot9DuLmwAsz9Xbdr4q5u+sJQUjlnNZ6MVaa+6wDW14FZHz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771987592; c=relaxed/simple;
	bh=ycfNhX1dF6V10u190xsDr7ArJ7BcX7WsiHn6SFFgsMM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cHtUQEH+bNT8irvRfNLc6Y9W+ASf2l/qnuhx/F+8hwt8KTHdnhEcSk4/XcpDBfypF407nlU32rc/FOmPwloZ5QjC2keKny9HDgDFhtctN0V3BpgoLKnVBvbWyLOi5MncAoYsdiUaXRud4QpH+y4Eg0T8LRlY+IoM6nK+XDMh6oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A+BQhBpH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ttgIGl/R; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A+BQhBpH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ttgIGl/R"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 034DAEC05AF;
	Tue, 24 Feb 2026 21:46:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 24 Feb 2026 21:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771987590; x=1772073990; bh=ycfNhX1dF6
	V10u190xsDr7ArJ7BcX7WsiHn6SFFgsMM=; b=A+BQhBpHaurQ9xTIQr0NlsZdq4
	DQXfYqdsRc+ZyHy2jzj46rfNMdesLAdPqzV2fAxK1+KHEDLDrOm+nfujpODvwalu
	ZBkHQkNCraKBnD/0rKZBdiLp1lhDwTsWzrHqYC2rKJKm88gDm2+AnxDdb0IT3ODF
	crUFK706PrJYFJfAMQVeDJfXbRKJNQF1aJEblHSugaqW4R6PFVkaTdo7YE9X0IGM
	YwNkrhE35EfZo5DPFcMVDYRQJTNINcRHUQitdKRZTCVmef0/xg5xTTOc2qQNB06P
	/IQNIVNaxwjDoRqRlPa0C6OyBaFy4vORqUflnpJzlGLbNqxQBwpxs0k88x5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771987590; x=1772073990; bh=ycfNhX1dF6V10u190xsDr7ArJ7BcX7WsiHn
	6SFFgsMM=; b=ttgIGl/RtRzGh/3vK1ed+ALU6WnLL0obJaXkUUnA4zVDV26w/0A
	H3ZTl/L1kMKwQqjcvzYsdY1JLbiuVywl/tsNoVV0wrACRCAVfQ4bVEhdv0VG3a3+
	mLdUtXQNrZkCu5dQ1NpLLToOcVZAS4znDFvTd2hfCYxoeupAU8Cw2md/0VlaBtE3
	lW5gD+fox4eRI/rlfDQB7OHZHqRm23bIAd5Fg+udmfaw/XmMmmnR78X9x0T3H93I
	LrHh9IedSXjrtnQCsBJ1hBT4GX3NO93nXmUuQM1McZQ+pIC/wy4WeNOQeBZt5W6c
	vx2zFXYxyNfFLWfdOGT36GzWAabLBwkZ3fQ==
X-ME-Sender: <xms:hmKeaVjRRUsp5YxFJgMHQSGumBIsxNE01sKXcou-iMENjNi5hDcYkA>
    <xme:hmKeaRDzHXcFGLozFk98ooHVZaCV5mAeBxxWc0y1Htrbv6EVIgQmp5YRnm1hykQoX
    t9Jq984_DH3RhkjHO_HOjXf1cwT244tiFKWl152JOUM17sQULlMzQ>
X-ME-Received: <xmr:hmKeaaHrygDzq83fH9Q_QjmAzPTTyB8puH_TbOKuTSGwLnhNwgZjWfiHgMxuH2m8pn0v7e1IEIP2Rh8SBl27X5td9A0R6n5NyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hmKeaZIHpVXn6XIe0uDhBWT_jn8yUPCevNVV_sc0q_STy2_QjKbvKA>
    <xmx:hmKeaema6v_QFeIkeumYU4j8eX23U3xss2Tm-lbwweMaqpVQVqLadQ>
    <xmx:hmKeaRSZc-mbgs5HxsgZvBFEQsoBvN895GKnd-0jbAx6SeNA5w7TxA>
    <xmx:hmKeaQI5G0AdA_d6GuDZ4KFqtlKLqUg_hk9uYAKT1IZVjR8wAHdYVg>
    <xmx:hmKeaancto36Ot7ZayJ00Lt4JB_DrQllJFwPuazgfP3nIfDXG4FQy2Ds>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 21:46:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] format-patch: add cover-letter-format option
In-Reply-To: <aZ4-_jmFS8yS4g49@exploit> (Mirko Faina's message of "Wed, 25 Feb
	2026 01:19:31 +0100")
References: <20260224040400.751247-1-mroik@delayed.space>
	<cover.1771925291.git.mroik@delayed.space>
	<xmqqjyw1g9m5.fsf@gitster.g> <xmqq1pi9g6sb.fsf@gitster.g>
	<aZ4-_jmFS8yS4g49@exploit>
Date: Tue, 24 Feb 2026 18:46:29 -0800
Message-ID: <xmqqcy1tczga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Didn't notice the test failing, I only ran *format-patch* tests.
> Thinking about it more carefully there are other related tests that
> could fail due to the nature of format-patch being used in preparation
> for other commands.
>
> Will run all tests next time.

Yeah, it often is simpler and with less effort to just run all of
them, as one can never know what fallouts a particular change will
have in unexpected areas.

Thanks.
