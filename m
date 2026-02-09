Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD042EC559
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625983; cv=none; b=gXynuut3MS5WLVJgZWc2b7AmSHk40xcW1w+2HJjTyjUeo8Vl3IFkBlw8cKJvKEiex3XPArA+FWHgJeoxG4tbThT3rPEKYU/vIhJP4STNR/q3MD/RGX842+YBl7BgL5Yhmt46vFDxUvScaRbv7RitcTblaqNXG1C+IcHy+HI/vk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625983; c=relaxed/simple;
	bh=ludTtqKN+GKmvOEO/wJnyIQdMCVttbx3+nhuJbWjBCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pas8xovYZZUyf/ROI/sVO4jHx/NdqOxY6kfxZNk1S72O7IsdLIA5+tPMPBZ2mhOl7DnGGZ48WAbGGHCfI1wVbgI+rXPQdfVSbfNdSQqoG3wvm35nEjwig5BJIRYkMHNUM1Qi4PsIsMrtBvvc7GoIb3VOq7HZu0q9PbjlSFhlQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XWem9ASx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ia9U+h2/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XWem9ASx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ia9U+h2/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E04B7A0158;
	Mon,  9 Feb 2026 03:33:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 09 Feb 2026 03:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770625982; x=1770712382; bh=Q19nZEyaPB
	bQ2TtAxv3k68oj6Ixl3Vrdc6NqLv1WVCc=; b=XWem9ASxGQOyXWD1tV5/T2GV5H
	NqH1AJ0fvW/jMjWeEgakLh6g/0sjhXTN+6pxZVsRkVv6efSEYg8Qo3ShoMAq7HZz
	jVPZIwtPU5U0M2tBD8b61YGJRov5pANZDnk5vkOAwPD6AFBiau4zd3H3csefi047
	0O9JdRDZ5eG+XLbrO3yVRocq8mrzgKCxHEUaQrYOv1Ip1kCXXHADDd9cDQPtmj46
	8LnJY06BaVNTgFNR242zhO6Ka4Q5LV3J1TlwxVcJtOON+QQtczt659MyWrPS7R0M
	9ptQx8lfN2f6J63R6eRxvie65jFL/Bkg4uf902nhqpoBWW7vQE4A6DTGPYhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770625982; x=1770712382; bh=Q19nZEyaPBbQ2TtAxv3k68oj6Ixl3Vrdc6N
	qLv1WVCc=; b=Ia9U+h2/PMspJelRBCXtX4vFyTiRxEIn4mAOGHkKjWH0gCmQqlF
	ydRE0SljV7a6y7Vs0olsCaEuayjnDVLG2+wZRXA3B/0GpAmOxniSddR//nuQSlYu
	qTxyaZU/5YnAdEk5R6vFFTU5lQnG7SzgfJWHaX99uBm3LBEIr55D0jk645I802yK
	dvM6ucSga+5XaSmG6cU0QXMsYYyr1S7r9lE3r1KUGWmsajcwiRNrsBadcB8KSTYq
	JVoMZ8hComBE7KNrnvGyvjK2pToUE1lCNZIyUQVI8FTASrhe350G2y8RMzpXDoSO
	jXk1C/kg547tlNezJCTFCMmZXGTmTqURN9Q==
X-ME-Sender: <xms:vZuJaaBfZAWO1QQx9VLYn7M8G2EbJVZfMOaQXSwEh-XsG4DSjcVuJg>
    <xme:vZuJabg3VcTAAR7MeG6BVttZVdHTVxQSpuPjhvhbi1za26KxgyNBIllMezfI2bymP
    57OS3BL3cHH6bTtZ1xCABGIulMi_meXop94v0DaUal9xaNOW-fpHPA>
X-ME-Received: <xmr:vZuJaSkX4oMMOXuAyzh-bkx8awPXmv3hWD0IV9FafPJvoVazEuHNqgzZkzf3N6tw7JpzoevumLsprFkFuovuaO2r7sU57qpOL6MGVOYi2_U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vZuJaXrA_ggjlQwyYxX2LW0J3gRaFlyX8qJPBoUK6eLQC7jo983MRA>
    <xmx:vZuJabHFHp_9e0LusTIdaOlCR8UH3YhxfCUZAdpDp7tu1TsKGJHF4w>
    <xmx:vZuJaTyAeXEjng7tIHRpP8gI8Ll8scD7tPpwsIPoht-x265EdxJNUw>
    <xmx:vZuJaQqVLEF2CQAvFL8GD6Ux8nwTWqM4rod4UvpJqGfqlynrim0i9Q>
    <xmx:vpuJafFQ-yxYQXg-iLOETyvynJAVbrFbH1PcPJSxjjP6MvtgIH9BqOFX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 03:33:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f9e1cb5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 08:32:59 +0000 (UTC)
Date: Mon, 9 Feb 2026 09:32:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] meson: wire up gitk and git-gui
Message-ID: <aYmbuLXiyGthSE0u@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
 <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
 <20260205093748.GA2177239@coredump.intra.peff.net>
 <aYSFGG7lCg6Sw8vy@pks.im>
 <aYYLLI2Gb7YlBtKt@pks.im>
 <xmqqms1lcy0i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms1lcy0i.fsf@gitster.g>

On Fri, Feb 06, 2026 at 02:23:09PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The fix has been merged upstream. I've created [1] to verify that the CI
> > now succeeds.
> >
> > Junio, I'm not really sure how to proceed here, as I cannot send the
> > subtree merge via mail to the best of my knowledge. Shall I instead send
> > a new version that just includes the upstream commit, or will you handle
> > the update?
> 
> Whenever j6t says his tree is ready, I'll pull from him to get the
> update.  This "wire up" patch does not need any changes, right?  If
> so, things will start working when I pull from j6t.

Yeah, exactly. Thanks!

Patrick
