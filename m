Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0712046A3
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602828; cv=none; b=YRg4ZK+tXO1V2qE+cGbPa1UMbfb5MbRWr4qpgJuh1cgyt9AqpWmYj6Pbxj1ncOJESqWK7dcErbyN17ganXOZUjFTl57LlHsYaIXWdJE+zDz9B+AiNPXyG6qEfVXMXnTfR20JWQXsI8+xBvei8lkv0CTDLkVOTz+BR/Mlt3zHmxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602828; c=relaxed/simple;
	bh=bJ7/QWaSACfRZ/pjbU668LihlK7DJwCOkmzDhBogXzk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AD7j6CjLOOJ44UJBGHoXqdMuCJW9s8M9G+rQo2L62bU/jdSdanGz40kR7OoDJnp+LpgWV3xgfX5jtZLjaNVpRn0Ul0s612QTfgKDDyW44eoc4SdWzKubtI1AxdBmDtYAEUUKXGtwc1ceAMRYGhNomoazM5oA/zRvTb5wY+hXKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P5t+kOTl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V3NWPxHW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P5t+kOTl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V3NWPxHW"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D594A13801E6;
	Mon,  3 Feb 2025 12:13:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 03 Feb 2025 12:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738602824; x=1738689224; bh=ixTyuObR/R
	lvYMh/V9VNwQZZRfagoEc7yKsnqAAvKqs=; b=P5t+kOTlFcgJBYxpXhPQ3XV6rD
	pIYdyP7vCi6kWxbpbEkwd1hS+9zHQotpxtO1EDuE2IK2F8EWvXRpiIC5b/AeLwGU
	A49SUNA6p/d4fC5OYQe6PhSBN5NxdaBfLD0uui5uBf+RWmswT1xiApjYkkKYGpZr
	3CbiK4idLAd4wPEkk0DSvxx/Rh55gE+ffgYk836Lt6nNW2rp6HOVqx20bHLTxfRq
	3cRwuH8S2Xwr7xI9FPKPrIe2p8ysT8u/qyTiWwQJBzunTHTHhVis2x56eAHGXic2
	+W2rM/5u0sNRoyTjqp8J7fZZEdhZBaz0clD1iKWO0trAXcHyCk1YOYCa8Zdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738602824; x=1738689224; bh=ixTyuObR/RlvYMh/V9VNwQZZRfagoEc7yKs
	nqAAvKqs=; b=V3NWPxHWIGUUAhNPPlmmBQNaBFmnljItvWh23BYnDHb8mMVjcEv
	JlPNmoOX3q/fXXob6QySftDC1Vbinbl5M1Qdnd5RmN1h2tQVU2JzHLwQaK/c7hga
	H7yfeBOt4Kkv2EXEG3XfBcbplOBml99xLYvTykDRAsCTFP0T/rMHneIrpuCaUDUe
	thgI/yb1DwopZT2uZ20Pag92HctfjCFTkoSbhYdq2XVNg7+xS0EMYXd6kc1e289a
	WULAfOXRaWiKh+GKfDWipVRHTnLkaGJAEkw287h4RGR3C3yOy9vdyLB4jzeuIcfU
	SieF8YrbJ/Rg74nrm/IqxSmRUn8SKUxWmZA==
X-ME-Sender: <xms:SPmgZ7_eaWY4QY_jKu9Xlr8JQdtV4oDKl_QVOZIIUjkz9qMG_NGF_Q>
    <xme:SPmgZ3uNPfuHIGUltw9ykFo7S-mAuZ3jX1aI6U0BxbxKCOeIYpTZ1i_y7Y5bD0gV3
    4oE0tLYKO_w1j1gaw>
X-ME-Received: <xmr:SPmgZ5AXFlXmquoWGe6Zd3vYoJqJYst5K8ckp6RFwvle4CMa7Hs1_XtWER_7LL7F1jpaBMFT749Bfx9hTbeEGLbPpYPtdhF0K5Rz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SPmgZ3fUNvEegF4Ar3iHg0h0jpVeOUTvU0QbJi7In8Awxzhe6LiU5Q>
    <xmx:SPmgZwMlM0OcFuCopafRGIfMfpaYjnd38mDNxXBRQ7YXCGabde1amw>
    <xmx:SPmgZ5kQsslLZ1XmupOWSr_GEh72EJw0Gisb0WCIYvWqDRpB4Alqhw>
    <xmx:SPmgZ6sYZEly6x2zIWzL-0ePdjcJw8ILWVuwl-iwpkYZp2m0ZA5X-A>
    <xmx:SPmgZ1qQCOs5yhHXZKHaWAAWCmwbPT1BtyD_Y_KImjrtCJN0wg7VkZNc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 12:13:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] t7700: add tests for `--keep-unreachable`
In-Reply-To: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-1-7c4d69c5072c@pks.im>
	(Patrick Steinhardt's message of "Mon, 03 Feb 2025 14:06:54 +0100")
References: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
	<20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-1-7c4d69c5072c@pks.im>
Date: Mon, 03 Feb 2025 09:13:42 -0800
Message-ID: <xmqqy0yn0x4p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +expect_object_count () {
> +	find .git/objects \( -type d \( -name pack -o -name info \) -prune \) -o -type f -print >objects &&
> +	test_line_count = "$1" objects
> +}

So this is counting "loose" objects.  Do we want to have "loose"
somewhere in its name?

> +expect_object_in_idx () {
> +	git verify-pack -v "$1" >objects &&
> +	test_grep "^$2" objects
> +}

And this one checks if an object exists in a given pack in somewhat
an expensive way.  It can take either .idx or .pack but the name
makes the caller assume it should be called with .idx, which is OK.

Would it achieve the same effect and be faster to do something like

	git show-index <"$1" >objects &&
	test_grep "^[0-9]* $2 (" objects

instead?

Thanks.
