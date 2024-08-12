Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAFA17C7B2
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470095; cv=none; b=kYRkP2aqdhO4Zvl4wlbs8hubN10ljHm0MbxUix8TrbOMMUbfTACl5Ef2it/niVyMFwi4GIqIEXjfjC3mrTPU8XlT0bW6t+P9oeEND43a0+fUzx4nNfmYpNDXdITvd4YNB+i2rcbQIZ+YdFvs/yqEy97pNVAjmiTCx2PO/SXLEGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470095; c=relaxed/simple;
	bh=L0xnSNGpg7PjdSjXtdUB9YLV4jwGAkaMKHRZOOvIChI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ic+rtg1H5jJcRGF6WFCvit7o6oaPc5EDeVqkr5RjSpEJW+gsaCwij3pUOF5ncvEPTdzosT1HgvIsjh+6ZL1lUd/yIFZ+lAjp/C3iYR+OXk7+4+DDNFjFpDwwJ8BVHlf0wApH/ZY+8MoHWUchCIeiFWtg7G+EiOR/dDUHgxQBNt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nqwCiQKN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DRdubEyb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nqwCiQKN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DRdubEyb"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 67807114AB62;
	Mon, 12 Aug 2024 09:41:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 12 Aug 2024 09:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723470091;
	 x=1723556491; bh=JgawX+qjusRMsShcKkrTMQr6u1nVUEvSHHSJAGlBpwg=; b=
	nqwCiQKN07sWmeh90hwrx4qESf3FHV99UOmItmqVp1IUDKVfwn/KT3xTlIZhBf/Y
	MV9Nw4FcGZoot6GZdG4b094xxIG+qdOUfZ/vdKdQnkynkvMcp/SXGdzXHLYF3JFS
	ouBHwgo9ulKbVb6Llpv7k8OPoTyHQAKpHpDD03sD4wTJd6CyJIDOTnzAxFdNM/TH
	IKi9sZfX+yt79POpmqrOhS1it/rz74/1PLxuq9wgktkBPJm2hc4lMXLMffIsjykV
	VKwpdQP7tgC5JQcNgR+K8h0jzVE1Iye/XcTUJQInhkKie7QF6an9nGutLQnsRboe
	Ucd7m+gTLjIzyZhsbn1i8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723470091; x=
	1723556491; bh=JgawX+qjusRMsShcKkrTMQr6u1nVUEvSHHSJAGlBpwg=; b=D
	RdubEybTD2mj9uZkvOnbSFVTmqOe9u1ONCu+D8yZb+6qgWl55mf4elDnCcL3jN5H
	eKJgMw8uILwL2iwXXpMoB2Tb54mqnGWJ8er7sAP7238qkzNqR95yax/o6y3aY9yz
	AE5FamDD0fWE61N7qsNsE6jQMD4xM8aINEFQ0XKbPRBPgOO1E4yaEEm5Qjo8p66I
	Wv3zVH+Boa0/c3oRfO9PcQ3vJfDC3qOAEZaSPtRtBgIEJDUOu/oXale9WHQpNTuS
	Y1O38h/iWDJ23D6X4PFC6+ZeDE8dYyFGklWJkpBTMM0qiEfcOo4bWL5mI8lNKM+D
	5syriBB+SvahrDdyHtt8g==
X-ME-Sender: <xms:CxG6ZqJxHlx_VkjNWApW9Nc9i2gFjyNPGoOAKKs4yv4X_BonRY1tvg>
    <xme:CxG6ZiIKXBhdv9uqsysYltmBrlb6d7VBMRS8vwnytr5qLuXQ_qJ3Oyo6Tox1KI0x-
    cIZ52HiIxbfNnmHMg>
X-ME-Received: <xmr:CxG6Zqs0A9sBDm3UE2YMvcC1FqHq4DFns7RiA5dKXe8cznIdPgfJFRz-hUQdOF82fiJGu5j03W4SKEnOywQtGnKzgbOmSs3HAREBZLIoDbwNkAE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegrsgguohgsnhhgrgguse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:CxG6ZvZ6Nj6RpERR98ct3PF-a3SbN8bWN27QUeTz69rmjtbqoPzMmA>
    <xmx:CxG6ZhYjt1rsi-fnyqZkwoMK6Dds-F2M_XvPmwADr8TGauoPWESE_w>
    <xmx:CxG6ZrBQrhYu7uXYnLzSNDRKDUE5UN-SQdfyNiKLpa5x3LDaXYDBEQ>
    <xmx:CxG6ZnYMlLmsZdWx7JSwPJPe0C7UsaHV9L1Fr6KmEUs2gqGhTuYDAw>
    <xmx:CxG6ZlEcrg_0JffiZtDPTkBlrdUbpinbVF-uxii2d43w79TwjhW3Tnyc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 09:41:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dc55d695 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Aug 2024 13:41:13 +0000 (UTC)
Date: Mon, 12 Aug 2024 15:41:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [Newcomer] Introducing =?utf-8?Q?mysel?=
 =?utf-8?Q?f_and_expressing_interest_in_`Implement_support_for_reftables_?=
 =?utf-8?B?aW4g4oCcZHVtYuKAnQ==?= HTTP transport` project
Message-ID: <ZroQ8-7SUmli2SOC@tanuki>
References: <31efb040-57cd-46a7-80f1-62a9ce9efb52@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31efb040-57cd-46a7-80f1-62a9ce9efb52@gmail.com>

On Sat, Aug 10, 2024 at 11:11:30PM +0300, AbdAlRahman Gad wrote:
> Hi,
> 
> My name is AbdAlRahman, I'm a senior computer science student.
> I'm interested in working on the `Implement support for reftables in “dumb”
> HTTP transport` project with the help of a mentor, I'm aware that the
> project is not being worked on in GSOC but I was wondering if the project is
> still not taken in general, and whether I can work on it outside of GSOC?

The project wasn't picked up by any of the students, so it certainly is
fair game to be implemented for any interested party. But...

> If the project is not taken, what should I do next?
> 
> I'm also aware that the mentors are busy with GSOC and might not have time
> now.
> I'm OK with starting whenever mentors are available, but hopefully, guide me
> on what to do until then.

... that being said, I probably do not have the capacity to mentor you
on it until the next GSoC. So you would ultimately have to figure out
most of the parts yourself, unless you are willing to wait until next
year's GSoC (or somebody else wants to mentor).

Of course, you are free to send specific questions to the Git mailing
list, and we try to do our best to answer such questions and help folks
get their work landed. But the interaction would likely be way more
limited compared to how mentoring looks like during the GSoC.

> Steps I've taken so far:
> 
> For git:
> 
> I worked on one of the micro-projects, modernizing a test script, The patch
> series is now merged in the `next` branch, there are still a few
> modernizations left in the file which I will work on after the first series
> is merged.
> 
> This taught me git contribution workflow and to expect to do multiple
> iterations of the patch.

This is a good first step indeed.

> For the project:
> 
> I've read the resources provided in the project description for GSOC [1] in
> addition to a video [2] and an article [3] by one of the possible mentors.
> 
> This gave me a high-level overview of the ref-table backend.

I'd point you into the direction of git-update-server-info(1). It
updates auxiliary info for the dumb transport helper for the object
and ref databases such that plain HTTP clients can figure out which
files they need to fetch.

The realization to have is that this is not required for the reftable
backend anymore because the information is already encoded as part of
the "tables.list" file. You will have to think about how to figure out
the ref storage format of a remote and then fetch the correct set of
files.

So understanding that code as well as how the dumb HTTP transport is
working will be the most important first steps.

Patrick
