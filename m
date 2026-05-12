Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAA4271443
	for <git@vger.kernel.org>; Tue, 12 May 2026 03:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778557852; cv=none; b=ZPKBjCvMQKIZZzkV8btlH19KYQb+FSghM2ZUm3DbDZo9Fm3LMJZEDeXNmScr5yZREV99clu9r3iRny2stm1vT8zk3JyQZ1Onw6wsUo3EYIOQwMNe+bltwVZKsYVEYBHQclQn/x+JPnokz0lWQ+3TmezjUrAWTXayRw1Lxfn2cU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778557852; c=relaxed/simple;
	bh=4Ep7heDT8nSyv76e8nSOqQLi+cyzVNtb+i6zFXqPIp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l9ePeSwzkRotV0BlJD4L4qd4BxJR8zZAEYGPDCT2g6su9Nnm7D0RA2wv1xllS7pqrCZ0QK2BLoGEktkuCdfQDh5gNM0yGjg8QM5pwACuTl+81U6pANzHBEmu8nGyikyk4EEaVDaNygd4Wi2mTNStEvcXpcMoyNCQPm49al/YtqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gc45sx8E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f8DVQcic; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gc45sx8E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f8DVQcic"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C721B7A012A;
	Mon, 11 May 2026 23:50:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 11 May 2026 23:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778557849; x=1778644249; bh=QJsj9FwfmJ
	e2IkgNXweQx3+d8k+9wSOlFHv4IJzyx2A=; b=gc45sx8E/U70rJZDCiqGhEIULI
	2TgKQ16VnFa9FZY+1sn4G7JKf2AiG3lDsd6VAcwK1VZUgzP1uSWFq/jOSVB1lqQZ
	Y1OjCeovM0E9xIzsV0qTAznNwLuVeBi3dzYPJe/jM+m96JFtzN9C5Oz/wvMkxTlN
	fVyw10gwsN6jTZWtPBS5JUL+CdfXpbJr5NO2nqXsQBTrt8YRmr0puAgpnpHeSpF4
	lYfhVYAriaF2SxMNzUgXOwMnMnzEqUxgfP3pNvluv3w5i1r/LYz6oEes7bsTsTR4
	m0L7fIdbjlR/yUXGZhMtYoYt2yNT0Pe1xD4S5cnA1CmdPxi/GIZDV9xgWwMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778557849; x=1778644249; bh=QJsj9FwfmJe2IkgNXweQx3+d8k+9wSOlFHv
	4IJzyx2A=; b=f8DVQcicUp4DuIvRCZ1B0eHZQevXhNCjDunXn0wvTIhcUXXy+zt
	B3755mmjF2I/tDWUWNF2YOHezVApy0aA0RnI+Gb6YYKY1E5QdzJ2kG5tYHqUNer/
	LB0jJy0EEP/U5InDld6Nyvi5nAk97EGZJmRs0iRpzkh5mG/JnWs80c4IPpbUl+pt
	NQ+7LDQwvBsHS5N+5sd0/sZ7iPJg0Tlv0wEkAsdi/WCkVLJi2Gj+oxZiShpzg2Ee
	JKtv+m+TQ64hLnqrg8ZrleeGkNCJA2rQvRamaiwaLVxjOzfnWNpy4KbT6hiWNaSt
	NDo5OHdg/XiUORl7tYWwDyUfXZ6d0HxbTWg==
X-ME-Sender: <xms:maMCaqNdu4rMe1-ZM9GoeqgtR0w4Tkr_wMyvTxmtbuXZa6JpPeymfA>
    <xme:maMCasqRnAtmnEiPYzO5chq3gNuMFU7AyfBK-Rp3E_Y6pX5iOsdRFhvFARWgh4nQn
    3sqU75KNHP9ewLBiQz9tDtM1eIET6DXFQNGa9G8UU6Q36_5FTUdm_M>
X-ME-Received: <xmr:maMCarHpoHc5bgkiNaay8Iw4e_ukqVvDFdP54F-y8nm3LPMvi4Nfa3VB96J2WD1BYEIcl-0rjwYCkmzlt0WDv02BK3T4FsnxIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgrthhhvghushesmhgrthhhvghushhmohhrvghirh
    grrdgtohhmpdhrtghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehg
    ihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhhigrmhhthhgrkhhkrghrtddt
    udesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:maMCahr2kVK3x21Uz9AcivDbhVS7rgz2iOTOpPBN_HwET2WqVIXsoA>
    <xmx:maMCakb0rh15DRg4vA5kDYkXiqA-5FkqOJILsCGhJpZ6Gxro1mDGaA>
    <xmx:maMCaqUErUYPvgdYV3meoNz7Zkai_SaoZ2-muxPfedzgRgd3ybkBUQ>
    <xmx:maMCat-u-_V1l8D-uL9DXOqkWrrC2lZU3OwfGWiLSIq-I2k2bh8qpA>
    <xmx:maMCajVWdubgOzigQpyXzgNP6qQ1VhxkqbUiPJGQdD4yPFeT8gu_ATH5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 23:50:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  Matheus Moreira
 via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Ghanshyam Thakkar
 <shyamthakkar001@gmail.com>
Subject: Re: [PATCH v3 0/8] builtin: implement, document and test url-parse
In-Reply-To: <6c0a1601cd379bcdc87b4fe3b854166a@matheusmoreira.com> (Matheus
	Afonso Martins Moreira's message of "Sun, 03 May 2026 16:36:46 -0300")
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
	<pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
	<20260503172838.GA22957@tb-raspi4>
	<6c0a1601cd379bcdc87b4fe3b854166a@matheusmoreira.com>
Date: Tue, 12 May 2026 12:50:47 +0900
Message-ID: <xmqqjyt9p9pk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matheus Afonso Martins Moreira <matheus@matheusmoreira.com> writes:

>> Reviewers comment: Nicely done.
>
> Thank you!
>
>> More a question to myself, may be, about t9904 (and may be other parts)
>> I have in mind that the parser learned to handle
>>
>> file://server/share/repo
>> correctly under Windows.
>> I don't know if this needs to be addressed here or in a follow-up commit ?
>
> I'd be happy to revisit this in a follow-up. It's been a while
> since I used MSYS but I do remember the fact it rewrites paths
> internally. I wasn't sure how to handle it properly in the tests.

So the only potential thing that is missing from the series is the
above, which we are fine to postpone in a follow-up series?  I think
that is a good stopping point.  Given that this command is new, it
is fine that it has known and documented short-comings that will be
improved (of course on the other hand, we are not in any urgent need
for this new command, so we do not have to ship it half-baked).

Is everybody happy with the patches in the current shape and should
I mark it for 'next'?

Thanks.
