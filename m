Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C714A60F
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598679; cv=none; b=kyEjQAHOYc2sAgVcyu+cOiI+9wf1qzFxl7UY3hyc13VR1dwYzMpng2oVvcU6iY2CJ82/CHBYGbhwsI8G5Uzk5tW4tRk+ylZXYfTePYN+CF+Gm87jqkrwpfV1N7IQTfx9wDzHiQPBr+459R21dgfvxb0CM0Kh1IpCf9nR+mMDrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598679; c=relaxed/simple;
	bh=eboXMrt3O4pFAMRy2IYWSh/MXJybnJKPTzoWirydf8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpGAnCgwpgLB+qW11N0dCCIcBgERNRACC8V5ExpnDd0vWwaWtaMwCj2iAR16m2R3juVtSDAlxll1ABtn7UtjMPmv1umn64fTfA/zlw9viyBY3sJSrcXX05n18Sy/D4eKxvqac0jkQ4QETUgybu6QukgNE7exZrtBoz4IesRuW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kgxD05+P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B/1zctlP; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kgxD05+P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B/1zctlP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CE587A00CB;
	Mon, 28 Sep 2026 08:31:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 08:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790598677; x=1790685077; bh=7fCEQi8u/2
	RCyHR+XmU8nZKOaQXwHGEzWlUf/Z5hzRk=; b=kgxD05+PYeaRaaBegshal8ZQrP
	8kmDrrbx9NsljALuqqGW0mt/hbXBCea7ye/OWR4LSVe4ldi9/7WqjiIdCfB9ruX4
	s3c6RXeCp/bR+o+VBIyCeRwDpKsT43/ZHb0cBw9LO63nprthjXkFUsBPZ9kUHdFC
	tFmGxH5Q1j7Jv4pEcNyGXSFuYIVIeBqlAII5iYg4rC5UgiRVdLQODeIvqSzbhQaW
	o0GOkbrg4naRS1p0Op2iL7biHr1SwnPPsSTIzX8KCmKYX97GPkWJKCYi5OEnuaOc
	5iGwrl8eydMwZvFiaf/C8o5ZMKdY/qcH+6ycqwsK/r55OIFhHrZHvaTTXJzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790598677; x=1790685077; bh=7fCEQi8u/2RCyHR+XmU8nZKOaQXwHGEzWlU
	f/Z5hzRk=; b=B/1zctlPabYJnt/XqiZx4PoKX2s1cK7R//hgaAySS0zhAobqPSv
	XoFk+28SgZ6uXAtouseCui5/HXzgJTIH1yOoAmtYPjG+hm0DwO6f6Nek9N+1BhCT
	An4VFdwKmNaTCUj3Kanlgr7rg9tl/opHECffD2mkF7ltNzBXN3ZrgEA0crd7emUQ
	EYp5DowAx/7kCwgVjmGdYbF5guy8p4TlmjFErAHaYftpLCm4EU8e75qYG/KA+vUE
	cr1HpTwX5DTMLrWFnk8Y5WHTMGz1WEUS5zzbciqq5xsh4QN/Ef4OFkuSWwDxq/ut
	bpUzqyILHOLDA8RxvhZUhQF7r7GcflkX9ww==
X-ME-Sender: <xms:FV66apBHx3VuJoW3tkCTqjvQNfupAufGTpzxzb-wv0cnPRtOttuRug>
    <xme:FV66au_PtrqKBFUTnHaFpre0kDez1glOh1OWXuHUjw2y9ex_WyU8j4nMptgZCKvu7
    hMhf2mUcFfPmwd3Z0LhuXBk40NoAi45HfjPo7RlxtJfs-Y5SctR8A>
X-ME-Received: <xmr:FV66ah9LeeU9dD2exw7m73pKibkiTY5hNjHvIwO1M6cQ2RYLVb6hhQ>
X-ME-Proxy-Cause: dmFkZTEpuHVqr0uc2890TwToWtUp37oYwhiJKK9Z3fMNz94vzgvGedM/3iUUcL4I4mc5at
    kxJLkGD+Hv6AwOknBrAy1wUUBsDUmp7CKPjnuJqOa6G9ovhFOEzRvuqd3V/PzIk+su/Znv
    urbUN1VBty9bYa6zA/mqirH6u3a6JKNF2XDtG8HPBZI9+qI4ILLKvC49LOint0wi/AVr7R
    ym4pxjZgFc522QwwbmB40cob4o+iBJ1r3myHV9Ar2cPKzaQpr44rl39/iJy+wmBvILliYe
    FTg+wyZK1oU1L2ErayVOOKv1YvAxLEroTfdHJ7NisVnf7JEry1+b/B8Kxfbd2XMx6Xsmg/
    0n+hYN6SbsFkr4g+rUK3ipRIB/iv3chy3nuaLUZvHebG4OmwNJU+v9kvnI8v5qjqn0/tYh
    t4rjGwaQFUPzGK3DiqKH+vPpAhNRPxf4zTjvSrsJFGs9xxdOXNuxgOA02wereYCx/BxWwP
    5N4ehn+JV9jIdl3q8Z/JbCXpc7hrq771vDEnS93REu234XViA46TPE366ZnE6HdkG7aLIu
    aNVllus0JUyw7AODmog4MDi3CEw0FAJL0e82BmxBFgP1e7LihlH0+A4ODbrveny8AGqsMx
    q17itDb2CtD1fvB1yC20D3xGalBqTC1o84vamE9tja8DQkhjk6LqvbAmhnCw
X-ME-Proxy: <xmx:FV66atdZgbmfYKnrrbxpgP-MCPwGqkVcmvVOt-2wivZolWlG_7DBGw>
    <xmx:FV66aiHmX-Gm-L32ajA-T-Qb-3eXUBOGhuV1mFpV7NswtTmTh7X66A>
    <xmx:FV66ajcjlO1N9B5N-IUzGh33gON46sZmXAv9sHF5TbgbKMJJkJ-NQQ>
    <xmx:FV66akFyPdY9aFlg6CKgMaCghiacjeqkeN_-dC2qA4wskUA7bs3R_Q>
    <xmx:FV66aibPpVuM5B4Cj_6gteikDKov8XmwH6EAHYlQH4EsIq43tC-APoyq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 08:31:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83bbe59f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 12:31:14 +0000 (UTC)
Date: Mon, 28 Sep 2026 14:31:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] ci: only warn about perforce/git-lfs/JGit on platforms
 that need them
Message-ID: <arpeDzeXlnZRwj30@pks.im>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>

On Sat, Sep 12, 2026 at 02:38:02PM +0000, Harald Nordgren via GitGitGadget wrote:
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 2f61fbb07c..a68cec64b4 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -171,30 +171,38 @@ Documentation)
>  	;;
>  esac
>  
> -if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
> -then
> -	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
> -	p4d -V
> -	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
> -	p4 -V
> -else
> -	echo >&2 "::warning:: perforce wasn't installed, see above for clues why"
> -fi
> +case "$distro" in
> +ubuntu-*|macos-*)
> +	if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
> +	then
> +		echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
> +		p4d -V
> +		echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
> +		p4 -V
> +	else
> +		echo >&2 "::warning:: perforce wasn't installed, see above for clues why"
> +	fi
> +	;;
> +esac
>  
> -if type git-lfs >/dev/null 2>&1
> -then
> -	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
> -	git-lfs version
> -else
> -	echo >&2 "::warning:: git-lfs wasn't installed, see above for clues why"
> -fi
> +case "$distro" in
> +ubuntu-*)
> +	if type git-lfs >/dev/null 2>&1
> +	then
> +		echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
> +		git-lfs version
> +	else
> +		echo >&2 "::warning:: git-lfs wasn't installed, see above for clues why"
> +	fi
>  
> -if type jgit >/dev/null 2>&1
> -then
> -	echo "$(tput setaf 6)JGit Version$(tput sgr0)"
> -	jgit version
> -else
> -	echo >&2 "::warning:: JGit wasn't installed, see above for clues why"
> -fi
> +	if type jgit >/dev/null 2>&1
> +	then
> +		echo "$(tput setaf 6)JGit Version$(tput sgr0)"
> +		jgit version
> +	else
> +		echo >&2 "::warning:: JGit wasn't installed, see above for clues why"
> +	fi
> +	;;
> +esac

I wonder whether it makes sense to have these warnings in the first
place.

Part of the reason why we have these checks is that we allow the
installation of these tools to fail, and if so we know to gracefully
continue anyway. Tests will be skipped, and the pipeline will be green
in such a case. But is that even a safe thing to do? I strongly doubt
that we'd start to notice such failures anytime soon, so it very much
gives us a false sense of confidence.

So I'd suggest that instead of warning, we should make the whole build
fail outright if we fail to install any of those tools. And once we do,
these warnings here become quite useless, because we know that the build
would fail on platforms where we expect the tools to be present. And on
platforms where we don't, the warning is pointless anyway.

Thanks!

Patrick
