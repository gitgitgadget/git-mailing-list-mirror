Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBC02210F9
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734731431; cv=none; b=R8Ai7j3HhrymPQ+mfqCC9INavYePM9AGaPxPjOlNyYvdqh2Wdjs8Pz9oDqMq+8hqSe3+8BKS71pLiN/n5ARdXc4L9SdBzqhtRW8epwZ9f7w6WS/O3yAv17L/21xhWIHcYjn0Pks/ut4ztmzvLF70W++an15NfiqFBofzkHFE1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734731431; c=relaxed/simple;
	bh=QLJ0+/fBViBP2eYDxBh5C5JSVWBB5nEHYw5AIY/6kBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hb62JxQQH6O+G/bD+Y0qnDR7qAKRvFGy0whx5K6vd/A9M4mPG15SqjwGJUOPi77f4arj6sV0aq4sVhwivcRSQyGs+y7zK6vmOgK2FVczbnR/r/mSlYJbhW8Bl8KkTQ1Tyn5qTUzKoNd6N2mTdj/dIqGIF7w6SwTHgji/NL+gjaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jSl7l5Og; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KKhFe73/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jSl7l5Og";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KKhFe73/"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 11694114014D;
	Fri, 20 Dec 2024 16:50:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 20 Dec 2024 16:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734731427; x=1734817827; bh=kQLEvZzuHv
	ZTXcF3bV23r0G/q+RyCXdbhxegVlWq98s=; b=jSl7l5OgAGCcC/XQ4NEg7Gtgbu
	fWI21qDcx16Z0oZyXOiG856Bct7ZKfGquePT0t9dx/gZb3fjJvgwFzGZVmBEuM7R
	Kufi2j+mADjVTX6GwSCdAYUbMJq2Wygm+nF2SeI6+U19J6N/ITZpETp/wiirEu1m
	xsGOdt44TPgWEa9+OZ0osvoyhU4AdskvuYgBgYTElvmQluOlBhUIKAgNtJLWhxCh
	iRQiO1k8qB2bRrixYgTP4hfl6aKl3+fQZD5Kc7ZfBqN8//nGC2ewAMo447+dWsU2
	Ua3kpww02kOnx6uTWBKkTstx7WPIfZIL8TdHKSo10iYs2FVQ4vGJUPzvbl2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734731427; x=1734817827; bh=kQLEvZzuHvZTXcF3bV23r0G/q+RyCXdbhxe
	gVlWq98s=; b=KKhFe73/SS48lDUVq45+VahiqPtUCsehZ+12RV4sfKlbFlgVZua
	NhPgqZsP38YZEr8jjxAfYriZHj5XX6MyIclnAav9ZjIzBhk5ZJxsK67+hBku0HKg
	d7SYrqJcGpzKL8VnJR+AAU2Xfp1P2V24FPMy89FKZqDehq7eXxsmCibEGR3lncKu
	dGNmGOTcyX9gcirTCAuTi69Fvq1a06xriesuMwUPSljNQw3DBeLUIfJ1fnp/SuQe
	+pWL9gFw/xsxOnIgQRmUx2o3pd3R5CA3K5g77tOkTtwGPwjfvYcC4dH60LpTIcBE
	hFrzpuBecWuWZPweQfkhxtJiQYf8BOg7jcg==
X-ME-Sender: <xms:o-ZlZxKqHQo2FiTr_KXG_IpgYz4eDnDJvk5DbFylZcsqMuHbVhq62g>
    <xme:o-ZlZ9Kx-6HWoWbjDw4uDTaATpzbq9nElhdTHMFFmfVfZtoi9fwdQoVNosW4OacIZ
    GR8ANxYht2CEcE00g>
X-ME-Received: <xmr:o-ZlZ5u65RrcEWCc1PjbDnWQG_FizjAg0-y0Hj-ANog-XOo1l_CGPh-j2nIC5Mr1AuJG76UXW7m7sXrpH216ar0WyuYLy8qmWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:o-ZlZyYiP49Sr_RzFJxHDN-UIaHTI-kgJULNmXsJetW95HWwckv2_g>
    <xmx:o-ZlZ4Zy22EhWGFlDGgMvEdjMSNhuADgNEqVlzD0t9f8dqCb60O21g>
    <xmx:o-ZlZ2DDwhua3rsFZ-i8aOA7wAhllCjV-F8qcpZghFiwwkPbnzwA4w>
    <xmx:o-ZlZ2YBk5y363nAWPLEDDNjXuzEP1o3j15gRZnUFnCFRjKxxz4w0w>
    <xmx:o-ZlZ3zau3g4rONUJOHpvCpGn_oEW3NH9Oafucd2P-Vlze5fpzFnHPQO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 16:50:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 4/6] GIT-VERSION-GEN: fix overriding GIT_VERSION
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v3-4-1fd79b52a5fb@pks.im>
	(Patrick Steinhardt's message of "Fri, 20 Dec 2024 20:44:24 +0100")
References: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
	<20241220-b4-pks-git-version-via-environment-v3-4-1fd79b52a5fb@pks.im>
Date: Fri, 20 Dec 2024 13:50:25 -0800
Message-ID: <xmqq4j2ydnxa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index ff30ab6c4295525757f6a150ec4ff0c72487f440..a89823e1d1ee5042367bdcca6ed426196d49ce89 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -181,6 +181,10 @@ endif
>  -include ../config.mak.autogen
>  -include ../config.mak
>  
> +# Set GIT_VERSION_OVERRIDE such that version_gen knows to substitute
> +# GIT_VERSION in case it was set by the user.
> +GIT_VERSION_OVERRIDE := $(GIT_VERSION)
> +
>  ifndef NO_MAN_BOLD_LITERAL
>  XMLTO_EXTRA += -m manpage-bold-literal.xsl
>  endif

So the idea is that those targets and scripts may have their own
GIT_VERION value when they run GIT-VERSION-GEN to cause GIT_VERSION
to computed, and in such a case, they should pass the GIT_VERSION
they have in GIT_VERSION_OVERRIDE, and thanks to the version_gen
thing, this value in GIT_VERSION_OVERRIDE is passed in the
environment as GIT_VERSION when GIT-VERSION-GEN is run, and the
value in turn is passed intact.  Somehow this makes my head spin, as
it looks quite convoluted, but the overall flow should yield the
desired value.

Queued.  Thanks.
