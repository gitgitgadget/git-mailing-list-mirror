Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7D32AAD6
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395269; cv=none; b=Ys/HIDz0epSZDq/RweStZc7z+JG+jmVhe68CCoyOJOPGliLDmoHuxtiGZe6qFxChLCib7tW5f/zwgTKHmhTgvpylnBqk2BtbQNqHN6sVHGQLdUs9sZ5tguCQw7oEfnBaMW70+6aDfK/wL1JOONDtNf2TSinvLbn/jTiYfn6d90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395269; c=relaxed/simple;
	bh=FGtlaZreEEkygd6ovCjRvXvJiC+1pUzbZ2b3+FY5DxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIR3m9BcGux68qE/3i71REYSYQuwUYvj6nVs/x5jVUZ9ieYN/jlD/HhS3Qgfjkdn0TyMVF4yN8jvBHY+NZJ6YPv+4kyNG3KgYlK6oFPEs+J0Trpemf87x2yuViNMxu6QX/1yA6tYd5EYhqKFYUx7IipClWNFmLY0wgCDo9rZnDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YLOqH2/T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=goBtKzzG; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YLOqH2/T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="goBtKzzG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 303C87A017D;
	Fri,  6 Feb 2026 11:27:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Feb 2026 11:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770395267; x=1770481667; bh=trSPBan04P
	18tPazuIdmA6HijrKaH5caZLmZnSJI/oI=; b=YLOqH2/TupjBA4XaG07tzcqpm5
	5Z0P61I7C3kAOGGunKpd7c2ztPn4saVATt0HQFK0mgeA561ZDLWC6eTt3PY7tbed
	e+r/UtaFYkZEN0+jaDdx5ImK41QdqWbSiqUtvK1KbXhgtaC/FuYRYw2QmD8Cfwsc
	Uc2RyXSp1MmMdG2SPqKvXohUgn07xf0IFdKJpX21JXdD5jSPgfv4Di9bMMyp13T8
	eEqNmanO+ggjs78Psdw6CUXeBTVoJpAaSllGbeez2VrInROHMxo5RpaT1FJloBbz
	CIl89GLAdReUoIOGoqVzxxZKbvp/aT5ONmxIJg6yDDFT6K7zN6Z+ceD4rSSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770395267; x=1770481667; bh=trSPBan04P18tPazuIdmA6HijrKaH5caZLm
	ZnSJI/oI=; b=goBtKzzGbfegu0SFowOLSIEFkFLeB42w5Uz9RP4rLnDcGECx/KZ
	kP6fFfHZKWgRoICoS+xJrHAIm9k60+LtfQ82te3ZPdJgz6U0HkUMsas9YOfHUpRN
	xDAkPUJsMU+jS4KeZTRZ3orl6k5FAGF39QfBeFU3A52pB53Ro+Ppt6unA3nW9Vkp
	lWLyc1ibo5hTGOBN9q2X4GqeTQl4LCKsOux+SqOzssuH3HV6KgrHRUTMaozHO9oT
	ElDRt5f52foadO9DsdWm/AOSnMwyS1G1JhnoUsVzLIF8su85lANYsvlq3FX7HUga
	3w70In98xS7sSIbeRUzLoejrCVg1S6js8ZA==
X-ME-Sender: <xms:gxaGaTyFiLBtKi5yqqXP4wNM4stNLnD-3-YkfTgQlBKA-RCC8Q7wfg>
    <xme:gxaGaW_byiD_m5ysD1UHLIjT_KgVFOX-bLCi5RM8zGhCAoONghBpECaKdX7Drz6og
    GPTt5inlQYdcy3CSr8Z3-GxLl_pNT0pq83Gpfp5s8MPCfvaNHUKq-c>
X-ME-Received: <xmr:gxaGaZwpTvQNaIZbhMHToAcYXwwt349lhf3f_4JISOO-1NT1UBIR3j-Ub3LnMP8CJoE3dLjuDN1ctxG6-OoqUorMX2-ulQ5DrZoFrzMinOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehptggrshgrrhgvthhtohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvges
    shhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepphgruhhlohdrtggrshgrrhgvthhtohesshhhohhpihhfhidrtghomhdprhgtphhtth
    hopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhm
    rghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:gxaGaWq3lz4AUFhq7yflon0iWxHnvFF-qLog2oZ8g2LwxEO4QgWNVw>
    <xmx:gxaGaarLHNAmEM1AujiYBmOvv5DfkFsDKLB45AUHJ3vg1vFu5iF89w>
    <xmx:gxaGaWDctTvUlG6wUFMjrDnx7fUjEFdzFP1AdpbCIWBmLe3qYU2kSA>
    <xmx:gxaGaYslX_szI2gjJnMwdEXo7cASVDTO8qCGhvKH_aEY9mTNlVZUsA>
    <xmx:gxaGaY7sLDKaeMzwCBj4H7AtqknS23eLrFv24OBMFi7hT770gK7EZ5KV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 11:27:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d97c3db2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 16:27:44 +0000 (UTC)
Date: Fri, 6 Feb 2026 17:27:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	"Paulo Casaretto (Shopify)" <paulo.casaretto@shopify.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v6] lockfile: add PID file for debugging stale locks
Message-ID: <aYYWfb1E6EHxEyQQ@pks.im>
References: <pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com>
 <pull.2011.v6.git.1769109815197.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2011.v6.git.1769109815197.gitgitgadget@gmail.com>

On Thu, Jan 22, 2026 at 07:23:35PM +0000, Paulo Casaretto via GitGitGadget wrote:
> diff --git a/t/t0031-lockfile-pid.sh b/t/t0031-lockfile-pid.sh
> new file mode 100755
> index 0000000000..8ef87addf5
> --- /dev/null
> +++ b/t/t0031-lockfile-pid.sh
> @@ -0,0 +1,105 @@
> +#!/bin/sh
> +
> +test_description='lock file PID info tests
> +
> +Tests for PID info file alongside lock files.
> +The feature is opt-in via core.lockfilePid config setting (boolean).
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'stale lock detected when PID is not running' '
> +	git init repo &&
> +	(
> +		cd repo &&
> +		touch .git/index.lock &&
> +		printf "pid 99999" >.git/index~pid.lock &&
> +		test_must_fail git -c core.lockfilePid=true add . 2>err &&
> +		test_grep "process 99999, which is no longer running" err &&
> +		test_grep "appears to be stale" err
> +	)
> +'
> +
> +test_expect_success 'PID info not shown by default' '
> +	git init repo2 &&

Nit, not really worth addressing on its own: you could avoid the
numbering if you used `test_when_finished rm -rf repo`.

Other than that I don't have any complaints from the ref side anymore,
and the code seems sensible to me. Thanks!

Patrick
