Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3211C7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 07:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbjFFHBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 03:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbjFFHBG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 03:01:06 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C4DE6F
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 00:01:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3DFAA3200908;
        Tue,  6 Jun 2023 03:00:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 06 Jun 2023 03:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686034858; x=1686121258; bh=qQ
        sXNIlHNSv7s0dJ8pX5VCayxOFEv7V0sDQGB9KFqgE=; b=Gk/VWRy+kzc+B0kFqD
        GisLcoBSBC0Mp+5XE6awAbTnY3+e2xEDQIFcfbvZQS9b+VtmeVlTW9Pq7OsmDf6B
        HCK3AADheBplXXjCHcb4D7gt9XnGBRUFKDikQD7WrClixi2UdsCcbMhuh5JbT4j8
        Ud0NEyjwo/6OOGSrSl4iVwYjxRHwn/pDGZvaCSqZQOwblGTQtpTbGLxKKHQqdVaq
        ep8lPGHwIEl9aSFYzl5Wze607La5TcZ/x7jxnsJWlnToWFfrbkERp78WKwqT6Bwg
        SvC7CJLgO5zJ3J5mvj544m/yzMzqKhI7gU/L5TC7no9vw/As4NjhbV0zXfpbL69O
        MZ2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686034858; x=1686121258; bh=qQsXNIlHNSv7s
        0dJ8pX5VCayxOFEv7V0sDQGB9KFqgE=; b=mSeK7MYqTINpVgFfzZmvDS6lmepiT
        yBIYrilhZqyHIkjeVFyq4KMdM/wTLXvF2jxH3hUJ+Ikbr2pS99AX1RzUbuEli3xq
        KE94wfe/Dn25lTqnhQzGOTqF7Rs9ODMRDFS231oZVjwdIV3At4oSHHVWCc/8DIE+
        kdYhGFJZmEMMEAfVlT4AOeg/vdVFBQm43Q6V3Ism9UD1g+TBahyfxMJ+0ZonGkkD
        MhuhpajxX/MrSE6ponLnbFI13riGIPKV96/E+N5p/SRS/0XNYhCBKQQ4K3biTJSA
        fM94/pEfykMIwpyDGYlVeRjgXAMxmbps3tmthRmZeR5sYelKybQhQNGmA==
X-ME-Sender: <xms:qtl-ZLNZH8ACcP2b8i--cOMtAE9hPvtNCOI4GJlwh-geSmUZNbZjPw>
    <xme:qtl-ZF8f6iprU-7HQKFAJo1iXtDcTP-U2BvT-pQ-wJsXhjgOAYk24AXJ8la2FYjqA
    onTC4IOpMnRwcAa4A>
X-ME-Received: <xmr:qtl-ZKQN0-JtipOnNusE9oKUlKEdtXZ195i_XnnbfwtbUzWbIXnXInNtye-KhOFa4Ofe9_FFSCd-1wPwva6kbZNfwb8GCcZt6kuwKECwC30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:qtl-ZPuSMULHw0n-blYdNSQAiZ92_-BMGeE9HIuY5tdEdvnZANi3wA>
    <xmx:qtl-ZDfb0B5UJG3ULZSWHg7zOlmVPOGTBlRcM1B9-fJcuH0NMotqVQ>
    <xmx:qtl-ZL1cew3vFIuQe72XSM5p7urq8led5ewA1cgyHVvIeDZGPyPoDg>
    <xmx:qtl-ZK5LXZmH0IIuS5bfUI3H7wQtyNdWygbfJ412rDb0rmRBd1Bxfg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 03:00:56 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id eada71c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Jun 2023 06:59:50 +0000 (UTC)
Date:   Tue, 6 Jun 2023 09:00:52 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/16] refs/packed-backend.c: implement jump lists to
 avoid excluded pattern(s)
Message-ID: <ZH7ZpB8eMBZN8q63@ncase>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
 <8c78f49a8def4148c92cdd7efe4daa63fb47f641.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9TARcCmEP3GE7WL6"
Content-Disposition: inline
In-Reply-To: <8c78f49a8def4148c92cdd7efe4daa63fb47f641.1684178576.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9TARcCmEP3GE7WL6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 03:23:33PM -0400, Taylor Blau wrote:
> When iterating through the `packed-refs` file in order to answer a query
> like:
>=20
>     $ git for-each-ref --exclude=3Drefs/__hidden__
>=20
> it would be useful to avoid walking over all of the entries in
> `refs/__hidden__/*` when possible, since we know that the ref-filter
> code is going to throw them away anyways.
>=20
> In certain circumstances, doing so is possible. The algorithm for doing
> so is as follows:
>=20
>   - For each excluded pattern, find the first record that matches it,
>     and the first record that *doesn't* match it (i.e. the location
>     you'd next want to consider when excluding that pattern).
>=20
>   - Sort the set of excluded regions from the previous step in ascending
>     order of the first location within the `packed-refs` file that
>     matches.
>=20
>   - Clean up the results from the previous step: discard empty regions,
>     and combine adjacent regions.
>=20
> Then when iterating through the `packed-refs` file, if `iter->pos` is
> ever contained in one of the regions from the previous steps, advance
> `iter->pos` past the end of that region, and continue enumeration.
>=20
> Note that we only perform this optimization when none of the excluded
> pattern(s) have special meta-characters in them. For a pattern like
> "refs/foo[ac]", the excluded regions ("refs/fooa", "refs/fooc", and
> everything underneath them) are not connected. A future implementation
> that handles this case may split the character class (pretending as if
> two patterns were excluded: "refs/fooa", and "refs/fooc").
>=20
> There are a few other gotchas worth considering. First, note that the
> jump list is sorted, so once we jump past a region, we can avoid
> considering it (or any regions preceding it) again. The member
> `jump_pos` is used to track the first next-possible region to jump
> through.
>=20
> Second, note that the exclusion list is best-effort, since we do not
> handle loose references, and because of the meta-character issue above.
>=20
> In repositories with a large number of hidden references, the speed-up
> can be significant. Tests here are done with a copy of linux.git with a
> reference "refs/pull/N" pointing at every commit, as in:
>=20
>     $ git rev-list HEAD | awk '{ print "create refs/pull/" NR " " $0 }' |
>         git update-ref --stdin
>     $ git pack-refs --all
>=20
> , it is significantly faster to have `for-each-ref` jump over the
> excluded references, as opposed to filtering them out after the fact:
>=20
>     $ hyperfine \
>       'git for-each-ref --format=3D"%(objectname) %(refname)" | grep -vE =
"^[0-9a-f]{40} refs/pull/"' \
>       'git.compile for-each-ref --format=3D"%(objectname) %(refname)" --e=
xclude=3D"refs/pull"'
>     Benchmark 1: git for-each-ref --format=3D"%(objectname) %(refname)" |=
 grep -vE "^[0-9a-f]{40} refs/pull/"
>       Time (mean =C2=B1 =CF=83):     802.7 ms =C2=B1   2.1 ms    [User: 6=
91.6 ms, System: 147.0 ms]
>       Range (min =E2=80=A6 max):   800.0 ms =E2=80=A6 807.7 ms    10 runs
>=20
>     Benchmark 2: git.compile for-each-ref --format=3D"%(objectname) %(ref=
name)" --exclude=3D"refs/pull"
>       Time (mean =C2=B1 =CF=83):       4.7 ms =C2=B1   0.3 ms    [User: 0=
=2E7 ms, System: 4.0 ms]
>       Range (min =E2=80=A6 max):     4.3 ms =E2=80=A6   6.7 ms    422 runs
>=20
>     Summary
>       'git.compile for-each-ref --format=3D"%(objectname) %(refname)" --e=
xclude=3D"refs/pull"' ran
>       172.03 =C2=B1 9.60 times faster than 'git for-each-ref --format=3D"=
%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"'
>=20
> Using the jump list is fairly straightforward (see the changes to
> `refs/packed-backend.c::next_record()`), but constructing the list is
> not. To ensure that the construction is correct, add a new suite of
> tests in t1419 covering various corner cases (overlapping regions,
> partially overlapping regions, adjacent regions, etc.).
>=20
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  ref-filter.c              |   5 +-
>  refs/packed-backend.c     | 166 ++++++++++++++++++++++++++++++++++++--
>  t/helper/test-ref-store.c |  10 +++
>  t/t1419-exclude-refs.sh   | 101 +++++++++++++++++++++++
>  4 files changed, 274 insertions(+), 8 deletions(-)
>  create mode 100755 t/t1419-exclude-refs.sh
>=20
> diff --git a/ref-filter.c b/ref-filter.c
> index 717c3c4bcf..ddc7f5204f 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2210,12 +2210,13 @@ static int for_each_fullref_in_pattern(struct ref=
_filter *filter,
>  	if (!filter->name_patterns[0]) {
>  		/* no patterns; we have to look at everything */
>  		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
> -						 "", NULL, cb, cb_data);
> +						 "", filter->exclude.v, cb, cb_data);
>  	}
> =20
>  	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_reposit=
ory),
>  						 NULL, filter->name_patterns,
> -						 NULL, cb, cb_data);
> +						 filter->exclude.v,
> +						 cb, cb_data);
>  }
> =20
>  /*
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 33639f73e1..67327e579c 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -303,7 +303,8 @@ static int cmp_packed_ref_records(const void *v1, con=
st void *v2)
>   * Compare a snapshot record at `rec` to the specified NUL-terminated
>   * refname.
>   */
> -static int cmp_record_to_refname(const char *rec, const char *refname)
> +static int cmp_record_to_refname(const char *rec, const char *refname,
> +				 int start)
>  {
>  	const char *r1 =3D rec + the_hash_algo->hexsz + 1;
>  	const char *r2 =3D refname;
> @@ -312,7 +313,7 @@ static int cmp_record_to_refname(const char *rec, con=
st char *refname)
>  		if (*r1 =3D=3D '\n')
>  			return *r2 ? -1 : 0;
>  		if (!*r2)
> -			return 1;
> +			return start ? 1 : -1;
>  		if (*r1 !=3D *r2)
>  			return (unsigned char)*r1 < (unsigned char)*r2 ? -1 : +1;
>  		r1++;
> @@ -528,7 +529,8 @@ static int load_contents(struct snapshot *snapshot)
>  }
> =20
>  static const char *find_reference_location_1(struct snapshot *snapshot,
> -					     const char *refname, int mustexist)
> +					     const char *refname, int mustexist,
> +					     int start)
>  {
>  	/*
>  	 * This is not *quite* a garden-variety binary search, because
> @@ -558,7 +560,7 @@ static const char *find_reference_location_1(struct s=
napshot *snapshot,
> =20
>  		mid =3D lo + (hi - lo) / 2;
>  		rec =3D find_start_of_record(lo, mid);
> -		cmp =3D cmp_record_to_refname(rec, refname);
> +		cmp =3D cmp_record_to_refname(rec, refname, start);
>  		if (cmp < 0) {
>  			lo =3D find_end_of_record(mid, hi);
>  		} else if (cmp > 0) {
> @@ -591,7 +593,22 @@ static const char *find_reference_location_1(struct =
snapshot *snapshot,
>  static const char *find_reference_location(struct snapshot *snapshot,
>  					   const char *refname, int mustexist)
>  {
> -	return find_reference_location_1(snapshot, refname, mustexist);
> +	return find_reference_location_1(snapshot, refname, mustexist, 1);
> +}
> +
> +/*
> + * Find the place in `snapshot->buf` after the end of the record for
> + * `refname`. In other words, find the location of first thing *after*
> + * `refname`.
> + *
> + * Other semantics are identical to the ones in
> + * `find_reference_location()`.
> + */
> +static const char *find_reference_location_end(struct snapshot *snapshot,
> +					       const char *refname,
> +					       int mustexist)
> +{
> +	return find_reference_location_1(snapshot, refname, mustexist, 0);
>  }
> =20
>  /*
> @@ -785,6 +802,13 @@ struct packed_ref_iterator {
>  	/* The end of the part of the buffer that will be iterated over: */
>  	const char *eof;
> =20
> +	struct jump_list_entry {
> +		const char *start;
> +		const char *end;
> +	} *jump;
> +	size_t jump_nr, jump_alloc;
> +	size_t jump_pos;
>=20
Nit: I had some trouble with `jump_pos` given that it sounds so similar
to `iter->pos`, and thus you tend to think that they both apply to the
position in the packed-refs file. `jump_curr` or `jump_idx` might help
to avoid this confusion.

>  	/* Scratch space for current values: */
>  	struct object_id oid, peeled;
>  	struct strbuf refname_buf;
> @@ -802,14 +826,34 @@ struct packed_ref_iterator {
>   */
>  static int next_record(struct packed_ref_iterator *iter)
>  {
> -	const char *p =3D iter->pos, *eol;
> +	const char *p, *eol;
> =20
>  	strbuf_reset(&iter->refname_buf);
> =20
> +	/*
> +	 * If iter->pos is contained within a skipped region, jump past
> +	 * it.
> +	 *
> +	 * Note that each skipped region is considered at most once,
> +	 * since they are ordered based on their starting position.
> +	 */
> +	while (iter->jump_pos < iter->jump_nr) {
> +		struct jump_list_entry *curr =3D &iter->jump[iter->jump_pos];
> +		if (iter->pos < curr->start)
> +			break; /* not to the next jump yet */
> +
> +		iter->jump_pos++;
> +		if (iter->pos < curr->end) {
> +			iter->pos =3D curr->end;
> +			break;
> +		}
> +	}
> +
>  	if (iter->pos =3D=3D iter->eof)
>  		return ITER_DONE;
> =20
>  	iter->base.flags =3D REF_ISPACKED;
> +	p =3D iter->pos;
> =20
>  	if (iter->eof - p < the_hash_algo->hexsz + 2 ||
>  	    parse_oid_hex(p, &iter->oid, &p) ||
> @@ -917,6 +961,7 @@ static int packed_ref_iterator_abort(struct ref_itera=
tor *ref_iterator)
>  	int ok =3D ITER_DONE;
> =20
>  	strbuf_release(&iter->refname_buf);
> +	free(iter->jump);
>  	release_snapshot(iter->snapshot);
>  	base_ref_iterator_free(ref_iterator);
>  	return ok;
> @@ -928,6 +973,112 @@ static struct ref_iterator_vtable packed_ref_iterat=
or_vtable =3D {
>  	.abort =3D packed_ref_iterator_abort
>  };
> =20
> +static int jump_list_entry_cmp(const void *va, const void *vb)
> +{
> +	const struct jump_list_entry *a =3D va;
> +	const struct jump_list_entry *b =3D vb;
> +
> +	if (a->start < b->start)
> +		return -1;
> +	if (a->start > b->start)
> +		return 1;
> +	return 0;
> +}
> +
> +static int has_glob_special(const char *str)
> +{
> +	const char *p;
> +	for (p =3D str; *p; p++) {
> +		if (is_glob_special(*p))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static const char *ptr_max(const char *x, const char *y)
> +{
> +	if (x > y)
> +		return x;
> +	return y;
> +}
> +
> +static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
> +					struct snapshot *snapshot,
> +					const char **excluded_patterns)
> +{
> +	size_t i, j;
> +	const char **pattern;
> +	struct jump_list_entry *last_disjoint;
> +
> +	if (!excluded_patterns)
> +		return;
> +
> +	for (pattern =3D excluded_patterns; *pattern; pattern++) {
> +		struct jump_list_entry *e;
> +
> +		/*
> +		 * We can't feed any excludes with globs in them to the
> +		 * refs machinery.  It only understands prefix matching.
> +		 * We likewise can't even feed the string leading up to
> +		 * the first meta-character, as something like "foo[a]"
> +		 * should not exclude "foobar" (but the prefix "foo"
> +		 * would match that and mark it for exclusion).
> +		 */
> +		if (has_glob_special(*pattern))
> +			continue;
> +
> +		ALLOC_GROW(iter->jump, iter->jump_nr + 1, iter->jump_alloc);
> +
> +		e =3D &iter->jump[iter->jump_nr++];
> +		e->start =3D find_reference_location(snapshot, *pattern, 0);
> +		e->end =3D find_reference_location_end(snapshot, *pattern, 0);

Nit: we could detect the non-matching case here already, which would
allow us to skip an allocation. It's probably pre-mature optimization
though, so please feel free to ignore.

> +	}
> +
> +	if (!iter->jump_nr) {
> +		/*
> +		 * Every entry in exclude_patterns has a meta-character,
> +		 * nothing to do here.
> +		 */
> +		return;
> +	}
> +
> +	QSORT(iter->jump, iter->jump_nr, jump_list_entry_cmp);
> +
> +	/*
> +	 * As an optimization, merge adjacent entries in the jump list
> +	 * to jump forwards as far as possible when entering a skipped
> +	 * region.
> +	 *
> +	 * For example, if we have two skipped regions:
> +	 *
> +	 *	[[A, B], [B, C]]
> +	 *
> +	 * we want to combine that into a single entry jumping from A to
> +	 * C.
> +	 */
> +	last_disjoint =3D iter->jump;

Nit: if we initialized `j =3D 0`, then `last_disjoint` would always be
equal to `iter->jump[j]`. We could then declare the variable inside of
the loop to make it a bit easier to understand.

Patrick

> +	for (i =3D 1, j =3D 1; i < iter->jump_nr; i++) {
> +		struct jump_list_entry *ours =3D &iter->jump[i];
> +
> +		if (ours->start =3D=3D ours->end) {
> +			/* ignore empty regions (no matching entries) */
> +			continue;
> +		} else if (ours->start <=3D last_disjoint->end) {
> +			/* overlapping regions extend the previous one */
> +			last_disjoint->end =3D ptr_max(last_disjoint->end, ours->end);
> +		} else {
> +			/* otherwise, insert a new region */
> +			iter->jump[j++] =3D *ours;
> +			last_disjoint =3D ours;
> +
> +		}
> +	}
> +
> +	iter->jump_nr =3D j;
> +	iter->jump_pos =3D 0;
> +}
> +
>  static struct ref_iterator *packed_ref_iterator_begin(
>  		struct ref_store *ref_store,
>  		const char *prefix, const char **exclude_patterns,
> @@ -963,6 +1114,9 @@ static struct ref_iterator *packed_ref_iterator_begi=
n(
>  	ref_iterator =3D &iter->base;
>  	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable, 1);
> =20
> +	if (exclude_patterns)
> +		populate_excluded_jump_list(iter, snapshot, exclude_patterns);
> +
>  	iter->snapshot =3D snapshot;
>  	acquire_snapshot(snapshot);
> =20
> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index 6d8f844e9c..2bff003f7c 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -175,6 +175,15 @@ static int cmd_for_each_ref(struct ref_store *refs, =
const char **argv)
>  	return refs_for_each_ref_in(refs, prefix, each_ref, NULL);
>  }
> =20
> +static int cmd_for_each_ref__exclude(struct ref_store *refs, const char =
**argv)
> +{
> +	const char *prefix =3D notnull(*argv++, "prefix");
> +	const char **exclude_patterns =3D argv;
> +
> +	return refs_for_each_fullref_in(refs, prefix, exclude_patterns, each_re=
f,
> +					NULL);
> +}
> +
>  static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
>  {
>  	struct object_id oid =3D *null_oid();
> @@ -307,6 +316,7 @@ static struct command commands[] =3D {
>  	{ "delete-refs", cmd_delete_refs },
>  	{ "rename-ref", cmd_rename_ref },
>  	{ "for-each-ref", cmd_for_each_ref },
> +	{ "for-each-ref--exclude", cmd_for_each_ref__exclude },
>  	{ "resolve-ref", cmd_resolve_ref },
>  	{ "verify-ref", cmd_verify_ref },
>  	{ "for-each-reflog", cmd_for_each_reflog },
> diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
> new file mode 100755
> index 0000000000..bc534c8ea1
> --- /dev/null
> +++ b/t/t1419-exclude-refs.sh
> @@ -0,0 +1,101 @@
> +#!/bin/sh
> +
> +test_description=3D'test exclude_patterns functionality in main ref stor=
e'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> +. ./test-lib.sh
> +
> +for_each_ref__exclude () {
> +	test-tool ref-store main for-each-ref--exclude "$@" >actual.raw
> +	cut -d ' ' -f 2 actual.raw
> +}
> +
> +for_each_ref () {
> +	git for-each-ref --format=3D'%(refname)' "$@"
> +}
> +
> +test_expect_success 'setup' '
> +	test_commit --no-tag base &&
> +	base=3D"$(git rev-parse HEAD)" &&
> +
> +	for name in foo bar baz quux
> +	do
> +		for i in 1 2 3
> +		do
> +			echo "create refs/heads/$name/$i $base" || return 1
> +		done || return 1
> +	done >in &&
> +	echo "delete refs/heads/main" >>in &&
> +
> +	git update-ref --stdin <in &&
> +	git pack-refs --all
> +'
> +
> +test_expect_success 'excluded region in middle' '
> +	for_each_ref__exclude refs/heads refs/heads/foo >actual &&
> +	for_each_ref refs/heads/bar refs/heads/baz refs/heads/quux >expect &&
> +
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'excluded region at beginning' '
> +	for_each_ref__exclude refs/heads refs/heads/bar >actual &&
> +	for_each_ref refs/heads/baz refs/heads/foo refs/heads/quux >expect &&
> +
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'excluded region at end' '
> +	for_each_ref__exclude refs/heads refs/heads/quux >actual &&
> +	for_each_ref refs/heads/foo refs/heads/bar refs/heads/baz >expect &&
> +
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'disjoint excluded regions' '
> +	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/quux >actual=
 &&
> +	for_each_ref refs/heads/baz refs/heads/foo >expect &&
> +
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'adjacent, non-overlapping excluded regions' '
> +	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/baz >actual =
&&
> +	for_each_ref refs/heads/foo refs/heads/quux >expect &&
> +
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'overlapping excluded regions' '
> +	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual &&
> +	for_each_ref refs/heads/foo refs/heads/quux >expect &&
> +
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'several overlapping excluded regions' '
> +	for_each_ref__exclude refs/heads \
> +		refs/heads/bar refs/heads/baz refs/heads/foo >actual &&
> +	for_each_ref refs/heads/quux >expect &&
> +
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'non-matching excluded section' '
> +	for_each_ref__exclude refs/heads refs/heads/does/not/exist >actual &&
> +	for_each_ref >expect &&
> +
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'meta-characters are discarded' '
> +	for_each_ref__exclude refs/heads "refs/heads/ba*" >actual &&
> +	for_each_ref >expect &&
> +
> +	test_cmp expect actual
> +'
> +
> +test_done
> --=20
> 2.40.1.572.g5c4ab523ef
>=20

--9TARcCmEP3GE7WL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR+2aMACgkQVbJhu7ck
PpSjfg//Z/lGKz4xv7EHnIybulWkuvQglsJOscwvVqdOSoBh0NhApFvedyMQqrCN
Ki8B9HCDpCPMamQpQfJSkG8p6DWrCpCAgEQx+Vc6Jh72HBQg9KCA0tCYsqpZ4UyU
Ku1i2MmowSqzxawEJX5rjw4S57OFhZn+tGo02njtMIyjmDYzBIUR1iMjxP1/Kclf
kPiyQkS7QG/LLX1I9jWiojG9k9W4GbG96F8F+K9L5BfFVKI7ir7DJIWfVQktme2q
aHIdPcgIIk1kl8VaR8ikEjUlQnYnc42h8vwbhkVUgrRXjGe0xYYlZreau+yZZyBz
jzhgjloBja/DePuVAwq+gk367INXArE6HmeIzakH6MCnxHm8/69XPw9Shc0KPu1G
jKIOVm2vcwn+muNMlmPGwJn27ixMa8F46Yn8E6sGY1gOOeC2cnA8qpvOrO+IUXR3
GQIGXIlaZoy84qjzzILP3dhFz4pHUFnalxGu3OHu5YtuVlRK1z67NshApRdeJz8Q
czUnxmHjHl0NPuwnBq74uZDeOE/6NQsSF9IT9udegtf7BkaeF5FMCrRs+XIw6xqc
IUIRRqBsMPjxfGIoxzLXQ+amJy+b6VIpYW9N/HrWRP1MI49yNI1x2PmcVMPE68K+
OftdwSTjV6Qqzl0A3hdRBNTTy03ip4fLCzjj+YSGqQXnrXL4Qb8=
=nlad
-----END PGP SIGNATURE-----

--9TARcCmEP3GE7WL6--
