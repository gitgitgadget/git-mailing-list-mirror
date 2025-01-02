Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58B01B394C
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735828678; cv=none; b=HNM1Hhb47HXJoR9mB0bfzCv5JUFULRtM2a20GdkTVKIuuSzwHxIDOFzTMiJuQmxd/ES3VgTg2mAMt08TbtoB8fcpnzaW2UXdSNaZgLUqr3u3uegp0QFfHbvc+L1Pn2LnPnJNzT2BtGof2ur7RCU6Z/fN3q18Cw+3pRLHW3gL+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735828678; c=relaxed/simple;
	bh=yJREdeY2n4gvxq7xai5Vv4XcHqFaX34KuRknWfoAs3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qp15DgzLodQp6MC//kZ8h4ik099eM4ghDd0zWWSCx8NFVR2A53F7+qT7vJzR+nGlywkSxfV5GQoI7vRLvx6gEDQDIIx6Shau43CecAHYhghkvSKCvjTBA9KNKUUThOgZT7x0YNvlzEFFdAMHl4NP1AgzF2HylUPqNMJUB3Pug2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F6JQKo0s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cfmDMuVX; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F6JQKo0s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cfmDMuVX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B88011140132;
	Thu,  2 Jan 2025 09:37:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 02 Jan 2025 09:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735828674; x=1735915074; bh=ri+9lSKwP4
	S6mSEuXAYqnRf/+fCbmKB3F6utHHJBTJA=; b=F6JQKo0sUkAdUpOdo3kPCRvA95
	/LNtIeYs1m52lP1Bay0/Fa2xLlC/jAwiNyfX1oc0ZJHEYMQsL72UvxpFfop/rJK7
	oqm6ITy9pZFq2yEARBQRMOxe90LejhED3c8SlehuYtS0vW45ihIeae3fRSnMVLCF
	BD7b7W81MWyrZpBcyamV1rjOtnx3F/5/8j/LlshsuaUtmfynFu7v/w9p98ZJvAa9
	j6RHqrXdb2UKe+SpY1uao9jRW0SHlZwu/Qy/HkooQ8XWWjD6z0Ger/VpG9sfAW4z
	LCGVvdCgv+C3Qaen5BrmPLkLl1EwpZKminQdS09qs17F9nHqc2Q2hb/aKZ8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735828674; x=1735915074; bh=ri+9lSKwP4S6mSEuXAYqnRf/+fCbmKB3F6u
	tHHJBTJA=; b=cfmDMuVX5k1XnYU73ZUp54195eHGHEjGLWS9ecJf1A8X/pv+t4u
	XfKYHLcVoYZqShc7iQsaB0mLOacUh7SgBf2YhbokDB9ofUXCWo8vTsceGW8qPyGB
	SNyR0V+Y5G8b2i1nhfWYrkIfZp3Kg+V5CPw/kfNLDNmMwzL+P2AApDp392JTtqRk
	zGiTkfjrquQ2v46lRclxDRHvyNQuvU882WdGTUr8jJIXqXTZ3if5795sLDsoovX4
	IpsnSjNRRms67EzhPnS9e2OqrrFqY69qrmxl6kTdS4jS/qrWwhw07NRl+/YoZ6GI
	PUJKlk0WwARZhem6mty4+pvG/auoBOqQP9Q==
X-ME-Sender: <xms:wqR2Z9emSrzOGY0i0t7totOi5WrEINKtHfflK2Mdln7pXhJi8BmIog>
    <xme:wqR2Z7NP2MXkDf2PRioKdnccT0G1y5e5tuy4QB3Za43anz_-gIgzTB1qDG1e1Af65
    lViqrpQyNmXeSClBA>
X-ME-Received: <xmr:wqR2Z2gZGT8tvRQO3olZZCSm_EmsMwKb_VgvC2vg3W_D0qyxQp3KENMc17HUtzI4pHHBZWKp49qOv61Cq0C2zBk13pZH8BVBJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveet
    veevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pegrnhguhidrkhhophhpvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wqR2Z2-tRkvmF-R6XMcnOiLSb-kLzxykB_eEDMneKvbLqvKuJKABuw>
    <xmx:wqR2Z5tWge1uueAcj-JUxK7kPf7OF1u3KGULVd23EGeaLaUAIiu0CQ>
    <xmx:wqR2Z1G-qxUXvyjTTxsnscaPTTwtwCoucCJ49RbOktAeNgAU76C3aA>
    <xmx:wqR2ZwNgZqohQ-kqgZHCNFaIi_YYtvCU-iVvrpxIJrCUHvWCEskaZA>
    <xmx:wqR2Z3XTUAeCFDeuEziil_Awza1nKMwceLwWzna9uMLWjxwW1fO3ufs4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 09:37:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Andy Koppe <andy.koppe@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: meson-test syntax error
In-Reply-To: <Z3ah2YQSx4ZreBpK@google.com> (Jonathan Nieder's message of "Thu,
	2 Jan 2025 15:25:29 +0100")
References: <CAHWeT-boK3x6mup11boEinNDQiAxxf0vwvZkxsGRc_GRvXYA8g@mail.gmail.com>
	<Z3ah2YQSx4ZreBpK@google.com>
Date: Thu, 02 Jan 2025 06:37:52 -0800
Message-ID: <xmqq5xmxwabj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Andy Koppe wrote:
>
>> The new meson-test rule in t/Makefile causes a syntax error when the
>> default shell does not support non-standard process substitution:
>>
>>   make[1]: Entering directory '/src/git/t'
>>   rm -f -r 'test-results'
>>   /bin/sh: 10: Syntax error: "(" unexpected
>>   make[1]: *** [Makefile:119: check-meson] Error 2
>>
>> Due to this line:
>>
>>   diff -u <(echo "$$meson_tests") <(echo "$$actual_tests");
>>
>> This can of course be worked around with 'make test SHELL=/bin/bash',
>> but is that expected?
>
> I ran into the same today.  Let's discuss in the review thread
> (https://lore.kernel.org/git/20241213-pks-meson-ci-v2-5-634affccc694@pks.im/).

Probably this one?

<20241227-b4-pks-meson-docs-v2-11-f61e63edbfa1@pks.im>
