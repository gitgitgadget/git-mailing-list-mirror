Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F703DFC66
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840058; cv=none; b=uZk6z4TiRa7TNqEXtriBu246RH4y1D2EDoXRQ2ONuB1JbxgOBD2Q62wCtNzx6Q1UpnDu7dRNF3qK7glqlwXnIb0EuRKbMBbT1GIrqKaXDUBo7VR7ix9A/PgP5EVrZKe94DKJzAcKr9+QOgvpYm7bF+Y+U0+1Pl03TaSDCATvsSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840058; c=relaxed/simple;
	bh=FTlP2mg1ZuMQjxYsRnnt7jlbuNYjcP9M75W8zAZoDQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DWwaWf1SNaYrG5cEKnPcJd1A0umXcto1UEEGS2KL/6Vm6AXqOMMgT7Vk4+mtgs3Tbitdz8P+cK2rP+r8n1TXaseN2BGhrbDAbv2EnA4uvButP1XGR1hhVPlKY2mMxKMDpGVV6Iv211mXpfQkCo834A5kt9JnPhPHFPgQkEnma0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ApZHKTRO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ao/RMI2Q; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ApZHKTRO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ao/RMI2Q"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id A61C8EC01AE;
	Fri, 10 Apr 2026 12:54:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 10 Apr 2026 12:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775840051;
	 x=1775926451; bh=Vnf1e2kf6VKRu3D9X4jU2ER5ZEQ1H/iToUawU+dmOAU=; b=
	ApZHKTROcNa+lisx4/24jazb0H3COuN8KOmEuHhQEydJD6r9EcVXr4vF/zOKWE1h
	TTjv/kkRagSCAAbz8kq2DOjZ1/MChTufSbTxn6iO0IcUBbuUfUuR+rr8ZdOFAtj5
	hHAk9jT3WL7G3kTxeinPUz+9hnK4Av0I/Y/yWyMMd2xWHZdUCMalnu40MXCUhHJE
	fDl9mYODiuCXPWyAL6CoicYqHS9dAmvUAFuQrS6rJtNwHUketczohhbrnYj9iiR/
	ud0fTS5zyzjgpbfAWegAu2vHmOT3LBGU0V03kmEiFW/Jyi8E+tCAubY1JHFSz+n8
	RibgzOr3zm0IuaMjsU9/bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775840051; x=
	1775926451; bh=Vnf1e2kf6VKRu3D9X4jU2ER5ZEQ1H/iToUawU+dmOAU=; b=A
	o/RMI2Q07B2uaErxDd1gvr/P19q26hDHMRdtS8awSn6pFWn+1KvnQ1/gCZ6toVaC
	dCIZtaUpXhc1wWCOUE2Kos0SWkpnJUkHw9F+dbM90QJluE0Q8lGqL9mNjWBhQoc0
	CwBpcRaNrksh5f2ZhPsIGOdHYqJy+pB8ZxyGyEDV5VqX9tdLbV5V+QbTknOco6Y3
	6vQO4AXohXcfJUXr1vP7deIAwvaSKsIYUJ/8Xe0ioB23TxVySAJkwDzcTbC/MapQ
	jOme3PTqDd/TKs1kycutfAbJf9EDOqFK8Uv2K6qyjffnpgF6TqEuu53LhNFh4vEa
	RHrrxfbqaQZlRbomMIBOA==
X-ME-Sender: <xms:MyvZaUosZkHlQcHbvUWl0A-W--DvpqERbt676NlR-sB_IflIZZSB0w>
    <xme:MyvZaXgsoSvy8_IEgXgy63UpfkT8jswSqWbLdjMVx39LnFms-ZgqjJfCjIq9EAQ38
    pvZICSGgKF2gQzcAHHMDFCAySfXDWc6vStaFfqH5uh7UmirNajpmA>
X-ME-Received: <xmr:MyvZaY90wH3ZIeWZWIQKcsjnvO2XF_vjBnQCRkuicicLmUc7crvym8kJj9aypIUk-rBPOZRTqCAAZp0e5Ggh_Tf-SkDgtsAgfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprggslhho
    ohhsrggsrghtvghrrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilh
    drtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    hiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    tghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MyvZabVK_mqWZbNwkrTwHPzybwXf_GPqQA2zz5-6Vycd98-kLEaq6w>
    <xmx:MyvZaUAj4utPJUBCLMgGrz8EJZPwX7bYVcLtZUd83GgzZJNySU1blw>
    <xmx:MyvZaYF--2I5oMvz7VAMj8np_JfaKpzzI2zl-EC6UEu-bKRA7G8EUA>
    <xmx:MyvZad6pdA2DIQvqza69PD2d5JWK6_v_xSBP_w18-PN-cGaQpqennw>
    <xmx:MyvZab6Hq4zKjmG22QHwFL19YLGmYGp8UoPnJif1bD-on6-INWcDo3t->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 12:54:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  chandrapratap3519@gmail.com
Subject: Re: [GSoC RFC PATCH v2 0/1] graph: add indentation for commits
 preceded by a parentless commit
In-Reply-To: <CAN5EUNSEt+W4kQsoTfLVJQ+KFYkcPCx3_=YTSwh8zhBMFDttEw@mail.gmail.com>
	(Pablo's message of "Fri, 10 Apr 2026 18:25:03 +0200")
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
	<20260404092425.550346-1-pabloosabaterr@gmail.com>
	<CAN5EUNSEt+W4kQsoTfLVJQ+KFYkcPCx3_=YTSwh8zhBMFDttEw@mail.gmail.com>
Date: Fri, 10 Apr 2026 09:54:09 -0700
Message-ID: <xmqq5x5ypxhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Pablo <pabloosabaterr@gmail.com> writes:

> El sáb, 4 abr 2026 a las 11:24, Pablo Sabater
> (<pabloosabaterr@gmail.com>) escribió:
>>
>> When having a history with multiple root commits or commits
>> that act like roots (they have excluded parents), let's call
> ...
> Hi,
> I'm sending this because I think it has fallen through.
> Sorry about the ping,
> Pablo

Pinging is good than no pinging, so no need to say sorry.

I think this topic (the one on April 04) has been on the "What's
cooking" report since issue #02 of this month, waiting for comments
and responses to them.  I haven't seen problems in it but that may
be because I do not view commits near the root commit very often.

Thanks.
