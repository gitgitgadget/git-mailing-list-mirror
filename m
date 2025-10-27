Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237DC2F3C3D
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559098; cv=none; b=kTKAczT47IYn//D76xQm+8o5aGKXGU4PNJmgEC40Sw+NabwlhfGEEeINhtoCtsOvWZit9ICHeQTixFgrCG5QEyzR8jExWjaN+iCEFV2fIFHMjpP3x+8TFfGR9gGWIl4iQX/HhZBG5pCez/4sSVbbOH+gDpJIHvWtcA910KCy4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559098; c=relaxed/simple;
	bh=0xQqsvGULIgu2UxmZ4jI+YHrX/jAr2AgMudBmCgAyvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nU8SC1fWhO1vzeDc9STjgjkY+3LuEgqL0BLBRhCYvkl2/F5L0d9TNTQIKGXwvqK48g3g7kl0r1XyC3z6OnrK7xTZFruMDC1DQujdfe9aHxagb0aA2vos7JW7HmWw5fUIspqri+INyByW4oierfSuBvFFdjm1NoaXboJYlzmkmC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ijIfPDRy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CVCGNYPL; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ijIfPDRy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CVCGNYPL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A9E5EC031B;
	Mon, 27 Oct 2025 05:58:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Oct 2025 05:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761559096; x=1761645496; bh=MhtQF1ZoU8
	BsxYyOOrEMuRx2TLCymJ/ofwAEo1GdOxw=; b=ijIfPDRyyr4+AzgRi4aVHwN2e8
	diaJJnwSfINk0PV+XseqJI31fb+P0M7qb8UvxdFgI9EHJI0cKMlhh43qGj0Jm9HG
	KzI0amRQ/UAvbfybnDe3xmZ30gCZWs1HKVERW/K2dEMv/5KkDOqzV2uEEBe4cCFm
	/L4bUdemDQ0ObgndLeeGsLIg5TFHGGdy6jHNmnEj8fh3iOgMN54QXAQ2ugwTElQK
	c+yFvzdXzZhUtFZQywAKmRtH7ZRFxZhdFMrYDy9Ys2TXmSrhJtvIjlCOhpH3FanU
	CdPinGAlHJL3eQnXsGyq11pzuNZjziqd0jjgzm/B5mREcc8iSj45bxbxUm8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761559096; x=1761645496; bh=MhtQF1ZoU8BsxYyOOrEMuRx2TLCymJ/ofwA
	Eo1GdOxw=; b=CVCGNYPLStIhlyQvCfbkmSnJP7OR4eJUz5t4IkwEnHQEoCrqFV3
	4gz1nFV37E4l0PHoQr5Q2+qsg7l1uwTgNfOaZhN+V2bIClxNOpCYbT1L93Ztp07l
	rd4+vgQXLsEU+vcN0r3S6b7GQ2sqfIZqg8qYScofKy0JQTR1sfVe5cA72Sm3He0J
	dIvR1VQLpsB5MsaDyI/ch+n1CHJdXOv7HEjewr5ytKn79Nak9JFl2ZeVmDyHdPMW
	L/xSd/gY5XqiTQVIR7zoWAthRr2OBAKZ4zYZ+NIxYSqWXrm5zNyZ4Jum6IXWFWWa
	lmtMwpx/K7dV2PcrrDFZnHMv54A3FnWYSpA==
X-ME-Sender: <xms:OEL_aK8peiKeoHXCUm2wvaLfueKN3UX3bktrTx5FD3wWZ6kbRC42Tw>
    <xme:OEL_aNTZftF5s9KP9UhB2AJp8n52A9a_uXy6a5xNyZ51NLldnCUVnikk5zwadRpzW
    j91kI4Y3CW9mSrqGx1YLj9RGF1xG6S_ZGmn3bWCQZVLZmFVvpwtgg>
X-ME-Received: <xmr:OEL_aDoMRVlKJ7qNDfexQJGe02Xy8js6GnTYP-FmNA9ynJf7KX8taSkO3Y0ZVB4xvU2kEfpCyvlWJjCPH25pwz9cE3dTzg4GX9eYR4Eg4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhhrihhsthhofhhfvghr
    hhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrg
    hnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OEL_aCkGZ6oGnh0uNPmLl8A8fBRLs3yc8qddkouUw0qD_0_haGX2lQ>
    <xmx:OEL_aEelstp0O8PHIj0oSk4sarp6ssdQscMom89a8n7kT8YfnHb1Qw>
    <xmx:OEL_aGrfo5-R1SHyZhYf8C3qnEOdMN6seHHd5XHZ3nNUImKYZiqfxg>
    <xmx:OEL_aGNYPt6a2iCUuiWDZdGMaTJIi6ST2nbVGvx5plTPlpA1hsZDFw>
    <xmx:OEL_aIJpRcn3Kocjpu67hFxyKKOslF-ZWi5mahK8WLjQvfaPucZIztda>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 05:58:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e269e4ed (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 09:58:13 +0000 (UTC)
Date: Mon, 27 Oct 2025 10:58:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 06/12] builtin/history: implement "reword" subcommand
Message-ID: <aP9CMa3dDuV_RGnG@pks.im>
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
 <20251021-b4-pks-history-builtin-v5-6-78d23f578fe6@pks.im>
 <xmqqa51kszvc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa51kszvc.fsf@gitster.g>

On Tue, Oct 21, 2025 at 02:34:31PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > @@ -9,6 +9,7 @@ SYNOPSIS
> >  --------
> >  [synopsis]
> >  git history [<options>]
> > +git history reword [<options>] <commit>
> 
> It is curious that a command-less form is still listed here,
> especially since this command "requires" a subcommand.  I would have
> expected that there will be a single line here after implementing a
> single subcommand.

True. You can execute `git history` alone, but it doesn't do anything
useful except for giving you an error and all the potential subcommands.
That's in contrast to e.g. git-reflog(1), which supports a command-less
mode that does something useful.

> > +`reword <commit> [--message=<message>]`::
> 
> That should be `reword [--message=<message>] <commit>` no?

Indeed.

> > +	Rewrite the commit message of the specified commit. All the other
> > +	details of this commit remain unchanged. If no commit message is
> > +	provided, then this command will spawn an editor with the current
> > +	message of that commit.
> 
> As long as it takes more than one -m and concatenates them just like
> "git commit -m <message1> -m <message2>" does, I would not complain
> too much that a command line option to give message encourages sloppy
> log messages.

I'll for now defer the discussion around "-m" completely, as the design
isn't entirely clear yet in the first place. So I'll just drop the
option in the next iteration.

> > +		if (!onto) {
> > +			onto = commit;
> > +			result.clean = 1;
> > +			result.tree = repo_get_commit_tree(repo, commit);
> > +		} else {
> > +			onto = replay_pick_regular_commit(repo, commit, replayed_commits,
> > +							  onto, &merge_opts, &result);
> > +			if (!onto)
> > +				break;
> > +		}
> 
> Hmph, I would have expected that the overall flow of this command
> would be
> 
>  * find the commits above and including the <commit> in question,
>    making sure there is no merge.
> 
>  * read metadata of <commit> like the parent (as we do not allow
>    merges), tree, author ident & time.
> 
>  * create a new commit object that has the same metadata as <commit>
>    on top of the parent of <commit>, but with the updated message
>    and new committer ident & time.
> 
>  * initialize a variable Current to point at the rewritten <commit>
> 
>  * loop for each commit C in <commit>..HEAD range in reverse order
>    (we know we have a single strand of pearls):
> 
>    - read metadata of C
> 
>    - create a new commit object C' that has the same metadata and
>      message as C on top of the Current commit, with new committer
>      ident & time.
> 
>    - make Current point at the resulting C'
> 
>  * Point the Current with HEAD.
> 
> without having to touch any "pick" machinery.  Why do we need to go
> down to the merge machinery for a mere "reword" operation?

You're exactly right, we don't need the "pick" machinery at all right
now. I think this is still a leftover from previous iterations, where I
was also driving things like an "edit" command that _do_ require merges.
But neither splitting a commit nor rewording it does require a merge at
all.

Will simplify. We can reintroduce the heavier machinery at a later point
in time as needed.

Thanks!

Patrick
