Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5B44C4E3
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248920; cv=none; b=FgIxfU5MuSU6koheTAPiLESB9MrUYpiLCF1/+O6d4YTc7ZHc8AF/ZWZKG+EcBkCFfe4Xxm1Ftfsn2we67hrTvVyJKM3uR6OQ7MnwYuGi23GO16+P9b7D5lGi4Wb5WCJZOat4xLxIPqUaOydlqhPXK7iPlVpiyJy80laW+K7MfSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248920; c=relaxed/simple;
	bh=M1gtCsHB3IT19RDNzvLRKdYji9GbHqsz9AR+MmnFWMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3ou2VUxATXuuuRiH294qqk3Fl2iL7FM3kReaezTLgj0nooRfvrj/pWECHelsZOWW7oGvJU+MxhkqHBORDDcwb0d/pHtINprFD1DxfJXebRKvZ2X8Yh6o0YazE7QQTLelswLw+VyynE196JB+xi0dYXPadCxDymHhRfVsoITjg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N9Z3dyU9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E4LijfE2; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N9Z3dyU9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E4LijfE2"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 619E0EC004F;
	Thu, 24 Sep 2026 07:21:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 24 Sep 2026 07:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790248917; x=1790335317; bh=bb0QWN165N
	g0ANIo90VF8OK6TVujrhCX63k2wtofn9g=; b=N9Z3dyU96psv7tMq8fykBG/P9A
	wDDgcvE7DBaCQSejd6V639J5juoauAiTLdV/BFLO2JncW+gQd1jWtURRbyJLzpsA
	uRhIJq9DIF57ZBUhMkjcyiMthFgGwyf4aPtZH6OC9hFd5naWYi01kf/ylggnTd0Q
	ua4ZJgIi09bXLf4WBw8m52pMz5BqBNzjDOPZlhEbC6rSepeSk1gW9IV3ZK3uSV3B
	/Pk31ZvCQSucBl6hT6lv7TF7ECes3vmnLLxR9BPC0/2T89qLA2MLMPhGa6JFzfqG
	70e2Glm0KDu9OEYXwCk0KNETTdA9+4ANcT2bNzWGR/4zgBgVzQmiBs9pyUmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790248917; x=1790335317; bh=bb0QWN165Ng0ANIo90VF8OK6TVujrhCX63k
	2wtofn9g=; b=E4LijfE2YLOvtZoL/ipN2sDwQPfzgjed8mUYlayop0HNqAm4oWd
	JHcvOfBslePJnj4l29TN6N+bcVCRtBrj2aKP1RO2r62iXTFkmkyE4Mat8Epx964N
	pOXUHb4V31yUMVSL4DZaAp/8ybauDAGL2MzDZYbMx/Ebve6AXa8eSftWppJmEWtY
	NELj3fLwztPbiFBfh+feO6rdPvL5MwuZi7sDezwZfpx5594FygYjw8nj+8GF/FQY
	WCWozmLnowqZCbnYItvXYBTIbcOuRNYlMAULVwFfTt5HE9ARbUgehHcS/2i36lU1
	ILSiHA0lvyNMhNpetf7JugYxidVA8jAQUHw==
X-ME-Sender: <xms:1Qe1agTMrb58MyWdPjorobDpBqCIe2ckCMQvGkAa3llo7cvewuV-FA>
    <xme:1Qe1alNtzZKDAKwgDxNsAYd89fbYpMOF1NIWtuoBr56xFgm8h2UcKW8Jg_VaLVjwU
    lLbNSJUsxDoHgOsrSxZa81xoQnfV_gmDCD9xOqp0roHZSMi7BbJOrw>
X-ME-Received: <xmr:1Qe1arMmsghxYI7u1NyblOq99HQXmQjn3eYIzzGyLcVMEKPam_vJ-_9Kq3ycnwyuGZfBW8c>
X-ME-Proxy-Cause: dmFkZTFvPNQ15CK9HlB3aPmTCPJzxmKcMlCrjiydP3JXAqY5s2jqRtmLJ4I+UguV3OVRXe
    nCodwJc47nhjXronKCkzDwMcMksNb+uWVjddDa4cekXkQtb/mhUcVKsA/v4wQDePkwnrgL
    iDEH2NtJ3I80dkbh1csr4KKXl3MpTBkeDu2BncGcnWpoZM9VfGTjv2f6b8vXYEjTfbOQLm
    DOQ5MgYVNeFSkf+Dqh7B4XgV3CZ/vfm8YGAmk6kSEm4+ecMBE0IBKhlo0U2QT3AFSszvyX
    a7ueuIc8JbV8+BlCDFmjJqobjDZEGInsUpQ/3RlSPY8pN//uQRhuAyU+8rY6GhlnIfVCRq
    1epC4oacKFjogxnmLPLrqk2Q+0ai07GQ2tj8JdDOUNy8oXBF5VLM1tjIkNEp4nQPwvyAdV
    8uKB/aWiCkwAfE9rqNReolySt7cDzUK/H03yKoMH/tw4dmCihHcFH05UKbFmfDsWzBiY93
    V7bBIqCvAbEIkiyw8qlLhxwwKr7ghX9SDGFr9pSvX/TktPFHLTk1+/l0+1787hcI9CxwRh
    ZcGvfW5wuYiXlKgyw1DTWTcROz53t7XvNqqf5KhM0pFzohaPBytme+3mbYdMa5dWgIoEuC
    leneUtkpdYS85AI6mnKrvOErSwgYuSnVnKENUB1mUGHSx8XmWf3zLW3/o1Tw
X-ME-Proxy: <xmx:1Qe1atvPbZK6fEn1pe1I11Du6GxHrX5f-oKdQYQ-DGGYNj41WLlypg>
    <xmx:1Qe1atW9xfNO7kI4oilyyf1LufQJY2jns6-sPF0j4aWGmGdA1tIcag>
    <xmx:1Qe1atuyrDTaoOuLQJrRWwD28U0KZBlq-gjaCmfjflxLUlRQ60wYWA>
    <xmx:1Qe1ahXz78_VA026L1KgW6LNnXLwCqAppbdc2pKvwPAb-_IHamnCUQ>
    <xmx:1Qe1alstWhqtv12dn5t5_djtjU9S8nIvfZPtB2r6UXO8EqBUAcE3OBec>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 07:21:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b49e0e23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 11:21:56 +0000 (UTC)
Date: Thu, 24 Sep 2026 13:21:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] ci(gitlab,windows): preserve exclusions during
 dependency setup
Message-ID: <arUH0v3rdq6lzriE@pks.im>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
 <8855c25128d7bd91bd6514a259ef8165f2fd81ac.1789819933.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8855c25128d7bd91bd6514a259ef8165f2fd81ac.1789819933.git.gitgitgadget@gmail.com>

On Sat, Sep 19, 2026 at 12:12:11PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Creating .git/info/exclude as a file with `New-Item` and `-Force`
> truncates existing contents.
> 
> When install-dependencies.ps1 follows install-sdk.ps1, this discards
> the latter's /git-sdk exclusion and causes ci/lib.sh to reject SDK
> files as unignored build artifacts.

Okay, this confirms that it's indeed the plan to start calling this
script for MinGW builds, too.

> diff --git a/ci/install-dependencies.ps1 b/ci/install-dependencies.ps1
> index 8c68fb0cfc..f6868dc670 100755
> --- a/ci/install-dependencies.ps1
> +++ b/ci/install-dependencies.ps1
> @@ -12,7 +12,9 @@ $RustVersion = '1.96.0'
>  
>  New-Item -Path $DownloadDirectory -ItemType Directory -Force | Out-Null
>  New-Item -Path .git/info -ItemType Directory -Force | Out-Null
> -New-Item -Path .git/info/exclude -ItemType File -Force | Out-Null
> +if (-not (Test-Path .git/info/exclude)) {
> +    New-Item -Path .git/info/exclude -ItemType File | Out-Null
> +}
>  Add-Content -Path .git/info/exclude -Value "/$DownloadDirectory"

Makes sense.

Patrick
