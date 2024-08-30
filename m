Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5931ABA3D
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008433; cv=none; b=Ghoh5Ko/JWNUOZx1cZBJg68lxzXVcPlMjMObC53kVrrct32FZDWVHS7PiMirI/t94PhPXUkXG2iCpJ/+Oocv/mUvG2o/3kDzRwl9u0fzBvL5NVTExizwlM1nHc6W1hRvku5v9CTPiEVDcqjENYy86/y42mrsin16bHPtxj+TORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008433; c=relaxed/simple;
	bh=f/NBLaQ2pUNiHooJ/mLwlqKrR6BXmKlZW2GmPapN4Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEOeELgID+TlCi3vrSF3YrSXKx7eBLCcGH3rNDi5r/j4Ui4AIcsopqsJqz/JzuM4gJ7lelrvX8lfhRE/iFrfCOfSVMGRwkqR2vPqj249Wua+mOBdT8qmElg4YwqZ3fkIbEmzJAGxJwbevdwofqqJhw6RrWAW92QE6CTmh3cHELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E0nXe/RT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L/gCT9rf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E0nXe/RT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L/gCT9rf"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 57F50138024B;
	Fri, 30 Aug 2024 05:00:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 30 Aug 2024 05:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008430; x=1725094830; bh=TpF9WjsMTw
	uU3oCagmEMczFwPBa64S+5JyP5yLwZv6Y=; b=E0nXe/RTsf3RFSbF8EKlEqp7yH
	sipj04GuOTu7B146iyATjidEth4O7X1c87LLJSBTw8ROdxcaW8MHeEwgsq//qBVQ
	4qHKN26N3yDSfspxAx6+PLLqX+NVgj20ZApkbId1FJP/fdhd2dwYVb/jHH3di9NI
	DQRWzoM6sX2jA8UYiuPxFxz1l6qUabQLS8r7bG4NvIgiOWaBz453y1eP8dWBwF/n
	fmcUB/S6axfxtl0tLJLCxAOvv20M/xDnkPQ4JNFljhApmD/fmZgONHoSxMLXlBU0
	K+QufzCKKCdoUMa/CV/ZdIcwpXREsG2oCOGeLxdsx04xjClBqCTAxEflk1xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008430; x=1725094830; bh=TpF9WjsMTwuU3oCagmEMczFwPBa6
	4S+5JyP5yLwZv6Y=; b=L/gCT9rfK1LjxddFP4pQZnVGtI5JnCD3+i2EmvzCXzkh
	i2mE97Pd2lOlJSaQb/8Mi6ClPpC7oFSeKUqlxz0OKZ+lhe7DAJY/1yhIqjDmWNXD
	O2iIet1JdymGrN8JgngRVPa2ISiaZivuQL9P4Lgu54SjQb4HFJWBhdNYfE5DmGWS
	vIwGw/He24hRT0w0av4IQ5ucgDD4Q5Blc7ldeIikF0LAacOnW3sWJDRQgZACSI8S
	8412VmH9ugaJaoe4oKfCgAf1gX8w8adcnQsSToYpLYLOEfsEKpanbxfZNDcFhRjo
	3/lqLL00dKesDzLvDsg1ppgSMuLIgUMWmWHhKgRx/A==
X-ME-Sender: <xms:LYrRZkljfVZQt63fNlERszuGDF11HPZsANWctSIY3sZibSy1gbhc6g>
    <xme:LYrRZj342JftjpDCVaRBPIO0MG_PqfcpAjLxcDIbISk5iEkr5Qc1orlCmlR62CIv8
    jcnN9P49FlUGQ_Dcw>
X-ME-Received: <xmr:LYrRZirYBEy4feOVkL3cPlZJXtCwczi0EpZDLO-o29pBTP8sAmDp07lAKTJE8by0ebT4GGMLj9TGk7HSy0gJDJI8ysHcRu0s9c1Fic9NI-q99KjnEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:LorRZgky4a_QvIMqPfnEtlDQklk4X6SsJa_VFTWPDSu9kWmbGIHJUA>
    <xmx:LorRZi0oZmDda5BzVzxABAPngEV4MnanNc3WK-JJbgf3OBflbyeqkQ>
    <xmx:LorRZnsl-mOPBDFJNEfCkVoavAC4Gs9-OYOqWlpigHTRi5fjxi2rGg>
    <xmx:LorRZuUIMPmmkOSoeD_L4KgNdVJ3784e4o4SMs0spwksufVqAonleA>
    <xmx:LorRZgAua16Y2Ye5mnzoy5hsSYqeGmOHb4lLC5qBIIZMReHqa4_5Hyh3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:00:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9dcd2e07 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:00:17 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:00:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/22] t/test-lib: allow skipping leak checks for passing
 tests
Message-ID: <ZtGKJfgBo17Vz8wY@tanuki>
References: <cover.1724656120.git.ps@pks.im>
 <7c158acadf40b44edb3cf186860a3f60818f76f0.1724656120.git.ps@pks.im>
 <87frqnjty9.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frqnjty9.fsf@iotcl.com>

On Thu, Aug 29, 2024 at 04:15:58PM +0200, Toon claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > With `GIT_TEST_PASSING_SANITIZE_LEAK=check`, one can double check
> > whether a memory leak fix caused some test suites to become leak free.
> > It is somewhat slow to execute though because it runs all of our test
> > suites with the leak sanitizer enabled. It is also pointless in most
> > cases, because the only test suites that need to be checked are those
> > which _aren't_ yet marked with `TEST_PASSES_SANITIZE_LEAK=true`.
> 
> What I understand from `t/README` the "check" value is used to test
> whether the presence or absence of `TEST_PASSES_SANITIZE_LEAK=true`
> matches the expectations. I think it's better to express that in the
> first sentence, because it sounds a bit misleading at the moment if you
> don't know that.
> 
> > Introduce a new value "check-failing". If set, we will only check those
> > tests which are not yet marked as leak free.
> 
> I would also mention this still has the effect that tests which *are*
> leak-free but do not have `TEST_PASSES_SANITIZE_LEAK=true` fail due to
> the use of "--invert-exit-code".

I don't want to go too much into the implementation details here, but
will note that we continue to behave the same as with "check", except
that we skip already-leak-free tests.

> Also, can you add a short paragraph about this value in "t/README"?

Yup, will do.

Patrick
