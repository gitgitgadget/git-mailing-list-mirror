Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F721F461A
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057098; cv=none; b=KT9mDcIECquXM3U7fX/Bt5F4oVUYwlQD3ZYMMDL4REwktIk7lXQP+jC+ixJ1+IlhwR9Huuhk1wK5n9zXJdz8rrbE5gaelChOqH5MlVfyBI15MD1adgpptMZLAWqFigEOz7UOw7pcTsCckjVemDCu30YNFknLEsXxSIGwGCSGnzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057098; c=relaxed/simple;
	bh=udCRVZMeepi6W/1k+UDJIkgA0nGsnnxJ9RhbNLIiN7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW3eze6Bk3DD5zRmL4SbeC2tE//C1Dm1/vHq7ceLpULlhFC4RS+rj+fwsTYc+ZfkbapNDRY005BCV8bqpb/rNSGACMg4MaoBzwb9qtupKblC4fysDwtsrUt78ip0CPa9lzOnN9o8hXkP3rzvzpYL7H78+YEZKFqiFdO0fKGOPqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lBEx+e20; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wwk9emD4; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lBEx+e20";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wwk9emD4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A4CC31D0009F;
	Sun, 24 Aug 2025 13:38:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 24 Aug 2025 13:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756057095; x=1756143495; bh=66XyfbsH0m
	pltFvbOacrqQFdH9cSj6mAD0s/neJDJVk=; b=lBEx+e20dw2EEwFHa94DvuV2xb
	8ecuO5lBoH4fXZDayh7xkfzLyvRr90oqdokT8YOv9i1rle2sUOTeZ+BDj79kug/F
	qyYtdGx596njASHgFSq9jwCgjg1jv9S1Yx77F9cfW0+QPecI/ChMlZ8pKhKeVQMy
	SFLMTjSNH75xjv6eeET1dm+Tj3FW70UYyd69zmskuVs1xn4sMYk9HgiYw+fFlYAk
	VED5cLGu8ook4bBokG/PrD4jKfz/q7AK77nUPA9nQiZ6VEJP9yiQfxmqRxDFAXtl
	tDquAckXXNPNLIE2SSiw5/o/7pzLy4z073Xji5YkZM3mYkh8bTeMx2khD92A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756057095; x=1756143495; bh=66XyfbsH0mpltFvbOacrqQFdH9cSj6mAD0s
	/neJDJVk=; b=Wwk9emD4/rFOOEziiko8DXD0I4Q4rcqLfZmXvWFYgB+W3on0OXa
	XRj1wCIXKCC+Oj7Ne3Zyo6/VEj1+bIDedOwpBUoGVU6VJQBmfY5acNcA9MrBm9q+
	tXjFh/yqkt+Gfc6I6HLuPMhKAfN/22NdGNMlzS3qFor7kGcwdpUtWAjtp+hYLqM6
	794CCM2ygZy/XmGbcgrrBtv0DnD43VnjC8ruEzVUQXu1Ls3PuhABq5V4Z45ohbRW
	+kgSKhPhyAMtMJ9XJoyiEcEDeRZ//E+hxxjQqcn98jaOpE5+kqwMj4pgGRGvKrk2
	DsFLkyWs+q3u0xH/KN5kMBV4IcHGiwms39w==
X-ME-Sender: <xms:B06raNmXmN-KrkL6tTTezMQi9Rx4GhHOB-SFVTeWoL55brInjYwhpw>
    <xme:B06raJCTuqqSe-9ZjwwxnQ-bdPoPzhYpL7SfVKkcn2ueDdHZd0sm9C8lwB_1Em859
    zjBbRDr79aN7NCg8g>
X-ME-Received: <xmr:B06raFd9nmIQkopMcetahLQjUZWa8iAR-s83lrANpNqGDhWB1REBjvgHr0HkgDl94Xh0hB4XnMtTD7Fqtouw3uRoVHvhzDqH8mkiVwKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:B06raMIFEkrTnBS1DFuRXa1NlzcphHVYN4W2ixSHREALaui84V-WoQ>
    <xmx:B06raAerSOOuq2nc_dXkLklXlPOFlayMTEgahuxf4wXRzCLmVrwWMg>
    <xmx:B06raL3OoadH035qR4ygRrqpADMI8MtfoG6LgCten_UHxIz-S1OBGg>
    <xmx:B06raBjMsO0ynlOuFpTMYcV2fRvI1lqF2aCLRNX6jjePsqUezMIbUw>
    <xmx:B06raAJ0V3OSEL2PgxROrNrz9pZVZWoCRY6JlZRaJfk7RJvFEmaKLfA9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:38:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1580c43c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:38:13 +0000 (UTC)
Date: Sun, 24 Aug 2025 19:38:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
Message-ID: <aKtOAFKpxCK0RZJH@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <cfb5eab0-ae72-477c-91a7-e9198ef7464d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfb5eab0-ae72-477c-91a7-e9198ef7464d@app.fastmail.com>

On Sun, Aug 24, 2025 at 07:31:45PM +0200, Kristoffer Haugsbakk wrote:
> On Tue, Aug 19, 2025, at 12:55, Patrick Steinhardt wrote:
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
> >
> >   - jj-absorb(1) to take some changes and automatically apply them to
> >     commits in your history that last modified the respective hunks.
> >
> >   - jj-split(1) to split a commit into two.
> >
> >   - jj-new(1) to insert a new commit after or before a specific other
> >     commit.
> >
> > Not all of these commands can be ported directly into Git. jj-new(1) for
> > example doesn't really make a ton of sense for us, I'd claim. But some
> > of these commands _do_ make sense.
> >
> > I thus had a look at implementing some of these commands in Git itself,
> > where the result is this patch series. Specifically, the following
> > commands are introduced by this patch series:
> >
> >   - `git history drop` to drop a specific commit. This is basically the
> >     same as jj-abandon(1).
> >
> >   - `git history reorder` to reorder a specific commit before or after
> >     another commit. This is inspired by jj-new(1).
> >
> >   - `git history split` takes a commit and splits it into two. This is
> >     basically the same as jj-split(1).
> 
> I think it would be nice if git-history(1) called the `post-rewrite` hook.
> In particular for Split; then all the possible rewrite modes are covered
> (one-to-one, many-to-one (squash), and one-to-many).

That's a sensible thing indeed. I'll add this to my todo list for v3.

Patrick
