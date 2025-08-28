Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBDA30F937
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383094; cv=none; b=QhimDu21mH3wvqimxC7Tts2bBWGEKC8R9Lwd3f73r+PEubGeVXxg9sVR0/GojtTwSmrwTfMik1HUwTgh7J1REE0ngd9lmRBzDoM27s3rSgCf91swnN4an2S5cjNrY0NnLz3fahCiZoBkV26dLbBB07z/acuQenMRWYrqZYagS7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383094; c=relaxed/simple;
	bh=5hCJH+rFo70151lwlc6s6sxh3Np/FwGbykE5J3FaOtc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kE3Gz/abUo1uCuUElVa5RrZgN+02gV6/dlNZALwxrc03/cb3Xp2agvu6mjjUFGqrMIGbmvotUSCEDmv/+5l+XcROzH0tGfQ8XjoGGSseOPrRQ14mwk/+j13smdEjxJUfDwDwqY+VrZRISVGwje1CaXGppGY+78Qs3tXQTwQ1sD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=LZ3Xitiu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SeVHWTuF; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="LZ3Xitiu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SeVHWTuF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B1970EC00D3;
	Thu, 28 Aug 2025 08:11:31 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 08:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756383091;
	 x=1756469491; bh=3Yv4AhK21YeMlKi8K8WB4+QiY6Wdm6Lg7esnZL3A4w8=; b=
	LZ3XitiuBP5sfnGMtDPzlh020BpTdH6dHjXB8IhSSrPgb7J1C3mKDwl0xWVEuEcr
	ypWeep5I8F3zCpVop1ixzO91mMlseHE1T96c9Oeef8YgjspRg1CWLCk93ZkW8Qfq
	fNoDuD1Q90ZbSa0t2sG6nvxjZ/XEwbDAdqYCL7PyUuPaw69+glmfsA19sfhiygpX
	WKHnfcGym3+HlGMuV3dXwRPsZw4d66yw5wiPAf7dd7LiL6sqmncSlD/bnTjo336s
	kvUFxdOlfCwzCfGNtt8vc6b8/oBmfWFmVHJUD/ViBX/bFVSv8C3KMR/bA3RqB8bi
	5xIqYv/W1M1GdwlBmgr6mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756383091; x=
	1756469491; bh=3Yv4AhK21YeMlKi8K8WB4+QiY6Wdm6Lg7esnZL3A4w8=; b=S
	eVHWTuFN48zCEIN4ZF4MVRV9v+XWRAc9oYdr5jEtjbttkpoWZUQmG1c2pPLgT4oI
	31Dy3k4a1YE8YX/HbUrgJL5It3w9exZqEVjE4NoO2UMKKDdQtm+Eu1CHU9LOzxR5
	WgoXji3NvAd+RiM7ue0P3dGb8JhC74Tr79heMbwKzqklqjPPww9oolsHB2FtQ0Na
	4LlQd58QiamYhhYU4JykSN7SL5IGidNcrGN1fMCqopsPj/ro2QozYDVuOm2BvO+u
	8pOpzdx//Eey6Q8Xbtl42vaieUZlhEz6YjjcJe9Vgdagd6ZqNpaix2XBWw8Dg9/Q
	oiMzj1W/0h/1VA2k7opSA==
X-ME-Sender: <xms:c0ewaI64vOWOs7oXzuPuTXdONTwbdCHa2ScUcrA8OLuVMVCWJPj8ag>
    <xme:c0ewaJ5ECO4MgwiApoioXBWoMvZoKHNvEHeEy0n0rv2rt--1ZAYdHsYY0LVJuglgD
    eWwJWjIMp5CDnVo5lM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedtleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfluhhlihgrucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhn
    shdrtggrqeenucggtffrrghtthgvrhhnpeefieeigeegtdefkeejgfdvteejfffhveeuud
    dttedvjefggeevfffhleegvddvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:c0ewaOAAYg3yPpgOpkun-T9bttMytS89thngA2GkF0VZ7HGlPvgRZQ>
    <xmx:c0ewaPYaZThauA_u8dz9ThtL7nCZH3gnqvlK8XR-lfl2Ym17XFguEQ>
    <xmx:c0ewaOj_nhJDVYV5gwan8amWxRIM-TwJgpccje9hivpqwarHZhkoUw>
    <xmx:c0ewaJ5vUE-6m9RUdX8QVYU5aKiEql4iEbcM1n3rKcm2ZjGi1r5K5A>
    <xmx:c0ewaNBxyo8mPKLFBB-_hntuB7QcDSejNaXqTLuke_k-z_HQQVMaHnvL>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 677017840CE; Thu, 28 Aug 2025 08:11:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvvqYbK4iQrF
Date: Thu, 28 Aug 2025 08:11:11 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <276630b8-ad98-4ada-aa85-9f136d653d7b@app.fastmail.com>
In-Reply-To: <xmqqldn5ix0r.fsf@gitster.g>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
 <b8873c4529caeddc85879efd122e5a57278352f0.1756148933.git.gitgitgadget@gmail.com>
 <xmqqldn5ix0r.fsf@gitster.g>
Subject: Re: [PATCH 2/5] doc: git-checkout: clarify `git checkout <branch>`
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Do we expect readers to truly understand what is to "switch to branch"
> without explanation?  IOW, I am undecided if the lost "To prepare for
> working on" is a good thing.

I'm not sure what you mean here: "switch to <branch>" is as far as I can=
 tell
the most widely used term to refer to this operation, in other Git
resources, in Git's own man pages, and in the error output of the=20
`git checkout` command itself:
("Please commit your changes or stash them before you switch branches.")
Which readers do you think would be confused by it?

> Usually with "changes on _<branch>_", people mean quite a different
> thing from what the above paragraph refers to.
>
> Imagine that you are on a branch that you forked from 'main' some
> time ago, built a handful of commits, among which there may be ones
> that touch file F.  You further have local modification to file F.
> Now you want to switch to another branch.  That branch, since it
> forked from 'main', never touched F.  Your local changes do not
> conflict with "the changes on branch" (there is no changes on branch
> to conflict with your work, as F stayed the same).
>
> To improve, "with the changes on _<branch>_" should be phrased more li=
ke
> "with the differences between the current state and that of the
> _<branch>_" or something.

That makes sense. I'll work on a better way to phrase this.

> I do not think "glorified no-op" is a reference to "status".  At least,
> when I wrote it, I didn't mean it that way to compare this glorified
> no-op with "git status" [*].  It is a reference to "even though you are
> invoking the 'checkout' command, you are not checking out anything."
> The side effect is to see the tracking information, which is "rather
> expensive side-effects"---compared to doing nothing, anything is
> expensive ;-).
>
> I strongly suspect that running "git status" is much more costly than
> "git checkout", simply because the former has to do a lot more than ju=
st
> peeking the tracking information; it internally runs diff between HEAD
> and the index, and between the index and the working tree, and it also
> has to find and list untracked paths.  Both commands compute the
> tracking info by calling the same remote.c::format_tracking_info()
> function.

Ah, I thought `git status` was faster because I benchmarked it it on one
of my repositories and got these results [1].=20

Now that I see that that's not what "expensive side-effects" was intended
to mean, will change to something much simpler, like "Running `git check=
out`
without specifying a branch outputs the tracking information for the cur=
rent
branch. It has no other effect. "

- Julia

[1]
$ hyperfine 'git status'
Benchmark 1: git status
  Time (mean =C2=B1 =CF=83):       6.6 ms =C2=B1   1.2 ms    [User: 3.2 =
ms, System: 5.1 ms]
$ hyperfine 'git checkout'
  Time (mean =C2=B1 =CF=83):      29.5 ms =C2=B1   1.9 ms    [User: 12.6=
 ms, System: 14.8 ms]
