Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8042D6E6F
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380424; cv=none; b=Dg3O/9pWdEbfXTqIMIzjVgGXKR2kEwjRFiWi/ezmtJubJAcghoCotirs4wxQGCCa1z6ac5SKh9fxb3q/Q3m3bmH+U7ER4M9ZM0LMnt4/3KupKM6ShQfJ282357jsV4/ComIYEUS8FDle4HAXB2gbRYZbuuxCRLW3Ea4qgZBcG/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380424; c=relaxed/simple;
	bh=sbCmyQ4KiSivD37Df6d2ezBYOTfRNVgUm/X+YM1hSts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QPr3PS3PjXc2M11libTA+jlbXrMKEhYHdEQKT1ia2qFMDiXPWUTmVUn7sz8UtQySzJdCr1nI55W/bV/U/2aW8ZiFqHd6IGdtXR9JNKqd0MMUbb1jb+VmurmkBWMSwc4k9G158b4dQiuNatGmY8Mq+XVVZmoDmAPdg4Pl9i4qXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hgY4/DbX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tpgTvo3S; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hgY4/DbX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tpgTvo3S"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E2621D000D8;
	Mon, 13 Oct 2025 14:33:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 13 Oct 2025 14:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760380421;
	 x=1760466821; bh=sbCmyQ4KiSivD37Df6d2ezBYOTfRNVgUm/X+YM1hSts=; b=
	hgY4/DbXevzGbu+0Omv0doxNCM4RiLGr5/ro1KbLE6aRjHGe38UYOnA3boRffyHs
	zcZ9K7kowcp7s5k3giJ4UhfgTdO2ugilu3n+I0N4u0iE8kDzUb5eZyvB5UPE40PI
	s56iXLZAQlpE5UgVTShr8rWoTX+ViXfXThFm9nTGWEj/RFEuOLG76U8jFXAHbOTb
	Lu8fxCb2UmrTBFRFBXXGIr0F8KUffaQpIGH3rNUvllr/gHZw41z2okT8oSSMMKiV
	ctRB0RGhIvAX5zjz7eUjj62NtHHiAXzoyCVwyga8xan6V9GqZcdjT8vNr2+uAzpH
	CFhShXRSIges4A1BNFbQrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760380421; x=
	1760466821; bh=sbCmyQ4KiSivD37Df6d2ezBYOTfRNVgUm/X+YM1hSts=; b=t
	pgTvo3STmgbBeId4rW+eSP7K/9CGBbBMnusBEy6E1Jsxf7g563dQ66p+UKbaGlI7
	b80qhuvxHlIdCz/BZlLTHv4OonXk+ZdWicPpmIQfDMhoNFSeQomo9Xdu6Duwh8y/
	0WBLCeZvs/GSP5vo49Q/CvCUlP/LPhXdSbTZl7/Dl8U2Qprm/d7+qJkGlViAd7Dy
	imtLt3F/aWXdHMQuenE5JwpLBwfsk5m2W6pMPhvTXvL7dHkjdPY2wvp7XWS5m1kR
	ChimuhL9/MjzhodwVogyAWz3rTpQQW+EZOi2hdV+IjD0hktTG0ll0CydFexjgvRJ
	4rHnzAPYU7XxCrjkzavqw==
X-ME-Sender: <xms:BEbtaEAb_5ZZ569EAZ149Kvfvsz7ICN4vuJZTaZ9DUGXbnkqAflJCg>
    <xme:BEbtaN8R7M2WJxha5gUU0uxjCfhGYClD_1Gz4hcTvrcMySn522LWi1M-8K5c1hZIN
    Z209W7FfdzMZtN0UBS8NmHPY9ay0C93hex8QQQ-02mbLPnG_t2SvYs>
X-ME-Received: <xmr:BEbtaE_-o9XH6P6KMSmhKIuJzHtzGVoU-ptUgc_wbdQNB-zCypJgDenIQ3kLL7fcSzrC7uPB_B9bffk2DVzZdjO7Ybh5O9C7DtF_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehokhhhuhhomhhonhgrjhgrhihiheegsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BUbtaEfF7CiJHtQjA26z_bDN2Po_3tO2eWP5W4bCoMxWfofR2yNDNQ>
    <xmx:BUbtaNFE4_84jA-XhvGczj2bh-KZ48hKfJ-CZLAHpOHnjkLIgZJA4A>
    <xmx:BUbtaCeU1dzw6dHn0SpyypGeB19nQABZj8IZ1c43kFrPpA9g88yEiA>
    <xmx:BUbtaHEo0r32YIBxOBFLmXVO16QfiXFcRGpA-RHNZUZye8vXv9PcsA>
    <xmx:BUbtaN8o8B2SjjgLg-qP_MT8Ixkd6eK5mTPiUTMxRHDI0DIRaXEHxUV->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 14:33:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy] patch-ids: fix const correctness
In-Reply-To: <CAFpMFfAHA8OfVXKVVSSAQ5p+B8ngT3p54on1HpM+n2qs3P1rHA@mail.gmail.com>
	(Okhuomon Ajayi's message of "Mon, 13 Oct 2025 19:14:47 +0100")
References: <20251013165320.201333-1-okhuomonajayi54@gmail.com>
	<xmqq4is23evz.fsf@gitster.g>
	<CAFpMFfBXhfy7ecBzR-cnGViivQG3AHGrQ00vSTnVY6OdxZPSLg@mail.gmail.com>
	<xmqqzf9u1zix.fsf@gitster.g>
	<CAFpMFfAHA8OfVXKVVSSAQ5p+B8ngT3p54on1HpM+n2qs3P1rHA@mail.gmail.com>
Date: Mon, 13 Oct 2025 11:33:39 -0700
Message-ID: <xmqqo6qa1wjg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> Thanks for explaining! I get it now the NEEDSWORK comment isn’t needed
> since the hashmap API is supposed to have cmpfn_data as const. I’ve
> removed the comment and didn’t change anything else

The NEEDSWORK comment is about going even further, starting from
question if hashmap should really be using "const" in the first
place, to sort things out among all the components involved
(including other users of the hashmap API).

A commit that does not do the necessary study and just removes the
needswork comment is simply irresponsible, no?

