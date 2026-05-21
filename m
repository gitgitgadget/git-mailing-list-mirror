Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9753382DE
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351569; cv=none; b=M46ddU7kuUI/xs+S786gyIBZA4vus4iAGMURcevpMijQEahVr2Tv0BK69NbDgE0Yq+cVssHlAjE5zMHngwJFSDtnfUrFpkThiYpZ+FDpyfgGaYtF52iFPnf1bMixuZgR4FUKzDRNGB88mvpxjY+CZJAqFINSiqP1e/Fhmx5GNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351569; c=relaxed/simple;
	bh=7DeFRdWPN5zHlzRcODxb5cq0QubV88cgNhwfSZCtGYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CAFF0e07/PZUimFzrN67Jtg5yegx0uAvRgCui1A1j4XnWlFf8w0H8QN9fE5nGsR/IjgochKMOwVpwFS9Ja9bFbbi/ORu1wuiJUteEidtF2fr7EE7+cNxijgRZpC//JWB+ebYvD4X0YlXfxZTNb7o85T9X8viamSobjSMNCpz2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y3AgmvuO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KZrJkQgh; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y3AgmvuO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KZrJkQgh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 420CDEC00F4;
	Thu, 21 May 2026 04:19:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 04:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779351566; x=1779437966; bh=8rTG7bjVQS
	wbmEDdun8HdGb6OXqhuF9JKu5wOu7l3L4=; b=Y3AgmvuOAOMjMQZ9xHTHJ1cmpZ
	JiPMJLXz0t9yAGkK4hqkNA7X+kjNS0YSRcLjlNrvPGSq5qTKlPGpujWIW/b/HM0k
	qbJ8lI8L6kdlzLXU3Wxv9lMJ9aUaNPs3oYmUofuIDhx0XN2W+gLhV1W/ExP2z0Vx
	RxFbJnvNKcSHmfYi4cgYN803usfd0z29Sdx093+iLFCcrjEuuLQc5nwv+WesHxHy
	1vqJb09A/aYuIQa0ZpUTlhZaeQlRiTdzw7oiGK7Rv5ewggWiovOdVVPvnygv13w4
	X7QvnXW1NKMX0GPZS3hQJ1OCa+45rAn6Ptm1JZc/Y7PiGTrTUqHzID4XTozg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779351566; x=1779437966; bh=8rTG7bjVQSwbmEDdun8HdGb6OXqhuF9JKu5
	wOu7l3L4=; b=KZrJkQghPNZTfS0jxTXyqiIufzp9leBRq+Fgx1dyO6Z8qMVcR0U
	Lh/Whe3/grOzlobILimMJMlSO1W3LLVWVeUaFMttTIu9MkUu6mDzJE8bpOzu0bZM
	URSX1vY3VtIOZFxUgdyTa6qgoltzTC56azAXOzsiDcGR/9jre9rn6MJJEC1zskiH
	LE2x6G4byfGJO4PeVCVIJfCQRvKeChqKJiF9Jg4wyZsZ3xyOKnE4+zNt8YrRlMWW
	hROOBBpKKmjrNa9m3s7m4nF73MeyK2BomZ+r/yuRCoFw3Id01Os3F5SCkOfyys5t
	DtJeTkhO2QCN5rg5u5RTSuDdQpevYFBg+eQ==
X-ME-Sender: <xms:DsAOag12RqE9_b-tiOxN3wXUFATDY6fBgOG9SEvSRdm_bT-CeQN-IA>
    <xme:DsAOaiGyOnYMfKLU0wq0rvUumQXipCP1XVGZdu8Lx4xD9adDvXvl4OOUndEgZzVFP
    I0h3lLMfQpfIkEutbYbzf-EIn1lgq7vWBDWth-ljEiqY6YwJH1uyGA>
X-ME-Received: <xmr:DsAOat6LXVWO5zLKyH4wzpbNh_iMmaszCfWtsvpfKTf0qBbQ-Ys-IzMVbWcl-RGUP-xzXCU6fPBWA7vqjeTgirKXw4CYsuKqCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DsAOaosPRrISO4ioVmYYbl8nCHkEwmhMXVsM389JIDO9HOqUxmLNMg>
    <xmx:DsAOau61MGU3hAirGCekF-ST7qL0Sttf7S5wSM6kRqiNnJW2ZYWbfQ>
    <xmx:DsAOajWYL0PPMDqsHZwuCeVnmotDPbFSLp5JcqrPezzCK6Wyn4zSBA>
    <xmx:DsAOag-AyizX0RqtFsD_IX2hHO0XKzMlemh8WlUZOENlXyP5Xd-uog>
    <xmx:DsAOapbzVAXotEbGhMazu7ejLBmnWmq4mFCvNbsmzuUFtid9klOuGy2o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 04:19:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3] remote: qualify "git pull" advice for non-upstream
 compareBranches
In-Reply-To: <pull.2301.v3.git.git.1779282625696.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 20 May 2026
	13:10:25 +0000")
References: <pull.2301.v2.git.git.1778665812261.gitgitgadget@gmail.com>
	<pull.2301.v3.git.git.1779282625696.gitgitgadget@gmail.com>
Date: Thu, 21 May 2026 17:19:24 +0900
Message-ID: <xmqqy0hd18fn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +		if (use_divergence_advice && advice_enabled(ADVICE_STATUS_HINTS)) {
> +			if (push_remote_name && push_branch_name)
> +				strbuf_addf(sb,
> +					_("  (use \"git pull %s %s\" if you want to integrate the remote branch with yours)\n"),
> +					push_remote_name, push_branch_name);
> +			else
> +				strbuf_addstr(sb,
> +					_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));

Here is where "git pull" is suggested as a fallback when the history
is diverged (e.g., you pushed and then you rebased).

> +		}
>  	}
>  }
>  
> @@ -2355,6 +2369,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>  		int ours, theirs, cmp;
>  		int is_upstream, is_push;
>  		unsigned flags = 0;
> +		const char *push_remote_name = NULL;
> +		const char *push_branch_name = NULL;
>  
>  		full_ref = resolve_compare_branch(branch,
>  						  branches.items[i].string);
> @@ -2396,13 +2412,25 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>  		if (reported)
>  			strbuf_addstr(sb, "\n");
>  
> -		if (is_upstream)
> +		if (is_upstream || is_push)
>  			flags |= ENABLE_ADVICE_PULL;
> -		if (is_push)
> -			flags |= ENABLE_ADVICE_PUSH;
>  		if (show_divergence_advice && is_upstream)
>  			flags |= ENABLE_ADVICE_DIVERGENCE;
> +		if (is_push) {
> +			flags |= ENABLE_ADVICE_PUSH;
> +			if (!upstream_ref || strcmp(upstream_ref, full_ref)) {
> +				push_remote_name = pushremote_for_branch(branch, NULL);

Here we _know_ that our repository has separate upstream and
push/publish repositories.  But we may not be able to "qualify" it
in the following "if" statement, in which case ...

> +				if (push_remote_name &&
> +				    skip_prefix(full_ref, "refs/remotes/", &push_branch_name) &&
> +				    skip_prefix(push_branch_name, push_remote_name, &push_branch_name) &&
> +				    *push_branch_name == '/')
> +					push_branch_name++;
> +				else
> +					push_remote_name = NULL;

... we assign NULL to push_remote_name to "punt".

> +			}
> +		}

Which means that this call to the helper function cannot distinguish
between the case where we were in "push" and pushing to the upstream
(i.e., "git pull" without extra arguments is perfectly a sensible
suggestion) and the case where we were in "push", diverged, and
triangular (i.e., "git pull" with or without extra arguments is not
an appropriate thing to suggest) but we cannot exactly tell what is
going on.

Shoudln't the "punt" case refrain from suggesting "git pull"?

>  		format_branch_comparison(sb, !cmp, ours, theirs, short_ref,
> +					 push_remote_name, push_branch_name,
>  					 abf, flags);
>  		reported = 1;
>  
> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index 0242b5bf7a..b613aba33a 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -646,4 +646,82 @@ test_expect_success 'status.compareBranches with remapped push and upstream remo
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'status.compareBranches behind both upstream and push' '
> +	test_config -C test push.default current &&
> +	test_config -C test remote.pushDefault origin &&
> +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
> +	git -C test checkout -b feature13 upstream/main &&
> +	(cd test && advance work13) &&
> +	git -C test push origin &&
> +	git -C test branch --set-upstream-to upstream/ahead &&
> +	git -C test reset --hard HEAD^ &&
> +	git -C test status >actual &&
> +	cat >expect <<-EOF &&
> +	On branch feature13
> +	Your branch is behind ${SQ}upstream/ahead${SQ} by 1 commit, and can be fast-forwarded.
> +	  (use "git pull" to update your local branch)
> +
> +	Your branch is behind ${SQ}origin/feature13${SQ} by 1 commit, and can be fast-forwarded.
> +	  (use "git pull origin feature13" to update your local branch)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status.compareBranches with remapped push and behind push branch' '
> +	test_config -C test remote.pushDefault origin &&
> +	test_config -C test remote.origin.push refs/heads/feature14:refs/heads/remapped14 &&
> +	test_config -C test status.compareBranches "@{push}" &&
> +	git -C test checkout -b feature14 upstream/main &&
> +	(cd test && advance work14) &&
> +	git -C test push &&
> +	git -C test reset --hard HEAD^ &&
> +	git -C test status >actual &&
> +	cat >expect <<-EOF &&
> +	On branch feature14
> +	Your branch is behind ${SQ}origin/remapped14${SQ} by 1 commit, and can be fast-forwarded.
> +	  (use "git pull origin remapped14" to update your local branch)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status.compareBranches with behind push branch and no upstream' '
> +	test_config -C test push.default current &&
> +	test_config -C test remote.pushDefault origin &&
> +	test_config -C test status.compareBranches "@{push}" &&
> +	git -C test checkout --no-track -b feature15 upstream/main &&
> +	(cd test && advance work15) &&
> +	git -C test push origin &&
> +	git -C test reset --hard HEAD^ &&
> +	git -C test status >actual &&
> +	cat >expect <<-EOF &&
> +	On branch feature15
> +	Your branch is behind ${SQ}origin/feature15${SQ} by 1 commit, and can be fast-forwarded.
> +	  (use "git pull origin feature15" to update your local branch)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status.compareBranches behind upstream-equals-push suggests plain pull' '
> +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
> +	git -C test checkout -b feature16 origin/main &&
> +	(cd test && advance work16) &&
> +	git -C test push origin HEAD:main &&
> +	git -C test reset --hard HEAD^ &&
> +	git -C test status >actual &&
> +	cat >expect <<-EOF &&
> +	On branch feature16
> +	Your branch is behind ${SQ}origin/main${SQ} by 1 commit, and can be fast-forwarded.
> +	  (use "git pull" to update your local branch)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_done
>
> base-commit: 7bcaabddcf68bd0702697da5904c3b68c52f94cf
