Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAEF2566D3
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 21:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754687363; cv=none; b=Bm/q4x2Wbo8jANvC9CNV2m7CyAT4X8Coy94T2aYmYpgqyyIMf+czcb5hdbuA34uEcZAeChcSWmHUv068NkkdTxoy00ehmkDkcMYDk/XE9iPuS6X+UwqX9V+Kpqr5UXuSOoGkeh88QCqpOdhfxR/28wuNhZwk7kRJpETq/nQvW5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754687363; c=relaxed/simple;
	bh=FWxWhiIobXmeNCOcJPR8pOHsZjpReTFGSfJWFJJwS3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n3qKOPH/NxyDEzICXnEe4ObM8CM+7eq4erdRLIAMnsB5rkmnSfemjW51qQyLnwTLrRR83HBHQJ9EZevf3aYyR1EsUJeXyobJycgAJA+5OM7HN+a+aWKAcGwWgmUQ/gKx5M6gwNhN39hlJuKiqup4DHVcgNCOZsvY1VYALo0w66A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l/BbCDNZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DoQJpVnn; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l/BbCDNZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DoQJpVnn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E1191D000BD;
	Fri,  8 Aug 2025 17:09:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 08 Aug 2025 17:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754687359; x=1754773759; bh=0DTNK0Cc/s
	c/Zy8SeParHzNyHRAZtU4FDgAd6Tum3tA=; b=l/BbCDNZa5nHTFionpKFQY7J5b
	cHH5tRpgZf3D9JcW0bLlOpMM+6085Cbv0RZDadNAG4R1AaETyKxK6/mraBYyGSkT
	h8MF80y/6qL8Zrr2Fq/9+XEv78BW5lkN9wmO5c6+crq9Nnpr9vG4QpsLH4GY0fUR
	f5rXtX0EPgy6t/c4msE6u3gF//3cGO4YiXz/cXbbPdNycHDZ2ZIlDdgKLyq1b7k9
	Fq0XI3yO6uDDFHG4tQW7g5y4C8vM606Gso/AqOQUehB6Ct9XviLVfMoUOEx/MFVg
	A/tMMlKwpywfhNqLz2Diy9Da4UJJnwIXSz4bJGlVlX+BXwi0OJndZnzPmMHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754687359; x=1754773759; bh=0DTNK0Cc/sc/Zy8SeParHzNyHRAZtU4FDgA
	d6Tum3tA=; b=DoQJpVnn+lLi36X0B/2Wlm32sn5fEpImfb+dmG/zUU+BfUonmVC
	6lRXzL8TBqj8ftoMpQkRVf6gmPynGn1w8Or8FoOerj/HnwqWeJCgP2eg6Vx9GykN
	2fM22M3l9IpNGS4aLbBo42Qg2kzTD3e3Ewxca0KngSOYJVBysW9nCin8RuKKlQLf
	WPd31cMyqH2EWsKIS+eAB4PQFXGISoXvvIjVf5FidKRXY+FY6yTYmNi9VBp0KpEr
	4snYrkS0MrLxZ/ybW4wFNAaxU3EIisCrJX72MSMsyvTlZFXNemeDrhjMpqXW9ahU
	WwolHyxIkI4f3eEXgu1NdXWifr93LThyBCA==
X-ME-Sender: <xms:f2eWaHAP1OCNYLEAtZzpEfDoIo02Egxtg1A7sbw_ghwABnaHOXXiXA>
    <xme:f2eWaIFAUwlXZu6xN9fd5_RqFZbAfuMtTZzEgjQja7sqv9Ie_bBPj3EL-9hkYZcDG
    ijLtX1ktNY04kOpMg>
X-ME-Received: <xmr:f2eWaPJqcvJtW8YZWiGc9uMMg6cnhuP4VZfjJQb1PPrWoPb5APqPRXYtjIQuN_06U5sZ6zx06KwMlqfkrPv6d4gmAP7ptfCsIcJgYMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:f2eWaMkqJidGb6D4NYbgZGYAqANILUpN8MK-O2BcaYcwrMmSM04RWw>
    <xmx:f2eWaHQbkwPRuuhwcV_PQ9tJkzwMHTTgTK8mKnRMEVHt3TT064A-pg>
    <xmx:f2eWaOL7Jx_HRXB7nRtrQD0gY1AJ0T_HF4eL4MnvfY_7j7C_Z9UG-g>
    <xmx:f2eWaNAx2Hudo6LyrEOg-OF3Q-cy-Jxq_pW2348k49pE3Y9l2zahkg>
    <xmx:f2eWaDz7px3VGslzIgy7nxh5_d6ecaZie5LrrCAS2r-Dj0bEduV2LcPj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 17:09:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 3/5] doc: git rebase: clarify arguments syntax
In-Reply-To: <ce7ab74ea0fc0719d66a53c3a1666be2371adea5.1754680525.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 08 Aug 2025 19:15:23
	+0000")
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
	<pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
	<ce7ab74ea0fc0719d66a53c3a1666be2371adea5.1754680525.git.gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 14:09:18 -0700
Message-ID: <xmqqwm7dfrlt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> This removes the explanation of `git rebase <upstream> <branch>`, since
> it was already explained above that it's shorthand for `git switch
> <branch> && git rebase <upstream>`

We usually do not say "This [commit] does X".  In this particular
case, since the objective is so obvious, we do not necessarily have
to follow the whole "summarize the current state, explain why it is
problematic, and then tell somebody sitting in front of a keyboard
to change the code in this and that way to make it improve" 9 yards;
just tweaking it into

	Remove the redundant explanation of `git ...`, since it was
	already explained earlier.

would be sufficient.

Although the proposed log message does not mention it, I actually
like the other change in this patch, that rephrases the "if you
don't specify...", even better.  The addtional "to rebase onto" does
make the description clearer.

Thanks.

> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-rebase.adoc | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index a93c616f38b1..e700b92e35ac 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -59,12 +59,7 @@ one of these things:
>  
>     git rebase --skip
>  
> -
> -If `<branch>` is specified, `git rebase` will perform an automatic
> -`git switch <branch>` before doing anything else.  Otherwise
> -it remains on the current branch.
> -
> -If `<upstream>` is not specified, the upstream configured in
> +If you don't specify an `<upstream>` to rebase onto, the upstream configured in
>  `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
>  linkgit:git-config[1] for details) and the `--fork-point` option is
>  assumed.  If you are currently not on any branch or if the current
