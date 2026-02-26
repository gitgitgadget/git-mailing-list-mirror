Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C328643A
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140089; cv=none; b=tjaLHO7RH+fZp2B7Eq5jzzoMocjnJtRT4NbSfwrCSURVGFG5Res/NzSn9CIjC6lszEJ8yTS07w0gyM0dmbOHWY0XSKIqlVW2AjUQP/tgYFTzBwIAIyM/V98ikBrOj607cLMrAhy7udmXZhg43Ev0BlR4lkooDu/SxsKq0FNs5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140089; c=relaxed/simple;
	bh=vjNyARkfonK7cT7AdzqjbxxjgsYTnC/OOIPU2DXqHR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LbJtrR3UB47JA1OiJTB2IZE4CjcTBOHmLJPbNfCeA/67V+U81MFx8yM1Ncqi1rhJgpu0JjqHxyCDv5vUaSWBg3IBumsHjBA/a4fnPNHDVYQYaGtd7bxunktsRebQ1ZIZMjVxfI+iruGaDe2tphjZ59o8h6QWOXUYUMjeyn5NvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L3iQ9uqm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V1UzjG7f; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L3iQ9uqm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V1UzjG7f"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 875E41D00090;
	Thu, 26 Feb 2026 16:08:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 26 Feb 2026 16:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772140087; x=1772226487; bh=1DP3SFiod9
	/UV7Zq7/S4zsBuXjujQJ1wZgO/QI7V/iM=; b=L3iQ9uqmaXSfNMWn7TE7oqsPH4
	GAKKHwJTCJDg+LLJfUQ4zOF2fUGqoFkyTxqbjdfRi5HtkRDt/tZcVxxEPSdT1qJj
	jopSZpdWn4pMtesr/wq5d6AYJkznUbIq3dAOJlM1JHiWkkirt0uUml9OPTtoHyHe
	jbpZs8KAkQIpUwvZg8mAPDJ2RGs+FpEbTDjiczstjLvNKBhqHxbZAgWQqjm68Ral
	EGNxPzjlS78PjdsS0y1xLzF+isBqU4rYljlM1sS1qR/Sk8h+Z+vRAdyldPwjb7JM
	QtEfYDANQe3IYezfFp0qtx6Q7ZQ1/jYe0oM0U8pXlEbfEkaYNLYn2BHxCAMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772140087; x=1772226487; bh=1DP3SFiod9/UV7Zq7/S4zsBuXjujQJ1wZgO
	/QI7V/iM=; b=V1UzjG7f4zCODDpInFo3JnLsAkJx2NMquktdmqMthDnlGaTr53p
	uCRX1cZNQ81M/X3JXTAscttEVAWyAPCApvKrM07btpr+yE4BUuAyyDsKUL07XetM
	eMVrGTlQ/NlHeUguryv4ihI1qWiZ4zNFc82dKpHCf4pBKLmUXcH4KWTQFgzHyvXb
	ZDWx1LCShTGgVoOAo1x3ksmt2YSspHQLNbzt4j2V8npSGWISurgcXC+kKMbUvhF5
	pTsAwVEmtnuGpxc6mbdNjdYIsMlwFICnTcDNJ44oiih8P2tCAwqBw3ozrqq7cmhH
	EoL9PIFnCREnyC8zSxHKPDDEYqb3aQRGPaA==
X-ME-Sender: <xms:N7agaULKzqSq4PASUTpl4Ma7gerLVMw3ksW907nCuDoavtygyVcblg>
    <xme:N7agaX2rDJ4B3vh6UOtbOHZ_PsN92lTOd3xfOW7eOLIEHQMR6CdkMQAdaklX8DQCa
    mq2CpzkUxvnm34-k-IN2gzQYvA-OoGj7ZFWhvr4MyGvNPGN-any>
X-ME-Received: <xmr:N7agaeisdnMDytP3JkwvshPXnKy7t230H9Z9ow2xDplW1ltcyUqjC-T7ZXr06qEycgyQIqlzBsNEKjt2WDaOFfkSOtL_Ft9RNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:N7agaYV-rUL7JWKFkwgEfhbfNyAvB1ocuU0HA6lCqpXaTA5eSxjayg>
    <xmx:N7agadUrnKILXK0HWDGdbe5B33_DORE0ZSOdEv3HHN_Mn7qkScZbXA>
    <xmx:N7agaYgmbDlAkbc8crY2b06EnepTxlDjIHPuHlSKwhsBZwL6lSRclw>
    <xmx:N7agaYYOEyGeFt7I8J4w3SihiY7ds9gnKJM9LXQ8a03mQWjdVHiBiA>
    <xmx:N7agabHeWROVQhaT-6dOZRiLBoGPDMIpzeg-JbOOff7R6HKj1sZzXEta>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 16:08:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org,  peff@peff.net,  "D . Ben Knoble"
 <benknoble@gmail.com>,  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/3] Fix small issues in alias subsection handling
In-Reply-To: <20260226205339.1535482-1-jonatan@jontes.page> (Jonatan
	Holmgren's message of "Thu, 26 Feb 2026 21:53:25 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260226205339.1535482-1-jonatan@jontes.page>
Date: Thu, 26 Feb 2026 13:08:05 -0800
Message-ID: <xmqqqzq7w6ve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonatan Holmgren <jonatan@jontes.page> writes:

> v2: Add patch 3 to fix memory leaks in alias listing reported by
>     Jacob Keller.  The leaks were introduced by the jh/alias-i18n
>     series (specifically "help: use list_aliases() for alias listing"):
>     list_aliases() allocates util pointers but two callers cleared
>     the list without freeing them.
>
>     Also fix a stray trailing whitespace in patch 1.
>
>     No changes in patch 2.

Thanks.  Looking good.

Let's mark the topic for 'next'.
