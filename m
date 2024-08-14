Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D83D20B0F
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 04:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608938; cv=none; b=lzoxxWPW13HWup/KKqVcw9g3LUxhKB2C6hQt+8uAIIGkEvKnVhtYcN9Y1p0+PtlxQCseb9gJJ3dQ27fDMAYwHFT79A97C/CnFn099gjBvW9xKrUkBcB8a6ESyv2HEJtkIFehSMCfv7Re/wKqXwx6Pvu0O3/+zsJ5CxOKuNohyTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608938; c=relaxed/simple;
	bh=WnuCwCBlB9q+Z++z5vPVO5trJXjPu5yRWuvZxPLfYxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mP1yhl6cOTHlY7FoaAB6NvEJsg2TVle1fsl73QqHnFg3SlDPjBcSrPEkMuKQnuHdpFAm6JWq97LbDZ7lzKyHOlJ5WsA5CuCou6/GbzCMjsSVjx1x9tW7gTjn6a//DudUIK02arYAqajXUnUBbt1mgkH5aFbFmEevE5bFDe6rXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P8ZQfxQ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AKr3xE9f; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P8ZQfxQ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AKr3xE9f"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 05A11138FD4B;
	Wed, 14 Aug 2024 00:15:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 14 Aug 2024 00:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723608934; x=1723695334; bh=4AGQXkoX2h
	p+SSV/2bIm8NRyv1B9LZw2ITwYerTA19A=; b=P8ZQfxQ++gzpo1Z5Hk4itgQq0O
	hmMSGPgiMoc3ZUjYjhskzZYOKGgICRY0j/ef4dJ+kUJZ30V2b2PG/wUSVfIMAT7Z
	yIYDXd9qaupH1oayjSBwz6hVkbRLKDW2+E1elQK7b62EKx7MrKCaxGlzdzYJ53UU
	HHrIh38rAn3P3kdwIRjD411fJFUFnAn5feKk0gIldc1e+bqlxq90RegU1AhAnppS
	n9XSVibx+gGmBR/y5XKhB3KEIY5HeABTRwqdzu2hM3J/LwDMhTQpM5reR5yv8Frz
	vPi3g0MNpn9nqXBMA8T52Fe8ve7vQd499HT4DXsJ0midpesubodF3BeyCwhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723608934; x=1723695334; bh=4AGQXkoX2hp+SSV/2bIm8NRyv1B9
	LZw2ITwYerTA19A=; b=AKr3xE9faQOPqUKJz2tDtZNYFg9OsOSRXmxYjBQP0HXZ
	7rvldSnFfluwZsJwT5rQ0aIAknSuoodS4vfbr3fLdRvOWaJsrOtfOIlYC/DF1+VO
	xwp4jckoXm9v1q6W9dHMku6QxHzjG4tTdPAN52XB+yrfgX8N/2rZrnpCPj2XgUxP
	x2h0VNMfQbWV1U8lkMfzT8lbYtlVhlrogBOVnJm1qZ3for7gHN3ot0xbIDwDDlWh
	V0/6LWBoYTTtVwC6a1x9lCEGcJ8YwNJ7FnCmCwc6lKDznTxuZYjWNnEA7isROTcW
	NS90XKgFYvUd71tsGeeteL3vmX2y4K87GfDDmNNzuA==
X-ME-Sender: <xms:ZS-8ZqPeJbLI3zwuQ_YYjIoXnhocr02hNDhLBzF9jsXDg2bdb6LPgg>
    <xme:ZS-8Zo9ZYMDMuN6dlzkG3u8bMNx_6XZ5TQdADh3JhpRAg1YceZcL9vRhjElEqUcAy
    QExlU_6vg34xUGMNw>
X-ME-Received: <xmr:ZS-8ZhT0sAIhGxEbpe0FJHz8ZFI6qRrZto6SmOt2fwnB2tRCx_RfBUcWpkKFzVLrQvD9qqJavwevpakDd2xnvoeKZ0LaZmYGO5aedE-ppWz_9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffke
    dujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguse
    guuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:ZS-8ZqtQ9b-w6TQTlq1UUg79Ks-otbRScvSclIcftGQ190Qafgukgw>
    <xmx:ZS-8Zie_1AV-gpWZhEiT8pnEVOCmR8lxlE_QdrVcmQZy5asGpwBikg>
    <xmx:ZS-8Zu0JLSp9jDreSprMrxwMpA399rAFhjT4ffq9xd38zliyLn3vuA>
    <xmx:ZS-8Zm-5MYvyJ-NSboBt6CSdsiYmCSHNjSFmlsrTsif_Gibc4Fmjbw>
    <xmx:ZS-8Zjrqk3kxe9v5GzDtJ-2by7d9vH3IctBGN0bVNv4aN0vOHdSf-c7K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 00:15:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f9f9a985 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 04:15:12 +0000 (UTC)
Date: Wed, 14 Aug 2024 06:15:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
Message-ID: <ZrwvWIhjZuFkRNgl@tanuki>
References: <cover.1723533091.git.ps@pks.im>
 <8d6cbae951177718b49d5cfbbeca2d5b0073e266.1723533091.git.ps@pks.im>
 <779795d2-eefd-4fac-b29f-9943f98bc83b@gmail.com>
 <ZrtKoVFci6cdvMS_@tanuki>
 <a02e21f1-b2a4-499a-b767-3426876d31be@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a02e21f1-b2a4-499a-b767-3426876d31be@gmail.com>

On Tue, Aug 13, 2024 at 02:19:20PM +0100, Phillip Wood wrote:
> On 13/08/2024 12:59, Patrick Steinhardt wrote:
> > On Tue, Aug 13, 2024 at 12:29:47PM +0100, Phillip Wood wrote:
> > > Hi Patrick
> > > 
> > > On 13/08/2024 08:18, Patrick Steinhardt wrote:
> > > > 
> > > > Fix this bug by asking git-gc(1) to not detach when it is being invoked
> > > > via git-maintenance(1). Instead, the latter command now respects a new
> > > > config "maintenance.autoDetach", the equivalent of "gc.autoDetach", and
> > > > detaches itself into the background if not told otherwise. This should
> > > > continue to behave the same for all users which use the git-gc(1) task,
> > > > only. For others though, it means that we now properly perform all tasks
> > > > in the background.
> > > 
> > > I fear that users who are running "git maintenance" from a scheduler such as
> > > cron are likely to be surprised by this change in behavior. At the very
> > > least "git maintenance" will no-longer return a meaningful exit code.
> > > Perhaps we could switch the logic to be opt in and pass "--detach" (or "-c
> > > maintenance.autoDetach=true") when running "git maintenance" automatically
> > > from "git rebase" etc.
> > 
> > It's actually the reverse: the old behaviour when run via a scheduler
> > was to detach by default, because git-gc(1) did.
> 
> Oh, I  misunderstood what this patch is changing. So despite being tagged
> builtin/maintenance and talking about "git maintenance" it does not actually
> touch builtin/maintenance.c or change its behavior. What it is actually
> doing is changing how other git commands run "git maintenance --auto" so
> that it is always run in the background unless the user configures
> maintenance.autoDetach=false. That sounds like a good change.
> 
> Thanks for clarifying

Yes. I should've probably prefixed this with "run-command:", not with
"builtin/maintenance".

Patrick
