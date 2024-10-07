Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F631D932C
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314931; cv=none; b=DP6DtzUl6rCx0GNdYIEPQi0yAGwKWCic0DH7AAkGUdEziCIK5+zS5tcKIs3ZUMjdNe5Q0LybUtxhdBOLAZPiLUbhprf/Sv67o89UCw/t7tG4dFSY2LhNa+D0g8fs5nH5D4LxwbIAFQB/2KFn5B8fpAQ7EeoOyrsIi+1lJXDjjvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314931; c=relaxed/simple;
	bh=zykc5tIQjlC+pq7eJ1/XrNDKKaFVw1aLCneZOMlIo3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9zeMGJE0YjR53dwbljF4RBSHGsMe2xky4jJgRxeYQlVREgLp+daH5XyNfLx8bfPkv/+gDswry8yBf3aHUe9VC1Mr1jZUOm2tO4fmwZcfMu+rnbIdHEkm6oXFgAme3T2/hgnzSkmSN1JfYOuR4AmexAbPxNBMiW7OsxKHZFCvF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SH2hNli0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MsRkJdFt; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SH2hNli0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MsRkJdFt"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id A29AA1380245;
	Mon,  7 Oct 2024 11:28:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 07 Oct 2024 11:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728314927; x=1728401327; bh=ps2zyFau2R
	MRyp2esGrRljGn7QihdjEOFDp15US8eak=; b=SH2hNli0rBg22tAiVSAm71auZX
	42fXmx35lFaBbpLLpCIZuKUjk60Ac96aWVabyZ71FhK+K94F2va6iHkafT9Lde/r
	3tfaaOuEVRbkjCbtv4THfvDgfRbdFzQOT1Qc07OYvBuBc9g27KdvEvyu117J9l0M
	0Enf5FoUYmsPoHsIq1bNu7LQY06JgOPwWibprEzoizbAtmV3OD8TOhsKVBUYMgPz
	ter8wsoWipqOn5HeoOOiofgDaUDow9AEVtNuTiivltgsT/SkT2vZKKj9dkjbdlHp
	FBM8+KQMIcGEfnOTslAntksROx+Mqz4NnG3cA2Y8SoA/+sV2tS7Wjv8El1KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728314927; x=1728401327; bh=ps2zyFau2RMRyp2esGrRljGn7Qih
	djEOFDp15US8eak=; b=MsRkJdFt7m2R8Rpj+w+p6HmvfGcVB+7J6qN9ZwIMeiyi
	WVHuBg4EuCfT74KxU/V7RpYM/I3+2ngZGYmS7ZaBQJVbV4uVLMwCHCNMfppoe3Ww
	oxEIkeBu8nbRbp6paye5dStRzsv6y4k2N9hjbGwLrkkldmaTWrxdMjhOXMs0DgQn
	8MaxTp/uTPr7npJkmexeMIPq4wGsqSLo2PFsF0QQurTF5MNUGNFp7Jgs9HLFXjNS
	nN1O6WYc6GSBxlbOqLrm99bpbJOu3E7OdfhtwY/oZh6QS1oXY4EFp9ZzG/NpE/R0
	PAQOPR1MZpCLI0uzGdnm4/SeeyZVc7URA77sPBRJHw==
X-ME-Sender: <xms:L_4DZ2jHrnFDHw46F8-6JGihcKa1MwIhivtNT4hP-Lp_dHbtKz_QAw>
    <xme:L_4DZ3BzaLqHwyGFEqy0StNk9JGrGz9DpTsAj2HD9XRJSU6Wff2NKszyIYuHYPkdZ
    DCchTJdf_AbY45wAw>
X-ME-Received: <xmr:L_4DZ-Ee0LgpbzIgA1TSWepWFFooO48AyK_7kBh7fO0RmTzIp30hdP7Jf_6tHOJ5qzjPAXytgkSgtNzPhbeTuNiln2BPDRVA6YSM12YhkgDnLc3qjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    shhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:L_4DZ_S3qoY2XQbBsS5iGETejaSu6amS2BFQh6EoaBgoWlclA80BfQ>
    <xmx:L_4DZzxPKSEkMeTNMOd54tugIFVCd0bRRINnSkzU3mPSTaMZH1yThQ>
    <xmx:L_4DZ95A_c8g2IXe3zJqBnKSUSM9_3KymEC5L3Wf2EdtCwD8QX7ytQ>
    <xmx:L_4DZwykYdoGPULOTU9FtnW-ZDJDYOKF-ftjiVZhfRgzlJRyuTQKlw>
    <xmx:L_4DZ1soJ0rgPXdA5d4rv9dssbBr5LifFTXQlyvNTKKeol--KVCYrNor>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 11:28:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e6dda9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 15:27:45 +0000 (UTC)
Date: Mon, 7 Oct 2024 17:28:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>,
	git@vger.kernel.org
Subject: Re: the latter half of october, the maintainer goes offline
Message-ID: <ZwP-KWZNOZOHigvJ@pks.im>
References: <xmqqh69thzd0.fsf@gitster.g>
 <Zv7aLRXwt9cfqW58@nand.local>
 <ZwAIM6GO3VtoG3ZM@pks.im>
 <ZwAYccsboGIhGVIx@ArchLinux>
 <xmqqmsjjereb.fsf@gitster.g>
 <ZwBtwFeVYmu6/Sc0@nand.local>
 <ZwN10b28Aaj3roz2@pks.im>
 <ZwP2hlVN7Cd+U3O7@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwP2hlVN7Cd+U3O7@nand.local>

On Mon, Oct 07, 2024 at 10:56:06AM -0400, Taylor Blau wrote:
> On Mon, Oct 07, 2024 at 07:47:07AM +0200, Patrick Steinhardt wrote:
> > > Sure, though I would add that my personal feeling is that it is a
> > > possibility, not a requirement, that the maintainer's funding come from
> > > either an independent entity (like the Linux Foundation) or from a pool
> > > funded by industry leaders.
> > >
> > > I say that only to point out that while Junio is employed by Google, I
> > > don't think any of us would doubt his impartiality with regard to the
> > > project.
> >
> > Oh, yes, and I've explicitly mentioned that Junio is doing an awesome
> > job of that indeed. But I see the employment by Google as kind of an
> > outlier here, because Google itself is not really competing in the Git
> > ecosystem. They do not sell a Git-based product directly to customers as
> > both GitHub and GitLab do, to the best of my knowledge.
> 
> I think your argument looses some subtlety here. Indeed, Google does not
> sell a SaaS product based on Git like GitHub and GitLab do. But they
> most certainly use Git extensively within Google. And I imagine that the
> engineering team working on Git at Google has certain things that they
> would like the project to do that would benefit Google's use of Git.

Using Git internally is kind of a different thing compared to selling
Git directly to customers though. Google also isn't (to the best of my
knowledge) benefitting directly from being able to say that one of its
employees is the head of Git.

And I think that is where things start to fall apart, because I think
that it would give a certain advantage to whichever large forge hosts.
For one part that may be because of being able to push through things
that the other forge cannot. But the more likely scenario is that this
is a huge boon to that company's marketing department. So even if the
maintainer would be impartial, I doubt that the company as a whole would
be.

> But what I don't see is Google benefiting unfairly by employing the
> maintainer. So as long as Junio continues to maintain that impartiality,
> I don't see any problem with him being employed by Google.
> 
> The other aspect of this is that it is Junio's personal choice where
> they would like to work. Is it possible to organize some kind of shared
> funding model? Perhaps (though I am personally not convinced). But I
> think that imposing that model on Junio is not fair to him. Junio may
> wish to work at Google for other reasons (e.g., perhaps he likes the
> benefits, his work environment, benefits from his tenure there, etc.).
> 
> As long as Junio remains impartial, I do not see why the project should
> dictate his choice of employer. Or IOW, if Junio woke up tomorrow with a
> job offer from GitLab or GitHub (or any other company), I do not think
> the project should dictate that he turn it down, or mandate that he be
> replaced as maintainer for exercising his personal choice.

But I haven't ever been talking about changing the _current_ model, and
I do not intend to change the way Junio is employed. As you rightfully
say, this would certainly cross a line. I am talking about a potential
future where Junio may not be maintaining Git anymore, due to whatever
reason.

> IOW, I think that the maintainer's impartiality is the most important
> aspect of this. So long as the maintainer is impartial, I don't see why
> they can't work at any company they choose.

Exactly, that is my own take, as well. And I personally do not believe
that this is compatible with being employed by any of the large forges.

> > > I think as long as the maintainer's employer does not unfairly influence
> > > the maintainer's decisions on their behalf, then it is OK.
> >
> > So yes, I would probably be okay with a maintainer that is employed by a
> > company which I don't see as competing in this space. But I would
> > strongly disagree with this statement if the intent were to ever have a
> > GitHub or GitLab employee become the single maintainer.
> >
> > Impartiality is only one part of the picture here. The other part is
> > that Git would start to feel like a project owned by that company. There
> > simply is too much political tension for this to work out in the long
> > term, in my opinion.
> 
> Again, I don't really see how this is the case. Git does not feel like a
> Google project to me, even though Junio is employed by Google. I think
> as long as the maintainer is impartial with respect to their employer,
> then their individual choice of employer should not matter.

As I said: Google is a bit of a special case. Another big part here is
also history given that Junio has been maintaing Git _before_ he has
joined Google, to the best of my knowledge.

> > So if we do not have an individual at the ready that is independent,
> > then I would strongly favor a model where the maintainer role is shared
> > across a group of people.
> 
> Like I mentioned earlier in this thread, I don't really see how this
> model would work.

Well, it certainly would be a bigger remodeling of how things work right
now, and I do not have an answer right now.

Patrick
