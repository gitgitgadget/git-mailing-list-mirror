Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C730BF5C
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781751060; cv=none; b=tIz6ojhWgK2Gb9cH2bkeURzlYvWNEg8qZBZY1sKyynsurKxE2Ne0E52J5sF2MgQwWw1Nd1RbovHCD+pg7wytBCav7soztDXdRVZZ+OarYzPC/GPoJedpyJVLsyh5c6j69eSYcYYSS77QtC6vwuISee9LY+GQcG43TM+G45N82oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781751060; c=relaxed/simple;
	bh=cKB6Oj9NKmJpdHp6QLZIgX9FRau7XANWF0jDe6Djwl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rhIHO6/Kg9yxVcjaRULnggP42xfHfIAc1rbdY9JuThyEOsOzjX6l33LYBxJOMXpshRuVAh+1MJZM0WzGck/ejw0H2gqOWv1gw42vKHmdj+3BOtVRLd981V78nqpIcy5AF2hfiWLyg6zRWL6j4Z17mH8/00H0/vmAfBiXd1AQGcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K3IZjdsp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PlqFiniC; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K3IZjdsp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PlqFiniC"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 7C1301D00123;
	Wed, 17 Jun 2026 22:50:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 17 Jun 2026 22:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781751056; x=1781837456; bh=Zi0wl12uBk
	yUtWEAl/2bStGc9vkEOBo1N7JnlxDXxn8=; b=K3IZjdsp+FpM9oV6h0zWAez/WU
	0Ko/dfwHZxoLyEmhrBWsKyNJTRwLDv4hf4ou8/b8vfhpItYvJO0s/mdtn24G/SJp
	ZxZkU4cTHt663ojI7IW5bbn/5i7fQ+BVRuhOgR33dYEBVy+uOg5aXfndGlty99cv
	A2B1GJDMhQHQ37oewvpr/mLbrKp5zkLfVL0CK/67IvpwykpyU0DuzBPp0+Jc1Wen
	PJ1EKc5J8dnwzbf9+EkY3ptOj/HMEocZKUs5lvLaCuYeP1oOW1VrHWcYR5FItv6Z
	JAUpd2nEUC/7e0s3oQh4Kbb67JAvdTbwTCcqS1TCLGShGAMr32j+NSj74EsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781751056; x=1781837456; bh=Zi0wl12uBkyUtWEAl/2bStGc9vkEOBo1N7J
	nlxDXxn8=; b=PlqFiniC5o2oGbbyI+Zg2pxNw+bh2yYPrfkNmc9hUhGmZHV3MqD
	kI6EgS+FQji2nXE3Sk/Qgp36TG20RjwZkWADmGPVmLLcWVQwLjl4YY6jDFkAD22Z
	kQYhs5/nm5A804vKMyINxEw7Z8yrJn/1kdkKhCeqQLDuJS1cgM2q/PJLKNOrvTj+
	jJ62t2SO7bQBqjz5/foyVktsvaxw8krXpwDPzeNvrOuMAnDoYSj94IgFDwWmZcz+
	B6iuT9GIDO7l7k+abt1XUwYNJ7SAxl7vNCOc33O4AqzMBDJI/fijxHp5iscXLooL
	DxaU1DsqXcvg79lFtHRHuCv3xBc/UgbgPrQ==
X-ME-Sender: <xms:D10zamU0x-N1ueNMllmSj0jqi0dtHNEEvCi8maP3Tv8VkgR63rs7Rg>
    <xme:D10zatM8gFm34OwBVh0WhMn0w7yszRnX9NphdmZqC9xQrdM_DlHldD6revj8PZb1c
    a1WwzjXOFdTJb5NI7YKDisTqHQ8XRLvxqoBzkD-9ZzI2Aof_HRwaw>
X-ME-Received: <xmr:D10zagYuZXDhh99PJ8_ToTMqGP4d26Xald2yiRIHR6bnJ67Igc3DltOboGZP_XYLyqI0W8TqNFLFn19ohrF1d-WfzkbzQyhUG-yS>
X-ME-Proxy-Cause: dmFkZTF/w1qslZpBOj20kH/SA1Yxyvuw8FP2xqe6Y1WmJsK44E0HPFjm1tihxXevQzhcPp
    EXJuvX/oD4/g42WLeTyP7/lqKv7QfF+/rwy986JMZftcZ+lBwb93+96+hUvWER8xUPXJyD
    1wUBqO3kpSc5ZF1o5pen95oihZt63EIETKZp0wwTgTEPlAM+2odDIgDDBGOSGvCfqUBAvg
    rgMIh9p5IP/Wdw0VmqAi7LmpN5nh6itWSOBOhExM/pP9acyA4ZHO2JH/3O33opEE2CLTyu
    TYi/amlc2iz8mcn1SIvsMHKIh4t5nEFkis4t12lBZD8pjKHbeVDagP64n+f9ewVgxOUWhb
    7fLBTvw86ttKpI2N/H9jCKPJybUqQ5gXsh9IPKHaxBe/X66k5tlNJkqo+1SUOnhGUxm2CP
    mlyPRmL0rxC86+Brzr1a57aoIGritGz5SRFWo9xtH9Wxh8T58pvgjW4jS76NZ13EAVOwOS
    MvO417j9BHyS9TuuVGTHYDXkH7CFRCU6MaTRcxP66GcszMH+g+oOlgaXSvHrZe//oUpIDl
    jmW0j/6SF3lz+5Pq6SGaQBfUvXWaz5ZJp0cQOItE+JDjCsFlq3PRH22uCBy0SoUF2Ac+iX
    hyfiXmQccamDZALH+G4HfoYzZX99SfVNGV6NLGEpudpcHwYV14Eu1n+Z0Hgw
X-ME-Proxy: <xmx:D10zas_4_Cx81m78ywiKJO4RcxC0KZXa3T5tPAwv6ySp2T2jn5IjvQ>
    <xmx:D10zahTR38eYfuKTZq7T-q3P8opf0SJVYPsQ08z49n6XOEOPOF7C-A>
    <xmx:D10zamc2OrpHZ1vWheI3EP2Xl7BEhZNJ-k-98v6IEGrEFan79nRVXQ>
    <xmx:D10zajS1EkGFuvbC0mp7JQCmDBCY_pIabUGUtpFT44aGRaAXmTzohQ>
    <xmx:EF0zanWaYwtB7nxYcZHoej_yd1-wrBaxszrxSm8zog-bdolTaY8C_mtA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 22:50:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Marc Branchaud <marcnarc@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v13 0/2] checkout: --track=fetch
In-Reply-To: <CAHwyqnXLceLXzRrW_7TB8JM+Ur92gw5QkYeKjzOGbWX+f_yLjw@mail.gmail.com>
	(Harald Nordgren's message of "Thu, 18 Jun 2026 00:10:36 +0200")
References: <pull.2281.v12.git.git.1779358803652.gitgitgadget@gmail.com>
	<pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>
	<xmqqmrwtuggb.fsf@gitster.g>
	<CAHwyqnXLceLXzRrW_7TB8JM+Ur92gw5QkYeKjzOGbWX+f_yLjw@mail.gmail.com>
Date: Wed, 17 Jun 2026 19:50:53 -0700
Message-ID: <xmqqtsr0tvci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> But can I offer some (unsolicited) feedback on this review process in
> particular? Given that it seems unlikely to hit 'master' at this
> point, I want to say that it's the wrong order of things to dig into
> code specific feedback, before deciding if we even want the feature at
> all. We are wasting each other's time. I have pushed on despite
> initial negative feedback, that's on me. But I also cannot lay flat, I
> like the idea so I keep pushing. Now we have v13, maybe soon v14, of a
> topic that has slim chances of passing.
>
> I would have been much happier if you shut this topic down directly.
>
> Imagine all the review time spent on this that could have been better
> spent elsewhere.

You are forgetting that there are two things a topic author can and
should do: addressing higher-level design issues (e.g., Counter "is
it a good idea to begin with?" with "it is, because in this context
you haven't thought about, it would make the user experience
better", to help reviewers understand and hopefully agree with your
viewpoint) and addressing mechanical implementation issues (e.g.,
Respond to "it is wasteful and adds maintenance burden to dupplicate
the logic here and there" with "Here is an updated implementation
based on better refactoring").  The latter is easier in a sense,
especially when the reviewers say something like "I am not sure if
this is a good idea to begin with, but assuming it is, here are the
things I find in your implementation".  But the former needs to be
addressed eventually before the topic can gain wider support
(remember, it does not have to be sold to _me_ 100% and make me say
"oh, I cannot believe Git did not have this feature for 20 years!";
you only need to convince me that it is OK to have it as an opt-in
feature, that is a lot lower bar to cross.  In addition, I do not
have to agree with it at all, as long as others whose judgement I
trust well enough support the feature).


