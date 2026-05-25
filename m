Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3318B0F
	for <git@vger.kernel.org>; Mon, 25 May 2026 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779749655; cv=none; b=BRI1+PCt/96pXbY5I9tiL5aROMwFweBnzEgW0rx5TXGoDJfzpnSWDrhIqeMhAgDmWNoqPbtdEFieltjYa0NUwPbcw03qQeCub8CQspzrr/kjGvFQYUUW+ssFVEu/D1YhTa2YkWVaI9723wnTKPEvS9wswEoupIORw3fff43YWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779749655; c=relaxed/simple;
	bh=6URr4VX9erhXiefJRBXE2CeB2jPxhYqlETp0Io12sWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iqd+B6ISIqVPp+YRWsmMY802MgTSvUxwc4SpzxyVmpbdimNlgq3YgQagLvfKHjbY6TGTjdl3Qr7HMpgpF3EmrDWBxJzx0EgiSDfou1wtDV73ewJjOLDPYCJl4tgl/jXKmnj90+grUZ4+YDBiwg39NZV1qe5qcF5Y6GkrjJA0Omg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nbr2s/Cx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=spvogxcx; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nbr2s/Cx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="spvogxcx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7AC6D14000C1;
	Mon, 25 May 2026 18:54:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 25 May 2026 18:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779749653; x=1779836053; bh=BexlhmGg1u
	SAWcVi4SofyBJEP2KhkeP95S4rWbRSD5Y=; b=Nbr2s/CxR9WN8//zcwFv64S3Lt
	rsTBuhFnMG2gKjyJoaEjQkP1QGzOMlxhPOdb6+DRJ1TQ9CUNAEq9ehX/Dnqvrf08
	Kom2RH7fliJtaaaUkbQvJbAnSzy7eAKvo0KLQB2Z2MHOWi98PlwiN8epSfoLhi7y
	1t04xVBl06Jx1d8zgIwSE1CSPpxX5inEPclyl/RKBTynlewBHZhVZlg84HYJe2ab
	JGHMEj75jPzl5+TPxNXqGR4Pg7+n8DiSeP/Xy7y7G0LIlj7fMc0dmuoZ7HZ7Zfhk
	tDhEXjiYD/6OZ4qDOKKT+gKKzCWNtq42n13gWUtj6sJEyye7NKD0tx7TEZOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779749653; x=1779836053; bh=BexlhmGg1uSAWcVi4SofyBJEP2KhkeP95S4
	rWbRSD5Y=; b=spvogxcxgW4h8VegIsxQLWHZEHD6wb8zoXnhCNTDgw18e8Fyj06
	5ZcelwGqtZsiagjGhUrYi9J+eO21nyr2GBnpEtamePuU7FjaDW+5jOPshD8fBoyX
	A/xrrJ38zGCNqesTvee45QRWwPoO0Mkxs2stMh/g+pRpQkh7REJTYg912S9Aoock
	sCRzmxd5JSiSkMje46kMES4fT8KWDDTddP8a8RoLj6D6fMACV5Sev+CHzjzXm37p
	WTW2OYuzyZHsB1sWnim02NIPy1/eAly71lSp8ImsakLbKjC8M2QcpWYjkXKRgQbh
	CYxXKtaBmel+VhJAGSzE59t3b3YRO5sPVow==
X-ME-Sender: <xms:FdMUavIBFL6HKlc4Mpuk5xZpFTPqFrBns2xBy4sn5SsvFoFh32FAQQ>
    <xme:FdMUaqAmiar3Eu4EFbyWDA_u8xhzYahXtpiFGm9PCfO6VLWkc6wXOGo1703EDFBGU
    gOjPt0iosVgSFP-sbRZqqiYAnDef2vKppCc_mQ9viifpSnjdnw_>
X-ME-Received: <xmr:FdMUagDFq9MqwfFOq_1KBdwl86ZCKnIWKghcArCItFwypafqX4GvnBmkGrBMvYCU3JzgCPfU0fmh9SsBOu2BMF4olugbEvl8lN2X>
X-ME-Proxy-Cause: dmFkZTE9lY9/bCc0VvqYDJozxyc7EPwAoNvm4k4+7Jk+9XOs9uDxAJuZU6tdrVU15H0XNd
    GvElR0Vl/TZbzjQP4pBbv9hZgzqs7zFs1zzXTRvNAts2IQcO6B4TNiL0atyj7ltR/YJKuH
    +d04KzJv7unYmrbPxL0KDKiU+NwUUeX2N9Uye98DkI566zfRM3UOsA9L8qfyliMmiZs3cK
    MXRmFIuV+G9PZzP6ziTTKfYWbXtvLJo9Cqb0c+eXmghqUsP68OoAZHwlQfM8quQtjOo7Uw
    rSBlWhGpuGb3wUXSVyHbHaiwk1Fxvdztzf1pPLdguavtTgwXs+Jd9B0+XC7dZW5t2TfbEe
    fJyg8EMtCiOx2Vj+LVkwmEXrHvCIAObAwA+0RbXoh1/76INGfe8IC0EHTi8keDkuslmbtA
    ZqcvNzUTlmhIKBQm21BPwzxAC2dFXktfEXYivNVTSnBSdPWtyukCiJUE+LEjQgHUdP8YLW
    p03NnbY27dBa5DnqQV9O/UQOYbnURQXI/IswwWQnVt/Ki1utfNrG5fs7rnhIMJ1RZskmDV
    uzhtgO3DWAFTHmVUyOu4CAADHasrIoxFcqwvBnN/aGqEKz9uyJtJLJN/eDFXgKwRhB9qFA
    b53xHRQqZjDgmkz5rnC5+21dUCb8K5GOQCF40OO5OaT6xJYnnpu2/62iRjKw
X-ME-Proxy: <xmx:FdMUakALwpQBxXAsTptNGCYrkVTvu2e45n7MdlhcWDjijz8pFGj3qg>
    <xmx:FdMUajoH0MD7Pg-1IsAtcj7q20NrnMoNkfnlGw3TeKrquhQDw3dWhg>
    <xmx:FdMUammJhfgJIMsV8lleSGDitCMCP-PNybz_imXWmvNsyS-5IEeeRg>
    <xmx:FdMUarwfVds3oVWtb1N6sZSFYQ-_3Yu7xjz2W8R3oX-qbBELTCDh4Q>
    <xmx:FdMUanT9Zn-23W48U_gXi6A_lpS4naxYxPQmOrZKgTim1TlIOD73kOmN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 18:54:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] receive-pack: fix updateInstead with core.worktree
In-Reply-To: <20260525162311.66240-2-hi@alyssa.is> (Alyssa Ross's message of
	"Mon, 25 May 2026 18:23:12 +0200")
References: <20260522154418.5883-1-hi@alyssa.is>
	<20260525162311.66240-2-hi@alyssa.is>
Date: Tue, 26 May 2026 07:54:11 +0900
Message-ID: <xmqqv7cbcd7w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alyssa Ross <hi@alyssa.is> writes:

> Previously, only one of push_to_checkout() or push_to_deploy() was
> called.  In a8cc594333 (hooks: fix an obscure TOCTOU "did we just run a
> hook?" race, 2022-03-07), this was changed to always call
> push_to_checkout(), and then to call push_to_deploy() if
> push_to_checkout() didn't run anything.  This change didn't take into
> account that push_to_checkout() had a side effect of modifying env, and
> that modified env broke updating the worktree in push_to_deploy() if
> core.worktree was configured.  To fix this, only mutate the environment
> used inside push_to_commit(), rather than the environment that might
> later be passed to push_to_deploy().
>
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
> v2: reword commit message in response to feedback

You also fixed an incorrectly indentated line in the new test, which
is very much appreciated.

Will queue.  Thanks.

>
>  builtin/receive-pack.c |  2 +-
>  t/t5516-fetch-push.sh  | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index c7b2818f20..7ee157532d 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1460,8 +1460,8 @@ static const char *push_to_checkout(unsigned char *hash,
>  
>  	opt.invoked_hook = invoked_hook;
>  
> -	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
>  	strvec_pushv(&opt.env, env->v);
> +	strvec_pushf(&opt.env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
>  	strvec_push(&opt.args, hash_to_hex(hash));
>  	if (run_hooks_opt(the_repository, push_to_checkout_hook, &opt))
>  		return "push-to-checkout hook declined";
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 117cfa051f..db6cc18673 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1791,6 +1791,17 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
>  	)
>  '
>  
> +test_expect_success 'denyCurrentBranch and core.worktree' '
> +	test_when_finished "rm -fr cloned cloned.git" &&
> +	git clone --separate-git-dir cloned.git . cloned &&
> +	git --git-dir cloned.git config receive.denyCurrentBranch updateInstead &&
> +	git --git-dir cloned.git config core.worktree "$PWD/cloned" &&
> +	test_commit raspberry &&
> +	git push cloned.git HEAD:main &&
> +	test_path_exists cloned/raspberry.t &&
> +	test_must_fail git push --delete cloned.git main
> +'
> +
>  test_expect_success 'denyCurrentBranch and worktrees' '
>  	test_when_finished "rm -fr cloned && git worktree remove --force new-wt" &&
>  	git worktree add new-wt &&
>
> base-commit: aec3f587505a472db67e9462d0702e7d463a449d
