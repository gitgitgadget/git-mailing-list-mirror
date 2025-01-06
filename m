Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C011DC99E
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736161912; cv=none; b=KWMRoou+QvC/buIpFIVa4uxxfmsPiHGQ2qN4awx2n1I4YVEp0DfSTk8xLG9pcG19JrqZcFVHdG48v3MhhhdWDt1FVyuO6JWNDMoN1YSZsQNPsSlnG2vU479MdVKZDSrJuhZHArGejY8lYEKrGSh+vF7elb/pqXU/oMBumgqqTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736161912; c=relaxed/simple;
	bh=NlBmHKk50G4N0IuvczopiMKOslPaV+Zbh+onnJ5GXIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B32W/MY45tDpnedIwuY6wE8rTgnLRLtIJUyqiIMBMbcwq/jnZ7f2FwbOSRDMy/uT9mdDu/iRgQ7Jsg9j1yod2GK1KpkCGFhFmo66fALk9rdbo1oRwtU9yHlU6gtJpiA8evZtIfs0kxMgiRH4J7Tu0tFRg2YWilF+L5wvI9TpcNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p3gLxb4B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nanUfLIC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p3gLxb4B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nanUfLIC"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BA4213800ED;
	Mon,  6 Jan 2025 06:11:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jan 2025 06:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736161909; x=1736248309; bh=jHRVbjblOY
	VlkeadjeKd3o1B6fu+7qO+0Lhaw3xlmTQ=; b=p3gLxb4BfC9+AIzyGudgQQ4q7J
	nU5SMe2n8AY3hQPIlrJ0uLH4Zi7i82F8gSNz53TiwozjJToiFe2Pc6uxTXWObPou
	ycBF0+izNG7nBlfUCgvepdsS4VWpIPxae17urROAEnDy7HzSyIN9KwJQCTrBFdwS
	t728U7MYbg1wv+uCTDM/OK+jLrkpSosxcrp3IiRSXXhnty1ywCk4Tke3zXLfp20g
	hkCGNYgrXXAEbQGSfORitmvqRvK/CAVu5LPcNMxXLW20UIx5+dfPsW1RGzz6UkXr
	fMp/Fgyg0R3z4T6aP9iwTgToyWq/mvf7OgqImpwNyfMu0JdW6p60zjtbITqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736161909; x=1736248309; bh=jHRVbjblOYVlkeadjeKd3o1B6fu+7qO+0Lh
	aw3xlmTQ=; b=nanUfLIC30BoopJ9RzoG/Vq3MgBhw9ytDp14j9rXrFt6KC1zHtu
	E0yGsqojTkywGchcXM7Foaa4lw5omniD1F0lKEQ3ydd1P0qyGLLUHuI5u1FResQd
	vTn94PgjEGoGMmfJmeymWKDwU5KwFyAFUFGl1FEUDm9NyqGkPLuqBMgKq4601XVB
	wGyJJdaqxSdBx6bE13seAvZD4HvNV4lzfsHjn1lYs9s4WCFInDDG/LxHJbnT1C2l
	TcQi2b1vg8f3HJhsSKYduAZVu8E0BPGNSLnwziYrRpUFNP3GkTifDTcd3BLs4Imo
	FvWx70dIMGEFrgTJOjBfK0pFO5XWNjP0myQ==
X-ME-Sender: <xms:dbp7Z8AWvCb5cEn-eu5trj629LyIMqR1ukP5rg9UKuynPDJdqPFH9Q>
    <xme:dbp7Z-hLfDs7-19_i_9MMRcUSSQhZFaLhu88cE6qhysdFW9wJuNd7tKjgxsR8zaNK
    t7cuXt3ESAAXwOdsQ>
X-ME-Received: <xmr:dbp7Z_kZXyE9qHIgRlwdqh_X9f_ltuHlxOL9DrVemHQMKg8Q4UxI2yHummqdHnWqJAX8A7HtqkNPb4topdjHY2GPRZlSWSiiajYAoJvy0OnczA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:dbp7ZywxQ8vjK6fcL2B3ZujiklAGtF2h-8uEye9V5-zzvtoZHnZufQ>
    <xmx:dbp7ZxQ8naK4QNvfAVEVHYcS-dzmKQPmoNovi_Yth4M9wCUdCBNdZw>
    <xmx:dbp7Z9YoQ7xXPTbZ6cOFifUCJXyWLeJ4AxQiu-UfOl5qwDhvEzLb7Q>
    <xmx:dbp7Z6Q4LivMqRTJTV2eRfpycu9Ic7K-evCOKMpP2zude_fVgeXGzA>
    <xmx:dbp7ZzeTm7GRcCQ78htq7svBqx1RgbKm3Ax9LQgUVz2-I446fcUG-xYJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:11:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f33075d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:11:48 +0000 (UTC)
Date: Mon, 6 Jan 2025 12:11:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] object-file: retry linking file into place when
 occluding file vanishes
Message-ID: <Z3u6c1UVQyZuHLdk@pks.im>
References: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
 <20250103-b4-pks-object-file-racy-collision-check-v1-2-6ef9e2da1f87@pks.im>
 <20250103194058.GE3208749@coredump.intra.peff.net>
 <20250103195942.GA3212696@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103195942.GA3212696@coredump.intra.peff.net>

On Fri, Jan 03, 2025 at 02:59:42PM -0500, Jeff King wrote:
> On Fri, Jan 03, 2025 at 02:40:58PM -0500, Jeff King wrote:
> 
> > I suspect there's a way to write this as a loop that would be more
> > structured, but it would be a bigger refactor. Bonus points if it also
> > get rid of the try_rename goto, too. ;)
> > 
> > I'm OK punting on that, though.
> 
> For fun, here's a version without any goto's in it, that should behave
> the same. But it would be very easy to miss a case. So I don't know if
> it is worth the regression risk, and I don't blame you if you delete
> this message without looking carefully. ;)
> 
> Diff is kind of hard to read, so you may want to apply (on top of your
> patches) and just look at the post-image.

Thanks. For now though I think I prefer to go with the simpler diff that
uses goto, as it feels less risky close to v2.48. We can still refactor
this in the next release cycle.

Patrick
