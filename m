Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4A47CC85
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853177; cv=none; b=erEkEVoW8wRLe/7a3bLDeoDYAxc6sAKG91VSA/vfrURPt7oCDjMYF32HAImS4Xk1TWxMqH7YibfjMvqBl/aIejh3WZw37ZDUty8AxErgGGEDRvBDemByGbyGBsg64FwdaopOHQ1lSbyAqy5JbpIzMdWeIWlHfrqSXVKGo1B6P98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853177; c=relaxed/simple;
	bh=r5o7C5kEi88fwdwCJYpamrjg6Cnwv/FpLsbogcrXH9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KX6LBpBC0KXRpDnkILy28kSHXMZQfjXzV4+qIuTCvVdno4shxggi2m36Oc7vS8bsXYHJEQLpWYnT3aVbxLjwL4slIxIQGyzeQXACbz1Hwzq5w6shi9NWDdw06BMms9uJUs5KuUgteI7Z6CzLaJ5dZ1xUpdiz7uXUfNWp3MohQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DZkyHHVs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MBKikFn/; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DZkyHHVs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MBKikFn/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 31E4BEC0075;
	Tue, 30 Jun 2026 16:59:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 30 Jun 2026 16:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782853175; x=1782939575; bh=BM1uZTk4O6
	ueetITmZ7zmykgM/Vn+zJuLb5aZWor2OQ=; b=DZkyHHVsgvXr8pCYBRdXgIl6TU
	4lzEEaqLl5I1xrkMNbmoH7pQqr3h2fl+cB0kKLBuVnAGENYKIqCgck26mGLG21YK
	dcIbOxtWQXm6D90120mnxoAmJhn65MNfzyYlA/nCE66L/W5OCchTlPHuoa2sBqSN
	mBGNhkRTolfWgLNtElFMoJaUTTTrl/kc9k8cSZbMu4Ituml8IDJA3h409r2Rw360
	Rq9D1HBOle6XfpGRF9Rwq4bNcLh/oAZeEP1bI5FnJ1byUB+6m+JKebLpjyxywymN
	3IhnpWiWU69QZ1W9WGcvr5uKZbtZIVRMwDJDvn78hwL0jhwfVIdbiCeCM2VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782853175; x=1782939575; bh=BM1uZTk4O6ueetITmZ7zmykgM/Vn+zJuLb5
	aZWor2OQ=; b=MBKikFn/+oldZSpAXDXTen/HqtMqCSOnFDcryLC1GSDlIKTBYb2
	nEBXj4cFzBULGsy1X0/LnPUrUr2mwJV2pKQIeSsVCA3oTpLI9NKK7g0qzTiqB21k
	y/IwijD3JCiOsKDz6ykdYBJ4NHXZNiFZLlwSk2vtbH0VpsSMGkSSSEOKMpOQKGOx
	b7rCC07l1OW4Qtgw1hLPVhjjWOnTKuVfEroz8ICgvK/Li+BfJuKigkWQ9X4mqKOE
	/oVCm29np893AG34izz5jF1Xgn4tUARRB1BAV5l1vN6CYBr9hNdSYpVRQnQMaP5p
	eJZdlFHpRmV6jqDgHBBoMFYMWUIAGbdlsqQ==
X-ME-Sender: <xms:Ny5EamcsKwn6hMSwS6D3bsuF7BpC-0rfRB5KvqVuEYR2VGtZjg7sxA>
    <xme:Ny5EanFYZw293BBTTt7khaWLh_oo9HshUOV2uLrpJ991QwwLSOYOsDguilrNeBDQG
    4MM2-ADjS2YG-0UwNrakJ8axpWGFPgABiJL2J-k1rO68W-5HGw>
X-ME-Received: <xmr:Ny5Eav3AtLfQecm-hU1WbCZu6MmLAd6c2m5Vdtg6cd7_MuFai7H35t3JPKTCL8vkluVoLEOAv76jGILxPWVOUYBJTd3rASPGu3Rx1i0>
X-ME-Proxy-Cause: dmFkZTF6oFEtVEQ1/lfZNmfggMPlhIyFeWQQvib21t9SnNK8EVj5a3UOacLrAxfen2G+/j
    9sh/6DSFOULOunFFOO9baiYAb1JU0Wnru/nCcxBanIIMLU4kLeTEstduNVb2JWETgOmPP0
    WeexzG2jc1FLL+kOY1kREUik4HX3kwMxzR0C5ikBjqGUmgfj3CPScbBumDfKeB2+OX57Ir
    oVdy5dGDUhZ60IKhlZEBSG0p/B47zGkXF/qHR4k55SnREbJNyckQKSwzt6IwKc3lHRxgqu
    ApypAITV67FPykyZdFPnKkuKCqGS1BTZ/ufM8GwPppob8fqX2rV8ddjVgqRe641MjqCaUe
    d66H95GkgRToEPZ8Sgl5oOB3YLPWkW8BvSzLjkA3uIrYUxozxd5eG+1dLxdOgMM9og43Iu
    WJj4JbSxMvoaQJPQLoK7Hki4eJtjA+ouH7rnge4otteVlbkIBFA1N1DCGWtkFRC6HjQtw/
    Ca5kfAcPX/kIhy2hCTnwe3FQUMns5EzjixVekz1wkB8FrTmvn4uHNru+6h1ZAyKMkRwvm8
    tiJ/4eDq0KIOBCm4ZyWzsNtwtmPtCUPFSTLbjJOMxRwpXfFQ/M5q9lxLhaSsBdO3SIJs+D
    BMROawc8w0zZmwNDYLzXFRIv25tl9yOmPEECQuEL+i2sl1S+nZemXtcBV9zg
X-ME-Proxy: <xmx:Ny5EavmjNnIO14t99PSJ6ALVuG8R2F4Hboal9n-TgWXgsADMwwluIA>
    <xmx:Ny5Eav9DNwWl6qoSV9ay4j96H9bYSKszaSH0YChHXAD6FRZ9mskcPw>
    <xmx:Ny5Eakpnr7QQMY_bIrWwfW83w81VaOtnckzoGK0aJUNJkgODhpmLuw>
    <xmx:Ny5Eaom-7D-oO-CKtKYdZwLRVAr8Znp9kq0uaZuZK8RluzztDmtYhQ>
    <xmx:Ny5EalJfKmlenETImArLM1xgmYWi-DWJXRIr0Ys9Q4M5iQKMWNJKior3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 16:59:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Kristofer Karlsson
 <krka@spotify.com>
Subject: Re: [PATCH v4 0/2] prio-queue: fold lazy_queue into prio_queue for
 automatic get+put fusion
In-Reply-To: <pull.2140.v4.git.1780945851.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Mon, 08 Jun 2026 19:10:49
	+0000")
References: <pull.2140.v3.git.1780832592.gitgitgadget@gmail.com>
	<pull.2140.v4.git.1780945851.gitgitgadget@gmail.com>
Date: Tue, 30 Jun 2026 13:59:33 -0700
Message-ID: <xmqqh5mjrbgq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Rene's lazy_queue wrapper in describe.c was a clever optimization -- by
> deferring the get, a following put becomes a simple replace, avoiding a full
> remove-rebalance-insert cycle.
>
> It turns out this pattern is so common in git's traversal code that it makes
> sense to fold it into prio_queue itself. Gets and puts are interleaved in
> virtually every commit walk, so the fusion is essentially always a win.
>
> This is mostly a code simplification -- three callers had independently
> reimplemented the same optimization, and they all collapse to plain get+put
> now. The 1.7-2.7% speedup on traversal-heavy workloads is a nice bonus.
>
> More details and benchmark numbers in the commit message.
>
> Related to but independent of the cascade sift-down work in
> kk/prio-queue-cascade-sift -- the two can land in either order.
>
> Changes in v4:
>
>  * Thanks Junio for review, applied all suggestions.
>
>  * Renamed .nr_internal to .nr_
>
>  * Restored flush_get() as a static inline helper instead of inlining the
>    flush logic into get() and peek().
>
>  * Guard empty-queue check with nr_ <= get_pending.
>
>  * Flipped commit order: the rename/accessor commit is now first, and the
>    behavioral fusion change is second. This was partly messy -- the first
>    rename commit introduces some ugly intermediate code (e.g. describe.c's
>    prio_queue_for_each with a skip variable) that gets cleaned up in commit
>    2 when the lazy get makes it unnecessary.

So, this is the "other" topic that we would want to merge first
before the kk/prio-queue-cascade-sift topic.  This round looks good
to me.

Thanks.
