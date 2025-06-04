Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F9139B
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749068364; cv=none; b=Gcb/ta/S0jVzwESA7vJ61i0x60SUn1N6hnFj5heHr6HfUWLCr1YWiGWcsgyDQFWy4L61PPSPxojk7iqj+/90RZGgOyYiBr+TISnTiLy26trCl3EQ89nPSAC419jkdl1bmXiGXn+l9w4Z6fZmxXK/FZ9wdK7EW9FosF2XQ7Yt0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749068364; c=relaxed/simple;
	bh=TG/4QVYXmRCMYvU+6SydG9WhR2GzNp8zOfZxgsrPXt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P9lST6WcMboB8UjxMaqFknEwbx7+Dq4uV9rOhwnkWUbC01cvzcZicuKIsav+UOvKCOe7nne81TDxKcQg3wzU12HwdKSNWDQ6t8W0tCt8bsD/J7ZRTjh2N0u3dgeR9ybqagJ+WCuMXY0n8nk1nGF3lh2aeE/71F0LtQUPKqltdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pRMWLXt1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JMRnrCVp; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pRMWLXt1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JMRnrCVp"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 16ACF13804A6;
	Wed,  4 Jun 2025 16:19:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 04 Jun 2025 16:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749068361; x=1749154761; bh=TG/4QVYXmR
	CMYvU+6SydG9WhR2GzNp8zOfZxgsrPXt0=; b=pRMWLXt11RkYc5fPFhabvlAFYc
	diLv3cuAo1yq7wgUdztyyZ2W2QhuWuuxi2zN6Ih98bOUFBupL6xi15PbTcbC62he
	nTQHKsAqzt9Cw7xKlvXZRFEyvupv34AN66PgsJUo71zfiCJtxLBubZuV29DGlzLB
	oKy0DjzEl3I86X/hXm8UtoRimEhcBJa1hJ+2cM2NiPmn9iPyTOeX8ZLf7qHaNjhw
	h6XEEmaopFt8r+Olt2OKnrgpDHm4g1UKJSvjZ997vsxTqCkL/G/tdeb3zOvzSbiM
	mGM2p7EKUxVlAzPFzhrhqYdkYh/ugrp83f4B/Xc9w4OiXTptHiV6azznSU/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749068361; x=1749154761; bh=TG/4QVYXmRCMYvU+6SydG9WhR2GzNp8zOfZ
	xgsrPXt0=; b=JMRnrCVpFIPbLK/sh9kE+Ug4WD8H8dvPS6vMjXcYOwco5nE8ATQ
	9Y/CFWWC9fu+elDFHWtUeuCXQt7/XkVRoHN4XOToPMs1p2bE0Hwza6BheR0w7zpY
	OQvEtSthtF7x/eDYrtN+bIM2v03tZ14KzrdimowrzjiCteDQo6m7pQIh+fAacYSR
	Ms/4PsT2WEXAHTSg1XmMBSXtxjrz4fgUsMHU1AHuxaUdTtKbstqN9vcJbtdz7VI8
	NWkDWT+wpiu1uK20wQS6dw8k0FE0i3oRcxWozcdzx45R4OfGMRolN+DYzpLm0w/D
	bmXeuJ/qdrHpP0BKqjH9HA7/QS3Yl2zVyRQ==
X-ME-Sender: <xms:SKpAaJRuofGlcVm8j5crnK735KsilBiLV2aXYlLvcBxlPZ5VB7VnRw>
    <xme:SKpAaCwpe3uLWX1EvLtx5dZms9kjdx6hA4mhdviLavABlYYcg2e4fr4U7BPeduDOH
    pSiPNcegbacuj1ohA>
X-ME-Received: <xmr:SKpAaO1nXk4U6Vrn_oGEbtzfFPpvLyMsvEElAihRJNIPYBuz_enNtr-D4VQYNGdka6VeF5u5DmzJHokM1glJQ4MzjzCsSBOVuBqT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrvgdrkh
    gvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SKpAaBCa8MhW4JtTYcE0-5LA03PXEzne46ZuyYatbxbcEBVYQogTXg>
    <xmx:SKpAaCi939vyZTmoZu7fU2qie3pPXpaCNnsUGPYRcXTgcSk9I3UshA>
    <xmx:SKpAaFoW_DOD4QU0Fj93HIu1XmhiuXQLxoi4ly7Y_jDbrIWbcZdr_Q>
    <xmx:SKpAaNjx_7fjwcg5Hm3DNWmgBQeveCa9crHA5t-uHDccGjDlo19oKw>
    <xmx:SapAaI-OaZHIg8h4-6-iQhd3YgojO7-1-wYMmYU4LSutGkgz826mAwdK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 16:19:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,  <git@vger.kernel.org>,  Jacob Keller
 <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
In-Reply-To: <f41be4aa-b16a-4072-8999-3c5874f2bce5@intel.com> (Jacob Keller's
	message of "Wed, 4 Jun 2025 11:27:54 -0700")
References: <20250521232917.2333291-4-jacob.e.keller@intel.com>
	<374BC043-8FB8-4052-BDE7-6BAE7F182994@gmail.com>
	<f41be4aa-b16a-4072-8999-3c5874f2bce5@intel.com>
Date: Wed, 04 Jun 2025 13:19:19 -0700
Message-ID: <xmqqcybjb6pk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> Would you like a v5 with an updated commit message?

What we had was already plenty readable to me, but if you think you
can improve it further, I do not mind waiting for another round of
update.

Thanks.
