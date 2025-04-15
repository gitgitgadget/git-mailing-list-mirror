Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2C2DFA21
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729516; cv=none; b=rpaBPFxpbrhBbkdpq8FDfx+GnzDsQU/onooNr7LuVX9WtHni+kDLd+2VanS4RdVzJpwFeMGBH+0JSrNi6Yx/KhQHbw9/by7frsRTUkyRntKuXdaJL/T4zu8ybECCPz9zKKWsXnZBzaWs+LTIcBdyj5dIP9oLLwOLYz0iw/Yz66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729516; c=relaxed/simple;
	bh=YVTt+D8/ANOfCNQQxQJWEbYFwDevgIaInD5wi06Vnbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X+S/HgQG+zTB+N9j8Nqx4DvWP7Yi8IUol/a1GkIDyoSSIv9FiadADV8qEr+jzzxaG1623flE+WutPqiwcVaPeTbadwQRKW0B9mkpsplQGMNp3YXdo9yZQOEbKiFAD2pWXifU5gi1u45FzL9tVnwcZUaLaylrRhOvNqHdl/erROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vZMGbcEe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fzKcV9mw; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vZMGbcEe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fzKcV9mw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6A8A211400A0;
	Tue, 15 Apr 2025 11:05:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 11:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744729513; x=1744815913; bh=ykTlhBvar5
	A8d3yqiH5klltrbfbv3WDa2JRUGwcEkqc=; b=vZMGbcEe3/W90m+u5ZD3Lo64So
	rhVA5by2cZNnl/4AQdpeg1Lne3QhDm8umZYh8wfjaJ9Zr+B8zKilxnIbqM9J5c32
	VYtgGJ/2UizQowvfCV2Xs9TNLHsZc3dUDvwiTVT2t/UpTxW183+rVwmmj4RBYwMK
	vrn8DS8Gmc6CrJgL8c9BQVSlP6urVhN8/L4sDpfM5+V8EKKRjhg5qXDcYzSAAgGs
	cV1yTIcWAfy3AaWhiOX3DU4hIceaanfsu9dmI2MPPp1N+y9IpQbczxXE8GIlIn+o
	9zJcoOpsLBXYYKwQy0HUN+gymT6T0P2IV8EaAbiXHtmYd80iEjTMvw93AvJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744729513; x=1744815913; bh=ykTlhBvar5A8d3yqiH5klltrbfbv3WDa2JR
	UGwcEkqc=; b=fzKcV9mwDyPsOJhsjsMY/6cfdi90DR6OUY2ndNY3D9NRQQnlmps
	lwRW5LnyL7TqlaMu9EfYTsU3HJwJb4lSe9Mg/zysBoYIG0q7NT9RWwmC37JhIpNx
	/mSULfhpbXXuSf9MLfg95GlDsZ9/YvTS9dS2Ueg2IrCGqcm+xCfNxpqe7QDL74lY
	K5CR7ovQQO6f+ReXYjSK6/d+mI+K3ViNal+VNPrh6PP621UzaDd7K50rtRLuUxfl
	hVJ90achhbVry8Apziqp5XT41LN0pOgX19j52P2UV0i5/payGAdtQ2Mhl2SDb6Za
	ROIax1mxFzkU2PrT7iTwdvtFnJVS5P3AklQ==
X-ME-Sender: <xms:qHX-Zw5b4gj6gClBtYfWj6eH-6VTS5vZZO-sSha7HDAmJmBaqdEBNA>
    <xme:qHX-Zx51DYPUgElI4urSrjIYu9-iymg9Ru8BFTDjmIWgyNntkf9-a_6zIC-SN4mIp
    aq5iH7ZP0laDLsTcQ>
X-ME-Received: <xmr:qHX-Z_cp_NZeetkXpx59vLZcZzz93FInAFKe8PMsoutzuSFP6FjjwTjFxncx4LeBXen9cucPwKsZT8JC_PJmZrtdosRCwG7iwTZc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtseguihhnfihoohguihgvrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:qHX-Z1I0qT3H12rX6zhZhX8wzJ2Qe7l6BAA6YjLVXZ1QBbnVT3NGhw>
    <xmx:qHX-Z0K36Nn8NAkWFsRYmdeqQ3YO7nLD5RgeKKslf7I45On6pE7U8A>
    <xmx:qHX-Z2zveYq37bui-L_k6p3gecLMwPux3I1L69__yLskaIak_C-4-g>
    <xmx:qHX-Z4KKM1VjCcg8lZ5zrp3SSeggJuPmeBX7S1Ky9QXiDc4garWG7A>
    <xmx:qXX-Z5FleaPyxJPnJuY5AzkIr-MjGQ1_YV-8HFR5fIA24306AZSLgITt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 11:05:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  GIT Mailing-list
 <git@vger.kernel.org>,  Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [-SPAM-] Re: [PATCH v2 07/13] config.mak.uname: only set
 NO_REGEX on cygwin for v1.7
In-Reply-To: <Z_310iVKmhrl0UGE@pks.im> (Patrick Steinhardt's message of "Tue,
	15 Apr 2025 07:59:46 +0200")
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
	<cover.1743859985.git.ramsay@ramsayjones.plus.com>
	<324bb213426ffc9c1f9cd155de309bd0b63cdbc4.1743859985.git.ramsay@ramsayjones.plus.com>
	<Z_y_VeJzT82by8wg@pks.im>
	<db92840f-ed4a-46b7-aba0-b556ed33af6f@ramsayjones.plus.com>
	<Z_310iVKmhrl0UGE@pks.im>
Date: Tue, 15 Apr 2025 08:05:10 -0700
Message-ID: <xmqqfri9o47t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 14, 2025 at 09:03:30PM +0100, Ramsay Jones wrote:
>> Heh, as I said in response to Junio, I have a patch that removes all
>> of the config in the conditional, so that we would no longer support
>> any 'pre-v2.x' versions of cygwin[*]. I think that would be an entirely
>> reasonable thing to do, particularly as cygwin thinks of itself as
>> a 'rolling release' type distribution. ;)
>> 
>> However, I don't think it is my place to make that kind of decision
>> and I was leaving that patch until last. Hopefully, Adam will make
>> that call. :)
>
> Makes sense, it's a bigger discussion indeed. I do think it would be
> reasonable to drop pre-2.0 Cygwin, and we have recently become a bit
> more aggressive in dropping support for ancient OS versions. But I'm
> totally fine with not doing it now.

Surely, and thanks.

If Adam declares that pre-2.0 is no longer relevant to us, I am fine
dropping support for it.  The fewer knobs to tweak we have, the
better.

I do not know what the best plan is for changes to update things
that supposedly help supporting pre-2.0 boxes, without us being able
to test, though.  I think I am OK with "this patchset I try to cover
everybody, but this and that systems are untested and untestable by
me" and I am also OK with "this patchset does not address this and
that systems at all, as there is no way to test them by me".

Thanks.
