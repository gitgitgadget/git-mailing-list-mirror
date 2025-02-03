Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226FB211A3E
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622029; cv=none; b=CqqiBt8kL/NXFObqlviRPRQryn7/f98OT755n+zVdJKWw/yvcN0MGZ9Yp+1G4/uFGP7jx/cukL05BPvVOlqRvqCl+mtHqbMPWcyZazD3Jx9zkkoj5SgQJa4MB/wDozzGpPrMzj3h9NT3ye8ffgf0GW+df39fcyuqh/1xb46P5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622029; c=relaxed/simple;
	bh=s8m6BXH54tLsr0MIMTOmsjiVbq74Z9Y/G+wzVkmePnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvC/AonMu29Wfc6scyrR07Ykuse7gG5oi4zsxvZXDfr/yRNWxF0kTHAO4uobOF660meWdiPh25cZvYnIT/GPKOsD2qnaVmJZLNGzSerxgCvNHKlGvEzWL3+gyKLYWrLO2Gnc0jTvIDZJBntbiufCdGWFPcvElcYipV6alQo0x9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jHZjMWc7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lnO0ms6b; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jHZjMWc7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lnO0ms6b"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B0031140147;
	Mon,  3 Feb 2025 17:33:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 03 Feb 2025 17:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738622025; x=1738708425; bh=pG3tTXTnKu
	djvTyxT3Ii3yYewqAk11PaFsF5Uz3fe+U=; b=jHZjMWc77763USH8uOQ8xTOYHy
	QmSHYQC6mnvVP7hYZISxxeZrGu/d5kMd6h6TirK3iS+wCXH9USnQ+RrYzCSBnuXf
	jP9a24z3eR3SjjZLT/7l1KtaOda6nSDRUd47xUUC6YuD6wqASyXlfcmKMcIEg9g6
	bZ4i8zmrIJAyvdknOhVV/LFae9Oz0qomJ3npv8Dna0lnsbUDyp0beo4XHEaVW6Fg
	oVxTJN/Xu2N5tCYIgCa0VHdYxj83xCABKnz75UP7hQUUKmuReqseEgLWQHNmvsFN
	6eERnzS8fPGXumhgqJ8pHwcChyBXFICT7ACFPuzP0M2gitBvYndGCQOTJmtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738622025; x=1738708425; bh=pG3tTXTnKudjvTyxT3Ii3yYewqAk11PaFsF
	5Uz3fe+U=; b=lnO0ms6bErgcC2P09+2ytbOZ1zgxn0xv58qeKmmamIUmqSIXBU8
	f92SFMlWcVVy5jxZ9m5HsItEfiCizfiLxJUs7Kl3xN575STWZd78bGVt8aNaoP8g
	H8eWuEzHoi0CIXfl9Qci3YkIfYlltERZEkCw2tvyzqxW2YE31vv8c1Ckco9Pgw0s
	WWs01RewnRnz4SIqns5HrvskDCS0SRuFNk138tkO0t41N5uJk86ODT85nV8aaDBx
	Q3mjPZySBKRCz08MjGJeJXwDIcn51eqoywXkMasytwN77GPBka0Ac7SLrKcZrSZ/
	5yoQVNEqNaECrfBcUJrpZV0pUiumetuznPg==
X-ME-Sender: <xms:SUShZ8T1Q5cSmy30J8fUXxrJVLe1V2acTqR52Lx71S4U2XgJAQ_iFA>
    <xme:SUShZ5zYY0c-IREhW42eAuDKzh3pTGEgqXbBMCYDx7HRE5DYqEUV1Y_p4fK9JQJ8j
    nx_dMb_lLCSoadZnA>
X-ME-Received: <xmr:SUShZ526Twmqwm9UJcsexudK2897Z8n3l9C5-1qXm1NvzMlNz4u9q-Sw__kEe693vOnzRFzYikFMw8gmii5ny51gBy18W93t8wsx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SUShZwDvOgwQuDhO0ICZ490GYm6EQCr5R7lCAKrkMqeew5tRircH0g>
    <xmx:SUShZ1iHFbhT-vx__bp1WzQ1p3fy8ab2L13X4XslsEU_NtoH7va0mA>
    <xmx:SUShZ8pMyk5JVRX7Y_W6oitM45-OIryh41FiTVJQoYqsidrTuGDqJQ>
    <xmx:SUShZ4i_9bWuBIqRsFgdkYw2GoUWTAEKrFajKPmrD98Myxwab96qfQ>
    <xmx:SUShZ1e3PJLNNcKnUqi5anWQYVmySngN4f-B_WcUgsszWz86PMSaU_cC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 17:33:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH v3 1/4] quote: add c quote flag to ignore core.quotePath
In-Reply-To: <20250201201658.11562-2-jltobler@gmail.com> (Justin Tobler's
	message of "Sat, 1 Feb 2025 14:16:55 -0600")
References: <20250110053417.2602109-2-jltobler@gmail.com>
	<20250201201658.11562-1-jltobler@gmail.com>
	<20250201201658.11562-2-jltobler@gmail.com>
Date: Mon, 03 Feb 2025 14:33:44 -0800
Message-ID: <xmqq4j1a1wvr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The output of `cq_must_quote()` is affected by `core.quotePath`. This is
> undesirable for operations that want to ensure consistent output
> independent of config settings.
>
> Introduce the `CQUOTE_IGNORE_CONFIG` flag for the `quote_c_style*`
> functions which when set makes `cq_must_quote()` always follow the
> default behavior (core.quotePath=true) regardless of how its set in the
> config.

Hmph.  

I was hoping that we can flip the default for 'core.quotePath' to
'no' at Git 3.0 boundary, to help folks in non-ASCII locale.  If
this is about emitting pipe-able output out of rev-list, unlike a
patch that is to be e-mailed (and being 8-bit clean was a risky
assumption to make in 2005) that core.quotePath was originally
invented for, it is more so that we would not want to force the
receiving end to unquote, no?

So regardless of what the future default value of core.quotePath
would be, I am not convinced that it is a good idea to octal quote
any and all bytes outside the ASCII range in the rev-list output.

After all, "git rev-list --objects" would show such a path without
quoting, no [*]?

    Side note: the path in the output from "git rev-list --objects"
    is a hack to allow receiving end to compute a path hash, and
    does not have to be strictly reversible, so it emits verbatim
    bytes but truncates the output at LF to preserve the one-line
    one-object output format.

We do need to quote certain bytes (e.g., LF cannot be allowed
verbatim, when the output is line-oriented, and we use C-quote,
which means literal double-quote needs to be also quoted), so we
cannot mimic paths emitted by "git rev-list --objects", but I do not
think it buys us much to quote non-ASCII bytes these days.

