Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7415FD08
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631029; cv=none; b=t7oHN2+P3AxPhqeOVteY27oYaQCxQ52Qoxqh5aGQYazsygFBnIQV4yYJBgF8mvR0EL64PDjhVzRSxVO3IF7GGYP7Z8tO0wrgwboIHPznZsdYUSaUqlXHz3hWGqsKC42I7CWrNsOHwHKmokMTxhcPkbHJyQEkGSBixQrMmqa3ugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631029; c=relaxed/simple;
	bh=OOIwsX12NmsJXagfTULYUFf2ngMbY9koAo8RFHePW8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcA2QBTOtIIgbakfK4bDQfR8A18eU2tmVJkY2kTLO2giJb7SSvUMuWyH3mSS1LD8Ha+m6DPmAuyjFrrUam3Jr9O3SIdz64HiwD54z9TokcqqPPoTE/grcfu35YN6M74kJ7p9+Hx7bG1dnaB5+ljKaYz5u0wVNaZsvlXsDb6vzNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=vs6Y4qqM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bwNq6syr; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="vs6Y4qqM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bwNq6syr"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id AEB551C000B6;
	Wed,  5 Jun 2024 19:43:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Jun 2024 19:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717631026;
	 x=1717717426; bh=RoxfyqjcSukS0ILe8ceZQX0EmvMqXpmYTVAumYhO5JM=; b=
	vs6Y4qqMRQZVvz5uu4mfS6+gEnmVBXmZR1Vp9GdSOF7mplgnLxwg7a/lbLncO8x2
	rs3vZldBp6kmWVKbkY0mpuRZYig3kwckue6vCWbE+JEmarIgdOw6JNWU7G1xhAHo
	zCPPaJcPmXzBPWCcp0djhDRuVjD7CilJuZUzwzf54x3iQzAv8QB3cdQreZMQiRL5
	SKBoBrTJJdsH8k4uIAwqW0SW/g24uzh39Q9V4YhGzBoLPT72BP7czmcS73JBwdcP
	dCdQ26AavxoEyIh1GJ4hq2EpszVzbZCkFksC5pBbqh/YgvWnu8AojgRsg/gWZyYv
	vNUws4nj4JrVBaSFhx4jQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717631026; x=
	1717717426; bh=RoxfyqjcSukS0ILe8ceZQX0EmvMqXpmYTVAumYhO5JM=; b=b
	wNq6syrDY6zB6UxuTPNR5slE1KFtxKht85BkRMPD6koGwDw8cY/HH7FrUn0/rkxU
	e2T1IXI/dNEOLuixT1CWyg1eQDO4fQewq2tANHKDKCkWoKii/Dtqclyhc6pey9GI
	M+gbwWZaG3J35nvdnUrR2uC4jLsz5Q23pvQVG+oK65jrhKXQFJRyJBcQmzmjJ0sv
	T9yHdVgTZz3/K03bNUzr9iYvtdkYNAzy+qwmD/kp0upAtqEDtxbMv+kfBO/cpjru
	nJMu61BEdySljT4Pq88OMV1mMG8L6VqkvTIoaEg78vSJiEEgMNnJ7Y8puZfyNgI3
	Lfe31Uv9THcELpOWW4d+w==
X-ME-Sender: <xms:MfhgZjwpB-EBNQugt6SeRlhXlDi3FzKbPr2vTZApxMLY45R2GgpEww>
    <xme:MfhgZrSSXpKrLemtG9IPGR0U6j3mbGfGvXhaB1ArBhsJrRxtx6JdOd8WrX-uga3PX
    ci-_4pNHRQ>
X-ME-Received: <xmr:MfhgZtWGYpekmJG11856OTuv5DiX6_KzuGxGewG-geC-iGSq_5QOdj6QfI7qZi6t7M6bMMjmuCulhesSIKW3Aw2M7HQV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ejredttdefjeenucfhrhhomhephfhrvgguucfnohhnghcuoehfrhgvuggplhhonhhgsehf
    rghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeejudeltdegleegvefgtddute
    ekkeejjeeuueevteetkefhveeutdetheekleethfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehfrhgvuggplhhonhhgsehfrghsthhmrghilh
    drfhhm
X-ME-Proxy: <xmx:MvhgZtgyVkHxM6Up4xg32tyw1PD0nLHmigj6FEnUPqkN1rM6FxHyZw>
    <xmx:MvhgZlB6xa4RrvKCUkFd_IyMcmzYDipaApgPxTR63ddFF3BWWTmtNQ>
    <xmx:MvhgZmKQn3jjwfyeDRBFmKFjvKv4rfjecd2a87JEUDhSiomQ95i8Xg>
    <xmx:MvhgZkAXnkDTPvDRMHKLBpEyxjCJyUTmh4dA2aBfClBUw5J_WsfZrg>
    <xmx:MvhgZg9OA_ZYahvfyG6EkPdzxnEGNotFT5wvRp8sdmaoPFxm5MiT9xIS>
Feedback-ID: i08fc41ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 19:43:45 -0400 (EDT)
Message-ID: <c2a02982-40a9-6629-05c2-c8de3335f35b@fastmail.fm>
Date: Wed, 5 Jun 2024 16:43:45 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: git fetch --prune fails with "fatal: bad object"
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
 git@vger.kernel.org
References: <16919-1717194882-875013@sneakemail.com>
 <xmqqplt1d0k0.fsf@gitster.g> <000501dab3b3$51779400$f466bc00$@nexbridge.com>
 <xmqqo78kbqwo.fsf@gitster.g>
 <20240604104437.GD1781455@coredump.intra.peff.net>
 <876fbb07-210e-128e-5289-57ab01761750@fastmail.fm>
 <20240605084718.GD2345232@coredump.intra.peff.net>
Content-Language: en-US
From: Fred Long <fred_long@fastmail.fm>
In-Reply-To: <20240605084718.GD2345232@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/2024 1:47 AM, Jeff King wrote:
>
> Your local refs should not point to missing objects, though. Each clone
> should maintain its own consistency. Are you using "git clone --shared"
> or another scheme involving alternates?
>
> -Peff
I use Google's "repo" script to manage Android repositories. The "repo" 
script runs "git repack -a -d", and I think that's what's removing the 
commits locally. Remotely, our bitbucket server removes commits that are 
no longer referenced.
