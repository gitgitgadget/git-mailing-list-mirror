Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BAD1E51D
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726137663; cv=none; b=mVy6Ns7ynXJDfqWQ73Rbs15+29Cpq8F1E0MSxtEZUAOVvYz0S/RZuHw0uvbBxvyGV93JrzbbBmF0zGiV+mKaWS8ooHSrUBIftlnCHt3R6ngZQlWJx0SvAEWPXafXSdm3PJCI+l46h9G6mouqyyg2rHGusKkEcpA2CIJzYTf6QAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726137663; c=relaxed/simple;
	bh=qG0Vx2JnJB3xw5Gaq7PSyuhSwCaYYlVe93ldjuqlmlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDsiiuLSL6ozmbgEvgguoPWjCHI38hm/4lPIyV7/HvmPwov1MYtUMsUZ+twhN+3icEMVp7DOnLOwwcEBA+u2juPFVO6CZVW3manZ/MGEIU9tsG26RlnWGNQfX3DSkmf9PiXHLRI1d65Tn3G0Y/uSAMsCMvDZbGuhpmap4LbeYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j0yOjjG3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YA1msYFC; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j0yOjjG3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YA1msYFC"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E20B11405C0;
	Thu, 12 Sep 2024 06:41:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 12 Sep 2024 06:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726137660; x=1726224060; bh=vQyX3rHom5
	Pd8IPt5j4jFk04OgeSoS5KAtAS6O0LN/s=; b=j0yOjjG3cYd3WNadHuE9w4W7OO
	PnKHEen1F59adGQOwAcaItxwLlR+p+nP7yCycRhSb067k5RboMcuDTuEQDmWZrtc
	d4aqGTrnNotIh7UpCgDZ+fiQeRjFLoE4XO0GmzlPyavkJgbjXPrgo13XNeJSbUL+
	HBD912LuCI/2lfKDvB+d08mwHPB5JXeLgsMdSG5kaFi5oCBZBJ1GKuWo22kDkTLF
	gTQSK/8KpFjrIfHKpzYW3i0A67jVyXNWEb34S6yfINuRDmQBxh/xkZOHVqiYMlEp
	M1Yyd9L1yDiHBgkOhbuOsGrBGhSHroRU42yPbtxW9jr9mSccR4pL+8sW3ZEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726137660; x=1726224060; bh=vQyX3rHom5Pd8IPt5j4jFk04OgeS
	oS5KAtAS6O0LN/s=; b=YA1msYFCvDSJzML1zq0JBp1p/PGns1R1mnZYbEEREJB+
	0bjVQwmjKkqQdvCNK1xGuVbmAIrcehRR3sFOa7MSUbS36FnJWf7KNkfhzLDMprcI
	utj2ZIK2aM8FwYzTJTG25Qsug91PJ+Yzvjs+utLt52ZwiJQk2DoGdaAXaKNynqZR
	8gVk7yMF8Yh4qLVk+r0nAQOuVDS+f/D9KD/4Dh6fNkiQxKTJGUzVP+l06G8TJm6x
	LzIlmImniUiXHz9PxXHmQ8YMOyjbQPnAbpaT6qcJALeV+awefSsh+ppyS+Y8Ilf4
	Q+MMXUuqQHBIZo0aiTcyZMZPIymOLmcCRCEA4uByXA==
X-ME-Sender: <xms:PMXiZkrApUerVi9Tqb56YFupeQZ6tRlpNJlVzi4nG98cYdWFQ9GEKw>
    <xme:PMXiZqp3gyRz68PGMGgcj-vgA33WFYi4vJpCBhzAiZU4ChNmy4HD9JEGsIAeQhk9E
    k8lQp86QbJwmSJt9Q>
X-ME-Received: <xmr:PMXiZpMHlV01N982SOa9yJ4Y-wsk-7CueqCrlf22OfXJKRmqENBujsZdgWEE-rwSEjlTUk8-9JSJGbYjrsKOMH1p1gc6mSrDW7-9o-AN1xri>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:PMXiZr63qXfBksLi23yRcY6udxN7CBjna1b6vXjEGuOKwK9VN0tOzA>
    <xmx:PMXiZj60w9GiH0Qs462NFTtOe23Kxil1WVx3WtgYFmaCIwhDDyERXQ>
    <xmx:PMXiZrgOUpIuEVrPmqwGSM6BcFLQqwShli_z2Gi5uNQxycBHIzCOuA>
    <xmx:PMXiZt4lZ5r7SDj1pHj8GkpTSQBoWECySC7gEvh-xDpu42uPI95Ikw>
    <xmx:PMXiZlmT-CGBYbTdNvYg4pQobpG7PUFyXE--StVzMS3Ev-msA2v8CueC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 06:40:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d187f511 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 10:40:48 +0000 (UTC)
Date: Thu, 12 Sep 2024 12:40:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] ci: drop run-docker scripts
Message-ID: <ZuLFODJB3Ak8Y2WK@pks.im>
References: <20240912094238.GA589050@coredump.intra.peff.net>
 <20240912094336.GA589828@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912094336.GA589828@coredump.intra.peff.net>

On Thu, Sep 12, 2024 at 05:43:36AM -0400, Jeff King wrote:
> We haven't used these scripts since 4a6e4b9602 (CI: remove Travis CI
> support, 2021-11-23), as the GitHub Actions config has support for
> directly running jobs within docker containers.
> 
> It's possible we might want to resurrect something like this in order to
> be more agnostic to the CI platform. But it's not clear exactly what it
> would look like. And in the meantime, it's just a maintenance burden as
> we make changes to CI config, and is subject to bitrot. In fact it's
> already broken; it references ci/install-docker-dependencies.sh, which
> went away in 9cdeb34b96 (ci: merge scripts which install dependencies,
> 2024-04-12).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I think this is worth doing even if we don't take the rest of the
> patches. But obviously it gets even more bit-rotted as the other patches
> change the CI config file.

I initially wanted to use them for GitLab CI, but eventually I figured
that it makes way more sense to just merge the setup instructions we
have into a single, unified script. Docker or not doesn't really matter
all that much when you want to install dependencies. What matters more
is the actual platform you're on, but that is independent of Docker
anyway.

The only remaining usecase I could see for these is to run CI-like
builds on a developer's machine. But the fact that these scripts don't
work at all anymore and have started to bitrot already demonstrates that
nobody does seem to do that in the first place.

So I think removing them is the right thing to do.

Patrick
