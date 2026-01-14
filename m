Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7444832D7DD
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416898; cv=none; b=u8QXo2FMhqZnNlrU3vOTfRl3zNqn6Z7B74mH33Ey57tPSVcNv/mQqtb1nivTu2cWWevva47f9pmJz7sHPM1ILseEN2HhmR/PYSXFGPWsOLrClneoIlqTIgPyRafG7yrZiK5swCcHXkArZQZIhZtSq7/mQbyEC3bmhdixTv0o3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416898; c=relaxed/simple;
	bh=9PHrnt+55lSlx8G8AV7ufwBRYNoKBerRbyl2TsRJ2mA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PtdS0yGoAFEisbFgCNlzHnWkDi0ZUXXpQwGS92mrNNS8GAL//8COY0OFdk/3lYOuFjv9zgqteBGmSqaqnnsqpjTj8yARdVCTXqoNqz9Z3MxSlWbI7ddevL09l0R1snDBHETcMrc0YY3A9UZTnK2tRD/4OJJDSUx7ZfOhJbiBd1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ju0xs+qW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aBOJii7P; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ju0xs+qW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBOJii7P"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A40331D00101;
	Wed, 14 Jan 2026 13:54:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 14 Jan 2026 13:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768416895; x=1768503295; bh=CvX9O43YPv
	zoLrtMfVoWVoWGQuoA5CqqjTheTyiDkZA=; b=Ju0xs+qWZN76SIJvQHsghrbcvg
	uQg8BZeFC4tBk9xDVNlJIvNu71rYNguVUxE+DkMWzSE0yOwlatqGXDPVLDiN8VK5
	vnxDhPzamy0zdmbLAUGlei4w4HPO5TH6rLNm9L21PnKdCbvYHeBqUS+tixaKNWGi
	9ZdWnkRGPH3wBiaBCitHSnzYZypC4Vu3kBErvvwfkxxYysDifAkTNQWZcUyG3TOi
	sfzBXpwHZaSFhjkw5rYrroifqR5ozrK/6yvCUpDhfhGAVtVPdxMsYwsB0Ya1M4fo
	nLoXWk0M9WziXREvZLSuRoyTic/1GWZpHmrvdh++JJJZQ05EYZu5FBHzeCFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768416895; x=1768503295; bh=CvX9O43YPvzoLrtMfVoWVoWGQuoA5CqqjTh
	eTyiDkZA=; b=aBOJii7PjLUW8EACjAlIaHxfGf/ab31PboK3DGvOF/urFdDOi13
	ijFyclyiXuqO+Bx7WAfUDhgsZTuhSZT1WdMY/QbMxIHBz1Tjtu5yAkQE/sSGK1gA
	ZVfgz/Fi2gO86xbNXliq7c/pFdwpAhGCGm7zj6M/LETNDzHOiBLsIAbXab909UK3
	mS69opkYkDH1ZeXRN+DU/WdiBQQomDeScsyfpfmp+zdMgT0BlEAF5JVS4E0l86Kb
	pwzm0fmktmXZ7q48Z4dYeEuPMWxJj4i4K9zCMaKT3tispcBoCMDus8ZOQj1/P3DH
	+RmZeJVYF7C9vgbS/E3qfA6diBCk6lvPMVw==
X-ME-Sender: <xms:f-ZnaYlmJDpfLYofw_m4S23SN3n_oO5rzFkTVTPavQHJeq9d_90OgQ>
    <xme:f-ZnaeukF-Wm9OMppUdpF6nn2NQWh6MzgRmgitJHCCv70r7yZB9dM9hnuneDK5MCa
    wnRgONEWC1KiG89yTQOdWhnKnnTh27LS9yjPtqVr6Y4Kd-NRxOU-A>
X-ME-Received: <xmr:f-Znae_s8j5AnozE0gZqJxO6CA-SxPJA_FXXxo1XdPNFSTBZLYDARwUETt6YDDnSpCTpUFdE-vWLuHOyYgBSNTjVlx7rdTK8yycfOhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvg
    htsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:f-ZnaQPGQkKZQwi9PWdOBEDHUTizARDBv0MIS43th9nc_BVo8Y4cUw>
    <xmx:f-ZnaUG-Lo6ltCUDYzwUeAcFqcdihQ0GQNJ-GVVJ6Bzvp5FmCTXsAg>
    <xmx:f-ZnaWTBvU6i5PUOwqG5Z6fH10ItZUB_KRXV5pqRdrmyqJ6HQRgnuA>
    <xmx:f-ZnaZt39FjrrlpFrn1AaNE8Vy1_4SqvsswuCZ4ZZCb2bWK1nI_r3w>
    <xmx:f-ZnaSuXpNfs59Wt22AXIpNfu9dCBu6vhrZFrCw3MfpbzAa9PIron67b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 13:54:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  git@vger.kernel.org,
  gitgitgadget@gmail.com
Subject: Re: Triangular workflow
In-Reply-To: <20260113214059.GC288857@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 13 Jan 2026 16:40:59 -0500")
References: <20260113170321.GA265671@coredump.intra.peff.net>
	<20260113183557.7991-1-haraldnordgren@gmail.com>
	<20260113214059.GC288857@coredump.intra.peff.net>
Date: Wed, 14 Jan 2026 10:54:53 -0800
Message-ID: <xmqq8qe0f2iq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> And having the extra output from "git checkout" is just extra noise for
> me, especially because it is easy to see only the second message (which
> looks just like the upstream ahead/behind message, of course) and get
> confused. The first time I saw it I thought I had misconfigured
> something with my branch.

It now is clear to me that this should be _optional_, so that those
who do really want extra output from the command should explicitly
opt into the feature.  After all, any optional new feature that you
must opt into by definition cannot regress end user experience for
those who do not ;-)

At the same time, I suspect that extra comparison on top of what we
already give against the @{upstream} may not be limited to what
Harald implemented (is it essentially the same as specyfing @{push},
or something else?).  I wonder if we can come up with a flexible and
extensible notation to specify what branch(es) to compare with, so
that we can use it as the value of this opt-in configuration
variable?  Something like

	[status] compareBranches = @{upstream} @{push}

signals that the current branch is compared against these two
branches, and not having the configuration (i.e., traditional
behaviour, which is left the default) would be equivalent to have

	[status] compareBranches = @{upstream}

or something like that, perhaps?

Thanks.

