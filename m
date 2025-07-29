Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD33C285418
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778617; cv=none; b=b5rQQmQUbQuylF0Uxtm/jnrZ0gAu/wUItGGVfOa6AIPvw2vopH83REj/c1D2pIr5renmvso33KUKcTnA8h9bBpjmt4TeIb5BAkd2BfMX3sQZHRzENn3s/sW4Mm5SsYHfFk+yg75WAitLK2uGk87ThB77vhEsu+PQVyPo5BuULKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778617; c=relaxed/simple;
	bh=9hRL5czBEk+CMW3wSutIKZTlFT/cjmNk+RDGjN5G834=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvkbyLOLRY3+g2ifG+sKXb2FFRqvagGvr1RMO6+GkMmjvmmiun+xWTMcoaiOR5mMBbL2qluXLvAh54Ob2ID2rHl0vPDKGzxP20Mx8wV8ZrS85jd/YhYsXnMRtxcLD9L0j/IQjiPj+4FV6JMm0cW/vkJ1Lkotw4YgKPdvxR3nLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZxJGKncX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XWxxS4Xw; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZxJGKncX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XWxxS4Xw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E680C1D005AF;
	Tue, 29 Jul 2025 04:43:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 29 Jul 2025 04:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753778613; x=1753865013; bh=5D/JU+dzX9
	F1RNz8DzT/PXoIys1yxZaDY8BXg50+T98=; b=ZxJGKncX/MgsnoNoyVisfbna7P
	LaKGHdITFKNEk1KryIJG9A+5b0bxizeQIFJITHxuh5T1XYyHekreylKA9U8Vz1K/
	WpdkbyKIOEg19+4xMhtV9kHxChCIkipHyiAD8bD5ED1W68WjhibJXUcFtTqmM0bn
	D8gel5+kVLbYZjbhSqXxFnmbZhuhVRB4ccGK5C2G3jabIv0eJMPn3wZaKihLCxiX
	zdq/7VeFhrt85NHZB4qOUqM0aPS0I6Y6KG0R69SVEQXQkg2PP9XT6JPCVfSan54D
	mjY1xxdXq/le+kpYGzoaHeKZKPvs5qDqLLvHM1TCA2U20LzdG/sftrjRUkTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753778613; x=1753865013; bh=5D/JU+dzX9F1RNz8DzT/PXoIys1yxZaDY8B
	Xg50+T98=; b=XWxxS4XwmqJerZxD1d2jhfpZdw4JVovXdGXoQepC4xG8qqNq9HJ
	1+jO37+GHwzwjj7WCtvQtklS1scnXhgDVtWTxjmKYGEejnSWUxr7eHj8YhAQfiaL
	Q7x+bUYtCBpZ9vb6x0hhKHFu4+M7AlVr0KsTrKlZXAdM07xWvmZhow2Xh2sZnUAK
	1dId55op5h920TK7iPe6xYk3hrCYKglWDkZRp78UQzYDuVvtfuLEzae+QLDgcVvh
	rxLHFmOZtbNXoKq9dRGNALRI05EV8tMPwm1zdc3kd+C4qWukVzB5cKp0QUC7/4nu
	/XZgayUHfnHehyVSrqZ3oL8fnJca97Qfdvg==
X-ME-Sender: <xms:tYmIaCxLlx-P1Gmj607pFLXG1GHArntcCdWrEXek8bex287GVtzr7Q>
    <xme:tYmIaI2XbkPam75d3xKEpPHt-Zhgp-KB_N3aHa3HKIu1BnVgLdQ3xhHGG4TNtEWg_
    ytOn_S6VD03zgsgIQ>
X-ME-Received: <xmr:tYmIaA5DW-eYprWBEkCEpodtz4aRDNNq34xm6LUk-f2dxZ2-Nuc-CnF1Ga9QpD6UtrWQjXUqczHPsn3MM6aFy5pBRtCzcb3ewDWAJkH6K2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehjhhgtrghrlhdtkedugeesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:tYmIaLVWQyI_oVp5fQl-2b5wqdGzqa-4Hv02unFu_5pEp9HcKuS8Ow>
    <xmx:tYmIaPDWBErFg6_q2AK3WtcD0hgRurMynvLUcOMprbMx9TYstZqVdw>
    <xmx:tYmIaK43VqpeqAw7ATtTEkJDatki_zlg1hKvXFE81oqC7fwjM5E-Jw>
    <xmx:tYmIaKzvUFBRFf-nbp1vkZCyH-MZeNrufpI1IX22QDtF3OQhaIYLlw>
    <xmx:tYmIaPAFYgPZco7Muh411OQWnTjDEQbTfnmegr-O-6XEacIu3USLo_1u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 04:43:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ce31e11 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 08:43:32 +0000 (UTC)
Date: Tue, 29 Jul 2025 10:43:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Han Jiang <jhcarl0814@gmail.com>
Subject: Re: [PATCH 3/4] builtin/remote: rework how remote refs get renamed
Message-ID: <aIiJsdPrGrhZYis5@pks.im>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
 <20250728-pks-remote-rename-improvements-v1-3-f654f2b5c5ae@pks.im>
 <xmqqbjp4w7uu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjp4w7uu.fsf@gitster.g>

On Mon, Jul 28, 2025 at 10:19:53AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > But more importantly it is also extremely inperformant. The number of
> 
> Is "inperformant" a real word?  "it performs extremely poorly"?

Well, in my head it is :) But it doesn't seem to exist anywhere else, so
I'll reword this.

> > +static void renamed_refname(struct rename_info *rename,
> > +			    const char *refname,
> > +			    struct strbuf *out)
> > +{
> > +	strbuf_reset(out);
> > +	strbuf_addstr(out, refname);
> > +	strbuf_splice(out, strlen("refs/remotes/"), strlen(rename->old_name),
> > +		      rename->new_name, strlen(rename->new_name));
> > +}
> > +
> 
> The function name felt somewhat iffy (sounded as if you are letting
> a third-party know that you have renamed a ref), but I cannot come
> up with a better alternative X-<.

We could name it `compute_renamed_refname()` to make it a bit more
verb-y.

> > +static int rename_one_reflog_entry(const char *old_refname UNUSED,
> > +				   struct object_id *old_oid,
> > +				   struct object_id *new_oid,
> > +				   const char *committer,
> > +				   timestamp_t timestamp, int tz,
> > +				   const char *msg, void *cb_data)
> >  {
> >  	struct rename_info *rename = cb_data;
> 
> Using a name of a system call for an unrelated variable, even if a
> local one in a function scope, makes me nauseous.  Not a new problem
> introduced by this change, though.

Yeah, I don't love it, either.

> > +static int rename_one_reflog(const char *old_refname,
> > +			     const struct object_id *old_oid,
> > +			     struct rename_info *rename)
> > +{
> > +	struct strbuf *message = rename->buf1;
> 
> As these temporary strbuf's passed around as part of the rename_info
> structure are never released or recreated during the run, this is
> safe, but feels dirty, because we saw rename_one_reflog_entry() uses
> this exact one for totally different purpose.  Perhaps it would make
> it easier to follow if you left "message" uninitialized here, before
> refs_for_each_reflog_ent() returns.  And then ...
> 
> > +	int error;
> > +
> > +	if (!refs_reflog_exists(get_main_ref_store(the_repository), old_refname))
> > +		return 0;
> > +
> > +	error = refs_for_each_reflog_ent(get_main_ref_store(the_repository),
> > +					 old_refname, rename_one_reflog_entry, rename);
> > +	if (error < 0)
> > +		return error;
> > +
> > +	/*
> > +	 * Manually write the reflog entry for the now-renamed ref. We cannot
> > +	 * rely on `rename_one_ref()` to do this for us as that would screw
> > +	 * over order in which reflog entries are being written.
> > +	 *
> > +	 * Furthermore, we only append the entry in case the reference
> > +	 * resolves. Missing references shouldn't have reflogs anyway.
> > +	 */
> 
> ... give the "message" synonym to rename->buf1 here.

I was quite on the edge whether these buffers are really worth it in the
first place as an optimization -- I mostly adopted it from the migration
code. But I've benchmarked it now and couldn't really make out much of a
difference at all. So let's just drop all of this buffer reusing infra.

> > +static int rename_one_ref(const char *old_refname, const char *referent,
> > +			  const struct object_id *oid,
> > +			  int flags, void *cb_data)
> > +{
> > +	struct rename_info *rename = cb_data;
> > +	struct strbuf *new_referent = rename->buf1;
> > +	const char *ptr = old_refname;
> > +	int error;
> > +
> > +	if (!skip_prefix(ptr, "refs/remotes/", &ptr) ||
> > +	    !skip_prefix(ptr, rename->old_name, &ptr) ||
> > +	    !skip_prefix(ptr, "/", &ptr)) {
> > +		error = 0;
> > +		goto out;
> >  	}
> > -	strbuf_release(&buf);
> >  
> > -	return 0;
> > +	renamed_refname(rename, old_refname, rename->new_refname);
> > +
> > +	if (flags & REF_ISSYMREF) {
> > +		/*
> > +		 * Stupidly enough `referent` is not pointing to the immediate
> > +		 * target of a symref, but it's the recursively resolved value.
> > +		 * So symrefs pointing to symrefs would be misresolved, and
> > +		 * unborn symrefs don't have any value for the `referent` at all.
> > +		 */
> > +		referent = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> > +						   old_refname, RESOLVE_REF_NO_RECURSE,
> > +						   NULL, NULL);
> > +		renamed_refname(rename, referent, new_referent);
> > +		oid = NULL;
> 
> Yuck, but this cannot be helped, I guess X-<.

I dunno. I feel like this is something we should eventually fix.
Currently this is misleading and basically useless.

#leftoverbits

Patrick
