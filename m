Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318B38BF9A
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494322; cv=none; b=qQ3xPde3mKgJbbHhxGd/fukZ6A3E/FVn/DXlieaXrY/pHOiHQ27m2yirKhFwtWrivqORalIEbOiJSSdILM5OXguFLMpXn6tAgjEWmB/PToomYK0MG73GwtY5LezcV6ttGiy+nf90U7mBf5mbqNbE0yG9EbPwCHggGRNsdLd4Kvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494322; c=relaxed/simple;
	bh=ka9VYSxsYDX4ERym586lg9S4IIJ9NuHn9ikQsabigHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pUqsgHOO5xLFtABXOc3pEoIg7sbIKjsuvPKibofzAkrBJpsA7MdN880Dnz/XYLbIxL8Q3z2XBQvzKmERBNha6E6R5smKZDf1D11oayukrw4us0cYdRjD9iGfSram/yyfEjaQOrQXAabWfgbN0otTgUiXmY/pmDk6g7pu2c/T0Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=brZYJxHt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mBmM3BxP; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="brZYJxHt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mBmM3BxP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A8447A0164;
	Mon,  6 Apr 2026 12:51:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 06 Apr 2026 12:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775494319; x=1775580719; bh=+Ka1xopCji
	l2omC1ISuy7quUUmRcFaBBOw7jn88DjIM=; b=brZYJxHtMjDcKEY3DqvtXuberc
	ZYa20OiRo+6CCmDx6ICzG4tjKEImH4tlb4UQwzYfdoxepp+jU0KLDw6AOikOIfrN
	y6bru6QhWLupXXHBsUpacqumaEv3ubz+rpo3Tb3l6A83svZ+YvQo2H+ao/AwgI4x
	+gL6jYgQimcZNfuwIkvcHLpcF6Nua398zJZnIBYqsELK3rB6sWCo0ubGFZXkPRI4
	giILHFOSoLtA86S1kvDqdafU92zsbWMeGj08EvTGklieYGT7XLlXRHpoWeeBvqSW
	dTnH/UKhwW5SFfoakpTYPB62vaTU9OFGzhoGrw5BHhbu+hbSimW4j0mPWgFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775494319; x=1775580719; bh=+Ka1xopCjil2omC1ISuy7quUUmRcFaBBOw7
	jn88DjIM=; b=mBmM3BxPWtzeYvX1cFm4TrJ1/ayynlGM9reG3Hzlar0pbsm6Wkc
	97WzSBgovy6mW/da8fUZHn0FYV9SV44G25keyFZNy0A2ti5z6FzR6kVWsJGIVYOi
	zMqw1nEXRJon9asWNbxJKOYgwTj4e5FnTl4uwRa6NaMVqVVdwlK22F/cd/AS9EWn
	f0OiDFEFHasy6pGfbBeaXsFVbzkNj56xULGl1utv7PkG2MlSAhRH4iq/HljB8O8L
	Js66PUJ/c+bsLZp7lKHzCIW/OPCKgBGCVyiLDzbMKbf1PFUfgpCEvvnm2M8lwWXr
	I6//mrEKLueB5QMBGAy+QwYvkIBKVPcXbYA==
X-ME-Sender: <xms:ruTTaQJ10SdkDphgaqhaCoqTzVNnunTG09iZQFoupRdWj3XQ0b-Ckw>
    <xme:ruTTaSai9Lul1zjIZOb_5RlVQJJqCYgP_Gp9-8L7oPxeGdm8VGCC9HykbeJ_wwD4-
    HSWkMmASxwH5aY-a0TIs1BCBQG-1tShYKBTjm5ey2IAWzeppptx0g>
X-ME-Received: <xmr:ruTTaS8KIyvqxKvfb6oktlACG9wgQK3ssVNo9oNO4hLiysHAT_TSfNfwEnjvqJDhDtuQV8ss4hwRRSil8UEP-0keJV5W8JFRXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehprghulhesphgruhhlthgrrhhjrghnrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ruTTaTb-FI1Ur1zAAn8esBvJ_1p234gTjo5G8zF02XsyfNB9sLrkVA>
    <xmx:ruTTaWOV0WNaB2ZqCh5ug8fsj2quu6gYoOhXQTZgwQOXc9o2QVh6SA>
    <xmx:ruTTafDsBLBJmCoAZ-3DmhagRZlEvA_qa7atJSZPALl5CZUwdphk0Q>
    <xmx:ruTTadLdEmB9drd1UU-PbgH8KfciRRgzIyC3s-rnx0MJSh00UORjZg>
    <xmx:r-TTafDVA6G4dyyMqomP3MWGN3qfVXsLTeJzuAeP0HquhUj2E1GU1bPJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 12:51:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Paul Tarjan <paul@paultarjan.com>,  git@vger.kernel.org,  ps@pks.im,
  stolee@gmail.com,  gitgitgadget@gmail.com
Subject: Re: [PATCH v12 13/13] fsmonitor: fix split-index bitmap bounds in
 tweak_fsmonitor()
In-Reply-To: <cd82f960-88ff-661e-1e31-a119beb817e7@gmx.de> (Johannes
	Schindelin's message of "Sun, 5 Apr 2026 11:26:02 +0200 (CEST)")
References: <b96ed977-525e-c3fc-a626-db1a4b3da376@gmx.de>
	<20260405051528.74435-1-github@paulisageek.com>
	<cd82f960-88ff-661e-1e31-a119beb817e7@gmx.de>
Date: Mon, 06 Apr 2026 09:51:57 -0700
Message-ID: <xmqq3418c9qq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This patch essentially tells Git to disobey the `index.skipHash` config,
> at least under some circumstances. While that _looks_ like it works around
> the observed problem, it is unlikely to be desirable in the long run
> because such an inconsistency is prone to cause problems down the line.
>
> The fundamental problem at hand is that the split-index _requires_ the
> index' hash to be calculated, while the `index.skipHash` config
> specifically _skips_ it. In other words, those two features are
> fundamentally incompatible with one another.

Thanks for clearly spelling out the core problem ...

> So the safest approach I can think of really is what I suggested, to force
> the `GIT_TEST_SPLIT_INDEX` variable to be unset in `t9210-scalar.sh`.

... and a clear recommendation.  Very much appreciated.

