Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606F86AA7
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204840; cv=none; b=h8T4D8Fe2vLnUe+OLfIcY7jqKAo+nLWX4wTEItjbvji+OaLSuScod/o0l8y2Ig+KUD0e1qTqaI9dB1q3I62fnUGZZmV8nHN7crSmDVI6NMGI5BfnU5mg9WftDAtgPQb3We4TQ9NQrMJ2QGvZGKl15ShMy46/SaLyJPmvV8dnl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204840; c=relaxed/simple;
	bh=9fBTmkaE6fQvFxWWTmpjC3E1ezJ7a+Qk4wHu6AewbTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m1vBhSGaInkBMr047U7r6ik6CrNUNZbbGYUSkJs7vIYJXwgFI9NoVC3BrF8vbF0eEJbSDoitGcEqniqeowEHqdF7+o+8I0wEl6/1533jVs8xq2KpegeePFqSBnwXhILOaisqJA4FtwR2bXBWo47SABTBpBt9PA3Mm9eqwYtJ5BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iOFx5r6D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qi+e54NN; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iOFx5r6D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qi+e54NN"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5ADE7EC0431;
	Tue, 22 Jul 2025 13:20:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 22 Jul 2025 13:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753204837; x=1753291237; bh=8GYHhVf7rE
	Wv+QsWKAGg3N7AeEa4zDKCYrZdwwfjlfc=; b=iOFx5r6Df/LbMAgg1IWem5/909
	4DDoahCmfZCOqgkCAtnozgdJJ+q+n3FUuhs8wTXPuKPgbuxfTXEcSuwubpPPDILZ
	LYr3OLuEYS4t6BR046uxhqESKo+6hQkAzjkpV3zi5UrkaKL4+rAGQAAV3fYWz58a
	jseuj0Om8tyYp+jg82c0L7Zawp5gnF9CE0UIXQbvMeqEeMqCHXYxcdMeoDx8akeD
	wCPVpdRPZh2ND1c+UCx9zUFyZc5maFKl59o+L2iKLnWNLDrTDeQ6OjFsEad9D4V7
	0WXv/h3II1Ezdy3gXHEyY7gS399J0VAxxjd7rZ216OgBE7uKGcUzGRgPOPAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753204837; x=1753291237; bh=8GYHhVf7rEWv+QsWKAGg3N7AeEa4zDKCYrZ
	dwwfjlfc=; b=Qi+e54NNyyRBk+W58Jt6KdAOojTIygmEuvKVNidltPqrJ2UEzu0
	wqneNyh2QUwoWBdwqnnpvexwOc7UJy+kKTCSnoEvTw8WQdt3HXU5LWmS8OddqAEC
	Da/dD4IzYupHj1i9JmrwOsOvNfRW/gk2QhUsMPzKkZctUK+vL+ViXS3UM5LsIl3I
	EXSQr8pMKYcEFXwn8/Dja/O8mYomF1mHOocC1OYEPgaJhKvRuoYzs4MWNamCiiWJ
	T+Y1d5k8W6gy/Geo0u1V7nDcck0+6iIAVwSL7ISfrfJ0MyLdVa44bYLyDV46N4lp
	iNehlawKI1mI1rWSZ2JDl1Wx0EGCMhpqEBg==
X-ME-Sender: <xms:Zch_aJvyDnsH-cKX-UD8ijBOzkS6gOeb3P8qDmUXNTZDbvOW0X7qIA>
    <xme:Zch_aMerIVkUsLiyaaTw0hFfbInOjxGSLYajBXzmX8hU1Sjuf9hMHM4EkU3XjIT_3
    -d04Q9Wc0CxqQTVWA>
X-ME-Received: <xmr:Zch_aDZ8XUko5SH7HC5hCI4_2_tt2Rg3fCIHzr_e9dza-G-3fOogfjaT1Eoe49zo41mVXW9BdQzu4L0PPEUK5qeG9Jp36qJo_uy007Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhgv
    ohhnmhhitghhrghlrghkieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Zch_aOZk5nCyQin6uDpdUxA4QOghzIt1aKsBb6w4n2_tniXLl4wUaA>
    <xmx:Zch_aILqigsWV1D6wDgDh_UXF_2pV1pjjwnpiuOFB1rglnPgcWx1hQ>
    <xmx:Zch_aKuFYtciHPoVQ5uBDTvoVf8827Hpv6hCi41zLZawlftTz4-_WA>
    <xmx:Zch_aMVgzEMQbKN7Gl6BeSBuynf6ef8AGd2WHhu6g-P7uZOrviUpuQ>
    <xmx:Zch_aFjwHJO9RRs6ItZAm-zstPgQZICJiBVcrZGcT-BNB8tyqZH73iLM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 13:20:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Leon Michalak <leonmichalak6@gmail.com>
Subject: Re: [PATCH v4 0/4] Better support for customising context lines in
 --patch commands
In-Reply-To: <49703ba5-5f2a-4e91-b9c7-5500720d5d3d@gmail.com> (Phillip Wood's
	message of "Tue, 22 Jul 2025 17:05:37 +0100")
References: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
	<pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
	<xmqqfrepzdxd.fsf@gitster.g>
	<49703ba5-5f2a-4e91-b9c7-5500720d5d3d@gmail.com>
Date: Tue, 22 Jul 2025 10:20:35 -0700
Message-ID: <xmqqv7nkrvks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> All of the above looked reasonably well done.  Will replace.
>> Unless there are objections, let me mark the topic for 'next'
>> soonish.
>
> I think we want to sort out the test changes in patch 4. Previously we
> discussed centralizing the option parsing in that patch as well but we
> can always do that as a follow up later.

Yeah, the tests can probably use a bit more polish before we can
move forward.  Thanks for carefully reading them over.
