Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B022F5A
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580961; cv=none; b=m9uIasMxMSodCcU+mS1LbHCMvBhLCYBHmn4chtOoLkBPVhEw7iC7p/rjxaEpyay7ncPpvwiXa1JifmsMPIBZGIqi9cLz8gsdwwsbWwf+ie/7sjgOMi36Z7OS5j9DhYH/sqFgj0u1YKz/+NrobsYGOCOeEcJYCoc5aVs0ApuzHnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580961; c=relaxed/simple;
	bh=ZofizPhQcqwqwAhsCNjPHytN1/VUn+aTHk3V4NCjW4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0nPfwZEbz2wAoT4dv5OzZM56Q4ypWEipb9FIdUHCHCpGBDIMwD4/hTbZciQtgja85a3oWV/g/65Xr4vNgDojl6PB0fezRoArmt1dEVJVZGVv0jr8d5x6W8dOJLULeIzH3iLsy9hmj5NUPbJgXgkkE2a8yPiDpnCrlUInbcXmCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N56VFz8U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c8pgO92Q; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N56VFz8U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c8pgO92Q"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7BE5B1140086;
	Wed,  2 Apr 2025 04:02:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 02 Apr 2025 04:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743580958; x=1743667358; bh=Ske+zRq505
	GTkxI0iJRTtp7lGET+RppD4oieXAaA9P4=; b=N56VFz8UrWp23mlOeEPuMD7c9q
	drni9LD696uigNlxNyVZxAglPOzZt8bpfcQeXDSsJzQTENVR4PEwIRGMQOcbR/Hh
	D8bNQRNlov7lqXN28KCtn+YTca03Cldk2igwBdrsNZG3I+xLF/BihFbmx5o4Ojvk
	wT8zbe6UD+HTg7cXARZTyG0cks5+mOjCt6bqYfXjtkxwmdDnieziBDjTkxl8g+BY
	8FrxEDqLn9ZtslUwaJbua5mARjiFXDw06qPnrXzXvv1cgLpOahuts5uDOy5Xa1Ng
	UrO7ul/SzqD8b7s+uWdXyIEgWPN0V4lVNnZydZoPYXvHDfVnevN5oUdBTi+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743580958; x=1743667358; bh=Ske+zRq505GTkxI0iJRTtp7lGET+RppD4oi
	eXAaA9P4=; b=c8pgO92QFtEQ+O0bul+73Qn/AFTQC/ijlZviXIZtfMcZr4p1R72
	v+DY5UDvtuoWzpuDHbr05ByREFJ2Riq1Qv7HXXmEe7wquWkf8NK5pC7+R1IZuvB7
	S6ZY3GJ3a3EwQlAxa7sZwI5LqQ/mfbSJ3MqWz1kT/M9F8LvVW5xw03P4J0MZ3Rsi
	EPgbFKqbXWSydRL/uFwxcT3QjHYJz08qsCuyqsY2d0D2ZfXWSb0Hl1FWr9qDdKLu
	MCaPsXJUHrULWEO0jBltVDEp/nhoLgPcglWWupQzgtomsR7awbUKN1BbWY/GGzwZ
	Bdke+p7SMXCV2GKTfAwJ80WhGumZEYpiZMQ==
X-ME-Sender: <xms:Hu_sZ0l4BmgnbBADl-KBg6uL7IxIWUGQMHE6khNGSfa2J526EbeKVw>
    <xme:Hu_sZz3pFJShdZnNHcd5fbGjAdo97iFKa9-r-wRlTx9JE0xdyAGIsrWu9ghcg_Moe
    wsB2YORhLcmsHYU4Q>
X-ME-Received: <xmr:Hu_sZyp1ELjP5QFHFufxr59vu-DWXRSDjZ9-eM3IjPCBWky0LH7g5G_ylEFC5AXY9NcFSk3bS48GLWx3Be1gTAwfc6bmGk0vRarPkmAylXk1Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptdehiiihtheftdesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:Hu_sZwkL4duTHgpPW-l3WrGrkd1zz7LoQAKZuJYc_Oy619M5fDOUUQ>
    <xmx:Hu_sZy2NSwWvyp1Tccm3EjzoJaZuC7XKzSGFy7xTPSiAjRYIRMufEw>
    <xmx:Hu_sZ3smZM5YlgQTR0QhnlJxnfxGWfFFouX0oUe2xeqQmslVjTKCEg>
    <xmx:Hu_sZ-V1OHG70NOw-5vtddAixAHcn8u8qd_vPbufy-pw0rZ7Sbc6Ug>
    <xmx:Hu_sZ6TqsIcu7nnjLfnU3DRF8DroLoCBMY_c7EqMnvWoJ-R_mzCZZbcR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 04:02:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 494854bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 08:02:36 +0000 (UTC)
Date: Wed, 2 Apr 2025 10:02:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Yuting Zheng <05zyt30@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC] git-refs proposal draft
Message-ID: <Z-zvGzD-mdwmaYrX@pks.im>
References: <CAMvj1+rbYKFNeWEvvN76MTpzfuWc4TN4ViXRE4nTfWy7ZMspWg@mail.gmail.com>
 <20250329150248.2274482-1-05ZYT30@gmail.com>
 <Z-pjjQhtCjLvghGl@pks.im>
 <CAMvj1+qdBb-6nDVzw1y60-C5+wknJVr=JM+4ZiAftob3Ynbs5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMvj1+qdBb-6nDVzw1y60-C5+wknJVr=JM+4ZiAftob3Ynbs5Q@mail.gmail.com>

On Tue, Apr 01, 2025 at 09:37:50PM +0800, Yuting Zheng wrote:
> Hi Patrick,
> 
> Thanks for your feedback! Here are some adjustments based on your
> suggestions:
> 
> > In any case, I don't think the naming and how exactly each of these
> > commands should look and work like needs to be hashed out in this
> > document. It's nice to scope out _what_ we want to achieve and propose
> > how this could look like, but ultimately I think that most of the design
> > should happen during the project itself.
> 
> OK! I may have misunderstood it. I will remove it.
> 
> > This one is something that is up for debate. While I do expect that most
> > of the commands should remain current semantics and options, we could
> > also use this as an opportunity to think whether there are any issues
> > with the current design and improve upon it.
> 
> So, discussing the specific implementation of the command should also
> be included in the proposal, right?

At least the general direction should become clear, yes. The intent is
that we want to double check that the candidate has indeed invested a
bit of time to understand the problem space and what is being asked of
them. So you don't have to provide all the nitty-gritty details of how
exactly you plan on doing the conversion, but provide a bit of an
overview of what the project would entail.

> >> - git-refs exists
> >>   Replaces git-show-ref --exists, providing reference existence checks
> >>   with positive (<ref>) and exclusion-based (--exclude-existing)
> >>   verification.
> >
> > I'm not quite clear what exclusion-based existence checks is. How do you
> > check whether something exists when you exclude it? I don't think that
> > this option is relevant in the context of `git refs exists`.
> 
> Sorry, I made a mistake. I meant to convey that the `--exclude-existing`
> option should be included in `git-refs list` (replacing
> `git-show-ref --exclude-existing`), which then lists refs within a certain
> scope.

No need to be sorry, we all do mistakes.

[snip]
> >> - git-refs update
> >>   Replaces git-update-ref, providing transactional reference updates
> >>   with batch processing (--stdin) and atomic guarantees.
> >> - git-refs delete
> >>   Separates the delete functionality from git-update-ref, ensuring
> >>   explicit handling of reference removals with safety checks and batch
> >>   operations (--stdin).
> >
> > It's up for debate whether we should even have something like `git refs
> > delete`. As you rightfully notice `git refs update` already handles the
> > usecase, so it feels like needless duplication.
> >
> 
> I think maybe separate `update` and `delete` can be more direct. Separating
> these commands can enhance clarity in their usage, although I'm open to
> further discussion if the community prefers a unified command.

`update` will have to support deletions regardless as you won't be able
to do atomic updates of many refs at once if that update would include a
deletion. So let's start with that, and then we can still figure out
whether `delete` would be desirable.

> > You probably underestimate the time to review and land a specific change
> > quite significantly. Landing new features in ~2 weeks is thus not quite
> > realistic and you should allocate a lot more time for each of the
> > specific subcommands.
> >
> > That of course raises the question of how to squeeze all of the
> > subcommands into a single GSoC. And the answer is that you don't: it's
> > perfectly fine to implement only a subset of the new proposed
> > subcommands. I'd rather you spend more time thinking about how to
> > improve upon the status quo for each of the subcommands and thus spend
> > more time on it than trying to do everything in a hurry.
> >
> 
> Thanks for your reminder! I plan to focus on implementing `git-refs list` and
> `git-refs update` first. These will form the foundation of the new design, and
> once stable, I will consider addressing `git-refs resolve` and additional
> commands if time permits.
> 
> So, I need to update my proposal to reduce the number of subcommands so
> that I can complete this project with high quality. I also need to
> further discuss
> the implications of these commands. By reducing the number of subcommands,
> I can dedicate more time to refining each one and ensuring they integrate well
> with the existing system. I will also detail the implications of each command in
> my updated proposal.

Great, thanks!

Patrick
