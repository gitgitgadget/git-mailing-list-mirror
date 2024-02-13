Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785BA524AA
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816838; cv=none; b=OvBxFilBPWpY6VS9rnAbZsyWXCf2nour9vdOYaTydAOH/o2kp1NJTbcI/zY0tnCwzX8O9LAjM4HVzfS7CRKO0a5hD6kpkN01gmzzz/mqh623gq00qMGyLxXCULz1uwCxQl/qxZLXYvAgnITOC3DaH9JkQLpmXj90FijG7a0Vs2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816838; c=relaxed/simple;
	bh=Qb2SHZ9G+kswSugGDFHOR5YaLcrUh/JkI91G5Ctpf3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m3rmxrIliDIxTytywza3U86VgMffwVui4ZkO/Ac25fy1rbQsjIyjEorpnQ8shF68o9gJZf9j/+8au3c+x6CJ9EYWxFyt0GiUtAtcxfUyphQDq8JKzJ2JZ71VgwiwGGuJxnm32ggMJAh2p0Sc5zuKzhQOHDKGvDDur0FwKey/GLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NrNNTuOX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NrNNTuOX"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso7211467276.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 01:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707816835; x=1708421635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVbfNG+dUnPBdJ0GJ+ifvGSwSxfvFl4/9D2CnsCumo4=;
        b=NrNNTuOXiV/nQBTV2Zh7VC3P0QT+P4WdQ60nHGUZrZIF2/KOd3dgcc2C3PUOG9Xigr
         nSQtCUe5asbr8ryrfCJ6kYYicKrfLwmDs9bQrWvXpUsiPG8RdebokV1fXFealVtZUVRD
         pqY1IyL1U/CFvCWXXoemal+ND2SXzwqiZwZtkczpnjoO+eA0A6Nwk3HEmtaWiDp60ukh
         2Pj0BLWMpZaEOaOZX2oCr4+ZLHUkTo/lV7bbCzMautON6aFDKdWIDAE4EdKdV556fBJj
         bTth0f52FAFXLycyZvx8keN1VLOOILjnO94lyHiMxLnuLvWk70LP8/huTOpsvhXxtPAa
         aE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707816835; x=1708421635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVbfNG+dUnPBdJ0GJ+ifvGSwSxfvFl4/9D2CnsCumo4=;
        b=vckGUQd7+bqkGwcKCTDXDu3z0MgLCy3CGrQeGD9asdt2WujHS1OKWJ2x9mJWUPHBpQ
         X8QUoQFw82x85mB+9gbsFONqH+qYV173qI8j0nWFnGHCBvAhUakz3LI8EAxX7npz61SY
         vDKC8ximqQbqXtlucQWDUbo6LDVTwl7Ybb0gsk22aW18tNGHoM6pBilvIkitaZrN33Mj
         8A7V5cA2uQtL+sXLTk1HpgMPydeWcdeyALu102ATuAadtjrswjb8DdA/hr8q2WXIzZUn
         NQWZsbi/Xx6CpI/xdPlk8YE4vAeyk754C6C7OGIqdzwua58OPhKge6R1AW5FFmkHNzwJ
         vZRQ==
X-Gm-Message-State: AOJu0YyKrIf7THXsvh7gGT2sKhx88Bpb7TyC6AM1Y9sur4J67J8/fNOx
	2E61gRawIzO93D1LeA6p95i4Qd5c9E8iX26PjFnvO1o1/fFywFBmx9GpTkfLLk9jFCMWQIy5TXm
	X3Q==
X-Google-Smtp-Source: AGHT+IEXgTmY2twlZEmDqkk0eKfR5V6bbfUjHCiLzIAyhqxbZQelW146W5DbMK7091nkyA6Kcy8TceH5ILc=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1109:b0:dc6:207e:e8b1 with SMTP id
 o9-20020a056902110900b00dc6207ee8b1mr2446422ybu.2.1707816835352; Tue, 13 Feb
 2024 01:33:55 -0800 (PST)
Date: Tue, 13 Feb 2024 01:33:53 -0800
In-Reply-To: <20231002024034.2611-3-ebiederm@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org> <20231002024034.2611-3-ebiederm@gmail.com>
Message-ID: <owly7cj8d7y6.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 03/30] object-names: support input of oids in any
 supported hash
From: Linus Arver <linusa@google.com>
To: "Eric W. Biederman" <ebiederm@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Eric Sunshine <sunshine@sunshineco.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> From: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Support short oids encoded in any algorithm, while ensuring enough of
> the oid is specified to disambiguate between all of the oids in the
> repository encoded in any algorithm.
>
> By default have the code continue to only accept oids specified in the
> storage hash algorithm of the repository, but when something is
> ambiguous display all of the possible oids from any accepted oid
> encoding.
>
> A new flag is added GET_OID_HASH_ANY that when supplied causes the
> code to accept oids specified in any hash algorithm, and to return the
> oids that were resolved.
>
> This implements the functionality that allows both SHA-1 and SHA-256
> object names, from the "Object names on the command line" section of
> the hash function transition document.
>
> Care is taken in get_short_oid so that when the result is ambiguous
> the output remains the same if GIT_OID_HASH_ANY was not supplied.  If
> GET_OID_HASH_ANY was supplied objects of any hash algorithm that match
> the prefix are displayed.
>
> This required updating repo_for_each_abbrev to give it a parameter so
> that it knows to look at all hash algorithms.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  builtin/rev-parse.c |  2 +-
>  hash-ll.h           |  1 +
>  object-name.c       | 46 ++++++++++++++++++++++++++++++++++-----------
>  object-name.h       |  3 ++-
>  4 files changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index fde8861ca4e0..43e96765400c 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -882,7 +882,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				continue;
>  			}
>  			if (skip_prefix(arg, "--disambiguate=", &arg)) {
> -				repo_for_each_abbrev(the_repository, arg,
> +				repo_for_each_abbrev(the_repository, arg, the_hash_algo,
>  						     show_abbrev, NULL);
>  				continue;
>  			}
> diff --git a/hash-ll.h b/hash-ll.h
> index 10d84cc20888..2cfde63ae1cf 100644
> --- a/hash-ll.h
> +++ b/hash-ll.h
> @@ -145,6 +145,7 @@ struct object_id {
>  #define GET_OID_RECORD_PATH     0200
>  #define GET_OID_ONLY_TO_DIE    04000
>  #define GET_OID_REQUIRE_PATH  010000
> +#define GET_OID_HASH_ANY      020000

So far the "GET_OID_*" flags sound like the "GET_OID" is the prefix and
the remaining text describes the behavior. So in this sense, the
behavior here would be "HASH_ANY" and I think "ANY_HASH" is better. But
also, going by the description of this flag in the commit message, I
think "ACCEPT_ANY_HASH" is still better.
>
>  #define GET_OID_DISAMBIGUATORS \
>  	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
> diff --git a/object-name.c b/object-name.c
> index 0bfa29dbbfe9..7dd6e5e47566 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -25,6 +25,7 @@
>  #include "midx.h"
>  #include "commit-reach.h"
>  #include "date.h"
> +#include "object-file-convert.h"
>
>  static int get_oid_oneline(struct repository *r, const char *, struct object_id *, struct commit_list *);
>
> @@ -49,6 +50,7 @@ struct disambiguate_state {
>
>  static void update_candidates(struct disambiguate_state *ds, const struct object_id *current)
>  {
> +	/* The hash algorithm of current has already been filtered */

Is this new comment describing existing behavior before this patch or
after?

>  	if (ds->always_call_fn) {
>  		ds->ambiguous = ds->fn(ds->repo, current, ds->cb_data) ? 1 : 0;
>  		return;
> @@ -134,6 +136,8 @@ static void unique_in_midx(struct multi_pack_index *m,
>  {
>  	uint32_t num, i, first = 0;
>  	const struct object_id *current = NULL;
> +	int len = ds->len > ds->repo->hash_algo->hexsz ?
> +		ds->repo->hash_algo->hexsz : ds->len;

Nit: So this is just trying to use the shorter length between ds->len
and hexsz. Would it be good to encode this information into the variable
name, such as "len_short" or similar? And if so, flipping the ">" to
"<" would be more natural, like

    int shorter_len = ds->len < ds->repo->hash_algo->hexsz ?
                      ds->len : ds->repo->hash_algo->hexsz;

because it reads "if ds->len is shorter, use it; otherwise use hexsz".

>  	num = m->num_objects;
>
>  	if (!num)
> @@ -149,7 +153,7 @@ static void unique_in_midx(struct multi_pack_index *m,
>  	for (i = first; i < num && !ds->ambiguous; i++) {
>  		struct object_id oid;
>  		current = nth_midxed_object_oid(&oid, m, i);
> -		if (!match_hash(ds->len, ds->bin_pfx.hash, current->hash))
> +		if (!match_hash(len, ds->bin_pfx.hash, current->hash))
>  			break;
>  		update_candidates(ds, current);
>  	}
> @@ -159,6 +163,8 @@ static void unique_in_pack(struct packed_git *p,
>  			   struct disambiguate_state *ds)
>  {
>  	uint32_t num, i, first = 0;
> +	int len = ds->len > ds->repo->hash_algo->hexsz ?
> +		ds->repo->hash_algo->hexsz : ds->len;

Ditto.

>
>  	if (p->multi_pack_index)
>  		return;
> @@ -177,7 +183,7 @@ static void unique_in_pack(struct packed_git *p,
>  	for (i = first; i < num && !ds->ambiguous; i++) {
>  		struct object_id oid;
>  		nth_packed_object_id(&oid, p, i);
> -		if (!match_hash(ds->len, ds->bin_pfx.hash, oid.hash))
> +		if (!match_hash(len, ds->bin_pfx.hash, oid.hash))
>  			break;
>  		update_candidates(ds, &oid);
>  	}
> @@ -188,6 +194,10 @@ static void find_short_packed_object(struct disambiguate_state *ds)
>  	struct multi_pack_index *m;
>  	struct packed_git *p;
>
> +	/* Skip, unless oids from the storage hash algorithm are wanted */

Perhaps a simpler phrasing would be

    /* Only accept oids specified in the storage hash algorithm of the repository. */

which is closer to the wording of the commit message?

> +	if (ds->bin_pfx.algo && (&hash_algos[ds->bin_pfx.algo] != ds->repo->hash_algo))
> +		return;
> +
>  	for (m = get_multi_pack_index(ds->repo); m && !ds->ambiguous;
>  	     m = m->next)
>  		unique_in_midx(m, ds);
> @@ -326,11 +336,12 @@ int set_disambiguate_hint_config(const char *var, const char *value)
>
>  static int init_object_disambiguation(struct repository *r,
>  				      const char *name, int len,
> +				      const struct git_hash_algo *algo,
>  				      struct disambiguate_state *ds)
>  {
>  	int i;
>
> -	if (len < MINIMUM_ABBREV || len > the_hash_algo->hexsz)
> +	if (len < MINIMUM_ABBREV || len > GIT_MAX_HEXSZ)
>  		return -1;
>
>  	memset(ds, 0, sizeof(*ds));
> @@ -357,6 +368,7 @@ static int init_object_disambiguation(struct repository *r,
>  	ds->len = len;
>  	ds->hex_pfx[len] = '\0';
>  	ds->repo = r;
> +	ds->bin_pfx.algo = algo ? hash_algo_by_ptr(algo) : GIT_HASH_UNKNOWN;
>  	prepare_alt_odb(r);
>  	return 0;
>  }
> @@ -491,9 +503,10 @@ static int repo_collect_ambiguous(struct repository *r UNUSED,
>  	return collect_ambiguous(oid, data);
>  }
>
> -static int sort_ambiguous(const void *a, const void *b, void *ctx)
> +static int sort_ambiguous(const void *va, const void *vb, void *ctx)
>  {
>  	struct repository *sort_ambiguous_repo = ctx;
> +	const struct object_id *a = va, *b = vb;
>  	int a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
>  	int b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
>  	int a_type_sort;
> @@ -503,8 +516,12 @@ static int sort_ambiguous(const void *a, const void *b, void *ctx)
>  	 * Sorts by hash within the same object type, just as
>  	 * oid_array_for_each_unique() would do.
>  	 */
> -	if (a_type == b_type)
> -		return oidcmp(a, b);
> +	if (a_type == b_type) {
> +		if (a->algo == b->algo)
> +			return oidcmp(a, b);
> +		else
> +			return a->algo > b->algo ? 1 : -1;
> +	}

This is duplicated from the previous patch (void_hashcmp). Do we want to
avoid a performance penalty from calling out to a common function?

>  	/*
>  	 * Between object types show tags, then commits, and finally
> @@ -533,8 +550,12 @@ static enum get_oid_result get_short_oid(struct repository *r,
>  	int status;
>  	struct disambiguate_state ds;
>  	int quietly = !!(flags & GET_OID_QUIETLY);
> +	const struct git_hash_algo *algo = r->hash_algo;

I see some existing uses of the name "algop" (presumably to mean
pointer-to-algorithm) and wonder if we should do the same here, for
consistency.

> +
> +	if (flags & GET_OID_HASH_ANY)
> +		algo = NULL;

If we look at the change to init_object_disambiguation() above, it looks
like the "algo" here is only used to find a GIT_HASH_* constant. So it
seems a bit roundabout to use a NULL here, then inside
init_object_disambiguation() do

    ds->bin_pfx.algo = algo ? hash_algo_by_ptr(algo) : GIT_HASH_UNKNOWN;

to convert the NULL to GIT_HASH_UNKNOWN when we could probably just pass
in the GIT_HASH_* constant directly from the caller.

> -	if (init_object_disambiguation(r, name, len, &ds) < 0)
> +	if (init_object_disambiguation(r, name, len, algo, &ds) < 0)
>  		return -1;
>
>  	if (HAS_MULTI_BITS(flags & GET_OID_DISAMBIGUATORS))
> @@ -588,7 +609,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
>  		if (!ds.ambiguous)
>  			ds.fn = NULL;
>
> -		repo_for_each_abbrev(r, ds.hex_pfx, collect_ambiguous, &collect);
> +		repo_for_each_abbrev(r, ds.hex_pfx, algo, collect_ambiguous, &collect);
>  		sort_ambiguous_oid_array(r, &collect);
>
>  		if (oid_array_for_each(&collect, show_ambiguous_object, &out))
> @@ -610,13 +631,14 @@ static enum get_oid_result get_short_oid(struct repository *r,
>  }
>
>  int repo_for_each_abbrev(struct repository *r, const char *prefix,
> +			 const struct git_hash_algo *algo,
>  			 each_abbrev_fn fn, void *cb_data)
>  {
>  	struct oid_array collect = OID_ARRAY_INIT;
>  	struct disambiguate_state ds;
>  	int ret;
>
> -	if (init_object_disambiguation(r, prefix, strlen(prefix), &ds) < 0)
> +	if (init_object_disambiguation(r, prefix, strlen(prefix), algo, &ds) < 0)
>  		return -1;
>
>  	ds.always_call_fn = 1;
> @@ -787,10 +809,12 @@ void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
>  int repo_find_unique_abbrev_r(struct repository *r, char *hex,
>  			      const struct object_id *oid, int len)
>  {
> +	const struct git_hash_algo *algo =
> +		oid->algo ? &hash_algos[oid->algo] : r->hash_algo;

It would be nice to have symmetry with the style in get_short_oid() and
instead do

   const struct git_hash_algo *algo = r->hash_algo;

   if (oid->algo)
       algo = &hash_algos[oid->algo];

>  	struct disambiguate_state ds;
>  	struct min_abbrev_data mad;
>  	struct object_id oid_ret;
> -	const unsigned hexsz = r->hash_algo->hexsz;
> +	const unsigned hexsz = algo->hexsz;
>
>  	if (len < 0) {
>  		unsigned long count = repo_approximate_object_count(r);
> @@ -826,7 +850,7 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
>
>  	find_abbrev_len_packed(&mad);
>
> -	if (init_object_disambiguation(r, hex, mad.cur_len, &ds) < 0)
> +	if (init_object_disambiguation(r, hex, mad.cur_len, algo, &ds) < 0)
>  		return -1;
>
>  	ds.fn = repo_extend_abbrev_len;
> diff --git a/object-name.h b/object-name.h
> index 9ae522307148..064ddc97d1fe 100644
> --- a/object-name.h
> +++ b/object-name.h
> @@ -67,7 +67,8 @@ enum get_oid_result get_oid_with_context(struct repository *repo, const char *st
>
>
>  typedef int each_abbrev_fn(const struct object_id *oid, void *);
> -int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_fn, void *);
> +int repo_for_each_abbrev(struct repository *r, const char *prefix,
> +			 const struct git_hash_algo *algo, each_abbrev_fn, void *);
>
>  int set_disambiguate_hint_config(const char *var, const char *value);
>
> --
> 2.41.0
