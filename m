Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97FD314D3A
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205870; cv=none; b=cex369tLms82If4Imr51iX/Ko3twdTdJ5bc9KPsX2SypMgIi/X4nH0wL5lJ1ARcoWeAGjxHArAev1Ordl/ewJekeRCxvNRi7/RekIaatVubKWmFTMrMFlS7br4Dm5wdibK78NPVxLuCpLzXg7AubGMUGDqPSBMCL4vXSOpiuDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205870; c=relaxed/simple;
	bh=78MAvr6uY3tgtUv9iKx8OxLdvjwpPpKR15OlL5BYsFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcdnKEtVPFIpFMWBNRkjLlpfYdLUTTwVmjCZ614vF0Oo0dtut1a9qA9HHZWxvD6bPYasr8zZgKayZhTa4vqgkBVlpj1DM5Rbr/w8vO6oGV1jORXwQysfS14+5Fz1bRFHP1tf5NFBrP7+dn+Dp7VwHnwdFNT29vAFaQYT8x19EsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YGzUolfG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rNysPY5h; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YGzUolfG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rNysPY5h"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E1A117A0041;
	Mon, 12 Jan 2026 03:17:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 12 Jan 2026 03:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768205867; x=1768292267; bh=QhQUTVLxKh
	1EBGmyrj/NPCNP5uQAaFiXAZKdVeoMjh0=; b=YGzUolfGTMY9pRDJkfjgcpQicd
	fRR6tqL/IgXQZr09AnAUHsfavIBMqAsqlahgjz25vSPTqM5/TU1I3kBHHq7ysEiJ
	dGXlVIhwPOmPnj/18CA/H6qKCNcvVjbTmtHtcsDzAfLP7zp75ROTNO2MwYLe/Ew9
	7JDQ/Uhp9xYqmwM/kCXV1r26VxhyKZ2kBCrp6iWMblzqAitnb4iSeeGFW9fMEEvm
	y9ckPILLJSjxWGWb0eD7+QshScjtprgRlX5+VGab/ffzcQkseD3xGMuH1aauVpMR
	w3GQG/GGsfpvZz7iQN9cZzl/uRoXdpd24Jf1MkA6FBoSlKbcggpZHZto77ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768205867; x=1768292267; bh=QhQUTVLxKh1EBGmyrj/NPCNP5uQAaFiXAZK
	dVeoMjh0=; b=rNysPY5hzRf2EpETebM1tTtlYNu+pEHJ6IhVpx2ixyNFy7miUkN
	xTezoVWdYuFcYz7et1FIcWQFtts9unXCFV9Kncy1sOXYFnGrZbrPtP5soWF0Ml21
	AkgKnKufn9dQAQ8FvZc7HRar1lOldNAh1Lt3Pckq+S2dRMmj3iRDyWDak6DO5F2c
	3K5o6VWSWARgZWoUiPEQM5kd64RX9l4MywtT0PYtxEX9QDvQkJco3YbJMApV6KxE
	jNCmneosMur31T9SqLFGTItlHWy0QyJYUZNHJfdC2iMq2TyD3vaIx/t2t13NxGLi
	Vjn99+L3wHBqPzANiBEmdImOtHcVOcLek0w==
X-ME-Sender: <xms:K65kaYOx_pYb8cq6gX0W37HfV24ZELR1uLm0lkvU1_vsVURgecHB5A>
    <xme:K65kaWY-gw5yABomwgFM84mZma2uRDAcf-ccihJ8irn0vga4Jk7Y6KS2IltA5O1sf
    kHj_tCh3AflFJzf_qAXmQNZ8udwoGJjotTAMSst68RzFQoT8FKQfw>
X-ME-Received: <xmr:K65kaco9d0ZO8Wqsn3y2-2R_YNIMn9MHAtwPrjMZVBTDhcsJk2IYjJV6jPaQYAMGMfqw7aKmNfHkGjAYjDjjZV4iqc4Q1lY3X4-MijwbCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeileehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:K65kaaZOSy0VXMEvk9mRGirGY7vYzkBcuEq8qjnEcwlfEVeIjRkwUw>
    <xmx:K65kaUQcI9GI4N8XlxPgnE_ok0wmMAwUcTXYGieN2riEONI641EELA>
    <xmx:K65kaR6imaj-S40k8a1Da6Lzf8kETRRz_ONyloxWo4FJ8_qvwewuKw>
    <xmx:K65kaZwEjLYXgkkGpcj7pJZNd5GuMnuG_kZ4GWwA9STkAbHC0K2dzg>
    <xmx:K65kaQ0NaiEiLDZQcKgW_m51DAvROwQv00_fiTsThYdaycp1p8XebysH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 03:17:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc2ff845 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 08:17:45 +0000 (UTC)
Date: Mon, 12 Jan 2026 09:17:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 07/17] refs/files: perform consistency checks for root
 refs
Message-ID: <aWSuH2bjlRqa2WoZ@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <20260109-pks-refs-verify-fixes-v1-7-3587dba18294@pks.im>
 <aWJKYzcY3H_-xy1V@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWJKYzcY3H_-xy1V@ArchLinux>

On Sat, Jan 10, 2026 at 08:47:31PM +0800, shejialuo wrote:
> On Fri, Jan 09, 2026 at 01:39:36PM +0100, Patrick Steinhardt wrote:
> >  static int files_fsck(struct ref_store *ref_store,
> >  		      struct fsck_options *o,
> >  		      struct worktree *wt)
> >  {
> >  	struct files_ref_store *refs =
> >  		files_downcast(ref_store, REF_STORE_READ, "fsck");
> > +	struct files_fsck_root_ref_data data = {
> > +		.refs = refs,
> > +		.o = o,
> > +		.wt = wt,
> > +		.refname = STRBUF_INIT,
> > +		.path = STRBUF_INIT,
> > +	};
> >  	int ret = 0;
> >  
> >  	if (files_fsck_refs_dir(ref_store, o, wt) < 0)
> >  		ret = -1;
> > +
> > +	if (for_each_root_ref(refs, files_fsck_root_ref, &data) < 0 ||
> > +	    data.errors_found)
> 
> I am wondering where we update this filed in `files_fsck_root_ref`. It
> seems that we never do this in this commit. I think we should delete
> this filed in `files_fsck_root_ref_data` and add this field back when we
> do need this to avoid confusion.

Oh, you're right. I think I did use it in an earlier iteration, but
don't seem to do anymore. Will fix.

Patrick
