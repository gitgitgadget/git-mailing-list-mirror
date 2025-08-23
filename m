Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBE2E413
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965691; cv=none; b=DOKsmBCVnbU8Y7q/d8qBkYlWLylp1B32QIDFutFJQaHjmEJNXXvCWr7oQvhujXGKe0MwXAEuS0U/M1DOu+qzV5+P0uT/EfyO1yHFRsGIG8s4TW5WWLRbhGNgiNpJgQCf5hVcaRRQi1njlZ+hBjTS6cFgUITBeuwcayr8kVtTuq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965691; c=relaxed/simple;
	bh=gsZKNhBQCa6DJSgVkXRof/ugswdytZfmh+gx42nwrrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hdjy8CDawH913QAUID1bmow/oWitb9jSgZ1M3ItJoWnH1NUZCZnSRx1dMY+a+TiXmkdpGNpCAZS0NPQtA9ddZUngVH3dZynfyKk2vKsUNPoIn7FaWWhcrK9qgga49f8fiV4J0uP6bECafDsJzAkL922gB6cGeijDF+hyYytjBMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jL9n/JAQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S6+p2eYz; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jL9n/JAQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S6+p2eYz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 09A187A0077;
	Sat, 23 Aug 2025 12:14:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 23 Aug 2025 12:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755965686; x=1756052086; bh=Gg108WfoCE
	7fmuBrdbjFT1t4j1FdvlD0oH+vi52BR1s=; b=jL9n/JAQvHOgPUwyhX8Nbz5Qfw
	lYOfc/YmJw2UY/CE+L3/U7iFrgJvOIXECvX2dffyA9pqdsnn8cY41C94vogfoqZV
	/BF6+2ViY7P5mjL4TtPqtriXsU50zKpy1GZ6z5pOFBqlfvgKrKBCLljnWvSmtaGB
	irRPaM3tOd9wleXrwX+C3Fc7QzzD9VjpX1WAvrCVRp4RD1JkSYTEHlCGejGSQcj3
	HAeOSg/7b6Ty1SepiP7wi8hXxgAN1w28jqYrGAzu8EE9FvPKKzVSqqlX483rusfp
	vQnWZxVDRHKi3t48qGMb0OrCuOkvuYrmdwcia6IQk38SFIVSuPgB/oP4/zGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755965686; x=1756052086; bh=Gg108WfoCE7fmuBrdbjFT1t4j1FdvlD0oH+
	vi52BR1s=; b=S6+p2eYzwCn/DWJBsZTjZf/XX4JuDInQCuClXo68SwyK5ojISR7
	XhSbn+1G76mfamPkAdp3N/uy9T3K+PGbND/YcikpCm+2UwfINo4XiPK8Lf8LxUNC
	NdkjkGjGF1trmRuCsaOGpm5wviSq4+5Z7hRB7Da57gvrVpMAXTV6fpKuJK0P1epe
	Zobu06mCrUMEAhDTnrzcAYMzdbFf77M+3iHULpRKp6T9ALeMZxeBRMl6sjgOiDGE
	OAEx7DJ/hoPklmlNTtT6YXPfxzxF1M+ElYPM9UPRSEb7Xil/hCLXwEj7a8IZIhgA
	ElJrl1spRzRn57HT/s4+w3qOAutn7WZnP9Q==
X-ME-Sender: <xms:9eipaNMmACwaSOBttCQuiHKaXbnqkaWU-vxHeJk2nTFyyry4SuBVmA>
    <xme:9eipaFEO1b2HexYs_75xT3VUUGW7C6qxknw8-xkJ6FHV57GUfhrdycL0B1VQ2xq4K
    9LiMoWGNlQj-OxY9Q>
X-ME-Received: <xmr:9eipaPO1ESzFZIQEAH4btjmIly0YLkSKcRyYXmcwIk_k6do8jgPqZsGtdGROgTo-cXDplMl9iJQ8ulex2akvk7HayOXYUrXHJ7JmjIU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieejtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegv
    shgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegtohhnthgrtghtse
    hhrggtkhhtihhvihhsrdhmvg
X-ME-Proxy: <xmx:9eipaPsSU1Z-KI7uOzI1PrkmzCa48EkPQTWDgZUUUgGf5HAkG82F1Q>
    <xmx:9eipaMXl02nFqEjEanoQ2B4gQiv2gPUdulmUQMnZUSzo5Q4JZYVEOw>
    <xmx:9eipaOS5VyDp5od-jZrP3LJXWHHJ0ZnatpBviK0BqR-zqbCDQJbXpw>
    <xmx:9eipaCLo__8kVKnNkyyzUDhjdej3kNdWLnWBaEHXWxyIXW8W1TROcg>
    <xmx:9uipaJXQIcTju4Ya_pageYcPU-UYnDyWWa2jOdZlJ5S7QJwvE0NFFV-m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Aug 2025 12:14:44 -0400 (EDT)
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
 <ben.knoble@gmail.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 06/15] ivec: create a vector type that is
 interoperable between C and Rust
In-Reply-To: <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Sat, 23 Aug 2025
	03:55:47 +0000")
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
	<db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 09:14:43 -0700
Message-ID: <xmqqo6s6uia4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
> index e69de29bb2d1..8b137891791f 100644
> --- a/rust/xdiff/src/lib.rs
> +++ b/rust/xdiff/src/lib.rs
> @@ -0,0 +1 @@
> +

This triggers an "new blank line at EOF" whitespace error while
applying.  Intended?

