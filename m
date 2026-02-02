Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB482BEC4A
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770036145; cv=none; b=m68yrN1FlyMXyTA/ylkh43j3YNKcCee04WxyDGOW0GgUjCkCs/zxc6rCYl07N4cQCjRM3YOzGzJSl1R0XmNc7peMPWaI3o0WI4RAe6rpAvOEC7rdFjgNYnRqZ+EqYaUNB+YEk2EROPqqlwUixb7uMueIkuJyjbWxdQLmrtKRKuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770036145; c=relaxed/simple;
	bh=70EqrYCbcFtC/8jXsLEvo/gbn3H3TaQgK0dvBfT3oxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tOeGZ37asKmp13IqdjgDp6L7Ry64gT/EqDrjr8Q/xQKMmA5smyY0nBs1rZA7N2ec7p/omnNGHRGmAh9uDPzbnOyo7GkyEp/5sU3YUM08PaBa/RFzt0JJ/6Up++0MChxtUMfil++jeogRk9eTtysKHGbfgehI7aHUXKFyxFkI2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DPIhQBiy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f/qcd487; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DPIhQBiy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f/qcd487"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5409E1D000BB;
	Mon,  2 Feb 2026 07:42:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 07:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770036143;
	 x=1770122543; bh=VaxZmd5aTuf+uQnDAGju+elzdSaCdlY0NarFtWTRjBI=; b=
	DPIhQBiyZ+VPBpLNPIO/2bM8SfqSjWdVk2ehpt1rjKpbZsaM86l4Qg9o2ffGHRWX
	caS+Kbkbc6dvpTpI0moJnbQp5gM8hhZvetKat8SiamYVaCwLkH04v03LQYeB/ERP
	e0esXCk5WjirF8lbPntogA4K7ZCNKT7kovTu4UN/rjDZKklZCwXj22FZE2UKw9pY
	WbFzxda+qITTuFy9kLdDvfJTxLLAjmjXuFX8rc/boUPx8SB1qSOcP40EL+pCVSB0
	12MRy/AEERGB+UxddB+BPuh0R+C8A6M5gaVy5hFa3oUDKOuqnUuLeDZlmUHk1KGj
	CREfiRIQLTNQPTgGCtq4XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770036143; x=
	1770122543; bh=VaxZmd5aTuf+uQnDAGju+elzdSaCdlY0NarFtWTRjBI=; b=f
	/qcd487XUDUznki0BdnKpRXIm2YzZpo4NR0N8RL1ZVez7t3BK7/r7v8G9gyY9fqn
	/L9uMkEtrktvtJwDea9A4WkolFKfPGPmKRhBDnpHgorlCfrx7C06J/GycAuEFr1l
	nGAr0O4ww8RxrnFtttbZUCQyO5ZXD7miGJlrbVYcP+s0//BU9Ster6FmzYeVXAia
	kXAs8IJHPhBY2H25CYdwnlEtTSjWk14UEFm+yWZgCiRdStyQ/XK9Qh2NOjM8vc6Y
	vdnS5tb4NN6+7GwhFVNWDBfVLjYICq1yG5+PSvaqmHRj6mkicKKrVszSE66fyUzq
	OyQQx0XNs9+SAZ4m1Pgfg==
X-ME-Sender: <xms:r5uAaVfUkFF5nS9VkC_oSXcnJB7qixrmVyy7qyIhg_c4c9sdIGahuA>
    <xme:r5uAaaNT0273lXQyuNLXFUoZ_eK4neE2G0h9TkZeCuu4DsXlwglG5ZpAYrBN1x6oE
    1SNBjrr6066STdb0eWrvh4iYIstxGaQ22Q8SffogNVwn_D5iRedYQ>
X-ME-Received: <xmr:r5uAaTgcTe_RqxShrPn1HKE9D9vZWAI309_-Nl2G3AOL103ScX5E7o1UZCyrpFoatDvVPybsnSf69cMlPb2SBo3bTAcpDSB4_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepshgvthhhmhgtmhgrihhlsehpmhdrmhgvpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:r5uAad1h75fmeD9JCDf6Ft7uE0-uwyWQWjbORyeHlekdPBn8Bk8YAg>
    <xmx:r5uAadhu1k3287mOojY-kWrRCm0dA9zR6ONDyvB13Gawi_c0S2NdXg>
    <xmx:r5uAadePmZlhmQkyEoi99Ef9YARcN552gckCeHh2T1dLrO1re8Txlw>
    <xmx:r5uAaQl8vPF-JPSRV5LAgBywATGToIskg3d77SKT6TdwgtnEKTvzSw>
    <xmx:r5uAadty7cwFPoR5h4Tqyiu04u9mm__iRLjh-rtoy5rBWYLuksiA26gP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 07:42:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Seth McDonald <sethmcmail@pm.me>,  git@vger.kernel.org
Subject: Re: [PATCH] blame: fix coloring for repeated suspects
In-Reply-To: <28ac1ee6-f3e9-4789-92b7-903788430697@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 1 Feb 2026 12:47:53 +0100")
References: <aX8BjoOGPIytGXjD@McDaDebianPC>
	<28ac1ee6-f3e9-4789-92b7-903788430697@web.de>
Date: Mon, 02 Feb 2026 04:42:21 -0800
Message-ID: <xmqqfr7j2u6q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> The option --ignore-rev passes the blame to an older commit.  This can
> cause adjacent scoreboard entries to blame the same commit.  Currently
> we only look a the present entry when determining whether a line needs

"look at"?

> to be colored for --color-lines.  Check the previous entry as well.

While this should work, I am kind of surprised that this has to done
as a sepecial case.  It often happens that two adjacent blocks may
be originally pass their blames to different parents of a merge, but
then the blame passes down through both branches down to the same
ancestor, at which point these two blocks need to be merged back
into the same source again, and I was hoping that a helper function
for it would be called to take care of this case as well.

In any case, thaks for a fix, and with a test, which is great.

