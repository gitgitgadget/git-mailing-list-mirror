Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016202C0F7E
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933601; cv=none; b=Ci9pRmzVHrlabA1RUkFfB/3gTAQjiCJPgUA2S0gESx8o5EUk6hHhU6WZmqnw6bCck6Rw8wsdyTVySH6ZJ+ryD3kYUgwRjTZ19M+nU3r/zk3v3/oW+kPpBYNZRX8f4DrgZLelNJikiCLvK8No5llUCv/QQ10f9BC73F0I7eUAJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933601; c=relaxed/simple;
	bh=sVG8y8M2sFs3r5hruq8KTTzI9KFT3XkannXwMqhjJUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH8rqZ8vNvxqnaxFIrgOpGEZaE4UZAP8TmudwU7KzZzmStFAKqOeB8k+6HdhEe6MkdK3MknS1l2QDcISO4AEPuwT11aBZYl6Jk5L1p6vAqsjiA15pAI0LTDr63jWMRob2wOx/pY71u/w+ESE0t77cMXIcoBBQTMOUbmq+ppE0rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R65UvVm1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSmgfZsI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R65UvVm1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSmgfZsI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F8AC1400042;
	Mon, 15 Sep 2025 06:53:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 15 Sep 2025 06:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757933599; x=1758019999; bh=4C5DUc4D0k
	ggxH9an1BImDf9l8lgwVTcn60ewL3S6qg=; b=R65UvVm1ZsALFjXKQkpFWFOasV
	qBKY7xQXroylMJIRw1xjR9y4bDG1vcz06YCrdrfkPcNpr+oxbcvy+ZRJUSyVTgPH
	oMmhwCPYNbS8hISpOFCpLJJNqT88GF6J1NzHABWK8P7nXJR8BY2lEr9m9xO1OZy7
	lpXuVcwhESVc/6PqJYDyGQaiih3ZrqWcOxWDRkTqtCCnxAoi4VJzrE5PRK3GHv8J
	2a4ZgOkUK1cJqWsuvgkH3kC84hAHlg0uy4HnCks6oDa/8kzR7rA98S/Hd9AcU9Jk
	XZdZ1Hbx+yP5VSsB5q789H+vVzchPAjUxTgfcWF2fIjSRsZ1QrIcfbKmGyQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757933599; x=1758019999; bh=4C5DUc4D0kggxH9an1BImDf9l8lgwVTcn60
	ewL3S6qg=; b=SSmgfZsIRwqZD3CiQsTDimSveaiQYfXN0df4xo2Ky8znO8c8Ca5
	H5U9afBweiYdcZXobQZ4JNt9B86WGW8XItKqE9vdCXpESyJ8P+IKE72Dek7LMji+
	tUOAa2LgU6LdZ/vuicHqWeRZlJSYHQwKaZZNZl3sg82CwX78/FHdWsWbJtFN77+/
	cLRqzcgKta9FQv8laIobdxEYTtO2/cT5DTPqQRU7WtvtYmJW4QBkWujUCjbHpIeP
	2cCZHH1xSFqGco2aKfIrz1aaDLrr4ELIaVpuIPCfklEk283LPfgyafpRCbe9XbV/
	5BdiV/xdjyXdzxujeBZj09vV2z0inAGDpdg==
X-ME-Sender: <xms:HvDHaPu5ltrgd9o9-uHMQP0dDIgJONXvlKMCNZIwiz53p0dW9OXTTg>
    <xme:HvDHaAlDZN3B7E9k_pX4xTXytGnPouT_oxT8w4HLpP_5SzSg7mV64xBMt-nCH2Rj9
    dQBcBwtzlwvaBxqXg>
X-ME-Received: <xmr:HvDHaKO1a3kBxn8AiBzvNl5TvfA-wxMm4p4U0la74rgQmR1ODpa9YFAjCIg9YHutKKoGXWpW50PElYlh011-CyH3dKyVOpevyMOY35EKjW5B-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghonhhtrggttheshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoh
    epnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghr
    uhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheptgholhhlihhnrdhfuh
    hnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrghnuhgvlh
    drphgrthhrhiesvghmsggvtghoshhmrdgtohhm
X-ME-Proxy: <xmx:HvDHaExoF_Hl6wOeX_tb3fRJ1cLvrwXV3VGglG5FrbSBmP2Dlh-p9g>
    <xmx:H_DHaHvUIthedMQXLFRkOtDlx5V4rnEGr-yUJ3xMD6gfNf1pf6sGww>
    <xmx:H_DHaHb_SXHqTEH9CCLTezDc96gHtRzpp7nAO36qqAsHrFUPs495Rg>
    <xmx:H_DHaG08eMBE-1KL0wmotJI94UfdKzg-qPdO0xPuaVnEiPZ9ht4hkw>
    <xmx:H_DHaKQTWyQE5Z7ep5BC3DbJkvlugy1DVWUyj4jxGeeAS4A3Rcgm-5I3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 06:53:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84d58ef3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 10:53:16 +0000 (UTC)
Date: Mon, 15 Sep 2025 12:53:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 7/9] BreakingChanges: announce Rust becoming
 mandatory
Message-ID: <aMfwGHL7dh8dk2cQ@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
 <20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im>
 <xmqqldmmqa1z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldmmqa1z.fsf@gitster.g>

On Wed, Sep 10, 2025 at 02:20:24PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +* Git will require Rust as a mandatory part of the build process. While Git
> > +  already started to adopt Rust in Git 2.52, all parts written in Rust are
> > +  optional for the time being. This includes:
> > ++
> > +  ** Subsystems that have an alternative implementation in Rust to test
> > +     interoperability between our C and Rust codebase.
> > +  ** Newly written features that are not mission critical for a fully functional
> > +     Git client.
> 
> This is a bit funny way to phrase the intent, even though I do fully
> support the intent expressed here.
> 
> When this topic becomes part of the code base, we are likely to have
> varint in the first category, but if we have nothing that falls in
> the second category, that would feel somewhat odd.

The intent here is to open the door for those. So yes, right now we
don't have anything in the second category yet. But the intent here is
to explicitly say that people are free to do it even if there is no such
user in our tree yet. And with the SHA256 interop code we already have
this feature in the working anyway :)

> > +These changes are meant as test balloons to allow distributors of Git to prepare
> > +for Rust becoming a mandatory part of the build process. There will be multiple
> 
> Are they still "test balloons"?  I thought that we established that
> the point of these breaking changes is quite different from what we
> have called "test balloons" for.  It is not like allowing them
> anything (like interfering to delay or stop, which would not likely
> to happen at this point if this patch gets part of the code base),
> but is used as a bit more forceful way for us to tell them and make
> sure they are aware of the upcoming change.

I'm mostly just lacking a better term here and haven't seen a different
term proposed anywhere. I think it's close enough to a test balloon to
call it that, but if anybody has a better way to name this thing I'm
happy to adapt.

> > +The Git project will declare the last version before Git 3.0 to be a long-term
> > +support release. This long-term release will receive important bug fixes for at
> > +least four release cycles and security fixes for six release cycles. The Git
> > +project will hand over maintainership of the long-term release to distributors
> > +in case they need to extend the life of that long-term release even further. In
> > +that case, the backporting process will be handled by these distributors, but
> > +the backported patches will be reviewed on the mailing list and pulled in by the
> > +Git maintainer.
> 
> I am having a hard time imagining the practicality of this "hand
> over but we still review" arrangement.  Some of the security fixes
> are embargoed, and the reason why we are jetissoning the stale
> codebase is presumably because nobody is willing to work on it other
> than the "community support" folks.  I can imagine that we would
> qualify them into the git-security cabal and let them use the forum
> to coordinate among themselves, but then to what degree in the
> "community support themselves" process is our involvement expected?
> As long as we can make sure that they do not leak before the
> official embargoed release, they do not need an official stamp of
> approval from the project or by the Git maintainer---that is what it
> means to "hand over maintainer ship", at least to me.
> 
> In other words, I like what I see in this paragraph, but I do not
> think we can practically live with the part of the sentence after
> the last ", but".

I think the most important part here is that this community-supported
LTS release should still live in the canonical repositories. We should
avoid the situation where we hand over maintainership to such a degree
that the end result (the tagged LTS release) lives somewhere else.
Otherwise we risk chaos and a plethora of different LTS releases, which
would be harmful both for us and those that rely on the LTS releases.

So this requires us/you to pull in those changes into the LTS release
branch. And that from my point of view mandates that we also review
whatever is being proposed for the backports. The mode thus essentially
becomes that somebody else does the legwork of selecting patches that
need to be backported and massaging them so that they apply to the old
Git version. But other than that we still follow the normal processes.

And yes, that probably means that a trusted LTS maintainer should be on
git-security@ so that they are aware of upcoming security releases.

Patrick
