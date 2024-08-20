Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C13149005
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139560; cv=none; b=Z0frz1Am9DXn8O5TXZRa/vJaDU5OwAqJs6D995CPiHaUk5xPeKDKb5s9aL64V30cj8B36nSVAQilM/xaJnY006sJRQJJmtpoycaeNsVEkyywpSoz+l4JmKXHOZczPiM3ePYzcLoypV+I7sOAaDC/KPX4xbVYC/nCQ5vhl6dnI9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139560; c=relaxed/simple;
	bh=QaA1704pclqdLAAv4gcSs/g1XMj+punaD2vBwK3vxeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UB98hHaRsLgUrOk3mzKZVY8IshZsPRDQpE2Pl/hzvy64q3c9iFcYzA7N7bCfetgdndDmkBRkEoKflR047Tjf4YVbiySmJL3fWcOmyNiTOlpt2EWBFy22bFtZKevCuQd0+YDNakqFZMyoH+fdVwYNSZXPn/X19FcdubJds0ZG4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rxPn8fRM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jYg+d+sL; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rxPn8fRM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jYg+d+sL"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id AAABB138FF68;
	Tue, 20 Aug 2024 03:39:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 03:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724139555; x=1724225955; bh=fILJhoURBv
	FhRSeeWysoL/3sBW3OIKjix0UfpBiT3aM=; b=rxPn8fRMJ9h+KbapgEpuPzDZCO
	6B/vkibieeVUj+WkOjMtyTuoiZxv/+X0UnD1zVgbrf4SsNKQyHKNo0OFdz2lNPlY
	9116wdih2HoUKVigLffnYgM4/DZylnU4LnjaySxC07r2J9M2u1gi2BzNoepePumu
	e4jdGfYj/v89vCdnoPYXqYyZ7JYtSx3XoPAEnNje56sRw5LD4/H84O68oTFWAQEl
	Zq+wqFFufn3BkwtsvEBYiMKGghsaREK5VLBCMIWTjc2pBhysGVXsGby2vD2cbJaL
	+CSKapuDPTVv39/0q909qZappOMFfKwDxS6j7COKy857NJaxJ7EseEmns4RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724139555; x=1724225955; bh=fILJhoURBvFhRSeeWysoL/3sBW3O
	IKjix0UfpBiT3aM=; b=jYg+d+sLI/Qo32WOd4+hmZ1Ht+ej++DWz9kD8MpXWBpf
	mSSYacWP4mv+LMvRAR7iP84q96pqOIdCXJ6jRXOSvJR6BiKusY7B4uIQrYRqat1T
	TLRVN4n3Wu+M70h3a9lHWFSQKNEo5usaZcyJvsy1JeXawyighBy+VU42cJXwVSP4
	POyhFcRx/LYjE7sMna77OqtVRX7dACGy0pYycTnUm0SqAKA8kHctCxMTp5fpd2vA
	+OjKj2Qv7aG8CpGWLpXQry4r8x7QFzwM1W9v015WtVVYhVoJZshEjFIaIMrmqqNL
	YbecA6QiH6msb9ycSxctE1H1f3DHhYbt1QwtX2w3Fg==
X-ME-Sender: <xms:I0jEZgPqSTrSOEOKF4otvnFlZq28l5G97BEWs1sVjDxeCbK6kuTENg>
    <xme:I0jEZm9xcdZR6vRL2FOh9sGxoyUkRsLmGtXSVLkoJR5lv0DYjUfmAU45nuDeNoL0R
    JecgHQ0Bfw5X23RQA>
X-ME-Received: <xmr:I0jEZnRe6wWhGpIOJntJ8yG8XIv9Uv-m9KAUA9qtOYZjr6WCvgh_WTShSyk3dVtx3VDzr5tx_MazJzesQ2GiwfNWGX84HqcgSikRH1SBmpQnm81c-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduhedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:I0jEZovb5uvsW9N9lF09rtAc1WlosoV0Wj_FY9RKbx2ATk3W9qu1TQ>
    <xmx:I0jEZocg8gT2D98lW3qGKR1s4Arp0UKvORJYcrC8NgAlCcF-N7xp2g>
    <xmx:I0jEZs2_qzPyvCPdgxJIE1Kut1OPtPaZiR3jnCNknvvMLSZTWHhrow>
    <xmx:I0jEZs9pDFgeWnyIEsz-sexGCp7xwJtEXz7B5lYvvrbl-4egczFGUg>
    <xmx:I0jEZms1Zk5VIHkSVuKATa08Jx17rjASxGcEptZlgFYgamD8FIBiRQwH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 03:39:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7b29e1bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 07:38:40 +0000 (UTC)
Date: Tue, 20 Aug 2024 09:39:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/maintenance: fix loose objects task emitting
 pack hash
Message-ID: <ZsRIHS0mFZaRHFVc@tanuki>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
 <c25b5333f60a5920c1fade06532e3379c6686908.1724053639.git.ps@pks.im>
 <20240819085522.GD2955268@coredump.intra.peff.net>
 <ZsMLZ3Tlhxsg6Qdr@tanuki>
 <20240819091715.GB2958552@coredump.intra.peff.net>
 <ZsMPqEWVOSLOi39o@tanuki>
 <20240819102602.GA2961332@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819102602.GA2961332@coredump.intra.peff.net>

On Mon, Aug 19, 2024 at 06:26:02AM -0400, Jeff King wrote:
> On Mon, Aug 19, 2024 at 11:26:06AM +0200, Patrick Steinhardt wrote:
> 
> > > Am I misreading the documentation? The entry for maintenance.autoDetach
> > > on 'next' says:
> > > 
> > >   If unset, the value of `gc.autoDetach` is used as a fallback. Defaults
> > >   to true if both are unset, meaning that the maintenance process will
> > >   detach.
> > 
> > You've omitted the important part:
> > 
> > 	Many Git commands trigger automatic maintenance after they have
> > 	written data into the repository. This boolean config option
> > 	controls whether this automatic maintenance shall happen in the
> > 	foreground or whether the maintenance process shall detach and
> > 	continue to run in the background.
> > 
> > The `maintenance.autoDetach` setting only impacts auto-maintentance as
> > run via `run_auto_maintenance()`. The `--auto` flag is somewhat
> > orthogonal: it asks the git-maintenance(1) job to do nothing in case the
> > repository is already optimal.
> 
> Ah. I naively assumed that they did so by passing the "--auto" flag. But
> I see now that the caller actually checks the config and passes
> "--detach" or not.
> 
> That seems kind of unfriendly to scripted porcelains which want to
> invoke it, since they have to reimplement that logic. The idea of "git
> gc --auto" was that it provided a single API for scripts to invoke,
> including respecting the user's config. Now that "maintenance --auto"
> has taken that over, I'd have expected it to do the same.
> 
> To be clear, I don't feel all that strongly about it, but I'm not sure I
> buy the argument that it is orthogonal, or that here:
> 
> > For git-gc(1) we indeed did tie the `--auto` flag to backgrounding,
> > which is somewhat nonsensical. There are usecases where you may want to
> > pass `--auto`, but still have it run in the foreground. That's why we
> > handle this differently for git-maintenance(1), which requires you to
> > pass an explicit `--detach` flag.
> 
> we couldn't just patch "--no-detach" for cases where you want to be sure
> it is in the foreground.

We certainly could. But honestly, your scripted use case you mention
above is even more of an argument why we shouldn't do it, in my opinion.
We have long had the stance that the behaviour of plumbing tools should
_not_ be impacted by the user configuration. And detaching based on some
config to me very much sounds like the exact opposite.

Mind you, we are all quite used to `git gc --auto` detaching. But if I
were new to the project, I'd find it quite surprising that it may or may
not detach if all I want it to do is to decide for itself whether it
needs to garbage collect or not. It is much more straight forward and
way less surprising for a script writer to use `--detach` if they want
the script to detach, because now the command does what they want
without them having to worry about the user's config.

> > Also, we cannot change the behaviour of git-maintenance(1) retroactively
> > to make `--auto` detach. While it already essentially did detach for
> > git-gc(1), that was a bug. E.g. when running as part of the scheduler,
> > we'd always have detached and thus ended up with a bunch of concurrent
> > git-gc(1) processes. So even though it does make sense for the scheduler
> > to use `--auto`, it wouldn't want the process to detach.
> 
> Backwards compatibility is a more compelling argument here, if we've had
> "maintenance --auto" that didn't ever detach (though it sounds like it
> did, via gc, anyway). But yes, one kicked off from a scheduler should be
> using --no-detach, I'd think.

Yes, we did, but as mentioned it was buggy. Once the scheduler kicks
off, you'd now have N git-gc(1) processes all running in parallel to
each other. With N being large you will certainly face some issues. You
also lose the exit code, which is another issue.

But as you said, you could make the scheduler pass `--no-detach`. In
fact, the first versions of this patch series were using your approach,
where I changed `git maintenance run --auto` to detach based on the
config. But after some thought (and after seeing the negative fallout
that this had on our test suite) I decided to throw this approach away
because it just didn't feel right to me.

> Like I said, I don't feel strongly enough to work on any changes here.
> I'd hoped to never think about repository maintenance ever again. So you
> can take these as just impressions of a (relatively) clueful user seeing
> it for the first time. ;)

I certainly appreciate the discussion, thanks for chiming in! I'm still
not convinced that we should continue to couple auto-maintenance and
backgrounding to each other. In my opinion, this behaviour was a mistake
in the past and continues to surprise now, too. Making it an explicit
option feels more natural to me.

That being said, when others feel strongly about this, as well, then I'm
of course happy to adapt.

Patrick
