Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8797273D60
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651893; cv=none; b=Trh91FVClc/3yewBE7eu9Dbkj3rVJMoSfpF17qKX5pM/0iNUEJpHKWvYdlC3hR45ID9COht5UZ3Hmm7ZChzigpaYmvGfQc5TKR5DjoonbMvFjcCWga/sM2VlQJ91nhfl7BIyDKsZIXqyYoF8KjK0AkeR1bNqOG4E0wGL9auXOP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651893; c=relaxed/simple;
	bh=Z5EXD1e9lclf4kGxWOzjO0xfSn127hpww1J+7TVE3tY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I9vU25dNAVpFzmcND+yvtcvAoSHoapjoGTnmZxPzx70NUhi5zBwCgiOPg2l8uhN+hBZ8pJJY6mLFZy9kgwnbCGmzdMy4Lr1JO62aKUFxZEuCdYMrqeOkEIZLER0Vn5Irvk4pkwK4skp7sQdenZX5cXldqWuzZH27ZqobxZ1/6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wq39SmB9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GW0zJrMX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wq39SmB9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GW0zJrMX"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA1B711401ED;
	Wed, 11 Jun 2025 10:24:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 11 Jun 2025 10:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749651889; x=1749738289; bh=hMPZB71ThI
	enIIYpanEfQXWDXDNwxGbsPdllKH+95jY=; b=Wq39SmB94OVK9mmzfCgt1UbZCk
	L4qq5NBj8HOGJUYZVIwf7YHIgZvMpEYrasQukytPJlntvq9XvXvuohSZvpxkRbeL
	k67IygcfWIfrocdBTy1hHr399Ptcuzst2DFa/nc/vdC7RfKL95rzWACsl+dJjKDj
	cyBEYvyMrN3dhquj3CRviSHd1wsWLpRuyzlhQ96mzClqUWp1gStkA2bhV0SPSomW
	GnwboWYNLWGKvtJRAgDN8cDbT3i9iL+2XNuwzEpSUcg5SukDafX6fQ3afjaQ4Hmc
	AfZxTUfAwRBQdz8lNSatxW0SwZKrEzi2sVaPcKxTnLKr/+jO+JlJ6yhQeOgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749651889; x=1749738289; bh=hMPZB71ThIenIIYpanEfQXWDXDNwxGbsPdl
	lKH+95jY=; b=GW0zJrMX0OHuq5Q69lAjk6oErNUIHgmBP14n5ysQrC/2svyBDqq
	SxVIKoVRi0LhW52ekWN+urWpAUekHUKayir99cf/5tvI16HbBGW8InOWGMTKxk/Y
	C6fClIyCFnrYYNWFxf46eWmlqdhzUPsSmHmmxOHjHTFQmXkIwgOtbW/OJ4xtfNgP
	JQFS7drSRBV5pdP5/LJdXNFkapk1vYHyZLLGEBeNYtc/tKnOvC48Uuh5y75XtMyG
	PyvoF7ivI/LPpkCV6i+goP7OQwJX/tK4chRMHuupQAcp+AH02fFO75GyVXLIH0JQ
	fxDMBmbtn06LGN4neUXtVN3lSMaeIVNVauQ==
X-ME-Sender: <xms:sZFJaFVFsGLgHSKn7nzDkqnrEcXbBs9UAcTRm3uD13h6Wmbm3NNezg>
    <xme:sZFJaFn_qUs6x-eT4jwjwnNcFZzju3sAz8Fm9AGiM4yrVSRqktqWc0IUIjiaMSpnJ
    hiq8mo5DPXy3B2vKg>
X-ME-Received: <xmr:sZFJaBYHOH7o3kR89MO7G63C7lCWRPyevB7cwggOmv4VCdcBk1Vy8HWlSg05tOlELrZGNnc4OSqbNpTgEqwS2STcjecncrfOyMQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sZFJaIU0ZPW8zaZxjCdxWAz4ZpH-XyAWUku0UYES9jQ1uidRXFNdIg>
    <xmx:sZFJaPmeuX_mTJ8JUJuxEUfS7ccJko7M9TPSVsETlk_4uqFcy47RkA>
    <xmx:sZFJaFcCTyPMvFajKGTbtpL-w-CfvnWLXDAIjmUSts_VNXFBhjzVsQ>
    <xmx:sZFJaJG6jxFW0UNnlFz6oPHmW7Re_ZfF6mfDpLOVbxjGqdyCXfZACA>
    <xmx:sZFJaDzBnkRts33Kxw1opA792zch0jYb72RguWPOrO8LjhkiPGd1bQgI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 10:24:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] ci(coverity): fix building on Windows
In-Reply-To: <c65120f25704e9725c317a62b9a1231bd19f3e25.1749650552.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 11 Jun 2025
	14:02:31 +0000")
References: <pull.1934.git.1749650552.gitgitgadget@gmail.com>
	<c65120f25704e9725c317a62b9a1231bd19f3e25.1749650552.git.gitgitgadget@gmail.com>
Date: Wed, 11 Jun 2025 07:24:47 -0700
Message-ID: <xmqqtt4mjqz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> ...
> In the meantime, the current Coverity documentation describes a very
> different way to install the analysis tool, recommending to add the
> `bin/` directory to the _end_ of `PATH` (when originally, IIRC, it was
> recommended to add it to the _beginning_ of the `PATH`).
> ..., and finding the "wrong" ones first on the
> `PATH` misleads that logic.
>
> Let's fix this problem by following Coverity's current recommendation
> and append the `bin/` directory in which `cov-int` can be found to the
> _end_ of `PATH`.

Wow, that is a very well described change.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .github/workflows/coverity.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
> index 124301dbbe2f..a5d99e59d4eb 100644
> --- a/.github/workflows/coverity.yml
> +++ b/.github/workflows/coverity.yml
> @@ -147,7 +147,7 @@ jobs:
>            key: cov-build-${{ env.COVERITY_LANGUAGE }}-${{ env.COVERITY_PLATFORM }}-${{ steps.lookup.outputs.hash }}
>        - name: build with cov-build
>          run: |
> -          export PATH="$RUNNER_TEMP/cov-analysis/bin:$PATH" &&
> +          export PATH="$PATH:$(cygpath -au "$RUNNER_TEMP")/cov-analysis/bin" &&

Additionally two things are lacking explanation in the proposed log
message, though, or an uninitiated will still be left scratching his
head:

 - Why didn't the original need "cygpath -au"?

 - Even though many steps in this job deals with different
   env.COVERITY_PLATFORM, this part does not seem to be conditional.
   Why is $(cygpath -au ...) safe outside Windows environment?

Other than that, nicely done and very nicely explained.



>            cov-configure --gcc &&
>            cov-build --dir cov-int make
>        - name: package the build
