Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BA765192
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 23:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782343222; cv=none; b=qOpj8C90PojnC4hFZEXw3ICQXnMcfCtrUH0lpXDv/s4xb06zPV+FrhMFnTQUNxZNCKohq/plncLIa70ymcnwA7EQdGVVJJ1V6McKaZTCiVO0acRESH9LWD8cXtoLToPVqMTWZZxdyB5EN9wG+d84KiN9nZ7ghmnUUp85kVosJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782343222; c=relaxed/simple;
	bh=6vXlSvZ62eJJ9Kt5D+7EIuzGptJpPHoVVuAAWajw64E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I8LRAIt3w55DipySEdADnLPeprnmVSrv2mkwCl59Kpg738Oo3esz0KENxV5nipKvuqOHZ0WDi3SW1WNVb7hW9qoFuZjxeG+l/i/f9I0/JUxiJ3mrf5v3OK2vlLZt/tgVfLINWCIq3uLtKuFmXASneLY99Uab9Hz9gH39Wiv14XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VSHTL0Fr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TTGhYJFO; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VSHTL0Fr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TTGhYJFO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E0EB47A00D8;
	Wed, 24 Jun 2026 19:20:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 24 Jun 2026 19:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782343219; x=1782429619; bh=fvBpWymeW+
	w/S1mAXryw44MNPojFVzUEm4V+U0BkqaA=; b=VSHTL0Frfra3kA9p872alzg7Mw
	ijMUwrBFiUw6Veo0KeczsRxjqOwOBznHQm5Zb17yQvh6Mlc3gXW3hkTi71awW/iq
	ZsJPesfQsOTNVbG5PPEcctEDw4kvaomU7PbWUgAjVEoN5pFqH8pozWM8MnVYnTka
	s3SUtT//bD3z4G1jKfVmWQraelRBHhx1LMsvbsJ7r8DjnosDh9Qsj2QrqnrId6V5
	jQREQ/r7EhcpCZy7ybPq79LLHuCIwpObS8yEQayTYMnn1HNe/8p8+UJ3pHWGZBIn
	fg+6tzC+11jSZL5if4exkING9HLooRY7H/2/6Vryp5GL54keqDPLKbsyqqgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782343219; x=1782429619; bh=fvBpWymeW+w/S1mAXryw44MNPojFVzUEm4V
	+U0BkqaA=; b=TTGhYJFOnO9kMAKH07HFnvPJuen+S3629yQ+NvArwrzKElifRTe
	WPVZVWaaIS1+GlTl2QEs9OjmNm+4V+x7GKMmEGCv7Rk3GLShs5Ug0V+gtI0oICPP
	I6TaOrr8r9DchvFZP+vSVh5xMXgYrnTKRuqSqtvPIDLfyjjPDP5BW3D2gYHhkug9
	pN1LYUy1PwFINWiKbS/+IStFla1iBhb6eslPM9QHdoSD7I7AXJ41wzqfkxyUhZiC
	7SKaTBwv+mq+99hksTgysqLaYekqhpZ/N7SPV+xN1if9FtrlHlCUEtVVbFSrjkL+
	Mc7qHBq+rUQnK2dxoTGwGOXncHP309gKGVw==
X-ME-Sender: <xms:MmY8aonRkcrhyyHfUriNLFe9tmWuwk8yQQM6q48NOwqt9HqfoRebrA>
    <xme:MmY8aoQDRUxDuL5Jqf5tYUtR6--Jg2ztrFXGtvjEPYKcUxkJwaaJ0MDiU0zAglAgn
    utngsIu5hKpxHkGy7XNWEINqQCpeE6OtFlUPYEt7ZBRvhb0as5h2Q>
X-ME-Received: <xmr:MmY8anUTQvnWJd01Lzr6spNknufD6SgLUjNPyXjp9giI5PI4M7lpm1FISdwESg1h0dt2XpIy5tTk7n6Tb8LLWybrqcsSRTYVsDK19y4>
X-ME-Proxy-Cause: dmFkZTGdLt/Kc50T7L/iYrBLx4AXVLPIrQPw3OxcYqmP/NVP692v6uXV8yeAg7chymg4YX
    dKP8D/bXd0PVyrDV2e1+pV6uxOVmQIW0iTOk6PDdIulp+tjnsR7GBrzOemhSSt7GYFQuDT
    bdRfMUiNMPIbR1Za7ScdtIbREcLPlTUUKAhXf9qySdjT4EKWG0M/zypDkXRiQk3qpsdTYu
    F2KN7iXbp+XAzEjMDtKIqAMrkbWouJJglwZZPnCqTtEC+E2/FSRIr5lIc50jL/htvN+Zyl
    hsBxLBrs9n71r7T/5JV63CBNbvcZFGk+wwvcCUhplyCKZuDdAlxEoB7kT3j4WBqvVpyWnS
    uQqlhB/X0KO8DcTohNMBtX8hPXPnIicp054Yr/gGguf3x9UQdm9cW74y0uk/bvBQgoS5b/
    rKca9wnzoMW0CCAI5cFWunwA2W6LmchByA6wn0NQB28i2f7xf1MypuhGn+lVUAod1S7lHL
    9gc/pTUVLGC7pDjyYb7d9G3FkLK8YN31LNtTeDWjnnhyKc8WJqIyJfFVHDzO9cwV7Be/Yr
    IbWM22C2HPgur3+tEK/wzrWFy8W0xw7iRGMW3WGYNuPRZCnbxkUwAi2PNpB3ccj/bDcLdI
    w3F6kR5mccwZsbGDoIv/GvoS5yQDcOTHvLnHHkDDwMSW+uf+Lvs/n6bWH3GA
X-ME-Proxy: <xmx:MmY8asJNRVzUgYJ0w4n0NoatHYNDjpekqvH_vjkwL6O_EXwmUkHQMA>
    <xmx:MmY8an2g3Osw36qO5LqS9Lg9Nq4qiUeHsl70UhwJP4Zd0XcTmPrAZA>
    <xmx:MmY8apKk0S5h0fnTv7s0_k5W5JuzjUc2xJOxUAuE0ZbRCATf2CrzcA>
    <xmx:MmY8aigW1PcbiAtrvQwklkT9Cu_zfNI1OT2oXM5VNUDRuMjRJRfh2w>
    <xmx:M2Y8arYGQOlK_WmG6CuiRNOwdstxM6kfFa2hfRtzYwfuKVoPHVchtpL8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 19:20:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Marc Branchaud
 <marcnarc@gmail.com>
Subject: Re: [PATCH v14 2/2] checkout: extend --track with a "fetch" mode to
 refresh start-point
In-Reply-To: <CAHwyqnWwyPHiaOW+rz-Z9ZvRf=OjXWw2T+rB3cSsxXWXkeRm=Q@mail.gmail.com>
	(Harald Nordgren's message of "Tue, 23 Jun 2026 19:47:19 +0200")
References: <pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>
	<pull.2281.v14.git.git.1781786652.gitgitgadget@gmail.com>
	<8518f090b1069a02d40c710975528ad118776b67.1781786652.git.gitgitgadget@gmail.com>
	<12998c3a-ff69-4a98-9ed6-18aa0224e75e@gmail.com>
	<CAHwyqnWwyPHiaOW+rz-Z9ZvRf=OjXWw2T+rB3cSsxXWXkeRm=Q@mail.gmail.com>
Date: Wed, 24 Jun 2026 16:20:16 -0700
Message-ID: <xmqq5x37h6fj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Ok, let's focus on the need for the feature before talking code:
>
> In an active project, forking from "origin/master" without refreshing
> first often has consequences: you start work that has already been
> done, or you build on an old version of the code which causes big
> conflicts only later when you pull. The fix is simple ...

The above only argues that contributors should not start work on top
of a stale codebase without looking at reasonably recent codebase.

I am not sure if automated fetch immediately before forking to start
work will be a good fix for that, especially if the fork of a new
branch is done blindly _without_ looking at what the updated
upstream contains.

> ... ("git fetch
> origin master && git checkout -b topic origin/master"), but it is
> still a mouthful. Other tools exist because this is annoying enough
> that people automate it.

And to actually look at the recent codebase, one would probably need

	git fetch
	git log [-p] ..origin -- your-area-of-interest/
	... other inspection of the recent changes to refresh your
	... understanding of the base code comes here
	git checkout -b topic origin

or something like that.  Wouldn't folding the first and the third
step into one operation encourage omitting the second step?  In a
sense, having a tool to let people blindly fetch and fork without
looking at what changed recently (i.e., they had a reason to think
that what they had was stale, so has a fetch actually resolved that
staleness?  what new things did the fetch bring in?) may encourage
a bad workflow.

An obvious complaint against "update and always inspect and
understand" would be "it would slow us down!", but that is why
projects encourage forking your topic at a well known release tags,
not from a random "tip of the tree of the day".

I think most of the above has already been communicated earlier in
discussions before we got to v14, but I may be wrong.  Are there any
new arguments in support of the feature?
