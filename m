Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286822E414
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770878108; cv=none; b=f9rt5Zjqo7BLmDuGolF5AP/IegTV5X5s+Zd4WsEsBigXuDg+5CAGbxuNXszLaXsKt2sbBkP5sbpuCD7eTwUg12j7HOcPGFVs1U+zaOatywbtHda7N9O6IG12phUfR0YWgFZmW0fN3PDdk3BRBXWTeNYTtwHljAw4sAq5ziqt9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770878108; c=relaxed/simple;
	bh=y5qGXRosrSzUmWouvU56yerdhTrP0++JgHnZl71HxE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlREghqrsDmTc/rLU8WuB6oAdVbWrfNS5uNev8aDCV20o50TIGN1TW8StQRVknLBOJtwCL2KzTK6R3iZi+1l1vJ91DdA+zQVx0Dynd5W7SSep5Mo56CtI/PgzpS9VYh2+CzjDenxiShZSTPL3XOxa1IQzj22kGbl7INQtvD1Pu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RDfLU2XI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uOjp7c3l; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RDfLU2XI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uOjp7c3l"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E80CEC05EB;
	Thu, 12 Feb 2026 01:35:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 12 Feb 2026 01:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770878106; x=1770964506; bh=RIYaIKwp2Y
	BqqMhkymgGwYmLYn8tsONIXAlcTmuZVT4=; b=RDfLU2XIQgtX8rzdEad8wLuCwO
	VPgJnHSmnXc9VAD4XsRd+XnnamUhtY9HyPNERvdI8RgSHCEz8zaUNdpmAJpwa70k
	EdQHOf1EG++q8+T4XoPkABTjzqmKr6rNQZwrh/Drn4zlMbds/IdYkWLvEXa9iJJA
	N9K+PPNEvEP+a5zl5BokAkMt9xvC6By8q+3AU3iyGWydsHPYmFqqk9fFwgy5oV+9
	ytDb58OucIgpiJybSqWOeBjbx0iLMbJAdy2ogfHDZmPxKi6dXJPI4sVfWA5vAI1S
	WC8i8BOCdr2lC4IES3UI2vZh81OZxVNDijl8gGebM3QFwPYROQ5voSH+84hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770878106; x=1770964506; bh=RIYaIKwp2YBqqMhkymgGwYmLYn8tsONIXAl
	cTmuZVT4=; b=uOjp7c3lwZHdrKNe0QZTX/GG6O5otuY6f+PCnRj1h/HIDCl31pT
	ViqoaCWjwBJn05sLOyro5O0THPk+0MyvfFuDHlgz2pbw7wT7rnRf73hIeYsGSUG2
	te2plOIICY2d+72nsYKub9kwwUXhOVIBPWrRqPpRn2/cyki2lFdwwUBwk/Ajjr5G
	MhA9afi2V/Q0NSuayF1dpXfIoRAmDOUfZqfaIrj0oOWa0MkMUkRjA1wg+8qLys/z
	IdGX6bSuRuCJ/9pR2/2l4JSzEf0tlMBnVNNtvUGM0kZ/RhNE11FAnTZTPrGqYNty
	dyt5ESaY/v1oNpPUgZLMH0vEaEzpDlNE/8Q==
X-ME-Sender: <xms:mXSNaWHU6gEL4uVVmGRKnLGV8MTCNr6apkef_hgKsAesMu9RDekDRQ>
    <xme:mXSNaeVTZhYFFpLZ6kGbAXxzwdzImdvARbuYsHL3EqBVdXSRmiiwwsY6pmJeu36F1
    CJyPrNQOfHVcT1jtXpaWJXvJfXijBXvIQlNHQY_G4g0dENheTLP3g>
X-ME-Received: <xmr:mXSNaVKE99NEPRDxGhpcGd6JzoE2MemYP7w1jhpLm1oZXF0UKCQIM0a0Pz0wpqp_23gmhb3uNd6FBOG0svCugYFNfBHb-OFTqhV8DQcRBq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdegieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:mXSNae8Q_ZHOQ-3bPtnLM2JFPtAv0g5xTdO__vgMHqwkrV7Nxyv1Fw>
    <xmx:mXSNaYIljBHgHTq3dIjuBozxNExdgRXchS-YJqCZp6lbDh5BhB-EOw>
    <xmx:mXSNaTkSzQDNjpiY4R6a72FvaugiS1ovZ1-FDNtRwMo3sJld71T1fw>
    <xmx:mXSNacMLJ1j9lLpR2c8TlpK8m3bbzSJjyVBXOKMCavlFcE51FGbqRQ>
    <xmx:mnSNafJsi9_5u8ezRHaobH190XYrdqiZW7DR8pWtmJBWPALkcFKMAdH7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 01:35:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bcfe8211 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Feb 2026 06:35:02 +0000 (UTC)
Date: Thu, 12 Feb 2026 07:34:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: ps/object-info-bits-cleanup
Message-ID: <aY10kwlEVuNVP6kK@pks.im>
References: <xmqq5x84xms1.fsf@gitster.g>
 <aYyQx8Yvx1n4W5L5@pks.im>
 <xmqqo6lvuqsg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6lvuqsg.fsf@gitster.g>

On Wed, Feb 11, 2026 at 09:35:27AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Tue, Feb 10, 2026 at 02:21:34PM -0800, Junio C Hamano wrote:
> >> * ps/object-info-bits-cleanup (2026-01-26) 3 commits
> >>  - odb: drop gaps in object info flag values
> >>  - builtin/fsck: fix flags passed to `odb_has_object()`
> >>  - builtin/backfill: fix flags passed to `odb_has_object()`
> >> 
> >>  A couple of bugs in use of flag bits around odb API has been
> >>  corrected, and the flag bits reordered.
> >> 
> >>  Comments?
> >>  source: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
> >
> > The discussion on this series has wound down by now, but I'm not sure
> > whether anything actionable came out of it. The biggest question was
> > around whether or not to use an enum as parameter or an unsigned
> > integer, but there wasn't really a clear conclusion.
> >
> > Should I reroll this series to convert it to an enum, or should I keep
> > this as-is and then we can merge this series down?
> 
> I do not think we want to go the route that was proposed in
> <aXhbXQo6taM33m-1@pks.im>, but it's your call.  As I said in
> <xmqqa4y0jop7.fsf@gitster.g>, it would make sense to change
> parameters that functions that deal with these constants to take
> enum instead of unsigned, if we were to turn "#define" into enum.
> It can be done on top as a clean-up if the theme of this topic were
> something more substantial, but this topic largely being a clean-up
> itself, I am not sure what the optics would be to have a clean-up
> topic that requires further clean-up ;-).

Okay. Let me send another version then that does this clean-up on top.
Thanks!

Patrick
