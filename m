Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DFD33F397
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146941; cv=none; b=arUMU3p85jucfXQmcHqzpre7Xwzox9JMYUKK1ny6FTmIAF+WT73cS2DjWQN9YTXqumw8MG9X/oZTDggrBBypHSKJjsJlU/g3ZoKi4C0BuWbiQAltsJ6gXOXH629Wjl3pVMIs5EjGPvlnoNEwDnlXMW5phTpAj91e7cd9L4C7uwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146941; c=relaxed/simple;
	bh=70if7tEa8RrKNX7aKk7Qf9R2TkRnFVCYgnxsuBgLfy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rw0zxRKAEP1sqjMcKvzLkXpeHiDXhZTQMW1z3jYCUHy0DFwxfsJJPj4LWLhddhAWZRq4H1oCNfVUqSgI+PVHIpZzLSWPZ6+9/o5DlK9WT3UrfnVFoUPv23vf+yj6mM2+2l9xTmiJ3XHyDhZ6djVR903KfDiNpcYsbv8MRD6Ibfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UC4Mlg2y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F3s5+PsD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UC4Mlg2y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F3s5+PsD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 664321400070;
	Fri, 19 Dec 2025 07:22:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 19 Dec 2025 07:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766146934; x=1766233334; bh=AcUllKLHcJ
	Kmjt8aTq5gQU1FhsjbMa+HTf/OK7uQUS8=; b=UC4Mlg2ylu9bWvwE8QYrBqqfAS
	lUAcWmeYcU6+ATY9DdQxaqDwlW2NovI2/tRxZvVul/qw2NHzINdsbdALr+A2DQCx
	IjEkp/REYglAnUTabIdJAYFdxO9U0KLQYz1uEOjVlR1pYab30w5QxCTJSTEJ5kjp
	9TZmQyyHIC1h/s7tYMCaZDCkmCEfNcRxtcabDj35yXMocZFz1oGqjXyaQSiT8S/J
	KxEgA/xR/EY2GAEFRVM++58iArgzglGtw6AZCM/NnEzcKLcrP5DBVQCRmgMUIs9O
	WokxYeniVwcErG9LPc/9cEhYmypbfk1OMzLlAtyDf6JQvQtp1MqJwZWKc0zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766146934; x=1766233334; bh=AcUllKLHcJKmjt8aTq5gQU1FhsjbMa+HTf/
	OK7uQUS8=; b=F3s5+PsDnT9UfGEX6NX7EdAih2erVFSY3ESqK50ByTMSrPtps3h
	vOuQ0ALGOCxT9HN8dkidSTaCn4KzXPEMp01Nu2VhxewWGbzENLuZLZVFlHBC3j/R
	HVXMR6FkmdGu6qc22eRT931hRO3fg1MoQVFhWQekPlq77oR4H16/gXMnKYYJEd31
	ZBr3zeNezCNXO0SEwmUoMQeuE5lUyX3YBleiBVoaW5Y5DyCdi7FH+mmrKUXZ3QH0
	Qt+LbvQ2bP3QZNsFz2h7u9dcIxEHRQxc7/vZGGBcFGpjp0eokVI2Ueg1jeT+dNN7
	v6/077tID7i1bG7V+Q17obg02zsyLy2W8+g==
X-ME-Sender: <xms:dUNFaXpQU_J7UNgPlKYolQEezOWpNT80Um4UKI7Yzeg09mnhFwjmaQ>
    <xme:dUNFabr9J3lAmr0xGv41WIZH2K-_QK2guzCRpxOtcfSVidNKM11I3j0Z0Mt1DeJHe
    b0F7N9Aco26jqngaNHQDMUvFQ63NJzXlVxYqFt1vxFhNJ4BgqjelQ>
X-ME-Received: <xmr:dUNFaa2yst8_de1023gmAL3099EAosl1Nud1jw6kmSChCXBGY-3mjbv0a8RiFObbBMsH9FFsBNUueIHsoL-gDIoLIFtlLEJT4VODorsK8TwLKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegkedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmrghilhessggvhigvrhhmrghtthhhihgrshdruggvpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepnhgvfihrvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhhvohhn
    iiesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dUNFaZF_0WlZn0IXnoXnFO_TGXeck8hQmQLHCeFWh0giwfpgu_6p5w>
    <xmx:dUNFaVHnPiFi28TeFl3TrNJ1f0P0mP94zf29-ejOn3aeyEOtQ3erxQ>
    <xmx:dUNFac4j-1rOlMOm04kLfDnVAewfXSZp0goMnTuRiKGIcv03CY2ZHQ>
    <xmx:dUNFaawnH4wdRPAkzZ07VdyVV8vFJW8-s1cT5QU46KMdMdkaDcL__Q>
    <xmx:dkNFabsib4CezwYEUiUOplgAD-ERZe3UL80kTSEJlGbKYFBtn5C12Pt2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 07:22:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dff29e40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Dec 2025 12:22:11 +0000 (UTC)
Date: Fri, 19 Dec 2025 13:22:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>, phillip.wood@dunelm.org.uk,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
Message-ID: <aUVDax0PbkaXGB61@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im>
 <aMsWL2cSoytbmRjA@szeder.dev>
 <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com>
 <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
 <a6efc710-4062-4955-8fe8-bb6d428a44c1@gmail.com>
 <xmqqms3qh13e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms3qh13e.fsf@gitster.g>

On Wed, Dec 10, 2025 at 11:18:29PM +0900, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> >> Its mostly because I don't like too much magic and because I think being
> >> explicit is always better than not.
> >> 
> >> So from my POV, I would expect "the simple case" to be "the simple CLI
> >> call" and if I want the tool to do magic and "rewrite all the
> >> things"^tm, that I would need to specify a flag for that.
> >
> > Thanks, that's useful to know. I'd assumed rewriting all the branches 
> > descended from the rewritten commit was the natural thing do do but 
> > clearly not everyone thinks it is.
> 
> It probably depends on the way one looks at the tool, as a building
> block (in which case less magic may be preferrable) or a complete
> solution for one part of workflow.  I probably fall into former camp
> more often than other people, but for this particular one, I tend to
> think it is less confusing if we moved all branch refs away from the
> commits that are obsoleted by rewriting/replaying.

Okay, so the majority of folks here seem to favor rewriting all
dependent branches, which is also the default that JJ uses here, and
git-replay(1) does it, too.

There is one major difference between git-replay(1) and git-history(1)
though: the former works with revision ranges, whereas the latter does
not. By using revision ranges we avoid the problem I have mentioned in a
different branch of this discussion, which is that we have no easy way
to figure out which branches we'd have to touch in the first place. This
is because we simply walk the revision range there and then look at
which of our references point into that range. That's simple enough.

But in our case we're not working with ranges, we are working with a
singular commit. In my head this meant that we'd have to basically do a
revision walk that starts from all of our branches so that we can figure
out which of them would eventually reach the commit that we are about to
rewrite. And that of course doesn't scale.

Now we could of course also introduce ranges into git-history(1). That
would indeed solve the issue, as we can reuse the same architecture as
we already have in git-replay(1). But I don't really want to go there as
it is leaking complexity to the user: they want to rewrite a single
commit, why should they have to think about ranges?

But now that I've thought about the problem a bit I think we can avoid
that issue by implicitly identifying the range: it's all the commits
between the commit we're about to rewrite and HEAD. So, same as with
git-replay(1), the set of branches that we'd need to rewrite is any one
branch that points into that range. It keeps the UI simple as the user
still only has to think about a singular commit, should be sufficiently
fast to compute in most cases, and it allows mega-merge workflows like
JJ supports.

Does that make sense to everyone? If so, I'll revise my stance and will
adapt the current implementation to do exactly that.

Thanks for the discussion!

Patrick
