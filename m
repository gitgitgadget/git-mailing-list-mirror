Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E552433CA
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294083; cv=none; b=kiG5px4oGHlV1uEdG/LpqYJ6gqHSBGE6rO59PIgh8kuFGKQEX/3cDAL4P/gussk1gVJhxKSa6c8oBwmQFMgnsr/XYBDnpEQTgKr2VdYlEsrkhTHBF5aBUUOrekUjuBtuZmeYFg6i8tpMdHP3Nc99XSU8aC/NikjGFHlQe52nG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294083; c=relaxed/simple;
	bh=bhNPwnKrG4TzYOumAaO5Ed0YIF066VRAhZqJzOlxsPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbMQzzLG54CYO3qIOBvo19pzFhn06zSTaYrB+ZaxSgj2UoELCDQ+dxgcYGUmOVcYCov88BhZDOUZFY3iMVsqp0zuyOxOt0qGwh46trs6Br+6YYW9iKUg3yn7igzgO0bk++WaNRPpaaxCjsTg63mB9D5Tz7yNg/7wNH2TD0uSZtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NqOeysbR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f+KqP8Nl; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NqOeysbR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f+KqP8Nl"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1AA4D25400C9;
	Mon,  7 Oct 2024 05:41:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 07 Oct 2024 05:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728294080; x=1728380480; bh=gKMsLav8cV
	zjqa3RTW4dr3jvOBPDTHLY4FGSbkfKpjM=; b=NqOeysbRAEWI1R2x3bUbOKYs6l
	CMAephve68DLmVrTtdadGEA25scotTO8BKgJkDWrcSJE2hTwdqReVDXmEEpKRRt0
	qIvNxajK8zvJKsYZ3tdS8erWzsJ9HJsFjdiMxt3fDhstOMGtQJ6Nm7rFLjDNviJ1
	aro5ToWfSukLnV7BFq/TsmWZ0gqhoYw56rN33Wu8xcNc6KGVQ/lzu8bh0F71P0ZX
	hDle2Bza41++MPC8sm3bMElcVW23dP1SCr1c8MZoJGSjVIF31+r67Z7hQPY0V9pF
	euzWmadVT8ccfV2Ke3K4Bi1jgTGciqaNwYNKEoRVpus7jiRDj5HjsJtoT2hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728294080; x=1728380480; bh=gKMsLav8cVzjqa3RTW4dr3jvOBPD
	THLY4FGSbkfKpjM=; b=f+KqP8Nl4GHK9bLZX17JauWiVKJomrqewgl7qsXG1fpV
	1DAAChsCh+pH4+hUf6AQtGpQyWdRqo8ly271e/T78H3qVleSZiCzuS9QaQlpgYHC
	Q0sQR/vid9FK5PznvfvN4814s0Mp2xd0B26YDvwVO2ipsxzEI0wkPlhVng5Q5Sct
	FWzUSY2VDzGSWa1QhksRTrr6dYttwDAbir0W2/eTXGBKbWlWP22gAHo6+kmtsaQh
	HxUvsSAqXoKTAKVfuMpL4G4fXJxczvFLoU5/osj+gubz400PMT5YEF95VH/quZfn
	9VgHNEzJvFUoURM6/dU7W/R+QkEOEiiCpHWx65wyWA==
X-ME-Sender: <xms:wKwDZ43qx4DACwG6cXGgEWPhWGCbWIpt9NVrsgTmooaFw8AIbpE3aw>
    <xme:wKwDZzGoyzl09yiA8D6hixSOt7HGa-sZ4WsRQnOiQtiw_Xdy7uT6KyP9IcGTmdpv8
    9zklsjUQtkElhBETg>
X-ME-Received: <xmr:wKwDZw77Xhcuk9LJiplbSd53LdFOGMoYDieVFScFC9BH6AopFef7aSIAsupMJ2cQ9pmwwr2FcyD64M9SV0PC0LWI4MMVSzgdLvVqBWx64eUWMNxfhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffke
    dujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:wKwDZx3lyiKOaRfYo6kSRhutgZp8Ndu18Z9V673LngKepr5v88VUGQ>
    <xmx:wKwDZ7FfO7NFypwtEa97ftmX8fz2vkuddsPiS_oIETP9H-r_O0RVhg>
    <xmx:wKwDZ69gU97_1BoEbeWt9z1C9IFLBCIo3_3edKhounFP0Gk7IkSVYw>
    <xmx:wKwDZwn2TujhDD55A_DrSAwveACyUZYyzsOV-2xKQCVWeXlOIjXEVA>
    <xmx:wKwDZwRSdnv0-N4LWbMbrvLaYlN2DSlyHj14KRbZwk0MKKG4U13PKHj5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 05:41:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c827a769 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 09:40:20 +0000 (UTC)
Date: Mon, 7 Oct 2024 11:41:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 15/23] pseudo-merge: fix leaking strmap keys
Message-ID: <ZwOstswKzqMNNOUO@pks.im>
References: <cover.1727687410.git.ps@pks.im>
 <9e1161d55f96253bfeb5cddd1bbd381e2dad8a71.1727687410.git.ps@pks.im>
 <ZvsWlNPGxt5AOQcK@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvsWlNPGxt5AOQcK@nand.local>

On Mon, Sep 30, 2024 at 05:22:28PM -0400, Taylor Blau wrote:
> On Mon, Sep 30, 2024 at 11:13:53AM +0200, Patrick Steinhardt wrote:
> > When creating a new pseudo-merge group we collect a set of matchnig
> 
> s/matchnig/matching/
> 
> > commits and put them into a string map. This strmap is initialized such
> > that it does not allocate its keys, and instead we try to pass ownership
> > of the keys to it via `strmap_put()`. This isn't how it works though:
> > the strmap will never try to release these keys, and consequently they
> > end up leaking.
> >
> > Fix this leak by initializing the strmap as duplicating its keys and not
> > trying to hand over ownership.
> 
> Hmm. I think I am probably splitting hairs, since a few xstrdup() calls
> between friends is unlikely to matter here, but... ;-)
> 
> It does seem wasteful if we can avoid it. We already allocated heap
> space for the matches via the underlying strbuf, and we really do want
> to hand ownership over if we can.
> 
> Would doing something like this on top of your previous patch do the
> trick?
> 
> --- >8 ---
> diff --git a/pseudo-merge.c b/pseudo-merge.c
> index 28782a31c6..6b6605d3dc 100644
> --- a/pseudo-merge.c
> +++ b/pseudo-merge.c
> @@ -110,6 +110,7 @@ void pseudo_merge_group_release(struct pseudo_merge_group *group)
>  		free(matches->stable);
>  		free(matches->unstable);
>  		free(matches);
> +		free((char*)e->key);
>  	}
>  	strmap_clear(&group->matches, 0);
> --- 8< ---
> 
> That introduces an ugly const-cast, but I think it's tolerable (and may
> be moreso with a comment explaining why it's safe).

Well, to me this is a tradeoff between complexity and performance. If
the performance benefit outweighs the additional complexity that this
shared ownership of keys brings along with it then I'm okay with the
code being intimate with each others lifetime requirements.

But as far as I can see the number of entries is determined by the group
pattern, and I expect that in most cases it's going to be quite limited.
So it does not feel like this should lead to all that many extra
allocations, and thus I tend to prefer the simpler solution.

But please let me know in case you disagree with that assessment.

Patrick
