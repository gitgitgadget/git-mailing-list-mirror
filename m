Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB7F1779B8
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652352; cv=none; b=ZaHHDKOx8HBRMlIpMMd6o4AZg3KDWgDqDe8s7Wy/pKf+MHcrpDz7hU+M0PB7QEwbxxj//fA933Nu6Px/Uycn72LyhZgg0u50MxaDDw/gqAzP9kL9TK92PxGtD/ptS0rLnB8Q2NNJAiajYxvM9nDXNlVk2Z6Si/kr88vQZAaSrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652352; c=relaxed/simple;
	bh=E4b4q+pD1qJvPpJrbdOoYCZAXsIUv6LL8jqHDe6gros=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrfS6+z7vjNXYIAPszugn5qXdaEi7w+OpXMMqM9701ov5hhwm3zCstL15utOW7bBt7zmVcXF3Zejn2rOGtRq+1DJthWrWxhO4ZK0KJDI8PEyEIPzKWo1slbpd7d1qnFgXDpshlWNpGmCCV+akYKcjP2GxMXRVUeNSxcNbuoSzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N5LfjNuY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=STpZOMDz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N5LfjNuY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="STpZOMDz"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 02C701380250;
	Wed, 18 Sep 2024 05:39:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 18 Sep 2024 05:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726652349; x=1726738749; bh=pUtP0IH062
	wN34pFJhMkDvUhiUWUOo+T2z+3ATAYa3s=; b=N5LfjNuYTAHX18y4chErXtxXUN
	CX95IMcQHhiT3I9f0h7UVNsP7UVurk2kdt8qZNkaTEeklRIP5KoFfqVhGHVVP46t
	GsS6vUTcU8jp+7zUv02uYBYLW7JeDH6NXIDfoKfJpoqAazLUxmTy+/XUrTBkubZv
	3VxMSTyBxQ0jut6yBRfFM0CP3sJg4b7aAC6fSar1hBAGVxLZmBzO/Xa5h2Q3N33A
	hF+V77fm91MrOg/X/XbL6Y3ozndQUQEdBDP4BQR1STomkGjV1OaEVIDWHqdKljTp
	Z++4ak0N4rrfuhlwwUoCjNZGja/STFqZJ2T9Q+m9F+uiL9m6Jtu/JQ3WIQOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726652349; x=1726738749; bh=pUtP0IH062wN34pFJhMkDvUhiUWU
	Oo+T2z+3ATAYa3s=; b=STpZOMDz10CcH0pTJBGbRJUhLv/guzstqen6rEYbL6HT
	MM8DghCV/mXMoL3LchuYZPQp07msjrrlcR1E0tZPGZpXw7znDxKAUy1kI/84sX7O
	IK9V9JEmc1WK1J6r4avLG+i71wDTt6fOM/fF7WNNLfHivbJjkLXu7+4DEf36VeVC
	45vxc0ENdLDX33V4i/wiIBNMnyMXV2zp7v/UoDnfSGIlhmGrwYz/0wdgLqv1AyPx
	O+5AO89KlkB5bAsOWEBzkQktNDDab3xUTwSkIn82IZpu6TlkM7sx6sIpboRdZsPQ
	h++srffNYrsif3d32fdnxI7WUB1ZuLl0BUI+GsP8pA==
X-ME-Sender: <xms:vZ_qZmoe8vQ29sgtB4xKgA6gFrIfM3_V0eF_K6JsEm363Dudr2W6Lw>
    <xme:vZ_qZkpLGBA2-UhhVF_MxtJYjFmOfDHc5tOBJx6OWLByoC9gGem_reXKUUfUmYe-8
    eRUkRU3dwXCFIsNrQ>
X-ME-Received: <xmr:vZ_qZrPilDlaM298HN00nX8tPX7fWbeXxz4W9g9CNwJ5Odu884aKocBeQWjRtBhG36Y4IRQN-7fWsgfU6Te1dW3_xK8I6AM2xXYmzGwSHP_MOPNO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vZ_qZl7E-MP-_TtJ-3lXt__bfep-Vj5oPdNZUTBtQSddCdcxznDHlA>
    <xmx:vZ_qZl7UQ7iEd3cxv7-8rx-G-LJRwMiBdH79KkXH79N5skxAhZutJw>
    <xmx:vZ_qZlh8PDEQic_YJFdRK9KIw9eSWC9iVdXGplj4Zxb20CEprU9D_g>
    <xmx:vZ_qZv6SNbLAtrjVCjzb4ZPdNVyQjksHHKLMUD98JdUrPoauEwrCfg>
    <xmx:vZ_qZo1D25TCqA_F4hqht6gHjLCkkB0aZpLcTdcD4F15SI3bbYPXHFPB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:39:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id edb1b89a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 09:38:45 +0000 (UTC)
Date: Wed, 18 Sep 2024 11:39:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/3] refs/reftable: introduce "reftable.lockTimeout"
Message-ID: <ZuqfufrL_de7Oaq1@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1726633812.git.ps@pks.im>
 <700a35df125eca6639d08d30720332dbc1ed15a1.1726633812.git.ps@pks.im>
 <D49ATJ4EIEG0.3A1RCYNFQG0XR@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D49ATJ4EIEG0.3A1RCYNFQG0XR@jamesliu.io>

On Wed, Sep 18, 2024 at 07:22:28PM +1000, James Liu wrote:
> On Wed Sep 18, 2024 at 2:32 PM AEST, Patrick Steinhardt wrote:
> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > index 1c4b19e737f..e90ddfb98dd 100644
> > --- a/refs/reftable-backend.c
> > +++ b/refs/reftable-backend.c
> > @@ -256,6 +256,9 @@ static int reftable_be_config(const char *var, const char *value,
> >  		if (factor > UINT8_MAX)
> >  			die("reftable geometric factor cannot exceed %u", (unsigned)UINT8_MAX);
> >  		opts->auto_compaction_factor = factor;
> > +	} else if (!strcmp(var, "reftable.locktimeout")) {
> > +		unsigned long lock_timeout = git_config_ulong(var, value, ctx->kvi);
> > +		opts->lock_timeout_ms = lock_timeout;
> >  	}
> 
> Do we need to support the `0` and `-1` values that are possible for
> the "core.filesRefLockTimeout" and "core.packedRefsTimeout" timeouts
> here as well?

We already handle `0`, which is provided by the underlying lockfile
interface. But we don't handle `-1` yet. I guess wiring it up does make
sense indeed, even if it is just to be consistent with the other
timeouts.

Patrick
