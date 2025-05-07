Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641F51CEEBE
	for <git@vger.kernel.org>; Wed,  7 May 2025 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599276; cv=none; b=YcnYFpQZ6YBcb0UZL/H+bDhz15TLtb9s9WjGbxkcDrW0yTfSeQIITta2jCCH9ZOga0Isvl5fgQXch8AdhhNhOEl0tqENnFmtZ7iR5HnPKktFMlUWZNdznwUETbdRh3CDtd5grPXkF58SP2JadkhNGJ9mMv/7KxPG9bn6FbaigxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599276; c=relaxed/simple;
	bh=SRCkk7p/+Oj+DvW7y2BSzmzHAmyQaVcSsP7hOD+Vs9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4yu/oOHanIZmyeffbIy+F/yoXd+0dnv7xgxH0/j/S4BBYHsFrGTbCfYQkFkuc96ztSgnfUm3qkPN7ap/rmpwB+7apvE+HlEr2qzaeS3paVHuCJBEtx5MfJDZ450F41FS60wDuyhlyTgjuR7/Wr/7KQynU+fBf+LTp2o8Gq++ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b3LKfkzB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lQ3joB2I; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b3LKfkzB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQ3joB2I"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 894811140081;
	Wed,  7 May 2025 02:27:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 07 May 2025 02:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746599272; x=1746685672; bh=8+/P3rWsrx
	IXYz+nNKdQu7W9q/J41WxaTpjnrGyT8dY=; b=b3LKfkzBAypKC8I+pWWFvDaJOn
	kjSIqRLD9kA8um9Z96TxwHl4HhqlRXmh1YwpBs1g7rL00mLui1zr9nAbZJy81oH2
	0hVtk0BvfixY0caicseRAZs8EL2tC/TaM6ELro3lDVNl5di/x+Gl8cSLv0rUMbDz
	htP8rniFkKC6LWaMuIJegpiqYAeUwSQ+JuEord5muLBsYYxkzJPJM5yQQ0AS95gR
	+Cil61DPXCq5OwOHXPvtO3+xxfFB72NtK9MGzu7/0ILQdGvlou9Kwsr8nzdGRbww
	+9VV2yLwlzh+9mCMy7gheuNweZ8s/Z8rI4qL+rfDI5hHLgcfTHzQsqvC8yVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746599272; x=1746685672; bh=8+/P3rWsrxIXYz+nNKdQu7W9q/J41WxaTpj
	nrGyT8dY=; b=lQ3joB2IA1B8tVPZNo3/XTDIJ465mxpXPR6eO3Rq+ycaF0nETob
	e3zCDVLMCqCUPbSMiWreIQcNYrQNOzY4dEf1eHrMia4chasK4GPZkmC8G0nFvwVi
	HLsW2LAu70iaFucPbT7qPr78bba8q9F54Q072Ix6Nm4dMtQrmESAgSEw++Q3Sa/M
	/BwIZVA8RXqbYvze+hXZmneG5eqPUNS5an4uIdsDEZmgEpoEDa8yVfn4nsmn2HbS
	2rble18Yz2h5Q3AiYz6nDJx1WsY5xcbmW9QuFg5SkZgF6Jp5XA/p7g4bIzo32b1l
	XZGP7bZrsIY6EJDI0EYM0l3JCnS5P/K1klw==
X-ME-Sender: <xms:aP0aaP-lpsfv1uXu760Q52f13AhLdxEuCXMS4IxbaaMuSG9WZVfmBQ>
    <xme:aP0aaLvjISyhkxrMcpaZN0bWloOa7kahZP1vV-6Y3YDoutO2VtQijz1xu1l1wiXQf
    IJlwMeX-ZE5qJe_0A>
X-ME-Received: <xmr:aP0aaNBQzE5Uyyt-sNoPL0nPWsiBtow1J1pNbnkOId9ACRjexC4NTffBC34TGLgCAaVIss_qUqJUsJ9iMN2jOICvJbgdzmXARet5OyQznuQ-Kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeiudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:aP0aaLe0PEJComX7zq5SRfAaeYSflTrbiaNGzuuX9okXmmFFOk8gsg>
    <xmx:aP0aaEMgLUWbusWP47CHRUx8we9NWkN0G1-c1NpubZkuG8ulHJzm7g>
    <xmx:aP0aaNmK3VdFis9BceQokENH3S1nfoLfDtV_8wFOqxCmN6jQPodRyA>
    <xmx:aP0aaOulvBS-Q_6g2Cg82l48fxcATZh2d09EOkoN90J-5EI6qo4NSw>
    <xmx:aP0aaL-r-Q588NlFba4hJlT40qW9UwOB-SOgrpWmZzAogJHuZVcLEeFW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 02:27:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c62e5b1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 06:27:48 +0000 (UTC)
Date: Wed, 7 May 2025 08:27:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/10] contrib: remove "git-new-workdir"
Message-ID: <aBr9ZhSmbYtRp6o0@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
 <20250506-pks-contrib-spring-cleanup-v1-10-e6d5ddd79a72@pks.im>
 <xmqqjz6tikak.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjz6tikak.fsf@gitster.g>

On Tue, May 06, 2025 at 12:57:55PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The "git-new-workdir" command has been introduced to make it possible to
> > have a separate working directory in a different place. The command thus
> > predates git-worktree(1), which is what people use nowadays to create
> > any such working directory. As such, the script doesn't really have much
> > of a reason to exist nowadays anymore.
> 
> Yup.  As the original inventor of the concept, I still have one "new
> workdir" I use daily, without any problems, so I think the layout it
> creates (actually, it created 10 years ago) is more or less still OK
> with the current binary.
> 
> But even I do not create a new one (not that I run "git worktree" to
> create an equivalent all that often).  I do not have an objection
> against the removal.
> 
> >  contrib/workdir/.gitattributes  |   1 -
> >  contrib/workdir/git-new-workdir | 105 ----------------------------------------
> >  t/meson.build                   |   1 -
> >  t/t1021-rerere-in-workdir.sh    |  58 ----------------------
> >  t/t3000-ls-files-others.sh      |  19 --------
> >  5 files changed, 184 deletions(-)
> 
> Oops, do we have tests that depend on contrib/ stuff (other than
> completion and prompt, which should have moved up long ago)?  That
> changes the story a bit.

The tests we have only verify that unrelated feature A works well with
workdirs created by git-new-workdir(1). So that alone isn't a good
enough reason from my point of view to do a full deprecation cycle.

> Shouldn't we do the usual WITH_BREAKING_CHANGES transition, then?

That is a very good question, and something that we should hash out as
part of this cleanup.

As you have mentioned, "contrib/" nowadays is expected to work as a
staging area for features that aren't quite ready yet, but that should
eventually move into Git proper. But if that future never materializes,
either because we notice that the feature just doesn't work well or that
the interest goes away, then it should be fine to drop that feature
without a full deprecation cycle.

To me this feels a bit like the whole point about "contrib/": it is an
stepping stone to get something into Git, but we don't provied any
guarantees until it has been promoted into Git core.

I know that this is certainly a revisionist attitude, as "contrib/"
hasn't really worked like that in the past. I think though that we have
outgrown the old concept of "contrib/" for quite a while already, and
that it doesn't really work well in its current form. The ecosystem
around Git has grown big enough that we don't want to and cannot host it
as part of Git itself anymore, so that original need has gone away.

So I think we should rework our "contrib/" policy so that it serves a
better purpose in the modern Git ecosystem. It should be a staging area
for new features that are experimental. We don't provide guarantees, but
we will ensure that things don't bitrot. If they do start to bitrot and
nobody cares, we throw them out. If we eventually see that the feature
is getting nowhere, we throw it out. Otherwise, if the feature is
eventually deemed to be stable enough, we promote it to Git proper and
are happy everafter.

If this is something that the project can agree on I'm happy to rewrite
"contrib/README" accordingly. Maybe I should even do it without having
any consent yet so that it can serve as a starting point for discussion.

Patrick
