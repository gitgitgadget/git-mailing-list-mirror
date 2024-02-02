Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1D917C91
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862652; cv=none; b=Cawi/ZTHERQY5GElDAVnBBzsO3DjCyQABfLIB/0gz1gXH5J/nyiqunVoV+yxxOkbwsoSOtRjQDOFB46Q9bJNmH9LYXa5kEtnNp+uJaY5gqPcd3NiT7qOYb4wwVxhbOqgcQcVeAWz9p8NzNXpP8Fir5jN4IFi6pdkrgAEowjGTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862652; c=relaxed/simple;
	bh=m1c7OVeZ0pEVmjwTntgW1VXziuEPIe1dYiNAM5UPxkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV4tIQ2psXAGTH25LUnTXfsNqChQWsjkS9868LCyE69bgfExL6BkXaZNScmKfLhsVFvhyMIzdWhJ6QeAXlYbwZVBt9Q3Wz06ErOTvWoYjsqHBTsJ57Y1MN587t2mG6X6cq9LyQUuJ5z5CT30edqcwclSfVPzgqOmsayV7fRaW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hzv/AqDO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OBwvRNON; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hzv/AqDO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OBwvRNON"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 2B31C5C0172;
	Fri,  2 Feb 2024 03:30:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 02 Feb 2024 03:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706862645; x=1706949045; bh=PqCiHKD+rd
	xOard+gFZqoDx86fUOOEdc9TvNLghTNQU=; b=hzv/AqDOTqOBvow3+XqDekPtU3
	Fa6aiegMRzKp6k+XFUs+7FRYTBgVmf21XEcGFA1Y3LrxkwM7IacrFNKhlAh9nH6V
	1qXcYIycDtkHJv4+Dq4mgYdYBp+FJmM/Cw62QEMpHiEwjGjCSnxgIdwDMiYTl6Qr
	mxG+dTUAiReU2IT8euD1CnMk+OZKjega/farBNAmP1IcH9OzowbvMe9RxEqa7lxs
	OlEPgK3rPDvKAtOVOLVx+XyOCODc4jVVw7tIO+xrl5lCJ9jwgmrWmTglTqR4eBO9
	F6GRqQ7SJlnIeN8ffvjQYran4qXXpuvVnbS1CtsAie1i5y84MB+rUGgyVHKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706862645; x=1706949045; bh=PqCiHKD+rdxOard+gFZqoDx86fUO
	OEdc9TvNLghTNQU=; b=OBwvRNONL/XsScKWUPlNN1bt527tLg5Vw/Ijz0gnEW5c
	YkEhF8s+ZQs1u8HtLbaFoNzwKAA4oOHbTcX+rWyB21/DSd9iIgWnapXjdxJbFd+5
	5LAzXNOGuZmrp0aHW3ZTts8jkyBb5Z/sBnpYMQD8FBp2EAeKhawRA+QFcFyl56Om
	vTgecOw2VHy6JPF1Llbr8VbNY4nbpbUq0rPHl3qMk8Ln7WKfncLor5eAKy0G6xQC
	U7FiH5Uu7zWRA8Jk58QmgGEtXaWR+ESbxjci5K0FqjKuxwY6p98T0+8ADQCKxOTa
	iI0d8IKf6wDi4rvpU8QzU4hXsj/kngetWCoeL9AgDw==
X-ME-Sender: <xms:NKi8ZU4uQCyfAvlXC9WLSYdVKR-tQdQ62z-KMwp2kMBxD7kPHNnCrA>
    <xme:NKi8ZV7nyxx9yIpcZUvd_fL-1197mZ9HK5zXzhynr8gPI3BQVP3QW-qlrasg50eSN
    d5X0D2aw6-gMg33SQ>
X-ME-Received: <xmr:NKi8ZTdPuDoCNtqxvUED8p8Xmx3Rgz4DSSh-StL0UwtGl2bwOXMF0UTi778VLBc8pYP6FdlulVYu54UyN8j_PBotn0f1iZD7zOjFoNhHdqP7cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedufedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptefgkedthedvkeejtedttdehgeefheehtefgudetheduudefkefgtdfggeejgedt
    necuffhomhgrihhnpehpuhgslhhitgdqihhnsghogidrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NKi8ZZKQPJWQ__bW9vUf5jKGdzknWjx9HENrYi8rQu2ICIVuF08ohA>
    <xmx:NKi8ZYJ-iBMmkS7qGWtA1SGASPZPOxXzMypYf8kkfK0IN8B9A1mb5A>
    <xmx:NKi8ZaxFhc8ajkAIPQws4RPO2qTUR1nPXmpNpATAjo2RYLMqtIVhIA>
    <xmx:Nai8ZfUZwA4rC9SuUy_XR2QfasT7qb2Y7ORDX-SOcqLJaOk2tpIinw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 03:30:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b7f50ca1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Feb 2024 08:27:18 +0000 (UTC)
Date: Fri, 2 Feb 2024 09:30:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/2] refs: introduce reftable backend
Message-ID: <ZbyoL3r7yEVYe35B@tanuki>
References: <cover.1706601199.git.ps@pks.im>
 <5598cd13074beef092a61235a505476d0cbceb90.1706601199.git.ps@pks.im>
 <CAOLa=ZTrPuRAbkDgg1Dh4M-3o58Rw1KruAMcw47o2V_LrK9KPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DrVRrsSkEuPdDLV7"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTrPuRAbkDgg1Dh4M-3o58Rw1KruAMcw47o2V_LrK9KPg@mail.gmail.com>


--DrVRrsSkEuPdDLV7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 07:17:45AM -0800, Karthik Nayak wrote:
> Hello,
>=20
> Patrick Steinhardt <ps@pks.im> writes:
> >   - It becomes possible to do truly atomic writes where either all refs
> >     are committed to disk or none are. This was not possible with the
> >     "files" backend because ref updates were split across multiple loose
> >     files.
> >
> >   - The disk space required to store many refs is reduced, both compared
> >     to loose refs and packed-refs. This is enabled both by the reftable
> >     format being a binary format, which is more compact, and by prefix
> >     compression.
> >
> >   - We can ignore filesystem-specific behaviour as ref names are not
> >     encoded via paths anymore. This means there is no need to handle
> >     case sensitivity on Windows systems or Unicode precomposition on
> >     macOS.
> >
> >   - There is no need to rewrite the complete refdb anymore every time a
> >     ref is being deleted like it was the case for packed-refs. This
> >     means that ref deletions are now constant time instead of scaling
> >     linearly with the number of refs.
> >
> >   - We can ignore file/directory conflicts so that it becomes possible
> >     to store both "refs/heads/foo" and "refs/heads/foo/bar".
> >
> >   - Due to this property we can retain reflogs for deleted refs. We have
> >     previously been deleting reflogs together with their refs to avoid
> >     file/directory conflicts, which is not necessary anymore.
> >
>=20
> Nit: Maybe also a point about how with the current files backend doesn't
> have a good way to differentiate between regular files and refs. While
> regular refs are in the 'refs/' folder, pseudorefs have no namespace.
> While with the reftable implementation we know that everything within
> the reftable is a ref and there are no other refs we need to consider.

True, I'll add that.

> > Performance-wise things very much depend on the actual workload. The
> > following benchmarks compare the "files" and "reftable" backends in the
> > current version:
>=20
> Pretty nice to have these numbers here.
>=20
> >
> >   - Creating N refs in separate transactions shows that the "files"
> >     backend is ~50% faster. This is not surprising given that creating a
> >     ref only requires us to create a single loose ref. The "reftable"
> >     backend will also perform auto compaction on updates. In real-world
> >     workloads we would likely also want to perform pack loose refs,
> >     which would likely change the picture.
> >
> >         Benchmark 1: update-ref: create refs sequentially (refformat =
=3D files)
> >           Time (mean =C2=B1 =CF=83):       2.1 ms =C2=B1   0.3 ms    [U=
ser: 0.6 ms, System: 1.7 ms]
> >           Range (min =E2=80=A6 max):     1.8 ms =E2=80=A6   4.3 ms    1=
33 runs
> >
> >         Benchmark 2: update-ref: create refs sequentially (refformat =
=3D reftable)
> >           Time (mean =C2=B1 =CF=83):       2.7 ms =C2=B1   0.1 ms    [U=
ser: 0.6 ms, System: 2.2 ms]
> >           Range (min =E2=80=A6 max):     2.4 ms =E2=80=A6   2.9 ms    1=
32 runs
> >
> >         Benchmark 3: update-ref: create refs sequentially (refformat =
=3D files)
> >           Time (mean =C2=B1 =CF=83):      1.975 s =C2=B1  0.006 s    [U=
ser: 0.437 s, System: 1.535 s]
> >           Range (min =E2=80=A6 max):    1.969 s =E2=80=A6  1.980 s    3=
 runs
> >
> >         Benchmark 4: update-ref: create refs sequentially (refformat =
=3D reftable)
> >           Time (mean =C2=B1 =CF=83):      2.611 s =C2=B1  0.013 s    [U=
ser: 0.782 s, System: 1.825 s]
> >           Range (min =E2=80=A6 max):    2.597 s =E2=80=A6  2.622 s    3=
 runs
> >
> >         Benchmark 5: update-ref: create refs sequentially (refformat =
=3D files)
> >           Time (mean =C2=B1 =CF=83):     198.442 s =C2=B1  0.241 s    [=
User: 43.051 s, System: 155.250 s]
> >           Range (min =E2=80=A6 max):   198.189 s =E2=80=A6 198.670 s   =
 3 runs
> >
> >         Benchmark 6: update-ref: create refs sequentially (refformat =
=3D reftable)
> >           Time (mean =C2=B1 =CF=83):     294.509 s =C2=B1  4.269 s    [=
User: 104.046 s, System: 190.326 s]
> >           Range (min =E2=80=A6 max):   290.223 s =E2=80=A6 298.761 s   =
 3 runs
> >
>=20
> Nit: The refcount is missing in these benchmarks.

Good catch, this is an edge case of hyperfine. Because the refcount is
used in the command line it's not shown anymore in its output. I'll just
massage these manually.

> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > new file mode 100644
> > index 0000000000..895de0b273
> > --- /dev/null
> > +++ b/refs/reftable-backend.c
> > @@ -0,0 +1,2286 @@
> > +#include "../git-compat-util.h"
> > +#include "../abspath.h"
> > +#include "../chdir-notify.h"
> > +#include "../config.h"
>=20
> I believe this header can be dropped.
>=20
> Not sure about removing headers which aren't needed. The coding
> guidelines mentions that we should include headers that declare the
> functions and the types used. I found some headers here which are not
> required considering this rule.

It's always good hygiene to not include unneeded headers. Also helps to
keep build times lower and reduce unnecessary rebuilds.

> > +#include "../environment.h"
> > +#include "../gettext.h"
> > +#include "../hash.h"
> > +#include "../hex.h"
> > +#include "../iterator.h"
> > +#include "../ident.h"
> > +#include "../lockfile.h"
> > +#include "../object.h"
> > +#include "../path.h"
> > +#include "../refs.h"
> > +#include "../reftable/reftable-stack.h"
> > +#include "../reftable/reftable-record.h"
> > +#include "../reftable/reftable-error.h"
> > +#include "../reftable/reftable-blocksource.h"
>=20
> This header can be dropped too.
>=20
> > +#include "../reftable/reftable-reader.h"
>=20
> This also.
>=20
> > +#include "../reftable/reftable-iterator.h"
> > +#include "../reftable/reftable-merged.h"
> > +#include "../reftable/reftable-generic.h"
>=20
> This one as well.
>=20
> > +#include "../setup.h"
> > +#include "../strmap.h"
> > +#include "../worktree.h"
>=20
> This one too.
>=20
> > +struct reftable_ref_store {
> > +	struct ref_store base;
> > +
> > +	struct reftable_stack *main_stack;
> > +	struct reftable_stack *worktree_stack;
> > +	struct strmap worktree_stacks;
> > +	struct reftable_write_options write_options;
> > +
> > +	unsigned int store_flags;
> > +	int err;
> > +};
>=20
> So, I'm assuming that `main_stack` here would be the primary reference
> db, even when inside the worktree. I'm wondering why we can't just have
>=20
>     struct reftable_stack *current_stack;
>     struct strmap worktree_stacks;
>=20
> Reading further on, it becomes necessary to have both, because the user
> could
>     1. Request main-worktree/{ref}
>     2. Request worktrees/{worktree}/{ref}
> So it's important that we have access to both the main worktree, the
> current worktree and also any other worktree.

Indeed. I'll add some comments to point out their respective uses.

> Maybe we could just drop the `struct reftable_stack *worktree_stack` and
> rely on the map entirely, but I guess `worktree_stack` acts as a caching
> layer and avoids using the map unless necessary.

I doubt that the map access would be all that expensive in practice. The
problem rather is that we don't know about the worktree name when we
init the backend, and looking it up feels fragile to me and may involve
parsing all worktree metadata. So I rather want to avoid that to the
extent possible.

> > +	base_ref_store_init(&refs->base, repo, gitdir, &refs_be_reftable);
> > +	strmap_init(&refs->worktree_stacks);
> > +	refs->store_flags =3D store_flags;
> > +	refs->write_options.block_size =3D 4096;
> >
>=20
> Perhaps use `DEFAULT_BLOCK_SIZE` from "reftable/constants.h" here.

This isn't exposed given that only the "reftable/reftable-*.h" headers
are considered to be public. Ideally, we'd just leave it unset and let
the default block size kick in. But `reftable_new_stack()` doesn't set
up the block size at all in that case, and that leads to failures.

I'll leave this as-is for now. We can clean it up in the future.

> > +	strbuf_addstr(&path, "/reftable");
> > +	refs->err =3D reftable_new_stack(&refs->main_stack, path.buf,
> > +				       refs->write_options);
> > +	if (refs->err)
> > +		goto done;
> > +
> > +	/*
> > +	 * If we're in a worktree we also need to set up the worktree reftable
> > +	 * stack that is contained in the per-worktree GIT_DIR.
> > +	 */
> > +	if (is_worktree) {
> > +		strbuf_reset(&path);
> > +		strbuf_addf(&path, "%s/reftable", gitdir);
> > +
> > +		refs->err =3D reftable_new_stack(&refs->worktree_stack, path.buf,
> > +					       refs->write_options);
> > +		if (refs->err)
> > +			goto done;
> > +	}
>=20
> Wondering if we should also add this to the `refs->worktree_stacks`.

Ideally we would, but at this point we have no easy way to figure out
the worktree name to the best of my knowledge.

> > +struct reftable_ref_iterator {
> > +	struct ref_iterator base;
> > +	struct reftable_ref_store *refs;
> > +	struct reftable_iterator iter;
> > +	struct reftable_ref_record ref;
> > +	struct object_id oid;
> > +
> > +	const char *prefix;
> > +	unsigned int flags;
> > +	int err;
> > +};
>=20
> So the `flags` in this structure are for the iterator itself but the
> `flags` in `base` are flags related to the current ref stored in `base`.

Yup.

> > +static int reftable_ref_iterator_advance(struct ref_iterator *ref_iter=
ator)
> > +{
> > +	struct reftable_ref_iterator *iter =3D
> > +		(struct reftable_ref_iterator *)ref_iterator;
> > +	struct reftable_ref_store *refs =3D iter->refs;
> > +
> > +	while (!iter->err) {
> > +		int flags =3D 0;
> > +
>=20
> Nit: I think the syntax in `reftable_reflog_iterator_advance` is similar =
but
> nicer to read, the usage of `while(1)` and returning within the while
> loop is better than breaking here and returning outside, either ways, I
> think it'd be nicer to make both of them consistent.

The problem here is that the ref iterator has multiple exit paths that
need to be treated the same, so it is easier to have a common exit path.
I'll thus touch up the reflog iterator to look the same. I think that's
the better option anyway so that there is a single exit path, only.

Also shows that we didn't store the error into `iter->err` in the reflog
case. Not a huge issue because callers aren't supposed to continue
iterating after they've hit an error anyway. But still preferable to
make errors persistent.

> > +		iter->err =3D reftable_iterator_next_ref(&iter->iter, &iter->ref);
> > +		if (iter->err)
> > +			break;
> > +
> > +		/*
> > +		 * The files backend only lists references contained in
> > +		 * "refs/". We emulate the same behaviour here and thus skip
> > +		 * all references that don't start with this prefix.
> > +		 */
> > +		if (!starts_with(iter->ref.refname, "refs/"))
> > +			continue;
> > +
>=20
> Since my patch series [1] to print all refs is now merged to next, maybe
> you could add this in?
>=20
>     diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>     index 895de0b273..3f4f905292 100644
>     --- a/refs/reftable-backend.c
>     +++ b/refs/reftable-backend.c
>     @@ -348,11 +348,10 @@ static int
> reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
>      			break;
>=20
>      		/*
>     -		 * The files backend only lists references contained in
>     -		 * "refs/". We emulate the same behaviour here and thus skip
>     -		 * all references that don't start with this prefix.
>     +		 * Unless the `DO_FOR_EACH_INCLUDE_ALL_REFS` flag is use, we only
>     +		 * list references contained in "refs/" to mimic the file-backend.
>      		 */
>     -		if (!starts_with(iter->ref.refname, "refs/"))
>     +		if (!(iter->flags & DO_FOR_EACH_INCLUDE_ALL_REFS) &&
> !starts_with(iter->ref.refname, "refs/"))
>      			continue;
>=20
>      		if (iter->prefix &&

I'm still waiting for your patch series to hit `next` before making it a
dependency of this series, but thanks for the patch!

> > +static enum iterator_selection iterator_select(struct ref_iterator *it=
er_worktree,
> > +					       struct ref_iterator *iter_common,
> > +					       void *cb_data UNUSED)
> > +{
> > +	if (iter_worktree && !iter_common) {
> > +		/*
> > +		 * Return the worktree ref if there are no more common refs.
> > +		 */
> > +		return ITER_SELECT_0;
> > +	} else if (iter_common) {
> > +		/*
> > +		 * In case we have pending worktree and common refs we need to
> > +		 * yield them based on their lexicographical order. Worktree
> > +		 * refs that have the same name as common refs shadow the
> > +		 * latter.
> > +		 */
> > +		if (iter_worktree) {
> > +			int cmp =3D strcmp(iter_worktree->refname,
> > +					 iter_common->refname);
> > +			if (cmp < 0)
> > +				return ITER_SELECT_0;
> > +			else if (!cmp)
> > +				return ITER_SELECT_0_SKIP_1;
> > +		}
> > +
> > +		 /*
> > +		  * Otherwise, if we either have no worktree refs anymore or if
> > +		  * the common ref sorts before the next worktree ref, we need
> > +		  * to figure out whether the next common ref belongs to the
> > +		  * main worktree. In that case, it should be ignored.
> > +		  */
> > +		if (parse_worktree_ref(iter_common->refname, NULL, NULL,
> > +				       NULL) =3D=3D REF_WORKTREE_SHARED)
> > +			return ITER_SELECT_1;
> > +
>=20
> I'm not sure I understand this. When would this situation occur?

There are two cases here:

  - The worktree iterator is exhausted because there are common refs
    which sort lexicographically after all worktree refs.

  - Both iterators still have refs, and the next lexicographic ref is
    from the common ref store.

In both case we want to return only those refs which are shared, but we
want to skip over all per-worktree refs from the common ref store. This
is because the per-worktree refs from the common ref store belong to the
main worktree, not to ours.

I'll rework the comments a bit.

> > +		return ITER_SKIP_1;
> > +	} else {
> > +		return ITER_DONE;
> > +	}
> > +}
> > +
> > +
> > +static int reftable_be_transaction_prepare(struct ref_store *ref_store,
> > +					   struct ref_transaction *transaction,
> > +					   struct strbuf *err)
> > +{
> > +	struct reftable_ref_store *refs =3D
> > +		reftable_be_downcast(ref_store, REF_STORE_WRITE|REF_STORE_MAIN, "ref=
_transaction_prepare");
> > +	struct strbuf referent =3D STRBUF_INIT, head_referent =3D STRBUF_INIT;
> > +	struct string_list affected_refnames =3D STRING_LIST_INIT_NODUP;
> > +	struct reftable_transaction_data *tx_data =3D NULL;
> > +	struct object_id head_oid;
> > +	unsigned int head_type =3D 0;
> > +	size_t i;
> > +	int ret;
> > +
> > +	ret =3D refs->err;
> > +	if (ret < 0)
> > +		goto done;
> > +
> > +	tx_data =3D xcalloc(1, sizeof(*tx_data));
> > +
> > +	/*
> > +	 * Preprocess all updates. For one we check that there are no duplica=
te
> > +	 * reference updates in this transaction. Second, we lock all stacks
> > +	 * that will be modified during the transaction.
> > +	 */
> > +	for (i =3D 0; i < transaction->nr; i++) {
> > +		ret =3D prepare_transaction_update(NULL, refs, tx_data,
> > +						 transaction->updates[i], err);
> > +		if (ret)
> > +			goto done;
> > +
> > +		string_list_append(&affected_refnames,
> > +				   transaction->updates[i]->refname);
> > +	}
> > +
> > +	/*
> > +	 * Now that we have counted updates per stack we can preallocate their
> > +	 * arrays. This avoids having to reallocate many times.
> > +	 */
> > +	for (i =3D 0; i < tx_data->args_nr; i++) {
> > +		CALLOC_ARRAY(tx_data->args[i].updates, tx_data->args[i].updates_expe=
cted);
> > +		tx_data->args[i].updates_alloc =3D tx_data->args[i].updates_expected;
> > +	}
> > +
> > +	/*
> > +	 * Fail if a refname appears more than once in the transaction.
> > +	 * This code is taken from the files backend and is a good candidate =
to
> > +	 * be moved into the generic layer.
> > +	 */
> > +	string_list_sort(&affected_refnames);
> > +	if (ref_update_reject_duplicates(&affected_refnames, err)) {
> > +		ret =3D TRANSACTION_GENERIC_ERROR;
> > +		goto done;
> > +	}
> > +
> > +	ret =3D read_ref_without_reload(stack_for(refs, "HEAD", NULL), "HEAD"=
, &head_oid,
> > +				      &head_referent, &head_type);
> > +	if (ret < 0)
> > +		goto done;
> > +
> > +	for (i =3D 0; i < transaction->nr; i++) {
> > +		struct ref_update *u =3D transaction->updates[i];
> > +		struct object_id current_oid =3D {0};
> > +		struct reftable_stack *stack;
> > +		const char *rewritten_ref;
> > +
> > +		stack =3D stack_for(refs, u->refname, &rewritten_ref);
> >
>=20
> Wondering why we didn't just iterate over `tx_data.args` and
> `args[i].updates` since there we already have the required stack.
>=20
> Update: we don't save rewritten_ref in tx_data, so that's one blocker
> for this.

Right, that's the reason. I was trying to do that, but also ran into
some other problems caused by the ref splitting we do in the loop.

> > +
> > +		if (u->type & REF_ISSYMREF) {
> > +			const char *resolved =3D refs_resolve_ref_unsafe(&refs->base, u->re=
fname, 0,
> > +								       &current_oid, NULL);
> > +
> > +			if (u->flags & REF_NO_DEREF) {
> > +				/*
> > +				 * The reftable stack is locked at this point
> > +				 * already, so it should be safe to call
> > +				 * `refs_resolve_ref_unsafe()` here.
> > +				 */
>=20
> Shouldn't this comment be a few lines before?

Good catch. I moved the `refs_resolve_ref_unsafe()` call at one point
and forgot to also move the comment.

> > +static int write_transaction_table(struct reftable_writer *writer, voi=
d *cb_data)
> > +{
> > +	struct write_transaction_table_arg *arg =3D cb_data;
> > +	struct reftable_merged_table *mt =3D
> > +		reftable_stack_merged_table(arg->stack);
> > +	uint64_t ts =3D reftable_stack_next_update_index(arg->stack);
> > +	struct reftable_log_record *logs =3D NULL;
> > +	size_t logs_nr =3D 0, logs_alloc =3D 0, i;
> > +	int ret =3D 0;
> > +
> > +	QSORT(arg->updates, arg->updates_nr, transaction_update_cmp);
> > +
> > +	reftable_writer_set_limits(writer, ts, ts);
> > +
> > +	for (i =3D 0; i < arg->updates_nr; i++) {
> > +		struct reftable_transaction_update *tx_update =3D &arg->updates[i];
> > +		struct ref_update *u =3D tx_update->update;
> > +
> > +		/*
> > +		 * Write a reflog entry when updating a ref to point to
> > +		 * something new in either of the following cases:
> > +		 *
> > +		 * - The reference is about to be deleted. We always want to
> > +		 *   delete the reflog in that case.
> > +		 * - REF_FORCE_CREATE_REFLOG is set, asking us to always create
> > +		 *   the reflog entry.
> > +		 * - `core.logAllRefUpdates` tells us to create the reflog for
> > +		 *   the given ref.
> > +		 */
> > +		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_=
oid(&u->new_oid)) {
> > +			struct reftable_log_record log =3D {0};
> > +			struct reftable_iterator it =3D {0};
> > +
> > +			/*
> > +			 * When deleting refs we also delete all reflog entries
> > +			 * with them. While it is not strictly required to
> > +			 * delete reflogs together with their refs, this
> > +			 * matches the behaviour of the files backend.
> > +			 *
> > +			 * Unfortunately, we have no better way than to delete
> > +			 * all reflog entries one by one.
> > +			 */
> > +			ret =3D reftable_merged_table_seek_log(mt, &it, u->refname);
> > +			while (ret =3D=3D 0) {
> > +				struct reftable_log_record *tombstone;
> > +
> > +				ret =3D reftable_iterator_next_log(&it, &log);
> > +				if (ret < 0)
> > +					break;
> > +				if (ret > 0 || strcmp(log.refname, u->refname)) {
> > +					ret =3D 0;
> > +					break;
> > +				}
> > +
> > +				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
> > +				tombstone =3D &logs[logs_nr++];
> > +				tombstone->refname =3D xstrdup(u->refname);
> > +				tombstone->value_type =3D REFTABLE_LOG_DELETION,
>=20
> Why is this a comma? one other such instance in this file.

Typo :) Funny enough this is fine and doesn't make any difference. The
comma operator will simply discard the value of the first statement
(which is the assigned value) and instead return the value of the second
value. We don't use either though, so no problem.

I've also fixed the second instance.

[snip]
> > +	/*
> > +	 * When deleting the old branch we need to create a reflog entry on t=
he
> > +	 * new branch name that indicates that the old branch has been deleted
> > +	 * and then recreated. This is a tad weird, but matches what the files
> > +	 * backend does.
> > +	 */
> > +	if (arg->delete_old) {
> > +		struct strbuf head_referent =3D STRBUF_INIT;
> > +		struct object_id head_oid;
> > +		int append_head_reflog;
> > +		unsigned head_type =3D 0;
> > +
> > +		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
> > +		memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
> > +		fill_reftable_log_record(&logs[logs_nr]);
> > +		logs[logs_nr].refname =3D (char *)arg->newname;
> > +		logs[logs_nr].update_index =3D deletion_ts;
> > +		logs[logs_nr].value.update.message =3D
> > +			xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
>=20
> Question: here and other places in this file, shouldn't we free memory
> allocated by `xstrndup`?

We use `reftable_log_record_release()`, which takes care of this.

> Also, why is it `block_size / 2` ?

That's a very good question indeed. The problem we have here is that the
maximum length of a record is limited by the block size. Thus, we cannot
write entries into a block that exceed a certain length and we must
ensure that no record exceeds that size.

Using `block_size / 2` is thus a mechanism to cull the reflog message so
that we can at least write a _partial_ reflog without breaking the
format. The division by two is kind of arbitrary here and ensures that
we have enough headroom to also write the remaining data of the record.

So this could be improved to instead trim at the exact block boundary
minus the overhead of the remaining data. But I dobut that's really
worth it for now given that nobody will ever write a 2kB reflog entry
(famous last words).

> > +static struct reftable_reflog_iterator *reflog_iterator_for_stack(stru=
ct reftable_ref_store *refs,
> > +								  struct reftable_stack *stack)
> > +{
> > +	struct reftable_reflog_iterator *iter;
> > +	struct reftable_merged_table *mt;
> > +	int ret;
> > +
> > +	iter =3D xcalloc(1, sizeof(*iter));
> > +	base_ref_iterator_init(&iter->base, &reftable_reflog_iterator_vtable,=
 1);
> > +	iter->refs =3D refs;
> > +	iter->base.oid =3D &iter->oid;
> > +
> > +	ret =3D reftable_stack_reload(refs->main_stack);
> > +	if (ret < 0)
> > +		goto done;
> > +
> > +	mt =3D reftable_stack_merged_table(stack);
> > +	ret =3D reftable_merged_table_seek_log(mt, &iter->iter, "");
> > +	if (ret < 0)
> > +		goto done;
> > +
>=20
> Keeping it similar to `ref_iterator_for_stack`, perhaps:
>=20
>     ret =3D refs->err;
> 	if (ret)
> 		goto done;
>=20
> 	ret =3D reftable_stack_reload(stack);
> 	if (ret)
> 		goto done;
>=20
> 	merged_table =3D reftable_stack_merged_table(stack);
>=20
> 	ret =3D reftable_merged_table_seek_ref(merged_table, &iter->iter, prefix=
);
> 	if (ret)
> 		goto done;

Will do.

> > +static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *r=
ef_store,
> > +						   const char *refname,
> > +						   each_reflog_ent_fn fn,
> > +						   void *cb_data)
> > +{
> > +	struct reftable_ref_store *refs =3D
> > +		reftable_be_downcast(ref_store, REF_STORE_READ, "for_each_reflog_ent=
_reverse");
> > +	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
> > +	struct reftable_merged_table *mt =3D NULL;
> > +	struct reftable_log_record log =3D {0};
> > +	struct reftable_iterator it =3D {0};
> > +	int ret;
> > +
> > +	if (refs->err < 0)
> > +		return refs->err;
>=20
> Nit: seems like this function and the one below
> `reftable_be_for_each_reflog_ent`, share the same code apart from
> iteration direction. Wonder if it'd be nicer to extract out the common
> code from them.

Hm. I tried to do this once a while ago, but didn't end up with a nice
solution because I basically tried to unify the iterator loops, which
didn't quite work out in a nice way. But coming back with fresh eyes we
can at least easily share the code that yields the log record to the
callback function to remove some code duplication.

> > +static int reftable_be_reflog_exists(struct ref_store *ref_store,
> > +				     const char *refname)
> > +{
> > +	struct reftable_ref_store *refs =3D
> > +		reftable_be_downcast(ref_store, REF_STORE_READ, "reflog_exists");
> > +	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
> > +	struct reftable_merged_table *mt =3D reftable_stack_merged_table(stac=
k);
> > +	struct reftable_log_record log =3D {0};
> > +	struct reftable_iterator it =3D {0};
> > +	int ret;
> > +
> > +	ret =3D refs->err;
> > +	if (ret < 0)
> > +		goto done;
> > +
> > +	ret =3D reftable_stack_reload(stack);
> > +	if (ret)
> > +		goto done;
> > +
> > +	ret =3D reftable_merged_table_seek_log(mt, &it, refname);
> > +	if (ret)
> > +		goto done;
> > +
> > +	/*
> > +	 * Seek the reflog to see whether it contains any reflog entries which
> > +	 * aren't marked for deletion.
> > +	 */
>=20
> Shouldn't we be checking `log.value_type` in that case?

I think this whole loop doesn't make any sense anymore. I initially
misunderstood how reflog deletion works [1]: I assumed that a reflog
entry with the zero object ID as new value is supposed to mark a reflog
as deleted, but that's not the case. Instead, deleting a reflog requires
us to mark each record as deleted individually.

Given that the reftable stack is marked to suppress deletions (see
`reftable_stack_reload_once()`, `new_merged->suppress_deletions =3D 1`),
we don't have to check for deletions at all. All we have to do is seek
the log once and check whether we get a log record matching the expected
name.

[1]: https://public-inbox.org/git/ZVy0zKcmc8tjmgzs@tanuki/

> This email only reviews this file, I'll review the others in follow up
> email[s].

Thanks a lot for your review! I know the code here is quite dense, so I
really appreciate it.

Patrick

--DrVRrsSkEuPdDLV7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW8qC4ACgkQVbJhu7ck
PpQBrxAAlKK2XRBcNkpGFD2R5lSJQAheWxzw+6H9zuV4ej8ILFd8cbiLbXQHynsB
KaYgu8TogypdoCmdmwbh8e0+VjDlx/JiN9YCkkG7maHzHVHReHC1dNcFCLzCzLMC
Z3NPNkyvs1TNtEFuuCJ42oLeV2gLSrtFCEfwBnkNXLqNDltS6uTPlyXz0E7Y23xd
GtM2gAN0siCBf0bRbosg0Vy/QzI50Cp81O1CkErmZKlv6LImtU8OphihkcZd2X6d
48JG992MRh9/0n0hNeeN9P4zkEIEXgXEU4TbgBO8kW7OGGmKe/zdj7isF56Jqpbk
kkC8kwzTaYkQ97JZF4Oul7x+EdUBIWEsPw0RLMF+CQSbqRbDap3OjEdX4lzVLCYw
h1M7pSC2GQ8u7cTfnnTTthYxhBu14jqtFHhv/X5ods/5R0i/iPTcpctOm8UCwQy/
Euq1eH3caW6RYmY5GwknGdThf1SRlWxEWyoC7kmcxD49Nv5AH9OTh/wgmKMACcVj
FU1tGdoxuTTgm6++zkTtQ69r1xyxa577KvYcuCEwwpSOMWPOpi0NO5oQdRz1OuWW
rq4120URNT3V8JFAyICxd4s9JZbOSE68GutEUxc/xtx1GvPsHX+zUk2tP33DoF+0
KJqEWNUKcBYJeWFA+mjdu+OBYRzOJdtx0MY7mdtK9sF8AfZ59/g=
=H1ul
-----END PGP SIGNATURE-----

--DrVRrsSkEuPdDLV7--
