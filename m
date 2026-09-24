Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8459E40A936
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248927; cv=none; b=VtchNh60pSPoi9f8mfMxIy1pt6Vw8LS3hAlhJUuIzcLR2oTRhHagFdU+XQSl8G++724fQzirXqJYpwFgAqdvRyWMd80oblixfRliDUjR7d/XaC1tOvmalhoCJZZaZYI172nwJ9LxcsxdqpOkHlUd9ssDyQdl2PisgOfGckXm6ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248927; c=relaxed/simple;
	bh=wpr1rtCzAK3CoYbjws2Lgn4yQsm3rP79XUqwfRc3sRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYsZIUz2Mpqh/r5fU+8kmB5dQrS455t4QIPw4F7Sg/YJbpbbWOCnlJSMdWjD8q0J84mU4vWINY3P3W+BSZWMlL3dicn32cd5oVgijt7dYO2OKuqMC7Smd0niCsPLmQxj94033TTLd6Bkc41Rgy69J+8mwPw+Oo8UX/mYiIFPI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ru/lTN6M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EazdhCIe; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ru/lTN6M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EazdhCIe"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 54FBA140004D;
	Thu, 24 Sep 2026 07:22:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 24 Sep 2026 07:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790248924; x=1790335324; bh=/7gdv47LBR
	//1Z1Fof9L7apDxMsliHV99flKRs8mvZw=; b=ru/lTN6MJbEkv/m7NgdMgzMH3G
	PfuhZ/S8GcyRnWQqa9kET64M0ZYISGVGm+nRHI/gsKYV/Rbnei3A0fB5pv+QVHWg
	e/O9Pfnanm54/hUpIvGYA8tEKm9EqHoQGskKf8BhiR/1Xg3fxMw2E45Tiox2dl6M
	uN3anJsH3ZOLWFFF/4U9JhjEnsVWxnhHeHBWtLnMEKjj8gcY8b2LQOs/Hmf7+4cb
	IrrKSEz5shuwXezsDLrd9FrI9rsc11QPwMAPKO2tzPAKNVbMZ8/+vAdwxkuXM2Iq
	O8A84kDmw7OGeuCaTMfJ8d1T4ppLGHy8kilGwi+lsn0+Yx19qQADdpojgRlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790248924; x=1790335324; bh=/7gdv47LBR//1Z1Fof9L7apDxMsliHV99fl
	KRs8mvZw=; b=EazdhCIefp3x1R89WA59006E7mwdqpwoqemABUqM05NGWnJrAFG
	RZz92TEZpHOuyRuWy7aVf+mNhjnGus7ScB8GtfvK1icrAeRhf7HFrUKcEwekRx35
	iMeZ35ta+kcJ/4OsHbwElvfM+JPmPeFA1SuEX+mtzycKTiR1kkJlcHoaXUXgWpcG
	TXjGGQDA5ABoBDCUGVaMJLcDO1sTI8SWyItzpnBwNSD2YhZ1Jr7hy8CWu5xM8ogM
	ihzFDiyxekliVxZHFExezpBvoZaTdVFgjDhNGhcutNpRDcRWPH1yHHmB8gGgnMuc
	QXcsjHC+omoYmblXxFX1n6K5BAIZsu8OSOA==
X-ME-Sender: <xms:3Ae1aptytPUVBAM-9NHzC4L10AiVuINsVx9w2A-hTn4rknJDIu-TBw>
    <xme:3Ae1ap4Fgn-IPOq9zAj2CrJIPMOCNjl3BJfODwJI3uqMcQXG_q4gOpVmR_YO6wyOs
    5ZFiPvga8XNAdBhXXRraL0b-ZH5NiF41bItO2ZwWJ8nPvHYsAioLWE>
X-ME-Received: <xmr:3Ae1aqJgjoHyUo7QgdlMZ-bR5oOGExzqoLZssqzmvN2YaSG_B1Z0MO7O6LIFQwWLI9ARseE>
X-ME-Proxy-Cause: dmFkZTFvPNQ15CK9HlB3aPmTCPJzxmKcMlCrjiydP3JXAqY5s2jqRtmLJ4I+UguV3OVRXe
    nCodwJc47nhjXronKCkzDwMcMksNb+uWVjddDa4cekXkQtb/mhUcVKsA/v4wQDePkwnrgL
    iDEH2NtJ3I80dkbh1csr4KKXl3MpTBkeDu2BncGcnWpoZM9VfGTjv2f6b8vXYEjTfbOQLm
    DOQ5MgYVNeFSkf+Dqh7B4XgV3CZ/vfm8YGAmk6kSEm4+ecMBE0IBKhlo0U2QT3AFSszvyX
    a7ueuIc8JbV8+BlCDFmjJqobjDZEGInsUpQ/3RlSPY8pN//uQRhuAyU+8rY6GhlnIfVCVw
    VoMC4L5iUqvu3KvanA20d3buvFmrCZ+yyllxW+80nLSO4tfxEEflsC4aA+RNAfPjBIn2XO
    z4UlPbguyHwyp9rYkmHcUHmMK6RXlrVjd/tL68n6Uk+TCmD8S66Bx62q52EJYqRaRtKtOR
    lXDb9QywrB7wAx/TDw1zsGB+Zl/SzI1WPQMiLJb1QRuRhX4gzuCAlpJarCA6ZWUcXwGTiG
    qj31wVi3lmSKQgKiiDqvkvJ1/i4btl9oTdlos67x1HMGPpn4YyWOyJRYW4QFiXrRysW21/
    dyoUo3bN87FaUypaTmXWLQBoONecNOizz9ziGGg6bgUAsImQKbCccHH9IJ6g
X-ME-Proxy: <xmx:3Ae1ap40k473Bd_ryzhwlDn6KzbUrmQl9ow0kSQaK1CLVrDWkpvTrg>
    <xmx:3Ae1atzW_OXy5nSA4WgxwM-i2SYksFRZPIygWqM7VOxI-aj4Gk92Dg>
    <xmx:3Ae1atakEvs9Tu2EafaR535GCpStLQKz-Alakl5k1tgl7uRVykAbvg>
    <xmx:3Ae1avR8I55Npumow8LCbDaj6iSgUyNxCiNo0bbYkzjCLOJchJGPNw>
    <xmx:3Ae1ahZHCVyNfOvr5LAu6tqb5uDGAyRBrpH-ztcKvfCpmr_34CZ-Op5c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 07:22:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2c19052 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 11:22:02 +0000 (UTC)
Date: Thu, 24 Sep 2026 13:22:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/4] ci(gitlab,windows): fix Rust setup for GitLab's
 MinGW build
Message-ID: <arUH2KM2rHQwhmpf@pks.im>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
 <57a83d15fda4ad3d4297f665d6c35e205e916e7a.1789819933.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a83d15fda4ad3d4297f665d6c35e205e916e7a.1789819933.git.gitgitgadget@gmail.com>

On Sat, Sep 19, 2026 at 12:12:12PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index cd6fd4a504..3f24835500 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -133,8 +133,11 @@ build:mingw64:
>    before_script:
>      - *windows_before_script
>      - ./ci/install-sdk.ps1 -directory "git-sdk"
> +    - ./ci/install-dependencies.ps1 -Mingw

I wonder whether it would now make sense to also hoist "install-sdk.ps1"
into "install-dependencies.ps1" now.

>    script:
> -    - git-sdk/usr/bin/bash.exe -l -c 'ci/make-test-artifacts.sh artifacts'
> +    # The minimal SDK's profile resets PATH.
> +    - git-sdk/usr/bin/bash.exe -l -c
> +        'PATH=$PATH:/c/Rust/bin ci/make-test-artifacts.sh artifacts'

Are we sure that PATH cannot ever contain spaces or should we rather
quote here?

Patrick
