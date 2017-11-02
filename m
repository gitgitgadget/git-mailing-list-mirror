Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0741320281
	for <e@80x24.org>; Thu,  2 Nov 2017 19:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934185AbdKBTcu (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 15:32:50 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:50012 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934065AbdKBTcs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 15:32:48 -0400
Received: by mail-io0-f173.google.com with SMTP id n137so1424599iod.6
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2b2Y/z6QaHObv4yJX84dB323SBx9RqTxBUrqnhigoFo=;
        b=i14035rKV++2V1I1n1R1YnxVmJUddfG/TahP+TLuwdK9jbaolzORvaI1SsjQmbKDUm
         IurhlBVyfkcXGwYa3Nv6aJd9UuZF+/0rmDOMWLPx6dkkENJZNS83sz470B3Co3w7tWiQ
         EJDiKZYdHxXUMJTefWlxYr1uOoIiWZteriY1vOmxMywnEAKkAmG2EFi8ccNDiGm/RHEh
         t3ZO2p+WHxepZrHX/Lhtu1fTzBF5TL6x0p+DO4TfwANJYshAsu1op/g5X2sQQ+sfT/uL
         Va94TP7H1WkBc3sAbhtElgIY0nVnQcPbv0Y599ybYGO9yZ0kv9gYShMeLWJqp6QPEk1b
         oW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2b2Y/z6QaHObv4yJX84dB323SBx9RqTxBUrqnhigoFo=;
        b=SPrKnti6hmseavqRqECg8FVHhggY3sy3tSlM9QiAe+Cp9JFjUXxXKMEAoDFe22nONy
         qlXng2S2sKEoorhHPYw/NZ2B5jL/xVRrGZZL8NleBLTh8D2Bf+1XiEH5Yx5sRDqQaoE7
         GjiCvtsdwTWKqiO5UT2Iyzetytf/8eH7C+RTc1c0CcqC6Lm3YJb/mxJaKCiUMSAzHfUD
         nRAHvNXUSx9AKFbTPPkrrA1MwBzQPrDQSeOv5jTzJTG36Aj1eBiU05kWgxiEG3z/fion
         VGda+ZIBX9jusUxSxb02HIMDB42A7yEi4A/s+lChBdI6U77072RuPR34A2VEVIiY0Xrw
         WOWQ==
X-Gm-Message-State: AMCzsaXg8OUrsNbl44/TSMxrD+1aHQeYCaUY18GCXnMfsyhEeffTLaxF
        xlOpYH9185RSsMICkRMRWsB7Mw==
X-Google-Smtp-Source: ABhQp+TqjIh3pxHROehV+zeTMH5WhYmnkAl5Z7aQDm8uXH26/pO/OiXRiPVXhz3jKLskFp6Q40MTWg==
X-Received: by 10.107.47.69 with SMTP id j66mr6236277ioo.244.1509651167782;
        Thu, 02 Nov 2017 12:32:47 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:2131:f64d:d486:a16f])
        by smtp.gmail.com with ESMTPSA id x26sm184250ita.33.2017.11.02.12.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Nov 2017 12:32:46 -0700 (PDT)
Date:   Thu, 2 Nov 2017 12:32:45 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 4/6] list-objects: filter objects in
 traverse_commit_list
Message-Id: <20171102123245.0f768968703ec4e35d3d1f81@google.com>
In-Reply-To: <20171102175013.3371-5-git@jeffhostetler.com>
References: <20171102175013.3371-1-git@jeffhostetler.com>
        <20171102175013.3371-5-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  2 Nov 2017 17:50:11 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> +int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
> +			      const char *arg)

Returning void is fine, I think. It seems that all your code paths
either return 0 or die.

> +{
> +	struct object_context oc;
> +	struct object_id sparse_oid;
> +	const char *v0;
> +	const char *v1;
> +
> +	if (filter_options->choice)
> +		die(_("multiple object filter types cannot be combined"));
> +
> +	/*
> +	 * TODO consider rejecting 'arg' if it contains any
> +	 * TODO injection characters (since we might send this
> +	 * TODO to a sub-command or to the server and we don't
> +	 * TODO want to deal with legacy quoting/escaping for
> +	 * TODO a new feature).
> +	 */
> +
> +	filter_options->raw_value = strdup(arg);
> +
> +	if (skip_prefix(arg, "blob:", &v0) || skip_prefix(arg, "blobs:", &v0)) {
> +		if (!strcmp(v0, "none")) {
> +			filter_options->choice = LOFC_BLOB_NONE;
> +			return 0;
> +		}
> +
> +		if (skip_prefix(v0, "limit=", &v1) &&
> +		    git_parse_ulong(v1, &filter_options->blob_limit_value)) {
> +			filter_options->choice = LOFC_BLOB_LIMIT;
> +			return 0;
> +		}
> +	}
> +	else if (skip_prefix(arg, "sparse:", &v0)) {

Style: join the 2 lines above.

> +		if (skip_prefix(v0, "oid=", &v1)) {
> +			filter_options->choice = LOFC_SPARSE_OID;
> +			if (!get_oid_with_context(v1, GET_OID_BLOB,
> +						  &sparse_oid, &oc)) {
> +				/*
> +				 * We successfully converted the <oid-expr>
> +				 * into an actual OID.  Rewrite the raw_value
> +				 * in canonoical form with just the OID.
> +				 * (If we send this request to the server, we
> +				 * want an absolute expression rather than a
> +				 * local-ref-relative expression.)
> +				 */

I think this would lead to confusing behavior - for example, a fetch
with "--filter=oid=mybranch:sparseconfig" would have different results
depending on whether "mybranch" refers to a valid object locally.

The way I see it, this should either (i) only accept full 40-character
OIDs or (ii) retain the raw string to be interpreted only when the
filtering is done. (i) is simpler and safer, but is not so useful. In
both cases, if the user really wants client-side interpretation, they
can still use "$(git rev-parse foo)" to make it explicit.

> +				free((char *)filter_options->raw_value);
> +				filter_options->raw_value =
> +					xstrfmt("sparse:oid=%s",
> +						oid_to_hex(&sparse_oid));
> +				filter_options->sparse_oid_value =
> +					oiddup(&sparse_oid);
> +			} else {
> +				/*
> +				 * We could not turn the <oid-expr> into an
> +				 * OID.  Leave the raw_value as is in case
> +				 * the server can parse it.  (It may refer to
> +				 * a branch, commit, or blob we don't have.)
> +				 */
> +			}
> +			return 0;
> +		}
> +
> +		if (skip_prefix(v0, "path=", &v1)) {
> +			filter_options->choice = LOFC_SPARSE_PATH;
> +			filter_options->sparse_path_value = strdup(v1);
> +			return 0;
> +		}
> +	}
> +
> +	die(_("invalid filter expression '%s'"), arg);
> +	return 0;
> +}

[snip]

> +void arg_format_list_objects_filter(
> +	struct argv_array *argv_array,
> +	const struct list_objects_filter_options *filter_options)

Is this function used anywhere (in this patch or subsequent patches)?

> diff --git a/list-objects-filter.c b/list-objects-filter.c
> +/* See object.h and revision.h */
> +#define FILTER_REVISIT (1<<25)

Looking later in the code, this flag indicates that a tree has been
SHOWN, so it might be better to just call this FILTER_SHOWN.

Also document this flag in object.h in the table above FLAG_BITS.

> +static enum list_objects_filter_result filter_blobs_limit(
> +	enum list_objects_filter_type filter_type,
> +	struct object *obj,
> +	const char *pathname,
> +	const char *filename,
> +	void *filter_data_)
> +{
> +	struct filter_blobs_limit_data *filter_data = filter_data_;
> +	unsigned long object_length;
> +	enum object_type t;
> +	int is_special_filename;
> +
> +	switch (filter_type) {
> +	default:
> +		die("unkown filter_type");

Spelling of "unknown" (also elsewhere in this file).

> +		return LOFR_ZERO;
> +
> +	case LOFT_BEGIN_TREE:
> +		assert(obj->type == OBJ_TREE);
> +		/* always include all tree objects */
> +		return LOFR_MARK_SEEN | LOFR_SHOW;
> +
> +	case LOFT_END_TREE:
> +		assert(obj->type == OBJ_TREE);
> +		return LOFR_ZERO;
> +
> +	case LOFT_BLOB:
> +		assert(obj->type == OBJ_BLOB);
> +		assert((obj->flags & SEEN) == 0);
> +
> +		is_special_filename = ((strncmp(filename, ".git", 4) == 0) &&
> +				       filename[4]);

You can just use starts_with(). Also, the filename[4] check is probably
unnecessary.

> +		if (is_special_filename) {
> +			/*
> +			 * Alwayse include ".git*" special files (regardless
> +			 * of size).
> +			 *
> +			 * (This may cause us to include blobs that we do
> +			 * not have locally because we are only looking at
> +			 * the filename and don't actually have to read
> +			 * them.)
> +			 */
> +			goto include_it;
> +		}
> +
> +		t = sha1_object_info(obj->oid.hash, &object_length);
> +		if (t != OBJ_BLOB) { /* probably OBJ_NONE */
> +			/*
> +			 * We DO NOT have the blob locally, so we cannot
> +			 * apply the size filter criteria.  Be conservative
> +			 * and force show it (and let the caller deal with
> +			 * the ambiguity).  (This matches the behavior above
> +			 * when the special filename matches.)
> +			 */
> +			goto include_it;
> +		}
> +
> +		if (object_length < filter_data->max_bytes)
> +			goto include_it;
> +
> +		/*
> +		 * Provisionally omit it.  We've already established
> +		 * that this blob is too big and doesn't have a special
> +		 * filename, so we *WANT* to omit it.  However, there
> +		 * may be a special file elsewhere in the tree that
> +		 * references this same blob, so we cannot reject it
> +		 * just yet.  Leave the LOFR_ bits unset so that *IF*
> +		 * the blob appears again in the traversal, we will
> +		 * be asked again.
> +		 *
> +		 * If we are keeping a list of the ommitted objects,
> +		 * provisionally add it to the list.
> +		 */
> +
> +		if (filter_data->omits)
> +			oidset_insert(filter_data->omits, &obj->oid);
> +		return LOFR_ZERO;
> +	}
> +
> +include_it:
> +	if (filter_data->omits)
> +		oidset_remove(filter_data->omits, &obj->oid);
> +	return LOFR_MARK_SEEN | LOFR_SHOW;
> +}

[snip]

> +struct frame {
> +	int defval;

Document this variable?

> +	int child_prov_omit : 1;

I think it's clearer if we use "unsigned" here. Also, document this
(e.g. "1 if any descendant of this tree object was provisionally
omitted").

> +/*
> + * During list-object traversal we allow certain objects to be
> + * filtered (omitted) from the result.  The active filter uses
> + * these result values to guide list-objects.
> + *
> + * _ZERO      : Do nothing with the object at this time.  It may
> + *              be revisited if it appears in another place in
> + *              the tree or in another commit during the overall
> + *              traversal.
> + *
> + * _MARK_SEEN : Mark this object as "SEEN" in the object flags.
> + *              This will prevent it from being revisited during
> + *              the remainder of the traversal.  This DOES NOT
> + *              imply that it will be included in the results.
> + *
> + * _SHOW      : Show this object in the results (call show() on it).
> + *              In general, objects should only be shown once, but
> + *              this result DOES NOT imply that we mark it SEEN.
> + *
> + * Most of the time, you want the combination (_MARK_SEEN | _SHOW)
> + * but they can be used independently, such as when sparse-checkout
> + * pattern matching is being applied.
> + *
> + * A _MARK_SEEN without _SHOW can be called a hard-omit -- the
> + * object is not shown and will never be reconsidered (unless a
> + * previous iteration has already shown it).
> + *
> + * A _ZERO is can be called a provisional-omit -- the object is
> + * not shown, but *may* be revisited (if the object appears again
> + * in the traversal).  Therefore, it will be omitted from the
> + * results *unless* a later iteration causes it to be shown.
> + */
> +enum list_objects_filter_result {
> +	LOFR_ZERO      = 0,
> +	LOFR_MARK_SEEN = 1<<0,
> +	LOFR_SHOW      = 1<<1,
> +};

Thanks - this looks like a good explanation to me.

> +enum list_objects_filter_type {
> +	LOFT_BEGIN_TREE,
> +	LOFT_END_TREE,
> +	LOFT_BLOB
> +};

Optional: probably a better name would be list_objects_filter_situation.

> +void traverse_commit_list_filtered(
> +	struct list_objects_filter_options *filter_options,
> +	struct rev_info *revs,
> +	show_commit_fn show_commit,
> +	show_object_fn show_object,
> +	void *show_data,
> +	struct oidset *omitted)
> +{
> +	filter_object_fn filter_fn = NULL;
> +	filter_free_fn filter_free_fn = NULL;
> +	void *filter_data = NULL;
> +
> +	filter_data = list_objects_filter__init(omitted, filter_options,
> +						&filter_fn, &filter_free_fn);
> +	do_traverse(revs, show_commit, show_object, show_data,
> +		    filter_fn, filter_data);
> +	if (filter_data && filter_free_fn)
> +		filter_free_fn(filter_data);
> +}

This function traverse_commit_list_filtered() is in list-objects.c but
in list-objects-filter.h, if I'm reading the diff correctly?

Overall, this looks like a good change. Object traversal was upgraded
with the behaviors of MARK_SEEN and SHOW independently controllable and
with the ability to do things post-tree (in addition to pre-tree and
blob), and this was used to support a few types of filtering, which
subsequent patches will allow the user to invoke through "--filter=".
