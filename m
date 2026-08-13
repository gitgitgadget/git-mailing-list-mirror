Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611EF38C427
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642543; cv=none; b=WY4AO5HPyHvfYImj09i7QoXjzWAET0GL9dhxLl5CWCp8mJnUYNPla7hv2kyODx6Xm+XLuuKSHzIfen6QqNIwlSrtWFMfgGoljJLXUHs8g85JpjioLMwvShlEd/hzCjDw3de/n9e2KSn9LtK1I4/CwB+tOyNTibnJqKMiJSKS43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642543; c=relaxed/simple;
	bh=X0flJQspJimdZVA4Fh52gdCjJvPYiqOejX8jcWkYFxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JgokYz+grF76JiHIqXP9wMWkIU+i2BKESzO/UdqbexBIcMcKAOgQzZI3qEZj1ZBLahOVE/ADI7EzcB6KxUwTnwTPtwZvDWC4rViYYRnWisSsmpVfOOm2WsmOKRcL6FGqHpTBM2KUrFaaa0A0WpRg06FnpmGd56zCLSn6dtxFibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HRxbcFTn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KZFFRUq1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HRxbcFTn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KZFFRUq1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 497F01400066;
	Thu, 13 Aug 2026 13:35:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 13 Aug 2026 13:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786642541; x=1786728941; bh=40Hv9AP5eB
	BdG49WRaXCDmjrnrscGfc8fqkOeBxfXRw=; b=HRxbcFTnfjItGYm7RoHCNOMLa3
	01vWdRZWfAOw4CCqEm52XcA9HboyPNWLXwoEuqWal2kgduoSyrar3dxCz4BeU8yp
	mSSdW7uly2sZySQv0TYMsfvlNpRmG+Bl6NrNOb/XooBA7YfuWlCgwUpP1/DrXSJ4
	c7821WMIC4bMYFhiRNd4UW5fxylC+Z7fJghYnF314Gs2R2c6D8hK5GpbS08laY8P
	aYBkMOW24jjs5cT8k2geMPl0EEYJDjEmnl5O/3oufMiGGqfeHMGpdEs87FYiHsa3
	7Q2kdqqpGmEa91+9NDuO/NlkCz5yqs/2Y6QkbhSFOVreBN7CbK7KyeUYQD7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786642541; x=1786728941; bh=40Hv9AP5eBBdG49WRaXCDmjrnrscGfc8fqk
	OeBxfXRw=; b=KZFFRUq16ipInBVRuYCFi4dqHLXYWv0ImiD+eKnaAxx19kaGyeC
	HBp0Wm9O9a7EdAuSD++w39wGW3lniCZemHU+yKyEGtTR7gwrhl24VEJ5wiU+oCb6
	afBSpmHrx20wsP0VP1Sb1Yonz1PYBAq7t5J57oO3xrcG356rjN5BuE/rB94MgLhU
	QtZTE2J4xGzcJV7pgxuLUuJQJ4ksg49nrB7IbQN931n0Qb5DWxFpaLppGPwkYpwh
	dqh35onliuK4e4v8Te2TOkHlzMvvMfGlzEyOEoFOxq1gWlsj54uebi/XP/4gu5CZ
	FSXtyvOnpWuYyeF9VUh0Afmk71KN8d87wlg==
X-ME-Sender: <xms:bQB-ah9BI74kYJTxZyuivR8vkE5duCISLK3uYiNbMwxHGPmd3FcEig>
    <xme:bQB-asl6RadlXlA9dx2P20cJnAMhE9ztYejWP06nptkZK_C7yVqEnYgCKXbgXTxUJ
    kcYBs1m1iUy9x8aXaorMRYlzB6o59ofg0MlDc5uNCfBq87XoL_BGw>
X-ME-Received: <xmr:bQB-anVwRMeDWg77nsNr_6SPrFfAQyR_t4R65bcvY1Gk8n1VRAe-ah8heKnRxXw_h19nl3IogNHhs0SopKD-PKRh7YTt6B7dhQ>
X-ME-Proxy-Cause: dmFkZTGOjmhcM5WZDwE4XsMf0QnrALFKXBDUBiEIRUjSa0IWO3JvqsyeIwgDUPSMPwf7GQ
    1uH1sxNW7HXH7R0hM/0hxnAMoef8riO9V6riG12P1LuaCH7ZuYbaSJOofdzrYi6cpCDjvi
    c5BBmrg2cDrk5tm/6MzmbDg5pRVqAgxd4YZVdVFBfXPalvfHMKE8jUaygEXJgk1M4+ZmM6
    ODAlSptJ6uCXSU7naTSCAf1lXBy9hVrX1Eo1llgRjUibhxtAgFW6i1WFDYMqhmj+OYVRes
    HH5SxjZq8+ASV8gPsenbLPiOY9zzCmdk8UVXplZ3IBWIaU91ejHxq6DnWB9n71WFjmotWy
    TI9XdDhFMjqOPrxE/eMkTPUk28FIO5/wYSMcBJgg0NpiGuArsV1M8rEjPCYwq14+rvKWAb
    IJ8uOCwKrLcSiliu2ve5uQWCC7UgWsyDRcf4tKz/YPuFsyheMat+WYOiGB3OBRoLNSoJgM
    0weZLctKz+akZWmkPjubnLOUgTzeY1OXFXBFtJzx9CFIOQcBaRHbvirtjispKS5dzJhHXX
    sN5jV2PPeac6qufAsnmJLk4+gO35sIqQ8EHh4KvLRd9i18VK+fxcvgKUZz4uuOD6fMvYdl
    H/yZtkczFh5AGZW7T3SkAT33V2NNAd7WVBltM8mgWgrgca14tXKIer9Vuhng
X-ME-Proxy: <xmx:bQB-ahEqqvxYMpFI7Vee9LFXo5nlsRSn20RltMJCOAkFxkjcdEzuOA>
    <xmx:bQB-ajfsADG-Os177vbKxCBtpUyC9nKzJlGW6S-3rQTtb8hhM1a_iQ>
    <xmx:bQB-aiJXTiowDLhKZs2c5bpuODKcNULt7EV_aT3bn4iS5Db4ZR4BNg>
    <xmx:bQB-aoHtNIsnVzag-mKRUQwW4fyfPeufih5Y59cvcfOlcdxUUTNS8Q>
    <xmx:bQB-anm804DCi9ryoU4-ClCdikQcBRyaqY_mRM0EPg6ajpDNDNvQM5DJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 13:35:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <ttaylorr@openai.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 0/5] odb: make packfile generation pluggable
In-Reply-To: <an1ajMjVRUsfu-lv@pks.im> (Patrick Steinhardt's message of "Thu,
	13 Aug 2026 07:47:56 +0200")
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
	<xmqq33wpej49.fsf@gitster.g> <anlg2rThlBLavyU8@pks.im>
	<an0EkMZGEbg6LERc@com-79390> <an1ajMjVRUsfu-lv@pks.im>
Date: Thu, 13 Aug 2026 10:35:39 -0700
Message-ID: <xmqqzeypsz2s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 12, 2026 at 06:41:04PM -0500, Taylor Blau wrote:
>> On Mon, Aug 10, 2026 at 07:25:46AM +0200, Patrick Steinhardt wrote:
>> > > With "--no-ref-delta" thing in flight, this will not play well with
>> > > what is in 'seen', though.
>> >
>> > Ah, dang, you're right. I'm not quite sure about the status of that
>> > series -- there's been a discussion around whether it is the right fix
>> > in the first case with Peff, and there wasn't an answer since Peff's
>> > last mail.
>> >
>> > Taylor, could you maybe share what your plans are? If you want to pursue
>> > it further I'm happy to add it as a dependency and/or wait a bit.
>> 
>> Still something that we're working on, though I think that it's fine to
>> kick this out of 'seen' for the time being.
>
> Awesome, thanks for the update.
>
> In that case, Junio, could you maybe kick out that topic and merge this
> one here into seen instead? Thanks!

OK.  Let's see how it goes.

Thanks, both.
