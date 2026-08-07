Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032103E0C75
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100681; cv=none; b=Ub7ZLxBe85Ai0aKbwZBYINU0dF39vcsMM6IGlcxDdNFKAZBD7FUpJGT9krN3tGOMfBktlMnWIq+9O2wFYKNbCAb+mdiYUP/FbVAStJPPyqCB0OHq/jcX9Gm1V4nVXD+86BRANanpAjpFlgMTTLGFfT+PCFmP+t2T2jcPmGZLN9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100681; c=relaxed/simple;
	bh=s6ETsGLJGiMP8iNA4AiVGzZjAJ0u0EqKI+PSxFvfpD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYxHJ4uhNr54HFrulHX40HuhMeYMJQE/KakebFxGlQ2u/c6OOM3ESAhKCIxFPY8TtQ9+zOheE4yyUztinHAv+EzuRwl9vjbpHJ3IEbXjL9uq+4HtdUUr28GY+lur3GXI729huO7Lapi8Mwx8sfEerPHxUZPwCgVsclXxgmGItvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H8oArym3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k/WmqENV; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H8oArym3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k/WmqENV"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 46F4C14000F3;
	Fri,  7 Aug 2026 07:04:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 07 Aug 2026 07:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786100678; x=1786187078; bh=nNU2ci+aig
	7FbPWhitX8J+5HS9/I6ZQxSoI6LUMLehE=; b=H8oArym3+FAwp/baaDY9xHzZif
	9CPkS1RG6xqQDbMt+bdJ0mJlejIavot7GDPLf29P+UmKWgZ7VH13V90CRCN6iMOm
	rpUker0dRh044kkoZnunY6G9TcG3ACKsr6OnqBp4MOS3wOcRNMAQmPyzvSskLWj4
	iG4qWTT2FxKXZSDkHokAMzd+Eo0BUHCfu0g2PovfRuEuG41PbftP8TtUp7YGgGC3
	kLv6nFC5SMlzSySrWYeLdwWj1VT7zoMUmu0pVE6nq2S9mBRfPjiFOFN7TwB8JVG7
	IqmB9szkHtdmbFE1Ka6h6exf0qHjGV4xeiXB0JDrwWUWv2LssKQ+MznhAs+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786100678; x=1786187078; bh=nNU2ci+aig7FbPWhitX8J+5HS9/I6ZQxSoI
	6LUMLehE=; b=k/WmqENVxmTVz0N62tPj09xwHiHM+bAR3YEsSEFkw2zwwnmQ8Co
	FJINmuZoV6CJn4x0V/9S1uL64YwybBQ2cpDa/G0xk3j14SlVzr1mujTgVAFwjxlz
	hU7hY4zN0lPcmaCYXV1bcaPQ+SUUvaqBlNkA8IL108S1Ti8sYiwgUEkaL7s++dB4
	QXQbFliHGXgzR1JIKdvOPrVEL3IQSr6CNGyYsJbzMsCeoQOkOffrvd+x6kSdHG1W
	03B8NG1BckhsMGm3u33xuaU7NJnolfWB76FecxLCmiACxy24j8SoBL6hQGDBxzdW
	I68Mcn+mXNXxrkduRlwoWPaXDZMy7GxqGeQ==
X-ME-Sender: <xms:xrt1arzKR5as6rv34cpkpoofYmry787mduX9ZQeH1odkxorj0c_26g>
    <xme:xrt1apTZmUK_ko0bpf4teS7CYbsOA-nWGa1gjworJtj2zji24LjjGvCmZ6TAfqNoh
    -nyC47UJZnnNhYi-R8waUfxA1M2XN-TU9KXwhDJK2KxsjMcdEdblQ>
X-ME-Received: <xmr:xrt1ai-StbXglFExM_xCg3AEA_vqoLlT1c8PbSHymlx1rTS-qUGmq05gOw7-rzrFu6ggF56_7-jvQEJJrALdGRbblWJZHsKw94tN-Xs-nEcfBQ>
X-ME-Proxy-Cause: dmFkZTE1U2jY1bOjdqk30xKc0KpBnPpAn0V1eg+cCJl3MmGSU/RrZ5R2ekRepAhCyXJfZI
    qIED1sFDFiJ/Odv/twKSeYb//a0XEue0eKt+MN6k90b3/VbF8MaH1dK8aOTTVHOq4m4YKo
    AY318jOq9D+SRcRu8N3cKjGfdBqhmsULTCH6rhKh3wUANo++pR8niPFDMYgfOF3SKwJgxg
    gCKKEQht33BltBYERnEqoeBSAwq5GP8a6hggidgyqQO5JY83xH8CX1agZlzziRYKzBDBvT
    6emwZATL1DmaKUYAVmR/89iC6hMpokUbPnkNhOUzmtv2vHsEmzsqmrWFL5kLngypkPhvqI
    ACPjiHRu6DTELXI5nVHZiO9TsYvyaQ7ZBjhvfMyiiyU4naFKJrREkL4jeqw95DRMp+lwJk
    5JYMggdBvEMlGQFD84nCEzi4edOMTVdo+wIYeFJybKPwyoJKiOfFsImDoD1MrOPJsEVk7/
    T9/PzmXl8/TNsGCWTWdrtiGW6r5/3QH+BNQEDwRt0nzPZWIZNXCTeLNJDlP/8aVgYX73nz
    SUWBGiYE2jSSzZHeuZnw/n1hJ7tChwnjMhm8/dHh+iz3j1V5uYF10MwdnaRZvJ5Z6Y2YIA
    K8FSFYtkgldfRbb0Z+pRTIJcj7olVaKECkgIF0YZZgFZEnrb9stscw5FGHHg
X-ME-Proxy: <xmx:xrt1agrB0yyHaNhIjpQXyJJHZx3ywjqIqk9-nSd3qjfw7FzW6RGlGQ>
    <xmx:xrt1avmqluDuLcprOb7UOcmAhL2WIf0T57T4shnye6-784pzzPiuuQ>
    <xmx:xrt1anJt5ibT5YG6_FIaXfTPAUYSxFQ6hES_a6viWS17GxSx7QydMg>
    <xmx:xrt1aky4HTN0qfR7vjYs5bQO91UpRVlMk2av3-e6CVIkoRWTrDPCMA>
    <xmx:xrt1aj-VGGJu02ncX20-jGcN8Q-QdvRX5nL3wuc5MooBdKTwTpj3ryPJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 07:04:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5de7952c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 11:04:35 +0000 (UTC)
Date: Fri, 7 Aug 2026 13:04:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] environment: clean up repository config handling
Message-ID: <anW7wHfUxYj9cj0P@pks.im>
References: <20260805115342.3939931-1-cat@malon.dev>
 <20260807085932.3958759-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807085932.3958759-1-cat@malon.dev>

On Fri, Aug 07, 2026 at 04:59:29PM +0800, Tian Yuchen wrote:
> Hi all,
> 
> This series contains several cleanup patches for repository configuration
> handling.
> 
> No functional changes are intended. The patches make the related code
> more consistent and easier to maintain by improving documentation,
> formatting, and the organization of repo_config_values.
> 
> RFC:
> If there are other small cleanups in this area that would be useful to
> include, suggestions are welcome.

Somewhat unrelated to this patch series, but I was wondering whether you
plan to drop the limitation in `repo_config_values()` that requires that
the passed-in repository is `the_repository`. This limitation is
starting to create problems as more and more of our infrastructure is
migrating into `struct repo_config_values`, so using a different repo
than `the_repository` is starting to become harder and harder in our
codebase.

Thanks!

Patrick
