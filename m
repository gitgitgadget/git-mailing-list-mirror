Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3D9EADC
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 05:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791350974; cv=none; b=OYD3GlykQ90RDwtw6BcsDS7GEWBaQC8NuWB5avin+dKaHXEjU5K+ST5ZLrnMDorM3LxVYrZrPGuTdqJ8x1jFSmQeGT30ImZVakfDHe5qHh7IujoYVhDBrMBWYM/3/FFt/gg+c+vk+2NbYwLf+cp9YuLr8d1LlArHUr79r6bVhK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791350974; c=relaxed/simple;
	bh=ZgmgDYD0VV1oXqO2SZ1xTc/ztxdsLD6rJ/4CbP9Doqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYkgU5xkAUgGtMGxm2qu99xH47UgFlFA6HVGl6+SqSmskCvJun+UPx1fEzoAopko1NN4BHi0+v9NIKUrqPg/qSUeRFKiMmsVO1bRSYXkfGzJL7ZiWtETBNnQB+GJTC6bP461Dn9T42HiykONHeKGYexCea70fM54xqCPunVbAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=chjHf7SF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kPcsc1z6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="chjHf7SF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kPcsc1z6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC91D1400150
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 01:29:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 07 Oct 2026 01:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791350971; x=1791437371; bh=tPsCVEtBIz
	M0RX3KmJPZzs9+S6NUgZkL7dZZqCRaY2I=; b=chjHf7SFNp8Oxc6QilSa31Iffz
	wekCMtPG2uR9su+bMEkI3G00VQykUuhF0qmlouFaYVFj/mORvypn4Gb4vXBUyzsP
	1HEF5AS3P4dZvTEg/cz+u+1ucb1hB7pqwUhj9nIgGafoLOJBUiHkfN3tcXOyvtjt
	YAWhawPiWJfC3I68O83JDIfGPgC/H196SMpFloUisBGntXSyMZATMDY8tJr7am54
	1Em76YfIGFi3KC54T9QMvnYXiD5Cqje5fQsRZGZNfBjRquGAVNJlTDY2S58wOePZ
	HN3QjUqrkwuBJgjGdahHAFaPqcIX1OILzn8Qrgd3aAehT7kf45tihs0J6U9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791350971; x=1791437371; bh=tPsCVEtBIzM0RX3KmJPZzs9+S6NUgZkL7dZ
	ZqCRaY2I=; b=kPcsc1z6YwXN0h03VdH5uNVkj558R2bAskPJLRSCekVsrOqrIoN
	xnoBliYFaDT00iNgxzW09WNtrpdW5DEinUf0kTXQN320o0IXIcYxUGnKGkeUevsC
	ngNVjzZUAxXIY4BEPzQ5O3MriVFxbkOumtgo9NEAP41NNkp0UoJU62CtHABRPV9r
	vsVGu1Jnqgc0kIVB9Ts1F89c2pAFPJeG0lkXtq51ftYLMS2xJ78lMW9fSeo3FIEL
	iZAF2GkcaHDcYxrgiglpaUKzECPv9XDoQU7k6ODriv0Aw/QElzpJTm7UkaF1jZKM
	Hnd+MlptK0yjBmGqug82jxne92NGOthzUvA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791350971; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KoITfwqfmQWAynI4JT9Qi0y0zzndkjprSUtx9s+YpYIYxBO
	uoqV1veWUr5L0Skt2yrOkXbQe6h8NN6uDCRkoohBYHMM2VnCJeaPbXORc85f0d1L
	L+TmaHXljaloaB+GRG2ebFTJStMy2Wg/3Cm85PWPwdw5CHDSRUd/FHZAUy0LP0kU
	u+OlkzGQkmTko/uZbyARZfsKmrGv3C+T4DU9rE6m78CKWqA3fKVPC8a+fu9U7Se5
	cSerT3r3tS3UheaJfen0uU9J2wAOBm18fj+Oe4zVYeja1sG7x1eoPHx8ZlRhtnEr
	1I6+yMNnxUsR1rmZe9nodZ1JrRv6BqKtkIfzVrw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bCXACcS/8E7zSTg88bD1vWVVvz0BVxF1YGanCm29tLg=:ZgmgDYD0VV1oXqO2SZ1xTc/ztxdsLD6rJ/4CbP9Doqo=;
X-ME-Sender: <xms:u9jFauCiJaCWzekZEIa7gWV75ijEq1VVmULvbM9dX0CvrHCrNGM3Ng>
    <xme:u9jFasPaTF47z-sDDe02fZBXMxpwx72ETosLNZoe3dDAqd_TkLEd9ysIu5nIoD9yq
    RabD2kxmhUivzvwWiPCSCtpeDhM-WgvEWwVGfHwaZCQjl7mO-8DkZFh>
X-ME-Received: <xmr:u9jFaraxy0Ei3tRptwRsHfwiWaaOY7qgYpodeig7kuRKB6circMpyQ>
X-ME-Proxy-Cause: dmFkZTENd9wf8bXqY2gnf/yXktbNq2+CMd+aCrvUby3iYUhBmXcvwShOPdquuaITVVE4VV
    NgokdP6vsi4hDBU/gxEEYFUM/+ugPJaK2v1wjAnVsz34FWC1uznxm649caWKj+hasAJ3s5
    1jfnUYveAsMknX5T9dATBR12BJNgQYwTZ1ecpn5ZYC18Vsml1pL3guhT4Y7L5u9OEBrZGU
    Ndnc5WpatFkzix9iGjMseD4ljZqQ2EdYSI86+HYeYs3cI23s5aNYFWRu6i5oE1RMcUUrS1
    5RnBDcflsm+Mth7Nq4vbDlN85FU5z51SNZBV8ySwjYYSO0FY354YJc1eptDHfopPYAvehu
    DoblODm1kjPmXzqChUm42t7Jl0Xbc1ewCf9RKwr+FcfJbCQZnnkkW36bGGS8VxIXPKs6pL
    2LcHCXAabEKPKh41fnJ0kHEj3xEmS6Y7BWxxLsZpz6v6SvITjS2l1fVv92i9dmOJbmXex6
    ltDVuGZjUrzswp/IBiCtR/hZKM9AjqOqJORISZ/MaewhoZQQ8wAFqLdfUJipNp5drHGGop
    1gYPnhThT/WBHz3vV+qCltNz8wQZwm2QCdvYnIRepIAKSHloojhzUEZ/dNvVwDhzIbqYra
    0l/3lvAFF0vGja2HfQppNsvRo0fGCoSmFOAwa7kuIxl2zR0/4Ceb70VWju6A
X-ME-Proxy: <xmx:u9jFajueGZG-7W094FDzASDRMAZrMu9to54_Fa-ng5wn7wVCWy9nYA>
    <xmx:u9jFalMw6zru65n1fmivYfRGIzjpBYXs29pk1MscBkghsDIWqh9iRw>
    <xmx:u9jFai5EQnnqXUxehQajSO9637J0hxLiqsGJxo1P_s_YGMl-dng5BQ>
    <xmx:u9jFajTS6PaKJm7wQF-eseJaN3Efpq3YYqjVRh1gV8lActVAJqNSyA>
    <xmx:u9jFatxZy-ksz8xEf57RGTCfpRv7iiowHg57OQwLz-h7vZgezz_4KYkd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 01:29:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e408142 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Oct 2026 05:29:29 +0000 (UTC)
Date: Wed, 7 Oct 2026 07:29:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Guillaume Chauvel <guillaume.chauvel@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] packfile: fix corruption due to stale delta base
 cache entries
Message-ID: <asXYtkkRs6kvEjBJ@pks.im>
References: <20261006-pks-packfile-stale-delta-base-cache-v2-0-69669a2fc6ce@pks.im>
 <20261006-pks-packfile-stale-delta-base-cache-v2-2-69669a2fc6ce@pks.im>
 <xmqqse2id2kq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse2id2kq.fsf@gitster.g>

On Tue, Oct 06, 2026 at 12:57:41PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Note that the added test reliably reproduces the above bug on my machine
> > that uses NixOS at c59305bab206 (cosmic-applets: add missing runtime
> > dependency (#566040), 2026-10-01) with glibc 2.44-25. But as we rely on
> > specific allocation behaviour of glibc it is very likely that the test
> > will not work on other platforms.
> 
> In other words, the test will not detect the bug, when the fix is
> reverted, unless the glibc allocator is used?

It is specific to memory allocation patterns and thus to the platform,
yes. But I just confirmed that the test also fails on for example Alpine
Linux, so it even reproduces with musl libc. I haven't tested any other
platforms though.

> Adding an unreliable reproducer for a bug that is already fixed may be
> of dubious value.  However, even if the test is unreliable (since
> other allocators might hide the bug when the fix is reverted), it may
> be OK as long as it catches the bug on widely used configurations and
> does not trigger false positives.

Yeah, it at least catches the bug on some systems. And I think even if
it eventually didn't anymore, it exercises a part of our system (doing
submodule merges across many submodules) that wasn't previously
exercised, I think. So it would still have some value there.

> On the other hand, the earlier suggestion to write custom low-level
> code to simulate a colliding allocation address somehow smells like a
> maintenance burden to me.

Agreed. It simply is too much boilerplate for too specific a failure, if
you ask me.

Patrick
