Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C3316905
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790836630; cv=none; b=JCQIbuBPmz9iy60dB5VkuxOtGZdH/yq7G1VKS/q9mpWQlwbNxCc9164c1tFBXeujgv+I3ZbENP8/Z01qrdneUldXjJ3g43HfyNxIMBrx+W9DzwfIJ65+1QOlgOTXd/zt+wgEgbdIqggm0o6fmIHf6rAcRL+5Rkbe+yQhoJspyoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790836630; c=relaxed/simple;
	bh=Vaqm6Eic01/hb0XNsWxjJNa+ZDdnzPhyGT9MYDd26r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErDmuZkhQ4YSmxSuRz0xMMCKx8GuvqgidfRTiUQ0P2qKSN3IsR0EC2/ulg6HoXN5/U0zRrg0J6Rnnj56pnLm2L+OYHETSnxn4F0f2sNIVVsHhAY/N4IOmFooBW+KJhqR4+bz8u9OBAmrkLFFgP3FhPLDvYIzKytIMZYYR2PxOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ehOPGZhx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hfbI5HEz; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ehOPGZhx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hfbI5HEz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 86B337A00D5;
	Thu,  1 Oct 2026 02:37:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 01 Oct 2026 02:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790836627;
	 x=1790923027; bh=SB959NH7yFIcZ5nGsAOQg5m53FtB8XckS2Plv548PnI=; b=
	ehOPGZhxaS/u8OvAxZCjmZUlfgV260cXB6pOgSFVtHchymaaAVD5sJJLfGmfDgEP
	LYkBgC1AP5EO+7EcO+nmL3Ej1vERx7Uw2E2SSx6mphMr1+yKzcBxEU71QgG1B01C
	vOp7ES22pPSeBAXY2mkxvgWB9dfvDE1fqhWKU5YyAM7evGWlQIR7BGnzI3TgLHId
	76hHsC918o/yK7pZc4AjGUunKxDjpRhxzzSBlSsUHr6414JvN9zCYGUD/dDLI59e
	4YLW7j8tlR/e9VvxZpiPrMwvuzIjpQC2CL8Vvs/uPrYIhkUxvvr9OFbeESSbG5Cp
	4yaE/ZQe2mjdrFbbuddy5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790836627; x=
	1790923027; bh=SB959NH7yFIcZ5nGsAOQg5m53FtB8XckS2Plv548PnI=; b=h
	fbI5HEzxZbXIJt/epKGxuNPP9kkGgxES1Wqt1rF+9ahau2Y9yW2guQ1k4iRrtM5a
	XSc7BbqeB8qu5p0vIP6T7cKV9wL8+bZj0BvbOZj/feX+LNAE0Vl3w6nyiazSbrct
	hStXKZUEgB7ypHFpAf9BgQEgDETJh1g/N0XljgZWd6JyMfzQGXnoZ53xyFdCI17J
	53neFe2AF+rtF4eiSLgqm6B2sXl2Q2ZUSCSB34XmBPqas/h6rTm3JWHrNPEVQVJJ
	hIhAqucSiK5/ncRETz3y6ldIW/2CIej+F0QTj+sLpMbPJqq5SzUUe0stbvab2XwJ
	eNKRxo8xoyPggC+bapE1Q==
X-ME-Sender: <xms:kv-9ai-TxHpdEXkqzy34UX_AeG0WYMG67RCvTT3oaeoOtDXM2X8SzA>
    <xme:kv-9aouE1iv6g29fJOXmCrcl4KpJ1imXVvrq12Rvq6wWqVJkfpGZjH8PQleur7dyD
    nmtuPrb0fXiU5pGolYOfGB8e5KJ3s_VGA1LQYxSth5YECHkGZltuVI>
X-ME-Received: <xmr:kv-9alpH2FMNXfo5gE2p9ct7ZHyq4kFvCf1kP8G8-BzBbW0Z8mRty9iS-WXKvQLfIaHiVA>
X-ME-Proxy-Cause: dmFkZTEYgwOMIHTRGxi5CRH7Aa6yNTt79uUZOeO+ll5796I7cGQtd7GpX7X4buGZcQgeUQ
    Zeoc013yfyL1ypkfhiDl0IhAUBH1pn2xfkOtqUXgb1hXJstiT/g5ZgCf0DLlbR0o9EXNuO
    NYOQqMQHjpiBgi/1eAnQsQBXvHoSDDgoAf1K8hoSl5f7Kw3HaOYg/av0Th1KfQ3BH/2/0y
    ZWmFxryH+RBnHcy9YT87wgEp110pYV7mv0Xg6jCcWT9Ae0nbVr6GjgJbHcAewaHY/FTYcr
    tmTcN1LebRB7tTeow9tbUyDleWg4AmmDUAcG72QFbk7a8+3y6V6k8S5mGLxSB3U55aNRN1
    ktMOJBYarvLhef/YgzGbnI/QTAcUQ6n7fSnmjKzNh9DA5tspxA7u6al3CV3HXVq5USO9C8
    GjUaQj144t8EeWslvsO0zhZ3UwyXIEtVCNDBTKXzpacVu4GaFsI7t2SGPg1YoooOKEImx/
    h8ixbOSiqSSNXLuPg0HfGl2J6+aO6KXUMwmCjRu9E5WkT5Z10tYDjs5e2OAUYUarMLqBcX
    HcMCgkCpFjWhxyxG8/+McqFblYRABmJLCWRGNvAQKKo+1ulLtrmJWfqbjVa8iTwBtuvXg9
    mL8Ph7KmcEPc4ioGa1jlLzgqQgJRauFHf55sTDrnjnjS2QX1ALuS7G52d5Jg
X-ME-Proxy: <xmx:kv-9almGA_58gU6ipTS3uldsY_1L3S-mPtpurmHDplX6or3nsjr90A>
    <xmx:k_-9apynBkRkF6faC2FAqX9vxOJjz1_wgmKUIuMezPPv6bMJ_bVFpQ>
    <xmx:k_-9atlw01pxq53wQkiCF4a74rilDXRSZQi-Dt5yNXxCgmbjCTvvIA>
    <xmx:k_-9aie1CrVa0vIGUrqlvABg2vz1pRniMtlx-B6hS59pAO0byu6ZOQ>
    <xmx:k_-9aoqd7Ru_yH9RUciPRaDb6fiTcOc0X9xcDnEwIfFwdn2LOJHPIPLl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 02:37:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8d8f7c5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 06:37:04 +0000 (UTC)
Date: Thu, 1 Oct 2026 08:37:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christophe Lohr <christophe.lohr@cegetel.net>
Cc: git@vger.kernel.org
Subject: Re: Confusion with git config list --show-origin
Message-ID: <ar3_jVZPdgKSZJF2@pks.im>
References: <b93a24c5-7411-4bf0-ad1a-aa5999f107f9@cegetel.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b93a24c5-7411-4bf0-ad1a-aa5999f107f9@cegetel.net>

On Tue, Sep 29, 2026 at 02:36:20PM +0200, Christophe Lohr wrote:
> Hello,
>   The 'git config list --show-origin' command is very useful for
> understanding where the settings come from.
> This command lists the files involved, specifying the full path for each
> one,
> except for '.git/config'
> 
> This gives the impression that there is a '.git/' directory in the current
> working directory, even though it isn't located here but higher up in the
> directory tree.
> So, may I suggest, that this command display the full path to the
> .git/config file used by the current git command?

I agree that this is quite confusing. I'm a bit torn on whether the
consequence of that is that the resulting path should be an absolute
one. But at the very least, in the case where we're not in the root of
the Git repository there is a good case to be made that we should adapt
the relative path to be relative to the current working directory and
not to the top-level directory of the repository.

One thing I wonder about though is whether that would break any users
out there. I think it's unlikely that any scripts out there parse the
output. But if they do, they may have long since learned that the
repository-local file is always specified relative to the top-level
directory of the repository. And if we were to change that now, then
those scripts may break.

As I said, I think the risk of breakage is comparatively low. But I'd be
curious to learn what others think about this.

Thanks!

Patrick
