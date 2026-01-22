Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B102DFA2F
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119670; cv=none; b=abEXvmhdRksKe4eZvhIfR6kYhn2r13dFyAiLqfSD81wmOhM5C4QxmPi+LbxTzAKBmcJQiFdYfcNXqwc6dDcwkV/ZEo2dfjoTKJdWZCWASVj3VjkpMYj5eP/DbuyoDcBqVDmY5aCiVrY+cQU5w17WVqZTdRwekakQgfY7+0oEzyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119670; c=relaxed/simple;
	bh=5tAUB9zYNIi7oT2COOUaTD6uyms2Bv+OCI4gfJRJR8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mzd4GVDYGQt7qrqKW7iySencEWTNCJ5UlF13y9zxnmiRlZfPv6FPYKup1gOJT9mqlF28RTnpG23+QGhsdy101evAFsDl/h10JcFODYiEsy6qB/zofXdg0IZKRlqc6VVxLShqBRJOwmQD5ugrcPg3iEY+is61CjD51ZeJvDJ7fPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ehOn33Ah; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m0OlBL4q; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ehOn33Ah";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m0OlBL4q"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 229601401048;
	Thu, 22 Jan 2026 17:07:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 22 Jan 2026 17:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769119663; x=1769206063; bh=IXwdoaq6O7
	U3pP7GDjG2H2WCRodUkTOOu1ndBhPJWcc=; b=ehOn33AhXVkvx9SCcI1s3hKqh6
	c886IRdIMRQHewB8g8CZybIw4z8acgtNHzWEE+QOyKe3cfBo2oKYgdubFSgdtTIy
	r6h+90t54NZD/A/gC0+H5oVrZf1ftqpKv7Kzpju4g+j/HGKhAmqMX3BbiPa8SUmt
	weoqeWDCugVkn26eh1lPCRtK2uwPwxT8XW17xQNAeD+jREJsL1Gv9KrNiJQRxtWp
	Wey+MHjMqGre/HqilYgdL3Mnd2v2ktMwJ7oQurTtRg3HabOYmYSDcl8y0ibvegM3
	TmQ0umiHAvhp/WShT5TvLfhmaQQyx08JyOsDgeT2CmFIQ8dTomM7kOYRnWDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769119663; x=1769206063; bh=IXwdoaq6O7U3pP7GDjG2H2WCRodUkTOOu1n
	dBhPJWcc=; b=m0OlBL4qtd/7xbRKm5wTzsaOiaW3aI6vdsSLyTVdtoo8hw1V8Bc
	E3ydMRX41eLjjoaSth024u7IfEwc8prx23OFQdPyG7WUtkxW96mf1Q3BDRGswv/x
	Lnpf25G7u28pWOaAcn+eL90pSJjCBWJMBDjToPm23s6gi9o3fy/B+VLjcumgPTlE
	UDLK+Ur4RKD1XmL3t1d+evXJ8K26bt70UX9pdGiODVtxc1XNovE/T41aZtz8KzZi
	27EEsz1SaC8nmVu8Z3mlJF0sqlgxvtGeH7T07LDLdCjtIzpfLprFBkxHsiG1W0+k
	+eRm5k+0+HUrYUiB+GDIe9kCYu/+So4J7RA==
X-ME-Sender: <xms:r59yaUBddl2qZEb0IFX-zsGCtowqhK2RtBfJGdlj0_WGeVsJP5D-9w>
    <xme:r59yae-O8OJPXaXd6p2y3n7yp_JmoW2l3Tg98z-UZKY7QBF-_WfOkTLX-mbmHYP2d
    uBRQrIejc-606DYd29C8gLrBKMcyLpOTZ-c8LY4ntgagVYkTbNx>
X-ME-Received: <xmr:r59yaYAFGatll3Q-5VWIFX-Oo3-S4SHSP0vxmTANS9cu4FSWwC79MYWBmKU0VZZ6GLDizvm-g162iJ-5rK4cG66FCAuK5e_0nTaakwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghmihhshhhhhhgrrggrrgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:r59yabQmDs1us-_qNbRaY509KuOhK7QfhiGRZHiEdeRbGPY9aqxZrQ>
    <xmx:r59yaXtR7Fpw6r4pt5hdCLNO2dY_xiFQvXyKAXDqVS4PXm1sFTXJiA>
    <xmx:r59yaf2pP93ame4AF-3s6-E1vVUOC_rKJKBBRfOYB0IsYB2iVeiWZg>
    <xmx:r59yaQWz3oC2mFZFAgqB1rNSU8-NCInsNnpccKZZg_GZZYFngSrKew>
    <xmx:r59yaeco7df1FM4dyWMTVtM_BKsV_HTbI1SqWjK1MU-OIH6Bfe8_cK76>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 17:07:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 1/2] Adding string_list_sort_u which sorts a list
 then deduplicates it.
In-Reply-To: <20260122171523.94234-2-amishhhaaaa@gmail.com> (Amisha Chhajed's
	message of "Thu, 22 Jan 2026 22:45:22 +0530")
References: <20260122171523.94234-1-amishhhaaaa@gmail.com>
	<20260122171523.94234-2-amishhhaaaa@gmail.com>
Date: Thu, 22 Jan 2026 14:07:41 -0800
Message-ID: <xmqqcy31l2s2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> string_list_remove_duplicates is almost always preceeded by
> string_list_sort, hence adding string_list_sort_u which dedupliactes
> post sorting.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

in this order.

To those who have been intimately following the discussion, it often
is understandable without some of the above, but we are not writing
for those who review the patches.  We are primarily writing for future
readers of "git log" who are not aware of the review discussion we
have on list, so we should give something to prepare them by setting
the stage and stating the objective first, before going into how the
patch solved it.

With that in mind, perhaps something along this line ...


    Subject: string-list: add string_list_sort_u() that mimics "sort -u"

    Many callsites of string_list_remove_duplicates() call it
    immediately after calling string_list_sort().  It is
    understandable because the former requires the string-list to be
    sorted, but at the same time, it is clear that these places are
    sorting only to remove duplicates and for no other reason.

    Introduce a helper function string_list_sort_u() that combines
    these two calls that often appear together, to help simplify
    these callsites.

... probably?

The same comment applies to the way the other patch is explained.

Thanks.

