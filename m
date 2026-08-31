Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA24A8A03
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196771; cv=none; b=uZPBtrNQuS5Hf2lFaT/CNIAvIRM7y+AnWtha1W6Dr18pFz5M3dSahwvw/1+ozg4UGdpVMB1mf9sNLKHqo98pbHsLoOCJ80npUwoXyTl1Q3RCUiYdf/2PQl475WdVE9EZPhQy3/aGZmQA4IgNDd91YxZP2aCE7aZrqByQO3UPdxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196771; c=relaxed/simple;
	bh=AMxkUqLBvzoeAR6oDvQBuVOPEvNN+/5qq7XCvhT6ZK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PoTv8qqydz1Tw0UIC4ZgrLq8JGPig8qy9CBatS8jF5+kugqXy+Hq54ZUcSrt+wgagn4fopDnAWMfuSbuXbDkYlDgCCO232drZsdvls7tP2vzvtx4gEtDiuGxsf4SUbFHesN7JTf0BnTS1D7m8Wl0Qtr1K2ZG+Vh+VHwdw0K2scc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vJhHdUNB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Em8ckbcO; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vJhHdUNB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Em8ckbcO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B2D1B1D000F6;
	Mon, 31 Aug 2026 13:19:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 31 Aug 2026 13:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788196768; x=1788283168; bh=/WTqp/AGbY
	Qx8wr4cLAVpOvqsOkA6jqbdIe3r3MM3Ts=; b=vJhHdUNBGHBf452KWVCaNvsnrc
	nIv46GrmhCu8xmlnoSLGWZm14cAfv9MbJI+M+mhYR2Dwl0SbXTae5a6PZeA7piup
	hhzoDkuNCggXsHSwnqa07PCZ0R2bZ4kP4s2OhdXizOUnHokSMEZiRG9Eo+Ou+tWn
	N+UJ7986BEYJeij5Ha+G5GXml0x3lMxet5c7J7epTdYAjEXtn4fbLbfIp2az5PFb
	a9ZTYYDtFEMZQOxns51E20448ptLWWHSiW77VX2WSpVUJk9wfjRZCJNNn8QoK50R
	mRXIyqidZP1Z6trNDxYM3wjlogi3N4vMlIPUWTgHyijj8pmeWj3vQl5HwFmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788196768; x=1788283168; bh=/WTqp/AGbYQx8wr4cLAVpOvqsOkA6jqbdIe
	3r3MM3Ts=; b=Em8ckbcOJY0mCVJhPi/x0McAwrK/Bry48BMqeTHdXLsbz4LNsrR
	+0io5ldRpBNdR5RNTw29ug9846KNamD06+8/vggiLgsNh/GSoyIfMJfJPm3SKQIe
	jHpfnuXcu90nDii+KpXgvjDgPeruePAajBpAMD70Qk7CLG607OmbRjSHHo8zB9tl
	PIiQFeSxKUUMWQKCdxpDiEyMdwNTT1AIyrjKSknHtAwSQw4uV6vfpVSl9pEJrx0+
	6f2xff1gMQFslHgCtlJtmalxoHxoOlgWdZko3HbDiAp87I+1N+0cpXvS9qPhH14d
	UzklmHQKyZiURwkmrd3Fb3dwZC7RWGs3Pew==
X-ME-Sender: <xms:oLeVarrdm4DsY6htPVoSbeyRy3VVaXLVuvyJDzxDVncnpxvT-4QMGg>
    <xme:oLeVashqN5oDjub_pfBk8ib7lIckko2Ca9Xd97_xaDgY5jCiYY1xpKV7ckGhsaIii
    ygxdLex7m4MfnIEY8gOJ4CkEm8fgH3R30wotlmgUpoM6YIkF81SVXU>
X-ME-Received: <xmr:oLeVagi6-vb6WgdqfQBb39Czngp7AWV_3Zs4krS6nZIeIVy46Z_wWwXFvjuxwiVhKZHLyCEJ4dj-9iYbmewgAOksEN49Ig1UaQ>
X-ME-Proxy-Cause: dmFkZTFeyKzdY2eZnMbqgFJ9Ut59tumWohbxxOgyyR899bjSp0k3NT8ICODZk8mxr3pO+c
    QPG54asOmjHbaYgGGDNQuAhF+hET6vMOrTp3IHot5B0b4bUree55I+aYZL/QPOcmcgJJNv
    UhDEJhZNS/fh6hEbLgNvyLzKyZU/3S0wAheYkzSq9xTaiTZCpmnTcEZg8OupdtTHTm/wJH
    VqfWfMJd6JNp982zg0CxhBDuYZrGyofrNDXtN4Et21vCt/2twyN0/fiIe+r17jgbG1BrdP
    YB2CksnE6x/lvBCzcz79khzPwjHmdO7XSQ+OlBQWiyYZS/k70JWZRVnnVSvMTryTOV/AFy
    WOaqA7jfZBXdnmi0IHwX2Mohz7f7aSwNWQgCFRFCoYwKPif/trOTQmfn2vfxa49T6o3BhI
    OUmC2GRGzoGnm0bSxkshhn5m9/u2haCRAVfIjqjhvx81DLyW7H5BDsaX4Z6i5MLxzLuDqn
    Wf4rJyElyHs4VUx6CfTzrS7akfylHSoXBMBRN5SV0KgxRG25j9+51Mr4TFq8GNeO9/u3Iv
    v6K3psKnXcD9ABO5Q0wva0RGLOaMCZgUFBTl9UMwInzC64BH89mCQwOfYzzPDvRclP40hl
    LSZ91a+6xLK1/oBdDJsyZCQ2U0QW0m2F7LXPJi+BVn/HDljY34rFs4kvoP/Q
X-ME-Proxy: <xmx:oLeVaqiP5WCwCU8zNSsvbZMUqjtAz3jKNhvXDSq5BuO6HoZokazoKg>
    <xmx:oLeVaoLXxNTtkeCVTeQs7uKsufQqaiEm469kmKuqwpk1btX3N5XPAw>
    <xmx:oLeVahHoQt1m_ftLHmsENRVxeJjVYBmE6zsZg5KebpZHcqSVfs5nkw>
    <xmx:oLeVakRd4VVHPHbMXVVNdbdrSLafdVdrx7PpX0QZdUlWaCxRz1LdBw>
    <xmx:oLeVatwTDXRYP2VyJiXLQUGnbC5y7kxOOog9gfpN_lh8-LGLVpB78-vi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 13:19:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] checkout: print blank line after autostash conflict
 advice
In-Reply-To: <pull.2364.v2.git.git.1788177601572.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Mon, 31 Aug 2026
	12:00:01 +0000")
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<pull.2364.v2.git.git.1788177601572.gitgitgadget@gmail.com>
Date: Mon, 31 Aug 2026 10:19:26 -0700
Message-ID: <xmqq4igaxl5t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> To learn whether the stash apply resulted in conflicts, make the
> autostash apply functions return 1 when the stash could not be applied
> due to conflicts (and was stored back), while success and error remain
> 0 and -1 respectively.  Checkout can then use the return value to decide
> whether to print the blank line.

> @@ -1237,12 +1238,12 @@ static int switch_branches(const struct checkout_opts *opts,
>  				git_config_push_parameter(cfg.buf);
>  				strbuf_release(&cfg);
>  			}
> -			apply_autostash_ref(the_repository,
> -					    "CHECKOUT_AUTOSTASH_HEAD",
> -					    new_branch_info->name,
> -					    "local",
> -					    stash_label_base,
> -					    autostash_msg.buf);
> +			autostash_res = apply_autostash_ref(the_repository,
> +				    "CHECKOUT_AUTOSTASH_HEAD",
> +				    new_branch_info->name,
> +				    "local",
> +				    stash_label_base,
> +				    autostash_msg.buf);
>  		}
>  		if (ret) {
>  			branch_info_release(&old_branch_info);
> @@ -1255,6 +1256,8 @@ static int switch_branches(const struct checkout_opts *opts,
>  	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
>  		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
>  
> +	if (autostash_res == 1 && !opts->quiet)
> +		fputc('\n', stderr);
>  	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
>  
>  	if (created_autostash) {
> diff --git a/sequencer.c b/sequencer.c
> index 65afd100d9..5ed9ae86c4 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4815,7 +4815,8 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
>  		if (label_base)
>  			strvec_pushf(&child.args, "--label-base=%s", label_base);
>  		strvec_push(&child.args, stash_oid);
> -		ret = run_command(&child);
> +		if (run_command(&child))
> +			ret = 1;
>  	}

This does not look like the right way to have the function return 1
if the objective is to do so only when the spawned "git stash apply
<oid>" process fails due to conflicts.

The reasons for a non-zero return value from run_command() range
from failing to find the command to run, to the command crashing, to
the command voluntarily exiting with a fixed exit status to signal
how exactly it exited to the spawning process.

Skimming bultin/stash.c::do_apply_stash(), I find this bit:

	clean = merge_ort_nonrecursive(&o, head, merge, merge_base);

	/*
	 * If 'clean' >= 0, reverse the value for 'ret' so 'ret' is 0 when the
	 * merge was clean, and nonzero if the merge was unclean or encountered
	 * an error.
	 */
	ret = clean >= 0 ? !clean : clean;

If 'clean' is 0 (i.e., unclean merge), we assign 1 (== !clean) to
ret.  If 'clean' is 1 or more (presumably a clean merge?  Check what
merge_ort_nonrecursive() does for details---I didn't), return 0.  If
merge-ort gave an error (i.e., negative), use it as-is.  And this
'ret' is eventually returned to the caller apply_stash() , which
returns that value as-is.

The value is given back to builtin/stash.c::cmd_stash() and the more
detailed exit value unfortunately discarded ehre:

	if (fn)
		return !!fn(argc, argv, prefix, repo);

but if one wants to implement 

    > To learn whether the stash apply resulted in conflicts, make the
    > autostash apply functions return 1 when the stash could not be applied
    > due to conflicts (and was stored back),...

correctly, I think this patch needs a bit more work.  

 (1) Find the values returned by foo_stash() implementations of all
     'git stash foo' subcommands.  Do they follow the 0 == success,
     negative == failure, positive == something else convention?

 (2) Update the code above to something like

	if (fn) {
		int ret = fn(argc, argv, prefix, repo);

		if (ret < 0)
			return 1; /* as before */
		if (!ret)
			return 0; /* as before */
		return ret + 1;
	}

      or with whatever necessary tweak to allow the positive "I have
      something to tell the spawning process" case from the bog
      standard and boring 'return error("message");' cases.

 (3) document what each of 'git stash foo' signals with its exit
     status.

For expediency, it may be OK to assume any and all failures from
"git stash apply <oid>" come from a conflicted stash application in
your first version.  If that is what your reviewer recommended, I
would agree.  But let's help users and future developers (who do not
necessarily have to be you) by leaving a note that this code is not
doing what it claims to do and needs more work in the code.

Thanks.
