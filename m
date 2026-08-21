Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA34B48AE06
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312426; cv=none; b=HAJvQqCOlhXRFNs1lfOBKkpLE0IghJg/ZmiBaIQhGKyxU9ktP0Wax3uZjvvJ8zGJZhjkGWU5yVMEsEEiP0HAwdtjrXSKruRDLtU8lZJLBgz7vjG3i4fZQ4OZlUVdxUy/0QksXW1+YufvdZO4KDEezDZ38MMNamDm2gxf5OS7SJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312426; c=relaxed/simple;
	bh=Re3wdv3EK6Zk8Neg61o+goK76FZisHM6BPZOxsp16u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdUdzbJ191UCFtWSb2TQefbO1hvFvAG8tnA7SZNhVqf8JxQHoGB+CgatQXv/aGn8SiKENKrrN5/ln18JX11kBt4GMYTPqJZbo4usIXsia3TXReS5+Bu0caPudOUooGwBQBn7dLx2yz3bxA06z/4Fht/1neBNROYv/p0qfvVBhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kx+abGA/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NkUdL/oA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kx+abGA/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NkUdL/oA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B5E7BEC0203;
	Fri, 21 Aug 2026 07:40:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 21 Aug 2026 07:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787312421;
	 x=1787398821; bh=ktAYWzgV4eUvXSku7Vvo6QMjSwUnBYaMTO9c9EnKg/8=; b=
	kx+abGA/5w+2bKSBZmm8+CU1cClrSD+ihOz1d+mqDYpcLeFvTA9bIhVcqPNELeYg
	7s2FqBlQvKhRvX5FKbgpVz5Vv9buS+Y/t2ccgif3gLIbGJaaYmCfKCaRy6/I1l3B
	cyiNvzHmvC5spaf7lzqESscB/VmiYGqeGrKODCGq7z+K1y0KLfxh+CdqHcjgqnAa
	XiS0fjUr7dd2z64ZyHjtMOLeHI43cOrnjp3mBBGaKgSSp4ppkdzY3DeX0rHDgc2E
	bgGkdKFgPCsbWOkR+brlDzIZlnXtTP2J61qMVQrfyHINhXXeuaMagcNxgvlWWUR1
	nC9Wa4UaLkgA4ZflBeQdcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787312421; x=
	1787398821; bh=ktAYWzgV4eUvXSku7Vvo6QMjSwUnBYaMTO9c9EnKg/8=; b=N
	kUdL/oAOzcVLE+vRJE0mDzfvxZ8hmAz8dAlO1HRRp06vmx7SEd44RzzFnpkCv5dz
	NPsrCbyai52N5us1PtWuonv5pB96UnI6aiqGksYfjqIiBy54wG3bHPjBwM9IIBpw
	OOEJecJFeAM2C1RrGQpzJrFNKFAxRaPu6M68N+oUz1/jhaBztur9qwD7oys2tzVK
	MEp4v9rwOGL+j4CUlkREYNrbC9cj70LEVTbBSLfI0iHM8M211VB4xxfaSoa/pXYD
	eIosNOMggy+lEFVbyyvC5yBtAG4QLuxKP6PhatT2k+ofTRZpiVSC10BQ3LVqcmXi
	i4rQ60jMEwBSv5m4brzdw==
X-ME-Sender: <xms:JTmIaumqvfHIZUbztgYiL8nHR08WGMLLNFy3-xziw-U6Nol-mmh8Gw>
    <xme:JTmIatQS7aPmzgipjAXG7BXpFqN_sLiGhlcfgmTsoZ6elKuuFhgqskpK9JT78wN3v
    PtXI9CnjqzC_8aVNjRDiXNu7QseG1S1_n3EfJk0BHhxXGRb9NTGgPo>
X-ME-Received: <xmr:JTmIaqCEyTJyY_OHdMT-He0Vs0PF3cfB9nF8-JP-QC3Jvkb2MoAxd4zsyg9qHNh6uQN2yT3QvHwaYhhTZKYqPACCwvnNbPKKw7NDOyrIFqgp>
X-ME-Proxy-Cause: dmFkZTEDKKYZLOfHYMF5xOULa+yxWIFsLntuF13+Nde2rTa41l3MyLlREKnkPT1fs9+Ubz
    0YBfTwavx4ZT0WeE0roKmv4V7lKcmlbgP9gVw/1EWMSyGTDdp0wPm/cY+LMqw6fPOIRN3f
    g7C9OOksDgL+cd7mRUdd0mZ7V7CEOPetTcyWx/vgsJ2cMtDrYeWWoolM+wchZB+xcaNAB2
    S03sDGJY1eMgCosVzag7KyDLVvE7kw4Q3aVAeM7AWI+oaGm7+5dnb0g/qNDL+qnQ+e7mAf
    VxoQ0PuFb85enIPve3DKOBQuLWMtQldYsEDk+iWHtXjcv0V7gVp2f/KxTEA9GqZzSlYco1
    8rlPKYdZoL98mrubMHM9hgv4iTcMGRw0fYtJJ3Bgzvd3HsrAeHdLpLjQ7cEMHZka1D5+B7
    NbZN/JlMHaeEaopqh6ZdHx8HYfqWeyCcjk1U44P8auEKZXp4Mvi+v5zF8Mp8lnnnTHf6+Y
    N/25U3ca3P4betUcYA9w6uKNZ9oYHaBJWuDmKd8DMNPXzcMGj+mLGfJSWRz38e/ctpPkEf
    4WuF2uBsxH0T/ysbPGa9r3kNq349PH4ul1epJCySLHUKyWJ3Tj+1Rh8W5Efdzzxv1VLZr1
    8+8jUj7bn4HuHKC0MQbcq0141pVTR6sBTf263+MDXlKqSjUSWeAOjSQ8zgGQ
X-ME-Proxy: <xmx:JTmIasS7P5ktDO12VQfCLO9-OQCy5dGuZ4W3LQdO_4M81fb0uZOFQg>
    <xmx:JTmIagqG5v2QmQm9QsFb0yrzY2qwoSuZbSL58bp8w54F-Juf-951YQ>
    <xmx:JTmIamyPXX8QsbN-IGQMPuTLXm4ZJG1WFu59AKa3FfEVgcgeI_yKdQ>
    <xmx:JTmIatIiFJfBVSiahrSeOxqOXQgRBoAxEw3xoDTvuiCW9WseYS-YYA>
    <xmx:JTmIarfw7Cva1Gsu5JgbhKwE21cOztm1j2U_9MFFfwo9UgdStjImxrjQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 07:40:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d98e786 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 11:40:18 +0000 (UTC)
Date: Fri, 21 Aug 2026 13:40:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>
Subject: Re: [PATCH] odb/files: be less aggressive with geometric repacking
Message-ID: <aog5Hwp5EQA0k500@pks.im>
References: <20260811-pks-geometric-maintenance-reduce-frequency-v1-1-7a54c42355ac@pks.im>
 <CABPp-BHgyVTHB_OGmCL4JprFFe6_MapOQNSjUOhJxu-+oWbErg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHgyVTHB_OGmCL4JprFFe6_MapOQNSjUOhJxu-+oWbErg@mail.gmail.com>

On Thu, Aug 20, 2026 at 11:40:46PM -0700, Elijah Newren wrote:
> On Tue, Aug 11, 2026 at 2:17 AM Patrick Steinhardt <ps@pks.im> wrote:
[snip]
> > Being this aggressive is also causing problems as reported by our users.
> > When running lots of concurrent writers, those writes will constantly
> > end up spawning maintenance jobs that end up repacking objects. As we
> > also prune objects, a concurrently running process that tries to write
> > an object may see that the sharding directories get removed under their
> > feet. While we try re-creating such leading directories, we only do so a
> > single time, and it may happen that the directory vanishes again before
> > we had the chance to create the loose object. This is not a new problem,
> > but it is exacerbated by us running maintenance this aggressively.
> 
> Unrelated to this patch...but should git avoid pruning the loose
> object sharding directories?

I was wondering about that, too. There are two contradicting arguments
to make here:

  - Pruning the sharding directories allows us to quickly determine that
    an empty shard cannot have an object.

  - Not pruning the sharding directories may avoid a lot of write churn.

The question is how large the impact of these two individual arguments
is.

By gut feeling, I think that the first argument is somewhat weak. Not
having empty directories means that looking up a loose object by its
path will be slightly faster because we have to walk one less directory
in the hierarchy. But this really only matters in the case where we look
for a nonexistent object, which does not happen all that often because
we prefer searching packfiles first.

Furthermore, iterating through all objects in the object database will
be faster, as we don't have to open each of the directories only to find
them empty. But again, that's not really something that we do all that
frequently.

On the other hand, we _do_ have to recreate the loose object shards
quite frequently as that's how we write data into a repository. And as
we've seen, pruning those shards can easily cause races.

So in the end I think it could be a useful thing to explore. The only
thing I wonder is whether there's a good reason for why we prune those
that I miss.

Patrick
