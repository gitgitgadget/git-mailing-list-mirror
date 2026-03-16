Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1557326560B
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648562; cv=none; b=Ud5Hn5lJzNtNAJvsVMIhV0rZ75PkqBLHiDT1oZK806QStrp6Kd5AbaPMjYDHZqNiMiVPXdqCvHvLOSWZyVlUzWwQBKzl8y9NTbabsBeW5rbNQQ92QADKE09F8rt8I9x2JsZ26QImGzSoYbRRq4Ld+QcgVdhmV4TcKdgmAfkx2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648562; c=relaxed/simple;
	bh=wE3cOpTfdtq1dFEx8nCs/tpufHve/Fqb5pd3t6u7ooE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPBVYhVpSD2okJeZ27NzcpfJF+qouxTAdJBtqiQ8OT/Up8swgMKxPymHhhM6JLrBup4F12pUT9WZW/s5CLdbmzyKM3HxZWveMwpSO4p3tC99nRFY/IFpD3z1auLsJTlYflccorz0TEyJRmg+BU/W+11hQvQ0cLOEwAV70ZEFhbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XmD7Gaz4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y4ZDBcj8; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XmD7Gaz4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y4ZDBcj8"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 502BE14001BD;
	Mon, 16 Mar 2026 04:09:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 16 Mar 2026 04:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773648560;
	 x=1773734960; bh=LqoWfdv9P4RGHJDQwgfbPPZUDXo62FPKAtwj946pfwM=; b=
	XmD7Gaz4v4njNhhLOTliUR6KemZPXcgETkQggregNItcyLL8DierTkQ0LNyooV1G
	17b184JieU1fxuQdU0ydoEqogTifIoRIGAdzC62GaJk5rhJfXPXYWMRopn5qDhtz
	if5ju3cDgZ04kZadJJFcO8ZRDufqQcMyA4NqElktgrXGjbhKun64mUrD+10eTuZe
	LZ59KgA4DSQY5nKkxmAds+oyOm+DeZMWhF7EFBJ1cD8peV9U2dxzixDN8s+6sGtM
	Wcekfm7Ycvdd/UaZ19m1D/dzs5P85VTOcVQROwTubVJHipPDOjNOUmcjiHG7iYPP
	RpCRMdu58QHsDyTZqL+POw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773648560; x=
	1773734960; bh=LqoWfdv9P4RGHJDQwgfbPPZUDXo62FPKAtwj946pfwM=; b=Y
	4ZDBcj8C5LYB4PEHpgO4t2sYpP7V2r2LBDyTg1vnPuYnn0byNdAMclCxWdH3moWs
	m+tEBxNTPmLp67tVvl345Qx2mdXzCa0pbLIo1k/j0YzFCITr6q9+mevFPqZJ63DV
	3YOYMs7ic+KSiqEyxxu6vNbVxAGBlahrRMaMbCU0BSP0brhpqB69HkRAHFMJYTPY
	lA/roXk+o7CZvrBWqE03XKHFx8t75JgNni8CdYFE+nFgmKqRTTXRyk/gbnIQJXr/
	p/qmSuReuZMJnQVYaJj/8Hg12djTnP2jVCQHMyfn5sI5umEu1RMBv6TChL2rACEP
	mGAujVUy4fYOSa+mIFONQ==
X-ME-Sender: <xms:sLq3aflXoxOlbnrtm0qn_0Rr4n-vOjYqhe-N4rpc93GmEby-3MgZTA>
    <xme:sLq3aamu7A1M6lp8mdgsslmMl19DEy4yzZG9rDae630rBIk14jx6NEdNFcGRPVjn2
    6ffQwctRBqYnrdFNpI1mpawaq833VhaSuiX3HKEdl6Eh9peMvOkUw>
X-ME-Received: <xmr:sLq3aYuv344A3LC1dRcMOLt-zpes7Dqub_Ws_us1oIJrZone4NQGCRwdw5qcY4xmngAGM1xrXGfYJ5skb0ATsyRz67A-8GsWNQhpRIdAvCc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrd
    hukhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:sLq3aVkhqjXXJcIr2yNvvD1V9bA8k4FpY1GssmGKAxKKnJLuUskIEQ>
    <xmx:sLq3absyRQ0Ra4N-PiJVy2mvvoB_XX5p2GmM504sxdx-mubRbv4a7Q>
    <xmx:sLq3aTdcnSOaCJEVDX1n4VQW3xbtEDL0Qni9XLqZmS6dbJusHjm9oA>
    <xmx:sLq3aTy7d62U7hJYeQ0gNIhFj7rnUGW2RPmpCBs7J0m3mVrTW0AiXw>
    <xmx:sLq3aVd3LBW3Wz10cD2AY0J_M32hsNV5FU8Powtn3S52iqf1zrmUUANy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 04:09:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08837b40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 08:09:18 +0000 (UTC)
Date: Mon, 16 Mar 2026 09:09:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/8] meson: compile compatibility sources separately
Message-ID: <abe6rGICliivaEqb@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
 <a5d1ea70-12dd-461d-b5c5-a1127e017d01@gmail.com>
 <debb89c9-2fab-4922-af1a-6048094baf9f@gmail.com>
 <abH6dayn5tJBMY9p@szeder.dev>
 <abJbhQwc-X0T6S_B@pks.im>
 <3be0c711-5222-4faf-bd32-117230215490@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3be0c711-5222-4faf-bd32-117230215490@gmail.com>

On Fri, Mar 13, 2026 at 10:33:36AM +0000, Phillip Wood wrote:
> On 12/03/2026 06:21, Patrick Steinhardt wrote:
> > On Thu, Mar 12, 2026 at 12:27:49AM +0100, SZEDER Gábor wrote:
> > > On Wed, Mar 11, 2026 at 02:56:24PM +0000, Phillip Wood wrote:
> > > > On 11/03/2026 14:32, Phillip Wood wrote:
> > > > > On 10/03/2026 17:52, Patrick Steinhardt wrote:
> > > > > > In the next commit we're about to introduce a precompiled header for
> > > > > > "git-compat-util.h". The consequence of this change is that we'll
> > > > > > implicitly include that header for every compilation unit that uses the
> > > > > > precompiled headers.
> > > > > 
> > > > > Is that a meson thing? I know it defines precompiled headers on a per-
> > > > > target basis but does it somehow force each source file to include the
> > > > > precompiled header? Looking at the gcc documentation it seems like the
> > > > > precompiled header is only included where the original header is
> > > > > included.
> > > > 
> > > > Answering my own question the precompiled header is included via "-include"
> > > > on the commandline. This is necessary in the general case because a
> > > > precompiled header cannot be used once the first C token is seen.
> > > > 
> > > > As an aside in git we could probably get away without using "-include"
> > > > because if we include "git-compat-util.h" it is always the first thing we
> > > > do, or we inculde another file like "builtin.h" which immediately includes
> > > > "git-compat-util.h" and so it is included before the first C token is seen.
> > > 
> > > I couldn't find this in the GCC docs, but Make's documentation states
> > > that "you cannot include a precompiled header from inside another
> > > header." [1]
> > 
> > I think you must have confused something, because the link _does_ point
> > to GCC's documentation, which does contain the quote.
> > 
> > But yes, overall there can only be one precompiled header, and it cannot
> > be used after the first token indeed. The use of "-include" is also
> > explicitly noted for "projects not designed with precompiled headers in
> > mind", which fits Git. After all, we still have the ability to compile
> > without precompiled headers, and I don't expect that to go away.
> 
> Thanks to you both for the explanation. Should we explain this in the commit
> message?

Yeah, let's add a note for how this works internally. Let's also
highlight that we typically only have a single precompiled header by not
passing the headers as an array.

Patrick
