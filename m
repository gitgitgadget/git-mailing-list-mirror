Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44DB315D21
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297710; cv=none; b=p5zCaZZu3K4Nukb32yEQvsClW8/xrPl7eScXI//1mZP620o/HICOYVs7yPVFgum8DjV/UXp9efpaimpLdTmFQM7ZJjcnqbheiqWEkS4KfZqt1JzpqDNWBVqz3NA21hFEX1QUQZWwbVGZCxd6Lc2HOFuWpXwrWACzb3wS9/6+MDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297710; c=relaxed/simple;
	bh=JHjxENFMFjDW/6WmmVRjwdh93+IPiBIm/okObPk+2Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lonPjAEvDbLthjvVhqAC8jE8SdPfW491z0/vGJnqZn0SFV1KGLUYqzP82GMpIMpV3Ky2Puab4txqktBxc38jDDEYYcvC0vkLIG7bUA2/N5KFzX79c4n6CcCD3g4zjUZm/1pfE5PDhf3NJ7rcnZdh24oHT/LwvAKs2kkfivzLQWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RSSswfQR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XZiUEK4r; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RSSswfQR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XZiUEK4r"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D61291400057;
	Thu, 12 Mar 2026 02:41:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 12 Mar 2026 02:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773297707; x=1773384107; bh=a0GIxi4yYG
	3XG+3kkhHZBzkSfMpFwkdvSvC5GQDMQi0=; b=RSSswfQRpLd6UItLu0irBiWSWg
	pO/uIsXS/OpFgjRu7etI1CgZQDhjXemJWGmKEoMW+xnkHyN8HVEPsIc7NpD++xg9
	nxAWF8mmp8pWqbpKw09ysEuGZggpVs0uDTdYShkogpgf5nh5Iv3ECL4Sd6RXvBmj
	FgzcngB3+cYcfZxQkvuGmCLn8Om2btTmsJO351eIyZ5Jj8ZLyAzfQCUeUxRE4PdS
	vRRdx6YyRKwKza/qggWLuz5dr+QwbRneN9T8IjYj11CIlCZe9WmmeQqA+E5ZHqfK
	Ugg9EewmbgPuuV5JYEFNVvZ6WmzIOLHHuHPb/v3ptZvoJpgB9xeq7B9v8mqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773297707; x=1773384107; bh=a0GIxi4yYG3XG+3kkhHZBzkSfMpFwkdvSvC
	5GQDMQi0=; b=XZiUEK4rMmfkHe+wXhd1TLR7jAGGbK5oJuZi8CS4VA6chLgZv0g
	cC9fhTNbvUIj7+dTPe+9+ualQr+uwM9cat3D2D4OFjKLcleltM+4KXDRlAk9e4QR
	CKm5hqfWHoCwiJAGxLjbUOwhzoz1Jqc5KKMrbXpwU7jmAJGHvIgomTdzOZ7CZuU3
	8V/GliWC3TNEVXT3mKYfPzxhDd2Bz0dsn0SXIDZ2gZj+gnCl5TMRKecUNwQ6v8vZ
	UEeUIWuSngILe1gXAh54UkzVFq0AbAI3Bj5QPwicSpe6q+1VwobJa1tvPuzh8KgL
	teIZuyptlwi/SS9DayQzrC/amtv4EXuiUQQ==
X-ME-Sender: <xms:K2CyaVbNZH-yCLWtfDxHtDcgLc2gmq38kuRChOMZZUqtSSd_96b5Qw>
    <xme:K2CyaTSY28gMGiQ1lxpzAE_2LwnhvgQP-0Dt-SCcNeLhclCxACKxq42ajQtqac1ab
    pHT8WzL0q4P_qgwj-CCbCkGCWCFf7IaUyaX6Kd3HPD630fQjvQnhA>
X-ME-Received: <xmr:K2CyaQQZQdsNQKCvizB3jjRrbLPY3gSbzB8IrkE3IBdg3GCoGhan0lR1kc5JvGRJaAV246xalNR_xF3yCVDTnSgtUa5m8VdPpB3Ot5GRZ8poJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeitdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgt
    phhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:K2CyafRoguQZv_jE2-t20y4Uglivm47Xx6GymK9zRHEjxlT73hXRXQ>
    <xmx:K2Cyad6k1wPTMdC36_FoR9NgRukoumv1c-UN4p6rXzxss21D_UI8pQ>
    <xmx:K2CyaT0AleVFiKnPZvAE6RK4EtZcUP2USIeJAtliJXTG5PATPtiUrQ>
    <xmx:K2CyaQAwHROXVK4XSkD4EvPScCJG-w0GGSXZw5WZ6Mdk4DOMUBbY-A>
    <xmx:K2CyacqQyeC3lhA7n0GyQk-5pMABq9D-kBZW2S4HtK76yz_0p-vqLhD5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 02:41:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ef11d4e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 06:41:45 +0000 (UTC)
Date: Thu, 12 Mar 2026 07:41:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] t: allow use of "sed -E"
Message-ID: <abJgGapdAIQXIsNy@pks.im>
References: <xmqq5x72m4lu.fsf@gitster.g>
 <xmqq3425lvtq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq3425lvtq.fsf@gitster.g>

On Wed, Mar 11, 2026 at 05:45:21PM -0700, Junio C Hamano wrote:
> Since early 2019 with e62e225f (test-lint: only use only sed [-n]
> [-e command] [-f command_file], 2019-01-20), we have been trying to
> limit the options of "sed" we use in our tests to "-e <pattern>",
> "-n", and "-f <file>".
> 
> Before the commit, we were trying to reject only "-i" (which is one
> of the really-not-portable options), but the commit explicitly
> wanted to reject use of "-E" (use ERE instead of BRE).  The commit
> cites the then-current POSIX.1 (Issue 7, 2018 edition) to show that
> "even recent POSIX does not have it!", but the latest edition (Issue
> 8) documents "-E" as an option to use ERE.
> 
> But that was 7 years ago, and that is a long time for many things to
> happen.
> 
> Besides, we have been using "sed -E" without the check in question
> triggering in one of the scripts since 2022, with 461fec41 (bisect
> run: keep some of the post-v2.30.0 output, 2022-11-10).  It was
> hidden because the 'E' was squished with another single letter
> option.
> 
> t/t6030-bisect-porcelain.sh:	sed -En 's/.*(bisect...
> 
> This escaped the rather simple pattern used in the checker
> 
>     /\bsed\s+-[^efn]\s+/ and err 'sed option not portable...';
> 
> because -E did not appear as a singleton.

Makes me wonder whether we also want to harden this regex. But even if
we started to understand that multiple single-letter options can be
squished together it wouldn't be sufficient, as we don't know to process
multiple arugments, either. And I guess it doesn't make sense to grow a
full command line parser here.

> Let's change the rule to allow the "-E" option, which nobody has
> complained against for the past 3 years.  We rewrite our first use
> of the "-E" option so that it is caught by the old rule, primarily
> because we do not want to teach our mischievous developers how to
> smuggle in an unwanted option undetected by the test lint.  And at
> the same time, loosen the pattern to allow "-E" the same way we
> allow "-n" and friends.

Feels reasonable to me.

Patrick
