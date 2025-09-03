Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DC82036ED
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 04:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756874695; cv=none; b=o6nGVtXcoRBHlwFrKKvx1zcAuDWQ/X3zYhx/vLhTwr51anLi0EH+gH5uuc6U519TxG2C0hCVizRhbbsf3YluGzWuvEx8LO8pC9a9u62DhVdoY4XUZJ4AIUj1M4BWH4s2lp3KifidCagAaWEHPM2s24T5KwUmp0pVgHNabni7LZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756874695; c=relaxed/simple;
	bh=9iGiNyHW8IdL1T66oy6cABjRnFW8RJXb+1+Yk9l0Vtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lm0EIENbyXWeQlwxv3BezMefdLVoB4cdpdrs7IUdUFSbc8BkFB8H+ANo4aBM2z/duhkB+jJtbJaKNjOsvOeBxXz8lCDNiYKHZOecXg41o1KRLUAzTCiho3XxcXJ6kBOv0KF61seB9GK+e6vGI4u/TVj+CKG2gt4p19PDKp6Jitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IMACf/Y/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AEFiA52L; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IMACf/Y/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AEFiA52L"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id EAE9CEC0308;
	Wed,  3 Sep 2025 00:44:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 03 Sep 2025 00:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756874692; x=1756961092; bh=sXjcaK2PXT
	/a40Yt3Dc05yClufephktVGG3/hsYqXaQ=; b=IMACf/Y/96nNBP7yHXLQVsdTuN
	Nqo+FqcXbnLRXn047hni+GziSUdZk8XdXDQ+ZhH0g47Vsy6uf55awWyscG5mrMzQ
	XHju05X8KEGmVCsO8sf56rsD5BwrBWfnQWeJSUvDIz/oWrCHCdFVJwiA2Es7zXTV
	E/ZycAbadMEY+gw2cax2I5dARcJUjlYqeba+vCeCueS8xTyNGat4rUgA12+3rZJX
	xvB17djNrGFkLPsB2mm994ESM5FruTAwHWJn5ZftK429lBK3TkZ+CNqiEqjN63mN
	0m/8u31vIJG4xvQWuK+AcM83CgVQvYN+E8hIzij14jEYQNYO3Zi1ODsYSiEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756874692; x=1756961092; bh=sXjcaK2PXT/a40Yt3Dc05yClufephktVGG3
	/hsYqXaQ=; b=AEFiA52LTN0LJc41xllS+Ug289aBv0nn2ORoQCIlEfhfBUeMw1s
	GzQQlOKp3p1daAWxioXFb+iL2wBhf/Wz8Gz0O+J/iPiriEHHBgKTYwmvvZfFxs80
	XsB+lTIvVYJjP3GaVKqXv2WBjlEv+sAxGweoBjXChNnMGgNQ3WUXoKvG7W4C4HZV
	P6fKmAAfpF9wC0A4fJcQTRlSTixOJ8TT1Qa4txnVfulq7P+xEhqF9/L266wbrazg
	Shrfj8N7V0fIihDON3Wm8QniBjkeFsdqpgu3Bdp/BFlHq+OV19bemkSSpm/gwLx2
	BXFm1dVec0Z4z1yeYRaIaSjfG4uz2uFN8gA==
X-ME-Sender: <xms:xMe3aBcP0D7VEcfLYt2qd6XWn-CWLkkFVmFxi0OQw2OzZNxcJTk8xA>
    <xme:xMe3aIpMmjSr-dy4r6nseK9s6j69iWhZHw0YkuNXzmiFThDLdEmds1RXPiS1yiyzB
    1Gq1sCYo5xHWNH0Uw>
X-ME-Received: <xmr:xMe3aKHgRJBQ3-mKTIHbsgFcBpUP7NxdPmEcwdoHo6JcCAvYFdl3LnMwow8UGw06W09wmsCFVWXASTgKH_W7lB3zUCgwSh1gN9BSbhs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehhuhgrnhhgshgvnhefie
    ehsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:xMe3aAtee4mQN1hA2sxqYpmarTkALSO7fVAK1yMshiY2JkWh_0y98g>
    <xmx:xMe3aEXTVbdPnlvQUyNM8PKmx6FGM-jyTEGPHC_w5G9vCiQWmguOcw>
    <xmx:xMe3aEGFCWhcjaS8o7YV7GyBCfjkOMU1RrokHNZKLJurYXN6zouDbA>
    <xmx:xMe3aO1MU5U0q9jz44XwvdQKeJUV4nM3J90x80EDpBUaP8KApm_7Aw>
    <xmx:xMe3aPTyi6j9OBZLeGWxYbHp_DG6n96HSD4d_rNiGYCAoINUcwaJbcxv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 00:44:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e0f1a1f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 04:44:49 +0000 (UTC)
Date: Wed, 3 Sep 2025 06:44:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>
Subject: Re: [PATCH 6/6] breaking-changes: switch default branch to main
Message-ID: <aLfHvl5JuttXrI0y@pks.im>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <487d1a33130cb2fafadcf98da00a332a7408a0e8.1756308283.git.phillip.wood@dunelm.org.uk>
 <aLbWuGQhriQCMFbO@pks.im>
 <96e128d9-e5e3-4bfc-9e33-3caa75cacfe6@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96e128d9-e5e3-4bfc-9e33-3caa75cacfe6@gmail.com>

On Tue, Sep 02, 2025 at 04:13:27PM +0100, Phillip Wood wrote:
> On 02/09/2025 12:36, Patrick Steinhardt wrote:
> > On Wed, Aug 27, 2025 at 04:24:50PM +0100, Phillip Wood wrote:
> > > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> > > 
> > > The advice printed when init.defaultBranch is not set is
> > > updated to say that the default will change to "main" in Git
> > > 3.0. Building with WITH_BREAKING_CHANGES enabled removes the advice,
> > > changes the default branch name is "main" and removes support for
> > 
> > s/is/to/
> > 
> > > GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME. The code in guess_remote_head()
> > 
> > As Junio already mentioned, I don't really think it's necessary to drop
> > `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME`, making much of this commit
> > series obsolete.
> 
> I'm happy to drop those patches if there is a consensus that
> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME is still useful after we've switched
> the branch name. I'm still not quite sure what it is useful for though.
> Removing it makes it clear that the tests are relying on the builtin default
> branch name that users see rather than some special name used only for
> tests.

We may eventually want to remove the whole infra. But I just don't think
it's necessary as part of the Git 3.0 deprecation and that we can rather
do it as a follow-up once Git 3.0 is out of the door.

IIRC, the initial idea behind this variable was to adapt tests to not
even care what the default initial branch name is in the first place.
Tests should be agnostic of that name and use e.g. git-symbolic-ref(1)
to figure out what HEAD points to. So maybe we should follow through
with that idea and start refactoring tests into this direction so that
they never set or read the variable in the first place.

Could very well be that I misremember though.

Patrick
