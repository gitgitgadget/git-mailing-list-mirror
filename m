Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8245133689D
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854354; cv=none; b=A/PKxfANvhaL3Wob8ybkNKQQyKGg4QAHREmETTB22aB70wgreaKQRstO4jtM/8RLPh3kQHePygOn9QWl0G7ENQjS6bjXNLg7pXggE8jGyPDXwk1weZS3ypK92XlntX9y7a1rhbsilbmuimQIygqRVB/RC40oJ0PutQns1EGcFso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854354; c=relaxed/simple;
	bh=7JOdTmQEdNtcSVO6s+RuT9V0t/VfIyITKoJj7OoLbbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ9eutfZfPpL224UnW9g7kWwn41xtPTXHSeVNZmBZCCeFKaJRCUquZQd3OcBXCPWfj/6NPJ05ZxY34k4uhzg80ZhenpE+rsnT/RfzrZsdQl0ytYWBFXYx1jOFj6FxnKpGO12vlpclz/RZAtSGuixL08HlIH0PPXGlRHXlutycWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iDdToZTA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YpQX9vhC; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iDdToZTA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YpQX9vhC"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 628BE1D000DB;
	Thu,  1 Oct 2026 07:32:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 01 Oct 2026 07:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790854344; x=1790940744; bh=mB404q+zXS
	7aRpKe5PjnferemG9RLCOI7LFO6LMfHQw=; b=iDdToZTA0ToNs8llxg7XV4CWoF
	oIVepgaCk9PsvbOpCI8nJDRb4pnFk+BMU8eB5yNw2/H5qNQqSZBsJeefjRTsP3c3
	+oiShCXbWO1oMDTNg9nPBy98lq6o/oKTKsbJvqpalfT+G3FyIFi1G60+qg6tL3/i
	nj/9gYxj1qmQgd8BU3JmziZltRU2tl3IMjIV7AiUrnGJyMb49siNQH4YoQxfz1gg
	Qax68DqKTOLQgb6qEk92vtP9erLMEbjn0lpA2uzif0K/YWufuNbtw+eBAl+jhJYm
	6xm4XGN7hg7BziUmEtYAlDSRrg/lI2+SzBqA12tDbAtIYIHBNq/hnArBVdrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790854344; x=1790940744; bh=mB404q+zXS7aRpKe5PjnferemG9RLCOI7LF
	O6LMfHQw=; b=YpQX9vhCfM3HuZ1pdAtnKAL8yghtwLpNPqhSnCUSOSLbcEfDvWC
	bT1hshVgW0rWE3ouIDYe2dctBMuUpvDslAq78zPQNXG7eXHbUfIvE8zi4nesTgSx
	V1GQdkjk7SQQDH3WCToNXgTm8TqSWfG3kL4oBDhfIFmbqeG8p3ywuuTZI2pA3O6o
	DcEgq0Q/aGUB9l9U5+PAYWgtyipby0m7P+WJExEXmyWx0x+TpT3AVRl+GuIsH70q
	9w0K/jvNeGcGZsgGNHeXYjKDy2Klfn5nQ5I53AFEu8yqujem5KAkRxVsXjbTQh1n
	6frOAd+/rYoyB0q206OXNnq8Mq3LiiYsW5A==
X-ME-Sender: <xms:x0S-api-dXV-Bpj69o20K4bWLFeoPyrbE1T2CDw4X1mT_BqE14dXAw>
    <xme:x0S-ar3EnimGOVFt_Q3s_qxCHa1ktEFeOftXUjBA3d-c7unBLPxRfS3AugcATedDa
    T6ikZaSt0j2I8f3DEDHZsEDPP9tQylAiKvXUaVd0ckIDHY_08utQTo>
X-ME-Received: <xmr:x0S-ajjI2E5TxCTEduyrLSBlcbQdS9w01WxJuvU1U51AkBM7Va40jQshsJBChOfvtmZhWw>
X-ME-Proxy-Cause: dmFkZTEVWOFs79HA26G/E4moRPMYox5222n9/erlnoqFk6yl8ZgIX8z6l2CTLKoqgzpewV
    wFL2+84M11YRJUkJ8cg57CutVaQ8glzNrV/+cisI+RIjOKSRCt/Xn/IJZeaL7Urde3+fk8
    xusFf6UxZQW/VhlHRQQV/STqxw3/kxVvZMnFqs6yJJJhbgDDg0ICk5fZVUI2wRd0rlf5AF
    90FxJw5HXJl1U7CMYrzRgJol+DfCpvNXSFQPCssdAwqbYZIis+dM2ghkxX6VIIl1nYqDfD
    W+mi0zvBby5pcSzW8Gd1k7QvWWEXW63WvXzMbSeKg6Ymyn8GAHiBFzGhRxi5KNQfi5QQLP
    yjHsUyYnolPVjS0II0nAJ/B2K7S19u7TYyn4eLhwizJ6O0xeWuOeBxxPewjTsIvM1U+Fgt
    BiXZ96HkmE0e7FvNAh0TVaJYIWy8R5TPiHjsD9qPK40gJ3GP3x0p6KsVpTGQ375Jl8isRH
    UoppEtbCjYkM7MTKYAj5NanC+QMiXuVxYV6fskte2zOPvpbSHZGo3vbUzdoJdEhw3lsz6i
    LlKjlYhTg3tagEUIsCzkHBG6cWAeUZDlyugq17aT0XzrkFFiNAQGT4tOH3Xntts4q8qhV4
    ZAewsdUAJav9M1VEOQzTaTRzTrsoEjLJS8XWOJjEYpGgaPplrhkMfSJcGygA
X-ME-Proxy: <xmx:x0S-arfdZchmf6hoAU1bnDbvY4E5EkBrOzD9VQViXn_QKmnCR68MTA>
    <xmx:x0S-amnkMHcb1JEUayUIBG25tUxaSnclaHTpTN-e2gGuaNYMJvjFYQ>
    <xmx:x0S-akt9AGdKswbeYTuWRHcNLFhreNP-9h6SFGpLBToqUnQTJA-dNA>
    <xmx:x0S-as9N_XlPICekGoVPaBY_W2XaPtJBEl3ZvgiIjHxx7sTtjzCbrw>
    <xmx:yES-aoJ23FEA92Jp7o7k0kySCSdnphP_WsLDWKOKf-XjEuPwz9uUlEwi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 07:32:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bed3fe57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 11:32:21 +0000 (UTC)
Date: Thu, 1 Oct 2026 13:32:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kazumasa Shigeta <kazumasa.shigeta@kanamei.com>
Cc: git@vger.kernel.org, Shabbir Bhojani <shabbir.r.bhojani@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] stash: expose untracked modes in create
Message-ID: <ar5EwwEt8-ADeLdr@pks.im>
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
 <20261001042155.33303-1-kazumasa.shigeta@kanamei.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001042155.33303-1-kazumasa.shigeta@kanamei.com>

On Thu, Oct 01, 2026 at 01:21:55PM +0900, Kazumasa Shigeta wrote:

When sending a v2 in response to review feedback it's a good idea to
both:

  - Respond to the reviewer to acknowledge their feedback and/or engage
    in a discussion.

  - As part of v2, send a range-diff as well as some documentation what
    has changed between the two versions.

This ensures some netiquette in an age where we're increasingly only
talking with AI, either directly or via a meat proxy. And makes it
easier for the reviewer to see how exactly you have honored their
feedback.

Thanks!

Patrick
