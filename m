Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ABE1C862D
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279579; cv=none; b=dcQym6QBe8p48mWjse1T6ff3M/vFHGzsuGX7DtwD8XJJUppyONmYoqx/5Fd1ZaZF4BTZ0v1fgR633u+FVi/OStL6v3R7Ejp4JVJHI9eHU+LgPv7xNkf0C92lIxvU7ZAG8/Y1rdS3wEvroe2KB6wCLLb/B1bSAj3zmNXbC35ABSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279579; c=relaxed/simple;
	bh=VcO33cqFLT1vrvgyASfDRwE8AE28M6w+JOmoRzCnHJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yqs4mu5N1ErZ9uhkqd8E2PrLM2LA+ka2d1KqRRVsRtfKbo2ir6PGddtGGVRJv2g8ZKlYLXzwH35c5Ln3MXtHm4+xKmxc5kE5xOQkbhGHyT63Arh9nrvCcuvLQDCLtNoVTCwOmp0/OiOeOAxcmhUlUrV5TfFsKuIuNPS5dsNnlcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KLNEt5el; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=teOEDhdp; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KLNEt5el";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="teOEDhdp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 104CDEC058A;
	Thu,  5 Feb 2026 03:19:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 05 Feb 2026 03:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770279578;
	 x=1770365978; bh=GB8mVes8pozhmrn+DUHJIBJMPKBGMv0J1jj7t8uGLMs=; b=
	KLNEt5elH285DhrRrTWvrxx/xIKQcLVP4q6oagymS0FG4LObW/FpQpnpPNe4WPuY
	d0Z7KYdL6AW0FRovfJrXGjIIrmMc0RCnttuswg5goJQWfeYJf0KfRXh2bGRhxlpB
	D0Ba6XkizoU6nLpCi0bFV0HU7W/qonwG1BNrFoSfiXQ9n950lwp6eIyIh1SmDYYI
	3yh9DBOSWzYtj0j5Qc4GvdbBRirFHEOkYsO8fksNQ7PndkgC4G0+wUyVFaU7CSIm
	3ZDQMZ4Pmrf9NszvMTF5u5I1Q63wRtkS7Nur6b7JXySqbSpCrsPQ6+ivwEzxuQIO
	zi9l/WiqU0oQXWugB4Nb/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770279578; x=
	1770365978; bh=GB8mVes8pozhmrn+DUHJIBJMPKBGMv0J1jj7t8uGLMs=; b=t
	eOEDhdpvZ6eX7BegF2xqUcqvkat6a4SEWxUPRWRigYfvmuFGQ8/upxk89Uz1i8Mp
	oZm6xxPW+OpeG9Nchv4hux4kxeM55G9dTPONyqEpKn9JSCdjThe88jYJ8q0Ic6+X
	w6fhBko5KUHoN3LiUcaC7GKCE1kPhVWJ6uJ4Ac+4XQZcoa9ZQ1CUed4cdIljUSNb
	SPgp8GqpE3UF1eso9eC/1JEKeRSne5wU4KgFCztVhCeBOJK8A1MEAFJMjey91sbj
	DWjwoJycdEkjGDW+qlvxFS2p9uziMXVM4DTPxreyi83SlM6ZvIo3FuEJSYaKr8v5
	KF4+mdSiwFFZZRBfcJqaA==
X-ME-Sender: <xms:mVKEaZFq1X6NkdgdnbH2Lu1ZYZ_hRBEUfp0uEyDFkJIiZokWkCqtqQ>
    <xme:mVKEaaIQenc9Dh-A14cmSAq8kDc51xVKkh3rl2hnSylT4RJMwtgHCdHaJtXStn2O-
    qU8yXco-LMa0WTYBZTISX5crxqfG98ZyAL5Kzn-G3F91FmaARFfRw>
X-ME-Received: <xmr:mVKEaWjakyNayoi-WUeeTreBQ_gp4QLZBJQ-C04JNGbxRkCNxEcq58QurHl7gilfUGhkNBE_-tLc94-AynrAWaKOMHsQGrbPhSUHPTz8i5vIFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeegkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetheffvddtleettdetueeukedugeettedutdegueeukeetheefueevvdeitddtveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhr
X-ME-Proxy: <xmx:mVKEaYmru7bnj_kJhNZkF_CQfdtxIOvx0E_xQe01Dw_6EsBqatpaiA>
    <xmx:mVKEadW126BuHWvJtJQP6nCgX-xXZtXx_aesV3RtF4RidrF73RMX8g>
    <xmx:mVKEaVubRGQ6K_oBV6E5ZHBh3urNq3qBD8xDpEAXpMgxfW3nD-4eSA>
    <xmx:mVKEaY71RkBQziQsNMG9WDlW4zavyLjh6JOqx1bmkk2KMGuQZ3m8Uw>
    <xmx:mlKEacG0SnouTfHOOmVXysPGt_iS2VEK1LkbZRBhe_QNy2AMxpsOZVw1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 03:19:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28036ea6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Feb 2026 08:19:33 +0000 (UTC)
Date: Thu, 5 Feb 2026 09:19:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v11 8/8] builtin/history: implement "reword" subcommand
Message-ID: <aYRSjhnS8VQPSHa0@pks.im>
References: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
 <20260113-b4-pks-history-builtin-v11-8-e74ebfa2652d@pks.im>
 <aWpnFqTmWB9XIWUW@szeder.dev>
 <CABPp-BHkNLdH4C7U4sFoVhrsSPH8KAaDtOdLEQGyajmXZz9hVg@mail.gmail.com>
 <xmqqsebivgop.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsebivgop.fsf@gitster.g>

On Mon, Feb 02, 2026 at 04:01:10PM -0800, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
> > On Fri, Jan 16, 2026 at 8:28 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >>
> > ...
> > Personally, I'm having difficulty understanding your second stated
> > advantage of picking the commit from the rebase instruction sheet.
> > That instruction sheet is obtained by rebasing on top of something,
> > and it seems as easy to me to see the commits since that point in a
> > git log command and pick your desired commit from log output as it is
> > to invoke an interactive rebase on top of that base commit to get the
> > rebase instruction sheet and then pick out your desired commit from
> > there.  Same number of operations and work either way, so I don't see
> > how either is more or less work than the other.
> >
> > You did make a good point that one of the differences is that you
> > don't have the commit checked out.  That's a useful distinction to be
> > aware of.  To me, that seems to be somewhat implied already both by
> > "in-memory" and "even if there are local changes in the working tree
> > or index", though it wouldn't hurt to explicitly call it out.
> >
> > It feels like each of your complaints with the new proposed commands
> > (given commit not checked out, rebase instruction sheet vs listing
> > commit, and HEAD-only) can be boiled down to the fact that they don't
> > behave like `git rebase`.  Is that accurate?  If you like rebase, is
> > there a reason you are worried you can't just keep using it?  I don't
> > see why others should be required to implement another exact copy of
> > rebase, though.  Further, if we only wanted minor modifications, we
> > could have just done those to git rebase.

git-history(1) is definitely quite different compared to git-rebase(1),
and that's by design. Not everyone will like it, and many folks will
probably continue to just use git-rebase(1) themselves. But as you say,
it does address some use cases that git-rebase(1) doesn't handle itself,
and it tries to provide an opinionated interface to make common tasks
easier to handle for folks who aren't advanced users.

I of course wouldn't mind highlighting more of the differences in the
docs and/or the commit message, of course. It's tough sometimes to find
the right level of details.

> >> I firmly believe that operating on all local branches must always be
> >> the result of an explicit user action.
> >
> > Over at https://lore.kernel.org/git/aUVaEPGoOkATQGl3@szeder.dev/ , you
> > alternatively suggested the idea of an "escape hatch".  I think that
> > may be a good idea.  What if we had a "history.scope" config variable,
> > with values like "descendant-branches", "current-branch", and
> > "error-if-multiple-branches", corresponding to each of the requested
> > defaults we've seen in response to this series?  I can't imagine using
> > anything other than descendant-branches, and the preponderance of
> > those who have commented on the default so far seem to be in
> > agreement, but it would allow you and Matthias and others like you two
> > to pick an alternative.  Thoughts?

I would certainly be happy to add such an escape hatch to the command so
that it only rewrites the current branch. We already have the
infrastructure for that in place anyway, so it's trivial to add a
configuration key that changes the default.

> The discussion stalled after this exchange.  What is the next move?
> I think the it is SZEDER's turn to respond?

I dunno. From my point of view I still believe this is ready to be
merged. Sure, there will be follow-up topics:

  - The above configuration to make it work on a single branch, only.

  - First-class conflicts. This is something that I also discussed with
    Elijah already, and we will coordinate on this topic going forward.

  - Additional subcommands, of course.

But I don't think that missing support for first-class conflicts needs
to hold back this topic. The proposed command cannot result in conflicts
anyway, and there's more commands that won't. Furthermore, the command
is marked as experimental, so the initial versions are expected to be
somewhat limited in their functionality so that we can get feedback and
iterate on the design if we see that it needs some tweaking.

Thanks!

Patrick
