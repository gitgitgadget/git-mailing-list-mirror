Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEB02F5479
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284554; cv=none; b=AMo5HA1BLvpfeLPlb6odshr1oAQ4WZEdsowNwfb70ugBZcPjjuLxMxGo83UaYI3c4/J3UOSsrnGzIyV7zNJN/uZ8Drzxw3tFaE+B8SsN5KKoVMm8oPqCbQidJsM9lIyRDcemJc8JnSaikl6ojj91jN9RwpraF71FNFTcbPH7dXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284554; c=relaxed/simple;
	bh=fuCghN7H+zL8Lh8NRRVu8l+KV9Dn/hDtZJzrKChUtrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XQwK7Qzukj1rXvE5EBXOw0RgU7XoVLBVe2RKyWd7xAALwa2sqvOS/lsx1Khvph6YAJDb+W2EEgoWyxVgSU6Idyg52LFCP5lCTlidOHw/VxEPCgugz8z4eqzOXMROqG2mZGedOZstR8VBFy78OXcr7Qp75vc6Gq7+FFLu81HhXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Arvyy8/4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JkhfQ4HX; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Arvyy8/4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JkhfQ4HX"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E8211EC1027;
	Wed, 23 Jul 2025 11:29:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 23 Jul 2025 11:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753284550; x=1753370950; bh=keFTjXeP3x
	MUjhd8lwDMkwiNXXg8xCWMXwfCTCYjQ1w=; b=Arvyy8/4i/AN85apzA7yMTiP7y
	8DbRhQ/Aq7GoKiXYhsAfY8+ovkwbet1EvUWwHKZbNaG8KWNjtA68zqUcl00wHVB1
	Ea6xF2Kzn2QhnT21vOnrdkfsTWqJu0gpl968pgdnXOdAF7a+/M8rxrWRLy3JW9wr
	KetCxdIP6HmoAfOJf0/vqEyAyHFKUT/NGsKaOI87lgtEa337r4BDxRGBmC9SLfaD
	TUTLEeWxSXQYBTcVbX/0hrq8nPigqTDqxk3YdXCtJMrbbnAuSSfGTwc5CKxK2dll
	lyj8WFZfg2kdpe6HVm+FvPsKTCX6FZ/sZLiS0wct0I7V1lyBz/9OeZ7tQedQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753284550; x=1753370950; bh=keFTjXeP3xMUjhd8lwDMkwiNXXg8xCWMXwf
	CTCYjQ1w=; b=JkhfQ4HXqk78ODjIfCRN1I/DYJX5G2GE0PXUW5FGYhkpTKMSv+n
	Ld/oEtVGv9Sh9g6FclNTbFiRigpwbiEsLpsvDNHwNGNeBr7aCttzxh5ufe/Ogyra
	YqucacXBRlca7UWl1Efrzu0gnBIoVwNgEIHPJZg6JRx18PNXO3bkpPgzUpavIK9E
	ExtDPFZXjgzUtW6O8mnUVqkVRyMWfD2QgHm4yIn5qDZicDRF5u6E731BKi0xy2OM
	qFciGPuM92gR/5RwKkxydg7uo3VgtlKhDerfuWRWhOObhCRDaKJNMiFBmBxSp4dH
	kXhnsbIKLCOKJFkqZJm6F3BqItU3Is32gvg==
X-ME-Sender: <xms:xv-AaB_lJB_sRx2QgWVOXejnsUsSkcvxodT-AoZXCwP72wCf8SPTsg>
    <xme:xv-AaAR2DfGa6TIReQFtFYkoXxK9D061-0R8q2aP-nKv5OPPdvRI6vDRIEFuML2Hq
    P0tQOXxtAlxi_8_Wg>
X-ME-Received: <xmr:xv-AaLnlktfQ2LgR5L_a7DOCjXYamjK4wHSmlfbVDb_QWuNYhPg9fWdNYSQBOQ1W8-cujOI5xlAE0Pr60z5cyZ7B5PImZRGyVul6qsI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:xv-AaIQ7vaV9K_wOlXBSg_8gw6n2mDtwQjAO78QG5R-ZM3oyDcGS6A>
    <xmx:xv-AaBM9UTna8IM2bcJJZri0EIBPRkr3AJON3RIIa5PBjj3kKMapuA>
    <xmx:xv-AaJUm5bM97qjISGgRXQcbaLLhS9p3jbsNKMpEYjElZLhJYowK6w>
    <xmx:xv-AaAcyxFu7CSgo97FHMDsqabdXe5L_Mr7zSUCsx2ry3bQmbKLx6A>
    <xmx:xv-AaMMU_Bza7nf4lixMSYwrHA9PdOXpNd_79OqUgj3UHe7_6BA6CSNA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 11:29:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 21/21] config: fix sign comparison warnings
In-Reply-To: <20250723-pks-config-wo-the-repository-v2-21-1502d60d3867@pks.im>
	(Patrick Steinhardt's message of "Wed, 23 Jul 2025 16:08:42 +0200")
References: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
	<20250723-pks-config-wo-the-repository-v2-21-1502d60d3867@pks.im>
Date: Wed, 23 Jul 2025 08:29:09 -0700
Message-ID: <xmqqfrenori2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>  static int prepare_include_condition_pattern(const struct key_value_info *kvi,
> -					     struct strbuf *pat)
> +					     struct strbuf *pat,
> +					     size_t *out)
>  {
>  	struct strbuf path = STRBUF_INIT;
>  	char *expanded;
> -	int prefix = 0;
> +	size_t prefix = 0;
>  
>  	expanded = interpolate_path(pat->buf, 1);
>  	if (expanded) {
> @@ -229,8 +228,10 @@ static int prepare_include_condition_pattern(const struct key_value_info *kvi,
>  
>  	add_trailing_starstar_for_dir(pat);
>  
> +	*out = prefix;
> +
>  	strbuf_release(&path);
> -	return prefix;
> +	return 0;
>  }

OK, so unlike the previous attempt, this one uses an out parameter
to return the length of the prefix it counted, so the caller should
use its return value solely for noticing an error.

The first iteration would have given the caller (size_t)-1 and the
"ah, we got a non-zero prefix, let's see if it matches the string we
have" code that follows in the caller safely jumps to the "done"
label without doing any harm, so in that sense, the breakage there
was also merely theoretical ;-), but this certainly is more correct.

> @@ -239,7 +240,8 @@ static int include_by_gitdir(const struct key_value_info *kvi,
>  {
>  	struct strbuf text = STRBUF_INIT;
>  	struct strbuf pattern = STRBUF_INIT;
> -	int ret = 0, prefix;
> +	size_t prefix;
> +	int ret = 0;

And this is how the caller adjusts to the calling convention.

>  	const char *git_dir;
>  	int already_tried_absolute = 0;
>  
> @@ -250,12 +252,11 @@ static int include_by_gitdir(const struct key_value_info *kvi,
>  
>  	strbuf_realpath(&text, git_dir, 1);
>  	strbuf_add(&pattern, cond, cond_len);
> -	prefix = prepare_include_condition_pattern(kvi, &pattern);
> -
> -again:
> -	if (prefix < 0)
> +	ret = prepare_include_condition_pattern(kvi, &pattern, &prefix);
> +	if (ret < 0)
>  		goto done;

Same.  Negative return value is checked for early return upon an
error, and the value we received in prefix is used as before.

>  	if (env) {
>  		unsigned long count;
>  		char *endp;
> -		int i;
>  
>  		count = strtoul(env, &endp, 10);
>  		if (*endp) {
> @@ -736,10 +736,10 @@ int git_config_from_parameters(config_fn_t fn, void *data)
>  			goto out;
>  		}
>  
> -		for (i = 0; i < count; i++) {
> +		for (unsigned long i = 0; i < count; i++) {
>  			const char *key, *value;

Variable "i" of type ul looks confusing, but it is a counter to
count up to "cout" that is a result from strtoul(), so everything is
now consistent.  Good.

Not that we would seriously expect that we can export more than 2
billion environment variables sensibly, so this is all theoretical
exercise ;-)

> -			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
> +			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%lu", i);

Good.

> @@ -2470,10 +2470,11 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
>   */
>  static void maybe_remove_section(struct config_store_data *store,
>  				 size_t *begin_offset, size_t *end_offset,
> -				 int *seen_ptr)
> +				 unsigned *seen_ptr)
>  {
>  	size_t begin;
> -	int i, seen, section_seen = 0;
> +	int section_seen = 0;
> +	unsigned int i, seen;
>  
>  	/*
>  	 * First, ensure that this is the first key, and that there are no

The loop in the body of this function makes references to an array
with the index (i-1), but i counts downwards and never reaches 0, so
this should be OK.  The next hunk is a change that adjust the caller
to this change.

> @@ -2716,7 +2717,8 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
>  	} else {
>  		struct stat st;
>  		size_t copy_begin, copy_end;
> -		int i, new_line = 0;
> +		unsigned i;
> +		int new_line = 0;
>  		struct config_options opts;
>  
>  		if (!value_pattern)

Looks good.  Thanks.
