Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027B65F48C
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800670; cv=none; b=oixk6t/yO0MB9nYKliuspHUdO+MNgn1XjUYKdhMG28nCTlg57VL2eDVHeqN/8Pgpe8MJ8kw9R3A5WBD3S1gV82ik2ZIwgMQF6I6YCMBb44OgRDLN7m5T3IXrd6gcv7T9Vv2kkg0lRm+Fq5446SVXz3k07F2Ar2uyTg+0Y6VYeUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800670; c=relaxed/simple;
	bh=7Gh8F6VJpNySohANoBmaxL+U8iBsN2eoC1E++vnioj8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHFUQnAxpo6eovHEPnbjhJ94hk9JyRWmkySZBJ1I9mOFVYvzMuFiy9LKM7Y+RLJDdTr44QwCI7PYNO++gbYNDilHD0fpzqG8mZIsonkbTgvrVsi6xzBOOG1ax8biP6hUu34UY/sNSU4bJOqFHblU76YFEj0CFEoskbevt40ANwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKsu/E/P; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKsu/E/P"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3be78c26850so655386b6e.0
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 07:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800667; x=1707405467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rW22TwIEj1J1wdWyjDAPslmfKRpgVOQYuqAJHisxnZM=;
        b=fKsu/E/PvklrcHvXZx9dgFKgjKG1oi4mr9sZWyT2C1hqrsLXmf7DcWuIB5whYLdaSw
         Gl3LMBx3JVaaMsYh5JQESbDnca08/nmfbWD2FqakdiIUc3L5YemDme2DNn+irkEdUkYx
         m9gxttRTkX+jdLeusvW4cLJVNMq28zFSmP7Cq8WrHI0EhDF50Qgxtfzkq8NdtnHSD4+P
         Bjk8hVi5zZXeQ4+0U+D5Mz9cJIn5WToZUgmMXAknlCwXvSoRAL4hhKbZzpYtK83bde45
         VNtCtohrL3E4yoF4FcwCuIu/2XMlNXkP4Y3w8VPgOtUgFOVDdzYayTy6FQQ/I99o3g3v
         MPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800667; x=1707405467;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rW22TwIEj1J1wdWyjDAPslmfKRpgVOQYuqAJHisxnZM=;
        b=EgYYikQGi36nBwEZh0YaGqSOP/H2jTGmRlqfiUGvSO6EveqOQ4V795AWDWFFrwvjaN
         yVLqMBZjOpbQw8swJqwrzSSgo2sRxpReZ5QsxGNAvA7BZu0Eh98W67OOMzDwU00ymTVa
         cXxTMAddPniuxigoNOsiGb0KSiyPNl9xYkF6UGVy+ioLN6kvMj4ECbGPLsCITEXK0ND3
         ybpxFpQwHl/KcZaW5iurmghfejd5RPiiJxytypeXSvIZaH4il0MLQxVqJJRJDDRUdM9y
         stBqH1oO7F9X8bWTyXs/x0oCvaMmZkK+XO5GOx1znIEF2cXqQdzkOz14WU5q5hwNh5q5
         tmTg==
X-Gm-Message-State: AOJu0YwR2qFLYiB6ypB4jUg2bgaro1DcsEBkQ7ipOoofnkfMKR2F4/Mp
	zxdJJtP40lsNPE9G5Cs1yJTr4Otc6YoXCAy/B3bIN8jKvrOs+S6CabATRLyB56G+DcTgDAnuf+c
	T2djwczjh5NeQqRAfT+nNbrnYZ7H82Txo
X-Google-Smtp-Source: AGHT+IFOoDAdWh7ZuTdRfjGCz9WXaqDsYPDbY4vJN7SxRNZiR6/7eff/Hcl8bCrw2WRTiqS+DwWOOHoImFztGGW7xjc=
X-Received: by 2002:a05:6870:76a8:b0:218:3f9a:78ca with SMTP id
 dx40-20020a05687076a800b002183f9a78camr4031745oab.23.1706800666434; Thu, 01
 Feb 2024 07:17:46 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Feb 2024 07:17:45 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <5598cd13074beef092a61235a505476d0cbceb90.1706601199.git.ps@pks.im>
References: <cover.1706601199.git.ps@pks.im> <5598cd13074beef092a61235a505476d0cbceb90.1706601199.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 1 Feb 2024 07:17:45 -0800
Message-ID: <CAOLa=ZTrPuRAbkDgg1Dh4M-3o58Rw1KruAMcw47o2V_LrK9KPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] refs: introduce reftable backend
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Content-Type: multipart/mixed; boundary="0000000000006d4f330610537f42"

--0000000000006d4f330610537f42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Patrick Steinhardt <ps@pks.im> writes:
>   - It becomes possible to do truly atomic writes where either all refs
>     are committed to disk or none are. This was not possible with the
>     "files" backend because ref updates were split across multiple loose
>     files.
>
>   - The disk space required to store many refs is reduced, both compared
>     to loose refs and packed-refs. This is enabled both by the reftable
>     format being a binary format, which is more compact, and by prefix
>     compression.
>
>   - We can ignore filesystem-specific behaviour as ref names are not
>     encoded via paths anymore. This means there is no need to handle
>     case sensitivity on Windows systems or Unicode precomposition on
>     macOS.
>
>   - There is no need to rewrite the complete refdb anymore every time a
>     ref is being deleted like it was the case for packed-refs. This
>     means that ref deletions are now constant time instead of scaling
>     linearly with the number of refs.
>
>   - We can ignore file/directory conflicts so that it becomes possible
>     to store both "refs/heads/foo" and "refs/heads/foo/bar".
>
>   - Due to this property we can retain reflogs for deleted refs. We have
>     previously been deleting reflogs together with their refs to avoid
>     file/directory conflicts, which is not necessary anymore.
>

Nit: Maybe also a point about how with the current files backend doesn't
have a good way to differentiate between regular files and refs. While
regular refs are in the 'refs/' folder, pseudorefs have no namespace.
While with the reftable implementation we know that everything within
the reftable is a ref and there are no other refs we need to consider.


> Performance-wise things very much depend on the actual workload. The
> following benchmarks compare the "files" and "reftable" backends in the
> current version:

Pretty nice to have these numbers here.

>
>   - Creating N refs in separate transactions shows that the "files"
>     backend is ~50% faster. This is not surprising given that creating a
>     ref only requires us to create a single loose ref. The "reftable"
>     backend will also perform auto compaction on updates. In real-world
>     workloads we would likely also want to perform pack loose refs,
>     which would likely change the picture.
>
>         Benchmark 1: update-ref: create refs sequentially (refformat =3D =
files)
>           Time (mean =C2=B1 =CF=83):       2.1 ms =C2=B1   0.3 ms    [Use=
r: 0.6 ms, System: 1.7 ms]
>           Range (min =E2=80=A6 max):     1.8 ms =E2=80=A6   4.3 ms    133=
 runs
>
>         Benchmark 2: update-ref: create refs sequentially (refformat =3D =
reftable)
>           Time (mean =C2=B1 =CF=83):       2.7 ms =C2=B1   0.1 ms    [Use=
r: 0.6 ms, System: 2.2 ms]
>           Range (min =E2=80=A6 max):     2.4 ms =E2=80=A6   2.9 ms    132=
 runs
>
>         Benchmark 3: update-ref: create refs sequentially (refformat =3D =
files)
>           Time (mean =C2=B1 =CF=83):      1.975 s =C2=B1  0.006 s    [Use=
r: 0.437 s, System: 1.535 s]
>           Range (min =E2=80=A6 max):    1.969 s =E2=80=A6  1.980 s    3 r=
uns
>
>         Benchmark 4: update-ref: create refs sequentially (refformat =3D =
reftable)
>           Time (mean =C2=B1 =CF=83):      2.611 s =C2=B1  0.013 s    [Use=
r: 0.782 s, System: 1.825 s]
>           Range (min =E2=80=A6 max):    2.597 s =E2=80=A6  2.622 s    3 r=
uns
>
>         Benchmark 5: update-ref: create refs sequentially (refformat =3D =
files)
>           Time (mean =C2=B1 =CF=83):     198.442 s =C2=B1  0.241 s    [Us=
er: 43.051 s, System: 155.250 s]
>           Range (min =E2=80=A6 max):   198.189 s =E2=80=A6 198.670 s    3=
 runs
>
>         Benchmark 6: update-ref: create refs sequentially (refformat =3D =
reftable)
>           Time (mean =C2=B1 =CF=83):     294.509 s =C2=B1  4.269 s    [Us=
er: 104.046 s, System: 190.326 s]
>           Range (min =E2=80=A6 max):   290.223 s =E2=80=A6 298.761 s    3=
 runs
>

Nit: The refcount is missing in these benchmarks.

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> new file mode 100644
> index 0000000000..895de0b273
> --- /dev/null
> +++ b/refs/reftable-backend.c
> @@ -0,0 +1,2286 @@
> +#include "../git-compat-util.h"
> +#include "../abspath.h"
> +#include "../chdir-notify.h"
> +#include "../config.h"

I believe this header can be dropped.

Not sure about removing headers which aren't needed. The coding
guidelines mentions that we should include headers that declare the
functions and the types used. I found some headers here which are not
required considering this rule.

> +#include "../environment.h"
> +#include "../gettext.h"
> +#include "../hash.h"
> +#include "../hex.h"
> +#include "../iterator.h"
> +#include "../ident.h"
> +#include "../lockfile.h"
> +#include "../object.h"
> +#include "../path.h"
> +#include "../refs.h"
> +#include "../reftable/reftable-stack.h"
> +#include "../reftable/reftable-record.h"
> +#include "../reftable/reftable-error.h"
> +#include "../reftable/reftable-blocksource.h"

This header can be dropped too.

> +#include "../reftable/reftable-reader.h"

This also.

> +#include "../reftable/reftable-iterator.h"
> +#include "../reftable/reftable-merged.h"
> +#include "../reftable/reftable-generic.h"

This one as well.

> +#include "../setup.h"
> +#include "../strmap.h"
> +#include "../worktree.h"

This one too.

> +struct reftable_ref_store {
> +	struct ref_store base;
> +
> +	struct reftable_stack *main_stack;
> +	struct reftable_stack *worktree_stack;
> +	struct strmap worktree_stacks;
> +	struct reftable_write_options write_options;
> +
> +	unsigned int store_flags;
> +	int err;
> +};

So, I'm assuming that `main_stack` here would be the primary reference
db, even when inside the worktree. I'm wondering why we can't just have

    struct reftable_stack *current_stack;
    struct strmap worktree_stacks;

Reading further on, it becomes necessary to have both, because the user
could
    1. Request main-worktree/{ref}
    2. Request worktrees/{worktree}/{ref}
So it's important that we have access to both the main worktree, the
current worktree and also any other worktree.

Maybe we could just drop the `struct reftable_stack *worktree_stack` and
rely on the map entirely, but I guess `worktree_stack` acts as a caching
layer and avoids using the map unless necessary.

> +static struct ref_store *reftable_be_init(struct repository *repo,
> +					  const char *gitdir,
> +					  unsigned int store_flags)
> +{
> +	struct reftable_ref_store *refs =3D xcalloc(1, sizeof(*refs));
> +	struct strbuf path =3D STRBUF_INIT;
> +	int is_worktree;
> +	mode_t mask;
> +
> +	mask =3D umask(0);
> +	umask(mask);

Took me more than a glance to understand this. For other readers who
didn't know: there is no single API to get the current umask. But
umask(2) sets the umask and returns the prev umask. So we set a random
value (here 0) to get the prev umask and reset it.

> +
> +	base_ref_store_init(&refs->base, repo, gitdir, &refs_be_reftable);
> +	strmap_init(&refs->worktree_stacks);
> +	refs->store_flags =3D store_flags;
> +	refs->write_options.block_size =3D 4096;
>

Perhaps use `DEFAULT_BLOCK_SIZE` from "reftable/constants.h" here.

> +	refs->write_options.hash_id =3D repo->hash_algo->format_id;
> +	refs->write_options.default_permissions =3D calc_shared_perm(0666 & ~ma=
sk);
> +
> +	/*
> +	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
> +	 * This stack contains both the shared and the main worktree refs.
> +	 */
> +	is_worktree =3D get_common_dir_noenv(&path, gitdir);
> +	if (!is_worktree) {
> +		strbuf_reset(&path);
> +		strbuf_realpath(&path, gitdir, 0);
> +	}

Nit: would be nice to have a comment that for wortrees, `gitdir` would
already be an absolute path.

> +	strbuf_addstr(&path, "/reftable");
> +	refs->err =3D reftable_new_stack(&refs->main_stack, path.buf,
> +				       refs->write_options);
> +	if (refs->err)
> +		goto done;
> +
> +	/*
> +	 * If we're in a worktree we also need to set up the worktree reftable
> +	 * stack that is contained in the per-worktree GIT_DIR.
> +	 */
> +	if (is_worktree) {
> +		strbuf_reset(&path);
> +		strbuf_addf(&path, "%s/reftable", gitdir);
> +
> +		refs->err =3D reftable_new_stack(&refs->worktree_stack, path.buf,
> +					       refs->write_options);
> +		if (refs->err)
> +			goto done;
> +	}

Wondering if we should also add this to the `refs->worktree_stacks`.

> +struct reftable_ref_iterator {
> +	struct ref_iterator base;
> +	struct reftable_ref_store *refs;
> +	struct reftable_iterator iter;
> +	struct reftable_ref_record ref;
> +	struct object_id oid;
> +
> +	const char *prefix;
> +	unsigned int flags;
> +	int err;
> +};

So the `flags` in this structure are for the iterator itself but the
`flags` in `base` are flags related to the current ref stored in `base`.

> +static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterat=
or)
> +{
> +	struct reftable_ref_iterator *iter =3D
> +		(struct reftable_ref_iterator *)ref_iterator;
> +	struct reftable_ref_store *refs =3D iter->refs;
> +
> +	while (!iter->err) {
> +		int flags =3D 0;
> +

Nit: I think the syntax in `reftable_reflog_iterator_advance` is similar bu=
t
nicer to read, the usage of `while(1)` and returning within the while
loop is better than breaking here and returning outside, either ways, I
think it'd be nicer to make both of them consistent.

> +		iter->err =3D reftable_iterator_next_ref(&iter->iter, &iter->ref);
> +		if (iter->err)
> +			break;
> +
> +		/*
> +		 * The files backend only lists references contained in
> +		 * "refs/". We emulate the same behaviour here and thus skip
> +		 * all references that don't start with this prefix.
> +		 */
> +		if (!starts_with(iter->ref.refname, "refs/"))
> +			continue;
> +

Since my patch series [1] to print all refs is now merged to next, maybe
you could add this in?

    diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
    index 895de0b273..3f4f905292 100644
    --- a/refs/reftable-backend.c
    +++ b/refs/reftable-backend.c
    @@ -348,11 +348,10 @@ static int
reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
     			break;

     		/*
    -		 * The files backend only lists references contained in
    -		 * "refs/". We emulate the same behaviour here and thus skip
    -		 * all references that don't start with this prefix.
    +		 * Unless the `DO_FOR_EACH_INCLUDE_ALL_REFS` flag is use, we only
    +		 * list references contained in "refs/" to mimic the file-backend.
     		 */
    -		if (!starts_with(iter->ref.refname, "refs/"))
    +		if (!(iter->flags & DO_FOR_EACH_INCLUDE_ALL_REFS) &&
!starts_with(iter->ref.refname, "refs/"))
     			continue;

     		if (iter->prefix &&

> +static enum iterator_selection iterator_select(struct ref_iterator *iter=
_worktree,
> +					       struct ref_iterator *iter_common,
> +					       void *cb_data UNUSED)
> +{
> +	if (iter_worktree && !iter_common) {
> +		/*
> +		 * Return the worktree ref if there are no more common refs.
> +		 */
> +		return ITER_SELECT_0;
> +	} else if (iter_common) {
> +		/*
> +		 * In case we have pending worktree and common refs we need to
> +		 * yield them based on their lexicographical order. Worktree
> +		 * refs that have the same name as common refs shadow the
> +		 * latter.
> +		 */
> +		if (iter_worktree) {
> +			int cmp =3D strcmp(iter_worktree->refname,
> +					 iter_common->refname);
> +			if (cmp < 0)
> +				return ITER_SELECT_0;
> +			else if (!cmp)
> +				return ITER_SELECT_0_SKIP_1;
> +		}
> +
> +		 /*
> +		  * Otherwise, if we either have no worktree refs anymore or if
> +		  * the common ref sorts before the next worktree ref, we need
> +		  * to figure out whether the next common ref belongs to the
> +		  * main worktree. In that case, it should be ignored.
> +		  */
> +		if (parse_worktree_ref(iter_common->refname, NULL, NULL,
> +				       NULL) =3D=3D REF_WORKTREE_SHARED)
> +			return ITER_SELECT_1;
> +

I'm not sure I understand this. When would this situation occur?

> +		return ITER_SKIP_1;
> +	} else {
> +		return ITER_DONE;
> +	}
> +}
> +
> +
> +static int reftable_be_transaction_prepare(struct ref_store *ref_store,
> +					   struct ref_transaction *transaction,
> +					   struct strbuf *err)
> +{
> +	struct reftable_ref_store *refs =3D
> +		reftable_be_downcast(ref_store, REF_STORE_WRITE|REF_STORE_MAIN, "ref_t=
ransaction_prepare");
> +	struct strbuf referent =3D STRBUF_INIT, head_referent =3D STRBUF_INIT;
> +	struct string_list affected_refnames =3D STRING_LIST_INIT_NODUP;
> +	struct reftable_transaction_data *tx_data =3D NULL;
> +	struct object_id head_oid;
> +	unsigned int head_type =3D 0;
> +	size_t i;
> +	int ret;
> +
> +	ret =3D refs->err;
> +	if (ret < 0)
> +		goto done;
> +
> +	tx_data =3D xcalloc(1, sizeof(*tx_data));
> +
> +	/*
> +	 * Preprocess all updates. For one we check that there are no duplicate
> +	 * reference updates in this transaction. Second, we lock all stacks
> +	 * that will be modified during the transaction.
> +	 */
> +	for (i =3D 0; i < transaction->nr; i++) {
> +		ret =3D prepare_transaction_update(NULL, refs, tx_data,
> +						 transaction->updates[i], err);
> +		if (ret)
> +			goto done;
> +
> +		string_list_append(&affected_refnames,
> +				   transaction->updates[i]->refname);
> +	}
> +
> +	/*
> +	 * Now that we have counted updates per stack we can preallocate their
> +	 * arrays. This avoids having to reallocate many times.
> +	 */
> +	for (i =3D 0; i < tx_data->args_nr; i++) {
> +		CALLOC_ARRAY(tx_data->args[i].updates, tx_data->args[i].updates_expect=
ed);
> +		tx_data->args[i].updates_alloc =3D tx_data->args[i].updates_expected;
> +	}
> +
> +	/*
> +	 * Fail if a refname appears more than once in the transaction.
> +	 * This code is taken from the files backend and is a good candidate to
> +	 * be moved into the generic layer.
> +	 */
> +	string_list_sort(&affected_refnames);
> +	if (ref_update_reject_duplicates(&affected_refnames, err)) {
> +		ret =3D TRANSACTION_GENERIC_ERROR;
> +		goto done;
> +	}
> +
> +	ret =3D read_ref_without_reload(stack_for(refs, "HEAD", NULL), "HEAD", =
&head_oid,
> +				      &head_referent, &head_type);
> +	if (ret < 0)
> +		goto done;
> +
> +	for (i =3D 0; i < transaction->nr; i++) {
> +		struct ref_update *u =3D transaction->updates[i];
> +		struct object_id current_oid =3D {0};
> +		struct reftable_stack *stack;
> +		const char *rewritten_ref;
> +
> +		stack =3D stack_for(refs, u->refname, &rewritten_ref);
>

Wondering why we didn't just iterate over `tx_data.args` and
`args[i].updates` since there we already have the required stack.

Update: we don't save rewritten_ref in tx_data, so that's one blocker
for this.

> +
> +		if (u->type & REF_ISSYMREF) {
> +			const char *resolved =3D refs_resolve_ref_unsafe(&refs->base, u->refn=
ame, 0,
> +								       &current_oid, NULL);
> +
> +			if (u->flags & REF_NO_DEREF) {
> +				/*
> +				 * The reftable stack is locked at this point
> +				 * already, so it should be safe to call
> +				 * `refs_resolve_ref_unsafe()` here.
> +				 */

Shouldn't this comment be a few lines before?

> +
> +static int write_transaction_table(struct reftable_writer *writer, void =
*cb_data)
> +{
> +	struct write_transaction_table_arg *arg =3D cb_data;
> +	struct reftable_merged_table *mt =3D
> +		reftable_stack_merged_table(arg->stack);
> +	uint64_t ts =3D reftable_stack_next_update_index(arg->stack);
> +	struct reftable_log_record *logs =3D NULL;
> +	size_t logs_nr =3D 0, logs_alloc =3D 0, i;
> +	int ret =3D 0;
> +
> +	QSORT(arg->updates, arg->updates_nr, transaction_update_cmp);
> +
> +	reftable_writer_set_limits(writer, ts, ts);
> +
> +	for (i =3D 0; i < arg->updates_nr; i++) {
> +		struct reftable_transaction_update *tx_update =3D &arg->updates[i];
> +		struct ref_update *u =3D tx_update->update;
> +
> +		/*
> +		 * Write a reflog entry when updating a ref to point to
> +		 * something new in either of the following cases:
> +		 *
> +		 * - The reference is about to be deleted. We always want to
> +		 *   delete the reflog in that case.
> +		 * - REF_FORCE_CREATE_REFLOG is set, asking us to always create
> +		 *   the reflog entry.
> +		 * - `core.logAllRefUpdates` tells us to create the reflog for
> +		 *   the given ref.
> +		 */
> +		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oi=
d(&u->new_oid)) {
> +			struct reftable_log_record log =3D {0};
> +			struct reftable_iterator it =3D {0};
> +
> +			/*
> +			 * When deleting refs we also delete all reflog entries
> +			 * with them. While it is not strictly required to
> +			 * delete reflogs together with their refs, this
> +			 * matches the behaviour of the files backend.
> +			 *
> +			 * Unfortunately, we have no better way than to delete
> +			 * all reflog entries one by one.
> +			 */
> +			ret =3D reftable_merged_table_seek_log(mt, &it, u->refname);
> +			while (ret =3D=3D 0) {
> +				struct reftable_log_record *tombstone;
> +
> +				ret =3D reftable_iterator_next_log(&it, &log);
> +				if (ret < 0)
> +					break;
> +				if (ret > 0 || strcmp(log.refname, u->refname)) {
> +					ret =3D 0;
> +					break;
> +				}
> +
> +				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
> +				tombstone =3D &logs[logs_nr++];
> +				tombstone->refname =3D xstrdup(u->refname);
> +				tombstone->value_type =3D REFTABLE_LOG_DELETION,

Why is this a comma? one other such instance in this file.

> +static int write_copy_table(struct reftable_writer *writer, void *cb_dat=
a)
> +{
> +	struct write_copy_arg *arg =3D cb_data;
> +	uint64_t deletion_ts, creation_ts;
> +	struct reftable_merged_table *mt =3D reftable_stack_merged_table(arg->s=
tack);
> +	struct reftable_ref_record old_ref =3D {0}, refs[2] =3D {0};
> +	struct reftable_log_record old_log =3D {0}, *logs =3D NULL;
> +	struct reftable_iterator it =3D {0};
> +	struct string_list skip =3D STRING_LIST_INIT_NODUP;
> +	struct strbuf errbuf =3D STRBUF_INIT;
> +	size_t logs_nr =3D 0, logs_alloc =3D 0, i;
> +	int ret;
> +
> +	if (reftable_stack_read_ref(arg->stack, arg->oldname, &old_ref)) {
> +		ret =3D error(_("refname %s not found"), arg->oldname);
> +		goto done;
> +	}
> +	if (old_ref.value_type =3D=3D REFTABLE_REF_SYMREF) {
> +		ret =3D error(_("refname %s is a symbolic ref, copying it is not suppo=
rted"),
> +			    arg->oldname);
> +		goto done;
> +	}
> +
> +	/*
> +	 * There's nothing to do in case the old and new name are the same, so
> +	 * we exit early in that case.
> +	 */
> +	if (!strcmp(arg->oldname, arg->newname)) {
> +		ret =3D 0;
> +		goto done;
> +	}
> +
> +	/*
> +	 * Verify that the new refname is available.
> +	 */
> +	string_list_insert(&skip, arg->oldname);
> +	ret =3D refs_verify_refname_available(&arg->refs->base, arg->newname,
> +					    NULL, &skip, &errbuf);
> +	if (ret < 0) {
> +		error("%s", errbuf.buf);
> +		goto done;
> +	}
> +
> +	/*
> +	 * When deleting the old reference we have to use two update indices:
> +	 * one to delete the old ref and its reflog, and once to create the new
>

s/once/one

> +	 * ref and its reflog. They need to be staged with two separate indices
> +	 * because the new reflog needs to encode both the deletion of the old
> +	 * branch and the creation of the new branch, and we cannot do two
> +	 * changes to a reflog in a single update.
> +	 */
> +	deletion_ts =3D creation_ts =3D reftable_stack_next_update_index(arg->s=
tack);
> +	if (arg->delete_old)
> +		creation_ts++;
> +	reftable_writer_set_limits(writer, deletion_ts, creation_ts);
> +
> +	/*
> +	 * Add the new reference. If this is a rename then we also delete the
> +	 * old reference.
> +	 */
> +	refs[0] =3D old_ref;
> +	refs[0].refname =3D (char *)arg->newname;
> +	refs[0].update_index =3D creation_ts;
> +	if (arg->delete_old) {
> +		refs[1].refname =3D (char *)arg->oldname;
> +		refs[1].value_type =3D REFTABLE_REF_DELETION;
> +		refs[1].update_index =3D deletion_ts;
> +	}
> +	ret =3D reftable_writer_add_refs(writer, refs, arg->delete_old ? 2 : 1)=
;
> +	if (ret < 0)
> +		goto done;
> +
> +	/*
> +	 * When deleting the old branch we need to create a reflog entry on the
> +	 * new branch name that indicates that the old branch has been deleted
> +	 * and then recreated. This is a tad weird, but matches what the files
> +	 * backend does.
> +	 */
> +	if (arg->delete_old) {
> +		struct strbuf head_referent =3D STRBUF_INIT;
> +		struct object_id head_oid;
> +		int append_head_reflog;
> +		unsigned head_type =3D 0;
> +
> +		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
> +		memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
> +		fill_reftable_log_record(&logs[logs_nr]);
> +		logs[logs_nr].refname =3D (char *)arg->newname;
> +		logs[logs_nr].update_index =3D deletion_ts;
> +		logs[logs_nr].value.update.message =3D
> +			xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);

Question: here and other places in this file, shouldn't we free memory
allocated by `xstrndup`?

Also, why is it `block_size / 2` ?

> +static struct reftable_reflog_iterator *reflog_iterator_for_stack(struct=
 reftable_ref_store *refs,
> +								  struct reftable_stack *stack)
> +{
> +	struct reftable_reflog_iterator *iter;
> +	struct reftable_merged_table *mt;
> +	int ret;
> +
> +	iter =3D xcalloc(1, sizeof(*iter));
> +	base_ref_iterator_init(&iter->base, &reftable_reflog_iterator_vtable, 1=
);
> +	iter->refs =3D refs;
> +	iter->base.oid =3D &iter->oid;
> +
> +	ret =3D reftable_stack_reload(refs->main_stack);
> +	if (ret < 0)
> +		goto done;
> +
> +	mt =3D reftable_stack_merged_table(stack);
> +	ret =3D reftable_merged_table_seek_log(mt, &iter->iter, "");
> +	if (ret < 0)
> +		goto done;
> +

Keeping it similar to `ref_iterator_for_stack`, perhaps:

    ret =3D refs->err;
	if (ret)
		goto done;

	ret =3D reftable_stack_reload(stack);
	if (ret)
		goto done;

	merged_table =3D reftable_stack_merged_table(stack);

	ret =3D reftable_merged_table_seek_ref(merged_table, &iter->iter, prefix);
	if (ret)
		goto done;

> +static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *ref=
_store,
> +						   const char *refname,
> +						   each_reflog_ent_fn fn,
> +						   void *cb_data)
> +{
> +	struct reftable_ref_store *refs =3D
> +		reftable_be_downcast(ref_store, REF_STORE_READ, "for_each_reflog_ent_r=
everse");
> +	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
> +	struct reftable_merged_table *mt =3D NULL;
> +	struct reftable_log_record log =3D {0};
> +	struct reftable_iterator it =3D {0};
> +	int ret;
> +
> +	if (refs->err < 0)
> +		return refs->err;

Nit: seems like this function and the one below
`reftable_be_for_each_reflog_ent`, share the same code apart from
iteration direction. Wonder if it'd be nicer to extract out the common
code from them.

> +static int reftable_be_reflog_exists(struct ref_store *ref_store,
> +				     const char *refname)
> +{
> +	struct reftable_ref_store *refs =3D
> +		reftable_be_downcast(ref_store, REF_STORE_READ, "reflog_exists");
> +	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
> +	struct reftable_merged_table *mt =3D reftable_stack_merged_table(stack)=
;
> +	struct reftable_log_record log =3D {0};
> +	struct reftable_iterator it =3D {0};
> +	int ret;
> +
> +	ret =3D refs->err;
> +	if (ret < 0)
> +		goto done;
> +
> +	ret =3D reftable_stack_reload(stack);
> +	if (ret)
> +		goto done;
> +
> +	ret =3D reftable_merged_table_seek_log(mt, &it, refname);
> +	if (ret)
> +		goto done;
> +
> +	/*
> +	 * Seek the reflog to see whether it contains any reflog entries which
> +	 * aren't marked for deletion.
> +	 */

Shouldn't we be checking `log.value_type` in that case?

This email only reviews this file, I'll review the others in follow up
email[s].

[1]: https://git.kernel.org/pub/scm/git/git.git/commit/?h=3Dnext&id=3De7a92=
34a8b39bd69de12b105731413ab8e62942e

--0000000000006d4f330610537f42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 942025a41a6e118b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XN3RoSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWpCQy85c2xIRlFOcEx1YXBVNk1FaSswRmFoQVNYbQp2dGNNZHdLYWpX
Wlp1cWhqZWtraGk5OUlyK0FnQy81akhPMDZRV2lERGpNekZqQlFhdUwyb3VWQ0NWUjNzYXhSCkgv
WE9Bc2l4YTQ1WEpiUTJma3EveFcvb05YSE5mT1pra1IvV01pZE0raHNwdmY3Zy9mZks4VjhUdTA2
R1BESHIKdDZKUjFYZFY1Z0FJSTlkb2JwN1ZTZXFXNUFRZUhNQy9Rc1lMMWVIUWZrL0pkU1lUWWM0
SnMrYStQcmw5Mm5OMQpOc0cydDlDeFIyb3Q0V2w3NzVDN21XQjJsa3VuS3BlN1E3UXQwQlpHV1l6
VlppbG9YRFlJNnhkakpyUGQxYVU2CmNxeXkxWG9jcXp1VXZXbVR6Sy8zWTI3UDBoNFVHTnJseG45
WFJpT0lsVHZhVWhmRGNIZzZnSE8xUDRxY1BoSlMKS25TVjlHanlPZGo3U0tJM2x1QlVBKzZpaUpU
enhhZDEvek5XZG9XNWVyN25KeHJFU0JleE5YdUpiWCtSK2V6Qgp6d2grVjYrVEdveU4yNGNjdlc2
blZwRXhDcSthdTd6SVhKekNMYTdIVHl5NG96RzYzd1hLS2I1YUMvRmZKbjAzCm9QZ1dBT0VRQUtr
QXFDcEVyamdIbklTK1JJRmZDRXVFYkxBSDFzZz0KPXdkVEEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006d4f330610537f42--
