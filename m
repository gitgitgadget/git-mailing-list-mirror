Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C69B1714AA
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406644; cv=none; b=SANJzvfYNdkZZdVWKJmwaHFJHEd/YkKJ/xTppelEKR+nQim2UR7pRUJGgBcNVNo7IFF0+nHEGkE22FW+7GNbnB9qITlkj60e74XUQxraW0pZ89JOL7txL0h8a/CEj4Jz4NR3Z25syxgnbdZBrurrQeBUkJfgM9HQ48MsJqLDrPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406644; c=relaxed/simple;
	bh=nCqA5NOCP4QRg6IX7FovwuU3maxUkHlTGfEsM1m5vRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SUMeAwbcqmd56fT4P+0cW729ocMZ2jOne8sNBbgPqKgCpw25L2nKimn7dpTL9FevO0VW6VHXyWXMFagjQDxqZuTHHVG/nEGjn98hFXHwRCze+bGobCusCqbAwEFAIhqvZIDo8KGunShb5sFtOVy5N/BLsMtwSYwDFQRX/CYjUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tXWXEHI5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tgpvw1Au; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tXWXEHI5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tgpvw1Au"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E0A2D1400170;
	Mon, 10 Aug 2026 20:03:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 10 Aug 2026 20:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786406639; x=1786493039; bh=a6ca0Nx1Fs
	bk8m/mPSEWYch7BK0YWNydvMcDz1d8AxI=; b=tXWXEHI5gU96r88aR9m+23fn/O
	L9VP1fgY+lklUg/QLUL0BMMENzwlQHt4h5feMLQuBwBDmFqBMBsmzZ+agaYuHLX2
	Qm+72G4KN6Djicb3XDDwhZ6aUaCs9KlpvnfVcXC2CmB+eyRGZFdx4yLFNUtQQDkv
	xCSHOJb8gqmhoWl1bxtVdJjw7LmQwf3+/YFznW71YhcfpAOtgKvbOvWf7YCBcvmk
	SOLOVoXT/PsiAp9IHjmeHym2dCZrfsGKbTk0BaBC3KamMSC2Km10CdBYC/mT72nY
	p7x8DZDmgBWsPHFkyuFwZ3i3KIIHEEb++j6B1TNGNvjYG1SWJxTh33+DVBLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786406639; x=1786493039; bh=a6ca0Nx1Fsbk8m/mPSEWYch7BK0YWNydvMc
	Dz1d8AxI=; b=Tgpvw1AuAWuaWcxKK6GY/KgHhqsUQgq3w79784XXC7Gb8KxdU3d
	aZACXL6VwwAe/tzaj9DWdZpOBmRuTknXKDQcRH6xY9bUH38GrvMO3bbz0JAWPSvl
	Qy5xJcJez2oylNVTiITzvFi14I58Hz1juWr8upJRj7Ecsfq1m7HgEzuurc/BUOFS
	A1UVSyRj2RHFdnz9MLPk0j/XgXUUPyNPe0A4HpsUkv+9RDkmpvjgdwtJmLkboJGe
	T9zeqaPvwbb2+Ep9L81YflpNjxIGsm+2HgQGlgEPgevgTuC/uY7BQto3yARYYA6Z
	7lL0XS7n7iOjfuE1IGaTnQbNVSzdJ6HRGqQ==
X-ME-Sender: <xms:72Z6aoEKVFmN82N08fySU1y-DoZoejkjvyJpexcjES_kjr16XZ2d5A>
    <xme:72Z6alCglQ41KSNlN9NYbkvbFh62ilNaGKWbKqAIRpAg43xRkGFXxAKinjdDD5Mmh
    tVz900EKdJKRbffED94e4pm8cQ5iiDlmn5zgJycC85A4-WGUMKuEAI>
X-ME-Received: <xmr:72Z6ar98QBYGwJjVizB_AwywPS-QoyKE_Zwf0xvNi_jt5qEYvNqsMWa3_N9TvSpsT6XFNsCPzRPHp3ar-Y9L_jN2Pwgh7Gbz0Q>
X-ME-Proxy-Cause: dmFkZTGSZx+RO73uBzx7EWdBv5gzSsbtbhDXKnKHrL8jdTNkMamAr5s15OWEjHsIoQvci+
    1CuVJa2MGsidvooNSww49+wNBJLvSGez33LQs1F+mFYf5ptRG7O67zhjrIJsa0b06FuEVi
    W/KG/SlJW44Ep+FwVpqCtcwaO8WuWGE8acUgk6IDGBosExGUCL4rYaE3qzo1qXTmBfPYRM
    B0afIdtlMZbKEshBOaC4wtvAvFnnSCZKb0E3PZ4Tfn7bIcislh/0E7Pvx/rIVf2zFkWzjm
    Am/NmY4EbJtiaHBGzY+Bo22j6GjPzNQXhRIlqWF7SgRsEsVokLFHa1vB4sKQvRi+Jp9TnN
    XthfomLDbCiTLQs4zcC8Sz+7nv348aUwWQpnHdltOMtt3xPtevanxQeLKa5uZ/ILO989dP
    yty1o65za3ncM32JcTFCHE8QFSSnRPoppapYxME58zABFjshxIyNS9qz9oLVUOY5g1R1Dy
    DBZQqrjfwyu+6U90450j2jSlnjCi37IU73jikC+UdS1LWXPWQgvR+CqDJKC4ZjPKCHWFC5
    1IMmCEVcxzHm07rnu4sB3THPV0rdaXJXmOFb+TWKUw3EdhL4j4gN+fqGaLUDWhjgKCwbq/
    sVyFj2ffSVJaJerqZzftQ11IUsIwhxImMia6LCmw8NX3YKLv6aFXRWnOSN2Q
X-ME-Proxy: <xmx:72Z6ahAniu-Z4wRb7VlTC1znJQkHs9alcP-e2NoRMN1mgerifrXFxA>
    <xmx:72Z6agTRIGbPleyIlnurfOPpVyieuCQ5SwHzvPqLlWAcFmqsu0PpLQ>
    <xmx:72Z6aou1oq5D0PPxcUhsq_Nmm1rNAFiNJFWb9GHOzyQ5AlCI4jpZdw>
    <xmx:72Z6as2kjn7YsbjE87lWBclfSAAxWb99sOjZs10wlYedyiiI2PR5cg>
    <xmx:72Z6aipiNMLGWqYnjIq9Xgkex-QzTL17W3-Pa_B8bQrHttu2UJ1yO8KT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 20:03:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,
  Yoichi Nakayama <yoichi.nakayama@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v3] worktree add: improve message for ambiguous remote
 branch name
In-Reply-To: <pull.2197.v3.git.1786395305884.gitgitgadget@gmail.com> (Yoichi
	NAKAYAMA via GitGitGadget's message of "Mon, 10 Aug 2026 20:55:05
	+0000")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v3.git.1786395305884.gitgitgadget@gmail.com>
Date: Mon, 10 Aug 2026 17:03:57 -0700
Message-ID: <xmqqecg55xqq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
>
> When the user runs 'git worktree add x y' command that does not
> exactly say which remote they want to work with, and there is no local
> branch named y, we try to guess which remote by passing y then create
> a new branch named y which tracks the remote branch.

I used x and y as placeholders.  The readers would be helped if you
used a more plausible sounding names, e.g., naming directory as
something like foo-dir (the point being 'dir' somewhere in its name)
and naming a branch as something like bar-topic.  If this were 'git
worktree add', it is probably more than likely that the destination
directory would begin with ../ to have the new worktree next to the
primary repository we are running in, no?

> If there are multiple remotes that have branch named y, we silently
> gave up, leaving the variable branch intact.  This later causes
> creating local branch and worktree not happen, and we end up with
> passing an non-existing branch to lookup_commit_reference_by_name(),
> triggering "invalid reference" error and die.

"This later causes" part still seems a bit too sketchy to help a
totally new reader, even though I've stared at this code long enough
so it would be sufficient for me personally.  But these logs are not
about helping me, but helping other developers, so...

> +#define WORKTREE_ADD_AMBIGUOUS_REMOTE_BRANCH_NAME_HINT_TEXT \
> +	_("Matched multiple remote tracking branches, you can list them by:\n" \
> +	"\n" \
> +	"    git branch -r --list \"*/%s\"\n" \
> +	"\n" \
> +	"If you meant to create a worktree from a remote tracking branch on,\n" \
> +	"e.g. 'origin', you can do so by:\n" \
> +	"\n" \
> +	"    git worktree add -b %s %s origin/%s\n" \
> +	"\n" \
> +	"If you'd like to always prefer some remote, e.g. 'origin',\n" \
> +	"consider setting checkout.defaultRemote=origin in your config.")

Instead of throwing the problem back to the user with four extra
lines of message telling them how to run 'git branch', I would have
expected this patch to teach unique_tracking_name() to optionally
return the list of remotes with that branch name, and to use that
result in this message.  However, if the goal is simply to provide
something better than 'invalid reference', we do not even need to
go that far.  Just stating that branch 'y' appears on multiple
remotes and asking them to clarify which one they mean might be a
sufficient improvement.

Could the original request be aiming to create a new worktree with
the HEAD detached at the commit pointed at by the remote-tracking
branch, instead of creating a local branch forked from it?  I am
just wondering if "-b %s" is too specific to one possible
interpretation that may contradict to what the user actually wanted
to do.

Thanks.

