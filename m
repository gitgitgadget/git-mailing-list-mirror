Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE896451988
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138022; cv=none; b=QlRu8s/KDm2FTiShi44Yfqz33ZShCdLfaiJQZMDiYBX4AU2FM+K+yhkzNsv4GyvIGS5SA+DOvZ6ID/oFWgTqAqruNwTUuqJnShJjLQUGhCOjHcN6mOUvid3sNz5HYxIn/najYRVGeqaPcCTLgj9PHh/BZ76/d+0HdybCm3Xm6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138022; c=relaxed/simple;
	bh=4LnDDQxOBUCpmmgmjeWRiS1CeAwN/1MAalHF/UOzc2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3oxDnU5GhPTiNBIBm+TDC+2sylFZS/Vrz5sUDdV/FMJDQVU4eGW8N+TlVYzjLdReJnu8a+f9ooIRYU+93rI6w7Axb+Cw80evosRwssftiiXFFnZrioAl/JJ4yUJo+XBvXozYpXlPuLam0RdeRLMOssedXAJkxnyMb8yVBnEzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y7K0RAM9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Th3VgmaR; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y7K0RAM9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Th3VgmaR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7EFFA1D00111;
	Wed, 19 Aug 2026 07:13:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 19 Aug 2026 07:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787138019; x=1787224419; bh=hZh2/OkD0C
	WjAIRq1IJTyM/RJiZ8cN53ivWZAE8bZO8=; b=Y7K0RAM9+BPKSZp2owNWGoGSWk
	+gXkDhG7h/26rxRM6kxwZuGYPjCin22klxzaoCMXJEhSeaU96FeqFuthJSpKdVc+
	uQP6xX/bY0i2JW/HQS2yjSt1eb9t9artG6Ht+jxVVeENVsWEqu2wrg1Iaxkkeus2
	xtaBmGY7mO9x2xiy51Q7Aj/zNyFf0wKIFH8bLZXvOg6VYzOVdlsOkhl939TEMpjn
	AGKIXN2pwMy6ih7fh73nbZJGFS52bNiATtUd0ML75U4qngR+Afb6gNWINdqAflZG
	hmD0zFHHG31I+lh1iXF6+Lnq3rdrzPH1J90KYtw2t8+msbU43LVG6E9r28JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787138019; x=1787224419; bh=hZh2/OkD0CWjAIRq1IJTyM/RJiZ8cN53ivW
	ZAE8bZO8=; b=Th3VgmaRz6cUOSqs/ZWloY//x1b4gHH6p7rpyRuah4qsSMQelel
	j6QrN6lNYWMYxvJMFmroKCpPv9en+Q5ME2KoXqY4lKKLBS9zaSyTjwr4yP5OauSP
	XbXcFnTUPdp8VPVyK0ZHuXyVDxx2YuMPOXhQyinLo6pm9QkLTS5ba86l35uft8+t
	AcdPkDnmfIHXXK5RycUEqRNmmLscPSHy/4tQSvdlw/BU+nR5bQA2cL7TNFuYVrrt
	6IgGShiiSWbnC5NK6LZo2aTk+ZS4xy8zBI7fm4E5J8pHIecE+dgvyJRkVCtokOuy
	8rc1xTWVGacoPrXfXA+PiXbPq5hqynNhlAw==
X-ME-Sender: <xms:44-FanOmgxc6KhW-wLPM_OPHoFIKhDGaJ6H4tYMvhQ2idethxicTog>
    <xme:44-Fao0XypEucjhKv3fwqDjW4d3h6EPgFZzAxt0ghIV0ogpGEkuxksnASeRccaDTE
    LJZ6XYdiQCevj1I4ZQwfmKOvGYF6aEGW1PiKZxv3EcWaLImR_byaw>
X-ME-Received: <xmr:44-FaulHQ0MJxFsULQyWELRC9-QE7r9mhlN1qAqzUzJYmKvv08dIeM32LumrRzczz8LrblAdj4jjptm3v5C2TGOq9BsqTJnWp4nIArtj>
X-ME-Proxy-Cause: dmFkZTG0GEY6axZ+Wn4O6te2LRprKx+5AO1GpxasARdSbtSSbCuxSzf7eLahirAFwGnGh2
    lqan/ye8fHcr4XDzWztY2fPWUPgeWlCWKAB8/+JBdPnXRDyUxYHtbEx3/sozzPHgFGC6Lk
    ozMy9UecR1xlVpfnkDA+DS3hL8Alml0BXz/+BZ3ZnuCvaLF2quc/BTppB4muLg951W+3UD
    rstbVTzgggmjeignE7uQ/dAI5rdnFO+1Ypv8fqk8GRrvXvIqLtb9HU2YHDF426s3kK/5iH
    Yq1Fwt4NQigpR3pvZJcyKy1WIv56F2C6z0QIAjm4NwMifROWLF3rhjWMW3Hg9KyQ11O8dg
    UGyEtObZwLtzVtvf5WUbOlp6nMTQmukEApLDiOOpjwUWNYuAVswDkQq4b3SSod3TXF1BI0
    ULuKqw+eBvC2GHR2YS98icSwILKCNFaR4l7orplkE7vNX/P/354evtK5VPMGlsEjPjsQR4
    9XE8XbnZkNZhOZm4ehXEBzR8YvCMrV8YgEKoLrUZZb0pipXpbyh+A+OHzlPCfsj+dMe/IC
    8a+UaPJH+JqDT2NBYXFL5RIXEpLsYm+u2G71hiFD7pd9lia0sK9DRdRl3WcOwgJynLVlpu
    rg1zfyBjiOp0QjGrhLA2/Cf6pj9KvBqd0LpZsmCbkelsQoE1rN6tjkF5ZInA
X-ME-Proxy: <xmx:44-FanUervTTf3LAzGonwdTVob7xjbL1KLmG9qP_r75WNtfbCbqJag>
    <xmx:44-FasvScVwXf_ewjejDdROoRl6PT_XX6DeH--B1vgzTIpvrC1q38A>
    <xmx:44-FaiZ8-QBjOZpyeYhIE7-NMhjjJ-YGtJbb0lQPyprn9nlfMUODKw>
    <xmx:44-FajVIBU3zWMuiNTVAINz7mxp6gZ-ZTmjSHFFX5t5gvMEfcUyq1w>
    <xmx:44-FajNG7MDpY93NGiBmctxvsQlC2Qhs_PYwAMCIUCk_MVz1UJSuzIqF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 07:13:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 418058fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 11:13:37 +0000 (UTC)
Date: Wed, 19 Aug 2026 13:13:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 0/4] completion: add support for 'git history'
Message-ID: <aoWP3TYq5rNjUx7S@pks.im>
References: <20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org>
 <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>

On Thu, Aug 13, 2026 at 09:05:01PM +0200, Vincent Mailhol wrote:
> Changes in v3:
> 
>   - Ignore the split "<option> <value>" syntax for options that take
>     arguments. This simplifies revision detection and avoids hard-coding
>     option names.
>   - Test that options are not completed before a subcommand.

I'm happy with this version and I think it's a good base to build on
going forward. Thanks!

Patrick
