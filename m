Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2E01C8616
	for <git@vger.kernel.org>; Wed, 28 May 2025 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415082; cv=none; b=PiY35zOaIhQpGkOhuP7+OdBEz84lFwlQf9a8IgDAOPMPtM+3alpCcsAL21Ye3rBaqd0nQowhXrf5Mn/gbZ8NhYdvbH8+gq78vEpEwh3snqheLNFu7918/nOpbB7lQS2b0PtxaLvkM0ajjLqwN8yUPtC140k+vF66Z/jA/IqSyuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415082; c=relaxed/simple;
	bh=AHLmY5dPV/qVCWqlIBMET4LE9BQ/7JhgXyxpgsgg7aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d71NyRtCnPl8HhxBk5+OyGbakq9qHAwbc+XzGxPAaWY63qMhPSqeClqprPUMD1KLY5YkE7YHybWqSWNy1Jc94IEzmuV8hKGKy3iWXBTRPZFD9ijmoq3E4amy8xT0+CPBgoO4PkAoz/ktnSAWneZ0OFf+1E/EBehujWVDedDubb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a2XH6Vb5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hS2byVQB; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a2XH6Vb5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hS2byVQB"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D178114009F;
	Wed, 28 May 2025 02:51:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 28 May 2025 02:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748415074;
	 x=1748501474; bh=w3j+trtLdlJTJqyGjE/Lcyaqz20w0pf86IJVdeKkiq8=; b=
	a2XH6Vb5MYI/B/k9BF7VvykHY9+4GDgm64hdgLTN/Re5+XeyZzDbgHnl/RFQCdzt
	uKTrt1Qzo4VWSoAQ9rxHvSHN0JlAjuQfyOltGHNWjnbWSQORirN7rXHViIvi0a8x
	7bz2E+4Ue4kWFYuwSXyZathHgUp7llhOE2XD1gaKOJCwZSmmLH4MtGxYw9uNKTEM
	MhKMODtmhX3yioY3+37PY41Q3bSzx9CESF1PEJusDJck0taGF40LKTsiSp3ojM77
	Wy1P+KcSuzLAR3fBIZ7ccLlI3yfxH1CuKrSPGr6LuvC+ajs5SlansqYHpshoUJML
	B+w/5X/PWKeHaKbFdKby7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748415074; x=
	1748501474; bh=w3j+trtLdlJTJqyGjE/Lcyaqz20w0pf86IJVdeKkiq8=; b=h
	S2byVQBNO4ucNVd2P9GMxqEQrSd3iPszgjYFJKg58c8g8bgCpAZCtqXnFZYqD01D
	RTJVfOt7yzCoj1n0OJp8hrt9iP9W3FdzQuhKbrQUetu0KHSuzQ3hjlP98Qs2ScFh
	wW9Ueojd0qmZ39cVe0+6ZwUuMZ348MGmvHMEXV7en4tkwzdZR7qxsPBwaMxQyJVb
	RtcJSZeywmMVlkKylG3iqyUq1dhf50LTLeVdqt8UZ34vmbVNXXK/30TFmPOECn5W
	pD8YP2IfCc+X4bB+cGdWszlwloH/4fdFfhFy9Kvkeiw/P64ORJ/r6IVBJ0Q5OfJs
	75HGNPTNix4a1DaSKv0KA==
X-ME-Sender: <xms:YbI2aGY-CEZTlGDA4kzfNuZyonlKTNvJwvqvMvkpN6k_hhLV4JN5RQ>
    <xme:YbI2aJZRkHutDHlCTlrONUkkEdEVSfJ8pJG5gR0cz_e3CSs2lXf-lFUtagHauFi-M
    QmQKENg9wf1nxp2GQ>
X-ME-Received: <xmr:YbI2aA_ZZ4dMBqSYzmNuLOt6_NrCMZPAIi_42OtDemwwsIsHi7QI0RnD74-SdEhSx_gwLmL48W4jlH2VPEmqMcq_79Vi1N7omslAhcFOEPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdehleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleeh
    ieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgrshgrmhhufh
    hfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:YbI2aIpR8lSP3Pel2KQZW2tvIoQvo-a3_sjbeiAgN2DZgaPbtNqCBA>
    <xmx:YbI2aBp46vNVvmzp2gSImi4P1rAWN9HWHwUftGTclAOOAG3-YjpElw>
    <xmx:YbI2aGQbm0dlI-gGPFhLUwKK8oZfFs0tLbBKkTJfsjMbRrHTmF-WmQ>
    <xmx:YbI2aBoTdEJGaUn15FLizAmGoYv_j7DskopI-fCrU1qjUIYCHnq9Dg>
    <xmx:YrI2aC6iD6mrccmGiXVjE2XUkiX6egLCcuI8K59Excz4GqVLgxpNleud>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 02:51:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9b26ce28 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 28 May 2025 06:51:10 +0000 (UTC)
Date: Wed, 28 May 2025 08:51:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Emily Shaffer <nasamuffin@google.com>
Cc: david asraf <dasraf9@gmail.com>, git@vger.kernel.org
Subject: Re: HEAD.lock and git maintenance
Message-ID: <aDayWsRRA3ur-Pwi@pks.im>
References: <CANi7bVAkNc+gY1NoXfJuDRjxjZLTgL8Lfn8_ZmWsvLAoiLPkNg@mail.gmail.com>
 <aDRq6oIgkSfAepcP@pks.im>
 <CAJoAoZ=OGOWVWQJNSk0YAVA0V_O68Y4ycXdw6d8bJ0=OhnNGeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJoAoZ=OGOWVWQJNSk0YAVA0V_O68Y4ycXdw6d8bJ0=OhnNGeQ@mail.gmail.com>

On Tue, May 27, 2025 at 09:33:50AM -0700, Emily Shaffer wrote:
> On Mon, May 26, 2025 at 6:22 AM Patrick Steinhardt <ps@pks.im> wrote:
[snip]
> > > Using GIT_TRACE_PERFORMANCE, we noticed that a Git maintenance process
> > > (/usr/libexec/git-core/git maintenance run --auto --no-quiet --detach)
> > > sometimes starts after the git fetch command, occasionally in detached
> > > mode. We suspect this operation is causing the issue because we've
> > > verified that the git maintenance command requires HEAD.lock before it
> > > starts running. We are considering setting maintenance.autoDetach to
> > > false. We are unsure if this is a bug or if it is working as intended,
> > > and would appreciate your comments on this.
> >
> > thanks for your report! A couple months ago there was a similar
> > discussion with someone else, but I cannot find that thread anymore,
> > unfortunately.
> 
> Google had a big problem with this behavior about a year ago, I'm not
> sure if we got far with a thread about it though. That may be what
> you're thinking of.

Yeah, I remembered it was Google that had problems, but I thought that
this was at max half a year ago. So I didn't care to look back further
than that :)

> > The root cause here is repository maintenance with `--auto --detach`
> > will detach before spawning git-gc(1). This command may decide to pack
> > your references and thus cause them to be locked. This then triggers a
> > race condition, where the next Git command that wants to modify refs may
> > not be able to lock "packed-refs" because we are still busy repacking
> > them.
> >
> > The actual timeout to lock the "packed-refs" file is configurable via
> > "core.packedRefsTimeout", so bumping this value may make the problem
> > less likely to happen. But it's only papering over the actual issue.
> >
> > I'll send a patch series soonish that fixes this issue. I think the
> > solution would be to make git-maintenance(1) learn about tasks that
> > should run previous and after daemonizing the process to avoid this race
> > condition. The effect would be that the caller of auto-maintenance will
> > not continue before refs have been packed, which is similar to what
> > git-gc(1) used to do in the past.
> 
> We'll look forward to this series with interest, thanks.

For reference, I've sent the series yesterday via [1]. I'll keep you
Cc'd on that series from now on.

Patrick

[1]: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
