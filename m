Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0782E92C7
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763269; cv=none; b=bnwuDhKkvuLmhXA735QGUpVXxuXtKlWxWECVRX7okeaT0Kboa2xg+4+fgapcoLBKSa8YrTQQ5PGlE74q+p1IdWLIL2OyJLeeopuk6FZEuSqqmCkSmME4ELSl04g8hiuUb4Mi27lsoelPxApVQbpy7dd69RgayxBaMNl3YHV3zow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763269; c=relaxed/simple;
	bh=Ox1eC/1pDHLysHgM+bGRlMlhz230qrWPpK87KtOErFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx0L+4vl6yglmJtqT5trimPn1tX4Qq82FF5MPd4dW4vbcz/4IehtrJJCIkkKrfd8cyVbg/AYH8C5CSKbdysZKwQFRzlWQqAIPRWMGV3Rf+zyBlmyoFMnrF75ZtvgbOslz/RI/VeUYFRUNCxyb3IXRqTg8v1JEi1bC0MYEJKk8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VA6y4YAr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dCUJRpBT; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VA6y4YAr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dCUJRpBT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C800E14000BD;
	Thu, 21 Aug 2025 04:01:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 21 Aug 2025 04:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755763264; x=1755849664; bh=N0Bn5tvIBo
	RRrfRnOXFBTOafV+dlKIPGnFqVYgVoE6U=; b=VA6y4YArxUeYcFnIIFgKpkb0c2
	77uoU1j+KaB9E5y5W+eEtmrb5pIZjiAB4crMDVaqm+4z4YfuMvTVcmuJleSZHsDE
	296jAjVllWfYc57TKHdd6DHDXD+MwJ/+oEf3ib+p4MSY0/QuLvBDm3jZ98sFhkHB
	refv4Pp10MtQi1/GcJf1X9tli6l+gzCu8Xn2hT1Yz01385JnAn9mgElpZxCHYxJL
	MA0eYwklviTbyBgpNU0Djo0L7FYS+/BL8fQ7RN+AvZGzVoKrfUzpJMPtoAc7M633
	xszAHqSX+dAygeqyu5SIVk5qwce6W5sD70UsYdz45W8kb3MQtgBEk5PMZX6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755763264; x=1755849664; bh=N0Bn5tvIBoRRrfRnOXFBTOafV+dlKIPGnFq
	VYgVoE6U=; b=dCUJRpBT8GPtWv4rHrSlOaNajqO2RjM9WuyvoYTn04dHOBtn0iN
	uUCe5DCsGivGzXjFyjambsDkW+onZbsVJNBIzVrCcgZGz1l315Joz61bN5ly0MCs
	+fBIZGGNnWwWaxMEm6bazLi5EYTgrUwp2fI2mdEs7QDDWBzL/sNj6wHbzUA045N0
	g+jfylN8FxnpE4ypQ6r7qb8WAY1ompsWW7rk2lL+DE9h1olgpBlW7H0KeoGOA0qA
	8FhVvIhT5AGrtmH0wscS6YzX9Rz1TodVZk0dTDlOWE5yXUCqNmedbmLOpWa3uQlV
	bJscO22lCu8Y0bEfpE/fh/js7JwAl5PZHQg==
X-ME-Sender: <xms:QNKmaFjkCLdP82FFczGYmi7qoBDusR-y5qfw2W1JuVcoEn4vP6YClw>
    <xme:QNKmaP9qADqvjASOf6b68IxpUwRRFvvUgUcGdeb3dnid-OZuPKKMY51AiiFFbRC5r
    9BkR-1md3iKqFdbLg>
X-ME-Received: <xmr:QNKmaCNI0Dwe49-0b_zoouuTA41lZjpn9xfYEaK6jJdDrM7IDmcV_YI3ycjhiJswpd8_B9gPx6FXh3y_MZKMk-T_P-Affh6cKx8GjCCqSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhohhhntggrih
    ekieesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:QNKmaLAzrHj-4OLTlET2-BSIYlCIYkciFAQPXe73trmxRAOwDfRKHg>
    <xmx:QNKmaONtrGurrmdFzYNSQ2PzRNBcE7HGRygvoNK-v3MxxCRgDyz-1g>
    <xmx:QNKmaKeeVmRghmF8f6qRNyXR4yhbdMG8CIHkySymIikDsBRWpOjw1A>
    <xmx:QNKmaH6KJT1Hgc3RwyTAovSKc9m0hLqOXYE7h2Sdgm03BhnBjmLTtQ>
    <xmx:QNKmaH2qIbcf8LSd6LvGK5s0hO7xmRN52chEXVoJGFrHb8zSen9tvIAG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 04:01:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id efbac8a0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 08:01:00 +0000 (UTC)
Date: Thu, 21 Aug 2025 10:00:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, me@ttaylorr.com, newren@gmail.com,
	peff@peff.net, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/3] t7700: add failing --path-walk test
Message-ID: <aKbSObIzXwUtjAdE@pks.im>
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
 <5b19173c03da676b3e1effda7ba6d2ef5666cad6.1755715196.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b19173c03da676b3e1effda7ba6d2ef5666cad6.1755715196.git.gitgitgadget@gmail.com>

On Wed, Aug 20, 2025 at 06:39:54PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 611755cc139b..1998d9bf291c 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -838,4 +838,47 @@ test_expect_success '-n overrides repack.updateServerInfo=true' '

Tiny nit: I would've probably squashed this patch into the second patch,
as we usually don't use the add-failing-test-and-then-fix-it-later
dance. On the other hand though it gives some nice context, so I
ultimately don't mind it all that much. So please feel free to ignore
this nit.

>  	test_server_info_missing
>  '
>  
> +test_expect_failure 'pending objects are repacked appropriately' '
> +	git init pending &&

We probably also want `test_when_finished "rm -rf pending"` before
calling git-init(1).

> +
> +	(
> +		cd pending &&
> +
> +		mkdir -p a/b &&
> +		echo singleton >file &&
> +		echo stuff >a/b/c &&
> +		echo more >a/d &&
> +		git add file a &&
> +		git commit -m "single blobs" &&
> +
> +		echo d >a/d &&
> +		echo e >a/e &&
> +		git add a &&
> +		git commit -m "more blobs" &&
> +
> +		# This use of a sparse index helps to force
> +		# test that the cache-tree is walked, too.
> +		git sparse-checkout set --sparse-index a x &&
> +
> +		# Just _stage_ the changes.
> +		echo f >a/d &&
> +		echo h >a/e &&
> +		echo i >a/i &&
> +		mkdir x &&
> +		echo y >x/y &&
> +		git add a x &&

Nit: I think I would've moved the explanations you have in the commit
message into these hunks so that the test becomes a bit more
self-explanatory.

> +		# Bring the loose objects into a packfile to avoid
> +		# leftovers in next test. Without this, the loose
> +		# objects persist and the test succeeds for other
> +		# reasons.
> +		git repack -adf &&
> +		git fsck &&
> +
> +		# Test path walk version with pack.useSparse.
> +		git -c pack.useSparse=true repack -adf --path-walk &&
> +		git fsck
> +	)
> +'

Patrick
