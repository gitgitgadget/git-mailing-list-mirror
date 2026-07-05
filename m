Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7333993
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 05:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783229286; cv=none; b=Z8rHfec8QUyj8C/veuDirjuTDWDMFLSP7E+chXTcsHyxG8Y1A5AJdlpKGScWGfAFFg7GgXjxFJGy24wz71VoZP3Ad1LmY2ChE5zy0EzfvHWZWPNvWBITUp9d1hkYDBXc4Jgr0AEfEXT9fl/p2ZpDKDFVJSdMPATpBq+9vPy5YB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783229286; c=relaxed/simple;
	bh=0NSv/gOBG0BqVM5eB8o9Ts4bevO+S3lNzNI2Meep+tY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aWFRjfWEowxeHh7MATgyHkt4snDYG8ApW6/4DTlSzSaQfVMK/Exxr306vocBZuPzH9l5+rr4FvaL1CzYwVtscEjjJcrnUR6oaYxf7QtJ+x7RGBSO3U1a6YIep7ttQDyItaXia9UAe2NdnaMgQS9jlSaHqV5c0WHYHjb/JIrOT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HOAbOmSh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GVgYySA/; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HOAbOmSh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GVgYySA/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E9EC81D000D6;
	Sun,  5 Jul 2026 01:28:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 05 Jul 2026 01:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783229283; x=1783315683; bh=DJ7aF5Ea3r
	0dtmD3gEEdBaSoCjqO0yNcui2Qwx3mp78=; b=HOAbOmSheYPVr4Gh0wy9cOjZJ6
	6ruX+Pi0lGe31UXenWum6hfmWf3qNMVyoOV4wkqa6EP+WqLFlTBOGP4NMnCjOBCa
	Eba/n/33LZWr3aaevdV0LZ1/j76nDN3C9NNDbAC0defW2MunRHtkwNz74cJYJR2s
	vVoOsRnhPP/0CHcTrbhpWfPphrNFr6yl80GxAlAIbBP0kBOTPbD5xVIITXJyDVLz
	GYpcjO5NxDwNRj2B3BfvxiixgWhn7Awb7BdrLDElTbE6r6M/47qWcPX3vOjxYNUB
	3pJcV9YPKqtykQn3njCJnjbNN1y20zhJTNo8bDUr4yqrL4BtdSWsFcr5TcPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783229283; x=1783315683; bh=DJ7aF5Ea3r0dtmD3gEEdBaSoCjqO0yNcui2
	Qwx3mp78=; b=GVgYySA/AA4UI6N+wsHNLOofr5/hULkPBXVE1X244TmgQ0d5GWE
	+hK1ImcppRIHxeUU9ZsUN1CsbLj6Kd+NP3It9jXchY/lD8oBBZ2BQ5PdRIvwPVry
	pNgUM1gEaRLI8gN+tAvwjwYfyxMLwFjgLpciqBSeyYnWy+ylgZkc6IFVkprtSoII
	jZyUIfpS+FgNnWLgo0wfG/fi4KIOSVx/9ZtFO0a2CIBY77ks1SiU5JS1740g00EP
	9J32GYC2pMgTp9GKMkqFnWsYZbBjTpkvE06rPFSw+uCZSLKUtuRPbCKMfywWe/Ae
	O+D26Zyb4r3njt9KXiStYGj9uEzlrQ4CnNQ==
X-ME-Sender: <xms:Y-tJakFzYY9FEIWz86_HzRB4SwBSRziVAy2t0fRZhuQH2RwPnKui8Q>
    <xme:Y-tJakU5JZvH8wabrfQ2PB6AxEG47Eta6gS6IiUR-yABghR_3DMWxY197RPLymwZp
    TXOAy3UNcZt0ieiHZlMyMV4BOhpDKaiRT-pCTUYjzyde70QRw4hBA>
X-ME-Received: <xmr:Y-tJajJu0492J7PaU7gCOafziqKd2K3c5mZpvwT81l6EOTPtG8_ONTSERJmrpMM9zyoLXqCWvbLX7T_FwjD4Xi7__Q42GwHHzX820pk>
X-ME-Proxy-Cause: dmFkZTEGaFijcxbYqMK5D0kUJdisGrMHX+5ufy6G2EO/igtC1l0VWO07Ndf+NVQtTSHS+e
    VW3MVgcD3uJjKOaei67lsU6TSy2C35yjkrRY3X1pjA72Sy/dVUSNenvdqH6YwroxAfYJYw
    Ean5EtepzsBW5o+s7DiUOd5cWyPgDaMyM3APNs+lJ4l5gdqSaqQnJRhxcS9tu+aEx6JcIj
    dMe/GIZT5OavDRFBylw4Z7Jfd9EnExhPCMETmWSi8pQYbPfbCK95Mzia5ugCDBQpi5mKvM
    plYdOQ5njr5GHwc+PZaR+3ooaWRfhEeBUbmcXv0GkAdZ1wBw5TvOiJ1djUYL2Zejv/w1sf
    xVHcKJh1n/quCazcTMH3gMwEwdGanvAJWBIAx8gpzA+pFr2P3mMjo4aX7Re7nvYtopwBuF
    Nn/mNsccQ4X1q6t03G8w87Fuf9VYcB4YHIdjCeZUsp77mwzPmid9YMIPL4Hmf9lACRTORJ
    zLhwM5YEpzG+awFVgtK7q2SRL1JYEBOnJQyLZOvCHRq+pUr3rzKDC/6FO24/imosIcM34p
    p4WJje0Oc1bXOlzRRnzjDa6CNEHaWDJ7Nh27Z36wbfN6tHN3gowkPsSNYLxbe3Y59jfBnU
    gLPHiv95eeblGYb80rqBivRNb3uQTF1cbYUsqEK2DaBHb0TyVMnRvT8puKMQ
X-ME-Proxy: <xmx:Y-tJak_lPv0-WMX-l3UxUJzUCv0xQMSzUJXADkwB19zy5YPCqosoAw>
    <xmx:Y-tJamLS4ek6pYlNufuyMWoKuxopxjdJPSpnBD8haJFv29W0dXlanA>
    <xmx:Y-tJapntGLXlazGARclqSLBBxVra5Ej_jYS7eKPlkP-9B543ZHvfJQ>
    <xmx:Y-tJaqOzC8C_GNGAfCH6MIyQCXU-G88xE3P1mJYtp1OgKNFsl-c8Ew>
    <xmx:Y-tJagiwiU2GJ0zd25JW59d1Md1EOtD4H2qO73hq5lzPE3oJF_B2cYmN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 01:28:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci(dockerized): raise the PID limit for private
 repositories
In-Reply-To: <pull.2164.v2.git.1783155124926.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Sat, 04 Jul 2026 08:52:04
	+0000")
References: <pull.2164.git.1782889484346.gitgitgadget@gmail.com>
	<pull.2164.v2.git.1783155124926.gitgitgadget@gmail.com>
Date: Sat, 04 Jul 2026 22:28:02 -0700
Message-ID: <xmqqh5medmzh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Every once in a while I need to verify that Microsoft Git's test suite
> passes for changes that are not yet meant for public consumption, and
> since it was (made) too difficult to keep up a working Azure Pipeline
> definition, I have to use GitHub Actions in a private GitHub repository
> for that purpose.

Great.

The updated subject no longer confuses me ;-).  Shall we
mark the topic for 'next'?

Thanks.
