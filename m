Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E618CC18
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095870; cv=none; b=XiDLy1fJB7eJ2DdEV9K/mc6Sv3JyKuQtQPGxg2lf2OH08Gm1qX7fJJZjjWr2jVoJJ97UENOVyEHE5A7TsnJa/f8x/NxHzFC+fBsky0FsJR6fncJQehZBqvyXg7T+FltLcJ2OSpOvr+hibiDMyia29FSdZy6p+6j9RT5gHl0jPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095870; c=relaxed/simple;
	bh=ULe8IgwZUgOctEobGasdfwg3TMeGUxs+Yszb7QhRAKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7XOH8nVubIjvvmFcK+RYNdvvShIVOMaqx1e+Ht8X0SyiEN9/vbbrpzxkJD3krVXKN/LPmDLwUGieOdTh/3vxHUXDZCc14FhgCBtxsJX1UPGfFNSgYQaXI0tkqIr+K1sXWKRqrrmce8klp5cJk4wi+0KBBJsWmgiwfFd5BAcbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y46HIdPN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jII5yZse; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y46HIdPN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jII5yZse"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9709011400E9;
	Mon, 28 Oct 2024 02:11:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 28 Oct 2024 02:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730095864;
	 x=1730182264; bh=EBMQcYnl3zfTgPbuIUgDDkesebP6v3fRnWOPI5yPmi4=; b=
	Y46HIdPNLkDYfHtaBU8gojMrNBERdz71F35OVty9LGZrIXEWyz96O3ZVob8gpa+9
	J/HkVqRKwKsOOR1SYJzBCyrkGUOcMAPJYo4eNhKXnp+vO5jC07mi3iJvB+cGATHk
	6WiODL8iy+TE+iaTmeZwsEfTwxX45gnTgRHgH4ghsNTNPVXsYOfW2eiMlFCdujYO
	+D6Z40+gSBiG/nNlpYedEeWD3ZzUU0UGGwW52HSwfZ0bxxW9a1WWU1+/z0XwH81k
	5bHM2es22cbzH3rBoUIKvXg/rcXxAbm1hctEQrTSXURwY8ZuTb9nvDtwRbMgFPdR
	Kf4YC5cKGKdKS6ZR0Qarog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730095864; x=
	1730182264; bh=EBMQcYnl3zfTgPbuIUgDDkesebP6v3fRnWOPI5yPmi4=; b=j
	II5yZseN5pX3BZNx+Kf2dML77LZW3on9EbosER0CwuTNki9T6Ct3DLZTmcpBrp2y
	a2oqyANEPB5dyYsvx6ZwtQ7gks8sKuL7ZnmV1jmpAU3wu41PjUAW9iYYK/HcazDr
	FrJsi/RYK34BYIVbjVAUHpEKLuywUA5tbKWJG9rDija/BgjFMmWOXce0ldLhugb1
	15r5mltqq4zWAGz8SNNrxhJVjl16G9Z97IQ+nNJIp6yghUcuTDSGK7ciht4GJi02
	X7T5G0BsoUXa7wJYAECq2QD3TLpLg9FNaGphOT0Uc3E5ayysQW43O7bMkAidIu1F
	UWaZVvGCMa/yaGrTMT81g==
X-ME-Sender: <xms:9yofZ_YzEzeFOWKx4LblT7uZ65i-oPbDL5b-C0hzQCv5u1cSYYx05Q>
    <xme:9yofZ-Y_mjY34XXCD9ejG9gML9OBR8gPDwHGV56oksEjnOkAC3_fYHtl36VAYqbZ2
    V7DGwaikdY71N1wXA>
X-ME-Received: <xmr:9yofZx8xfiiN34yAj5-bENmRt8LVnPqK1t7Xud_98cl7jhpD_V1g2sn0j0nlUFUxZMpelWQb1l-bjmYEQkllK9tyVz5xN_WNYyJa1ODo211Oyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvg
    hlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:9yofZ1owVA1VmfwfxzaP3z-TeYGlwa0xMXY1XI9T4e9uAaSaqjL4LQ>
    <xmx:-CofZ6o2hStzzmraWpR5lDePIbXZmdiMs7tkleIq8qOkh7HQrTrOxQ>
    <xmx:-CofZ7Sec4jNvJHzVjDCpPoRV9yY9yOF5gH5OOpxKPmi_q53zg6IzA>
    <xmx:-CofZyrcXdJNg2WwGZ-qTgIkFiVRztykDUD-p4EfQUxtWluW9BeT9w>
    <xmx:-CofZ7eCLZmiPdSUYO_Hqqp9ZK3TYewz7RRRnPSxORqzIs6rmIhZxlZZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 02:11:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ba78b081 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 06:10:56 +0000 (UTC)
Date: Mon, 28 Oct 2024 07:10:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>,
	Christian Couder <christian.couder@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, gitster@pobox.com
Subject: Re: [Outreachy][proposal]: Finish adding a 'os-version' capability
 to Git protocol v2
Message-ID: <Zx8q7jnDIS3_omBm@pks.im>
References: <CAPSxiM-4okXfiWZtSNArMjfXzja9wBrMaEayhqt1hvJpu-PHkQ@mail.gmail.com>
 <CAPSxiM-YAAMwOvH8KYO+qKahCBHgw-NDb-eHJKNCZyk8xtpeGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM-YAAMwOvH8KYO+qKahCBHgw-NDb-eHJKNCZyk8xtpeGQ@mail.gmail.com>

On Mon, Oct 28, 2024 at 01:56:36AM +0000, Usman Akinyemi wrote:
> Hello,
> 
> As I planned to submit a proposal for two projects, below is my
> proposal for "Conversion of Git Unit Tests to Clar Testing Framework".
> I would just go straight into the project proposals as the other
> necessary information is in the previous email. I would prefer to work
> on the "Finish adding a 'os-version' capability to Git protocol v2"
> project in case.

Thanks for your applications! I'll only reply to this email as I'm not
mentoring the other project.

[snip]
> ---- December 23 - February 10: Incremental Conversions & Feedback
> Integration -----
> 
> - File Renaming: Rename test files from t-<name>.c to <name>.c
> following the structure outlined by prior contributions.
> - Clar Suite Integration: Add the module name to CLAR_TEST_SUITE in
> the Makefile to include the file in the Clar testing suite.
> - Conversion of Test Assertions: Replace the test assertions with
> Clar’s built-in functions (cl_assert, cl_assert_equal_s,
> cl_assert_equal_i, etc.), enhancing readability and functionality.
> -  Patch Submission: Submit each converted test as an incremental
> patch to Git's mailing list following the Git contribution guidelines.
> This phased approach enables targeted feedback from the community.

One thing missing here is the work with upstream in case we want to
implement any functionality that doesn't yet exist in clar. You mention
it in "Additional Goals and Extensions" though, so that might be good
enough.

Other than that this looks good to me, thanks! Please don't forget to
upload your applications to Outreachy if you haven't done so already.

Patrick
