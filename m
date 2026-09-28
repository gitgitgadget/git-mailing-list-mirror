Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723A415B82
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578213; cv=none; b=ozr++iuEnzGfuxbl/GlaFacdzecUGPhJJ28a7YKGR0yMkruF0OwDJayaFjBqKW8JH5EDHprHWuwqGuPmzepSyy6kulEIiqtj636gne+eiSP0WRSTgsMNb2cpvkmEbUzSZWWMDKMd9d7TbyYaEowRDM3y3R4LBMWkoLgSMShSMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578213; c=relaxed/simple;
	bh=P8Z+yq+ik3Klzt+jXjEWumzzH563KIE6C3tKbrsN7DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQ9YH/u0wWaYTs/gpwut40pKACFtP+Xaz489lbB+LQoQutC0Kk6EQCpQ6w6sHAYNF+Hvz66Z36OUWrTK5ZcoMwhniFadauDNNd8FF1rQKmUcaXHbdYxmoT03YT6ROxZyxnAaOD7rKmeq6im6Lpq08b9Lt8Ha9K/ezL0nSvvOLAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G8IK7fSU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oacNX+Hg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G8IK7fSU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oacNX+Hg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9741714000DD;
	Mon, 28 Sep 2026 02:50:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 28 Sep 2026 02:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790578211; x=1790664611; bh=JAe9+Z9xoB
	zsvkRbtj1mT47nax7mHp/Kdv7hTHTOxTs=; b=G8IK7fSUQsgsJh7BJ6AU7ZcIzy
	L4OwlHHS6mGv8zietB4vRUFloal1IPPbH0k5BYl9NepX75JjfWTBHYofcpJfQ/n5
	yNYZIFY0NFPxcaLqdQnMmRxWTjk8tEcTh8zxHqzVPVmJOdYzIpNxyrPKJO0Mf5p4
	M6uoIHxAUxD2dOFb9pWSs/susTJpjX3QC2WAgIoQiJWT3FkUqJ1hde6Td7FYfp7d
	O1emGdr/5pDpDfR1Z22RMGk1LkLKkeywamsH/umDJu4ZMtNJUq7/5JU3+q5k5qxJ
	1BNCXUxzywtcUhSZVoXFscyTJ4GGh1Qa7Li/xfuNTdOwLX4SysH+ZlskBS4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790578211; x=1790664611; bh=JAe9+Z9xoBzsvkRbtj1mT47nax7mHp/Kdv7
	hTHTOxTs=; b=oacNX+Hg3oJCM3Zse5iZLtt3c/kYfzKVToJrBRO1VHLg7Ooo/BI
	H9WQM7UpEKQVh/L0u6TFKXwyCouSuuDAv3bQrMt7T5CgCt3iaUGJ7SwfZ8aVjjtb
	PhK4sT85kDgiSKyN4VpfpSq4iqt7rkk24m4FYFF67wVYTg70tikNwboORFPfeRPI
	OwO5ZIxQFJOVZ03qVLINCScHw/wpSPC9RSvlwwvI1ZjhTDmtYXcWnJuhn/u22DRg
	giMe2Jp1ZPPDqf173M8MwrumOct2eEejwKUlVU+jTtfD8wHiYpC/huu1m2+r2KUh
	pyh9+JuX6q7gObnw7nKt3awP+HCCFN3/9OA==
X-ME-Sender: <xms:Iw66auVO23Ql_np-Qo-tFZwBAWy4g3Qt0qmaoWfHLuzdRJXDoQvCZw>
    <xme:Iw66ahkWjX4FDKr9uMTtCZKBshMfysuJscIKuSozMHsKZWsOupvrp5mKf_p6zSgLw
    nWL_ZgzgtTz70OvxK021xdoPMxNcaVAJCBxo2cNmVphBUXDp1X1-CU>
X-ME-Received: <xmr:Iw66anbs4h4C7-kvNZSSLhXB5YutfLy2oeF_Fc5w4AlBndB0N-S2dQ>
X-ME-Proxy-Cause: dmFkZTEeUW03Q53rsz1W6feYxipMrltRrzC/DhT3bxXW8qsVVI8ztfH985Ut2n50iDlrVr
    2s0fPBh1m+HYV1RdrTl+KTqd5ZuvWGIIFzvk+N/sBGGZU6J4Wey9L7FJt+ard3q6asXNFb
    IKTuy9pPB5WlCJPRH/UCU5PatySDMWl/GCxR8z5bKF1y50fkMhdjLCswRi20T6yPn+Q1ty
    QDFQE3+RFZBV8nhltWYN/NXuBJO6AYHAYQXIVcIU5Y+2Icb9S8zx5HSBvy6pagDtlTXOOo
    1K0SM/h/DRGV+/f2TitjX27fY3xJZ/08zzUe+rbDuGC05S7PfHpjE+81xr2LVK8p5Zdcgs
    oaK4GN5R15o2qozzjXHVepKxRGwCi0drxSPLSCBP/Hm5h0ko2g4HIG/k/NtliJT0Eewhed
    xZLrYzDauwaeU/sowA0bUS9mIIpHVZOl3QEDL3IUUzOSRhsYJN1p7ltAcTCqpYCIBiYsmh
    XqUI377sYfiZeQOyFyxfRkgtrQQ/aV1I1KpSAlZiKRN3YZUZpjSUrLzzKgVOsVEo5iYv2Y
    NCyZPv5nCoiG0PAGuPemvEPXgAw9lnF2o/+EHhgz/oZxMYaR1ESiJYCPMzaWpyijDOM3sH
    owA/+3iFdtLOObqgtmFJ0QtPCAcC8Md15PIP3pYUovpEW1Gb41vzv+HBix7w
X-ME-Proxy: <xmx:Iw66akPA-DBjIce5mvGWp7qqLhNPFfwtJ-5txt29OUKwW1dIrJy7bg>
    <xmx:Iw66akZEq1tf0L2WtWWZZiqQUHVt0zs5iRaoJpPDjhKMPphcQ-hvfA>
    <xmx:Iw66aq1DYdqfFLkptXlfDhPxfSspWDpThSMQBcrb1dfCRabQrvPDEQ>
    <xmx:Iw66aidSnk_JjZMyCxUSeFcyZLpYn2A7NXk81D1FyYOaigjCBRRZiw>
    <xmx:Iw66agqwWeztPk7sbSXnr-CFLCjG-s3PrqkQ5VuEIl5Xw5hM_m5mIm-E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 02:50:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 43f03150 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 06:50:09 +0000 (UTC)
Date: Mon, 28 Sep 2026 08:50:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/4] gitlab-ci: fix the cargo invocation in the
 Windows job
Message-ID: <aroOHoSXsemSlP-7@pks.im>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
 <pull.2233.v2.git.1790280113.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2233.v2.git.1790280113.gitgitgadget@gmail.com>

On Thu, Sep 24, 2026 at 08:01:49PM +0000, Johannes Schindelin via GitGitGadget wrote:
> Range-diff vs v1:
> 
>  1:  6a389b2bad ! 1:  cdf2eff480 ci(gitlab,windows): provision GNU Rust for SDK-based MinGW builds
>      @@ Metadata
>        ## Commit message ##
>           ci(gitlab,windows): provision GNU Rust for SDK-based MinGW builds
>       
>      -    The minimal Git for Windows SDK already supplies Git and GCC. The
>      -    MinGW Makefile build needs the GNU Rust toolchain, not another Git
>      -    installation or Meson.
>      +    The minimal Git for Windows SDK already supplies Git and GCC. The MinGW
>      +    Makefile build needs the Rust toolchain that targets GCC (as opposed to
>      +    the more common MSVC one), not another Git installation or Meson.

By the way, are there plans to eventually include Rust as part of the
GfW SDK? Just asking out of curiosity.

Overall I'm happy with this version, thanks!

Patrick
