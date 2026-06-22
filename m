Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D831346ACD
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 04:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782103355; cv=none; b=srCa+L2lkxGGZT+q9pc/eXxI6VDzqb0gMxpDd2tNNwBPGtpMGYoUezhPpBnUXZgFzHstC6nvyKu6MTuEb8yY9xEMKXfQh0XdAVanWQJpbrWwmabNtd9x6ezylMNsDXGK1g8ytXaRAyWxvNXJocJW7y/5EBk3Tow7ZrFnpMLyDwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782103355; c=relaxed/simple;
	bh=oRGI5IpQC0jnc4XuybrRibwOMvYT63eb7C3BzZPY+MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drIjKr1G5YsyyaHm3jGcL3quHQ/Bv06Ukq8IODXbfhfPMdJO3TaK9768ZbLNJlezsoKzaZGOIbOD5Sdy1wpbzzcspvyLmNIMUZRG3qdn6vObi+pjvmAuIbTv/quohtXRR2qIVzAf6T54fvBerp267JU9FYxkW2Z4whwkQaU1+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tYftC+4Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TbzMM2QK; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tYftC+4Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TbzMM2QK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B10031D0005B;
	Mon, 22 Jun 2026 00:42:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 22 Jun 2026 00:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782103352; x=1782189752; bh=BcsyP2Tlvs
	5Znv19F2tBAJgEdLrakVi+jrb5YireKgo=; b=tYftC+4ZPtbxGBbPuliHH0ln1K
	bEzinKsdjrxPQTdyn7BEuJdvT4lcUS8CqGVAxCKBww72aWF9/oRbChLxq9n8QhBp
	DIUs1xWCUgK9bMmzVKr80SWxUXzm54JKw0PrAFEsSTn0QBoF6wXh/O2UOzS7cVZn
	LLNXjJ/DCAIrCxpP6C5IqK1WBp84eo0MHZmwsSFsgzWYvFuhIKZShXkAOl/Y7QYe
	dqEYDywYDYcBSPGfXd3sJR2hYyKmXJyKgPdGy7nNe/jz9thTW1HzkmRhtiHNP3gL
	VZYn3a+4GTv8CBm1D8hST8aMG9k8ZIpkKSLwjqXMBi6HNHMQxBSz4sbY21dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782103352; x=1782189752; bh=BcsyP2Tlvs5Znv19F2tBAJgEdLrakVi+jrb
	5YireKgo=; b=TbzMM2QK79rEovdLkirpNQLxveQ/3u0akxKDvIdvQuwy5kNG1lO
	1ZHt70r21KA3GA7vOU1d51N2GZrQ7em5mRSJyPg2cDENYoxgce7b2m/QqQWqPdUz
	Jl1RMnPiNx+kFKtVWH3oIkXD8/eVjE3mE0ioSnSfQMFLsQgKcdXNcQN9vGNuDlLH
	2cSiXQBqC5mpa/kY6gw3lmHqpFY6Sw6RCUjtSAuDoUZ3dUsNwUcv8z3Tp2zbR0Nq
	IT4yVx844c9oeX4zVFqw7rSDEcTh89Do3PHOj5mVR0JIA5kQuZnpN2pyAYyZZJNH
	GYDruSss6MLt0gsZZJEwX2manumtNM3sKQw==
X-ME-Sender: <xms:OL04aiELIaxhjULHO2nna0kqxYFlUuyngrxdWIweIXep3KbtobJJYQ>
    <xme:OL04aqUjrD0spkuIQ2cyrLXFl-icVCEWWKJjpSnIvzwsWv7Q89m30yyuWmTmSEbGI
    oE6oMUe_8h1FtQgsAnqT3jErmigjN3PcIkMlXPRKwcDEnCrq3NUqBU>
X-ME-Received: <xmr:OL04ahJ5V0qpAeMEDXw4p74V8Pti-z0Ir-joDQIajkzXuNMV9zP85vyM-bckcjm62kwyailSP-QiziSqgRhkNy3-ClBCdEzx2t023MDG5A>
X-ME-Proxy-Cause: dmFkZTGM1Kf6cbVPuNw88+bBS8plTp2iNc7wWY0WcfgDp2MMJLc85vE2cDKVXPEZ8rDdsE
    2rpPkcV3PY5qBjcMJx5TeTdzpDtah+MK686ZoBSHCYKrGIU5PpsKV0iaeb8hgAeuTMwvPf
    xQzT0O3ctT6OKJYl89JZwDF5VP2cBSegc+r1jl8oOa0GkwOsuq++zwBrG0Kfm6+VvNULAv
    powuzap0SXA6yUX8PbXcuEWHE+UGfnPG7pIKxSgoxOD7SBU5uO2BkjSWeJy0renxAvlYj0
    MGv0xi7w9TAkuEsp32UUJh5+1LARB8WVmuz2D6xZ7praPjU5+IHzQfl3Yh0eZrIqsvNjMh
    tC2JIN7iPdCa2G/dswjGoDTUqroISbz4z5zmMTmBD4kFUT7xQ6FhGxs9MQ2BPvPfFvfgJt
    ULC9YoAhCKevIUF1yFs4vejh3wznfmNL8F9CFEfkCKRlJbIMt8d0T6GbsXMO6tOTW/mhQv
    YdX4HRAIaU4QiV42l1nbJYIgCZdUDfsLp7UIwPd7xkxfgK0Wm1l1UAMCDI7lLiNBLPyrn1
    UTs8Ra1M0BnQ8U37Te3E8NF7iOt/GSW/Si6wLaatYGe/OBAKqaoFz9c2cwkJnsp3oZo/SH
    3+NOx78Sm5UUBGX2AXlKcwAtN99i8UgVzvjtnA5F1eWEI1wmSg3uDOiZbiGw
X-ME-Proxy: <xmx:OL04aq_GvE_Y-QlKTKecXnxWxigCrb9LMWMSxFC27OqrP3LFkkCzLA>
    <xmx:OL04akIIdybLsDaesv9kQJYCNdW61ieM0tAXiUDSdsAzjoFQzc2mYQ>
    <xmx:OL04avkdiHl1ZDnIK9b_WQaA_6O8EocXd8WtMTyhtsVUtDLG35Mrzg>
    <xmx:OL04aoOMWSGRRpyXVzk3l5ARfa81rJnGrz7MvdceY0k36m3eASo9Gw>
    <xmx:OL04ahELljXVNCHD8CZUk3JsdStZfd-3Q6qKCyQ0AMtw0tf9xDAJrtpk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 00:42:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b251463a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 04:42:28 +0000 (UTC)
Date: Mon, 22 Jun 2026 06:42:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] Why do osx CI jobs so unreliable?
Message-ID: <aji9MOE-NTHKXYqn@pks.im>
References: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>
 <20260621213407.GC2297179@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621213407.GC2297179@coredump.intra.peff.net>

On Sun, Jun 21, 2026 at 05:34:07PM -0400, Jeff King wrote:
> On Sat, Jun 20, 2026 at 08:33:13AM -0700, Michael Montalbo wrote:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> > > So I strongly suspect that it most be one of the t555* tests.
> > > [...]
> > > Maybe this is something that's specific to GitHub's environment...
> > 
> > I think you're right it's t5551/t5559. The runs Junio linked:
> > 
> >   osx-clang     cancelled  360min
> >   osx-gcc       cancelled  360min
> >   osx-reftable  success     35min
> >   osx-meson     success     61min
> > 
> > All four run the same t5551/t5559 under EXPENSIVE. The two that
> > finished differ in just two ways, which look like the levers:
> > osx-reftable generates the 100k-ref advertisement in ~24ms vs ~1.2s
> > for loose refs on macOS (so much less time mid-response), and
> > osx-meson runs tests at nproc while the prove jobs hardcode --jobs=10
> > on a 3-core runner (over recent master/next the prove jobs hang ~40%,
> > meson ~10%).
> 
> If the problem is a racy deadlock, there is a reasonable chance that
> some jobs may simply be lucky. Even if things like packing refs help, I
> suspect the problem may still be lurking. Maybe I'm just a pessimist,
> though. ;)

I had the same thought.

> > When it is wedged the whole chain sits at 0% CPU. upload-pack is
> > blocked in write() on the ls-refs advertisement, curl blocked in
> > select(). So it looks like an HTTP/2 flow-control stall on the
> > response side. The same stall resets itself after ~60-85s on my Linux
> > box and on a bare-metal Mac, but not on the GitHub runner; I haven't
> > pinned down why yet.
> 
> We had some HTTP/2 stalls/deadlocks in the past, and they were dependent
> on libcurl and apache (actually h2_mod) versions. IIRC some of the
> non-TLS code paths for HTTP/2 were not well tested, which led to
> 8f2146dbf1 (t5559: make SSL/TLS the default, 2023-02-23). Of course
> after that commit those cleartext code paths should not be a problem, so
> that is probably not exactly the issue now.
> 
> But it might be worth checking the versions you're running locally
> versus what's in the GitHub runner.

I didn't observe any similar hangs in GitLab's CI systems, so I wonder
whether this is because of different versions of curl. And indeed we use
different versions:

  - On GitHub we use 8.6.0.

  - On GitLab we use 8.7.1.

Now this of course doesn't mean that updating the curl version is the
fix to this whole issue, as there's a ton of other factors that could
play a role in whether or not the test hangs. So while we could just
upgrade parts of the stack and cross our fingers, but that feels rather
unsatisfactory. Still, one place to start could be to update our build
images to macOS 15.

But the big question to me is whether the hang is because of a bug in
Git with how we drive curl, a bug in curl itself, or a bug in Apache.

Patrick
