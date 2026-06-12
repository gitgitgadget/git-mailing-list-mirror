Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07635AC2F
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256479; cv=none; b=tADNItoeS+O2z89oMGOudS4BiOQIjPgSY4s7aZrmV75GKVJw/fyhc7t1cbcIAcWaMfwy45v+EPgg8L0oONWzAzzbbQ+uJWz81vBhb7tHkrnntPKC9Mt2rBJ2BwhHdiimnWZPdQdRvgjaxLtWQRxqn+Y22pR7preZGx6wii3KA/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256479; c=relaxed/simple;
	bh=wIkpAPhZNiRtR52O+U4vmfUim8OGOozzAQxCzlqO7NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixW7T92GyDdhSI+68y2Pb44k+jQ1ZaEajfjMLangWqQPcVh1zDY1KGQGDIVpRLkHpQwHTj6AZwRH7aB2p0eRQzNmcrj6HX33NpO+PaGrAfuguTg/gK7HRhjF5tNbtmfFJBn/JYV97zqcyei+KkNMha40fxTXDjbw/eG4Y0dqDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y5QRlth4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jSmAE+5m; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y5QRlth4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jSmAE+5m"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D9AA814000CB;
	Fri, 12 Jun 2026 05:27:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 12 Jun 2026 05:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781256476; x=1781342876; bh=egFw/wpfrN
	0gXOdO5/jQ2TiH7casxOnBMoA9jjZhFbc=; b=Y5QRlth4m1tZZviy7aSBd2oWKd
	A6G5TdfbI7BK3gDHL7QDZWU9/udeY8QiClqiKE/om9IAVgK5G09Pw+ZeaGmQbj8s
	n2BgeWe5aGOeg75fP865nBd1ZE1h6HoLaG0ugZRYZR6ijF2WZcjO3zvDjiaJ3VYh
	r+r4nsjmumGLigB5eS/jexKB6q/Bcyq6cn2ZzeQXdxHBV9BUWOwOCedKElSNSZ00
	ZNg1pQSbGAt3lTQnIGJhhtZOMNb761bL9PcseHtQj5wHJQmMIIy24mnkJ/MZZG7r
	+5yslPoUdaS6yao0/81hDgk0vYcTUI9hJafLLkzL1eeWwx5gW6Sqlas3PebQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781256476; x=1781342876; bh=egFw/wpfrN0gXOdO5/jQ2TiH7casxOnBMoA
	9jjZhFbc=; b=jSmAE+5mUHTqrB4+pnsWjx7uPolA61lvExM8gyl5MMsTMfeDdFi
	m7eCHNLp/SZv+28Y9pJOZAyhWacT8ofs6wXAYso3MGgIvR90kYpzWYcweYDFfDce
	HHHhgzsBv3Y2LD4FoGpHbNAa4G73gJVGYU1xj05HSb21E2uYYuCxFh5b4TYT1dQs
	7e633pQedWj+DppJJq6nWBDRb4I1rrLgjnazALFoyBKTvvcxHl6SC/kdLw8kluSQ
	vRikx9QJICLk93OoDKlu/7JWm3veLGjRTd0Rg/x9vupFtAqEXNLXG2dLgx0KjoyF
	IZ7pfhEanj15pBVp0RDt9qT/gXZs+D6GfFg==
X-ME-Sender: <xms:HNEralrgobdLT5CvxOwwO0fRikWFd72SWNXk2aNNekh5cCZrArQ-fQ>
    <xme:HNEravFZRzC7AbF9_R07HrAhqY4q6MFxZ6ra3zCLgFjf6zpNRRf_gGv_isoEykGLP
    4mRVMz0kyONmwCQMqxFQKtvBxK7IsPUXG8tyQLR2NbjGFCE4UUXaQ>
X-ME-Received: <xmr:HNEravnZ2cVX_bmmwTGCVMPRwnLXjgMb5RaGSNjkRvyW__8WDuuajzIBl1lVoNW-ahkkct7ne9Wo8uQgsprs36Wp5Fg0W1xUjeVA8dTrO_U>
X-ME-Proxy-Cause: dmFkZTFj1ik/BeL7640FCwdioSXGEKljFWYYFhGToQRUuTKS8mArZv7AZyB/clCtmZHGlW
    sa3pH2//dQBLtyoNZz+1DZBDEZAGilB7hADbDMt0f557PfsK1TZQ8FtnCsO+CPfTdypp9V
    X+Pa0FP0H1DnlrKRJGnrfDjXYSRxSmzar2DfIQtLUrO+BPBQ1F7Kh1t2kToA5GQe8pwcTM
    1ro+ar+/5fnQAiUzoU2DycxIiOWeyv5SLcfcna6+c6jTSER+ZckeANFIpVxMW7jY74J4Ij
    d2CcZxahmXrrkkBMXZshYxzrmHf4e1azm1YIzC2OfHNJlezq1B0eIX0Ffh7U+jcrRDOwN8
    4qn9uKz/20LYY8CD6zXxgGSqg5XD0XZKny9udnk/s7isWAcey9iyUL3VRWftpz4GX4WZho
    NADFAFNLV3R7MivYGN7i1StyIC0m8IV8hRzgdNwUWCa9K47ay8mIfFNnyWuXj6xU/h6asw
    nE9aGuzeDyAYnyQ/M/QWE4GpYfcleuTIyEjEanDK09xjuKKOAMET9Hi1sDM/KuN3E57Qt2
    qpDfFMddcnv6y9ciINpCxHAj1Enoc9kC/2UWtu0QE8OBGV6Fpoof+wUVIPCa9fwsbyoXNC
    oeao08ZVvSobDK4V6RGfFqbpVQ/UH70dMuEk16nSxlU0Z+IRffbMFqnZYzTQ
X-ME-Proxy: <xmx:HNEraqkI7r-adHwzZHplXoc-77xiRNQVfrPaoTSzA9ZWm7Won3SL_A>
    <xmx:HNEraosBT4gxZ8YvfXjIhYEoVmw06dlwfuG4PsAj9YS0NG94blu6FA>
    <xmx:HNEralkLvAXFjiRSji1LIcWdezei7u95I9Medz2cJkKxPbA_1hp6_g>
    <xmx:HNErarvUIXXphr7TAhiQ_b6OFPsaYMyMjlzYccJ38XayzklACU9edA>
    <xmx:HNEranF73ZC3cdWLDCnoMY-3kCcrlJr-bZVc6hv5GANtQUaqXtDJUrde>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 05:27:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e71bda5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jun 2026 09:27:52 +0000 (UTC)
Date: Fri, 12 Jun 2026 11:27:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/7] builtin/init: stop modifying global
 `git_work_tree_cfg` variable
Message-ID: <aivRFY4T9ACtuoFP@pks.im>
References: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
 <20260611-b4-pks-setup-drop-global-state-v2-1-a6f7269c841d@pks.im>
 <87pl1wyyjw.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pl1wyyjw.fsf@emacs.iotcl.com>

On Fri, Jun 12, 2026 at 10:04:35AM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When executing git-init(1) we need to figure out the final location of
> > the worktree. This location can be configured in a couple of ways: via
> > an environment variable, via the preexisting "core.worktree" config in
> > case we're reinitializing, or implicitly when reinitializing a non-bare
> > repository.
> 
> Do you mean:
> 
> > case we're reinitializing, or implicitly when initializing a non-bare
> > repository.
> 
> So the second 'init' without the 're'?
> 
> Obviously not worth a reroll on it's own.

It can actually happen in both cases. I've queued the following change
locally. Thanks!

Patrick

1:  0808dbb336 ! 1:  cc6999257c builtin/init: stop modifying global `git_work_tree_cfg` variable
    @@ Commit message
         When executing git-init(1) we need to figure out the final location of
         the worktree. This location can be configured in a couple of ways: via
         an environment variable, via the preexisting "core.worktree" config in
    -    case we're reinitializing, or implicitly when reinitializing a non-bare
    -    repository.
    +    case we're reinitializing, or implicitly when (re)initializing a
    +    non-bare repository.

         When checking for the worktree location in "builtin/init-db.c" we
         populate any potentially-discovered value both by setting the global

