Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8732CCC0
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756051393; cv=none; b=ZjA/POVSSBKxc9kzyOe1qRKWNWu2+gWUelhmGPpRGzW67rFIb4W5CDZzo9JRVTyATHo8r4zoAqcw3gmifjmbecWUIOF4qZmNOo0HTwxzG1HDgla7DA99VcaS7rBAo7qstqRQht/P1Ftx9FCXILlVwX85bx8JS5gQvQnUlHCp2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756051393; c=relaxed/simple;
	bh=H9eDG0W+aP0zvijEQgkEA2b9AAl32o5mtcal4Yr+zQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rD88PNCKjsCnEhDvbZFzmGHKoxZ8ZsZOSb2BkG9GSidkq+/eWi3oWF8O+yNksgx6umje5J9BohLcMl0l91tPATGY0g3CClIqkFWhNe18M0Cq/yI1LQ4xp/jLyKUQLGFXKeQBLaZ54vj7HnEPan3w5ao0x87orPOwVpQqMhlgsag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Om9XNHKo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kwRJlO/K; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Om9XNHKo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kwRJlO/K"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id C93571D0010E;
	Sun, 24 Aug 2025 12:03:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 24 Aug 2025 12:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756051389;
	 x=1756137789; bh=SfHQf6m/xBn1jaNOixIKCjA8RVqIV26g/ylHVrd2eNU=; b=
	Om9XNHKoyAtoMFK15s+qv0Z3VyWvcXwRqeVD6vcPSLYqziwJpMi0cU/vHtoOR2PP
	hlmEPqcbxwNC1iejEebxeIJz4qdaXM56K7+8/vU7s+M+xGtGagGiSRZco20cAxGz
	cQpMYpRwQiWVDoGq3teM3fe/pjZhUr0q+n85YKB3lND9YwilC5kJmKhS0Ob8qXsp
	QhrKeCT/IOqAcabgcJWdk6bziJzF2vBiZWBj46I1FgtuvsaLuX9peJ9W8dq5Ax57
	oXFx+tE4J0/M4Hj0xCuYLInKk4yFjhaD3P/pKwbQBUzbY/BkhnN6aHxiH7bHWDPy
	TcdwaJbsNm8/BsBtjDRiOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756051389; x=
	1756137789; bh=SfHQf6m/xBn1jaNOixIKCjA8RVqIV26g/ylHVrd2eNU=; b=k
	wRJlO/KAlEkE6rnSXTgplWxzELOpOfEo1T9rRj50yN6MjTiDZY5PPq0PPfg7ZlOJ
	fVRoYCMqMzm5r7cSNXkVrrQXEj6j+0KjIHd2SA7eJ38kOkmcnD7qMgzkOPg+aKNa
	wdnsEG4ZQMAPhYwoq0wde32jXEyLk74bAuDVHAam+3UPpoK/5UV3NrrdEgG2keMD
	JVAfdkSFrwSbQr9jk1cQ3yLgKpGZmlp2U+1qBt32A2uj2iIvjTW8710I2iqXt8jI
	u5docbz5Xkqddo6UvGCykVE+WbTPV0zZ16nYjmtVCWFA6QHBbbOTfnHMVt+YfxBG
	F17mxX9c3f5kKZ5Kv3ueA==
X-ME-Sender: <xms:vTeraN8AaaBCek___p2lO5-2msbIu49Qg0_uVKUCe5qWxE1CbP_Ftg>
    <xme:vTeraB6vWgdVNiceYOBYgGHTRaXSUdEFsf_PFEdOboZ1If4YSg260mh-AKk9Qz-Yz
    6YqSRqckHjC0d2SXQ>
X-ME-Received: <xmr:vTeraM3MczYvnc2o7ZTl_RbX0JiDsy2ZahcBy2fnKp9IOZ8K9fUkIZTTAveza-EgnTOHdAFP5j7rVLagQdyxZVvve9l74oRs33Zl9tic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieelleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedukeeuvefgkeduffetvdehgefgvdehuefgtdelueekueffteejteffhedtgffggeen
    ucffohhmrghinhepghhithhhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:vTeraADfELai6Q1qlLeFtUGioluEMmALiCdiNULz26VfikkwTpNj5w>
    <xmx:vTeraG3eIN8cQIlHxq9zyQr7g1-hw9QrfhDp49Sdt8MmHcerVJ-uZg>
    <xmx:vTeraCtV5fZwwPgrIkwLbnMUMMhkC46OauclHZZteI4-vjX0E7ayfg>
    <xmx:vTeraO7cn6kgiMBf4SrDM1vvy-z8rBaXt1IYTWgqRvi2eGAqcTz3Lg>
    <xmx:vTeraKND3kAdXqkihTp1KIB0ujeBpETm62taHTtrXyG5GLdoMxELN819>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 12:03:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e1301248 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 16:03:07 +0000 (UTC)
Date: Sun, 24 Aug 2025 18:03:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Martin von Zweigbergk <martinvonz@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
Message-ID: <aKs3tqjE510MF0T-@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>

On Sat, Aug 23, 2025 at 06:25:06PM -0700, Martin von Zweigbergk wrote:
> On Tue, Aug 19, 2025 at 3:57 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Hi,
> >
> > over recent months I've been playing around with Jujutsu quite
> > frequently. While I still prefer using Git, there's been a couple
> > features in it that I really like and that I'd like to have in Git, as
> > well.
> >
> > A copule of these features relate to history editing. Most importantly,
> > I really dig the following commands:
> >
> >   - jj-abandon(1) to drop a specific commit from your history.
> 
> It also rebases all descendants on top of the parent(s) of the
> abandoned commit(s). Branches pointing to the rebased commits are also
> repointed. So is the working copy if it points to a rebased commit
> (the closest equivalent in Git would be HEAD). Do you plan to make all
> the `git history` commands behave that way too?

Yup.

[snip]
> >   - `git history reorder` to reorder a specific commit before or after
> >     another commit. This is inspired by jj-new(1).
> 
> It seems more similar to `jj rebase -r X -A/-B Y`, which rips X out of
> the graph and inserts it after/before Y. Just FYI; I'm not asking for
> any changes.

Fair enough. I think calling this `git history rebase` would be
problematic though given that "rebase" is already a widely used term in
Git that means something else.

> >   - `git history split` takes a commit and splits it into two. This is
> >     basically the same as jj-split(1).
> 
> FYI, the default behavior of `jj split` is to split the commit into
> parent and child, but there's also `-A/-B X` to take the selected
> changes and insert them after/before X, or `-d X` to put them on top
> of X.

Oh, that's neat and I can totally see how that is useful. I'll not yet
add such a change, but that's certainly something we can add at a later
point in time rather easily.

> > If this is something we want to have I think it'd be just a starting
> > point. There's other commands that I think are quite common and that
> > might make sense to introduce eventually:
> >
> >   - An equivalent to jj-absorb(1) would be awesome to have.
> >
> >   - `git history reword` to change only the commit message of a specific
> >     commit.
> 
> FYI, `jj describe` can also change the commit message of multiple
> commits at once (e.g. `jj describe main..@` to edit your current chain
> of commits). It concatenates each description with some separators
> between in that case so you can update them all at once in your
> $EDITOR.
> 
> I'm letting you know these things in case it impacts planning for the
> CLI arguments.

And I very much appreciate it :) A bunch of the functionality in Git
will have different terminology so that it fits better into Git overall.
There for example is already the "reword" action in the interactive
rebase code, so it makes sense to keep on using it. Same for "drop", for
example.

> >   - `git history squash` to squash together multiple commits into one.
> >
> > In the end, I'd like us to learn from what people like about Jujutsu and
> > apply those learnings to Git. We won't be able to apply all learnings
> > from Jujutsu, as the workflow is quite different there due to the lack
> > of the index. But other things we certainly can apply to Git directly.
> 
> Perhaps the simplest thing to copy is revsets (which we copied from
> Mercurial). See https://jj-vcs.github.io/jj/latest/revsets/. It's not
> at all simple to implement, but I think it should be relatively simple
> from a UX point of view because it can probably be done in a mostly
> backwards compatible way.

True, I very much like the way revsets work in JJ. Whether it can be
used in a backwards-compatible way... no idea. I'd have to think about
this more closely, but for now I think there's other, lower-hanging
fruit :)

Patrick
