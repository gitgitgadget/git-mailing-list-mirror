Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E3DEC4
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739425581; cv=none; b=Yl80+Xi0t9CkMQ/kQp7/9HmwwjXrFy7p1worSc3GCm9HUSMTBeOj4PePrNY+ncEwfuStw1hxJ7JHm2a5xnqnXhsjyyJM4BwHdS7vkn8pw2CptrPWozO/oB8PXvY28Qp5/G8BKpO5NnvUfYkL6o/YVy802lr/kJnKuYn7AVU7QBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739425581; c=relaxed/simple;
	bh=MWyNpqomQDJbQDBya8wbMygP5t30yd9fKTHXfQolmE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r5mfguljITTW/psr+ghYimNnWyueRIwocgdtOmSbF1O025STa8YxH3m5cGQ56/W8btuYKiXhIsyVWt3oQjlfgemVMmk2fU3OtOCtIBzJPgn8woDkCGu4y8rWDgsDL5zG9O5U/bwp261433K3g4oMRLrbbYHSsyeNxy0raD7iGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l4cYInq9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JqE2e56C; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l4cYInq9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JqE2e56C"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4696525401C9;
	Thu, 13 Feb 2025 00:46:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 13 Feb 2025 00:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739425578; x=1739511978; bh=8ac9IuT7Ww
	MKcjHrl2QdcedWRweujJhAHALUDiIWr34=; b=l4cYInq979IGiDh0yziO1NCX+N
	vGdBOHNVS0CZfewqh0tqqBddH4R0wxXjwaswxqTBhFjN06CoZt3CLg4QMU8pBF7B
	SXKExk0bPCWGh9YvKDEFZU9hBjlXcam15ROVKkki4O/WLfg3pws0YdWGjtpKMNtf
	DQK/VBEJykQzddlrQk2LePRZgfJAHzMqN7qWokQSZZ/bDQDK+RRQQc8fMnWlFmSM
	+XsoAg/z1qo2UXABC4pQDXMk8Fig7jjUeUHxRg/TLMFMp9p5FR+PtZp7VCApMj9d
	zhHAJWXGO6YSJp+OSutTXLcDbNx6v/4XcsVPD1mHXkTZME8D/HJTx/v+3wQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739425578; x=1739511978; bh=8ac9IuT7WwMKcjHrl2QdcedWRweujJhAHAL
	UDiIWr34=; b=JqE2e56CzIyFBFaIQOxpcw8By/6eWnZNb7HzSkA2eRYp/iqIV2G
	BupIZlkQvDtrchwFpSzKyi/Z+aVea7RtARgGmVsrT0B7MEr4Lwq/J2R2iU7jKC0s
	E6GKyAGQ5x4fMifbDtQtNTsM/bIfLqZzsKe9bDwF0kTgDft9lLgFmPmH8M4FVptw
	xJ2Ni8lU6rcP2lAgnHUedIdwIKY7KjBFEv7fQJL6zG0El8+WKSvOruBatpP3CIlR
	SFHI/8YFB8MVV24ISVGDrd/648HIjJLA/zlyZht0iBm3mWKRtj2Kl5N4ZI51k+ez
	2bMPIEkqhXBak5S0IfZWTDpsAuk6z+oD66Q==
X-ME-Sender: <xms:KYetZ6vGydQZr6LTjY3VURP3B6qppqapmW-5YuRB01V5wopjy_ThwA>
    <xme:KYetZ_dUAZokYveWGHXFQX9L0LoBkKJEC9opVZJOxSq6_IqJXbqbR8n_lNBXZRiyY
    ZuMooHe8bc6cpY1Eg>
X-ME-Received: <xmr:KYetZ1xv-0FhcQ9X_q7yMaQ2LJbav3bIlhNoWL-ZcSjcvHLnSV68dDkLLRoZ7cajqHkdPKCgVYEMz2vEbeKrfgrmbE35xBUtcw90tpY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegheeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehilhhlihgrrdgsoh
    gshihrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KoetZ1N-zrN1nYWoHaEOECvpO8pll9uEs-Or1efGUG20Jt-X12RENg>
    <xmx:KoetZ68fMr_ZDEUhuCJK-DxPiWYwO3M384IO5bVsnrMyTZD-8Bzj4A>
    <xmx:KoetZ9VTCemrjtRO45MW0UMkRY-6ty39qHEIC_PezyVPjGc5tCWeHQ>
    <xmx:KoetZzehQwum0eMxib1klNgEyhL1EqqFjs_bIJlt-XBL_KkYOuXB1Q>
    <xmx:KoetZxZ_tiNpUhufCj4yCFsJ7NXTrRT-b_Q70ImSX5DPel9JnTgJoIEo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 00:46:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 07/10] completion: Support --patch-{grep,modifies}
In-Reply-To: <20250212032657.1807939-8-illia.bobyr@gmail.com> (Illia Bobyr's
	message of "Tue, 11 Feb 2025 19:26:51 -0800")
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
	<20250212032657.1807939-1-illia.bobyr@gmail.com>
	<20250212032657.1807939-8-illia.bobyr@gmail.com>
Date: Wed, 12 Feb 2025 21:46:16 -0800
Message-ID: <xmqq8qqapfbr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Illia Bobyr <illia.bobyr@gmail.com> writes:

> Subject: Re: [PATCH v5 07/10] completion: Support --patch-{grep,modifies}

"Support" -> "support".


> ---
>  contrib/completion/git-completion.bash | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Missing sign-off.

Other than that, this is a great material to be part of the main
topic to add the longhands to these two options.

Thanks.


> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 41391..daf335 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1900,6 +1900,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
>  			--output= --output-indicator-context=
>  			--output-indicator-new= --output-indicator-old=
>  			--ws-error-highlight=
> +			--patch-grep= --patch-modifies=
>  			--pickaxe-all --pickaxe-regex --patch-with-raw
>  "
>  
> @@ -2216,7 +2217,7 @@ __git_complete_log_opts ()
>  		__git_complete_symbol --cur="${cur#:}" --sfx=":"
>  		return
>  		;;
> -	-G,*|-S,*)
> +	-G,*|--patch-grep,*|-S,*|--patch-modifies,*)
>  		__git_complete_symbol
>  		return
>  		;;
> @@ -2239,6 +2240,14 @@ __git_complete_log_opts ()
>  		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
>  		return
>  		;;
> +	--patch-grep=*)
> +		__git_complete_symbol --pfx="--patch-grep=" --cur="${cur#--patch-grep=}"
> +		return
> +		;;
> +	--patch-modifies=*)
> +		__git_complete_symbol --pfx="--patch-modifies=" --cur="${cur#--patch-modifies=}"
> +		return
> +		;;
>  	--submodule=*)
>  		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
>  		return
