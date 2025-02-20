Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8A12641C3
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079043; cv=none; b=krsAnKDbzVXZ8I7iyoWY+xOsYRxsputewLU0ZtaK+7DGRubRylAQr7xxusPRSaOTdpfZlb3TeLqX1H9WVPr/0ISK3oSuTZmM1Mox95zG4UU0k4zy3mr2As+Q7ANH0FSZ8DJOVFrFrQNf4xTl3GXGt7xA2H/QMBrF4WpHXW5P9g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079043; c=relaxed/simple;
	bh=1h6tK1BScB+pBYfot1qVuHbVgEX3nxinq/5BClRLm0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HCM84bvJNXvLaC3OcvF7DUMQSMjEMcOBsdV57xmgm7QoTb7dukuGJ1aF9+nJpo7RjlEDEF1pkNyHUinroxE37Of86Wxlw5IK/YnSWbYt8w3Kc5+dBFJpj0rhCYXWIX43nA1TtjMVC35+xYcoQzrvGDynUdFbUN2axQRKbiGI9KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e2Rxk79y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sbGwDFwP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e2Rxk79y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sbGwDFwP"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DDB57114019D;
	Thu, 20 Feb 2025 14:17:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Thu, 20 Feb 2025 14:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1740079040;
	 x=1740165440; bh=zhhmzv/95qJQ8SQncqzqdIoRmlsMuhzUMGDmiACwISs=; b=
	e2Rxk79yo/tIIWltILdzDktTydTim0hCMmuB8Hr3iEqvFq0/i77j4S4Bo1CiqvoU
	UTSf9IRL3CyUHRMv3rfnnCIQbI5oRL4I8xpCTwQPrJgqPTEkhUD4J+XdZBsmUH/B
	owOEIJ2I5raXpWHYxKRu2D0hqleHIcFDrA2gA/7DYDcnM7X96ngAdGrtNFYIda0T
	9mPkX1P+EI8obdfolhpLmRYyhGPo/OFVC+GC0UY1BnLqhCmPMCjOlg5cSmi2XNr7
	qQp34QzmsA4ihTsbFlWUeKRiYGRja+iB60FE+w1PMwTxfOhcJ6hzqv12dP8nRamv
	M7EMrW4HDxJCD6AaqIzkdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1740079040; x=
	1740165440; bh=zhhmzv/95qJQ8SQncqzqdIoRmlsMuhzUMGDmiACwISs=; b=s
	bGwDFwPdsKq5sSzzJDutB96nfNoUHBti2OaanPXlM7dlF0x5AAJbjqfhgCSZKhXv
	eFwe6PvzmRV0nQXiN3IlOvkgrDZbEG7wGXuNHacYzh/hRAF9uo4gH2kg7adq/7Fx
	MVwi1iLqOhgECpNQDPBKqwbqMJ+rVoYvzh6iZOH3s8Gh5TJAmnhusS1eswQAiKpJ
	rREPP53+L26LeRq63ifBu6Sr1Novu+aMG1LiperzQ4zvUF3AwY7ctNr1G8LPIV2D
	/MRX7/L4wni8nEkjKJTcr520stpvYSmE6jRbx0vAhlZCh5atFlrwbGzXIc6z56Tf
	GmBYD7u0DfbMzPg4gHIdQ==
X-ME-Sender: <xms:wH-3Z3AysbFgKeXnsuG_w4SDv5xAUlSD2fkc6SZN2S9XMoADILA5dg>
    <xme:wH-3Z9g1-cI44lGLojmZxtNgMFHYEmR-GLHjxgRgM0nT10lxoCmuJPk2VrWQmJn0z
    OXzDSW4x7AxviZJpQ>
X-ME-Received: <xmr:wH-3ZylV_NRRo5cRzyCiXjBqZ2GGu8HmAoazlWsecfjGjHnzTG4eGSqCKH3CMCvCfREgltt4bdusa8LPLl5s02fnfaP3O8Dm4mkevt8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhephfetvdejheduheegleehfeeivedtgeel
    fedvffdtvedtudffieekieeijedvlefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehurdhklhgvihhnvgdqkhhovghnihhgsegsrgihlhhisghrvgdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wH-3Z5yEorh8COrxIALMOSg12yMOHLFfCDzil_TBs-Ds6X_QBeBjNg>
    <xmx:wH-3Z8RiamS94axk7kbWllW3ibZuQ-tpKdT_yxX4l1ySW3TcQZxuBg>
    <xmx:wH-3Z8bBnttYWn32CgAQxGegqnbPDkzXnyrAp-CFQ6ccGju5IPxd_g>
    <xmx:wH-3Z9T21e18dbDxl4PM8UavZKkCRtkm578trJ2sFXea4oG4bJbZ9g>
    <xmx:wH-3ZyMMeDp5ayUt29G-AliT34PnpyvmXmA004FRVHgVOQlDPXgEfS-q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 14:17:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
  git@vger.kernel.org
Subject: Re: first bisection step takes quite a while
In-Reply-To: <CALnO6CACJTKasKT9rX9w4_r9q0DPOPZhGnHt8f65oo6Q=8NxEg@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 20 Feb 2025 13:44:47 -0500")
References: <arrp2ye3kid76pwghguu5z4jkpv7xsskzdsjunbfkgmwejgby5@qh4phxwzenyp>
	<CALnO6CACJTKasKT9rX9w4_r9q0DPOPZhGnHt8f65oo6Q=8NxEg@mail.gmail.com>
Date: Thu, 20 Feb 2025 11:17:18 -0800
Message-ID: <xmqqikp4ctoh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Thu, Feb 20, 2025 at 9:38 AM Uwe Kleine-König
> <u.kleine-koenig@baylibre.com> wrote:
>>
>> Hello,
>>
>> today I did a bisection in the kernel repository:
>>
>>         linux$ git version
>>         git version 2.47.1
>>
>>         linux$ time git bisect start 09fbf3d502050282bf47ab3babe1d4ed54dd1fd8 96d8eab5d0a1a9741a4cae1b3c125d75d1aabedf
>>         Bisecting: 572238 revisions left to test after this (roughly 19 steps)
>>         [eafdca4d7010a0e019aaaace3dd71b432a69b54c] Merge tag 'staging-4.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
>>
>>         real    18m41.374s
>>         user    27m18.306s
>>         sys     1m0.565s
>>
>> I was surprised that it took that long to find and checkout the first
>> revision to check. (That is on a 4 x Intel(R) Core(TM) i5-6440HQ CPU @
>> 2.60GHz, 16 GiB RAM with a Samsung SSD. On a different machine (56 x
>> Intel(R) Xeon(R) CPU E5-2660 v4 @ 2.00GHz, 256 GiB RAM and (I think a
>> spinning hard disk)) it took nearly an hour.
>
> Related thread:
> https://lore.kernel.org/git/19461b87a5c.5a2ea74016716.8214238482389812984@zohomail.com/

Indeed.  I haven't had a chance to dig any deeper in the area of the
code since that discussion, but the ideas raised in the messages
near the tail end of the thread may be worth exploring.

THanks for the link.
