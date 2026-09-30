Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9BA451996
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798512; cv=none; b=sC6Iv3AvadrtTUtZH4hka2Z1WXSTwhr4UaUNxVRZk3BYMN2uYsrj9tVjA4xurd7IwS3GD46SVlsBAA5HuXlHWAVSbfS2E/hZ1h0j2rnuYbXZI5nkIkjgrR5QrfwC4S8p4tRrLzz5VWJjl7vPLihaGtcJgj7C0sQUPGZnmET7lAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798512; c=relaxed/simple;
	bh=7HjRtxLUbkOry3Jxjmy77en6xnY4gMvDgM4vhxXDv18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FZaRt9E7NLA2J0BUrXxisB4uCteQqlyYSmElsMKUjGzsk4xAK3KERy1MwP12btdJCnGhbMgzOBtCkg5f15kd8t82g5N30iPlfWwPoLLCiBGxXxbmTHY8xYdTxJQDRk8XTv7CX06hmiVz5WbfRZC1XFk8oxP6M5c9ev7hpt07FkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HI+QfbCV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ueaZbh2W; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HI+QfbCV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ueaZbh2W"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A86DEC0215;
	Wed, 30 Sep 2026 16:01:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 30 Sep 2026 16:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790798510; x=1790884910; bh=vzAntOvnGB
	wsU/N8zPQgH3iqXgkMWrJ08U6aE6fIxYk=; b=HI+QfbCViVk1BpCE5XoxS+iOk3
	L9cZnaIkPgPrMfaL8Fcx3aYn1AlMVanw48fUPx/T5tMelOw9zEZP57VrUhkSWRWM
	zs1fMq+tqnK0mtcQO23rJW0Vo76zLA2BDfOMCbONbZvLdNqzlMAyUPpF4xAHSNTC
	0Mwu+78DvHxaf+yFNLF5LBaqMpf0kyOJKwkcj4djeTKbkCtxPwPs7Fu0fCWvpD7s
	voZXiz35PPOk2amfojwOftX6mvOeM9cQGWZbzRA01wNPs6u+ioCBJfYn2MVArXW0
	vML/EfwFIpy3nMIMfp4SgvtZcVsOgAucnFTkP33iyvyOSu/POFbG8Y301yLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790798510; x=1790884910; bh=vzAntOvnGBwsU/N8zPQgH3iqXgkMWrJ08U6
	aE6fIxYk=; b=ueaZbh2WgmvYtGHzBV5X5SCPjQVQ6BAbMT+/8JvS9ACETcf1MHn
	f+/awxtfCh6hDdvlxs21VeYB8BQYykkDal3n5irovUQ8tNRuvro1Ai+GKuO7UyKW
	q6YTSlEDN03wU7q276jE9tfMY40WyFBBCByGCGHemYE1kJYWP2XdnP9szBRrpkkF
	36u4Wq2zQfIRvFAwv9VYHoW2jDCoVSbzFWOpD6B0gTZ0mi1pMJ6m4wyI3i99cYjh
	dos6OSxg0gkJRDFQZ/+wMyA6ysPxDUdkFdQAe+qcdCw6T84ciJGxcBp9B96V9QYS
	yVkwofxFop2U03ISzSGz5yJ4WgAYuHKVasw==
X-ME-Sender: <xms:rmq9arGGSUOXFwPXPJXkq5_HX_FMCQpZOp2qS2hXrRmgZUrIxS1lRQ>
    <xme:rmq9avUfrMF6vYx_HfkZdRnDnxui_V7ZSz63f2jfOQtCJ0HpD6_wCo5RK7dKxaAVJ
    0gg_E1rwY_ozYXMeq0sryNEUZJVu9czcb7a4RBjFDjxY1jxRRVcfYw>
X-ME-Received: <xmr:rmq9aiLHxXSvWzyMW7kKpEAyScQeWauFwd6ZzgVTysMEtc__YKQky0eKu6anNkz7LjX2AdHUcIQeVRVFpSNQC9BeBnZDU5f4lbKr>
X-ME-Proxy-Cause: dmFkZTFpCX9NNHU6aKPH+80M//hUswTjlQeXIxc5iNR9k7WAoZXLB2YNMEiSA3pd4L4ilB
    STUAYvwKX+PtfUeYQypMO3DDnlaJmc/Nqz2rGsbGkWYFCzAnK2AEo8S0EBHXstbECW3LIF
    p2MriiYn/hV2mt+3fYqeqjLvgjOqJecIlZa/Vlrd886En2oKF3d57f/4ym6Ga2pUjPlxHD
    0RUBZmIeNvPv7a8oPyHR1kFls1hxXb+d9u2lk/hhoZeKD7+ihG6Gu7rr9dY8eAVnnJvw+Q
    bFm8XWd0ljJ1gXWKq09wVLBUY7/yeA3QFcJOXexB+uX8DSLq4EfsaLJqyM5HzCTFXuylmm
    ABiYJIJ60yYU7R0rPWu6ravYIRarczzfAiCSP1QkBCSafZLmxajzH3Q4BsQxvFtaBoQDDX
    f9OgdfppBdK8q5m2RcS+PFlefLo4OVt9ZHj8n6m4LtaxETpprdAJY9dGPcb9olcOIPYAEM
    oMwhfuF5EPzCwrf1mK+zHigYRCyKU6c/2pWh46nxaestCMp8wlQxCHQ3aFdR2MhPPOcE3n
    c+KjEPpgtQrUs0I9PsghDvo2yVzaHX4RMt2GxlF4Zd7Bp8df4D4GlDYEKSgE9zWP6DcxXn
    ia4fbcSz/dm4IzduhLDAF0V1F5DiieybBRvmZo9b8e9X5uPxoy8VX8KUZEig
X-ME-Proxy: <xmx:rmq9an9jllFipasifDBU2fYdERqYrtM3mK53VBMkjMo8iyrn02SOBA>
    <xmx:rmq9atKswWKlZAV_-pePwB2mpqIVctUGGcWcUq0OJU-GYx86HgHAeg>
    <xmx:rmq9akmP6clVW2LjcIKKFfjiHgmM2x2YUe1H1FVmw13XztP1CyKGjA>
    <xmx:rmq9apOrZLzbCxflB0LwFlxVhFT_lKup1C69O4a_bsQevegnTgYr6g>
    <xmx:rmq9atprWhXRw-NGZ0iQwzlhn7ZSfmJpVm5RhRav-OYe4X1T2lnUqmFJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 16:01:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>,  "Derrick Stolee" <stolee@gmail.com>
Subject: Re: [PATCH RFC 3/5] fetch-object-info: return a status instead of
 dying
In-Reply-To: <DLSUKMRZHHGO.HVX98MB8KLSF@gmail.com> (Pablo Sabater's message of
	"Wed, 30 Sep 2026 19:03:26 +0100")
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
	<20260930-backfill-dryrun-v1-3-1128f247ee01@gmail.com>
	<xmqqwls2brca.fsf@gitster.g> <DLSUKMRZHHGO.HVX98MB8KLSF@gmail.com>
Date: Wed, 30 Sep 2026 13:01:48 -0700
Message-ID: <xmqq1paaa4pf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

> On Wed Sep 30, 2026 at 6:07 PM WEST, Junio C Hamano wrote:
>> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>>
>>> A subsequent commit needs fetch_object_info() not to die() when the
>>> object-info capability is not enabled on the server, so that it can
>>> fall back.
>>>
>>> Make fetch_object_info() return FETCH_OBJECT_INFO_NOT_ENABLED instead
>>> of die()'ing when the server does not advertise the object-info
>>> capability, and propagate the status through the transport layer so
>>> that callers of transport_fetch_object_info() can act on it. It is now
>>> up to them whether to die() or fall back.
>>
>> It may be just me but unless the client can tell between the server
>> not supporting (i.e., they are unable to enable it even if they
>> wanted to) and not enabling (i.e., they are capable, but are not
>> willing to give it to you), it may make sense to report it as "not
>> available".  "not enabled" sounds as if we know that it is the
>> latter and not the former.
>>
>> The code change looks very cleanly done.
>
> Makes sense, I'll rename it to FETCH_OBJECT_INFO_NOT_AVAILABLE.

Make it UNAVAILABLE instead.
