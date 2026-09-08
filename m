Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BD537E5C8
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846621; cv=none; b=QhyDCbZhqydfcZDq1DpjlFDG65d9zKSd7IOpVywMhf+Wp6VoRHsD7IAHhiURK+pbG2eKod/d1RVmVfYuZ+XJ9/ns+ZDDkNNkTg292A5RuXCIk6pzbjz5S/AFmm9aPCBrn81MFFf/j/M6Wmcpb2czW1iuUsBmD5M5voGHofCi6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846621; c=relaxed/simple;
	bh=missBVeu7TLdJleubb6MTDrNNSZ3pSr7XWvQAaksfJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnriThqjh66rxNr/YUfioeJnfEWqV8/FYTsjWkvbThDcq4KcqvxAlLg8U051ybmzBCR41nhu0/iJ9ny+SsoH0pFZa60NP7WTu5ELXRPO/UzqaqHGp3ysRbafnSjPiPt0x5jyJQkiEZ/3KjP325Cv2hq7ZHHsT81lqPxqk/QxiXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c3cJg/cb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ULglg2i2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c3cJg/cb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ULglg2i2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 05174EC00C9;
	Tue,  8 Sep 2026 01:50:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 08 Sep 2026 01:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788846618; x=1788933018; bh=IGRK9bdC9i
	4p1vMZhDAAB6vBqBcdAE55GmjDYCxPUVk=; b=c3cJg/cb2CoibuiIUpMh7PMxJH
	yCwac2BFJ9eHnzh6B2EdVUPNBTxdIR9yZc2/lFqYqxHfWMitMuNuOopxPDWWfoES
	k6tq6E6v87NFDp/zr8mj7EDfDPa+HNXOrowU1a613lH5JjdUOjk5wrnsbmbKoFOs
	7Uu1gG2D/nnx9I6jyHHRBO0jmWKGUleV1cj7hHMuo7ths4wfTI7GtUKNR6x8q5Xx
	lpQEToTq0TVe7M3rZhS7KqueBwj2b5lIdcWO88YocpmDN3Oif69WKy3/uLn7V7+a
	6UdhkMc5p0K8poqw/CX3se1u1AztNgUi17ac24bkoZznXnXDIO5D6uxtRvkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788846618; x=1788933018; bh=IGRK9bdC9i4p1vMZhDAAB6vBqBcdAE55Gmj
	DYCxPUVk=; b=ULglg2i2k85lYd0s/x0EnpxdLv2gFyq9ylyg1a3j/8uME5Rt1Wu
	rXVNRlcbo0wcPcSfAvb8+qWuAXh1PacRHF2d6G7raQZn6D0JhoSHbQwRDWYVcXwU
	BN5gjt/FNrVq9T8LikjYdm7qqZzKPpqtHxd0oL7wii9JB5vXuj0uUl0H7xitrooH
	aaq1gCUqoU6dVBx2J+a9eUcQnOr2t0IM1eDZBtlQ2Dt2asS3e1ab2HQMy8T+cAz7
	pBceKVJcHti6ICdy2wdnxtk/eOvLcX2zZ+msEez8MJwt/RqH7coaVXwSE71b4Li5
	pqSSxT7Auvmia75ymJQS99QDY3mT/Bf9QiA==
X-ME-Sender: <xms:GaKfaojN7f6K3v7zB-XDvx9Hr1FG-pOPh6hGB0xPUI2YRIyBucbUEQ>
    <xme:GaKfaijd6SCniu_BKheMlV1W_58yRa7CUB2wRYH3yYTbYWT5AF8X6dyx5KtRWvW0E
    Xf40Hak9QMkbM06FbiEnt8uUeEybSaQ4se6o1Q3BaTxpL00ZYxpRg>
X-ME-Received: <xmr:GaKfagLXOub58JWZhZjZgSIdDGBEO5Ju9paynz6e1BiKL3SXdj-7ODDa4IKbHDLbWETFPAg>
X-ME-Proxy-Cause: dmFkZTFXHIwx/okMKAc3hZIrQiAlOgoCPdyIphISJY+a5vHFee2rG9KUlGb5ZvGAWSuAVC
    e28cy0bIrCD/VbWCdbIyCQLhyYtu/HyHYdU00fFDDjMwycR1tIaqFLBXgkRi5p+xwhTg0W
    Tq2fuq7wg7vd/AAsjkhxL+vlEnhM5zIt0+d673Pf/DsD3mmQoHNaphGg1ltXuqdBl/y2Aw
    PxyxoRXyOPCpN3Y6u2E6TpKFDdr0cZ6E29BJyId+rt4ok/BStbC1vdNJJ/0A2/6S61dgcx
    4L/5rGg23pTj8IbB2u1ww73uaGRTCyXTWq1g9yXXL787MrlKP/Lj0ylKhA83mlul66Tjq3
    +JaKpZOcKXJeit6yB9yKrKUJvzXeKT78OH84RoHM+MQklQxVi68VgINf9cHi3LtdfVogWE
    IIW69kjDvV3pXFNr4h1wGJd667JVlCckgo0KzPY3UWEgFa2V4xZWLWwIHe4x6uLZKTmX4F
    umWinNbP8pzQ8EPNraiwMvFRYrnfNcmYamVqAoKgl9TjcEPLBLNRayOweFjAd62x2JhF8x
    0O63l9gYM4vSoaGdyVzAbbQ8z1j/FbRwMj1EpxpUBdR+Ji3bp7WqNoG95fPsLtkkOg6HOU
    zmA4nq87lBPaiQg6F+Ls8PLsfvN8tTEKbfCBS+ns+Wd3QLUfhRBWXvtvrbZw
X-ME-Proxy: <xmx:GaKfapGxDdrqtDOqpsktIvzmqG4NN7T3utqf-OynGOwt9qmh6CNcsQ>
    <xmx:GaKfasQoQuumm-5dxFzCLKyXxBBVIEm76P4cSwxvXSiUnYEGQ8KaUw>
    <xmx:GaKfate07B97IwOSvPSLotWcEoU-A3_apjfsUqc3zGvsGC8xbhKVwg>
    <xmx:GaKfajqEObO_gEu85O_Fl82D1IY831uZE8C7rsF21Qu2LcU12MfiDg>
    <xmx:GqKfahiodr-GrIfMNOW41YKFZwKPtfUxzrHOLbvXvlG8DCDDIjcMnHvX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 01:50:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f915cb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Sep 2026 05:50:13 +0000 (UTC)
Date: Tue, 8 Sep 2026 07:50:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem <mail@thomasbachem.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, gitster@pobox.com,
	johannes.schindelin@gmx.de
Subject: Re: [PATCH v2 2/3] sequencer: run auto maintenance once a sequence
 is done
Message-ID: <ap-iEoeY7XKjeZgL@pks.im>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
 <baab8d4876441ea883044c34bb5584631e30e1ec.1788537086.git.gitgitgadget@gmail.com>
 <ap5yVFNEFm2vdP1B@pks.im>
 <CAA0xjtqy3jOPWAGL9Cr0B+VnHAkZF0=cVCxKNqMiVJpfbdpomA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA0xjtqy3jOPWAGL9Cr0B+VnHAkZF0=cVCxKNqMiVJpfbdpomA@mail.gmail.com>

On Mon, Sep 07, 2026 at 06:35:20PM +0200, Thomas Bachem wrote:
> On 07/09/2026 10:14, Patrick Steinhardt wrote:
[snip]
> > It's surprisingly many sites where you add the call to
> > `run_auto_maintenance()`. My hope was that there is a single exit path
> > somewhere that is used by both the "apply" and "merge" strategy that we
> > could adapt to unify when exactly we run auto-maintenance across both
> > backends.
> 
> There is none inside the sequencer. run_specific_rebase() calls
> finish_rebase() for the apply backend only,
> "merge backend cleans up after itself" as the comment there says.
> Sequences end inside pick_commits(), and a single cherry-pick or
> revert never creates sequencer state at all and returns straight to
> builtin/revert.c. That is where the three sites come from.
> 
> I could instead do what the apply backend already does. am.c skips
> maintenance in rebasing mode and leaves it to rebase.c. If the
> sequencer leaves it to its callers the same way, run_specific_rebase()
> runs it for the merge backend too, once its state directory is gone,
> and run_sequencer() in builtin/revert.c runs it for cherry-pick and
> revert. Every entry into the merge backend returns through
> run_specific_rebase(), --continue and --skip included, so nothing is
> missed. The sequencer then never runs it, the change is in the two
> builtins only, and the rule is short: the command runs it once when it
> is done, and nothing it spawns does. Is that what you had in mind?

Maybe. The question is what kind of impact it would have on other
subsystems. I think the most important part that I'm after is that the
commit message explains design decisions like this, as it gives the
reader the required context to be able to evaluate the patch.

And please stay mindful of LLM-generated commit messages. For most of
the part they are just completely useless as they tend to ramble without
conveying any useful information. The commit message is the place where
you yourself sell the change to us, and by explaining the changes well
you demonstrate that you understand what you're sending to the mailing
list.

An LLM-generated commit message on the other side demonstrates nothing
like that. So in many cases, it's actively hurting your own mission as
people do notice that it's not generated by humans.

It's fine to use LLMs to help you with drafting the commit message. But
what we're asking is that you double or even triple check what was
generated and whether the generated message (1) makes sense and (2) is
understandable by a normal human being.

Thanks!

Patrick
