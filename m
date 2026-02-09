Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1836E7082F
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652744; cv=none; b=oszvH4DK37445HwcJ26UeWgOCM+Va2edxP6kkFK1YySBOczJRsr+kqDU+SwVpepc7pm1NR0HTsri+jVnyeMI2rFER1XC1qvwnMzmVhG0IrfwBh90BY60M9n84XYf58tUR8STowpqDRczJiljlUgBCpBjQ1nZAIlHYOgf/pYdN1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652744; c=relaxed/simple;
	bh=UapVMwQFh3XYhZQSP7NHXe5s/NgSMkZ/56ldzdKX+y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/FdFVwaXhvxfgNJtBVz5UuWuWlMpZQc6hiH5dA4is0Y8LEyIGtZOGuiUrrbQwYLN3kP0HUMMFKkUQbya7jbFSmAq1kEHMSZaUrOqbXhAuBlP/zP8GG/FP3mePwhwcFGP9WsTDux+tdBI29yvUZ0QGhsHcMUnJPuuBXD8FJmqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d4rqd2pW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E0yIQqXz; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d4rqd2pW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E0yIQqXz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 200CF1D0013B;
	Mon,  9 Feb 2026 10:59:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 09 Feb 2026 10:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770652742; x=1770739142; bh=Qm45VMr/fb
	7if8fOHlZQBINY41V64BVGqsD7LeB1DjA=; b=d4rqd2pW/KuV5KMds7JNh4wLKV
	nooC7KI2Zo6ql6C5/8xa9sHZc+X9ph0GHJWApY3LSjKS6XEQTzvBeCQOwLPXDfI7
	YmdCIwEtKTgB1J5xjpGQ2mmaVR1L9wKdWliSwAzM+kRw8wTuZDdnQdfGpbcNORWa
	nh58ntVb0L4baWcY9geigMubq2kIh2kj4Ww9EupbAEepjsYRj9eZ2+OnPeZiMS8A
	i0tx4GhPxM7huV0HNReW89PwB3XhXTzVXLcso5fDrMfytlS6aS4r0YcxhY7HQI9j
	tw4X1ra5E8iqj8mHZybimAcLK0nKy2TD4ZhX636q9gzq2N6tdNYqBzrlUefA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770652742; x=1770739142; bh=Qm45VMr/fb7if8fOHlZQBINY41V64BVGqsD
	7LeB1DjA=; b=E0yIQqXzPjssaeJATUxXdUxriHn3H3TcApVzzQcDKk13AR5x6ce
	tMjdU8GZoTgILNOsR0mjSrZC7aSRbayGQBrBw1nqpxpnEyaChEXey7nY+Y4mI4JX
	Pc6Cv9y87NctPMp9km3Y9YIKwS8Nhg2GG/4z2WddTDF92REa8XPSw6QcZlOB7kVx
	YgksqMHB+z6ba92pwafuMS5cTO25pSI4oRPUGi54pZ5BGgChsCrU63aAxVEmBcOf
	TaHBC9iDrjvYA/7I2rq7P6BAcEar0m6Z/lV4c821Ge37GocTf1NI0vv8Hnjozk3Q
	p/mmenyqmvW+ROMmtSLenLpWK8w/mu5Cw3g==
X-ME-Sender: <xms:RgSKaW8i6ykValkRnKSTYbnNxEK_NtV0FWbPLBRJJHaNK9t3d6W1RA>
    <xme:RgSKadlJjjV7LktJsFViMbBQ3YNLqHxkW6Xx8ASB8thoHGRecOm4iMvJJzx0azmSj
    a8-3PpqVm4m9qLD9WesNk-2dkftrbH_pMlGCNgYug4hb9bFrQmBuA>
X-ME-Received: <xmr:RgSKaUX6DIkftRsd45Co11uXFnUcVDFglC8uSNKVpjimJlTL1akMorhCe7jVDEkDlrrEHqoL77giyHRRFGpBhqpuvMp_8Tmy3Ibt5jckcPM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmrghilhessg
    gvhigvrhhmrghtthhhihgrshdruggvpdhrtghpthhtohepphihohhkrghgrghnsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:RgSKaaG3nRYBDywhigkL6mU9Iamjiyal7aeA99IPeHE2rXnqfL6dUg>
    <xmx:RgSKaYeSo29bL7Jx4ex9_KW4zZwDFao1s0MFtN0Z6i-nwcSuWthffQ>
    <xmx:RgSKaTIHu6jWURrHHDE5k_DAlEM8g1XtTYAEycuRJFqqOK6aOgofnA>
    <xmx:RgSKaVFEajSYEN5bUmZcx26g579-BOrnNtjU_1DI2VpsP08C0b9AIw>
    <xmx:RgSKaS20h9GjJU-VewU-QxqrVtQrfA3sSUsjGsBHWBpVodPONhRnUvGt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 10:59:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6bb40b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 15:58:59 +0000 (UTC)
Date: Mon, 9 Feb 2026 16:58:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Matthias Beyer <mail@beyermatthias.de>,
	Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org,
	pyokagan@gmail.com
Subject: Re: git-am applies commit message diffs
Message-ID: <aYoEO0CcVt2Qjgnb@pks.im>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
 <hn6q2mdjdqezzvtxfxffmatctnlf4ttvwedfk7wnw7xw75gy4g@hetctv53f7bh>
 <20260206090358.GA2761602@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206090358.GA2761602@coredump.intra.peff.net>

On Fri, Feb 06, 2026 at 04:03:58AM -0500, Jeff King wrote:
> On Fri, Feb 06, 2026 at 09:18:50AM +0100, Matthias Beyer wrote:
> 
> > That said, I am no expert in either C or the git codebase at all, but
> > from what I saw from reading the git-am codebase, it looks like it tries
> > to find the patch by looking for three dashes on a line with a linebreak
> > behind ("---\n").
> 
> Yes, that is how the split is made.
> 
> > From what I read, it looks for that from the first line.
> > What I would think of here is looking for that "patchbreak" from the
> > _end_ of the email rather than from the top, that would have prevented
> > this issue, right?
> 
> The patch itself may legitimately contain "---" on a line by itself (it
> would indicate that the line "--" was removed from a file). That would
> confuse your parser, including in a way that we end up only applying
> part of the diff (everything before that fake "---" becomes commit
> message, and everything after becomes cover-letter material up to the
> next "diff" line).
> 
> I suspect it also creates corner cases with cover-letter material
> (between the "---" and the diff itself) that itself contains any "---"
> marker.
> 
> I don't think there is a way to unambiguously parse the single-stream
> output that format-patch produces. This is a reasonably well-known
> gotcha (at least around here). E.g., some earlier discussions:
> 
>   2024: https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org/
>   2022: https://lore.kernel.org/git/d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br/
>   2015: https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJDxAs9u=FGpHQTkjE-guhwkya0DRVA6g@mail.gmail.com/
> 
> There are probably more, but it's actually a tricky thing to search for
> in the archive, so I stopped digging. ;)

Maybe we can't parse it unambiguously. But what we _can_ detect is that
a patch is ambiguous in the first place, right? So maybe we could extend
git-am(1) to bail by default with a hint that tells the user that:

  - They ought to double-check the patch.

  - They can override the check with "--accept-ambiguous-patch".

It at least notifies the user that something potentially-fishy is going
on, even though it still shifts the burden onto the person that applies
the patch. But I guess that cannot ever be avoided anyway, at least in
the general case.

Patrick
