Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CDB9443
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 04:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767501628; cv=none; b=H0C62fMFFrIGBU1tDuKXO2ntq2KRPPHg0RG6B/iFGjlCtKWjv+TZ0qIoF889CVmF8XR5IAGqDdJaERaP/m5RooG800Fqw/mP3bGd7ecAN20PWQpah/ewL5524tmtu6Zfn26H0T6+/I01ZdvCmKDXC1YyvBZiMR9g9/1Q/o2kY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767501628; c=relaxed/simple;
	bh=JUB0+biQhdrdPMGr4a8QVDC/D/jiYUAoE53TnBLpKFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BownpswCOdTNvnLwjsSsIch8u1aijR6+UURqU+3SAsuKALQFHGehrCp6n6i9raZGWXcvAhzBbzULmX5yw5WodsVWi9+k5+YbcvKfzjvRWpc9j59dZD2zf7DMRs1U4fVF8194imK2Z1wqpOQryRsegpQoNoVF9XT4zsdGZbGrWGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bElDE1q5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZneyaD8Q; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bElDE1q5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZneyaD8Q"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39D047A00BA;
	Sat,  3 Jan 2026 23:40:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sat, 03 Jan 2026 23:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767501625; x=1767588025; bh=l/4s6S5NPS
	WuFjH5t3D2HQ4nLerETBhiCovGd1JMozc=; b=bElDE1q5ztKIeog2JdDSXxAU5p
	2K+RkC22A+vUNUdL2UCs4UiFhN+pirTRtgKjuDulbdakmaB8U0HZr/CY+OdqXnY6
	CGgufz4+G6e2e1BHBAXtVNMXFxKn43WQ+feKpJLF4iPPviU+ebYO9ffMSJCQg+GO
	GxH5yT7CNpEQjLj36yPWPXx/Mvprf2ZU/WhobHgz6e/ZGroRvyh69fuiNy5y/KT2
	dhog4+MKrJ1PLSgj+0kcBvzvmm/7kMU9SKCZ2cCXdt0b9xg4COpVdBbiJeqDjDpj
	nMOwjTM1Nd576gQSHtr01BYABE9fOZqHKQKei7tjqjW3ZuxI2oZ6BT1kgcRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767501625; x=1767588025; bh=l/4s6S5NPSWuFjH5t3D2HQ4nLerETBhiCov
	Gd1JMozc=; b=ZneyaD8QX3L+Fbv8CtLwM0d1xydqfrm2o3UOBb6g2Jm8xdVtTBs
	g3Bdcvi0ty7o6Kd2Z0SrKsw/AOCIxVKN6pdi2pBwVlnawI4zUr48eCEIhPuZlBZc
	01u3ZTNeHz7PtfbIVe8UFHLkoh0NIOyIlYTF9bRvyyjOD3MdpKe2Sy7ANNiW+F2j
	R24azgIyPVFLkWHkaCe3sUn7uYOV6UBRtS4lbZf4hNqzIiUU5VrwyWm3S72m8rNs
	d7+qwy5r6V35/+kCuQuRbE1MMuLyc0FaeMpafUd+bM+pAuWo1q+4/W0NpEqPgL9/
	ZdW4vqrqzHXKRcb8fl+/YPbNjAIpXmL9oUw==
X-ME-Sender: <xms:OO9ZaTIr45p8TmDNqEqDgqmz5yLzJp8IFYk1dkEakm2q1xvf-jULaA>
    <xme:OO9ZaeIQz5wE7Kj-QBO8puyku0j-bDA4D0a_MIKWNRLehqd-GTVa_DxSelEoDhHhr
    iYg1qWlRPOJmRX469-NNvjuz8ZYBwGX9K2aKLojlrshG8QeF3PZbg>
X-ME-Received: <xmr:OO9ZaQtKl8dpHnzc4MxomuibZKj7aX0kBnMOMgKAoJI4kCCuT60qBgv1JjpOikKPkJr1SZ4eqT_fV17AE7d_kfqoDSYadHdQjZjUAd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OO9ZabR2NI0sivEkdLiSeQcPqCPlxBYOzcCwRz11PqCMh_Y__yuwBg>
    <xmx:OO9ZaWN4LXUUjqGmXM6SQqZqqwHheOosjIbewrrTAYFjg2xoTPfktg>
    <xmx:OO9ZaQaCX-JcgVfkcyu3ZmQoFQH0bccS3iDwSe8SdPAeX8Yyx0vxoQ>
    <xmx:OO9ZaQzU7sqOyuwZoj8Ils_YgRkb_UFRwhqWNZzkFE9q_AhidtyGZA>
    <xmx:Oe9ZaQNMjAWgw9RISLvC73LyiN9PZbB9aBG1cC0P97WExlSBjx-BJlQD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jan 2026 23:40:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v14 1/2] refactor: format_branch_comparison in preparation
In-Reply-To: <a2c160c53ee0159a88234c64409f2a216d584cc4.1767445236.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sat, 03 Jan 2026
	13:00:35 +0000")
References: <pull.2138.v13.git.git.1767409701.gitgitgadget@gmail.com>
	<pull.2138.v14.git.git.1767445236.gitgitgadget@gmail.com>
	<a2c160c53ee0159a88234c64409f2a216d584cc4.1767445236.git.gitgitgadget@gmail.com>
Date: Sun, 04 Jan 2026 13:40:23 +0900
Message-ID: <xmqq8qeeng7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Refactor format_branch_comparison function in preparation for showing
> comparison with push remote tracking branch.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  remote.c | 99 +++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 59 insertions(+), 40 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 59b3715120..58093f64b0 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2237,66 +2237,50 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
>  	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
>  }
>  
> -/*
> - * Return true when there is anything to report, otherwise false.
> - */
> -int format_tracking_info(struct branch *branch, struct strbuf *sb,
> -			 enum ahead_behind_flags abf,
> -			 int show_divergence_advice)
> +static void format_branch_comparison(struct strbuf *sb,
> +				     int ahead, int behind,
> +				     const char *branch_name,
> +				     int upstream_is_gone,
> +				     enum ahead_behind_flags abf,
> +				     int sti)
>  {
> -	int ours, theirs, sti;
> -	const char *full_base;
> -	char *base;
> -	int upstream_is_gone = 0;
> -
> -	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
> -	if (sti < 0) {
> -		if (!full_base)
> -			return 0;
> -		upstream_is_gone = 1;
> -	}
> -
> -	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
> -					    full_base, 0);
>  	if (upstream_is_gone) {
>  		strbuf_addf(sb,
>  			_("Your branch is based on '%s', but the upstream is gone.\n"),
> -			base);
> +			branch_name);
>  		if (advice_enabled(ADVICE_STATUS_HINTS))
>  			strbuf_addstr(sb,
>  				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
>  	} else if (!sti) {
>  		strbuf_addf(sb,
>  			_("Your branch is up to date with '%s'.\n"),
> -			base);
> +			branch_name);

So, we used to say this when stat-tracking-info gave 0, i.e., ours
and theirs have not diverged.  But now you decided to make the
caller responsible for making the call to stat_tracking_info(), it
seems to me that this if/else-if arm is somewhat redundant given
that the caller can and will signal the same thing with both ahead
and behind being zero.

IOW, it smells to me that leaving "sti" as a parameter to this
function is an incomplete refactoring---I say "smell" because I
haven't seen the other, new, caller that will be added in the future
step of this patch series.

And if the new calling convention is to let the caller be
responsible for calling stat_tracking_info() and figuring out the
base branch name, it probably is also better to have the caller
handle upstream_is_gone case.  This is especially true if your plan
is to reuse this "branch comparison" helper to compare a branch with
another branch that is *NOT* its upstream (e.g., where the result is
pushed to).

>  	} else if (abf == AHEAD_BEHIND_QUICK) {
>  		strbuf_addf(sb,
>  			    _("Your branch and '%s' refer to different commits.\n"),
> -			    base);
> +			    branch_name);
>  		if (advice_enabled(ADVICE_STATUS_HINTS))
>  			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
>  				    "git status --ahead-behind");
> -	} else if (!theirs) {

As the code already handled !sti, which is equivalent to (!theirs &&
!ours), in the original, !theirs here meant (!theirs && ours), which
is (ahead && !behind) in the new world order, which we see a few lines
below.

> +	} else if (ahead == 0 && behind == 0) {

And this is what the above (!sti) should have checked for, after the
helper function lost the sti parameter.

Do not compare with 0 for equality.  Instead write it like so:

	} else if (!ahead && !behind) {

I won't repeat for other style violations of the same kind.

> +		strbuf_addf(sb,
> +			_("Your branch is up to date with '%s'.\n"),
> +			branch_name);

> +	} else if (ahead > 0 && behind == 0) {
>  		strbuf_addf(sb,
>  			Q_("Your branch is ahead of '%s' by %d commit.\n",
>  			   "Your branch is ahead of '%s' by %d commits.\n",
> -			   ours),
> -			base, ours);
> -		if (advice_enabled(ADVICE_STATUS_HINTS))
> -			strbuf_addstr(sb,
> -				_("  (use \"git push\" to publish your local commits)\n"));
> -	} else if (!ours) {
> +			   ahead),
> +			branch_name, ahead);
> +	} else if (behind > 0 && ahead == 0) {
>  		strbuf_addf(sb,
>  			Q_("Your branch is behind '%s' by %d commit, "
>  			       "and can be fast-forwarded.\n",
>  			   "Your branch is behind '%s' by %d commits, "
>  			       "and can be fast-forwarded.\n",
> -			   theirs),
> -			base, theirs);
> -		if (advice_enabled(ADVICE_STATUS_HINTS))
> -			strbuf_addstr(sb,
> -				_("  (use \"git pull\" to update your local branch)\n"));
> -	} else {
> +			   behind),
> +			branch_name, behind);
> +	} else if (ahead > 0 && behind > 0) {
>  		strbuf_addf(sb,
>  			Q_("Your branch and '%s' have diverged,\n"
>  			       "and have %d and %d different commit each, "
> @@ -2304,13 +2288,48 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>  			   "Your branch and '%s' have diverged,\n"
>  			       "and have %d and %d different commits each, "
>  			       "respectively.\n",
> -			   ours + theirs),
> -			base, ours, theirs);
> -		if (show_divergence_advice &&
> -		    advice_enabled(ADVICE_STATUS_HINTS))
> +			   ahead + behind),
> +			branch_name, ahead, behind);
> +	}
> +}
> +
> +/*
> + * Return true when there is anything to report, otherwise false.
> + */
> +int format_tracking_info(struct branch *branch, struct strbuf *sb,
> +			 enum ahead_behind_flags abf,
> +			 int show_divergence_advice)
> +{
> +	int ours, theirs, sti;
> +	const char *full_base;
> +	char *base;
> +	int upstream_is_gone = 0;
> +
> +	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
> +	if (sti < 0) {
> +		if (!full_base)
> +			return 0;
> +		upstream_is_gone = 1;
> +	}
> +
> +	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
> +					    full_base, 0);
> +
> +	format_branch_comparison(sb, ours, theirs, base, upstream_is_gone, abf, sti);
> +	if (sti > 0 && abf != AHEAD_BEHIND_QUICK) {
> +		if (!theirs && advice_enabled(ADVICE_STATUS_HINTS)) {
> +			strbuf_addstr(sb,
> +				_("  (use \"git push\" to publish your local commits)\n"));
> +		} else if (!ours && advice_enabled(ADVICE_STATUS_HINTS)) {
> +			strbuf_addstr(sb,
> +				_("  (use \"git pull\" to update your local branch)\n"));
> +		} else if (ours && theirs && show_divergence_advice &&
> +			   advice_enabled(ADVICE_STATUS_HINTS)) {
>  			strbuf_addstr(sb,
>  				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
> +		}
>  	}
> +
>  	free(base);
>  	return 1;
>  }

Overall I think this is a reasonable direction to go, even though
passing the "sti" thing is iffy, and the implementation in the
function may have small rooms for improvements.

I didn't look at minute details to ensure that the output for all
cases are identical to that of the original, though.

