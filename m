Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB81184549
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338494; cv=none; b=k8/ttT4n4Elgn9H0Ohn3LS08Rf0zl7nqdI2pzgtV2fZB056WLV+V05LjGqG+kEC9t/wppXISFMuUAkz9LkvLdJkMdnTbKHWyQHMWpFX+XPhlj4XqHP/HQrkaYtpGVDCGkCOwqrAouzKqh9Qskh1ZEwhSAlKv8xmDdWPZXzmXLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338494; c=relaxed/simple;
	bh=DJHY0BnjWrUD8DfJeaNWGn/rM7KBxBK9G0gL1HZH0k4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GgPmzT1dwg1Cp0QXj7ME580zOYwvG0UGsla6nnVInzWCr9Oh0xRTDgyAbB/KbK8TlwhLbWlCZqYBY8RMF8teOKebhATDuCfTdkQXAUtvoAiFLjl6+dzW8suapDp3vCYB1CN3P8juEyCcgYCYLjNgfMjTIXT14x+D0dXqv9Z/Ebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=huKWktZm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RTq5KBAj; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="huKWktZm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RTq5KBAj"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE07A11400AC;
	Mon,  7 Oct 2024 18:01:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 07 Oct 2024 18:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728338491; x=1728424891; bh=bXzIDNdPP4
	6X8qbez38k3JxZYLi3ea99ycVHcQhriF0=; b=huKWktZmbifpWKDtCNaNFOyUpB
	CYVpqHBokB/7mrNKsS+gxv2hIaKpY9OlBw2A/KQRSkNtqMcb/T83Hvi/fkoFre/T
	U92CklyTOn0ZaHSeaSAutkxBiA3/5GiAAQS5o5rKFRjZoZvzBUUrLeDVjsVlxFUy
	A2BnoJtI+CmDW003F1+xMCD9F6UPqdhEjD5xV8Lu73z5hnHUlxKcxSOOGvi1v4/B
	gp69U+zGBK3REvofnUOzpJbKScyRatpWwcWAFD4yaSRxJLqIAY20e/CoK7hACyZY
	axlFJN0UNoAWazeuyD+B/KmR97YNT/8XiPmQygeBhoNN0AfSCf/K2AtOiM6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728338491; x=1728424891; bh=bXzIDNdPP46X8qbez38k3JxZYLi3
	ea99ycVHcQhriF0=; b=RTq5KBAjsBqj6gx6thLvsESwo8LvMEu7OhaZyUZGgECm
	Vf6CDfpTiHxBT4s57LJSMcPTBn8st9BRqQB3lpLXq5IQktB8DQY1RNTq99E9Dgq4
	iHv5AlQXVQtsmoaK6jXL6cN9Txz0nNjo8vZvcAemGx7Rib8eceI2n/LIgegvuzmM
	6YhxP5SjQkoiBBYQaMCcKgGtAdIx/iravGLNf7LZv91FpdN+UjDJEt0NQXpUZbwL
	fKNhAleh9L6EqzAXTHP3Gu34Dd/CegAFj+KBynF8Twpdfp0kxftQf5sDusIVnJhA
	T3ZrM8AgUrW8w4NksnOBAGRif9xus1yu+itTBgTB1A==
X-ME-Sender: <xms:O1oEZ0yFVl6dwK6e7_N0Zefsd2pm9BgCeDS9cqfreucFIURpTzluRQ>
    <xme:O1oEZ4Qln_hrMfz7yn0V05ysY_UpaASNQnc8rsGYU9FRAlZy4yue6RPRxpaNmX1Zf
    T3fCxK2aM9EKWN7ng>
X-ME-Received: <xmr:O1oEZ2Xph9xzrFk8KjrafOFYRoswE-YgvI-qGHtBO2sW_J-FlMdg5Zpia5tz3L51mc51o7Z9DPWZ8TxECnNvDbL26plnuOUSyVCwwS8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeftddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:O1oEZyiKjgW_hsONRcHaHKQ7r7-lU6rNlGRZWd5MP4o5c-2aKxO5-A>
    <xmx:O1oEZ2CH9LY_ggdAe9PQquEe7uiH_bBRgsg4qtKtZDKPT5QnLWGDmA>
    <xmx:O1oEZzKAJCXi1tudfmcmPvycGBsNPdOQFL_iKNS0VeqyekJcQWsffw>
    <xmx:O1oEZ9ASbZiV6OIDZZKXRLREUI2F7zBdA8SZ-PVv7pyPLkpxOPlltQ>
    <xmx:O1oEZ58rwKFH7EF34PTi-Q-Cj00ESgw6_mYCuIpSXVTOcvrTR12lIzEt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 18:01:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH 2/3] object-name: don't allow @ as a branch name
In-Reply-To: <b88c2430f88b641d69e5f161d3a18cce113a81c9.1728331771.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Mon, 7 Oct 2024 22:15:18 +0200")
References: <cover.1728331771.git.code@khaugsbakk.name>
	<b88c2430f88b641d69e5f161d3a18cce113a81c9.1728331771.git.code@khaugsbakk.name>
Date: Mon, 07 Oct 2024 15:01:29 -0700
Message-ID: <xmqqy12z7eti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> `HEAD` is an invalid branch name.[1]  But the `@` synonym is allowed.
> This is just as inconvenient since commands like `git checkout @` will,
> quite sensibly, do `git checkout HEAD` instead of checking out that
> branch; in turn there is no practical reason to use this as a branch
> name since you cannot even check out the branch itself (only check out
> the commit which `refs/heads/@` points to).

I am not sure this is sensible at all, after all these years.

I suspect that it is much more productive to deprecate and remove
"@" that is a built-in synomym for HEAD (but "refs/remotes/origin/@"
does not act as a synonym for "refs/remotes/origin/HEAD").  Having
two ways to call the same thing merely adds to confusion in this
case, unlike "HEAD" referring to 'master' (when 'master' is checked
out), which is also to have two ways to call the same thing, but
adds a true convenience.

Those who really want to use @ can do something like

	$ echo "ref: HEAD" >.git/@

or something, perhaps.
