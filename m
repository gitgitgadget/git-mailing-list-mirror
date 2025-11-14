Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F12D9780
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150773; cv=none; b=G88R+JsiLOGBE3SQR6eg4a24WE1hXV+3QKItSA6/z5II1Y+hPbcA69F/mUkIr+c0p5aPaKklasEjYdk+LU9nsqZMA+rY+R0Mi72aPh5lgHmxuHXMhZqD0C4em3sB0zs5dXzJozUnTXXLiIAVSrsa1uRYQvP4nfIHViWG9PcrZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150773; c=relaxed/simple;
	bh=SfaPPR89NIgUsjRr9fX9XkXi5TvTmpqkVLIEtP3nEGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jwdWRxzq5YNCnskOzOfKujxDBxy96juA+JfNe++UPDKO55W6di5amshJDr+6a/BvqklHHwe4v3sPz3+J7Xa8x4aIxWubsXUbZV5M7i9HublulOz7BY+ssGTJEMNqsbeJ6l2eZ4iNGuikmnN4gwk9mUFl+rMhIp0ywdv0oOLtRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fIjtLeC8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zkfzq+Yo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fIjtLeC8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zkfzq+Yo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F1D7EC0198;
	Fri, 14 Nov 2025 15:06:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 14 Nov 2025 15:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763150769; x=1763237169; bh=0I2xzZIdf2
	QmNW2turiwGHLFp7CbA8sD6RRAakc82mE=; b=fIjtLeC80Ja0sIkJsMwSy89U6B
	WU4XkRXlbpYZHZQKAsQx+vgma/2RSH5rBM+HoAgfJAl4tjaXA7TGc0GbbvYvXhxq
	PEGrcO1YyICOidCVE/B5Db0+RwR9VitgImEDBUNWRSHxZs0svvR6g5eeCuximl2P
	7gy5lY2OfFvJ9lzFtYRH+ERu9roIuIZwsH1ePko6gDRSKUB1U1LSoDLdVKYYJEj6
	7wKDP7M/iQmYCumXWXK6DWGiUVOg0X1UlIu3ME6Vm3UDr+URULqAG6ePdYm214Er
	welpouAN8Y9+gx/XD4HSyJT7S97qacNvx4H13A6T9dD7TOpgOHDma6a3drew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763150769; x=1763237169; bh=0I2xzZIdf2QmNW2turiwGHLFp7CbA8sD6RR
	Aakc82mE=; b=zkfzq+YozXHM7CPnDxRUyt0kFb1+Yvdy+2URhZaiemPQ+i+Cj22
	tdF7cfwKcwVtQnGDDgJRMLqwuxnrUkLYqHBc1hTMNkA8Q5G2U3MM475N/22YMUaP
	xrwDtIKH5MfgBhFMiNZe6QCxokqHLjI47Nhair/h0RIeChPQEQa9JlvhWpSAU2/c
	AIBQqoyiqde6xpMFHUM4jZ5yNKxMo9I3pgm4yJ1MbM+iZYuFOBM2GajP/AleIwCi
	VYlFU9bvJGP6frhOgXqwht2nIoBYkSkB+zDpIhi6Dx6iyNxzAG166bgBqiEqEvU+
	l97eySU+2wGRZFryndIqen8GJA8PE9Y34ww==
X-ME-Sender: <xms:sIsXaUohg7SUWhbB7VyMGzqZuoFpPf4TgqJWFgzSbysTc2XS_bwL5w>
    <xme:sIsXaZujXhaA-sd8ohzwSR5Uu6Z8MGf_toD4UynuEzCD7EF93c4SEPfQxiJEe0pOH
    SV8v42c3EozBHDcIip8PyTTT6lobNeUoqIQQd7f--u94WTexO1ewA>
X-ME-Received: <xmr:sIsXafaouV0qrei-yYdYPPci5a9tfblU6zzZn-IxdnDilAGbaBnT3tjnGmH1ujfnr1MYghGvS4UrcQaqLcjbfvRIE908oOUdZjHJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvii
    gvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sYsXaYYSi0FpSydiwnTbZzxDdQ_PqdoITvoY-3gfZ03GuhwiFTFnuQ>
    <xmx:sYsXaYnVoUpSvuvmvHswUBXPUFa6JXhLkNkEJ63AFHBpEFi6PjolMA>
    <xmx:sYsXaT3_xLVioFHC-ZYGjYxfdL7wDUtUAE_TyfQarZ2tgIeUM7OJCw>
    <xmx:sYsXaY3LMBf_O6z0syET9EuuSWZ5ICuBVQQI8_zXTAcfavuLCSyrmQ>
    <xmx:sYsXaUrE2E9HUP7bJ31l2mi7dDrmDX7YKX53jR3RL3BYsCXgGMRpB2Jp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 15:06:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>
Subject: Re: [PATCH v3 06/10] xdiff: split xrecord_t.ha into line_hash and
 minimal_perfect_hash
In-Reply-To: <CAH=ZcbCJ4MXnHpspuT+KkeR6LRTQrzh-7v5ep9S8WPRjdteR8g@mail.gmail.com>
	(Ezekiel Newren's message of "Thu, 13 Nov 2025 22:41:15 -0700")
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<3834ea8f9becc9d6e1b407679e8a95dc6c9d56de.1762890152.git.gitgitgadget@gmail.com>
	<xmqqwm3wtat8.fsf@gitster.g>
	<CAH=ZcbCJ4MXnHpspuT+KkeR6LRTQrzh-7v5ep9S8WPRjdteR8g@mail.gmail.com>
Date: Fri, 14 Nov 2025 12:06:07 -0800
Message-ID: <xmqq346gidlc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

>> How much extra memory pressure does this change cause?  In a single
>> instance of xrecord_t, we used to have a single ulong plus a pointer
>> and a size_t; now we replaced the single ulong with two 8-byte words,
>> so 33% more memory per record, which is not so huge a deal?
>
> This was asked and answered earlier in this patch series [1].

In short, this step does bloat, but the memory usage will shrink
when the members are moved elsewhere in future patches?

> [1] https://lore.kernel.org/git/CAH=ZcbD7FeRHtYvN_4=qHApB-AwK18=KRU2SGWNg8ADkrFM-Fw@mail.gmail.com/
