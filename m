Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16411AA1EC
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737142537; cv=none; b=hGOlgHm2s7PDOaF2AA+RfVkQsgAzh/6uCBjfCuVDucwDH3aDIyBi6mDxuWgtSFexGoxO42EmTjg8jmnaEey3SoUmemQGwkvZrb5Y/V88bx3IoQo/wGly6xwYLMVvrllaaTwLFOLoAS247/Puc1VjFCZ2kHv1+m3gtxNnf0fc+uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737142537; c=relaxed/simple;
	bh=RuVdSdiuLqsdxerFAumusg2DKZZpN04g+H4s3eqX89o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nrA4GnG6D7CpUok7LbYu4qchO72Mz2OxUoI1j7NjWtkwrDJ2Rhprvpzg+CkRxp00sJl+iedRnVjxdBr+SUT+i7U9/44UJYtwvlEInWBxvJuwWL8jyc6hVHG/XcfnGAHk+DfoNTN22UUOZrbDgWS4eHPDi4w1Z6ZH0gA0Jf6Cva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WYWjMzGH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lt+hiKFI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WYWjMzGH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lt+hiKFI"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id DAC61138019D;
	Fri, 17 Jan 2025 14:35:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 17 Jan 2025 14:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737142534; x=1737228934; bh=RuVdSdiuLq
	sdxerFAumusg2DKZZpN04g+H4s3eqX89o=; b=WYWjMzGHCm51I08S6dMnIl36YV
	DSkB9oDJMumKMnQz4uOxD8Y6+0snSqXbnlJIdi/JJCSQsr/8XoRao9OU8Xrx+O6T
	/CkagcdFxPJ/mhrtZOyc9MHT3lYF1LitehDrqGLeSXSTmMQlSn2Y3mtYju65Yq36
	S7eal0BUZ2aM5CfKaKKz7GS9acn4vBbsl8cLdwCr3AWl9EJqwcb4/Bffj9NOrtlj
	mrB0eZHQXmZd1JjJ2B5dLgQH4DoQViUxpsLl3xZhb3PyMSO/7au+RSzouVD5nCkX
	ubE0Jg3stBFjbz/4K18NPRvc4D8kDzEkg9V0L15mAl5kgF4HLbRFcdZNNKKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737142534; x=1737228934; bh=RuVdSdiuLqsdxerFAumusg2DKZZpN04g+H4
	s3eqX89o=; b=Lt+hiKFIpVOPCsJ+jZPUzdwgCojgeauN69NnTy+otZl3DJ9j3bw
	ZEOy2EAxOWzgQeqWhOi0i8kgNThUqvQZ95kYueYcKxV93taEjUsrD25AycKDWWDP
	d4W9f+IZKIup3G0afhCTyM7LvSEadwYeOLLLhENA0kXM3a0ulvfps5cDRPRVYib7
	DyfGllG/HEOe0uZB3GXwmW/UbFQpaNYIfBglrVwAXrYYZynkYxFROm/1vE6i/L/E
	/RrfZt1cFBgTk2m2ASLzofYAlukKGsAmxl6fCC+6i3fNW7hNUYADZrOr3b5TVjLN
	RCMNvdEMTLrD7QJs9yqPEVQbWl9LanTx9aQ==
X-ME-Sender: <xms:BrGKZ4HnOK9mhZ8zMmqc452pN21YmxOaKBlsaaCTQg-aiIbfm97jTA>
    <xme:BrGKZxWUGkyrMs4H-TifSbpwfjoHKnvIXtO6Y2n-LnL7H5Vd8Daf_Ex6UyUq3YdS_
    hcSwm0FQkJxVuZjUw>
X-ME-Received: <xmr:BrGKZyJDGPl8B_bEWaB6D3eHqCcbQZGwO7K7Bl09F9b_IajsvxS_yeqiV42o7O-su_umFKDh69KYERKReoRPwmAAtwWbM9iWBYv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mh
X-ME-Proxy: <xmx:BrGKZ6GN4H-BoO2xGzoJA4g0MkPqInDd1SMo3ERGYh-ZFIKUcJCa0Q>
    <xmx:BrGKZ-W3ipz5JvXZWzSeH2Lja3kNcVUUPPfCUvrY4RvIxOGeexOQpg>
    <xmx:BrGKZ9OmSuZJfszkj6R7_gXFUfHbhwYOlBI06lhoZQM8wbqHgYFAYA>
    <xmx:BrGKZ10rzFYsxw0Q5Mrb75ulm6orIqMj1SHs31xV946IoRQ2EMiIGg>
    <xmx:BrGKZ_u8_c7XU0soqsWRVcdgZ1y7pNO1C_IcHiSGs_FwM0XrhCRwDYpv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 14:35:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  sunshine@sunshineco.com,
  rsbecker@nexbridge.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/6] connect: advertise OS version
In-Reply-To: <20250117104639.65608-6-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Fri, 17 Jan 2025 16:16:17 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-6-usmanakinyemi202@gmail.com>
Date: Fri, 17 Jan 2025 11:35:32 -0800
Message-ID: <xmqqy0z9jksb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> +os-version
> +~~~~~~~~~~
> +
> ...
> +characters(from 33 to 126 inclusive) and are typically made from the result of

Compared to the preceding few paragraphs, this paragraph is overly
wide (the previous iteration was much better).

I'll review this step separately later.

