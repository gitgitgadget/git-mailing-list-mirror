Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C427A4052A6
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969655; cv=none; b=LufFA0u1Rg/vz5vhfWQzgQszn5A7mAN7uBfdVERpAZJHg7VWFzqww7yiSlhFDrOMgi5nNCqosNUcQZoIrTP541J9KzHoTXpC2mZLtTIEnXgYua5SHbw3qVqb1OGfFz9jFc+8O+4XctU/SuybUe2s2Q5CPOy5T6AMZp1nMHLD8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969655; c=relaxed/simple;
	bh=lHLr5UzSy0m0M0QL23m32eeS9nbnv+PaCtDnX7scxxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMujDYWl9Z5cRw6YpPeUnNFM6xwEIIb3qJimySB7LJoW2EYnLokbVUxD+EX1VraFXlJpJ6AjvjntnByZmCz8nRJWNMK3vGkF9OKhnMXWHyqnGGE1NQiTW0UvoA7Qd0a3Lfmz+B0rTk+Mb3kb6ethInCJ5TzrK82aRxK2nVvKRZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I8YuzN4q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RGbXRdAW; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I8YuzN4q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RGbXRdAW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B5EA01D0003D
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 15:34:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 02 Oct 2026 15:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790969649; x=1791056049; bh=QW9O2+sqvx
	txK/wAel6h6mpinqMsqWFsXmY+KTjSCOM=; b=I8YuzN4qGFTj3fjQXKARfDqw7h
	cBk1M7ylEwvJmHQ0VBvLh+ISgvJ8Gm8RULa+fDfFJm62lAzJY5mQCUSx0OHhrWRe
	YYZskA1kmw2piVp2X6Xpjuohy2/d8t7HFPidCY0CjmR3RUBB1K+mrQ+e8RpUf2Hl
	5E63zs840O9GAHSeC1iAGh2dKkQm/DHi4ZJ8YElwN3dqC7oFNWrDYf6iF00LvcZX
	aHJPTD0hrd9lRUOItOuOwzFacv2zUmDheIwpb64KpRdQxalycWigpvBKoRenh7X7
	kITJ/dqp1e7LQyPFTe0xXls1j0VDUF7mVFRg2OYPSgqUF7X3TygslvjiRfrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790969649; x=1791056049; bh=QW9O2+sqvxtxK/wAel6h6mpinqMsqWFsXmY
	+KTjSCOM=; b=RGbXRdAWysVInUeCxF2ELQvLPoC9DZ130nx3vBZFgYuhsaqFkBE
	VW7YBwuQQCx75XZ5Oe+Z89KUPygCe88arFhrane9HjTbz2X1X2kIOy7Tu52q82Ma
	dvMrkxWhQyR6rBydaeTe/vU2D8+WJPFfe3fe/JnDSx3Uz1hXLfQPPJwZTXDKX22n
	ZoMTbx5EHKbJutNa5Gg70uWaR1SMLzRDwkzgh0+cuqwAtTPOFZdOpf+UdinNCRSZ
	G2Br5cCnU4tGmFpsOzGK5J0PhPMJrhql3o7vikgmx6505vpjOCww0sj0t85qmQI8
	NnBd6gGoLXaXKOMlwM6YJlaSVGYHktNqfZQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790969649; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LXn2GaJFegyeLfEE8TzKKGjeKHCjt2aq2xJKoRO+A1pr+Fs
	R1g7iaXUZcaKGo/5aT++3FppW3SrKpPHngBH6FVfB6VeJe+xX9wRJhfyweXJFv38
	xNtK8bnr/cRJOGvyvwQg8TGGjfp+CYJfY0RgQyR2Bj2SRyHCmp1rQjwYz3NsfMTO
	5pcjRIUMUCcoZDXtgBALXkjE2KoavvQPBHJ9TxEH+luBqkEGPg+4NlUtnfRHwPIJ
	khHPbP9tOKSeNB4n0LmAbK20lQz7oWo3chvj+YJRAIO9REQG1ATMfdMD5cepNemW
	wCOQ6BjSijpIjsoBZGVDnOLrRzZgyRK6OWeuB1w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:u0IXH8VVzq+b3TgDLHjVmc3NCfzAphxqbYMUvR8alto=:lHLr5UzSy0m0M0QL23m32eeS9nbnv+PaCtDnX7scxxk=;
X-ME-Sender: <xms:MQfAaqzWWQa5QPL4BXu3OgFAp9-IEFTKlZBfHwNWC4okZrA-6EZSdQ>
    <xme:MQfAatvmgCttyyFKVZNoOXkwOgHJ9vq1jBKXECtxJX49iFcTpjesBO4YyFPfghcge
    P_0E8TmzzsR6fPI5xlHCDskuVHRQRogREJdGhu4aYYUBN4St6Zfy3s>
X-ME-Received: <xmr:MQfAapsVrUUmPevNym9BJDstwOmSNaApx4gs4rR6oYecOZgS182gGg>
X-ME-Proxy-Cause: dmFkZTGgvJwJcxhy2k7Kf716imikU0fEVVfEJhUVT1pEKXty1xCfN+k+MR98q0K1ucnHXN
    JjCrzIDh5owwg+XSZO/JJynOW/D/QZB6hi/9yG1lZo1MjKg21zHGgdF7chZa/2rLS2awNk
    dtNZ8U9qPPfpYVcSAzYn8YDv9Z6oFT1xK14sW6RTjAKVSuib2VmT587eGVOH6wiwYqnP+a
    ydVk7+J9/IhTMG8eEgf4afIRTCahqHLaocs68Wws0vnDSlCs7wpPr9XIaakGItduOEotaC
    levHpg+DgnYSx/sV/QE3hjxbkUqjOD6Uxz1RgEzhwZLB4Xqs6y3xwToi2xq/ZF//LvMDIb
    b2Q7JFZjf059KRqfCWrezdtg2mFIyN8F4+dXwIdnSE6NVXf9q/ftufFYl7Tnf1LengMHqd
    7fTR+D8UPrX7Q1DTNKbUhbXctFHWmibBlMSy1KO72uZ0qoUiFVB3PU3jsXxPvxhGgB53n5
    vIw1YG4TdMz1x84byPWhEeDILqkA4rc/bfgvAvIFTC5Ecj0NttrI2ByK3jigNbKmV5leN6
    9xmGsVWIBk4YS9GEK5gbldqgkpsiy63Ux33/KBX4KiMS74jLdjmhSSnxA4A+vzYW+mB1eF
    v59udGcRwYzFTqmRzKF2VDYcPgxWDCgADslCAxgfC36sASHmblUULOaq81iQ
X-ME-Proxy: <xmx:MQfAaqP4yWloyf8vki56itiIIFqdOvnYxHO0k-lbvOf3cBb7TsR5iA>
    <xmx:MQfAav3KBnsPwIihHtumvtkziQBt8Qa-j4sNv2wLOHMOTW-MG-9j3w>
    <xmx:MQfAauM8EQ6Jsd44jQEsHSCdqvzPNttJaDg4UAY7N2w1FSn5ekBw4g>
    <xmx:MQfAan3oIePzO7yGzFuiTf3Q47i-OQ5UtTz6vxlvOem2SRJV0mnyZQ>
    <xmx:MQfAatJ0Un4M9WTDwH_J9QyCMLMk2f_yOCvw9F_WHvDpAl27Dx82eqfb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 15:34:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 035fc421 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 19:34:05 +0000 (UTC)
Date: Fri, 2 Oct 2026 21:34:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Guillaume Chauvel <guillaume.chauvel@gmail.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/2] packfile: fix corruption due to stale delta base
 cache entries
Message-ID: <asAHLJvsz0gpSB7j@pks.im>
References: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im>
 <20261002-pks-packfile-stale-delta-base-cache-v1-2-7592a3e31ae0@pks.im>
 <20261002133405.1284-1-guillaume.chauvel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002133405.1284-1-guillaume.chauvel@gmail.com>

On Fri, Oct 02, 2026 at 03:34:05PM +0200, Guillaume Chauvel wrote:
> On Fri, Oct 02, 2026 at 09:34:07AM +0200, Patrick Steinhardt wrote:
> > Note that the added test reliably reproduces the above bug on my machine
> > that uses NixOS at c59305bab206 (cosmic-applets: add missing runtime
> > dependency (#566040), 2026-10-01) with glibc 2.44-25. But as we rely on
> > specific allocation behaviour of glibc it is very likely that the test
> > will not work on other platforms.
> 
> What about forcing the address reuse in the test for deterministic
> behavior ?
> A test helper can close a pack and move a second packed_git, whose
> delta base sits at the same offset, into its memory.
> 
> This was written with the help of AI tools.
> To apply on top of [PATCH 1/2].

You can do that, of course. But given the amount of code that we'd have
to add to test for a very specific edge case it doesn't quite feel
reasonable to me to add all this infrastructure.

Patrick
