Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695631D5CFE
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822240; cv=none; b=fQtFJb+0v09T3ngY1zqMNG8QibrEFclsc0dSOAzO1Txh8TpDxz1NQ2k65aBhsOY31LDczdZyjdUaSC6ZoYHdjcd69aCjRPcXMk2TEEVS1WCs3ErD3f8MHCiNo106biITCjHN5Y+nxp1PkO75yE8ee8M1zSTHbezR534rOhINz3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822240; c=relaxed/simple;
	bh=oLFNcTeb/7Ll/j8NcsoTMy4UaY20Cb1g5DplgcbTqKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nM1JKJ5lEoEYQFI+/xOR76W0+Pa6ZzhmPdW/nXYZ2wHhF1egar7BiejmAocjZexql3TEkUEebv9wlK1JS8y58jJeGIhSpso6JgZhxgOrb3a5Gj7K45xzDzFh3IT6oUQJltJI0pDtZwzLYdAvQOE6RL3pTNBGawdBGyDppa6UOc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JZfgG8t4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDD59L4I; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JZfgG8t4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDD59L4I"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B9DDE14001E4;
	Fri,  6 Mar 2026 13:37:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 06 Mar 2026 13:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772822238; x=1772908638; bh=YpgDWIrbtV
	ay3JlfLK0qdYOd1fazLZqkX9MWF02kUmo=; b=JZfgG8t4zXuff+6T5ybm7d+tou
	DAToDVH/9UDEJKY5zPriXJiALkWbznFCiZgsmf0fIKJtSG7IcIJFbbV6F0BWf099
	1O8PXUeF4as3OBs0WU/rV3GikDLRaSoOcpvwkwqXhywNlAVe+NE61aLmXZHfrV/U
	udjDthNijrJqc0gtIzOUh2Yd7vNyvzeXpoY7/HcQssUJCCp1S0UWqs0Olypt7GaK
	xqk1rlmeeNX2qQGVh8oUEhY6dVS8ALGpoGyBa+41y0fTJsFxzPNzIWioLtGQwW3B
	L0yQKHuE5W2xCBeJPVyy7DE5MAfIr6DvOE/OpagjmsDcLiDA8c48nTIDEs2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772822238; x=1772908638; bh=YpgDWIrbtVay3JlfLK0qdYOd1fazLZqkX9M
	WF02kUmo=; b=gDD59L4ICJEN1b0+CPrZ1J/xhINApOrwojFld4G7qzjMWyok03o
	xQAPQk+FWMgc41Ne9D3gi0evaF0WfYcdaBs4he9QfmwwWNzIgfHFQIrh0gkY057b
	CDMDB5HHLZ+z3b//jK54VhBp7QaTFt6R5t0HYmHqVyCaMdwPV6BeZWdU+T7M+pJk
	RmxJ9ARnMI6G2mwPMm9KTZlMyZEp+reHiPs4ej/oYuI8ZmcVnZvlAolbF6KBge5D
	TBKaMX1g+cpVXahEW0gwx1ssS76eHlbBPUYlt5DdqVhPDDcR+1msx+8dUWOLe4JS
	6UPqSsUyQDcDb98Tz2541dnIDK5t6rZJ9Ug==
X-ME-Sender: <xms:3h6raZb1mycYmHXN0whR6aAWQ1T80wgc0bc0A1nu95inJdGj5ZbA8A>
    <xme:3h6raeNidE_IvERRRaqHrrGJ89oBiNIJwn4o385L-bCYf5xcMVNNBMPI-jA_neP8z
    U7yEUKIJOAtsKc-M-8ryMS_8aekJiOLgmfbk8pyBAq0NcD3FaxcRg>
X-ME-Received: <xmr:3h6raWZC6xVN6qM65EqfkHx7DCK6u4wfXXepc3NQsgKyp_4E5bP8u0StuRWqhbZF7Vayyseg3Y7onvpnP94u-X1UhCT5kVbetg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedttdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3h6raU03cavr5WUZoUXq6v0v-jt3HDU24_pNrS_gZ2c06RpsXjzbDQ>
    <xmx:3h6raUfNyv_ZAYtnAl9Xc24ISGHjCoBKP_H0By0dRan3HmnhjW5LKw>
    <xmx:3h6radEXaAg-dQINoDHxOCIx89B6iyAc5ROQsastU8FkDjqLGMbBCQ>
    <xmx:3h6rad18du9yQ_f4K9lDhAkJ4xeLSrOtuc__PfMUrkQI4jS6LxGPFw>
    <xmx:3h6rafXFTbCgIqOE7C29VWdvxtsPKRVFQlf5LiXVzxOdedIYzXJUnxT5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 13:37:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 0/4] plugging some mmap() leaks
In-Reply-To: <9137fd66-9ac3-42ff-a892-1b6f20b49972@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 6 Mar 2026 04:37:49 +0000")
References: <b9fa930e-7d5e-47f1-8896-1997cf7c0cdb@intel.com>
	<20260305220214.GB736322@coredump.intra.peff.net>
	<20260305230315.GA2354983@coredump.intra.peff.net>
	<9137fd66-9ac3-42ff-a892-1b6f20b49972@ramsayjones.plus.com>
Date: Fri, 06 Mar 2026 10:37:16 -0800
Message-ID: <xmqq5x78249v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> When compiling with the NO_MMAP build variable set, the built-in
> 'git_mmap()' and 'git_munmap()' compatability routines use simple
> memory allocation and file I/O to emulate the required behaviour.
> The current implementation is vunerable to the "double-delete" bug
> (where the pointer returned by malloc() is passed to free() two or
> more times), should the mapped memory block address be passed to
> munmap() multiple times.

Sorry if I am missing something glaringly obvious, but quite
honestly I am confused.  Wouldn't it be a bug to call munmap() again
on the same region of memory obtained from mmap() and then already
unmapped by calling munmap()?

Or can the emulation layer cause such a second free() even if the
munmap() is done once and only once per memory region obtained from
a single mmap()?

