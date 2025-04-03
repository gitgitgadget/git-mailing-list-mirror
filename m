Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0EA24BC14
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743678382; cv=none; b=WG6OTpcnK2xNfy2W48LM3MRufq6BhmvPKsSTA02Kr2yThugWHwiaQ56lGMR5g9xew0FNgLNNwqcvxIuLZXs5nknbEpDjTArJxHEyrvrX5AQ+NQ754HpYo9ma4GxTkGe0yMor2SzCq17ys18zVQ9Tc8eBeOKNt4relSNt+w6AiYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743678382; c=relaxed/simple;
	bh=IwlxeT7dvr4VIOrYaM08XhCxYq7VjnE4H/mO9iVNyX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvYJ9ap1g/HXXLwXDJ/2TMTWOOLGN9Xa7rsnzf7yYiTmLkKlf1wjlVwYILDUUh+/IY0nE/2if593eL+MqSJx3T1Fq7GGb2jQpkevdEPq0Es6IW/749lUMEdMFlgcios02ouc7GqxaFxOZBkxP0Vvv5ieKIE5Zv3jlFqTMNmlmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K+35iCF0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jrf/G4q1; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K+35iCF0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jrf/G4q1"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D0CA25401E0;
	Thu,  3 Apr 2025 07:06:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 03 Apr 2025 07:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743678377; x=1743764777; bh=6OBldW7ydT
	Ab3nbU/oNJTNg+66nZINCHIac8PHKETUM=; b=K+35iCF0opWh+8W6gL1BMBWwAn
	9ckik+yDTpju1wfaXpgoxwLTP156vSYLzZKM+kn7uKnSboEp0j+hP0+2IoJDuK4E
	qcdtm4hLpQsFAnBI5XsOkeO4yAkNpa/OtRPAmiNjW2JB+jwFbWdgGl/HM28C+0TG
	DqjD4Fbv0ZSgjnXxX51Hz0TdwMgrau93vkQSEQ5jX1NIjuNJpTv60J7XQLJXzrgH
	m7RyIA8f2USGQhT1JE6GYALY3ZIPFPyeugOyC6pKAFrLXWfXn83vF2niRTMEmnQK
	5rHi/InhSdsWEV64ASJJTb6crjxOd6t+KcmamgiD3VYn1WGBeT3uClU3/oag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743678377; x=1743764777; bh=6OBldW7ydTAb3nbU/oNJTNg+66nZINCHIac
	8PHKETUM=; b=jrf/G4q1ShvR5LrEL2DvgzxeC7WFdufRAdCdGNldm9+NTSGw6AK
	iA1MDhcKr7ZoXLtBQrfnsl4dBT2yjLv1Yl5OoGgK+n3/PJgWlPxldyItW9jfnVZN
	A7eCPr87B6lFVw6LOiUCYhWXENXfqB7StMFxynBA/iEyF4VZu5eAAKse41bwvjC3
	+hpbx9LbE3+O/HVcyDfXaBxO7r+CwtyHKg8CdGXEu7x2OQD+WI2ilgw0WvDL3Ymu
	8t7iJaLIACREA9EbaN8bFcwGVoFlepAnQ3pduFs9x0rjYgYxhQIDLclgoCdWWIMI
	hQ5a8yVm/UOAFKB7+QPnCURpKAQJJrniMJA==
X-ME-Sender: <xms:qWvuZwe7aODmy0PN6UvzYgqP9zB_IbfnQvgcThU4Y6mbzVAuhmFrrA>
    <xme:qWvuZyMICmmqcZIEb1DI7Mshf9bq-D4FaT3yNFYzfSifXLWPNQ-T3kNbg4Tnbs8fg
    mb2xqI7rj6kI8mY4A>
X-ME-Received: <xmr:qWvuZxhBOY5NaNIV3XMxZoqKIl0dHqpbJ-kM9TdrCBxK9hDPRYKRR2PUh5G-n_iHIa4gJHwmO0Uc2KD9yrium-lRL_oXtK64W8ewl4JuI6576es>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprhgvmhhosegsuhgvnhiilhhirdguvghvpdhrtghpthhtoheptghhrhhishhtihgrnh
    drtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgtohhtthesghhithgs
    uhhtlhgvrhdrtghomhdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehphhhilhhiphhmvghtiihgvghrsegslhhuvgifihhnrdgthh
X-ME-Proxy: <xmx:qWvuZ1-z3xWD__wyDOn_osqFntb68mga1z5JExZR4-xg8NwHiwxpvQ>
    <xmx:qWvuZ8t9PkXjTe8Iv7LjIjAr3e_WjTNTsn4SIYQ3XlBWPlJFuFzijQ>
    <xmx:qWvuZ8GNqiKI4zthQOT-MjUYQTes9ADViAHW737FtOxdXR2wkHfddw>
    <xmx:qWvuZ7NSg3yURBiMuq8xvYDhFsxNvnlGQBCxqfaPHvEwnjsebqoWWQ>
    <xmx:qWvuZw73ls-3yjlSp3ssDbxpymDw0itXuUkojToaYsJKw6VWyzmBV_3f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 07:06:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c938ee97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 11:06:14 +0000 (UTC)
Date: Thu, 3 Apr 2025 13:06:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z-5rpWKAVPmz32jC@pks.im>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <Z-5QR57zgSsm6jNP@pks.im>
 <D8WXTCOESY86.3RRJOR5GPUL47@buenzli.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8WXTCOESY86.3RRJOR5GPUL47@buenzli.dev>

On Thu, Apr 03, 2025 at 12:38:52PM +0200, Remo Senekowitsch wrote:
> On Thu Apr 3, 2025 at 11:09 AM CEST, Patrick Steinhardt wrote:
> > On Wed, Apr 02, 2025 at 11:48:01AM -0700, Martin von Zweigbergk wrote:
> > The biggest question is of course backwards compatibility -- can we
> > introduce a change ID into the commit metadata without breaking existing
> > users? I guess you'll already have a lot of experience with this given
> > that you essentially already inject change IDs into metadata, and tools
> > generally handle this just fine?
> 
> Jujutsu has been injecting a 'jj:trees' header into commits to track
> more metadata around merge conflicts. There weren't any problems with
> that, unless one uses git to rewrite these commits with e.g. git-rebase,
> in which case that header is simply lost. But commits with conflicts are
> usually not pushed to a remote anyway, so the risk there was minimal.
> Scott Chacon with GitButler has more experience in this regard, since
> they actually push commits with a change-id in its header to remotes.
> He told the Jujutsu community that they didn't encounter any problems,
> no misbehaving tools that are fussy about unknown headers. The only
> problem is unknown commit headers being dropped by Git itself, depending
> on how it is invoked by the remote. (GitHub seems to preserve the header
> during a rebase-merge, because they use git-replay. GitLab and Forgejo
> drop the header.) With these insights from Scott, Jujutsu is moving
> forward to put the change-id in the commit header.

Yeah, Scott made me aware of the limitations in GitLab already. We
wanted to migrate to git-replay(1) for a long time already, but never
got around to actually doing this. Coincidentally I have recently been
talking with Chris, who proposed to finally go through with this change.
I guess this here is another factor that will make us schedule this
change sooner rather than later.

So: we'll soon start working on it, but I won't promise any timeline.

Patrick
