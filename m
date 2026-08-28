Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942D34EF0D
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932158; cv=none; b=kN5Q9eORKvQH7IGzpidkJEe//zEvHVK1T5K1wj+1zrJCu7cZDfoaW5rYmRHiZQZSIA6/m3tRhVD23uNHCuzwaLQjFKD+2z5lYxvm330gQz5P7Olyo0F2vVUbCwHQ3ZanPd4homIpXWd3NU+HfgG03xXcu+c4rNoQngTn2XfKDdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932158; c=relaxed/simple;
	bh=dZVShnmiel+x6zxxSkbPbdxT0ObCS9Y8c2GO+BWqZg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A1vMTko5DB1GsHk/5Zlxyd7Qrj1LfsumSbXWdcjb2G4+VMl/5NKObQJ3101Er1FEbitiO5tmMiXvNphRh6UHUP3M6lGJfyDloXSj7zVesSxOiU/YlbkT30HwRviiEj4c8JD/1yHB6AeirF9MZTeUhOex8qfqWxEGZkTgNh5Pfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bwbYrzGx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NMhfFAHq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bwbYrzGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NMhfFAHq"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4FE971D0012D;
	Fri, 28 Aug 2026 11:49:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 28 Aug 2026 11:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787932155; x=1788018555; bh=n1+3EBqUnO
	0hmwAcKffXnuhE0ZANaauq1MD4hV3/5LA=; b=bwbYrzGxXQlJv1iG+WPUhzbOUb
	OSAVLVzivFjtIpAQNd+Oq4dN4rCp5ZNYN6Jzvdzn7Wj5WjtrFOO1JJdX412GFx3e
	2nTjtH4y5SWVMRCxGOQZGTrV2l4HW7+9YB3EI7yMSCHrWkx1cfICtbig4zXXu61l
	Ceo7LcU5zdSp1lDiF1zGzrNOaPGzGizpeTQ1jolcVMfdTy/USAO7GqwuEpHtED1U
	oabGgSNbjfB99wtS2ZbDut6fca37C0vcVaHQt1675ItcTvtu8HdTnKFD4MDL2rYg
	jnu9JCZcvmrad19sXDQ4y5ueFu8BWjnR5VjZyQ9q74HvHDO+1mDaNbFTiXQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787932155; x=1788018555; bh=n1+3EBqUnO0hmwAcKffXnuhE0ZANaauq1MD
	4hV3/5LA=; b=NMhfFAHqSwCVhLe+NNt5b7yIkDws45az9DLS408MDYJCpIMNfOY
	w1yrqELjseG93u4EF6jwSWcL9Twshpy8qR41NI5gXdAa8qfzIJsBSTRJUcnrPG2c
	efj8Prn3PSgyYpW8car+6t9ibGZ76jRtUv6jXEMWJrLdppHpW2OKjuo2Oio7ojgd
	DoqPb7aeg7PQGo0ImZt+FQuHZCOlPOcitx90ROx7/WbzJw84jq++xbkFYYi4pXpp
	63Hyrgt+lMcMCWTln2mwMX19JPLnoBo5xLNM4/ZVYrOzgmLrNezNmpjz5fF0boHZ
	MXw8obZAN9Fj8I8kaPtrh6wgDywAwU7EkQA==
X-ME-Sender: <xms:-62RauyYBQLDvCOyIaGAbGH-DFOmwKvabvwuKIhXR9ZV6A9Pw2j60w>
    <xme:-62RahILg6BZ1urfw9XZtm1oL54EMKMvenUGsLFiOjdjjqyFYWpRURXFQDhCSLz52
    VFZZH_aTadfjGas23cRQU8zMDi4K_58mRvGXQb72KLQ_A_RWn_P4A>
X-ME-Received: <xmr:-62Raop1aIcGArd3Np_htNwrCUt1NL9fyz03uapAlkKnhjvPJ1ZBGkuiU4GDtAPjaJlHtE4dHbn1IhFaVgQKy3AJY_nbj3B_bQ>
X-ME-Proxy-Cause: dmFkZTGDLNANsG8qft+sd/VvtBw5hj4CULZjift6/D/OK4+gri3aOn9tHCZejZpyKt/d8H
    9959lGpdqAnYaR/VaHgdPJ5JOTHik5H65GGpWNSUNk3Ce3DuzFgf6TM6v+0sPZicYGGmeU
    3qqcnz03T9T6vnEC7WXAcbCqL1UaiinFF/w5RAKOHOED391DVY+lErWu9jcoMbBvW9Krtb
    4QI8RUq3UlBEXc99RGAzlBiRuQ3yXrNTbbdnJvWlBx/+hFi2UsdiJoHdPSTGEXNtY+PE0E
    VZi9pZ92geZt9yQtkwMXnVRoPEVBjKzsYQFPGetSsa51J9yHtHhfeIeErC9tPv7sl7h4RG
    IMffiw4Ilh8FIyuFBbaVCQorf5/4z4EMOGgOCBwE/ThpuMa1a/gDnxmBPp2nI+oSvbVcIU
    b0/zeRRs2W93U3RGmnfAdEVTUhY9rgSVYaJjYE0xtHpr2T9pMYFlo/3eyW7Tpo3c/HQhIR
    hDSBzf5h0mFoQNXA23YNFfebfAYoZbZN9aZbIhuaVy91GoleIPYVzI95Gd2X3deyjQsvXS
    OElgigFoSd4CzBViI6mCvO+SHSa20h7sdPcHqZOLClpcffU9p7Ojr8y/8HDFueZ5Mil+0K
    yF4a+cXM6Xto7QQjHvW+ZH+aiNCZksPBsk87ZDMjmglS54Ezq4k6U16/yRsQ
X-ME-Proxy: <xmx:-62RagIy7Q1WemF1dIGiNMdGJAQttt-PVNqrtcRsLMv2NY6X9GZYMg>
    <xmx:-62RatTT2RPpbRyADP0WIHpR0MTPmDsZb1a7TvIWxS_0iwCCgHYtXQ>
    <xmx:-62RavsCfEuD_ui1CXIPF55QTVeXQYyDzKdOWzlg_b14UIJqQxZ1zA>
    <xmx:-62RauYOGE53wrb8xrauHUbX300M_WANYvZXDRagra_BuwDjCqsA6Q>
    <xmx:-62RarZqe0t7opP0ihvweLe_wWLJCqXe0HJW2-3mC3CYjTDhIbaoZT3y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 11:49:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH v3 3/5] commit: reword the empty-commit rebase amend error
In-Reply-To: <0850a999dab65345c9efe4b1d5bc6926b2641217.1787903085.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Fri, 28 Aug 2026
	07:44:43 +0000")
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
	<0850a999dab65345c9efe4b1d5bc6926b2641217.1787903085.git.gitgitgadget@gmail.com>
Date: Fri, 28 Aug 2026 08:49:13 -0700
Message-ID: <xmqqy0dq5jpi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> When a rebase applies a commit that becomes empty, it stops and asks the
> user to decide whether to keep it or drop it.  HEAD still points at the
> previously-applied commit at that point, so amending is refused, with:
>
>     You are in the middle of a rebase -- cannot amend.
>
> That message would suggest that amending is not allowed during an 'edit'
> or 'break' stop, which is misleading, plus it lacks the specificity that
> might help the user know why their particular case is a problem: the
> commit they intended to amend became empty and was dropped, so amending
> would affect the wrong commit.  Reword the error accordingly.


> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/commit.c              | 2 +-
>  t/t3404-rebase-interactive.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 610820c99f..774fb8299d 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1332,7 +1332,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		else if (is_from_cherry_pick(whence))
>  			die(_("You are in the middle of a cherry-pick -- cannot amend."));
>  		else if (is_from_rebase_empty(whence))
> -			die(_("You are in the middle of a rebase -- cannot amend."));
> +			die(_("The now-empty commit has been dropped -- cannot amend."));

OK.  Much less awkward than the previous round.

>  	}
>  	if (fixup_message && squash_message)
>  		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 3588e16543..81f4844950 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1880,7 +1880,7 @@ test_expect_success 'correct error message for commit --amend after empty pick'
>  	) &&
>  	echo x>file1 &&
>  	test_must_fail git commit -a --amend 2>err &&
> -	test_grep "middle of a rebase -- cannot amend." err
> +	test_grep "now-empty commit has been dropped -- cannot amend." err
>  '
>  
>  test_expect_success 'todo has correct onto hash' '
