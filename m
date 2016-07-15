Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699A22018F
	for <e@80x24.org>; Fri, 15 Jul 2016 11:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbcGOL7q (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 07:59:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:53324 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932565AbcGOL7n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 07:59:43 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MXDo1-1bu9eQ1yVB-00WBDw; Fri, 15 Jul 2016 13:59:39
 +0200
Date:	Fri, 15 Jul 2016 13:59:38 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Kevin Willford <kcwillford@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH] Use path comparison for patch ids before the file
 content
In-Reply-To: <20160714201758.13180-1-kcwillford@gmail.com>
Message-ID: <alpine.DEB.2.20.1607151320330.6426@virtualbox>
References: <20160714201758.13180-1-kcwillford@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:P73N03UyPz9pjtv0shfk5KLJeR5IqaLPPpS2TvGkSqgJV/GzQQN
 VZRzT/giJAIDYVCwS9+9D3BK9OYiEeV0t1WvO/q7uHHvU3YVlYjpeMcj6b6inn3U/mwTwzc
 /VosGcXLo02SACn1cONo3uOPd5wABJQR+U67W7jtDNxEkUor9fW3PtKdNC2p/BviQMljeZ7
 nTFMticZMZdzOTC42ApFw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:X6hnUIqsMQs=:OKPG2jA83dL7Y7g61Dqvz5
 oTeFRojTKiEd2lQZWCAZxcdqOEBszcv0WoNUcO+Go58MI5gEbaoMZKZAXEUo5OZHmWa8rXGXY
 e5KLDJzV3zjD4r81WCQZeqnPsuIHJC1Dc9Spb9O0YFv3brbTPELiCpGUo5o/Wr3MrD2d0awAQ
 jew16H+v1rfVrjklyCVX13rBBilesD55ot6A25GKDcvbfmZVodL5RfC0ukosg8Q4QJSkHb4gm
 SLxS1VVnfWO4NJ9peCFZmhCE+NQHC0S2qXsbryNo3OxSsir/lqlrChBHXQfn70h0apMJhRJ2+
 dZEPCezaAsWBMHtWI8FwrCJxxxjgiG69vjxCwvCAMNUVxML05gSwr0bCz0riz52aTEnI5y4Hy
 urUkVMl1VeWnUQxg/q8X/IKaq7PniOmcMQe/1oVbCEje4FlJoHQvl3J2oBaDAktc51deJWmMm
 opuuYevK9qd1m0urMtI9zprnr8qldAYRHzuvsCM+V3bfplFyUXGTKZf9+aB6IGRQDvzsN4fej
 MaHRuehsZ9MDaHiTKF0/rz4NCA0X6U4s8AVFO9miD/0DQW0AiWjLrnOxNVWlWfutU4JdvYYlp
 vi7FRVxIy4erpaNdQcAlJvZW7+fvkaOOf32LN5oZ2ais+OMTxO8b/2N5q+TBOttNqFCHEepJQ
 w0sI+51q+OYFx4debwWorfbELFzbGfqqlXPMSAEYhLRed+RYjpLP258KxussgdQO+PpM93J3I
 buw8i4YtitWMPawonXTIOQpHVI0yH4fTY3dRQyZI4ALYdogNQpWYCwhcvLhA1uoXMIULiK4ou
 rqJ7ajC
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Kevin,

congratulations for your first patch on the Git mailing list!

On Thu, 14 Jul 2016, Kevin Willford wrote:

> When limiting the list in a revision walk using cherry pick, patch ids are
> calculated by producing the diff of the content of the files.  This would
> be more efficent by using a patch id looking at the paths that were
> changed in the commits and only if all the file changed are the same fall
> back to getting the content of the files in the commits to determine if
> the commits are the same.
> 
> This change uses a hashmap to store entries with a hash of the patch id
> calculated by just using the file paths.  The entries constist of the
> commit and the patch id calculated using file contents which is initially
> empty.  If there are commits that are found in the hashmap it means that
> the same files were changed in the commits and the file contents need to
> be checked in order to determine if the commits are truly the same.  The
> patch id that is calcuated based on the file contents is then stored in the
> hashmap entry if needed in later comparisons.  If the commits are determined to be
> the same the cherry_flag is set on the commit being checked as well as the
> commit in the hashmap entry saving running though the original list of
> commits checking a seen flag.  This will speed up a rebase where the
> upstream has many changes but none of them have been pulled into the
> current branch.
> ---

How about pulling out the change that replaces patch-id's ad-hoc hashmap
with the struct hashmap solution?

It would become a two-part patch series, then.

BTW I tried my hand at a different commit message, maybe you want to
cherry-pick parts of it?

-- snip --
rebase: avoid computing unnecessary patch IDs

The `rebase` family of Git commands avoid applying patches that were
already integrated upstream. They do that by using the revision walking
option that computes the patch IDs of the two sides of the rebase
(local-only patches vs upstream-only ones) and skipping those local
patches whose patch ID matches one of the upstream ones.

In many cases, this causes unnecessary churn, as already the set of
paths touched by a given commit would suffice to determine that an
upstream patch has no local equivalent.

This hurts performance in particular when there are a lot of upstream
patches, and/or large ones.

Therefore, let's introduce the concept of a "header-only" patch ID,
compare those first, and only evaluate the "full" patch ID lazily.

Please note that in contrast to the "full" patch IDs, those "header-only"
patch IDs are prone to collide with one another, as adjacent commits
frequently touch the very same files. Hence we now have to be careful to
allow multiple hash entries with the same hash.
-- snap --

And as Junio pointed out, please add your Signed-off-by: lines (see
https://github.com/git/git/blob/v2.9.1/Documentation/SubmittingPatches#L239-L291
for an explanation).

And here are a couple of comments on the code (please read all the way to
the end, I cut the parts that I do not address):

> diff --git a/diff.c b/diff.c
> index fa78fc1..f38b663 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4449,7 +4449,7 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
>  }
>  
>  /* returns 0 upon success, and writes result into sha1 */
> -static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
> +static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1, int use_path_only)

If we used `diff_header_only`, we could address Junio's concern about the
naming of this parameter.

> diff --git a/patch-ids.c b/patch-ids.c
> index a4d0016..f0262ce 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -4,8 +4,9 @@
>  #include "sha1-lookup.h"
>  #include "patch-ids.h"
>  
> -int commit_patch_id(struct commit *commit, struct diff_options *options,
> -		    unsigned char *sha1)
> +
> +static int ll_commit_patch_id(struct commit *commit, struct diff_options *options,

How about simply changing the signature of the commit_patch_id() function?
It's not like Git guarantees any kind of stable API of its libgit.a or
something.

> +int commit_patch_id(struct commit *commit, struct diff_options *options,
> +		    unsigned char *sha1)
>  {
> -	return sha1_pos(id, table, nr, patch_id_access);
> +	return ll_commit_patch_id(commit, options, sha1, 0);
>  }
>  
> -#define BUCKET_SIZE 190 /* 190 * 21 = 3990, with slop close enough to 4K */
> -struct patch_id_bucket {
> -	struct patch_id_bucket *next;
> -	int nr;
> -	struct patch_id bucket[BUCKET_SIZE];
> -};

The idea of the original code was to get as close to 4kB for the initial
(and probably final) hashmap. I do not think we can, or have to, achieve
the same with struct hashmap. But we should use a larger initial size than
64 (maybe 128? I would actually go for 256, even if that roughly doubles
the initial hashmap size) by passing an explicit value to hashmap_init():

>  int init_patch_ids(struct patch_ids *ids)
>  {
>  	memset(ids, 0, sizeof(*ids));
>  	diff_setup(&ids->diffopts);
>  	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
>  	diff_setup_done(&ids->diffopts);
> +	hashmap_init(&ids->patches, NULL, 0);

Like here (just replace the 0 by 128 or 256).

Also, since the "header-only" patch ID makes hash collisions much more
likely (I, for one, frequently have patches in the same patch series that
touch the very same set of files), we need to provide a hashmap_cmp_fn.

For the hashmap population, I would suggest a function like this:

static int patch_id_cmp(const struct patch_id *a, constr struct patch_id *b,
	const void *keydata)
{
	return hashcmp(a->commit, b->commit);
}

This will guarantee that all the commits will be added to the hash map,
even if some "header-only" patch IDs collide.

(If you go with my suggestion to split out the conversion to the struct
hashmap in a preparatory patch, then you probably want to use
hashcmp(a->patch_id, b->patch_id) in the first patch, and then replace it
with the version above in the second patch.)

Of course, we will need to change the cmpfn after populating the hashmap.
See below for my thoughts on that:

>  	return 0;
>  }
>  
>  int free_patch_ids(struct patch_ids *ids)
>  {
> -	struct patch_id_bucket *next, *patches;
> -
> -	free(ids->table);
> -	for (patches = ids->patches; patches; patches = next) {
> -		next = patches->next;
> -		free(patches);
> -	}
> +	hashmap_free(&ids->patches, 1);
>  	return 0;
>  }
>  
> -static struct patch_id *add_commit(struct commit *commit,
> -				   struct patch_ids *ids,
> -				   int no_add)
> +struct patch_id *has_commit_patch_id(struct commit *commit,
> +				     struct patch_ids *ids)
>  {
> -	struct patch_id_bucket *bucket;
> -	struct patch_id *ent;
> +	struct patch_id *entry;
>  	unsigned char sha1[20];
> -	int pos;
> +	unsigned char sha1_2[20];
> +	struct patch_id key;
>  
> -	if (commit_patch_id(commit, &ids->diffopts, sha1))
> +	if (ll_commit_patch_id(commit, &ids->diffopts, sha1, 1))
>  		return NULL;
> -	pos = patch_pos(ids->table, ids->nr, sha1);
> -	if (0 <= pos)
> -		return ids->table[pos];
> -	if (no_add)
> +
> +	memset(&key, 0, sizeof(key));
> +	hashmap_entry_init(&key, sha1hash(sha1));
> +	key.commit = commit;
> +
> +	entry = hashmap_get(&ids->patches, &key, NULL);
> +	if (!entry)
> +		return NULL;
> +
> +	/*
> +	 * Since we found a match in the hashmap that means the
> +	 * same files where changed in this commit so we need to
> +	 * get the patch id using the contents of the files to
> +	 * compare with each of the commits in the hash bucket
> +	 * to determine if the commits are truely the same
> +	 */
> +	if (ll_commit_patch_id(commit, &ids->diffopts, sha1, 0))
>  		return NULL;
>  
> -	pos = -1 - pos;
> +	for (; entry; entry = hashmap_get_next(&ids->patches, entry)) {
> +		if (is_null_sha1(entry->patch_id))
> +		{
> +			if (ll_commit_patch_id(entry->commit, &ids->diffopts, sha1_2, 0))
> +				return NULL;
> +
> +			hashcpy(entry->patch_id, sha1_2);
> +		}
>  
> -	bucket = ids->patches;
> -	if (!bucket || (BUCKET_SIZE <= bucket->nr)) {
> -		bucket = xcalloc(1, sizeof(*bucket));
> -		bucket->next = ids->patches;
> -		ids->patches = bucket;
> +		if (!hashcmp(entry->patch_id, sha1))
> +			return entry;
>  	}
> -	ent = &bucket->bucket[bucket->nr++];
> -	hashcpy(ent->patch_id, sha1);
> -
> -	ALLOC_GROW(ids->table, ids->nr + 1, ids->alloc);
> -	if (pos < ids->nr)
> -		memmove(ids->table + pos + 1, ids->table + pos,
> -			sizeof(ent) * (ids->nr - pos));
> -	ids->nr++;
> -	ids->table[pos] = ent;
> -	return ids->table[pos];
> -}
>  
> -struct patch_id *has_commit_patch_id(struct commit *commit,
> -				     struct patch_ids *ids)
> -{
> -	return add_commit(commit, ids, 1);
> +	return NULL;
>  }

If you go with my suggestion of patch_id_cmp() above, you will have to
change the cmpfn after the hashmap-populating phase.

Happily, we know that this phase is over as soon as has_commit_patch_id()
is called, and it does not hurt to re-set the cmpfn multiple times.

Even better: if you re-set the cmpfn, you can now use something like this:

static int full_patch_id_cmp(const struct patch_id *a,
    const struct patch_id *b, const diff_options *opt)
{
    if (is_null_sha1(a->patch_id) &&
      commit_patch_id(a->commit, opt, a->patch_id, 0))
        return error("Could not get patch ID for %s",
            oid_to_hex(&a->commit->object.oid));
    if (is_null_sha1(b->patch_id) &&
      commit_patch_id(b->commit, opt, b->patch_id, 0))
        return error("Could not get patch ID for %s",
            oid_to_hex(&b->commit->object.oid));
    return hashcmp(a->patch_id, b->patch_id);
}

With this cmpfn, your has_commit_patch_id() would become something like
this:

struct patch_id *has_commit_patch_id(struct commit *commit,
				     struct patch_ids *ids)
{
	unsigned char sha1[20];
	struct patch_id key;

	if (commit_patch_id(commit, &ids->diffopt, sha1, 1))
		return NULL;

	ids->patches.cmpfn = full_patch_id_cmp;
	memset(&key, 0, sizeof(key));
	key.hash = sha1hash(sha1);
	key.commit = commit;
	return hashmap_get(&ids->patches, &key, &ids->diffopt);
}

>  struct patch_id *add_commit_patch_id(struct commit *commit,
>  				     struct patch_ids *ids)
>  {
> -	return add_commit(commit, ids, 0);
> -}
> +	unsigned char sha1[20];
> +	if (ll_commit_patch_id(commit, &ids->diffopts, sha1, 1))
> +		return NULL;
> +
> +	struct patch_id *key = xmalloc(sizeof(*key));

Git's source code does not allow declarations after statements, therefore
`struct patch_id *key;` needs to come before the if().

> +	memset(key, 0, sizeof(*key));

Since you want to initialize it to zeroes anyway, how about

	key = xcalloc(1, sizeof(*key));

> @@ -873,23 +873,10 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
>  		id = has_commit_patch_id(commit, &ids);
>  		if (!id)
>  			continue;
> -		id->seen = 1;
> -		commit->object.flags |= cherry_flag;
> -	}
> -
> -	/* Now check the original side for seen ones */
> -	for (p = list; p; p = p->next) {
> -		struct commit *commit = p->item;
> -		struct patch_id *ent;
>  
> -		ent = commit->util;
> -		if (!ent)
> -			continue;
> -		if (ent->seen)
> -			commit->object.flags |= cherry_flag;
> -		commit->util = NULL;
> +		commit->object.flags |= cherry_flag;
> +		id->commit->object.flags |= cherry_flag;

I really like this simplification.

>  	}
> -
>  	free_patch_ids(&ids);

Let's keep this empty line here; There is no need to change this existing
code.

BTW I could imagine splitting out even just the feature to compute
header-only patch IDs, and keep the changes to make use of it for a third
patch in the series.

I also think that this patch series could use a test that verifies that we
no longer generate unneeded diffs. Maybe by rebasing a commit on top of an
commit touching a different file, after corrupting the blob of the latter
one? Let me give it a try.

Ciao,
Johannes
