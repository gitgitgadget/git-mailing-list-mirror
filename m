Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905AF221269
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 23:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634299; cv=none; b=SvWaL+P2llvSxfDy41sKNK8luNn/7qzNoPrrsaOu3PMdsKmb98o7lZx6IWnWfFlmh1rnaDxs59fzVFmaYCH9XV11/mYeAoPiYRppV3n9eRl35wXXLQG4UXy0lkk9izFccpZmMaAb8OdP5NL+iQZaOfptZLlvRQsG9g8skFn/yNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634299; c=relaxed/simple;
	bh=qZhRloqygTq4pErbSBPiDd3ZIBXX1dJNTtGuS+WVO9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jtuLNyy/7Rg7GaIAfx2NIkOW4E2dmrQUVW02ioae0zi4PdrnPCp+vznwMiTG1Y+lrdLrqr10ar4BbsPeezYBKouNP+WfB3Bas0BWRC1xCQYeh5iXG91a+3Rn9hyAVjSXrYME8Q3F7zXzzmWOO2PvOgo7RzY0EsRCorNeisCcOGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V28uPX2k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XGnbbgHc; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V28uPX2k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XGnbbgHc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 71C2F7A0320;
	Thu, 11 Sep 2025 19:44:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 11 Sep 2025 19:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757634296; x=1757720696; bh=nRPQakz3rn
	jTQa/Sf1tvIfUPYoWN8nkK1Nm2W98kWMU=; b=V28uPX2k8SPAUOJXYD6GQSYlj0
	zTseRufMVx2WZkkPfgX+CrwBMvsSidwNcPJT1VVe3ZI2NpjxxiG55GPv42EXN3cM
	q2Q4Hdy6kHGa3BfQBeb0uyFisyurTw1lhGi8lPlRQgO9ID46H6woHev7sgsX8HjF
	7c9gzjQqANA2d6hm0p1FI8PQZTmqjKflgsAh72kf5zflrCyD+IRU4Qb/LsjAbUJp
	wF7uln2XCebyyoSvQv1j2z0r6y99xInPmVJu0JSLvlVIZRfwS0aRjhNxxgi5awUN
	+LlCevb7jKpPdNBQcLVgzAXSYaqetaTNamVk9AMDTsMsG6qAA+QHt/W8D+DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757634296; x=1757720696; bh=nRPQakz3rnjTQa/Sf1tvIfUPYoWN8nkK1Nm
	2W98kWMU=; b=XGnbbgHct9hwTJ3jGdABK/LQn6A7b7OlCj4enQldxHpu7jNDJ+0
	XJTeP4JTuWorb6ERXBEg3Yml8dN2vg2oAASfCjLG4qcRsFT3bJ3qAIESCteeuVqf
	jak65kHjRbpEyNF4SOyLN6clTQXIharVzZQ1x5rqCVSpBkDsKaou/QsdvnDmpUJE
	1GsNYTVpJ9YTAUMFf1/M2fIrjiVext2cUb9pSuweUAEQPE3HUkaAP6y+0wuSZ7hE
	Fr0tgGhroZL3Hwz2sTXu3gtD/b6Gixh7C7O9SDUSLSvQtmPcqVZN8J3Hyg+uTv7G
	E4MLAAi/4oNhmE+SVtKUSYKrkolaIRsE1Tg==
X-ME-Sender: <xms:-F7DaPhMB9mQqE-Hpsxuv7iM1enqzipZYNMwn6EDW75b4J2j9snk0Q>
    <xme:-F7DaEfwpUS4bjPBOecMG7UqOlWXN2iCRLV0PQX24NuTnxATRpRvSM0VuW4hnKjkA
    qLWm-6R9SNJ38BCsA>
X-ME-Received: <xmr:-F7DaPiH6EcQyUcv7jXORK9Ddvbkpa5-IuWsIvOhX3QI1l-LLNdOEBdMgQCSIHKBEfhLY0tBsOvfGtDIO-tVNpF7Kyx-kbxpHVbWbBY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvjeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-F7DaMyDQFf44IBPzB5SMWlV2FWlW9U7YZQ656R_-8QoQ-K0RzRceg>
    <xmx:-F7DaLOEIRSE-7igOwl0zs_PI-jt4VqA56VmBMbmlfF9qjr0PVHv8A>
    <xmx:-F7DaNXIikxiA1lYZiLlEgLpKG8LIQQSsDzDm0tHczipM3YuBOiMFw>
    <xmx:-F7DaP3ksCB-HqyKTAz-JPCIgX7qoo8pH4Haa8osWRAPfohUbLI2sw>
    <xmx:-F7DaHK8Xs_AhqzSvXFurPT-KDf8b4bNbVSEmFRwaNhu9ZWNfLOrCE_->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 19:44:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee <stolee@gmail.com>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v3 0/6] midx-write: fix segfault and do several cleanups
In-Reply-To: <aMNXhDn9O5+swQ2u@nand.local> (Taylor Blau's message of "Thu, 11
	Sep 2025 19:13:08 -0400")
References: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
	<pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
	<xmqqcy843d27.fsf@gitster.g>
	<cc0c30f4-5e03-423e-a6d5-f8effb953f68@gmail.com>
	<aMNXhDn9O5+swQ2u@nand.local>
Date: Thu, 11 Sep 2025 16:44:54 -0700
Message-ID: <xmqqjz24o8p5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Sep 05, 2025 at 03:57:10PM -0400, Derrick Stolee wrote:
>> > All incremental changes made sense to me.  Will replace.
>> >
>> > Shall we mark the topic ready for 'next' by now?
>>
>> I believe it's ready. Thanks.
>
> Agreed. I still have this nagging feeling that the reproduction case can
> be made smaller, and I wish it weren't flaky (as I understand it to be
> on Stolee's machine). But I don't see any reason that should hold up
> this series.

Thanks, all.
