Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A32E49BC
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865241; cv=none; b=Ps+MSAPhjGF3tt98gp4MOcTLbq37d+5EbJpy5br3k9tBP0/YwZN/7XWo/ocIAGOZ1LLWDNJCnMhF3yTtGG4gWfzju1qCmx3XEY9co2IOj7zTCancJEK8NaQzr7N60FFUzYGAwdkksDwa4GyRAhAPg1SRTZYKj8J0A4iAjCaY/Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865241; c=relaxed/simple;
	bh=dT3s9FHgh5w/0s82KPpyrcW7TM4DFxJslu+y0nFcMPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=swuHT1fDdxB2o0/uquNOYcNQfCbgdmprck2H8FDkbCQcLIHMp+Fi0EmLUWoCE/DzRqYwa2rgee8Cl40sQ1BNPLssVLbc9J5SJoKIYh6+TglBMHwClK0WFFD8aHckNoRZTNErQKT0XVvig8oYjEoqdVsZdouSt0+EPf0/ovWha8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s5Me0YtH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QatKvkFw; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s5Me0YtH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QatKvkFw"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A0BF7A0140;
	Fri, 18 Jul 2025 15:00:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 18 Jul 2025 15:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752865238; x=1752951638; bh=0A/cJHC43i
	MCPQ5GlW1kYeSJU60ccDL1CQq2khDbst4=; b=s5Me0YtH2m9KS35Ep0RkUTqmOZ
	AkQmWW8fLm/cDpw+OjT3qwN0NsblYwunrTPeJJXn8nyaJucWE9EsHk5xr0kvrAl3
	xM+0m/0YmMojk6b3lvz9niU33bTB1EHnZGbHxzeLCZRAn+MCyVn0KOGSnzIDSL7L
	qBM1NxAFUTuS4ZD3eYamR6fK0u+wAWtJnSCdLasu7PDvBndlSwnL426vTb8XgPUG
	VxQkLb38yvdabpmh22jC+rdwo9xCF6N627SIy6JiccbXdtKgdJG143sNxPvXhIlL
	5GlR0by7obuzqsrnNygjd77QWowyqzUTvjWEtZtF6SgzI42F4GgpyEObulTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752865238; x=1752951638; bh=0A/cJHC43iMCPQ5GlW1kYeSJU60ccDL1CQq
	2khDbst4=; b=QatKvkFwtZYr1xdnZRTYzycd6gQaMBMBuP25B/SU+r3YH6m3w0f
	Hs1R4++2u2gPbTy0fBzpEwqis6CLZRorW6fRtwNef67ByDu+43fH7hezfkTdJkDW
	F1HNsb1StOz7ie2ke+osMOtBDYZVigu6f7xpKXrZwulgwwQfRKIusiuXke2XuG5R
	U5eckMpESZ3quyYwvCS+C2D0rLEAMTgzFU2ZiOY7OvwFc6CgHG+P0hGkXBSWAiV5
	aQ4O/DLjtyIP5LyLJWBU3b8+ZgSQUZMtbJVcPx5N2X7O8s85a6CE5GxRp+ApUZbE
	1lzCc4VgKVXGWm39EQxqMDg0CCBEHfslNHw==
X-ME-Sender: <xms:1pl6aHKWU9O_AGolgxzgrJ79-HCH-Y-sFLv6YPt5dsIFppcQtfRruQ>
    <xme:1pl6aGoN7EOPaj5OlipVvDUkNU04l28OFouecA55G0_F5-Yt15HtNEA2Ot6s_m8Lp
    DXKuOhuaQIptyWMtg>
X-ME-Received: <xmr:1pl6aGIc6M6s93_zl6vkVhF5a6cCgKFvn5j4v4FM9TBr3pdDG5z8fiWctuF9GMh47bK0KZhnCTWt8E90k9-36nO2WPHfUsyVb4MJEeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:1pl6aLTewf1fVF_rmHI8zuteXNFb8N95lEguU6xRF7o8DGLoq55Pkg>
    <xmx:1pl6aFvkjaO1nJhjEsY6i5LNoT0Tz-NamcTg2Sf4jZqcrCgb85UgdQ>
    <xmx:1pl6aMZEseL8s6C3qnKUbeDieIS47k0Lp3BNcjKXGe7XiigTLhiIfA>
    <xmx:1pl6aLFtPdtBiRHjx2mY0EwfGgCe-nwYadd0zLTc3EIp49eKbHa58g>
    <xmx:1pl6aCoJYgco9MH69fAVFLoB_WE0-vegC9Jc7UMkZv1hutCrUYrgCbXE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 15:00:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 6/7] xdiff: conditionally use Rust's implementation of
 xxhash
In-Reply-To: <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Thu, 17 Jul 2025
	20:32:23 +0000")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
Date: Fri, 18 Jul 2025 12:00:36 -0700
Message-ID: <xmqqzfd12ujv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +extern u64 xxh3_64(u8 const* ptr, usize size);
> +
> +
>  static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
>  			   xdlclassifier_t *cf, xdfile_t *xdf) {
>  	unsigned long *ha;
> @@ -175,14 +178,26 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>  
>  	xdl_parse_lines(mf, narec, xdf);
>  
> +	if ((xpp->flags & XDF_WHITESPACE_FLAGS) == 0) {
> +		for (usize i = 0; i < (usize) xdf->nrec; i++) {
> +			xrecord_t *rec = xdf->recs[i];
> +			rec->ha = xxh3_64(rec->ptr, rec->size);
> +		}
> +	} else {
> +		for (usize i = 0; i < (usize) xdf->nrec; i++) {
> +			xrecord_t *rec = xdf->recs[i];
> +			char const* dump = (char const*) rec->ptr;
> +			rec->ha = xdl_hash_record(&dump, (char const*) (rec->ptr + rec->size), xpp->flags);
> +		}
> +	}

As a technology demonstration and proof of concept patch, this is
very nice, but to be upstreamed for real, we'd want a variant of
xxhash that can work with the contents with whitespace squashed to
be usable with various whitespace ignoring modes of operation.  When
that happens, and when the result turns out to be more performant,
we can lose the xdl_hash_record() and require only the xxhash, which
would be great.

And that variant of xxhash that understands whitespace squashing can
of course be written in Rust as a part of this effort when the
series loses its RFC status.  At the same time, those who want to
use our xdiff code in third-party software (like libgit2 and vim)
may want to reimplement it in C in their copy.

Thanks.

