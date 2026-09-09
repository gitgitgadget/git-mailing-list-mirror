Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D098258F066
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988883; cv=none; b=mzdJeDOeTOAn2DTihTrIGvrXa563S4kx6EV7DijRzCdI0Qn1H0xV0a6NhPMjs+dBHdFBac4GBr30JnqdMYv9inTkKfIQWuwrdK0RyMh0JH2g6B/yaivJqyrNniQ9/7cCLrdGkggU0DohTJIrBr1cZaoawZs478B0VbgQkF0Do30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988883; c=relaxed/simple;
	bh=QDv/pMJ8zGwf7zd40GGcUJjEWNO44UmFxMqVv/gqDu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=txmr2zxu0saTIHatAb0gM1xJC57W4CmLzUnqePLFHieWGcqWubsRsOeK8MvsyG8v3ur9eHchQcyCywg5aOAIz1uhetIJBUronUFlgXlkw9NO4Y0zqoZWsDlvf4eULdDDGVikarNq9sKDcPHBxiaEUWb9137c2J9zGqU2BtWI/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nx19pNpy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=trD4nLb/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nx19pNpy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="trD4nLb/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id EE917EC032E;
	Wed,  9 Sep 2026 17:21:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 17:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788988880; x=1789075280; bh=QDv/pMJ8zG
	wf7zd40GGcUJjEWNO44UmFxMqVv/gqDu4=; b=Nx19pNpyMFJw8WaYBUciADCs3h
	+3wJMmoa8l3Roe4lnc3fq/eEm5kF6eYwJEetF1/uxLXILMlO8IQWi8ebZZJGs1bx
	izVelirwz/H5aiBWCihemsaqCUAr0Gs+7H6E92THEBVOxvuFIxMEYa/V72GCMOns
	MyOivQTyoT4WC0kw+5WctAzhClLwnnKYg7LiAf1lLp+LnGczv3HkNBn6U4xrH6AH
	I9VGlbpct6RAF6dAwTdEwVfo4vyEbiKRrug42yBZ/k0UrIOxe69/hwA+1JDMm16n
	P5AZv2n8sPLx/fvc8YsVuPpEuzl8Ra/fo7Z22akSJuUfPFxb6gtWvnJTiGfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788988880; x=1789075280; bh=QDv/pMJ8zGwf7zd40GGcUJjEWNO44UmFxMq
	Vv/gqDu4=; b=trD4nLb/WYsxSPH2Oq/mOfhOux/yfxVoNKUlzP9WJJaOiHGc94w
	pe+dLtaLZuNRtpyfrjqtm8L5V8ObNIzC3sOUAhk0j4nM1lF835ByEx35RzCy6VzC
	CS/3vY5zsUZFLAOmo/ZodUotGk72tcM2lzOgXvg7UhyPwNU+roXdxpz8j4RB5K21
	Lpigy551STXSgi+pSF27G/nSfw8RGaoZfZFP4OpjgOP1JSGwBiqdRUIaCY4wczyo
	Ia5kiwGhTmfps/wLAeHlvbb2bLz/c1j96ZtWmOS/7qkrK45ZYFdlElroNNL/wofL
	Fzt3I7AqgUqRemZOUL4opJ4jtPYWh785/Nw==
X-ME-Sender: <xms:0M2hakcte79QoCtOWDFKDiTwu1YUTMNPvk4v-yC7oy77oL-5q5wvzQ>
    <xme:0M2hap5SBXnYHJz6m4MofZXQ0GgX7TWrDUUKIEzZ9py5QE8OUzKeEWoGwgfPkVotB
    _EkuoUBdr9GtpTkNM2QuAvSX5iUOW-hWHWH64ZnneCunqfE4FFrFys>
X-ME-Received: <xmr:0M2havV76cX0FD0vZSg7eNyaqMYneV9YT6YqdXh-de5nmm-sGBM4Pcvy07wJmyr5nXjWU4x1k637OSrIZk2cCYsEdQXBNWhBqlgV>
X-ME-Proxy-Cause: dmFkZTEuK0myH3bZ5RtTr6dvpDnJojUKh0SGi1LO3mL9nC6lHSaqt7KfK3dLY+WWpMfSwB
    yNtl4zEzaXsRJD74vz/wJhl81tLeGJ2wgfDowQJvovwZbtf1yrEwihwOGw8opmskgq9p4t
    rMUBMSvLARUR+72LdSRTINw3tNuu6A2c9V1fcgLHrVbzNk/8mmgWxkX7+bsPWis5vKkplV
    cefFL5AYNWhHdFc2/YrX0k97zayXEHV2TPoS7mWmy4XFGiuiUTUXC5NPvpxMEzSYvRYOmS
    +qVFIdr+Oxx2ZZuz1kXjXom3wz8B0HFOuyUbu/aafZGcarpNyN/woF5j7NqzsNBUhuV6Un
    /+7EvwvW7dEGUYDxrghPt37qnGxw33x6se//H8Tdk3cykYaE2LTgGmRv7l6E/867CskbhZ
    Q89lZowuH3Fy3aGSPSCudYI5poht9H4w0CCSF1NXBnQ3Zb8XUbia0qWFEKEi6RR6ziyWkS
    pGst5uM+nO6YZzw4cq9M/0ZNxQ1+VjfNec655NKfoPZMXjCUp75y9WEDTcMayZJvCkrhqk
    5UWFibt4Wcv39ifG1JBUHkseT1ZoNqP4ANQfLTryJBDm/ZJqX0D9wtpaO02oBvN9Cs7+1P
    l4yERi02S2tD+FFCJPYqsufrS8ilL7e/RRDaxK4QIrKyY0I5w0yUsEJixdVw
X-ME-Proxy: <xmx:0M2hag5Vkalsd3WR5zfMbF5Qb5NarDeyj8Ug4eTLrbENgGiVy_Zmpw>
    <xmx:0M2haiqaqbiHrEW6qw3s06alA-TXSqHn5HGIAwiRB7ADnrr7JNa13Q>
    <xmx:0M2harl-oBozsuyK_CNN7yyV4g7UUQxyO5X4YI50YkX_wE85pqJBlA>
    <xmx:0M2hamOhxNapvMM1V7gTVtoNu-oOu_s1L0OvjgUryFdrtH2YxtKFTQ>
    <xmx:0M2haimnKVS51k-6nHlymRRQRxLe14fcLoaaFvDqiqm1tGI6JyVBifp9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 17:21:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>,  git@vger.kernel.org,
  gitster@pobox.me,  ben.knoble@gmail.org
Subject: Re: [PATCH v3] advice: use global config for default branch name
In-Reply-To: <20260909202718.GA183838@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 9 Sep 2026 16:27:18 -0400")
References: <20270829004959.90983-1-ub4nal@mail.ru>
	<20260909202718.GA183838@coredump.intra.peff.net>
Date: Wed, 09 Sep 2026 14:21:18 -0700
Message-ID: <xmqqecf2p1dd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I had somehow hoped we could reuse the existing CONFIG_SCOPE enum
> without having to redeclare it ourselves. But there are a lot more
> scopes than these three! On the other hand, I think it would be possible
> to use config_scope_name() to convert them into options.

I had the same thought, and do not have strong opinion myself either
way.

For everything else you suggested in your review, I think we would
want a hopefully small and final reroll.

Thanks.

