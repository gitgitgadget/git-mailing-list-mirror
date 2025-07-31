Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6348D241670
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950520; cv=none; b=h0LTFpkDqxB41/Dtf1Q8m60U2oiaJLB860+ersnjhCA2FH9gbpBsEPaj371H6++VOB/wf9Y6izBdwFhaKm6yAk7uShO5vXXKJPkM7t1NHClwa4K3nt43P5vfRuEjuRvqXEVqUwSvDwmWRzh+/RMM5ED0508Dckowj+/hkw22hrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950520; c=relaxed/simple;
	bh=QcTlECs0K/G+AmxEc6vFCY6V5H2dkGJrKwgSgbJ+jb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnwsNPREg6afJxfdKMQh6Ik4BmiaAbahdN4fQYgGCHk76UK+WWy7RnXjGOBW36R8NnUIx0TCoGW9HOvuLm+JdekECNx2C2PjX74wOgobHKilo5nKU9N0WHHhw51ZoJ8dfE1sJRjDHtXPSWcRHNkFc3+aVxlCD3ACz/F6RB6CC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K+WJ0jTP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UGsQoA+o; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K+WJ0jTP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UGsQoA+o"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5CB7D7A05FB;
	Thu, 31 Jul 2025 04:28:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 31 Jul 2025 04:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753950517; x=1754036917; bh=0+TAOkajS5
	LoYz60eDa1piIysFV48Sf9H2Xi1EzdSXc=; b=K+WJ0jTPEXIbwLS09oIUpedzpH
	oBCtOeFfgR4IS23vGu1p+ZTjxV9rgGJvwI9PlanxYn6o07BN92h9/Sx+7rSRnY4G
	FwW9BYDqLGbyifd7vpTBpVpeJwvpsqxMSozr5YEg66DPeqU5qqJKBYFXI05MHj8f
	kCRHMwhw1tlnujIDQUExoTnRpKPCM9t3aGQjM7rEm98u8P1puj11P2Z3A560avS1
	sglpF2XDcGNxci5de2Z7fjvNe2/2IBP+um/AByGZz9ODwJQmJNj8VU0t/9/pSR/N
	pPOD85NzsN+yCGAMAdXfv9jJpJSJpFrXc4hwmb1Tap5mueM6hqbm5YLna9iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753950517; x=1754036917; bh=0+TAOkajS5LoYz60eDa1piIysFV48Sf9H2X
	i1EzdSXc=; b=UGsQoA+oWFoNTvZ+s7i+oGbJrD1mNdCubXde8xe12+Mxjwf+sHP
	HMArL+WuSM2Xf/SZ3pieaOZe9nWBpRE7cKTdnW/s5pw/ZUVXgQ+t/yNF/Va+nnBb
	UPnmpIVzlyXIdX51RHo1O/3mrkUlynYI+M4wumUXcACTKkWTtaJiUTy0aM5afgE8
	f/NAOO03W8Wd4L4nlHgEjIkBLgIXB4Or58zIKne0NiDT1wX1fkgzguSyTpGXBnSO
	M8SBBOAdKFftZ4qnVDsAmqBRnMEqjrOgCfkp1P1BWS68Qf/JQuOULJd/+an+cPbY
	Bv8TB1BBzyU2HTMyXDA9NslVFkJZNOLEpHA==
X-ME-Sender: <xms:NSmLaBXp0mhXVQ7yia8-D68dxvi5ysrUl48I91JlFAArK7fMiChCGA>
    <xme:NSmLaNGupNeSTT6v3UMRwYHesqibxCySYt6OCBO6kZW8nFAQczBm4l5pHrs1cBkLe
    YJkW9BqSoeyTxa0bg>
X-ME-Received: <xmr:NSmLaD1fe7L-XIT6dOzOHLEUk53bNsbwhNU4WmeDhZEJNVzX3URwjWt2UGwcxJqS4Fs2MRnUIr-4osKo1-32ky-wRqs82x4sIXnMW9smRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjhhgtrghrlhdtke
    dugeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:NSmLaPMXar1LMa7UorCVovsgOYyCj1B0xPv5Ak8fGt2Gfy6pL7CK0Q>
    <xmx:NSmLaC7esMnZ5mtYinPwQNO5RMfw7coFLdwBS8MgrOP2RO4WHrinyQ>
    <xmx:NSmLaJ01jdQ1arUG2xObz5Gg7rRZkMTMFZzUgXJG6ZGNorAbVZu9ew>
    <xmx:NSmLaDwjeOh46YUjgdjS-PUn4LWzsoITp8Zj8mnVMQAOxFx-bbmQHA>
    <xmx:NSmLaACS8rRLcp5C3ZNwx_MPxUg8WQTOWxeN1SA8fImaaUNkXm0TAsNR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 04:28:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e3c7b92e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 31 Jul 2025 08:28:34 +0000 (UTC)
Date: Thu, 31 Jul 2025 10:28:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Han Jiang <jhcarl0814@gmail.com>
Subject: Re: [PATCH 1/4] refs: pass refname when invoking reflog entry
 callback
Message-ID: <aIspLhS-hVIHQ473@pks.im>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
 <20250728-pks-remote-rename-improvements-v1-1-f654f2b5c5ae@pks.im>
 <CAOLa=ZR10eOikwFyDwMDSyX2qQM-knCKhCKB4YtLD=Pdoz=vTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR10eOikwFyDwMDSyX2qQM-knCKhCKB4YtLD=Pdoz=vTA@mail.gmail.com>

On Tue, Jul 29, 2025 at 01:30:49PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > With `refs_for_each_reflog_ent()` callers can iterate through all the
> > reflog entries for a given reference. The callback that is being invoked
> > for each such entry does not receive the name of the reference that we
> > are currently iterating through. This isn't really a limiting factor, as
> > callers can simply pass the name via the callback data.
> >
> > But this layout sometimes does make for a bit of an awkward calling
> > pattern. One example: when iterating through all reflogs, and for each
> > reflog we iterate through all refnames, we have to do some extra book
> > keeping to track which reference name we are currently yielding reflog
> > entries for.
> >
> > Change the signature of the callback function so that the reference name
> > of the reflog gets passed through to it. Adapt callers accordingly and
> > start using the new parameter in trivial cases. The next commit will
> > refactor the reference migration logic to make use of this parameter so
> > that we can simplify its logic a bit.
> >
> 
> I remember hitting this issue with the migration code in 'refs.c', so I
> think this is a good improvement. The changes themselves look good.
> 
> Nit: Changes suggested by clang-format in case you re-roll:

Okay, I've rolled in both suggestions. I'll not send a new version only
to address these reformats though.

Patrick
