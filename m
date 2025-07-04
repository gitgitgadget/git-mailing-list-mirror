Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51751FDA
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 05:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751606003; cv=none; b=rPRO/inDAMlrfL8CXLxyigCY+2Rv0lSjT0RxSNUNl+QzOj0vgaMH988Qhw0W3vKpSLza7oHVukFej7pXOs7INXcD3DRuXDoH9LZHI7wwtZWeQeBMT6QuYfBaThuXNxFQIldNV9frBAY92qYeAkAhNVWyKcbKzLdG/Zo8tJXPPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751606003; c=relaxed/simple;
	bh=WsZq1SJwZA6zPKJn86jEjoA9HBeZQmOkcKjcF20dd7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zwa6d+XUcV4SjHerKcO0/LMi6Ry3zTWNL4v2Bl3allzaecWmCq+LpZZU5EgO9SGXWXxGd5mmae4+qhjo4Svo085s02FZai6vBsz4CQcXy9U0p0gSGUNmxbuYBBciJKWrpiIzBOJaIoEZEjnIym3eHJF0mpvlKsMylcJru64pKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uW22IBX8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z4bAdKc2; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uW22IBX8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z4bAdKc2"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8152B1D0012B;
	Fri,  4 Jul 2025 01:13:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 04 Jul 2025 01:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751605999; x=1751692399; bh=Y8RdUUTood
	YebsjAyfN8mKfn/Xh2TDKl8yfr6vNkis8=; b=uW22IBX8pfZLYL9MteoLyjB45r
	3LgIE/khED+wKMKEmkisttqtTUBKSxvHsxvhW/rB1NvkDgJNb0F7+iB4oZaQa2aQ
	vzuC4hMPdYUA2ur3lIQ3djFYRhvGwaODMWQ4DsNcYkiNLPp75Q1A469xqETJ/bkR
	QXlVxxI0HCeK3kT4eowXkHZm93BOCVqCFBhNs8koaz/7q9Gp2j14RUKATLNlSkXP
	bWcU+Cy4PHo98QqIIoQnZ20BfZPb0yMtFEfBb7vhikDB3zDaXkbFOAxxy1pFNsqt
	yBEJHNAqxSbGBVir/hHV7tx/QVK8qcfBv23GlZpGrbkep4voWZ95k949oP+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751605999; x=1751692399; bh=Y8RdUUToodYebsjAyfN8mKfn/Xh2TDKl8yf
	r6vNkis8=; b=Z4bAdKc2yR+hxpId7VM64kOq0xhPd54EyfaVXbudHBUKdJdEviA
	CwmwdaPZj3howSCq9PD/Pwr7AyQo6TLFM/L9BU2zyfFjI9z3kRdefERDADT/kTiv
	NgoFImkzMBF93FZUIjuGTKNdR5Uyc7PbQnJoJYrlFjKQTFmmcrK2C4qwCQiXhqoZ
	i4qIqg7dvzoKAtgqFEr3QP35gU5Knl+H+e038o9+w8F/aI8qCuBylU+LqlKu8n2L
	rVQUsEWgVGZCW1IFJZgl2pJ58wu4clBQELI4ywXS+jlk5EQ3Ew1LT976tQGRXvaw
	K8thkXl0HYkSHpw4YU1t//KEyPCrKcm5kLg==
X-ME-Sender: <xms:7mJnaFpkxy8ZSIjuz9G2XTm1gAUO44WS5Zvj6wE1iYc8XHmeHjLAGg>
    <xme:7mJnaHqy_FJdVyOkkTyi_rbBNXo-ijRSrRr3npGpJl1Ph3f7hSuCRcG5JFJtSIYVy
    89VsY7LS0bQCaJNtg>
X-ME-Received: <xmr:7mJnaCPyyamAB_SGDhOkQjlJIxV3c371cQiaV1yokWNfi48FVaeRWjjXBR0fUxsZiY0_0VKex9sK8yiMU3mYxmX_XbdeWGxYgXfMJBX5Hdxa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvvddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegtvgguvghrsehlhihsrghtohhrrdhlihhurdhsvgdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:72JnaA73rpEvPR-JC5_PmMxIFNWg4-IlRvhwy9w7cHYYXIe03NM55g>
    <xmx:72JnaE6JoVqXp8tEpeQt8O0WzZHvAsgYpKoyNPyUnxsWL51k--_Pfw>
    <xmx:72JnaIgm8nAKmtmrLdtC-eKtcePmo3SOKgxBz4twAFVFpISee57VKw>
    <xmx:72JnaG4pto1wesB3pw6yT_mU00vzKkjkGOPJ4o045I0PeUUYS6NCSQ>
    <xmx:72JnaDLz1hRqqJ9_dFPv9lN8qw7hrmKZbXg_ljycJFIAG2ojaObJhYYH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 01:13:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 939cadd8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 4 Jul 2025 05:13:16 +0000 (UTC)
Date: Fri, 4 Jul 2025 07:13:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org
Subject: Re: Allowing "/" in the name of a git remote is a strange choice
Message-ID: <aGdi6GRbI6Txm25Q@pks.im>
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
 <xmqqikk8bltr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikk8bltr.fsf@gitster.g>

On Thu, Jul 03, 2025 at 09:51:12PM -0700, Junio C Hamano wrote:
> Per Cederqvist <ceder@lysator.liu.se> writes:
> 
> > Today I realized that git accepts "/" in a remote name.
> >
> > This can lead to problems. I have a repository that contains a branch
> > called "master" and another called "chat/master". Just for fun, I
> > added a second remote in this repository and named it
> > "origin/chat".
> >
> > Now, does "refs/remotes/origin/chat/master" refer to the branch
> > "chat/master" from "origin", or the branch "master" from
> > "origin/chat"? Git seems to think it refers to both:
> 
> That would have been a fun experiment ;-)
> 
> > If it was up to me, I'd add a check to valid_remote_name() to ensure
> > the name doesn't contain any "/" character.  I doubt it is used often.
> 
> If your remote-naming discipline is to always use two-levels
> (e.g. origin/chat, origin/chien, origin/lapin but never origin or
> origin/chat/blanc mixed in), then there is no confusion.
> 
> It becomes only confusing if you mix origin and origin/chat.  
> 
> So it is not like we can just forbid '/' retroactively and expect no
> repercussions, especially given that I hear there are more than a
> few thousands of existing Git users in the world.

We cannot just blanket-disallow this now, true. But shouldn't Git be
able to detect this conflict, similar to how a user cannot have both
refs/heads/branch and refs/heads/branch/nested?

Patrick
