Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB1136354
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296279; cv=none; b=Cr0ew5ovKaZaKQ5w0PXRlI+oxJ79+YqAeB9sOfL3VgRMVPL//jCr9bMd32v/tTx8yzPmDDStabRaKg30sRk1i/F4W/lNK/A6tdbLUIwBrGLefWVty0V32Ty78HUbUBF7akwuhCIB2KjABwHTN6cK5ebrjsg+78pciNYOI1tHYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296279; c=relaxed/simple;
	bh=LyQpgx0n4CDpbrnqJq/CHRYFRMMnLuqlTjru+iC2J/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRo+6fFCsIa1HsFpwbKTZVMHxJtK3n1ghenl76hiRWKeqcTqlxwdoIQyknJj+SdOrKTAYY8fE73QaGZ/PN2lzXgEhLllG+nHxxur5GTAySdqggRd+yPIqRQKFMshTCtJNDVJkxEnOp2X4dNRTv/lod5K5RbhcebgENscv/eGWZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aSgNpiUf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hQCFL4aX; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aSgNpiUf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hQCFL4aX"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C745F25400C5;
	Mon,  7 Oct 2024 06:17:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 07 Oct 2024 06:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728296275;
	 x=1728382675; bh=S+JN7YJFsv+J0ACXyTg8bjZPpFJP1zBPWgzeCCroiSY=; b=
	aSgNpiUfOiVy6ZIpthB0VcajW4Fb/fqGRXzxR3L/k8Dmv0n+pOOGGwxURtxgLaIM
	6rko3vlnV6eYA9ZiU3QVJ7uZCJRYL9wbDmRL9WPsHBeCX5MWVZvhQadt7zas+hYF
	z/MCURXeFVVbWbTfENmGrz+ELvUJnoq7CwwdTAAK80tMBnJ/gcGZ6833lHf1doDf
	6zKEcCyNTzR0cj1xNMOdXmncLh+rc6Pe5UFte6WaLvGDNlcYGK3egqtBUq0GqRyj
	JCB0fSe+BCeD5B80y2sVm2FrImryOvGxliY1ZiAbi9u0/mxZOrahCurbNyucnqzX
	nb9qr6VE2LJKqH5Tw6G+bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728296275; x=
	1728382675; bh=S+JN7YJFsv+J0ACXyTg8bjZPpFJP1zBPWgzeCCroiSY=; b=h
	QCFL4aXubDD/3NfoCUhQDpun5kE8yU8SdlebOC2rim286M7HMwLzEqiPk0fPVsHf
	phfVGu7LUwPYqTABSf8InYcJgOWOnRtitKnq33wLHF3nxmbIRwr6PiEwRHsRHeOC
	85nXSt99yszlsn9pdpImMN/RDCbce30nkV8IAR3eCAGvbx20n7AhiUPyT14v/6QI
	OzTEaa9XgHoAoB4dBfVDstmnC6wO9FjzlvCmjUaacO8AiguFtZXHd9QH2xBhX707
	g9Q9EtF1e5/4+wXOiV1/9MIxueq1deRngW4xgpvRVnoD94t6JFW7YK71aDowAbuf
	iyiWV3jSnE5C7sK9C1crg==
X-ME-Sender: <xms:U7UDZ4U-8KORsnSd79Tp4Yb0uqijTxDf95VY9Dziyu1sH3Hcqa35aw>
    <xme:U7UDZ8k4CObNIDQ7XKu4KF30emC1Av6GBDQlILU1p5dnB9YaDSvgSDNALcsVhDh0v
    8n1SHnWyudL_VlXnw>
X-ME-Received: <xmr:U7UDZ8YbMfMiRnbjPyMW645SvcBuRyxNkO78jhg4eEJ58zXaMSkampfaqy9j6CmWPnobFmyzyhPnJ_AufM9OMC65psSAmeyBSsWUYxfl6S_Yd5Ym8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:U7UDZ3UjSD5eXQjpMUmCLEyeAKyyYpy537f1NvXmYrAg6cOblZi_xQ>
    <xmx:U7UDZyn7sbahnVxo4P3SiqzKTu5BywC5zWNTKTkUhPmmx1KLRmPmig>
    <xmx:U7UDZ8diIUrqWpWV4TUf5MY3xlLQPX6d3PkelzjPGCcaJGFVjMtBEQ>
    <xmx:U7UDZ0FqB6PE4YX9ZYmNlsPYtIIefzmO2gOZkIsPxmLr70nrmXRzEA>
    <xmx:U7UDZ0i6EhACnILo1Q_0BqkZrKyQxFGoMhmFNoBzWhMj4rEp8L49OJwo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 06:17:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5df5175 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 10:16:54 +0000 (UTC)
Date: Mon, 7 Oct 2024 12:17:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [RFC PATCH 01/21] Documentation: add comparison of build systems
Message-ID: <ZwO1SVCHym34yGe2@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <508e3783d284fd2d3bd4840907ed0bdc20bc1b23.1727881164.git.ps@pks.im>
 <CAPig+cQtxx=fQM2xHSt8AsxyWgjSiS9Kd5PtjA+jDoK5s9xh4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQtxx=fQM2xHSt8AsxyWgjSiS9Kd5PtjA+jDoK5s9xh4A@mail.gmail.com>

On Wed, Oct 02, 2024 at 04:24:10PM -0400, Eric Sunshine wrote:
> On Wed, Oct 2, 2024 at 11:16 AM Patrick Steinhardt <ps@pks.im> wrote:
> > We're contemplating whether to eventually replace our build systems with
> > a build system that is easier to use. Add a comparison of build systems
> > to our technical documentation as a baseline for discussion.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > +=== Rust support
> > +
> > +Many long-time Git contributors are nowadays in favor of adopting Rust as a
> > +second language next to C. The build system SHOULD thus support Rust such that
> > +we do not have to reopen the discussion once we decide to pick up Rust.
> 
> I've been watching the Rust discussion mostly from the sidelines, so
> it's possible that I've missed something, but I was more than a little
> surprised to see the claim that "Many long-time Git contributors [are]
> in favor of adopting Rust" since my impression of the discussions does
> not reflect that claim, nor could I find sufficient references to
> support such a strong statement. My understanding of the situation is
> rather different; I've seen both proponents and opponents. With
> regards to project regulars...

I felt that during the Git Contributor's summit the room was in favor of
adopting Rust in general. The discussion seemed to rather revolve around
_how_ we start to adopt it, not _if_ we do so. I also cannot really
remember anybody pushing back on adopting Rust.

In any case, I'm happy to tone this down a bit, as the document is not
here to make the case for Rust. I think that it is very likely that we
will eventually start to adopt Rust, and because of that I tend to think
that we should be prepared for such a future instead of having to
reevaluate our build system because it cannot handle such a potential
future.

[snip]
> * At least one well-established contributor has stated[4] that "Rust
> scares" him. (Possibly this was said somewhat in jest, but I suspect
> the feeling may be shared by more than a few long-time Git
> contributors who see Rust as an overly complex, complicated, and
> convoluted language but who haven't spoken up because they understand
> that the programming world in general is moving toward more modern
> languages such as Rust and Go.)

Well, that was me :) I _am_ scared of the learning curve of Rust, but I
also think that it puts enough on the table to be a worthwhile addition.
So it was said half-jokingly.

Patrick
