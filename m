Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A3305969
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663313; cv=none; b=tktG37t7uLhkN1epuvG2hv1T6lahn6UKDQKRzxoqqYX57l1/2IURaAKxXnNlTvBMcxGd8k9F2eHXpUGUa46Skt6RYy15C0bCT4qAZYyBxqMXiUq0+XNyFAnF+Ran53SZyREFGafDbehFbbk5uWgEdFkP5kQ9negkyNmpiLpHcn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663313; c=relaxed/simple;
	bh=7vSDeKWoyrmQ+bRh9Xx1UaE3bAiMetB2YRJ1/bkP9M8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CoTyu0ulqmEp99f+/pT6MvupYm1S5JiF75x0PPE0WoL/aqhDWjbrN5om9KoNJQFYkFBCnOYK0oZ+9NUIMvWUk1dg+yhuvAD12nHC5k5rM96CBFMxXVL0IPzjF2MK9tEpENfoK3kDzAJxI80nHfpbZj3ehWnFRXrRedye7yrpJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LmIDiHV7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iIPsDe0F; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LmIDiHV7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iIPsDe0F"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A203C14001D7;
	Tue,  2 Dec 2025 03:15:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 02 Dec 2025 03:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764663309; x=1764749709; bh=hL1gYVinIp
	b9u/2TW//bzQK4HG8eMBK0TqnjHWMQhzY=; b=LmIDiHV7UbumlV98OcE5cz5RU+
	g0Nfy3Ra2dHbbj9bCRtFQhozV+8iyD+ehgVMwejYxKGw5wDGOx7A06lUIXg3MWR6
	EMcU9lDVLfw/WBCoNTTNRImpqzwJ+6t3V94vZE6HGS7p7enZ5feQ9ETumDYjy9GG
	N2TRMQlBQB1Q5TUc0DFowER6Glax3SZYwDOOCed3skFBu3hZN8G7TqhK2w/VtoYv
	/XpJZsEPh3Z96/Jd2lsx9YXXHjIcR9Cms6BxUY3OOrVKvxT228uOz1cN9uURrn++
	q0Ki8CNkkrkoRwcYpRl9dfDWIX0eIV3rkJC9rBprAbHSw8Hd2NnVC5FXNz6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764663309; x=1764749709; bh=hL1gYVinIpb9u/2TW//bzQK4HG8eMBK0Tqn
	jHWMQhzY=; b=iIPsDe0FpUSbqJ/7ssKTOK9LJoODxyBls9Ebu2yhQU667m++/o6
	SbTrSsagZ7pgqFLFpW6PsDuRN+5ENg7qbv2KKMiANQz2iDXaVrYH5vMADkyrxtFu
	DxC+8HyasYUB0asgiv8kyR/77V0WDr9VYi2KrBG7uejw2tez8nLL+ggqhzqQlloR
	Gqn1z7Xh3nRr8XMyiAGxxm/45dhxjTEXfHlyet7V/mLBEVOhPpcpDpTdlCUa8XN/
	EzYAepVp1mn46+p9jElDf9LNyuP+10LZKB+G1Ib8i2DunfEWPTCQIRnlJ6ouW3Vu
	YLwExL2HxhIgj1YNquAR7WkVBB+eKEHXumA==
X-ME-Sender: <xms:DaAuaYhY5-Das1uP46S8ZxuQbSK8jRyfDXunnzmpAtgaqaT0OgQRkQ>
    <xme:DaAuaYCimYyZsTdhq5ZM1xzANrAwZi8MAPnNqtqGuOqYx9MmvuTx6tSSWWTXWeK-G
    fLxJ2b1lJSGAoNHtruByJCycEoNGGQqj4CW3h9Z8mvxddiUxn0N>
X-ME-Received: <xmr:DaAuaVE-UyHS__Z8csqkiiHlnchL1TfChD_RsgzUrGhsnxriCEYFEhGamjNB3WMKjbUsFt-JkXy2JMK_zbka4vGJP6fD4B6tDHs5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedttdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepjeevffeludelfeelgfetjefghfeugfejtdeijeffudevteffffeuuefhgfeh
    veevnecuffhomhgrihhnpeigkhgtugdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrg
    hnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DaAuaYJcOoRjkWgzhgQahHWullShbVF3PmJkH3L-X_u0aFPGLa5hmQ>
    <xmx:DaAuaRllD22BwX6s0KJrfYa6PXyVpSh3FdLwKonO_pEmWuBmJbV-WQ>
    <xmx:DaAuaYTPBHQZdK0bt9ptd-11bZRwAbxX-c9gLTeDNfAHmvoQNEbIcg>
    <xmx:DaAuabIGGAb3HX0MY2Lnk3bAncGwQ5VkqH6-SVFldfFuDtqGMjp4Cg>
    <xmx:DaAuaacyLS6bFnBGusklJM5xPBmxj1jU8gQa_HCI_pOX2G9tb4vAOcp6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 03:15:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 05/10] t0301: another fix for Windows compatibility
In-Reply-To: <e355d80a-a0e9-7795-06cd-1b8acfa6c7c8@gmx.de> (Johannes
	Schindelin's message of "Mon, 1 Dec 2025 14:25:40 +0100 (CET)")
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<c59a5f24789cff55819caf92d828256f2291b3ff.1764440906.git.gitgitgadget@gmail.com>
	<xmqqikescar1.fsf@gitster.g>
	<e355d80a-a0e9-7795-06cd-1b8acfa6c7c8@gmx.de>
Date: Tue, 02 Dec 2025 00:15:07 -0800
Message-ID: <xmqqfr9t8flg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> In any case, a more productive than rethinking the "can we express
>> what mkdir -m <mode>, which is a construct in a simpler world, wants
>> to do in terms of a much more powerful permission system?" would be
>> to see if the test linter can be taught about this particular rule.
>
> Seeing that this issue had to be fixed twice within the course of over 4
> years, https://xkcd.com/1205/ applies.

It means that we are punting and are not proactively helping future
developers who may make the same mistake, but we expect it would be
rather rare so I am OK with us making that trade-off.  But then can
you dial back your condescending tone against those who are not as
familiar as glitches in the Windows port of POSIX shell environment
we use for tests?

Thanks.

>> It is easy to forget that there is a platform we care about whose
>> testing environment that emulates POSIX does not like "mkdir -m
>> 700", and it is a bit too much to burden developers to remember.
