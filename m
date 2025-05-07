Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2B32144DC
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601600; cv=none; b=hS/Vi31EuVKxFjj0VT8k031p8ZidUL2XZRWq28pNnjbHf3bMfStk1hoRZVWTRHqe/T2evVlaq1d3QaCvsS1q08lZL4WMYv+74ei56/XKeMZwkRLVc1JKjx0dIIhBcYLW1InDOm6ivuTHNGkorO/SBD4LeR8DaEvVJlEbczoE7UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601600; c=relaxed/simple;
	bh=C7I4q/RxnJ+tTZVS/ijqr8YqECf2a3Z5KorDBMM/lMU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMlDm9TlqJDpuku4m5bIt0ljQCeoXjCCJgH9F176RJe856JWWHp0yGRU+yIjPobKZLchDByHuHoTBdOFSqezssXto/oOPb7NAIwg34EMk7xinpUEsnJT/AX976OAdI8Ru1qWWy1+H8VwzGOvuKZF6Dwx9RB4/fwevsNuIcUJv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AwiBUKWl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iMjiaytj; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AwiBUKWl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMjiaytj"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7548E114011E
	for <git@vger.kernel.org>; Wed,  7 May 2025 03:06:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 03:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746601598; x=1746687998; bh=+Gxxm0wFQk
	X9HZb4bAGGxqeK/m4C12t0BZMIuleclCs=; b=AwiBUKWl2axy9LGKHVqwnid1J+
	7riNjUXrArPjJ9uZK6eaR3v7zvR9hOYPAW+lYlI5yx0Lhme3Dvc4Ip8zfNM95rKk
	A45OEL1+DU+DKO0fc/WpxDZ8a7Y1wSgUq2iqiYTb8xAbBPMRSbV6T7WilDTlwztT
	prFBgCgjxm8wRHQMuOXGG0MT8F62rBP5WVaXmxom362mS3BkAhULuw2tJLpPI0SG
	8XhU5yPu4k6vGEukeJaVq3xpxG1p9ZlABg3lUCF9do9V7vXANI4xsXKgNPtZd4cU
	rjGpk5kzw101CDa5GwLtgt0u2mJEnq2I9dxGCQIRbiZV5tVg7S9GltL0tYVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746601598; x=1746687998; bh=+Gxxm0wFQkX9HZb4bAGGxqeK/m4C12t0BZM
	IuleclCs=; b=iMjiaytjiM6X1m04JWWgJfnBuSd0XqI9Yx2ZGo56mqDayOyzxMK
	YxmShaE2wJ15Bz9GgTC3pCvV1ZMaK61hUfwtuHrie5PlIKsj72afQUzqNm7o5+P3
	TT71bcYBY+DATe25RQI/jHSaStFP2VUQEnd3Qo/j6OwEpX2hqt5b7SWYwIfNMz3p
	T/i4vz1Nm7uivAcqfTSz6KXSoGru76lTtEg9OnmVvfd3Yi14i3Gvk9NtJ502TOIO
	sqqZKoHLcq3GMBVFiKfhbiDmMiMeEKKFFj99RVvWxpGeY9cLb7cNSbQaLCDJzun5
	/Ht3FMNmbMQQ0hoaWJ8PP2LzfzVOZkmtLZQ==
X-ME-Sender: <xms:fgYbaPlZezQ6AUKuAYAD8RTGGVN5bUHGSt6YcNJnf0rPCKnWX2vbLA>
    <xme:fgYbaC0h3VIXIEh0E2kU5E7HgaPaZ3FEXGM7ZD8GjIVizQ-UJdgfssPr8RGaEZYrk
    eHZS_UoaPPLljFM3w>
X-ME-Received: <xmr:fgYbaFrm0YboqcgQxF-Wu_QFGN4TmxsDBt6NgW4kz1FuNAZGSib5DosA6n6BDwJqz5M2s6QF2ZQuzrJuLeQyQhOf_jbF-2-EtMyAdtayrkOHXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefge
    egvdegvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fgYbaHlcL6j7LRKb1tDpS2adr4AIaVY_7mg6peuM45cGmCiPc4TMYA>
    <xmx:fgYbaN3ZDpNoRiMzkLf5DGJe3Vx5ZbLFKLKMfdiGNxRW6ZglZPcrGw>
    <xmx:fgYbaGvtsfMCdnKVQUYpI3LWKLyGQSyQ5VJQd9PPQ6oWzH_N6w8AtA>
    <xmx:fgYbaBXKUbmRBZk9vmcBSun_m78pLQNchdyK4BrkiyjZc60oaYdJJg>
    <xmx:fgYbaHyNqHbtlmlW9X-Gk9FEgHTf1_Mn7wx2CiIQITQU3htar2FtFayr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 May 2025 03:06:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e8e39e15 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 May 2025 07:06:32 +0000 (UTC)
Date: Wed, 7 May 2025 09:06:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
Message-ID: <aBsGeu8MIOU5Zzsb@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
 <aBoAr6ABSFiJPGgu@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBoAr6ABSFiJPGgu@pks.im>

On Tue, May 06, 2025 at 02:29:35PM +0200, Patrick Steinhardt wrote:
> On Tue, May 06, 2025 at 12:59:49PM +0200, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this patch series starts to parse TAP output generated by our tests when
> > executing them via Meson. This has the benefit that Meson starts to
> > understand skipped tests and reports how many subtests have been
> > executed:
> > 
> >     ```
> >     $ meson test t002*
> >     ninja: Entering directory `/home/pks/Development/git/build'
> >      1/10 t0024-crlf-archive                  OK              0.17s   2 subtests passed
> >      2/10 t0022-crlf-rename                   OK              0.18s   2 subtests passed
> >      3/10 t0029-core-unsetenvvars             SKIP            0.15s
> >      4/10 t0023-crlf-am                       OK              0.18s   2 subtests passed
> >      5/10 t0025-crlf-renormalize              OK              0.21s   3 subtests passed
> >      6/10 t0026-eol-config                    OK              0.25s   5 subtests passed
> >      7/10 t0020-crlf                          OK              0.81s   36 subtests passed
> >      8/10 t0028-working-tree-encoding         OK              0.85s   22 subtests passed
> >      9/10 t0021-conversion                    OK              3.45s   38 subtests passed
> >     10/10 t0027-auto-crlf                     OK             26.35s   2600 subtests passed
> >     
> >     Ok:                9
> >     Fail:              0
> >     Skipped:           1
> >     ```
> > 
> > This new feature is only enabled with Meson 1.8 and newer, which
> > contains a bugfix that we have upstreamed [1] to make the TAP parser
> > work in `meson test --interactive` mode.
> > 
> > Despite the changes to Meson itself, this patch series also contains a
> > couple of fixes for our test suite that caused us to not generate proper
> > TAP output.
> 
> Please hold off with merging this to "seen" just yet. I have missed that
> this introduces issues with MinGW, which I want to have a look at first
> before resubmitting. I didn't see those issues in a previous iteration,
> so I'm not sure whether it was introduced by this series or not.

Hm, this seems to have just been a CI flake. No idea why all of these
MinGW jobs failed all at once, but a rerun of the pipeline fixed all of
them.

Patrick
