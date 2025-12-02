Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3821D3C5
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701413; cv=none; b=pa4fqBia0jm26cixI86f44UGRDU2TZaXR8719efwPCn+AuFEzPgL2AJ0Z+VWI5n6+yglM1h6oMCrfjzA2iTeKl+dQAkBw6uWc/MIx5Qbb4W9M9YdAdJ0pRRJPMGzOTpAqeBwfoGXc4nugDteedqOPdA5ofe3xMpYluegUXMwlUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701413; c=relaxed/simple;
	bh=atQkZr3j5aYVmQrjNuT7Ydd75vPNvUkVS1BmqedfZ2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeK/M52f0is2n7O9/7rN8aNDugLWVPajgmzKaZoNorRE7MTpLautHc+WN7ggQpRf42rGgaIWxaqNCxw8oYSBCW/CLV85UFWqiyS7vYNp0CWzwUUYOQkgTyGCJzH2x6ffs5X+GOAgsRXXkckbXCq8yTNH3BCSh9MvHb0COQ/cldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B+d30s77; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VdZNEKQt; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B+d30s77";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VdZNEKQt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 34C3C14001E1;
	Tue,  2 Dec 2025 13:50:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 02 Dec 2025 13:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764701411;
	 x=1764787811; bh=AACCWkSNk+EpbDsQpNDRwSmoLIQwTuKQJq87g28bBNY=; b=
	B+d30s77MWtc5kN6H/s4jzvHGIZIjm4sgb2hPqg1jHJPML7chcqETwOHlbDTUF2R
	bMqrIArBgnEwYYtGQvOxGQLqPC+c5S9r/9kmfZcljYl8hGcA6Y6HSwfi2olf5tOx
	PGyFcQc7dOkHZkjYFN+6evJ1fZhRoBF8wagYpIYbIPdapfD39ENycgICvh0xjvwn
	5qxzn6ALwLAunVowjrQwtlgBdxDr0RZgTWj2Ebo7X/vkCg8R6ssxoBlmRiKgKAmz
	SSRLFLSu0fUnkkqYhysOUCGVOXNVsGj3eDIImQz6RxIK0RxDOjr3+kuDW2O5ydVL
	epa8JuqUh6pES4IHicLbtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764701411; x=
	1764787811; bh=AACCWkSNk+EpbDsQpNDRwSmoLIQwTuKQJq87g28bBNY=; b=V
	dZNEKQt4uIqvAtuBXvygETSuqm1n3n+50tb71gU6jiBiPm1IgyF58Bcne4C9K6M9
	1/FeFpv5Dh+2Sl6niHSa/iu1OajrVwZHVps/wfhn6DXd/PWjeWR1j5G2mwdLvUkN
	ORwDpIbwBvPx++YiWQQxnPsUR+jUvVLO22+qKDWtXX3kWSQNNlfdoG2kuqsm6EMu
	i5fcVslNMBV3h2APe92OkcAKe1/TaIeFzwYEH68hMUqAbuPuIFZpgBjiUwpOzZAc
	J7c4GkRUe36bl5x9MmdN6o2ouXh63Yh+b0hEbqb1xOZ5eJO5vUx4EVwqRE9ssN+2
	vXUVbvxGFKTsaNR3f35tA==
X-ME-Sender: <xms:4jQvaXwsoZhfpHUX-LmKDaz4NB1EEIUOvcdNYT9izUTdiXQYu-8q7w>
    <xme:4jQvab0_s8yoEDUlUAJHyYWAPY1S4Pu-C232t_Qb-QLyOKujtNuwiBGY2qjqX1LAH
    beNM01adgqNB_4XzuEH_JQnmYSIOxEUS77JmbbSdp6iN2GVV3l9Qg>
X-ME-Received: <xmr:4jQvaVwqeE-HqUrT9HhKxq-Xvc_YLDWXsqN2suktqOGEWwoM-gKjIzy2SmClwvxbMG28-WX8r6hfF5TdiozY5oozzOSUJ07XwIX1SHMeFmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvd
    efjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonh
    iisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghi
    lhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgv
    fihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvg
    drfhhr
X-ME-Proxy: <xmx:4jQvaYWyfdFfJg3S8NYt8ocJCs7tNq_59xDCYCMNzH-4_Xdrblzgsw>
    <xmx:4jQvaZ9YomWplQk2_uozJzKppktHXjgfp4goS6-kl4EwJn2IjPBfpg>
    <xmx:4jQvaTsNVY_lWYJVHsvv531A7GbxJ8LXd-dZwKC4k1aYWww90gw12A>
    <xmx:4jQvaR0NPmE7hKpFQECNRkCed-Vr_6xPmXh1sAsND6bwoP0nSEQrhw>
    <xmx:4zQvacDTp0lgtcX9d1fq6f5iucrNXwqll7BEmMNDEUs8I3gfg9ajLVAF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 13:50:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 37a49a58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 18:50:08 +0000 (UTC)
Date: Tue, 2 Dec 2025 19:49:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
Message-ID: <aS80z0DxAEBLba-M@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
 <xmqqbjkw78jj.fsf@gitster.g>
 <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
 <xmqq7bvk77lr.fsf@gitster.g>
 <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
 <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com>
 <xmqq7bvj5q8m.fsf@gitster.g>
 <CABPp-BEVX85xZ7_1fSfW4-xJod13p2-HvQ-e5ga+m9-Sq7mbdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEVX85xZ7_1fSfW4-xJod13p2-HvQ-e5ga+m9-Sq7mbdw@mail.gmail.com>

On Sat, Nov 22, 2025 at 06:54:00PM -0800, Elijah Newren wrote:
> On Fri, Nov 21, 2025 at 8:01 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> > >> Granted, I think good progress is being made and perhaps the changes
> > >> needed for the rest aren't that huge (and maybe there's more pieces
> > >> I'm not quite understanding yet similar to the
> > >> two-split-patches-always-summing-to-the-original), I was just a little
> > >> surprised that my comments are summarized by "expecting a small and
> > >> final reroll".  :-)
> >
> > It was because I didn't think (and I still do not think) your
> > comments are something for the immediate future, for a tool that
> > wants to present its minimum-serviceable experimental version to
> > users so that the users can experiment, extend it more and fix its
> > behaviour incrementally.  I may have been probably wrong, but I was
> > getting an impression from the reviews that it is getting to there,
> > not the feature-perfect version that needs only maintenance from now
> > on, but a minimum-serviceable one.
> >
> > We could instead of collect all the I want moon and I want cheeze
> > comments and iterate until the tool has all of them before it hits
> > 'next', but I do not think it is often what we do to a new feature.
> 
> You're reading my feedback as feature requests rather than as bugs
> and/or possible paint-ourselves-in-a-corner situations in the
> presented implementation?  I must have described things rather poorly;
> if they were just feature requests, I'd agree we could just implement
> them later.

The command is explicitly marked as experimental so that we can iterate
on its behaviour as needed. So I don't think we're painting us into a
corner yet.

> But maybe I see where the confusion arises, since you were focusing
> solely on the single branch thing; that's the one issue where it's
> perhaps not as clear whether I was discussing a bug or a new feature.
> Let me try to explain that case another way:
> 
> 
> The early cover letters said they focused on a case where just a
> single branch was involved, yet they don't check whether there really
> is only one branch involved for safe operation.

I think this depends on the definition. We _do_ verify that the commit
that is to be edited is part of the current branch. What we _don't_
check is that the commit is _only_ part of that current branch.

I'm not sure whether that is something we want. I myself have the same
commit on multiple branches quite regularly, as I tend to queue up
multiple dependent patch series. But I wouldn't ever want a history edit
to affect all of these branches myself, I really only want it to modify
the branch I'm currently on.

> If a user tries to reword or split a commit that is in the history of
> multiple branches, the current implementation does not check and makes
> the branches diverge.  Some users may want that, though I suspect most
> would be negatively surprised.  The commit messages and code do not
> even discuss this case.  If we merge the code as-is and then later
> notice and fix this problem soon enough, maybe we'd be fine, but I
> always worry a bit about a git-switch/git-restore kind of case where
> it sits long enough and people depend on side-effects in a way that
> prevents us from fixing it.  Besides, since the bug has been
> identified and there are multiple not-too-hard ways to fix, I think we
> should do something.  Some possibilities:
> 
>   * Document this case and warn users to check on their own (not that
> friendly, but might be good enough for the first cut).
>   * Check if the user-specified commit is part of multiple branches
> and error out, unless the user provides a flag verifying that they
> want histories to diverge.
>   * Just rewrite all relevant branches
> 
> The third of those could sound like a feature request in isolation,
> but I raised it primarily because it's a potential fix to this
> overlooked bug.  I mentioned all three possible fixes, but assumed
> others didn't realize how simple that third option was, so I pointed
> out how easy it was with some code (~12 lines, which also replace many
> more existing lines of code).  I personally think the third option is
> *less work* than the second option, and that the focus on trying to
> limit to a single branch is creating more work rather than simplifying
> the problem.  But if folks really do want to limit to a single branch
> despite the code existing to handle the more general case, then we can
> implement one of the other solutions.  (If we do so, I still think
> choice three is more friendly to users, to cpus, and to future
> extension of these features while also simultaneously simplifying the
> existing code; so I'll volunteer to investigate and post patches on
> top of this series if others decide to go with one of the other
> choices for the initial version of the feature.)  My main point here
> is just that there is a clear, un-discussed bug, and it should be
> addressed somehow in the initial version of the feature.

So with the above clarification I wouldn't call any of this a bug, but
rather working as designed. We could of course still print a warning in
that case to protect the user, but one problem I see is that generating
this warning could be quite expensive as we'd now have to walk all
references. That might be cheap in case the user only has short-lived
feature branchs. But it may very well not be cheap in case they for
example have old release branches checked out, as we'd now have to
potentially walk a significant portiion of history.

Consequently I'm leaning more into the direction of doing nothing. It's
not really clear to me that this is a bug, and we still can introduce a
flag in the future that opts into the behaviour of rewriting relevant
branches. That behaviour certainly can be useful, but I'd claim that
it would be rather surprising to the user if that was the default.

Patrick
