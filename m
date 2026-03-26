Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898D71EEA31
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552211; cv=none; b=bq8n0h98SgnNwwcHNUi/gzBYlVLRqbW+cYzVrRO66/moo6coKgbrYuCGXHex71FXs0fuHogHyYTrWw75OFO6UEdxFxwdI6SCnu6o1dW3N4K8Eif8VSx8C6K3Vp/1yFyZT7owDtD8hCr+MVmmZJFVVcSta+ESA9fcWpDPK4u9vVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552211; c=relaxed/simple;
	bh=7cZEYkkBG2J77C2x7r6QuQW521EPwEGy8iqzVcfPP3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=moxQjM8ViExOrK0ArY2IbLfAoGb6nTU+ZkgBdeXdBV8aiFT52jyHd4X85mVHGSaNU3OQMBQFbjImnGsEFR86WHJZfxzEUXFsfWR2SMBEXsZ4kdmJrb9sggQDeKgSouuUtgBPxUESY1qDGlFBgq+gZShOpJZ0qjwsSRFrvRMgNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gwnq8ROL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pTzyj8h3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gwnq8ROL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pTzyj8h3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D47C71400173;
	Thu, 26 Mar 2026 15:10:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 26 Mar 2026 15:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774552209; x=1774638609; bh=LlYPKcDSq8
	Ui7WXMrk0buPOuCpCWTqQ7jxD6Q5PkUVw=; b=Gwnq8ROLjXO2V7/svQlkjs8BIQ
	4Gs9mrXV0npvbjWJars54IF1nFmhYLPL4YE+5ZcLGNQpcKdAwNdbzHSEbCmWV3R2
	UncMXI+LxsiVMsXFVJUwllj4dAFxP9ou3bTS7tyjCivRjyONYrDtp4SE7gU9RMFD
	YXZLChAGPOGut+C3fJTwoF1fJbsPTyt/GNHrpZKJuu8eVeJZEMloVxZH8PgbXGSe
	Zopgas3U692LxuUwiwd+4WPrGophiFk/jvop3bGB219xhAeHLJEAfy0vUjp0ms6w
	VF0V3reHEuuHyLsXFrby+hZc15xFjvvGNNKLPK3GIRaH7gz22MuMpupAiNTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774552209; x=1774638609; bh=LlYPKcDSq8Ui7WXMrk0buPOuCpCWTqQ7jxD
	6Q5PkUVw=; b=pTzyj8h3DRzdBhhJOGtsd+Iiz4BtqC+pUS4LBOAKuQiHoHqT09y
	b/Hicd0s8KPiLnS1xjxOFcVQgsqqOgugaQ8bkGBObk13Kkfle3s5M6uEB0K5wqDY
	+UB+FlQBPKWhV+jn3Dnfn7FMQvaJcB4qXaPdWSah0Ww18Eg4kJo9m5cJsEV08nTP
	srdyo5N24+UUQCpjEIuYv4hDNgA2XGL6YEHsmswROJVr3ext8WPw85i2rl+EcKf6
	Bc2PL2/R8DcF9V+D5sga8JU6ZSmFhi742aQ+BwOJcAl7SMn9saQPOERCov49JGHs
	Yi8UU4U/lAo2Cuwsc/246i4Xm9DXML/1STA==
X-ME-Sender: <xms:kYTFaW5Fk7U1qioRZGLizFL3z6VUmyjHmwYp_Fyut0asw3Er7HxctQ>
    <xme:kYTFaXVbT7etng2VoVn7dK4CINTJ4T1ydFPp_XLNLi1u2aEuyr3qFG_bofWj5HNsi
    GifaKXZbnkOqwKgIX1jUq4z0vglyGK_kM61wjEiNQv4HX3MFZriFA>
X-ME-Received: <xmr:kYTFaS0XT1Nue4sQilWVtAFjfIG5cTvBMp3c2Ydtz9MQzvn3BeZFTFE6DWsWDOFdZdLOXarusIqvkbV5g5Z9ku--tofPxGnztg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kYTFac3PxdOmiwIa-VR7Hsysh3ou3ZfjR4AxKu8r-ZP6suW77dVFmg>
    <xmx:kYTFad8jSaWDsJzDaJ5s5wVupQEPtLFHSbnCioqn3ivhMZj2tsr1JA>
    <xmx:kYTFaR0hhJSIov6DROKVh-6DzP8JV3eV_r7Q2k0ZvgOAAgfIib13Bg>
    <xmx:kYTFaS8xkQw26hMFvYPSitmrcm0cR2LiMrOl3_RrPXmMCNv-U-iu0A>
    <xmx:kYTFaQiCc1tKrAaAo5JOgF0cj58PuFY9W8ezg8QErcZpoX5BCWPZ2jU9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 15:10:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] docs: fix --commit-list-format related entries
In-Reply-To: <20260326185541.17523-1-mroik@delayed.space> (Mirko Faina's
	message of "Thu, 26 Mar 2026 19:55:41 +0100")
References: <20260326185541.17523-1-mroik@delayed.space>
Date: Thu, 26 Mar 2026 12:10:08 -0700
Message-ID: <xmqqpl4qpfu7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

>  	The user is allowed to drop the prefix if the format-string contains a
>  	`%<placeholder>`.

As you do not, and we do not want to, parse and validate
placeholder, it is more honest to phrase this like

	A format-string that contains a `%` letter is treated as a
	custom format even if it lacks the `log:` prefix.

even if we omit saying ", expecting that '%' is part of a %<prefix>",
or ", similar to how `git log --pretty=<format>` works as if the
<format> were prefixed with `format:`".

> -	If not given, defaults to the `format.commitListFormat` configuration
> -	variable.
> -	This option implies the use of `--cover-letter` unless
> -	`--no-cover-letter` is given.
> +	If not given, defaults to `shortlog` unless the
> +	`format.commitListFormat` configuration variable is set. This option
> +	implies the use of `--cover-letter` unless `--no-cover-letter` is
> +	given.

A new reader would wonder if setting the configuration variable
would count as a trigger to "This option implies", even though we
only want an explicit command line option to do so.

Here is myu attempt to rephrase it, but

    Use of this option from the command line implies `--cover-letter`;
    an explicit `--no-cover-letter` can defeat it.

I am not sure how much better it is from the original.


