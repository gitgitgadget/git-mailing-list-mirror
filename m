Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4A2DAFBD
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758906; cv=none; b=BooR9aGyZehUZzRklTxv3o0KTyJ5vHrRvRRuABzRFcdTTZ6oy52cV8y3nN3krpE6aXtmyOXU0BIT1w3I/J+2UzFbCHgDnQg5lDp1dCmrc7cUCyuYBCV9sE5c4+WcnRyq9LMckqroeufzQRDxlEzjkinVtZZJR7QDX7qsfg2iGsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758906; c=relaxed/simple;
	bh=ViqgT2YLnaVhNbEdbIN9EIBVoztpQkdaMrdjGgAs80g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AblPmV3tSqUXRN0+lN/LZCfLVd83++q9B3nnPaVzuDcnloQCoOOUmmIaJ6zqd3wWDBr8mxaJW3UFKsaT0p9KsLRiBt2XmZP3yhS1ofU230b6skF/2/3C5F7Wxk3sTsCgOPrlV7q5OotB++z9YGMHVQe52Wt9WAx1466JzNye5Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IpzXBB8q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uE8TStTt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IpzXBB8q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uE8TStTt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EC4F14001AE;
	Wed,  3 Dec 2025 05:48:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 03 Dec 2025 05:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764758903;
	 x=1764845303; bh=EAH/uBg88IyY+6BeTAgWZN/0D50sbNo9aNKwYZg0g5g=; b=
	IpzXBB8qr/KFXot5V5lNdTuh3+6FFrIVj9opiOCcdEb1CofTXZBPYkzlP3j61Ei8
	pn9ruWueOLlaUx/7BXDF9Qs2qjt6Rm3z0utpM4m6w5GLuyKtokLiIfOFdXZOvMdy
	IIVmTIxSpUl7X55CkPi0RkFHmMhZbBsFO0qua9ixlAIouKUXVzCnRBNIBA+HkKZB
	2bpETGurdSo0KDi06CBxVzU7Cl12L9uRWjLQp8IA5Oz4R/5WG2pUxL2tZ1EvaDD/
	xI+f+xnD9C5Ilb9uNkFyOPS5b0PHm06cwiN38fgcGYunbHcpE9ITq9JLLaWGamWZ
	Z87BsqGFpEERS9rsjHqKaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764758903; x=
	1764845303; bh=EAH/uBg88IyY+6BeTAgWZN/0D50sbNo9aNKwYZg0g5g=; b=u
	E8TStTteP1C64pB3JRLo2r03ZaTMKeW7BnvJEni+OU4wgbg5fT+yRCQtdrofC1dg
	jnhT/1dTdFrClIAleoJ22BBtfrKeT2DdkqVFw/S5zFwP8u1RH5t91evhGDP8AVbJ
	Bvam+i+02PetK4lW0m6emTm7wevHj2gIoyRJNdBbkXBfpDOkbES5WQM8RF+WAYaA
	rlzKBX0Tf4DMTbF3KGLqUm0VyK1N+szVpepriBJ8CJznFztrBsIdv0KDo1Vu2kXP
	+zqp60Ib3RwTpXPW9dc1nn+uVjANo8hpDH+X9toTs5OhDXtXw25IzBVdpFNDkz0I
	mA8PJ5wbaxIDzv647Lijw==
X-ME-Sender: <xms:dxUwaX4kF8eY13-kKwGARE-wlql0dEiG_b72UTNbQWZFUxKOWEPo2w>
    <xme:dxUwafedf6rG3obhc-CiucGiCN6LSeIvG1ZyWOQL1gFpdFfSkpPOiNFGd0iuAplZR
    rzzZfc0O_zJHR8WWXkROm0YxrMyman7GqtV3b2ZUKd5bWwDvnub6Q>
X-ME-Received: <xmr:dxUwaSEBFJkDvioxTw5NU9-cVat-WTx6A52uxBAxWB7_80Nddd0_76_VLOH1GTjFzu0FP5Kl9ynhfinIJzI8OkK9ob1LD5A19e8-Nbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrg
    hnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrh
    htihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:dxUwaYTWgNz2oMgoRdb_fm6n6Bl_DpjKgdnAeqYf6g01XLSBAVigog>
    <xmx:dxUwaQYexl4aFIppsTiopPR5vbHTbpF6Hc-LosKXdg066FllR5JG7w>
    <xmx:dxUwab3ifUy5rjltEuET93y2KrjhvLXox5TUzJSHSe5bcAg_zPgYRA>
    <xmx:dxUwabpUkmA9MrzXK2YnxgD-9-VKJMSOQZfY3bHwtWZvUFKVVrB67g>
    <xmx:dxUwaV1WMg_fBIbMY07jC7hojFFd4H8a9hCLVib5CF7OlQiN-E7VC1BC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 05:48:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 378f6894 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Dec 2025 10:48:19 +0000 (UTC)
Date: Wed, 3 Dec 2025 11:48:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 04/11] builtin: add new "history" command
Message-ID: <aTAVb337XsGuRUTa@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-4-407dd3f57ad3@pks.im>
 <CABPp-BGSYKPB7met4U_4ECNgA9vb5y_AWnMWfpiisOHnd_OyhQ@mail.gmail.com>
 <aS80co7VTABD6nXs@pks.im>
 <CALnO6CDG5EMha8k4DPy=p0FT1hO_SeU0wxm6qn2+Q92xNY6hqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CDG5EMha8k4DPy=p0FT1hO_SeU0wxm6qn2+Q92xNY6hqQ@mail.gmail.com>

On Tue, Dec 02, 2025 at 05:44:15PM -0500, D. Ben Knoble wrote:
> On Tue, Dec 2, 2025 at 1:48 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Wed, Nov 19, 2025 at 11:02:20PM -0800, Elijah Newren wrote:
> > > In addition to what Phillip commented on...
> > >
> > > On Mon, Oct 27, 2025 at 4:34 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > >
> > > > When rewriting history via git-rebase(1) there are a couple of very
> > > > common use cases:
> > > >
> > > >   - The ordering of two commits should be reversed.
> > > >
> > > >   - A commit should be split up into two commits.
> > > >
> > > >   - A commit should be dropped from the history completely.
> > > >
> > > >   - Multiple commits should be squashed into one.
> > > >
> > > > While these operations are all doable, it often feels needlessly kludgey
> > > > to do so by doing an interactive rebase, using the editor to say what
> > > > one wants, and then perform the actions. Furthermore, some operations
> > > > like splitting up a commit into two are way more involved than that and
> > > > require a whole series of commands.
> > > >
> > > > Add a new "history" command to plug this gap. This command will have
> > > > several different subcommands to imperatively rewrite history for common
> > > > use cases like the above. These subcommands will be implemented in
> > > > subsequent commits.
> > >
> > > "...*Some of* these subcommands will be implemented...", right?  You
> > > only implement two of them in this series, not all of them, or am I
> > > reading wrong?
> >
> > No, you're right. The initial versions of this series implemented more
> > of the above commands, but at no point in time did we actually implement
> > all of them.
> >
> > Patrick
> 
> While I'm thinking of it, at work today I had occasion to use "drop"
> and "reorder" (from an old version of this series whose binary I
> happened to still have laying around), and it was very convenient.
> Looking forward to it ;)
> 
> - drop: I had made some changes on my tree that needed to be in a
> separate branch. I didn't want to mess with stashes for some reason,
> so I did "commit; switch -c …; cherry-pick @@{1}" (or something
> similar). Then when coming back (switch -), I could just do "drop @".
> I'm sure there's a better way to do this slicing that wouldn't have
> needed drop, but I couldn't think of it at the time.
> 
> - reorder: I have a series of mostly logical, separate wip commits
> that need some more explanation and might need further tweaks as I go;
> I'm working on uncommitted changes that logically belong to the tip,
> but spot something else that will be a separate commit. I make that
> commit, then "reorder @ --before-commit=@~", and voilà, I'm ready to
> amend again when I get around to committing the rest of what I have.

Yeah, I definitely do wish to also upstream these two going forward.
It's going to be a bit more complicated though now that we are building
on top of the replay infrastructure, because it doesn't know to handle
conflicts.

Maybe for an initial version we can get away with just bailing out on a
conflict and then iterate.

Patrick
