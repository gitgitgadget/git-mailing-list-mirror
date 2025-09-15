Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7231F63D9
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922301; cv=none; b=N0+DulWwysSP+Cbq7obTe4uqaKiUXsx+rGZ4pIpSm1g62OTEdGDoEh4VhwB/rNeg6X3fLQqQFgBCV+w8e7jGHcjggaijZUG2T8wMla+VbeMHDKVuhu0jAkqe5znZxkBzzh2tPOQ3NHg+UiSjtKLM7QmGIbyeC7sjxFsj7FyaogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922301; c=relaxed/simple;
	bh=98sSsu69vjDnsJFY5pd1liqc0s8G+wyocZPmb+zVjK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7IvbF1t6XJREKp3ZrDyJLOyEtUeLGL+NyL485mYeR1VqkvBR6XK3HmTKBb4oMeCCFhHW5YNnADE0p7ouRNpNFYZ5KJyHT/UelYuSmAPp96yihAm+bhd4JbK7DLo5NthtmfOFcTEak0FxPnbC8FBE7sqMutvSvBpbJ8edGTUW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XKp0s8B3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hvYOA9L3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XKp0s8B3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hvYOA9L3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 22EA214001C1;
	Mon, 15 Sep 2025 03:44:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 03:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757922299; x=1758008699; bh=P7yWse7K6r
	HtVoCEuaL/9K2Xze68ozK610SJJcSfbfY=; b=XKp0s8B3Jm/sU4cPysKeJoTJYV
	rrJV3kv9SXZF+hl+aL14eHKNRNUmdaB5+DqrDvKidlgrp36MeSeaznts1KtDQAQl
	v3+O656BxI6VPVlABarvYQPrvkTfNiErmIyT1XebpHMRNZ/dk4970sZVYOr1203i
	wGDwSPfnkh9ogqNXcKVsjnPFZXg+qC5dLfv3Uh7kzwHz8WpEXHKZohtNIob4uWTc
	FnqsJZYb4wcJPks2TTuN7Bv858eY2cQNXbDlQdBiY6XVfISP25UV7HkoQxF5o8NF
	o7eP3GnJn+ARkPy/TDZJ99AiOA9fWrQRVVj2rIEwu9OSYBt7caDBl+x6Nsig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757922299; x=1758008699; bh=P7yWse7K6rHtVoCEuaL/9K2Xze68ozK610S
	JJcSfbfY=; b=hvYOA9L3vlU78sYPSauE0lNt5UnHIwR3TTLVEuqdrEuuKpjMMC7
	407VWezGNzCeZ8z2gHH61OvaKQEhhEmKjSXx4nUVRz//mxd8/50ZyAgB6zy9Zf/g
	niRLVQms7bNJfBaHkgbpk8pg6++esM+W69iLlasynHCn8EkAuJXM8lIR4GcZQAWs
	BWa5LSm6qn3bkjqy5l/o+Zv3+9jKUTgKJo2c60M1QkqHmmfbzNXi09CN1xnWs4lW
	h29Sy78VEBQtRSzslWb2JfqSAaTBA942FL6KEPT1UcfBK8O5FTZ3WD5KEmiRrFDB
	u+wfCPSbLQpgasbUeuVxQ/lg4k7VibW4mGw==
X-ME-Sender: <xms:-sPHaIhaIINzZs7306JHL5uBB8imBvQMnyx4qD_IRmPx5rbSJt4PZw>
    <xme:-sPHaLnJZrnMaf99Hezme6od-9gc3dPTCQogMhbT_5EZuj1d9I66bu0VzdL-AfSf5
    AF5FpG0sdjyqfVm2Q>
X-ME-Received: <xmr:-sPHaMonrIe6KMQsAYvkawVhlsrGIyP83lorjPq3KaYN6xRoLiKQ37ZLI-2FsYwVukpER3f4EMdh2ThHS7qlWOgVhWMDQ0HrmxfhoXSJ-SrrAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:-8PHaMGihfeEjQc57DCgSIqQ2SAWCKy6EK9plk8fkrCr93QUDO-LtQ>
    <xmx:-8PHaAwAoiqvPRDeY5_NK42P843MF4pZrCoalxoLtowpW8n9AXTkSw>
    <xmx:-8PHaJrg_62OYs8F7IswOlkzC_6XHWNHT-Optri2Ru9eJWDtp-J2Bw>
    <xmx:-8PHaCjk4a5KTw-mDIf6HSa3_fyi60kn5k-TTAwSyaigWJuKxKBdjA>
    <xmx:-8PHaF62t3NX0otsM5cZ65hrLzWjFQIYZJZa3RyGnXD1sbIfNdz2K6yI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 03:44:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9d328eb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 07:44:57 +0000 (UTC)
Date: Mon, 15 Sep 2025 09:44:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 15/16] packfile: refactor `get_all_packs()` to work on
 packfile store
Message-ID: <aMfD9o98crVSQZ5P@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-15-d10623355e9f@pks.im>
 <aK5jK2Q3McLnJ9Uw@nand.local>
 <aLawAalFhp9j0qVz@pks.im>
 <aMNcNTfcg1Jn+oeU@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMNcNTfcg1Jn+oeU@nand.local>

On Thu, Sep 11, 2025 at 07:33:09PM -0400, Taylor Blau wrote:
> On Tue, Sep 02, 2025 at 10:51:13AM +0200, Patrick Steinhardt wrote:
> > On Tue, Aug 26, 2025 at 09:45:15PM -0400, Taylor Blau wrote:
> > > On Thu, Aug 21, 2025 at 09:39:13AM +0200, Patrick Steinhardt wrote:
> > > > The `get_all_packs()` function prepares the packfile store and then
> > > > returns its packfiles. Refactor it to accept a packfile store instead of
> > > > a repository to clarify its scope.
> > >
> > > I think that clarifying the scope here is a good idea. But I am a little
> > > sad to see this patch proposing that we drop get_all_packs(), which IMHO
> > > is a useful convenience function.
> > >
> > > In effect this is pushing out the implementation details of the
> > > packfile_store out to every caller that wants to use get_all_packs(),
> > > which I am not sure is a win. Should those callers care where the array
> > > of packs is found, or have to write
> > >
> > >     packfile_store_get_packs(the_repository->objects->packfiles)
> > >
> > > each time they want to get the set of packs in a repository?
> > >
> > > I could see an argument in the future where we have object stores that
> > > aren't packfile-based and thus calling "get_all_packs()" is not
> > > meaningful. But I don't think we are there yet, so I think that this
> > > patch is pushing the burden of that future hypothetical on all existing
> > > callers of get_all_packs().
> >
> > We aren't there yet indeed, but the entire goal of this patch series is
> > to prepare for that future. So we have to do some steps into that
> > direction that might not yet be entirely sensible by themselves, but
> > that are necessary prerequisites.
> 
> I understand what you're saying, but I think this is the wrong place to
> be applying that trade-off.
> 
> Yes, we will eventually want to have callers handle object lookups
> differently depending on what ODB is in use. When that happens, yes, we
> should be pushing callers to go through the ODB abstraction layer. But
> we are not there yet, and I do not see a compelling reason to force this
> burden on *all* callers of get_all_packs() today.
> 
> > In the end there ideally shouldn't be that many callers that want to
> > access packfiles directly, but it should be the case that most of them
> > go via the ODB. But many of the callers that we're adapting in this
> > patch are callers that are deeply tied to the actual ODB on-disk layout,
> > and we'll have to tear down the abstraction layer between ODB and the
> > actual backend used to store objects. It's unfortunate, but we cannot
> > really avoid that in a bunch of situations.
> 
> Maybe at some point, but that is definitely not the case today. I count
> nearly 50 mentions of either "get_all_packs()" or "get_packed_git()".
> 
> I am fine with evolving those callers one at a time, and think that the
> "the_repository" conversion has a good model for us to follow here.
> Replacing, say, get_oid() with repo_get_oid() over time instead for
> forcing all callers to do so at once was a good idea for a number of
> reasons, and I think we should follow the same model here.

The problem though is that I'm now facing a chicken-and-egg situation.
We'll have to move the packfiles into the object source to make it
possible to abstract those away. So that's basically what I am working
towards: to remove the global linked list of packfiles that contains
packfiles from _all_ object sources. Moving the logic into the packfile
store and make it the one place to access them is a natural step into
that direction that makes all of this way easier.

What I don't quite understand is what your concern is. Sure, we are now
a bit more verbose here because we have to pass the packfile store
instead of `the_repository`. But that doesn't really change anything in
the status quo, and it makes subsequent patch series way easier to
implement. So what are you worried about?

Overall I'd really prefer to stick to this change, as subsequent steps
build on this and as this allows us to iterate towards the goal.

Patrick
