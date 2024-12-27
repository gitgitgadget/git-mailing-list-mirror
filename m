Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E31F193A
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735310080; cv=none; b=RCf7EQRgmN91k44J+6D0qyqHQ9F0IW+WY2iLEuMlNTDmHETtvztsp/ZSUEcv1Z4LlFY/BO0vLpF0qS5uUddXsY6SNeJ8ZZ4CJ6F8Xub6ujj6XHVuHL//t9l4jjocyLl5nvCK/0rQqZrL8G3SIq2IdQAVbQY6ikC88MRR9ZLfdlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735310080; c=relaxed/simple;
	bh=4OLqIAVNkddF9cPW0+PI6BnSIjJoeIvsCACwrlHHCEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOrFlmwbWtOsoY82vhT5s8EHBT0MXx+/9+4XqPP+0nQLU/oDThuQiZ0YDnzn4rTBTNGzCoNWoJFDWHUGmGw0XxR7v6T2OYbzGkRMm82Nf+EMbWZ3Tbrl/Wy4C9kForGwAwXk9aEv2FCU6v/Ji8y7oS4v/Hgq7ftKYaepPPFzIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VXC6Qy4Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UjfWjaGO; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VXC6Qy4Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UjfWjaGO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C7EF22540187;
	Fri, 27 Dec 2024 09:34:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 27 Dec 2024 09:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735310077;
	 x=1735396477; bh=1uUx+m6x3amMao470zqdXgP9LOx6MzuqeMiXrWRAt0E=; b=
	VXC6Qy4YqTwemNOFtpny+StIBmVzv72s1ndQeirbSQyxxBIlZ0VW6wOKAYO6tsm9
	FN4u/Gdd/tbhu/yt2sGaRbO2WkVFBwNhBusYtYgJEu8mycuTF4mJjd8pjWhJyRd3
	D/fyGK+FTdnqTOUCKS3EMlnGDRFHfl1c+sXpReByose681JgtSdZHM9ZP3537nfD
	gRbIhVerxK9A1R7/7j71c4JKbZQtTv1gXUz1qf8dXgTVl+1kR/TnYRDTxpNrBFLo
	8A0/77BQFWdNSdR0SiRqWLvO7fMkTPnb6BDzMnUub/7wv4eHCpSzSd9q0E+sJGD/
	9DtM1ruiPhfP9jeupWtegQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735310077; x=
	1735396477; bh=1uUx+m6x3amMao470zqdXgP9LOx6MzuqeMiXrWRAt0E=; b=U
	jfWjaGOm5pB73MViBO8L+E4fb30SsAhfX8VCjpS7fky1IGFcfRKcOXZPLn1bheta
	DvZuGEjbJaw7OA7K7hDC9V0YiVpr985qs9vp9tso/D9RyATSyfobulPEA9UIp+7x
	pvqPgftl340M+LUn4UQEthLrWEMmipGjlueAhvmtyxYUgX77VeghG+vcZxkX6Le/
	m1ThW0flJmiNRjxo9jXhg6Y8gIgP4NXwY0WBbHymGFSqxmrpR1YnHcCSHASK8VZ5
	ILMxP+fXmxkh4AdefAimToDTcBSRmyYxAk39C30cmXTMwapxbh1YOijZcvA/UXJI
	g/yAoMmQfnBFuQT92lTkg==
X-ME-Sender: <xms:_bpuZ99eoKJugYfMMXS9RR2EmHk7fA5nfRF7rKrVE2xDOsZVu_7J4g>
    <xme:_bpuZxvbDnOhFtYdSDIDXmXzaWAbmy8WtCshKyNifnsW0_O6MyO0TZMFYhcp2HG_9
    _Gh2BwuVrRzAtG_2Q>
X-ME-Received: <xmr:_bpuZ7DkcbS0PirIRm99WzvWJJa0rUnJbYCsBE2KoAeaT07Dz5dlcn2E2CwPjnUmHYXk5iYNGHNhNTJ_LkMoCIw9zVwyg-bbXeb1M75uGr5pfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehshh
    gvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhfuhhnnhhivdefgees
    ghhmrghilhdrtghomhdprhgtphhtthhopeguohhrvghmhihlohhvvghruddvfeesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:_bpuZxfrF98Qh_oO6V7sykVznMz_AtGxBXtXUtbXsFCS8M-Wc31azw>
    <xmx:_bpuZyOH3WFxys3iQrZ_kSM1jOXzJ_lPTM_ik4yCmldUy_fKPEu1gg>
    <xmx:_bpuZzmY5iHPS0lSATEYbMBzPiLXGv1SbatLzCP2CbTAvfUrjRAoUw>
    <xmx:_bpuZ8uXG9EZM4Alo49gKXQOkLiXFYR5QLjrG1O8M3T6tB-oJN6mMA>
    <xmx:_bpuZ-A579MizX9-mZrQnjdnU1wcYobSTEbgUQaw5h72t-uh6cX8cyfR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:34:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f197ac40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 14:32:32 +0000 (UTC)
Date: Fri, 27 Dec 2024 15:34:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: shejialuo <shejialuo@gmail.com>,
	AreaZR via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, AreaZR <gfunni234@gmail.com>,
	Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] refs: exit early from the loop if it is not a main
 worktree
Message-ID: <Z2666eLeDbWE2yKc@pks.im>
References: <pull.1848.git.git.1734488445457.gitgitgadget@gmail.com>
 <Z2LOpOxu0oAY0DW3@ArchLinux>
 <CAPig+cQd=vc5rte47biFbR+w_DV2OhdCRpC2WH_dKsSi4wvZ2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQd=vc5rte47biFbR+w_DV2OhdCRpC2WH_dKsSi4wvZ2A@mail.gmail.com>

On Wed, Dec 18, 2024 at 06:52:02PM -0500, Eric Sunshine wrote:
> On Wed, Dec 18, 2024 at 8:30 AM shejialuo <shejialuo@gmail.com> wrote:
> > On Wed, Dec 18, 2024 at 02:20:45AM +0000, AreaZR via GitGitGadget wrote:
> > >               if (is_main_worktree(worktrees[i]))
> > >                       continue;
> > >               ret = 1;
> > > +             break;
> >
> > So, when we find a linked worktree, we just return the value. From my
> > perspective, if we decide to optimize like this way, we could drop the
> > loop because the first element of the result of `get_worktrees` is the
> > main worktree. And we could just check whether the "worktrees[1]" is
> > NULL to do above.
> 
> You're correct. get_worktrees() guarantees that the main worktree (or
> bare repository) is the first item in the list, so merely checking
> whether `worktrees[1]` is non-NULL would be sufficient to answer
> whether linked worktrees are present; no looping is required.
> 
> > However, I don't know whether it's a good idea to exit the loop early
> > in the first place. CC Patrick to help.
> 
> If the loop is retained for some reason (though it really isn't
> needed), then exiting early is indeed desirable. I suspect that the
> missing `break` was just a silly oversight on Patrick's part.

Yes, indeed, breaking out of the loop feels sensible to me. Checking
whether `worktrees[1]` is non-NULL would be fine, as well.

Patrick
