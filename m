Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0D36215E
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706433; cv=none; b=LnDaF2DGEQlBav3thAy+FPInYK7LMtIk2Y5idkhoXLnbAuw3Vd4lOu2TSHRCWfHTpxvu+1LCl+uA/IivSZCbjjO3L97CrW83HghI10ryvJDlB+gBrpaAfI6VTGWbZ56f0O5HqMivP0lESS0hyURMEeRMHXcLCD8ZipoS8zdB4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706433; c=relaxed/simple;
	bh=a+jn2HTHBX/ESrV6loECkIMK5zAMpqV8O/NqEgT7ZEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bHUUqdXdy8GRVAIJk6tEzaDW4uAdPbgQtdwAc/xfeFPTVY8CGog9O8jQKOQU9WCZiHkl/xqTchQLxbk6qCEHdgRzWzhLbzo66b1yVujuqAF2J4mqxJD5rKJeI/1KAvWuRhGl0gSsPD68Z2AyDLTltggRBB8c7EQtRbGnnd9v0Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xJU4Xw8c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PTgP84Y/; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xJU4Xw8c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PTgP84Y/"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D20401D0029B;
	Tue, 29 Sep 2026 14:27:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 29 Sep 2026 14:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790706430;
	 x=1790792830; bh=a+jn2HTHBX/ESrV6loECkIMK5zAMpqV8O/NqEgT7ZEA=; b=
	xJU4Xw8cSXMFWAMp5Dg4oetevy/qAiRD0NBckAO0bfUveadq0AYb+HXUxlxxiW0S
	DUWqHDBaJSz68amYRkK1PZYMslDJjyf16SvIOP0Lz0MCAippbaq2BvUBPNNAfN23
	0DBKHpXXZJ8Z3Vnzqcpwcpuvn9XaNqRdw7ntNpmd0sZYe79Axg8NL86NYWVdAQmW
	JAtozeZIW48v2F2fQUzgscUHnSOLdNkMnfvc4X8tas2KiBbXLcAHF5aORM9jxE9x
	d7Tr3vGl7ORpgp3AypG+I4TwZVW7nMCvD9vXPMwPHE/arkva2vSTO707rMapEHV6
	b/jb84FNOirjwDTQkZjX/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790706430; x=
	1790792830; bh=a+jn2HTHBX/ESrV6loECkIMK5zAMpqV8O/NqEgT7ZEA=; b=P
	TgP84Y/o81NTic1fhicdFBkqTRKkICmK6gSMBZqY5qTzEuCCcp8sa0XqWbXbMaRz
	ABAsnOahYNm4esh0qVJB9RGH8jN+mIo6P53LJUxGCS6VivFAZQd7fGvTdYR9eClQ
	3jdVOuihcc8NX45CB5RpW/bN520wGg7TPKTPgfcjzfH1aQfDiv7khmAloEXQNOI1
	jua/tckobsE0yNbCxIXCCpSO8NcJmql5HKHJUgrxihFw0J5bDGzFzzIc8hIb4VWi
	681Trdd3V5IEH3a5eb3XCot1BlSlGQqqyyUSgUVMMixJVloUyHBmgr15RRPPruT1
	X7KrvhKW1shXO3LRdFelw==
X-ME-Sender: <xms:_gK8aiMuHGklikHifB7umzKbrJweiNM17-9BbgXwmf7B5c90d700rw>
    <xme:_gK8aoYOiaakekNM80OyISRzyi0gxD1QSkd0feZ2oewv6Y9GtLj7qzkBp8hp_gEDS
    W_1DrYCKGANQP4WxFEr97KHTglUikH-A3HNbk4_iS6h4sfOs8ZD6w>
X-ME-Received: <xmr:_gK8amqbbdchwCSduvPJFxI1sZWCyUmfzlB0dAoO-DbaKPARsIlVKD7HQ6_jOxQD25jIcRb8OThTtjuFnlmJJbO6Me6ESeVtLxcR>
X-ME-Proxy-Cause: dmFkZTF5kTPvN24TTfLnlCPYum3sg32i9EwrMscX8s9itFgI8MJ6/GtcZKMie8OjqcEzOY
    GltZK2IeE1mU640l+hz5tzYTWgwuSuAMNygTPw2Dxhfx1w20frNJ7cxZdWb4q3IqPQy7uz
    lZCNMWSKxt95xS4+6QUPXS/SAS1dbMfiViw+AONQdeTKKzWUtAqPs5rSZbuR5El6Z4iGl9
    C5KY/L1i5MLmkFjSa1y5vzkk3LEpH7yH1/zeua9Kn7hhyk/1Sbr8hfAWXHPSs5HiDGKUAO
    THB9sX3qLWi1Azfk2eDO7/fKuBmYrsavWUisDx3ZLmXX64QqB15GrKP7EEQC5ml+AsuMlu
    Ha+CLyN2nySFTvJWcV7duMLViauG/+cXJdJ/mjI5ltVuNHZf5K964xk7iVgAP3hbkc07IY
    i5kL/pcMI9ad9fl79Fa+MUhkDdfV7egqUC7lNTp0vexbSXK1+4gkKXCwRQR6PspDFj2yZT
    s0CxAivPYQEuAj/CTieytXV4ELpuggF4fMDHORCVjMBtcRDQO0tmlGsX20QY6tZIs99gDu
    80KL84Fkv3BcIRMrMhw7g/N/pk2y6NHFuIpqyuR5RyJK+kiAvyo4uc/uZVAWPsliq7kJCy
    SBnV/44wChTKvfpmYSpd3si/gj5GpNOPyxKUqrOnMvr4gDoe91BN9Nsc3fdg
X-ME-Proxy: <xmx:_gK8asbrzk2ZlNnns7mHCBxohBKlsZQakVrZWg1Qm7nc44B4EMZ5wg>
    <xmx:_gK8auTC14FE16wIBsJbTvL6i9y_pGpFdGN5f5kGSK0gWcbqGqA-5g>
    <xmx:_gK8aj5UuI5T8xQr9Bus7yos8jGGza3iYcif2YImvqYd3CQrMFwxGw>
    <xmx:_gK8ajycJju-SLctduXPUxbkzNgCU1fUKgqq_aYdCVEzT32bxyDmyw>
    <xmx:_gK8akbc4SrKusIXkuikaHEdCa9PugACaNZV3Ta1AULxXDwHAu1PWVHJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 14:27:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Dmytro Lymarenko <dmytro.lymarenko@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] Optional per-repository consent before running local hooks
In-Reply-To: <CAF1QGTmK=WY_AODsfETOtzOSuwpZ_4KV5SiNPoRv0SAYeJ7T5A@mail.gmail.com>
	(Dmytro Lymarenko's message of "Tue, 29 Sep 2026 07:23:43 +0300")
References: <CAF1QGTmK=WY_AODsfETOtzOSuwpZ_4KV5SiNPoRv0SAYeJ7T5A@mail.gmail.com>
Date: Tue, 29 Sep 2026 11:27:09 -0700
Message-ID: <xmqqjyo3hq0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Dmytro Lymarenko <dmytro.lymarenko@gmail.com> writes:

> I’d like to propose an optional safety setting for Git hooks. When
> enabled, Git would check for an active hook before running it in a
> repository that the user has not approved. It would show the hook’s
> path and ask whether to run it once, trust the current hooks for this
> repository, or decline.
> This would help when a tool or setup step installs hooks from files
> supplied by a project. The check should happen immediately before
> execution, so it also covers hooks installed after a repository was
> cloned. For scripts inside the working tree, Git should ask again if
> the approved script changes.
> The default behavior could remain unchanged, with this protection
> enabled by an explicit user setting.

One thing that immediately comes to mind is that, if the "tool or
setup step" is allowed to install hooks from files supplied by a
project, it is unclear what prevents it from also approving these
hooks on the user's behalf (or, rather, leaving the same "clue" that
your proposed mechanism uses to record that the user approved
execution of these hooks).
