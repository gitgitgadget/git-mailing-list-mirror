Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5841B4F38
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296301; cv=none; b=m85CRSwIm2jJGGRauEAO6E2cLkHnOHuXS3QaXWBEvGdZz8tPZwh9/+a9BLq3XecvwsHdekNxoOFSqhGENjQxC4csnl71pxceoHMHamHqnAzKBg5Z2nh/5/ECV6WvNcNzPVf1RieBCRESKlhcAe9DK4rOfVqORjBiokV0tS/O2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296301; c=relaxed/simple;
	bh=YDiwBNU24UBZSE/CGVlamg4aggM0mwMkfD/8ZqzbhXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBSCCkft33dUv6DRoZOfxlGDgUNH2+dkhV28bRNfQbyXRup5fm9gWanOn5LO7/fEAKanH6f5CVtGTwj7ynee7Lk1hZcNaMHziP4qqA2d4kq9vNx1pX4VSfF5acNZ/0cU8qqw5hy9/K17ASXkkNP8jxfwuHgbhR74qldgS5UJPl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CjYrQMRB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CkYIpWuI; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CjYrQMRB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CkYIpWuI"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CCCE11400DD;
	Mon,  7 Oct 2024 06:18:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 07 Oct 2024 06:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728296299;
	 x=1728382699; bh=PGf2mxM5y8Hcc+V5RaoUclbQXsGaUrsTDFOIYGVHHoM=; b=
	CjYrQMRBiEqxgvNYUjC+tMwFupIgNo+FUBDvqP6d2mvP/KwYtS/2bEcB6lp6Hbe9
	W/OhXgXlC3uZSX9wvVBIoTOs7aP73ynI0/Mu06IOBeDOjQlp8VU6AeXYBKdMiTO+
	lZT+ELi4nw1HweVGVNQgsfvvp0IlCXATv6rfQ8asCt2HS/QMKPp0m29Bbvsasy7E
	Z49PMsODpex2yVjMG1AXihdivFMjEe7eWRTJA2TupYPmvXasuV/yW+oI9a+c/NDq
	fdeZdKaEIDhHtPwqnMrapSXyJU/Uukmuc49mlcyxulGR498IA+XV+g3kC7ep3LJ3
	tiQ9AkyodjkN5si6M1Pf6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728296299; x=
	1728382699; bh=PGf2mxM5y8Hcc+V5RaoUclbQXsGaUrsTDFOIYGVHHoM=; b=C
	kYIpWuIjpcIu3+Rp+rdSRD6wPam4MnN8XQDG/uNYQ9/ieiU8yT71GhEV57QedrGP
	qF1RSTg4Sb+GpGiASb+mdX3FzOP0+2K1DgtuRiYsgRxiB+Hh9suAZSYNkklVG2J4
	AyYl6iG2qJFQ/ButR3IOLsLY2phYcVKiqYUbHdreqvcYHKrbA5Nbd/kAT6nsyUQb
	AkZZaH+Ptva+DJfRglHIzBaCmlB2Kja867FT1YYIx64zboYNUdZq6iWHNLO+tXlv
	7zFSLWAJKv5PFgG3mRQlsTRwpNyLqvCro6Q7l2XtUXb/NxKzkfMJvojnwUZdOL2E
	ShJoGDL3vrqPU+5f9tHRQ==
X-ME-Sender: <xms:arUDZzFCHSvKFlH23QOMd6W93ksRrYu2YDUn_gClpAeZ0SSCVxQ-bA>
    <xme:arUDZwVRD3DKcKlcRhXFfz8w_pxWHVAnXZWhMUjA0fcuMdZTbcbtVEN2Aua2VhzPb
    nGALB3zp_4OD5Ui0Q>
X-ME-Received: <xmr:arUDZ1JVTHfU8rjiw_Kn6cJYI8TQwhzcwhrhY0bZ9BugK2Ve5N06WzqZ8S8IBfnkQuRRceyaOvhe2PEmGVC1wSxrSx2aKnKkEO3bMXF-S7_eaTpeWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:arUDZxFso2gwrJ11FHcTDYYxc24KqkopinR6Z5jFRAwILAA9q7ifXw>
    <xmx:arUDZ5UNnPoPlBcAKl52bK26aoDbr6ImJ_FZlp0pULJaf3aZnkTlpA>
    <xmx:arUDZ8NC6CQQiwK6yhGOWQPA2TfVzy-mvN3c3sgolYA4BVzlSqhneA>
    <xmx:arUDZ40wQXtn3dY5c10udwv9hW9LJ7mrRts3UBlKWB-hU_-O4yq2sA>
    <xmx:a7UDZ8QdP6z2j38DX3s2WHKfXkK2yoG8CCvdeLGsh38g6yUBe9tebzQ3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 06:18:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e5a38ed2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 10:17:19 +0000 (UTC)
Date: Mon, 7 Oct 2024 12:18:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [RFC PATCH 05/21] t3404: work around platform-specific behaviour
 on macOS 10.15
Message-ID: <ZwO1Z1jDOT6r5doT@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <00fd829833cae1d192d6c42237aa13427156e3ea.1727881164.git.ps@pks.im>
 <CAPig+cSqeKJX99jbxouJZHdGZuyAgNz-wOgt+0C5OPvW3MHgLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSqeKJX99jbxouJZHdGZuyAgNz-wOgt+0C5OPvW3MHgLw@mail.gmail.com>

On Wed, Oct 02, 2024 at 05:43:45PM -0400, Eric Sunshine wrote:
> On Wed, Oct 2, 2024 at 11:17 AM Patrick Steinhardt <ps@pks.im> wrote:
> > Two of our tests in t3404 use indented HERE docs where leading tabs on
> > some of the lines are actually relevant. The tabs do get removed though,
> > and we try to fix this up by using sed(1) to replace leading tabs in the
> > actual output, as well. But on macOS 10.15 this doesn't work as expected
> > and we somehow keep the tabs around in the actual output.
> 
> I presume this nebulous explanation is due to the fact that the reason
> why macOS 10.15 exhibits this anomalous behavior is not yet known?

Yeah, I didn't thoroughly investigate this one but just wanted to have
it fixed. I was hitting so many platform-dependent issues left and right
that at some point I started to feel a bit tired.

> > Work around this issue by retaining the tabs.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> > @@ -1917,18 +1917,17 @@ test_expect_success '--update-refs updates refs correctly' '
> > -       cat >expect <<-\EOF &&
> > -       Successfully rebased and updated refs/heads/update-refs.
> > -       Updated the following refs with --update-refs:
> > -               refs/heads/first
> > -               refs/heads/no-conflict-branch
> > -               refs/heads/second
> > -               refs/heads/third
> > -       EOF
> > +       cat >expect <<\EOF &&
> > +Successfully rebased and updated refs/heads/update-refs.
> > +Updated the following refs with --update-refs:
> > +       refs/heads/first
> > +       refs/heads/no-conflict-branch
> > +       refs/heads/second
> > +       refs/heads/third
> > +EOF
> 
> Although this works, the problem with this change (and its sibling
> later in the patch) is that someday someone is going to come along
> (say, for instance, a GSoC applicant doing a microproject) who submits
> a patch to (re-)"modernize" this test by using `<<-` to (re-)indent
> the heredoc body. A better approach would probably be to retain `<<-`
> and use q_to_tab():
> 
>     q_to_tab >expect <<-\EOF &&
>     Qrefs/heads/first
>     Q...
>     Qrefs/heads/third
>     EOF

Cute! Didn't know we even had this helper.

Patrick
