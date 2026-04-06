Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E365B21A
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493368; cv=none; b=V1ZLqDBG5/c+kvl//3ooniff+uGn7j8cw7ZopF2Oj7KWMxtvNvu8kL2OQgqOkciBksNQDpyLR3nFlsokycKBzcRchNtjc5SvnS9cDN5zqcOxrPt480pDk4vACj8tHLe4fgkMnl2iI1Cg8gzpj8YDoqHL3Z82pwX2SJVykeHuglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493368; c=relaxed/simple;
	bh=RuRN36OnPVd7um15yNTGwqEzpXlOJyXDgWX8lFplkRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U3s9dBqBvrn9hcwk74O+pfik/1Xzdn1+H4Ejzte3qHFonbdm5B1hGskQIMhbcDMbFEKBcUOdfwe5KYa5G4hRQhae6QheeaOUv7KCcYB1JjHPtdoL4MUVQ5npkYk/R32V1EGGHPjbBZvKxrDLaqU/c7UpG+RoL/FpZboCa+63PhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YbvpCiwG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UCCyCZbV; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YbvpCiwG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UCCyCZbV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E109B7A01C6;
	Mon,  6 Apr 2026 12:36:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 06 Apr 2026 12:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775493365; x=1775579765; bh=W3Ut/9I5fT
	MkFw4Sj2EeAeullNZ0yNd9YkmVSnCCQBs=; b=YbvpCiwGiLCHqSZbI0xzoawXqO
	ODrkgHL/eB6IQxF87VIHDIjHCRa6Je9zMzsquoysRKMevRpCDYmyJ8x1le7K2NJf
	eVI+uuuTebRg9nLi9nuqcyknz1dTMLbuzO8qaxe4Ye8HXrwR9NczbtEOzNNlFb22
	M2dAtaw8E0T95XUylwS0c+vu9fOP1d6X+8T7jNdtWROUxt7lAGHY1L0v84akJTGr
	8JX9NZp6N4KXiJripz0nA7ryxoljg3/Er7KFJUvQfyfXtF6yM0LX4HB47VFtSALg
	zG+J/P/F24vvTnYDq47e6jZOFwHvttXg3jxoIGf82f2hY4bk0mbLqX0qKHNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775493365; x=1775579765; bh=W3Ut/9I5fTMkFw4Sj2EeAeullNZ0yNd9Ykm
	VSnCCQBs=; b=UCCyCZbV+6gxM7lD3KqxYg+D7PBpmNSB62nGCEbR361IzPfANGI
	cLGLD5enYooGmXkPbOiC25eF3JYsES54FmG0Edg8bgZvODpkkG7BjyvS6Cki8HPs
	JYEyZEvbELHW5nWaa6YdG7Ar5MdVJy0uIYxVwLZIZahmYueMMxoZUQkZwR/f2KLs
	3U0maxH9bir7zs3rvnQIFFvp8SXTXS3jduOURSNqPlQLpsyESa7qG7fmc9sPQfLG
	6GqnQ2FGdKgItO1ItRnSHI8AxPRTB9SUpaZXjRazitGWDlrRcaXEiB4S+56LGpYv
	cL00xCMIl2sFklrWlU/5aM8aMifL8mq24JQ==
X-ME-Sender: <xms:9eDTadfC4IL5NFhoCNlDOWVNaffbgjHQr-DioA2EjvVt6QTGhHC2EQ>
    <xme:9eDTaSoXxmqoYh5iu_Gu5Z6DLmWmPTNPliIEhkkFL_0p3RELpZsxztF7xu-oPBf4w
    qRzSNF1Juk7-1TKwxCTf2KMskcM2rEQajyDuC1oIPh5j-75H3yb6A>
X-ME-Received: <xmr:9eDTaT6hXWq0dKRJOzbsd9aj7TCXgSuZTrc5VQsJAXynCfHsNvMLrWrHLDsaqqAmjsGCTl8cbXZ1EVqFTa_ejoMxka0yta7W5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehthhhitggrnhesthhhihgtrghnrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9eDTaQrfrbpsTtEFyMtsBE0DaJqyLQdQxMR8p8kKIPePOjjz-DH1VQ>
    <xmx:9eDTadhuBGbdsDv8vjXc8161QqYKrxYySzc2hTWVCIqFg9e5Qt1aNg>
    <xmx:9eDTaSLDKvWFgnacBzrLtaNY8oJj2EpTVCxKa4-MgTppkbIuQVmJCQ>
    <xmx:9eDTaVCrsJvfl6Kj4mf-d6e38_AwpG24tJz7F4IEzieuVyRfcysnEA>
    <xmx:9eDTaZUyVQeTDTVZqx6km-zZayHHx_2qza5lDPUx_WtmMK4eO6LxiUDH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 12:36:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Thibaud CANALE <thican@thican.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] switch: provide configurable detach
In-Reply-To: <njuf62lav6akkmdyqutwk7pim5yutw5cuicjidwpe5eh6qnkqr@4ir6q4uhhvht>
	(Thibaud CANALE's message of "Sat, 4 Apr 2026 16:28:57 +0200")
References: <njuf62lav6akkmdyqutwk7pim5yutw5cuicjidwpe5eh6qnkqr@4ir6q4uhhvht>
Date: Mon, 06 Apr 2026 09:36:03 -0700
Message-ID: <xmqq7bqkcah8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thibaud CANALE <thican@thican.net> writes:

> Its purpose is to provide for git-switch(1) same detach behavior on
> commit it than git-checkout(1) through configuration option
> `checkout.switchDetach`.
>
> Signed-off-by: Thibaud CANALE <thican@thican.net>
> ---
>  Documentation/config/checkout.adoc |  4 ++++
>  builtin/checkout.c                 | 18 +++++++++++++++---
>  t/t2060-switch.sh                  | 27 +++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 3 deletions(-)

Sorry, but I am fairly negative on this change.

"switch" was an attempt to give folks an improved experience over
"checkout".  The implied "--detach" was deliberately removed from
the command and I do not think it was a bad move for our user base
who wanted to have "switch" that can only be used to switch branches
(as opposed to "checkout" that hecks out both files and branches).
With fewer choices in a single command that does only a single
thing, the hope was to make it simpler to teach.

And it is backwards to make "switch" configurable in that context.
It defeats a major point of "git switch".

FWIW, "git checkout" that knows what is and what is not a branch
name and does not require "--detach" when detaching to anything that
is not a branch name is always available and will not be going away.
