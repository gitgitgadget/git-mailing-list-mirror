Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0E415F07
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786600087; cv=none; b=GCypeQzqRC91Im0GE/v58wTMgU/mSBzL6I9ZkSzWYM2DPhRAIOI4BXAqgAbbMWv7BznuS9OFpT1D3UJC6z//DYhexfam22ID4AMynb73iYQhbYIqTCu3lRBRq11PjSnljXMJyxfJWqMS0l2FWcF+kXmBKSmfgIeZsKqCUjRdY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786600087; c=relaxed/simple;
	bh=BXoMjld/l4n5CKelz4o2WyvTxvVLNZxfdzYtT47mV5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eExSJynndMXXUyfwC2D/ozFlAGtxEU+3xMR2pZa7U2v1j3xvJ5Uh0WzElH3YTVp7ys1py/XvV7WqGtQ8yrAZcPFZaIinwCQ7WSpjzXJug7Nta2rYl2Bd+6Rfg6lWf7RZxc+joqhH2xCRD+gDlw4i2zQcuNDZNOfO3qHhELA730M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VkfYbPwu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fxAs2lcT; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VkfYbPwu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fxAs2lcT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 35DD7140013D;
	Thu, 13 Aug 2026 01:48:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 13 Aug 2026 01:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786600083; x=1786686483; bh=QGx7U5Oqtl
	JrTSe5cNHU45uT1bzfYgBwN2R+npw0kbM=; b=VkfYbPwuJTbiy9B5jCgrp+g4J4
	lvhpYuirb9JWbJSP87ghzmlV0gUIoq2LORVHd26uP6VcrYVV3XjpimD5y77b4jgQ
	g4ltqXfacztCssLyxCMqH6YvL/cA3kB9ez2D94GGt9gEsPfRb600HSDbTwFguhUn
	x9KN8uHMp2H6Oo2Y4FJ11KXP4nZ93dCDmOCyPY9Ezjl7dUPAVyvRYxcqTEPgn9Nq
	uBo54zGMZkJDGDliFQCGaUedRlUzBylPjGI/B5xn1IlT0HSDPruGh8vkx+QXqmEi
	/F9+mQMdRYuVO6xGvys6cKt5SM2L+6zJMlKpp6lHgnuCdl18LSmdhkaalsIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786600083; x=1786686483; bh=QGx7U5OqtlJrTSe5cNHU45uT1bzfYgBwN2R
	+npw0kbM=; b=fxAs2lcTzL+Uw9icshNQRtfq7eC4uFabmP/qgl9JxgKahXEUjuc
	GBhYuShCQQv30+hzmwC5QWivj7kdF0NfTUaIcq12knYsUql6WBLlZ6YCmsIqVgtT
	cmd/RusiSN86KWTsRwUwDD7lhMzS8/UEnxRQcpLVV0nscJO6i+oITvdgH+1/7KPB
	8HHUH4vwczP1VbqAkv6MgkGoDaoYZESmxdlWP8XavqvCJ2PfNe5zPmO2Tt9BYy/p
	L2QEoS2kYRAP1mXPNHyhIw8ogkGswXgLDM504beg8DM86hZpNMAzMKIsn2dbifXh
	NWNqU73DMOjwcE1Vl01JMuKE/htb26H8jbA==
X-ME-Sender: <xms:k1p9apapE9sdGkV1CPpQ7ADwemjpkY8Ya7phoJ83RiZnFliqXmNloA>
    <xme:k1p9ana5Mr9S-n19XndPxl59Yt7_BHS_SLbV5x5xQ_WEiH8GQU8wYLypMfodmke5e
    nGvSLFDKSrPub3kwCb1QuxtOiMk5R09xAn7j1eIQVYOnt3Yn0DlqrM>
X-ME-Received: <xmr:k1p9ag8J67WEFP-s7XDcOAQ80faw3UIaDalhgh6Z-Ibf-HRnbosh-b5NgIjcYyXndo6QFJR_yAiHIlXronX74csFm2ORY65lZMM_ByKSp1yS>
X-ME-Proxy-Cause: dmFkZTFrI7IDr9tUbscT3NVIlZotbcQDqDbXki6SSu4OqwR52VwB7QnScaVY7mVzqxrKMb
    fr0YpBUCVbSSZV9g+AfbwGb1S8dQj7Z6rD53N92uOriBsIzrpdmEtZpmqqU5Gx76Mp6JKT
    t7zqb2HYBfMfYw/ul5kDcoO5PSWhuKoMnIz8DZGOigqj9SsKCc5bbnvL1LfxiKP48xo1fD
    LSsY0IYb/ukVSii4NlBVvRjO15cui+eH8aBok4Rqs2j4fRjegdE2a4aWXpgx7/mZZRg6K9
    Ln2scACGKGQChgmcMjCIjkqzGEoKyrsHNSY5NmnIy02HZLYeOn2OD91CXu/sdvCi+ZCiSC
    xVRpsZR8gwUwsw0t5p0m0H46khfQUTwe91+3PJCgJg6ElSLIixHfGl3Y7TDyVfH2tmatqz
    CnmlS16SFFgtT4ixMsYog36US8aAFbPUhKyDXRKLrge5w8o2oFSCKdbP6frQbgVOz/6l3u
    SMGgeWRHYO5PCa3EphSLOK1SF5mtQJuNW+KkuBhPBFOSwTTCbT5HS+CGRJg2gF6NMQi5kZ
    SBIoSlDLAx9/vV+PG7aXXFyuGOcKGcCh4Kclex3XOZBR+vxIkoP2/nppw788cPZnY/Un9g
    JgHaGs6+jP7ZZhIKH16my4VBicKLmGlBHcZry1EyWnKsW6ZcLPfT72pdlSDg
X-ME-Proxy: <xmx:k1p9amhjKtSuRTmPoex-CEfNtR9XeCPhUTOvziTG6Kt6-OazvEkEUQ>
    <xmx:k1p9agf5fOyZdcG-pc7QyeFRDJkR_WjJI9jLjyaZZ8If73OKLMAo9A>
    <xmx:k1p9atqf_OtH42qb26v7k-xmAvSh4askX_fNPcOOHGLhZRyE0NmlVw>
    <xmx:k1p9alD_EGMta8dMY3dRf0Lpm8iwQ2xbl8l62-b5JTvwsxZ1vhmP5Q>
    <xmx:k1p9au5DvG-_n8xIuThE-0WFAGkKN5JASnZ4wFR2ducFr2jtC9taxLqa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 01:48:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8d314383 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 05:47:59 +0000 (UTC)
Date: Thu, 13 Aug 2026 07:47:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] odb: make packfile generation pluggable
Message-ID: <an1ajMjVRUsfu-lv@pks.im>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
 <xmqq33wpej49.fsf@gitster.g>
 <anlg2rThlBLavyU8@pks.im>
 <an0EkMZGEbg6LERc@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an0EkMZGEbg6LERc@com-79390>

On Wed, Aug 12, 2026 at 06:41:04PM -0500, Taylor Blau wrote:
> On Mon, Aug 10, 2026 at 07:25:46AM +0200, Patrick Steinhardt wrote:
> > > With "--no-ref-delta" thing in flight, this will not play well with
> > > what is in 'seen', though.
> >
> > Ah, dang, you're right. I'm not quite sure about the status of that
> > series -- there's been a discussion around whether it is the right fix
> > in the first case with Peff, and there wasn't an answer since Peff's
> > last mail.
> >
> > Taylor, could you maybe share what your plans are? If you want to pursue
> > it further I'm happy to add it as a dependency and/or wait a bit.
> 
> Still something that we're working on, though I think that it's fine to
> kick this out of 'seen' for the time being.

Awesome, thanks for the update.

In that case, Junio, could you maybe kick out that topic and merge this
one here into seen instead? Thanks!

Patrick
