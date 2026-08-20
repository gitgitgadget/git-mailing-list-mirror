Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A83343D85
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236712; cv=none; b=ZTR7haBDYb9lC/zSmGCiBpKD6dY1mh4b71wWeS08NXzMmq7fuB7uciSFHjqsM/ZNpt5CGqIlVxXhFhqvZ0JNd9a8eD3FjuKuRFY7/Z5NmhcgmMhQVykJTNHDM3eQDIxLfr4E8ytpN0ZWOwd1Y0pYTBfMmV3MYiDTseoTfA6uBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236712; c=relaxed/simple;
	bh=RIFH/heiAp6hnFQxaL0osCRSwQmZw1ZQgrKU5vZnrbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kqfP8a6whB9rl5YwMM0Pwxu2njAQmdOCoOtWo1EYfBQszHhkXvZTmH5yqCbvpnA1KSP7qFj4WW4Urb79Z4/AmbsHiqZmbjwDG+1CBA3YiFkPzDvOptDQWLaqCAMhAMRFyxaJtQYJjN6jSQJEAuYn5SND6Xu9stgbgfCQaZ6u5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f+S+XWld; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NzlQ75k8; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f+S+XWld";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NzlQ75k8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F9A31D0007F;
	Thu, 20 Aug 2026 10:38:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 20 Aug 2026 10:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787236709;
	 x=1787323109; bh=RIFH/heiAp6hnFQxaL0osCRSwQmZw1ZQgrKU5vZnrbE=; b=
	f+S+XWldcWXsDsbkY3WtZ2ryN4AruKOsveqzJyg28imQIsz3w2Hvse7PA9KtX9qT
	TwqseSS9qgqKk17KfS+3W4ZVnValWK0XSxZ2UhyTnDDrWyt3CEUWQSCZb+f5o9jw
	Mdiii7UPTFUu6Rv5slP4g8Wag6Jc1qi2VUpvETYnilQqUlI/dTMB/L0HofrfimxN
	ACRX/Ms2h7q4yIMLKcIrXx4Zqc6nuGVIiwImckqmw/4AsbFEp8Uz8MzkIX9kE+yu
	LSyEwOY476OHIaiwk2kLM78gR/7XqE1fDCzXfEY/k/pyKLBzzyLKGS5Vs1tjAoCn
	d8V2TFGPeUOdtt7efhExiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787236709; x=
	1787323109; bh=RIFH/heiAp6hnFQxaL0osCRSwQmZw1ZQgrKU5vZnrbE=; b=N
	zlQ75k8Q79XaljNeIAsf9vXuGkRaLPbnweIJfelokK/8VPs4TDOyc+9y7eNjSNPP
	ItnBlb5HPMR1ilhVyql2LbR9v9IijjesZQDYsB1ORXp9e56h4zt7rAPsi9UpW4HV
	lbMyUNae1wrmLAK4BUPeXHBiL8PrYdvliECZQx5COGWk4Icel/uGh0IxGFF4j9zR
	KavP/xGauVRUkDUlAdAyOkWltDImX+DiD9JgvxryVwTzqJ06Z1gQlsUHjbr6TKvn
	6t9YJfu3Tqfw2ml9jiRsXICiP21RJZv9D4FRPK4e3bfgz3nOz+OEQr63iP7SaqLN
	3WU9UEFgGB/ToE2FD8l0A==
X-ME-Sender: <xms:ZRGHahShyTtpA5V-pKF1btoZc8VVZ0rQQ-eG78-jCVRjuG_JUhRHrg>
    <xme:ZRGHahp0Lo1HYYVCgcSYeHmUPuZv-1edrM9OOd_5-g7BxvbiydiylIiqR_gohTOVE
    s_VewMeW7zvt7Q4YnNfLOJ2YFQPnykbz9ILOkTLfPR4PwtPs6AnnPg>
X-ME-Received: <xmr:ZRGHavJdIRDClJlOrOTa07K66tfnviFhNk9KEVa6l4xMNAKm8HbgtvcLXsjxlgJGWHnI0SUrVL05Z8KPiaUWuBncaKllo-Nftw>
X-ME-Proxy-Cause: dmFkZTFlOXUSgVCqXBvybWZP4H1StK/slLTwk/1hxkSPjhbUBD4TKfOao+NVUBCmWG22AR
    Y7qC/RptP5Zuk9jS4gIphHRklyK6nURMfKe4dK0NwduqUEWu2c59eaVqIkqFS6yfxaZlhq
    Uw/D3J6P3ULUAYHxy4tL5HJmTS+cZ+/xe4gCGR9Uukno+w/PDe+uKHM33cVCnWglUIt3Ic
    fFizlpQIROPJU6UcgicifvTGhoPsH0ACEX1p/n+g9KikmNsaOO+jyW7sgw0Xiw290R/dcw
    il3XqYi3EhqwWoROaOBHpnH9Hvp44QlJrtbPpUNx0hLmvCOBaOI7ss0TrUdBdpD0xXJae1
    pUFnQwvGBppfC4B1hVkRRwtkyQpJ2o//0lLnIqgHxLpepv8dkYFi3ry+PGnN4ykF/bNYU3
    qOCT1fJi32+gCNEzI4gVu5Z3ifKJUg6OiHA4Qz7UGMPT8pHNJx71C5iD5kCTyyBUA5wikq
    GxcvG6PD8ZGHYvwtTIYNOjfUs11djx2XLIqSJjy1yMGDBap/WVk9ZLXTWeBXoVS2RlcEWX
    +fcgMym+XmwjUdluoFN4UvyfgsWNaJZfbLnDGGbdBDh7cz2dB79uaFgRWwaTq+7yKXQpli
    s6zua4zEi1WPcbQLkFzwk0yHUBBMcPBMMFO27YJTLqORFg9QZ+Wgvttyd7yQ
X-ME-Proxy: <xmx:ZRGHakqWVdUsfDJeHHfQC93yIidsmwVfznME24Q0jQRPxU-GFyfkjQ>
    <xmx:ZRGHanw2xac5ta1OzENxt1rwYZkBIcbndXjtQe0GugxRnFlD0XANrQ>
    <xmx:ZRGHaoP0N2SfiPqfTZ3ReKBPGuFNw0bqoJ1ToIh0sd8dVVThENPwqw>
    <xmx:ZRGHas4VfkoKNd6mWnBXEJxsZEyUuYQu6UWP0B5nMZR0h4cPUvKKZg>
    <xmx:ZRGHatQzpvVQM8Oe8xTHVYJ-QKofJDw4uLYjPnyPHLkAdcmNO8rYXVdo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 10:38:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH] trailers: stop recognizing URLs as trailers
In-Reply-To: <URLs_not_trailers.b13@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Sun, 2 Aug 2026
	21:57:17 +0200")
References: <20260609004340.GF358144@coredump.intra.peff.net>
	<URLs_not_trailers.b13@msgid.xyz>
Date: Thu, 20 Aug 2026 07:38:27 -0700
Message-ID: <xmqqcxvcuaak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> An HTTPS URL starts with an alphanumeric scheme followed by a colon.
> That means that they will be recognized as trailers in a trailer block.
> That turns out to be a problem in practice. Let’s stop recognizing these
> as trailers by failing the trailer parsing when we:
> ...
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

This has been on hold waiting for the base topic to settle, but now
that the base topic has graduated, the effort can be rebooted.

Can somebody summarize the outstanding issues on this topic (if
any)?

Thanks.
