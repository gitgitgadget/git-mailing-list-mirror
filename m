Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C072AF1D
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 05:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728453072; cv=none; b=QOdHON7GIwCgd6wCx/8y3Lj1oRwD94GqzBvNH8FrfkvBcOo8Y/nV4sjRKj7QBn+8ak0S4JVTs4Onng65GETsFEG0KZ7OiLgZ7u07374EUwLygHZgvaFegnWvKOvv1BjbglGYxLvmH67jgu8a8NBEqjrtcUsJQF1C6vxtg/YRyXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728453072; c=relaxed/simple;
	bh=WT59F4TgVYpRpX2jFUGxJmJZE83R0kqxT4zyBiEVMwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEBvQjtGXj3oepWZ6kUJZMxFxP4i92u+AK9gt4K2iL923a1pT1uV1P4P8M8PI3C53o1vGKTfZ0VlX4vIwB9nwxGx8JvnybcZNv1Vwu3/e+6/YN85828F+Zn5DXqc4KvfVwSFj6PR6RwKHWK2YLomrBtVGDhqS7YDatOD4aaGGyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RvnYyqsL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cxjQAxXo; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RvnYyqsL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cxjQAxXo"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9FA3D13806BE;
	Wed,  9 Oct 2024 01:51:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 09 Oct 2024 01:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728453068; x=1728539468; bh=zAQZZkorMn
	zIUrfJjRyCgI9fGlWDzsQlWBNob6MivhM=; b=RvnYyqsLm6WARIEHnZoY7Rd3ve
	MqeoWC4sYcFjOk+j8cJtDuY3IKbeL0sK63sTwhgR2BVIfikMUlgfTt5V/cfej4q7
	SsupRm4e819GU7ua2YcvLyt2q+8FLHwJNWm4v/3eoMsyflljUgFAUyYSCRj/C7wi
	XOJ7QXmtWZR1bjYdPz6VNLJ8Uk401RdLTSOVFCmD0TV74y+O/F5k4ZgN8OkmFCtD
	OVdKP+sjxZM2MtPmGpXDn8x9rhUXiabSng1sqAuJrW8dUnYeKQIig1C7ISJ8JeeA
	/TbtyaWemxDOFc/geww/EIp2q1wbp1EPR3T0rLbJ3J9ZwIgzRFMx8IZpreUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728453068; x=1728539468; bh=zAQZZkorMnzIUrfJjRyCgI9fGlWD
	zsQlWBNob6MivhM=; b=cxjQAxXoLUcK5CnnHm0kvnoUcQf5H1jkDgnhPu9MZZzd
	iCA+8DGJshiRh7knLmCeuXI/n9f0fbmuDvpTXmVEFl7gnzDqPEybzcEF2aKv2seF
	vPmGat/IWg2bMtfGswYFsHD7N/I7v3wLOfnaES+fCTnkcMWsOQF6eIDAyyAhdCv7
	MUR9b0AxXFeZosDB0/O2yM3/JYWAJS5ZtJ3xNvqsXCZXi7SnP8mBVVA0ba/Rj2Ba
	EwLwnbS88iutr6frY+aW5jq3gMf7vkx0HRuTa/3qBVk/OAHBw8eQ4027j/vVBQks
	4srObQ3d1DvK66hX9hrUkPxpuQbTknQBIeYYEfNfUQ==
X-ME-Sender: <xms:zBkGZ_MCNZg2gMCeCpxPDWm0osTwkHxKj-vgHadpcZDxK5G9Gp9QaQ>
    <xme:zBkGZ5-vMin2cOdBzeNFVIRnWNbKjdedev9NVXWAMVLFZCO-rghzfPBGZMZM_n6o1
    njyBCCRICPDkojcUA>
X-ME-Received: <xmr:zBkGZ-T4UdSqOb1NjcO-2mjqxSttM81IplBTHpVhW7tyEPkCpIOR8CqShEJqJi3fG5Bob7tABi5kpPmjePvfPLd01pCatDT4F3d6H87YOLwUjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepleduueefje
    ettdejtdejteevuefgieeikeeggedtueeuieekkedtudeujeeliedtnecuffhomhgrihhn
    pehlfihnrdhnvghtpdhphihthhhonhdrohhrghdpuggvsghirghnrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:zBkGZzs9l3v0VuIZ-NqGgBC3jI3jiTdFQU7BoCRXP4oiCEQWRadKDQ>
    <xmx:zBkGZ3fYD1kqUGGCZ-Fr6IDUDMMdMLxE5DWnMfmQ55_yBYZvr9w6Qg>
    <xmx:zBkGZ_2w1GiEIJx5Dh7P-trHmoWN2jZI7vJeNhh-uEq79Xs-2yGKtw>
    <xmx:zBkGZz87bLvs7yMjMREA8t8ZKb4cyeOExpIX_6n-qjqF3zNRk7A2RA>
    <xmx:zBkGZz5ZkTo_LgsJflro31X6zFbQCa9WHH2oIW1yOijVU5R7XgnMuu9a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 01:51:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 052bab72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 05:50:03 +0000 (UTC)
Date: Wed, 9 Oct 2024 07:51:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: the latter half of october, the maintainer goes offline
Message-ID: <ZwYZwBOYpd4nribV@pks.im>
References: <xmqqh69thzd0.fsf@gitster.g>
 <Zv7aLRXwt9cfqW58@nand.local>
 <ZwAIM6GO3VtoG3ZM@pks.im>
 <ZwBwcOK2/sazF17B@nand.local>
 <xmqqv7y2354r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7y2354r.fsf@gitster.g>

On Tue, Oct 08, 2024 at 09:56:36AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
> > On Fri, Oct 04, 2024 at 05:22:27PM +0200, Patrick Steinhardt wrote:
> >> There are two maintainership models I can think of: either a single
> >> individual or a group of people would take over.
> >> ...
> > I do think there is a need to have a single individual who is ultimately
> > responsible for ensuring that the patches are reviewed and merged in a
> > timely fashion, that releases are cut on time and are high-quality, etc.
> >
> > But I also think that the project benefits from having trusted
> > individuals who are knowledgeable about specific areas of the codebase.
> > The maintainer can lean and rely on those individuals to get a sanity
> > check of whether or not some patches are good or not. For instance, I
> > would imagine that Junio relies on you to help review patches in the
> > reftable implementation.
> >
> > I think that's more or less the status-quo, and IMHO it works well from
> > a contributor's perspective. I would be curious if the maintainer feels
> > the same or not ;-).
> 
> This turned my "explore how you folks want to manage yourselves
> while I am away" into "how would we want to run the project after
> Gitster retires (or moves on)".  While I find that the rumor of my
> retirement is greatly exaggerated, I think that is a discussion
> worth having.

Just to make things clear: I didn't think that you're going to retire
anytime soon. As you say, I rather wanted to use this situation to think
a bit about the bigger picture and think way ahead into the future.

We do not have any kind of contingency plan if you ever did retire, to
the best of my knowledge. And while I hope we won't need such a plan
anytime soon, having some kind of common understanding of how that
situation would be handled in the community would be nice. I could
imagine that this discussion would be rather heated, so my hope was that
it is less heated by having it in a situation without an immediate
need.

> It is a tricky topic how we want open source funding to work.
> 
> The "benevolent dictator" model, even if the day-to-day operation is
> delegated to various area experts (aka lieutenants), cannot work if
> such a dictator simply does not exist (due to various reasons,
> ranging from "nobody wants to become one" to "community cannot agree
> on whom to make one").  The community has to go with some other
> model that does not require a dedicated full-time maintainer, even
> if it prefers to have one (and the community can choose to follow a
> different model even if it can afford one, of course).
> 
> I think the status-quo, which was nurtured over the years, is the
> best this community can have, *if* we want to keep the "benevolent
> dictator" model.  I would not claim that we perfected the model, but
> I would say we are close enough.

I do not really see a strong reason to change the current model while
you are happy to fill in the role. If the model _has_ to change I think
it strongly depends on exactly what you say, whether the community can
agree on a new maintainer or not.

The Linux kernel partially uses group maintainership models for some of
its subsystems, see e.g. [1]. Python uses something a steering council,
which is a 5-person committee [2]. Other large projects like Debian also
use a technical committee to resolve conflicts [3]. So there are some
projects out there where maintainership is handled by a group of people.

Now all of these projects are way bigger than Git, and they of course
have different requirements than we do. So the mere fact that they seem
to use these models successfully doesn't necessarily translate into it
working well for us.

In any case, if we ever wanted to change the model, we'd have to think
quite hard about how to do it.

[1]: https://lwn.net/Articles/705228/
[2]: https://peps.python.org/pep-0013/
[3]: https://www.debian.org/devel/tech-ctte

> What I hoped to see happen here was that the community is prepared
> when the community has to (or wants to)choose another model.  And I
> am happy to see the recent trend to document and codify how we make
> decisions and move the project forward, because these efforts help
> us whether we have the "benevolent dictator" or not.

True. We could also do the same for our maintainership model: lay out
requirements and the different models that fulfill these requirements.
That would allow us to discuss things in detail and capture the results
in a single document.

The intent here wouldn't be to change the current model (at least that
would not be my intent), but to document it and maybe have alternatives
ready if we ever got to the situation where the current model doesn't
work anymore due to whatever reason.

Patrick
