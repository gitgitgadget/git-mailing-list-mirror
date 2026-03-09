Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E891465B4
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773015994; cv=none; b=kiZuAT2ZUXmu7SvFXduXW6CqJadoFt6ZO31ZNFl6hqxTkPujIvTuhm+emOCscLAnLBO+jI0pQZSQSZ5SLWAjWh9VAcpH29Su5D1gGti6vqbaKg0rh0jYoPcAT6uyGYXG4rBoz6vvg08oRGIsYduXU2RPyOU5rZlprMtJ891fU8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773015994; c=relaxed/simple;
	bh=asnpgS9vLytxoQ2zCJ6zu/CgnWB+1Z8a0vtfQfewmr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DMr4OtS8oKascGkarynJm4OxiF3hGC9fWh3oeryQwalzcbpV+yzt8BDbKiJ+khVgjZG+iOl6XkhVbjFZ10MXg9F++z/U/T/cHvAibs4wsYZwX09v2/98UR4xaNeH08E2MqKTOc10OMlh9TOnRAcJ0rxyI8JmccfKceuKXFO6rko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xj2+yviV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DgoLXibs; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xj2+yviV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DgoLXibs"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1ACFB7A00F4;
	Sun,  8 Mar 2026 20:26:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 08 Mar 2026 20:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773015991; x=1773102391; bh=7jenjrD5M9
	uZemBhuO3WFsFpRqDYiqAF5hIKM05tIDM=; b=Xj2+yviVfPl+IXj6g2g40NM7wz
	AqSGokNoEVlJkb1Ka2jFrEXA6ZQi5H9tEUxvcOia27qPMZ4d4FO86pF3+8j/0JID
	xcrmV9Hx/jiUlDMgVIQh6DBywWotXjptLeSjIme9lvV++zbl4pW4tTAPFKuhuOzw
	p/BG6Vxq/w/FeLvUJtRjLJQqm2b5m2U734l+VtGZ5sIinCSPVkEqpAHTK0+s0iQg
	XdpwAlYzwgKWljbaDRXJ/Au7dU2EUMopl0Sv3MTzUpXIYG8Q9FH+FSipNy/kqqCI
	xXy5Xh2KX+0qjLLbKv1n4/CRt0GpakkV/8vUZJPZw+vj0It1uftxXj40aIDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773015991; x=1773102391; bh=7jenjrD5M9uZemBhuO3WFsFpRqDYiqAF5hI
	KM05tIDM=; b=DgoLXibsoFv2RTnN/csOrbyBm7W/08bZohxWayrLXyYpqE/9bCc
	/A25FNihRjlASPr/kx64N865pK67FHQFQnFADrQGv4xvH6VKCrBGkN+kMoxgXoog
	laqPe4ZwzYzJcmINcBTWE2LuLT59bwCVj8ZNt4PmtwzURrPCBZQGU1BaNk90MNcE
	Zs5eXMGoQ8ELCv8w6NzzudEk3NcRV4HQe/3KYfolC4F1ORNHTKort1wCeVTPVBfb
	Z78+qKSkitYUWg+heYNePBCeHDvn99tM+CgbZrGKFqIr8ZD/cLRWLjeMeSyMbQd5
	yuuZSAdtuUlxpMlGEVBHPPs/niixVlBJjXg==
X-ME-Sender: <xms:txOuaXg7QhM4Qxvy3YXSWNXaPR_p3gh5cLk_-wZOomEPYdg41LkBVg>
    <xme:txOuaekvKwX3GFkUfEwzoihdGBUWRKFATvOIONGElmTi7pQdJ53rVMU9P4n0EhZ_5
    5kBrnW4lMD5BvVE6D3ZMNv2hORPuzIFol4M7uIYuOqyytuyFIs0gg>
X-ME-Received: <xmr:txOuaTrKWhIHCWpQ6BUaWowMNmfvHSaYfb0xWG20ZhT8jc90kD0siD33EohB57xsvUIMSb_DFFkbdO035bNN4TBQqbMw8fcJnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeiieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvhhinhdrfihi
    lhhlfhhorhgusehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:txOuaXFsEcndNeOTi8-pgiMdFVh7sZ6-2KFEMkGn-q-wNkdlnNfDng>
    <xmx:txOuafz_mogDTCb0mxIJ3YwfXJ6tpDQ13uFHr20xhSzz-n1ZDJbIow>
    <xmx:txOuacp5NngUWGoWPcrLqtYN3-7VLMDI5QoRw9Q4h8BMttOtULhoOQ>
    <xmx:txOuaZg9Aq6JFh4D6SawxdFSweudRe4sZZxPcfc03L5vakT6wDV4dg>
    <xmx:txOuaSnnWpZ_K6mM7gmecVd5V-GZTKKNZvCDwwXku9xYHZLNEr_rd47a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 20:26:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, Kevin Willford <Kevin.Willford@microsoft.com>
Subject: Re: [PATCH v2] patch-ids: document intentional const-casting in
 patch_id_neq()
In-Reply-To: <20260308150203.86299-1-cat@malon.dev> (Tian Yuchen's message of
	"Sun, 8 Mar 2026 23:02:03 +0800")
References: <20260308043131.77782-1-a3205153416@gmail.com>
	<20260308150203.86299-1-cat@malon.dev>
Date: Sun, 08 Mar 2026 17:26:30 -0700
Message-ID: <xmqqh5qp97bd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> +	/*
> +	 * We drop the 'const' modifier here intentionally.
> +	 *
> +	 * The hashmap API requires us to treat the entries as const.
> +	 * However, to avoid performance regression, we lazily compute
> +	 * the patch IDs inside this comparison function. This fundamentally
> +	 * requires us to mutate the 'struct patch_id'. Therefore, we use
> +	 * container_of() to cast away the constness from the hashmap_entry.
> +	 */

Is that a "performance regression", I have to wonder?  We would
regress relative to what by doing what?

Is the lazy evaluation avoiding unnecessary work?

If we are going to pass _all_ the objects in the hashmap to this
comparator function eventually _anyway_, then the total cost of
computing patch IDs to all of them in the hashmap would not change
with or without lazy computation, but if we are currently getting
away without having to compute for all, but only computing for the
ones we pass to this function, then lazy evaluation is clearly a
win.  I do not offhand know which of the above two is the case, but
we need to know that before we can touch the NEEDSWORK comment, I
think.

The lazy computation comes from b3dfeebb (rebase: avoid computing
unnecessary patch IDs, 2016-07-29), even though the "const
correctness?" comment is a bit newer than that.

So it seems that we indeed are avoiding unnecessary work without
this patch.  We'd encounter "performance regression" only if we stop
avoiding unnecessary work, so I am afraid that the phrasing used in
the patch is somewhat confusing.

    Even though eptr and entry_or_key are const, we want to lazily
    compute their .patch_id members; see b3dfeebb (rebase: avoid
    computing unnecessary patch IDs, 2016-07-29), so cast the
    constness away with container_of().

or something, perhaps?

>  	struct diff_options *opt = (void *)cmpfn_data;
>  	struct patch_id *a, *b;
