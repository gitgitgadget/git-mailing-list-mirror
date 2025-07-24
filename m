Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74291F3B83
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382323; cv=none; b=TLpxgx7m7OvPhZHKIhmULgnPJGe3MJsQX87yH9cKgKOqYAmI9dCrXeyv4rqKuhEkzMh+xht2TUQd00PwfmQosFVUXVZiLsW3vyP6ZQAA+tTSQKWcOVfmNwOsY1QHeQ50VBHvY9g/crqys4fktN+57WdrMQhQof+JKZead+mdEYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382323; c=relaxed/simple;
	bh=vft1T02vHnWf7Nx3Ng6tTo6QvupJ04YOej81TP6Lpoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ggIU6TYXSt1OCCGnaaMkIBGRgRh5LndK9FyOuQY25yPbSgfuMJnuiGEF6aOGcZtnqelD2UkJQcK0ZlmL8IC2UROtMze7YNkcx+mLJfvQ8++Mf/AuNKlDHXR8m1+gjWMHrJ8n0ESpg+Mh07ojPvWQYkYOyc10as9JSMXW96go7P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZO2nqrxr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T+xOA9eq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZO2nqrxr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T+xOA9eq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BE1C0EC00FA;
	Thu, 24 Jul 2025 14:38:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 24 Jul 2025 14:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753382317; x=1753468717; bh=aisyCxWVlJ
	aRNQnfMosX9juwXKVIQ4IC13xtFIUVevU=; b=ZO2nqrxrkCJvxf6UHV9+zFpBdX
	UJtJ50Th14XTQ75QsXVurYLgV1bkJqwVxG641OVDUaLNTvZRL0wfMmcd9aSLlHpf
	/2fy93+OPJWurP8F2QNSXwiZbRJ4Zxd9DrQWun6NPS65IGWwYswkUhcxArKTsKQn
	5ob/upW2GqQTKmFFhEFLaDev2FNdFinTmHbp8wttdXra0NjkkurILSz9MHGDCw84
	7InR83lffunjkxY2iFfvXtAc6HTxGdgMtBxObkbMm8ZNVyTIxb/cP9wjTNYAWh5h
	X2ofDjAaJawhTCoPOvHiDN8SHSi8ToxFha3+BiTCuL63jx6ysioIjD8z2eAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753382317; x=1753468717; bh=aisyCxWVlJaRNQnfMosX9juwXKVIQ4IC13x
	tFIUVevU=; b=T+xOA9eqbwXHHAO/PjTWYV8/dipXuOcQev3AQcsXsH37xV0JhM5
	zCKssUqFO2M4E3MZFs4uRGOT+rS/lVVBVH1Mp0zqxh6MY5zDV5iY9WMGSkLeLnDZ
	G+XPiuT3JdgQDjakULSrCs6Y++PIipQwmELOV3yU7Soieud4cxEfHdT8SsUl6QgQ
	fbfFBX4pppEPkUoD9/qIb8Ue+e0lCDKoj2UcOhGvx60JNlsGHywwMzZSfXChNwX5
	KtUjv5nPptNI2CEAOA7ZQtVVDiWQ5Ymh/lefx2Ubv36GKB/DyVxTDv/uKqIaoR8z
	sGnOZZ3I1hlUK8p6wi7dDrWOeS51SzaJk8Q==
X-ME-Sender: <xms:rX2CaCGFyMxoV5lAuad-znsMs3W6uaxBWQAXKbkfa9UhEsgSurSKhg>
    <xme:rX2CaO3nelRmdh0FnPtHe00v3bdbWlvzgP3zL4Yc2K1d8kIEiVGP2xjvReB6kitap
    nyeiYWjUbiAcPLOBA>
X-ME-Received: <xmr:rX2CaCnY0D5xla8_KJh5GOunVW1n-zEwbgvS1gbueAVpfgbi2O_U1fkU_L9M5b7nWEAVOz3-O2tQYwPrZJTIYmLkEKBtpZ7MjaetmGc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehjhhgtrghrlhdtkedugeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rX2CaG-cAmrzjHY1PIvRc8zqsHQLMsW87kX7D3wAq4X5GY_TLHz4IQ>
    <xmx:rX2CaPqu-PcsVo4S4s3WyJfeoNNre0xicAUGOjvTuEDzegQsnKInXQ>
    <xmx:rX2CaHlkyHJZXXKeybRIHwvzaWiQH-RZXp962ukAx67vdqy6-DwF1A>
    <xmx:rX2CaOi-lG6xYdd7H8-CuRq8pTb1MMh1jMnzrfX7qiuJuggiRrvjhg>
    <xmx:rX2CaPz844QiwquMCYHAsLrDbOqaWEuk5SFhbERVIxEfTVJ-lPnazKEN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 14:38:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Han Jiang <jhcarl0814@gmail.com>,  Git
 Mailing List <git@vger.kernel.org>
Subject: Re: `git remote rename` does not work when
 `refs/remotes/server/HEAD` is unborn (when right after `git remote add
 -m`)
In-Reply-To: <aIIvHxR8wXLTCgMW@pks.im> (Patrick Steinhardt's message of "Thu,
	24 Jul 2025 15:03:27 +0200")
References: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>
	<20250724104536.GA1316505@coredump.intra.peff.net>
	<aIIf7S5iPspktxdw@pks.im> <aIIvHxR8wXLTCgMW@pks.im>
Date: Thu, 24 Jul 2025 11:38:35 -0700
Message-ID: <xmqqbjp9h1sk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I've quickly hacked something together now, see the work-in-progress
> patch below. The patch does not yet handle reflogs, but that isn't too
> hard to implement.
>
> And these changes indeed speed up things by quite a lot: instead of
> hours it now takes 7 seconds :) I'll polish this patch series and will
> likely send it in tomorrow.

Nice.  Not just the "oops, we shouldn't assume symrefs always point
at an existing ref" fix, performance fix comes at the same time ;-)

> diff --git a/builtin/remote.c b/builtin/remote.c
> index 5dd6cbbaeed..072a70e6b45 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -612,36 +612,53 @@ static int add_branch_for_removal(const char *refname,
>  struct rename_info {
>  	const char *old_name;
>  	const char *new_name;
> -	struct string_list *remote_branches;
>  	uint32_t symrefs_nr;
> +	struct ref_transaction *transaction;
> +	struct strbuf *err;
>  };

OK, as a place to hook the transaction into, rename_info is a
convenient place, as it already is passed around throughout the
relevant code paths.

> -static int read_remote_branches(const char *refname, const char *referent UNUSED,
> -				const struct object_id *oid UNUSED,
> -				int flags UNUSED, void *cb_data)
> +static int queue_one_rename(const char *refname, const char *referent,
> +			    const struct object_id *oid,
> +			    int flags, void *cb_data)
>  {
> +	struct strbuf new_refname = STRBUF_INIT, new_referent = STRBUF_INIT;
>  	struct rename_info *rename = cb_data;
> -	struct strbuf buf = STRBUF_INIT;
> -	struct string_list_item *item;
> -	int flag;
> -	const char *symref;
> -
> -	strbuf_addf(&buf, "refs/remotes/%s/", rename->old_name);
> -	if (starts_with(refname, buf.buf)) {
> -		item = string_list_append(rename->remote_branches, refname);
> -		symref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> -						 refname, RESOLVE_REF_READING,
> -						 NULL, &flag);
> -		if (symref && (flag & REF_ISSYMREF)) {
> -			item->util = xstrdup(symref);
> -			rename->symrefs_nr++;
> -		} else {
> -			item->util = NULL;
> -		}
> +	int error;
> +
> +	strbuf_addf(&new_refname, "refs/remotes/%s/", rename->old_name);
> +	if (!starts_with(refname, new_refname.buf)) {
> +		error = 0;
> +		goto out;
>  	}
> -	strbuf_release(&buf);
>  
> -	return 0;
> +	if (flags & REF_ISSYMREF) {
> +		strbuf_addstr(&new_referent, referent);
> +		strbuf_splice(&new_referent, strlen("refs/remotes/"), strlen(rename->old_name),
> +			      rename->new_name, strlen(rename->new_name));
> +		oid = NULL;
> +	}
> +
> +	error = ref_transaction_delete(rename->transaction, refname,
> +				       oid, referent, REF_NO_DEREF, NULL, rename->err);

Remove old ...

> +	if (error < 0)
> +		goto out;
> +
> +	strbuf_reset(&new_refname);
> +	strbuf_addstr(&new_refname, refname);
> +	strbuf_splice(&new_refname, strlen("refs/remotes/"), strlen(rename->old_name),
> +		      rename->new_name, strlen(rename->new_name));
> +
> +	error = ref_transaction_update(rename->transaction, new_refname.buf, oid,
> +				       null_oid(the_hash_algo), (flags & REF_ISSYMREF) ? new_referent.buf : NULL, NULL,
> +				       REF_SKIP_CREATE_REFLOG | REF_NO_DEREF | REF_SKIP_OID_VERIFICATION,
> +				       NULL, rename->err);

... and create new.  Would we be hit with the same "while renaming A
to A/B, there is a D/F conflict which the ref transaction does not
handle by itself" issue we saw recently here?

> +	rename.transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
> +							 0, &err);
> +	if (!rename.transaction)
> +		goto out;
>  
> +	result = refs_for_each_rawref(get_main_ref_store(the_repository),
> +				      queue_one_rename, &rename);
> +	if (result < 0)
> +		die(_("renaming references failed: %s"), rename.err->buf);
>  
> +	result = ref_transaction_commit(rename.transaction, &err);
> +	if (result < 0)
> +		die(_("committing renamed references failed: %s"), rename.err->buf);
>  
>  	handle_push_default(rename.old_name, rename.new_name);
>  
>  out:
> -	string_list_clear(&remote_branches, 1);
> +	ref_transaction_free(rename.transaction);

Very nice.

>  	strbuf_release(&old_remote_context);
>  	strbuf_release(&buf);
>  	strbuf_release(&buf2);
> -	strbuf_release(&buf3);
> +	strbuf_release(&err);
>  	return result;
>  }
>  
