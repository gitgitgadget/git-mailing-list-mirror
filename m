Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999C013D29A
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360562; cv=none; b=Yv3JXQCYvREdVuRrXuoX6qBdRSulHHKuzJ6NyZGxQU0dVQgNza8q9Ei3z5NfZI1fazvErm1B3sjGn2LwldzYOTBSXhCd8C0yYU9p3cHergm5daIsH6Qv1ZCf6iS5ZRCLeygcu2y1POYSqk/cyoglfJpkute8U7VMZvazTk8EfrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360562; c=relaxed/simple;
	bh=z18qYh/vpRYPQPQmTIfe3UEyQcW7YWPHhuhwCS9bYSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiU9VZngHLKSXvZUzs+IcXWqXPa0kJWTU67xYInMWxj4p9QNmaQ7e1W8FtsGGpfuLLTLMbRHnsR/n99174rdNoBF9REIxMFIHtKy30Thw5b83zkh5sEUrCDnOykqF4nerIgGSv72L5Yu1RYVtKnSnTKzUmCZzUnT5jfc9jePTXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EpMiesCC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v3rOjcMF; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EpMiesCC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v3rOjcMF"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68D7525400EC;
	Mon, 16 Dec 2024 09:49:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 16 Dec 2024 09:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734360559; x=1734446959; bh=7iR3s1Kfou
	1Km8CnoOxDH6xStI9gA9d2Kdg5nKIBokk=; b=EpMiesCCWzf5E22FaGNJaMTYqx
	Tzfbl073eqRUdw2zR/c2j6zRFDIki3LMbg/uzIMbQF820Vx4CCNE1SMmAWYIeJkL
	0EbWdMvZcqAyu4YcsYe1s+aBpZJb0LLZJr2DO8UdI8t5JBFCZ5XbiRFw31aujSci
	u8ykgjIIqY3dX1JuQaQEKKXuhbJPVKzzeNhpOHaleZbmJTxeAqGNIFI3MgQclJu2
	zUOMiQt6OgGuVfyiFicV0orJPGbE7WE9YZCCTaPNvTfmYFGrg0aL5qY0FQhZsLci
	TBIAU5oq6IUGwGj6dMZa0IL/wxKIo9bPsiSsn7ZWLDCdHcTnzTjiYUUmM1jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734360559; x=1734446959; bh=7iR3s1Kfou1Km8CnoOxDH6xStI9gA9d2Kdg
	5nKIBokk=; b=v3rOjcMFoHGTTTnG70by/VFxGEEfy8VbmH6OJZdMV7Q5/AyhfR7
	pqCnm73zO90TuohttGnvDop0t3ioiY9Vj8pd5kFXYpyP/Z1MHo4IzdI8YxHweuCl
	hDsuLA0h3O3aQoXCn6l+uKvjshTYPulnl8taLxq3iG6AwVKYaghBs3N4bduhiPiY
	AmAuNwQurJbQT42Y6Y6243eZeAptVuXRl/KwPX1yW9KZgjps6E7qaOcgCdeMDJcV
	BfW1yBoMmYHqFS/VeJXCsd7Np9R+GK7Y568DXV4k8Gv6AwgCEJqtQdl9OPortLts
	nkRkuD+LDRz2zmFYOwHDhfs++TuFgg4LWAQ==
X-ME-Sender: <xms:7j1gZ8OteYItcZl3meOjrqG3-gPMXQdOORGpyw2a-T2dryI_vKGNYg>
    <xme:7j1gZy9KpnFZ4dDAAqb2KFeDEIU6uFUknQDXZd-qmtU6LyVpyhQurwx0EBxxcLdDz
    Z6yYIoxjrCngV_55w>
X-ME-Received: <xmr:7j1gZzQoKOfQOwTxWiIXQkN4egbCUSu8eFy7DFGXOTplPMBELfucRIdHqi4xsWIVtNSJ1ndLqfUB0iIdaZw5vlEU4uvAF58RwmzEnXiqZxbvUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepmhhhrghgghgvrhesrghluhhmrdhmihhtrdgvughupdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:7j1gZ0tCC-0B5EuTUq1_4XZtGGlRzpga7fyQfOAnBJjBiMCPvZfXDw>
    <xmx:7j1gZ0dgwm62L4Y1c-Y3BURB_78sVyg8jWqO2PeEnSr_gkK1IIlNDw>
    <xmx:7j1gZ41knZ8URWPJcvdKhhbAf-HegUuidsX1EWDY6_Fs3WXH6g26GA>
    <xmx:7j1gZ48P9MgE90y4fdGBE9yyFRRzaUQXQ3KIiQkSF9Oysjg_BvVf5A>
    <xmx:7z1gZ5ERBGcjzskgw_qH_wfHg564ZxIdTcVK5U9wYYh62JBwINi2qaTo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 09:49:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4f74a617 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Dec 2024 14:47:33 +0000 (UTC)
Date: Mon, 16 Dec 2024 15:49:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Implement consistency check for packed refs
Message-ID: <Z2A93X2rxZEnYE76@pks.im>
References: <Z2Ax9dtx4XE5xjgw@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2Ax9dtx4XE5xjgw@ArchLinux>

On Mon, Dec 16, 2024 at 09:58:13PM +0800, shejialuo wrote:
> Hi all,
> 
> At current, I have already implemented the consistency check for files
> backend. My next step is to implement the consistency check for packed
> refs. And during these days, I have learned the source code of the
> "refs/packed-backend.c".

Great. I'm also starting to work into the direction of consistency
checks for reftables right now, which requires a couple more changes for
the reftable library to expose reftable blocks. I'll probably get to it
early in the next release cycle.

> The current "git-fsck(1)" implicitly checks the packed refs by calling
> the method `refs/packed-backend.c::packed_refs_lock` which alls
> `get_snapshot` and `create_snapshot`.
> 
> In the `create_snapshot` function, it will check some consistency of the
> "packed-refs" file, if anything is wrong, the program will die.
> "git-fsck(1)" relies on this to check the basic format correctness for
> "packed-refs" file. It's not suitable to just call "packed_refs_lock"
> in the code, we should not die the program.
> 
> Based on above, I have some ideas to implement the functionality. But
> before I implement the actual code, I want to share my ideas to the
> mailing list to get some feedback.
> 
> There are two ways we could add consistency check for packed refs.
> 
> 1. We simply read the raw file "packed-refs" file, check each line. Of
> course, we should also need to check whether the content is sorted.
> 2. We may reuse the data structure "struct snapshot" to do this. And we
> call "packed_refs_lock" without calling the "creating_snapshot" instead,
> we should just check. The reason why we do this is that we could reuse
> some functions defined in the "packed-backend.c" instead of repeating
> some logics. However, this way would be more complicated and require
> more effort.

Hm. I cannot really say much on this. The important part is that you
have enough information at hand to be able to implement those checks. If
you have all necessary information in both cases I would recommend to go
with the one that is simpler.

> However, one thing I am not sure is that should we lock the raw file
> when checking? From my perspective, we should lock the file because we
> are checking the consistency of it. If other processes are processing
> the "packed-refs", we may encounter inconsistency and things would be
> strange.

The consistency checks may run for an extended amount of time in repos
with huge number of refs, and locking for the whole duration may easily
cause problems.

Furthermore, "packed-refs" files are written atomically: the client
writes a new "packed-refs.lock" file, syncs it to disk and then renames
it into place. This operation doesn't invalidate any file descriptors
that refer to the old file and you can continue reading from it, so the
snapshot would remain consistent in itself. It could of course become
inconsistent with any loose refs, but that's always the case with the
"files" backend and something we'll have to accept.

So I don't see any reason why the consistency checks should lock the
"packed-refs" file.

Patrick
