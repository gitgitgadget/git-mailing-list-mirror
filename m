Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2DC1D0BA5
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493053; cv=none; b=AdptQ844wRKYZ2WN1X0Mg/yce7vkwdvcz0Bz/04QC8Q8xSUrkr3HmKXab/LbeyUNYrqGKv31jO6SmmD5quvw0FMSyMqxVel28bsOms8SbXV5TD52T2lt7SDxrl3mCEp/PhdhelAitsOHFcBkLoMy48tT1jH/fqx951BgvvJb+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493053; c=relaxed/simple;
	bh=2XaH/5Be/+MM9LW1UO8d+SqvEbQlkcDR9YcT9qqp8vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBkhJMchiqCmeXaMcjRTcT8/Odl0n18MXYbVyn6/gJrw3rBpRKXMZaDfV1qFWwR91hYuPbzQoTL8WX33ivhSJzb1/sFp7VzX/IuowFt77cUoYyYWjDoxE7s9NAy33uEbW20q35gSZQyeUxKvceJl48Oq1q85GTSjNeThkaTlnAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jC7SQ8Rv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MKae9QMj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jC7SQ8Rv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MKae9QMj"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BD8A813804A4;
	Mon, 21 Oct 2024 02:44:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Oct 2024 02:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729493050; x=1729579450; bh=1aEpgN9DsD
	jFqmKOWAgC7CzEocnzNWuJbzR3alnccko=; b=jC7SQ8RvXQWr1k6oR0/UT6JpHo
	OKLWwcV+AIYnAYm2jHBj4U3BktSBQ7C3Ayk+wb9SKOtnnYmbQU28hctlTAoksH+y
	K8CwsU+BmCbUEuNuka+YAyjz2Txvuox0+PouFTvL8m/WyyO2vRYL7eeUxJIa1RgK
	HMeOTilT194iFzb5p+jV/+5MRwrlCPZI1JspBg208K21h1sUTIKPlyvKuLak47O6
	FkEyjW+2dJXXExsdB8Z0cjOVCrw+iu0adRM1HcgjwldBAwUZcIa+B39F2pbg+IMQ
	XrnRTnwmJsPNgd07NKaV5hQD9A8CQn246TlcJGNeKSVPk0LVWVCZs0KXGtvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729493050; x=1729579450; bh=1aEpgN9DsDjFqmKOWAgC7CzEocnz
	NWuJbzR3alnccko=; b=MKae9QMjf72GD8C+uuR55wg8I+NsUC08d97WzN9+I0ck
	A6B4AAtsXx90LnmRnxLIvpttkOjgJOXotUm9H40J4uj0vGCcXhdKwCDHmjEo/722
	xFhIo0lVFP1hZHKWWPMVlmd/hefwslS4tqbmZM+8NyeYh6iP9vYYWfVBZuOlqcRY
	JxKYnfEpfAaLO5JfefyEhifBC9gLE6aKzq6M2Iuq7RPFZjaufkSlpb7YcpNuo2AJ
	cGZds2pvUEoVahb9p1YZS0H/WXCkJZj19/44hRbXuyq7r7SVzoq9yGebCQk2gzTq
	s3pAHkEmMQa7tQCC0dk4nxUXReltQLylMtwfSG8BSg==
X-ME-Sender: <xms:OvgVZ5kwlq7DXn3wE_SvIwnBhGUnsZN6GXImimDwFGnOgSVld0upNQ>
    <xme:OvgVZ01DngifN3s07RHt_TcFE_e6XluTWNEaTXYiQa-nIC81Z80KGGdxbaOMpOSUl
    OsdMGly1IM6G87D1A>
X-ME-Received: <xmr:OvgVZ_otNqTVqUZNc1B03mFxexlKq7Q0UIhEGuHmeG_jeG5_URpkVCyyd8BUWUFe8ClYTZ4UnWhNexv3hwcDmmsvN6KHJr9VzZZg9LycpwEh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggrghgrshguohhtmhgvsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:OvgVZ5mbuwslMWXDrChz4rUxM3BUsd2bBuiTdLHpR8aPe1_j02AB_w>
    <xmx:OvgVZ316_OfCuRVrKpWvaiOwKOgUEEPB9Fl5ZIFMZ-p2IsKcHuIWvw>
    <xmx:OvgVZ4sRr268xpgwrDsfFFcPpoIVD5FIjtll9AUZ0Ko56-qiDGBmnQ>
    <xmx:OvgVZ7XrDpPHhHkzZ7psazbVOOYzFnEQ_YfbCId0ToFAUjDgjks5iQ>
    <xmx:OvgVZxruRJERZ5guzqPqnr7hbIIZIyol9iQiBobtq3CgfvQSk4ecnDJp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 02:44:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 909a4ed7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 06:42:39 +0000 (UTC)
Date: Mon, 21 Oct 2024 08:44:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <ZxX4AsMRoC0Botcj@pks.im>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
 <ZxGN9zzt55GcL4Qj@tapette.crustytoothpaste.net>
 <20241018045155.GC2408674@coredump.intra.peff.net>
 <ZxHrIBCdnwdRdXAv@pks.im>
 <20241018052448.GD2408674@coredump.intra.peff.net>
 <ZxHylOLHaxP8crom@pks.im>
 <ZxLKLJCgiA3oY4Nr@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxLKLJCgiA3oY4Nr@nand.local>

On Fri, Oct 18, 2024 at 04:50:52PM -0400, Taylor Blau wrote:
> On Fri, Oct 18, 2024 at 07:31:00AM +0200, Patrick Steinhardt wrote:
> > > Overall, I'm a little sad to see all of the #includes in clar.c. We have
> > > spent 20 years building up git-compat-util.h to meet our needs for
> > > portability, and there are lots of subtle bits in there about what is
> > > included and when, along with various wrappers. And now we have a new
> > > subsystem which doesn't use _any_ of that, and has its own set of
> > > includes and wrappers. It seems inevitable that we are going to run into
> > > cases where a platform we support isn't handled by clar, or that we'll
> > > have to duplicate our solution in both places. I wish it were just using
> > > git-compat-util.h. I know that means essentially forking, but I think I
> > > may prefer that to inheriting some other project's portability problems.
> >
> > Well, I'm of a different mind here. It sure is more work for now, and I
> > have been chipping away at the issues. But in the end, it's not only us
> > who benefit, but the overall ecosystem because others can use clar on
> > more or less esoteric platforms, too. It's part of the reason why I have
> > been advocating for clar in the first place: we have a good relationship
> > to its maintainers, so it is easy to upstream changes.
> >
> > So yes, right now we feel a bit of pain there. But that's going to go
> > away, and from thereon everyone benefits.
> 
> I'm not sure I agree wholly here. In particular, I think saying "a bit"
> of pain may not be capturing the full picture.
> 
> Will it take us another 20 years to resolve all of the portability
> issues which Clar suffers from (but git-compat-util.h doesn't)?
> Probably not 20 years, but I don't think that it's on the complete other
> end of the spectrum, either.

My assumption is that we'll iron out the issues in this release. Our
"git-compat-util.h" has grown _huge_, but that's mostly because it needs
to support a ton of different things. The Git codebase is orders of
magnitude bigger than the clar, so it is totally expected that it also
exercises way more edge cases in C. Conversely, I expect that the compat
headers in clar need to only be a fraction of what we have.

I don't really understand where the claim comes from that this is such a
huge pain. Sure, there's been a bit of back and forth now. But all of
the reports I received were easy to fix, and I've fixed them upstream in
a matter of days.

I'd really like us to take a step back here and take things a bit more
relaxed. If we see that this continues to be a major pain to maintain
then yes, I agree, we should likely rope in our own compat headers. But
from my point of view there isn't really indication that this is going
to be the case.

> TBH, I would not at all be sad to see us "fork" Clar into our own tree
> or have a new repository upstream that we track with submodules, etc.

I don't see any reason for this. If we eventually figure out that we
want to rope in our own compat headers we can wire up support for this
without forking clar.

In any case, I'll reroll my patch series that updates the clar today or
tomorrow to incorporate a fix for the reported issue.

Patrick
