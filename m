Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDE472613
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756056900; cv=none; b=nU2qzRdWZUy/Yvlkc/yl8CUoU2THg6RQcm9YRzm+EOKCHMYmhDqGBmblJxj4dybLm3Rpa7Wz6BuFNsl3NtONkbIiANW8Ajr1v6+E8m9Hkg/k1unssnjH3nbj/n9J0nvAJVJe6GMs7dB0mEqD5JQlBEMlYjjTy54RTJVJr5UWkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756056900; c=relaxed/simple;
	bh=SeeUe6PgqO/mixHYyNqy8CRD4wkJLEKlycA7WWJfytA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQNylkL6c2SzXjOfEqqwBp7FXO3M5ZE0FYaq0xZfxIZISxZA+JUpYvoaN4dDt3E+yD/Stz4YH6F2MUTGUXAf49URt09bVHkT/YdVBO31OvM2j4v69OYHqNEHKZOkmcXd/9tQ2MPSZonk4sJQjIemmI5zKDxXLmnLYUhLgIfiTvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ACHG7sJa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bjcgFixQ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ACHG7sJa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bjcgFixQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5DAEC1D00101;
	Sun, 24 Aug 2025 13:34:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 24 Aug 2025 13:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756056898;
	 x=1756143298; bh=/ZeBr81GqlkItXDPeqxV0h2PiGjiDUkkDNHtGggM/Oc=; b=
	ACHG7sJaLz1qnj/JwrNfidiQyTJnYln9+TnP0FvAGBRxcmgqUVU9WHPr36watU3+
	GlrMtZqqKTZbu1AkQFpZwIXX3VGsyQfhlrP50rTO8gxM20y59GrR+IxMpNeIehov
	yTLxhKq2YcyAzBBVUnNosPYEDsdcLqPEYDZBlQI7iDFvRq6xNvkkH+CCyFBjQn4/
	tkM66g4odRB2dhLbXvW3728MZGp3jlY6ngEKKIo82PSFoiB1kYLUjAt0KSHQlBBr
	q9rlzKTdv4IzHTYh2NtjN4lJgpjXk/29bTyc4WlULXlgJx0hFPbSYXquLvq2LA7j
	iHLOmPGeBZQDck98fPJFlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756056898; x=
	1756143298; bh=/ZeBr81GqlkItXDPeqxV0h2PiGjiDUkkDNHtGggM/Oc=; b=b
	jcgFixQMfqDutKkv056eojsrKOaOKACMANSIJbv7BF67mNjwl9aXbdWe7jrGGtFy
	6l6Rm4BLiSkvgexlwM6NWA+dY3WEQwIVT5hEkIjB0AekSttkMPzUDUuJOoH18ylx
	kyaaqnFUYzjOmyTzszAVIKOzqRgUYoPkCOgmgFBh5GkLcz3jEj6TfukQImaUM9nN
	3G89oghuspPLmIe+7/+Wkot3pFFKRq0Zeu6yj81Vs+HVLvFr1gnEPz0Y5xXbm3Vx
	/SXMf8j0ZKaxihds5FPWBBTfuY9rrntpbPEIZiQzZV+VzlwBbRdqpNnWo2pu+FAl
	HuAzMbakfcNoNzqFK4cAQ==
X-ME-Sender: <xms:Qk2raEDA9xa-3o9TVirJAq-sGUGKvr4aO6xl4yi0GZ5kPKSKBx_DIw>
    <xme:Qk2raGtRf012Yyfk2FWQW95_p-m3_4SJMuYxTJJNs5QeFHD4yhTqYAl_gbz6gLl5F
    Vvop7-iG2XvJinElg>
X-ME-Received: <xmr:Qk2raJYV2mLmsK3znG0Sr2Toy7m96vAixtg1oU3q1jCz_C7ZqDaWueYY6XVGmKCaZF619RTQpul8sVgJxQ3wUGh9oDqSQVHScw2bLxEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Qk2raJVyTuqdUd0ZeT1wL4SaMuD3-FetrxWqsX52_m8fgsm7tAZCcw>
    <xmx:Qk2raN6STLOwLfZmPAHiTUdApLg9txtEWutA0vWiqInQ_8mLG5jH-Q>
    <xmx:Qk2raEivyueZUNHo4DwfMEYzw3u97EIB7SlednBwpn4ap-XBWFDnaA>
    <xmx:Qk2raEdJ-YILVvKB6n8sI0s2ZEAF_arb6Mv88xN7tjAIy0NVa9984w>
    <xmx:Qk2raOnbzXZQEouGFV_cgionbJ8wAt3zI1aeDyBYhFul8VXNRV3JyiS4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:34:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e23070e6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:34:56 +0000 (UTC)
Date: Sun, 24 Aug 2025 19:34:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 06/11] builtin/history: implement "reorder" subcommand
Message-ID: <aKtNO3z3xfiu-5aF@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250819-b4-pks-history-builtin-v1-6-9b77c32688fe@pks.im>
 <f9f4a4d7-3111-4671-8b5f-43c96702f83e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9f4a4d7-3111-4671-8b5f-43c96702f83e@app.fastmail.com>

On Sun, Aug 24, 2025 at 07:25:48PM +0200, Kristoffer Haugsbakk wrote:
> On Tue, Aug 19, 2025, at 12:56, Patrick Steinhardt wrote:
> > When working in projects where having nice commits matters it's quite
> > common that developers end up reordering commits a lot. Tihs is
> 
> s/Tihs/This/
> 
> > typically done via interactive rebases, where they can then rearrange
> > commits in the instruction sheet.
> >
> > Still, this operation is a frequent-enough operation to provide a more
> > direct of doing this imperatively. As such, introduce a new "reorder"
> 
> s/direct of/direct way of/
> 
> What’s a use-case for doing this imperatively?  With a nice rebase
> frontend you get to shuffle around some lines in your preferred editor.
> This seems like using Ex mode in Vim.  Which is legitimate but I don’t
> quite see when you would do it.
> 
> The thing with e.g. the Drop subcommand is that I might have some
> commits marked `TEMP` that I wanna quickly drop at some point.  That’s
> sort of a semi-interactive use case; I might want to lightly script it,
> but I am always going to invoke it interactively.  Doing that light
> scripting on top of git-rebase(1) sounds like a hassle though.
> 
> But in this case I don’t understand when this would save you time over a
> nice Rebase frontend.  Because I don’t see when you want
> semi-interactive history reordering.

All I can say is that I ended up using this feature quite regularly with
Jujutsu. It sometimes just feels a less heavy-weight to tell Git what to
do directly instead of doing so via the editor.

Most often this happens when I just created a new smallish commit
because I noticed something and quickly want to reorder it somewhere
earlier.

> > subcommand where users can reorder a commit A to come after or before
> > another commit B:
> >
> >     $ git log --oneline
> >     a978f73 fifth
> >     57594ee fourth
> >     04eb1c4 third
> >     d535e30 second
> >     bf7438d first
> >
> >     $ git history reorder :/fourth --before=:/second
> >     $ git log --oneline
> 
> The `:/` notation makes sense here.  You’ve probably just made these
> commits so you want to match the newest ones.
> 
> Is this example meant to demonstrate how it works or to also demonstrate
> how you would use it (i.e. with revision syntax)?

Both, I guess. I often use this revision syntax myself, but in a lot of
other cases, especially when you just want to rebase HEAD, it may be
easier to just say "HEAD".

> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > index 3012445ddc..6e8b4e1326 100644
> > --- a/Documentation/git-history.adoc
> > +++ b/Documentation/git-history.adoc
> > @@ -40,6 +41,12 @@ Dropping the root commit converts the child of that
> > commit into the new
> >  root commit. It is invalid to drop a root commit that does not have any
> >  child commits, as that would lead to an empty branch.
> >
> > +reorder <revision> (--before=<revision>|--after=<revision>)::
> > +	Reorder the commit so that it becomes either the parent
> > +	(`--before=`) or child (`--after=`) of the other specified
> > +	commit. The commits must be related to one another and must be
> > +	reachable from the current `HEAD` commit.
> 
> s/current `HEAD` commit/current commit/ ?

Let's maybe say "currently checked-out commit".

Patrick
