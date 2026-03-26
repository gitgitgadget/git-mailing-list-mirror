Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B77333E36A
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554277; cv=none; b=C0qGWj7fwoZAkpKI11Owq/b766mnJwL8H5BiH/1sPWNFq/xYav1KY5kKDEOQi7zMxgrjB1MX3kpR6/UEktxkJfDYeCcN6HU/ItzwUjaiyrYNkx/OYKOrJc4i+6Te4vBVJ75dLzG+nPbsFMyfD15q5w6Bby61CUqzSyHKPEwvoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554277; c=relaxed/simple;
	bh=kLDGsGOt03571k2eoS39TSuzvG1tB2ZwStPRmnFbH7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rc7wTSngr4rjAg9ZGRHLNNQYXg3JOpWzGYIvcjIzxIYre3G584jiV50SQp9ilKxoedoVlGvGInwpN+qyyuYQMbPDArvyfid1xnx04Xqy1I7UCh/S2mm+zgd/kOzstgKjueLHlwFOjAQCad/fUoVa44V/YbYgMdV65heslZXzbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D4cczHyg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r42LBZf8; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D4cczHyg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r42LBZf8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 522A914001D4;
	Thu, 26 Mar 2026 15:44:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 15:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774554275; x=1774640675; bh=jpDOkFj3NZ
	cU6LI2a9zkZJhAiWH8ujU9QmdfmRDWFn0=; b=D4cczHyg+q8+MMje56TYAju4VG
	A+xIxpeym/yG93jI2eOGPVaRf/cw6wjCtk0VYZszsaBassmGpeME12l9bQ+KJTHv
	mbwxqWXVh+XbjL1oKK2x8NbX4yrcrLht3wumB2UA7OnDErFNS02Q1WhoIlu5GGg4
	icdrBcmYYi045vc2lyeC5n8fi4PRA0hJ3DT1p3JGEyXLW03WslSyWDEQNY8jZY9D
	bNiM5LclnlM60Ym3mzFBrxfSeOO8BBNzdFFuaOyO32KwuLAFigLeu1IUvM0pdPeH
	g9MD9EsKBgqyXdrPv5pYzinBVlSiVSHJAuynLI5C+USl0LOrqrtTyCR2p6/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774554275; x=1774640675; bh=jpDOkFj3NZcU6LI2a9zkZJhAiWH8ujU9Qmd
	fmRDWFn0=; b=r42LBZf8UV7/6E6gwqQxGScZvchmndFMqO0ZUZ1lBasGHgdmGie
	caJaUvgkaXc6/zvwIeIHjV7UsJIfwLoFmy0AHuwYIVJhJRu/7NY84/BHqPaHukU4
	oYoIJDRdP0W5qxqzSxa5Mha1y5IYyxNDAJ3ASu+g+iWlnVpeS1U6VDR7N5rOCP4c
	X/WxkhNNTkGjXz6/aqAt83D/sB1UUBR0HmUDs7FwAEfRTF/SFz+2DhCjzL9Sypnu
	JsCvXCDiJ8uxHELIVJxRB3JWmOaiwy9cULCeLQ79CtamEIE5bHFdPHESqGfQZEod
	R/+KGiZZWIza3MwRsiXWZe/HURkwegTHnHw==
X-ME-Sender: <xms:o4zFaUIr5Bo-OKKCpxvhbaJQtUmYEe7NmN1XxML0n0FlyAxJGnutdw>
    <xme:o4zFabmurUCcDNf9nzH9JQvr1MqMu6FdoUgRCoSTyOj3KlbpCF_q6ha9xDQ1Ly9Gt
    NNsuSGW_WO7lXh7yvJOLvQTgCK3p25cAcz5qFS0Cbvdj-YwOMBabw>
X-ME-Received: <xmr:o4zFaSGj90l1gMCh8X0P7JJsZwQKp6XSuWaMIkdxxx139Eb4Zyq2vpjZFb98z3tw8tXpzam_KS_TnhkDgEvyyhjyIgtDjIWWYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:o4zFabGeNuRDhrZ3_tYkgjcU5RGSKe-eaUK7iNgG2ZQvvBI81tbmdw>
    <xmx:o4zFafMSYnGbKitrH0U9f59wxQbrNE5B5qrNYLERdgKHo-vBYBy1jA>
    <xmx:o4zFaaHkXaBnT-CypEwR08JzQMEudQU14LSUVefpZ14ukOrioVgJoA>
    <xmx:o4zFaWMIonNV0dT-o2jE_yAzsE3istWqBXQUYHgOjpn9jOj22ApnzA>
    <xmx:o4zFaTvtq4h4MRfgag9SSja-dW4KlQkMUn3brhfVwFQseWV9VYNW8Ys0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 15:44:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: kh/name-rev-custom-format
In-Reply-To: <8c9dd9f9-4d41-4901-b1fb-080e4e73b40a@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 26 Mar 2026 20:22:46 +0100")
References: <xmqqldfgy1ye.fsf@gitster.g>
	<e33142cb-1ec3-468f-8080-ba3bad79ae25@app.fastmail.com>
	<xmqqtsu2pgu9.fsf@gitster.g>
	<8c9dd9f9-4d41-4901-b1fb-080e4e73b40a@app.fastmail.com>
Date: Thu, 26 Mar 2026 12:44:33 -0700
Message-ID: <xmqqecl6pe8u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> With git-name-rev(1) it looked like formatting options could crowd up
> the place.
>
>> Wouldn't this be done as a new option to "git log", for example?
>
> Okay with me.
>
> git-log(1) blocks until I have closed stdin and effectively dedups
> the output.

Ah, I forgot about the "--stdin" mode.  That makes it a non-starter
X-<.  Sorry about the noise.

>
>     git log --oneline  --stdin --no-walk
>     HEAD
>     HEAD
>     HEAD
>     ^D
>     <HEAD is listed one time>
>
> So if an option could tweak it to instead (1) give one output per line
> (like git-name-rev(1)) and (2) not deduplicate (well, follows from (1))
> then the problem seems solved.
>
> Thinking out loud here.
