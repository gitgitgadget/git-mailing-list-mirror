Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1243D47DD
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961789; cv=none; b=ow4vp6yMnBGsSi2EvdkKIAdu9e7dhTGrqMxXUh3psDoisiaJxoIhkOvOp22ApsndCqcpMabgkL5XjSmJetsUQ+dYNFsIyujFyUhVg+yfWmobrI2GvNyPVO2UjOwP65+gTfzQwvKX6/Zlq6TkPiCyvQgLlUjtqeMLL+KsMKKYtek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961789; c=relaxed/simple;
	bh=s8nIPlD6rEahRkXOrm07PEQeiGQjXykcGjL81YIFOSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PG1S5bAb8BjSVEb/5KFKt91SQKJkZxNeeiy297u/idViOtvE6Yr+Kstz1sJFL7JXqFBPHnPUd3ox/prdZWaXbY13Ampbka85jnkk0/O7bx+/eJt9rNjyNPokktA0I98yo1UyJW+r8aGGNEpGcqF7rm4ZEJIyFOj5Y20c+BxD0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=x2rm4t+6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fuacAQSQ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="x2rm4t+6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fuacAQSQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 87C287A00CE;
	Wed,  5 Aug 2026 16:29:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 05 Aug 2026 16:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785961787; x=1786048187; bh=s8nIPlD6rE
	ahRkXOrm07PEQeiGQjXykcGjL81YIFOSs=; b=x2rm4t+6x60Xok3ZrQDGILAaAO
	jG4bGDVmZMkza0rLgPuC86GG4/UmFxVgiFfNJMv8+diwd35VMRw1IYGFEhB7ZVNr
	yeWgxIxudtkc0kDHAbUoSeqHwueJHY70L8vZGE65QTIWz4EOtihh3wbQiw0W/t7d
	Ozfq3Mr545Dwvg5Xynu/jyFkpnSqUrSgqfpG8151NJe7iIxlEZk2xM0IV9mTJhx9
	pPgQ/p7Ofn8o3BSjyoAuTpsu9kNJgzr5J/NhsVNUe4i8W8ibvEprGR3a0hX4K2BF
	NeKQ2qhE39c0N9h9ouvESzy1BZOD6YTu2qSG+j3JM4BG5Kvf5C+a6ANunYzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785961787; x=1786048187; bh=s8nIPlD6rEahRkXOrm07PEQeiGQjXykcGjL
	81YIFOSs=; b=fuacAQSQJy41Z/xWQ4wRbR0o9wC79jWZ0k1jZn7fzVRtajJSSp6
	MX+LKM8AuthINukKWmV+6jQutxX2JsLgv2pB6qh0EqNGLb1Ovzho8S4vs3fNVNx9
	nkAxZJkvOCulua2pwMzq5mwbbcz2g/o9VDANPXFoJ7yYpd4qpX/+v4B+lhMrP66z
	luS//eZUj3SZI9kqL3++Kd9url87hlIk5qpIx74Fh0eIcr9axWUcgItUPx3XOrB3
	7lBQXGCxP+mlpNtrGodOFyulzoiKl8YJT6PB+s+nqBzBJnA0ApydqS6gYixqCP9S
	CwIJErWJ9zgaRty5X8AMtBuPCZrtVaflISw==
X-ME-Sender: <xms:Op1zaoYsJALPDF0pQt6ukN9fK1sNKVQzXXD2-d85jYqAJYpawkS_pQ>
    <xme:Op1zamdaZNl8MWdCCghXak9sjZNAlPnPnZ2vkHVFSMk43pJFDtESZafhhjXZUJgVD
    lyZJMzlEYsv-ldx9Dq_R_xFcLR4yAJ66Q_4m7eY2Ewal6GtWPlLpNI>
X-ME-Received: <xmr:Op1zatnfBL4Ln89gToHEm6c99B9HX8IykpEqFG3t3s2sb6cP9vI_kNRBYFA4qAEt8ceR5Z5WnDD6Wkuwu4ecDTd-wL5_7lygMg>
X-ME-Proxy-Cause: dmFkZTGtNqkwlvufG1p8ADOfmTgyBbzjxFNXl2roGBkZ5uhu1wb1YxckVvnEI7tVJf5Ose
    lwgE0zP3Cq0S/ct/+ZUlTsazpc7gYQx1iXW7fYBoDc2kZlbVU34g9pNYH70Qozi3olmkXG
    lBzygisk3SmWpwG8djub8wTiNx5IQTBxnGMs9Xn3tY7gHK7yBd7EnQLwqAYUa+M1YUSVkn
    udgPDgvmaA/eeyWj1SDrzCewaMIxheGEfAsO6BROMqUTZXJPT7GVX0fjviNjbNOxycARXu
    7Wi6R97H8Cr0sEIV14Lz7Ew0k5I50b5EflcY+3AbptGMf0JgEHuo+LGFWfm87TA+ZNFvMs
    mgO0wLZbkPZ3oV9XiQbkSm4TgcZ2Ca4uAfylDBThSrb2yIvvFjIXuWvTGsoXTdtRJCZK83
    FmYxbzMjfKfbi4CG+darvZA1NsgKPiQ3xYLqlEIGYvXQwFb2VCGjDWJMGs2cg21vzMpgy+
    m4gWvHjand3zN+lpwDLHvjc1Fymh2mzf7cLJs8dXJHjzG9YMtZ6ArmtubXnlwgsd0NrBRh
    MI7ZEa3oiaCDFvKNYSwJeRvBQpqVroT/trjM+6M3I7qweaubmXjraqxIm++xQhWA4LCooH
    +LT92UcUOREFQHGyKN9I8fVZHdp89OA7JBxVxVFG06SYMm+xYwavzzjS1l4w
X-ME-Proxy: <xmx:Op1zau28PqzoWLV9V7wILl6gzCRPZUA4yAduzUO8nJ2cGtbA8hNIqA>
    <xmx:Op1zaufHr_i8JVyWv4zevx-b0eAdB_6jeVHc5u5NS2YfVvk9vuaE6g>
    <xmx:Op1zaga41y0kGzT83fEK5OhykZFEeNO_Dl8ruoZ8BNo1YvNi9g-vmg>
    <xmx:Op1zarGAMbfxXtw-5-soqXyfotZUYa40UlcXdslGZJciFT4GXOABrA>
    <xmx:O51zahmlDgwcFyAGMX87y0e_8G2t9VyWrTY4zB8lB35y6i7QsaAlZUZP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 16:29:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>,  Ben Knoble <ben.knoble@gmail.com>,
  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH 0/5] Reintroduce writev(3p)
In-Reply-To: <8ff3c3ea-2604-4d65-8a7d-6acd6218b7c2@kdbg.org> (Johannes Sixt's
	message of "Wed, 5 Aug 2026 22:00:51 +0200")
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
	<f8050598-392f-44c9-8d66-0454740a7a12@kdbg.org>
	<xmqqo6fso2s8.fsf@gitster.g> <anL0nIk6uzkYR9Oc@pks.im>
	<xmqqy0ekr0bm.fsf@gitster.g>
	<2952d9a7-c7c0-44c0-a321-7ddad6497a6e@kdbg.org>
	<xmqqpkzwpg1g.fsf@gitster.g>
	<8ff3c3ea-2604-4d65-8a7d-6acd6218b7c2@kdbg.org>
Date: Wed, 05 Aug 2026 13:29:44 -0700
Message-ID: <xmqqa4r0payv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 05.08.26 um 20:40 schrieb Junio C Hamano:
>> I think it is OK to explicitly document that any writev(2) emulation
>> is allowed to be non-atomic, and it is also OK to declare that using
>> writev(2) in this application to allow competing writes to the same
>> destination is a bug.
>
> These are fine.
>
> But I'm not worried about current uses of writev, I'm worried about
> future uses: "Look, we already use writev elsewhere. Let's use it here,
> too, where we can take adavantage of the atomicity of the write." It's
> too easy to miss a note about non-atomic emulations when the function
> name advertises more than can be guaranteed. For this reason, I strongly
> suggest to use a different name.

That is why I added the "it is also OK to declare" in the above.
