Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66911A239E
	for <git@vger.kernel.org>; Fri,  2 May 2025 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746173173; cv=none; b=JrtHZ+/toL/CFqtwJNwZtpQzC52ThHzCUIukg6xOtNKvXDCo603AMasq7rzo+I50fyLLcjfTjcvAVUTs2BJqm83oW7QI9CMoAxLLxjzaoVK+7Zwgl6hqxTQ5T2VVAQYcFcxu3OPAF68wdq65BzCcF7iCfULGmjBkQbdI4CNIFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746173173; c=relaxed/simple;
	bh=O9n+KxMAWVBLoytvW150ynnhHkwRS3Df+rjCJ78LfFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXjzkDTuNWrHe4DWh9L6ZI6Rnc5jK54k/zKOxhV1ZJQbZLuwK73hYfCUEYE4+sXWqNUXWpwXYmWkE80ytkG+HUVDg7MqaKxCvE1h/xxxN6JSd+0emHcAkAXFulpEqJYazfbbVDKBh+mhvNqgqyDMvpKGIeu3Eu0nZDMaMZXb9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m+/dXarQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W1afLtSO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m+/dXarQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W1afLtSO"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A17E1380511;
	Fri,  2 May 2025 04:06:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 02 May 2025 04:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746173168; x=1746259568; bh=nLv7EgdBMe
	1qSlzmZxeYR/3j2rGUZQhvbpb/x+sGDnQ=; b=m+/dXarQAzZ+EKYX0RK5kwqxMW
	r3DPL2fYi7rUbL7c662X0L+pPPV2ZYLC79tg7xT+xs646H1fjuRRLw3Nph9qNY7m
	EZeJYpNdGbHHdq8q+AtJYXFLZ6AGUQuoWnRpqiImNYtMK4WhkqAPE1Fp6U1didJS
	Z9vaQWtsQ5kNNVsOhKQcuD51nPbaUWg+SqIfFbgK+C5tPi0kocQ58+SPnT7E9XlG
	+6MezR80r/4Gx8iZ6L4OG7cZ5RjIiWbZ7q7OvB1L3ekQhdc7Q4JvzKhcapkMp35z
	bRHP/AntzYpZppThI2l3YLBkk0qpFultCeZilFEcI5OStDGgWCyj5lRtZjPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746173168; x=1746259568; bh=nLv7EgdBMe1qSlzmZxeYR/3j2rGUZQhvbpb
	/x+sGDnQ=; b=W1afLtSOHXeaLk8/88BQcuJmNyVrTYF7+pzxPznzqMLw3vWAaoj
	aL5vPZqBPwFo76p4W8NrxqXhFUIgfNwLO2AZe4jpgj+F6mJ+I3D2eDzmhiu/nVe3
	ll/lSDAvgV/j+vldGdbdnpQYky61Qql5jiZbzXWXH5DWoj3UKZqOQaR474/LmyDf
	MeF/rwSMd70PSQQ6gLRxyt4CORt7VRqKhwn+gnuYdT6pmoZRHYlXYiKqnfa8oCsX
	0lJ8Fo8uMsxZRGWbmYrbN4OwOLOW9RZ3JHz0MXkN+it6bJ9Ql9kLK4RTgupiRGS7
	s8QNRGxSsdocdmJZ7W1JfoH3kV/QoO0p8pg==
X-ME-Sender: <xms:8HwUaMGD-WmDSmV-gigcndq3ukyIgHiNzDZCRN3iTpSkQSsQFhnrOQ>
    <xme:8HwUaFWbfmep-TYcnvfa3h__6ZA0GgUy7ri3nHU-LQdHZdWQyMMbG73Jdo8QpaYo_
    nF-TD3iOVOSS25frw>
X-ME-Received: <xmr:8HwUaGLZMrDdJov-UxI_Grvo3FLFgx6pZ_og28Mue2TZ9X_ENv4ALYN4jdDeYlT08vTvOYsqrWxsP16my6XkEHgi4b6MmqZLfqV5d4nDrb4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeduledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdu
    gfehtefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghm
    vg
X-ME-Proxy: <xmx:8HwUaOEGMFx8zXHy32Vo3xCgjvKiMyss6dhWXX0RvdOvWqsrTDNDAQ>
    <xmx:8HwUaCXYUBgxD2IyP2emjNhof0Q5XdnH5ttVzfFydY1Vk6DSiH0MHw>
    <xmx:8HwUaBPin9XRttMPmvpe5jjdEd7iVp0bzM_XMJmVTfFiwTGI0qu3mg>
    <xmx:8HwUaJ3lUfDlT4P49ID5rHt-08agjbxAyPbT00TI9tzOq4OamJAs1A>
    <xmx:8HwUaAHRUJ5LDhn-Ouj7XLdjlFWLHZ8tLXnhtUma8Xh-0SBprWTpDwNc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 04:06:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a8d019b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 08:06:05 +0000 (UTC)
Date: Fri, 2 May 2025 10:06:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] builtin/mv: convert assert(3p) into `BUG()`
Message-ID: <aBR86Ct8mMUN_tzk@pks.im>
References: <20250430-pks-mv-parent-child-conflict-v1-0-11a87c55ffb9@pks.im>
 <20250430-pks-mv-parent-child-conflict-v1-2-11a87c55ffb9@pks.im>
 <xmqqr0191oaz.fsf@gitster.g>
 <xmqqecx9z1n6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecx9z1n6.fsf@gitster.g>

On Wed, Apr 30, 2025 at 04:10:37PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> The use of asserts is discouraged in our codebase because they lead to
> >> different behaviour depending on how Git is built. When being unsure
> >> enough whether a condition always holds so that one adds the assert,
> >> then the assert should probably trigger regardless of how Git is being
> >> built.
> >
> > Nicely put.  Yes, this is another reason why we frown on the use of
> > assert(), in addition to the reason why why Elijah's series that
> > ends with 5633aa3a (treewide: replace assert() with ASSERT() in
> > special cases, 2025-03-19) was written.
> >
> >> Drop the call to assert(3p) in git-mv(1) and instead use `BUG()`.
> >
> > Being explicit about what we are unsure about is always good.  It
> > would hopefully entice those who want to get their hands dirty to
> > see if they can "prove" that BUG() would never happen, which would
> > be a great outcome ;-).
> 
> By the way, with this in place, and without Dscho's "assert() makes
> Win+Meson test job get stuck, so let's make assert() a no-op" patch,
> the CI seems to be fine.
> 
>     https://github.com/git/git/actions/runs/14765572702
> 
> Triggering assert() and BUG() are something we would always want to
> notice.  They should never trigger in production and it is an event
> to call for fixing the underlying cause that made the condition
> trigger if it is shown to end-users.  Dscho's patch protects us from
> addition of a new test that triggers an assert().  We won't see such
> a test get stuck forever on Windows, but by turning such an assert()
> into a no-op, we would waste electricity for running CI only to miss
> the triggering assert(), which does not sound like a good use of our
> resources.

It makes me wonder whether we should forbid `assert()` altogether and
use `BUG()` everywhere, similar to the recent discussion with Elijah. We
do have >600 callsites of `assert()` though, so we would have to
introduce a macro that doesn't require us to provide a reasoning for
now. E.g.

    #define BUG_UNLESS(condition) if (!(condition)) BUG(##condition)

or something like this.

And once we've done such a conversion we could add `assert()` to our
deny list of functions (wherever it was, I forgot).

> So I am inclined to drop Dscho's "build in release mode" patch when
> we merge this series down to 'next'.  Being able to notice a
> breakage (which triggers a real assert(), whether it is due to
> broken code, or due to a broken test that documents a broken code
> path---which should be rewritten to use "if (condition) BUG()"),
> even if it needs to be done by noticing a test that gets stuck,
> would be much better than missing such a breakage at all, and that
> is the primary reasoning behind my suggesting to do so.  I would not
> be surprised if I am missing a good reason or two to make build
> tested in CI ignore asserts, so let's hear from others.
> 
> Opinions?

As far as I understand there is no need for this patch anymore.

Patrick
