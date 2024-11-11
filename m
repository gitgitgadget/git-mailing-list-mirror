Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000915853B
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329604; cv=none; b=iqEVM7M0Y4C1OzgowYbpKqRYeFGNYE7Vik4I1YPA4fTAXYn+0OqA1PIJcmi72p+wPa2F80TabKXwn1mpQkRUCeOLpVh4JOCfjDUzF2PcqCdcSpR83uAq+oDpC9EbwrZxCGeGcoO/mLZbkyZTguO5UtvLcNMncuZVLqlKyf0jfo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329604; c=relaxed/simple;
	bh=5fpMsZE/NuOVc+qoiez8gXDvQpUk6kdpnqZo/29eXj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deFeMu1azBD9Ac+kn0VUOui1mA8YWfP35lWYw5zzEAoeM+HrQewu/glYtiw3HYywBoGDvqe7UYhN93VVfrzzujdw2E/dhHsOM055xRK33SBAQsNbKKc6sMGM3om8ZBnGMMhwIg4lCqFnh8oroAiO2cLs8LBYdM07LQWY3dVLxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N0MBw3nu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TG7+pF5D; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N0MBw3nu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TG7+pF5D"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 03EE21140143;
	Mon, 11 Nov 2024 07:53:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 11 Nov 2024 07:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731329602; x=1731416002; bh=5fpMsZE/Nu
	OVc+qoiez8gXDvQpUk6kdpnqZo/29eXj4=; b=N0MBw3nuhlFl114ZGSc/wA3Bv3
	xIsojJNArWbht9pdToNfneBWTw79HwTbr8wgQBH6zj8+ycxRqIS4ZS2WnzwcIxVy
	FJ69XULhtPnOMb8WQtL+eajzrOch0A22JcvSGXID2vPwpnGSZ7r17f36Khv3Xgpy
	UScQxcMs2+At+CWdrk0i330d189uS6DQDXsmk5nN0xYsK87EZd8B6RleiQrolouJ
	NM+8RlkqrLtZh+yMPHvIMx3cRKXnz1SXxasMdekFYmSbzMl91cA99RenhnIM42eM
	QzUmJm+lqSynxnc3wCMtBxb9IUhpbJwsUlxwYMX9P5xTsCTK+GZWSgLglGXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731329602; x=1731416002; bh=5fpMsZE/NuOVc+qoiez8gXDvQpUk6kdpnqZ
	o/29eXj4=; b=TG7+pF5DjqmQtsoSar71DJeb1NczytDHL0zc2Zu/6FJeoOEcF1B
	HXV6rWCO2dLQ5YfIzAeVTh717t4pofapvfGNDWKRj9MXlMl+k2Mf8TzuvIsa+Nn8
	JgCJSwOTs+7pSV2x9Q6s9RAPPvnpXVivT4Yg8GPg/GPgzpRnUSplwJBmLC5eEkda
	lIDZGrxYapmeO9PYp1FuUX+P9dTZm3oU7JSRCG2Pygg9kTf5K1x2OTR4seDNG+dA
	HFmk9qXRIIVdueErr8n+/g+ScJfAb9jYWOx2KXIEDtujZi8RO27q9cz1s3aCsZNt
	SgW7pR2O5XU+xP9R0kJkr1RqiyrY03fB1gA==
X-ME-Sender: <xms:Qf4xZxR9E6Pbl6eFA-QIsika6xXvf3w9ch-wHgR7mmilXYSCIcIBEA>
    <xme:Qf4xZ6xVEuAQVJUZMiiuaSHjKsogwYGmRzlXKnsceMzJXxiEYPJF5N58wxHug4JcH
    idFBa4WoBdeFWC78A>
X-ME-Received: <xmr:Qf4xZ21at_qu-qT91yBc15sAGiq3s1I8FOXp6lHZf9hpJaE7xTSQs2rBbsnrH9I4pihJMn49n4CeP958aTBiVh9KTEDO0AtzKshEhJ9BvLug8Z1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Qf4xZ5DarqKvIOr_iZINKurAvSeFWYpgDDMMLTUHWWQDDU0HZ7nikw>
    <xmx:Qf4xZ6gz1PUx5jpNX2o1KwCTjgL589Yro511qR7nBPVMci2CL2IKvw>
    <xmx:Qf4xZ9qKiSHqNiGbraQUd7QFWnfKBTxZStK4XBqADDu0z0C1MHq7Rg>
    <xmx:Qf4xZ1iM5VlqNx0_bBUBpBCQUXWiuhuXD5dAwqhDjZnciX8VAXTj8Q>
    <xmx:Qf4xZ9sNgwiXxqTA3p_3B7HxSKds-PZfLicZUUMqBWiLiOn-7G8kyx3c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 07:53:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 350a036b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 12:52:47 +0000 (UTC)
Date: Mon, 11 Nov 2024 13:53:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] refs: optimize ref format migrations
Message-ID: <ZzH-OaXmFcZkGE43@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
 <CAOLa=ZTGtGJDnMmuv++FS9Rv4KiRQewOepo_qOY=6h1xtNmNZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTGtGJDnMmuv++FS9Rv4KiRQewOepo_qOY=6h1xtNmNZA@mail.gmail.com>

On Mon, Nov 11, 2024 at 05:57:43AM -0500, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> I read through the series, apart from a few small nits, the patches
> look good and straightforward.

I've queued the single change to the first commit message locally, but
don't think that this is sufficient reason yet to reroll the patch
series, so I'll wait for additional feedback.

Thanks for your review!

Patrick
