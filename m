Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973436923B
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343192; cv=none; b=qJyMvFPQvFhn40yhoqrmqhKj4c9/ho0CtHLK94EJRw4h0J1PLPQFihRfHPTVLa32iYZBtuAVbLQSwinnSo3mmPlh7kalnoVj6NDOKPjpWFOeApBh1pCpit6lsEY6rpjim2bcGnZyzB8lOGHQjkumtSVwSLSCMLd9sZ5xsBydQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343192; c=relaxed/simple;
	bh=cHIMpglzjGj0gVmAJIFhfhhFLpY87sQbp0ps+QZaUuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDIgTHmi28B0EaaGlI/2fYMBlPdCarCQE9wdKKNQTcnhwx/rXoHb1BOchsWaXCUk5eHi8/IAQM3TVEZ0XKyQ/+XXzpTjuvZaWrqQza6cDfardCoIAuW5fD1AzaNfNPH5DZfn3gVxagz5TrkSy9KzJS4r/NdTLDnn3f2EZDulXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wxxkxN+T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DwDKcS8z; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wxxkxN+T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DwDKcS8z"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AECD41D0014A;
	Wed,  2 Sep 2026 05:59:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 02 Sep 2026 05:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788343189; x=1788429589; bh=jiFo8b5OkU
	5F7sBRLEsuRR+osSYzTZYAskJSQfcRhcU=; b=wxxkxN+TShUQSatEbAn0mkPkvb
	8m9XFe+lfM7ojVDSEdZ69WoaLqMhG+Muvrc7J5M4jQltkotIc1H9TajdPpD9tu7B
	65uKcoDZrfHbsGmT6Y/Cb8VDnIcI+gVc3CxAL6/0JtLob4/3FsFJXuKxqGAjtHN1
	NaCN4w293QaWzwRN1rhI1efv5SIF29o/fvLR+qKtGzIYLR5yMuZraMAoW2+/mYBS
	DpHH78lpIYGPpAySPlymE09KLLPp7axd6QX6DHtBdocC+1JKQMajr4gkRjM4hjOF
	sh8NiOao64j9r/lg85VRrfsJhd3vw0lsR3aBIDysM1iSWrvuov/dmw3Cj2KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788343189; x=1788429589; bh=jiFo8b5OkU5F7sBRLEsuRR+osSYzTZYAskJ
	SQfcRhcU=; b=DwDKcS8z9DS1lkLKeA919kz9tJWckG4L/UfjCtOqUe3/91TUIBy
	1FCGY0sxPCoa4SiB2LInOHPwRiBSbIrvGDLPUYUO9MsKOAl+CZkZguLkNsZc4gPP
	ejbIhfO/jruNh9yRnKSPVCPT0MknVbBEgth3lDsSfF0IlVvEZb/XKFGZLqJ/0J+k
	Yb3nejjN5HKAlFumVHeUBDTMipu8YfFwoFPWICyTVi1k124dW+zosYJAe/516xLf
	y1LWN1/NBSJIAO4wLPNouD07IS9aaKr0dlxBlNLsD36NBOH6q6VU6WwxxpSL1eQp
	29XlU4Z08hFLWrFbcVZRIXuFNE9K1aOXPFw==
X-ME-Sender: <xms:lfOXakJqiEPNkT2QNPMWPBKQfktPoW8xoDi94bDF7C6lVbDGduuqQQ>
    <xme:lfOXarJKk-RoeNY-U9TvTwhCsRUGK-gFvwM-z8S_MQkq5God0YyQBPnxnCl19PxhB
    Exq-YJ7RHYT2mzpr5QYnzrAmqnsczT863COYjBvGsNesw8jdOzOW6I>
X-ME-Received: <xmr:lfOXapvH1E3o7FD3X9Os1LnUUIiFrQwgfzd_wcgn9CCecBhHAE152jnLvi6SeqGOgtfI6Z4>
X-ME-Proxy-Cause: dmFkZTFqrqtaLRuMgBYUFfAbTvfvtf57mMbbSLCdVWOy+uZMl9SoPT3qACQttnOGvRsr8V
    AAix4HKs+ckaKSUCNJso+pVL33q1NQtTuQom2u2DGmea2mk+YhgfXCsOwvSUod/BNZzpnN
    nZb9kx+RKv5xKgPaiyDZIaZzzYDZyNcoK2tjnDKGwtdVC5bdWvyL3/9z1soL60K/2jdGIr
    5XqV96lV2wVm1lJdQGSPh6IweFZCTacVRLV6/qBO5ro2YUTS5h5E9PXLwc/9ITNQT9fLKt
    qOCTX0hM7xD866Vm0W23jci3zs5fPHd1RWQVCBg3WIplHL+U4rQKpzVtwTFpc3WcWdp0hF
    yE8AOrHoJfAHZGuoyj2mwBrzap978+KNx4b9q19jM5a+gAb6/9N9eHkqYtDyAKEtao4nlp
    clbYb3ffcejyUg6kRxOcF4gWRUGnG21n1AZttH2CMMx+znRgoJsg5vLP6lSnRnjYL3Q8c8
    EZ+owx6YJukgGNxkHEAja0YAMyQuDDJMxw5hnYdJFebyD6fMnKngfw/9b1o444D3NjaPeP
    lZOCV0f5H+6d+xIJMW/eq0XPQO7MP21twgctOrlkV92K6m3iBRV0al4y5HFPfrlTCvKdZ5
    xqsrNx1ct52EKURwzbw+85TtNmLnHEaysmkC/q9OaPZNR3hPPS1cOTVbPi9A
X-ME-Proxy: <xmx:lfOXagRN8pT48yyS8hEMv1DXrlfm0OZFRf9y-IZAJNoLVxCFEbcZ3Q>
    <xmx:lfOXanOYTUGwcYwCt1zzQKEQTU3Zr_dpiv-6ZPAlqr7EcCpeNeW5og>
    <xmx:lfOXataImxcPgzbN8o5vyxt9F2svPT6TXtzfvX_QeWctZR9mN6VBMg>
    <xmx:lfOXapyaXAsf3ymHN6tW16sPRpwj_UiBEUIfD4G-Mhl4wf_K5E4Tzg>
    <xmx:lfOXagCoO3KjiA_YfTILp99Ozos8orDfkZQ3GClN5KSMtpYdc_yxBiKE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 05:59:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 970f4b78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 09:59:52 +0000 (UTC)
Date: Wed, 2 Sep 2026 11:59:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] ci: use system asciidoctor
Message-ID: <apfzihj-1YAhn5lT@pks.im>
References: <20260902071113.GA70165@coredump.intra.peff.net>
 <20260902071613.GB641414@coredump.intra.peff.net>
 <apfWhYF6nmcFGKE3@pks.im>
 <20260902090146.GA1791728@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902090146.GA1791728@coredump.intra.peff.net>

On Wed, Sep 02, 2026 at 05:01:46AM -0400, Jeff King wrote:
> On Wed, Sep 02, 2026 at 09:55:49AM +0200, Patrick Steinhardt wrote:
> 
> > One thing that we might have to worry about is compatibility with _old_
> > versions of asciidoctor. Now that we're using a more modern version of
> > it we might start relying on features that weren't available in older
> > versions, and we wouldn't notice anymore. So we kind of have the reverse
> > problem now.
> 
> Right, this is the "we could in theory check both" path I mentioned
> earlier.
> 
> v1.5.8 is sufficiently old that I don't think we need to care anymore.
> We can still take bug reports if somebody happens to use it and finds a
> problem. Checking other older versions isn't likely to be that
> interesting (the next version after 1.5.8 is 2.0.0, which had a higher
> than usual chance of breaking things).

Yeah, I agree. We can still reconsider if we ever hit a scenario where
it caused problems after all.

> > >  Documentation)
> > > -	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make ruby
> > > +	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make ruby \
> > > +		asciidoctor
> > >  
> > > -	sudo gem install --version 1.5.8 asciidoctor
> > >  	sudo gem install concurrent-ruby
> > 
> > Huh. I was wondering whether we can now stop installing Ruby altogether,
> > but we still install the "concurrent-ruby" Gem. But what even is that,
> > and what do we use it for?
> > 
> > It's originally been introduced via 974cdca345 (doc: introduce a
> > synopsis typesetting, 2024-09-24), but unfortunately the commit message
> > does not document why we have to install that Gem now. I couldn't find
> > any reasoning in the mailing list thread, either.
> 
> Er, yeah, see my cover letter. :)

D'oh, yeah. I somehow skipped reading the cover letter altogether,
sorry.

Patrick
