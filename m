Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4437333D6F8
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774337984; cv=none; b=sY3GPGeC+wgan1IFzksAKV20NJgICrJ9KQ8W2NRwn4OnLDuo+voLUyv6zr0iUzjiKqUp0JWo9BpfTpbWCY2mXIuDQgG5R9QjFVXutHRIGWD7QNEu3HKN/G79q6P8uKINsWk1WoFH8Cep/8/EY7Snzusri47OSuWqInAE3/TKNno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774337984; c=relaxed/simple;
	bh=rxfRyh9/8/5UYjRw0gDUgJdunAQVoJn6aREWuhwiwwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALJlMeyBJIwaxqClxviX6MGeRjK5bNHU/ejEllf+wCbfy2o8nJBUhKPjDqwIEX0cYH9nyp5O6OTVnUoPvZHGxOv10sqUgl9URjmFe5Om+L1URs0FppI0lTlpjyuHU6UnLYaBoS+eFErp/sWLt+7VO4B7zzSQFVGtJ2Q1Z6zH99s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oG7r8z/w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2csbvr6S; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oG7r8z/w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2csbvr6S"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2BA021400199;
	Tue, 24 Mar 2026 03:39:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 24 Mar 2026 03:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774337973; x=1774424373; bh=ZKthfveEUf
	EBIbnMR1ftrfSsbalUUvlC46QorcEGbzA=; b=oG7r8z/wgDJJB1PVGpoh4oZPiw
	bzPZFXyF+rzVlgVSgw8Vbb0oHEukl6aBVbAhh7EBpYeh2wKcTNYXUwZQowaeu1vR
	oAiqLDii9F2WlXZAlrIHFuI5/3N3rd4AymO9+yPMKg5SZcvxSDSBR9EmRoPf+k0A
	8yETa6TsiuQLxPH7FW7fHNxVrCyKJOalvnQKvp1HiBCrfIZzD8kcv1/QFRLrHj2h
	fndLQHruZCfb0S+h5aQ3SV6FIha5i0sFpE8ozGQiPOdenL3l1cCBCWeVrn/j13PF
	pofnFNpc9nhLP0cFw8FjuX5I8Lc4VDd6GgUnypjIiL4MniZcUtEkJMiNhUTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774337973; x=1774424373; bh=ZKthfveEUfEBIbnMR1ftrfSsbalUUvlC46Q
	orcEGbzA=; b=2csbvr6Sgbkkx4wYM/PpaBNWCIBY/nMay1EyF1HiYdKoJsiAOsm
	I2QzWpm55y4SdrEUUqknIans/sxvaNa9yX+gBFKBXU0pQOF1GDljcx3qw4nDih+Y
	UNAWwYvaAMRndrC0YRIuwPJYXeURh4m7v1Lwc/T0fB7ut7Dw/FNPKMbooic5NRwM
	4z2g0l/gc8YmrsQBAUfBkscK51BdwlMvQ6CLjk8fTIxjV2tidhWuZC4HdngmijPI
	+OB/PWCZbNNMJ0Xixxp5daiJpEWow3HWeylPci353GnX8a9NWk1WIi7XUEJQlOa1
	6Uq44M/HtHSWX5HFGaHpDihjprhXby2ghEw==
X-ME-Sender: <xms:tT_Caaqe2kO2Jw8BG6AGrs1CkW6WklV1Bs5Q-cAQC4gRiL_Ebba3ww>
    <xme:tT_CafgwhxrOG3DAF-KpHp4NtBbGV2u8xqnetKIUyJPu9s-tZcj2OxcKDejyOH3Hu
    qtmRyHrS0kQsJh1iBbxBLATi0_K9cWXfCGoanw8U-Dw9ake-sL7Uw>
X-ME-Received: <xmr:tT_CaXg8QZmGvyXos3E9DmO_epdfOET2dnxoMLzOycsXt-9Ws-2JfPBcBCAcpN22R8XNrl8lvqX6N4LtFUll8kTg-sj67u_SHMCVgoiGOEkgSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tT_CaVi5WzHRDryUKllUuw4yOwMf7ilg7CC9-Y5BLhhXuhQ6DInpIw>
    <xmx:tT_CaXK3yM4P4T-OyQN4I7yRq5QzWu01opzGTl92aP6cmjvPSM1Ulw>
    <xmx:tT_CaUHhWl2LdXJLQCJa1Sy8MkDI4_CJipE65buEcSlBuTz1wCx0Pw>
    <xmx:tT_CabSWN8LZqey4SHdx3jnvJcBdMB_FWMn1TqvEhHjXUtInMOw8QA>
    <xmx:tT_CaSA_9u4LEGrZKIDcwRKhNghjou-zwLKcz-MRURpUwommcuicKCLu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 03:39:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea06b9a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 07:39:31 +0000 (UTC)
Date: Tue, 24 Mar 2026 08:39:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/5] pack-objects: refactor
 `read_packs_list_from_stdin()` to use `strmap`
Message-ID: <acI_sP6ZEdw-xGpR@pks.im>
References: <cover.1773959041.git.me@ttaylorr.com>
 <ea6fdbcc46f608c3fbe65298e9ca91faf43a1b16.1773959041.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea6fdbcc46f608c3fbe65298e9ca91faf43a1b16.1773959041.git.me@ttaylorr.com>

On Thu, Mar 19, 2026 at 06:24:20PM -0400, Taylor Blau wrote:
> The '--stdin-packs' mode of pack-objects maintains two separate
> string_lists: one for included packs, and one for excluded packs. Each
> list stores the pack basename as a string and the corresponding
> `packed_git` pointer in its `->util` field.
> 
> This works, but makes it awkward to extend the set of pack "kinds" that
> pack-objects can accept via stdin, since each new kind would need its
> own string_list and duplicated handling. A future commit will want to do
> just this, so prepare for that change by handling the various "kinds" of
> packs specified over stdin in a more generic fashion.
> 
> Namely, replace the two `string_list`s with a single `strmap` keyed on
> the pack basename, with values pointing to a new `struct
> stdin_pack_info`. This struct tracks both the `packed_git` pointer and a
> `kind` bitfield indicating whether the pack was specified as included or
> excluded.

Okay.

> Extract the logic for sorting packs by mtime and adding their objects
> into a separate `stdin_packs_add_entries()` helper.

Right, the ordering was my first question. Interestingly though, that
function doesn't seem to be added in this commit... ah, it's called
`stdin_packs_add_pack_entries()`.

> While we could have used a `string_list`, we must handle the case where
> the same pack is specified more than once. With a `string_list` only, we
> would have to pay a quadratic cost to either (a) insert elements into
> their sorted positions, or (b) a repeated linear search, which is
> accidentally quadratic. For that reason, use a strmap instead.

We could of course just add them and deduplicate in a later step via
`string_list_sort_u()`. But I assume that you want to handle the case
where we have duplicates specially, either by merging the duplicate into
the existing pack info or by aborting.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 9a89bc5c4c9..72c9ddbed6b 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3837,90 +3838,120 @@ static int pack_mtime_cmp(const void *_a, const void *_b)
>  		return 0;
>  }
>  
> -static void read_packs_list_from_stdin(struct rev_info *revs)
> +struct stdin_pack_info {
> +	struct packed_git *p;
> +	enum {
> +		STDIN_PACK_INCLUDE = (1<<0),
> +		STDIN_PACK_EXCLUDE_CLOSED = (1<<1),

It might make sense to provide a sentence for each of the enums to
explain what they do.

> +	} kind;
> +};

Okay, this is the new structure that allows us to track the packfile
kind in a way that is more extensible. Makes sense.

> +static void stdin_packs_add_pack_entries(struct strmap *packs,
> +					 struct rev_info *revs)
> +{
> +	struct string_list keys = STRING_LIST_INIT_NODUP;
> +	struct string_list_item *item;
> +	struct hashmap_iter iter;
> +	struct strmap_entry *entry;
> +
> +	strmap_for_each_entry(packs, &iter, entry) {
> +		struct stdin_pack_info *info = entry->value;
> +		if (!info->p)
> +			die(_("could not find pack '%s'"), entry->key);
> +
> +		string_list_append(&keys, entry->key)->util = info->p;
> +	}
> +
> +	/*
> +	 * Order packs by ascending mtime; use QSORT directly to access the
> +	 * string_list_item's ->util pointer, which string_list_sort() does not
> +	 * provide.
> +	 */
> +	QSORT(keys.items, keys.nr, pack_mtime_cmp);

Okay. I was briefly wondering whether it would make more sense to use
`string_list_sort()`, but I guess it doesn't buy us much.

> +	for_each_string_list_item(item, &keys) {
> +		struct stdin_pack_info *info = strmap_get(packs, item->string);

We could avoid this extra lookup if you instead were to store the pack
info in the `item->util` field.

> +		if (!info->p)
> +			die(_("could not find pack '%s'"), item->string);

This case basically cannot happen as we already `die()` further up,
right? Should we rather `BUG()` or drop the check completely?

> +		if (info->kind & STDIN_PACK_INCLUDE)
> +			for_each_object_in_pack(info->p,
> +						add_object_entry_from_pack,
> +						revs,
> +						ODB_FOR_EACH_OBJECT_PACK_ORDER);
> +	}
> +
> +	string_list_clear(&keys, 0);
> +}
> +
> +static void stdin_packs_read_input(struct rev_info *revs)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	struct string_list include_packs = STRING_LIST_INIT_DUP;
> -	struct string_list exclude_packs = STRING_LIST_INIT_DUP;
> -	struct string_list_item *item = NULL;
> +	struct strmap packs = STRMAP_INIT;
>  	struct packed_git *p;
>  
>  	while (strbuf_getline(&buf, stdin) != EOF) {
> -		if (!buf.len)
> +		struct stdin_pack_info *info;
> +		const char *key = buf.buf;
> +
> +		if (!key || !*key)

The first case of `!key` cannot ever happen as strbufs always have `buf`
set.

>  			continue;
>  
> +		if (*key == '^')
> +			key++;
> +
> +		info = strmap_get(&packs, key);
> +		if (!info) {
> +			CALLOC_ARRAY(info, 1);
> +			strmap_put(&packs, key, info);
> +		}
> +
>  		if (*buf.buf == '^')
> -			string_list_append(&exclude_packs, buf.buf + 1);
> +			info->kind |= STDIN_PACK_EXCLUDE_CLOSED;
>  		else
> -			string_list_append(&include_packs, buf.buf);
> +			info->kind |= STDIN_PACK_INCLUDE;

I was briefly wondering whether we need error handling for the case
where a pack is marked both as excluded and included. But we didn't have
it beforehand, either.

>  		strbuf_reset(&buf);
>  	}
>  
> -	string_list_sort_u(&include_packs, 0);
> -	string_list_sort_u(&exclude_packs, 0);
> -
>  	repo_for_each_pack(the_repository, p) {
> -		const char *pack_name = pack_basename(p);
> +		struct stdin_pack_info *info;
>  
> -		if ((item = string_list_lookup(&include_packs, pack_name))) {
> +		info = strmap_get(&packs, pack_basename(p));
> +		if (!info)
> +			continue;
> +
> +		if (info->kind & STDIN_PACK_INCLUDE) {
>  			if (exclude_promisor_objects && p->pack_promisor)
>  				die(_("packfile %s is a promisor but --exclude-promisor-objects was given"), p->pack_name);
> -			item->util = p;
> +
> +			/*
> +			 * Arguments we got on stdin may not even be
> +			 * packs. First check that to avoid segfaulting
> +			 * later on in e.g.  pack_mtime_cmp(), excluded
> +			 * packs are handled below.
> +			 */
> +			if (!is_pack_valid(p))
> +				die(_("packfile %s cannot be accessed"), p->pack_name);

Hm. Doesn't this change behaviour though? Beforehand, we would have
checked the packfile for every included pack. Now we only check the
packfile for every included pack that was yielded by
`repo_for_each_pack()`. So if an included pack wasn't yielded at all we
wouldn't notice that it doesn't exist?

I guess an easy fix would be to mark every pack that we have processed
as seen in the pack info, and then loop over all pack infos a second
time to verify that we've seen all that we expected to see.

Which you in fact already do :) That post-processing happens in
`stdin_packs_add_pack_entries()`, where you verify that the `p` pointer
is set as expected. And if it's not we die with a message that the pack
wasn't found. Good.

This was a bit more demanding to review, but I very much like the
outcome of this.

Patrick
