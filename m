Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1F383A5
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735750865; cv=none; b=jnAN/xB6A3ng55/4w1faFXIpoElOpifbLArb92ck4arzviL1eajo8dEmIFyffQ/cAHLhMfHdygE4BYVdaaAQY7qVNUvZl5WuNTLGQQ3u5QIK3+A+epzn5TRFJ/EGIW0f86OmDlZaV9IuFnZSJAuqQ8mSbL156aOo63XZ7V+wIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735750865; c=relaxed/simple;
	bh=rd1h4Rudck+93ZFYVIbAHOAlwiHl7lXWRt1FHnCQ5cU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MdiE8cPkmN94t+RcJi2WQ5xkAmTErMu4+zpZx1d3HjmxqyDrklEOaXfBFx4bwKmskAJ8whh9a5I7gbz9e3JEI9Zkva1UmYgS/P7ucGiHMsbH1u4rVnikhGByxbFwzpq2rP2GsvFbRDIZqjAGGENRzeCqO7Rb++A6GN+oMLxqhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=piMouMbj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yY2FrSNN; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="piMouMbj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yY2FrSNN"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9DE21140146;
	Wed,  1 Jan 2025 12:01:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 01 Jan 2025 12:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735750860; x=1735837260; bh=yNjxtSfaZk
	EA/Fl4a78MwkRwOWYTHH9srQjIUqdxqk4=; b=piMouMbj2cbWa4JhrH68uA2Mny
	3fRQizW3TyEMqTb1Mvb1E19Kn0axpMdNJ9tUu8AHQIQrtdUJN9J+10kcOVzFTU5c
	EHy2aURhbXSlRPag7L8x4RdlQYzmwwEBGeVjtERRGz7/y5weAJJGbSab/RQ8IjPu
	uT7dY8DLdbHETXM8rGlcExB7GUsltciqa/sh37Squ8X57oO8L+NB3lM0GZyWrNFH
	cWaycybVn0v2LYWPR5Ej0ho3Zc093yh4wCaM3Zsj9WdaNhH9sqGDDG3G6XpRQiJv
	bmO9mADMpXrDwDBD8GBgpO4ihcKu7LWAw4Cnhm/IANIbURW0iLNAj8EK0tDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735750860; x=1735837260; bh=yNjxtSfaZkEA/Fl4a78MwkRwOWYTHH9srQj
	IUqdxqk4=; b=yY2FrSNN7MgV6afIU9bdVLAk77MIe+0gtsgty6akkvIwVGPphcE
	1EliScgLbAkt44FvqGpvzvLRpAr7IXSds4TjiKu8/ZNxW2bVJc9JIWxUqv8vbq7l
	ywDE9fUfy93w081XMuHjV8Bhh/PkuztRxb58WhEx5Kkci3zAiWPRxii+cL8tpWS8
	WtAxY25JDRByaX9UQa4sO0Gz3LybvCHal1Iq2tx+JElEc22ZKbo3rFFAK5MrsyJk
	sXcIufLg/zZWe5pEPep86bNFC6e8AyjeUp3dHw7oIDyPa3rG704U6vCngBYg+7Bv
	agHSJSBHZUjnAD07/7bOltDPjnw5LkHF3sg==
X-ME-Sender: <xms:zHR1Z1Ic_xLHrIR_AIjZoY60gxGRCNLF43nxV7T5knwXDCPZ9xQ29A>
    <xme:zHR1ZxLXnslmEaJwsmR-SezCqbZ96kMW_QUGzJNazx2nkbQ0fvRlajD_-8GRRpye0
    C7S85fkQPAr_recVQ>
X-ME-Received: <xmr:zHR1Z9sW1GVz0FpEHWgOTNIcbtQ8CmUsw2kKzSVHCvbAeTAOTUD_cRaZQOG-MuqTgk-8TpU0IwkiiMWyReFGEPPoCj7sW7uZHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeftddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefh
    tddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:zHR1Z2bpnSihTt1OUfZY4OeMVCE0qELSv02wkRHfcoXTOgE8DrpabQ>
    <xmx:zHR1Z8bIOQXMH6EY2xee4u_NX1zzBgUUacRlwOrh64SxOpUoPyw2iA>
    <xmx:zHR1Z6D8am_Bh_mLbUibCgJdK_2Im5TtfbNA1dk6XNbl1G2P3DNEHQ>
    <xmx:zHR1Z6bhoqUYeZAoNYWBjcHqlGhqJpq0u_BMJONVl4E5SJcTFq6X6Q>
    <xmx:zHR1ZzW_FJDk2H_MDx7IFsqGiw6wzYcreGWz4o6xwQQJRifQw52N20Ik>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jan 2025 12:01:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] object-name: fix resolution of object names containing
 curly braces
In-Reply-To: <pull.1844.git.1735699989371.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Wed, 01 Jan 2025 02:53:09
	+0000")
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
Date: Wed, 01 Jan 2025 09:00:59 -0800
Message-ID: <xmqqpll6wjsk.fsf@gitster.g>
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
> Given a branch name of 'foo{bar', commands like
>
>     git cat-file -p foo{bar:README.md
>
> should succeed (assuming that branch had a README.md file, of course).
> However, the change in cce91a2caef9 (Change 'master@noon' syntax to
> 'master@{noon}'., 2006-05-19) presumed that curly braces would always
> come after an '@' and be paired, causing 'foo{bar:README.md' to
> entirely miss the ':' and assume there's no object being referenced.
> In short, git would report:
>
>     fatal: Not a valid object name foo{bar:README.md
>
> Change the parsing to only make the assumption of paired curly braces
> immediately after a '@' character appears.

Interesting.  I wonder if this looseness was to ensure that we won't
mistake a colon inside "master^{/title with : a colon}" as a start
of a subpath, instead of asking for a commit with a title that
happens to have a colon in it?

> Add tests for both this and 'foo@@{...}' cases, which an initial version
> of this patch broke.

Thanks for being extra careful here.


> Reported-by: Gabriel Amaral <gabriel-amaral@github.com>
> Helped-by: Michael Haggerty <mhagger@github.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     object-name: fix resolution of object names containing curly braces
>     
>     Maintainer note: this bug dates back to 2006; it is not a regression in
>     this cycle.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1844%2Fnewren%2Fobject-name-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1844/newren/object-name-fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1844
>
>  object-name.c       |  8 +++++---
>  t/t1006-cat-file.sh | 17 +++++++++++++++++
>  2 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/object-name.c b/object-name.c
> index c892fbe80aa..e92f26b3256 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -2087,12 +2087,14 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
>  		return -1;
>  	}
>  	for (cp = name, bracket_depth = 0; *cp; cp++) {
> -		if (*cp == '{')
> +		if (*cp == '@' && *(cp+1) == '{') {
> +			cp++;
>  			bracket_depth++;
> -		else if (bracket_depth && *cp == '}')
> +		} else if (bracket_depth && *cp == '}') {
>  			bracket_depth--;
> -		else if (!bracket_depth && *cp == ':')
> +		} else if (!bracket_depth && *cp == ':') {
>  			break;
> +		}
>  	}
>  	if (*cp == ':') {
>  		struct object_id tree_oid;
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index d36cd7c0863..252485dac78 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -603,6 +603,23 @@ test_expect_success FUNNYNAMES '--batch-check, -Z with newline in input' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success FUNNYNAMES 'setup with curly braches in input' '
> +	git branch "foo{bar" &&
> +	git branch "foo@"
> +'
> +
> +test_expect_success FUNNYNAMES 'object reference with curly brace' '
> +	git cat-file -p "foo{bar:hello" >actual &&
> +	git cat-file -p HEAD:hello >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success FUNNYNAMES 'object reference with at-sign' '
> +	git cat-file -p "foo@@{0}:hello" >actual &&
> +	git cat-file -p HEAD:hello >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'setup blobs which are likely to delta' '
>  	test-tool genrandom foo 10240 >foo &&
>  	{ cat foo && echo plus; } >foo-plus &&
>
> base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
