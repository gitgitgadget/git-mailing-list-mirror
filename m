Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E51DF26B
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415769; cv=none; b=MulxDeq62aYjS5BDHBkNJKUcZYGBUS5OyRZo4SkDEIfj5qI5ACeOHeKcSAUuUC8dSv9dcxtQ9Wr4w49VjZh2hoIq0m4MMUEzbIqHHZq175g3B8fT6Vp1iz92xni+BYhfpmkP57GxA2ztL6S5c/rK+do8WYgX397/VihrmuESzJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415769; c=relaxed/simple;
	bh=6edDikIpB+sxg7t3Fe27P9Et/WbIcz0goKofthxzHs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRVOnj+9BwK/3dMCmuUX+X5n0xCsOKEhJXJMhTjECKy0LAE/7MfxCA8Plw/4zKXvzpKtIO6YNiccm0Dj8lkQKJpjs8XyuqfLMgzAdUTVffPhyxTDRKaRgmoj3uj3e0HLnmU7rxvxhuseZkN9mk40w36Nbbb4/FHMu0FAEm1nrXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AR3gRuPG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=crAgZ+Dk; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AR3gRuPG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="crAgZ+Dk"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 940EB2540169;
	Wed, 28 May 2025 03:02:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 28 May 2025 03:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748415766; x=1748502166; bh=k3eO2U9C+V
	PfAklfTHw82y9TXkWJiXi1cHqwXY2AN/Y=; b=AR3gRuPG4yTKEBFJpcjZO3ENCl
	F8XzU2i4HUUHzsQuOmT/w5yMGbbGNptRh1VT+wbeFQQw23Q8huJv2UY/1fikOa7n
	vZ6Um1BqiH2AXJWtswcnw6Mnw5ZscKpkiz5JQo1y1HakykzUSPTNVE+y3ZTYv0Vx
	y9t2PmWzeDZAcO3ssGnjdnq9lT32MXslivTW10MCGgE48cZu6xDZklY4A1hYOvWV
	Vzy/tdBnxUkMzPV+CCMobvWMQIZEWgInCPEOE/MpSf1w5idmclcB/04lavlYkOd6
	X/yXpiZ+KHOClXWt9tZ3iN27VDBILPvjTHQCrQ5iBnROVOYlCj35j3oJdFng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748415766; x=1748502166; bh=k3eO2U9C+VPfAklfTHw82y9TXkWJiXi1cHq
	wXY2AN/Y=; b=crAgZ+DkBKKMADXgS/s8pSxPNQBxJ1f5y75CXpadpnQQjFhXnjD
	i27RkjQyoy2Nz2EV88pY5dXDDC4gvOcI04dLDjjQwASBNet1aGzEuMII6r0Y0Irl
	8hfox3tbXByHwR6dnuxRpl0ly2crtxPRXqKfO4Wg1zhtTC6pNdctQnhjpydY+jqH
	vIWQhCWIkd7ya19Kjxo57jMHy3KqlHDm6vdwv5Y076OTzjaJGQFJumEIub+tU5i/
	8KRP0kfWrguG3kCg/2qaOPpOp2zuPd6r3GLBOr+1Trj4DsyGacw2NSGE0SqQ7FSP
	vLnd4Stcy+xQJRhqb5a6VUVSKlhp69rb5NQ==
X-ME-Sender: <xms:FrU2aAkA8mi4oghpFc3ReGOsM_pbaXqxOTECVv1o_K_i-HQRfMFw4Q>
    <xme:FrU2aP01VDnd4d5ZYI_gUSmGUpWDolwIjROU9olju9rFG7BUUFgqxrlMCxvh4xKRH
    ti28_MKo4NvE-Xenw>
X-ME-Received: <xmr:FrU2aOqi-DOu6qtY1MCvqbDHHxPRJDwWD0h05TCN4hpoizSjgqdRb7YkDM-jOVkZBAnsa-XpZuZtXYsTchANUI-2d7iTxnne2EKvStMrG-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdeiudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrh
    grmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepuggrshhrrghflees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtohhm
X-ME-Proxy: <xmx:FrU2aMkF1-NclMug3z-9GbiKl4cXrLCUa0u0Zs9cxdP9mfSrXcGFig>
    <xmx:FrU2aO3QTxGWyCP6hugpXhHkM0yae801CrvFYDLHBVCLqKEEKjGfWA>
    <xmx:FrU2aDt_E7YLDTXlDxoDnrr2L14GGRQTSaR53wxt0i28CVOLmdaN2g>
    <xmx:FrU2aKW_nfHrI6a57_u0iCut2uOpUgBV44SvDhTkDTgj3Wf7HhsvOA>
    <xmx:FrU2aBbwVK1yuRwnCZJtecenDOI8YRYyeWLmpTiv3Ffxrpm4SG1rJUMQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 03:02:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cfa5ab6b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 28 May 2025 07:02:44 +0000 (UTC)
Date: Wed, 28 May 2025 09:02:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
	david asraf <dasraf9@gmail.com>
Subject: Re: [PATCH 04/11] builtin/maintenance: mark "--task=" and
 "--schedule=" as incompatible
Message-ID: <aDa1E8aWHmy22TRi@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
 <20250527-b4-pks-maintenance-ref-lock-race-v1-4-e1ceb2dea66e@pks.im>
 <3f6863f8-7fb9-4516-a36b-f55243794dd0@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f6863f8-7fb9-4516-a36b-f55243794dd0@ramsayjones.plus.com>

On Tue, May 27, 2025 at 05:43:23PM +0100, Ramsay Jones wrote:
> On 27/05/2025 15:04, Patrick Steinhardt wrote:
> > The "--task=" option explicitly allows the user to say which maintenance
> > tasks should be run, whereas "--schedule=" only respects the maintenance
> > strategy configured for a specific repository. As such, it is sensible
> 
> s/is sensible/is not sensible/ ?

Oh, obviously, yeah. Thanks!

Patrick
