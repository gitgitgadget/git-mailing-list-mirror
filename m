Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F9542BC2D
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061686; cv=none; b=tVyAKFLT3Ii8d8+LJGeYFp6/FpIh8+W4Hd05irf0kl4EhP0ILhW1rB/sMn5lqY+oxjiwHTrTsZH/f+CqkjWPTn2u0M9+8ugvdDOSO63FA/iTguao+ki4P+zRem4i7nWJjmbvqAfCfX68eqPDjHVzrk76MUkDK2Scx413wPoYyOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061686; c=relaxed/simple;
	bh=0d1rcYeK7vcjkAP+b7wAl1c0aEtHoECdByjWReWDTdc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L/Qnqt5IQfDGKqvZrCKGaib7odAeZx1MkvRU56nC+NFi9rVna5KgzwEcDCSQehgVQG2AldrFD/+Y5ppji4EGzFYKtapQS+brNmc6MCh1zCc84nE9KwNJkptRFDrNMYhRKg0bN8l6YBpTbp89MWvWIaLeQXOZVk9CyuqSSuQV4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IRn9n8PS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZ+yE8J0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IRn9n8PS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZ+yE8J0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04B9A14000F4;
	Tue, 14 Jul 2026 16:41:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 14 Jul 2026 16:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784061677; x=1784148077; bh=Ftw2eANbRM
	3ki1oB70bqs6/Lrq+yILZr1FAA4wv6X/8=; b=IRn9n8PSYO0WCuR8TWNijTkNVr
	MX9eVSLamaLfRucalY3sbVe5knYYnDUP0t5e8XlFkKDEOrHZvEDBENgFw9plc7Bu
	oufweAydDhDHNEHApJQKe2YvLOkL4mPAclyI7t1BIrrUhKkuBykQezXqcKgvfk2e
	4/IxJyfbshyFVnVAe/FjTHJKEsGf7QTvNKTQXQ/SMIqLQixq4+YIhz1rxcVCHZg0
	N04WXydjJdxfpTPFB7TFtMTOjxo3l+QI38PnR+XNOFq2yoquPnJpCaZpQrmeSM3o
	2CkJnvgsCmjLMMwF5/hUg6qbOvtI+qA92umMGFW95cVF5ZQ3yml8B8Thwunw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784061677; x=1784148077; bh=Ftw2eANbRM3ki1oB70bqs6/Lrq+yILZr1FA
	A4wv6X/8=; b=BZ+yE8J0ECzImFxNIsdN0Od+7HBr9OmhLf8njNatsVYDOEIASBQ
	8v1kwairMVZOZu8iNiNVZ040pN9Act+NrldSRE72HMFgeJQxzLd73fuQghsDtibV
	qnxHZ+srUbI5Zeew2xZjcXCqUxd7CodlsaF+oFG1Q17o2a68YlHCRohLYWRO10FC
	zYlsG0RbfDSi56Lan2fzlmVmArDaH8UxAiZ8IOo/ftFPwgLcTap0khHsikawAezH
	bEUXO4aNQujpqzE89vAIqIIQcBeeQWX8eIPIKbcJWP2hK0MmUtFXHzj+xSurwOI7
	MBcTBMBlDQVIx5liyb4trffRzpNayjIvvoQ==
X-ME-Sender: <xms:7J5WamRPPcSy3Yi9RmYhWH4f_dNT4OmKAlOIx0Z9flaENuAmA9s22Q>
    <xme:7J5WajOdcD3MOf8QojGEnKa-7qvStpEUv1zvNEFion4biV3P-TQigzMR0nfb79ysK
    hvtxJfPKf8GML07cU76lo4o6BGJfD4OCRuC3HSHzoCAu2vQdnUS7IY>
X-ME-Received: <xmr:7J5WahPJsK-b75nkgqREWkeOonoOgu_z_ndRiwWKqflvrgc0kBACWeepdxqH0T8QXRTT7Y7ojs0RDYXIPT2eNH-9CBJmbJcDJdBKO-s>
X-ME-Proxy-Cause: dmFkZTGlCOFUNznOpzI2IrI8J8aBQN9HHOLWZCF8xU/EyiTGj/o8g2rpBmK5bqrXTpSiFB
    VcrcKnNXZEX4naA5JWqTDxmMKQBVzTDSZfSFJl/GWvznuLOFmmz5I6Lenn7EyhQ8hf+v1U
    Hedng1gnT9MnxDWRTdmsPKpHIzyUfRbmqoY9RcycUT5OfTKVEH5lCZHefzHSNcemNJnrn3
    pQTfYZ+NskbVeYM0t4jrnR/3g7QhUQ+w/8tl7GBJ0ln3lFiV2EoeN3O2rqUdDV2H+beb/m
    7Ki4fpXCNr9lnfoqMJ7p8VkkRIjJ93XV2iIp9q5sZGfRje4gUSWztcp6ENU8/6oGcN0yo7
    1hMD43HCeqHVgBXK4A/bcM6CEEpBhQD5lJkIaDVEe+qG+q4o7QDT35qDFFCcpyeo2YW+xL
    F0GtjsDa7p8wGrq10x9n1vmCGFxfj6rl2h+iYuy9EyCWvHnaM420WmICV6jqn5gYz4xFT3
    HT2vgVeU17LAypfa/lAE9Jcq8jFK/GdO7c+3eKFDHdNVe5qGKzLjd3ghbh14vrWh8zRlQh
    RUdouJiii9KsAjPZ+2RJG6SO+5FtRmkHrGhRzmWmkD+X70WsI4oKZQ3rVyPvvZB6qCx925
    bfWJSDpvUv6pZkOW4jiE15LjBpigi2kHqCD0xJtLGjmc7B7PSEqdJuUdpNHQ
X-ME-Proxy: <xmx:7J5WarsyO2PMNmU0n8UZn22lBWjc8if4vgAjNSZBK-F75ymwJ6zbng>
    <xmx:7J5WajUXjsikiGCF1AjlqSCHP3uSpbc5btC1_8TwwjkH1zXdoc6SrQ>
    <xmx:7J5WarsAx3KhIMeXFNobsYBCjRO-pX5oyAGHymM0bqynt6Zx8ckQIQ>
    <xmx:7J5WanVbmu2XY_kQ1zdxZQTHWJTIe7hDZzZv-q0_jrOo67Za1toleg>
    <xmx:7Z5WajOlgKRu7aAsG1CZkRRjgp43M26nOCeO82NIA2C0e-3hohAkfG3F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 16:41:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] show-branch: convert object.flags to commit-slab
 with uint64_t
In-Reply-To: <20260714200237.70509-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Wed, 15 Jul 2026 01:31:22 +0530")
References: <20260714183028.67857-1-gatlavishweshwarreddy26@gmail.com>
	<20260714200237.70509-1-gatlavishweshwarreddy26@gmail.com>
Date: Tue, 14 Jul 2026 13:41:15 -0700
Message-ID: <xmqqcxwps3ro.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> show-branch uses commit->object.flags to store per-commit data:
> the UNINTERESTING bit and per-branch reachability bits. Using the
> shared object.flags field for this purpose is fragile as it
> conflicts with other users of the same field, and limits the
> number of branches that can be shown to MAX_REVS (27).

The command was written with the understanding that it would not
allow other parts of the system to touch these per-object flag
bits.  Therefore, fragility is not a relevant issue.  The primary
problem with this design is that the flags word has only a fixed
number of available bits, meaning it cannot process hundreds of
branches simultaneously.

This limitation is precisely where the concept of using a commit
slab shines.  However, to truly take advantage of a commit slab, the
slab stride must be variable.  If the tool is handling more than 80
branches, for example, each commit requires a `uint64_t[2]` array
allocation (since a single `uint64_t` provides only 64 bits, while
`uint64_t[2]` can store up to 128 bits).

> Convert this usage to a dedicated commit-slab using uint64_t as
> the element type. This is the canonical way to associate per-commit
> data in Git without polluting the shared object flags. Using
> uint64_t instead of unsigned int lifts the MAX_REVS limitation
> from 27 to 62 branches, as suggested in prior review discussions.

I do not understand the reference to 62.  As I previously noted,
storing a fixed uint64_t[1] instead of variable-length uint64_t[n]
in each slab entry fails to realize the full potential of using
commit slabs.  Furthermore, we should be able to utilize all 64 bits
of a uint64_t word.  There is no need to pollute this dedicated,
one-bit-per-branch slab with the UNINTERESTING bit, which is used
for the command's revision walking.  Revision walking can continue
using the UNINTERESTING bit in the standard object.flags instead.

> @@ -511,18 +523,20 @@ static int rev_is_head(const char *head, const char *name)
>
>  static int show_merge_base(const struct commit_list *seen, int num_rev)
>  {
> -	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
> -	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
> +	uint64_t all_mask = ((UINT64_C(1) << (REV_SHIFT + num_rev)) - 1);
> +	uint64_t all_revs = all_mask & ~((UINT64_C(1) << REV_SHIFT) - 1);
>  	int exit_status = 1;
>
>  	for (const struct commit_list *s = seen; s; s = s->next) {
>  		struct commit *commit = s->item;
> -		int flags = commit->object.flags & all_mask;
> +		uint64_t flags = get_rev_flags(commit) & all_mask;
>  		if (!(flags & UNINTERESTING) &&
>  		    ((flags & all_revs) == all_revs)) {
>  			puts(oid_to_hex(&commit->object.oid));
>  			exit_status = 0;
> -			commit->object.flags |= UNINTERESTING;
> +
> +or_rev_flags(commit, UNINTERESTING);
> +
>  		}
>  	}

What's this funny indentation?

> @@ -607,9 +621,9 @@ static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
>  	for (i = 0; i < n; i++)
>  		if (rev[i] == commit)
>  			return 0;
> -	flag = commit->object.flags;
> +	flag = get_rev_flags(commit);

Has the definition of local variable "flag" in omit_in_dense() been
updated to u64?  If it is still "int", then this would not work
well on platforms whose "int" is still i32.

>  	for (i = count = 0; i < n; i++) {
> -		if (flag & (1u << (i + REV_SHIFT)))
> +		if (flag & (UINT64_C(1) << (i + REV_SHIFT)))
>  			count++;
>  	}
>  	if (count == 1)
