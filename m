Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5041D61A3
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754544059; cv=none; b=pjWMS8anPHG+TQCeYg+wDGCm4jAAl2E3r2PUg9RsKvJo2fVK3nGl/ofpwEYy6h7PiFvTYza+PUIhrlSoIebreAUnunws6ZqH/WbxKpFpgyWmEuBI//ZLGc1faV6Yh152xB76A7L/wcXyUKppMxnr3RP2eXIFaxZx79VCRBm8cyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754544059; c=relaxed/simple;
	bh=dpuUdctbo3puI518dY83y1zQlrEX90lZ7TzPX3fB7Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOgjymEyUFsqARxTBInu+GhNIv6NbUlHYozftdwv+WsSHlARXcA0RX5eZv0MCEtNW66fyNPENFOVVAFyRQJm1U5hsvzt0/ZaMUFxEKOVJ7t4q+/UaStXmlqJ4iG+tfimsv7OFAisU8CI3SlK4CXUw4kKmPWt2yos6xW7GmlGzaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZfJ4foCx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g63bmyYH; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZfJ4foCx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g63bmyYH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AB5A6EC00C3;
	Thu,  7 Aug 2025 01:20:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 07 Aug 2025 01:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754544056; x=1754630456; bh=jC0qR1xDfv
	bCyz9lT5/Ga5NCfHknvmRd6cxOv2fBn/A=; b=ZfJ4foCxVzjjfO8hYAUwqkiVaQ
	jzpwvL6+/iGpdJr5jzed/ehokyYLJQM1k8+YBVdSi4Hm7LwhxcYu7BdmJ6iM0A9t
	pCRNDFaU08ekx2EJkt1QfNJqVH7N1fbByhdT/820dFsOJhzSZaXblDuzJdoOAIGY
	+AWUAb0K6tvGy4rbYJlMvd+oCmzGHhKP1sEsQyxh8fVGbzU+ZWSZErss73szrOVg
	c7bqmeWR6Xz7/fbNhyvDGwNDb7qVffd1MP7IZp/XIBNXVOYPW4UW5O82Fs4DPRjP
	O1TGQ7j+BSQTAIeoRj70VGrsRkL11JRDl3p6cEX/HXNO80It45MrwwrDMTDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754544056; x=1754630456; bh=jC0qR1xDfvbCyz9lT5/Ga5NCfHknvmRd6cx
	Ov2fBn/A=; b=g63bmyYH8ZXF7LhilBtyeaHTTCxh6dEjD5DaJVkcgWUJyuGl6l8
	eSwyb0a1DuIW7WBfJqLo/d5oRICGJzI+reCkWSIQeDEltU446sXKl/doLjQlNBQ2
	9VOnivMPngq5EOhni2N8G5i3dfmcqLwfwYumj88la7ZTfNk89N3ItQDtl5vddLss
	KKFnJ3R3gPYki5dIGaClngJS5cV1CccS6g3gL4Z1eFHB8QMVGVQHVPhwaoJ4XEUy
	n6hUBWPAQweag33E2v0XlJKlxaLuQGQ3Se4UTtIFQUHvDLfEMFox1RLLjEvaFAfH
	VLNnr9p3lH+qvrAj/M3mv+QAbHtKcDbzcdA==
X-ME-Sender: <xms:uDeUaIwRfggo__BLUUUpmQDv9uQgfWLp09-bA3MPENRGjhGp0ANcGA>
    <xme:uDeUaJoYn9KKcXjZN7jAEyZbE0wN1x_0oN54OUz-zfqoPa7Zvw5no7pk_MwtIh7hr
    ktOO9E8wJRlmf91UQ>
X-ME-Received: <xmr:uDeUaBpN0rDti7w_50lt_YLNU77GgGdkfnUTxItISCXiji94dGMZK2Bgm0SxVmTlRhLg-Lh6Ly7foGlCkGMzQB4TLHWbaFnIt62dbxtJsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddttdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehoshifrghlugdrsg
    huugguvghnhhgrghgvnhesghhmgidruggv
X-ME-Proxy: <xmx:uDeUaBCZiG6VzKI6tGXivu-FI5um2D9YuAi24h3zsXvRpFs4xx8DYA>
    <xmx:uDeUaHuc34ad1zQS2wyWQrGN1L_FB1oViFfk8l1WalzeOwdV2mqndw>
    <xmx:uDeUaILkqshLyPaaY28ui5YiNrhU6f5H-IBYsy6cSf9Jfh5Eq03nOw>
    <xmx:uDeUaGadYMC14QksNgAPDGbB3iSF3cMbL9SdhP6lpG-fwJcS_kyXaA>
    <xmx:uDeUaKDd3EJEqz6UL0Wl2mC63eteOfKFKTK0kNFPfkyTerEfmRw6VNpu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 01:20:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51d88c2a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 05:20:53 +0000 (UTC)
Date: Thu, 7 Aug 2025 07:20:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, karthik.188@gmail.com,
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
	jltobler@gmail.com, jn.avila@free.fr, sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v8 3/5] repo: add the field layout.bare
Message-ID: <aJQ3sVf4MsgnCaMz@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250806195537.93302-1-lucasseikioshiro@gmail.com>
 <20250806195537.93302-4-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806195537.93302-4-lucasseikioshiro@gmail.com>

On Wed, Aug 06, 2025 at 04:55:35PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> index ce02b394da..32f64b635b 100755
> --- a/t/t1900-repo.sh
> +++ b/t/t1900-repo.sh
> @@ -54,4 +60,14 @@ test_expect_success 'only one value is returned if the same key is requested twi
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'output is returned correctly when two keys are requested' '
> +	cat >expected <<-\EOF &&
> +	layout.bare=false
> +	references.format=files
> +	EOF
> +	git init --ref-format=files two-keys &&
> +	git -C two-keys repo info layout.bare references.format > actual &&

Tiny nit, not worth a reroll on its own: our code style doesn't have a
space between the redirect operator and its target.

Patrick
