Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2030C610
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863713; cv=none; b=aFjJ0f1H7XQg/7QgZo6WtHvxvU+T8q7oo+wuPz/qxdzg5nJyq+tTp1hyPYERjxoEP1mEIbyNn0B/Xnv4kaX8x27zpLriyRpT0dZwR+tpOr2X8HSMMCwYS5Ov3+TQs6EtQBJ4fM9mXOiTssAm6B6m+/c5BbrEt2zeSE0rRj59Zk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863713; c=relaxed/simple;
	bh=+/QBxrS+Q+474Y7zTsj7w+vaTqeiPROMOpFOpkC07yM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ0eq1dE13UF4JPX2aVtrNTAuMpVn23KpwzDSJbowvn0kY6p5CPxVDwtc3B6kFkkBiZI2SOHEwRqBzSzbbi1F+c+JwETN++/kMLyFPuikIL6sbeWlimh7wfPKSw/C0EMVssZ0NWNLj/TLu48vsxKOVzWSVY8q0umUKzXv5bl5xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nmw9Dtyw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HP4ngLmc; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nmw9Dtyw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HP4ngLmc"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23C3014001BB
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:21:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Feb 2026 11:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771863711; x=1771950111; bh=XhwrJCWa7L
	zD34w5VV6dBgL6MPNLq8e9zVQ7Y5nv/tU=; b=nmw9DtywXq9LiTr6evoN1Q4Gzj
	wOstemiuwjRaG4DksJhgF5HHpxipOMLX4ePzhBBQxDWjH+MtqijbCu1dVQgW0FG9
	oEcONcmeOPvlGjmEy1djkKCWAhiVPDyMjPPOlZ0Xt2x5DDSJnDboI1de4KMNn1LK
	wAwvfKJsJHOkS3E9NifTraotAz/dR2rp1wHvUXroCXgO7VzrnM0ETUHnHZTd82Hu
	YcZj5k9ih7eEHUgE3nwi01+4tZovSjJor3g2B42UgDTrKlMeqT+DqrMJ2uB5QRxt
	Y7p/6S/4/3k7zoscdpI1aj3XgcZAvCVNCWdh3QEACxgFq/L3z3sJ01V45Fjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771863711; x=1771950111; bh=XhwrJCWa7LzD34w5VV6dBgL6MPNLq8e9zVQ
	7Y5nv/tU=; b=HP4ngLmc1VVRHHoKghmUjNDrCoKwbrWdcBfvmiLlVHAqzGEV8nA
	dTQ1yo75EdI/Wa3s6OMxN12LlolSFOhpg3114S9K03dTxc7NmoYmkxUQ0Os9RQE1
	LX4yGVNDSSjGfF7ETymVEvEqCMofXqCcFSYEpHE05AuGo5hFr+L7FYh+E4KIFhRQ
	zesJuIRrgMFoaNJAwYmjPRg8jLHiv691BvJvqSjP1REEN7qAg7UMpRX2SIbu5LPb
	5AM5kgWxvSguZ1ac8Cjd5h+Z+To/iEXtExyV9nfr6IYWQoiF67dWrnFu6ebAgBgj
	dtbllWSwB6ENzoJUsrzYDZIuKRXLPsde3LA==
X-ME-Sender: <xms:n36cafC9c5j07cvZJwsxefcB9mlDM4FYbEZ9eoWQccDOW88QHqj0yw>
    <xme:n36caceTzcUc0Y8RbNhc9na2U7TROxPi9cvWkYCmKklf4MPhM-3n7ViCQ1gkxjOiD
    R6QdbKqsyvU7KeenlV6AEKrDw6MRvJ6MTQmm-7AVwxHkpn_VimK>
X-ME-Received: <xmr:n36caQMh4zQ9XmYLuu4GKQGOUuUS4h4x4_roU9aDQFHhNuI3a4qUM2QSaPaaRxSkVD8plg9gVxMB_-21xttTFb2jM9JiR1r_wGUce4HHgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvdegvdeffeehtedttdffjeeuff
    elgffgheefleffleejvdefheeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:n36caW5BlwXnedw6IahOhuWPp2_Kw909K8wIwIRoMRfx_6cQzfDVMA>
    <xmx:n36caUKlvJyjJyO4ybERqhIxdu1UMuxMGehvUi91gAyt7_f1bn66PA>
    <xmx:n36caQeWTo82W-RaUMEeHNGaRWzjmt2N4l7_YDGWLJzhWdewilQBtw>
    <xmx:n36caXc0sw5gEkgrZT6HfdFFa1M0hn2Pm174wK4lBwsx5FwuRZWzog>
    <xmx:n36caWDItuF6nQJ95yWPqpzPnNI1SUdl8gzQOxI-gzkb81HeLOtQEpf6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:21:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10ec1b7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:21:49 +0000 (UTC)
Date: Mon, 23 Feb 2026 17:21:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 00/17] odb: make object database sources pluggable
Message-ID: <aZx-mrdbZp-7VZfi@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>

On Mon, Feb 23, 2026 at 05:17:51PM +0100, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series finally makes the object database source pluggable.
> This is done by moving backend-specific logics into callback functions
> that are part of `struct odb_source` and providing thin wrappers that
> call those functions.
> 
> To set expectations: this is only a start, there is still functionality
> missing that needs to be made pluggable. Most importantly:
> 
>   - Counting of objects.
> 
>   - Abbreviating object IDs and finding ambiguous objects.
> 
>   - Consistency checks.
> 
>   - Optimizing the object database.
> 
>   - Generating packfiles.
> 
> These will all happen in later patch series. That being said, with this
> patch series one already gets a lot of the basic functionality, and it's
> almost possible to do local workflows. Only "almost" though because we
> rely on abbreviating object IDs in a lot of places, but once that part
> is implemented in a subsequent patch series you can indeed work locally
> with an alternate backend.
> 
> Furthermore, what I didn't include as part of this patch series just yet
> is the introduction of the "objectStorage" extension. I mostly wanted to
> focus on the mostly-trivial parts without introducing any change in
> behaviour.

I forgot to note that this series is based on top of 7c02d39fc2 (The 6th
batch, 2026-02-20) with the following two series merged into it:

  - ps/odb-for-each-object at 3565faf28c (odb: drop unused
    `for_each_{loose,packed}_object()` functions, 2026-01-26)

  - ps/object-info-bits-cleanup at 732ec9b17b (odb: convert
    `odb_has_object()` flags into an enum, 2026-02-12)

Thanks!

Patrick
