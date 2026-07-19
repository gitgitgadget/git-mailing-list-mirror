Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0873175A72
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784430144; cv=none; b=gnqGTRjbwAUNMKG/ZlMt9jqGet3etZLJSqAi1BQZzw8GO26h99RKkb4xQW3ZQOzKWImqTFD8n29/rdJ0eiL+2AfOPr/jMz6XfDjh4lGY6hgGvwgTcwEkC1YYT5UhD/DAT5oSYPOvVZzuh+2Q/NOftJtIRwB0ihBCFAt4tUoqadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784430144; c=relaxed/simple;
	bh=6tazwGHUCrQcWgqR9JI6bz9QiBGJB+YiNOWCAgjb2Vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u/5bbPSBA4+/uIpqgfq7DJhh9KBn9AkWp/wya2GOAl7v2XffJEd8vty6TRBcI08crrslwTb/XgF+tKtsXVXIQc7extc/h+Da95bh6+jC8NmsEt1ovUfQs00p3hD3qGRqUV+WAIra/+Deov1OWOVYEYtXOit8D/N943kOU+A3yfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AkPQ5nRJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hGCxc7ZN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AkPQ5nRJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hGCxc7ZN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF8DB14000FF;
	Sat, 18 Jul 2026 23:02:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 18 Jul 2026 23:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784430141; x=1784516541; bh=xHd87i/xrB
	2u5Cy6GBjVpFBIYX3HemlHLHL5HM17Q9M=; b=AkPQ5nRJZ1rNqWEXA2kxfkTAfm
	82QSgQ23ZnAEGRQvBpq782ElkgZUGTjQBvZHVOLqif7tFvKyJkqJUl9FTUvXLYNS
	06wbmUeBbGVzaVQDB3XtjHEY7EctpKNxA4hCB+TqXEXTVDu45+qvej0nv2/nZM3h
	VYR9dQT7S2aDvZCNbe5OkwrJy0E/BTyKm1DA5/j7UToNGKzKa1pJv5w7T2IAoBea
	vni/+4YqzOtqHRz38tSG/Ekqn+UYXFzj07CyyyP85kspaI1zyMTD7v6AzrQjpAa3
	kJpvv4cf+T7+YhgL+jHoJ58SjinibrIO2WH6DR8wbsH3dXD+LOr/zUiaf5Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784430141; x=1784516541; bh=xHd87i/xrB2u5Cy6GBjVpFBIYX3HemlHLHL
	5HM17Q9M=; b=hGCxc7ZNQXtBYPBXVW+2Lgz4238S/h+U/t7KiP2gGRM6pyd8P8e
	zKQ5kjJ6EhR/PfHuWNhcUBmJ81YHOSgJFffh+DN5G7pB0+fyiyv6xRjgtTwlTd47
	NAFXEhyJ+OLQZPudPDOggYYSVyjzPwiDCXBQ7JY9WpeHbTwxylt47o8kvZtHCffu
	PYtI6Btn7vdtFdXINnDcMFozNm5vQXuNLrrq5D0pE7GFyfO4h+7ej6wUnDA63qmR
	ev7i/0Qdfzk6+j8Rd7C0f0b5x3FGkRl+V3YTO1plXxIxoEH66YZCXXmV+ODslsIh
	/MgjZdEVz3+8VyUuglSHT1Pax5C0CwOGD5g==
X-ME-Sender: <xms:PT5capbatvPK0xfp-SCbjxp6cTtuYv6jnCLADpu_KqIhNxGXAYpyWw>
    <xme:PT5cairaU6KfWqcdninOXWXjpgG_m9WGukCLh5aZwMo1aUjW8twmGAC0Ntsa744h_
    c1iTQgM0ZDeW8u88JSkbuOOFZtpVXRZRcrS-omYwzUgoTMDI1clPQ>
X-ME-Received: <xmr:PT5cauN7semWUOSFStyhyukcwlowwOgEAINGTmCXfamxEjA2nLyjdtaMag6InswrJsbobqEZA0QQH6UvP2kqAfSFn26LWOdgOg>
X-ME-Proxy-Cause: dmFkZTFzsozSdL5pC9eY+aENKDepe7rQzfIlQSDR74kRFXrOlh4Nf/xhZ1K5VcMJsiNtVz
    CS4KTvpnLgxhKv8wphdHcIc1jXP/IohBCwdypFRMfIFguQolr+HW81mmMgAzI4PjGbVClt
    RVBUjx+9nzKTQxUPrM9Zj8Pd9wzav5f3Z04S6guA2XY5dtriYV+kuCBNzU5dnPFDl0vCAk
    swmOzus8z0SyPZ+oPWNBpySw8KYcUx0uME1F0qyo3lTAUZbiPubhJFKMBNqmbGbZHZ61X1
    Dry4q3AHLTxNyTqjRu39iUC7YFkAGw0I24xwjwqIRshUouaGaGccwtyKy4gwmivucDP1j5
    eRlU9lTvD1HVQPqs/yUTqd34q+QmQDVeCN9b7qMTxYMqGP/cV2ff+UjdGo/uQ3Ilu23zYw
    uaijkru6VVaBHZXo710DcIS/5XmtHb2s49vrtl8qzwcOGeizXfbHDEfFajbLjfFyawEBKW
    WLn5FI/5YzISUOsqCX0aSNGQo03vlMPJ5zAxqhN9ABdzskDLYnTgLPZdrgwfgVBsb9i+Q4
    baFeYsTRZVKETLN4YQHUr1bRJ2JbJjqRO1rCUdg9GBjXlKeh7PsV0+RYKiag+QI94nPLCd
    UgFuqR/W3UVi/LWby+E+1QjS7OxCIk7eD7lGnbYtvuap3BIPDvHDxAKd+20A
X-ME-Proxy: <xmx:PT5catof05OyG2lOnqKqfV2OZ3SmMf93b1nFTotlrflmLgmZsV1RgQ>
    <xmx:PT5cajdAL1DDGFNUYX95qNAYECTksv-6NwgVn1l2kfXa8k7eQIwu8Q>
    <xmx:PT5cajQh0c71bvjPNvs0-pilbade4Qn-QX96-2-2dI2vInYhKZUZnw>
    <xmx:PT5casY2qhoAIKdVbqmDvE_fqjYuJf4s1sDQOtGUjZuTfvSWNdv4Ig>
    <xmx:PT5calVd8pH5uqJbzQevJOAwzY9mAPR3YKh5c6a4fcY8Apdq2sUa9_z9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jul 2026 23:02:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v19 5/7] branch: add --delete-merged <branch>
In-Reply-To: <a6caa5b397da8ea24eb97e6aa6dc92b437e456ef.1784053493.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 14 Jul 2026
	18:24:51 +0000")
References: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
	<pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
	<a6caa5b397da8ea24eb97e6aa6dc92b437e456ef.1784053493.git.gitgitgadget@gmail.com>
Date: Sat, 18 Jul 2026 20:02:19 -0700
Message-ID: <xmqqtspvptqc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +struct spare_data {
> +	struct strset *deletable;
> +	struct strset *spared;
> +};
> +
> +/*
> + * A surviving branch stacked on a deletion candidate would lose its
> + * upstream, so drop that candidate from the delete set and remember it
> + * in "spared" so its own upstream can be tidied up afterwards.
> + */
> +static int spare_stacked_base(const struct reference *ref, void *cb_data)
> +{
> +	struct spare_data *data = cb_data;
> +	struct branch *branch;
> +	const char *upstream, *up_short;
> +
> +	if (strset_contains(data->deletable, ref->name))
> +		return 0;
> +	branch = branch_get(ref->name);
> +	upstream = branch_get_upstream(branch, NULL);
> +	if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
> +	    !strset_contains(data->deletable, up_short))
> +		return 0;
> +
> +	strset_remove(data->deletable, up_short);
> +	strset_add(data->spared, up_short);
> +	return 0;
> +}
> +
> +/*
> + * Keep any branch that a surviving branch tracks as its upstream, so we
> + * never delete a branch out from under one stacked on top of it.  Such a
> + * base is itself merged, so when its own upstream is also going away
> + * (no surviving branch tracks it), clear the base's now-stale upstream.
> + */
> +static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
> +{
> +	struct strset spared = STRSET_INIT;
> +	struct spare_data data = { .deletable = deletable, .spared = &spared };
> +	struct strbuf key = STRBUF_INIT;
> +	struct hashmap_iter iter;
> +	struct strmap_entry *entry;
> +
> +	refs_for_each_branch_ref(refs, spare_stacked_base, &data);

Hmph.  Wouldn't this implicitly make whether a stacked branch is
spared or has its upstream configuration cleared depends on the
order in which the branches are visited by the callback function of
refs_for_each_branch_ref(), which presumably is alphabetical?

For example, if 'a_tip' (unmerged) tracks 'b_mid' (merged), which in
turn tracks 'c_lower' (merged), visiting them in alphabetical order
('a_tip', 'b_mid', 'c_lower') would spare both 'b_mid' and
'c_lower'.  If they, however, were named 'tip' (unmerged), which
tracks 'mid' (merged), which in turn tracks 'lower' (merged), they
would be visited in the order 'lower', 'mid', 'tip'.  This would
result in 'lower' being deleted and 'mid' being spared with its
upstream configuration cleared, even though the relationship among
these three branches is exactly the same.

Since the branches are visited in a fixed alphabetical order, it
might not be an unpredictable order that yields unrepeatable
results.  Nonetheless, the behavior should be consistent and
independent of branch names, as long as the inter-relationship
among the branches involved is identical, no?

Or am I grossly misreading the code?

Thanks.
