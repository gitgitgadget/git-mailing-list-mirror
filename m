Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59783264D1
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784269638; cv=none; b=W0uf4IhnVnp+Jx7xfdVYv7f5KYWLnVFJNpp23UM/Pk/FxcPL7zeS7udVNugkOUmrA9VTwMfzCKzF05I04uYXBh2HPifUCLo7dMXReXK7GzTW0UzokfknWI++Xi1tMcUfmyJ6je6lj5Ud7XQEU6xOr+QA6kJ5g140eCSSi1WcUNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784269638; c=relaxed/simple;
	bh=Lj0q3q67t6bBA3FzlbewRDLW9CuuWFsmdErwvHDQfAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOPv7DRmbTOC2cI58X8aVnK4zmqAjE8xYxUR5VkQnrZttKzGkNC6lqj3l4cff0b3BXfTIOjMWyyzNpZaPO/27kYgxjhLjf/AZUQuge/ATDzh5dreWead7M9IuMK9EQrYloWPbbl0InW31B7CnPhFDvC3+4to7mO+/z55ace4cUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PkCrkoMk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gRZtFAaR; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PkCrkoMk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gRZtFAaR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC4AB7A0089;
	Fri, 17 Jul 2026 02:27:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 02:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784269635; x=1784356035; bh=nB6URXvQaM
	1Lg6tVl9GhQBHWvEAouYDbpkpLjlA7mw4=; b=PkCrkoMk92lB+JYIlB4uFTdu4q
	qHdMZ2TehPl3x8YeaQ7PubsvW+2yoPlwf21lhIgZ7mlj/dBO1FG4f5kfJCxdMdqG
	0ZkltqpEps3YBYHGX4jo+D9gAcF0CSRlz1Pe3iH04qlDDCcoxMxoLBmB6GikeqKr
	mjetqdihPhjb9Yl1QwG6NQLNWzNYzdpbMb4Zzk9X2C3mivB8wMMtXqEHy7/7muCI
	A+JLtKBZRnpsoavUlsgukR6MWew06wL1HXgSjQzlJzomxGD3X85d8bH2mMZcu+px
	hk4Qo09YMTK+7XV6e0juPsEJ2OctpWLDcCnzJ6gdLDusBWfEWm9BncEJVGwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784269635; x=1784356035; bh=nB6URXvQaM1Lg6tVl9GhQBHWvEAouYDbpkp
	LjlA7mw4=; b=gRZtFAaRUO0MA/aIfTUPw52oyU9PjzOacZIPNIHtsrY3e1kNcWq
	0DTR/KtOzq6U6F8Jtq5g+V15PZRXqlaWf/QfcB4I18ZSjT9ILuU4yMDgH9ZyZTDE
	ceGgMEedo5bG0vSXxHmiEc0xhH2fD+VeLSxXYMMzU9ypa9bVod8G2yhLgm1V55ou
	UqE8k+freqgrSPb2kWJENlrVdHm0kJhcrj285VedKMHr+jxhZ6Yw2vXLzbrm6hYD
	3I+yKklV/QmSgyYsmV1O2lCbLOup7cyKjCSvs/81K+m1x7GmSvs10LtLPNj2DUKq
	5PDaOk05KIx8H6kNg2LK/GuDAUWwR62Di2g==
X-ME-Sender: <xms:Q8tZajE4V8-pR3cCg2OSuaRukGNh226_-ysyFDNkF8GOjCaGL8uQ8Q>
    <xme:Q8tZakA0POeUJ04-MoN2RO8l4smr0tvaEt4e76sF05Ip_8Mx_vVOxPtSnbO14Kds8
    4aw3EByGWHwTa6Mr_zWdd27zzSLTSe65EP08CJDiELTG31Ae7So>
X-ME-Received: <xmr:Q8tZau8ZV3-HBAzwEZVGY_PijPRiEkSsYc2_neKvEmhiiBOTfLem8grJqJEkQ8uvUVVZyWfvCHhlTi6t4fzOGocAwacd-8rw-0Z4ErGwVLY>
X-ME-Proxy-Cause: dmFkZTEIwOnnMsiIG7Ug4ADT75Wb9z/4DUo9UzjClcbZNjFN+vYuPWY9CxQ7whjAFZcnVU
    ie8Os46njz6y+q57WNy5v7++SB1qI8s3/J8dwKFUbvjbQgyg2gnsheCj+njj9/CPeMm50L
    KORXi6JXnWJGwb9iqw3f8LQSy4sLEaGuGnmo8kQ0QLy7a4wZj3q6n2HzbrWq1iXmH5dpWn
    Fs6UD0rhH0PlNUAXhaQ8gbJcgV60RIL+qCcYBWF0M7bzuTd/LLWH0nVtlnB9uvKlKn1sJu
    9prtM27j3o8FoByNWsWhy5j0YSti1sjeiiyC9fm+XXpYaw6Y5Zu/TAsYyxgsG6IfkWmVZx
    hOPSS4yHGlkFx0S45TsfiZ3pFV9PIlgPPlWWYANeAGKdklROS11I9rPWCj9F0B2BcptNnQ
    dAXwnEGecG76HeNbyJITeQkX1pZFO01sApfyicCoq8oFAeZWBxqCyb1J/2F9MNfVe9XNAY
    z+eKgoUrMbT0tVLVBo1PAOXRQTM9feXjkrZcYKX+J0Wa5fWmjqhtv18HHbEU/nZpbXoaiq
    qlKAGw0RZEASbtoH8Wx5fNWsNf4vtOvgFE/2fuOMZi0wGf5LlHwwx8FetNPOTXzbGInjJD
    zQzCTnkQiLJKhkNxlUZRXjGwaJ3R655E7SU3XVjJwEAuXva6EZNIiVJG+w5Q
X-ME-Proxy: <xmx:Q8tZaoA0pIcySNoDz-avkjz3eZ0tv_k3m4ZyPL0w3cBy28-EIySSWw>
    <xmx:Q8tZarQpixTaD68rfxHGOwdExIUxlJjgvcZ1pbWiWZ3w9JpjeXDS5g>
    <xmx:Q8tZanuY2N-VlLStmkXB6CTrDl65cSdyVqSLcy392x8MyMFM4TNwoQ>
    <xmx:Q8tZav3kozEda76iDqpyWPSVWzgTb1wdPy8jOjs2IarcDkkDM9Etvw>
    <xmx:Q8tZap0JrPNmaSxHwrUROGysqzqEHCI0gE7ScW1w9iwJBj2YTRz9S-ZF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 02:27:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85a0029d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 06:27:12 +0000 (UTC)
Date: Fri, 17 Jul 2026 08:27:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Sahitya Chandra <sahityajb@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
	stolee@gmail.com, peff@peff.net
Subject: Re: [PATCH] wt-status: avoid quadratic insertion for untracked paths
Message-ID: <alnLPSnOt_Sf7cA5@pks.im>
References: <20260716185045.229320-1-sahityajb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716185045.229320-1-sahityajb@gmail.com>

On Fri, Jul 17, 2026 at 12:20:45AM +0530, Sahitya Chandra wrote:
> wt_status_collect_untracked() copies entries from dir.entries and
> dir.ignored into string_lists using string_list_insert(). That keeps the
> destination lists sorted and deduplicated, but each insertion may shift
> the backing array, making construction O(n^2) in the number of paths.
> 
> Collect the entries with string_list_append() instead, then sort and
> deduplicate each list once. This preserves the sorted, duplicate-free
> result while reducing the construction cost to O(n log n).
> 
> Signed-off-by: Sahitya Chandra <sahityajb@gmail.com>
> ---
> Notes for reviewers:
> 
> fill_directory() currently sorts dir.entries and dir.ignored
> before returning, so another possible approach would be to append the
> entries directly and rely on that order, reducing this copy step to O(n).
> That would require relying on these arrays not containing duplicate
> entries, though, which I have not been able to verify yet. This patch
> takes the safer approach of preserving the existing duplicate-removal
> behavior from `string_list_insert()` by sorting and deduplicating once
> after appending.

Out of curiosity: is this something that you have encountered in the
real world as inefficient, or is this rather a theoretical inefficiency?
If the former it would be great to add a small benchmark to the commit
message.

> diff --git a/wt-status.c b/wt-status.c
> index 58461e02f8..13a7cf7946 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -832,14 +832,18 @@ static void wt_status_collect_untracked(struct wt_status *s)
>  	for (i = 0; i < dir.nr; i++) {
>  		struct dir_entry *ent = dir.entries[i];
>  		if (index_name_is_other(istate, ent->name, ent->len))
> -			string_list_insert(&s->untracked, ent->name);
> +			string_list_append(&s->untracked, ent->name);
>  	}
> +	string_list_sort(&s->untracked);
> +	string_list_remove_duplicates(&s->untracked, 0);

Instead of sorting and then deduplicating you can call
`string_list_sort_u()`. It does the exact same thing as you do here, but
I guess it makes sense to use that interface anyway.

>  	for (i = 0; i < dir.ignored_nr; i++) {
>  		struct dir_entry *ent = dir.ignored[i];
>  		if (index_name_is_other(istate, ent->name, ent->len))
> -			string_list_insert(&s->ignored, ent->name);
> +			string_list_append(&s->ignored, ent->name);
>  	}
> +	string_list_sort(&s->ignored);
> +	string_list_remove_duplicates(&s->ignored, 0);

Likewise.

Overall this looks like a sensible thing to do though. Thanks!

Patrick
