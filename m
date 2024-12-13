Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E411DF268
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091144; cv=none; b=JIKhR444+p7QPF7EHmwic4E7VgIpLJy5tYhgR90070V6Iv4mFNKawYiBKc3F6YlENyToZFL6ZfXDzy+yaZBygIm3UAWV2i8TxCc9OuFFwUOQ0n4IBFvYK2BOeMAo0kDHwP3Bk/vfQqrD+ociiBYVpYfE4nHs2xl5xvA8fARSSTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091144; c=relaxed/simple;
	bh=KMCuD8J8GXbue0TJ/tspKbA+yk7wlOAPwaBL1Zp7gmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYVsCHTGXMbcjhoD31cgk7DbNDDPmGPEwb+d7I8Ax4FATWXXyNee+/xU4ZFtb0xjOejP1pk9G5/kupgOfXOzhvsCG7SPj9iLU0MnoF6HWcoJkssFMNSl4tS129J0BXUqPN6mYiIkyiALXrwm2odIEPl/TXOOPJjL9SccBdkcfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HDFpWKbB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5Kwt/SJS; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HDFpWKbB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5Kwt/SJS"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 52D59254013D;
	Fri, 13 Dec 2024 06:59:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 13 Dec 2024 06:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734091140; x=1734177540; bh=yPM4MD5+Hi
	tlHjh720sXUTwJuVBOoPSAf2h9YOvARXQ=; b=HDFpWKbBnURcXwledOuaEN/3+/
	0CegE4A53Alu3JdzBHMPAZ9PUe/uO+/TiLJMcpc5xMfttqRHuA2x0uj31EwSGMPt
	4upRRXHt5WYGwRnGZ8zRJf/65BDgafozqte46fx5LclLfQsX/HQJWffchyvq+1PY
	unkA5w9kkiDRdA1mfvFMN33qTHAzaCuzRKFB9mdpMPFPns8TfxFSBKjfGFrHKEcM
	qBq9HYokso0OABXYBpj1uXktyk95CiRR+Om+RYcW7J92QsmZ6tGCzrWl6BDm+BXK
	az7Jdw7YoC6trP96w7eBAKB+JXpEOlGwxgGCEh/ShtZhfzmB0Gz6ViU+vsng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734091140; x=1734177540; bh=yPM4MD5+HitlHjh720sXUTwJuVBOoPSAf2h
	9YOvARXQ=; b=5Kwt/SJSYqru76HLvluXIqv8HkXMjiIq4PWRcw5mfE89Aavlc7w
	R2OCxer2pEP8gtPb+nGJQ9rhUVs7YJY50Vgu4WcLWM1rBtmQlkYw5L/sTSwsGdjD
	iaiUHVYH/VlkrRHKCKErD5fJDl9zh9g7Ikar67O8s1gta/pUqXsGiY9EWHB1O5Zk
	uzFP2ib0HgGQzSeuPesKdw5QNyFpuU3UqUxuZujTkjFJSHAVoo931NB4BUoZrOIj
	ATZJHdceVAFAc0rSO7vkEMyUO7WP3lhtuAk/xclNSihi6CX36S6S+bxQPgXNmYt6
	ba8QtRSvNQCfjiXQUgPgBkvvHJXcElcknfA==
X-ME-Sender: <xms:gyFcZ2fpPcmXRRLmyuJfGp16D6GFGSbViN2Z3Sw1JP5Yxb8Xq-3MqQ>
    <xme:gyFcZwMH-RNGdeiCyWdx2loA5cZu0wQiCXKpWXHyA15t7C3zKvBDJH52DqBZSojg1
    R8FvsMZ05UF4kkQiA>
X-ME-Received: <xmr:gyFcZ3gGeUV57zOe2jRS-n39k37jxW9tR68tgkQhdcuZ3ATcHxrtGygtiPn1dKhiQl9kDYB9UaAoDEG_SdlmN1wbFxMvk5vNb570vV28QOh3ixA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:gyFcZz_92psEH4SMSZxZDtQDeOkDpnqNIa0Ug7K2G3WpBjFS7LVqzQ>
    <xmx:gyFcZysyHHCUOpdRvnrmbt-J5oQT_piR6IdLJBMyFLUlryEOpBsGWQ>
    <xmx:gyFcZ6GanhtVdp2XFzljHUUOwVlA67tiArGGZ5tV1aJurCNDSdmQjQ>
    <xmx:gyFcZxMOft65Z51qV3j0Z_xdsext5IpZYN5TR1CijF5G-rfGD4kn3Q>
    <xmx:hCFcZ3NbP74Kl3qOKWHrGW3tSaTNVzcjMhXwVFxveiRX49fqn_GGNpBU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 06:58:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59c56128 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 11:57:17 +0000 (UTC)
Date: Fri, 13 Dec 2024 12:58:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 1/7] path-walk: introduce an object walk by path
Message-ID: <Z1whcUJE-MHAhULO@pks.im>
References: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
 <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
 <b7e9b81e8b32313f00d38257ba731e73d17224cb.1733514358.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e9b81e8b32313f00d38257ba731e73d17224cb.1733514358.git.gitgitgadget@gmail.com>

On Fri, Dec 06, 2024 at 07:45:52PM +0000, Derrick Stolee via GitGitGadget wrote:
> --- /dev/null
> +++ b/path-walk.c
> @@ -0,0 +1,263 @@
> +/*
> + * path-walk.c: implementation for path-based walks of the object graph.
> + */
> +#include "git-compat-util.h"
> +#include "path-walk.h"
> +#include "blob.h"
> +#include "commit.h"
> +#include "dir.h"
> +#include "hashmap.h"
> +#include "hex.h"
> +#include "object.h"
> +#include "oid-array.h"
> +#include "revision.h"
> +#include "string-list.h"
> +#include "strmap.h"
> +#include "trace2.h"
> +#include "tree.h"
> +#include "tree-walk.h"
> +
> +struct type_and_oid_list
> +{
> +	enum object_type type;
> +	struct oid_array oids;
> +};

Nit: formatting of this struct is off.

> +static void push_to_stack(struct path_walk_context *ctx,
> +			  const char *path)
> +{
> +	if (strset_contains(&ctx->path_stack_pushed, path))
> +		return;
> +
> +	strset_add(&ctx->path_stack_pushed, path);
> +	string_list_append(&ctx->path_stack, path);
> +}
> +
> +static int add_children(struct path_walk_context *ctx,
> +			const char *base_path,
> +			struct object_id *oid)
> +{

So this function assumes that `oid` always refers to a tree? I think it
would make sense to clarify this by calling the function accordingly,
like e.g. `add_tree_entries()`.

> +	struct tree_desc desc;
> +	struct name_entry entry;
> +	struct strbuf path = STRBUF_INIT;
> +	size_t base_len;
> +	struct tree *tree = lookup_tree(ctx->repo, oid);
> +
> +	if (!tree) {
> +		error(_("failed to walk children of tree %s: not found"),
> +		      oid_to_hex(oid));
> +		return -1;
> +	} else if (parse_tree_gently(tree, 1)) {
> +		die("bad tree object %s", oid_to_hex(oid));

I wonder whether we maybe shouldn't die but instead return an error in
the spirit of libification.

> +	}
> +	strbuf_addstr(&path, base_path);
> +	base_len = path.len;
> +
> +	parse_tree(tree);
> +	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
> +	while (tree_entry(&desc, &entry)) {
> +		struct type_and_oid_list *list;
> +		struct object *o;
> +		/* Not actually true, but we will ignore submodules later. */
> +		enum object_type type = S_ISDIR(entry.mode) ? OBJ_TREE : OBJ_BLOB;
> +
> +		/* Skip submodules. */
> +		if (S_ISGITLINK(entry.mode))
> +			continue;
> +
> +		if (type == OBJ_TREE) {
> +			struct tree *child = lookup_tree(ctx->repo, &entry.oid);
> +			o = child ? &child->object : NULL;
> +		} else if (type == OBJ_BLOB) {
> +			struct blob *child = lookup_blob(ctx->repo, &entry.oid);
> +			o = child ? &child->object : NULL;
> +		} else {
> +			/* Wrong type? */
> +			continue;

This code is unreachable, so we could make this a `BUG()`. Might also
use a switch instead, but that's more of a stylistic question.

> +		}
> +
> +		if (!o) /* report error?*/
> +			continue;

So this can only happen in case `lookup_tree()` or `lookup_blob()`
run into an error. I think this error should definitely be bubbled up so
that we don't silently skip tree entries in case of repo corruption.

> +		strbuf_setlen(&path, base_len);
> +		strbuf_add(&path, entry.path, entry.pathlen);
> +
> +		/*
> +		 * Trees will end with "/" for concatenation and distinction
> +		 * from blobs at the same path.
> +		 */
> +		if (type == OBJ_TREE)
> +			strbuf_addch(&path, '/');
> +
> +		if (!(list = strmap_get(&ctx->paths_to_lists, path.buf))) {
> +			CALLOC_ARRAY(list, 1);
> +			list->type = type;
> +			strmap_put(&ctx->paths_to_lists, path.buf, list);
> +		}
> +		push_to_stack(ctx, path.buf);
> +
> +		/* Skip this object if already seen. */
> +		if (o->flags & SEEN)
> +			continue;
> +		o->flags |= SEEN;

This made me wonder: why do we only skip the object this late? Couldn't
we already have done so immediately after we have looked up the object
to avoid some work? If not, it might be useful to add a comment why it
has to come this late.

> +		oid_array_append(&list->oids, &entry.oid);
> +	}
> +
> +	free_tree_buffer(tree);
> +	strbuf_release(&path);
> +	return 0;
> +}
> +
> +/*
> + * For each path in paths_to_explore, walk the trees another level
> + * and add any found blobs to the batch (but only if they exist and
> + * haven't been added yet).
> + */
> +static int walk_path(struct path_walk_context *ctx,
> +		     const char *path)
> +{
> +	struct type_and_oid_list *list;
> +	int ret = 0;

Nit: needless initialization.

> +
> +	list = strmap_get(&ctx->paths_to_lists, path);
> +
> +	if (!list->oids.nr)
> +		return 0;
> +
> +	/* Evaluate function pointer on this data. */
> +	ret = ctx->info->path_fn(path, &list->oids, list->type,
> +				 ctx->info->path_fn_data);
> +
> +	/* Expand data for children. */
> +	if (list->type == OBJ_TREE) {
> +		for (size_t i = 0; i < list->oids.nr; i++) {
> +			ret |= add_children(ctx,
> +					    path,
> +					    &list->oids.oid[i]);
> +		}
> +	}
> +
> +	oid_array_clear(&list->oids);
> +	strmap_remove(&ctx->paths_to_lists, path, 1);
> +	return ret;
> +}
> +
> +static void clear_strmap(struct strmap *map)

Nit: this isn't clearing a generic strmap, but rather `paths_to_lists`.
Should we maybe rename it to `clear_paths_to_lists()`?

> +{
> +	struct hashmap_iter iter;
> +	struct strmap_entry *e;
> +
> +	hashmap_for_each_entry(&map->map, &iter, e, ent) {
> +		struct type_and_oid_list *list = e->value;
> +		oid_array_clear(&list->oids);
> +	}
> +	strmap_clear(map, 1);
> +	strmap_init(map);
> +}
> +
> +/**
> + * Given the configuration of 'info', walk the commits based on 'info->revs' and
> + * call 'info->path_fn' on each discovered path.
> + *
> + * Returns nonzero on an error.
> + */
> +int walk_objects_by_path(struct path_walk_info *info)
> +{
> +	const char *root_path = "";
> +	int ret = 0;
> +	size_t commits_nr = 0, paths_nr = 0;
> +	struct commit *c;
> +	struct type_and_oid_list *root_tree_list;
> +	struct path_walk_context ctx = {
> +		.repo = info->revs->repo,
> +		.revs = info->revs,
> +		.info = info,
> +		.path_stack = STRING_LIST_INIT_DUP,
> +		.path_stack_pushed = STRSET_INIT,
> +		.paths_to_lists = STRMAP_INIT
> +	};
> +
> +	trace2_region_enter("path-walk", "commit-walk", info->revs->repo);
> +
> +	/* Insert a single list for the root tree into the paths. */
> +	CALLOC_ARRAY(root_tree_list, 1);
> +	root_tree_list->type = OBJ_TREE;
> +	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
> +	push_to_stack(&ctx, root_path);
> +
> +	if (prepare_revision_walk(info->revs))
> +		die(_("failed to setup revision walk"));
> +
> +	while ((c = get_revision(info->revs))) {
> +		struct object_id *oid = get_commit_tree_oid(c);
> +		struct tree *t;
> +		commits_nr++;
> +
> +		oid = get_commit_tree_oid(c);
> +		t = lookup_tree(info->revs->repo, oid);
> +
> +		if (!t) {
> +			warning("could not find tree %s", oid_to_hex(oid));
> +			continue;
> +		}

Is this error something we should bubble up to the caller? As mentioned
above, I'm being cautious about silently accepting potentially-corrupt
data. Silent in the spirit of the caller not noticing it, not in the
sense of the user not noticing it.

Patrick
