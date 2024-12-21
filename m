Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE52837B
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734800904; cv=none; b=nXmtdP/67/kfEJ2SAHje+5wz9YAQjbf1gksxUxTt7tjNVdOIaK6rVjm9GSCvWCXb6T/EQUqHJglwnM7fDGJpxkgAhRj04Z2IEkdQ6V1/XFCI5dSYKVTLzP1waHY6SK/uiQJBSbY4cuo79YV7YBGUIA9Uf5bTS+DDveHroaTpHU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734800904; c=relaxed/simple;
	bh=4FAJ9FS6I38WD5D/8bIO7fnzEIUdp3q6fdrx8r4ym9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fsPWWWDppiK3MNWjhS2Xa98ZlOvbKtz0CpUSCa2QC+xwC78wTcK67LWRFI0g62CJ+G0u5Lm5p2ZwRr5M3WRtzjiGpUtEB+WDiXgBXXgEcIyjHvduW5++aDcCnHSQ0eWolOEIrT3BLxsFhwbwWxb/awbHpE+ZTmGJpFbmzRhGTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pFX6n1Bj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jrPtXOhJ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pFX6n1Bj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jrPtXOhJ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C84FC138012C;
	Sat, 21 Dec 2024 12:08:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sat, 21 Dec 2024 12:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734800901; x=1734887301; bh=m3e/J1s2ZW
	aufYyLAZTPwMXQ5mkybGJY7lUK+rwXFJA=; b=pFX6n1BjezQR9csKbEovZ1M2iI
	7eBnASbYvpp5M+ASj6uF/7IQI3qtbzXzBRb9/hfxWeuC4OcqngBRX8AMHRtMSWgL
	zn4lxhw0idetTHbj30ZvxA6o1Xe/O8r73OJAbOUv1vd/Xd75fojd52/wqPFLFG1D
	YUixnezy960A6fJ5gVLfMjlcvkizSvxOF/7QzEdiQXH3ikXrtg9eQl+ApdvTmHpx
	3XbpOCQ2zttHLZVRkZQ6HTeSb6Mv9nLiGaFEv8muZK6K0XfPIObhXpLhAWjZsIHk
	I7+ju8z4h04PM2Xrvra0m9Ihad+qnQSNho9fVpHamB8RboMnX/FEpoCh/fnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734800901; x=1734887301; bh=m3e/J1s2ZWaufYyLAZTPwMXQ5mkybGJY7lU
	K+rwXFJA=; b=jrPtXOhJmIuEsoMhG+TkiaG/+6h8EqR4ASNN0AQZ3mJhfpmcMx0
	dgMsaRAGsqOkv1hd8G8Hjm/EdU182CUZtpBGIBpv0yCuXotludSwCAUu+MMM3zDX
	X9UyhwsNXQlgO0x8BhMNd7/vRahj4bON1NBFSn+s7AB8e1bnxaDLqVy1p88/ALu/
	r0Wu0GCC3H/51W1Grp1glt9KcKQTU6q3X7JOmaxOhmFPI1u+tuPMRO0MB0dutBKm
	ZvcHIJfUlXQOJwfA8bQyfjJdjNEsSNNknESDjS9U+OZvPB2Jylbqk1rt/UxNL4ER
	r8HzdxLp3YtXphEo8L8HD1s0JZnu3exuLtQ==
X-ME-Sender: <xms:BfZmZ9Hkc0Bw8wNKPuhhXwXmHzhVoAaRrsE9SAkkdSA9suJMRFy6zg>
    <xme:BfZmZyVPjgfwF8NDXmc8aseKt_-h0w--OHF06pb4OmmlwuKhO-O8GwEtb7LFrqguo
    _N40W04GpKbT5MNKA>
X-ME-Received: <xmr:BfZmZ_JILxZfy7RaxmBp6jyFb0ecacUMhYwoiBdQdxABU7N-EhHeWjkjpg5634KyNiwYGUjs371_uh7R1hGHQeThKXz7Qwlh_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BfZmZzHnpk2f6nLOAY4f0LSAZP3tLKB7Au4nahwgfhSRzcBnsTqX-Q>
    <xmx:BfZmZzU6Nt9edjBLj3Vhwd4O7S5F9N7rlweSFmAOt8n8JOYCrqHrhA>
    <xmx:BfZmZ-MCJeLBq1II7Nved1STA8nS-MJpYxS04GDawdq_Gn5ql08ceQ>
    <xmx:BfZmZy2-O4AxZ8qZzHQIz2AzkF7g6CZ0B-MxBM-g_StK5ZGxEP937g>
    <xmx:BfZmZ5wFRGdI6IbHRjjcQNkL2jKTotRi5rxNZz4YOm6jwiVxiY_NXAo1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 12:08:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 1/4] reftable/stack: don't perform auto-compaction with
 less than two tables
In-Reply-To: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-1-12db83a3267c@pks.im>
	(Patrick Steinhardt's message of "Sat, 21 Dec 2024 12:50:07 +0100")
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
	<20241221-b4-pks-reftable-oom-fix-without-readers-v1-1-12db83a3267c@pks.im>
Date: Sat, 21 Dec 2024 09:08:20 -0800
Message-ID: <xmqqmsgpc6bf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In order to compact tables we need at least two tables. Bail out early
> from `reftable_stack_auto_compact()` in case we have less than two
> tables.

While that is very true, bailing out on "< 2" would change the
behaviour.  Where there were only one table, earlier we still went
ahead and exercised compaction code path, but now we no longer do.
The end result of having just a single table might logically be the
same with this change, but if we were relying on some side effects
of exercising the compaction code path, do we know that the rest of
the code is OK?

That's the kind of questions I would ask, if this were somebody who
hasn't been deeply involved in the reftable code and came this deep
in the pre-release period.  But since we all know you have been the
main driver for this effort, we'd take your word for it ;-)

Thanks, will queue.



> This is mostly defense in depth: `stack_table_sizes_for_compaction()`
> may try to allocate a zero-byte object when there aren't any readers,
> and that may lead to a `NULL` pointer on some platforms like NonStop
> which causes us to bail out with an out-of-memory error.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 59fd695a12c2033ed589a21ef1c9155eeecc4641..6ca21965d8e1135d986043113d465abd14cd532c 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1627,6 +1627,9 @@ int reftable_stack_auto_compact(struct reftable_stack *st)
>  	struct segment seg;
>  	uint64_t *sizes;
>  
> +	if (st->merged->readers_len < 2)
> +		return 0;
> +
>  	sizes = stack_table_sizes_for_compaction(st);
>  	if (!sizes)
>  		return REFTABLE_OUT_OF_MEMORY_ERROR;
