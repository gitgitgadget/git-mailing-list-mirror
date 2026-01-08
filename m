Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67C145B3F
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854027; cv=none; b=ge5AmdN6hmtE9vXhzl2WvjpP/RaznpbgidvDv9/pFWSZbmvXFtjLs0Cj0U7luZ0zfVDVsvKVGm0u6w8IdmxIyB/gYIRfv8yBRUAYTNkBwMyfJ8EtupNSp344dXfyinc7l+uxrxfkkiKEF1IIRSVT5w9Kb/g8qPkXl6n4cvUUg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854027; c=relaxed/simple;
	bh=zvwJvnx4ls6B0s8NvgrdGBK//1ePVRyiALFLbMLY70s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9kBWkO473HdHyxO1+C/ORy6UoFXvF/P14KgdiUWGd4PeO8og1Qk1jFz1xjB86m77bu9mkvfHLjNehp9kd6c5KvBDsPMcsbxTw9I/eFbpeOf/8VdtaKbbCSw9Uk/QjqjVQMstZAunHMHUHXPU5ERSYMH1ZlU9UqoYVTQP68ZgEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qo9WW5FJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wyy5wGS1; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qo9WW5FJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wyy5wGS1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8434E7A00E5;
	Thu,  8 Jan 2026 01:33:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 08 Jan 2026 01:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767854024;
	 x=1767940424; bh=ThP+2M/BJ6XaF2r9cjXqwuAl+H02colI010wOS1NMrI=; b=
	Qo9WW5FJyKGlCBDvg2A+pTxx64F5Tos/AEY79Xc6LeiE6/YQjibqXkf5lq3REDvA
	CxBB3/J6sh27vxGB0TH9bG8NZHQQqMC+9DfCbXYxETaNRXQJpcdSo3JDch8/ZEzz
	m7FZ5oufPRGfrwELRgoW+43EUQkKBZ+aZDuVW6IrlqalmcJZioLY79e84q1tz2IG
	GYlyxG7XljMo7wviiGBKY+Qb48ncoVbEs4NOF7wGfO8qFG3Ux9qXg4/RPK9YltQX
	jOq1kbi2QSIQpevBzsuLex1GGWiMeZH5KVKTCXjcDBTLjU+LIBGKdLU/5ech3agb
	MWCqo4c1j5q3DKJzj9f0aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767854024; x=
	1767940424; bh=ThP+2M/BJ6XaF2r9cjXqwuAl+H02colI010wOS1NMrI=; b=W
	yy5wGS1NLutaadBUcRP6+vrdIeY+TfPPOuXpwsklN6vdOXMfv1mQAfg6124vrQF4
	xH6KR5WAvOypV1XlMjSaADtm4XXxZDT9UOw9CqzrdDVB6nGQ7H+GxgPGmC2dGhkV
	pxuHrxKSEEUMVSGwlWlTyh34YB0+wo7My07U7pKH1suiu8rYV/TRoZOWsJvNAKeZ
	eQzWGiLOYUAsZAhzuYVlHJO0gQwZQjSR4XLAPyOcUnqJiKlkEzpP22EzfblGkNUU
	2RYS42GEfl+G34IM8GY/NferHHy7twFz3I1g59Z7QwT14vlCD5X3AoLkwIbq9ye6
	ws6Ootb1edWtAfJFIPRag==
X-ME-Sender: <xms:yE9faT9K0DYL5_ko98zbNkjfSuU28SwoPcv-bE8jFsluI3SnkUbBlw>
    <xme:yE9faWv3pvB6mjreefYT1F12MAhkVyEYvXgsZRaf1QNL1gqR7KqWBUzh2j-OkksgH
    9tfabfbwuQgMLih17-7pcoZ0Y94XHVzKroxrRgw6IINLMI54iUI8g>
X-ME-Received: <xmr:yE9faWCI78evdIOGbyexshfrZBpLLfxvUODizWg-hnMiixdkLcR6LSPTDsSVT4Jc22xZIZ2glAfr4hQBeSHmUxpJyIVv8gep5BLLC7gFmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedugfeuieejgefghfejjeekkedvteefieefudeukeeuuedtledtkeevtdfhueehvden
    ucffohhmrghinhepudejrdhsohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmfhhitghksehnvhhiughirgdrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yE9faeVeIyc3JmPivIc2_bcWZUIvHt_sLVKz-9QSg4Xqx6yBWKbXUg>
    <xmx:yE9faUBbri--8jbY7BZG4u5cOZY32eVBOFEst83hd_eQN5d9UQzgzA>
    <xmx:yE9faR-ozuDxbdK9XBGoCNdZP1ZSfqeYhVfCmkjQN5wWxeQFolkKOA>
    <xmx:yE9fabGCiMl8NgGoCBTtETYAzDlMFTy2IU7xOZTZt3PAIQsREopduQ>
    <xmx:yE9faa_0f9HVIR4DH0EPU--ofzEzcUBN1EmaJXlGgTMafC0hIII9nXG2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 01:33:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9755048f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Jan 2026 06:33:41 +0000 (UTC)
Date: Thu, 8 Jan 2026 07:33:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Martin Fick <mfick@nvidia.com>
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Message-ID: <aV9PwnouO8652XQR@pks.im>
References: <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
 <20251226044507.GA1971832@coredump.intra.peff.net>
 <CH3PR12MB9026DFCF7AF4ED1A249B16A5C2BDA@CH3PR12MB9026.namprd12.prod.outlook.com>
 <20260102074901.GD2581074@coredump.intra.peff.net>
 <CH3PR12MB90260C4887067C88629BBE52C286A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aVyxbqk-2QQIgDXK@pks.im>
 <CH3PR12MB9026F1E4B99D32E138800EEBC287A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aV5GwOS_N2jyIFaz@pks.im>
 <CH3PR12MB9026C8C940270F02CEF83C4FC284A@CH3PR12MB9026.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB9026C8C940270F02CEF83C4FC284A@CH3PR12MB9026.namprd12.prod.outlook.com>

On Wed, Jan 07, 2026 at 10:58:36PM +0000, Martin Fick wrote:
> > From: Patrick Steinhardt <ps@pks.im> Sent: Wednesday, January 7, 2026 4:42 AM
> On Tue, Jan 06, 2026 at 11:02:19PM +0000, Martin Fick wrote:
> > > From: Patrick Steinhardt <ps@pks.im> Sent: Monday, January 5, 2026 11:53 PM
> > > > Did you try using perf(1) to profile the process and generate a flame
> > > > graph from it? That should likely make it immediately obvious where Git
> > > > is spending all of its time.
> > >
> > > I will pursue this. Unfortunately this might be difficult on this
> > > particular server.
> > 
> > True, on the server side this can be a bit tricky.
> 
> I ran perf, and got a flame graph, I am not sure what the best way to share that
> is, but I will try to summarize what looked important:
> 
> About one third of the time is in this section:
> 
> libc-2.17.so 32.5%
>  _memcmp_sse4_1 29.8%
>  page_fault 7.23%
>  ...
> 
> I am not really sure what that is doing?
> 
> 
> Another third is doing:
> 
> unpack_object_header_buffer 30%
>  page_fault 26.9%
>  ...
>  nfs_read_page 10%
> 
> Which could very well be looking at the headers of objects to see if they are 
> tags needing to be peeled?

Both of these are lacking some information to be able to tell. Are you
by any chance able to share the whole flame graph? That'd make this a
bit easier to figure out.

> And the remaining third was a bit all over the place with small sections,
> the largest two of those sections being:
> 
> packed_refs_store_create ~8.7%
>  unknown 4.4%
>  memchr 4.4%
>  page_fault 4.4%

We spend ~9% of time in `packed_refs_store_create()`? That looks
seriously broken to me, the function shouldn't even do much.

> nth_packed_object_offset 7%
>  page_fault 3.2%
> 
> This was way less informative (to me) then I would have hoped. :( Maybe
> this means more to you? 
> 
> It does look like a lot of page_faults, likely due to the use of mmap?

Certainly looks like the page faults are to blame here overall. It's
still surprising to me it's _that_ slow. Quoting the other mail you sent:

On Wed, Jan 07, 2026 at 05:05:53PM +0000, Martin Fick wrote:
> rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp,noacl,_netdev

I know that back when we still supported NFS we recommended to use an
rsize and wsize of 1MB to reduce the round trip times.

Patrick
