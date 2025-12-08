Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C4C3B8D59
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765200403; cv=none; b=Fba/8sMaf37yLSpXapz3R9qPtJ4sc0NhNneFv2Im72rWx5MZr2etbKxtCt2mIkAAPsI9KtQdfSnjj+P6eNOnbrfw6FxoM1x2k28MM7y7L7pJQZ6z21MuPMwWAdNbHkVB2fSHA+55fJYU0p1rR0XQGevlcX5t0C8q7JspNy+6Yp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765200403; c=relaxed/simple;
	bh=EDGLZxNmBbb6r+xX8FwbDdcWR83P69lV+cgrQKNVT0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U2+vDMNSkqddk4pukk1C20UHUGiLmidSibuxRVgU0Hwx02BHnvZfX1q9fH83Iys2gIDBZ8zORAoMyC7MEyg31t6BSsOhBJWf67czDs4s19Jhx91wemtaGqEbtldttERrvgQznrIUcUt59djPpkbdwrEuaMZRKJEuBdWXic0vTsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FLflD95F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mye6eubH; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FLflD95F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mye6eubH"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id EAC431D0017B;
	Mon,  8 Dec 2025 08:26:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 08 Dec 2025 08:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765200400; x=1765286800; bh=SmZ9GAiGj5
	4pYr5b8uf9Y7McfXRW9nFSYiMs94OOq/o=; b=FLflD95FpWfpAh2HPxLDw4Z9By
	DOYrFigOvvaYebXwt+WZroz/DT99f0qm0yDEPTZDn1i9jGRwcqCWlqo6TbYEBbcF
	kPHuG/8lxEQp0R/Yyf8uxIixAsWeOM1GVleRuFLIj6nc62c4MAvrfxtJZRTAPqBG
	AMksPTjuz9G6C79EAxTAMHNs3NZh7QAfYQFOOeJtMSZ0VutbMlTO+6rcxQmt0Z+F
	Xhhh/XeC9owSbHxlUCFKsbAcnQ2Dl305hNvGkCkLGFdgI3dkmt7M3unk9YXW5lCX
	QTPFCRBJlsjN8WwW/yM/c1nIH3XZR62qItnhGlyn9QTbcMNIjbIhWZ9TBTAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765200400; x=1765286800; bh=SmZ9GAiGj54pYr5b8uf9Y7McfXRW9nFSYiM
	s94OOq/o=; b=Mye6eubHaJK7+fH6/krJx2MwkjRXw9s3hwxsJvM6fVrU2Pljst+
	VItDYOLlYHaKbcRwsf67NZ+fxgcxRZRKvkyLnu8gcMSnt1Qc2AukxHu5hsX1dFL3
	Kan645vxDN9EoeMJt8Zq3vwW45tMg+qR1kEJcIIqgIWepam73KE5Hlvn01sbVgDw
	l9R7FvUi/GbxRwdj4rCdaWIwIVDhhslwEUGCYdLufvUVWHct9CgNgDTx0X7Y2thl
	igj8wEbMdy+MqpUOIiSka21TSFLXtIO6Nrr1WXI2ddIMnwodKQHeDSqoy+OlhJoR
	JjJU8zUhcwPdkEEottvDNNyEX4+L4pkiM4Q==
X-ME-Sender: <xms:ENI2acIkdJjN1bF3NcCz4yo5UDSr8L3Ymf17oMHBnCH4jPwrVLuM0g>
    <xme:ENI2aUlNFaqQXo4Ttn1imwuKY-_-y-39frjnOsxNnLQjR93k7jqDntSber7diWdN9
    dl6Xge5BX1IjMpjlUDFnzE9JC7B-HSkrYuFLp91gxU6_J_JhFdqtA>
X-ME-Received: <xmr:ENI2adLtuv_y957yQ42Z1RmavKXiSxExk5-6dQviwDT2sz12AHYtE8Fmo7tQWukr-ltESpu6ugrd0vRdRa3pZ7CMg6qYm-_-bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpefgteejgeduveeuteeiudfhhfeguddtjefhjedvffelteelhfdtveejueehudff
    ueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhooh
    hnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegrnhguvghrshhksehm
    ihhtrdgvughupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ENI2aZ69T5TDo5HD4xo4gXKx00ZUfnyxuNoaCfFiStIwqik_ZF8Kgg>
    <xmx:ENI2aR3PJyvG5kOlalPN7pggNbwiBHxBJ06OqRTMZzqIUgkmXcHdMw>
    <xmx:ENI2afezy0YEhTxkJj2x4596exDbDRhQYEbue9fzXLRG_9UrOXplnw>
    <xmx:ENI2aXeO7UCtPWJwf56QgjCBlR-43KnWLpYa3DxKGVVn6Se07ygSng>
    <xmx:ENI2aYuu55P6mpb3XjkkdBdEfqfxhk2ixZ4SvwiroUtHPHVvy1_JdmWX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 08:26:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Karthik Nayak
 <karthik.188@gmail.com>,  Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH v2] last-modified: fix use of uninitialized memory
In-Reply-To: <20251208-toon-big-endian-ci-v2-1-76b46763a597@iotcl.com> (Toon
	Claes's message of "Mon, 08 Dec 2025 12:46:05 +0100")
References: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
	<20251208-toon-big-endian-ci-v2-1-76b46763a597@iotcl.com>
Date: Mon, 08 Dec 2025 22:26:38 +0900
Message-ID: <xmqqikehkstt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Changes in v2:
> - Defined and used MEMZERO_ARRAY() macro.
> - Fixed up title which used unexisting word
> - Link to v1: https://lore.kernel.org/r/20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com

Sorry, but hasn't the old one already been cooking in 'next'?

> ---
>  builtin/last-modified.c | 2 +-
>  git-compat-util.h       | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index b0ecbdc540..ac5387e861 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -327,7 +327,7 @@ static void process_parent(struct last_modified *lm,
>  	if (!(parent->object.flags & PARENT1))
>  		active_paths_free(lm, parent);
>  
> -	memset(lm->scratch->words, 0x0, lm->scratch->word_alloc);
> +	MEMZERO_ARRAY(lm->scratch->words, lm->scratch->word_alloc);
>  	diff_queue_clear(&diff_queued_diff);
>  }
>  
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 398e0fac4f..2b8192fd2e 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -726,6 +726,7 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
>  #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
>  #define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))
>  #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
> +#define MEMZERO_ARRAY(x, alloc) memset((x), 0x0, st_mult(sizeof(*(x)), (alloc)))
>  
>  #define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(dst)) + \
>  	BARF_UNLESS_COPYABLE((dst), (src)))
>
> ---
> base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06
> change-id: 20251126-toon-big-endian-ci-fe62bb361974
