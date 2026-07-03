Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D263B9
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783108926; cv=none; b=O7D0KWfMcj1IPKxagflHe7cQyfFUW0vwUE38cNicIlcfhSKpHQM/Wsh7LmRE8TBUMyOxjgwaTjJ5RHqghyXbJNC+TuzaB4U2ZTAQGCqBmFXfpRc/AqB0L879AhpKPFh2KAvSCnWj1cbReeqeYJ8TixQFXnBMob6zibx9EHshjzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783108926; c=relaxed/simple;
	bh=1tNzZJPKAkGmgZxhwi5lvIs8pg9ncBkr9o1D+l2uAmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OTNtNyM9lSUCIt7qGK0gV/tQ55YLfdsPlIBi3nL+TTCPqhrc8oyFPQvRNG5ueh8evBq+h65aLmxOQxILpmFNXT/k3a5NTA7iLhtnhC0TjVNrw1imOw/rBi+9zTdRRqV5TpfHJnJVJZ3MMgiV0SfN08DC/epydfGJPvozHtiCLrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Eo4R7zHW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ey3UEjaV; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Eo4R7zHW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ey3UEjaV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 763837A003F;
	Fri,  3 Jul 2026 16:02:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 16:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783108923; x=1783195323; bh=VaRutIgOFZ
	6thnFS3onOiXIdMXlKb4m3h2+7WxIEpV8=; b=Eo4R7zHWF7vkE8mwVzRqDTLocb
	yUFQUZrg/A6FrLEXyYO2PNDc29nPwzTmE+TSADiGQvNpokrOFcqio1jkGL0BC/gm
	dHqjCFZCXeYNVCczkzJcxYwH46jLaVhO5gwXb01fvYX2vYfutkfF01qUWFU9Rd+j
	1w/S9s42higIhbqAt3DX2jUjutSlOhIVoutZTICI04xHjy6LLlID0POtKhKjkZx+
	Ra95YeZWJNX3AEyFMiA8TUTjH0cbMDoQyKDuH/CZVdICN93P7GAXRFYxqjaCSUf6
	I3qVdsApRCh9R29/1A9xtjHFYcHXSn3thOSpOFxl7U78lzo+MKo5P75wyx+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783108923; x=1783195323; bh=VaRutIgOFZ6thnFS3onOiXIdMXlKb4m3h2+
	7WxIEpV8=; b=ey3UEjaVyO9BEUIV6NKDMD13hY74hXlsz7Zryacci/5ccsKQBfy
	kWnbCrjjVaB0G4afpVug+a5rKaa4QtHnuDI2brnMnxSAocgaNPqPzX7mooaFFOoN
	+R3NmHj0hKX4b53EFx95v4Jd950ifQMCz/lQXARjlMcjLDfqa63ewDpXt154TNrR
	FJI0PXaiiltYG/PFnYXT+BWMKyLgjVxQwZl5gotak8rRZmV+iesuvNex8BuNqCmK
	2Dq2E3UNosJnRzPfAVkw/tU5rmg5NifX6iba5DyoyNZh2L2+MtWlxjzD7+qJEdNk
	OKHBq0CuSGrMuEcnagceaKcJsqyBCcCj46g==
X-ME-Sender: <xms:OhVIakYbh9DkPMDo1wbZ9YaQZ_I8LK8xnIUHiw5wCXAJrWF2797TuQ>
    <xme:OhVIapaeeHlyeWzqTXY8yNFlfOhOc-xuAkBC7729kYcOdsUai8DqBeHMBCj0VvOTH
    eVUlTMDWJbWj4bFp3YgPcZlBnwDW20KOU1OnCzER7F4-8K-vci_>
X-ME-Received: <xmr:OhVIalnYXIXbrgCJxfasxbmV1LG6-7sxk05hJ5NvhAHMg8Ujm76PKU4IpRlIzO8xJ0tmkrLgGghtr4Xh18HUd0SXeMzpvBsxFqk0Zqs>
X-ME-Proxy-Cause: dmFkZTGHvs0c/+8h4fK1LpdjSx+RstP6gMeV7ulU6RzjkzLM6WpYUYm1pvXzbGcf9TYzPk
    hVGQ2gWVdBz8iNO4tOByVXvh/YuqbozjBTxEr8uH0MNVKNIX8Ek+w7GXtgB37KzMV72xlP
    eVQzjVcsbC0D93ZZRauRfrPz+F8dxeuB4ZS2zSsE2RNZcXaeSxJEcTQ/eSRrRmhMos21JC
    KlQPwYxlOnxCB3W+GasuYuTI6syYV/dLNdTnNHonO3xw76h9mzF687sER+K2IItVrHVue9
    ro+VpwChwY1R0LUkH16TGFdXy0Rh5kQSmG/ZSj96TqIT4KG+xnPNgKAoqIdpyY6rRVs6ez
    Vxgv5dQcIX5vmOWpvK1tDZrShN9TxqjVoGYrk4XKe0QE5fV61mtyVuhC5b6o+B3kf1CewG
    +JQLwwuvpYQXfrGOvjRgSS+AG0vmScStjGfKtt/mzqoTwkxxMebyFD9X/g2B+Wrg+DS4XE
    w7xtgtunCJTNVXsQeG6w/MRPYzZBH8s6DbKG5QFvzFz+sdTBQummzVS/PlsoYA0DM6wJt2
    oai+kRuRRN4jeGzIPpxHY6j4VuyvtsDry1MsznECTEaJJId59xP+r6frb1kLEEpLJ/1n7s
    BC+rUa4PwE+p+m+7j6ZuTUGnA92Mz5SOyVYbmputmKXlyk9bq0x0fKEeL7fQ
X-ME-Proxy: <xmx:OhVIas0RrLMKWA6D7Dx3DN6OQqQ5w_a4a5hVc-P4r2AhYGKT1ACYOA>
    <xmx:OhVIat0SAcpYBgKGqxV3xQCB8WNaemfh9vijN-73Qp7agac4dCYQiA>
    <xmx:OhVIamp21zVA7o2GoBmEMGvLVpBLKzbKdkNDUkxrehZ8gMRgTEyKWQ>
    <xmx:OhVIahh89h3tL6mmBKTNrM4_JV9HUCAwwbzxmCKQMrmJ-jHfW8toQw>
    <xmx:OxVIah17G9IEphIzuZfd3LFfC3NunRi-sHC4H07D2rMaQCKdz3L4r5DK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 16:02:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Pablo Sabater
 <pabloosabaterr@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 00/11] builtin/history: introduce "drop" subcommand
In-Reply-To: <CAP8UFD3OAktVQsLuqBNFH2uhEO31PH8ZF3ZT1ZW8k++XE8YLPw@mail.gmail.com>
	(Christian Couder's message of "Fri, 3 Jul 2026 09:10:19 +0200")
References: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
	<20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
	<CAP8UFD3OAktVQsLuqBNFH2uhEO31PH8ZF3ZT1ZW8k++XE8YLPw@mail.gmail.com>
Date: Fri, 03 Jul 2026 13:02:00 -0700
Message-ID: <xmqqik6vj0zr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> Changes in v8:
>>   - Pass `RESOLVE_REF_READING` to make `refs_resolve_ref_unsafe()`
>>     return a NULL pointer when it cannot resolve the reference.
>>   - Drop unneeded code that sets `head_target = "HEAD"` on detached
>>     HEAD.
>>   - Add a test case that verifies that we can drop commits with
>>     "--update-refs=head" and a detached HEAD.
>>   - Link to v7: https://patch.msgid.link/20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im
>
> Except for the style nit in patch 6 (spurious space character), this
> series looks good to me.

Thanks.
