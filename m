Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85F1136658
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759184637; cv=none; b=sMKWfRdk+KWd78ctCbZ+J1t6j4S/qs2mrnIhwR7qaOb3+fwcTuIxegYqDDjOpcEghPsMTc/HJoSW0SIcMsHpWsYwK8X8XEdoW+c3tsIbX6nGxRb0iWa2UzhuN09lu7TXu7o1/8G7vdXwaWazhKHoSt8eEB5OwlHQVOv8ej2Klww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759184637; c=relaxed/simple;
	bh=EHUeJ75+8fHad+yv4UyK4bezQX4JPSCsYeaxFPeK+cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zwpt2elGd/Jhl0zYIvnzryMK96e0GlGGoIU9+5mKjOgfns/+M6D0yekSfDgUCe4hBHxN0VxJVj9/gP5hfmj9UBuCE9d+3HFV1R9gQ0LTZUHzLZPfObUW3T/Ttn/AxYqZK6eu+IuLZmOjp7wl9Hy+3KPSCAJwrhsh4JaCIHU3eyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jXYsAtn+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J5c1Qy7E; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jXYsAtn+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J5c1Qy7E"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 01570EC0229;
	Mon, 29 Sep 2025 18:23:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 29 Sep 2025 18:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759184634; x=1759271034; bh=MYywvxWVMe
	7B80ZHBg2Rbe156DAHKD04dhl6FGffd9s=; b=jXYsAtn+SOM3xpQDBPD/D/hPeG
	LP2gIPlmyfiBEPj5behkS+tXdueZXaXXtVpKMttQnpt4CcWfOIq6Vif5r1CYHRpT
	kTmFVoD6xtdCYJQQ0rIwYifhTvTqG3+eemEumsLXaILF/8vlFGjbJ9aMIExRLMJG
	4jG1JctKlordenSEb1WNrFNJVn3AF+Y+LNXRNQNYjhb+IEPE0Kthz4vsjpVhUHHh
	5cWuVXdkFzYiGLKyZbjU7QUM+/gFJkq2XcaRbyfJWnGMwgT45e4H7jXW0KWPEizf
	biYjNonRlo/8+cOz5D8eVmJeoKt6jsLDa067w86N1fYY78gbaj8wf86wEPzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759184634; x=1759271034; bh=MYywvxWVMe7B80ZHBg2Rbe156DAHKD04dhl
	6FGffd9s=; b=J5c1Qy7EIVxgeXBCOwUmkLvBF7wi0tG7SiOGpEbTxz+2zRrWnIM
	k/bBLE9JjaaJAtMWiZTzu4054y0T8NsH48wzr8uthwBYBbLXrYS0PdxIysSGsUX8
	LQ0zKZ9mWNBF/RcNvoATlA5jIvd/MzflvXdocp3U3tbb2EcU7riaWKGKUSN77yxI
	SRmf4bLp5W1tugl2LWzFcO3fz+RT2jQAnMsYa+kgDU70T9OYumkDtHJku3XdOiEk
	HHKu9GamrL6j0YHpiBjjPGvhphk+LGMoIaR4dFUWxDBQUT/PoEj7D4wbHrTl/ipY
	nbtQC7A6loF9cFFRaLakALw+Y6QfU8uEHXg==
X-ME-Sender: <xms:-gbbaHv8eP8GeGYBay5sD6A5Su85WgJc76rBonNEVZKj6artDGFrzQ>
    <xme:-gbbaPfC7EcfKI_kPxh47q0TSmyfQg0xs9jGvHED68WhGOwHoznH1ldJTyReVLbKr
    7Bz_JGfOGu87BAH0B8DlrftCbFTe4np5zhzNcAHKarHCO3EUkOgdA>
X-ME-Received: <xmr:-gbbaPz6lrJKUuJSz7woLCm625Y_foAc40CfbAf5dw8ptVcqyINXxEUnsex6xka9ansbJ0CGSEe6pjLEA4wvdLflwAtV1f65VJrRLMRTqYU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejledulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhm
X-ME-Proxy: <xmx:-gbbaFFTN3Fr0JlIwUR_1jHAilxN439lLGF-463ILXGmgoJSe3rxNg>
    <xmx:-gbbaDx1VqNRFMeqhXMZSNPVuLKKS6RN7FA5V2PQzAnFp2QOpiRyxw>
    <xmx:-gbbaGsgCqNN5nE9O184ql_CNAL29NL-XWzAuWZGR7NDZ_BK6AZfTQ>
    <xmx:-gbbaA0D_7g81caJpAZql1qmRxlmdITm0e4J-yXng7lm19pnljusZg>
    <xmx:-gbbaNC-l8h_DPbTlO3TdONsaXiC9LKUGB7ptXbiHdzTBa605DcEVnoa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 18:23:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0321f980 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 22:23:53 +0000 (UTC)
Date: Tue, 30 Sep 2025 00:23:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
Message-ID: <aNsG9kmkfoToSmAD@pks.im>
References: <xmqqldm0am4b.fsf@gitster.g>
 <aNhX9AJ/zq4IYhmW@nand.local>
 <b583b17e-96a5-4f22-8cc4-acbd3dfec82b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b583b17e-96a5-4f22-8cc4-acbd3dfec82b@app.fastmail.com>

On Mon, Sep 29, 2025 at 10:12:31PM +0200, Kristoffer Haugsbakk wrote:
> On Sat, Sep 27, 2025, at 23:32, Taylor Blau wrote:
> > On Fri, Sep 26, 2025 at 03:24:04PM -0700, Junio C Hamano wrote:
> >>  4. While the above cycle is running, the maintainer may queue it in
> >>     'seen', for two purposes.  (1) not to lose sight and forget
> >>     about the change.  (2) to catch potential conflicts and overlaps
> >>     with other in-flight topics to keep their interaction manageable.
> >
> > Perhaps a third purpose is to let the maintainer (or those who use
> > and/or build off of 'seen' as their daily driver) detect any bugs in
> > that topic, or via interaction with other topics in 'seen'.
> >
> >> The time taken during 7. is pretty much fixed and unless we are
> >> willing to sacrifice the quality of the end result, cannot
> >> reasonably be shortened (note that this is based on the assumption
> >> that "find any remaining bugs while it is in 'next' before it hits
> >> 'master'" philosophy is working, but we have never run experiments
> >> to shorten this to say 3 days to see if we see more bugs on 'master'
> >> yet).
> >
> > I have mixed feelings about this. On the one hand, I am a little
> > uncomfortable with the idea of shortening the time in 'next' to fewer
> > than 7 days. I, too, have the feeling that having more time in 'next'
> > gives us a greater chance of spotting bugs in a topic that is otherwise
> > destined for 'master'.
> >
> > On the other hand, how many people are using 'next' as their daily
> > driver? Of those, how many are actively looking for bugs in the topics
> > that are in master..next. And of those, how many are actually triggering
> > unique code paths that would expose those bugs in the first place?
> 
> Theoretically all the projects that make heavy use of git(1) could run
> `next` (and `master`) as an alternative configuration of their
> integration tests.

At GitLab we do: we have nightly CI runs that execute our integration
tests with both `next` and `master`. This has already surfaced issues at
several points in time. We also have plans to roll out `next` to all of
our developers, but we haven't gotten around to this one yet.

Given the daily schedule of the CI runs it would be _okayish_ to reduce
the 7 days to something shorter. But realistically, not every pipeline
failure is noticed immediately, and sometimes we have different
priorities before we can dive into the pipeline failure.

The same is basically true for those companies that deploy to their devs
from `next`. There is a certain roundtrip time: the new version has to
be deployed, people have to start using it, and the bug reports have to
trickle back to the Git teams before they become actionable.

So I don't really feel like we can significantly reduce these 7 days
without losing some of the safety.

Patrick
