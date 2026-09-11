Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55034490BE8
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141261; cv=none; b=Yb5pmwSq/XeBjpc2kcWXI9dTKEc572abWlVLrmuldY6w2Ie1tMcj+soJvTGgrWmqSLdicdagLszF3TgPQxlI9xKAh6UojWvE/vXHXOxVpXuxHceI8ZvztXzqsiEO4JmQf4Ubpf9I6OwSS4yYGnfA1zvPTQHHdqk+Qd7Mef/rPRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141261; c=relaxed/simple;
	bh=7KcjtXhrbYukISVr9c0ZGTmLh6NNzdjdpf0r6YXyWpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=orqTCYnscnVZUzkUYCX671O5IiHSnoeAOiinHwN1J4huZSgXgdCvON3J1UinFC3O+O0t5c1zVY8WDxjXl/lCc7kV6g3sKhZpTu7EjO2HghzqLPb3gnUVEQirQEZYR+ADPwfFbxOyHXUvhWhH61XXAQ4rO2H8qHprk3MuKuY+DV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mm4Oeyb4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C5bHGQSo; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mm4Oeyb4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C5bHGQSo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50A4814000DB;
	Fri, 11 Sep 2026 11:40:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 11:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789141258; x=1789227658; bh=Z5rDA8t+tS
	8CxfB4dimv8AjTH6c5qyuIO2OeeajekAU=; b=mm4Oeyb4BbKxJeitPO6knI3iOn
	Q6N/ekxcpi6zkoQPMlhPfeldj1WUcfSRtmT6bRaZ/AFWIXmrRN4PURnRTjANAifx
	ODcRhLnw0nobWBWAsmvCPp18rc5m46xVPwRuDmANuc1RxP8VmC3/ECjCRVfWmSCu
	BiKaac5Q/Wf8Y1i/2x1HW5u1piGTe0Tv2G6VuM/2UabdusObCkWcN+aZAWPoyZvk
	4S24Um3z0PiICqEHvcQ5vp4WqlnNL2Bw3WO3aWZ/fN0X7KVy1nxDWmHnLZzrppFs
	k3D3PFZMfS23unI67urFJMHuYzTo8hX21PtMtloTyG87q6F+vPe8oISFdXZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789141258; x=1789227658; bh=Z5rDA8t+tS8CxfB4dimv8AjTH6c5qyuIO2O
	eeajekAU=; b=C5bHGQSoncjLnuuiRwY0mNm/z0Y8f3CDAWIxMKgEFtjXF2oz4Xp
	Hc3B9eg46gC8J3+ixjayeR16YSKIkTGfEHv3tegBKJ0yRm6lMIUs3f6kccOluUi8
	grYEIW0wxoFDeemt3nC6LqnQ9pboAoayx9+pp7ElhNFPwp6OXyZ4wJtA9kyGi93v
	esYrajnGnZjYbMeydeCb2/eg1mkRZ1eRTl/xjI+1pOD3wWdLKeSk9dxcdsZn41OO
	QKCcy+oGs/Ge7qYpRGyROk8idFvAubmXZRBKjh41EvKLRtMwXMA6qdw3br+KzaqE
	VgJ9a3xY95lxMtsei8cCdCLx2+nUfrLgi+w==
X-ME-Sender: <xms:CiGkavcDSwGx0RWhJCrnO2e1x4uyngcsXEjnbykxn0qmgcMhm9b_6w>
    <xme:CiGkakSVnVoWYiHkFTy4fnd40QCECQMKcE4Y21eVyB4jaC48VvfjHIgfvVRRhmNpr
    v_vker11K5Ll7lJHvI1fUQrINLMCdTppOZSEPjIXuwIe60FP3egVg>
X-ME-Received: <xmr:CiGkautjcE_KxZdS1oXWqfzl_VUjq6ctyUyAZEER7qSjJ8maRUajH2WE0v1sqMJrKzU0EudxjaxowuxfbrEPl4-ZxDi_Fg5TGxrS>
X-ME-Proxy-Cause: dmFkZTGwKC1x6BF6tzmxTGZKnWk8LC+y+40cXW01M1uqlpPIVrvPSoGTuQh7GQW114+CTH
    1/LZJBrEybD6/rhbKGwk/5XgNZW8tWlqsTJSyXFzQ9NqWtQWKeZCaURvFqF4O7koBi1lFU
    A+cjMf2WCd6XqOcSFnbJQVrpIL9PlPylHGQ6auPxMh93BzewWd5PfqrEJkkEOz1mAJ6Jqg
    UjkEiWkCaQwnNVmv49OrwUCEZKO7z2h8Cx4kTcixq96Fu/cbFqyQIq5bBL/my8lesxNy/U
    Eaaowx2KVXHjGXWAiCFXomYdUDOhB+GOPvBnzIvwRIQa2g3N6OZUwOrdP8DJ7i6RcKwxWi
    doWpX73Znq/8AnrPbTztt78wIT9niGOn9EafG1jjUvH8JC8/U2TiKekTduHGV5RYhZXU99
    mvazdDuDIXj8jh2LEidvU501v7qJkYAtDigy+gUJcvAb3gjkDJHUBfFYtOG/HJrSY+oXJA
    4r6PButXGcEw5lH64UQt6+81NGox4JX5MuSk/LlYHvmRzg8s/g2B7Lw2eWm6AUHV2xXwGl
    m+e6U4IhlxSlcCRys+x6zPnkKvZ/nEq2EAL0/iIXqd5j3w1Gr4/Z4BwzCVntBVy32dAxpo
    FP0cLzNII7ROzKAetGN+qOxJiqfjQXoVq0/3+n8iFTo0sN/tx9PAw2hoSFgQ
X-ME-Proxy: <xmx:CiGkatfKLCgVkzJD_fqEe7IfwxF6Q10gmLBjycFwj_N1PfX4Z9C5iQ>
    <xmx:CiGkagYWwvGBLUkevtAiKD5iw9I54n_eDyyPh8Sx7HLI7x3-hIjALw>
    <xmx:CiGkanbCrLGo0Jj0mmiAamkBSAe9mS2QUSmOKtGFPEB1Yr_y9uSvrw>
    <xmx:CiGkatIg0PgYh57-35DPmFFO-33pwx7yY6Ps6Tv1Ve7d1yCBiaGMyA>
    <xmx:CiGkal97eHQq6fwzGRUOWztdfccs4oUunbzn-D71ip3TiAW1qihih8kW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 11:40:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tyler Cipriani <tyler@tylercipriani.com>
Cc: git@vger.kernel.org,  Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
  Stefan Haller <lists@haller-berlin.de>,  "D . Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] push: fix --force-if-includes detached HEAD advice
In-Reply-To: <20260910230506.1631656-3-tyler@tylercipriani.com> (Tyler
	Cipriani's message of "Thu, 10 Sep 2026 17:05:06 -0600")
References: <20260904210122.431757-1-tyler@tylercipriani.com>
	<20260910230506.1631656-1-tyler@tylercipriani.com>
	<20260910230506.1631656-3-tyler@tylercipriani.com>
Date: Fri, 11 Sep 2026 08:40:56 -0700
Message-ID: <xmqqtsnvdcdz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tyler Cipriani <tyler@tylercipriani.com> writes:

> When a --force-if-includes push is rejected due to a detached HEAD
> state where there is no per-branch reflog to consult, the advice is
> misleading:
>
>      ! [rejected] HEAD -> main (remote ref updated since checkout)
>     error: failed to push some refs to '<remote>'
>     hint: Updates were rejected because the tip of the remote-tracking
>     hint: branch has been updated since the last checkout. If you want
>     hint: to integrate the remote changes, use 'git pull' before
>     hint: pushing again. See the 'Note about fast-forwards' in 'git
>     hint: push --help' for details.
>
> But a `git pull` will not fix this rejection. What is required is either
>
> - Specify the expected remote tip with --force-with-lease=<ref>:<expect>
> - Ignore the error with --no-force-if-includes
>
> Add ref->unverifiable to differentiate between a detached HEAD rejection
> vs. a remote update rejection.

Makes sense.

> diff --git a/builtin/push.c b/builtin/push.c
> index 6021b71d66..9676c6241f 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -319,6 +319,12 @@ static const char message_advice_ref_needs_update[] =
>  	   "remote changes, use 'git pull' before pushing again.\n"
>  	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
>  
> +static const char message_advice_ref_unverifiable[] =
> +	N_("Updates were rejected because the tip of the remote-tracking branch\n"
> +	   "cannot be checked against a detached HEAD. If you want to push anyway,\n"
> +	   "specify the expected value with '--force-with-lease=<ref>:<expect>'\n"
> +	   "or use '--no-force-if-includes' to skip this check.");

Good.

> +static void advise_ref_unverifiable(void)
> +{
> +	if (!advice_enabled(ADVICE_PUSH_REF_UNVERIFIABLE) || !advice_enabled(ADVICE_PUSH_UPDATE_REJECTED))
> +		return;

Line that is over +100 column wide?

> +	advise(_(message_advice_ref_unverifiable));
> +}

This is a tangent, but on a separate thread we were talking about
consolidating a sequence

    if (advice_enabled(ADVICE_FOO))
	advise(_(message for FOO));

into

    advise_if_enabled(ADVICE_FOO, _(message for FOO));

This is an example of usage that falls outside of the pattern (not a
bad thing; just what those who advocate more use of advise_if_enabled()
need to be aware of).

> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index 0c02151747..fe6af3f41c 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -311,7 +311,8 @@ test_expect_success 'background updates to remote can be mitigated with "--force
>  		git switch main &&
>  		test_commit J &&
>  		git fetch --all &&
> -		test_must_fail git push --force-with-lease --force-if-includes --all
> +		test_must_fail git push --force-with-lease --force-if-includes --all 2>err &&
> +		test_grep "remote ref updated since checkout" err
>  	) &&
>  	git ls-remote dst refs/heads/main >actual.main &&
>  	git ls-remote dst refs/heads/branch >actual.branch &&
> @@ -457,7 +458,9 @@ test_expect_success '"--force-if-includes" should reject forced update from deta
>  		git reset --hard origin/main &&
>  		git switch -c newbranch origin/main &&
>  		git checkout HEAD^ &&
> -		test_must_fail git push --force-if-includes --force-with-lease origin HEAD:main
> +		test_must_fail git push --force-if-includes --force-with-lease origin HEAD:main 2>err &&
> +		test_grep "remote ref unverifiable" err &&
> +		test_grep "no-force-if-includes" err
>  	)
>  '

Great.
