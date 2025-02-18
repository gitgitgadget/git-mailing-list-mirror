Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8A21B9F0
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907028; cv=none; b=dOki0UC+MmARotBx7kCaevtzsMsJp+rTLgm/1c1vx3J56Eh0Wv4NT//czEBoFlTSBOmNtc46+RrvDY3AFRdca30GVD8ab/1BkyQq6rMRTi2UzOE8ZiWbQz3CbEg/kXIqdZkNPdpX746HhCSeeVss7n0qcmt1HVpEhJmbdWglb1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907028; c=relaxed/simple;
	bh=SKDbLZ9yW+nV32FK557KxV0zRMCRCLMV8D5EtTMK1Us=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FAwEDhqxWk/hf1I+8xjh7079x0C6vKZaY7vrVwQpVzXPrnFaoJfg1x1Ni1yW/vf0McLOLxwmJgqx+djd9O8fzvCrpuUl0S/yTAvU9+X4YnA3K2DFb9PzxErcNk9SsFRxbHLNr2ueikvezBmRFz46N97ypW1Dhw/nOyWup4qAgZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JgElR0Ud; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CRYslP2f; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JgElR0Ud";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CRYslP2f"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 45E9611401DB;
	Tue, 18 Feb 2025 14:30:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 18 Feb 2025 14:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739907025; x=1739993425; bh=NNegcm9dVD
	Aq+VpCy/tME7ACq825UKUAiJRbG+A0/s0=; b=JgElR0UdClFsDC6OA+d892CFic
	b9bH7HKqhWLJYFCCRsziTCvBjudywSby05NF1+W+Er2q1t1ugG+sqIm7S+P4aZTf
	e/hpwl15bz1T5bwyM/l/We0Y29r7qvJJZpNABhUmvQa9XvuWwc8S4StRH7Sc0K4u
	tX4tDfV+IqB6W09YV3vCw5SMmUJyTIM3KCJPFBXeQZtWdw4ozlQUfhXRfm5rsZSz
	ArIFZjPk6GlLOpObVnSam6gAYUOKWgqbU0pHexZ0l6Hu+w7EtWsEfvy+soF9ydL+
	zsIcqaePCjGb8E033yZgOHPRAar5qLGPcC4htbEu2HOMJI1J5efSHwhTN6gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739907025; x=1739993425; bh=NNegcm9dVDAq+VpCy/tME7ACq825UKUAiJR
	bG+A0/s0=; b=CRYslP2fmnmtYf+Hrt5zmNCXtqmSLa5oC8eiQUvz1L9NIC6ZtmH
	jix1VL17/vKZO/oE6rBScfRN67u2zn6+dI11W/1uPUw4hk/vxuXgxvaukFaydIxQ
	hstptnu9JQibv/IhWkvSNyysmwIdH0yVitvnl3t1aww1ZBIqFFWa0VhMwzaq8PNH
	auLNFLAAKjs9dCrsXfVBO9ChsXehGVavQ440AIP6vXkGEVJg6JAeVjh4NG0njQl7
	4qVad4uhM44BTrr7RNpAvUUNU/GSjLBhSG3atTzOxlvl7M2c6rWDZDdFfinIE7or
	gIlQZvWO2oRX5eOImNjusN763CLcC9Z3HJA==
X-ME-Sender: <xms:0N-0ZxC-fymjyqK-UFIW-1yzfVmFngdOnqtQxocKgwGQyTGiZFN2uQ>
    <xme:0N-0Z_ho3M6FXxLBzzBHjOzWxGE5mhgrqaQBlrr3lTVtfYn5Av1OvFqqmN8f3PFCk
    byxdgl5VZW-bDMgXg>
X-ME-Received: <xmr:0N-0Z8nZJ-Zdvzzsvd9M_w1wTVroGYAYm6JdUcv027Ai01sT-kw4v6xqIQ4ITLAsm-1ChE7X1hYUlYSJc22wtFo0Z7x2s8-KSddWpgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivdduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepughhrghrieduheelheesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:0N-0Z7y80SS4aNoN3g6u8-wMGVt8t_akwkm5DArkl7FoYl2lusZuAA>
    <xmx:0N-0Z2QIcl4WWWPDFuV5EpOo-lOtI0Hs9cBZPvWKxriWPbbjmJcEhw>
    <xmx:0N-0Z-YGLp8MYHw0mWbu_lrx3Kno-wor_6J_hY46IAFKCFHd1wrneQ>
    <xmx:0N-0Z3QlcWPK8hr1KWwJEnuzZJsq4XUCTQPZKIVSmbz-tW2NjA4BvA>
    <xmx:0d-0Z0cjHtrWTdelF8s0yY_zgQEpOsRcz2P4LWQWZjaEB0oA5Shh1V1_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 14:30:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Moumita <dhar61595@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userdiff: extend Bash pattern to cover more
 shell function forms
In-Reply-To: <20250218153537.16320-2-dhar61595@gmail.com> (Moumita's message
	of "Tue, 18 Feb 2025 21:05:27 +0530")
References: <20250211114611.9334-1-dhar61595@gmail.com>
	<20250218153537.16320-1-dhar61595@gmail.com>
	<20250218153537.16320-2-dhar61595@gmail.com>
Date: Tue, 18 Feb 2025 11:30:23 -0800
Message-ID: <xmqqy0y3jbjk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Moumita <dhar61595@gmail.com> writes:

>  PATTERNS("bash",
> -	 /* Optional leading indentation */
> +     /* Optional leading indentation */

What is this change about?

>  	 "^[ \t]*"
> -	 /* Start of captured text */
> +	 /* Start of captured function name */
>  	 "("
>  	 "("
> -	     /* POSIX identifier with mandatory parentheses */
> -	     "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
> +		 /* POSIX identifier with mandatory parentheses (allow spaces inside) */
> +		 "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\)"

Is indentation-change intended and required for this patch to work correctly?

>  	 "|"
> -	     /* Bashism identifier with optional parentheses */
> -	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
> +		 /* Bash-style function definitions, allowing optional `function` keyword */
> +		 "(?:function[ \t]+(?=[a-zA-Z_]))?[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))?"

Ditto.

Regular expressions are write-only language; please make sure that
you do not add any unnecessary changes to distract eyes of
reviewers from spotting the _real_ changes that improves the current
codebase.

>  	 ")"
>  	 /* Optional whitespace */
>  	 "[ \t]*"
> -	 /* Compound command starting with `{`, `(`, `((` or `[[` */
> -	 "(\\{|\\(\\(?|\\[\\[)"
> -	 /* End of captured text */
> +	 /* Allow function body to start with `{`, `(` (subshell), `[[` */
> +	 "(\\{|\\(|\\[\\[)"
> +	 /* End of captured function name */
>  	 ")",


>  	 /* -- */
> -	 /* Characters not in the default $IFS value */
> -	 "[^ \t]+"),

We used to pretty-much use "a run of non-whitespace characters is a
token".  Now we are a bit more picky.

Which may or may not be good, but it is hard to tell if it is an
improvement.

> +	 /* Identifiers: variable and function names */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 /* Numeric constants: integers and decimals */
> +	 "|[-+]?[0-9]+(\\.[0-9]*)?|[-+]?\\.[0-9]+"
> +	 /* Shell variables: `$VAR`, `${VAR}` */
> +	 "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{[^}]+\\}"
> +	 /* Logical and comparison operators */
> +	 "|\\|\\||&&|<<|>>|==|!=|<=|>="
> +	 /* Assignment and arithmetic operators */
> +	 "|[-+*/%&|^!=<>]=?"
> +	 /* Command-line options (to avoid splitting `-option`) */
> +	 "|--?[a-zA-Z0-9_-]+"
> +	 /* Brackets and grouping symbols */
> +	 "|\\(|\\)|\\{|\\}|\\[|\\]"),

The fact that this patch does not have any changes to "t/" hierarchy
suggests me that we do not have existing tests to see how sample
text files in the supported languages are tokenized (otherwise the
above changes would require adjusting such existing tests), so I
think it should be left outside of this topic, but I wonder if
adding such tests gives us a good way to demonstrate the effect of
these changes to userdiff patterns.

Thanks.
