Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D08F22DF9F
	for <git@vger.kernel.org>; Wed, 14 May 2025 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747225743; cv=none; b=fWxxcuJLqruQLEdZRZR90WHeUhnWh4GBPdEYZsuzK0lTnk3E4Z1AvuhHS8JTWPvC3F/qnmqr0LxxN3Rqn/KXSfETjo0Yi9B9OejDJboGvrvRrZQC/uP8SM517CjNdw6QWAxk0JGeRKY+qQA0xpjxR9jZEmXgAZi3Agz4yagebsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747225743; c=relaxed/simple;
	bh=ON7DRxsT/6LBCChnCreQc4wjFMRnkOyo4bNOUofwkF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y9B1YBkvNU+8B+NHcUc8LORya5IbkVq3PcEKdunqOxSLM/m6KMpBQAngZavqOsoW4GJFZwDRf5fF/p4GlWefsfEywxzbe9okY+nWUIJsiFkghChi/M7YDyQOvmKmZW8budoSWx8nfclKkYVZdXOhBQwAFnkEfViwTREVca0tJ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oJUVmar3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oKRy0Fzt; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oJUVmar3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oKRy0Fzt"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8E0A114013B;
	Wed, 14 May 2025 08:28:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 14 May 2025 08:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747225738; x=1747312138; bh=qFtAyzzOb9
	icbuofMHoO+0oHbqkRL+LEVBb94WU2g10=; b=oJUVmar30ChpJfliMpvc4uN3JD
	Jiqn6R0zTVG/ujrkSKtp94oSZHpz9hR/CNZZe3cyXcxQGLZsUoBHgT1musR7pEJx
	uzcOVI0LlBPAsLqv9xiiNNIFDgsQF+EeAyo63E3NyPx0PN0cTbgqF6jHQ7o5qVgh
	EwpdYEBG+lTVAezDfOuiGzGEIyoGu7wYqRwndJV6iC17T7BLvlnTO89hVFyimZiL
	thWz2l2yIa9q3cYbLF1Z72rI+d1XKYK9R8/QgHo20LbhOk3aQ8szKmFov4K5QNRP
	0xKYmGd8hX/n6GyTvJPzMP99ZmJN/ejEtsZ/xLyDKfQAKF/dMlT7syBSRT7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747225738; x=1747312138; bh=qFtAyzzOb9icbuofMHoO+0oHbqkRL+LEVBb
	94WU2g10=; b=oKRy0FztvidEPE0mVggvnaB+XuqMgjRdLnCBgdiIo2UyoA47Pry
	2afG+VPvH687XQqqMUxkaVYItiIonrDMQJgtGMGriwZhMVHNL+INmHD24k4+BYTE
	/iLZdwnobKCL4Lup3KI+difpQCN1oPc2UqI2t1yFVSwgyBKE6gg6iQuTB/U/tXGI
	nraBJ6zvNZzevQ/6NXJcbp2Ap1rZbgX8rjLLOlhnc0KJKvrNs9+OchV/wcrzCiam
	WODeGw7sHfuPmId2f3NcBW96F+WP/zOCf6YoqMbiP6UUxII+VMNgGGSd/u1IPemn
	go5+iGawSEDL5XE5wR5YTWQhoDi5GKHgXDQ==
X-ME-Sender: <xms:iowkaHu_jeh0y9qkjaSkhSJZP8sHGY5X7OuQvDTuiweRcc_9RfRyQQ>
    <xme:iowkaIclvdXcK_sMRP9IVD8kMkvuXUcGlfFC-Lyv2xmRNnx0eMnNgn7fRSRulIyfq
    lo1eIsZ5L1ALM8xRQ>
X-ME-Received: <xmr:iowkaKycFJNjU_De2RgdOokrozxrGYVeqWVtxT9GH3hEMqFYHQy5XXOyXkrDwtOmvwJTDcoUTtxu7STwGOPOQ4W2Z-WEkWE_tfGh5DY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeileelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:iowkaGOp_P_tzR0GH2XY-i1eyRARqrV-bWVKepCYizsyOwy9iqhWYg>
    <xmx:iowkaH_VSjxl4avDa53J92cno7sadseXLdLWU3QFEmLV2ooBYNpitA>
    <xmx:iowkaGWdp1tk7L8DpnGi3MwAX1QYUXpqJVOdyEKWoaFiY1AMPU0x6Q>
    <xmx:iowkaIdTgL9dFKet0evjzGL9MD6zb2BBKbf1_jEs4JSrBcIyFp-ZKg>
    <xmx:iowkaA0C-LGJbjG7FGJAeCsq4ORDnP-p3F4PI0NPfj0Z6l4OCcYECJTm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 08:28:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v3 4/4] scalar reconfigure: add --maintenance=<mode> option
In-Reply-To: <82c2c073-3fa6-4023-82d5-bdb772c3790b@gmail.com> (Derrick
	Stolee's message of "Mon, 12 May 2025 14:02:26 -0400")
References: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
	<pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
	<684f04aaf7e87f22ab0b00a4fd42d2943304ef04.1746582637.git.gitgitgadget@gmail.com>
	<xmqqcyckayb4.fsf@gitster.g>
	<35ecaa1d-589f-4d28-9d97-78bae8de2d41@gmail.com>
	<xmqqy0v1sp05.fsf@gitster.g>
	<82c2c073-3fa6-4023-82d5-bdb772c3790b@gmail.com>
Date: Wed, 14 May 2025 05:28:56 -0700
Message-ID: <xmqqzfffcr5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>> As you suggested in a part of your response I omitted, we can
>> annotate <mode> to give hints on the valid choices to help users,
>> without changing the default behaviour.  I am personally fine either
>> way, as long as we clearly document the reasoning behind our design.
>
> I'll create a new patch on top of the current series version that
> does this, calling it out as an intentional pattern. It's previously
> been used by these examples:
>
>  * --fixup=[(amend|reword):]<commit>
>  * --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]
>  * --tool=[g,n,]vimdiff
>  * --exclude-hidden=[fetch|receive|uploadpack]

Yup, these are good things to have in "git cmd -h" to help users jog
their memory what the available choices are.  We do not have to
always verbosely explain what these mean everywhere, of course, but
if we said in "git commit -h" something like

    --fixup=<choice>

that would be almost hostile to the users.  And in documentation
pages, of course we can describe what each of the available choices
mean.

> One place where this kind of notation could be helpful, but appears
> to be absent, is the '-L(<n>:<m>)|(:<method>):<file>' argument for
> 'git log' and 'git rev-list'. Perhaps this is too dense, though, so
> it would be better split into '-L<n>:<m>:<file>' and
> '-L:<method>:<file>'.

Yup.
