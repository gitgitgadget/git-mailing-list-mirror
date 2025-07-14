Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023726A095
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528211; cv=none; b=WxvI8IXcn1q8Q6Ujhds7We5ZHLKFnBOYkav5ItzvN7insvJfxmnNe3z71v7kqj769CqkU5MZfPjsVytaDvzzQkiM/b7TnH4iVy5rDbWxsVK4pubpEEzooDWcUGQl2OPBNuPr65IfwDHghsv9NvnruR5oWLY/mm9/50ngRqUt9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528211; c=relaxed/simple;
	bh=uL04kqRWJYlWWsTONScQ+EeuqXAvsqvD4FjS5BjHYys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qu9ddTDkfFHq3tpdGy1WrdmLmG5tRsuTFdh9moqaSCHAMhkEOQVCAu7B2vpqk6oj7AqXyrPAN8ij+LU+bXjgUZFxQtWERC63SGT2mUYy3yLl59nrwDqxcXG5OB29Ei81yVR40SHIuZ0gaC1s7BkEbvzEzAeA/5lq9hmy3EqvmEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LbMJM5WF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FIC+G6Aq; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LbMJM5WF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FIC+G6Aq"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 974E6EC04DB;
	Mon, 14 Jul 2025 17:23:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 14 Jul 2025 17:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752528208; x=1752614608; bh=rLk/cRCw8I
	EK0rbep8Zv736+dscVe+qHi4+IOlA3Wcs=; b=LbMJM5WF7J9Y7y11XHBu91VySJ
	qMRMMo0q/J19way/SHXL/+WHXe2tvl0YGsXyNaoi7U5M4z+0AA+Dx4x3SZ5B2CAZ
	H9zAyQ8V13hWEhZEOMtI1L6/a81xZxTTbOA/YmhgQddCCY8X6irFKxOYy9W5zaQt
	Jjr9/Hni1/Uw/OjVZRL0xQBU1hQar/oc9OVlBQBVvfAzILFAAjNLVsfX4n9kImBH
	cFpaOypz2OSYdevkO540d/ciYg6adUtVFQQNBs0yaj3C7a51uuixN/ue9JFmtdwn
	EbDEVHlRRI1u+hH9vJpvBx1duvMu5Yn/JJDwC9Qc4YPNvlSQzeISLppWf8XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752528208; x=1752614608; bh=rLk/cRCw8IEK0rbep8Zv736+dscVe+qHi4+
	IOlA3Wcs=; b=FIC+G6Aqe6WF7HCx/ExKxmA2D6z3faJNWGZ+tB7gtK608qEszdh
	ilznfEd0AfBmex6lMUugzIFcCyD1rG+yxwomM2dAbltvpmLgH/owj0eGNcRRUFlg
	j6vnnzrQoiCMIoWiLJlKGkC9HUhdMLmYGSktCNJz5WeQURcOhA8vkkJexNG75Atn
	Blyh6iYOaz96ISoRNRC5GeJE4wvp05BJzVTERQx9lxhjlgBSHY7GQ+AJvsTitJn1
	iQ9rreav/gmdRoKOrgWe1YUpjv6nfcUjZD3eV8fVUFXaSQ6vyzhIwarl4HLymsc3
	cOQTzX2rsftjrkBzPq9zPE3GshPFvmAYKTQ==
X-ME-Sender: <xms:T3V1aMMLV8Zu0bpzBGcSS4j3AMMqIQhL9VDU5ZB_H67VgVsUSraykA>
    <xme:T3V1aP0IgyBgyuCEY5qocmy1QIXGy96hMj-30u6sILMDOiZkdaxQfmjjAeSk-heZK
    xzsTR3h2LtGZMuKsQ>
X-ME-Received: <xmr:T3V1aDDXpk4U5MGZDVw4nc5mBC9sPMNCvvM6j45bFh7vOpObtN99iGQwZD6-yt9iSOnEqdbszTXLPC-82KBk1F2A8wi6tmyUdM1ZQOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehfedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:T3V1aELvHuShE7eaVdUvfEYZfPhfKHLVkjz-yPHc2RAOEub-odXznw>
    <xmx:T3V1aEnhmspiBx7W-MalLkmSTO_3Nd2wCevEOV2vYMv0LYJAGxBs_Q>
    <xmx:T3V1aFZ-rDBVeNPuDVtl5UiaAh4KgGmD5x8A1RnB6j6TD0S-WhLgHg>
    <xmx:T3V1aI_1Bjb3ntIM2BHWS-Mkr4A4UYDBJF8EQLgH2KTGvE80zaLVxw>
    <xmx:UHV1aA7RCv1FjJ55PVj_awpPFzfNwzyDIGjJHslTLAmTBrKxFHmZZjsV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 17:23:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6] fast-(import|export): improve on commit signature
 output format
In-Reply-To: <CABPp-BHM5afgiUf7GsTPWmrf_tm6mWnvHWMKiZPxApJzN-U8gg@mail.gmail.com>
	(Elijah Newren's message of "Mon, 14 Jul 2025 14:07:14 -0700")
References: <20250708091738.4072857-1-christian.couder@gmail.com>
	<20250709141253.623563-1-christian.couder@gmail.com>
	<CABPp-BHM5afgiUf7GsTPWmrf_tm6mWnvHWMKiZPxApJzN-U8gg@mail.gmail.com>
Date: Mon, 14 Jul 2025 14:23:26 -0700
Message-ID: <xmqqikjulb5d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> Overall, the patch looks great now.  There's just one little nit-pick
> left; I'm still not a fan of tests of the form
>
>   (
>     cd dir &&
>     git fast-import
>     ...lots of other commands...
>   ) <output
>
> because I think the "<output" should really be moved to the "git
> fast-import" line since it's only meant to be used there.
>
> This series adds 2 such tests.  You did point out in the discussion on
> v5 that the testsuite already uses this idiom and you wanted to match
> existing style.  (Though there were only 2 tests previously that used
> it, and you already modified both as part of this patch.)
>
> However...we've been through enough rounds and this is really just a
> nit-pick; I can submit a follow-on patch later to clean up the four
> tests and see if others agree with me that this is an eyesore, or if
> I'm just weird.

FWIW, I think it makes sense to ensure that the "output" is consumed
only by the intended command.  And "there are already two cases"
would not work very well as an excuse to add two more to make the
codebase even worse.

> I think it's good to merge down.

OK.  As long as somebody promises that the result will be cleaned up
soon later, I am OK with that.

Thanks.
