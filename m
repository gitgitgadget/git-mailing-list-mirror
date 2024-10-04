Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA951D9A50
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055593; cv=none; b=S90wO02QeoXXJjNgjGkn80YVs+47QZL7l17s46YHjwYBW+fO8IAJli708kWCKxhryhI+8ZtD7EM2L7amcZ/undxkhpLph/Gz9yall6Q/KYi6Vm3GRjgZvP0EqZM5wk2cE7mVN9g6qdWtEtZYGNi9LfHZGn4YcbzkSZ3jlqHXnUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055593; c=relaxed/simple;
	bh=Mt+iACTk4RRd3aplyAD0IY9Rd28fJW2QGPl+0JUygiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDPYsHSTIZnHj2UBJKMZT5I8Q0tD1i6gj10xJNZcSDLKmK/F4QnG1o+CPiIwGJGS+9INIXy5paNej+9L6HcjqfuA8wJrf/rWmMv5d4MwwX9fgMmc+I+0NsVoDHa7LhT6vmIsjXgx0aLQNrRxOfADbGhJkU2fj0Fy74ZsWkgCRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pv7ux4wd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cqSWx8Rb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pv7ux4wd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cqSWx8Rb"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 551AD1380236;
	Fri,  4 Oct 2024 11:26:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 04 Oct 2024 11:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728055591; x=1728141991; bh=Bl0gkhoWpb
	kzf+Ho/8JyV9BboHtsCEFbtSxg0Evi6tQ=; b=pv7ux4wdfKRfS24BwOBLnU0tTZ
	1CQNf3NNz89/Ilvl6rhyhfK/Ngtx5kvXcU2JzFwaBHBNmvJNs+QiG0J3uZCjCKhF
	daGgEq3A0suO7QaMWuTqqJ4Rets1rSvZtoxnK2EJK2GgW2MPhBSsO1Ni8by1wKJD
	I1jZZ6R+/AgQvQB3A5lodnqiXUk7ggSToKNhAUzefBZeHfDopZxuKgoBZlKoKn9N
	qt55MEaeF/F2WekDQMiuvrptS23x61taSplqtAYEeY63XD10zQ/V/4r43v116X0Q
	tHLkzcInySBIbEZbIhYdWIU9gJtW2LyruivcVRdXuZDI4edhW7u+ITFnI6Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728055591; x=1728141991; bh=Bl0gkhoWpbkzf+Ho/8JyV9BboHts
	CEFbtSxg0Evi6tQ=; b=cqSWx8RbX0PJ9n5W0n81mSyCXCjtzf1EE/1Pi3t60Gx4
	fbhNzrpyM47kinaNHdYWYQR0cGH4V6LsZOFVFVX+UsA45ZpDHKU6qB0cDy4U0+Jf
	ehCv2lLIewO8Tx6ZISeYA0p88MjDCAtwSL4qkuK98pVeR7ha231zli7S/to6CwYm
	b98a+m5n/688YMLaLBGQlltIkr0Ntl6ekPlD73KCkE7xcEeVwgB3i+pPrWJ7IW+3
	v77R1KlGvubjV+w29ka1aAMEvDYxCg4dmxzBcOLcH+MhgVG64eClvOBGnh4Kd1xj
	wRhtZDizL/Xus2QGyTOyTpg/3C2iOb71qtwBGuN4OA==
X-ME-Sender: <xms:JgkAZzswhNWXrT53q2WNZZP8E12Cw3LNniUOjHDSQSR5tNg-qRRlYg>
    <xme:JgkAZ0en95TyJ9ALUK0POuRy2ByM0hqiA6_EGyuuUjM27BmqUDnmF_P4UDPIq6CSV
    jUzDbVDI69FfR7ypw>
X-ME-Received: <xmr:JgkAZ2xbkKw-4Muc3DZ4i33y4TwICHdX5Nbl3edT0cfzc6noFrjT_24YS1sBrI7sr_ogIvttVZjzuDiOVcmoDSQJE-vxQcfyEopDS-9QMXjSPwsp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsthgvrggumhhonhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JgkAZyNhDWBSnBdTw0lDFlvC8zmsNASxt0yHhag4dnFzUEkUy3nSNQ>
    <xmx:JgkAZz-Sfw2ojwN-zCm55Apl_y_cL5Ok1yiJChMY_GUvsqzIdFh9aw>
    <xmx:JgkAZyV7sFE3j3CJRNJVC4I7KAcYxiJt3QfcF5y4ntz4_TIeSbVd_g>
    <xmx:JgkAZ0c-gWXntFz0svu4uEd-z-KdV2VY1mqwJdcaKAj6wAhDNPPPhA>
    <xmx:JwkAZzwaGuUt2g8j0amnIsYpEjV1Ue8yfKCUn_gewywJ4_a5wu2oKPW8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 11:26:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d24915bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Oct 2024 15:25:36 +0000 (UTC)
Date: Fri, 4 Oct 2024 17:26:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] t0610: work around flaky test with concurrent writers
Message-ID: <ZwAJIRPUrxu5ox3w@pks.im>
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
 <f83e23f1e76454a80e3e53cd02b3bb5bba6b8da1.1728044178.git.ps@pks.im>
 <277c243f-7179-4946-99c8-b19ad5c85412@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <277c243f-7179-4946-99c8-b19ad5c85412@ramsayjones.plus.com>

On Fri, Oct 04, 2024 at 03:47:01PM +0100, Ramsay Jones wrote:
> On 04/10/2024 13:16, Patrick Steinhardt wrote:
> [snip]
> 
> > Now the two reports are somewhat different from one another:
> > 
> >   - On Cygwin we hit timeouts because we fail to lock the "tables.list"
> >     file within 10 seconds. The renames themselves succeed even when the
> >     target file is open because Cygwin provides extensive compatibility
> >     logic to make them work even when the target file is open already.
> 
> Hmm, not so much for me! :(
> 
> > 
> >   - On MinGW we hit I/O errors on rename. While we do have some retry
> >     logic in place to make the rename work in some cases, this is
> >     seemingly not sufficient when there is this much contention around
> >     the files.
> 
> I am seeing I/O errors.

Interesting! I wonder why I don't see them. Maybe it's boiling down to
timing again.

[snip]
> Can you think of anything else to try?

Not really, no. I'd be curious whether Windows 11 has the same failure
mode for Cygwin, but cannot test it myself.

> I would strongly suggest skipping this test on cygwin as well as MINGW.

Yup, I definitely agree. I was operating under the assumption that
Cygwin works alright. Now that we know that it doesn't we should adapt
the condition from "!MINGW" to "!WINDOWS".

Patrick
