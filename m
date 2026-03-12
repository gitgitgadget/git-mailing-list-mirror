Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119583A5427
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337062; cv=none; b=UCIyJ0VcSuq5HJE9SsGawfrMUzJ5WOGnzyoABdiBiEKsT8hQZM3Bh/T4I0jzBNjzq0dxel/cJ4KItcgBxYBalPEJJ7x7brV6rVykiTiTZopxNivqi/SISOCVLKv6gu65wxkY7DC8/3lM3m6Ck/F+jp6dVdKcL4U0MuUg6U6Y840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337062; c=relaxed/simple;
	bh=gtSPxI9Rd8rs0/gyKIGHLRnU3akrK0nrAYxt6IWmuT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CGCwYG7CcEyLWcgZH+eC4+T9FVRqCDBP4hLdpFplRSBMNucQbj6QI/ZQmDBJ/9BTq0FUlaFmU6EPisa1w/bxtezCdakdtbK9FtGqtT8gi31MNybVQ4yinHOWz7pzxufACnaF5QOuEw8PWoqVah/wzioxd8PCcjlWugWjPqF0StM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g0bASArC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gStvZHUv; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g0bASArC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gStvZHUv"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 49CEA7A016A;
	Thu, 12 Mar 2026 13:37:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 12 Mar 2026 13:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773337060; x=1773423460; bh=oPLJ9/KOPG
	twNjMyTZf8Yf7KPckVJG8v7ddZiGGOO1c=; b=g0bASArC/gVjRSdV4vE9FyNtq+
	mxktUz6oQ4/x3QNeYahDrwnmoYulUU/XsNYUFyYXs3DdOR6m4D9wujPXY5Rc36km
	qgnzWciCfKiK7jt7pjYR3hn8h9idph5hQCD7gmSwGoefCvd9fHYhQob1mMABzKWy
	KBGShcAdlm3/l8DZ07LDYj29V7z/BYjds2LPTWX3GEgO7s2qP+7nY13INfoZ3avl
	Iitc0RxtMgkOfjaNs91jRNut9w14/qZrzDyUMM32GXpp94oHlrA5sB0xtrHQYJkp
	ABIeJR+F74ZRCE2os+eHlFClFc0EIlFcnQ2/TIqAw5J8ZrerxSqWMBTZG6FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773337060; x=1773423460; bh=oPLJ9/KOPGtwNjMyTZf8Yf7KPckVJG8v7dd
	ZiGGOO1c=; b=gStvZHUvm4s3X1DZU4MJumWdOs6EEdTkaheWc7JE59eV23B/fOc
	W4SeXOd+GBcCOJPwFImQebC1Y/LIw/yv9P9NDx+havf7BWChIyp2A1MTog0tITKl
	7ElGeomCr0xOtldHcIj3QCsOusIye+lM+wtSswPe6qwoyT4J+DoC3tDut3sDLkox
	92O6OWgB0bKEUZN5ErIpVx6KOCmTTxQ/i/c7Vrpj/PYUu5z0EWdK0rEBQOrMyKPg
	gRBXMtDQENmsnMF1cdvw0cqBLXgqKRsPeprXljv1oyxn6SHZWREXPRdxCtIDwzoZ
	URQsLNP8bX8G8LG6xdKWFimMtAD9ObNiT0A==
X-ME-Sender: <xms:4_myabJI1MabknOmIIgseOrJevV82ml8E7phb95iO6ni7vUd2DRfxg>
    <xme:4_myaRvAfvTzXGlWxNUywIVP0gBAeiGcpov5B1IOMjCc6_k3x8z1jPQrW0C1k7axs
    WH1EsMVSbL3EsTWXLyDTXyCZyPaOceylY1GQeTY26tpoElFU1rRTw>
X-ME-Received: <xmr:4_myaXXikQTOXI5-v_TcnRhbPoU9_dYhZyTpmyE6Z00mcpBUEheF7pTD7zXd1dCDLdXoS8kpNMsJImNRMUdFKOQuYdW7hclz0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefgteejgeduveeuteeiudfhhfegud
    dtjefhjedvffelteelhfdtveejueehudffueenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgrsghlohhoshgrsggrthgvrhhrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgef
    udesghhmrghilhdrtghomhdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfeehud
    elsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:5PmyaUg_-0qliGYT0vQaWP6NmWjCDzEuPnXCWjOcRvb1bzvxC87j7Q>
    <xmx:5PmyaXrRtO8hCbPyEmqyGdcqoThICGFswNQhwloky2OnPcUje3_2wg>
    <xmx:5PmyaSGDSn7IrIxpMFBUXNRDulK7SMiSpo0sudQgt0MFKDk9RpTr8Q>
    <xmx:5PmyaU53_ADs_99Dc5a791mKi3EDfxpprTtE77pvnSRwVWBZUny-Ag>
    <xmx:5PmyaZU8cOjw-_guNMWIqwlcMxexhojq4fSHCIhdOSSb_WoYRFNhJyFh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 13:37:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  chandrapratap3519@gmail.com
Subject: Re: [GSoC PATCH v4] t9200: replace test -f with modern path helper
In-Reply-To: <20260312173305.15112-1-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Thu, 12 Mar 2026 18:33:05 +0100")
References: <20260309150935.578465-1-pabloosabaterr@gmail.com>
	<20260312173305.15112-1-pabloosabaterr@gmail.com>
Date: Thu, 12 Mar 2026 10:37:38 -0700
Message-ID: <xmqqbjgteyot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Replace old style 'test -f' with helper
> 'test_path_is_file', which make debugging
> a failing test easier by loudly reporting
> what expectation was not met.
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---

Will queue.  Looks good.  Thanks.

> Changes from v3:
> The first hunk was dropped from this patch, and sent as a separate patch.
> https://lore.kernel.org/git/20260311194002.190195-1-pabloosabaterr@gmail.com/
>
>  t/t9200-git-cvsexportcommit.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
> index a44eabf0d8..15a91931a2 100755
> --- a/t/t9200-git-cvsexportcommit.sh
> +++ b/t/t9200-git-cvsexportcommit.sh
> @@ -303,7 +303,7 @@ test_expect_success 're-commit a removed filename which remains in CVS attic' '
>  	git commit -m "Added attic_gremlin" &&
>  	git cvsexportcommit -w "$CVSWORK" -c HEAD &&
>  	(cd "$CVSWORK" && cvs -Q update -d) &&
> -	test -f "$CVSWORK/attic_gremlin"
> +	test_path_is_file "$CVSWORK/attic_gremlin"
>  '
>  
>  # the state of the CVS sandbox may be indeterminate for ' space'
