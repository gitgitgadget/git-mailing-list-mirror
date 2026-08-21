Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD2624BBEE
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318274; cv=none; b=aP4FSDxOQPUDf4WnlQNO3/Z3nXY1e5iB6e8FZvCCymaXVSmfpeixAmL+AX2qxkTYTc9gcRPHzY2iP6+2pLBr5oyi+Yp3LgBf9Sm8gPFEWRsjc3seRD8xDklvcjWoCQemhHgH0egLBrA6/csws4SvbMdcG6f/x5aNRK1dWcBuxSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318274; c=relaxed/simple;
	bh=mBtH/eeRm9OkwwK58z06Hq7n/woMblbBH/3tnjBy3tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCEnp4cjqXn7wqgrEa2R3l2b+wOv4RgpPZv/L+zOwmz7yHbm70770ysaho3nlN7ZIQ1Oa3Be7D/38e6k5DMCMo42Z2fGvELXoCKLpnvJR5jcBNTnwavNVdqSVKVAlZuRbr6q00fd/7/0N3niXFf9iByB3eDIm2iPC2xRcmeu9BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hAdIdQF8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LdTZSfRC; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hAdIdQF8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LdTZSfRC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 049B57A001D;
	Fri, 21 Aug 2026 09:17:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 21 Aug 2026 09:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787318263; x=1787404663; bh=Y1QdPcNvde
	Cy9L8v/AEvSyWGFBgKQZTH1dLuOqJkW9Q=; b=hAdIdQF806ScX9tLFQAVuMdxN+
	F6jS34DrwS3LxH5CqHVyuGffgX+yNkG6v8D7p64tOkd+0pH02Ylf4QFT+Na43+ku
	zg0NTI/3cPJNP1wy+56xrbH0srR9EV0pw2hrRNOYdmubTfHziHQDA6mJGQiLyqHX
	dtfU48yN01+PB+OJkTsUrnd7nonC4yoTmcyG1z9VOJ0zybLj+Iiym2imM557HJ9p
	/LI+Rym7GNJqV6W5ozUqXghL33CeYE6AI8ziZWrdPn7tuN+R0YkezNSu99pQQygd
	w4UY8zHnD8Abvz1YFWRX8P6YpWlJYkoZZbkCERO/vx92mLoH2+N8GfXdnziw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787318263; x=1787404663; bh=Y1QdPcNvdeCy9L8v/AEvSyWGFBgKQZTH1dL
	uOqJkW9Q=; b=LdTZSfRCcDFjPLiF0wPxrd/Wjq9nHNx0edmJCv7O/GTrBbOD6/F
	GKIOkn8sqPLw/hujgva0mEyblgvQhL2HAGnMJDlucij7dcbtKh9qSIy7NuwibejR
	aMG1+hcJHh/H64qR/xshy/foBAVVC16I0P6mw8AiN2o568sqDGNWPHbBY6PUJqR0
	+diA27QwJWhjGdnjgWKYPnLJLurxFchnR79/hH5VeDtzbGYcSm95b0nDhRiPQhMq
	1St5AewdOub09OK+oG5f3/50cPiXzI9+qlpE7W9tH74Sj8R9MJmRXFuWJ6tU7B+n
	QBhAWJFpdXCWSYzFrfRJFVvMo4E+/XIxNJQ==
X-ME-Sender: <xms:90-Iags76v-hFPJM40Y_MpBPfH0d8gYOZ2WLDDoCnl4BUHIJJ-dJBw>
    <xme:90-Iak79vBE7HzEQVXP8Zubpxq1_T8o3J4F59HFS_zkJAbBCj-HiCYzG1nLGDTW5X
    xMNeea4htCUnw0utpdacHE2c_otepZdDkzj2lEjHHIJ0n0JffqsIkI>
X-ME-Received: <xmr:90-IapL2cbX63GdD1NXD3DnrgefiD6xRFPXJkCR18ZepflJ5U9g1gT6FJCNP8PLJt2sFqibjlVGCb7P_HytF-X1oaqe5GTQ3HOL8R_PlU40H>
X-ME-Proxy-Cause: dmFkZTEuudJtZOntLBleVJDAH4hhpVnpG/zGmtBanODBkYZqTrjcJK1DQROxBamx9E8UNI
    +uwJZ3AmjNXNDMpDJgJjE0IKjapp4W1sMcYQdfeK8a/NnMMc1N16wcTrBaknzf9CiLqDbY
    O8F7jvp4IAepBG3em1k2L73RjfwG9sFJZEvosMYRL71nHUF8yBGKaEKHd9/IyA4gxtVnG6
    RlMXa8asMwDKSNBueN9a2tbaKwT3+1gftzXxO8G/MZaAG5SzF7l7VI3QsJeTC3DlmlsGMp
    aLj4QZ+JVOjMpng+eHTewtW4fmXvuz2jzq61epnuEpiQmS6BGGhzevWa6s/lfY66/QuwO0
    Lr2q47AVAhiOIk5Emp/QXo4LZx43QHY/2unXu/IGKNBwnzNwUYiZvZtYEtjzGNtxZ/H4Vu
    Uc9zmf2wqIdD1BFwTtP2OCTtnUYxN/ic8Vnj0qarq1zFopDyhvZNCKZdPnTK2cXaeiYhkw
    H12xier8nO56hTZSlaDRzt5dmolODIX2wY+tX8nrlD4ugCjNLsw1k7OrWynk9tLQN5g9FC
    n9aQlN4kPww+AQWeQNk5GCg1Sx/3aXLbsHO7ARHgm6tC3vDuXokdwJEQFb9MPe7yPxi/dI
    pBOfmyUvKh96Gk6qwvX19h4OCPXnzl4m5A+Zmgv9zLers6qfl5eqIVxHuzCA
X-ME-Proxy: <xmx:90-Ias6rb3jfjlqbssGyLrK8APjqL3oHlSQCz9JSdP0o1zI6iTMDcQ>
    <xmx:90-Iaky2MAyq4GjuS0K28Mixksdj9QBLHPSdugsoQ8P2ZObyvCrLCw>
    <xmx:90-IaoZnJ_XpTSCpREwUBshF_Cq8E7ZKiSltWYdA-3REYUK2EDrcnA>
    <xmx:90-IauSBJNoHbB5enF_tIyQjFZU9ExvZ4NCzVMDtohn5nnGsKfhNBg>
    <xmx:90-IanV6H52aZhHpG0FPWxIAe5R-hxz-5gVZOeJBeXg7i7tvGz1Xc1df>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 09:17:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c2eceda3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 13:17:40 +0000 (UTC)
Date: Fri, 21 Aug 2026 15:17:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] send-pack: avoid sending the whole tree when pushing
 from a shallow clone
Message-ID: <aohP7GMx9oX3ZCsQ@pks.im>
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>

On Fri, Aug 21, 2026 at 06:55:51AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> When pushing from a shallow clone, even if we only have made a small
> one-line change to a tiny file, we often push the entire toplevel tree
> of files.  For large repositories, this could be gigabytes instead of
> kilobytes.

Oh yeah, that issue. It's a common foot gun indeed, and the common
advice here is to never clone with "--depth=1", but always with
"--depth=2" so that there is at least one non-grafted commit available
on the client so that they can indeed perform proper negotiation with a
server. But over the years I had to explain this again and again, so it
is clear that this common knowledge might only be commonly known to
people who have spent way too much time in the Git codebase.

> The reason for this is that the push likely lacks the commits the
> receiver has advertised, so it walks back to its shallow grafts.  Since
> it doesn't know that the server has anything, it sends the entire tree
> for the graft.  It would also send the parents of the shallow graft,
> except the shallow clone doesn't have those by construction.  We thus
> are forced to assume that the server has the parents of the shallow
> graft -- if it doesn't, the server's receive-pack will reject the push.
> 
> But that raises the obvious question: if we're going to assume the
> server has the parents of the shallow graft, why not just assume the
> server has the shallow graft itself -- which this clone almost certainly
> received from the server when the shallow clone was created?

It's a good question to ask. In theory though, can't it happen that the
client changes the commit in question locally, e.g. via `git commit
--amend`, and then pushes? If we now assume that the local commit exists
on the remote side then we'd be insufficient information to the server.

> As noted
> above, receive-pack already has a builtin connectivity check that
> predates pushing from a shallow clone by years[*], so even if a client
> is pushing to a different server than it cloned from, the worst that
> happens is a rejected push.  And by assuming the server has the shallow
> graft commits, then for large repositories (those most likely to use
> shallow clone) we can avoid transferring (and perhaps re-compressing)
> gigabytes of file contents that the server already has.

Right, the server would catch that case and abort the push. But it
highlights the need for an escape hatch, and it makes me wonder what the
current behaviour is when the grafted commit got modified. I guess
nothing good comes out of it.

There's another question though: can we properly determine whether the
tree of the grafted commit matches a tree that the remote side has, for
example example by including the tree in the reference negotiation? I
have no idea whether that would break git-recieve-pack(1) or any other
clients out there, as I don't think we ever negotiated down to trees
until now. But in theory, there isn't really much of a reason why we
cannot do so.

[snip]
> Update the existing shallow-seeding tests in t5538 to set
> push.shallowExcludeBoundary=false, since they exercise that
> receive.shallowUpdate path.  Add tests for the optimized default and the
> opt-out, that a rejected ref does not cause an accepted ref to be
> over-excluded, and that a shallowUpdate receiver still rejects a
> rootless snapshot by default.

Do we have tests that modify the grafted commit? It would be good to
learn how such pushes behave right now, and how the proposed change
modifies it.

[snip]
>     Users can work around the problem described in this patch with
>     push.negotiate=true, but while we can educate some users to set that,
>     trying to get them all to do so is quite unlikely. Let's help users by
>     providing sane default behavior.

Makes me wonder whether the default is something that we should adjust
so that this defaults to enabled. Are there any downsides to doing so?

> diff --git a/send-pack.c b/send-pack.c
> index f20460fbf4..9a035d7403 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -55,6 +56,86 @@ static void append_negative_object(struct repository *r,
>  	oid_array_append(haves, oid);
>  }
>  
> +static int check_to_send_update(const struct ref *ref, const struct send_pack_args *args);
> +
> +/*
> + * Add the shallow grafts (nr_parent == -1), which are reachable from the
> + * refs being pushed, to the pack boundary ("haves") as uninteresting
> + * (negative) tips so the generated pack leaves out everything beneath them.
> + *
> + * Walk only from the pushed tips, and only until a graft: using a graft
> + * that does not bound the pushed history could exclude an object we are
> + * genuinely sending (if it is also reachable from that unrelated graft).
> + * Stop early at any commit the peer already has, since it is a negative
> + * the peer can use and the graft beneath it would be redundant.
> + */
> +static void append_reachable_shallow_grafts(struct repository *r,
> +					    struct ref *refs,
> +					    struct oid_array *advertised,
> +					    struct oid_array *negotiated,
> +					    struct send_pack_args *args,
> +					    struct oid_array *haves)

Nit: it might make sense to mark those parameters as `const` that are
only used as input.

> +{
> +	struct commit_list *pending = NULL;
> +	struct oidset seen = OIDSET_INIT;
> +	struct oidset known = OIDSET_INIT;
> +	struct ref *ref;
> +	size_t i;
> +
> +	for (i = 0; i < advertised->nr; i++)
> +		oidset_insert(&known, &advertised->oid[i]);
> +	for (i = 0; i < negotiated->nr; i++)
> +		oidset_insert(&known, &negotiated->oid[i]);
> +	for (ref = refs; ref; ref = ref->next)
> +		if (!is_null_oid(&ref->old_oid))
> +			oidset_insert(&known, &ref->old_oid);

Okay, here we assemble the list of all objects that the remote is
supposed to know about.

> +	for (ref = refs; ref; ref = ref->next) {
> +		struct commit *commit;
> +
> +		if (is_null_oid(&ref->new_oid))
> +			continue;
> +		if (check_to_send_update(ref, args))
> +			continue;
> +		commit = lookup_commit_reference_gently(r, &ref->new_oid, 1);
> +		if (commit)
> +			commit_list_insert(commit, &pending);
> +	}

Hm. Why do we loop through the refs twice? Wouldn't it be possible to
combine both loops?

> +	while (pending) {
> +		struct commit *commit = pop_commit(&pending);
> +		const struct object_id *oid = &commit->object.oid;
> +		struct commit_graft *graft;
> +		struct commit_list *parent;
> +
> +		if (oidset_insert(&seen, oid))
> +			continue;
> +
> +		/*
> +		 * A commit the peer already has bounds the pushed history
> +		 * with a negative it can use, so stop here rather than
> +		 * descend to a graft that would only be redundant.
> +		 */
> +		if (oidset_contains(&known, oid) &&
> +		    odb_has_object(r->objects, oid, 0))
> +			continue;

We abort the walk whenever we hit any of the objects in our walk that
the remote supposedly already knows about.

> +		graft = lookup_commit_graft(r, oid);
> +		if (graft && graft->nr_parent == -1) {
> +			append_negative_object(r, haves, oid);
> +			continue;
> +		}

And when hitting a graft we explicitly add that graf to the negative
objects, too, so that we include the graft itself and its tree.
Logic-wise this make sense, pending the above questions around whether a
graft can be modified locally.

> +		if (repo_parse_commit(r, commit))
> +			continue;
> +		for (parent = commit->parents; parent; parent = parent->next)
> +			commit_list_insert(parent->item, &pending);
> +	}
> +
> +	oidset_clear(&seen);
> +	oidset_clear(&known);
> +}

Instead of doing a manual walk like this, shouldn't we use higher-level
interfaces like `repo_is_descendant_of()` that can make use of commit
graphs? That might be overkill though as we can assume that in most
shallow repositories we won't have deep commit history anyway.

I guess the answer is "no" though, as you don't only want to check
reachability, but also whether any commit in between is part of the
commits that either we or the server has advertised.

Thanks!

Patrick
