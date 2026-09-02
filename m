Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD8442B23
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344625; cv=none; b=jBlKYoANC2al5LC4PAaHf9Dzje/zUVn1xMkG8ZEjhfLi9xSldhZGt4SQ1jrGm/8gcZlurVCYwPRckAC0+PmNgMcG6X9MeeMgeyDbqhkorS4nnBJMjrJC0yNDY2CzFRayHaQNBI/Qtf1wlzffOCdJDO3URRXxAjzrkMFCElN0Fs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344625; c=relaxed/simple;
	bh=RNy59rte9/JtRLQ6H9o9jL8hR2KvxT9bUtuuDCmPDJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9S0jm0soGeRhQcBLLvaJUosQ4J34q22NXEPdHN9Figh4hOuFa+uh49co2Wod5tQF8UKNu7R42mJKEYOjcZj4/R2GfpjaJ+VMVGubJZcFtnX9wb8btqIDWIW4m81bF7TaHdnXA+AGJqkGi3n7mJ4Qnz6sMPGYCVo3/t+TEgeMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xt0zOkzS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aIxvI7xK; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xt0zOkzS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aIxvI7xK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8538A7A0126;
	Wed,  2 Sep 2026 06:23:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 02 Sep 2026 06:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788344616; x=1788431016; bh=LGKvVsiDMR
	UXEVs7MowLtqn4sVYG3eefIRY6MbowN5U=; b=Xt0zOkzSe9n+CGIM1EL77I0ooD
	rumO+sY7ofTaSySZcjsTPg9cN8aVPH4G9PYuRtfL9zeJo4dzDEhWZ2xcytXL3ZeY
	kcjiWENMkbY/TQZK2TK2Z0ghL4DG98A1lJyER4aYuJs1OgJ5KXo6/W3qKyttU/hC
	dVwnwW6TSP5+WJJd1aAlp15ZF0A/LS6V/JmD5bhU0+BulU2Mqusk7A8oxUKbk56D
	QuRAm7IQL/zl9Qvf97EzID3GyB+4Imv0pFSGhFHCYETfKgUjuoAWlJKp898ClnSu
	Qk16U7phY4Ob0RD2cx6jrHZ12Q0NH+ylBasd2iUjY2/q3wLK8NMWoYoEYEeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788344616; x=1788431016; bh=LGKvVsiDMRUXEVs7MowLtqn4sVYG3eefIRY
	6MbowN5U=; b=aIxvI7xKrIKI+UkvMNXPYuyvF/CujVVu4lREYdDb+yo25oe6CZ9
	qaOJ8pOf7KHFd5IbVa3YrR1WdR4PNbJlozOmeYxN3tHr7ocd7QTQvniWKZfeh1lY
	WovJBtVtYIxvoex8yAx5an9oyIWqTQZudRhDRJP5v0grWFRJb2B//A7cO7TjUxuA
	Zol7dbIXQQQIhZxZ5JvGRc3AyBpABBDyJQ+DTig5bblvs9qalfooRoBAu3EF0Zxt
	WY1naCA2JQ7e3+F6Og9CPGlnHrP96hZd8VDLawGSogikPljgOqpq5rcDXoHGRPgM
	meSkUUMtFU5hU1IRAjlDlGZsW4h1D0d7CWA==
X-ME-Sender: <xms:KPmXaumHHIjAQ4rider9GtCrue-OLZEAE2B0ngm-jptfnXFcK8kltw>
    <xme:KPmXar3ToMeTYFHdV6GRMcmlxMyhckWHxu8MUSwFzx57iWn1KYKaOb4JTFBIP53Mm
    ryVu4WoLdZH7Stx5U6JUWJiZ6olm4YLzS7BqwUKIZqbtYhHjfMRmQ>
X-ME-Received: <xmr:KPmXaqTrOspKa13y4udT_IAzIpKccU-Eqk35g7UID0v5liQ-vSeB9Y_iAHy4J9ucX6L7hJA>
X-ME-Proxy-Cause: dmFkZTGup8q8gfQDRZ4LdYwGzhPAg0x6OuHEZgo1ASqYouTxIZnZ2fx52YLmV8kF38WfCr
    Uzk7mfz6zwbhAd7/UEMGDDmM3Is4871/gXzTU8U44/h3akHh4xX1fTy9iT8LbYgU/8zRoj
    IqKZZKKTVhdUo2ddCPVnzD5UKq3zMp9Wn/YWTRy4UV43wnBfzVHZ9wO+QhHR2FX/F5NQ66
    lnvtxj/xoFeRoE1NT6m5gHjyOOmgvCFmSWNF95FX00vInizEwGINuAOpJvO9buOTN+NeHK
    S5lK3/M+kkEtfjjrfqN5I05Xu9GLYxV73PFabTR5XEzSxKZbXucDYz/Pa0mSafFRg5REKQ
    FtKmVrMHg84CEk+dJ16aCFFoX/SqE4iIdPqAKs2nDmTnBxvOx/OfO1MkrWbOHDLbiEF3T+
    PSv3aNIY+1JyXha/mrEuVg2wNUy+v7NMxv2H1AJHyLQlZzRd3V6pWWkCP1NapybS4oTZ2N
    5wHe6HLswSEQQcLKwX8CAKBfumXdgvtTQjftaY/OCtYjrESYIVMK07Bz4oWJFEhis7H4xf
    +r2YxhvLtU+BrLCqX71vR3aOWxunYujUarJSZqFe7ixH5R2gJGNNImeuNXeJh2OJCpJWMV
    1HNQqLJJS4gdRyUz4SKUSgZavwKdlZQMLfAG8VqTcpdS11BY30Tsoon95KEQ
X-ME-Proxy: <xmx:KPmXatv11aXX8YauAvDtkssdvxob9sn8W4w2K5LKQxWEtlVLsTU-Xg>
    <xmx:KPmXavbtplCp74zG2twP8tbOzKvWiicrtr179ScCmy5W6Y1hNZuUsA>
    <xmx:KPmXaitBPqELHJRlbFdc5kU-CyLG-gxzF4SJuSDcMCnVM2NnAU__hw>
    <xmx:KPmXahEUR8_DJmBx2VF8yYle9gydcI9KWtOKhJEhdVE7n-fcJb5Zug>
    <xmx:KPmXap--CCQmZeBq4iexklwlkmJpqie3vorKtx45ufUsMRaq4YApp7AZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 06:23:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b98e652e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 10:23:40 +0000 (UTC)
Date: Wed, 2 Sep 2026 12:23:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/12] cache-tree: remove dependency on `the_repository`
Message-ID: <apf5HjD7IHwStiS4@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
 <20260901-pks-odb-registering-in-memory-sources-v1-1-97a312d5fa25@pks.im>
 <xmqqzey0ljcv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzey0ljcv.fsf@gitster.g>

On Tue, Sep 01, 2026 at 03:03:44PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The "cache-tree" subsystem still depends on `the_repository`. Adapt it
> > to instead use repositories provided via the context, either as a new
> > parameter or the one passed in via `struct index_state`.
> >
> > Besides getting rid of `the_repository`, this also removes the last
> > dependency on registering submodule sources with the main object
> > database. When reading gitmodules from a submodule's index we implicitly
> > read that object via `the_repository`'s object database, which is of
> > course wrong. This works though because we would then register the
> > submodule's object database with the main object database, but a later
> > patch is going to get rid of that mechanism.
> 
> As "the_repository, " is quite a long string, many lines bust our
> usual ~70 column limit, but other than that the changes look quite
> straight-forward.
> 
> We probably should make the cache_tree_fully_valid() into file scope
> static.  Your new cache_tree_fully_valid() that takes the repository
> and a cache_tree, which will be file-scope static, will gain a new
> thin wrapper around it, i.e.,
> 
>     int has_valid_cache_tree(struct index_state *istate)
>     {
> 	return cache_tree_fully_valid(istate->repo, istate->cache_tree);
>     }
> 
> Migrate the callers outside cache_tree.c file to use it; outside the
> implementation, nobody has any business talking about a subdirectory
> of any cache-tree, or any cache-tree outside the context of the istate
> it belongs to.

Yeah, I think that's a good idea indeed. But instead of introducing a
new `has_valid_cache_tree()`, I think it makes more sense to just adapt
the current function and introduce `cache_tree_fully_valid_recursive()`
as internal function instead. That also matches the other existing
interfaces like `cache_tree_fully_valid()` better.

Thanks!

Patrick
