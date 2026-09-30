Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4B51AFD6
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794005; cv=none; b=LwVYs7G3Z6w3XdHbNmaAIQtu3MgC8/hx3khIMQ/Oc2rDSS14PZ1sZJONhCLMlMKL3ZCjK03gGtbFdG7+KqI4OH/cVaoS0tuXyzf/IPvKOI5o/o8SvwbYfW5RY6hWQNQvCwZDbiTZ0+s3td8xT6Qnn65fAkb94JlLbpbc438STWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794005; c=relaxed/simple;
	bh=NbFZkLE5RtWssffD8XSrAUNZEQjE2Px3tS6XX8hiLIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NjZo5GU73d9n2vf8znbA6UtRby44f9sd/WnGCEesQZP5kxv5qC0uqfY/wKtOg9M5eapfYxOzD7q8lyNrZUGV98TwGf5HXBQpHEvbpVS9TOi9hsrqi15ToCqLN2Y1j8Ubzl6cJHQqTcJjnDQNnI2q4Mt1f6bfMJxdaUYqSLHnXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I1QzY3jP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VlW6/ZC1; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I1QzY3jP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VlW6/ZC1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 25DB914000BB;
	Wed, 30 Sep 2026 14:46:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 30 Sep 2026 14:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790794003; x=1790880403; bh=Uta9dNruGc
	QivszDVDV9bFMV+iLka9ZKgKlQ6d+kFK0=; b=I1QzY3jPApzUVVBdAK/r/0Hc0Q
	tOB+F7zqnPTD+1mbt0curvwgyZtSdBwali1Xr+U2jGW/XO8eICVLAc2I6OVmNMSl
	oGTNWjWcVBXWUc3EJEP3H7PdRnGL4n2yHQWwnWeH0piHSK9P3xOO06tISasYVHMO
	Q55HGWqtXMQhsKpylV7OVEvV1pXg/goUbcrqpJnEZK358GHknJQMWxTvFbbUCTWj
	aRB5MsrY5GI9UHyTkr6z9FHVBEgXmVDT/RmT9PZXSQBi8URealPL/zv7xfhdgbDE
	fFx86TM0m4Pq9VEvRtDRZzwDexIrH5oCdS/uFhtrTNRnCd4/WRxSD+ips2zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790794003; x=1790880403; bh=Uta9dNruGcQivszDVDV9bFMV+iLka9ZKgKl
	Q6d+kFK0=; b=VlW6/ZC1n7bFvJQE+Q296x8HbtDOUttFGlnTKceDvzuR8HQKX43
	SVdJgaNyqMY4TX4Ggq13fQt2wrd0u7WcCV8LUMP86mN2WbYs/MiK/pOthjkx+viw
	yHYLYUnJpwcc8G+GLnEHmm71VmpshhO8yKKbTqiEXji6Rqf2UCT4n/wxb+6B/hAn
	pK1vZ2JFVwl1vLvlyTMbr5trZnU1xxBZZt0hWy9N3t5yRvsesPSStZ7KagG2kyiv
	bUbW0BCnXvf9kJ7AjFdrGmjcg8jrWO16PX5cDIfqB4tyFyLKqjbQ37nhTH8iBc3I
	uCKUZJCZOIz6yxQmummagMye1pPvAtlgTog==
X-ME-Sender: <xms:E1m9aia1qqL5UDAc9inMOaewcPmwtgbrQDwwDSxxzD-dX3ub6uwxoQ>
    <xme:E1m9apGG6ItRYxG8Vd8nxN-m4efytm7lJBbrIXL0KMoSTLHbe0xFBbUhZhBuDLVE8
    SrYrGGxVpuN4eWCeoPm4JACTFui4Ro2fm6cpj-AASTV8odS8H-WrLk>
X-ME-Received: <xmr:E1m9amzsVo-HMKx6V1mUIaP8K4CPKQtq_zrN558H3QrfgPxy5MNJonIfQsCpJ2rk_0OWyZMHLf1FrgYfyZw8roLB6TFzX6SkBL_v>
X-ME-Proxy-Cause: dmFkZTEYNU1WNL1gEmH5oK8dQGMez5VTDsK9K6RXxVjtLy9ikQf6pUUKESpCscrXT44b+n
    HMXCKanVQUuTiWtNkd7FGY1dJsGznhxJzeaAL8Cv5DypqWDvvVT54lcjaL7mGlhkhc+FUc
    iMqcNtpkZighmmVolyH3AvQsB92cVBTq1YbIZvBY0T3fhZeN+5+0uA+WLD0xPMJLMk6xPi
    17nyDcCqLNBPu/4Lh9W6GlUZsg0rUEDAbgtNdlsQ/C1oOaru7rTjNT0xZJ4HWHVYkHUO/4
    EaA9OFBNZOTRO37XQpc6Ksdd3BIv71cl5VW6k+KCdA1gx7I3P5dSgNCD6bi4QglqvI/FSB
    3LtlOA4qac+IrgUuwVyaZYWdOxJGUp5FQDguMVVSmgVbixybFMTy6F+L0DiVqgYnfUUYHx
    HwniyZ+jhPrsbXwCeqvOP8FZdmeM1ahJlZo24MakN124kbGh0naVgfOVTJjj8Coh9kHdjo
    HBFBdhtL6kEgFe0ASgR6jxSNee6e7O1o7Bp8DNCK9ZW0Jn3KZjn2i2VSwhMc72qk0JMyJL
    SLHtxyywZV9FverGvXGUUZ+NTmBsolLb4BndfFD7/a3yimuO8xaBy+4O7V1D8taTi4q65N
    PSeEU7402Wy4qzWKGwJb7Oo3A2Mscsn3QfpTIkvxhMzeONMobGKFnVr4Lgog
X-ME-Proxy: <xmx:E1m9arkh6Z9a6AaDx8ZhToNuyZKX6v0rh8x6xvJLQGA564_RMk_ckA>
    <xmx:E1m9avlgkXWhH2M1LylVNar2E_dkpDrS9V7RFLEvOecStcPFgjBr8A>
    <xmx:E1m9atwewo4cPAWXQMHNv4so3i51JwdP7xfOFTjHIrBJWgvFB6kiYQ>
    <xmx:E1m9akpCOXm6cfrw29g5Nx41GtZkzx4ivlDb9lKkuJPl00PMd7RwbA>
    <xmx:E1m9al-W5_pEu3wG-ZlW1Wa2qtBZrl_5R8tj_1BhJr6insr1F4DL0MXy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 14:46:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 0/2] ci: link failure and leak annotations to the
 test script
In-Reply-To: <acc4ad5b-1ac7-4a63-b771-fc2e585a6ebf@gmail.com> (Phillip Wood's
	message of "Wed, 30 Sep 2026 16:52:17 +0100")
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v3.git.git.1790748583.gitgitgadget@gmail.com>
	<xmqqpkxudcva.fsf@gitster.g>
	<acc4ad5b-1ac7-4a63-b771-fc2e585a6ebf@gmail.com>
Date: Wed, 30 Sep 2026 11:46:41 -0700
Message-ID: <xmqqld8ia86m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 30/09/2026 15:37, Junio C Hamano wrote:
>> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>> With these updates, the patches look good to me.  Unless others
>> spot problems I failed to see, let me mark the topic for 'next'.
> I've left a couple of comments. This version is a nice improvement on 
> the status quo, but I'd like some clarity on what the filename and line 
> number annotations actually do, and why we selectively escape the 
> annotations.
>
> Thanks
>
> Phillip

Thanks.
