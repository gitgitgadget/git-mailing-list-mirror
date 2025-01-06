Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CE01DC9B3
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736161947; cv=none; b=MJO2L+hn+iGW5UEELgv7bwJ2Ba0cXr1gojgiLxI0DOKcLj53dmxTMIVcVsQKcwZO8/4BJ4NfgIfPQVFCInx8l6N8sJwvxV7NuTc++RLh5Wl4wyj0ZtqOpE9N3DwXrgIbzhh3eQdghVkmwHS4MoKo/AZqbFZH/tgfjRflhnZmf68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736161947; c=relaxed/simple;
	bh=gAC6UexhTyifLXGj5rH/5IEoBjmfu4U2s0kpyr200D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwSYcco+qprmqd7S8oG6JWk+Am0neUBLGRX/JG6p9nktTaOclOprcXb9NmZVrr+0sHlHSerssV6Bliq8IZBLAcuZHgfouaCndCBgYjEJuSMe5qv1a7tp/vK8HhaYQO3FCmvCRtd73HuzWO5v/Z1pWtFafpiTalS1x0tPMj3hTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=owj6tl3F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W4xM+CSn; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="owj6tl3F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4xM+CSn"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 61709114008D;
	Mon,  6 Jan 2025 06:12:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 06 Jan 2025 06:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736161944; x=1736248344; bh=5Jmm5AzPRC
	XG06vPeWDIxSlPD28IMwiugynMs+2WkF0=; b=owj6tl3FbB+8MBBF2Iv4/9icKS
	pOTpDhmo1PHijAEzyH0YpjR/GiBUqFeyI/TDgwhGDAdp1Tx60UwV6Ftn9ENJKl8q
	8wixKY8KVpPPEdEQfzrfeUy8Uha4E/6k/r2YN69VAX97MLsMxp0x5DrpRyxP/rkL
	2/AIllsVXwU1WzYsptM0NCM18PwP9dWZS3WDEB0b2ET6a5CwgWBc6nCmEqCCKQtI
	BJtD6PIcaOFFkWQOCoQVK/G42mmYH0GrfS+Nuz+4tO4IZ0qnm2DixsNFoxaBJrr4
	BbypUXzpua88LP7lIETM70aj/rGWgFFpgMagHBBtQRjmd3xuqNMXgxWHXVhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736161944; x=1736248344; bh=5Jmm5AzPRCXG06vPeWDIxSlPD28IMwiugyn
	Ms+2WkF0=; b=W4xM+CSnZAG1P9+C2jHRRYmO5R1Q2zGL6ScjM4WLGtPG4HL9dY3
	Jk7QjH36wjaCtLEXJ6gqkCwNgghlpz685fvinPwcpbXNN0qa5zjhpUmXUn40jbuy
	46jJCQlCIkkFlDK5Bl7Vwdx0TXTpg3Eas2yiS6KZu5wCnBQoUBH3lykRLj5VJYc4
	3hv22Vjyv/AWfUSs2bIkFQ72BvoAGusziFaEoGQmNz/e/dHqlb+oSnVzHCD5mjXn
	l0WXKztAxAHAtnLLTfWXSCuvdU8ZXhQ8UYkus2Cx9pYKceQZGMvnBHNjJEvk7q6Y
	YIhGyqEHfPMiFusB1eFfu32Vun7RldhtDeQ==
X-ME-Sender: <xms:mLp7Z3pey-0uTVzIuUH6SQqR1C0mY8jP3ll4uMzqn961ea_Z37XV0g>
    <xme:mLp7Zxry5iJ5GizpfvsEf5JPDzqCCSwbMrE2XML1T86NuQkRiWojMiHQrrV4bUEx3
    cd_0I5oONzAZV2QuQ>
X-ME-Received: <xmr:mLp7Z0PJMA015UoxyQgUjiTKDEkJo0lEGXL5FbUsUfoPh9ntVo45KQ8i_1XCZHWonVPRrSrcogUDKSGQlPziKO9oP4_faNxdGZ_1S0LiFVV55w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mLp7Z65PP1t216VMW9Me2gQTUWRvT4JYX76pblf6h-BGjlMDngeDhQ>
    <xmx:mLp7Z24FN1C3CTyhkaue6cKwclnjxtHQT9qqntGLbcnyUIDLM9bFJA>
    <xmx:mLp7ZyjAnHx5u0YlfAM_4OEZITqq8UXFTjJGtsEbCVWdpnOrE42eFg>
    <xmx:mLp7Z45S3yo6Vv4RMrESjTyTOaF6o0DmWyxkCEPtoTzTOWPcDcfWjQ>
    <xmx:mLp7Z2ESKFuryOHZNh7HM2SE2hkNPwycYa-V8Hyf_W8ew7sw9hVKFyoR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:12:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5961e8bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:12:23 +0000 (UTC)
Date: Mon, 6 Jan 2025 12:12:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/10] t7422: fix flaky test caused by buffered stdout
Message-ID: <Z3u6lj_bpM7N93Fd@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
 <20250103-b4-pks-ci-fixes-v1-2-a9bb95dff833@pks.im>
 <20250103181739.GA2527684@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103181739.GA2527684@coredump.intra.peff.net>

On Fri, Jan 03, 2025 at 01:17:39PM -0500, Jeff King wrote:
> On Fri, Jan 03, 2025 at 03:46:39PM +0100, Patrick Steinhardt wrote:
> > One test in t7422 asserts that `git submodule status --recursive`
> > properly handles SIGPIPE. This test is flaky though and may sometimes
> > not see a SIGPIPE at all:
> > 
> >     expecting success of 7422.18 'git submodule status --recursive propagates SIGPIPE':
> >             { git submodule status --recursive 2>err; echo $?>status; } |
> >                     grep -q X/S &&
> >             test_must_be_empty err &&
> >             test_match_signal 13 "$(cat status)"
> 
> I couldn't reproduce with --stress, but you can trigger it all the time
> with:
> 
> diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
> index f21e920367..9338c75626 100755
> --- a/t/t7422-submodule-output.sh
> +++ b/t/t7422-submodule-output.sh
> @@ -168,7 +168,7 @@ done
>  
>  test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE' '
>  	{ git submodule status --recursive 2>err; echo $?>status; } |
> -		grep -q X/S &&
> +		{ sleep 1 && grep -q X/S; } &&
>  	test_must_be_empty err &&
>  	test_match_signal 13 "$(cat status)"
>  '
> 
> The problem is that git-submodule may write all of its output before
> grep exits, and it gets stored in the pipe buffer. And then even if grep
> exits before reading all of it, it is too late for SIGPIPE, and the data
> in the pipe is just discarded by the OS.
> 
> So this:
> 
> > The issue is caused by us using grep(1) to terminate the pipe on the
> > first matching line in the recursing git-submodule(1) process. Standard
> > streams are typically buffered though, so this condition is racy and may
> > cause us to terminate the pipe after git-submodule(1) has already
> > exited, and in that case we wouldn't see the expected signal.
> > 
> > Fix the issue by converting standard streams to be unbuffered. I have
> > only been able to reproduce this issue a single time after running t7422
> > with `--stress` after an extended amount of time, so I cannot claim to
> > be fully certain that this fix is sufficient.
> 
> isn't quite right. Even without input buffering on grep's part, it may
> be too slow to read the data. And adding a sleep as above shows that it
> still fails with your patch.

Great. I was hoping to nerd-snipe somebody into helping me out with the
last sentence in my above paragraph :) Happy to see that you bit.

> The usual way to reliably get SIGPIPE is to make sure the writer
> produces enough data to fill the pipe buffer. But it's tricky to get
> "submodule status" to produce a lot of data without having a ton of
> submodules, which is expensive to set up.
> 
> But we can hack around it by stuffing the pipe full with a separate
> process. Like this:
> 
> diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
> index f21e920367..c4df2629e8 100755
> --- a/t/t7422-submodule-output.sh
> +++ b/t/t7422-submodule-output.sh
> @@ -167,8 +167,15 @@ do
>  done
>  
>  test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE' '
> -	{ git submodule status --recursive 2>err; echo $?>status; } |
> -		grep -q X/S &&
> +	{
> +		# stuff pipe buffer full of input so that submodule status
> +		# will require blocking on write; this script will write over
> +		# 128kb. It might itself get SIGPIPE, so we must not &&-chain
> +		# it directly.
> +		{ perl -le "print q{foo} for (1..33000)" || true; } &&
> +		git submodule status --recursive 2>err
> +		echo $? >status
> +	} | { sleep 1 && head -n 1 >/dev/null; } &&
>  	test_must_be_empty err &&
>  	test_match_signal 13 "$(cat status)"
>  '
> A few notes:
> 
>   - the sleep is still there to demonstrate that it always works, but
>     obviously we'd want to remove that

Nice, this indeed lets me reproduce the issue reliably.

>   - I swapped out "grep" for "head". What we are matching is not
>     relevant; the important thing is that the reader closes the pipe
>     immediately. So I guess in that sense we could probably even just
>     pipe to "true" or similar.

I think the grep(1) is relevant though. The test explicitly verifies
that `--recursive` propagates SIGPIPE, so we must make sure that we
trigger the SIGPIPE when the child process produces output, not when the
parent process produces it. That's why we grep for "X/S", where "X" is a
submodule -- it means that we know that it is currently the subprocess
doing its thing.

It also simplifies the code a bit given that the call to Perl doesn't
need `|| true` anymore.

>   - I tried using test_seq to avoid the inline perl, but it doesn't
>     work! The problem is that it's implemented as a shell function. So
>     when it gets SIGPIPE, the whole subshell is killed, and we never
>     even run git-submodule at all. So it has to be a separate process
>     (though I guess it could be test_seq in a subshell).

And that one should also work if we retain the grep. I wonder though
whether we shouldn't prefer to use Perl regardless as it's likely to be
faster when generating all that gibberish. Perl is basically a hard
prerequisite for our tests anyway, so it doesn't really hurt to call it
here.

Patrick
