Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667653AE6E9
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540731; cv=none; b=WqjIkDUzmdkX9m+Fm2RUuMaBXe1yRoPh1VKwOokNsvFfZV5gNHBmOXI30nwmrnE2dT8sIx2tyKyaRYE9UFSUomP9RHNRahfa+Z18XeJKntyPy/ivmDLGsK8mgk14zNH5Qx+camweAmeeFic0+6U8RHwXKGVHzgDZfRKREIk0rRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540731; c=relaxed/simple;
	bh=UjFaZyvYs8qRgX/M8LKij+9O1ocOoeJSjOTxoE02xw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k3CZb7ci+z6pZvf/YGmJt86zx0mdQHgDQuI3wh2TrGVSRvfOCh//GvjQg+5kYO0Cc6vCpmafaB1c8wlsNs/h16VlkOU2X4wcWT7K7XJSLnM832aiCyZkc82aEoUZVrpJuz0w3AwqUfFEY9Wa9yLW6oSLa7BmV25kPX0zfo/i0sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m4oD2PZD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=im4aIKOx; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m4oD2PZD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="im4aIKOx"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id A6A9B1D00116;
	Wed,  8 Jul 2026 15:58:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 08 Jul 2026 15:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783540729; x=1783627129; bh=vyEbErQGoU
	nPP91VhwPfgAbcxCQaJARA4AHLPIIWwk0=; b=m4oD2PZDgwbFJSzNgueJbvCQcV
	b6G58hNfavdIjT+4DCGZl6IhBn4moaudOB/mf5XYlnTxF+kCkara1l05Gdo2gtiO
	v7J82zC9kSWxk5Xf/qJ9oRfXzJWH29epy9o7iJfIez249wGgo1duFTKZG8vz9uqp
	msxHHht34ew0wEUnlCqW2K2lQU7u5JSUys9Ch5bEENyloMl+IkbwMkLtsd+w4IpP
	KYVhXbWsS7rslT5TgczCYXLNCQcKZ0fHEuvJyCbS1o26TXWRNWLXey5F7UQdCmUD
	b2gDktRVHDt8t0wWrBId4HVyoTVWAL6bN5ZvleFXf5uguB81fh7lRo7hj4FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783540729; x=1783627129; bh=vyEbErQGoUnPP91VhwPfgAbcxCQaJARA4AH
	LPIIWwk0=; b=im4aIKOx4WJEfsw/nMLtcnJHdpinV7S867kJo5CU+LZQq+bK7gx
	YvJK3vsiVA5JmUU3yhLPtI4RJcGfbpSO/Ok6A6R4wIQX7oHUkfCIpaZXxsF0obqz
	xLXzW00GzpUzfaorwKxc3qeh85+tJ3st8CyN5YOKbVpoBUI+iVi0KwNmZG+LSPQY
	oXrsOcS2j06/R6KL3wYJbNo83ZcFQOEu0pMKJrK3aYaPtabNO0DDoE/9tvNnVYfr
	OWNEXqRsjQAL762jgVupPj2hEOPSB8yN3k3xsHOU1f/IAp/YRS6a6B94gzj17d16
	j004OJw4q8k72zuxUE9HKfIvuOlr+V5TosA==
X-ME-Sender: <xms:-atOaojgMr_BozWfsju5kSrPKh-ipdcj0MEXAoeCBKgWe8H_p7ajeg>
    <xme:-atOaoCK8m7MhfWz7e4aJ5qQLp2R1P-aojPa8mhBloPjO7tP23hK6V0bX4AJhu8Tu
    g5uiCbc6wE-YMSJRYTavWwnHp6WVivWDlORO7wqRgqJni6pjLmY1nk>
X-ME-Received: <xmr:-atOalEGnkGBNcGTgDu12BV3Js2KvhXnFRA9mAJeyvr1rYlNKJgPPxEOPuU-6p--WBX1087hASv14VnA85yCyE_zQd3OKRywF6cHZFk>
X-ME-Proxy-Cause: dmFkZTEXkKWGMmRAWN2sJuGfTctq95cDWQGAWX/rgw3kOK6ItOYQ4fKfcO/gpkOzfje8kO
    Pfcb/R6CIqnPiW1ysU/B0MtmNsg84putrS2pPf1aRzkbvDgJcfuMu4EHDtfEuFMaRztxNc
    Mdu/XjrHtuUkeN4aLUR9YscMCoHMqP8/yWDFoPMBndti9h9WCZgP4yp5/zO/8ZYazSHOjA
    +krd6DOPUuA6eUpCWsPd2i8kEzmbIYOHmHCsdj8qGp1Xh7pPVZ90lZY4R87R5/hXR4kwbZ
    lc8QDtKvw2eMWMRMn9w4zuW4tnWstkYocpVIMvDyQhU90dn0zme892JW0Fe8TaQb2rHpk0
    pXnBxvwCdXvSpb8VsLHchuHYU1Q154Q/PTkfVJ7SMGj50C2Ani/0y+RWnBGG37H32l5+YQ
    GsR82+prT5gk44rXCVfHYS1abfs3SvT+Fd7zq/gA146N1Z+Zw9t8mso3UhX+k8IC77lncA
    ufsOria0829toNYQOUlt8FHInghpMJBNxveVFZz+lbG//kvXaqJQ6KFmXrW92uskdmuFph
    u4z1LVtGMy840U0Gx6Q1dCXjMdLqfGaNBVCa/yuriq1z4wco6CuD1y/rhAFVXZd0+zhZM7
    9jrkSoJpXdPk4H6HsABfoxXkMSjdI1fCokivSLcPMtpj6JaoEy40mNpmmX/w
X-ME-Proxy: <xmx:-atOaoKEwdMNfF8jII0ScIsF70V-MRWI6Lx09qGrmzVw7AzdB6Tnjw>
    <xmx:-atOahlti5f2KcZTHv3Vbmw6ijv_pjlChsoI41hxULW6WjpV4XfxDQ>
    <xmx:-atOaoQ3BFpm5IwojjgcatPXcwruNag-BGkAP4Gx3IK4l3brQxJcpA>
    <xmx:-atOarJOR0tEIeehR3eUxMSOO6Xzepi7gjnO1Lo4kvuIl3FybzFAZQ>
    <xmx:-atOasyosNt53vtfaZ-Sma9uEhDUrRRCvY-cvsfbEsm8yui37gMab2p3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 15:58:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH 2/3] t/lib-httpd: make http-429 first-request check atomic
In-Reply-To: <efd34c17157b3183cdc851c8b17e7967b6c85506.1783479584.git.gitgitgadget@gmail.com>
	(Michael Montalbo via GitGitGadget's message of "Wed, 08 Jul 2026
	02:59:42 +0000")
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<efd34c17157b3183cdc851c8b17e7967b6c85506.1783479584.git.gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 12:58:47 -0700
Message-ID: <xmqqldbltfrc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Michael Montalbo <mmontalbo@gmail.com>
>
> http-429.sh records "already returned 429 once" with a "test -f"
> followed by a "touch" of a shared state file. That check-then-act is not
> atomic: Apache can run this CGI for several requests at once, and two of
> them can both pass the "test -f" before either "touch"es, so both treat
> themselves as the first request. The retry flow that drives this
> endpoint is mostly sequential, so this has not been seen to fail, but
> the race is latent.

OK.  And use of mkdir for atomicity is an obvious solution for such
a situtation.

> -if test -f "$state_file"
> +if test "$retry_after" != permanent && ! mkdir "$state" 2>/dev/null
>  then
>  	# Already returned 429 once, forward to git-http-backend
>  	# Set PATH_INFO to just the repo path (without retry-after value)
> @@ -52,9 +55,6 @@ then
>  	exec "$GIT_EXEC_PATH/git-http-backend"
>  fi
>  
> -# Mark that we've returned 429
> -touch "$state_file"
> -
