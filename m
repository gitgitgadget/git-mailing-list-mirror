Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52F0480356
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961393; cv=none; b=uoTiC6uIXxPDlVfBqrL+NP7HEEKglW3pgxSbFyLy/j+L3cwgcvkPhjkdS26X95NuuKyn4Zam3A7SPIDd8K/fQ5ZsGQU+lb9N7jbDYl0DYm9XEBMhA+7aJt7leRdm9IPtCq0RgNxC3p8bNvSKCVB6tn1w2Bfip6EmxkTgwp/NVVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961393; c=relaxed/simple;
	bh=le/0IyAINg0brE+nT7PuOqHyI3jps1I2I2+WTAsYNMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAGL3eczZdjXdgdgi4DvvhE8Y20U8FfKCV9AXShcNUJR9YPY9+Q+yUogRGMR1JdOdVTE3byZm/6jMesnSAgbuQxtOtVCBoHTVB6Cfp0/qBwoMm6H2FPBWaoGeDyChalWOhpGjyuh1i5MSj5gCcuipK362qKr9IGDgNueWFc0rwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iqGm/txo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sdci4qkX; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iqGm/txo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sdci4qkX"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C85B8EC01F5
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:03:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 14 Oct 2026 03:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791961390; x=1792047790; bh=LUTzkMjkjd
	NJosJNfceVzDxPijWjReHVDNiOznBT1Zk=; b=iqGm/txoaMKfWNL3flKWfLHaXu
	Co0vvN+8/3xM4cZ3QZ8YIJmdeWKod/jb73/gtDx774ZwLT1s/PbYnfuWlyGvqW8W
	L4DyaIPMxTDEC3F1lX73HeeGxbhWdUInBNy0Da2eXEvKtLQJrEmgDtcG1z2Prx4L
	+sjRlMDO47+rjUfKEvgjIso5QsdliKx1u+ubKoExVlC+NhbxNfL3VV74VJpsXlAL
	GbndMcqQv2hpox70fYXKHuComAZdp9hfsGcKQupmtDRAJsh8HWzbHTPGGWlcGd+l
	kvtyzQK/pRB5CiAsz3JekJpI449vM+qPNWK2YyY3Kb7Tk/tky2Cmh2Ok0MUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791961390; x=1792047790; bh=LUTzkMjkjdNJosJNfceVzDxPijWjReHVDNi
	OznBT1Zk=; b=Sdci4qkX2C5+i7xrlXoXemjVfaICWr2xZ8dVCX3ACi40Z6aMuML
	91gNECUcjeYVsiRHY3TXzfpg5ulnTt46nXLz2ZXnQGwm3lZINASXpqKhjyTp14kl
	ontgcBi/+0afJxygFd4Aa+I6e6hkQFUYmslWmV4VmyarGHxQXSHMsJIWxSREOE0j
	tb6ECsnoPaZ5cGc2fJzHXD1wQ8pfLYTI/IL6SClGANtGw+dgwyXJAH8Dv5FvRGk4
	+GB2eC7Q5H47htvahSkSeIHuEbLbaRwQx+h1W6E1vTRrlSGZwpEFBDFO3/VUcidk
	L1Ut+j99B7faVLS+VSAeivMtvAy94JBXaZw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791961390; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BV5dH1LjdDg+GEcMxifrt9faljR5uo3z3kd8oBfK5PbbUUB
	vE835C0A+jbZtsbNxzQU1UY1RW8aIPklyspmDxF7JpRfITov+66JZkAiuImASHzi
	KfRSSmJgLhtDNwSIqM6+hKyikGsfd0VQQYoinRq72w6mrum4Y1qYtZREzkP2Qr02
	Hq9EYltwYqc5etI3vgHYJ1xHxvlfyL9+lK7PTKta0vMMMPdxLxR+SHoeS2sGIO+1
	kYB6+BZpfFWE6DKh3hgaVA09F8ZBc9NYvhSmrNepmczPuTO+XXjhAlNYC3D2nOAK
	m3+HDm8CJCL0r7h3qvKOX4ZzfKAgzIB1WggMQTg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XOmFZD41J88x5vLa2sAZKY40zd1aTbX8GfQkObT/rfY=:le/0IyAINg0brE+nT7PuOqHyI3jps1I2I2+WTAsYNMQ=;
X-ME-Sender: <xms:LinPalQ2tuYtwLCwk3cIJN3XiAOCENoUmp4RHeovotYSR0-tXW7vfg>
    <xme:LinPalqAAfny5wEPKqYGSxid0EiLSxNo2SKQ2KnMNHf1zAaelsIixqd_ccD4KK3f6
    jtRs-iayx9W_f9LRIhNfEDULqKeNR6w3MmmmnVsfL1hwdrVXo6_RA>
X-ME-Received: <xmr:LinPajIV_2AFGTrOEzQNmUrGjccVQRg1gvJLJrLPj_bIoPZQnz44xg>
X-ME-Proxy-Cause: dmFkZTGoeiSZS0vzMY4SpiAJ8JUjangUU54iRhE8xWzAdr2hHl2h8cPyVAcbKYHaajngUR
    zQDzU7V8RYWrGtxsn7yhfeUE8qgzHlekmajk7A46et5Ciu/B43WNoJWvYK+wDc3KQj6K0p
    YrBjLrx9Gsrj5QIVIcztQ69uUBSTD971TSkr5rO81LnFmAUbkLsduQA1eIqejJpTisNZhB
    z6+x49be7+1iJHFFRIbfTv3PLLNrjvJailvMat2izLaDXQkgq8Er1nVyYSMWoJdO8h9XZy
    dbjkihn2EZWX53Kh6jukmQ2elG7+485eELR8P56D1W3QH15xVXPtkmb7cGz/Rg677C0uYx
    ZpolPFL2zlwKobrcgbzS1dMU/KaOh6lOeMzPKCJGwV6nDV/tfLnVRx/c1sJjmqBOACyUkr
    5uM25elzBgIebp+PGq/I2Revca/3IfSjX5amEygqIYvdbL7gOweyH6bcsg/PMPxF43bAJP
    hXDx4imPBT1k4Yv15Fq9KBL+fR4PcP0SH4Q4xl/d7SILBl+u8pUgkKXSEB5UDJoWrLEYFq
    5/8jpCeGJBiHryFNFriW2IsBS7rTyYLA2F3gKgYOBbBFSGcXMES0UdxiRfP0mlirOr3Zjr
    WtJiD7ZsNBK0GoiP/DkY/9uinIyllRtbZgI0+RUcieqi+BDuuPfBhcjGZ5/w
X-ME-Proxy: <xmx:LinPaoocYOUXjCvKCTfVZDciq9H7XddylkdIjM9GEtfE0L3rwTdzKw>
    <xmx:LinParzf3TPhp6pyv75dpILB1RDv4jwOuIL8Xq9RQwJtltwQb-bcwg>
    <xmx:LinPasOEx7lS3JMYe9JAqQQs10IbjJ0RouoRwFgVL1QV5C22GSmb9A>
    <xmx:LinPag4BOC8FeDTDbrpTPU4qxED03qkWbs5IgFLws_ycGIPdenUqPQ>
    <xmx:LinPalJ-BEisVg2GdmCxuCCdveMpu0P57gnaiys87C2v68KKsKQX14GX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 03:03:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e6f4691 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 07:03:08 +0000 (UTC)
Date: Wed, 14 Oct 2026 09:03:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v2 5/8] ci: rename linux-TEST-vars job
Message-ID: <as8pKXTBC33_iQxu@pks.im>
References: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
 <20261009-pks-ci-housekeeping-v2-5-6863d58ef691@pks.im>
 <askI1DGldZx8ElIN@szeder.dev>
 <as3b-u7SzE3uPwQx@pks.im>
 <xmqq33u91wu0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq33u91wu0.fsf@gitster.g>

On Tue, Oct 13, 2026 at 07:47:35AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> Seeing "linux-exotic", I would think of a job running tests on an
> >> exotic Linux distro, or on an exotic platform...  but it wouldn't
> >> occur to me that it intends to set a bunch of GIT_TEST_* variables,
> >> simply because there is nothing in its name to indicate that.
> >> 
> >> I think this patch makes things worse.
> >
> > ... I think it's still a fair point. The question is whether we can come
> > up with a better name then that is not an eyesore and that gives you a
> > clue what the job is doing without you having to know about the
> > underlying mechanism.
> >
> > A couple of names that come to my mind would be "linux-nondefault",
> > "linux-optional-features"... and not much else. Do you have any
> > suggestions?
> 
> Among the following, my current favourite is "feathre testbed".
> 
> == Feature & Capability Focus ==
> 
> * linux-experimental-features / linux-experimental
> 
>   Directly states that the job enables experimental features.  This
>   is clear, standard industry terminology, and avoids any ambiguity
>   about the Linux distribution itself.

Not all of the features are experimental though, so I feel like this is
a bit misleading.

> * linux-feature-testbed
> 
>   Positions the job as a testbed specifically for experimental
>   features, which aligns perfectly with its testing nature.

I like this one, will adopt the naming. Thanks!

Patrick
