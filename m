Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC5821D3C5
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701298; cv=none; b=s8CWTdWvdjTqXAy41Izo3lpaHAC/0Pq5N/E1/1GuvUYW+5FOFaOvDPKI7WOKhRefOM8TIIh/VooJ4+v8jkvlZDIBLOSEMgqZeZgcR0CrcOzsJv8csXNtUsz4eIcBp7PxlMdEtgd3s4cgmXgQkcKtZHpQMvlgrsuLdfGkxXlalf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701298; c=relaxed/simple;
	bh=Eh7RR8Ewg/lD0bQx/HQfI887BuJZi80KlxkbSyAenHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0pIOhoWkdKHipPjYAHoCZ8erktnpJ7jWH+TIpsQOloZOBbrz3in3H0bfTVmkUp2q0GygEhCpCMtGxEH1/Jl146pqDSaGKZhSPVDvTlpNpXDKym9P/DWuPAzoswg5maJC1hBylRPkpbESJfKXc1Qz3OtY8EFJUYKnr+YK8HGDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g9GaHCUw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NLdTJtDZ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g9GaHCUw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NLdTJtDZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB75E14001C0;
	Tue,  2 Dec 2025 13:48:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 02 Dec 2025 13:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764701295; x=1764787695; bh=2TuhhvVeK9
	jw/bfexmjFva9/19fDV1i2FN9oHzbaXCU=; b=g9GaHCUw8JmN3LS2A6K12OXhjd
	MqXtRHsIqzn1ZhYfA9hS8ugMLVybjltZW8pa89pIjHY+48ThQM+iLJPnhToOOg78
	lHFFT3UsRHtTfP3IFCEKYLCulMP87by2LXzPq1E+xi2l0wHA8WZ/ziaYfA7gXvPM
	4c6EmbmPX/s+HozLphrucLonawPoFXrNPgav2DVwBhvqZa4qS/G2pAnBCqJfJxc3
	3djvsFdI6rdZrTg/DDXIijZGVhbUKeGCj087JKFJvcAyG+OAOAqWpXKjfBe47+s7
	USgOTOWpdfqp9twkg9I/zaSifBeRWswRy7g2CDdImnf0clftv5ak/tWWMUIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764701295; x=1764787695; bh=2TuhhvVeK9jw/bfexmjFva9/19fDV1i2FN9
	oHzbaXCU=; b=NLdTJtDZhGRR5UVTsLWNAisSaz7zAV0HyMw3/PN6I2HuS1ODAMW
	gkbSs4JKD5rdhkNsRrgVvPclQ057Z6S77r3B/JK83BdGwOVtxWp4+PDL0TYdX6wD
	fvwbk0soyQGMdmNMs5B0nBGHT9CNDsnM7WPYmZdD7j7GoLQOW2cXuAHsmtFLdppi
	wvoqaPK0n3l6fcwW14kDJY4qBUHXBDztMTGWv1HECHUsSods40IIYVwFZ/UznX+6
	84XC+SjuTiNjxjKwnREc/vdxD/cUGV+BPhWGWz1DngGctigsmj0blcl32i5Rjbfn
	fa8vfSC3AIknMEYEvo7Cku4bIYwbhKs/a4Q==
X-ME-Sender: <xms:bzQvaXi29pw2pVaww3oCS0JwAIoEOH5lDYa-SvPM70FToSe7e4J-Ww>
    <xme:bzQvaXGCEPSqd9r3VzCYTk18Nm-H8ZTshIFonrkHNAMAmrlh_12gFeRcQyoBW-Jr0
    Cqtahk4ZrDfIo2hBg9T5PECWwe3rrRZhSDjUfBsASbC2h8wcvl-7Q>
X-ME-Received: <xmr:bzQvaRvoglr59JqVr-gVO9T6vTxxhDDJVwH5ASkq-bgLWjd3MXFkHjN8tdtPgB3PcotC5BvleF7JiIg_y3T4qYn5XUiMHbugL1cf--jwphQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevke
    ekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    shhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdp
    rhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvg
    hlmhdrohhrghdruhhkpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:bzQvaQeNK2KcpEIJCcb2eDea0av7tmVo8_tvitBJFcqvIK3hoT2X3w>
    <xmx:bzQvafm-c5Wk-7coyhtVBo61TqdoVYhr_iRr64YnM2rSgoDAbYg9VQ>
    <xmx:bzQvabAW2l3M3-qKQBjitNQKHGjWedGzsJRp7diHeNRGljIidH9U4g>
    <xmx:bzQvaROL-PnlNnwU2Bs6u-cqv8MciwDK8qwylIXU77ZYxoQ667ZQyw>
    <xmx:bzQvaapLuBePTZ6clUBb9pn570-0SVdD95pIRSPjhvAnzJT44t2-P9ob>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 13:48:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51353cb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 18:48:12 +0000 (UTC)
Date: Tue, 2 Dec 2025 19:48:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 04/11] builtin: add new "history" command
Message-ID: <aS80Zjr8OwVMPpNk@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-4-407dd3f57ad3@pks.im>
 <cca1e594-6685-4f9e-a57d-8419ccc6fa68@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca1e594-6685-4f9e-a57d-8419ccc6fa68@gmail.com>

On Mon, Nov 17, 2025 at 04:28:06PM +0000, Phillip Wood wrote:
> Hi Patrick
> 
> On 27/10/2025 11:33, Patrick Steinhardt wrote:
> > When rewriting history via git-rebase(1) there are a couple of very
> 
> There's more than a couple of items in this list, s/couple of/few/?
> 
> > common use cases:
> > 
> >    - The ordering of two commits should be reversed.
> > 
> >    - A commit should be split up into two commits.
> > 
> >    - A commit should be dropped from the history completely.
> > 
> >    - Multiple commits should be squashed into one.
> 
> I'd add editing an existing commit to this list, even if we don't implement
> it initially

Fair indeed.

> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > new file mode 100644
> > index 00000000000..6bdfeb50e8b
> > --- /dev/null
> > +++ b/Documentation/git-history.adoc
> > @@ -0,0 +1,44 @@
> > +git-history(1)
> > +==============
> > +
> > +NAME
> > +----
> > +git-history - EXPERIMENTAL: Rewrite history of the current branch
> > +
> > +SYNOPSIS
> > +--------
> > +[synopsis]
> > +git history [<options>]
> > +
> > +DESCRIPTION
> > +-----------
> > +
> > +Rewrite history by rearranging or modifying specific commits in the
> > +history.
> > +
> > +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> 
> Excellent - keeping our options open is a very good idea
> 
> > +This command is similar to linkgit:git-rebase[1] and uses the same
> > +underlying machinery.
> 
> This isn't strictly true now that we're baisg "git history" on the replay
> machinery.

True, this is a historic leftover.

> > You should use rebases if you want to reapply a range of
> > +commits onto a different base, or interactive rebases if you want to edit a
> > +range of commits.
> > +
> > +Note that this command does not (yet) work with histories that contain
> > +merges. You should use linkgit:git-rebase[1] with the `--rebase-merges`
> > +flag instead.
> > +
> > +COMMANDS
> > +--------
> > +
> > +Several commands are available to rewrite history in different ways:
> > +
> > +CONFIGURATION
> > +-------------
> > +
> > +include::includes/cmd-config-section-all.adoc[]
> > +
> > +include::config/sequencer.adoc[]
> 
> This probably isn't relevant now we're not using the sequencer.

And this, too.

Patrick
