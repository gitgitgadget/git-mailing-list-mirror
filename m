Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809680BFC
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727126686; cv=none; b=saccQp8OCYKJIsy6uHrYhaPQ2YR+4kts91QVWVX8E56saPX4CqvTvHStSkl8DURLDtrEOd+QcYPZ8ZJvsm2tXfXNI4GheCfrY/K5pI3O0iyVwrdl7TXYCbzC+qhcnQm6ZF0fGR/LpIsjd40ct8H8JGxYGshTXjNadX8iM2UZRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727126686; c=relaxed/simple;
	bh=h+dgTeuQ1RtvsCyY5Hxer5l/etH9ZoOFt+kL1blhFps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jNRg64Ao+TDQmAKggnMGeVnBHJIM/h9UFV+Siv9yGu9gnA2WrwnoHanravN1G/R93FJOyq6RMaMk/I5qba9f0RxgMbn01n8/00CO4RIAe5wjw+XVq8oGPjydIrhbWKtEm133u+MkP4+8/iDA7atCUmq+o2BYDCUa6kVdhiFq0Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wst/3Omx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wst/3Omx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56BAB2633F;
	Mon, 23 Sep 2024 17:24:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=h+dgTeuQ1RtvsCyY5Hxer5l/etH9ZoOFt+kL1b
	lhFps=; b=Wst/3OmxNpVFHaq65YpMr0LooxyPPs6cFZSP4XgU0dtmnBQZS7zpdI
	LFJt9iw6dy7atvzYfMDBZ5IinZxDd7mMjrP70C0vbSg+tKo3OD7/h/MrF+CWewLY
	bRs8b6tgQktBC8paQ7mDiEFlsaDvmyIxNhUuQOVJb2F1xrvnWq50Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E7E22633E;
	Mon, 23 Sep 2024 17:24:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B49652633D;
	Mon, 23 Sep 2024 17:24:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "Patrick Steinhardt [ ]" <ps@pks.im>,  "Derrick
 Stolee [ ]" <stolee@gmail.com>,  Shubham Kanodia
 <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH v3] remote: introduce config to set prefetch refs
In-Reply-To: <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com> (Shubham
	Kanodia via GitGitGadget's message of "Thu, 19 Sep 2024 10:23:59
	+0000")
References: <pull.1782.v2.git.1726409329993.gitgitgadget@gmail.com>
	<pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com>
Date: Mon, 23 Sep 2024 14:24:41 -0700
Message-ID: <xmqqfrpqxduu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3F94FFBA-79F2-11EF-97AE-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Shubham Kanodia <shubham.kanodia10@gmail.com>
>
> This commit introduces a new configuration option, ...

The usual way to compose a log message of this project is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.

To those who have been intimately following the discussion, it often
is understandable without some of the above, but we are not writing
for those who review the patches.  We are primarily writing for future
readers of "git log" who are not aware of the review discussion we
have on list, so we should give something to prepare them by setting
the stage and stating the objective first, before going into how the
patch solved it.

> diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
> index 8efc53e836d..b04ee0c4c22 100644
> --- a/Documentation/config/remote.txt
> +++ b/Documentation/config/remote.txt
> @@ -33,6 +33,11 @@ remote.<name>.fetch::
>  	The default set of "refspec" for linkgit:git-fetch[1]. See
>  	linkgit:git-fetch[1].
>  
> +remote.<name>.prefetchref::
> +    Specify the refs to be prefetched when fetching from this remote.
> +    The value is a space-separated list of ref patterns (e.g., "refs/heads/master !refs/heads/develop*").
> +    This can be used to optimize fetch operations by specifying exactly which refs should be prefetched.

Overly long lines.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b2b5aee5bf2..16c8a31c2e1 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -38,6 +38,7 @@
>  #include "trace.h"
>  #include "trace2.h"
>  #include "bundle-uri.h"
> +#include "wildmatch.h"

The match done by the wildmatch function is a way too loose to be
used in the context of parsing and matching the src half of an
refspec_item (e.g. a globbing refspec element can have at most one
asterisk in it, but wildmatch does not have any sanity check to
ensure it).  The refspec logic to accept a fetch refspec
"refs/heads/*:refs/remotes/origin/*" and rewrite a ref the remote
side advertised as refs/heads/foo into refs/remotes/origin/foo, the
remote-tracking ref on the local side, is in
remote.c:match_name_with_pattern(), and it does not use wildmatch.

> +static int matches_prefetch_refs(const char *refname, const struct string_list *prefetch_refs)
> +{
> +	int i;
> +	int has_positive = 0;
> +	int matched_positive = 0;
> +	int matched_negative = 0;
> +
> +	for (i = 0; i < prefetch_refs->nr; i++) {

Just FYI, in modern Git codebase, loop control variable 'i' can be
declared in the initialization part of the for() statement, i.e.

    for (int i = 0; i < ...) {

which might make it easier to see that there are three variables of
importance to determine the outcome of the computation (and 'i' is
merely a loop counter).

> +		const char *pattern = prefetch_refs->items[i].string;
> +		int is_negative = (*pattern == '!');
> +
> +		if (is_negative)
> +			pattern++;
> +		else
> +			has_positive = 1;
> +
> +		if (wildmatch(pattern, refname, 0) == 0) {
> +			if (is_negative)
> +				matched_negative = 1;
> +			else
> +				matched_positive = 1;
> +		}
> +	}

I suspect that the function can be exposed to external callers as-is,
possibly after renaming it to make it clear that the helper function
is about refspec.  Then you can call it from the code below in stead
of wildmatch(), by passing the pattern as "key", and the refname as
"name", with NULL for both "value" and "result", I think.

> +
> +	if (!has_positive)
> +		return !matched_negative;
> +
> +	return matched_positive && !matched_negative;
> +}

And the implementation of the logic looks correct.  If the pattern
says "!A !B !C" (I don't want any of these), we only care that none
of these negative patterns trigger, but if the pattern has even one
positive one "X Y !A !B !C" (it must match X or Y, but it must not
match any of the A B C), we also make sure it matched at least one
positive pattern.

> +static void ref_remove(struct ref **head, struct ref *to_remove)
> +{
> +	struct ref **pp, *p;
> +
> +	for (pp = head; (p = *pp) != NULL; pp = &p->next) {
> +		if (p == to_remove) {
> +			*pp = p->next;
> +			return;
> +		}
> +	}
> +}

We remote from a linked list of "struct ref" one such element
to_remove.  OK.

> @@ -610,6 +655,22 @@ static struct ref *get_ref_map(struct remote *remote,
>  	else
>  		ref_map = apply_negative_refspecs(ref_map, &remote->fetch);
>  
> +	/**
> +	 * Filter out advertised refs that we don't want to fetch during
> +	 * prefetch if a prefetchref config is set
> +	 */
> +	if (prefetch && remote->prefetch_refs.nr) {
> +		struct ref *ref, *next;
> +		for (ref = ref_map; ref; ref = next) {
> +			next = ref->next;
> +
> +			if (!matches_prefetch_refs(ref->name, &remote->prefetch_refs)) {
> +					ref_remove(&ref_map, ref);
> +					free_one_ref(ref);

It is curious why such an overly deep indentation is used only in
this if() statement.

It is good that you made sure we do not leak the ref that we
removed, but it looks verly inefficient to repeatedly call
ref_remove (the function becomes more inefficient as the loop
progresses as it is more costly to remove later elements on a
linearly linked list).

Wouldn't it be more efficient to iterate over the original list, sift
each element into "surviving" and "discarded" bin as we go?  Something
along the lines of ...

	struct ref *new_list = NULL, **tail = &new_list;

	while (ref_map) {
		struct ref *ref = ref_map;

		ref_map = ref_map->next;
		ref->next = NULL;

        	if (matches(...)) {
			*tail = ref;
			tail = &ref->next;
		} else {
			free_one_ref(ref);
		}
	}
        ref_map = new_list;

..., which I imitated code structure of ref_remove_duplicates().

>  	ref_map = ref_remove_duplicates(ref_map);

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index abae7a97546..054f1f06f95 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh

Avoid overly long lines in the test script, too.

In any case, I very much agree with you that get_ref_map().is the
best place to add this logic to.  Looking much better.

Thanks.
