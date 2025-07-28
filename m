Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87C56FB9
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753723199; cv=none; b=kNfatxBhbFCM5GIZ0DbtR0709zXuGoaPVZAWsW/wH4bSHiouFBD1zHL8sqpfJhWPEjoWa6RyWCo9fz0XMX67kBa9C+cgAjzBJFsSQ6y5ZettIyHfetIgDuANndJWGLjggNZxAMzDKJkxVIllGmEVnVgLBR6OsZi3q4rCdvHiZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753723199; c=relaxed/simple;
	bh=AlOLwRJBHKzgcovevWHt5hKuFkQPeiCjR48LfrO6Isg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PWvAgNwz0rpz0aaEyEumKA1R1WICw6zfqt8xtye+aW9edEy6vxfjZIz+XHwIfbCBb7TMhGFqo/V2AR0LjcmwqubLzuMN/3qD99ry9aa6PJiO7geKmUANUXFZIsOpNV8oyscBtxHPdBXT5EpQ/GADmgficWlg7UW8mwViHnKhuos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lk6QQWcP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RcTVSTUL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lk6QQWcP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RcTVSTUL"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF0F8140009C;
	Mon, 28 Jul 2025 13:19:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 28 Jul 2025 13:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753723195; x=1753809595; bh=TYVjAlsiuC
	tPaWPvBnJrYRriXxJitrmwiTRqfptgz2E=; b=Lk6QQWcPPwq2sT911ZjIzUlwf7
	ORbLHX2ih1pgKexgAxsD7d1sUX5pZZYSkXZfdvcYnNHkvYHbKp4pL1w77RBOihJN
	qUXdEzFUr+PXOFq+oWvj7VpJNsCIu5BHmVSWXXCBzOtSFL6W5pEF8pHH7Z1x2S7T
	OwV089/I5RNbqwEy5dDa87ilbDr0tkcbKjMRe5IChcgksgNnJXjg7Itrx47GU07U
	z/y3xYSfjp3XF+YhVslldP0dZ2nz/KEj3RRl3oK5Xxni6uqbhrXEK6ESCCIHA70F
	iOg8ho/LoYy1dzxxabt1DRUyozVGh8N0KIw3QKV2dH0G5qcyO67i9LKFzfjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753723195; x=1753809595; bh=TYVjAlsiuCtPaWPvBnJrYRriXxJitrmwiTR
	qfptgz2E=; b=RcTVSTULDpt38o9BVdqgATyoDr9DenmxYYqe7u1C+eOUwF0rv8V
	MvmOvu/soKAUr5jkZeBThZGvb1n86SucOmFFK+F+hQc+MWiE7soCNT/orMH2UW8L
	tpvRM5KHWprwCyhMvG+q58pHrhNGu+9lvRZjWnAiGKItKWzGgpYy1ZU7Ke6LijLs
	gWH50VxjxQ6RCZfhOAzJReF5mfxFXWtMERaxGAPmM41LQ4inQbFQDkcbp3mObovt
	aKRA3IKLD98tIxxxAJ/I0UGDY0zULkmpCs198/VOHEXEhQQEHDEuMy0otTl7N37S
	aGW1ptjBAtx1BpVodc4isdvmUKuPXVuatzw==
X-ME-Sender: <xms:O7GHaJy9BonUhtfYd7ooa1BpSKTXTfqvobxxHDyvG3kwuLI0r03H7w>
    <xme:O7GHaEx2Gx26eKNx1TlDLZAmL815XU5lqm_P67WI9kxOnqw6VzCHf_MG2JHe56qBq
    IwbJyLh1UZWhhqy5A>
X-ME-Received: <xmr:O7GHaJzQqowUqgvmm8kqgrKYE8NCxCNczeJB3umU1y7-QRl7wMc2xDOprtFgky3vZy2DDJOBkBT0G21pizBUf40DIKQDmETr-l-LvSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:O7GHaGa3DCk38fcwztlp1yq727GvtltffikJuPlnAgtqV8xlTUZ5jA>
    <xmx:O7GHaCUUNHELx1Y80uwHqoGhwAR479GGjURvfh61hrYI37cCXepY0Q>
    <xmx:O7GHaMgZm_v8HziiSWo-6AkuBz5SonezNqzAxhJSzfMJPMuh5ihWFQ>
    <xmx:O7GHaIvrBKaO6uqqR0GRJbtxjB1rpSTI9BKTivIin294DD65m6y5EQ>
    <xmx:O7GHaJMyFH3zqXUInO31QwkRyE37qfVGJDEdf2Pz-fKAHc9DvXVVJnQR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 13:19:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Han Jiang
 <jhcarl0814@gmail.com>
Subject: Re: [PATCH 3/4] builtin/remote: rework how remote refs get renamed
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-3-f654f2b5c5ae@pks.im>
	(Patrick Steinhardt's message of "Mon, 28 Jul 2025 15:08:47 +0200")
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
	<20250728-pks-remote-rename-improvements-v1-3-f654f2b5c5ae@pks.im>
Date: Mon, 28 Jul 2025 10:19:53 -0700
Message-ID: <xmqqbjp4w7uu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> But more importantly it is also extremely inperformant. The number of

Is "inperformant" a real word?  "it performs extremely poorly"?

> +static void renamed_refname(struct rename_info *rename,
> +			    const char *refname,
> +			    struct strbuf *out)
> +{
> +	strbuf_reset(out);
> +	strbuf_addstr(out, refname);
> +	strbuf_splice(out, strlen("refs/remotes/"), strlen(rename->old_name),
> +		      rename->new_name, strlen(rename->new_name));
> +}
> +

The function name felt somewhat iffy (sounded as if you are letting
a third-party know that you have renamed a ref), but I cannot come
up with a better alternative X-<.

> +static int rename_one_reflog_entry(const char *old_refname UNUSED,
> +				   struct object_id *old_oid,
> +				   struct object_id *new_oid,
> +				   const char *committer,
> +				   timestamp_t timestamp, int tz,
> +				   const char *msg, void *cb_data)
>  {
>  	struct rename_info *rename = cb_data;

Using a name of a system call for an unrelated variable, even if a
local one in a function scope, makes me nauseous.  Not a new problem
introduced by this change, though.

> +	struct strbuf *identity = rename->buf1;
> +	struct strbuf *name = rename->buf2;
> +	struct strbuf *mail = rename->buf3;
> +	struct ident_split ident;
> +	const char *date;
> +	int error;
> +
> +	if (split_ident_line(&ident, committer, strlen(committer)) < 0)
> +		return -1;
> +
> +	strbuf_reset(name);
> +	strbuf_add(name, ident.name_begin, ident.name_end - ident.name_begin);
> +	strbuf_reset(mail);
> +	strbuf_add(mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
> +
> +	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
> +	strbuf_reset(identity);
> +	strbuf_addstr(identity, fmt_ident(name->buf, mail->buf,
> +					  WANT_BLANK_IDENT, date, 0));

It is somewhat unfortunate that we need to do all of the above only
so that we can recreate the full ident with the given committer with
a timestamp that is given separately.  This probably cannot be helped,
though.  The backend may not be keeping this information as a single
string anyway.

> +static int rename_one_reflog(const char *old_refname,
> +			     const struct object_id *old_oid,
> +			     struct rename_info *rename)
> +{
> +	struct strbuf *message = rename->buf1;

As these temporary strbuf's passed around as part of the rename_info
structure are never released or recreated during the run, this is
safe, but feels dirty, because we saw rename_one_reflog_entry() uses
this exact one for totally different purpose.  Perhaps it would make
it easier to follow if you left "message" uninitialized here, before
refs_for_each_reflog_ent() returns.  And then ...

> +	int error;
> +
> +	if (!refs_reflog_exists(get_main_ref_store(the_repository), old_refname))
> +		return 0;
> +
> +	error = refs_for_each_reflog_ent(get_main_ref_store(the_repository),
> +					 old_refname, rename_one_reflog_entry, rename);
> +	if (error < 0)
> +		return error;
> +
> +	/*
> +	 * Manually write the reflog entry for the now-renamed ref. We cannot
> +	 * rely on `rename_one_ref()` to do this for us as that would screw
> +	 * over order in which reflog entries are being written.
> +	 *
> +	 * Furthermore, we only append the entry in case the reference
> +	 * resolves. Missing references shouldn't have reflogs anyway.
> +	 */

... give the "message" synonym to rename->buf1 here.

> +	strbuf_reset(message);
> +	strbuf_addf(message, "remote: renamed %s to %s", old_refname,
> +		    rename->new_refname->buf);
> +
> +	error = ref_transaction_update_reflog(rename->tx_create, rename->new_refname->buf,
> +					      old_oid, old_oid, git_committer_info(0),
> +					      message->buf, rename->index++, rename->err);
> +	if (error < 0)
> +		return error;
> +
> +	return error;
> +}

> +static int rename_one_ref(const char *old_refname, const char *referent,
> +			  const struct object_id *oid,
> +			  int flags, void *cb_data)
> +{
> +	struct rename_info *rename = cb_data;
> +	struct strbuf *new_referent = rename->buf1;
> +	const char *ptr = old_refname;
> +	int error;
> +
> +	if (!skip_prefix(ptr, "refs/remotes/", &ptr) ||
> +	    !skip_prefix(ptr, rename->old_name, &ptr) ||
> +	    !skip_prefix(ptr, "/", &ptr)) {
> +		error = 0;
> +		goto out;
>  	}
> -	strbuf_release(&buf);
>  
> -	return 0;
> +	renamed_refname(rename, old_refname, rename->new_refname);
> +
> +	if (flags & REF_ISSYMREF) {
> +		/*
> +		 * Stupidly enough `referent` is not pointing to the immediate
> +		 * target of a symref, but it's the recursively resolved value.
> +		 * So symrefs pointing to symrefs would be misresolved, and
> +		 * unborn symrefs don't have any value for the `referent` at all.
> +		 */
> +		referent = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> +						   old_refname, RESOLVE_REF_NO_RECURSE,
> +						   NULL, NULL);
> +		renamed_refname(rename, referent, new_referent);
> +		oid = NULL;

Yuck, but this cannot be helped, I guess X-<.

> +	struct rename_info rename = {
> +		.buf1 = &buf,
> +		.buf2 = &buf2,
> +		.buf3 = &buf3,

These can be embedded in the struct, not left as three separate
strbuf instances whose addresses are known to this struct, no?  We'd
need to do strbuf_release() on them at the end anyway, so it would
not be a huge deal, though.

>  	strbuf_release(&buf);
>  	strbuf_release(&buf2);
>  	strbuf_release(&buf3);
> +	strbuf_release(&err);
>  	return result;
>  }
