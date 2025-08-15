Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA412472AB
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 05:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235729; cv=none; b=oKDk9K+/1y2Wex82mEAHYtQDVQRs8f+LkHqSeRUYNOa2SR8q4hkv3YUeyG7/hsCTXLPDA5OkYZ1FPke0O/0q167td9/kkZhBz8+WSO6CkYI0VGxPm41C74fzM++e1A7UORcLfuFsPnHbja41sRWpQLKa+kA3uYi5hyWmBDyOvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235729; c=relaxed/simple;
	bh=bm7DKWe/Iabo/41fhPOOLR+IhsJ2CLbuzg7CbR+rg+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihgmJ5NXYP8ZZ/aD5CwCjC5biiO6h2ljDD3Qmv2B4JIwRo06j9WI+lCfHX0K0P1kauv7F5Qdoko4X+srLL+s5UNVZVkvxcziD/vBv4ezXU4K3opGK6h8LK7AP+RJKf1qANAuDU8Q7YxEOC9PuH6xac9Z1jqORlleWqeK18vUOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UdHvKGIP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K8ZepqPh; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UdHvKGIP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K8ZepqPh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 827DEEC00E6;
	Fri, 15 Aug 2025 01:28:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 15 Aug 2025 01:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755235726; x=1755322126; bh=iNuokpE2mr
	MAxttC8pVphllZpeTtUnF6e0OKsF7K2QM=; b=UdHvKGIPH0DQMFJRSEmziiFe8X
	kOsU8l9uSEsx5J7BwU4Ez7tFvr0FkRKzBTdbVUI0oGueR1TllhvdGhe0ggs/DtU6
	yWTSNj2a8XNaG7sKrROVYB9pY+gd2oryEIEnx8c07dJhsY1awTvW8Gr6zngyHXK1
	l8k2tnUTYLqcJSak3brjxtdXBlYznrIEgjtrvRR2tEPt05HlMdxOd7q61VAbCpda
	+kbBmX8eQkU5Ob9LskIQE0ckMF9v+Z6T7WXcc+M9sI4cF+fhWNJ8k2gxhmbK4BPf
	0x9eLNl2HHxKkxYuNlp/euesXnJUNPVb+UIn6CY72YTBEPwd+KmvsKFVPYZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755235726; x=1755322126; bh=iNuokpE2mrMAxttC8pVphllZpeTtUnF6e0O
	KsF7K2QM=; b=K8ZepqPhaOkUbuIHWMvf/UsBu03XUsP3NjxWoD9JLx2pjpKrcbD
	/29J5bUVmu2IK1hLkrlS2+RuoRs2eTRoJwnPAO7UNromK2h5lnwrEICUL+so4BX5
	QE1yYjEpJQXCHOVzwCyH6WoFisF4CWPwf3fkxXkbvfMjf7KgCFMrsvK5/nhFDy7j
	fpFC8/9sTw1aBO6pRtQmDzcyaTt7e2hiqBOJd2VExwt+6cqGFYv6dW/aHju7v6+/
	X35vWE/BniWxDjG9SXu4PqwO4hh/tDHH4THDXcPz9VqNgWPZHWuFZNx1EUpxhLIg
	LyXgw+plPocUWPo1/7IHnBGiQ6RoE5RsF6w==
X-ME-Sender: <xms:jsWeaFps7uQ9MO1povw1sqG2Tbec5F7D-2wzXkBFrmIQ7QyTrUYobg>
    <xme:jsWeaK4GU9K8zE_8yjSwq9QzuvdX5mXpIUuT5dRWnDLx4e9IhbR1PFy_yd4cM236a
    S8tZ3E1kgK2CyG7xw>
X-ME-Received: <xmr:jsWeaLqvjBqm8B6KAwTkJViwobW6zaZtYRDOlKCERAh09JwAq2gJYzi2W8lm5gWAN7fQL2-mKnxuOXiEV7e9JksOqyhWBwMO6D0H1j7KxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:jsWeaMhpoWmZ48cD9sh_yn0COTa3nlwGWzxFYvRGFMVD-LtwGH17uw>
    <xmx:jsWeaFI7tf1fvlVpFdNaqaK3N0vWLkKEKjM0XZ3KRO36RK1Do_OZyQ>
    <xmx:jsWeaMD34BJkorvs8iA49ZX7gVYhEIwfJUNDjmen9N0hfhTMtXDMHg>
    <xmx:jsWeaFi9jnDMn-QHkT-whaJ9MI8XvtoSyYsOnysQGVbC2hiMDvGUAQ>
    <xmx:jsWeaLsB2xYUqm_E9PcGDcoE2nX1WENByLdN9utdPvAC4n1gJgW8PLa5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 01:28:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7225c96e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 15 Aug 2025 05:28:44 +0000 (UTC)
Date: Fri, 15 Aug 2025 07:28:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #05; Mon, 11)
Message-ID: <aJ7FiIbvZ8n1hB-y@pks.im>
References: <xmqqwm79x7ra.fsf@gitster.g>
 <aJs5Gee3ZVCJX8dk@pks.im>
 <aJtSqgJ7w02Ox74w@nand.local>
 <aJw5eenXu5CO5z2W@pks.im>
 <aJySUWSq+xFxhyZr@nand.local>
 <xmqqqzxfnudr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzxfnudr.fsf@gitster.g>

On Wed, Aug 13, 2025 at 07:55:44AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
> > On Wed, Aug 13, 2025 at 09:06:33AM +0200, Patrick Steinhardt wrote:
> >> Fair. I don't want to spend too much time on this signedness topic,
> >> either. So I'd go with either:
> >>
> >>   - Taking the signedness patches as-is. They don't regress the status
> >>     quo and allow us to warn about future unintentional signedness bugs,
> >>     even though the fixes are mostly of theoretical value.
> >>
> >>   - I drop the signedness-conversion patches altogether.
> >>
> >> The more important part for me is to get the second half of patches
> >> merged anyway. So while I think that the first half of patches are nice
> >> to have, I can live with dropping them.
> >
> > I'd personally lean towards the latter, and drop those patches for now.
> > I think practically speaking that equates to taking patches in the range
> > [5, 10].
> 
> Yeah, that is much simpler.  That way, we do not add more commits in
> "git log" that people may find later and mistakenly think that the
> project had consensus to encourage the use of unsigned when signed
> and narrower integer would do fine, and we won't have to see
> misguided false positives from -Wsign-compare.  We are better off
> without these changes.

Okay, will send a new version accordingly.

Thanks!

Patrick
