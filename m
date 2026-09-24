Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1957C2D0C62
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248918; cv=none; b=TUttuWX5iOWhceOT5kBONEPfkOoVFJR8aGU6etYN30dPTlaasKrJAhWxk1j86MbzdlKhBRT1qM+SH8O13QaX2BL2wbYOGr9SNpvGCRC/2L/p/XVxhQwdqGjGl6BYZ7NbLuJHL20IVD8b9lbFtO2lNlJoOH2Y/jxCqA28hSny8CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248918; c=relaxed/simple;
	bh=ujs3ZCEliHTDg6XrTId0pQ4Q8F6cIedGo5LMINVslZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJxDAYMDCTUQmSg8yoCWUZhSDKKYssoItf5i7oREXHvAityEUKmoS04vcAqcu34iGRctAiSpuDpTUKbS1pmkCdm08SPUOoxHs+Tv6Eozx5NAsLI1DnYFfbOXPThp1I6GbLCP19fLtIL9dIgAwyb17SMzxY6AtCFWJsVxClK+jxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nJF93RCD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hhid/wIm; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nJF93RCD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hhid/wIm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B659140002D;
	Thu, 24 Sep 2026 07:21:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 24 Sep 2026 07:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790248911; x=1790335311; bh=OiQNQ8PrLe
	xS0rysa9QFU3Y8o9gEkrtGufkyFgV6VmM=; b=nJF93RCDaRF8RZEVEi3GDnI25A
	gUMZXfQ+00lNNVlZyGONSznl2MciHrQAAlOXkTDwV8ZRQwXGcZ/2UodEBOGNZl6g
	hyHLW+I1JzC2kVS2dWRCsXf1F/9qlcoe3zIFcSz8XyTcBxLGkHfTfEgqrCI+9iH9
	73hKGIfsFCevysDPm1bBHE50TgQZgqOBw2zFmGyy666garYrezOOw00Dd6Zo/H8p
	o4t1p3B/bag2FMxQktljIuOeFrSO7yjiWRES8igcbUtuSGYaYyxlEc2dC+C1sAE1
	HKyS79OLarSGOkSeFzNV4HY8XcAe5snW9oJ0XQJIzWNc6Pr858NX41CePS7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790248911; x=1790335311; bh=OiQNQ8PrLexS0rysa9QFU3Y8o9gEkrtGufk
	yFgV6VmM=; b=hhid/wIm9xkjF/zEjPXyXCBzkidOtmJyjKWPwRE3iqwb4vRb46R
	BXOJJ+pKODm8B5+MVkU+QNwOx6deLPc9zcLS6mdn54IwZOTHMZiPRrlkL/jMbyTh
	Sb4gKyV0fEYDscvpAfubLHEW7iaQePNRYoDImwG0MAC28J/gMkH49DQBwgmsJr9B
	V6E5IENueikKDi/xwYLm18NdCel2fBOIdQ3tqHqWYY5sf9b2ggqd0ovARx+GObMS
	R+PVSV2ipoMsrgbCRH4I6HpY3VL7VOCkOVoeL0XSa51wMCo21yFBGwG23OsiEgk8
	86Vt8+juxE1oNGG+XaTRCNOFhwQmX+mkTLA==
X-ME-Sender: <xms:zwe1atJ7eZZk8HX30aotEJqH2B4LV3Unahs2gKUf0ID9YoczmGIyTw>
    <xme:zwe1aglcYirOvuw02HvfG2XGKPFuwhojm17AXlqFAkDzJxfsdLKXXUEkI1rS3kgXG
    T8MIvQvIIyl0R1H5s4vEYXEcrb-IIwbr5gU9jV2fQLUo2Qyxx8e-X4>
X-ME-Received: <xmr:zwe1ajFOW0WxfTpZexUv5vWBTZGh8uC05XJ_DaStWzDH3TLInmiD-X4AFXe3ozS2TEL9Tig>
X-ME-Proxy-Cause: dmFkZTE+aTbrE9ghSzT97qPS5vxtiNKJ5dRyX/+yEDJMS8D1xU9QxoCK6Ixt79nyblI34a
    dsTikztVsEt1HXdMfVt/lvuA0ksBQC8Wb5jEIkie9y7km/Py1ZWf6kKJq7s1eswmh3mkm0
    yM4P0yFUG1RdVcVOYV9pfD9BAewBx6dhvqq1QLyLG4gTTlTRyQleAhvwfbBuGlfTYXJyhx
    ifxTW5X+Faf88xzWw95WdFNvxeCIGenfQMBCYuLeqA/Rq1wLZbkJMTWakZcLIspv+o2vZn
    J8XrSPnfibH9Q924RbhEwX5xaFWxMR4cQ0+uzxS4/7MT+qJKubLoihAVr2JXpVYETK7HcL
    uRsd7kD4Uo15PRgxp6CtR1cB9BkStj+e52i6bScZCVbEJPaGZUYT8/AzgHPIAVLWy2sPiO
    19kkSbXCCGQKOx5RzhNL099MKVQQWpcEfzTk3hLh9mVnWYoXRLg4YyqiIzJw/2CgNhW7fF
    8OkCnVxksy0LJFMHOQLWogXhd47Nj2sF0e/nw79SXryNIF0DL4FN5WiWRAccW2ou4ISExs
    68N0hzhjOPTB+hjWgjZfPp7aD8A1YINoyiuXOQzHjxeFKz+hw0fGlj0YJPXZ6EvX4QPxcD
    sXqRZxZnUMcIl+UZ9VxE7g98ugNRg0gST1kIK2bKvoybo3Yl1wgC2YcHl9Nw
X-ME-Proxy: <xmx:zwe1aoHUFgy5Y-O6JXfhpDPxl5ESklClXyGy7GsS0mIzsNAsKLI24w>
    <xmx:zwe1aoPc8de_CJ77OPLTAzM1RwIWX-GvHUnyvsY0sF0oPodJHJw_uQ>
    <xmx:zwe1avEWbiv56maHinOYdjHzBieI-kfDGp52WyXvRK69vTCVBxt9Kw>
    <xmx:zwe1anNUe_h2p27Fusy-2VbcvM44C0Jy7Xw5XurdNwOGCc0bgfKO_A>
    <xmx:zwe1avFIYy2P4mJnhfVku_wiKU9423neK47JTwr-B8_ueICgBpZ08ffc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 07:21:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 512bbbd7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 11:21:49 +0000 (UTC)
Date: Thu, 24 Sep 2026 13:21:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] ci(gitlab,windows): provision GNU Rust for SDK-based
 MinGW builds
Message-ID: <arUHyjHAX20ovmr8@pks.im>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
 <6a389b2bad1653175bde2a767ffbb5b672e324e2.1789819933.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a389b2bad1653175bde2a767ffbb5b672e324e2.1789819933.git.gitgitgadget@gmail.com>

On Sat, Sep 19, 2026 at 12:12:10PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The minimal Git for Windows SDK already supplies Git and GCC. The
> MinGW Makefile build needs the GNU Rust toolchain, not another Git
> installation or Meson.

Huh, what's GNU Rust?

> Let the dependency installer serve this configuration while keeping
> the existing package set for MSVC builds.

Okay. What's implicit here is that we in fact don't use this script at
all at the current point in time for our MinGW build, we rather use the
"install-sdk.ps1" script. I assume it will be wired up in the next step,
so let's read on.

> diff --git a/ci/install-dependencies.ps1 b/ci/install-dependencies.ps1
> index e3b367fa54..8c68fb0cfc 100755
> --- a/ci/install-dependencies.ps1
> +++ b/ci/install-dependencies.ps1
> @@ -41,6 +42,17 @@ function Invoke-Installer {
>      }
>  }
>  
> +$rustTarget = if ($Mingw) { 'gnu' } else { 'msvc' }
> +$rustMsi = Get-Installer "rust-$rustTarget.msi" (
> +    "https://static.rust-lang.org/dist/" +
> +    "rust-$RustVersion-x86_64-pc-windows-$rustTarget.msi")
> +Invoke-Installer msiexec.exe @('/i', $rustMsi, 'INSTALLDIR=C:\Rust',
> +    'ADDLOCAL=Rustc,Cargo,Std', '/quiet', '/norestart')
> +
> +if ($Mingw) {
> +    return
> +}
> +
>  $gitAssetVersion = $GitVersion -replace '\.windows\.\d+$', ''
>  $gitInstaller = Get-Installer "Git-Installer.exe" `
>      "https://github.com/git-for-windows/git/releases/download/v$GitVersion/PortableGit-$gitAssetVersion-64-bit.7z.exe"

Okay, so installing Rust is the only thing we will want to do on both
MSVC and MinGW builds.

Patrick
