Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A521FF4A
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760888015; cv=none; b=YCx/hAMMPXLepxGRMytaz4Vds6xli8tPZRB+5JzOfZi52n+UFivqDHIs8YPZcP5a96T3a7yOBzD38HvCyNpuiPIHK3S6o42ii5U2hsOjyvzWZvpmy6YLQEQ17HoqVBPLgNktOQQYirnmPyjjdDnwfod2KmiMOdxfvstgJOldGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760888015; c=relaxed/simple;
	bh=jNYwH5a4dmnLoE2LZVgrIL0A+pTwJ7VfWQwpXfyh1bA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JNTFFEzgW83iAnOhyuwFXcNv1GWWDTvx88EYgollqrOVLwktOlodn3t3HbMvlHFwvVGtBH/lnebqJz8/F+Rp0r/g0+SR252NaSewFtxH3ZwRYH7KtNb60qQFLepnXDZS18MMyyQpGP9OLW6/MoYXgKcLehYuZNgq3Z09I2t+1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UhX1WuEi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iwOuabSB; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UhX1WuEi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iwOuabSB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 73A681D00031;
	Sun, 19 Oct 2025 11:33:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 19 Oct 2025 11:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760888011;
	 x=1760974411; bh=ROO0TAE6fj332xXeaM1Vx6xN3stCvn/Sdxl6Jl4Mp6s=; b=
	UhX1WuEiQ2aUbA6kfFEjVKZzpz1v/b7Ga+oleAnS1pVMGzg1W/Ozy0N6EVPrfODo
	Sv5A/ux0n9wrdgMwL68gE7uUwE3ADVcR/H9YFNK5IHBBVFo+2bMePiXZI96KhsCk
	4cgKfkEh3rKz5uStsIRByhXhBC99gd+60euH3ql2kSo4GHVal7QSsrV5C4FiJfoA
	sNiXR61xq5Qzg5/jh38Bd2HrGS2upLqBYXvlIcixdcf9zE2aGJ2SWFEKKeRvZv+J
	bcw70ehT145AB9K60cgGx6h6DjL/rN5p7iEN0BtH7+/lHgdmNRsthGLgK2Z5ub3M
	msIDPjaBz10MRdlPffh6MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760888011; x=
	1760974411; bh=ROO0TAE6fj332xXeaM1Vx6xN3stCvn/Sdxl6Jl4Mp6s=; b=i
	wOuabSBBk5a4DYXeOEtKFHVjCfwpn28eVlGieiqjYX93xfZuqjGyQo4nKCCKtAps
	gVdF6IILkVTDXvQj7Tr4jUdEgBHDOLRFdaBrGe5zGtpSrBUMnL9UGWN84SWJvsvj
	bipS08n/fdXjM2tkxndfLghFA2GRxuuGBPHz3jR748v6EHXzwEjOC5Uo2dynfWPv
	CEKJo+4nPe7B+lhvq80CeM7H4uqpfdhCrpKb1X+rQdtmYound0UrBTtadPLoOX8r
	1hFIJvW1kPTFWgxGdEyK5mdW9UvRZA9I2y59YU/gyrMdsPOFv51nePb5tNVYAy/f
	2pAKo1u8O/O0Vx/CPi/6A==
X-ME-Sender: <xms:ywT1aARSd06Uy9dG3PTc9rQANXK9JwmnwiE0_KdQ7WkJGHK9AsEm6A>
    <xme:ywT1aEpqWsuk6PECNSzCCfKo3NF6tVoVHDN7dF8_KqMHdaJmcWv-v2HZh5LNl-yuw
    T6r2jquxNK242uRuyM2i5Ate0uv6YRw-vBYt6urOrBUROhwkLv4ew>
X-ME-Received: <xmr:ywT1aGJQSJxcSk4wvYpG40YCPP_KeXeZ55WVpJSL7zflO1yTmbcsvdaInv26Ig-tdBV0dM1zcfhQAbT51BkS9_yuhG-776k-h26c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeehfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhmrghilhdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ywT1aPpv-x7phmHVJWhjgwuN-ckMMNpUQojsYZLM1CdMBv3hAXKqoA>
    <xmx:ywT1aGwGN1M4wnYTEiadKdgnaNhHxeMlAAByjSp__KhC4upzx7FNEg>
    <xmx:ywT1aLMdv3VoONrj49qmsuL8J5dNMXxE09MHNFJRiys6e6--zztZRg>
    <xmx:ywT1aD6_S8huvA5y1lK5Awo3y1CLJ9n1GMkSroNM5xUltd4MUuzmjQ>
    <xmx:ywT1aML7pjSju-rPspcbysJDorT5_d1dpJN5o5MUMk60bVhWhx79CP8t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 11:33:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Jeff King <peff@peff.net>,  Lidong Yan via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] diff: stop output garbled message in dry run mode
In-Reply-To: <DEF57576-E0E5-4F09-B7E7-CE1B8753F088@gmail.com> (Lidong Yan's
	message of "Sun, 19 Oct 2025 22:31:27 +0800")
References: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
	<xmqqh5vx1p0q.fsf@gitster.g>
	<6C994C9C-0034-46D0-8112-FF88773B5CF5@gmail.com>
	<20251018094722.GC1060824@coredump.intra.peff.net>
	<xmqqa51ow6xu.fsf@gitster.g>
	<DEF57576-E0E5-4F09-B7E7-CE1B8753F088@gmail.com>
Date: Sun, 19 Oct 2025 08:33:29 -0700
Message-ID: <xmqq4iru52k6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Lidong Yan <yldhome2d2@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> Yup, that matches my expectation more closely, which is
>> 
>> * We'll do the "send to /dev/null as we used to do before the
>>   dry-run thing" on the 'maint' front, which will be merged up to
>>   'master' and above.
>> 
>> * We'll queue "here are fixes to the recently introduced dry-run
>>   code" (without the /dev/null thing mixed in), and cook that in
>>   the usual 'seen' down to 'next' down to 'master' route.
>> 
>> In a distant future, we may consider removing the /dev/null thing
>> once the dry-run code path proves to be stable and robust.
>> 
>> Thanks.
>
> I am not sure what should I do. Should I make a new patch which
> only contains “fixes to the recently introduced dry-run code” without
> Peff’s code in it

That would be my preference, rather than I make up a Chimera out of
your initial fix, proposed log message and a single fprintf() fix in
your second version in this thread.

Thanks.
