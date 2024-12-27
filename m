Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA31D320B
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735310078; cv=none; b=QTRBODiE4Mqcaz0TDpOd7zqw+4GCUyiwn91CMr6t8d5asqJwM4op3NtDgt0xuAf4x9ILY+4SOI3bvoVCY9aLJFFc4bK615nSVmTOwWeYS5LZq549eYlW0TPFVJQJlWAGV7OMQTn2t3/btLyYAlvF8xxneqzEg4MkGeA8rt6sZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735310078; c=relaxed/simple;
	bh=Yh5qHz85IAIo8AbUpXoSJNPjN7sRDylplwOLCFp0E6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOwMjk0+6sBfpVV26cIC0oKvmEF1D50Sh2HTurHEFMpmVOkIKJbs50lgYJnqy/agcQxfpCDGKstGIzMJb2Ai/bI3X7fE706JBFnwUPybKEOKFsW/5EPtpbq7OAVIJXJ2N5GO+haqZMbUmgngMsBiKu5mmbhOgE3YsNhEWVFQgws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NzFv/jPD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ObNggOTJ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NzFv/jPD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ObNggOTJ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D0ABE25400CE;
	Fri, 27 Dec 2024 09:34:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 27 Dec 2024 09:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735310075;
	 x=1735396475; bh=co0Hu1azSafOGR6Hh1cy5BJohCcd6+kDEnBdQLRhkMY=; b=
	NzFv/jPDR/kFQfKxvac1lg/6iIQazZrTTSPwZe87bDQM1eOLLrr86GniC7Ci/eEz
	QoLnjUbIMloRNed97AzDUk/SOZ2EIEJHKG0gvUTk8qINlhYlowy1J3T9BjuWnlvJ
	O0Sd77MUbGq0qIKg+LGlb4b8IBDYrViQYqAWr+M08ljbP03W5lIfdOVesjA+q8cE
	JNKcfftJoGo8Cq4VBdw1sMltx8rgc1T04zXW2tiVrG2/w+R17MysEI5BFY3Ec9Xw
	HhyKIvGpTj8BlsoJfBwtowH/lyFWAKavB4+WEG0BvHbdPtqWW4rouAggqhoRtXqo
	oEsFIVwMwHXJqJi3UsPVjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735310075; x=
	1735396475; bh=co0Hu1azSafOGR6Hh1cy5BJohCcd6+kDEnBdQLRhkMY=; b=O
	bNggOTJy71kRRLCkQDhKAbeJI3sF66ZgZUosPVHd4BiLnew4cbVdMJ/SLlwzFD22
	VhK5ta1MvqK2o3pSjhQ70ORUex6NjKoblf393eExsqCIPLU4MwHkMr/LilhVkGIQ
	hFTkKHYELL08kOQBrxxfcsjd4wUTgTz75aQ3nZfbohd8Ql6bIWIKlJMTZH88MP+Q
	+qwZxHnsMNeXd/6mRbAJqDMIw3wHpPgXKiecrIuJaCHyddGAY6Lbl1VncVPM52pN
	ZFuF4rCsJx8wGOFF4MDESlETVROdgxzaVom3Kdu+z8F1fnbVOzH7HHxvpRvW79ox
	tzMLqxt1WY34E6vnk1eFQ==
X-ME-Sender: <xms:-7puZ3M09UNc_msjXDETCULPk8CdM-4nOq1l36PrjpHgERFUnr0PjQ>
    <xme:-7puZx_DgJhRC9tiaArjLxxx5mRUMAvwcvM89GElVmNfILZpOdWZNBMDJ0a1fv9Jr
    yb3QdZbb11SnthRdQ>
X-ME-Received: <xmr:-7puZ2RGFVjyX2INGH_jshvxOrQmRNot6gHPewGWpIAwKv8U061CQNX57Fk3IyVjI61B2Qp6pBM__f6iI6aOhkTkiCcOqnPwwFo5jN8QaFFcfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopeguohhrvghmhihloh
    hvvghruddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhfuhhnnhhivdefgeesghhmrghilh
    drtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:-7puZ7s8YH_eZh6DyiZaIh0PwDCsyGowF17_TPtOyqbqG2n92Q0tPw>
    <xmx:-7puZ_ehMRWrzbGmwJ8Et9Guhyv-IwSehcNY1IX511nrSc-RmhGBng>
    <xmx:-7puZ318QKDGgmbZLn-JPDqqX_C_dQIqmYmyxxysRAA9XV4BYiuTZw>
    <xmx:-7puZ7_gJsen-A_WV_fFxgR-bDoyKQaQl94qR0eRY_jZi2MTT0Ptzw>
    <xmx:-7puZxtTrbZu8MgV9L-Ces2tjKGCEbt3OV1Xj-opdsh-tQZUozUAladi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:34:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a1681fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 14:32:29 +0000 (UTC)
Date: Fri, 27 Dec 2024 15:34:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>,
	AreaZR via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, AreaZR <gfunni234@gmail.com>,
	Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] refs: exit early from the loop if it is not a main
 worktree
Message-ID: <Z2665YeBYXUYB12D@pks.im>
References: <pull.1848.git.git.1734488445457.gitgitgadget@gmail.com>
 <Z2LOpOxu0oAY0DW3@ArchLinux>
 <CAPig+cQd=vc5rte47biFbR+w_DV2OhdCRpC2WH_dKsSi4wvZ2A@mail.gmail.com>
 <xmqqv7vgo4u7.fsf@gitster.g>
 <CAPig+cTf=Lm_yNWQPq2SKfuROhSMMwNVXNmXhags43SRKonwxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTf=Lm_yNWQPq2SKfuROhSMMwNVXNmXhags43SRKonwxA@mail.gmail.com>

On Thu, Dec 19, 2024 at 12:54:55AM -0500, Eric Sunshine wrote:
> On Wed, Dec 18, 2024 at 8:10 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > On Wed, Dec 18, 2024 at 8:30 AM shejialuo <shejialuo@gmail.com> wrote:
> > >> On Wed, Dec 18, 2024 at 02:20:45AM +0000, AreaZR via GitGitGadget wrote:
> > >> >               if (is_main_worktree(worktrees[i]))
> > >> >                       continue;
> > >> >               ret = 1;
> > >> > +             break;
> > >>
> > >> So, when we find a linked worktree, we just return the value. From my
> > >> perspective, if we decide to optimize like this way, we could drop the
> > >> loop because the first element of the result of `get_worktrees` is the
> > >> main worktree. And we could just check whether the "worktrees[1]" is
> > >> NULL to do above.
> > >
> > > You're correct. get_worktrees() guarantees that the main worktree (or
> > > bare repository) is the first item in the list, so merely checking
> > > whether `worktrees[1]` is non-NULL would be sufficient to answer
> > > whether linked worktrees are present; no looping is required.
> >
> > Would many other callers potentially want to know if the repository
> > has more than one worktree?  It looks to me that the has_worktrees()
> > helper function in refs.c is a sign that the worktree API is missing
> > a function.  Calling get_worktrees() to prepare a list of worktrees
> > and then counting the result, only to see if there are more than
> > one, sounds a bit wasteful if we need to do so too often.
> 
> If the need to answer this question does become common, then I can
> imagine a function being added to the worktree API which tries to be
> smart about it by only calling readdir() -- and validating a
> .git/worktrees/<id>/ metainformation -- enough times to be able to
> answer the question.
> 
> However, although I haven't audited the code, I suspect the question
> "are there any linked worktrees" is rare, possibly only asked by
> `refs.c`. And in that case, it is asked only at the start of a
> refs-migration operation. Moreover, it appears that even that case of
> asking the question is probably temporary, existing only until someone
> extends the migration logic to work correctly in the presence of
> worktrees. (I'm sure Patrick can shed more light on this, though.)

Overall I have to say that I found the worktree APIs to be quite
lacking. It's surprising that you don't even have a way to load a single
worktree, for example.

In any case, for this specific case I'm not aware of any other users of
the functionality, so there is no immediate need to lift it up into the
worktree subsystem.

Patrick
