Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5A0156225
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528093; cv=none; b=RHqoZjruum0fnQUTAiacLYqov2sUHTbL5Dlmzw6Pn0MinjTPxnrVyJlWEXtm7MUI/ldIUic2X9yoGKdR8Hc9yCcM6zycMEGhNR5FMX51ghfpMYrVpJhMXxhqpKwW8Xy4lqpJDbkiT9YYS/zH3LXD4gv84QouGT1sY6WvVQUhVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528093; c=relaxed/simple;
	bh=TrIzsjWlt1tI2nDPPKG3VIkkB3YMj4sPIfJLshobj+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zqey9eI52Y5onYnEvXLKJ1i5hKMDFbrsGJjjBDKcwpF5Wl6QZj01GGDs1WwNfsLyhsdYWbr6ORM6BGYg7ab/YQLzyu+Un7rqP9wSfrXXCdmStyZrC6GO0KFOYlpfYltY3G4vYLq/8tFR8qi9B7r/ERayqAjRqmvhptX4gYmOpNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oaZqwzID; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XnkWC8xm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oaZqwzID";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XnkWC8xm"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 55C0213801CB;
	Wed, 18 Dec 2024 08:21:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 18 Dec 2024 08:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734528089; x=1734614489; bh=TrIzsjWlt1
	tI2nDPPKG3VIkkB3YMj4sPIfJLshobj+w=; b=oaZqwzIDqWjN0JmJHZPSkuX7xi
	1JhqfMy3wXHjyr7Jbq58/iMX4xXgcz5rqr05b9gF3YTGuamcrxfmqjoBjtvPFjZ5
	mmkYXLTQ0WdnZxcdXOKWNfzhJ+J9+rzTSNBe92laW8szZ+cmggE5DTO4wpu2ZIXH
	yHpFIP1j85qUcAeGCFK8bEXn1jVDvGqFAgZQFeTHwtKfTOvSSImPllSnV8fJCywH
	6Y94BhwVzeVttKWU/mF0iqckFaR30YSbLI50cOABbNpYf57bGpHHnEoZm0uBjvgs
	BhhmpYpcokUn2bHtUbpglYox3J1R4/8ml1gufT2S9p/RMtcQWGn1epu652ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734528089; x=1734614489; bh=TrIzsjWlt1tI2nDPPKG3VIkkB3YMj4sPIfJ
	Lshobj+w=; b=XnkWC8xmsqW0c6QNFDPpJSXy9+nqdz/pNL+ipqNknOEIBcMDNh2
	uYckLj9P6d8DDH6oBMZCYUiqnvOyYv/K4lOEgFDYoBKVWEJiuZ3IixLWUssp1Tjg
	B1VihocnuRaZz0Aitbk2JmrbWIiaVhvPUsZDCIielflcR/4fO4fvFvHYiyQd4zgJ
	NmlE78eKS22p9E33Y5muAASvkOsMgsWV0CzeiGKei0f90ijEtt3ixEhQV358awso
	ueEwYHVLAXv6SVRemhqTdbMd6De1X7h/eUlEZOdx9ZebED6/jBJjbYTYyfd/7+U1
	85iLTHJ5ZoVplUcmYJAt+UwdLbJ32AWMRTg==
X-ME-Sender: <xms:WMxiZ7v0sD13u_kwjZ-8FB8lmKtAIVrWoe4F7jpgVdeZp4ZgnXAMrA>
    <xme:WMxiZ8dRkk6DdYp9-qzlCQSONGkhx7MKQw9e6jqU6iULoQyAxh1Ix_CW1I-FDLzjK
    50tCfqMcYKm_mXbWg>
X-ME-Received: <xmr:WMxiZ-zzmdYHcxX8sRRiyyA6-Qm360ruvVDHB5TZwRQZbnBUwKxtAEj3a11qcZCzhq20GO4xq4uzPnYODFqkLUmxZ4VPNhslQ7WZwAG-e8QJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitd
    eludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WcxiZ6NPJnuL2X7hl9e2IOY0vmvx0aPyFTH6ZagrVY7Pn-av-H_ExQ>
    <xmx:WcxiZ78eZNv7goD9l0y9Gr3lVOnzwkVHZRKVLO55Nzb279dGj8fqwA>
    <xmx:WcxiZ6VNO9jFdLgwmDq36sCWRET2UuGE3a9kzPteHSrKW4gL3hYmFw>
    <xmx:WcxiZ8feu3XbvGkLPbR2wc3zq5UzvVRG6DUQYf_d71kucR8a6OcTTA>
    <xmx:WcxiZ3bfSf2tkz-x3AoEjMV-FSS-EsmV8wdUCFKGUxYQH2mqVRak7fnl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 08:21:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d822d22e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Dec 2024 13:19:38 +0000 (UTC)
Date: Wed, 18 Dec 2024 14:19:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kyle Lippincott <spectral@google.com>
Subject: Re: make GIT_VERSION=foo broken, was Re: [PATCH v2] doc: remove
 extra quotes in generated docs
Message-ID: <Z2LL9F8WANokZJ7R@pks.im>
References: <pull.1847.git.git.1734479267736.gitgitgadget@gmail.com>
 <pull.1847.v2.git.git.1734483422181.gitgitgadget@gmail.com>
 <xmqqbjx9yedb.fsf@gitster.g>
 <20241218113324.GA594795@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218113324.GA594795@coredump.intra.peff.net>

On Wed, Dec 18, 2024 at 06:33:24AM -0500, Jeff King wrote:
> Perhaps the script should be doing the same for GIT_VERSION itself,
> along with GIT_DATE?

I won't be able to have a look today or tomorrow, but will have a look
on Friday and send a patch, unless somebody else beats me to it.

Thanks for the report!

Patrick
