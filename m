Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0941A7AF7
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371663; cv=none; b=Kueh91G0EwOqZIKq1mKbgoI4aWc3+oW98SxrxRKJ1Gs9qbcPKporidzPU8G8+LwGyoF+qBjnTYfzrpbpR81Wt2rNRftNMN0daDvxVSOi7hVrXFlJHEF3WyIRWCWYcQBFTa+441LvPwEegbo6FHtjP+aDydZcmZg5tlRjxrBSjBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371663; c=relaxed/simple;
	bh=UvglRUhlzarDjaNNJxeAV7iVdNRX3mCQLw0NTJEJCwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h0ayUGzEroXwsElMuV0+5c8nV11ceSQYVpfJT24m3GjLHS4+mTt9OG11yFJ6PugCVn3JHkjK9QYzVLdRRTfcpypIzosTiZfjXBDpQtErY+pNJ7jg8qSjI0OGeTiRyx7WaYssMsNVpt8cmfoSWpzNp73AWzUCz050XQ7VMqD4X+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wOWXNxGY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZTmKsygz; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wOWXNxGY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZTmKsygz"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B08C114019F;
	Fri,  7 Mar 2025 13:20:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 07 Mar 2025 13:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741371659;
	 x=1741458059; bh=BZ/TISiE7S3CGcn+GgbF8OYmvvihEUTj+ccOXBx+/cE=; b=
	wOWXNxGYeuTGc661v9EDH5DYc8HR/Y4YckYaPr9c5gZB9LKUq3Kxf1Jp0dLUC7RD
	eyIYOkzvVrMMZZYym0hpalZAoLxMtGJkMbtKUNHZ/dMWXqNGk8DEN3vJV1Djd1aX
	RL/X8/KtW/PuxzokaFaMksUPgtIapmbFrfqKZgWptWP9WWgRCjuNa4f13W/lb7YC
	Nt3E1K18PiCkPuVFQE6qyrO+QqPESnRtjoI7uWtyJpu1I23NMWTTbGuXixHqzUUH
	aUh+ZB/j82mM6uwyq51tpKTGIkNQ2XjtHt1Q9QJwwfcgppznTc9zfFt3c1NODIh+
	oILGIoAPAcIXHSVNvrgjMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741371659; x=
	1741458059; bh=BZ/TISiE7S3CGcn+GgbF8OYmvvihEUTj+ccOXBx+/cE=; b=Z
	TmKsygzvhEeZjMMPprizAJF7XVEtkVCA4IkGIn7Tl8Qzut0MwoC5ttXE7FIBd3Gx
	8HuQ6RrIpMOxf+nJn+60dd1wdOH79CC/QgZc4pLpk+rZIjqjaKsD2J3R7MnMINws
	JVsXt98xy3HMriqLHuMqCPuA7odno6gcpNiBpnHizx1jFTbk8WrheGmQ2n+9K1pc
	Rz0q+fwdsxy5q8XSxdrb+pwH0v+se5IFgmurEDP37chN0b72AAXuHirPx74zIqYa
	EdlL7/nZpbxS1SGUIlbb5oAWbAu5hnBv5El86NBkyGMZlzBasJsz1FuwKKbezUWx
	QrRkd/acGnQT/yOBRjNfg==
X-ME-Sender: <xms:CjnLZ4vZaDHGrD0CFvD4uikxbB1m4HzVGCmidpplQfpqRM8G12dNHA>
    <xme:CjnLZ1eeMZutHPnzJpSK8nyBu7GL4RfvahSjmPHoz-oTYrTdDq67r0AlXDdDf4PtI
    2QfJObgMIjzzbDwng>
X-ME-Received: <xmr:CjnLZzzt9gmjBoRqaPEGvFUw8o8I3U84P0MeN1ZDDFnkL_QlXMpyIw9dhuurl6sif9-XDmOqLZklc9Xh2zj8Bq-LewTs9DaP1zTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddufeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CjnLZ7NWehefVt9f-f56jKHdz47vclwFeynO9mczFDa_-p2fXuxgIA>
    <xmx:CjnLZ4-AQ0zK7fXHsqDeRPuR8jAd-bNUDe4vfQUeAffPxHu5G-YjWw>
    <xmx:CjnLZzXT-CTUrSNb-FhhR0shQcPcb6cX7YTRSm7O5DiPJo60zj8tFA>
    <xmx:CjnLZxcdLWmwVyXG0mihPTgBWRnip5N9Qix-vM24HP87ap1avGM26A>
    <xmx:CznLZ3l5m_2cqcmjxQY-rrPFf_lXsMgyYRbBmoQ0darRiv6a4i3TE7XO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 13:20:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] ident: stop assuming that `gw_gecos` is writable
In-Reply-To: <Z8rEIffQeVCjd_U8@pks.im> (Patrick Steinhardt's message of "Fri,
	7 Mar 2025 11:02:09 +0100")
References: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
	<pull.1867.v2.git.1741256780.gitgitgadget@gmail.com>
	<3e9ccffc7474698947bdcb6d49b5d0728deadd08.1741256780.git.gitgitgadget@gmail.com>
	<xmqq8qpijezc.fsf@gitster.g> <Z8rEIffQeVCjd_U8@pks.im>
Date: Fri, 07 Mar 2025 10:20:57 -0800
Message-ID: <xmqqjz90em7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> I think it would be a bit sad to disable those jobs. They build and pass
> the test suite alright in Git itself, even though they fail downstream
> in Git for Windows. They help me quite a bit to ensure that I don't
> regress anything that already is working while I'm iterating on the
> current set of features. So in the end, I view them more as testing more
> variants of Windows than replacing what we currently have, similar to
> how we test Git on different Linux distributions.

Hmph, but compared to Linux or macOS platforms, do developers on
Windows (and users of Git on Windows, including but not limited to
users of Git-for-windows) benefit from having the code base to be
tested on "more variants of Windows", or would it be more noise that
they need to go visit the failing CI and spend time to triage if the
breakage is something they should worry about?

The above is more or less a rhetorical question.  I think by now
everybody knows I do not like monoculture, and if we had infinite
engineering resources, I would think it would be healthy to have
more than one prominent and competing Windows port of Git (no, I
know about Cygwin, but I hear that the platform is POSIXy enough, so
I do not exactly consider Git running on Cygwin qualifies as "a
Windows port").  But we do not seem to live in such a world.

> I have said before that I'm very willing to help to figure out any
> issues, regardless of which platform, and I stand by that
> statement -- if you see anything that is broken in this context
> and report the issue to me I'll jump on it immediately.

It's ultimately up to Windows folks to take you up on the offer.

>> > Nevertheless, there is currently this huge push, including breaking
>> > changes after -rc1 and all, for switching to Meson. Therefore, we need
>> > to make it work, somehow, even in Git for Windows' SDK, hence this
>> > patch, at this point in time.
>> ...
> That's completely fair. The CI job we have isn't meant to verify that we
> have a G4W-compatible distribution falling out of it, it merely verifies
> that we can build and pass tests in such a "standalone" (that is,
> without the SDK) configuration. We might eventually want to introduce
> another job that _does_ use the SDK with Meson, as well, but I didn't
> yet see a need for that until now.

Knowing that it is the most widely used platform, I naturally and
naïvely was expecting and hoping that there are folks other than
Dscho who have enough bandwidth and inclination to help in this
area, but so far, having a set of jobs in CI that use a toolchain
that is different from what G4W uses (as expected) did not quite
help X-<.  Nobody noticed it until the last minute.

Which made me say that we do not seem to live in such a world, which
in turn makes me accept that putting all Windows eggs in a single
basket and watch it closely may be a reasonable alternative when it
comes to Windows [*], than hoping that diverse set of different
builds eventually help flourishing Windows developer community.

I dunno.



[Footnote]

 * Yes, I admit that it may be another way to say that I do not care
   the particular platform deeply enough.

