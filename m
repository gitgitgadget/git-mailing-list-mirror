Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423FD29405
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711506; cv=none; b=ia0TEv5XO+JI5FH8pxEvRNazUP5c8p2zJ3IPNKyexZrHRiUwfuLQRXUiXX6u0DKScBQEKtVa16BfzF77TKB9yY8Djo4BObRapLx7wRLin3SqtiZc+F0VcW/qjNR/KJ+KajkttXQFWwAKUUrx0UYOQzXUvg7pQTjUNs5fAx9DdlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711506; c=relaxed/simple;
	bh=kSFWNSvytbY3zkNB1w6KqqyiHl4K6+iKixrFiI0j0rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oatwIIS3NrD0qUWkKYtea2Ru0qav476su5X3rcR+eArmuXq771aopAxMGPLHcbQGa+CTXO5Ge0CGQ2jO2JAVG/h1WK2zWuAJczO/bVjDuCE9/UDjvuxRw3Cog4KCSLIlvZRtRxfjBMuApJ9Dv0SRuekbjLpcQhqcF/a3oJa2SRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cNbHjJIs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4C67brHE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cNbHjJIs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4C67brHE"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 48BA1138022C;
	Fri, 20 Dec 2024 11:18:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 20 Dec 2024 11:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734711503; x=1734797903; bh=RgdSq/7Tso
	G8vz0WATi8x4wmOd3C0fVZBicfH2jMoU4=; b=cNbHjJIsDF14Vj6r+Q+f/tY9Gv
	bLaeVGWlngAE4PKzV7Wg04m14MqCvcvWbs7Z2XsykzNDWrgIFp2mDrAVP/JKaKvH
	amzXLLVlEDr/Yp8G4k30rYlhzOLTsWY6uR+hPBI/Y5aEJFTuoo6YZYUXkIyCRA2l
	NnUsYO/fJD+x6IliS9IBGaUgjG2wK3ZlyR1a027SlM/OFYVwWqQ8jo8yH6q7EVs6
	egnv2Kd7BVrqEWYAPvZDRtrpUUd2cnW04F8yRBZn2IwxFQj2ejyQQKCN6I6BM6Od
	QIQlVbL6ABZtI3wvpGKcztX2oacNeiJUBz5D9QQ6Q33ViXit//3lpeHVNy3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734711503; x=1734797903; bh=RgdSq/7TsoG8vz0WATi8x4wmOd3C0fVZBic
	fH2jMoU4=; b=4C67brHE62MWIEf1JvB8WawUf4ZY+MWp3yThn8uxI2UyS2HyASi
	X4FKEwBNgM8A2cQ0x+D9/8knEakBK8RodX8Aaj/shNVSeMTxpZ3WS7eFwS+VMj/A
	j+8UB/sywa8Xn6sE2Yur+sAGN9EYUp0h/jWJ/Rvlgz51GDLHWhpw2qQGMyQDi9C8
	qDm+HucuuiFWzkLndB+sSUSbLXR5rdx/KXeWCVmOx2nd5J9i7HyNHDZ3RFnjdHzU
	o7rBLKbs8debhZ+32A26AAIWDGH9E/MdzRcdYcyDPqlgNo34fqZ23MJQCBdTHuEz
	kTB4If7jKzN5zMwCwy3CfBhd5ut+TXqQjfA==
X-ME-Sender: <xms:z5hlZyrFwfyUq5KXwwXfNvCBdr7bxmHeQZVQN6GWgjhECAXIK_qcHg>
    <xme:z5hlZwrLUiz1Yiz3YdksemFDw58OPMBnYQxuiu3mUnaeZ2u09kVyJ-r7hKs8TyYxo
    RiYzs-AIxyk0SRZxQ>
X-ME-Received: <xmr:z5hlZ3PHQxK2Nmj28HFBEGHxJQ4Wkol-oCjo4v3s16yzszfOvhBFzqYlwzCzC8LnsHUDLktxKQ9GFymYUJJKNtckvVb5b25kJBGPe5Ei1Khuyxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:z5hlZx6q9IgdCZoypt6vSnWxzY6YN6a2WXtR62PH_WNxcfiVR3jR5w>
    <xmx:z5hlZx4n7zTT_DoJGtbr-5CMWy0b7DbAV1LJwj85uEkuYo08JTbyjg>
    <xmx:z5hlZxg4h_vm87bBC97MFjfhnjOG_xo8ImW8b2vv68-St-zunq1WwA>
    <xmx:z5hlZ74Dto2NSiYtg-d9FZrCgfDhozpNNUzGOOQzU1oPzF154oyAkg>
    <xmx:z5hlZ00MMTK097pxYd-T93G1RW8_5SFvb1LwuZKbGRMpQ2n7qBqY8MaG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 11:18:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 84a7f12e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 16:16:26 +0000 (UTC)
Date: Fri, 20 Dec 2024 17:16:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 1/5] GIT-VERSION-GEN: fix overriding version via
 environment
Message-ID: <Z2WYajwW-Isxmzwz@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
 <20241220-b4-pks-git-version-via-environment-v2-1-f1457a5e8c38@pks.im>
 <20241220155223.GA152570@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220155223.GA152570@coredump.intra.peff.net>

On Fri, Dec 20, 2024 at 10:52:23AM -0500, Jeff King wrote:
> On Fri, Dec 20, 2024 at 01:22:45PM +0100, Patrick Steinhardt wrote:
> 
> > diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> > index de0e63bdfbac263884e2ea328cc2ef11ace7a238..27f9d6a81f77248c652649ae21d0ec51b8f2d247 100755
> > --- a/GIT-VERSION-GEN
> > +++ b/GIT-VERSION-GEN
> > @@ -29,7 +29,10 @@ export GIT_CEILING_DIRECTORIES
> >  
> >  # First see if there is a version file (included in release tarballs),
> >  # then try git-describe, then default.
> > -if test -f "$SOURCE_DIR"/version
> > +if test -n "$GIT_VERSION"
> > +then
> > +    VN="$GIT_VERSION"
> > +elif test -f "$SOURCE_DIR"/version
> 
> Hmm. If $GIT_VERSION is set, then we set $VN here...
> 
> > -GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
> > +# Only strip leading `v` in case we have derived VN manually. Otherwise we
> > +# retain whatever the user has set in their environment.
> > +if test -z "$GIT_VERSION"
> > +then
> > +    GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
> > +fi
> 
> ...but later we ignore $VN completely.
> 
> So it would work equally well with the first hunk dropped completely.
> However, having an entry in the cascading if/else does mean that we
> short-circuit the effort to run git-describe, etc.
> 
> I don't think the old code ever did that (we'd generate the Makefile
> snippet in GIT-VERSION-FILE, read it back, and then make would still
> override the value from the snippet).
> 
> So I dunno. I like keeping things simple, but I also like skipping
> unnecessary code, too. Maybe if the top hunk were:
> 
>   if test -n "$GIT_VERSION"
>   then
>     : do nothing, we will use this value verbatim
>   elif ...
> 
> that would make the intended flow more obvious.
> 
> There are probably other ways to structure it, too. The whole $VN thing
> could be inside the:
> 
>   if test -z "$GIT_VERSION"
> 
> block. Or alternatively, if each block of the if/else just ran expr and
> set $GIT_VERSION itself (perhaps with a one-liner helper function) then
> we wouldn't need $VN at all.
> 
> I don't know how much trouble it's worth to refactor all this. Mostly I
> was just surprised to see the first hunk at all in this version.

I think wrapping it all in `if test -z "$GIT_VERSION"` would be best. I
was thinking about whether to do that refactoring, but I shied away from
it due to the required reindentation. But I agree that the end result is
a bit on the awkward side.

You know, let me send another iteration where I just do it, now that
we're two having the same thought.

Patrick
