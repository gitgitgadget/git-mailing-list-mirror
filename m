Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1513CAE7F
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791319238; cv=none; b=crmn+Qhf2GnyFsPgLAWmGiLb5sDoYuNP/7eiridoR+AJYfZUp0WdUbs9mN9gj0L+PNAZeavkp8aVunJ6kJsAXQK/8PvIqQi8u6nYCXCQ+PZuBrrCdgrh4cHH0zuVVNsSHv9D6i1He9wkJ5UL8BAz5IGpbMto4oEVQchC/Smyi98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791319238; c=relaxed/simple;
	bh=UCrHGLvZIUYyosrtWwCvn437HExCBI9vFiM+DWmg+1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gxUAQSolSTqQla5Z788imQIzD/RNcBuZuC6jeSsl/s1iv2KU+jkr+t5cU+nrIWYRt9zhtCSx8CA+yczGHy9+5rMCW3t7EjKpQYkiVlfr8ecfPkUsj357iEnjWiLsoatMSKFRDrzEgPzkRgA/gJiJRLJDQmZC3fPtQ/Ami1EYxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ANm47oWv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lM9tSfaM; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ANm47oWv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lM9tSfaM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AEF781D001CE
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 16:40:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 06 Oct 2026 16:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791319236; x=1791405636; bh=x42CW6XfWA
	yTvKj1keMskFnLvbxENV5FklhRLthFqnU=; b=ANm47oWvJogHSH9lkkmaHzVwC5
	hZMUbvWgSH7YuIObSD57uCFQn+qyp7MCq4hymxxEQUgifvSC3teKJAKHZIENEovZ
	lySVqimgtcJIkke8RY84DLiPf/jGDDY+wS4b9AklyyojySQnJ2beR48J1zSuwrFN
	6snGE4yBoscAO0WxSvIxyqV7u2c5EeV2D0CGYA/YReypy7sECIOq7qnGkOYp3pg8
	d44yoswnVxi24TfdCIy7Gy0I+bydRB606AGOlgErigkzBLwIQBdm9LrFflWtVpwd
	EEcmotlSGfnDH1QNoKc4NYRcj+BZCVz/QnrX5zH+L4fxdh3JC0M3PWMNrv3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791319236; x=1791405636; bh=x42CW6XfWAyTvKj1keMskFnLvbxENV5Fklh
	RLthFqnU=; b=lM9tSfaMkg4DitjEf1PY0lf7xj2dMvOvMoa5WTX7Te5RAbWHRBN
	ne+2vqFmR6/9yu8aT6R5ThVkBYObFAxl1S6mL+TFRBy0jXdV05+r7nIfrC1hNOJH
	ZUekGwO2flqpIpQxZZ63rhuDZvyYl/whWU07rUjZoogCUPfAaCBFE+AFc83jiopX
	TsCw1FZxVy5XbyGgRKkLRvCwE5rXsqAMWLonrRMpyKIgUwiAzINTPBX20cVCAvOr
	7pCJeqDyMiS5OED6VjrtyDeuE/4dLMY2fXTk0G1R7XxlJUmR6kgxYGEbHQdzoC09
	/d6QGVvCA1c5EYfw4Nrum52jOEaslGvtl2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791319236; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:nipHx5vj0MYziks1K4Cbdp877K2i6C5Au2ugxqr+hZruAKa
	takXarqXP7WGI6BkAPIwSwoF/iinjybv9vcOKcVStoDbqBE7cg7UwTwrARf0kOWg
	89GeRE6xVsShWSB89CmLpYbNKUqnuvy7BY3CWBr9jZVd6xmfZbxxdK5FXV/jpJIg
	aCMxBrjES0f2JfgGX3ZDqpnN+bbRENHuMHIaIIdkWU8XOCFMLWlMoIGagvhQL0VL
	68x/bijJraXJHtYDVV4NEgL7sjeiQDwxFSc4xHEgWFvBbuO2Xzx9Kl780xaXS9+0
	CVbXXNu4hWsIL6PhlHxYAV5jCaenlDCrtIs+S7g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:G+p4NkULFm9LxsAfUonSkMzcdaQO17f/XIO+6YUztJo=:UCrHGLvZIUYyosrtWwCvn437HExCBI9vFiM+DWmg+1o=;
X-ME-Sender: <xms:xFzFaslBrWGoWud3tmFj_f-tHZM3me2hsp8UhTVfSYvHoNniyueEuw>
    <xme:xFzFait_WE6nx8SLrtamkU_j-0xaga4jSMB7ttoWxJlewt9dC96P_g9m4ZoQb5mot
    hGRL79roCn6ZsZdtst-d2ygRTEm43z0bXYePF4D3i_C5D3LG-a1Xsc>
X-ME-Received: <xmr:xFzFai9apQZ8UREQep1Rc-XjpJmQxSH__lMA51jpAl5KLu6O7t03KDkjC1BNsy_iOi2Mm83y3CBinmQqv04HKOJJymLK1TFZEVB4>
X-ME-Proxy-Cause: dmFkZTF5s4FslVTA6XXQLI+rFHT5d7Nk5in5BFioIqfAY04GbXOMmjXkMIy5tEnapDT5aT
    vz7vKZ0lXTmwK3WPMOWoo3wNd32H4ALdbQHGnDZfK0+w6b2z9HICGxkuiMBH9HYhRh5g5G
    ByLk0TrVOlWrlNBhsgOMdvwG2dClVvrlh0cSSMSGhznLHXjNvvf5Sg6u3HiXdrJnCOWtLM
    3W25mN45sahfg7LTuQf5AoxwIUXT5vjJpnL2Ee7Mb6GeFDuRQ216NBDzzlnToCGM2BUhwL
    89alX6f3c5Y5NVyc1u3cxyN46M8zXAKacMdmonwHkby32ZkNFrMGn34Td6ZUCZ8PsCy2NB
    UUo2xdRBSVYDRjLJru2/iJCr4M3s6QAgzCRdA+RzyjDezqW6oFVDO8UjrTuGyO4XQkoTn/
    g0T/lO9Awcmx1dYXfgBxdsGYB0u01gkh6QiArXYgj7Wtt+o3A3s/jVEWdStTsSl98StNaf
    JpFk3VWZWVa+GpA3Hilag1BW2jVYEfM9f+S/LoMiO8xuPHPLu/IwanSsVTgx3erunbwFdv
    pWxiqTowbHehnoMwdln0Lu2IwctqpownMfN8vHkK+fgC+T93L9g/HMooUIlf6PU3fVvOI0
    nazaBnn7Q6bJ/l9zmAFEbBdICiOOhJiQhX6tkNIfNbKmMLzdvPr79DiLoozw
X-ME-Proxy: <xmx:xFzFakPKYs6rXbE3fIF9tdaH9jCCHEDawUQdHyv6PnPncJZIfDWoSg>
    <xmx:xFzFaoENomZ_aqYj02_eISFeeAAoDT0Nf0aoqatU7JYjec3HFo4rdw>
    <xmx:xFzFaqT_CaBrX9GeyAIe_VECK4J_l9LGF8L-PeUt4mJoNuQr2_qZfw>
    <xmx:xFzFatt4WFkhpujjZqyHSCdZEhZIZKhNG_Fj8cLiAoZpe4As3Ly3Mg>
    <xmx:xFzFan_bJKshmPG6t6oBRwa_uMYiWraOeaY7k6Jxp5d7Cd3Z2Xzv3ZqY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 16:40:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Tuomas Ahola <taahol@utu.fi>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v3] doc: don't require a SYNOPSIS in section 7
In-Reply-To: <pull.2246.v3.git.1791305670386.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Tue, 06 Oct 2026 16:54:30 +0000")
References: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
	<pull.2246.v3.git.1791305670386.gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 13:40:34 -0700
Message-ID: <xmqqfqyid0l9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> Remove the SYNOPSIS section from the section 7 man pages where
> appropriate, to avoid having a section that contains no information.
> It's not the norm in section 7 to always require a SYNOPSIS.
>
> Update the perl script with a special case for section 7.
>
> Tested by running `make lint-docs`, and looked at the renaming synopses
> with this fish script snippet:
>
> for i in *.7
>    echo $i; grep SYNOPSIS -A 5 (string replace .7 .adoc $i)
> end
>
> Co-authored-by: Tuomas Ahola <taahol@utu.fi>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>     doc: don't require a SYNOPSIS in section 7
>     
>     Changes in v3: Make sure that $man_section_number doesn't become
>     undefined if the first line doesn't match the regex
>     
>     Tested on a file with a first line that isn't well-formatted to make
>     sure it works and got this output:
>     
>     gitdatamodel.adoc:1: first line must be formatted like 'gitfaq(7)'

And it aborts the whole thing?  That does count as a lint.  We are
promoting the "assume the first line is ..." to require the format,
which is probably a good thing to do.

Will replace.  Thanks.
