Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C6138AC7B
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901322; cv=none; b=o7FoAj1y7ZN8ahHmMNc3478mivhZkL0QJJRM3W7U6PrhalGenmHrEhATLvNbnAxKnbtHtWBHjTtkwGFpit1pyk1jPgXNreD7EokC4tzrJtRWjgJSA0e6tIYm57CviUzdIbxU1CMdHTusRCFX8aemJGi3VhfC40X+0TukmvNhbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901322; c=relaxed/simple;
	bh=FSNFYDfaRvQyQ4i1kuYPiOSQcM1j0h0vRgPWyb/9abA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mm95vgdU4Rau//YtRF5zUw5Xv2O8j6dZHSkHDDxLqoI8eBEapi7fcmBEAE7VGAMHDOSIeJEhDLFRThpjWnhts7+OKYehuD0DgKFnj8C31BOM73IPKhlep7K/C6MBO2CT9OS31CawmgLSR6W0p2sS068AnoQlKPWgGXi12ykUet4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RWnWWQ9Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZrsSwiu9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RWnWWQ9Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZrsSwiu9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BC4137A0050;
	Mon,  8 Jun 2026 02:48:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 08 Jun 2026 02:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780901318;
	 x=1780987718; bh=3s5s390/Ggd8RTXVNu8LvXLVlVhKVlnEqqfFKYr3NM4=; b=
	RWnWWQ9Z410Lc43y4lvcbQW/+2AvRpvtdpX9s8SNVAEaqxlfjHTC/pdGR+z+2QB1
	KqE0IWsABDKj4JZLQOdJ5d29V+jJ5Vn2Y0MbtmwEDZ9JR9FPQ7UypMtV654Mil5H
	hVOvFWXrvTol4N/xDYiK6jESjuzMV9PpUMs6DZZb/aljf8tlGTc3rMhUf/YWsXNb
	86Vo74T42IVBL8OuprkG4FX2zxPJEmsSXH4uENteUv7/oQLoxojJ4f8YsKJRmELt
	cDf+bsfdWumBkkgG3hHAz5axTUxU5mGBjS/3RsHZOJDM5GxI+uoo4fUnqE75AdJb
	HuiQevOr1qF4p2QTO6P/LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780901318; x=
	1780987718; bh=3s5s390/Ggd8RTXVNu8LvXLVlVhKVlnEqqfFKYr3NM4=; b=Z
	rsSwiu9p37t6hK+hr5pyU+QUkN1l3y37xhwHKh52XBLUv2c+FSZzFkiluk5Wr3/H
	AOBaMy+mDkHScoc0M5JfzTnFuwKmp0z5mLt1KoPP8i+ew3F0vc/IchO86sb7JC04
	2M9gbOtTa3ZzEMsdR3Ey/6WW+2YjtvO6mZ0s+v70xvTzYbDK7UIMgOFAyu9M3dvw
	wYnPTenhnkDt6CQhij3byXr1MdAghPS7JjLAVTfrVrh5LoLz8dMR5n3qSqJXgZQJ
	JBqaJPL0yymUFGEYHhDMGmuILxrGXAnH53XJi87Eznm3p8Pii9T1Xq/Xvu7vDKvD
	6Z/ud2cOIqnvNHo/MF6uw==
X-ME-Sender: <xms:xmUmahtyqak6y_WGXs8tyNk2TTfs0ysCt_gOf9L7E3fb_c3d69DaRA>
    <xme:xmUmajxHe_jNb5bbyIe3Ph4FNDJwljbiD-U2rFLgiqi1MVYkwquwyNHQJ0H46LtbM
    7L3UFWQ41EWAXkhVEKC9x9o9ZLPdx-Im-E5OP2lC36SqT9Sp7aJ>
X-ME-Received: <xmr:xmUmasALQ6h9SG7It0KJEFTUdjGom63K4JbTh1GPd4tkkePdxt6OKGyq3xRV_PR5Zm3CxXsJj4QWj1QlLGwJbHVQlOoPe80gKBb-W9QEfw>
X-ME-Proxy-Cause: dmFkZTGZjqa6PNK07FjLQHihpoFrmh60zwE5G5WVXOoVxM1Who3qwGxETVvdo3t+UMDMQS
    hGdRMbDHfH7wYPAqmrGI0iDRHCl72jcp/czLjnJIMCtKCX53kmRagMzXKfvb2RuUl4CCb7
    zw2c0vnljJ06r6rs7oioCWzMGPDVXzx7XaC9roVrbib54fD5LpGASy1nj2tlHmYo5+LKBP
    cqje15/Jmwhqx5+6n7013mGQ4NZVpC/HPtwe5w9SDDXHXFMvPV/bp52VDce480AyQAyNz6
    eCyqfRrIWAF1a2qJw1q+GJXlzBRmXjnGQsEDtYnD9vCAgBJz1S+HjOTXZzi1f2A3zAcmhN
    JehzgP5DTMIhq2lUftjXkjOm1+luhMq74+JCvWOyHS+gMihRIGFpxdZ9LdliYOM1MI7/KZ
    B3u8ucQjnLBB8NZtnTfaNCDr9PRRYOWDxjSyZrfTWN+CQ2+k39IK1RY6ebZdqjple3G7wC
    dqQAjr4N2Y63RLRZvCjV5+bLv927uNKCH3bXKf7gksJ/xtSSlB5NOgXG3z8IVIer1Qerm+
    0RcGCdyME8jpX0IUnJN7YkbgRyJxZtd+nIQmXz5+pt6iDq2k18SdGKr/qz+9Fd4gzdgob0
    aqeVLnSsHZRlmjAfJLUu2r4x9sZB3cRRS81KqgvkCpR4V329+DBh2aujfm6g
X-ME-Proxy: <xmx:xmUmapefSsX1TXj-1LXzF-q9AvOXzzM66H-aELoYliksxJSfM1RCsQ>
    <xmx:xmUmaukTZCs-ro1evwr-YScazwUs9OiL8GA5H2k9ZUgEjTXGYO0gKA>
    <xmx:xmUmaoHUGcu18cJDBqrgfYSsfILlJogxtlT4EB1h0-twZxbglmojVg>
    <xmx:xmUmau48G18WanHT1av1BvCcpyRL1ZB5tepSi8eoA4y6H8Ax0s_C5Q>
    <xmx:xmUmap42F2xB3vAfu08Q-HXugTusq8Vy3wNR5xa6792MK-fFVTxDaaK3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 02:48:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 322284a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 06:48:36 +0000 (UTC)
Date: Mon, 8 Jun 2026 08:48:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tuomas Ahola <taahol@utu.fi>, Weijie Yuan <wy@wyuan.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 1/3] Documentation/MyFirstContribution: recommend
 shallow threading
Message-ID: <aiZlwi0V4jrtSRAj@pks.im>
References: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
 <20260603-pks-b4-v2-1-a8aea0aa2c23@pks.im>
 <f1dbb848-2d9b-488a-835b-2d23006b5fa6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1dbb848-2d9b-488a-835b-2d23006b5fa6@app.fastmail.com>

On Wed, Jun 03, 2026 at 10:09:39PM +0200, Kristoffer Haugsbakk wrote:
> On Wed, Jun 3, 2026, at 08:58, Patrick Steinhardt wrote:
> > The "MyFirstContribution" document recommends the use of deep threading:
> > every cover letter of subsequent iterations shall be linked to the cover
> > letter of the preceding version. The result of this is that eventually,
> > threads with many versions are getting nested so deep that it becomes
> > hard to follow.
> >
> > Adapt the recommendation to instead propose shallow threading: instead
> > of linking the cover letter to the previous cover letter, the user is
> > supposed to always link it to the first cover letter. This still makes
> > it easy to follow the iterations, but has the benefit of nesting to a
> > much shallower level.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  Documentation/MyFirstContribution.adoc | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >[snip]
> 
> Only today did I notice that your eleven-version git-history(1) series
> uses this style. (Or: today I noticed that it’a thing)
> 
> https://lore.kernel.org/git/20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im/
> 
> That would have had a bad rightward drift with the usual reply to
> previous version style.
> 
> I’ve been reading Lore on Safari on mobile and some threads go so deep
> that the replies just become unclickable backticks. *Huh?* Well I can
> use the Next/Previous buttons and maybe there is a way to make it work,
> but I’ve just given up on those right-going subthreads. ;)
> 
> ... and I also don’t see any drawbacks to that threading, using that
> series as an example. It looks just as comprehensible as the usual
> style.

Yeah. It doesn't matter much for patch series that don't require many
iterations. But eventually I feel like it gets out-of-hand to have the
deep nesting.

Patrick
