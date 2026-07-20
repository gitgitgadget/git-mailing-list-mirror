Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A5C42BEAC
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557796; cv=none; b=u3eVYipYa68S7ql1kbUQZObUnGmB7Fd5nenMurUzXGmxC9dkhUVZGqLB/QPYOVH+B30Ej/O1VlED+QZN71iQ5qgzKROBLI+W4TtLO9HV/8LjNbbpv2GEMuoJPFdrRwHkDFxaz12nNIlxYiKTFlMFPIFBhinPMVQywQyuyay7noA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557796; c=relaxed/simple;
	bh=csgf/G/YRsQW9wasBTtEWysosHFnyovLIYH/M7OKn7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uAAZEvWmT6YNBur61SSsghss/ZA6nf8SgycGOX6isw9cXRzvlpxueecO2nVhYW0rTrCkjHtIIfOAmwVy1YJOOWuK/WFiXhEEW+/CALsSy3erq9ypMl60lf7DJcRl7iGvg/3zD9VZrA198gocHYEM/lbsu8ptb8icWpO/akVMW28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nKQecUHf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=htxt3tT5; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nKQecUHf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="htxt3tT5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A1D9140009B;
	Mon, 20 Jul 2026 10:29:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 20 Jul 2026 10:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784557793;
	 x=1784644193; bh=Y1mLIBKX9kcwBLfa0zGOpQ0MR/WsbOO4UVHe7GVp94k=; b=
	nKQecUHfkSwBAhIn/w6mUnvTZK4H1+bYcLy5b0Lm1n8QhqxYbnns10U2NHTQq7m1
	6FgfBny46J56Hd6uRnO6DH9pWsSfMyahy9DDvXUp7vusHioBtu1HTIG5VKnnaxqa
	J8bq293p+hmHdTNO1rXASQTpAgWItYYebukpzCyBaayA1WAqde3KYg5GCSFAL4TB
	CtBM2vCcomp1AVfR1gubjk5IlBi3q3r4TwB/G6BRTbgkRR3ujVKHW1Uddn6ht8dx
	Xk8ZK6BBHsJPfqDNWZ/+1bR7OmKJBOhigiZ4Z4vXkffZiBxcz4FGWQ8pMuDZNdtx
	6+JEiEuSHAmPBN+jDByZUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784557793; x=
	1784644193; bh=Y1mLIBKX9kcwBLfa0zGOpQ0MR/WsbOO4UVHe7GVp94k=; b=h
	txt3tT584xpJH9plcDjlkEbBzFnm3L78ur3DPavau8cvn1KJnkAE9D62Op/zJu0Y
	L8AZchxUkXg7E9Qz7W/ioZD2/xsSiY8RZ0s2eTNhKSDFxaYEVM+ER9U9KMTq45Ap
	S6/MftnAtb1h3Fg8urIAKsIvtQAaZoBSYwZchN7JBTSnzFBh7ScoS0NaaIpx/5pv
	kuMn716AtwIfSaHxywpm6otlqWUQ9Mkvv0G40Ql/5eEjHfXDVuNbwqBLi7qvbaH6
	TVthg+5/M7d0L/81BQHQ4JlFZm9ZR98jagXzzUmLSuC45tDr0UcAjiPqaSX3CpYk
	MkNBJ3RGSM/LtLK5dabpA==
X-ME-Sender: <xms:4TBeao3na2NHIBqMGQJZGQ8hutHnLvId_Hx0vEz3EZ6RWmHTqdksvQ>
    <xme:4TBeap8rIx6B_cB8Mu0X-dKcLsKREmg_QRWEBaViG0WpwNE334Jh2hEvfO7Vg8E8N
    HOBfbVtvlATqVQIQ1_8x5n0oIuTIkM4yYbQ6uPjryCCFPQAsCn9VoI>
X-ME-Received: <xmr:4TBeapP_0CkS4EEugHmJO8msw5rgXUB_qHCrzpjEL4h1nPVNEyEPqrOEHn9IhEkCcYzue1wsxnLuRUF1Q8I-kZx9MunFHdWd6Q>
X-ME-Proxy-Cause: dmFkZTF1vcqLERxl9eDygruwAuhBgGU/VImAM9rtwuswBLbhe6wlxgG5PMkQEaoFrv8R0O
    jvk7fCKf86e+E1PRR64RZoR97wWvE1Avx+N88c7pyFKMCSbfLme4nQwR8J/ronno1z6RpH
    DpS3ItyA3vhRskMB9jlHu8ECGBPcqkK2inxJzOYJu4eudXH+I3CGv5dY+QKbHKsWFdH/G0
    Oyq2F/lqE4JL+gvqtVpJaoJ/u9xe8SEkodwV/lHC6KEloR57reZ+2bqsKNo/dBlpSKXutj
    whK5CBP7u7dNq5Er4xvcilYp0lbslFMkmcRmlIjKTI4bsoDZ/bl52UFWuoGNDm9Tj8YLLG
    Cje86SglfxcP37Axj2oor/7PUOzZ5rjK3qvUB7Re6/0L5vb6VFxtbkmVuRYuslqcRwXVZS
    NrVYZprzLxArYL+1w8M0hDXNy2CO3Hob5DQ6VZHoj6oDN4BvrF+JtLcj+qkMm7qjSzLKzr
    kE899S09pQrwaBDyAWXAiR5T5S+aHp+vfQLpGn7mHuZtnrRjUpRZ+H/a6AMbjfxF8cO/sk
    fWAMayJu1aI9eMzfE5ZujgeHr+dNKcJXSzXS+cJ1e+nw6s1eJ9ihOauMoNDugZOC77FUdx
    D988qfv5M4YYt9Qy+Sv3JuwLBbWMzDR4a9U0rBeXGoLAdOTce4vYv5GIEJTA
X-ME-Proxy: <xmx:4TBeatcNwC7oJEcvw_Ntt9B9YPldV3mj1wmjZCBXCUOMYYr3bdDjnA>
    <xmx:4TBeaoXLft32-6WtubGwNFV5bibXUGUXN6sK_qzoinxCzNFE0S7jCw>
    <xmx:4TBealh_bjIJRzHEj08zc-LLBD8g2azkkaQVf2wqahmLkuvC6s9_Sg>
    <xmx:4TBean-Qzsob3YBVgYQTnWzKvHCB7PZ8ZGOZnAABGv1r4zMx2H1Mfw>
    <xmx:4TBeap_BHeT_4eURu1j2FVYFcFgMdHJwAzMbm0aab2lNBFQ0BAdmGtXF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 10:29:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Taylor Blau <ttaylorr@openai.com>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] trace2: tolerate failed timestamp formatting
In-Reply-To: <c8d443a5-3cfb-4752-8716-cf0d8fadd9d3@gmail.com> (Derrick
	Stolee's message of "Sat, 18 Jul 2026 11:01:02 -0400")
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<alpXW5U6sndZtgqV@com-79390>
	<c8d443a5-3cfb-4752-8716-cf0d8fadd9d3@gmail.com>
Date: Mon, 20 Jul 2026 07:29:51 -0700
Message-ID: <xmqqzezlhgyo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Derrick Stolee <stolee@gmail.com> writes:

>> Would it make more sense to fix the xsnprintf()/libintl boundary and
>> treat Trace2 reentrancy separately? I still can't explain why the
>> allocation failed, so there may be another GfW-specific piece I’m
>> missing.
>
> I think that your suggested change has merits and should be pursued.
> I'll explore it a bit to confirm.

That band-aid may be a good idea, but I would prefer not to see the
conditional in a common source file like 'wrapper.c'.  Somewhere
MinGW-specific would be more appropriate, would it not?

> The other justification I'd like to make in my patch is that the
> xsnprintf() calls die() and the trace2 machinery should be die()-free
> whenever possible. Solving both possible causes is likely the right
> long-term approach.

That is indeed worth considering.

You mention a few calls to xstrdup() that can potentially abort, and
I agree that anything that triggers malloc() and notices that we are
out of memory can probably do little better than to die.  But are
there other operations that may cause us to exit, even though we are
not in an unrecoverable state (such as an out-of-memory condition)?

Thanks.
