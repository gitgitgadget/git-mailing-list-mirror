Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BEB1A5BB6
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743758965; cv=none; b=i1/eFtFFN/YQGY0vcsRDucZdHMnx1+8K3tuTtXV1BetIg1tIkgqyMxx/oRK9YWH9DT7yKtJHZQhoq4W7lSXA2LoBARQk/FeMhR7Q38h62Bq8DN6I//GgS8dw3EoVD9piGvr6VvAYYTRU0PD2iOEZQAuBd3RgQ120AkvQqfqodRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743758965; c=relaxed/simple;
	bh=Z51VIeUaRWPphFkbGuYV7eveHA1beV10rmLoyjmzFWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYFBAFjJx5J7q1/UE0bfi+ho50dxANqJEJgrlwKPVc8gQCtam4/DlNLdtyUWSwsQkBvsuEF9S/ZlrzfSVbC8wbr80vbQFD8VX3kNcL2FJHRQ8d56P+BauhZlkWAA1bqPatcWOgzLHwC+SCuNIat4+thySaB7sLNInbo4HzQ9JUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lWGmXabg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PN7tCw8+; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lWGmXabg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PN7tCw8+"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A0DDD2540113;
	Fri,  4 Apr 2025 05:29:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 04 Apr 2025 05:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743758962;
	 x=1743845362; bh=mTj0ls7B8xvbcXmdfFMzCw3XA6t98qHR6MQuPceuheU=; b=
	lWGmXabgSIJtFdLZOHabwPCqFDotbWHLyTz2goR0AO5dqD56uJAsCZorKQLuCHWb
	3xk776a9zso4BmdfOt6UvwVTg1JzhNbc6xGQst8qZkvTGzjfxeqfPeuFWbKM70w5
	eFryyZ97beht+w/YVKJYnoEPjEtYjDzPtKJpdFTnk4+jlgp0c9e7Lz1zuQGIifHB
	caXExWA1nJLyCdAcksk58gLph/W6+0fVJ2RTqAPFe60EITM+qM0Ntaft+2owh9Ic
	pm751UDe+aUKgqc+PvipHHJgh32a43wLs388eidu9aDqSM9BmzUKLadFZAFlR9ML
	yhY33EP79NRwb9YCHLZyIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743758962; x=
	1743845362; bh=mTj0ls7B8xvbcXmdfFMzCw3XA6t98qHR6MQuPceuheU=; b=P
	N7tCw8+J98MJUi0NwfIlfpSdeqEI/vx8I0nOr5ZNLKT8beUHIetEigxS2Vs4KP7m
	rkM4QUFLmy4WHcHnifMUeZIJhso4NNQOYprB34wA7QF+TBb6L7fa/MlGJXn1aS7d
	eoWZy8wEcmbXRCLSTtWv3TUloSh5Qsh9sssSglkPrDe80QhExPtwmSQa18fvm6Da
	E3rpliC+JBfayRwrPqE9kvnu4LYux3ayyQ7XsZuCqlVZbkw6VVSGOsBacucPKzN2
	Zzfj2AGghIahRrTqWDCmHq/NbRJ2OzYiKxwsjovHflfNwqxaXi2vtRgdgRiMkZrv
	pxvE8nx/1IH6jeCYLZrlg==
X-ME-Sender: <xms:cqbvZ1Jdd1Zm8RLiRXnHYw0FwXuqLPpreO80zuXbTjYEcr8PovDH-A>
    <xme:cqbvZxKEOHo7YZEFSr0KrTA7bK5fFhaxtPlI-mV1rPQOLddT_dzwAC9Ehu3dcSL5g
    nLaGKiycKA3Txldww>
X-ME-Received: <xmr:cqbvZ9u_sCTXaLyQ8ByrWRy8PyeXQQTXAUXH-K5-mGqBy2lmJHUZ19M2Uk1JTxjCxfmNvEncvuO-zoP63ALt8zw1PwNwuOEYspQIzzxrmWxSyA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledutdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehstghothhtsehgihhtsghuthhlvghrrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehphhhilhhiphhmvghtiihgvghrsegslhhuvgifihhnrdgthhdprhgtphhtthhopehrvg
    hmohessghuvghniihlihdruggvvhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehmrghrthhinhhvohhniiesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:cqbvZ2beZ3iCt6Hbe4pzTR_pxImuosGTi1n0rkHEdnu-h4gKkzQkQA>
    <xmx:cqbvZ8YZVUw0z7kqlZvygbhCFH1FLuxleym2H-uoIGfAPzvDExpW7w>
    <xmx:cqbvZ6B50uwVcc3GGK6zqolV0n1fbocGfb3trJvVIBogxpWJ3CLZzA>
    <xmx:cqbvZ6YaAUG1NfqrmmpIDIgDsSszlJEYEH-NvQ-c-F775TBZVqkXFA>
    <xmx:cqbvZ20s9LUFRpZDRetdu46LusWsiyxFa5FjFivwaXEIhYaUOImqr4Zz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 05:29:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7d0b4745 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Apr 2025 09:29:19 +0000 (UTC)
Date: Fri, 4 Apr 2025 11:29:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Elijah Newren <newren@gmail.com>, Remo Senekowitsch <remo@buenzli.dev>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z--mbrqpUGOcGMVi@pks.im>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <D8X5I3W7K1DI.2JYHGNY9L7ZD3@buenzli.dev>
 <CABPp-BECTrVp9X6bVmzU8LEeYsC3KbzeJvAaDPN+FgZz_uEhmA@mail.gmail.com>
 <CABPp-BFYoZ1cuUMJPhWhtgntS0D-E=ZF+8_KS7gC+ShXjTrEDg@mail.gmail.com>
 <CAESOdVB4yrDQ1v1BZtPiHDJwbaRVN6tixWg9eWNmBitXyqAh6w@mail.gmail.com>
 <CABPp-BHWFaUHAXwuddNpD1w=Fe7BK=9-Bc=-b9yXbqqWsQ8_pw@mail.gmail.com>
 <CAESOdVArh6Vksd9bktBz4DBqOzvoydfh6_DZcm2t9kJ5F-s1EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAESOdVArh6Vksd9bktBz4DBqOzvoydfh6_DZcm2t9kJ5F-s1EQ@mail.gmail.com>

On Thu, Apr 03, 2025 at 10:21:57PM -0700, Martin von Zweigbergk wrote:
> On Thu, 3 Apr 2025 at 22:00, Elijah Newren <newren@gmail.com> wrote:
> >
> > On Thu, Apr 3, 2025 at 8:47 PM Martin von Zweigbergk
> > <martinvonz@google.com> wrote:
> > >
> > > On Thu, 3 Apr 2025 at 19:40, Elijah Newren <newren@gmail.com> wrote:
> > > >
> > > > One possible simple solution here is just to treat change-ids (or
> > > > there abbreviations) kind of like abbreviated hashes -- they aren't
> > > > guaranteed to be unique.  If the user specifies a change-id and there
> > > > are multiple branches with such a change-id, we provide the user an
> > > > error much like we do for abbreviated hashes.
> > > >
> > > > Is that what folks have in mind?  If so, I'll be happy to drop my
> > > > reservations about this aspect.
> > >
> > > Yes, that's close to what we have in mind. I think I just didn't
> > > explain clearly that it's mostly harmless in at least Jujutsu if there
> > > are multiple commits with the same change id. If there are multiple
> > > visible commits with the same change id, then you'll just have to
> > > decide what should happen when the user tries to refer to commits by
> > > change id. We currently let it resolve to all the visible commits with
> > > the given change id.
> >
> > resolve to all visible commits?  So the Jujutsu equivalent of 'git
> > switch <change-id>' would simultaneously check out N different
> > branches?  Or do commands which cannot accept multiple commits just
> > throw an error in such a case?
> 
> Yes, the latter.

That sounds like sensible behaviour to me. We already know to print
ambiguous hashes, so we could probably do the same with change IDs:

    $ git rev-parse 1234
    error: short object ID 1234 is ambiguous
    hint: The candidates are:
    hint:   1234d8d9179 commit 2018-06-08 - Merge 'add-p-many-files'
    hint:   1234e8297f3 commit 2020-10-26 - Merge branch 'en/sequencer-rollback-lock-cleanup' into next
    hint:   123456ff3f0 tree
    hint:   12349764e65 tree
    hint:   1234b76f424 tree
    hint:   1234c687269 tree
    hint:   1234ebb5d8f blob
    fatal: ambiguous argument '1234': unknown revision or path not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'
    1234

It should be rather easy to adapt this mechanism to also handle the case
where the same change IDs (or abbreviated change IDs) exist across
multiple commits.

Patrick
