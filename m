Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6221D3C5
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701282; cv=none; b=MxnYdqCNQV5LE6iTY7NvO0dpn15BNDLy5DzlBqoUJkvqrU4Hi8KypRWAAmQOGLoyZqRDBTEOHhHxr2YYW856tSWuLkZGuDmdMTSiVh+Gw5igDBkqnTua2cJkhDju4ejYa1A4loN9P4S+wwMQETCT4MzO1jSuTLX+G4asiltLB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701282; c=relaxed/simple;
	bh=e1o1ocuCv+GiqjE0aggx1WMRwlZMAbepVHYxxlbyaPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HT2/dI4yCFtzxf2MvOxSzG48aZzr2rNw9Cckdy3HJwMhjXkn+bwHRQ2ifsbK+ogWmg40iit20p9PlWsRlHFXr2cTYUFCyBXFObaqBAbW6lP7XMaz98AbvyvoT7p/ixzvYYnUA/iOC/j8n/SlddYzjMSARXgTNwoqEpVxm+ZAH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IfQ57EeV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nlEjCoQx; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IfQ57EeV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nlEjCoQx"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C54EEC048E;
	Tue,  2 Dec 2025 13:47:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 02 Dec 2025 13:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764701279;
	 x=1764787679; bh=3fOA8FKAwdvG8udlN/LR01D7fdn2g6vd+QtBe4dw2Qw=; b=
	IfQ57EeVoJmyIYKZhLx+lB6p+VRc5zBQOvFlqJBd5xsBD962CrNdwq/4EJG2XXrc
	aHBduHO+YWU0qLM12zmW0M3ER7jWzYWl/m+QPrXlIpFDHVqdM2yNMdo0sLt0CtMo
	UALvw5ad4FPwtuD4NuyzMTld6ax+mLx4hbMUTlCWGcBfuzQqWOcTZWOm8Mo3SbdH
	pD0f9/+I7g9QpBZiUbXSQd/kvZ3a/YdhUmNjvtG88QJyiuvmbnOFa9s5rqyUcKan
	NYVMRJibvf1tyfmTzC8PwrykVMd9v5NzRc/avGSYOtW4hD7IPoNImUwL+8q+ELu6
	CklVfeCrLYiPpjscxzF5DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764701279; x=
	1764787679; bh=3fOA8FKAwdvG8udlN/LR01D7fdn2g6vd+QtBe4dw2Qw=; b=n
	lEjCoQxci30bOdwjB5tJv9pjUw4VhgrZZLRVM9OdsaPF7DILtU559MzVs9plToZb
	PDxoCWmeH3dbet443sCj2Ej56aTddL9Xlp+5BKrq2pP1yN/oUr+Rm4jzAMR7Bw9E
	z5gKbus38BNfth/I6LfvJIZqeZN2jDJ2yMRe17C5/pzxhk599hl0c3BnBh+nBh5P
	GLMS1EYV88Mne82yJlooLuXSAD2c2NejqAbYpcbvn790cEtFAmXF/X3EeM0Ko4oP
	Ovbh0ospibL0IqKADCUCkLAKr7VRBKTBQqru7FPhRlQTdbbp1GdHs9T7w2Hu00Vi
	rTRsonhTs+3wkGi32Fm8A==
X-ME-Sender: <xms:XzQvae8qSjApYBGrqwwb_5GR_zntFQErTNnLoZ5dxk6QiwN4OCMR2w>
    <xme:XzQvaRTiLjvdQPjLatXB0Q76KMpC2_jwqB8YBWZT-xFbBYCrnVPq8dQ_DVI28KQcm
    IMKJry9Fa8d6yYGHm_OxCDqf5aPDlQfWLTUOxtFq_SzYKUrT79r_g>
X-ME-Received: <xmr:XzQvaXoPopuup6aFoNmD3g7PMGAWueBvShy5-kE3Hgq4R9aMk09gS8PcQgLd-3g1nogA8x0ebwjmIIIhP0IfIi-Iy0ZuTLTP1ITVtH7ca1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvd
    efjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:XzQvaWno7PudYJ_kv31LNDS8N-20PTAiJsQW5ozpRhi4GY_wzgrgEg>
    <xmx:XzQvaYd6-ex9rDWmhERXsl0rNSuC8Jlew71rvagJH9vYUjszKi9K-Q>
    <xmx:XzQvaaorZCIcuU3O3Pmg3gkrGJn09zeJRBTSGE4eOjxIe7Ze_a6aHA>
    <xmx:XzQvaaNPoBnIU4ZFtBoJx9JFPhG4rNxV5IaWN0qdS85fVRyhzmpcUw>
    <xmx:XzQvacKrFWlZwrIKDaMP8SJ5-u7UP7yQkkLNJHY54JyxCiproi8xczNP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 13:47:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 416af0ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 18:47:55 +0000 (UTC)
Date: Tue, 2 Dec 2025 19:47:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 03/11] replay: stop using `the_repository`
Message-ID: <aS8zvg1WquqJiC4H@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-3-407dd3f57ad3@pks.im>
 <CABPp-BH7E1Bh2g0vR3T4NEsv34DvFQPzMuJSsqtOAaWY-fFCxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BH7E1Bh2g0vR3T4NEsv34DvFQPzMuJSsqtOAaWY-fFCxg@mail.gmail.com>

On Wed, Nov 19, 2025 at 11:01:29PM -0800, Elijah Newren wrote:
> On Mon, Oct 27, 2025 at 4:34 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > In `create_commit()` we're using `the_repository` even though we already
> > have a repository passed to use as an argument. Fix this.
> 
> I feel like I've fixed this multiple times, but it keeps coming back.
> In fact, I have this same fix locally in my replay-edit work.  Thanks
> for fixing it.
> 
> >
> > Note that we still cannot get rid of `USE_THE_REPOSITORY_VARIABLE`. This
> > is because we use `DEFAULT_ABBREV and `get_commit_output_encoding()`,
> > both of which are stored as global variables that can be modified via
> > the Git configuration.
> 
> Indeed.
> 
> Going on a tangent for a second...I feel like I've had to remove
> "the_repository" from builtin/replay.c multiple times.  In my local
> replay-edit work, I actually added a "#define the_repository
> DO_NOT_USE_THE_REPOSITORY" in builtin/replay.c, after all the header
> includes, because the_repository isn't what builtin/replay.c is using,
> it's these other two things that are also only included if
> USE_THE_REPOSITORY_VARIABALE is defined.  That obviously doesn't need
> to be part of your series, but what would you think if I were to
> submit that?  Is it too ugly/weird of a way to avoid the_repository
> being added back to builtin/replay.c so we can stop having to remove
> it again?

It does feel somewhat ugly, and the better solution would of course be
to refactor both `DEFAULT_ABBREV` and `get_commit_output_encoding()` to
accept a repository as input. But if I remember correctly that was a
nontrivial endeavour, so your proposed hack might be the next-best
solution.

Patrick
