Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F4A26D4E2
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106018; cv=none; b=PaWzrL815Dfv80Fyccpy7C2WvMKMKxgsaIycMJgSA3IzTN+8rrCcF2/bOLfcFgB4E6cI/V4gt10pEykB5uuDBqa2EpjDWbNrLBfkikqaALFIYk4kxuiJGZsNEJq2xLFmyyMMxPhmAX6FPaISuPu/qqXE0eRFb9pG5fERnVAJmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106018; c=relaxed/simple;
	bh=vl++jd4B+HMLsklB0D+USHMs22hZZFi9ZuQitzJtTAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N6dFwYtyVXoyiRz+GlUQKkXIu32XQdrTtNMbtPLTXC/BQSpdxH23A29opkja7dMNJkTOm1HQUrsJON1jcYP3EruNmBzCWiv9pkZegFPf/HXF0+Cfjxq3qPMW8HHtpKLtJamFXWMEVRbZ0OUic8JIITrcuXtZ1NJVNPqdjvhklro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AozCPdi5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z+Mi5v57; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AozCPdi5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z+Mi5v57"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A519EC02BB;
	Fri,  5 Sep 2025 17:00:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 05 Sep 2025 17:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757106015; x=1757192415; bh=jL6hk4oB6N
	mQPShMcEfl3ax2iL+BSiGBh+SllloXWXY=; b=AozCPdi5Ms+ZSW2IClygef4MpX
	KXm++46SXUCQt+v2OBIVzAG8UjeWADvJKPnq2MhV4aLzoigUyvINI7ieKjZ7SG76
	PxT1KbisMDjatt+fWYJTSABrwKeqvX5wPEtFCWuZbhJGdxO9THEn2UwikXePUMEU
	N+fulB2J18iJga2ulyJzgYTWiVuq4k7Mbi6EIpc73W50Y9/7xOYCNqL2pBbf1W4J
	jRWN4K+hOuBQxAcHB4bIvhCTK9bvFD+cucqTY8itR37NQBLzQVNimzDhK2DnaYOt
	Dd/R26jRbX2er9bm6i3zusiaAfTZ5eMEoV8Cr5IH5TGk+EERf4FxgLpwce1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757106015; x=1757192415; bh=jL6hk4oB6NmQPShMcEfl3ax2iL+BSiGBh+S
	llloXWXY=; b=Z+Mi5v57BJcSxIpphfC2nxSmL4rXPiCHyz/1f9XkTyazNyXriF0
	OmjvIIrCd9uiT9Hqv1YoITRvt3ccN+HVi0nRe5JWWZ1fHz2af3BYuzaJ1/XTdl6K
	K6w2hp+PmNzDNRUPIqQvKIbEn7Laj3arrsNXArc9Vqlah+2wwUsPY4i9BwpRA0Lx
	p2yL40UvN0iNdsVw4uLRzT2Akju2POY7Uc4IM8OlRP9unYQ7tO4azEVCUPo8EqIu
	6wB7+IJgG05dXO76T+cJRThx9UzZOU+eNEzf77InxkGFz9c6VisZAPfujwou290p
	Z+cAmuUnodZvsJRAzNqgqx7nqUBpLfysnYQ==
X-ME-Sender: <xms:XU-7aCxYyHlVF1ydKN8MPcexHIb7CrE9czAm4gyGR4rAXfp8Q32x1g>
    <xme:XU-7aO6C-Kpm0Xih_LXsGBlo24J5Ww8irrnR7GVX9YHTjX6D-PPsvNc5OwyN9rsm6
    msOyTis6QXjcuPSMw>
X-ME-Received: <xmr:XU-7aPdia39DImlBp4BUQAaeBNX5QZm5Y4RxriMPZ4dRHjXwZ2BVhmZsgt6vJ3Mh3e82OJ1I_1HNhVEtg0RxdjhncPSm976jNVTvNls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhht
    ihhvihhsrdhmvgdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoheptgholhhlih
    hnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiies
    ghgvnhhtohhordhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:XU-7aNEXAkRJ6OurFfQbMDylTNXcCzUN9xBRW01D3XSHwJJLmEOrNw>
    <xmx:XU-7aH5JqbzYRyNIET7fmrjcqUXKfnquctZ5kSIYq6_ZyLJkYnCAYA>
    <xmx:XU-7aIsGlYTDc_ecKiVt35HmarKMNjF6cuMHm4jP2LIHRIpGx37H7w>
    <xmx:XU-7aD_p_si6Zf-AEztoDYyUqsZdr7RTyZkyTzyY2FacDriotsYycQ>
    <xmx:X0-7aAgAfpwzglM7jgcIcvrDGEcCPAuqwj7ZWtwFXmN44MAcI0IhOR42>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 17:00:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 7/7] ci: enable Rust for breaking-changes jobs
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-7-6939cbf4a0b8@pks.im>
	(Patrick Steinhardt's message of "Fri, 05 Sep 2025 13:51:03 +0200")
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
	<20250905-b4-pks-rust-breaking-change-v2-7-6939cbf4a0b8@pks.im>
Date: Fri, 05 Sep 2025 14:00:11 -0700
Message-ID: <xmqq8qis399g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 3680446649..c718bd101a 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -9,7 +9,9 @@ case "$jobname" in
>  fedora-breaking-changes-musl|linux-breaking-changes)
>  	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  	export WITH_BREAKING_CHANGES=YesPlease
> +	export WITH_RUST=YesPlease
>  	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
> +	MESONFLAGS="$MESONFLAGS -Drust=enabled"
>  	;;
>  linux-TEST-vars)
>  	export OPENSSL_SHA1_UNSAFE=YesPlease

This had a slight interaction with other topics in flight that
targets 3.0 boundary.  I believe the resolution I did was correct,
but please double check for sanity.

Thanks.
