Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256918DF6E
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223749; cv=none; b=fI3cZA6rw75MbgiPYCADEOKp0We896afXPB7cd2NT9WTIXJNJ338QQrYn6b5NGa91JXcKkepk4KAZOQuGqV34fZE7DMG0URNF4rjtNtNlsdXfSNQTc5YlUnbgFLxM+a2GiMPLjFNQNHUdyFUlsW0sRIGSLmtcKUZF3l2jRt2dgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223749; c=relaxed/simple;
	bh=7jMHGsezCkQcdJypJbdJ2DFtiolg7PMeC0V+qWD7qDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj80zi7NM8d+rzwqgtiYIbm7Qw9g7rTS+Yc/M83YWODlPi3pWfbe1ubbzY3RQ4kFMbkD7WnrTVtqcoThWao7uwoOx8uwBguYZryxS71OJnu0n92oVsETJJlXrVT6jhAwOECgktnBLrDNFrjVXl9tPOzck4iKgEDw4XpOzTQhanE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZdnxpLad; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N/yWYusi; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZdnxpLad";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N/yWYusi"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B80207A018C;
	Fri, 11 Jul 2025 04:49:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 11 Jul 2025 04:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752223746; x=1752310146; bh=NhfRWSgNLx
	WRwpFCes0nNlSAnIw489Hl5/zQ0NcmPDo=; b=ZdnxpLade22t7p5Du/lpK3Peks
	7LzCriHG/7vRACI8vBxiivxxa9JXKYs4F51xt1L/zjjF+6d9DKan7ND7msE+IVdX
	crKZPN/e0u4855/bj4mF4hoDDHsMwYkU4+r+SsEKiekb3K8Eyi55+seR9jhqkzaO
	wyJTU8RJLpyC+9V5NgWaqwI5mOwck7AOf1TNl5TMoRvAf9uBJIkSWVNrMO6Q0BXx
	1Yxe3febEuIQYI5cHkciZK/ir+cFU4ZnYQ9umDGLQU5k85zrKIx2pqil9TCRIHq7
	U43B15/a44I8Gfd0CSLCIPuFMTUJmk2WfKvCeg7BjoG1XuC0CFLWowTdPeTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752223746; x=1752310146; bh=NhfRWSgNLxWRwpFCes0nNlSAnIw489Hl5/z
	Q0NcmPDo=; b=N/yWYusiWuBv+IM86jmKzT/bxMKUgCtetyAlV4bO9V3rAB7Sk6E
	wDdRvi7ca+Tgzw493vY56qzudUjUPPYn1LMNDsSuDjFLEidpVPdXKQHumQk+K8Ac
	PfdqkFLJWOPdHsXym6rKlwgBGYVLkrvZ9MLjXQLFG2mupAQNkvU/mb7f9EnHesGs
	AJBO4wwuSsUxMyotDRtltmlz2jR2/BTCoQz3ky1Rk5b96gT1JYlLn5lMwYyj/7cm
	NOzAUXhh5T1RyO70UM8TiHIEmDoL/JRKZ2UtmkaO/XZ1McPCbsr3GzYMSeojE7gd
	K8ne/1LNI8R6a4NquSJJlV9BC5EvBUkx5KA==
X-ME-Sender: <xms:AtBwaCcFlrj6iZMULMT7BoqW3kalp5XOtEro5YZHRa9KIBEkdu9cbQ>
    <xme:AtBwaDG31lzzEw58tuy19-GoHya_tlbhqYhRB0iz8hJDfyPZrigivgFD6HFVXgIR_
    U_CRUmT90zBA2vXmQ>
X-ME-Received: <xmr:AtBwaAeHv9kOS3ApC6-1hN-z_Ugaz9v1oWkUL2r3GZ2PQDIaIwRKcdOdjCHFAt8J08KRtupF0Z8FIRfo--AzLKZufQvP3GY1nb25_Tr8sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvdekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgv
    shdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:AtBwaNHRI8Ts0tQf_meKSyl_o60DhajpKL-ulNK6WRNOjXWNUT8j_A>
    <xmx:AtBwaJXcnL8sq4Wrk6ndZycSfbjCq_NdppUSFIcDo4aucJ6w6XJFjQ>
    <xmx:AtBwaELXPYHzOh-IRce5-TMyo7GUni9ffbIJFE1YlLci0AP-cp719Q>
    <xmx:AtBwaB8BshzFRk7Ox30fOD57vlebXFQyiKTd_ISZ9fqxVSGRab5Xyw>
    <xmx:AtBwaNASL948_tqEbZS0vrO2DIV-7gNDoD4UVdux4XqWlt_7yikcEW87>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 04:49:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d3053e05 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 11 Jul 2025 08:49:03 +0000 (UTC)
Date: Fri, 11 Jul 2025 10:49:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [-SPAM-] What's cooking in git.git (Jul 2025, #03; Wed, 9)
Message-ID: <aHDP_GK0ytKkp_3n@pks.im>
References: <xmqqv7o08ocn.fsf@gitster.g>
 <f614e1c8-91a9-4430-9d60-5aca05170b4a@ramsayjones.plus.com>
 <xmqqo6tr698f.fsf@gitster.g>
 <61a9185d-8ed8-4794-8f7e-1ed64503cc62@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61a9185d-8ed8-4794-8f7e-1ed64503cc62@ramsayjones.plus.com>

On Thu, Jul 10, 2025 at 10:44:07PM +0100, Ramsay Jones wrote:
> On 10/07/2025 22:12, Junio C Hamano wrote:
> > Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> > 
> >>
> >> How would you like to proceed? (yes, I haven't written the commit message
> >> yet).
> > 
> > ... appears near the end of the message, and the way _I_ would like
> > to proceed is to make sure two parties involved in overlapping
> > solutions to the same problem talk to each other and come up with a
> > solution together.  The first step to get you going would be to CC
> > the other parties involved.
> 
> Oops, I had intended to cc Patrick! :(
> 
> > If the controversial step in Patrick's 8-patch series is relatively
> > independent from others (which was the impression I got from "more
> > or less random cleanups and improvements"), one approach with less
> > friction is to simply omit it and make it 7-patch series.  While you
> > and Patric work out what the best approach to solve the libexecdir
> > problem, the rest of the series can proceed without waiting,
> > hopefully?
> 
> Yep, that would be my preferred route.
> 
> Having said that, Patrick's patch does remove the regression, so we
> could keep them separate if that is preferred. I don't mind either
> way. :)

I'm happy to just drop the patch and let you handle the regression.

There aren't any dependencies between the patches in this series, so
it's as easy as removing the patch. Junio, do you want me to resend the
series with the patch dropped or will you drop the patch on your side? 

Thanks!

Patrick
