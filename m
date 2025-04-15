Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421A1250C08
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708764; cv=none; b=Q6tAMT2pEuF22pTphZJBCGcPpNeVyYQ+NC5obHEF7ESTgTdfo7MOR0t1Fj47LH4PfBsHFJLb0aVNIeFr4+Na9CUs1xRVzv1eUZLhN9aZiCuGcVw4pbii9N5bt29208B318js41GX+duTAUVTLaULDmlLx9+3Kdprc83FfjtUaGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708764; c=relaxed/simple;
	bh=A6FWs8+0XKFZipEMEo+8Idbm0XKAfcVsmTFexl3hmdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dD/mrqOGUBioH1MBuTcuAhJZsCD3z204pH51numR61yBv/8/E7cMpcGbhaqUtTwdCE0hdMprhJaRsKpO70hAZDmfDNt9gbIOCZS0jESCMnXQ22B1vaeHbFhpgshFeTeBa+2nwJCrNjnmuSd1qpmIOaH9o3MWBSAUdi2svJtI63A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ODZVJmON; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jbtLQLIP; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ODZVJmON";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jbtLQLIP"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B3F411401E5;
	Tue, 15 Apr 2025 05:19:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 15 Apr 2025 05:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744708759; x=1744795159; bh=9FSzuF7jAn
	u12I4NErtsRTIzGyHyWSlhvUFNrSGF120=; b=ODZVJmONqJlJayusfM4Axj6Bmj
	YnoeV1aQjTMGPSEqPaFUTl1EinneDscjmF8WXgcD7ccssYSm0I7cCH93dIy+IWPZ
	Xr+mB5JEDTGOhEiNNIRlmfF/e+qzzU3sxLQTElLkWB1ezmYNnDum0l2eNwzn5Yol
	Vp0WUkBQQA23ljyVEeAoKMu0rKUd4fnU61Xti9okC9nQ0jJjxLzaMmp3phOhEp1y
	etjGra7HKgnySlyZBGNwiFwsMBqYpK7WeEDhoivb11D4crbq4CcBS0Au7eh50WuG
	5MHExjfbmX3/PygsoE7CXiDfgrlV+MovZTYohEHeje6Wt4zwe2Lkkd7CMhxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744708759; x=1744795159; bh=9FSzuF7jAnu12I4NErtsRTIzGyHyWSlhvUF
	NrSGF120=; b=jbtLQLIPN+ZI+fmEnhr+8OOtumX9fINe4rdtljy8HC0+zmqZyvT
	rBKxmAT0EU/89LvruNIWF4SVZOA8+Y/MMVEWfKzFhifFY8L4M4fE0HkaqY76DVct
	nICQL4/r0SpB1qQgJCylTQ9LXBzZ5ryCsWVbeeugjyOlH99Kge34w4sAhcYFWR2u
	bHrwQ8r/LsLHGJlqxZeYwiWf/EF8op/MvHBT+28WHBOs+ibrku9xC9vMgvcjUanD
	FpwiL0MGs3otHzEG3nQmaqonDiNpgD24QLUn6PbXZcGlRV7CdiNxf/W/+RCIZ0oG
	ZvDcR+eLQokjQ7pDuUUrMG/ZAwAvX/uih1g==
X-ME-Sender: <xms:lyT-ZweyGuZtc9KIda1rvS3lN6gHrbhqclMa4Hreqgar83rB1OywJA>
    <xme:lyT-ZyMzum07NsNYctpSa9uyIktggmLsPmC4ohImhF3JJ1eB_LXx4weBb2JH6sK-0
    VgIMu7vAlmI7MKF3Q>
X-ME-Received: <xmr:lyT-ZxiQ3Xcqr2sfcUcj99vjd2_5_Nlq07bgfrAIQ6XY_R8zFVHFN90JNQnW-W4JrXV869RopwaIzkyqvSfrXRH1vnKDUDIF754s867YCTD7pA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgv
    fihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:lyT-Z19WzwPvd47_j1QxyUxK8bEc8PweeWcnq-it8uuFhE0_bIjBUA>
    <xmx:lyT-Z8vkuCRAm8PK1qYBwn0LiYuUHpfayQTnO-iR_bKHmaokcXVAFg>
    <xmx:lyT-Z8FoUjZpcf7IE8t5bz0tVXM_IEAOqv3vFVkcHbM0K1qktctrQQ>
    <xmx:lyT-Z7ORvY1_7f77NJpVs8VYPzaqBwDnjObm4K-TOZglDW278lvLFQ>
    <xmx:lyT-Z57IFPjXv90HGJYEyQ486cVmtEZN6I55HAVsnlZvpVBoVUPuXUZa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:19:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 83dcb1f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:19:14 +0000 (UTC)
Date: Tue, 15 Apr 2025 11:19:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 8/9] object-store: remove global array of cached
 objects
Message-ID: <Z_4kkQ6IqQ-CDUO4@pks.im>
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
 <20250411-pks-split-object-file-v2-8-2bea0c9033ae@pks.im>
 <xmqqtt6ul30k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt6ul30k.fsf@gitster.g>

On Fri, Apr 11, 2025 at 03:58:03PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Cached objects are virtual objects that can be set up without writing
> > anything into the object store directly. This mechanism for example
> > allows us to create fake commits in git-blame(1).
> >
> > The cached objects are stored in a global variable. Refactor the code so
> > that we instead store the array as part of the raw object store. This is
> > another step into the direction of libifying our object database.
> 
> While we do need some execution context object to hang these virtual
> objects, once we decide that it cannot be global, I am not sure if
> epository objects are good home for them.  If your application
> running in a repository needs to give one object name to a virtual
> object, and then that same application wants to access a submodule
> of that repository in the same process image, wouldn't you have one
> in-core repository object for the top-level superproject, and one
> for each submodule?  If a submodule commit bound to a path in the
> superproject's tree is a viertual "pretend" commit object or if it
> has a virtual "pretend" tree object, don't you need to expose these
> to both submodule and superproject repositories, if your application
> wants to seamlessly cross the module boundary (think "git grep
> --recurse-submodules" or something)?
> 
> For now, as long as the_repository is being used as that "execution
> context object", and not a repository instance passed along the call
> chain, then the globalness of these virtual objects is maintained,
> so this change will not cause breakage (e.g., such an application
> may want to pick up the virtual object from the repository instance
> for the superproject and it may find it, but when traversing down to
> a submdoule, the same virtual object may not be found in the
> repository instance for the submodule it descended into and working
> in, if you make it per repository and pass repository instance
> around along the call chain).  But eventually somebody will start
> saying "let's remove USE_THE_REPOSITORY_VARIABLE", at which point I
> am not sure how subtle such a bug would become.

I think the answer is very much "it depends". I can think of usecases
where it might be the right to pretend objects to exist globally, but
there's also usecases where I think it makes sense to treat them as
repository-specific. The thing is: we can do the former if the virtual
objects are specific to a repository, but we can't do the latter if the
virtual objects are global.

As far as I can see we only use this mechanism in git-blame(1) right now
to create a fake working tree commit. This mechanism does not cross into
submodules at all, and if it would I think we would want to create two
separate fake working tree commits anyway: one for the parent
repository, and one for each submodule. So converting this mechanism to
be local to the repository (or rather local to an object store) feels
like the right thing to do to me.

But I agree with you in principle: we will have to be a lot more mindful
going forward as it comes to handling multiple repositories in-memory.
We don't do this well right now, but as we convert more and more code so
that it doesn't use `the_repository` anymore we'll have to become better
at this indeed. From my perspective that isn't only true for these fake
working tree commits, but it's a general thing that we'll have to sort
out over time. It's inherent to the whole libifcation process.

I think for the most part we're fine right now, as we don't make use of
any of the new capabilities that libifcation brings with it in theory.
But once usecases start to come up that _do_ make use of this we will
have to think about those issues a whole lot more carefully.

Patrick
