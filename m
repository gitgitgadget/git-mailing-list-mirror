Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878DC1F12E0
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755556303; cv=none; b=M/QcSgFXuicsmTwvgqmlU3kzTrM7AvU9kwvHiqWMoyIOTPqDIFtGoad1Q+EidFNf1Lu7W/t2CM3px2oinBPwCiKDKuIEm9sPiqXqeioUbHgut2qXLRMOQplYq6HPxvIgSNDAQ1afOA8gZBEhoXZwoE17V9R5p5o8hfLlwle9ww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755556303; c=relaxed/simple;
	bh=N8G10C7kskVvLyWARvRxq79Jruc7EwSHc4nDR/oNvJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fIycXgxl7gIvKDDZVvnVgmwkbTarECq5bg9HYhzBOipA9ltvTPR+9g7PKNqHGhSPpPAfHT2Fs7dgu5DtdmXG3NmSJvLh58GAho4+E+L/e1RL4V8aXSc0DvVH5JnlybzjTJYZyQj1tbVfD8imwG4NhtwZc6facaD2xnCKtItkY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HkXcsmPn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CqaXtUQ3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HkXcsmPn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CqaXtUQ3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 13F661D001CA;
	Mon, 18 Aug 2025 18:31:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 18 Aug 2025 18:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755556299; x=1755642699; bh=qclz9Nh+Ux
	D15cPGzVq4Yksgx5sBt7Bz/jtYZiM7ssg=; b=HkXcsmPnfJiEFrT4Ylas/yKp7k
	fkl2TWKUxhPEL+2wjl57qOurAidMomcEJH3ZMpHkzT1Oil6qJE2jFe8d1M1Ai0WR
	dw5R2CBX3LXZUxHagkbLC4286HFtMhyCGm2kDCXQGUDt1RysmXw+BqAX+ZtNX1NX
	0BgT75/VVZHfGQpAo8aOMuzmf+BygA9CFNEjE/MfOooHULCQ1MDtkeEr2Xqkz8h1
	vPROjMlSCc3k4icgpviw6YWWJTq6Nvej4FXZ3WltMHqyTH8aO7B0GKLCrfJ9WI2A
	E+HzuvTn4sRC+1SyzZixPqnYEqgxRBVk4Km2j/NFDzcHWwbsaKiIDtwhon+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755556299; x=1755642699; bh=qclz9Nh+UxD15cPGzVq4Yksgx5sBt7Bz/jt
	YZiM7ssg=; b=CqaXtUQ3WNFOEgwjBIcfOQkIzOaZpwvobGbEcQmQws1jfyc/M6N
	uauIqjl9rSnxe2FuoSHJyx6psLICJM52nO4zYt9KAKBRhJTyQ9eODtT9nYsdbYGn
	Z5nrB9YL50m9SI7N7Inhme8V2CSVJi1vn7suzsiNzEterKIEGC68yzR+xglVDzQy
	GeCJtW2pimdMtF9Xae4WGu33OQ+5Wh38VrAFgfi69ogsVrqZ5s+ZcCbESbP2SFHY
	6ZdkzwIochv4P9kmxQ2yl+lBnL7pdhkszZw9XzYsCix8yawD7CpB6vjXV64O2peP
	nSeBwIzHMYv4TkjAjmjKFKEVVpRHqyGri8g==
X-ME-Sender: <xms:yqmjaGxP8nzzPfJrOJN4m1KAzUg_BRtzAeTShTAxQq7aCACmkXQLSA>
    <xme:yqmjaDpwMSiNR-B9rbB80WXv1c7hWnlYPGxpujwl3JUYbugVpraCzeWYH3uSLDo3r
    N2phPXPqjeCZUtf2A>
X-ME-Received: <xmr:yqmjaBmkD-XEl1-O7e0_5b4Bkdp-t_0nb0LcdxIQXZTQAjijXCVzdhEIOxMRDnmGwNDSR7UXJZCiXUaVzI6Xy94QiQ9-I98irF4pThQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheefkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegv
    shgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegtohhnthgrtghtse
    hhrggtkhhtihhvihhsrdhmvg
X-ME-Proxy: <xmx:yqmjaEwLGo7PzgHXGjRRRQEKNyYTb16CsS5Kol2lVhj2hJqWt4a2HA>
    <xmx:yqmjaO0g804O42L2RREt1X0rFt31ZHc3kspd51GJsdyYrWP-WTykbw>
    <xmx:yqmjaIBQeQI7d3vSr3_4XA86JunM1Tsgu87pfQrF24_s9mzNSpUE8w>
    <xmx:yqmjaL-Y6fOR75W6E7_oieTJTnQLKcSzX6QnWGKk2XQWJuYpB20NYg>
    <xmx:y6mjaMginw53ajCwYEtoLr-SQITe8kCe7sGNzwbxWGLCfprgxInJAY0A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 18:31:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Taylor Blau <me@ttaylorr.com>,
  Christian Brabandt <cb@256bit.org>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,
  "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Matthias =?utf-8?Q?A=C3=9Fhauer?=
 <mha1993@live.de>,
  Patrick Steinhardt <ps@pks.im>,  Sam James <sam@gentoo.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Mike Hommey <mh@glandium.org>,  Pierre-Emmanuel
 Patry <pierre-emmanuel.patry@embecosm.com>,  Ben Knoble
 <ben.knoble@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 00/17] RFC: Accelerate xdiff and begin its rustification
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Fri, 15 Aug 2025 01:22:35
	+0000")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
Date: Mon, 18 Aug 2025 15:31:36 -0700
Message-ID: <xmqqldnggt2v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * Code style: Should we adopt a Rust code style of some sort? Perhaps have
>    the code always be formatted by rustfmt in its default configuration?

Sounds sensible.  I'll let folks with more Rust inclination to
figure out what _the_ style should be, but having _a_ style we all
stick to is good.

>  * Rust version: We are not using the same Rust version on all platforms in
>    CI; 32-bit builds and Windows builds require a newer Rust version to
>    successfully build.

As long as we do not have to bend backwards on the code with "if
using version X or older, use this alternative codepath" all over
the place, "pick a version that works on each platform" that results
in "due to the quality of ports, some platform's older port is
unusable and newer version is required" is not too bad, especially
for a system that is still rapidly getting improved and a bit on the
unstable side, I think.

>  * Performance with whitepsace flags: I originally intended to leave out the
>    whitespace handling because I knew it was slower,...

If the Rust guinea pig were different from how each line is hashed
in xdiff, which is targetted by am/xdiff-hash-tweak topic, then we
can leave out the whitespace-ignoring hashing from this topic
altogether.

Quite honestly, I do not like throwing away the other optimization
efforts that can be reviewed and integrated trivially, but it is
practically impossible to do so while still have a "let's start
playing with Rust" topic that targets exactly the same area.  Yes,
this topic licked the same corner of the cake first, but still,
I was hoping that the second iteration of this series would use a
different code paths as a Rust guinea pig.

After all, the primary objective of our first Rust topic is to set
the framework right (like the platform and version support policies,
how foreign interfaces like type systems get impedance-matched, what
the impact to our build infrature looks like, etc.).  It would be a
huge plus if it can at the same time demonstrate how much safer code
we can write with less effort if we switched writing some (and
gradually larger, posibly) parts in the language.

The result this cover letter has in its title, 'accelerate xdiff',
is not primarily due to use of Rust, is it?  As the other topic
demonstrates, it is to use an implementation of a faster hash
function (we can consider it to be an impressive technology
demonstration that a rust reimplementation of original C code can be
done in a very performant way).  And nobody is expecting that we
would be using Rust for speed anyway, no?
