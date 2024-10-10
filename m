Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFCD18E02D
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 05:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728538922; cv=none; b=BlX348IFVlNLIvejVudKpfIFPus11zcWf5sKdKsGuj/aJEgr9qDkMpyAbcnVVTUhfQtv9b8rbc2KAaLSywLRXdPCdSSR0wrp3fXS6srU0QJFevz3MVosB6ibInNBQU6/ooWHLSGiGqLBe3npopP5AqfXiNn3ABYcTmWZtYvS6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728538922; c=relaxed/simple;
	bh=cDFyxwKai7lf1sWlAoXe6HhrYmFp7Hg67/6m/5M8J6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/XvroKnuRwmaBXeqlHFh6FU1QTTVu5sOb3HIkX3iI70s313FmvMiWjscqYoca3zYstwwd0idduV1exag+0n44XamD6yi6wCcOYP0g9MxMIsSXzvZPTKlc3cx+R5g0rXyRL5fs4hGIWeTSHwGZ/MB7FAvIdRPAoqhnCp0jJvfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DfEPTzMT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PPB8w+cm; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DfEPTzMT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PPB8w+cm"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B9CD4138028B;
	Thu, 10 Oct 2024 01:41:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 10 Oct 2024 01:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728538919; x=1728625319; bh=B9Cwg97lyd
	NHON49rFQAfyQgK7UzU7lyE7bWfl6zZ9U=; b=DfEPTzMTbkeyBmphg/L/e1nJDB
	U/RfBg+vMP9uoa/1PXtX25lKXfMjgpI+kI+ULGdZuft44k6IcTEEv9D0k+Tqw5vQ
	7RnhkgajicE+WexhisJPySVxg/uVbe+ZvRx3tRvnXiByilqB1ZfeIlAscbGnEAPo
	I5b+cnV1bZgRqToZyLi95FMB/tgWVbpp7wl1hQBnIjqCrKIRh10BDU/qIA9QmSLe
	I0usAwiasqwI+Cg7dkomncw19D2Fki+mLceGUXOS726iiw3/ZjeukKV1MF5yh6rZ
	J0A9sOxhV3CwR6fjizzd/wvxxMujTPKyKOYLxerN7tixAAZs6Wbp0yB2KVbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728538919; x=1728625319; bh=B9Cwg97lydNHON49rFQAfyQgK7Uz
	U7lyE7bWfl6zZ9U=; b=PPB8w+cmlG5JwjnMPrQYoAnkhpi538XT5E7pcYwIKY9a
	IR3U2iEA4+bvvT9oUgubsCC/jX7k3947AZ5y99lMSaKe/IoGJSmWPi8q4gM53k8F
	432X+3VGMRT6yXrVDOzUiRem+7JKj28xcPHKcFuWSw3YeQ59XZHE5kyaptsmrBVH
	winfuxqvNzbOejxB426Z6TESX2jAr2F5/e8UYYRQjxxn2GdGrUzcZSh8oXujSN01
	DIXr0x3lloMseEfTUv8YrINDWiUskpt4c/7RL4UWOGRmayq1yVMlXEb83UQ01rFJ
	OwFVFvlu3M2zPhz5VqApzh+dyPBl5aS0WGXsEsjx3w==
X-ME-Sender: <xms:J2kHZ2Oopu7Y-2kMmQO-MNdQ8UGg5N_xv-i22PxTfTRPTkvbj-5Mzg>
    <xme:J2kHZ0_AeLUQPmwzQPbF_GPJixMtHcUB03pQLrwlePHf-Y4klp7lIVWQdXTIpOb7K
    tJ6bfCye59tMwWxkg>
X-ME-Received: <xmr:J2kHZ9QzZYM0B9BfGvCwINK7zefxNulZ-URkFItQjJynzscnMp3sXuwrq-lwDeG0GX5g1e8PopiYBc5HwX4BIlzmNRXpVB0deRJ-sdUFCa7Bw1xe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughr
    peffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkuc
    futhgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedv
    tdfgleekudehfefgffeggeehledtveeujedtteevjeeivedvieeiteffgfegjeenucffoh
    hmrghinhepghhithhhuhgsrdhiohdpohhuthhrvggrtghhhidrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvggv
    mhgrjhhojhhuleeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:J2kHZ2v1-sJeDtsjuFJ2c4rWgKbxm2z1lfMp_16JVH_sI6Y1ZL7LHQ>
    <xmx:J2kHZ-dkQMIPqHYEG2Y5BDV5t5_JJderoyYWD4cJW4tM7w6WW55qVg>
    <xmx:J2kHZ60c7WdZr2ImWiVNyCIsjz5POYytDLDAPM7pQx1UWb8stoCbiA>
    <xmx:J2kHZy810i85mShTf8JKjWpSgsj4PlpK6FwbUKhU6MSYeIhBYroiYw>
    <xmx:J2kHZ96a3e6Vlivq17BBe-x_fOLB_0zPz8F-9yj8byKh2E68axQCZKWO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 01:41:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0a6f9b89 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Oct 2024 05:40:52 +0000 (UTC)
Date: Thu, 10 Oct 2024 07:41:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Neema Joju <neemajoju96@gmail.com>, git@vger.kernel.org,
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [OutReachy] Introduction and Contribution Phase
Message-ID: <ZwdpHNOPKpi12n3e@pks.im>
References: <CAEqABkKmkqJCqpG5nOgGnK_BKhN_rTgmioptTvCLYGWd4WV0ig@mail.gmail.com>
 <CAPSxiM_OssSLAGd1JC3UJ9Saorf4yxx9FtvnhpL4=hBrcoh8hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPSxiM_OssSLAGd1JC3UJ9Saorf4yxx9FtvnhpL4=hBrcoh8hw@mail.gmail.com>

On Thu, Oct 10, 2024 at 10:21:54AM +0530, Usman Akinyemi wrote:
> On Thu, Oct 10, 2024, 10:17 AM Neema Joju <neemajoju96@gmail.com> wrote:
> 
> > Hi,
> > My name is Neema. Pronouns (she/her/hers).
> > I am an Outreachy applicant. Completed my initial application and am
> > currently in the contribution phase. Looking forward to working with
> > you.
> >
> > I have read through
> > https://git.github.io/General-Microproject-Information/,
> > https://git.github.io/General-Application-Information/ and
> > https://git.github.io/SoC-2024-Microprojects/.
> >
> > I am in the process of selecting a microproject. However, there are
> > some things I would like to clarify. As a part of outreachy
> > contribution phase, making one contribution is mandatory. In the
> > Project Contribution Information
> > [
> > https://www.outreachy.org/outreachy-dec-2024-internship-cohort/communities/git/
> > ]
> > section, an applicant has to complete a tutorial, microproject and
> > then make a contribution.
> > While I see detailed instructions regarding the microproject, there
> > aren't any regarding contributions. Is the microproject considered the
> > contribution? or are they separate entities?
> >
> 
> Hi Neema, when you do the Microproject, you are also contributing to Git.
> The Microproject is all about making a contribution. You can also wait to
> hear more from the mentor.

No need to say much more than you did though, as what you've been saying
is exactly right :) The microproject is how applicants demonstrate their
ability to adapt to the workflow in the Git project. So this is how we
mentors ultimately decide which applicant is likely to be the best fit
for the Git project.

You are of course free to do additional changes after you have completed
the microproject to get more familiar with how things work. After all,
this is an open source project, so people are free to contribute at any
point in time. But this is not a requirement.

Patrick
