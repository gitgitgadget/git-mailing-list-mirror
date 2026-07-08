Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D9B3FC5A4
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497970; cv=none; b=nivOr8Eof6OXhS0ySV+BnDXb65W8RXd4Wn5O+Kc3ihesPKxsLJfzIhgx6s29d8sJ1tayrHAtnKsGWncrDjQa+Dqcn9Ah1Uj2tkkVHzD0NRA3f39ZnJl2EEhlgm8GUSwsZmz2295x0PXDJFgEby/Rs+PAwXwg7FbGH2N5eWGSxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497970; c=relaxed/simple;
	bh=VnWPV64elvsFobHU2qxNEQdefIslz+d7TgKc50fw1l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt2UGbqIK3fIHY7jXkkrhG7hoBccOf641P2nlPY/wcI/+vU4tC0JsGLxdGVGIb1CMeKUlZavAxxa4RqFTlRPV+tKb9DkUHQSZy0uGq5EzVaVxtGGbedaRhpsKbxC7+0mKR1rk4L8oIRJ2aILza8IMKMX1bw/SLOd85afhj9zLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fjYdstsS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gUeMQWYo; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fjYdstsS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gUeMQWYo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7133E14000B3;
	Wed,  8 Jul 2026 04:06:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 04:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783497961; x=1783584361; bh=JaCIm6hrAf
	Ac3PV+QWZ/l8fi6tqp7eEjvLQHDdZpfEI=; b=fjYdstsSlsZcAJ1S4NcnlovLBk
	eJnDRbEcX26Q9+t4oTOhSXD3mt+B2TvqDUX9t+BkWhPs9ZPIR5VN1lGyV2jvRr5f
	djnQm1TcVrK3vTDr9+KgQlA9OxYJyHbJ4MqhlmWyngY6HEAjehZ5aI/li/ZYyqnb
	Wmp6ut9Ls4c42r/kEYXSUr4a25KkJiJkiZoH2w2kelFdkBI1c2y9kocH+8pEAPvx
	72IoLlvYW2JGghJ6TV2lzf64bLbkurbKkF3CDDn+EohtaZUyApAvNuLNFuxuFSgH
	Hek+ExC0tESn66Z9qW0c+RgW4IRu45VuVB1JhsHVpvNV/8gw+7Gvj0Y5baRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783497961; x=1783584361; bh=JaCIm6hrAfAc3PV+QWZ/l8fi6tqp7eEjvLQ
	HDdZpfEI=; b=gUeMQWYopDQgmkyn7jeaiB6Kr5KMKxq6WQOjlpQzb0OwHo8ZvTW
	eb4lBSN235ZbXoQc3yvwmiIgUs7MFW/HXgcxkwDzCIqh9D0BBtXHEJ9On40YBGf5
	5GBn7k0SJv9ANJYytU0bZ+keSQc700g3cjogWNS6tEGfQLBBA/KBWlqoyYxeZhQa
	ak1dYhQMO2TuON8EFqMyN8jIzbG/h1BYLjAK79bt1XyM393gL7BQ8oMSA89WT60i
	CFFcDz4DlY/1Y/lG1OYslE6GbnMUwiV1dHcAx+i3gO6FOVsvEuaUhZzrRqSIAXGk
	GyQfdAAEfZGqAI+tlbqKE3ZXDJrp43jhuxg==
X-ME-Sender: <xms:6QROaorLMAT1regeTsg4eUFucO82x1Nq9Wc5RfQ3bGAWBBX_wkxWeg>
    <xme:6QROapOzxlzpWmhGh-H62WQfQtVZKnjNEv6wKP4BAsbjNSwh4yIaqhfM6NZmRyhcd
    L1MycFg_SlcPtK77JVd7vBjztmz6wY5Ye0aLFLKkWiLyf3L5VaocA>
X-ME-Received: <xmr:6QROapyVlOQLvWTJ-CTg27n27xkiRp9bgotjsijidvpZrS3VDb2EPlj14DBUejTezkZS6SgOisvVTD6-JJnGyfwa1U1_3CFBtP9_N9y7>
X-ME-Proxy-Cause: dmFkZTEtN05q0HU8GwkyGGs7gBGR2680jRQxI51Lqwoiru6pfeWIQCPLHXjzSWBq/Sy/kH
    JuXY2dy8CI4r2TvyNJRKEOwsTkZKxIxOrb3qRaIZxBTBIR1pY1idRKGSbgIAt0b1VVfgJb
    O1vbGfZCQcyFPBXe+prusdLyNICfILrEjCXyJr2rk6d47aRLqbM46TjwGJsi/v02r4KhNt
    +14Q7orGQNKWV0tWWH3Kw1pk12Y5rGGQ3bTDa1g1ZR+QraG2TcDez7U4wX5KIZ/jBfYbWF
    IjXqNQI9WsA68MWjezPW9fq10bF24WNGWmtC+e7QnhmO0JBRj3Fi+oEWAVLxh+fR3tc2hY
    KPEKXdZQK2UZZY/MCGuthxpBiq4P2w7bF/sSlvZeEeC//2ELT+gwqegDgqGH/6DbcdOjF9
    ghMT/v5m43hUmmXd+SVs3V91bsWGRm6dIqmDBVvN/+NIg5+lkhBcVxXKKxEptnaqxvGsuH
    wan1EfIj9RF8ymaI5P1nYJGRuHDRZEyelNyEbLERlQHqQQ3a3pmYcGDxrMCQI47yY3zZ4N
    RppHMBlNuaP+GQ7XX0iZbvZiw8g4f+57qIBxFhtNx27vMgjPMPoU/f84fguqf1thguxmdV
    zSoZ7PwYbdWBa4YHooqvMBBsnpGtb8Ja4XCSxM8UMw01tgsCORaGmeWiumeQ
X-ME-Proxy: <xmx:6QROaisRv7LYhe8CjpCfuQ34IVWtwsJdE_gO-x1-2aZIgQ-zXKDMDw>
    <xmx:6QROai4_ATFap4NRKg1lElPDoP9LoPST_59-xPAYgPq7B9msIq2JaQ>
    <xmx:6QROahROnqbhpsSyAC_yBw23fE3NvL0LE2XItE2swFpPo4HIj3JNzA>
    <xmx:6QROahodKplEL1j11d561iQ3RLvD6_xczZn0cCNCzk35QjLx-BhDig>
    <xmx:6QROatQknnveoNgYRfj8fah8Ku-RUW_bINbnBd_8Jv9hsyAgu5afUwDj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 04:06:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6c62210c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jul 2026 08:05:58 +0000 (UTC)
Date: Wed, 8 Jul 2026 10:05:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] git_hash_*() quality-of-life improvements
Message-ID: <ak4E4-jmgYFSI75O@pks.im>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
 <20260708035235.GA41491@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708035235.GA41491@coredump.intra.peff.net>

On Tue, Jul 07, 2026 at 11:52:35PM -0400, Jeff King wrote:
> On Tue, Jul 07, 2026 at 12:55:57AM -0400, Jeff King wrote:
> 
> > This implements the "idempotent git_hash_discard()" discussed in this
> > subthread:
> > 
> >   https://lore.kernel.org/git/20260702080707.GG2029434@coredump.intra.peff.net/
> > 
> > with associated cleanups.
> 
> Here's a v2 addressing the comments so far. Mostly minor changes:
> 
>   - fixed typos noticed by Patrick
> 
>   - dropped extra braces added by coccinelle
> 
>   - dropped a trailing blank line from patch 1 (this gets fixed in a
>     later patch as we add more content after the blank line, but I
>     noticed "git apply" complaining)
> 
>   - a bit more explanation in patch 7 about why we don't support
>     idempotent final() calls

All of these changes look good to me, and the range-diff matches what
you describe here. So this series looks good to me, thanks!

Patrick
