Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79D2F6565
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757028466; cv=none; b=lNBdPZbHKkHoJvlb1lJbJ3FiM1c0U5jR5mddrkaqMj73Jbu9Z9+2QYJz3BTgnnx9nPlaaAAPHe7mNzlamCuUzdtEMkeD1aZDoFWbQSzO+BpezpZkdW9nbUfx8oyi2QlY2YMBAgtPCvSk+OIAkhZ9Ji6gM92zs8tri3BYKII8tNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757028466; c=relaxed/simple;
	bh=cBfHd5jgi70VRWcM4PlUENuzG2bNmKfcpC/YvBIkA8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yg8UwNbTCIcbABYfzLiOnYgXTOkwkW/Tyh19GQFsLXNw8EbqPK3Q3yCxolERGYD6XK6jHEWjIzcldHD8fxmuqQ4VsbtNx5R5jBevuDeZK/4b9mO7Lr37ii6j6czT6o02CvKPjE89oKct7C0Baon2ErbbuuTyfC4zirB0jCSCjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ILaI1iOM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JTeBwJZV; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ILaI1iOM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JTeBwJZV"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B53687A05E9;
	Thu,  4 Sep 2025 19:27:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 04 Sep 2025 19:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757028462; x=1757114862; bh=iBuMaj49S3
	rkogzKun1b51t61swo3PhE6y4GVMoMjDE=; b=ILaI1iOMDzfVfb0MyOgLi2CS0F
	7fD1cT2No4wQK8+9+WHULp13dQv5a7NLPkItpBMt8QPVcZiu7L3kI3k6imMBjQ1J
	vJZxTYwg1t9QgKzeNp9jjgYy+CPPVzR1RXehVuEsn1XBvQg1LdFO3COP+2HKUik9
	JQ+Gfm25fgA/aXweg23QsFG3sbr8NAn+kjQTKOTNHVBJ9Zdfs1V5AUPgp+Pu2AI5
	mGYKKtS0021h6S/nUQzgxZPjbWyiFVa5/2O97Dxne1YVIEbcURbrr4TrBfaa7i8u
	yHE2sf/NhqFIbvvi3cvTCsM/T0ImLvrytL0dfpQCD1lvs3OMqwV+K+suNZZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757028462; x=1757114862; bh=iBuMaj49S3rkogzKun1b51t61swo3PhE6y4
	GVMoMjDE=; b=JTeBwJZVK7d84fZkocq/5ZuQMedGsMFKXcxCxoEyE/c6Nul99GX
	3nyBFcQ64fGutbGLLfl+waYnlxxof0wksWQGEtBeYlJk1/elvoDgmB/VSBqRpcJZ
	42+00WgbAMBioHyCaS7rL/WZMNNYwec/JJKOgkjiz5zuoiDeWMhgktMXPp1Hdii1
	TSnollaCLCeYjIX6irLTXMMd2HcCwoRFm9zH+RaTL05yuskJK51Va72t8fYuE/lj
	AiiScafGXz/gH2cKZ6RoKha3jBYAVdu4Qb4eKp6ss3Y6DUBl0LV688dnLxW4hG7s
	S6gPt5WF1GXCV0KZtGdpq9y6RrCgF+keQXQ==
X-ME-Sender: <xms:biC6aGk_dRCIHIqu8-i7ioey-49hUbvwZhKb_GGKKxu5KttQ2XFDTA>
    <xme:biC6aBFeLhCyv4LCebAZS_iJp0lCagpUdKj-jtiCH4faQNrtWHBmVTlZd9wkBhr2L
    mZVebeVN2P6Ju1fhg>
X-ME-Received: <xmr:biC6aOHWt-pwBtw4fO9Ub5V-STp57JijwFzPfwzpLsgK5dJEEGdmRGwJCaQcq3Keqka1eYsvcsmveqlobm9Rr_lLQc5Nz0ONEnNkScc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:biC6aGMfIrt0odB_son3QVuC8umTrrnIpwmJiEoTnAZrP8NjI7J8nw>
    <xmx:biC6aFHQjykfZVBtbJGWuKomPzezZM4-RKam8jR8iQyU7-PXzi6O4Q>
    <xmx:biC6aFOC451akdG7b9lYjErJ9NgLxscWkxYYtsLIRy9MgDjFOIxd9A>
    <xmx:biC6aO_PpyJdzJzckqOPdq42Yhg8HOZ2OdYRZhnDhBQDN2pLh7oQjQ>
    <xmx:biC6aIqFWEXGrvS_lj_nH3A81Q0ia3p8xNDW1z1Sugn82bSFM9s3yX3c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 19:27:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/6] odb: track commit graphs via object source
In-Reply-To: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
	(Patrick Steinhardt's message of "Thu, 04 Sep 2025 14:49:54 +0200")
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
Date: Thu, 04 Sep 2025 16:27:41 -0700
Message-ID: <xmqq1pol7q8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> There's a trivial conflict with tc/last-modified that can be solved like
> this:
>
> diff --cc commit-graph.c
> index 9929c1ed87,2f20f66cfd..0000000000
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@@ -823,7 -812,12 +823,11 @@@ int corrected_commit_dates_enabled(stru
>   
>   struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
>   {
>  -	struct commit_graph *g;
>  +	struct commit_graph *g = prepare_commit_graph(r);
> + 
>  -	if (!prepare_commit_graph(r))
> ++	if (!g)
> + 	       return NULL;
> + 

The while (g) loop will be entirely skipped when g==NULL, and then
the function returns NULL after iterating the loop, so there is not
much reason to have these three lines for early-return, no?

>  -	g = r->objects->commit_graph;
>   	while (g) {
>   		if (g->bloom_filter_settings)
>   			return g->bloom_filter_settings;

Thanks.
