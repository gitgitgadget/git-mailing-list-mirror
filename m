Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D892C235B
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 06:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771481917; cv=none; b=G34hnbaKpE0HLxiDnH2gJzj2SWMyqZD9jyPXIy06uCXHsmB94dmb8SanHooZ00+kHaY9GusRq81lcBtyCusk3QGC5onCelgqYIRas70Pu7lQCV7JXHfJ7jEoR15tJBfcepyoLZfY6JCkgO2ktRI26kgWR6kuOJlK1+ntiRw5kkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771481917; c=relaxed/simple;
	bh=zLQj1Jbh28i7dv9OZXLGA0n2VPnaNY6GtX4HQDWgpRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLNzSICQRiinCNL6J7klrxjPg50yUSD+ZIRD6nuipEkwVDgijrDx4h/RtmBJ0NGRuyDfjzZ+WW4vFtBEmoz8Hv+4U9qaYl91liuwIv8MMK4oTO2x/tkAY849rlNBcqnkRfCpCND2JjfNGjuQBvQR6eXhlKpIdRhO5jheCpty87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sUJwDIYM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ex/4jYvs; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sUJwDIYM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ex/4jYvs"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 83C27EC058F;
	Thu, 19 Feb 2026 01:18:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 19 Feb 2026 01:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771481914; x=1771568314; bh=0kwLvhHqlI
	DfQbYYyuVciQUeiloTJnW8eRczW0GLOGk=; b=sUJwDIYMXnJlFITIzkpmXDuHA6
	1gUAK79z5FZnfpHb3Getzm0fL/m1OT4ARurP8Wri/YnncUojkMzSnSOlEqhFr5gS
	ycAgKbzJ3D+zSPq1kM1Fx85Pt4TMvSxaFvIOSB2eCypC4Tj8uP1gEjQOS6/gGGcs
	GnnPl+vEayT/fLqiWqv3lyb5Le68Cj5SYZ286ZDr51ahBpn+ku1CJofGfnZAMd4G
	BTjHJUgPXF+22svPK9zbP/B2Agx36aV8QHMbpDChy2vNa5hjtosTni0PsYdF1/lp
	IysO2PeGdkvtntAK8JZ7Bn4W0dWZQ/fA57zUdSC5QpcGBaisrcDpJSIKPHWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771481914; x=1771568314; bh=0kwLvhHqlIDfQbYYyuVciQUeiloTJnW8eRc
	zW0GLOGk=; b=ex/4jYvs9Ze5O98U7j77yC7/7aAx6o/6czFRDNaJO1k4Xj2svFA
	CDln1ipe2geyhQNXULbMDgrw5uP6jve2aNI2/CcFPsjaZO8qeQZTBJYQtgy1DvVN
	ItmTNV2K9NVWl40b7hR2foncJXu8ttft6Wdf7lY24FW9pXmne5OGQ60qcwg+dfdR
	MJoBMl40IVQNje1drIIeStvKqgkK/cvw5h1Os4ZEAypQr435HfYLKw5HzuIiA2sT
	Rkd+oza2EwQwWSCkwXc7R6rgXS0TGoW97D+fy4qMSTQ4enhXxVE3IywTaiZL6llP
	cC1/r8admfIdrYGKN/ea1L9LR9IxjLxcVsg==
X-ME-Sender: <xms:OquWaYH692SmGcg-taIz9_YDGcLldQ1Q30KYafHZgoRrE1xzY4hYPA>
    <xme:OquWaYN1vrCGJLPwH9GYIJdxexVrRbrAaWcdQXSMZs1Wdoklo5Z-DTY1Owh8zP61k
    lR8ccSTlzkZm1RI8Wm0y6L0DIwtEuq-y2kjjRjJ45nrVh6FODMn>
X-ME-Received: <xmr:OquWaadNgvB2WbgdzaNMN7MNzxs1mM5zRO1TVVW3s8ryucYzVCgs_U37bdui3jHjHm_YfwVl_xu16RWzy_agjsVWJ5Fnmp7cEBJIyTNqkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfehtefgveelhfeuueevuedvnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggv
X-ME-Proxy: <xmx:OquWaVtE1GbUJcO_sgkZRaPtWpA9Ew7HkMH0YJDh7QXUrnquv8IadQ>
    <xmx:OquWabmZxKDmK_D96T8trhm0ztOcB2T5Dv6XT30WkGEYcSdz_d584Q>
    <xmx:OquWaXwDWj4byg18JZrrU8sQw3iw5rWYJmdHJXani1em7KZirLes1w>
    <xmx:OquWadMr_n8-9Q8gD27KNQ_AmTwSjl-OMKWCDNkmEFIjiOilv12E7g>
    <xmx:OquWafLdm748tz4rJlKzH84sXJMHf9u4tXVweTlwonZWI2nhDvirat7k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 01:18:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c59ace73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 06:18:30 +0000 (UTC)
Date: Thu, 19 Feb 2026 07:18:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/7] ci: make test slicing consistent across Meson/Make
Message-ID: <aZarM9CeGjBqC3S3@pks.im>
References: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
 <20260211-b4-pks-ci-meson-improvements-v1-5-cb167cc80b86@pks.im>
 <83168201-9c26-4ece-51e1-1931d4b38443@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83168201-9c26-4ece-51e1-1931d4b38443@gmx.de>

On Wed, Feb 18, 2026 at 10:32:20PM +0100, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Wed, 11 Feb 2026, Patrick Steinhardt wrote:
> 
> > In the preceding commit we have adjusted test slicing to be one-based
> > when using the "ci/run-test-slice.sh" script. But we also have an
> > equivalent script for Meson that is still zero-based, which is of course
> > inconsistent.
> > 
> > Adapt the script to be one-based, as well, and adapt the GitHub workflow
> > accordingly. Note that GitLab doesn't yet use the script, so it does not
> > need to be adapted. This will change in the next commit though.
> 
> This seems to require the following to be squashed in:
> 
> -- snip --
> From 677370c8cd3b73358713a0efac6bb573b347d53f Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Wed, 18 Feb 2026 22:12:27 +0100
> Subject: [PATCH] fixup??? ci: make test slicing consistent across Meson/Make
> 
> This seems to be needed to let the first "win+VS test" job pass. See
> https://github.com/git-for-windows/git/actions/runs/22153194896/job/64053953314#step:5:70
> ("fatal: slice must be in the range 1 <= slice <= 10, got '0'").

Huh, weird, why didn't I spot this myself? Oh, these tests don't execute
by default, right? That's why.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .github/workflows/main.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 412842eb3e2..42585fff779 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -240,7 +240,7 @@ jobs:
>        shell: bash
>        env:
>          NO_SVN_TESTS: 1
> -      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
> +      run: . /etc/profile && ci/run-test-slice.sh $((${{matrix.nr}}+1)) 10
>      - name: print test failures
>        if: failure() && env.FAILED_TEST_ARTIFACTS != ''
>        shell: bash
> -- snap --
> 
> This here run proves that this change fixes the CI failure:
> https://github.com/git-for-windows/git/actions/runs/22157880378/job/64067214717#step:5:70
> 
> Patrick, would you mind adopting this amendment into your patch?

Yup, looks obviously correct. Will squash in, thanks!

Patrick
