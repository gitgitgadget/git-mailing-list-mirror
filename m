Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3A5674E
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314781; cv=none; b=HJ41R6zVIirPxLatxZGSAVgYnojGxi29/+m+MO0xTE2AB995rwO4WvSY6/N/0ffxPliuRECCt+rDPXF2dhmCSuWZr8WwK0GWtdR4WOQl7Y2/GF6yP2aUzBcJZuk02OATZjM0mJcKV2+XMfGfxhU/9mOmhLgx6sxPf/PmLyGc5bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314781; c=relaxed/simple;
	bh=FeUuRQ9zgVSQc+yfajQyZ2pCz12w3BslmqnmMnjSG7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGF5/eOzi1nWL7Hb2b2ZaKoQAKZrWGpOJaKRjK51cn2Q7J42RYJJsXFQMqE+alTAKyXwKskq67/6OPRYUHcD9TLxaeagFuAVMnbaHlylw6tjwxX3jwNz2ly7gVAdbqBPlSfz+gxvURLeZuhSMQl7O+T45Oqm80S9oR5sktZY4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VAsOrgCb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XkOs+ES1; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VAsOrgCb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XkOs+ES1"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id B7C60138FFB5;
	Thu, 22 Aug 2024 04:19:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 22 Aug 2024 04:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724314778; x=1724401178; bh=HQVqPiYVo5
	pgHPsRwAvDs4bs/FqE+4WJDhiSSElTKHg=; b=VAsOrgCbAbnBiu0VCGQ8+zoCHo
	GtFDAuwet6pYB92I6OKghsDTzNaM6LM97phsyUsJAj7DslLDg/42KrG/mOvg3y7l
	Vonv0jTCy6kdhK15QaYBiLZVQK23Hq6GucSMxLhdNZms0emmpiNKSxKM3lO6kMjE
	6TYEiCfdTLjMEnb7fyUS4T0ixgj7mjFNK1gr/RElP22DsvnyIvs/u/zsEF3HB6zM
	BeQ8yGuErX3qe0OfIzQhC/px7UJatbb+PYa+H5pZDTfXs52MPQaVhWaHBjpNFXsO
	ixlZCpCyEBVZhgQzqijcQTHq7gBo+cU+FVEjGj3uE6ZgoN78yDVDNWCUXFig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724314778; x=1724401178; bh=HQVqPiYVo5pgHPsRwAvDs4bs/FqE
	+4WJDhiSSElTKHg=; b=XkOs+ES173NWRZLbBYz275wp9lm1Tq87ig+1BRy0MUEh
	Ivc3+u6PhRFdkPHpS7sEIJRx3TbNWCXZ3Ec6K0qq+giLP1RKfx9/CDwnQwvPAff8
	o8M/h8OBEwDsbUCJv2gprPDNspO2JYk3wAbUU1b68s8Rdq2RZQYhpo8H07iAjGvQ
	p+NYlbcHOSi9MyJ09BtPirLQRY32RjxwxhF4PQLUAaI9X8STOJE91CqpRgKFDQ8q
	j3L27B0s+o3z4eeNT+k5sZUf8FoeNPPNKF539MfMqo+BPNaN424iKlkwPKfNAZA8
	wPC5hFwBrnw85M7gbxcAZ6PopLPtJMUQPnm7KU0AHg==
X-ME-Sender: <xms:mvTGZjgjRDlncRBAtOQwugdVF3CMDz_nNL4eX93nyq4ZuY9LNP66BQ>
    <xme:mvTGZgBrPekxHKbU8XP2RooAt30nE9WmRBfJt4vwzYMA3AWcC6evGsaIz4GGpYz2z
    tmYazEmyD2vT9r6Vw>
X-ME-Received: <xmr:mvTGZjHnqBhXQ1cwSgPZFG1Nnc649pLfI61YJpnqJ9rF2IV39boiEsfShtvxr5iG70UGqFUDkJt8YdYcwNsvx2_hXKdIjuTMbbiNhldFBguZaxI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:mvTGZgTiryPjPSLVTHSU6Jk-KyKJRhMMwAzhd-WTNnZrXQb7_3G-aQ>
    <xmx:mvTGZgyY5kackST15M4YGGuOmjgsCIPZg1SuDRAU5OEqNd6nsdG-JA>
    <xmx:mvTGZm4hwHCqeXrRKkDJ1kvu8On1r9PoJYBTo0kUoxO-sHs5K_VJog>
    <xmx:mvTGZlyh3Eflvj5Hi4_iAfoXb38Vs42SeOmC0apvwAfwvLdHG0bxmA>
    <xmx:mvTGZr8asIZty3duw1zN6qCaAB_vqcC_XgriFpGlhCM4jdnsFcqOsAi8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 04:19:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a0bfe5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 08:19:00 +0000 (UTC)
Date: Thu, 22 Aug 2024 10:19:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/20] midx-write: fix leaking hashfile on error cases
Message-ID: <Zsb0lUkoJkbfuFiO@tanuki>
References: <cover.1724159575.git.ps@pks.im>
 <5f042ce5098563aa0662026006c356c278dad0b8.1724159575.git.ps@pks.im>
 <xmqqed6i4wb2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed6i4wb2.fsf@gitster.g>

On Tue, Aug 20, 2024 at 04:19:13PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When writing the MIDX file we first create the `struct hashfile` used to
> > write the trailer hash, and then afterwards we verify whether we can
> > actually write the MIDX in the first place. When we decide that we
> > can't, this leads to a memory leak because we never free the hash file
> > contents.
> >
> > We could fix this by freeing the hashfile on the exit path. There is a
> > better option though: we can simply move the checks for the error
> > condition earlier. As there is no early exit between creating the
> > hashfile and finalizing it anymore this is sufficient to fix the memory
> > leak.
> 
> The above is a good explanation why "are we dropping everything"
> block was moved up, but does not explain why the other "if there is
> no objects" block has to move (it is however easy to see that the
> latter block can be moved without any bad side effect).
> 
> In any case, the struct hashfile hashfd() gives us is now associated
> with the struct chunkfile cf immediately after it is instanciated,
> and there is no early exit while the chunkfile is in use, which is
> great.

There basically is no reason why the other block needs to move. It just
felt more natural to keep massaging of parameters closly together before
we go off and actually do "the thing". I'll document this accordingly.

Patrick
