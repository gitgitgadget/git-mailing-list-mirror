Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1315221F03
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901572; cv=none; b=JZdA2HLbkBQe/P5vxdlo4fiLeXcWJxeAx51oj+KmCqb8MOJGGWIU9Yobu0IVA+1eva4t2seY1ASTMIbpJgbXDa8fVEpPFs69a+HVrdeSkCFz8CrjxhyKBA/z2o25yInJlYQYb9rekpz1LgDL4PBsXAY9t/zOSw/SMj73ogN/35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901572; c=relaxed/simple;
	bh=726k8NbthadrUjXMlS++dVCfHMZD14XAvX9JS/9emVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n4ygngTCir2E1J4yMUtlhSMG/4IHUV0PhqQJ09CxtYj0TggDtQUjUraUefOWACYxCEM+w7WxuppX2xg34mbTzJJ2CXT0gXi3PhckjYHgeyIB61pc5LDQyJCEv9O2lvU+1+11+eGOzN8W7+Hd5ChRKELyj8ySNzjTpIv+lpGllLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HPyWPEHV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DZZd/8Xp; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HPyWPEHV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DZZd/8Xp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F5391D0005B;
	Fri, 26 Sep 2025 11:46:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 26 Sep 2025 11:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758901569; x=1758987969; bh=9d8aaXhw4b
	nSStxOLCyyjI9bCS4Ftz95UA20XnzG9qo=; b=HPyWPEHVlBR7TRxq5I511ZK+Lq
	mZjnNza4ZzIisaFV5gFWaDPDVmxGV7Wg0Nb/Tmy0PqCG2n91OPKv8asyWto6Ud4R
	MdpAzduQhRMnTh3kpm/MvAq8C+wtEffZoEq7CifqCqy7Q/VOIAB0B1Sc35ueQg7y
	98HKCmSQQVVfl8ga/AI9KwfSohiFblla49snFlmXafva3bmv9vBklEBV31ONQej3
	UGCx2+EpQMFvLwYdX5re1NcpdGgU+9y1mpBEwCXduSToUPCy6eJpxWyhMI2Oo0Xo
	IskYhB6YHGzKR4a832RSv8rnCzXaXDrWAa6/RAL9nlD4ihGTIATVOA/o/YZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758901569; x=1758987969; bh=9d8aaXhw4bnSStxOLCyyjI9bCS4Ftz95UA2
	0XnzG9qo=; b=DZZd/8Xp9luOH3GGKBv5lMUpiIs6pOgwZGANr6IgeQLssk8mtq0
	pvrVziqj6/SZFt63lNSJa6zTJOrECQE9tp9JdRNT8kr4V4vse0mrnQF5LArWt6OQ
	s9f7bBEzjgakw+aJ78zeMW9t+eTH3GlED2d1V3fmXeley1sadoax52d+hEblEL+k
	VJOpIBHn7Ww2q/bD3vCHFfvz1G5O61iOpVPIp6bikAyjfzQqeKwcdkczikhljPEE
	BuCu/eCq2HgVMGMfvzoDA9ZzQlOgWZXz3NiylLngOHnSzzI0Yo3ss7zGvYkerigx
	zvJYLGClmAmqD1bGOUUaS7nW7+BEI1ZzyUA==
X-ME-Sender: <xms:QbXWaBF4T9wvLkLqMj0PsEASk_FR38NnBbq9BBI8sLbJ5S4W50XH7w>
    <xme:QbXWaH2PAid9Gn4V2ip4B4E6JXki8js5EdaRgeacD0Cv6DYmECU4dAQEJZedvIPOI
    tM9txhUJIhjV06_A2HtTkLGGHfYqDYZEpl93dTSdwsKDLPm2KEW3g>
X-ME-Received: <xmr:QbXWaDMjU8s_zRW_4oELYW-4ik5tc5w2u-p6Wmmh54kbM6pS-9Ty6_AWfhAQcnkSC9Sp0sWDQ7u1sN89QBiRMtXvtBf0pGQIZF-_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmh
    hsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QbXWaG4oBvXA1uel50Q3FeuivtGwyZW5stSETUim-YYEPmWUVQzacg>
    <xmx:QbXWaN1Sk9sGIb_2HlPkNMOmY3cyXO-RzbOpqC1yAUcSWyNxwSO6BQ>
    <xmx:QbXWaHwXWtsYcp2rOyNXg3krRokViD3jsHmJfMX7hoAfvRQhUB34kA>
    <xmx:QbXWaHvCiM3c2XNdeIzfNBYgaOOnHwPeHoJkoRxxeSzOxvyjhW5RqA>
    <xmx:QbXWaFwEDHf8l16yuolpCpBy-cua9S0bIVMv4qOsCTbnH0cHYDXM_mqj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 11:46:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH 3/4] doc: sparse-checkout.adoc: fix asciidoc warnings
In-Reply-To: <19964f5e-f553-4eda-8a62-7d0aa3017657@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 26 Sep 2025 01:26:14 +0100")
References: <19964f5e-f553-4eda-8a62-7d0aa3017657@ramsayjones.plus.com>
Date: Fri, 26 Sep 2025 08:46:08 -0700
Message-ID: <xmqqms6hcj3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  Documentation/technical/sparse-checkout.adoc | 38 ++++++++++----------
>  1 file changed, 19 insertions(+), 19 deletions(-)

The same comment about explaining your changes applies to this one.

> -=== Terminology ===
> +== Terminology ==

We've seen this in the previous step, too.  No comment, no objection.

> -=== Known bugs ===
> +== Known bugs ==

Ditto.

>  This list used to be a lot longer (see e.g. [1,2,3,4,5,6,7,8,9]), but we've
>  been working on it.
>  
> -0. Behavior A is not well supported in Git.  (Behavior B didn't used to
> +1. Behavior A is not well supported in Git.  (Behavior B didn't used to
>     be either, but was the easier of the two to implement.)
>
> -1. am and apply:
> +2. am and apply:
> ...  
> -6. Performance issues; see:
> +7. Performance issues; see:
>      https://lore.kernel.org/git/CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com/

OK. They want our numbered list to be base-1, first item being
labeled with "1.", not "0.".  I think the majority of readers would
prefer that way while reading the source text (I thought markdown
formatters would renumber them anyway, but I probably am mistaken
here, like in many other things).  Curious that we have "." after
these numbers, though.

