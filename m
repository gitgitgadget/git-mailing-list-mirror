Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63145254849
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713997; cv=none; b=LvKLAjf67FMOvAem6Tv+awk6UDxMC0IyJ+f3I++tUo0dFmsa9lSFqcGXOtZxB4ofAVlZW7u+GRWaf4lBa9/FNq2tjfUGOWsvreYIe/vZFhbeKNnQ6SZzdSPPbwlwqsJmSgZrhvlhsgnhNHOuvn7OvmgifI0FLmxO4JTA7GnR7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713997; c=relaxed/simple;
	bh=kVeYdkiaMDz9OtLYbCSaFhfdFS8iL5j1/ybkBTRDi9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imGs+Q8X54a5N7OOjTGai+GUrh/Rk/Z11DbN3Ww/9Cy1CH9iBMhHhZZIbMRM46PU9x9d6535Dk1eA3qAPmASYc5iQUL2GQK3iDk0bO1fE5HXg5AzXp1XN3EAM/72wUjy7AlsxJ3dqalpLUoeSD5gj/BSts9/gpJVARS8oWmwS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iOwJN8Oi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A/GBdFBY; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iOwJN8Oi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/GBdFBY"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6AE551D00136;
	Tue,  6 Jan 2026 10:39:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 06 Jan 2026 10:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767713993;
	 x=1767800393; bh=tsNSCkqgZDI+rFqjrbAGbPAM8hBp0qCKq4nQpGTDdeA=; b=
	iOwJN8OiZqOT0ASe2n84LoGOE6BorgN3FNIyQCXSoACWnFqoVk3+FeckP7gXFkc5
	ZCC2BwKOkLLxjfDrMsPcv1v01vWeCoDtQlQOf+ejjAKnK7IIfoZiVqrOqNnEqN9C
	ruff4E9HW5qRVp+0TOSH94gtEw5VDxijCQ0Miq1dQpE2NzwqjfOTA29QhCs3br2Q
	DqT9j7OUFxiUDJMzk/RIDLUOfkQxlB2iFOoCSXPoOOjV4P2ikZCmSPij4heUFsZp
	aR1zgg/7eOm1Gy9j48cgtTPAyqF6Odqf9jy7QveCuMZWmdjsasjCXTGIjD5N3MeG
	DJDh1woIVlCll77b67bZuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767713993; x=
	1767800393; bh=tsNSCkqgZDI+rFqjrbAGbPAM8hBp0qCKq4nQpGTDdeA=; b=A
	/GBdFBYhsvbbMZANI2x5Skw2gCDzr9/nMFDNMuC9FBE/l+9K4+DCBq6v+BLbS12u
	wLYlWWkK15utU/7kbPVO3zGZ6wem1ruBoCxlI6QKP9pTuocMSwbxeaNRDTbOOA+l
	X3y/s6uKomHL/FBeYp8Q94EVz0rAAcW87Mg+ZGCk4X7m7yPDrqgDt+AISPG8gSCO
	4KtwZOb0tWgmKf44ererBBuZgQP1R2f1lpaGzP5DeMAmYlLOnyF74VH8C+mkHpaQ
	cD4aBL5NaTVREWBvflBJ1by0FujHNvRI7maGjt+CJAOIOZ9GuPe9tEUwqqAC97DF
	Uf/k8Yexwtv8erzOkJxLA==
X-ME-Sender: <xms:yCxdaXB-hYgPpQ_Qj4MqsQ2cMXvmR0_-u8f1PUT31hOkNFd3EFqMPw>
    <xme:yCxdaXiTmDTPNo39xyYXDHDxavJrcZZ1JVaGHiybcb90MOLpBC9qX1i60W-5aeC_U
    IoHAnVr-B_gY2ff5oMsQc0s8nEo9PYJW82iX8rVKz6hd_WI0MKyaiE>
X-ME-Received: <xmr:yCxdaZMoU6QIa-k8A0BL1L39UczNYvf6is84rWUdnZGHOe62fMo7roqqe2zeKhOOom5i2FM2NkyhogUMaUgkiDdqusHTrWCZBCY5H1Mi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmrghilhessggvhigvrhhmrghtthhhihgrshdruggvpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgusegu
    uhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yCxdaX9WGHA0pG6Z1VLMrsEhgd4CwBtrlCEjZn_ZO_jFNv2x2nvg1w>
    <xmx:yCxdaac-6vlKhSdzTT-dQPD2kopCOLYBt5joYhcpXCgPmlRngCjhDw>
    <xmx:yCxdaWyXrqMPNqFlCV0IC1tHT6KbeIXuSgAIl7vzaRhHnyhNbhrTew>
    <xmx:yCxdafJVD1SfcgzBxDzzsJJiHjhwfF-yv7wlVddHYY_xnNIMVXwZtg>
    <xmx:ySxdaTETvu7LJFuZVbTzxQMwZemFDSLfHgbKc4iUbYcr4hm4glC4Pbf3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 10:39:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3b4cd08b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 15:39:49 +0000 (UTC)
Date: Tue, 6 Jan 2026 16:39:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>, phillip.wood@dunelm.org.uk,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
Message-ID: <aV0svlRpEZPoJmkO@pks.im>
References: <aKs3tqjE510MF0T-@pks.im>
 <aMsWL2cSoytbmRjA@szeder.dev>
 <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com>
 <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
 <a6efc710-4062-4955-8fe8-bb6d428a44c1@gmail.com>
 <xmqqms3qh13e.fsf@gitster.g>
 <aUVDax0PbkaXGB61@pks.im>
 <CABPp-BGE1PC0RhpkfABUL74Yade6HkMQd35bv0my9A2+1VY6AA@mail.gmail.com>
 <CABPp-BG9h1xxp9b2UfE00EaKozk5kGAUELe-Od139amZdAa47g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BG9h1xxp9b2UfE00EaKozk5kGAUELe-Od139amZdAa47g@mail.gmail.com>

On Sat, Dec 20, 2025 at 08:51:23AM -0800, Elijah Newren wrote:
> On Fri, Dec 19, 2025 at 8:30 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Fri, Dec 19, 2025 at 4:22 AM Patrick Steinhardt <ps@pks.im> wrote:
> > >
> > [...]
> > > Okay, so the majority of folks here seem to favor rewriting all
> > > dependent branches, which is also the default that JJ uses here, and
> > > git-replay(1) does it, too.
> > >
> > > There is one major difference between git-replay(1) and git-history(1)
> > > though: the former works with revision ranges, whereas the latter does
> > > not. By using revision ranges we avoid the problem I have mentioned in a
> > > different branch of this discussion, which is that we have no easy way
> > > to figure out which branches we'd have to touch in the first place. This
> > > is because we simply walk the revision range there and then look at
> > > which of our references point into that range. That's simple enough.
> > >
> > > But in our case we're not working with ranges, we are working with a
> > > singular commit.
> >
> > I don't understand the distinction at all.  `git replay edit` also
> > took a single commit, and then implemented the obvious (and jj-like)
> > behavior of rewriting all branches that descended from that commit.
> >
> > > In my head this meant that we'd have to basically do a
> > > revision walk that starts from all of our branches so that we can figure
> > > out which of them would eventually reach the commit that we are about to
> > > rewrite.
> >
> > Yes, and it's only a few lines of code, as I showed earlier.
> >
> > > And that of course doesn't scale.
> >
> > That's quite an assumption about scaling; I don't believe it.  Under
> > what conditions would this be slow enough for users to notice and be
> > bothered?  commit-graphs not enabled + weird local clone with
> > thousands of local branches?  Also, isn't jj specifically designed for
> > large repositories and with scaling in mind, and yet this is their
> > default behavior?
> >
> > More importantly, this is being used to justify a large principle of
> > least astonishment violation (disconnecting branches with shared
> > history), so we'd not only need to show that walking all branches was
> > slower enough for users to notice, but slower enough that the negative
> > user performance experience offsets the negative user experience from
> > the astonishing behavior.  Typically, spending extra cycles to provide
> > users with good warnings/errors is a good use of time, especially when
> > it'll take them far longer to discover and recover from negative
> > surprises.
> 
> A quick clarification in case I'm misunderstood above:
> 
> When I talk about rewriting branches descended from the commit, I am
> specifically talking about refs/heads/*, not refs/remotes/origin/* or
> refs/tags/* or anything else.  Because:
>   * I suspect we'll soon implement an "immutable branches" concept, so
> that e.g. a request to modify a commit in the history of "main" would
> result in an error (by default).  This leads to the idea that we're
> just rewriting the user's local stuff they have on top of the
> immutable history, i.e. their local branches.
>   * refs/tags/* are designed to be immutable, obviously.  In fact, we
> might want to automatically include tags in the set of "immutable
> branches" by default.
>   * refs/remotes/* are designed to match what the corresponding remote
> had, not to be independently rewritten.  We'd really mess people up if
> we changed that.
>   * The fact that users created local branches means they are marking
> those parts of history as a relevant area of interest
>   * While it could be that some of refs/remotes/origin/* have shared
> history with whatever commit is being reworded/split/edited, so too
> could branches that were never pushed.  I think focusing on the
> branches of interest to the user (i.e. their local branches) makes
> sense.

Fair. I'll send a new revision tomorrow that does this. Thanks!

Patrick
