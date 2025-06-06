Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276A2CA6
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 05:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749187391; cv=none; b=Uefve93e/Wxw34VpWtjDozMES6Ljzj0OJbeGB/n5hmPcgeJMFPXd5d7txPYWNsaOY+EFhFCPazaY7sjWjiCbUnUVNbIw9/0OT0JtRpFfG+F6+EUV1D+gP+aCl03djh4Y2rcD9vm8h5ICKQNGDLPhXOZG6lgc9v1e+DTxUzAe8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749187391; c=relaxed/simple;
	bh=4Ur5I1Er0wmSJciRiqKHXFjsPRgz4e+fGpx/1eFTXzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYCmrxYKaNe7n4/As38UftZV+WCDdVxqjHFiNIwyA788SZx3jxFCFtsat4xMTg1loK3/rwA7vQHuWLgVQ8tYmDYrJw2W6S4A6xRzgm6KKTkjuO1RkUpzJnvDImdg18bcY704s+RP9iUQt4TTGRC/6/aN5To3UNdGGdXtko1jvqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mNM4HLwd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SW4Cc6VZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mNM4HLwd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SW4Cc6VZ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B5A31140139;
	Fri,  6 Jun 2025 01:23:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 06 Jun 2025 01:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749187386; x=1749273786; bh=8lrZGB6aWY
	o+9bRzfuRrhWd5qtFBFTzzgF2mzEp9jwM=; b=mNM4HLwdVJwB8orojemhOX6dNw
	rXmg7Wl4h7xwQuHyVBwiPGc5+qbqQ4V2WoKFB2/xeWnNv3bq6SftIZ/W5oGce+1w
	76Vt8LbOeGgmBJBM7URxwPTwh4ErHjOC5VcN1wdWQlg6Qx74/MiLXzeNEvDxrF/r
	+hxQuQFDwoUj1GECHCkTm7pqWuSf7kIiyV2GazNKsetp5/E9pHTedio0+yuF0X8y
	MIYgz5a7XwuCiWUzPlwxLmEVzNk9AR3wChA0TZjDZryZTv7IZC9zFRnEQCn69i31
	/ZVmY43xzeBSI9icBmRKj7X98AJjMrCKldbC1QmuprfzgH9/TiRipv7ke7Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749187386; x=1749273786; bh=8lrZGB6aWYo+9bRzfuRrhWd5qtFBFTzzgF2
	mzEp9jwM=; b=SW4Cc6VZBnb8gZA2AVvI1dMn6egxDhmylCpLa4OUUgWUMortrKB
	zGOXqaGjVf23w4MuYj6ySkg7nh6kPb/le8Yu0x0VE98KsAPhd+/LvQA95yyrrgox
	fcscni9zkonwQI7VudOqPGz8Eu1SNRgLmgaq97TsTK96IVuU+0cyVSkA2qa84OQi
	yp/PYg8Bw3dOO/DWRiIzXQ0mW+1m0ATvAqNhk5/Zrg7XVu/0Mkeka7E+MIjp7Tf0
	aqEZQVJdpNrk1b/hK2ujyqgE2FZaN4+hoi1xrNWNV1Aav9mTivh3Ecdmpj7Fnmqa
	5cnuxwgp9VMamIn6JPNfh8UZQc82HcE/mzQ==
X-ME-Sender: <xms:OntCaEdvEH7Lpg4fRbCi6KMxNQtrnZW4bfC1bNjIdz1HhD1Lgr5GzQ>
    <xme:OntCaGNHY-CFMDJ4IFAQ4J-NxupZt3A_wegia202DNaUjVyDHT5PRLorQmTFhjLf8
    KlQQX1KXSn_mTsdcQ>
X-ME-Received: <xmr:OntCaFivDF1sVBFwpyDHTGlecKJCXQDkvVUAl_i13RJEbAMBGujZJFDyWKpH_JdW_b0xYzci5lLIQGRBJTybVwL4AHnd2Zh8f4ZJ4HH8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkh
    hsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdr
    tghomhdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:OntCaJ8k8z0MJLL_Vmu7AAnHf2JHYMy65Ncs3m0eB76bCtgEO870kg>
    <xmx:OntCaAs2RbRKt24yuG_fxLlyK4z6ZrQpWtEXPgy8AeYC8hebq5klMw>
    <xmx:OntCaAGBEM2h9U8NZ-ABDL7DiZWREYbSNhJB9PJ05-J_UNMpuIQF2w>
    <xmx:OntCaPNkd2F_vVq4il4-PB_ITYNClc3lroXR6nzn5tUphnfA_iAvEQ>
    <xmx:OntCaB8S5Bdj4NMi_Fy3hnw3CZqp0SPSLOe_KLVNoi7ab_1LGHfCTsjM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 01:23:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 50794a9a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 6 Jun 2025 05:23:02 +0000 (UTC)
Date: Fri, 6 Jun 2025 07:23:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
	david asraf <dasraf9@gmail.com>,
	Emily Shaffer <nasamuffin@google.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 00/12] builtin/maintenance: fix ref lock races when
 detaching
Message-ID: <aEJ7NW6A-FBpDTnw@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
 <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
 <4a8b02fc-09b1-4e7a-9b44-49a526b1da48@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a8b02fc-09b1-4e7a-9b44-49a526b1da48@gmail.com>

On Thu, Jun 05, 2025 at 11:53:32AM -0400, Derrick Stolee wrote:
> On 6/3/2025 10:01 AM, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this patch series fixes races around locking the "packed-refs" file when
> > auto-maintenance decides to repack it. This issue has been reported e.g.
> > via [1] and [2].
> > 
> > The root cause is that git-gc(1) used to know to detach _after_ having
> > repacked references. As such, callers wouldn't continue with their thing
> > until we have already packed refs, and thus the race does not exist
> > there. git-maintenance(1) didn't have the same split though, so this
> > patch series retrofits that logic.
> 
> Thanks for making these changes. I read this v4 and only found an
> opportunity to improve our docs relative to the more helpful errors
> around using --schedule and --task together. I sent a diff that could
> be squashed in or skipped.

I see that the series got merged yesterday, so your mail overlapped with
that. I think it's a good addition though, so would you mind sending the
diff as a follow-up patch?

Thanks for your review!

Patrick
