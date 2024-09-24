Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293C84A51
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 07:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162425; cv=none; b=SoUAXWPT+L6qpN+dqs4YfYvXFImxVBNrjk991H0j7Gb/QMois6ThdpNOtUbU6fe/BmQahHkAjFhkdDcvbB95Bpn+5gw1gstzVkt/tSQY1mfPBcl6oUM25iU+EMrMme4LOLy8sKETYuC0gtiBrRohAWg5Rxp4hU8bDl/0z0a4tqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162425; c=relaxed/simple;
	bh=aLXmqdJZv4m9cKwFhptuDq2c+E/fTdM9nXWPD99noT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtsY+kQBYWICxvGEKfaP2njyCnGqesyaiouzZHddP2LF8OOiFEckIa6yB2zQZIM4axH6yJGXA7s7i4yNM1Itk7kqzLzFz+Gxkj8bFHBvAn0u51lQdcFec+eUHHV6mAxWh2XEA2+Nk+Ccf0thkgXUBBNy19tCYll0gjOAXYMGp3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CHxuumFT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XIxVpqWv; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CHxuumFT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XIxVpqWv"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 535EC1140338;
	Tue, 24 Sep 2024 03:20:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 24 Sep 2024 03:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727162419; x=1727248819; bh=U5Er9ufbBS
	FmfaAMRKclxLgKPXGL5yVSKPdCqnzgCMg=; b=CHxuumFTs37Vxa0hCWm8ACcQJx
	JhTXNqYHBrypJ13rmZyl5UemaS3d4bq3VbqTmnxtSRoRMYKkMZ0tpucxoYg0QFMz
	uAwJGd8pDEkHFqhn6D0pQJL0ISnn4Z9eLeHSX+v5be6YSPZBMYyFadoliS89/+Jx
	3HnhvKTeYTY6evrbRr+c2u8nuRJ0D1d2WO2tKWsdWG76vx3/rac4sPLIWLGA0k7O
	XssZDh23uCJ0D4UCYOe3o4HzeJEUOyj2ec4dBDv4a6EMk5FJlrckIhN4i1oaAPML
	6w1LEplc+UHZQkufl/4ntRidWAiG457Gd0iIgc6epPWDzb94xYQZ2HiLOrMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727162419; x=1727248819; bh=U5Er9ufbBSFmfaAMRKclxLgKPXGL
	5yVSKPdCqnzgCMg=; b=XIxVpqWvrxzeobt7WUZeLNAdm8CbdGHhVdnMhw3HGaAc
	K1tG+LgZBHluxHTAZlgLgA2SyFnIujGR3CLlQjjPzqMCkq0HYpt2JTAb9BLKCat7
	uGs6CVjBvnIO8MFowkI+Ya8BXhvLBsjtdVC8bPSTvCVa4PO8NgkZ0VlgjtmNMydV
	/P9QmkcWlfitY7enKcKQVLiPZotrz7GjVHVf8bQh18mER0wspJMqg0cnz1DK46uv
	stMjS3cR42053d4XcAqYSFTRLLjU0SaID5VG9uAVkIQk19q8+UpsgX/RUH+QGhcY
	HsZ8S/aYpJsrZclv+oyVjpDuDsIYPjFntDMDTuaBlA==
X-ME-Sender: <xms:M2jyZgEbHPTKF-aU3tDgl5fLgPVJQ55OVkKYcCQyzH49Sir7OfrOPQ>
    <xme:M2jyZpWBHDvaz3_4BGBrtA_KHaZa7iYd7685tOhhpIzsQ1UwQ2NGfS6V4_BGedBmJ
    92fn2LN_jpdPS9gyw>
X-ME-Received: <xmr:M2jyZqJiS2pU2Ppn_WOE-eCIEKgOkroYlyf_kt7Az0rbTdKqlI-ac1q-T8K76z-wmcMODY-tPjk2KltCbPLLHcsxaI-RcapDeWHE1O-R7cDpEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:M2jyZiH38aqMhu5bxvP9xXamJz7ZjRr4aYswQihHvSp_KKTp-aPlSg>
    <xmx:M2jyZmWjvdmGnPexf58-SOCd_O8B_b9bN_mIEntkfbNLs_LxmWFfrA>
    <xmx:M2jyZlPsjc6TGLBCPxF47nDXN2Ywb0BmrWoiqebnrqJt4yqe94jLvA>
    <xmx:M2jyZt3C4b0k3ntXpkpo8aFyWUP_gMMMJ5o4UX92v7V9qr0iGFw8MQ>
    <xmx:M2jyZjjYUe_i5r_fJPAPhdjduKJoC7Kz_fSNrsQx5OJv30dMciu4qnR8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 03:20:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0e74d533 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 07:19:43 +0000 (UTC)
Date: Tue, 24 Sep 2024 09:20:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/23] Memory leak fixes (pt.7)
Message-ID: <ZvJoJ7dbqmhoVdS9@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <xmqqwmj779u9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmj779u9.fsf@gitster.g>

On Thu, Sep 19, 2024 at 11:54:38AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The patch series is built on top of ed155187b4 (Sync with Git 2.46.1,
> > 2024-09-13) with ps/leakfixes-part-6 at 46f6ca2a68 (builtin/repack: fix
> > leaking keep-pack list, 2024-09-05) merged into it.
> 
> I haven't said this, but I really appreciate contributors (like you)
> pacing their series submission perfectly with the rate of related
> topics in flight solidifying.  If people hold off sending new and
> dependent topics for too long, that would waste available review and
> testing bandwidth, but if people send them while the other topics
> that they depend on are not yet in a good shape, it would require
> conflict resolutions that may get wasted when the depended topics
> have to be updated.
> 
> I've been trying to be more explicit in the "What's cooking" report
> what my evaluation of each topic's "doneness" is, to help contributors
> who need to send new topics that may conflict with the topics that
> are already cooking, and I hope it helped in your (and other
> contributors') pacing their submissions to help the process run more
> smoothly.

This series of patch series was something where I wasn't immediately
sure for how well-received it will be. In order to make progress and not
be busy with memory leak fixes for the next couple years I had to keep a
steady pace that wasn't too slow. But sending out a 20-patch series
every other week could feel overwhelming to some folks.

So I'm happy to hear that this is well-received overall. Thanks, and
also thanks for your reviews!

Patrick
