Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C686463B73
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790836072; cv=none; b=Iv0Hv4nOXNCo9KePhsHFrZFHbTexyWveJ1UYDXsopU/al0Pa54/cEFtQtP0lBhWav7KvjahrTfWiuv1mspiCuT4RLub471RAN0FwayxNwH1T+9MUaCDy1B6XKW9E814Z97cQSof+AEz7+nTbkfXZkv4lNhjU5lHCHa4w02Ymdzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790836072; c=relaxed/simple;
	bh=QcnPKv0Sp/7DH8v2DxdOogwRUAFmxUT7bgm5qMzKaj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nptg0dxgt45fM+7g9DB9wJUABHnzimLJKXtk9PHLlBIgXlgyvQI9kajvybNIUfHgvG5//RVCYS2muHrN9n++JdvoYc+mY73Tfmz8x/RHpM8v5aUfYJvoS4fCPmak4QGZDyqdL4MG4WIOksM17WbQLx9zaJzy39fwVt+16ON9oRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V0lDnbbw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GMwKOWfh; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V0lDnbbw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GMwKOWfh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9805D7A00E1;
	Thu,  1 Oct 2026 02:27:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 01 Oct 2026 02:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790836069;
	 x=1790922469; bh=alcWO63CjphbIHs+UyUn5ZT5LTxQKfJnlXxlAIJCIcE=; b=
	V0lDnbbw6GDFHPZYRK81OV885HYoWYUEOT4I/p1wK0brOChxQWsRXI+1+7X+Pwgg
	Y27RmH2s1OgvES1bDnBQ6SKFOi8rK75scX56kX66YS5X3UE2Utogs5nrhzoOSW6F
	K+Sk9R1HCj8UxeFq//fvS0ygSWfiktqEJxDfDkqCmaIYbv39esDqGBPze/PA2dcy
	8Wa4Bm1oNadiuIOQPC8OSeF2Hm+9sIhUjbBgXb7pBI2qCXQwT4Sv+EKU7zqsqWBl
	n3YEGlGGf2uhLX/5D4RB/sI90AcC1cjZSBQdXcMfIrAZegjNEltXL6rvZ2PzZgDd
	gYndZtal+ASKkftN6Bi4Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790836069; x=
	1790922469; bh=alcWO63CjphbIHs+UyUn5ZT5LTxQKfJnlXxlAIJCIcE=; b=G
	MwKOWfhNWfeRS6RUe/FIJxG+daBvhJ6II5zxXE0KfTjc+vJnhmArTrWIQ2ZYgr3Y
	HfzH4jGXC+thnVtYq5b4AO2oJrep1GIMBYiG3dRjBVBxgCa9jZ8AcQMbjIvfa207
	T5XMUtVoxLR+EshbFB/eHNqpz35zTtbtT4e3puS0DWzZVCy7gjbgEoB5pXZpiOZO
	5p47Fvlu5NXtRDj3hCoRzinXQ11r39shSPrN/aYYCXRjD5n303TV7jRVyz14PJ4g
	3dxSn9zQa1b/W1H3jxoG5JwmEjegHghVzsGNw6VaGg3STEKoZLtD7oNDFKDBj2Sf
	yFNK+XE1BalN5Ru1zmxgg==
X-ME-Sender: <xms:Zf29ao-7Z1bFYLvdqrZlrQnj0NE7WreO9w7hShI7ccXBvLgG9FVazw>
    <xme:Zf29ansWsEmY0IV42XCVAWCq_4zgv7bknw8PI1i3xqrxuir6Rp2chuMuK3mKbp0FI
    DGu-HvKyPBOe2Uyq_mVgdK970IYVmWCfOQtmqBs4yGmCd80ONcU_Q>
X-ME-Received: <xmr:Zf29ajAiemU8Vi3owoPeYFZ_L2gArQB9U6e1qDF0K_Ra60f5OY0pci5iauKmxAwfL6F80A>
X-ME-Proxy-Cause: dmFkZTFZY8JW2OJeN6nq8vlCx78DPtVkSz2xRvM52hyWg6Y3sPw6vSFouwDgQOdOpDeRGx
    da6DmFtndDp4s+RMDGbRnYP7JNrHgH4TDtK8d6fzp2lMNW3663RcTXcr1OyKmepW0YREw0
    dTOkfdvpNX4Xx1myldxsu9g46nxVwJpIbLQmkSOGuV1dQOFZIQVHPfublpVx+YUueyXgnb
    JfpVjqSW0MI6isuWV26eEmX70NHg7RwXLjjYAUb8DudZVjCJuMblRSWvoihmFdfZ5qMPdl
    X1xRVfO3FC/f6xsPj7Lu/zbaV+7+9Txh9HHEGsFYCIaFjIEePOxbBlVxsLkXvwU007PMV1
    6aDJNuMXJ8YTPwVT2z0zjPQLFq4lvXPqQA9xotB72Sgj1LYy2xsYUQDONnti6oRf63I7Gx
    h+9LV9WQwVS6bAPrCf/ifQfyvXkNeqnkKPX1LILhH/1booEqaBUt6PPKilSn4ZAh8W0ujd
    F5QfF6nnO0q3kXGbUJpf5dhiWRFhVcqVY9rmHwNauQxHxBsJRBtWEUiTqBxXVDx8ziZKak
    x57W4vgogkyDDDVN5Vo9CLvI6oU7hWDQPrADEMDLNeNz/I+wK1lkfVeO1y71ipkI5Q1mwx
    726Iz6WTot6iHMTfNxpnAJDaCz9/ncY1Hj0FGatcFO08mrXharx4aJNhRYSw
X-ME-Proxy: <xmx:Zf29anW8F-1bCyqNRHhwKQhQTl5t1GwBOwx_cPWwdcjwYbpWlP4xbg>
    <xmx:Zf29apCRiSXk6l-GB7gSqyQcSGgxnGjfOeS2H6P7C-CUFCNFNucXuQ>
    <xmx:Zf29ai-osPPnhSeyyfFHEZaj413vIeCveQwixJLp0Q1JCDqMFMQz6g>
    <xmx:Zf29aoHpkM5iA7eu1NL4efodtAuz3D9VvsB3L_amSvOWeAIo1D-dJQ>
    <xmx:Zf29appuhNGBLEqAFVCuc5wrAz5_zyanZ_Hb9QSs2HkWNS98bW7BFpfL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 02:27:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea674d55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 06:27:46 +0000 (UTC)
Date: Thu, 1 Oct 2026 08:27:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [RFC PATCH 2/4] doc: gitbreaking-changes: replace msg-ids with
 URLs
Message-ID: <ar39V5wIK1LGLXx2@pks.im>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <URLs_not_just_msg_ids.d1e@m5gid.xyz>
 <ar0OltAkeTiCx81c@pks.im>
 <xmqqeceaa5h9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqeceaa5h9.fsf@gitster.g>

On Wed, Sep 30, 2026 at 12:45:06PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Mon, Sep 28, 2026 at 12:41:26PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> >> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> >> 
> >> This document has used msg-ids to reference emails since its
> >> inception.[1] This makes the text a bit more terse, and is perhaps
> >> also convenient for people who can use msg-ids to link to messages
> >> in their inbox. But we should consider how convenient this is for people
> >> in general, now that this is a more public-facing page (see previous
> >> commit). And I suspect that most people will be forced to paste the
> >> msg-id according to the described URL template:
> >> 
> >>     https://lore.kernel.org/git/$message_id/
> >> 
> >> Let’s instead replace all of the msg-ids with complete links. That way
> >> everyone can jump right to the discussions.
> >
> > Fair. The links may of course break if at any point in time
> > lore.kernel.org were to vanish or change its interface. But if so we can
> > adapt accordingly, also because the message ID can still be extracted
> > trivially.
> 
> One caveat is that some "funny characters" in message IDs need to be
> URL-encoded.
> 
> A recent example I saw was <20260930061524.GNkIK%taahol@utu.fi>;
> https://lore.kernel.org/git/20260930061524.GNkIK%25taahol@utu.fi/ is
> the URL you need to visit to view the message.
> 
> Having said that, I am somewhat negative on what this particular
> patch does.  We should instead give both, having something like
> 
>  cf. https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g/[<xmqqa59i45wc.fsf@gitster.g>^]
> 
> in the source, and render a readable link text with reachable href
> when shown in the browser.

Oh, that's even better if you ask me!

Patrick
