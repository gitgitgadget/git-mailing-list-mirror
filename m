Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618303A782D
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166096; cv=none; b=R20yRnAHQqdtFADRUhlMTKvwoMTBEzTjsLT8zZguZx28eilLBEYviOPcoWcEYZINtAhSXFULcYHkbkYZ7QzhpO4qilxQsuR+ODilaXE16QOVKh4ZAMFaqTGE7TikB8jSL+vxW7QI3aS538g28KM1SC2h5pn4DKv4hY4iabaOx/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166096; c=relaxed/simple;
	bh=pU46K0t6DzEdfYRwg2ax5FLd5jhELrWv1Bybjl9+zWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2E2ojN2MHFYk2mmHANdYSSEiSGMDM4w3w1LWJtDfgJNifrca6nGWa8u7exzUDJR0b9Dczf+ELMtDsqWNcMC2JoxuX1e+qgMj21kLr39t6V/mXgA1fYjtSriE8M2hmjC6cvEMZTYNnYmewIJ5qSi4urcEXuNVzZ3FCbmhuFsFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cSSZPzSX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fYXlaLBV; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cSSZPzSX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fYXlaLBV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E7F77A00AF;
	Wed, 23 Sep 2026 08:21:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 23 Sep 2026 08:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790166092; x=1790252492; bh=UoPXD7hQLH
	+d92bpyz3rh2YWcoOoOBlcH6+78nf0uSI=; b=cSSZPzSXGHRRqzSqvnkjAwmzFB
	t25u9zMAV0F1qH7ynzhDOKgZR2j7uHB1g+ie2XOPgAE6uzG2MvWg/u0xn1Nx7XOa
	ImYIt1bd0HW0UF+B5mo2jZvO5ifmP2bnAzTq0/0jrhDLNvj9q4XWqw++CcVs9UY4
	WczKn8cEzHdW7goySB1fwzHFuu2a0K+c1gsuhtaeM9+KS0Iy00jduQncGRJz7nAf
	tvduCmo5u3W9pJ/M/sI4hTM0j+vIVdmn4BCxi/xJdGX6UiwT1Ewg9hqr+OErgNd3
	IjUfs3cdUwyy1zA0Q3ClZUPvyfUn61flW3tE8mOlZ4hH1ScjyjnXRAsnFB5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790166092; x=1790252492; bh=UoPXD7hQLH+d92bpyz3rh2YWcoOoOBlcH6+
	78nf0uSI=; b=fYXlaLBVVkN9ajYXOS0GA51AXTcxJ+PHVNZ8Wl3WbtXGtQNPTyz
	6Kg0c4Vym74oCCgHdjfVa22wZi/nkfkFlJs4C/dMPcZO9eZxL4EMmqhz0zrnfxXo
	DHWCT7UQ5qEL8WaJgCJbALntyGeITUiaIUToMVZy5s4v/7HZFsj2SssNwFJtuVkR
	BXeVTij+yfbNhaRuz3ePs4M2bfDI+Vp6AJBXo2JRtWlo7ZeFVXS6t0S2zJm4iPpD
	b0fF/lFM/l2hwAw51zXGmflaTXXSNdRpQQfdkqxCf7Qz3ja3NCNNeM3UKekeM87b
	OtQMrWiTKaTaTDnoBx4TQn7mT8OGe3g14jw==
X-ME-Sender: <xms:TMSzaifwtursFCLLKKrDGdFFxAlYSFzoZt_CBAb7QA3msWPJUTcnfg>
    <xme:TMSzajExyJyobvzhT_Th3SjrqtCVYC-4um2n8cK2usiwAI-p0jHibFcsWXMiCLD1y
    mv-EgMS8w7Fgc0XOWGLvuHwVH-2_fvuDeEd08stKttB3spuqTIvPH8>
X-ME-Received: <xmr:TMSzar2KrRfKrxzwmcE3SfYGRSr0m5VfS_nMqI4ZwsXDq6G2govo-w>
X-ME-Proxy-Cause: dmFkZTG4IuTp7OQgNncJ6JDLUPhOMb9jhjqutEWCpczmBP/CkhweCl2WMm7UigCfiLxNhX
    ICZzG/N5nFb8eu02TYF4SzdT1eYfqi5Zl7X0ACmMMudncxaZxVM1I4dAALACHuYS/rZc9I
    Vi4p+DiEGZIofVtgLYCI3Nq+VhACU/MgS/zHDX680nHYd4DBpc9Xfp1YNSP8Mgk3GTCtMj
    YaGez1Q6eKKVg4cJjMNyanFEnR01IE3xwuuMd4sVU+c3fbF7A5l1nbi/EhLMcLQ9X9CHdb
    t4W0IRHSvcuXFTwapT/CQN0zF65SBKLfpIbKToH39pTCrVWlGVccVux7JzwyQp0nHrHpB+
    0HRXSFW/pnhisUApUeazkFoZwBpm28kXrC4Y78sJwSPLm1LETOemPlZ/ntMTOMfpgSSIFb
    ww4ha6Tqm7SbdaLqzlW798Hc3MwZzVX0+OFSUEK35SRxDdSjeDsRJTavrhfrcme1P8N9Ew
    sOtMwZUXgohbqXeeGdFAVCiAIlQk2Fpjmx87oeGoQ5T0UiEg6QeZlg45Fkcfu7ImaASoQR
    pQrTQ8JzqrLMGxVVaXaXPebCvFqeRPTGX2B3wNNtj0LQIT51EQgqQi7XfB87B4RqEVlLq7
    Wxk0K9xOs8ozkLLYhipJIt1motYK155NINs86TG/wQJhSVDW7NmrY4jmirow
X-ME-Proxy: <xmx:TMSzarkKZ1F--xu4SlQuLLmd4tuvPJ1oN3Mz21zAS2remi_2GZMwXg>
    <xmx:TMSzar-DI8L16DKnlyQ8sBFyU6QOhBjHMUK6stRug2OxifTPyoEPAw>
    <xmx:TMSzagoMjauEcdWSezP5qCzVCkj6lFtG1RekTcrYIocAU2XsZmfb4w>
    <xmx:TMSzaklkUN9oz4mjXwPMyREtz-jLrfn1d4_evsFxtMhIYAwJH9O-qQ>
    <xmx:TMSzaoDjhfij-2TNV3DrZ7Yy9dYNwrx4kCQQ4ZgmFWmJi8O7-Ijn-Fx7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 08:21:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba083ea0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Sep 2026 12:21:28 +0000 (UTC)
Date: Wed, 23 Sep 2026 14:21:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
	r.norouzi@proton.me, git@vger.kernel.org
Subject: Re: [PATCH] reflog: fix default expiry periods
Message-ID: <arPEOdE9SKyOd8EJ@pks.im>
References: <GZicFFe4cqB928v52ERTcEFaAFtAwL0rp8VaCKSMyYzJ48XbQ9XoduiDtsou0Qp4N2CGmCS49uRbxi9dUWwlFzgzlt0PkGzR7IkqysP9tVQ=@proton.me>
 <20260922165433.591551-2-pushkarkumarsingh1970@gmail.com>
 <xmqq5wzxfb79.fsf@gitster.g>
 <20260922180251.GA18803@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922180251.GA18803@coredump.intra.peff.net>

On Tue, Sep 22, 2026 at 02:02:51PM -0400, Jeff King wrote:
> On Tue, Sep 22, 2026 at 10:27:38AM -0700, Junio C Hamano wrote:
> 
> > Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:
> > 
> > > The default expiry periods for reflog entries are reversed in
> > > REFLOG_EXPIRE_OPTIONS_INIT(). This causes reachable entries to
> > > expire after 30 days instead of the documented 90 days.
> > >
> > > Restore the intended 90-day expiry for reachable entries and
> > > 30-day expiry for unreachable entries.
> > >
> > > Add a regression test for a reachable reflog entry that is
> > > 60 days old.
> > 
> > Does this breakage date back to the beginning of the reflog expire
> > feature, or was it working perfectly fine but was broken sometime
> > ago?  Do we know where the breakge happened, and why?  Those are a
> > lot more relevant things to describe in the first paragraph.  Once
> > the problem is described clearly enough in a simple case like this,
> > the solution to the problem is so obvious that latter two paragraphs
> > do not need to be said.
> 
> I had the same question. They were flipped by 8565827570
> (builtin/reflog: stop storing default reflog expiry dates globally,
> 2025-04-08). That definitely should go in the commit message.

Oops, indeed. Thanks for finding this issue and fixing it!

Patrick
