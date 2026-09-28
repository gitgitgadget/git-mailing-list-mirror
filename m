Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508240E8FC
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578394; cv=none; b=d30YyhgmDBDK434aZEMz3VYya4tC1BD7LMU2c37UPqeSn/IIglTKpZuOdcN9EEPitJ2sZnrGhSEiby3/k4sNOUamAd9f8VhNMUOnxOVRc1xhhuzpxvAUhBL4xy9It3zuvaXs+FLQVIqGTVTh14/lFIgTnqUUinPzopzEaoJztDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578394; c=relaxed/simple;
	bh=xegLRVYmPQtBbmyKogwqXCILbN8T1rMp2AjXNoRvB+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBHPz2fS3RLXpgE3GvIzhIvd27cSRumSd02ah3brAwvOC086Vz8/RqEps2uWNoPTRN5zW3kSV3FAakw0A+zDtQoyyUhtdfwteDJnxsH7kSzy3UKwB7ZzMtud0FIQ+xlhxWg8NrlUW4WDfWBjeGyJpkWdtyn9PvULLogzGNRUEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YnCirsSP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=skgk/H1U; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YnCirsSP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="skgk/H1U"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D6C914000D0;
	Mon, 28 Sep 2026 02:53:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 28 Sep 2026 02:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790578392; x=1790664792; bh=sItuQsSeGS
	qZN8zDHyLzXwZsXq1I2bprmZsNF1mV0ds=; b=YnCirsSPy0uiOwqR1HwK980nCl
	ZJolqLL5b1+3rmWUlaFCtmb6DM34OdqoodNgnwJRlR1PWp1GB+nB70+C/yqnMjoi
	3qXnIHUItUeH17zgUGDVB363kYkRepBZi2cOZpgfWLwn7+sMvRkvdPsRNuNeB+w3
	5zkvtGJFAClNy0VeKqZ166be7GYZ+xR9ODP1kh6kPuq98OG/5kv0BwXi0JHcRrDH
	lzZcjuM4DvBoVj0N7Xa5IQhamSfvpqzKgiZUnCDmTu5/MbolqhP5b25KiUnS/cnR
	14JxXnVV6GTA4B62aTNkEPKhjcgHGlZsel/rKuYVwd1iX0hFFMTXQ8SiYCEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790578392; x=1790664792; bh=sItuQsSeGSqZN8zDHyLzXwZsXq1I2bprmZs
	NF1mV0ds=; b=skgk/H1Ux0OMhciFp8QcdUMuRTnZ+SzjYKeJVGPugr4yZi88HQO
	p1RB+ekMAaLS4gGb2ZjUQ3gXT843H93EGG839FTwFa21ZVj+lhJz+b6cCbc27ab3
	GJ4LMcHNQvyH7rG7J7y9x3gNjFifjKgsNkL+bqNL4FXzEbkhSjFAvaQCXuLkvlsP
	n+1uZY8aqxYQlOZNNHOSXDCDtYunX5spixf6sKcg18DsTxVXaaCW+UqvxsFLdy+T
	bL0E8V7oVEVz70Z20bAm0jGvFNi3d5fNRNAzX5hsMNO6tHwJTrq8I7E3YqitdXIS
	iqgjchtF8ojsfamUDoYi8dwJCjCjgVPXpZQ==
X-ME-Sender: <xms:2A66an0hWFi5W6nUEcb2WGsjIhAweNvxwaIpbJ4GMMe0O3fDh8vbyg>
    <xme:2A66as92BSyFqK2uIRJS4tYUIArpVGLmFMhWSTDv72qJ0HAQZYLoVFc_DHBECWRyL
    n1xdIPUfuFthn_lsPki2GIf-ahE-Uv9WKoB9R16_rKt-QWMncWOekU>
X-ME-Received: <xmr:2A66agMj-FLd4q1rPnN-KJIGFEdveg8Bj4G4ZT1Vn7LY1J8nMBftAg>
X-ME-Proxy-Cause: dmFkZTFck/jGvgs+JBtOp18PEmSiL76iLC2NeSRRyB4ZLcDdKAhRXw8EbE/WfLDXPYwF4B
    rE2PPsdyqvkN0CjzuVSndRT9b8X1/XPkzNAdBeP3QjhXf+6ygvCt9RULmaKXi2XTEHY1Ik
    38BDyb1bGAntDjdQt+A45tyAuHgU1hMGEEP21y6qY6JsCavNuakEhTRMGgtRJg7Zg5uPAL
    s1l2O3RLcb4hysbysagOgTGj4CRe2GJlw+Icib6aHhqySZsBblfcmsqlAUQA+NnfKq+bnG
    s1qrrZbYnuMeUMS+lyz5fE301I03b1R0mMouc7yAb3casNqaTHD78fJYrxwGYuGDOOlgnz
    uf1fy/59Bl9Ms6febVO6dPMjXZbqR6hDePyHBzFKyo/TZ4sPSX+CaOuTcFNsxBbqO/l43N
    /Wadr7izafjRadp+CJX8mz5pjSI3467GShAmP0ZVcl7Bd2pEl/MDxXgBKGrzeQlN2qpLej
    WZynSF2Gg9Yc3cVCrtcaRhO/9tDEFrKJSf/WOZv4Bi9MWWdAp4mqkI2ryTMg92AWRnxnFl
    FBufh80SafFgtyUM/vFTQy5+f99RlSb6GzeovGcpVcbZx0ssHcv4uCobE3wXRFOBFnrx2P
    WQlo8RcCy7QS4Poc2+Bc98TlH8YN6fpO01QudSarNNKssIMbHpZb5Nrqx3fw
X-ME-Proxy: <xmx:2A66aofEgKkksstBNhwyQ7EEQQObmtOd9Yliv8d6Nrhd7OrYazP1NA>
    <xmx:2A66anW07k9d3T633F1LoHsOXcVvuLr6W4faVQ0SpHJpjHbTfoE9oQ>
    <xmx:2A66aohNnFRkjWOSWbRR5sf-XqifhYj9i3To07Csktl8vgKNaNV5nw>
    <xmx:2A66au96zjNNKk7pnBk2WuCWgALTwrCACwe_TKtDluSipRDknw8SJw>
    <xmx:2A66ai75uM-3xdvasbPoGOOtDfVikUwnlR03tCfmmmF9hOPxlN1o5WxK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 02:53:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7189cdc3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 06:53:09 +0000 (UTC)
Date: Mon, 28 Sep 2026 08:53:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
	git@vger.kernel.org, r.norouzi@proton.me
Subject: Re: [PATCH v2] reflog: fix default expiry periods
Message-ID: <aroO0x0Ptp09ncx_@pks.im>
References: <20260922165433.591551-2-pushkarkumarsingh1970@gmail.com>
 <20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
 <xmqqpky3ahvo.fsf@gitster.g>
 <arUvtE67n5_MFM4C@pks.im>
 <20260924154659.GA736248@coredump.intra.peff.net>
 <xmqqecei35n2.fsf@gitster.g>
 <20260924184331.GB747880@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924184331.GB747880@coredump.intra.peff.net>

On Thu, Sep 24, 2026 at 02:43:31PM -0400, Jeff King wrote:
> On Thu, Sep 24, 2026 at 10:45:21AM -0700, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > > On Thu, Sep 24, 2026 at 04:12:04PM +0200, Patrick Steinhardt wrote:
> > >
> > >> > >  #define REFLOG_EXPIRE_OPTIONS_INIT(now) { \
> > >> > > -	.default_expire_total = now - 30 * 24 * 3600, \
> > >> > > -	.default_expire_unreachable = now - 90 * 24 * 3600, \
> > >> > > +	.default_expire_total = now - 90 * 24 * 3600, \
> > >> > > +	.default_expire_unreachable = now - 30 * 24 * 3600, \
> > >> > >  }
> > >> > 
> > >> > and the fix is very straight-forward.
> > >> 
> > >> Is this something that we want to fast-track for Git 2.56?
> > >
> > > The breakage was in v2.50.0, so it is not a new regression. OTOH it
> > > seems quite obvious and low-risk. I'd be OK either way.
> > 
> > Yeah, I didn't know the breakage was that old.  Perhaps not many
> > people are paying attention to reflog expiration?
> 
> Quite probably. The default expiration dates are somewhat arbitrary, and
> the reflogs themselves are somewhat ephemeral. Probably people would
> notice most on stashes, but those are also somewhat ephemeral.

Oh, I didn't realize that, either. In that case I agree it's not
necessary to fast-track this. Thanks!

Patrick
