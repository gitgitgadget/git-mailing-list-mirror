Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A03378D7F
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300057; cv=none; b=pSPa9znqwGAVs6clog1O8AvSG8LqStU54i+wfgtRFpNkvxxVfyX8K1TlQElFcTUJA0a7qjtZNwNM4v6gyyoppz6hUmL/t1qXj1tqzOy089DZ52UzAVmBIPuQShp2S9I+nrIWMhhtlcBpbCUzKOKUAYJb8C7U72AAArTvnqkyQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300057; c=relaxed/simple;
	bh=AqJryPL1Q0EhRXhqwmY67YV/zt5s4Zr/itkrmVk1+Zc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ECjHPwgYJZM7AdT1bmBu5PV2y6ADbtysIsDPc0lbB/R55Zje5Df44HYsXl6JHEhIW2YxjSL+8OtUgXkH3LIdB09ayat451RbzOIqX4yw7VF9dvS/55Q6hrFzw5BdyPHXQL+TuGgTW26UpSOxZnB16cDDshKBbwUC53Qmhrgx8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VXd0EpEV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+9STGEP; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VXd0EpEV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+9STGEP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A3445EC0224;
	Mon, 23 Mar 2026 17:07:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 23 Mar 2026 17:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774300053; x=1774386453; bh=Qs3F5Buwg/
	y4A4pLQTJmTCyRxDgwZZVDP/27oW+HayE=; b=VXd0EpEVYwbvBhvxf5YVlYpLmF
	EXRdrC2dBPp+K47pSuJF+v5RsxPFUSe4sIq9hxDTw0aiqlISmkMTazRCJbcphFPb
	czGkrZyrnsxofiYaEBY8Khfgp7CsoIf60ivPhFzd3F9cqWh3FKIbL4CQJV//0Z42
	RVg3VvjshXSGlrbxlkko4vkbLuv1R8VAy3rQf2inZ2yGVlsedqks0cKbH/Sy266O
	Tmx9AGIobJxLiBDIMloxOc1EJ0MF0pof+W2tdGegS6MwdQHmEvh+lkfwBNHl8qC+
	8SqqBIQ5R/RzMw2yQ6D612LTiquugNd7GKtUz/2nH+SLtaXbgSlPLpTVErkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774300053; x=1774386453; bh=Qs3F5Buwg/y4A4pLQTJmTCyRxDgwZZVDP/2
	7oW+HayE=; b=W+9STGEPMalYY2FmUqp1u+J60Mz9QonKYUZziJPmM6V3D9j0eAS
	1PMC0b9+uUm9L3IiSXxdsZ4vvvpZPU0SKFkq2dy9T6XfOo3QnpFuQn+vqEwSftaT
	xNwzivnZIXnOK2TUwRyVU0pmjKdpQ2ftIeppuOm4lzdx9sphJdDsFb7gK0m1ihhS
	V23m2KFq9HlrfdjvhxaUw//kPrEmUQ+kBZCizE+RKCeKJ7EX8kyw4DMkNqf6tTkZ
	NIu8eQVvaYbPUuGWpMaQgcHSJE4P9EDrqyDugiloybByBxV7JJ1ZsdF3Z3JFn2+n
	m2x0y5bICSKVl3NDpUeEE8Cq/GggyvZyU1A==
X-ME-Sender: <xms:lavBaSgWbs0BDEx21-1H2RK2cnKcuLjLYXvVSMREXIqOOTwrqTmQ6Q>
    <xme:lavBaVRjdXu7cvInl0BCWPrvR3jTfhghh0dCokOZdgzn1IssiVqb1v1YM8fppX68e
    4RrGjjxe3ckEFXw1CtF8hKYeIxup1r3aVxj9HEkkioLDHkxG-f5Dw>
X-ME-Received: <xmr:lavBacWe7Fx0-70mZE9hOFemq3kCTlZYVSHetqLZ9mKmiINA-YhUl1akwl66r-j1h4eZit0NLtlVNauVXdHk5s3mbWofDny5nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeljeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhorhgvnhiiohdrphgvghhorhgrrhhivddttddvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lavBaRQGsOmOmpWUyXBGX0Ac6Rarmvwjea9CXsHiADG65VVmpc7QXw>
    <xmx:lavBaelijd9zxO5AuYVRKYnJ29ux0W-oYVQuEfeH1bTIAbdroL5jVQ>
    <xmx:lavBaf7SKcXJ9O_5_hayiAs-65jsj2_ThkehjorTNO9VGXDt06MgTQ>
    <xmx:lavBachlYcClFaCRtxHM2mH5mvZkzoUq_myuB2j8gM8IlcBWabK-OA>
    <xmx:lavBabJvBP5cPqmrnca1ybDK3jrIEfXGrRc6TDh9aZo6VWaFtcH2Eg9L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 17:07:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v2 1/4] pack-write: add explanation to promisor
 file content
In-Reply-To: <fec0c24897092d19a718563ca4ef6e509ab104e6.1774205661.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Sun, 22 Mar 2026 20:16:23 +0100")
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
	<cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
	<fec0c24897092d19a718563ca4ef6e509ab104e6.1774205661.git.lorenzo.pegorari2002@gmail.com>
Date: Mon, 23 Mar 2026 14:07:31 -0700
Message-ID: <xmqqmrzy45m4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> In the entire codebase there is no explanation as to why the ".promisor"
> files may contain the ref names (and their associated hashes) that were
> fetched at the time the corresponding packfile was downloaded.
>
> Add comment explaining that these pieces of information are used only for
> debugging reasons, and how they can be used while debugging.
>
> Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>

A natural question any reader of the above (and below) would be
asking is: Who told you that these are only to aid debugging?

Please refer to the commit that brought in the reasoning behind the
comment to make it more convincing.  

Something like this replacing the second paragraph,

    As explained in the log message of the commit 5374a290
    (fetch-pack: write fetched refs to .promisor, 2019-10-14), where
    this loop originally came from, these ref values are not
    actually used for anything in the production, but are solely
    there to help debugging.  Explain it in a new comment.

perhaps?

> +	/*
> +	* Write in the .promisor file the ref names and associated hashes,
> +	* obtained by fetch-pack, at the point of generation of the
> +	* corresponding packfile. These pieces of info are only used to make
> +	* it easier to debug issues with partial clones, as we can identify
> +	* what refs (and their associated hashes) were fetched at the time
> +	* the packfile was downloaded, and if necessary, compare those hashes
> +	* against what the promisor remote reports now.
> +	*/

I do not want to sound too pedantic, but we align '*' asterisks in
our multi-line comments, assuming tabwidth=8 and monospace:

	/*
	 * Write in the .promisor ...
	...
	 * against what the promisor remote reports now.
	 */

Your second and subsequent lines lack a single whitespace after the
leading tab used for indent.

>  	for (i = 0; i < nr_sought; i++)
>  		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
>  			sought[i]->name);
