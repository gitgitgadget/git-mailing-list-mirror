Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC3C2F362A
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928836; cv=none; b=uufOPo9fWP2oUfJKD+ZYLNoQoNi31189mpIJYA6ejWEvzjmix4xMYQFOYv1GaMRikjV9nb02J1LjZJ3HmwqbANoA+zUA1o0cWUK9eT8gG8GnRPna5hyZVRar8YuRqiS31DkmDw3XU29LIbSshqbUS1vx3U6kPTwmIeKEDB0UAsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928836; c=relaxed/simple;
	bh=FSfiblYjMmdgAuFoPoCFEYUnrxdncgwSG2WXVKxtBN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN5KsNIUxpnBxWi6nfaWnnYoHbs5mqXqsLmX7sZ+WGb3WdR8xNN4jTWI4/obCN15rW8GuSAzjN6NTOE0UHFBYudYukvRFSK6g+KJf1Z+f70JS/xgiD+gTsQ4kY2wwm/p8u9XPH+oKgc0hoY6p+96J/DEMAFx2xrpHpHsYaGyEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mItYRAVI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ch5lefJE; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mItYRAVI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ch5lefJE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 38950EC00F3;
	Mon, 15 Sep 2025 05:33:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Sep 2025 05:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757928781; x=1758015181; bh=XHf336pmuo
	Q+C6uNEh/dEvU+zMJMdqIzaw2IOmWqH0M=; b=mItYRAVIdepWKqEWYV9W2XtOUm
	Y9ON+tIzI/5A+JSanwjRlCzF4ZU6cu6xeONkKtc74AyuT1790JwIVm4/FFLBk3SZ
	BK8AsdljrESTNvlxbPi8HOaSQNVTwCM3N24Ci9NKW/LPsOkDITlvGm8uTLBM/wlx
	pGIQgi1TVK1jSrkmLo4cPfDe1ZHylRQ5FyYsZi9IZZuSOosYyWBR1ACR7tiVrpq0
	Cnv3pskeW1vXZaveydHTHcKxJpszAjQbM/fsli2IhS2LhkxJK8GkZIR/WUYzc4cJ
	MCpIjW7Yw0XOXtY1nG9iHWZjdUCbx3BmAiqjbULMBH8AEBsjceTP4uJQf8Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757928781; x=1758015181; bh=XHf336pmuoQ+C6uNEh/dEvU+zMJMdqIzaw2
	IOmWqH0M=; b=Ch5lefJEOP4SDvzyEonJ03Y1sH+UIrB1tlyq7tozZqRcbIIVoaq
	1DY/tcv8ig9wn8/cUY2frslIhb+2srEMbC0nnGAC7zlXDr/KL1akeRYo7vuxmwm5
	e9gIMlvakNucrCZe8ywNZYCd1hfPnxoJ5yH6niyRQmTW7iEF/x5Wgjqcv6fHNs8l
	zaqdarYgMeWvWJXUHFM7PdNg5Dg1gqu0YXi8YHk6AjLWHDKpn0EDDT/nVms8jVox
	JL/EYkOcQZjv3gGUDcOArH4hq5wz+fyLJwqu9RPgTdMRXhNy39+5eWa0a/8XdlXh
	R8/F66WlgOCGhVcf8fIBVk1wvyYaqnztXDQ==
X-ME-Sender: <xms:TN3HaLH6AvsA6AxPolFmWivPCmaTHj683vhBWkT5vU4SmLrlFk4yPQ>
    <xme:TN3HaNhR6k5o0nRvWbfUI7KBWw27_7dftwm5UpoKCCiEjAt2sN7ehcdeNglXPVQqI
    20X7xiqsJaRIxbHvw>
X-ME-Received: <xmr:TN3HaODmJMMc6YQ-NZqqJCUFptw1E4XinOq7Wb1GtQ7LK-dhBLuwiaSSp2QVADjfDDuj3EE0clxL4-9aHa6eaQLRb2WpOgvyxYrwo7FU2PZngA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinh
    hvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggr
    khhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:TN3HaPTdZtcAteEKafQ6AwcERAPzGmCWcTIdP8K6f15BymzHL5vv5Q>
    <xmx:TN3HaDWZ2YnyR1IorUJNgPBAfM7rta5uCicwCKhkfOVCaUd4RL0FwQ>
    <xmx:TN3HaIeuRev28DyGGxs1FaGfIz6qJ_1snhh1uhIvyvoy0-CYiJpDgg>
    <xmx:TN3HaPJOect6N1ltXu9m2bghm06RsIZXMYgW65Jgjo8PJwAAJpRq5g>
    <xmx:Td3HaIqUHhBCmTPNHMuMof2DOnDcVtUfAfHEGABk7I6JHnZpbY1nMVTS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 05:32:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71ea4b6f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 09:32:58 +0000 (UTC)
Date: Mon, 15 Sep 2025 11:32:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v3 17/18] builtin/history: implement "split"
 subcommand
Message-ID: <aMfdR3JE4zq-2j9b@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <20250904-b4-pks-history-builtin-v3-17-509053514755@pks.im>
 <51689153-3012-4d3c-995b-69af296ea608@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51689153-3012-4d3c-995b-69af296ea608@gmail.com>

On Wed, Sep 10, 2025 at 03:04:49PM +0100, Phillip Wood wrote:
> On 04/09/2025 15:27, Patrick Steinhardt wrote:
> > It is quite a common use case that one wants to split up one commit into
> > multiple commits by moving parts of the changes of the original commit
> > out into a separate commit. This is quite an involved operation though:
> > 
> >    1. Identify the commit in question that is to be dropped.
> > 
> >    2. Perform an interactive rebase on top of that commit's parent.
> > 
> >    3. Modify the instruction sheet to "edit" the commit that is to be
> >       split up.
> > 
> >    4. Drop the commit via "git reset HEAD~".
> > 
> >    5. Stage changes that should go into the first commit and commit it.
> > 
> >    6. Stage changes that should go into the second commit and commit it.
> > 
> >    7. Finalize the rebase.
> > 
> > This is quite complex, and overall I would claim that most people who
> > are not experts in Git would struggle with this flow.
> > 
> > Introduce a new "split" subcommand for git-history(1) to make this way
> > easier. All the user needs to do is to say `git history split $COMMIT`.
> >  From hereon, Git asks the user which parts of the commit shall be moved
> > out into a separate commit and, once done, asks the user for the commit
> > message. Git then creates that split-out commit and applies the original
> > commit on top of it.
> 
> I like the idea of this command, but I think it would be much better to
> prompt the user to edit the orginal message after creating each new commit
> rather than asking them to write a new message for the first commit that we
> create and then not letting them edit the message for the second commit.
> We've got no way of knowing how they are splitting the commit - they could
> be keeping most of the canges from the orginial in the first commit in which
> case they probably want something simiar to the orginial commit message for
> that one, or, they could be spitting out something which means they need to
> edit the message when creating the second commit.

Yeah, Junio already said the same. I can do that.

> If this was implemented in the sequencer then we'd be able to reuse the
> existing code for creating commits and editing commit messages. It would
> also make the "split" command available to "rebase -i".

True, having it available in "rebase -i" would be nice indeed.

Patrick
