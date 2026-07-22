Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3DD351C35
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727597; cv=none; b=oHSGwM8t3WW46WlujO814ZcBxCdPdae+k8KTWGw2vhnSCDw2EbdNLkeEpK+Ry9XpdrlmyBk/rfD1LjAjfFUJut4ZJxqOw8XptgsfhMRBkMj8MJ2dQ/226REr47Vd8Vj6n1XykidH0YQ/Z2a1O4Usr0Jx4GiayEOqTZSily5y0K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727597; c=relaxed/simple;
	bh=aBcm/5VjoxXxgiiPmFOJJm4Fn8Q1sO/92lphfFPCwBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FM1w7lgbMfbuEu4LyItrXEPt6CHDgfBjrckXsfMMou05KtUERR3FVQ1WnKh0yqwElmLjVNECaxL/9Y+HBN+IY/SG5wLBQxyT+wronCjrndXllKWhL/jCruKsFs0O99hTE/XlGrmcIWJjnJTs76XhrFHSZmnAJTkQmjQSXQdmGfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDr3sBno; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDr3sBno"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69eefa92a1cso2868269a12.3
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784727587; x=1785332387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9EsQ+JXGffkSXgbR5CyURiJz2oMIndPVMIB3XbTybrc=;
        b=mDr3sBnonouDa1KRZtjfatNrhQAHAJVNh21ITYASbQMWTfgxWvkLeqn/hYDuj6A0LN
         J//tvAyOjT2BY8Mw+kuw3x0HV1IB52IOjxa4vQvBqS5sjbGnGDuf4sIlXQ+m8S9pPjFN
         WxDmywpniV5QZDQ8SkZ7XJArFYODhexnvteT7G30whRC849wGzF08My74ZWO3JKFGPmW
         vv7ZHpCcdi3Z5+dt07Cal+ipPhcDp3K0lROHDiSvxembrwz7tvPdZn/9I63uXIsWJNWK
         eTvX17D1m3Ci3xX/SYW2aB23/ui6gdUJgXGf6IKLWfqVNkTld9V0rnx+qT+Q062b8KJx
         K34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727587; x=1785332387;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9EsQ+JXGffkSXgbR5CyURiJz2oMIndPVMIB3XbTybrc=;
        b=ZzUoPVw7hapUSXIeuW7qTLkCFx36o+ZQIVnj9Vh7Qc5u4slk92MARc2EbRT58mfg4a
         gzdFIr4nvfN9oqQXg4MeJqlDnC08tziunLkHESIv0XoZ90EctV63pmY5TZNCD0yvRvQQ
         dxB4d7W6U0HXOO5p8azzLpe0RJvXyiJtliatNI/rrHr+/u4JPacTjViHSmQ0+3ggGVa0
         2FfzKvStBHGYEODqKJYBbEMJlmHcCiE+S/+fWMYz871OyrtibbzFCTKKs/LB/bQFuseM
         wv46bPY7ard1MDQGsCzQMuau4M+QhIbmAJvGwLANK4HnWJgQfbsF6TKM717B0L4r2Knm
         SK8g==
X-Forwarded-Encrypted: i=1; AHgh+RqyJ8hq038yCipEwBCUt5kS1F89ZSWY0J3iCqLDSP3cUSyT8fFAGFigsu2yoDmVWYrdNkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVMMTMh7JIto+aTy/WfZ2EbWcXrkmfqUqrUVHdD555blx7eqLz
	Qlua8xVSvm5o0JcmOmdGBOoCQeboC8GM4gQ4IWCQ8Zh0fjGU77nQm1TF
X-Gm-Gg: AR+sD12aDfPKxA+uq9zX72N+aO1bmaIpJ2OXl7YbZEjfuRwbAXCIsPPsFstyfmyEv99
	f///sh6BUfywBQ2ZozH0ysnctL0ITBkrZS/+PJq0olB9bQpngzfPHC4eTlpW9S87je8QQ0Vxrmy
	HdPo6h3RXxQIgHaqDoIhLQ1ttGyX5IvAferF0B3kRcVcO+QNJWX2iCdpg40iXyy32LdOJBcD8Po
	b+iJXAbWpR2z8D6hxSbycq5nYbIOOmH4nUy+Zpx1droczr7IxvVRh7wy7EVUnM60+AWikwM79nD
	/+u/ysAubP0bb45lb2LlVu39o46boM33fsrGrIO7oEsUlVTpYXfw/AxNw3B4Hftx7sHXnvOE8Pb
	uKmiUHEZRYHz6vvTJNUIl+zQZM9Sm0Sl2x2W+GbgdUc3dws2EyevG1Gva3jWtOXQETxKuPaq5d6
	IvMXgaqGuBGV/XjajzdRLEwBDSOE+1XrMEPcVJG5sKby7F9Mjn6XJvPGkl
X-Received: by 2002:a17:907:c012:b0:c16:44c3:5a1e with SMTP id a640c23a62f3a-c16b489538fmr937713466b.63.1784727586729;
        Wed, 22 Jul 2026 06:39:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac6ff3sm107890466b.19.2026.07.22.06.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 06:39:45 -0700 (PDT)
Message-ID: <20976edc-fc9d-4d4d-8919-b599d336f9cc@gmail.com>
Date: Wed, 22 Jul 2026 14:39:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v20 0/7] branch: delete-merged
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
 <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 22/07/2026 08:10, Harald Nordgren via GitGitGadget wrote:
> Delete branches that have already been merged on upstream.
> 
> Changes in v20:
> 
>   * Protect branches transitively required by a surviving local upstream
>     stack. Traverse upstream chains once and defer delete-set mutation until
>     traversal completes.
>   * Make stacked-branch handling independent of ref iteration order and
>     update the documentation accordingly.
>   * Clarify variable names with regards to branch names (short) to reduce
>     confusion.

I'm having a hard time reading the range diff due to the renaming of the 
members of "struct stacked_branch_data". Can you explain what has 
changed in the logic to protect branches that are upstreams of unmerged 
branches and why please? In particular why wasn't sufficient to stop 
removing the members of "spared" from "deletable" in 
spare_stacked_base() and remove them after refs_for_each_branch_ref() 
has returned instead.

Thanks

Phillip

> Range-diff vs v19:
> 
>   1:  562648132d = 1:  51c1c9d075 branch: add --forked filter for --list mode
>   2:  c7ebd9344c = 2:  711574b2e5 branch: convert delete_branches() to a flags argument
>   3:  0c4f3358e3 = 3:  47c5975dc7 branch: let delete_branches skip unmerged branches on bulk refusal
>   4:  64a202526a = 4:  46268acec5 branch: prepare delete_branches for a bulk caller
>   5:  a6caa5b397 ! 5:  ef9f57e735 branch: add --delete-merged <branch>
>       @@ Commit message
>            A branch whose work is not yet merged into its upstream is silently
>            skipped, so one unmerged topic does not abort the whole sweep.
>        
>       -    A branch that another, surviving branch tracks as its upstream is
>       -    also kept, so a branch is never deleted out from under one stacked
>       -    on top of it. Such a kept branch is itself merged, so when its own
>       -    upstream is being deleted, clear its now-stale upstream config.
>       +    A branch that a surviving branch depends on through a chain of local
>       +    upstreams is also kept, so no branch is deleted out from under stacked
>       +    work. Collect this transitive set without changing the candidate set
>       +    during ref iteration: walk upstream chains from surviving branches,
>       +    visit each branch at most once, and remove the collected bases only
>       +    after the iteration completes. This makes the result independent of
>       +    ref iteration order without repeated full scans.
>        
>            Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>        
>       @@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mod
>        +silently skipped. Delete it with `git branch -D` if you want to
>        +remove it anyway.
>        ++
>       -+A branch that another, surviving branch tracks as its upstream is
>       -+kept, so a branch is never deleted out from under one stacked on top
>       -+of it. If that kept branch in turn tracks a branch that is being
>       -+deleted, its now-stale upstream configuration is cleared.
>       ++A branch that a surviving branch depends on through a chain of local
>       ++upstreams is kept, so a branch is never deleted out from under stacked
>       ++work.
>        +
>         `-v`::
>         `-vv`::
>       @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
>         	return 0;
>         }
>         
>       -+struct spare_data {
>       -+	struct strset *deletable;
>       -+	struct strset *spared;
>       ++struct stacked_branch_data {
>       ++	struct strset *deletable_branch_names;
>       ++	struct strset *protected_branch_names;
>       ++	struct strset *visited_branch_names;
>        +};
>        +
>       -+/*
>       -+ * A surviving branch stacked on a deletion candidate would lose its
>       -+ * upstream, so drop that candidate from the delete set and remember it
>       -+ * in "spared" so its own upstream can be tidied up afterwards.
>       -+ */
>       -+static int spare_stacked_base(const struct reference *ref, void *cb_data)
>       ++static int collect_stacked_branch_bases(const struct reference *ref,
>       ++					void *cb_data)
>        +{
>       -+	struct spare_data *data = cb_data;
>       -+	struct branch *branch;
>       -+	const char *upstream, *up_short;
>       ++	struct stacked_branch_data *data = cb_data;
>       ++	const char *branch_name;
>        +
>       -+	if (strset_contains(data->deletable, ref->name))
>       -+		return 0;
>       -+	branch = branch_get(ref->name);
>       -+	upstream = branch_get_upstream(branch, NULL);
>       -+	if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
>       -+	    !strset_contains(data->deletable, up_short))
>       ++	if (!skip_prefix(ref->name, "refs/heads/", &branch_name))
>       ++		BUG("expected local branch ref, got '%s'", ref->name);
>       ++	if (strset_contains(data->deletable_branch_names, branch_name))
>        +		return 0;
>        +
>       -+	strset_remove(data->deletable, up_short);
>       -+	strset_add(data->spared, up_short);
>       ++	while (strset_add(data->visited_branch_names, branch_name)) {
>       ++		struct branch *branch = branch_get(branch_name);
>       ++		const char *upstream_refname = branch_get_upstream(branch, NULL);
>       ++		const char *upstream_branch_name;
>       ++
>       ++		if (!upstream_refname ||
>       ++		    !skip_prefix(upstream_refname, "refs/heads/",
>       ++				 &upstream_branch_name) ||
>       ++		    !strset_contains(data->deletable_branch_names,
>       ++				    upstream_branch_name))
>       ++			break;
>       ++
>       ++		strset_add(data->protected_branch_names, upstream_branch_name);
>       ++		branch_name = upstream_branch_name;
>       ++	}
>       ++
>        +	return 0;
>        +}
>        +
>       -+/*
>       -+ * Keep any branch that a surviving branch tracks as its upstream, so we
>       -+ * never delete a branch out from under one stacked on top of it.  Such a
>       -+ * base is itself merged, so when its own upstream is also going away
>       -+ * (no surviving branch tracks it), clear the base's now-stale upstream.
>       -+ */
>       -+static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
>       ++static void protect_stacked_branch_bases(struct ref_store *refs,
>       ++					 struct strset *deletable_branch_names)
>        +{
>       -+	struct strset spared = STRSET_INIT;
>       -+	struct spare_data data = { .deletable = deletable, .spared = &spared };
>       -+	struct strbuf key = STRBUF_INIT;
>       ++	struct strset protected_branch_names = STRSET_INIT;
>       ++	struct strset visited_branch_names = STRSET_INIT;
>       ++	struct stacked_branch_data data = {
>       ++		.deletable_branch_names = deletable_branch_names,
>       ++		.protected_branch_names = &protected_branch_names,
>       ++		.visited_branch_names = &visited_branch_names,
>       ++	};
>       ++	struct refs_for_each_ref_options opts = {
>       ++		.prefix = "refs/heads/",
>       ++	};
>        +	struct hashmap_iter iter;
>        +	struct strmap_entry *entry;
>        +
>       -+	refs_for_each_branch_ref(refs, spare_stacked_base, &data);
>       -+
>       -+	strset_for_each_entry(&spared, &iter, entry) {
>       -+		struct branch *branch = branch_get(entry->key);
>       -+		const char *upstream = branch_get_upstream(branch, NULL);
>       -+		const char *up_short;
>       -+
>       -+		if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
>       -+		    !strset_contains(deletable, up_short))
>       -+			continue;
>       ++	refs_for_each_ref_ext(refs, collect_stacked_branch_bases, &data, &opts);
>        +
>       -+		strbuf_reset(&key);
>       -+		strbuf_addf(&key, "branch.%s.merge", branch->name);
>       -+		repo_config_set_gently(the_repository, key.buf, NULL);
>       -+		strbuf_reset(&key);
>       -+		strbuf_addf(&key, "branch.%s.remote", branch->name);
>       -+		repo_config_set_gently(the_repository, key.buf, NULL);
>       -+	}
>       ++	strset_for_each_entry(&protected_branch_names, &iter, entry)
>       ++		strset_remove(deletable_branch_names, entry->key);
>        +
>       -+	strbuf_release(&key);
>       -+	strset_clear(&spared);
>       ++	strset_clear(&visited_branch_names);
>       ++	strset_clear(&protected_branch_names);
>        +}
>        +
>        +static int branch_pushes_to_upstream(struct branch *branch,
>       @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
>        +	struct ref_store *refs = get_main_ref_store(the_repository);
>        +	struct ref_filter filter = REF_FILTER_INIT;
>        +	struct ref_array candidates = { 0 };
>       -+	struct strset deletable = STRSET_INIT;
>       -+	struct strvec to_delete = STRVEC_INIT;
>       ++	struct strset deletable_branch_names = STRSET_INIT;
>       ++	struct strvec branches_to_delete = STRVEC_INIT;
>        +	struct hashmap_iter iter;
>        +	struct strmap_entry *entry;
>        +	size_t i;
>       @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
>        +	filter_refs(&candidates, &filter, filter.kind);
>        +
>        +	for (i = 0; i < (size_t)candidates.nr; i++) {
>       -+		const char *full_name = candidates.items[i]->refname;
>       -+		const char *short_name;
>       ++		const char *branch_refname = candidates.items[i]->refname;
>       ++		const char *branch_name;
>        +		struct branch *branch;
>       -+		const char *upstream;
>       ++		const char *upstream_refname;
>        +
>       -+		if (!skip_prefix(full_name, "refs/heads/", &short_name))
>       -+			BUG("filter returned non-branch ref '%s'", full_name);
>       -+		if (branch_checked_out(full_name))
>       ++		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
>       ++			BUG("filter returned non-branch ref '%s'", branch_refname);
>       ++		if (branch_checked_out(branch_refname))
>        +			continue;
>        +
>       -+		branch = branch_get(short_name);
>       -+		upstream = branch_get_upstream(branch, NULL);
>       -+		if (!upstream || !refs_ref_exists(refs, upstream))
>       ++		branch = branch_get(branch_name);
>       ++		upstream_refname = branch_get_upstream(branch, NULL);
>       ++		if (!upstream_refname || !refs_ref_exists(refs, upstream_refname))
>        +			continue;
>       -+		if (branch_pushes_to_upstream(branch, upstream))
>       ++		if (branch_pushes_to_upstream(branch, upstream_refname))
>        +			continue;
>       -+		if (check_branch_commit(short_name, short_name,
>       ++		if (check_branch_commit(branch_name, branch_name,
>        +					&candidates.items[i]->objectname, NULL,
>        +					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
>        +			continue;
>        +
>       -+		strset_add(&deletable, short_name);
>       ++		strset_add(&deletable_branch_names, branch_name);
>        +	}
>        +
>       -+	spare_stacked_bases(refs, &deletable);
>       ++	protect_stacked_branch_bases(refs, &deletable_branch_names);
>        +
>       -+	strset_for_each_entry(&deletable, &iter, entry)
>       -+		strvec_push(&to_delete, entry->key);
>       ++	strset_for_each_entry(&deletable_branch_names, &iter, entry)
>       ++		strvec_push(&branches_to_delete, entry->key);
>        +
>       -+	if (to_delete.nr)
>       -+		ret = delete_branches(to_delete.nr, to_delete.v,
>       ++	if (branches_to_delete.nr)
>       ++		ret = delete_branches(branches_to_delete.nr, branches_to_delete.v,
>        +				      FILTER_REFS_BRANCHES,
>        +				      DELETE_BRANCH_SKIP_UNMERGED |
>        +				      DELETE_BRANCH_NO_HEAD_FALLBACK |
>        +				      flags);
>        +
>       -+	strvec_clear(&to_delete);
>       -+	strset_clear(&deletable);
>       ++	strvec_clear(&branches_to_delete);
>       ++	strset_clear(&deletable_branch_names);
>        +	ref_array_clear(&candidates);
>        +	ref_filter_clear(&filter);
>        +	return ret;
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
>        +	)
>        +'
>        +
>       -+test_expect_success '--delete-merged clears the deleted upstream of a spared branch' '
>       ++test_expect_success '--delete-merged keeps the upstream chain of a surviving branch' '
>        +	setup_repo_for_delete_merged &&
>        +	(
>        +		cd repo &&
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
>        +		git commit --allow-empty -m "tip work" &&
>        +
>        +		git branch --delete-merged origin/next \
>       -+			--delete-merged lower &&
>       ++			--delete-merged lower >actual 2>&1 &&
>       ++		test_must_be_empty actual &&
>        +
>        +		check_branches <<-\EOF &&
>       ++		lower
>        +		main
>        +		mid
>        +		tip
>        +		EOF
>        +
>       -+		git config --local --get-regexp "branch\\.(mid|tip)\\.(merge|remote)" >actual &&
>       ++		git config --local --get-regexp "branch\\.(lower|mid|tip)\\.(merge|remote)" >actual &&
>        +		cat >expect <<-\EOF &&
>       ++		branch.lower.remote origin
>       ++		branch.lower.merge refs/heads/next
>       ++		branch.mid.remote .
>       ++		branch.mid.merge refs/heads/lower
>        +		branch.tip.remote .
>        +		branch.tip.merge refs/heads/mid
>        +		EOF
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
>        +	)
>        +'
>        +
>       ++test_expect_success '--delete-merged result is independent of stacked branch names' '
>       ++	setup_repo_for_delete_merged &&
>       ++	(
>       ++		cd repo &&
>       ++		git branch c-lower origin/next --track &&
>       ++		git branch b-mid c-lower --track &&
>       ++		git checkout -b a-tip b-mid --track &&
>       ++		git commit --allow-empty -m "tip work" &&
>       ++
>       ++		git branch --delete-merged origin/next \
>       ++			--delete-merged "c-*" &&
>       ++
>       ++		check_branches <<-\EOF &&
>       ++		a-tip
>       ++		b-mid
>       ++		c-lower
>       ++		main
>       ++		EOF
>       ++
>       ++		git branch --delete-merged origin/next \
>       ++			--delete-merged "c-*" >actual 2>&1 &&
>       ++		test_must_be_empty actual &&
>       ++
>       ++		check_branches <<-\EOF
>       ++		a-tip
>       ++		b-mid
>       ++		c-lower
>       ++		main
>       ++		EOF
>       ++	)
>       ++'
>       ++
>        +test_expect_success '--delete-merged requires a value' '
>        +	test_must_fail git -C forked branch --delete-merged 2>err &&
>        +	test_grep "requires a value" err
>   6:  734d27c908 ! 6:  fa70108611 branch: add branch.<name>.deleteMerged opt-out
>       @@ Documentation/git-branch.adoc: A branch is not deleted when:
>         ## builtin/branch.c ##
>        @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
>         	struct ref_array candidates = { 0 };
>       - 	struct strset deletable = STRSET_INIT;
>       - 	struct strvec to_delete = STRVEC_INIT;
>       + 	struct strset deletable_branch_names = STRSET_INIT;
>       + 	struct strvec branches_to_delete = STRVEC_INIT;
>        +	struct strbuf key = STRBUF_INIT;
>         	struct hashmap_iter iter;
>         	struct strmap_entry *entry;
>         	size_t i;
>        @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
>       - 		const char *short_name;
>       + 		const char *branch_name;
>         		struct branch *branch;
>       - 		const char *upstream;
>       + 		const char *upstream_refname;
>        +		int opt_out;
>         
>       - 		if (!skip_prefix(full_name, "refs/heads/", &short_name))
>       - 			BUG("filter returned non-branch ref '%s'", full_name);
>       + 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
>       + 			BUG("filter returned non-branch ref '%s'", branch_refname);
>        @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
>         					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
>         			continue;
>         
>        +		strbuf_reset(&key);
>       -+		strbuf_addf(&key, "branch.%s.deletemerged", short_name);
>       ++		strbuf_addf(&key, "branch.%s.deletemerged", branch_name);
>        +		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
>        +		    !opt_out) {
>        +			if (!(flags & DELETE_BRANCH_QUIET))
>        +				fprintf(stderr,
>        +					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
>       -+					short_name, short_name);
>       ++					branch_name, branch_name);
>        +			continue;
>        +		}
>        +
>       - 		strset_add(&deletable, short_name);
>       + 		strset_add(&deletable_branch_names, branch_name);
>         	}
>         
>        @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
>       @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
>         				      flags);
>         
>        +	strbuf_release(&key);
>       - 	strvec_clear(&to_delete);
>       - 	strset_clear(&deletable);
>       + 	strvec_clear(&branches_to_delete);
>       + 	strset_clear(&deletable_branch_names);
>         	ref_array_clear(&candidates);
>        
>         ## t/t3200-branch.sh ##
>   7:  7aa9d5db14 ! 7:  13bac431a3 branch: add --dry-run for --delete-merged
>       @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
>         
>         DESCRIPTION
>         -----------
>       -@@ Documentation/git-branch.adoc: kept, so a branch is never deleted out from under one stacked on top
>       - of it. If that kept branch in turn tracks a branch that is being
>       - deleted, its now-stale upstream configuration is cleared.
>       +@@ Documentation/git-branch.adoc: A branch that a surviving branch depends on through a chain of local
>       + upstreams is kept, so a branch is never deleted out from under stacked
>       + work.
>         
>        +`--dry-run`::
>        +	With `--delete-merged`, print which branches would be
>       @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int ki
>         			char *refname = name + branch_name_pos;
>         			if (!(flags & DELETE_BRANCH_QUIET))
>         				printf(remote_branch
>       -@@ builtin/branch.c: static int spare_stacked_base(const struct reference *ref, void *cb_data)
>       -  * base is itself merged, so when its own upstream is also going away
>       -  * (no surviving branch tracks it), clear the base's now-stale upstream.
>       -  */
>       --static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
>       -+static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable,
>       -+				unsigned int flags)
>       - {
>       - 	struct strset spared = STRSET_INIT;
>       - 	struct spare_data data = { .deletable = deletable, .spared = &spared };
>       -@@ builtin/branch.c: static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable
>       -
>       - 	refs_for_each_branch_ref(refs, spare_stacked_base, &data);
>       -
>       --	strset_for_each_entry(&spared, &iter, entry) {
>       --		struct branch *branch = branch_get(entry->key);
>       --		const char *upstream = branch_get_upstream(branch, NULL);
>       --		const char *up_short;
>       -+	if (!(flags & DELETE_BRANCH_DRY_RUN)) {
>       -+		strset_for_each_entry(&spared, &iter, entry) {
>       -+			struct branch *branch = branch_get(entry->key);
>       -+			const char *upstream = branch_get_upstream(branch, NULL);
>       -+			const char *up_short;
>       -
>       --		if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
>       --		    !strset_contains(deletable, up_short))
>       --			continue;
>       -+			if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
>       -+			    !strset_contains(deletable, up_short))
>       -+				continue;
>       -
>       --		strbuf_reset(&key);
>       --		strbuf_addf(&key, "branch.%s.merge", branch->name);
>       --		repo_config_set_gently(the_repository, key.buf, NULL);
>       --		strbuf_reset(&key);
>       --		strbuf_addf(&key, "branch.%s.remote", branch->name);
>       --		repo_config_set_gently(the_repository, key.buf, NULL);
>       -+			strbuf_reset(&key);
>       -+			strbuf_addf(&key, "branch.%s.merge", branch->name);
>       -+			repo_config_set_gently(the_repository, key.buf, NULL);
>       -+			strbuf_reset(&key);
>       -+			strbuf_addf(&key, "branch.%s.remote", branch->name);
>       -+			repo_config_set_gently(the_repository, key.buf, NULL);
>       -+		}
>       - 	}
>       -
>       - 	strbuf_release(&key);
>       -@@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
>       - 		strset_add(&deletable, short_name);
>       - 	}
>       -
>       --	spare_stacked_bases(refs, &deletable);
>       -+	spare_stacked_bases(refs, &deletable, flags);
>       -
>       - 	strset_for_each_entry(&deletable, &iter, entry)
>       - 		strvec_push(&to_delete, entry->key);
>        @@ builtin/branch.c: int cmd_branch(int argc,
>         	int delete = 0, rename = 0, copy = 0, list = 0,
>         	    unset_upstream = 0, show_current = 0, edit_description = 0;
>       @@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps the upstream of a
>         		check_branches <<-\EOF &&
>         		feature
>         		main
>       -@@ t/t3200-branch.sh: test_expect_success '--delete-merged clears the deleted upstream of a spared bra
>       +@@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps the upstream chain of a surviving bra
>         		git checkout -b tip mid --track &&
>         		git commit --allow-empty -m "tip work" &&
>         
>        +		git branch --dry-run --delete-merged origin/next \
>       -+			--delete-merged lower &&
>       ++			--delete-merged lower >actual 2>&1 &&
>       ++		test_must_be_empty actual &&
>        +
>       -+		git config --local --get-regexp "branch\\.(mid|tip)\\.(merge|remote)" >actual &&
>       ++		git config --local --get-regexp "branch\\.(lower|mid|tip)\\.(merge|remote)" >actual &&
>        +		cat >expect <<-\EOF &&
>       ++		branch.lower.remote origin
>       ++		branch.lower.merge refs/heads/next
>        +		branch.mid.remote .
>        +		branch.mid.merge refs/heads/lower
>        +		branch.tip.remote .
>       @@ t/t3200-branch.sh: test_expect_success '--delete-merged clears the deleted upstr
>        +		test_cmp expect actual &&
>        +
>         		git branch --delete-merged origin/next \
>       - 			--delete-merged lower &&
>       -
>       + 			--delete-merged lower >actual 2>&1 &&
>       + 		test_must_be_empty actual &&
>        @@ t/t3200-branch.sh: test_expect_success "branch -d still deletes a deleteMerged=false branch" '
>         	)
>         '
> 

