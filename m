Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637F14A4C6
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742253150; cv=none; b=Mgazb1Vf0CMiwkLZVc+mBfA0znryZb3FhptCityFwL0/vwTUvVOBQ59Xd1mhlp1pmfzJ9lvUSOnvW2ObJlMEjGtv6qy9vSqEumVpn1DWGd9lxAUa0FZURPba4Z4RSNJ916wDdMSGLkrxnx+d3jKHPS0gc2wTC+QJ+lmTkz17C50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742253150; c=relaxed/simple;
	bh=qkmXsWF14O7HSyURs+tM4S2+pSIOpJxgtv1jGjODIiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XIBREfxEhxTBjVH7WrKK8AcLrdkP4sT3H2baDh5Nh1rbt3CbN3rfEY5OFQXg23majapPwBL5FsbqnlNGsqN1wtq0Cdq5W0bYdGgxUG5pCIwP3QfZ/X5hDh9Wz7ZYY5UL4MhJnkAEGd4y+5Oz7puW5p0jMFQ46aDdHR14rhm5XvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=y/TFz39S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ap+Mdgs1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="y/TFz39S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ap+Mdgs1"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1865411401A0;
	Mon, 17 Mar 2025 19:12:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 17 Mar 2025 19:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742253148; x=1742339548; bh=qNmiIxU4kb
	l9EwT6FGRVjw5m7laeSf0dqee3DD0OjfU=; b=y/TFz39SI+FHKHR+ltLMTLeCpN
	rHEaHpSAgmDO1YAIcAaUkPDxVUtw6kQ7WPA6zzeO8SZeE28JleaiiljeX84KcTgb
	HTuyeGOvd/fKJ6Kt4FOpyxGWQgOyYq2CJEZlv8tkTmG/3PmdICAqpsri7RBKF3wS
	jIphr/5tfkM+S7Imi1usBysgH4QMndqC2ax0Dy+6nNNWq/PFaL+k+97/rKVYtmdM
	Tv3tQJbluAjCI11QVU1fDViGULSfqDUVZt8xM58ow3b0Xr0vJJjibyTZIaLLy8tE
	BKTbUlb9GZ+WFi3tyoljTCRCk7ES+P+jVMKMD6F3j52ZuQiD3iQcRTcThL4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742253148; x=1742339548; bh=qNmiIxU4kbl9EwT6FGRVjw5m7laeSf0dqee
	3DD0OjfU=; b=ap+Mdgs1LhXecXic07XZa3RgWN2kPIuws3ZADsKUIfyky0sW5al
	eiEGOv+wmTqpxTcv6of6Lr/kM9uxKuL+UDL0WKLq1rJ1uxE2w7VQlAnlOvX2n0W8
	ZDGQZy+f+GF971Lzonv35gwiITSNTj7z/x3r4ZXeGORJCXUJS+0n4bYOWu/aRr19
	yujX3RBxNWosr6LEw4XbqCgT4W4qnRnBELrKGD9t9o3IWW4x9+cQjFi/uT2TLqVh
	30GtInUZap71iSS61vI4kzgWS38CXEFjf9Mt4g64XQwi+8q7zoMKqFCqYa+ZVuR6
	RVcN7yO3hOVohjz0bMQYsd2OqbZ1Fi8R/7w==
X-ME-Sender: <xms:W6zYZ1xx0BsbG67zagydrFu_udW6mbcfg6ozv8Smll2gTcFOp04S-w>
    <xme:W6zYZ1QIX66F8UNRBfvyuAs_gI-mUb3V_pr2SzuthtPcZy1CApIcuTKmboiNPtEk1
    Wo-GpvRDS-1Htmmfg>
X-ME-Received: <xmr:W6zYZ_VbwhxfFkg0zlbohtS3TZnXsBzpt5l5ujtnPsnu4ZyDKquJRINkF4RkWzt9K8IAanb1MVxi9HcJgIDjEA3Vat3KPJb5hEgc5FM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efgfdvfedutedukeetteevheeigfdvtdejffdtkeefjeffgefhgffggeegfeefteenucff
    ohhmrghinhepmhgrkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:W6zYZ3ixHl4D3KMIIg-dlxSfzR_i8i3TZ3PvQXrrENod_TfQ7u9nWg>
    <xmx:W6zYZ3AkZ43Y9sJGxHxhwL_pMGqMsIkiuQ2qAkLdt451PN3KGNZ7-w>
    <xmx:W6zYZwLAzRc_YQ7B1L5-NtZcEYOgd6BXy6qm88BAH7NyAnGm-F8hsg>
    <xmx:W6zYZ2Aeki1zb6cHJU-Ibc9KUaAkGOspOg0RsJk3SFBmjPD_1Y8GfA>
    <xmx:XKzYZy8Zhfl6BAuhdhYpAVrVd5xzevIgCItHXYA7IU-MAEVpPlvuqrdE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 19:12:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] run-command: use errno to check for sigfillset()
 error
In-Reply-To: <Z9iUe3Hg30W5LFSZ@nand.local> (Taylor Blau's message of "Mon, 17
	Mar 2025 17:30:35 -0400")
References: <20250307225444.GA42758@coredump.intra.peff.net>
	<20250314210909.3776678-1-gitster@pobox.com>
	<20250314210909.3776678-3-gitster@pobox.com>
	<Z9iUe3Hg30W5LFSZ@nand.local>
Date: Mon, 17 Mar 2025 16:12:26 -0700
Message-ID: <xmqqwmcn5k11.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Mar 14, 2025 at 02:09:08PM -0700, Junio C Hamano wrote:
>> From: Jeff King <peff@peff.net>
>>
>> Since enabling -Wunreachable-code, builds with clang on macOS now fail,
>> complaining that the die_errno() call in:
>>
>>   if (sigfillset(&all))
>> 	die_errno("sigfillset");
>
> Hmm. Would it have made sense to swap the order of this and the first
> patch so we don't have a DEVELOPER=1 breakage (for macOS with Clang) in
> history?
>
> I think it's too late now since this topic is already on 'next', but it
> occurred to me idly while reading this patch.

I thought db1d1f5d (config.mak.dev: enable -Wunreachable-code,
2025-03-14) aka jk/use-wunreachable-code-for-devs~2 is still out of
'next'?
