Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEDE3A873D
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471031; cv=none; b=cTcdNqcDizbFyIHJEpOswVaXWR8+UC7RBdJ67y/brs1w7VvYSa9z9zxwSGKvJHWOObgzmU22PD2tilEpTLy3ujSqvPpSEMokGRntB0s+g2adaOwJAtSeZPCEpj+cwZnRONn6sK6MwViu8Wl4XyMywZT4h03Yx+8NxhvWaJBNoCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471031; c=relaxed/simple;
	bh=2j+M3qK4/Mxzvy9n4/3Al2oFJ7F+7DYM/Ww3a/ZUYeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE307R976DgRlWoMdTHOiSOch54C/YLVDJCADi7iXGZvQiGwvmJChpEJwiv1NtU5HYh1209l3TaJTAnks7y1SqsyBtudmiU2xQATsOzRseN9Z6Gh/cByjj/KI+jg0VJ+JhyYVZr4CShdC/CnoBcSLbSlyoVf7F6425Dn+3mYcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jqoW3DPs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EuxmQJdR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jqoW3DPs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EuxmQJdR"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5CABE7A00E8;
	Fri, 26 Jun 2026 06:50:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 26 Jun 2026 06:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782471028; x=1782557428; bh=VTfGV+x6Dk
	3LsYiIv7QnGB3CJZLKtK96j+6buR/bUxQ=; b=jqoW3DPsNMrza/wRIp/CHIn3V2
	px4fEqcfu11TV6fPujby9h7XsNaer4AD5264dNmINehJuLTMtd4CAE9wkzBqVqo0
	pCMo7b3yTNHCyXTzEzmROziaMkElMV+5ezQHzzLxbCJvezdJ8y6lyo7kzgpyH2aJ
	k0GbhnYX/qt4qTKrf1XCqurD2qq6b2hlqpMa91qxrLoOTT1XzL2uP5lm2sqW4LvM
	HdmRKn8MDQBuHkpZDAYW2dakELFL2+AfRV4KJ54FGrnqg1zuttoXksDJwghXfSXD
	kyathOkPl9wsP5PikfEctiAoetkmf/sTKA9002exnINqimYEbTtKqIyjuLAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782471028; x=1782557428; bh=VTfGV+x6Dk3LsYiIv7QnGB3CJZLKtK96j+6
	buR/bUxQ=; b=EuxmQJdRqP9sCQcIDpqvP7X+vF/DCIuVSsJmg1xxEBUI5V0qUhd
	poiAtaD/qzo36dcgOOPwscQMjjwhvbezyNeICj2y5WYsAf21fLd9DvVvbNrDdLlJ
	CgjOfaIdMnkxbnjnCTGkTLFvP5TM8qJYjLtVlYQLyyOlsqdK4rpMhA6wvLJ237DZ
	5GYLjgQMHhvVIukbbyHqr3U0EwNnFUa2yWo+OzrmuPp2vYJkVbirTlO69BPfWjNF
	HFUvrf4zUNQstB1MhBW4csLbUVy2nzh4Rl0ka+i6w2ohkfV2231JqbgY+AznCWKN
	Trnrjty9HeG+uYBl3v5MnxfHKcHK2CWplfQ==
X-ME-Sender: <xms:c1k-ascWlz4CAK_EXjXJHhGpyi8LIOh1dPb3JlLcCjIoLibMwwyi4Q>
    <xme:c1k-alM9blk4EmSTMWmmYktJOSquJ1eHz11N2FAXaaWTx_Ec7SIbpFeVLmU0OWZc8
    uXXJHVH0p04FbRzJUE5VbOlLzIDhli-SRoozTnPPAPR21WPH843Xw>
X-ME-Received: <xmr:c1k-aii8dg_GA0xf_NBferenywFrUIRlDahV1SF0ZmoOjCa2X65KceJOcpuGxFhFiiX4xZIyQhTJJuoDEynkDJGQTFxBxc5k6yJES38V0xs>
X-ME-Proxy-Cause: dmFkZTGO9ypVA495YmJmI0CQg+/FVDSl+S8xRTRP+EcJO1Vf/FbbMMvnhcEDtcUUgYjkoJ
    S/U51DR6HG7BaOHkcTPAT90poyh5FNLB+8K+Soy3tEubF1E+g7FPaJDXpUP1R9OYY/Z2YQ
    h1QgnLtP5ILK/jFdpCg2wIiTh3DBApn1WlVxiGR3fZpkOmmZyEcTqR3YSnImkMt3iRkXQp
    9K4WtsiWBhfneCsaZB/GBfA9oGqkYic67sgxNN1+uhEhnv+pX4+ZGI02Yzbtpg/dCzYbeJ
    q6mUVhQcw/6qiAc82uCs7oTnNSfTvtjBfi4o4TnxMMMsDkmv23st7F65jJ/qo0op9YFpZo
    oqmX8ZkBZGbv02NUs4cRdYxM4Mp5jLpj/qPdxAFEZ49NsF8x2Pz9CcTZay9aip/58jTCSt
    If/tV1CxwlSNy0atROAKZAEL6ujPxHw+4vbVFiCYeNAfeRoJ/Kr7hZVI7MbziGIBahF6v5
    wScu0ddpDBOLLlCqfDa/4Y2k9GuqkfFbhFu0Z9XFWWxKC1lQ5spVQuD3JgXOl8VAidNVaT
    071Ej9nDYPdQJTSOOx13t2shXOPQRo7zXKhBDRel132Lcq/tzhlc6VjvV2j00mL9ufZ3vf
    PgIZVtq91QvsCPzI+DcwZrxPK5yx3SBERl1DAO+ULZ3tSHRpXnpnl/Srt+Ig
X-ME-Proxy: <xmx:c1k-ag0bmkCP5sp1e74phMWxJ5rlf_JmjQs67OvLUMF5Cts2sWXjDg>
    <xmx:c1k-akhoKNklgv8hDuofkGzjB6VesuvwiVGYf9KlL1vt8-8f9caqhg>
    <xmx:c1k-aodk26SJJGyg-QDr7W_9iApiwG1lRhvP1Al31hM7qIFSZQAG0Q>
    <xmx:c1k-avkqGpTb2x9wnxIU1WT6U1WlqjSVoJKu72ninqIsayndWZpQsg>
    <xmx:dFk-amdCcsG7mHybqv8DuKB_CZBZrPH0l6LYnBjAik-2OoL3gHV76rmt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 06:50:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 537a315c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 26 Jun 2026 10:50:24 +0000 (UTC)
Date: Fri, 26 Jun 2026 12:50:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] Why do osx CI jobs so unreliable?
Message-ID: <aj5ZaZK7xylfs4Xw@pks.im>
References: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>
 <20260621213407.GC2297179@coredump.intra.peff.net>
 <aji9MOE-NTHKXYqn@pks.im>
 <ajkEzhdqzmAePk_P@pks.im>
 <ajkGkB2ckf3p43QR@pks.im>
 <ajkOoRhqaAcy6gBg@pks.im>
 <CAC2QwmJA2TH6BmO0O61qRYvV2pqURUk0dTXpkJtb9e-TZNZDZQ@mail.gmail.com>
 <20260626051657.GB3138423@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626051657.GB3138423@coredump.intra.peff.net>

On Fri, Jun 26, 2026 at 01:16:57AM -0400, Jeff King wrote:
> On Thu, Jun 25, 2026 at 08:27:35PM -0700, Michael Montalbo wrote:
> 
> > I think that is the trigger for issues we've been seeing. I spent
> > some time investigating the Apache side over the last week and maybe
> > found a mod_http2 bug, which I filed upstream with a potential fix:
> > 
> >   bug:  https://bz.apache.org/bugzilla/show_bug.cgi?id=70131
> >   fix:  https://github.com/mmontalbo/httpd/pull/2
> 
> Thanks both of you for digging into this. I'm not familiar enough with
> Apache's code to pass confident judgement, but your findings certainly
> convinced me that this is just an apache bug.

The bug manifests both with HTTP/1.1 and HTTP/2 though, so this wouldn't
fully fix the flakes we see, right?

> > Given there could be a potential reliability issue with an upstream
> > dependency like Apache, I was considering what mitigation strategies
> > might help:
> > [...]
> 
> Depending on how widespread the Apache bug is, another option might just
> be: do nothing and wait for it to get fixed.
> 
> Trying to make the wedged state fail fast and loudly is mostly just
> punting on the problem. We'd still see spurious failures. We've so far
> resisted the urge to do any automatic flaky-test retries, preferring
> instead to just try to root out the flakes. I'm a little hesitant to
> start now, because I think our strategy has mostly been good so far, and
> I've seen some horrible counter-examples where flakes and retries become
> a routine drag on development (and I'm afraid that accommodating flakes
> might make them more common).

I agree. I'm not a fan of retry logic, as every flaky test may mask an
actual bug that we haven't fully investigated yet.

> >   - Make slow tests faster by optimizing the test itself and/or
> >     the test runner configuration (e.g., job number matching
> >     cores) so wedges become less likely.
> 
> It sounds like the bad state is triggered when Apache hits a timeout,
> and we hit that timeout because the system is slow or busy. We could try
> to make things less slow, but would it work equally well to increase
> that timeout?

I was also wondering whether we can maybe work around the issue by
increasing the Apache timeout value. That sounds like an easy potential
solution to try, and from all we've discovered so far it doesn't feel
like this is something we can address on the Git side.

Patrick
