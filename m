Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77DD1FAA
	for <git@vger.kernel.org>; Fri, 16 May 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747412491; cv=none; b=YpVxLwpB2U+4VUWG7alVDo7n4gyoAlEjq3s/Zvic4VAtXLviJCwn+BdkC15kRABc/oZIkQ/J9ZD6uG9LLlknbVXbYz4PTA8/RHXL5GhgcEE75+oDNyYHZHBwwU4Hb3WmmLWC4jpGA2xlUNA11RDwUgrwBc8HqE7LuUp5tcQW2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747412491; c=relaxed/simple;
	bh=AZDt+4z6tOHPz1HuVtMExBuU4fLWkUOScQ2ytapwsFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fz+821ZdXhFTVE8loH+NUyGPSGMdbVlLfBQi9//1tu+UXZGA/03gUcxvFHpEFE8rEqQamDREhJn60SUY9JvlPCT8sL0e6yGo5v4CScxXfuou1HB34f9EbqnsSkqDHbngW30FFFgT1IqpE6Xqg1kKZXlFzZgY4GxZ322W8tP9w6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bklufo3l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DUkU0hOY; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bklufo3l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DUkU0hOY"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id DD62F13803FC;
	Fri, 16 May 2025 12:21:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 16 May 2025 12:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747412487;
	 x=1747498887; bh=PjmJfYH4NxyiH6d8InAmGvnEMELP1Fo+5U7Wk9G8pxo=; b=
	Bklufo3lVQlyVoV7x5yS5qX4webmWRncJsncieZU+jIwqLqhVXC8DZmyMc08okT5
	KqR+oV6JMpCxjG3jW8ukcU2mTdND0b6zlYV/IQugEVaIeSifuprmz110e/tB5oRm
	5HEmXPRzy728kJunXMNFb+OkY0+Tq3tgyqnXv3XAt/1Tt+oq1uyOTkQrClAdd9Pg
	a604Ul2jubMQzbe8Y3hA5Qrn5MMn61IEed2+5AhwDi+gk1JbCgtxqImtRvct9k2R
	njkHvaRTW6B1YmJTBb4lqZL8oSsxDFkb7Ku2PwJbjOuaYFGXHTwWiz6v23mdlk1l
	cRRKHCn9XfoExjIseJIAvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747412487; x=
	1747498887; bh=PjmJfYH4NxyiH6d8InAmGvnEMELP1Fo+5U7Wk9G8pxo=; b=D
	UkU0hOYkejhILf+iwqgrWSHMsccSsBkbAKi9saIbeC8a7T3hZtUvjlze5y7xkLq9
	adGgHweHU2dn/ctq4bopCVDAgQXyV2Ie2Tt16c0fWrlfWn1Kn/qBCAe/2zA83qJs
	XYZjFYf0N1dkp+kwFd/YrY8GerIGQ15BokFVB8eZQBlloj3aZMXaAKBbm5iSjzow
	aVWpmvXFhxzRYXsFx2Bx0mNwuRpVgcpQIx7+y9rhCFehwO8woz9LmfN179uZ9MmE
	XYyqWjD6NOJWjPNxP/fxwnIejId+8xCRLtO+d01LdaV9SFS9LDRzGVk33zTWXQKr
	d1Fea07BjGd52f2SVQ7qA==
X-ME-Sender: <xms:B2YnaBAxELuHBQI0YzcaUeCjyUgOnyci3f16pEDQmq0PlQgAfJiJ-g>
    <xme:B2YnaPhfr5TpXIjm42PkOgaTANlhmWvRQX-M0M9ZNUWvY_1Sdm_JclIsXWuc6ho9k
    p3P28We1OdHHOAoIQ>
X-ME-Received: <xmr:B2YnaMkE5V4FO98X7U1pP-25ebNTnr5FRUeKF68HDx_kEnd4ZWrlyS6gVPZ7LM71vwcBFUjrK0dd0fiGbILCMY4Rt5FbV5D7wiS3IH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:B2YnaLwL_yVhfq-AyxEeGhlZf_GzKRbCT1qFC9ZQ8M4auhibINzvow>
    <xmx:B2YnaGSrtmdyCeYrxRMlxWeQPPMdBY6eaUiC9oTj5bJkT1jvn4j5TA>
    <xmx:B2YnaOZt2X-PlmrQmTxNqEakKh8gv8a9n1yudAPHdjCbv_sGl2WxUQ>
    <xmx:B2YnaHQA9v4z7-rJoZGnjDfC03qI2L7YvnIKeJnjnj7_uSwYpA8I5A>
    <xmx:B2YnaCf7O7qmGBTvB-XwIK0lamBwZrjjgYTgD_HKY1Y9u1O7-X1vpjRO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 12:21:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Elijah Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: make it clearer that commit descriptions are
 just comments
In-Reply-To: <ABFDED43-3AC7-455E-9736-A8D9AC0F3A40@gmail.com> (Ben Knoble's
	message of "Fri, 16 May 2025 08:04:25 -0400")
References: <xmqqv7q13m15.fsf@gitster.g>
	<ABFDED43-3AC7-455E-9736-A8D9AC0F3A40@gmail.com>
Date: Fri, 16 May 2025 09:21:26 -0700
Message-ID: <xmqqikm0wmpl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 15 mai 2025 à 11:56, Junio C Hamano <gitster@pobox.com> a écrit :
>> 
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>>> -        grep -v -e \# -e ^$ work >patches &&
>>>> +        sed -e s/#.*// work | grep -v ^$ >patches &&
>>> 
>>> I think we could just use 'sed -n "!/^#/p work >patches &&" here
>> 
>> Or even "sed -e '/^#/d' -e '/^$/d'" ?
>
> I’m probably missing something obvious, but why step away from "grep -v -e ^\# -e ^$"? A one character change from the original ;) If we must go with Sed, I’d prefer Junio’s construct (combining, with obvious semantics via "d") over the sed|grep pipeline. 

Mine was a spinal reflex against piping sed and grep; I do not see a
reason why "grep -v" with two patterns like you gave should not
work---that is a good way to remove the pipe, too.

Thanks.
