Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5C1ABEAB
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999024; cv=none; b=qCRPN1RRT8/5+EHRplFeKEMda6qWQu0mRuiqv5IlgoWvuhq9Wwkak6Kxb0AVnWyOIM2OpGFCqTlMPKallYreCjXj7eLOkLEH+WbUkUwwo5TOIZmFjECQ7pkagAc52FNvds/CyRha3yd4CX2oLLwhLX0XmBJYEgAun2VyYHRUjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999024; c=relaxed/simple;
	bh=396t263n732zGIR76GhOReDOFYucLj3Zz7YohhBPkDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bjlXvHgE2ut9hP+9QZa4FvF/RDyC5TD7czhQCpW+7bdxZySTf9T10bBd97CylJ1Mjp+BemJpolyVWRNcSmwooqd5NDRKc80OvoXsKNFIiGZ5iY7YIDmIRNsnV08yRga8p1IqgU486peo3xxNLNnezpgIudi1x8koNvxt2AAnIX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tFG+1jrp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aP37dToN; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tFG+1jrp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aP37dToN"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DAD30114018E;
	Thu,  3 Oct 2024 19:43:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 03 Oct 2024 19:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727999021; x=1728085421; bh=PWAbjf97kv
	lIKfGfQl3wiDipJsZtPtG1xOJ0mt73DSY=; b=tFG+1jrpufHrbiwrcvsSsQ1KDP
	XoeEEWwrMiXkgCp1njINYVWoPCYwtkMI1z20c5x0TrOFutVilZboAeW7CpnOrxtu
	Q9PxzzxGyiBCyUH50/2Zgm3aisk34OhvWIaFvvaXK3jF0dampVTLnVZVGikI/RKO
	nGduPaInAqgRnme4lwxZMxbQvYC3AZEj9O/qk6hpscMr6C50zyYggnjKkJH4Ss96
	cbZUG3r6/O91FmG+Cw1HOpD1Z4GWxrtWIGdGROu2eacWQJo2627VXokrDWnOdBvy
	l3LWa883/eXsb03XIk5OjTDSegL9cKx3sxD54dpO4p7Yxy9JJ+CnoJh6RhYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727999021; x=1728085421; bh=PWAbjf97kvlIKfGfQl3wiDipJsZt
	PtG1xOJ0mt73DSY=; b=aP37dToNK0rZAi2wbaHg4tUUFwoKk3S7buvyb61rsi+k
	QwjldCaNPJltWZ7pIrXW/Z0WbLXO2gG7DGKwE77fc9dqoL8XjjRLql7Ndmq0Msc8
	N6AESoKKOZK/FvNCxgIt0S8dUo0iT7TPofq4pc8b9YxsOXlWh7BcP+kUz2kNBSkt
	8Y2GX3OGOboA8j8mxKpGevVzfpa2+zvy03dFtOIzo/BDaWmmQGLECV0ji1ceZyRt
	6crBnXbE9bFY9x9eup17ey/bnRxqPzB27VSBg6M5xnhlORslT2g3N8ui2R58yvoJ
	hmoTDsnE8BhdLBfV2naRsLx2WAJqhmKps6Xy3m//cw==
X-ME-Sender: <xms:LSz_ZmcNy311-kwp5uua3Dp4tOUYpfzmEhDsnvUS17u2XxAtVpwt3g>
    <xme:LSz_ZgNbafIiVB13HKe8HTmmH7YEjzPt6gtwKfL5PA9MBeuHsb8FB9wV6B-ryustI
    EIUqQCTvsNzM1dizg>
X-ME-Received: <xmr:LSz_ZnjKxFZR1pkQWSDr-dy6o0tF25BleWFjA605ufjUYwhy0AX_v5i5wvfz-UE7_ffYohofs7ejCRso2cvSqbKJSQNcFSXpUFYtEEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LSz_Zj9xNburH7pPC6KgFKBWtZ5kUmmk2r_7Dy2cUpLEwxgo58ezYA>
    <xmx:LSz_ZiuW1_12RHBQBhF9Tj3MeOW_ZnUSZaUWCBDIkO3U_oO5poLSPA>
    <xmx:LSz_ZqEuQABDCf22HbtNbyFPEyo5yAfwIcNaXeI2lSfkvtv9EOnpow>
    <xmx:LSz_ZhMSQtJIfHUMY6PjKpERDNW6fyHsuT5bdLa7C5T84l01YPNnwg>
    <xmx:LSz_ZkVOncjWfnnzuGvL54j5aRkW4lLwHPKsnAFeHXIlvv4p8mokCYny>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 19:43:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 5/5] diff: store graph prefix buf in git_graph struct
In-Reply-To: <20241003211317.GE11328@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 3 Oct 2024 17:13:17 -0400")
References: <20241003210548.GB11180@coredump.intra.peff.net>
	<20241003211317.GE11328@coredump.intra.peff.net>
Date: Thu, 03 Oct 2024 16:43:40 -0700
Message-ID: <xmqq7caohhw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Since we only need the strbuf when we are formatting graph padding, we
> can give ownership of the strbuf to the git_graph struct, letting us
> free it when that struct is no longer in use.
>
>  static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
>  {
>  	struct git_graph *graph = data;
> -	static struct strbuf msgbuf = STRBUF_INIT;
>  
>  	assert(opt);
>  
>  	if (!graph)
>  		return opt->line_prefix;
>  
> -	strbuf_reset(&msgbuf);

Oooh, I love this change.  The fewer file scope statics (or global
states in general) we have, the better ;-).

