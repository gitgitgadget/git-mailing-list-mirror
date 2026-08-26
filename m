Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5D4333730
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781888; cv=none; b=jn3MwTyI0uKdYRZP4gRUxQbWNNdIvXboNe+Lp7d3lTBu1Re822dGGoaYKI71JInprCMoh/wnEC4xu5GOGbYRaOBCVbylhqTk+7mzeXIs+J8YY+R6f0DUs690f3Mz9vg/PO8R4faL0/XtAPXmeGUVYmtfNfEKo0ke3gQtKt5r8iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781888; c=relaxed/simple;
	bh=nSMMuQPZZq3ovNFbn6b43ZjlSyysJ2T5VO+lh9o2GXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T63Ac8uwnQIk2tConb99c0ZKkyb/+pRDPiihWykthx2npWS1BHtcJwH16DYkUNNILKnNCXiikrlGkOsMAGMVOM8l1w2+YhOWEGRJjNM0aYyNSsOhnmXXcaMLJJK2xwZ3vMRTVAR4fd1ewk/j5XbVxyFXcit7O5B6DoniDqV42Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hHR3TQip; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OAbiufME; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hHR3TQip";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OAbiufME"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E47F91D0005A;
	Wed, 26 Aug 2026 18:04:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 26 Aug 2026 18:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787781885; x=1787868285; bh=v9Lo6WgjNh
	CkJoS42K2plqSeubFAUMkFf7CAPF0nfGw=; b=hHR3TQipwLEr9dhww8LCP7n3A4
	yNXPwTLoqyovTFMjPRf3y2hKtg82d0PzGsW+Slj/jt1F79qHSmxLQ5QuqS+BS/A/
	CGJs6AaMCdfBko+kmu490qYuM8anvwQCxdKtv/EvM+OcOUtRlhGN1G3EfO5mnkft
	L9EpEV4RpUZAd4Q7+6oRiZKot/6iCFccQiNpXXKR8FNX+mOY06QSGJm2LsoIBnKE
	ekzM1BNNQ4V35dpjUJSCJUYzCp4ZMHQ79pAJ/1et0CbJ3uLQQ8BgNjXP2YFG4Zz5
	WI2j2EjZoUfeALWHll5pey4rr4ZTVkZg+kKqHLGPQMVE5hIB0oHbQbTqRG2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787781885; x=1787868285; bh=v9Lo6WgjNhCkJoS42K2plqSeubFAUMkFf7C
	APF0nfGw=; b=OAbiufMEEJJyRWFdY079AjkmkVMsVniuW2Lh6g8g+f1XMg9o09w
	GXdcPzdjs2ddsveCRLnTvx8XSsEq9+2Mjz4T8esfbtbdbKbF26zTX8mcOik1c5Yz
	jLA0RuTBsVzwu3wSjKXq6Ro2uojC+b6i45mu/z65W+O9TfM8XYxWYPQzxC9TZ4fr
	sYRNO0wlYJBvRaxeLmsdxiyUwmAdpSo6CumKrGWvxnvXF12LNhAcJc+JVAe5CH/v
	o2URi4AK0Ucv65I37HV8i8f2vQWBqgdiIlDkKeSKGW8K+AdUXLtO0rsEX8W4xtRS
	9UoETwuw17x7vz9WlyS5pZOIp6HQAc5txeQ==
X-ME-Sender: <xms:_WKPao-Y1u6sKsN-gxVegUdCPumdWw8HF_llmEq4m2wBDQul_5akcw>
    <xme:_WKPanlVcD9EW3Za7a2XFpI7iujyJhbh4Xil-5LreONMShPHEO_0Ww-Lb6yoNPN9K
    Kz_TqvyYSR45_N69VrARvJZQWxjLwZIjMICjxMOv8n_2GOtS6I6ew>
X-ME-Received: <xmr:_WKPamWtPUxq48w4aCcAIVwpeuU7nzTm1u0C3hpp7qXU4EJOLob1WEmUjdLx-rD-xOv6Lm4OesSSMT5qadTzTC7MbOHMcIxbhA>
X-ME-Proxy-Cause: dmFkZTEojJ2LyJmUB4vOKBQ/eNP1fQepCjpnI/kp/iyJd6CayIuv66FMGusaKnO44Tgew1
    zWwIVU8K/VM90xFRvKEnQEAnajvC52E+kesDYMUvhjHxOO0D6/xVfI/7eeq1hGIwD3RxqH
    /uXn+iYgvS8IVWsmHTZib+uIEKqvBk/KfXHSlkiCIOHfWrGR0dgfQ8TjPQkmhWAuqktowB
    1E8+bFOHKT4MYTXeO1RyJo0KLpsUnE5O6obr53qYxWOdSwWXvLrjcGbzsxvQ5H+R7g3pRd
    4hnRVCwYEKzPH6VCX40wloYstLd9MKbyTT/cjzDPy7slqQl7MYYGEWx+3aktlwS9oiH6H1
    8JIVbyHC/gdndpM+ihrCZoKx31c1G/Ws9HgYm+okSwvII1USWSrx87RNlRzNpYxGC5WKV+
    fcWo1bsjjo4XHZKgbsjYhz6Te98dIr3GYZB/HiKoEzSwiEUA298dHyDsNZ85salpdh5zVT
    rBVLra0jyi3aMdfqRP8ULfI5/OtuKnIG/LIYPxb6nAPZ78LSqeP6VTW9twT/45qMLRpL7g
    Izs0McHCBpqo8UWlzhHCSq5IN8VsRq1MBZC5B9g3Yifl4GjkXzU4qyelepNTcN6c7KKCa3
    2L9DSH0dP2GuNhV5pQVTkdPYNTFyWLiDFUXkgu/7WgzNSe++lPCOUQPFK16A
X-ME-Proxy: <xmx:_WKPakG8yNR2cbpFUsPz9EBICV0CAxZtHboYVNxiFvtricM2doHU9g>
    <xmx:_WKPaqdKnBEwKAJS_gRf3BgjHfKFqEhUpSl8zSkQk1FH9NeJmNp-Pg>
    <xmx:_WKPatIsjpINKkAxinoKiv1euwjjblckM75quIi92CcQZ_-dHDuQFg>
    <xmx:_WKPanEJn-ZXYzG8XTMgKOxuxkPmZYeh5cPeUE3y8e8GE-TyWtnpRA>
    <xmx:_WKParWZs9QcZtumHyqXXW5_61-r4wmt0PcBI9jr_xMHEWxqXTnKshKe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 18:04:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lutz Lengemann via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Lutz Lengemann <lutz@lengemann.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2] completion: zsh: support completion after "git -C
 <path>"
In-Reply-To: <pull.2155.v2.git.1787144872870.gitgitgadget@gmail.com> (Lutz
	Lengemann via GitGitGadget's message of "Wed, 19 Aug 2026 13:07:51
	+0000")
References: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
	<pull.2155.v2.git.1787144872870.gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 15:04:43 -0700
Message-ID: <xmqqld9sczd0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lutz Lengemann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lutz Lengemann <lutz@lengemann.net>
>
> The zsh completion wrapper does not handle the global -C option, so
>
> 	git -C <path> <command> <TAB>
>
> offers nothing.  -C is not part of the _arguments specification, and the
> wrapper hard-codes __git_cmd_idx=1, i.e. it assumes that the command is
> the first argument, so the bash helpers look at the wrong word.  The
> latter is not specific to -C; the assumption breaks after any global
> option, e.g. "git -p checkout <TAB>" does not complete branch names.
>
> Add -C to the specification, and find the command by skipping over the
> global options and, where they take one, their arguments, as __git_main
> in git-completion.bash does.  The index is one less than zsh's, as the
> helpers count the words from zero.  Collect the paths given to -C into
> __git_C_args, or else the helpers run git in the current directory and
> fail to resolve the aliases and refs of the repository the command runs
> in.
>
> The argument of a -C is still completed without regard for the -C
> options before it, i.e. "git -C dir -C <TAB>" offers the directories in
> ".", not the ones in "dir".
>
> Signed-off-by: Lutz Lengemann <lutz@lengemann.net>
> ---

Let me mark the topic for 'next', as later parts of the thread was
about an unrelated tangent.

