Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F418C03D
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224626; cv=none; b=SVPDpSnTQoRFqDfHEP29UnGgtKNPvE2ioz6xWQGYouhOV2NNvQZaoJOLGuZEWa85rEErOIQlk0Dklr5Gf+S6t7SBKm6V9wd9XDx9qfly+IigZjP19kFhJNQyYisleyGDnt5Z5ML7LzTQ5R7a1wQq1DuyLTeWO5pA7g6dGsXN4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224626; c=relaxed/simple;
	bh=vqJtHluhJcKhR61GxutF1fp787h5Uk8+nAUu1AtpE4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnQsx2yvogfENirBgbPb6Emq7yDBiHjN2f9ebq0pMQIvANsSI+TeCV+Je5RDLCSDXAOoL0aZtGu+7dERjXJZYLfXjClN+DAc36+L/8LpKjgXWS7OOlnJ1lyO6X0iUrINPCVYZILvEZfs09DEn1U30IpwLbPtkha8ZvD2Idjf63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eZhALYoT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X7zWHHHB; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eZhALYoT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X7zWHHHB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D8F9425400AB;
	Mon, 17 Mar 2025 11:17:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 17 Mar 2025 11:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742224622; x=1742311022; bh=NXyqvuszsK
	4zhAujksFGFtz3N4Vn9LTa7cCtqfLio14=; b=eZhALYoT1T1IYjgv+iNK4UDknf
	c4cVMSsOLGlmkds6XFiSR1RRuOcym68uMkk5I+8S2bbBbkowa2JTV+oW7A+yXuAT
	jPCThRAHRch/5GVmQ/1fhyrJ1M1YDS0ZWZP6u1EPdvNPLlCL2lfitOMgm+jBjvnj
	qkOiqNCUNt1e+wGGA1nqufrnmLH2R07LcIMQzJ2mRCOCcJ1yQpCHvniecNff9W43
	+IX4lbQQr6/GgkZSD0N8WDiWW2myrw7UCcCwZEk98EZjdTusLJhZp/0kpdYMTBnP
	SYikM3WYS+tkysYBugMKI7MgGURyYPFbxHSs4IhEGfOgeKBZN2yPyMfCD6kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742224622; x=1742311022; bh=NXyqvuszsK4zhAujksFGFtz3N4Vn9LTa7cC
	tqfLio14=; b=X7zWHHHBQzkoUuQTNbik6UOIgl7mgv2/TwC+/ZN4HJ7ah8TNa12
	aXR7cC7BVrAfmq24dS33f8+AX8zWBARZ6MiZsQtgjEh2P+Eba7iE6KjRomphty/2
	yw+54m6oKWfl1lVZBZxpCBdYP982msYyKoqZgM/Va7zSzcfx+BpHmQM7j/Lgg5JZ
	sR8k/lanK1lyr+jWMhpK4vRHMSd+bZ6A8gVoc8mxCLUKz8sweXZbCbhwBBE/pPiO
	L9BgORH7qFg/G2fL5SikiLoM2hvdNeKiyUmiFzexGmVbkGpzkIbiQXK2uOAeAxmy
	aueU+tVNM77lhzAKcYxh2v6Bq2eyEJCTKFw==
X-ME-Sender: <xms:7jzYZzvi6p5uOpOBcyQfvwlsxELTs1Gb9c52U-2VnpfWwrFetHxulA>
    <xme:7jzYZ0dxnbFWzlqctAd0OtuCnQEPhq7xGBq5kHWBXcnSSvYn31TIZXdOb75T4W8fD
    2Tvetde_-Jq8vIwsw>
X-ME-Received: <xmr:7jzYZ2xdowrEgroeL5AJKTazmf6QKDJPOfe0t7EDxCHwu3qawALfvZGSWdRwztI41Z1QK9Mp3sGkILM4DEqaZQZmXtwFhusGvcFQhrpkVOPH5nBR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeelkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7jzYZyM78Vnc2Y0UQWdrHiNi1bzn7z9IDiI2QAWUJhuB79tL-Ej9BQ>
    <xmx:7jzYZz9kXyFo_liSak8txlVj6ulTX2yxgDIWENsqBC8KtzQ6Hr8GaA>
    <xmx:7jzYZyXlqHZG1Bz4w7P8wPAKxLPwOqHX2C1iWy8uhisfr-55IPYh5g>
    <xmx:7jzYZ0dgggr69sL_SMFNZgFCTp5oDbgJ7CWO4RrbLjNwNkS7CWbmJg>
    <xmx:7jzYZ2bqGDEYFUkWm_0yjDDDHBAuOFyaLMHsW5MXVX94U9Gd1rZiuYRX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 11:17:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 909b7e16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Mar 2025 15:16:58 +0000 (UTC)
Date: Mon, 17 Mar 2025 16:16:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] compat/mingw: fix EACCESS when opening files with
 `O_CREAT | O_EXCL`
Message-ID: <Z9g85X8sNqFOwRaU@pks.im>
References: <20250313-b4-pks-mingw-lockfile-flake-v1-0-bc5d3e70f516@pks.im>
 <20250313-b4-pks-mingw-lockfile-flake-v1-2-bc5d3e70f516@pks.im>
 <239e4222-cdce-90b6-2a8b-ee48c3e024eb@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <239e4222-cdce-90b6-2a8b-ee48c3e024eb@gmx.de>

On Sun, Mar 16, 2025 at 01:01:25AM +0100, Johannes Schindelin wrote:
> On Thu, 13 Mar 2025, Patrick Steinhardt wrote:
> > In our CI systems we can observe that t0610 fails rather frequently.
> > This testcase races a bunch of git-update-ref(1) processes with one
> > another which are all trying to update a unique reference, where we
> > expect that all processes succeed and end up updating the reftable
> > stack. The error message in this case looks like the following:
> >
> >     fatal: update_ref failed for ref 'refs/heads/branch-88': reftable: transaction prepare: I/O error
> 
> I saw this error plenty of times and was wondering whether there would be
> a way to get more useful information in the error message.
> 
> After all, I/O errors come in all shapes and forms, and telling the user
> that _something_ was wrong but forcing them to recreate the issue in a GDB
> session is an excellent recipe to cause frustration.
> 
> So I'd like to suggest to improve the user experience substantially by
> augmenting the rather generic `I/O error` with details as to what
> operation failed, with what exact error, on what file.

Agreed, the error handling isn't great. The very least we should be
doing is to print `errno`, but even that I consider to be suboptimal.
Ideally we'd have structured error handling that allows us to return
richer errors to the caller, but that is a much bigger undertaking.

[snip]
> > Fix the issue by translating the error to `EEXIST`. This makes the
> > lockfile subsystem handle the error correctly: in case a timeout is set
> > it will now retry acquiring the lockfile until the timeout has expired.
> >
> > With this, t0610 is now always passing on my machine whereas it was
> > previously failing in around 20-30% of all test runs.
> 
> It is good that you fixed this issue!
> 
> However, `ERROR_ACCESS_DENIED` most often means one of two things:
> 
> - The file in question exists but is opened exclusively by another process
>   (which might be Defender, the anti-malware scanner), or
> 
> - The current user lacks the permission to create this particular file,
>   i.e. it is really what `EACCES` would mean on Linux.
> 
> While the first condition clearly can be interpreted as "file exists" in
> the way this patch wants to do, the latter cannot be. And the patch
> touches a function that is exclusively used by the `lockfile` machinery,
> each and every caller of `open(..., ... O_CREAT)` is affected by this
> change.

I feared as much. I was hoping that the second case would cause a
different error equivalent to EPERM, and the documentation didn't really
say anything about this.

> This has ramifications e.g. when running in a worktree where the user has
> no write permission (but which they indicated as safe via
> `safe.directory`). Git would then no longer report correctly whe it cannot
> write files because the user lacks permission to do that, but would
> instead claim that the file already exists, when that is not true.
> 
> Maybe there is a place higher in the stack trace where Git could instead
> learn to handle `EACCES`? E.g. treat it the same as `EEXIST`, or maybe
> alternatively make it Windows-specific and introduce a back-off plan?

The place that would need to learn about it is the lockfile subsystem.
But we basically have the same issue here that we cannot know why we got
EACCESS in the first place. So retrying may or may not be the correct
thing to do in this context, same as in `mingw_open()`.

While implementing the workaround I wondered whether we are able to get
clearer error messages if we were able to verify a few additional data
points:

  - If creating the file fails with ERROR_ACCESS_DENIED we could check
    whether the parent directory is accessible to us, and if it is then
    we can assume that the error is due to an existing file. But that
    falls apart rather quickly when thinking about edge cases, like an
    unwritable file in a writable directory.

  - We could stat the file in question to check whether it exists. But
    given that our case only happens when we have lost a race it may be
    unwise to build on top of an already-racy mechanism.

All of these feel hacky, so... I don't have a good idea for how to fix
this. It is unfortunate that `CreateFileW()` throws these two errors
into the same bag and doesn't give us any hints which of both errors has
happened.

Patrick
