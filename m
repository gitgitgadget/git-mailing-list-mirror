Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611721E5710
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858167; cv=none; b=j6grEcRHlQFvsItTFpGF1Dd3TAwEchA4E1W9vuClz3CwQ+smVxDVjon8mS5NnUGrVu3TKrP3rvJUwc7YeMm05RNhSAwFhfbeNg076+fONz9hmTEe4q7lrN9/EG0RZmmh6YWkxSFFE0qWbmybYpToVzDIfg7QYh15/nf7x9uiFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858167; c=relaxed/simple;
	bh=BJHCbzivGCB3GKyMxHnNndWzkuXA6MkYTJLtgGeENDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dcL18lmgR7AFOnNQY5Nfb4wcFTZBlWPYSymghJ3jSuoMXwj8jr1tfGnP8oh4fjAEQRqPyR/ZsDXRjO5tdOga0muZMcY1EoxcaooU3y7RFaDm3vfrzj+Q+miA8zbn20c3nKwS/IJgpxr0UJzy/NQSgLsuCfFOwjmUYcO4YlXYNhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MYqG49pH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=knqbGWI/; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MYqG49pH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="knqbGWI/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B0B851D001A1;
	Tue,  7 Oct 2025 13:29:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 07 Oct 2025 13:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759858164; x=1759944564; bh=QlJ4kNn6u2
	cpx9CWILbSuezMufHYidCgPlqmtqvSykA=; b=MYqG49pHpbYW6dewKQJqd3Dxye
	IGBIQGl++1kmE1Qk/WkgWDOPUicDvZIGe7M6UjzHtqPY12q9yvORuJ/J3huH8sEf
	WoZXYdS/x/8XBECsIp7k3hOK/uByKUcqxm8eEgba0BskFPqbXsGvyOCEh6VNC2Zc
	X9mBLDtfvY4elH67I/1tr3FklaQtquVsDqSCk7J/ZPI5cvsMw8Hs/BefUZYWDOO5
	d1NCUwfIsWLXdUZd+DjicGVbAQdx54Ox0ipDYpUBU/cFzv40q+veBcNlkthnXwTm
	+7cjxFJ+d0TZGRWap9Hx9jytQIADOA13jRuuP5y5B1ODm8EGoYg/oDI7WMVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759858164; x=1759944564; bh=QlJ4kNn6u2cpx9CWILbSuezMufHYidCgPlq
	mtqvSykA=; b=knqbGWI/Pl3FWn/w9gztdFAuyzLk53qHeLq0TnQuQYrBIG/zfiL
	CBTVznV48GVCcMYtqp5Os7jDJ66w54uA1C62YojrHpTz26Plv9Z4995QHaHAHWui
	taoL4mtcClKnxnv1wW32mqCC3eAxRrPQSOUXuooqUWVqGJ/VNaeUua0BojMQA06e
	h8IB4FDfUUJ4JTDszA0dK4bdibjcJFmnuDA2n75Sjl7n6C87bis/SecJJOgn/uv7
	/zNvwpLD0e8dYAHO9BHGzz+LFqSbJgJYHRd2wjBM3Ri8NSThDuZ0NhHjh0r2arik
	oGF7+EnZ+l+TIaavhDf0w0vM5zRFDMCDcxg==
X-ME-Sender: <xms:9E3laKaSkG4GNOVqzSlkZzoxtYtmCx-rlMoZO__YfiOGd-hnQ2FW4g>
    <xme:9E3laEZVhn95z4zDl-wOtA1L4X66gAEbmmIrT6TKarXzbAXN8J6_FMFm426D1zcHx
    kmHEWrj5MwibFeSrGl16rgynOap5acwKywflLJ-gqjcYc-xo8JhQg>
X-ME-Received: <xmr:9E3laJ9AQbtH0EpjXPzy7fnrh1h7rLmOObUdNEr_ZE4ThEcd0Xtj9mAsuXhBlnH8M6aTcO28TxR4QvcaMb98AYLtI26HcNtCD407>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddutddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhnrght
    hhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9E3laLhri6hKYLDNN_onZx8fhtFsqGkQnUnp16SwIFyMhOZZ6VNzbg>
    <xmx:9E3laBdjBZEMXVIrvKTk_AabhWoSgwa_YiXEAnzcB4b5dic9IfrfYg>
    <xmx:9E3laKooHDCe6OMb7rvA58mVkTF6ekoBgme7LQIzijqY2QY4ZdnxUw>
    <xmx:9E3laOAfKTnhdp1tgEu5bxvEegQ0d6fTR2FyU9VIgZU0pTsHjIPeFA>
    <xmx:9E3laCi9M51Bw424q5sOv4laXkzrEYxlK4uxK-18F2BY9J-ILiL8SdcF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 13:29:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  jonathantanmy@fastmail.com
Subject: Re: [PATCH] mailmap: change primary address for Jonathan Tan
In-Reply-To: <20251007171145.573858-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Tue, 7 Oct 2025 10:11:44 -0700")
References: <20251007171145.573858-1-jonathantanmy@google.com>
Date: Tue, 07 Oct 2025 10:29:23 -0700
Message-ID: <xmqqfrbuk4cs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> I will be leaving Google soon and will no longer have access to the
> google.com address.
> ---

Oh, sorry to hear that.  Will you still be around Git circle, I hope?

>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index afa21abbaa..7b3198171f 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -126,6 +126,7 @@ Jon Loeliger <jdl@jdl.com> <jdl@freescale.org>
>  Jon Seymour <jon.seymour@gmail.com> <jon@blackcubes.dyndns.org>
>  Jonathan Nieder <jrnieder@gmail.com> <jrnieder@uchicago.edu>
>  Jonathan del Strother <jon.delStrother@bestbefore.tv> <maillist@steelskies.com>
> +Jonathan Tan <jonathantanmy@fastmail.com> <jonathantanmy@google.com>
>  Josh Triplett <josh@joshtriplett.org> <josh@freedesktop.org>
>  Josh Triplett <josh@joshtriplett.org> <josht@us.ibm.com>
>  Julian Phillips <julian@quantumfyre.co.uk> <jp3@quantumfyre.co.uk>
