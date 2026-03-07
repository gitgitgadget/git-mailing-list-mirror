Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78203242D9
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772866053; cv=none; b=MFD/jyEkwaZ2ZNIZsLq+XI3GOvwn0XKQscsepNWzuwCYj/aIRVBXp/4U5abQ77w82brBWcXldHmPjyTus7kvbsUCgj/5pqLdxT4LtIukEF9ygXirFf0Hdz2QjjCj8jt0RxTHv05jWKC1NmzaUIKOMyDLxmMEFIJRZCq9Kkz8xoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772866053; c=relaxed/simple;
	bh=/DnypgWp7LhuazMM4XwImiHzmJWGhy8+sOWc3AQpslg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ADFHcJNgdsj8vikjisXWjmbScWi2cETulKi/EY5tZU6RD4Tdq/S19AxJEi7dJoulZnN6SsLQBvWq5tqQl/XyogKHVeEtMYYmwDyF0WxTOJ4Ezquz1eAhJvHhYhGQunv/GvDm3fNAT21pi15s64MYpPOYmozS/GBKPZDwkskD1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bRXxhL8r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AMrE3c0/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bRXxhL8r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMrE3c0/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DAAFBEC030D;
	Sat,  7 Mar 2026 01:47:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 07 Mar 2026 01:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772866050;
	 x=1772952450; bh=lOEea5tuLcOCB3/YcK6FHcrFHmIZM7aA3f47GWyogWs=; b=
	bRXxhL8rjg6GmdoM1DTF3x3hscGoNm3oLpdgL65U4+sJTNSCf5V5c7BWrdugMxDf
	JvGUvbSa+pvthHSAto5WKFl6ZdH6xXiy5pDS3BrjWOdj6mb1HRQUJonmhesxFG8C
	apaXy6rjpRu0BGlgH2yx07aaMuXAeiWxODk0kHUhqrrjGzbXWMhvKnfIHGzDyItx
	ivCJuMXhMBSjS9PgZr1yttI6CTJT2IrC22KQZVV/+p4K2qsATxVPuxh/AL5/3QpK
	QhCSH12JtXdoul78Miid1KCg/DgMBFG7awvTd27r6EkvuU4ZLnnUJFA5aTvfdVbN
	zlMm2sZsR7X1pnP8INhofg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772866050; x=
	1772952450; bh=lOEea5tuLcOCB3/YcK6FHcrFHmIZM7aA3f47GWyogWs=; b=A
	MrE3c0/RbfA8oZ67iM4K8MYPh462B2CYT/xyaPCg83mXQPYI44FkGXcok3MAsWDI
	jQX9UgPXI7wIzvFxtpsERIY9q5H+NKXo43PLEkfnl9j1d4eoYBTjj1+IqukGumRS
	Nhb/8rRPW3xApK1Zb4WfmpInBk6wqBSGPYP0naols1Vg6NRPnKqBAZm8d2fS6MzH
	aOPXY2qUY7A13hrvlPZlKa9krIYNSnu/PM35Mhy15bOv1HhF5+42k4uF+3CZDevh
	SxNrZw0Ey1CV58sPJysZOyV7CoVuM5UOW40b2ojLwlZDFYUBoDViDdzE0IC4U7DH
	KCwpZpbJoEmbaz8krgmog==
X-ME-Sender: <xms:AsqraWt54cX4_BvmSdBoziPt24FHviOrggfiPiA5vGgLr5k4r3_VNQ>
    <xme:AsqraS7MjD6JlwxUkti_ElaxECn-hzuGMWSSqPMRzAyrV0NuqvC2PxiSOz6djJ2uJ
    bmGpwAuhb1IMWG1nhwg5QtTNF6xkAzw7sJkhy3dSanCFD6Odl4UfQ>
X-ME-Received: <xmr:AsqrafJLSnQcy5KW58jsQR0BfdRs4O1sp7XRjK2z0Em1eClLr5FTYKQEqGntlAHWK0PAzpoQnbBXr7Of-enlkbQgrkfIHSJjaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeduheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    hunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:Asqraa5FwAs8bsFCMUxkWVTNsSTPm63yYjLvi-yelDy_82AUeW-iLA>
    <xmx:Asqraax6QUrnsjDTN1AtRX-kQa4L4By1nvt-favG26RTaFTVQaMsXA>
    <xmx:AsqraWZEObseaw5USvd5V11O4XdInZP2WW4btcf6SepvuCQuulpktw>
    <xmx:AsqraUTNsBqF6GTkRnIbZhrlt7DumBXHAbWnMIe7sxa6PVMv4jxC3g>
    <xmx:AsqraXkhQU6ZUqFMbtDQmFMbyBo52tgMPHGfzKqMQ5QYZfw1_ynLbgqB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Mar 2026 01:47:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #03)
In-Reply-To: <CAPig+cTMz3SmxrJCVA88yrV-_CkHT6JX-GMVZ4mKp2LiUX65kQ@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 7 Mar 2026 01:33:44 -0500")
References: <xmqqzf4ktm2s.fsf@gitster.g>
	<CAPig+cTMz3SmxrJCVA88yrV-_CkHT6JX-GMVZ4mKp2LiUX65kQ@mail.gmail.com>
Date: Fri, 06 Mar 2026 22:47:29 -0800
Message-ID: <xmqqqzpwt9tq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Mar 6, 2026 at 9:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * fp/t3310-unhide-git-failures (2026-03-05) 1 commit
>>  - t3310: avoid hiding failures from rev-parse in command substitutions
>>
>>  The construct 'test "$(command)" = expectation' loses the exit
>>  status from the command, which has been fixed by breaking up the
>>  statement into pieces.
>>
>>  Will merge to 'next'.
>>  source: <20260305225128.54283-1-francescopaparatto@gmail.com>
>
> Perhaps one more reroll of this topic is in order[*]?
>
> [*]: https://lore.kernel.org/git/CAPig+cQWCK48GJEnGX7bP6exu847WR8HU3Y8sna525w6NEhmmw@mail.gmail.com/

Perhaps.  Thanks for a prompt review.
