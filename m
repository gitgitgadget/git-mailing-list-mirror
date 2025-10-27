Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F871CDFAC
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595528; cv=none; b=uWae20n75T+VatCAvsnJumnRixjCeJTtyzFVe29oNcypRZFCo0DuD0u7gEA1bLe4GzsqzzX2CA+Rjw/bvdIMnRxDN/N0T9CVHQSaDa6cXhOL8rMzMobpDhtPgdgmwJgTx654UxnDM6DY8U5Y1wi6nPN74d+qs/UJ4FIdB16qnbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595528; c=relaxed/simple;
	bh=aJSTrk6YD5IrlLm/NzMklDRO2PGr4MpPSVyhOPqFgLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKcascd5NXCSgR0mDkb48DXLUHCdkIntGTUWroyA9YBXWdZoRFEGomTVHhezgvFdhnhdwONuHAg1h62FtCdRYU0oNpZHXhwyOA6l/J2O5MUTKC4FkLBj+myMdTvK1u5IjDkdM7Nx7HONK/XnCRrTdjgx4UEVTQq4YRCC2nbMgbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZNxQB5zk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EnE7dJ09; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZNxQB5zk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EnE7dJ09"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E072614002AA;
	Mon, 27 Oct 2025 16:05:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 16:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761595524; x=1761681924; bh=ff+Pe+eXqM
	9ICsTK/8zxH50OQFIQCnX7bt3m0d6SBPo=; b=ZNxQB5zk8XMCJKkXLAXDTGh/y4
	+acLSqJ+X78bdrsEpXNSU+q3sCmBCjgQnyLA81rfJQkvbVuVLajXbfPMOLSAJdKu
	4AOO7mEIx36/BfK7giMk7S7vzYm2AThF2LKgolKURq/l1yDR+KI0JiR/86ZSuoyr
	/SjtTi9/VWe1Qu2zQEbGJp1Z5zOYDsuMQGJGrtsrNIQ5kf3bxy1w3mdCvRhxtXME
	vOCucYVcV51h8FvC3QzX/AtiAFQuX5zrU4H+ZWh1LMSTv6BRYJzk3idBS52k3dLg
	ss5rnOP5KcmBEKosJpQqUfY2shF9sGQMZ2mXqnO9zD0nn0gMGHSdUiyksAGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761595524; x=1761681924; bh=ff+Pe+eXqM9ICsTK/8zxH50OQFIQCnX7bt3
	m0d6SBPo=; b=EnE7dJ09Z0W57rxniMT6MT75DyI8TW4KdCcckOV7skSW7B0YNJl
	pju4vO/BIXkkYeFYVu7Fe5ga0Qb62N4AqcxYVPahUpsMz68y6kTpseLXB/7l6vhg
	402zT0WOh1VEz+cjryYon9nmOupsdPsr3FKI6r0m3hMhiKH2Jj8RJA0rnONSwEyd
	Ic/LOYdTimSE7GQzl/aLNdxd/1qIxsGwyVJjhsPhe1ESEZCTyrnTMzBfUlhPpe/Y
	ZSQnNSttyFtf6xtjMzh7qCQgzp5iat1qZI4V3td95sMpYsOYEZYo/4NTUQFRaiuE
	RAY6lmb73Wk6yVmQcAqehZSJ+yv5zS5c3SQ==
X-ME-Sender: <xms:hND_aG5GylKahe93bU1sKdNEzo-xOH1FZh_Tx5w1EKwIg9mSa51Kbw>
    <xme:hND_aDkSQEShc0MyY5L9VCVu3BYd5lpzTut9_AFDx4ITp49RikISN5g0i-qiJ6UwM
    3Oat4ivpgGR9snB2tB9WXICzj-vkSTj7h_cp4KLfFWKfz8ag8PvrdQ>
X-ME-Received: <xmr:hND_aPRS9iJRy3sggNP9t9fMdAKzI8nmjntfqnc68jbRL0oY6mrcglhrJ436sgVFMjsc7WaSeD4ehQnlhKtmKPojpwnpHDyjBqNRWmu0Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hND_aKH5RSbaBuK2rlXZYfdQboUK7nZWRgGzdr9WxASYtBvVhrDq8w>
    <xmx:hND_aMG-805u03BdUqV-w9ibJOwjnbRnzjCPiHjTTDvMpm1hSYUc3g>
    <xmx:hND_aAS9RWLM7PVoxdCM3hz9PumtntGkxIYAqygX2wbasaSqCYxwOg>
    <xmx:hND_aFKJO0U59HdMQ1aNMefNFnnlw_EOInjme9nO7eyeLFeidPhNRA>
    <xmx:hND_aGERHVAb7V2LxyydXKksOEZ1qAvAUstE367jgC7syaNEM8u1nj9Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 16:05:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6bc570d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 20:05:20 +0000 (UTC)
Date: Mon, 27 Oct 2025 21:05:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 00/10] builtin/maintenance: introduce "geometric"
 strategy
Message-ID: <aP_Qe2QG5w3g4Z9y@pks.im>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
 <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
 <xmqqtszkjq8d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtszkjq8d.fsf@gitster.g>

On Mon, Oct 27, 2025 at 08:53:22AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Changes in v4:
> >   - Fix a flaky test because git-repack(1) always decides to rewrite the
> >     MIDX, even though no packs have changed. This isn't a new issue, and
> >     other maintenance tasks behave the same. So I decided to punt on it
> >     for now.
> 
> Thanks, but this round raced against 'next', so let me fabricate the
> following and queue it instead.

Thanks for doing this!

> ------- >8 -------
> From: Patrick Steinhardt <ps@pks.im>
> Date: Mon, 27 Oct 2025 09:30:50 +0100
> Subject: [PATCH] t7900: fix a flaky test due to git-repack always regenerating .midx

s/.midx/MIDX, as the MIDX file does not have a dot anywhere.

> 
> When a supposedly no-op "git repack" runs across a second boundary,
> because the command always touches the MIDX file and updates its
> timestamp, "ls -l $GIT_DIR/objects/pack/" before and after the
> operation can change, which causes such a test to fail.  Only
> compare the *.pack files in the directory before and after the
> operation to work around this flakyness.

Maybe add something like the following:

    Arguably, git-repack(1) should learn to not rewrite the MIDX in case
    we know it is already up-to-date. But this is not a new problem
    introduced via the new geometric maintenance task, so for now it
    should be good enough to paper over the issue.

But I think this looks good enough already, so please feel free to
ignore. Happy to have my authorship with either of these versions.

Thanks!

Patrick

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> [jc: taken from diff to v4 from v3 that was already merged to 'next']
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t7900-maintenance.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 0d76693fee..614184a097 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -500,9 +500,9 @@ test_expect_success 'geometric repacking task' '
>  
>  		# Repacking should now cause a no-op geometric repack because
>  		# no packfiles need to be combined.
> -		ls -l .git/objects/pack >before &&
> +		ls -l .git/objects/pack/*.pack >before &&
>  		run_and_verify_geometric_pack 1 &&
> -		ls -l .git/objects/pack >after &&
> +		ls -l .git/objects/pack/*.pack >after &&
>  		test_cmp before after &&
>  
>  		# This incremental change creates a new packfile that only
> -- 
> 2.51.2-678-g0cd646409c
> 
