Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BFD26F444
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745407532; cv=none; b=njQslEwuY86xt2MtgFDH9qfI8ULYNeGpQvQxVHeocPlWTF+rNEtwSCcFd60CYCIfhqJYxNcVQfIoD+t5LirTFbSQihdtyLA/hhgGPyf2ZqUnaMs/kjreSeL+2SIgS45OHhDNjFv89ZS3ZTJmQraC02fP5XeGa+ghiDJ3Aio5MaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745407532; c=relaxed/simple;
	bh=JgiaQSvG4r5IT6zl9u3NR8QtTPxouN2JPuVFKGtYKOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6ZSQetKgI04VS3uv6+FlvkDkd2Qcyk+17Pw2PvLDNlPUP4Sb6TCpcv5Y3Wwvutjhr4lBYxgWK9pCH+TR2FxOuKp8GOjiERiUnc+MyEStPQMOXTttzER6vBGcFxb4y22i9vMo1nzo0FccpIUtMyK2g54TSWFoFeM0+Bhv4AQtA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oOvOJrgl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h1WKmWKr; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oOvOJrgl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h1WKmWKr"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 61E40138008B;
	Wed, 23 Apr 2025 07:25:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Apr 2025 07:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745407528; x=1745493928; bh=Srz50AQLFy
	p0cN8Nu6yEGpQjvEwbCUnVkm4lXqasMRY=; b=oOvOJrglegtKlWhN9iVpsVIlm1
	l+nJ48tkZ6P5ULnWRe8WdBpKJlkk8Fr3XlaV/UGJO3I4DW01hqo5mM//CEORS14m
	e3pEu2RlcSaaEECXJj2x841gTcPmluzgIw32s1CBopO7uJTfyl5F3e9yMR9ZF7pX
	jlnI2wXYt9ozqsSQwHAMaT1iM8r5JtIlyuiiHeYUOV/aZfUvG/pEucvf85aauRSa
	iHkWLiuPSMW1nqNorOd2J1dxCIABK/QctQpZBvneZnTBS4p64qVu0O6EvTsHdkP8
	hzDS3P/x+gc1J/Bghnj3ymSXClBPugUzO/8z5Pjarl/eAWEFnnPKw5ppgi4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745407528; x=1745493928; bh=Srz50AQLFyp0cN8Nu6yEGpQjvEwbCUnVkm4
	lXqasMRY=; b=h1WKmWKre/vixflvGt4vHtdTNN/48b92jdPbRwHgApvAMvKfdHN
	RVKPcqMnOwp3gSVtjnxaJmOwyk15mZRmkwXfs8xj2ujOuCKBv4j5mAsC9auW8IeG
	CZtjHbuF4aIYpcrr7+0Qxhc3Rcpa+Jl6DIxrTnKdAIg97pykMdGi5hygdWejj3Nk
	AByX8/LB9jzuOZ4NQKggmDy1V1tJJrqQ3GYFLS2aDRWCIINblgcLlTINylO0gcyv
	wk88zXC6LdCxzw122Pr3jZtAwW6xiqfaIgCZE64ULU5e/zND7qe2EBXm0hy+6ibV
	DAqGyDavENT7kZjuS5jnaPsBJJ0r2TtEWoA==
X-ME-Sender: <xms:KM4IaN2vTXR25JbyyaVhAgKZs0QmEGYtXfBC997h11hu0FPS-Iw-fA>
    <xme:KM4IaEGLxl52vf23ZjfAU0tcEVEreNNebRixaSFuqyYlMYAe71jA4-A9rzWowAKs4
    hhg0jAB5gfl2AKIwA>
X-ME-Received: <xmr:KM4IaN4I8nDPU-DQ2xSezwEudQAHBC6IhCJnTw8HCzDCQjmQOqbRSmjHp8nXgvRkWT8nY_tANxKqRjm4wHbedM1zGvZxiHakyE1Xuwb0RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeigeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorh
    hgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:KM4IaK2mkIA_TMy_LQFq2r8q7eGud3vhUnyn5dKAbYw2MvUC6h_61w>
    <xmx:KM4IaAEqFp0l5ZLQ98SzPoTrEezvpPpMMPT6Fd70kjC2BCr17NWuvw>
    <xmx:KM4IaL9k_-N9FIpU7q8aGk7Dg-4T6hoZXu3Fns-jXk77H_XFKlmwzw>
    <xmx:KM4IaNkQ83wV5Wzs0b3ufgkz3lbCc_-eQmNcUkVpaNGfGsFqslrYwg>
    <xmx:KM4IaGQOOd2PCaNrBwckHr_mGPmyxsWsPCnngpzOU6jREWfk8v0PavO9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 07:25:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1adc2c61 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Apr 2025 11:25:25 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:25:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] meson: simplify and parameterize various standard
 function checks
Message-ID: <aAjOIEs5Lwb9CvkU@pks.im>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <83d9fda5-8399-47fb-87b2-a8b376cf1625@gentoo.org>
 <aAdF4DzFCZ3uOJCx@pks.im>
 <590d0daa-59ac-44f3-b277-e3e83ad1add5@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <590d0daa-59ac-44f3-b277-e3e83ad1add5@gentoo.org>

On Tue, Apr 22, 2025 at 11:36:06AM -0400, Eli Schwartz wrote:
> On 4/22/25 3:31 AM, Patrick Steinhardt wrote:
> > On Mon, Apr 21, 2025 at 04:04:30PM -0400, Eli Schwartz wrote:
> >> On 4/21/25 1:51 PM, Eli Schwartz wrote:
> > I'd rather prefer to try and detect this generically instead of adding
> > more platform-specific configuration. It is way simpler to maintain, and
> > if we ever see that things don't work well on a specific platform we may
> > still reconsider at that point in time.
> 
> 
> Okay but, how do we generically detect that a platform triggers the
> Makefile advice "recommended if Git triggers O(n^2) behavior in your
> platform's qsort()"? I'm not sure how to write a compile-time check for
> this.
> 
> It's easy to write a compile-time check for whether a function exists,
> but it seems to have been an error that meson assumes some platforms
> will not provide the function, as that was never the intent of Git's
> support for internal qsort.

The question to me is whether this is still an issue that we need to
care about nowadays. If we _know_ that it is still an issue that we need
to address then I'm okay with adapting as required. But if we think that
it's probably not an issue anymore then I'd rather wait and see whether
anybody complains. Because if nobody does, then we can eventually just
throw out this logic altogether.

I treat this as a bit of a canary. Git is quite old by now, so we need
to question existing infrastructure every now and then so that we can in
the best case throw out unneeded bits and pieces every once in a while
as the surrounding ecosystem matures.

Patrick
