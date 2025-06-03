Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB3F23C4E6
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964745; cv=none; b=Z1XM7iJwHgqQ7yBG4beFjkQUwc/KxW94jr4tU9tXiDJwjCOmpirHQB3HSVSYRa/ucS1cX/XAXGRU0iatEISlydC3DEh0w5h58YNfbvQupIDwm+YSaTOlHEMEBrsi7r6XhJkVvSQghDrRj1k/iEkFd7+smEIYDKxpiEBKOwNckmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964745; c=relaxed/simple;
	bh=9mGOw87yk+F4p3dHl53vEspaGIPdwq7nTMgGfcsIO2M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qLxcmHrqEdl9GmT2nwp16rBBslKeBYGSHH3XCdN5bTmyyNvkH9JFvWBHBKpUjijfZebiXwSIe8KWj0kWqQUjHMgAsmCMLTcp+JKA+nr86qbNniJPcA4hfED3HpXKizLPHZobcZXEDnBDDhSgXEeLG3BEZ5AuzYR+CbPF88LDmgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=l5oOpPKd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mcJhN7mJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="l5oOpPKd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mcJhN7mJ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F0AA138031C;
	Tue,  3 Jun 2025 11:32:22 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 03 Jun 2025 11:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748964742;
	 x=1749051142; bh=F1HgItqFY5HBIxe0ErzqbglyMlNAThoCl7dvH+9HcMY=; b=
	l5oOpPKdEdf11drcQXEc3DQUosFAzlyMYwFRi2w5SEZPRePj5c/Ofu4PdH4R+8iq
	Y7Iwg4GYXqsxUSKhItdrFfVvl0+PSv2GVVP/xZ9rrC07tV4b19joNBeR60B/ECDb
	FA8l9Aqdqm0+0jenuGgJMVPfG2sdK59qbRKeHJjlEi8u9nKEl4VP79czeyrGY/vt
	a+/cXsKh1wf9h9KoKdju5Cw1EPHy8lJ53MxLyBMZOgdp9ksy2b+ssmw23uY/Fcph
	dj2g+KMGCz5hFwAGf30rG9Obs84e6gk35xEapuFd6fUQTZR7tvf2/ngv4ULWKOnM
	5CCee0iOoWN6TunlldQ11w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748964742; x=
	1749051142; bh=F1HgItqFY5HBIxe0ErzqbglyMlNAThoCl7dvH+9HcMY=; b=m
	cJhN7mJrTtbRdqpWdJZ6lVdxlqNQTGmfO8NYYFe8utEZhBqT5WDUMlMuHwl64rRV
	sqrkv4F+C/I6KGwcFA/x9pa6OPF1ATBhJNiXQ3VhAfjePXFgS31epYRYnx73HGMR
	zzcXRFEkKHpFxVnnYrbg7T+t6UHFxBbuz57iOA415/hTzdsWlmwhkaWq7mhs8uLc
	VNLbeLpjWXUGqDTounJhZd3CSYDgfDiUvT23UgOiLANolp5UgG07enDIGjvrW5MS
	dkYH/0fAzk6nNOBQSqszrNQwqvlRACLMzzIKmjsiB1RzVee+WZ/x/oab1yR/0euI
	Yr0KaZW5XtZK8rMZBcVYA==
X-ME-Sender: <xms:hRU_aIaRn6XS4byyGp_h-Du_gVYJWVkL7RHEJfdwTeZTtNCb-n3-NcY>
    <xme:hRU_aDZ2LYUTO7I5ZVxF6A4l9rOtfBpmqZyAMt0lkVv0RriKjtI8ywhQnuq2MzcwO
    6A90EBuRX910GQCNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetff
    ejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhn
    ohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrshhrrghfleesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    ihrhhothhhsehprghlohgrlhhtohhnvghtfihorhhkshdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hRU_aC8xuFG-WKIiTzmlEQQfyH4JOZfu3ZiMCw0amlFa7G6aLMxO4A>
    <xmx:hRU_aCqX1KXn7CKTgOdab35HFRuIG4dsu7O2NmCiQ-nwZCm6MPYRFA>
    <xmx:hRU_aDrdT55oES6iIhvxEOjyVkDt0dD_0Eu66rhG4hTlMgEvQUgjjA>
    <xmx:hRU_aATqIeePjfa3mTxfoDngwuWhtAjN5Cs1HNLkG1v45Wu1A2fZdw>
    <xmx:hhU_aI7Jm69mPpB2AbhvTFlyS3o7C7yQnw5r5BcGnL9wMBERgM1GcYyh>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 66CAA1EA0061; Tue,  3 Jun 2025 11:32:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9e3ee3fc1bf18109
Date: Tue, 03 Jun 2025 17:31:46 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Yonatan Roth" <yroth@paloaltonetworks.com>,
 "david asraf" <dasraf9@gmail.com>, "Emily Shaffer" <nasamuffin@google.com>,
 "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <28f38435-159d-426a-95e1-fc3e4fbd4118@app.fastmail.com>
In-Reply-To: 
 <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
References: 
 <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
 <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
Subject: Re: [PATCH v4 00/12] builtin/maintenance: fix ref lock races when detaching
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 3, 2025, at 16:01, Patrick Steinhardt wrote:
> [snip]
>     @@ Metadata
>      Author: Patrick Steinhardt <ps@pks.im>
>     
>       ## Commit message ##
> [snip]

Looks good!
