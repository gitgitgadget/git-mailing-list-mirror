Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BB934DCD7
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546498; cv=none; b=oS/LD57pKwZGGjTWlJK1shEG9XV1966EPDR5Y0v6iw3sT8X+F18zeIb+7wFO4oLqKWBCa8e4ip4uUXQI7FSEa2fnwuM9fpUblE85vX+AOyLLNwbrPQWi6r1RRKrDdklc3kxtL7fWZnnBhOT1XO86e2QPc+l1jayq9P6VtvXmzEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546498; c=relaxed/simple;
	bh=+d63OHRYGAZnOqaMHLOhhIRk96t3uE0Kh0rnW8WA5xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJboNvvAYEtFYt+bFwbCOBaCqeeXc1bxUv1+jkP5utZU0ZJIQIVpKi4Q0dnPmsXtvHU0i7GecxtMeJkV1MMzeOVjUCJyUFLr++xg/wf1RwodxOqr+tsLQd7FGbm3e+qZxrD6f69evMWFTp+T4v6OgGZLvDjLKbzKPP9WZK8pCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LFAqjiD4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dKiOVtKY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LFAqjiD4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dKiOVtKY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 75F7B7A0154;
	Fri, 16 Jan 2026 01:54:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Jan 2026 01:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768546496; x=1768632896; bh=aznSA6hMJF
	eyNuigQqzezGy1QQZrZzDE/g9VzeLPqXY=; b=LFAqjiD4imkF0tjdwUMhloR6H/
	MuzNSD8JCzTXCSfdHs1j207EWEFTt910PS2WqAF+8ajK7vvSPpRnPYmpYAabhx1P
	4WkYgwHzBxlpxkoqQRnVd7HbBmnbUHfrtmyli+w5rLNksnbnsBntBEonR6lWmEHY
	9M+K9dZz1q0p3Bhm407YSbYrXZijO0IRoT0rSkHmnjcyCOKC50asSYggAmQSGdVU
	UWJQlxzV4G/Hw8Y+S7uD4yRB0H+aYIcyD6FRFSZ4pAhXX7XP7+hD0LVXhhD0OPOd
	+8X44kzsIUkH89UgyYG99zvTG+S9Wr1Yd2U9hWi2FpLfxuNoXsOUrB/tbBVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768546496; x=1768632896; bh=aznSA6hMJFeyNuigQqzezGy1QQZrZzDE/g9
	VzeLPqXY=; b=dKiOVtKYsYagE97z7YK+WaKztX4wKDE+i2DzMIkF9nYKDty5+5m
	mDPrQX0FtGq/OaeWHAUafZDaeft7ffcCsEGwyFjnOqSnBohOF+fU2PUMhZOJIqxx
	mDAeubmX81Lb+yOu/tse+0Dd9iNVIpGhnre4K2FhCvoK/kd2sfC4Qj8CDmMmnvgP
	omxbu0TUgb2O5qbBjCduAOye3icp1XBepouuSUkj75u5oTiKv6ZD+nSl1ISrQT4l
	cyiYGyaliXMyLRPJ5HB+Gl+HIap41A+1J4mj1fioJt/aO+JliTON8ZbTbXG/Zhr6
	vApSAIbLCKHVJYjVeYyYOl0j49rHvJ289Pg==
X-ME-Sender: <xms:wOBpaQlMzpdedwNx9Orf7tb4blgroUe2HohdtRyRH279tdmaUlxhbA>
    <xme:wOBpaV0VBrprS2ibW5xmYlQtyt-QghfJllOWli10JWmOGo0syfVDhP58V9OjrWPn5
    rQ6vRJ0GWmcyUxu19VuIEAN9YhV8kHNGQ2maqkZckXvU7GMh0Rsp3Y>
X-ME-Received: <xmr:wOBpacSczTf5UEVOw8Q211eL3POZPwbbUWB76x92tvVLeQvWinWMmg1g3IqxxMu-AUAXAXV1T4Jx9No1UCBGzh9ard5Xu4bc8_8GbC49DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wOBpaXsg7iGp35Rjx8Knn6KJE1bWwcHNLLnVSgE-qs1TfDJO13xNPw>
    <xmx:wOBpaRbUvOhmm1EmW6m2PSYvTN-ZHzC4JjsU3Ak9jbIuCRyRT-eoHw>
    <xmx:wOBpacv80fSGlod_BPd0Fs8y9qzp0I7CNYlDLNWoNiLAB94PGRoxdQ>
    <xmx:wOBpaTG3P9fxFJMxCtEWXV4Cr-hxA1TUKvcjY4cKiw8LMrelwOVlOw>
    <xmx:wOBpab8Sj8GB4TByafJ1uP4x5_xEmw7Gnx7W47IouMAJKow8bzCK9QZH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 01:54:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e64df49d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Jan 2026 06:54:54 +0000 (UTC)
Date: Fri, 16 Jan 2026 07:54:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] Rename commit list functions to conform to coding
 guidelines
Message-ID: <aWngu0AZx5Akd_m0@pks.im>
References: <20260115-pks-commit-list-coding-guidelines-v1-0-c58868dbf412@pks.im>
 <xmqqa4yfdmsp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4yfdmsp.fsf@gitster.g>

On Thu, Jan 15, 2026 at 05:32:06AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > I've been working with commit lists quite often recently, and every
> > single time I get bitten by the fact that a subset of its functions do
> > not conform to our coding guidelines. While most of the functions start
> > with `commit_list_*()`, three functions don't. This patch series fixes
> > this issue and renames the remaining three functions so that all of them
> > start with `commit_list_*()`.
> 
> > Note that I'm adding compatibility wrappers for the old prototypes to
> > ease the transition and not make life hard for any in-flight patch
> > series. I've also dropped all changes that lead to conflicts with
> > "seen".
> 
> Well, these are quite well established names, and seems to have
> different callers between maint and master, which means that your
> compatibility wrappers will need to stay there for some time because
> these three patches will not apply to maint, leaving them in maint
> under original names, and future fixes that involve maint, when
> merged up to master and above, will still need these compatibility
> wrappers.

Fair.

> Perhaps the new naming rules were introduced without surveying how
> established names that follow different rules are and how often
> they acquire more calling sites?  Should we instead tone down the
> rules so that it says something like "when you are introducing new
> type S, then call functions around it this way using S_ prefix",
> leaving established names excempt (which is quite different from
> letting sleeping dogs lie---as long as they acquire new callers and
> the code that uses them change, they are not sleeping)?

I dunno. I myself prefer converging towards a consistent coding style,
and part of that is to also adapt existing callers over time. One should
for sure be careful in this context and not go on a holy crusade against
all violations of our coding guidelines, but I still think there's a
point to be made that a slow trickle of changes of sleeping code is
fine.

In the case of these functions here I only did it because I was very
annoyed eventually. There is this mix where most of the functions
related to commit lists follow our guidelines, and only three of them
don't. The consequence is that you need to know by heart what the
exceptions are, and I got this wrong every second time and that
eventually made me write this small patch series.

If it's considered to be too invasive that's fine, then I'll drop it. I
think there's value though (well, obviously, otherwise I wouldn't have
sent the series :) ).

Thanks!

Patrick
