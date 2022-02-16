Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289CEC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 05:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344668AbiBPFrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 00:47:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiBPFrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 00:47:09 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE06E6DB4
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 21:46:57 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id 9-20020a170902c20900b0014dc0faf52fso644406pll.14
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 21:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3xe8BLggy2OPVPMI+gDMzg0boqAt63Gw3y6TXtMgMFQ=;
        b=ZjqMz8wlFgOTRG4+YePxtRbCkRjrNYOr6dtipEn9jkxp8o3Sd07tc9+1t+VyAPds5G
         iKfruIESSHVKzPEu1guyvleveaN54iwyC4y6bJvmtmIkRb8GdNHu3iva7Fyt1wnHzp88
         EUegKS/rHyLp4Hng2BN+6k7NV/oCkeF3UBmG6Z5RQLenqN+y89wPoHHVZq41XcB2IfOw
         Hp/SZBuwn5MfKEp9/p/LdzyfsDP+90WALE70rAH7jJ1tWz4pnG3efRNdT3zcUdV8tv0e
         gTGyPlzjbpZ2yzyKuO9UDZybJ2nXSHDRkc9jpy6jPGjsR2CL2YvGv8WcZry9f0Z3FISE
         PpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3xe8BLggy2OPVPMI+gDMzg0boqAt63Gw3y6TXtMgMFQ=;
        b=JmAcmzKccDIVfPNNQvlMZ4lS88jG6rvPNahFzcmVPS7ypiVvGGt3Pfw/5x837sU9F4
         8gTbVyh97Qa9i35BE18lGXaKwC86R/f7eS5xSwyXHN00dwR8giWNXUtxm/8uCyqAd4f1
         tmLupL85bx4KIiBbRUhXz6EFyrA7i5reumdV4KfGbuaRUOluRV0zjoI/oOkxOgSaNKLG
         JPBVKfpG+R1O5pAZCR/zxHbaRcd1uRyOdTFAaI0Qkroq2v5p6YfvuF2/ZHDIcvOeJgag
         r/zMWClNcNbqwbTy4/9ULY9K9KlCQkRzmkwutGFyKiGIIrY7NAZo42ipZZHNUtgTBFNn
         6NlA==
X-Gm-Message-State: AOAM532wg3dGuyrrseRGdTwTiM5+xpoevWKHzw1Yn9XTvPWNxwf4/H50
        2qesvDNbS9Pk8hxdB2IvtrusqdTPYteLLg==
X-Google-Smtp-Source: ABdhPJy9AMAP4uKQJGPjscW0ukILST1UEvFhGFxdLmr9K7p9FjXxmiT2uhlCdPHTQds+m3id9Ick3sKTIShIsQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:120d:b0:1b8:98f3:53f1 with SMTP
 id gl13-20020a17090b120d00b001b898f353f1mr1115813pjb.36.1644990416819; Tue,
 15 Feb 2022 21:46:56 -0800 (PST)
Date:   Wed, 16 Feb 2022 13:46:41 +0800
In-Reply-To: <20220215220229.1633486-1-jonathantanmy@google.com>
Message-Id: <kl6lr1835poe.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220215220229.1633486-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 7/9] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> Teach "git fetch" to fetch cloned, changed submodules regardless of
>> whether they are populated (this is in addition to the current behavior
>> of fetching populated submodules).
>
> I think add a note that the current behavior is regardless of what is
> being fetched. So, maybe something like:
>
>   Teach "git fetch" to fetch cloned, changed submodules regardless of
>   whether they are populated. This is in addition to the current behavior
>   of fetching populated submodules (which happens regardless of what was
>   fetched in the superproject, or even if nothing was fetched in the
>   superproject).

Makes sense, thanks. This description is true, though a bit misleading
in the [--recurse-submodules=on-demand] case - if nothing was fetched,
on-demand would still try to fetch submodules, though no submodules
would be fetched. I'll tweak it a little.

>> As I mentioned in the cover letter, I'm not entirely happy with the
>> name repo_has_absorbed_submodules() - it's not a standardized term AFAIK
>> and it's a little clunky.
>> 
>> "absorbed submodule" is just a stand-in for "submodule in .git/modules",
>> so if we have a better term for "submodule in .git/modules", let's use
>> that instead.
>
> I think that this is OK if the doc comment is updated. I'll make the
> suggestion in the appropriate place below.
>> +/*
>> + * Returns 1 if the repo has absorbed submodule gitdirs, and 0
>> + * otherwise. Like submodule_name_to_gitdir(), this checks
>> + * $GIT_DIR/modules, not $GIT_COMMON_DIR.
>> + */
>
> I think that if you replace the doc comment with something like:
>
>   Returns 1 if there is at least one submodule gitdir in
>   $GIT_DIR/modules, and 0 otherwise. (End users can move submodule
>   gitdirs into $GIT_DIR/modules by running "git submodule
>   absorbgitdirs".) Like submodule_name_to_gitdir()...
>
> then it would be fine.

Thanks! Sounds good.

>> @@ -1338,6 +1366,7 @@ struct submodule_parallel_fetch {
>>  	int result;
>>  
>>  	struct string_list changed_submodule_names;
>> +	struct string_list seen_submodule_names;
>
> Could we unify the 2 lists instead of having 2 separate ones?

If I understand the suggestion correctly (Can we combine the two lists
into a single changed_submodule_names list?) I don't think we can - at
least not without other changes. The intent behind seen_submodule_names
is to tell get_fetch_task_from_changed() which changed_submodule_names
items can be ignored. If we only used one list, we wouldn't be able to
tell whether we had already considered the submodule or not. If we
stored this info elsewhere, e.g. an extra field in
changed_submodule_data, then we could use a single list.

>
>> @@ -1529,12 +1569,77 @@ get_fetch_task(struct submodule_parallel_fetch *spf,
>>  	return NULL;
>>  }
>>  
>> +static struct fetch_task *
>> +get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
>> +			    const char **default_argv, struct strbuf *err)
>> +{
>> +	for (; spf->changed_count < spf->changed_submodule_names.nr;
>> +	     spf->changed_count++) {
>> +		struct string_list_item item =
>> +			spf->changed_submodule_names.items[spf->changed_count];
>> +		struct changed_submodule_data *cs_data = item.util;
>> +		struct fetch_task *task;
>> +
>> +		/*
>> +		 * We might have already considered this submodule
>> +		 * because we saw it in the index.
>> +		 */
>> +		if (string_list_lookup(&spf->seen_submodule_names, item.string))
>> +			continue;
>> +
>> +		task = fetch_task_create(spf->r, cs_data->path,
>> +					 cs_data->super_oid);
>> +		if (!task)
>> +			continue;
>> +
>> +		switch (get_fetch_recurse_config(task->sub, spf)) {
>> +		default:
>> +		case RECURSE_SUBMODULES_DEFAULT:
>> +		case RECURSE_SUBMODULES_ON_DEMAND:
>> +			*default_argv = "on-demand";
>> +			break;
>> +		case RECURSE_SUBMODULES_ON:
>> +			*default_argv = "yes";
>> +			break;
>> +		case RECURSE_SUBMODULES_OFF:
>> +			continue;
>> +		}
>> +
>> +		task->repo = get_submodule_repo_for(spf->r, task->sub->path,
>> +						    cs_data->super_oid);
>> +		if (!task->repo) {
>> +			fetch_task_release(task);
>> +			free(task);
>> +
>> +			strbuf_addf(err, _("Could not access submodule '%s'\n"),
>> +				    cs_data->path);
>> +			continue;
>> +		}
>> +		if (!is_tree_submodule_active(spf->r, cs_data->super_oid,
>> +					      task->sub->path))
>> +			continue;
>> +
>> +		if (!spf->quiet)
>> +			strbuf_addf(err,
>> +				    _("Fetching submodule %s%s at commit %s\n"),
>> +				    spf->prefix, task->sub->path,
>> +				    find_unique_abbrev(cs_data->super_oid,
>> +						       DEFAULT_ABBREV));
>> +		spf->changed_count++;
>> +		return task;
>> +	}
>> +	return NULL;
>> +}
>
> This is very similar to get_fetch_task_from_index(). Both:
>  1. loop over something
>  2. exit early if the submodule name is seen
>  3. create the fetch task
>  4. set the "recurse config"
>  5. get the submodule repo
>  6. if success, increment a counter
>  7. if failure, check for some conditions and maybe append to err
>
> Could a function be refactored that does 2-5?

Hm, it makes sense. I don't see a reason for 2-5 to be different for
the different functions.

>
>> +test_expect_success "'--recurse-submodules=on-demand' should fetch submodule commits if the submodule is changed but the index has no submodules" '
>> +	git -C downstream fetch --recurse-submodules &&
>
> First of all, thanks for updating the test - it is much easier to
> understand now.
>
> About this line, we shouldn't use the code being tested to set up (we're
> testing "fetch --recurse-submodules", so we shouldn't use the same
> command to set up). Also, if we don't have confidence in the starting
> state, it may be a sign to write it out more explicitly instead of
> relying on a complicated command to do the right thing.

True. I think the easiest way to do this would be the
"porcelain-downstream" you suggested in v1. But as you mentioned...

> However, in this case, I don't think we need this. All we need is to see
> that the test contains a new superproject commit that points to a new
> submodule commit (and recursively). So we don't need this line.

this isn't necessary, so I don't know if this is worth the effort at the
moment. I'll tinker with it.

As for the line itself, you're right, we don't need this. The state of
the downstream was more important when we cared about the old branch
head (it's needed for test_cmp), but we no longer do.

>> +	# Create new superproject commit with updated submodules
>> +	add_upstream_commit &&
>> +	(
>> +		cd submodule &&
>> +		(
>> +			cd subdir/deepsubmodule &&
>> +			git fetch &&
>> +			git checkout -q FETCH_HEAD
>> +		) &&
>> +		git add subdir/deepsubmodule &&
>> +		git commit -m "new deep submodule"
>> +	) &&
>> +	git add submodule &&
>> +	git commit -m "new submodule" &&
>
> I thought add_upstream_commit() would do this, but apparently it just
> adds commits to the submodules (which works for the earlier tests that
> just tested that the submodules were fetched, but not for this one). I
> think that all this should go into its own function.
>
> Also, I understand that "git fetch" is there to pick up the commit we
> made in add_upstream_commit, but this indirection is unnecessary in a
> test, I think. Can we not use add_upstream_commit and just create our
> own in subdir/deepsubmodule? (This might conflict with subsequent tests
> that use the old scheme, but I think that it should be fine.)

I copy-pasted this from existing tests, but I'm not happy with how noisy
it is either. I'll tinker with this too.

>> +# In downstream, init "submodule2", but do not check it out while
>> +# fetching. This lets us assert that unpopulated submodules can be
>> +# fetched.
>
> Firstly, "In upstream", I think? You want to fetch from it, so it has to
> be upstream.

It is "in downstream" - we "git init" the upstream, but we need to "git
submodule update --init" (which wraps "git submodule init") in the
downstream. If we didn't init it in the downstream, downstream wouldn't
have the clone and wouldn't fetch.


> Secondly, is this test needed? I thought the case in which the worktree
> has no submodules would be sufficient to test that unpopulated
> submodules can be fetched.

I'd prefer to have this test because it tests the interaction between
populated and unpopulated submodules. e.g. in a previous iteration, I
only had the "no submodules" test, but accidentally reused the
submodule_parallel_fetch.count variable for both populated and
unpopulated submodules. The test suite didn't catch the bug - I only
noticed the bug by a stroke of luck.

>> +test_expect_success "'--recurse-submodules' should fetch submodule commits in changed submodules and the index" '
>
> [snip]
>
>> +	git checkout super &&
>> +	(
>> +		cd downstream &&
>> +		git fetch --recurse-submodules >../actual.out 2>../actual.err
>> +	) &&
>> +	test_must_be_empty actual.out &&
>> +
>> +	# Assert that the submodules in the super branch are fetched
>> +	git rev-parse --short HEAD >superhead &&
>> +	git -C submodule rev-parse --short HEAD >subhead &&
>> +	git -C deepsubmodule rev-parse --short HEAD >deephead &&
>> +	verify_fetch_result actual.err &&
>> +	# grep for the exact line to check that the submodule is read
>> +	# from the index, not from a commit
>> +	grep "^Fetching submodule submodule\$" actual.err &&
>
> Instead of a grep, I think this should be done by precisely specifying
> what to fetch in the "git fetch" invocation, and then checking that the
> submodule has commits that it didn't have before.

verify_fetch_result() already tells us that the submodule
has the new commit:

	if [ -f subhead ]; then
		grep "Fetching submodule submodule" $ACTUAL_ERR &&
		grep -E "\.\.$(cat subhead)\s+sub\s+-> origin/sub" $ACTUAL_ERR

but (by design) it does not tell us whether "git fetch" read the
.gitmodules config from the index or a commit. The additional grep with
"^$" tells us that we read from the index because it checks that the
info message is not "Fetching submodule submodule at commit <id>". We
want to have this check because we want "git fetch" to prefer the index
in the event that the submodule is both changed and populated.

> In addition, I think the following cases also need to be tested:
>  - two fetched commits have submodules of the same name but different
>    URL
>  - a fetched commit and a commit in the index have submodules of the
>    same name but different URL

It makes sense to test both cases. The former is a new edge case
introduced by this commit, while the latter is a concern before this
commit. I _believe_ that we already handle the latter gracefully, and
that the same logic can be used to handle the former, but I don't think
we have any tests proving either of these hypotheses.
