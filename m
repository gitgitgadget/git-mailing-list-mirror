Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997E2370D47
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745072; cv=none; b=IX4MhWCTS2PQ9jqeuO1p5KP/sPOvo6kbmzf1zIK0BIgSDgkhEpTBZLlujdhJx3P5LC6yc6y//0EGuXKzH/OLgxC81uuSMQ/k8jqkCkyG/lumghHaVll4kJrWIMT9typgjr5y7pFBv6Qy047tEdcQ8ADJsrN/S/6KS97ys2Qbke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745072; c=relaxed/simple;
	bh=V6Juhd9UMDOKsxpXho1p15IqqdpqvI/NMufxW2YIWaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M4mgLkt20eo9ym8fA7cM/sMm61njS85bFSrbZ63dnsGlYMjOlk9mvkBWC+ea68uyYAEIo/JevO+lz/aFiO5BPU9G5SrovUc4olrbmu+HdW5tkED1O1cEPAJ/n2sYx29K5+Pv0/dMCG+GI62zG/mCceCt58mQpO8Xf9oVKzMk0ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aHFD53F4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GnfBcIcL; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aHFD53F4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GnfBcIcL"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D678EC0199;
	Fri, 14 Aug 2026 18:04:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 14 Aug 2026 18:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786745069; x=1786831469; bh=oXt4h8PBs6
	MnE6pYX3XD6wDBg0sGgaGYQK/AeC9j2/I=; b=aHFD53F4soF+sCcM+7GGhXmwch
	nryaxTYA4rVGSzFLPoM2K9GtAfzdKSFNwj/6/RFGTP2WZNK4T+sus6raW59XvjQK
	hWRANTr4GIxukFIjbANtxVtZZ5Psm1CM9dUgBDQ2vrkxJDp0tsIXHlvVl2cpGkp/
	CUU5utnt/L6WmCW0wF9WdsMBMI5Ujqso9P2jy1SVPaxwGgidbwjw6/jnK2YLV0Hz
	9nF3opeSZ9JUJVv5wvO3tBQx34Fp6dlbXcrrFp3OKSUUVD+4kJc3bU2HMU827pWN
	BQrWoD2yhFNW3FuxlXGb+FtTFDIsKiD1HNs4DJevS4lsEjg39KFr5CbXSB/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786745069; x=1786831469; bh=oXt4h8PBs6MnE6pYX3XD6wDBg0sGgaGYQK/
	AeC9j2/I=; b=GnfBcIcLH145AGWW+tf1PefnHair9NYre1WYrOE6yd7gsqbmL4O
	fexT3vt9dyaAu2q26d7q3jPPsO+xGf1mfCoAN1gy9tkFxRpioIeYzWBLZSylF+k1
	EM13WqiI2+5UcUUdD29jFMtymu3UCA5FYi/JKd3mn7kHWk0+/HdUzGccsj+qzSxc
	uHcWlXvmfB1XVdB/ZNAssvWv2RmH+HZ1i8LOScG9h0RmA41cN+JSRZIfNTF7Vyxf
	0afEv7YEKCsrWYCJu5YqI0krIHd75FpZ/b+a9Je4WqrpCVVrx/c2/ypY9yVhaq/d
	fRbrRc8/uAu8subyVjjcmjCOOzAYhQKpM1A==
X-ME-Sender: <xms:7ZB_aq92EIZguXntQ8s-6duaTbXkVjQk1a4PHF6aGvqmAD_DA_F9kg>
    <xme:7ZB_ahmpJCaWKcHZRCqdJ1ZQpMbxLKsY9Qg28F2nedyc-9YY-K8YcwzuQFUr1QcZR
    uqluEq8n_H42-12_fXSN67lzifPynKZ-u0NWH5PSwElusZ35QDg>
X-ME-Received: <xmr:7ZB_aoUIp2HLguieRhmGF0jCFCrMH0k8H62ntTWefO-MLVShvAPRmW0qfwsixOrn7j6JOi6UKcW-Wg1sL00JvMEHVKN36eyY5A>
X-ME-Proxy-Cause: dmFkZTG0eTso04/hASuub3y+aX4Y4/ZLCko6M8+wfjTR0GVxq5ZGep5yIVysmx1waU95hg
    RvkKKpgcEYPhbNxLjK61j4HijdFJ6ko3qVDYtCzQQiemWt8wyxmqQue/2s5WpO/jKUaRY2
    LfQzOIlUBFz1ApE/NiHyMYdYUInPMbgWXi8C+8EhGMrP1+eGAQuh1BxQKD6pJqVIbIOXU/
    LFR9rbyY1Tw89NfI3Ey5cMTFk7PP+Apnbfx2Ft+OOSokBZ+B8ip1vzjykwKPwnGz4lyrDn
    btKoFi/a18fPyrL0z39iOf3xVBpujlUTv9+4405JPFgTBf8sSCBn/bNz0aQMaWYRuIrvOn
    QtLUBf5XAK611Ad5KY/b27UW7YiC7uw/3J8BqkIZRhBnxBD1AMao5PhKt8Gu3ddHqncIc0
    NhXU5RB9ZSrWwJ8j045eX7oZZ4RrxTBZwY+DZBCKdLh3/JNYE8h44g+n8w11EPA1xBvi6o
    19jNKDOPi9/UHpBnmGa7uWsLgnhpMAdectS1FPTrA7cdcYXOlR3NDKy66RtfO+ryE4lLxA
    PXkZI9hMV9KKE94M0khDFKQjduEthGODpaWYCDYIZWat6A5KDsgZc4zlz8xpMP9La3aO17
    lxrs4znjQTT+LBCJQjimouT+mmrp8MwcTsJ8Z5W/XQ2PO51SGYI8/DUld2Lg
X-ME-Proxy: <xmx:7ZB_auFIA1whupVlakIE9CMBXS3UCQjLd6uEX8cOv_TtOoMzFk4wSA>
    <xmx:7ZB_asfqYaNS3qVRnE8XHf-jZqly1brroUw3-GZ7ahnmyOxfrWhcHw>
    <xmx:7ZB_anIaEI_9Q796AWAW00s8kFL8gml5jzMON_R0Lj_84-WsXFjUMg>
    <xmx:7ZB_apH27vRAwCW3X22PLUbT5o-V48gaGAbf-6p41l3IAHu_QkqzgQ>
    <xmx:7ZB_aki-rpe2U5VEK5eyYCG0pZ8rUD0kcara0ggjC0WrnPCNE1X-xZpL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 18:04:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: tilak-raaz <raaztilak07@gmail.com>
Cc: git@vger.kernel.org,  wy@wyuan.org,  ben.knoble@gmail.com
Subject: Re: [GSoC PATCH v2] submodule: warn on valueless active config
In-Reply-To: <20260814212431.43626-1-raaztilak07@gmail.com> (tilak-raaz's
	message of "Sat, 15 Aug 2026 02:54:30 +0530")
References: <CABB4Jh3UUXvmAJpefaiP-xVRQfGRdTF2jW8GkdhbA1BXe6Okdw@mail.gmail.com>
	<20260814212431.43626-1-raaztilak07@gmail.com>
Date: Fri, 14 Aug 2026 15:04:28 -0700
Message-ID: <xmqqqzk0l5oz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

tilak-raaz <raaztilak07@gmail.com> writes:

> The config parser previously threw a hard error if 'submodule.active'
> was provided without a value, causing commands to abort.

An exerpt from Documentation/SubmittingPatches:

    [[present-tense]]
    The problem statement that describes the status quo is written in the
    present tense.  Write "The code does X when it is given input Y",
    instead of "The code used to do Y when given input X".  You do not
    have to say "Currently"---the status quo in the problem statement is
    about the code _without_ your change, by project convention.

> Swap repo_config_get_string_multi() to repo_config_get_value_multi()
> to parse valueless keys safely. Use the standard config_error_nonbool()

"valueless true", I think.

> helper to emit a warning to the user rather than crashing.

Good.

> This resolves a NEEDSWORK comment in submodule.c.

Good.  Resolving an existing NEEDSWORK is a two step process, (1) to
determine if it still does make sense to do what it suggests to do,
and then (2) do it.  The early part of the proposed log message
solves a half of step (1), in a sense that crashing is bad.  The
other half is what we should do instead of crashing.

> -/*
> - * NEEDSWORK: Emit a warning if submodule.active exists, but is valueless,
> - * ie, the config looks like: "[submodule] active\n".
> - * Since that is an invalid pathspec, we should inform the user.
> - */
> +
>  int is_tree_submodule_active(struct repository *repo,
>  			     const struct object_id *treeish_name,
>  			     const char *path)
> @@ -261,12 +257,16 @@ int is_tree_submodule_active(struct repository *repo,
>  	free(key);
>  
>  	/* submodule.active is set */
> -	if (!repo_config_get_string_multi(repo, "submodule.active", &sl)) {
> +	if (!repo_config_get_value_multi(repo, "submodule.active", &sl)) {
>  		struct pathspec ps;
>  		struct strvec args = STRVEC_INIT;
>  		const struct string_list_item *item;
>  
>  		for_each_string_list_item(item, sl) {
> +			 if (!item->string) {
> +				config_error_nonbool("submodule.active");
> +				continue;
> +			}
>  			strvec_push(&args, item->string);
>  		}

And we do warn, but I am not sure if "continue" is sensible, though.

Since we know that the configuration is broken, we should cause the
command to fail (i.e., exit with a non-zero status), shouldn't we?


>  
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index eefdecb0bd..74c26f6630 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1549,4 +1549,15 @@ test_expect_success 'submodule add fails when name is reused' '
>  	)
>  '
>  
> +
> +test_expect_success 'warn on valueless submodule.active' '
> +test_when_finished "rm -rf empty-active" &&
> +git init empty-active &&
> +test_commit -C empty-active initial &&
> +git -c protocol.file.allow=always -C empty-active submodule add ../empty-active sub &&
> +git -C empty-active config --unset submodule.sub.active &&
> +printf "[submodule]\n\tactive\n" >>empty-active/.git/config &&
> +git -C empty-active submodule status 2>err &&

In other words, shouldn't this say

	test_must_fail git submodule status &&

> +grep "missing value for .submodule.active." err
> +'

Curiously, the test part of your patch is severely
whitespace-damaged, even though the C part looked OK.  This is quite
puzzling.

