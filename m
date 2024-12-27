Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F1647
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 05:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735278003; cv=none; b=ssTf8fbnXYG+Cd3vQRR1F8WcgAZ9abcOVxulOwBpEFWn0UQm+7/wDSX025zeabXhotC5xaX6p+lrvIS7W5du+szLZJW2upFHH+oQrk7eWDoQLEUJ80ledX0re/SLU/FiCy3868B93Avv0mMQVDStguZrYWFYY/Io++DAFTUwr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735278003; c=relaxed/simple;
	bh=tZvTP2uDIv5AMl+eUydv8cvlCGPSOjHfzUBBBVG38xs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KXLevfgNTp1ltmHz+axvFqnzCSugbyKG6o9iVFfFdawl8ORKx7ti4fEWWxkWf3UHbGzrPrLKXzdozT66pgeVoOqU5OmtS+f9wWq3rkqK+HEXWmwtGUiJXLQHp+u86Sh3Zq9ea0Skpd8Fx0mFGGcDXRGM3UE44ZI8XLLM2rPw+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hdK5Lvqn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wg61HI9H; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hdK5Lvqn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wg61HI9H"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA5C22540157;
	Fri, 27 Dec 2024 00:39:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 27 Dec 2024 00:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1735277999;
	 x=1735364399; bh=aDZ0jpZaGv7iGqrmccUt6Rql/6T42j7D2aeE3dqh8Lk=; b=
	hdK5LvqnIchxNQUwJFYejOuBRQ9nQXCPiU4JrR92FB3QI+longyjOrUSNUjk4qBo
	JG5by+HVTzB00Kpc0+swZelGGLdUWwwDhz1/aS8GQzJysE6IhyFUyvjNG2TpXGZd
	xVQX2zTV84N2UxPWypTeXy5mEe2ICYQ3HLB5BFn0Ru/dxXpMOKCGSUhZXrQmgAjs
	wfNTLyYt6NECW6deUZpdhSAAp66SNIa0MmqStbMR1VWffi8ObKO1kTQv9p3RRwGU
	SZUUx3bLkxVPD+ZX2KTMWlgntmI42tv8NEGl2M+Vd8NDI1BO5shhTweeLCaKhXGO
	eDvEUsCpkZYzStoRe2g6AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735277999; x=
	1735364399; bh=aDZ0jpZaGv7iGqrmccUt6Rql/6T42j7D2aeE3dqh8Lk=; b=W
	g61HI9HQHLnfw5PXphd9wnDrTu0T9rLMaGzSwP+mBmKA0qVCFwUpLQzPMAjgXWfK
	OyQq5dTupibh8DVGqSTot8a9uXJnhjxx0eLCRPuzlPQIbVUii+E2mlSVTi9tRcYv
	Uba7ZqJS3SlSTmbXAbdluQdGjaDuw16FRtQqqKUpx3OHZD7RJb3+hoA/s72bJ0IO
	aSXOk3RzR6phZsvZyE742GwhQPWypdJU0hBQqS5Atp214yLfDJC4C7JbORfNvJom
	GUjyhTt8tj6AtUTfhVDEE7QelXbN36cOOGASmbzoz0wG00REphsQIdk985U81DRU
	nP4iS5LgHClwXlGXQN+ig==
X-ME-Sender: <xms:rz1uZ0aDGB8OfOUImha7uVOCogga8Gg6Lxuze2TBPtwf49P-NcOOqQ>
    <xme:rz1uZ_bk3kPAhEn1t--1khpViUM-pML83mHHRyYeW0Ba9WdeteA3tGKPMsCrQ8NUA
    T6omd0QGz3XoEn3Sg>
X-ME-Received: <xmr:rz1uZ-_YxIVEUOzQGo7XE4eUlDOXqMkj9fuSVpzGexEG8pvQm1OUx6fJCmU861DueFXFXL2YFrrVifFKvfLsLJjwbyOkYdEzWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudduledgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvg
    gsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:rz1uZ-qD7lLVVK138P84xBkvyvThImoco0Z4L2sQ9p-wNSF1jv24fw>
    <xmx:rz1uZ_oqDl40s4jdOw634M4Zfs53lp7n8nu9Pj53y_jXThRuEnuRBQ>
    <xmx:rz1uZ8SEA7KK7sHAeU42ArFgMjMzgO0om-EOxMMIBpcV4cISBw3J-A>
    <xmx:rz1uZ_owFcSF9byzImMNOIMw66R0lNMMZMu7gg_YcD_PAxZNvaBrMw>
    <xmx:rz1uZwklOh-KgyHJDRzlfFz75nCwdBb3Q4vbseIzf8feL6Rh0j6gkX2h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 00:39:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/4] reftable: avoid leaks on realloc error
In-Reply-To: <9b2f4baa-b602-4cc5-8dfc-dd941b1d7af6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 25 Dec 2024 19:38:29 +0100")
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
	<9b2f4baa-b602-4cc5-8dfc-dd941b1d7af6@web.de>
Date: Thu, 26 Dec 2024 21:39:57 -0800
Message-ID: <xmqqttapvg42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> +#define REFTABLE_ALLOC_GROW_OR_NULL(x, nr, alloc) do { \
> +	void *reftable_alloc_grow_or_null_orig_ptr = (x); \
> +	REFTABLE_ALLOC_GROW((x), (nr), (alloc)); \
> +	if (!(x)) { \
> +		reftable_free(reftable_alloc_grow_or_null_orig_ptr); \
> +		alloc = 0; \
> +	} \
> +} while (0)

It is tricky what (x) means at each reference site ;-) but the above
looks good.

>  #define REFTABLE_FREE_AND_NULL(p) do { reftable_free(p); (p) = NULL; } while (0)
>
>  #ifndef REFTABLE_ALLOW_BANNED_ALLOCATORS
> diff --git a/reftable/block.c b/reftable/block.c
> index 0198078485..9858bbc7c5 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -53,7 +53,8 @@ static int block_writer_register_restart(struct block_writer *w, int n,
>  	if (2 + 3 * rlen + n > w->block_size - w->next)
>  		return -1;
>  	if (is_restart) {
> -		REFTABLE_ALLOC_GROW(w->restarts, w->restart_len + 1, w->restart_cap);
> +		REFTABLE_ALLOC_GROW_OR_NULL(w->restarts, w->restart_len + 1,
> +					    w->restart_cap);
>  		if (!w->restarts)
>  			return REFTABLE_OUT_OF_MEMORY_ERROR;
>  		w->restarts[w->restart_len++] = w->next;
> @@ -176,7 +177,8 @@ int block_writer_finish(struct block_writer *w)
>  		 * is guaranteed to return `Z_STREAM_END`.
>  		 */
>  		compressed_len = deflateBound(w->zstream, src_len);
> -		REFTABLE_ALLOC_GROW(w->compressed, compressed_len, w->compressed_cap);
> +		REFTABLE_ALLOC_GROW_OR_NULL(w->compressed, compressed_len,
> +					    w->compressed_cap);
>  		if (!w->compressed) {
>  			ret = REFTABLE_OUT_OF_MEMORY_ERROR;
>  			return ret;
> @@ -235,8 +237,8 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
>  		uLong src_len = block->len - block_header_skip;
>
>  		/* Log blocks specify the *uncompressed* size in their header. */
> -		REFTABLE_ALLOC_GROW(br->uncompressed_data, sz,
> -				    br->uncompressed_cap);
> +		REFTABLE_ALLOC_GROW_OR_NULL(br->uncompressed_data, sz,
> +					    br->uncompressed_cap);
>  		if (!br->uncompressed_data) {
>  			err = REFTABLE_OUT_OF_MEMORY_ERROR;
>  			goto done;

These all have "has the preceding realloc() return NULL?" check and
error handling, so they are strict improvement whose only effect is
to plug the leak (and clearing of the allocation).

> diff --git a/reftable/pq.c b/reftable/pq.c
> index 6ee1164dd3..5591e875e1 100644
> --- a/reftable/pq.c
> +++ b/reftable/pq.c
> @@ -49,7 +49,7 @@ int merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry
>  {
>  	size_t i = 0;
>
> -	REFTABLE_ALLOC_GROW(pq->heap, pq->len + 1, pq->cap);
> +	REFTABLE_ALLOC_GROW_OR_NULL(pq->heap, pq->len + 1, pq->cap);
>  	if (!pq->heap)
>  		return REFTABLE_OUT_OF_MEMORY_ERROR;
>  	pq->heap[pq->len++] = *e;

Ditto.  And the same can be said to all hunks that follow (omitted).

Makes one wonder what remaining callers of REFTABLE_ALLOC_GROW()
(other than the one in REFTABLE_ALLOC_GROW_OR_NULL()) are getting;
hopefully the next steps will deal with them?


