Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E7D3644C3
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147172; cv=none; b=IHPvhlo6FAdhIha7ZdfGXhSm/+gVvXEyHWhLgxdTR7hmSzWS1OY1KlE4WQVaXT8I72aDrblPU8gsMbXbtEq09WpAzIMo0gEz7FH+mxNbucve7HHpU2ePw+STqJgvpXFu8+lturyZmh2XyqQRgak5POBnjgsVSgJqJ2doytocm4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147172; c=relaxed/simple;
	bh=rtg9yVAgyV5wmAxTg6QJ8ij35C5o98oIPdM+googy2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s66Pz24m7uN9fQkXnMzicxIuPqCmMgRp94mMHcEBiIRDs5Cfg9J4AgeAGID6zbbdlh6Sw6hUCT6sEZDp6WzDQFG9B3MRQT346mx9hEuW6oa7Aa6Tbo49EssrOrS9wR8ATKCw77hCVRvbaLKwFi7iPst57gCcAuR1X61ES1/hc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KzeAg+xP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Phpu4BTf; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KzeAg+xP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Phpu4BTf"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 67FE7EC019C;
	Fri, 11 Sep 2026 13:19:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 13:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789147169; x=1789233569; bh=uLc40r6aYY
	vn7hPL5hidMHeK1/cM0ycBn8VBUMMQ3t0=; b=KzeAg+xPHtZGmeIKUn39PAcqR0
	XWqc35Y6jd6mzLp+q+eb/oiuBa7Qp72Sm/LmMnZYeSvXHDxM4+dbcXRRlJlKXQR4
	9cXo2pTMGY8Ob+PTH3tvGnfnRN912OgvctX9KNyo0vxFxF8kgX5r2iIWhPvlnWuk
	XQsHgC+xr87uAROxz/NufmXJDWW/TmxEh0zM86ABtU7yrUi2YRodAg76nH2KNysa
	WFgb6LYW42MfR3cxo0Z8hHTk0TIMv+Bm5qT4DW02YprfxZI2VRiz6ZIyinPUnq0x
	Cv5wGUyEi64ND60b6hHXydoLETZCKKcZjNpmOphpWhPf+H8cduOkIEvh8Fjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789147169; x=1789233569; bh=uLc40r6aYYvn7hPL5hidMHeK1/cM0ycBn8V
	BUMMQ3t0=; b=Phpu4BTfjhEIdmYiqBmSEJmWH5j5PM2m32rbxpjYE9vApy0yTBy
	1a3Y87DXgvTC90awmVLIPbRD5DBGblikpYh2rIxflyfar9CBVQAOH+qBMU/8Si/t
	9LZnSn4miOvhnJOSlTTth/Zg7Ev9KNQX16k3BJJFNceQQPeKrjRC3BMDum/M0fXv
	36VKWdHIZYTr6OBAb5X0nSZBnlfv41tIjW2NEZjpvYK5l3h8RrOq3UK0teobxsia
	76JsyS/rI6Dj8SWHg4w636HKxs37CiOfuTTGbhVLHhNno/BBcaAxwhAQ7pVbgnWN
	r4HfsACOo5jKttC3zKHh1Jje3q5D7Y+Qv4Q==
X-ME-Sender: <xms:ITikanAOLXV7305dCqzWOJxniDsXheCzYUTQmWSYL_JvYYNABII__Q>
    <xme:ITikakiGljFmtz2FPRYMYmzoVcscy_UgXPX--E0-wQNwH0R4fXOg1LIjAhy-fugl0
    fUeAqL0gaEfqybDWHDUZWCekLWCloK55Ai5Q4kBmQJlxXMVVp3wNGo>
X-ME-Received: <xmr:ITikannqBQLciIw5cOPGji6v_Da13vedW-vUZmRTCmujYUwD3TevSQ_Xf7jSHV7AxnE5jc1HxOsAVe8d9zObEmvixqMI2wTUVTEu>
X-ME-Proxy-Cause: dmFkZTF6f9z1nLUg64aImp3Nrihp6klaB014BstA6WgVzVocRt/U+UYxcW8KbSuCX8s2Yq
    62B/pX0MfcXHgg49WzartFngG+BmoF30sAPJ6ClWygi0iVG6CyRxEOzRpCN70tMKfa2RTX
    E0588wxDXNT6w0jqa70kII0PUkpndJCt5la7TSy2j6/ouC/7j7redXzJ8EmIAia8l2ZOOC
    2kySHGTsCPMGdIlUpk4ebGGX+jtMjF5cJWDIzElWUhz4AO5YYmicx/JG8uN4S1S2YKjHHT
    6F0Cbh094CRQlVf1ZlS6ZxgSzwAc0jJ5Bububvy6xhgHZL3F8eLxG2QX4ouPfoPQDL2QGt
    ybOg/4fT5ELjvotD1oXV4PdpgxCbbIzOMkjcU26CNnEp3HAFy34hWgEldOgLvXmSGnHcqk
    Y96trFVJYlg8FilC44rszMR/7eSoVEu10xz8UM8cxuTzJ77kZIhuDe5qAUKq6vqMo2UDZj
    S1dDZcZ48ISoTihPUZ3WRZCV/AgLO5V/BpB3gO3Ekm8tZmZkc4iAF/K0vUFNjFEJGg4qJ6
    iSDN7ZrRK+mhJExgjIHxVSb7f/Qbaul2MSw+szHjdOov3Gp1pPep3RSLmqnWA+x3h1hDsf
    MSvqzcWa8PutmPqEhS3ErlH/JDfsqduIEQ/03qQ4LOChoIRrjsGQSzhw19LA
X-ME-Proxy: <xmx:ITikaoqZ2Rv8hIu4xHhvgYAYL6vPtzbR9j7XkRU7d8Dl6p2tANzhrA>
    <xmx:ITikaoGREUC1efye90BhJJVlZUhrBzipWZCvMPTdWX2uA1-5BUzLsw>
    <xmx:ITikaswnt1-Vcy7wF8oNAVlYTvm6BGPsMKN6CBMhf39Ql66LePbtHA>
    <xmx:ITikalpNuG5Wq9HVJu69sjJujEhSeAyEImzi1YSBw7Uh43lZHBTOqg>
    <xmx:ITikavGBMB_foR69WxQ85T1W-xz3mWwrdUU24DdkEfUsmSfSbFfnJhCw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 13:19:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] range-diff: add --matched-only to skip one-sided commits
In-Reply-To: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Fri, 11 Sep 2026 16:41:17
	+0000")
References: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com>
Date: Fri, 11 Sep 2026 10:19:27 -0700
Message-ID: <xmqqik4bbt9c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/git-range-diff.adoc b/Documentation/git-range-diff.adoc
> index 5cc5e2ed56..58e59e8e3b 100644
> --- a/Documentation/git-range-diff.adoc
> +++ b/Documentation/git-range-diff.adoc
> @@ -10,7 +10,8 @@ SYNOPSIS
>  [synopsis]
>  git range-diff [--color=[<when>]] [--no-color] [<diff-options>]
>  	[--no-dual-color] [--creation-factor=<factor>]
> -	[--left-only | --right-only] [--diff-merges=<format>]
> +	[--left-only | --right-only | --matched-only]
> +	[--diff-merges=<format>]
>  	[--remerge-diff] [--no-notes | --notes[=<ref>]]
>  	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
>  	[[--] <path>...]
> @@ -82,6 +83,13 @@ to revert to color all lines according to the outer diff markers
>  	Suppress commits that are missing from the second specified range
>  	(or the "right range" when using the `<rev1>...<rev2>` form).
>  
> +`--matched-only`::
> +	Only emit commits that have a corresponding commit in the other
> +	range, suppressing any commit that exists on only one side. This is
> +	the same as using `--left-only` and `--right-only` together. Useful
> +	to skip added or removed commits when reviewing how the commits
> +	that survived a rebase changed.

While conceptually it is the same as giving "--hide-right-only"
(which would have hidden the right-only entry) and
"--hide-left-only" at the same time, because the existing two
options are not defined in terms of "hiding" entries that have only
one side (which would have logically allowed combining) but instead
showing "only" one side (which makes it impossible to give them
together, and indeed that is the first thing
range-diff.c:show_range_diff() checks and yields an error), this
description is not accurate.

I wonder if the implementation actually can be more like

 - give "--hide-left-only" and "--hide-right-only" as synonyms to
   "--right-only" and "--left-only", and deprecate the original;

 - allow them to be given together, which will give the new
   behaviour you are introducing, i.e., skip steps without both
   sides from the output;

 - give a short-hand synonym, "--matched-only", to truly behave the
   same as giving "--hide-{left,right}-only" together.

which would allow the above explanation to be more accurate?  I
dunno.

> +	if (range_diff_opts->left_only + range_diff_opts->right_only +
> +	    range_diff_opts->matched_only > 1)
> +		res = error(_("options '%s', '%s', or '%s' cannot be used together"),
> +			    "--left-only", "--right-only", "--matched-only");

Don't we have die_for_incompatible_opt3() to do this?

The basic idea sounds good.  The unmatched entries do serve as a
strong hint that a greater --creation-factor may help.  For example,

> +		git range-diff -s --abbrev=7 combined-old...combined-new >actual &&
> +		cat >expect <<-EOF &&
> +		1:  $old_only_oid < -:  ------- c-old-only
> +		-:  ------- > 1:  $new_only_oid c-new-only
> +		2:  $common_old_oid = 2:  $common_new_oid c-common
> +		EOF
> +		test_cmp expect actual &&

the above clearly shows that the command might compare c-old-only
and c-new-only with a better creation factor settings.

But because the entries are numbered, gaps in the numbers, like this
output

> +		git range-diff -s --abbrev=7 --matched-only combined-old...combined-new \
> +			>actual &&
> +		echo "2:  $common_old_oid = 2:  $common_new_oid c-common" >expect &&
> +		test_cmp expect actual

may be sufficient (we can tell that 1 was omitted), except that
somehow we at least need to be aware that there were only 2 commits
on both sides (it may be hiding commits 3 thru 99 as unmatching
pairs and we lose that hint from the new output), which is not a
huge downside.

Thanks.
