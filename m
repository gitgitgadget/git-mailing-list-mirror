Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ED8C433FE
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 18:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345833AbiBNSEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:04:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbiBNSEl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 13:04:41 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D344DF73
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 10:04:33 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id j23-20020a17090a7e9700b001b8626c9170so14764272pjl.1
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 10:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wb+xZQOv/zQGpfrwNx/5jsWQjExDJWRvzHkcUhn+8Z0=;
        b=IP4szVDkhkBhsKQbC3CncwaqFRTx7oPzeNI/0bIRGDkh0shcXLnd7LNjegjbL9stuX
         F/W9TqEGTOIgY1UjLwxqaGehQoISqTMyexWhMTHAZAr3l3kUkwwqtpEIUr/AdBisC79r
         xaxf5B7GJP0COWY+iSH99GpTjUXlyz4GG67GZU7GVz7wlpSAAxT+kEYga6vXEtv43Zdw
         JbH5dMiIF6LHma7mC9ie5Ga4LdyEM0Pxu/fxVcUdLPd6rJMy+YKUDloCSDyORnc6iaXn
         6K9UBR/54GwazBdJb7ILVxCE4n9G0kRg54/bIMlyiBkf2GGIdUTHv2xSDYo5MEgtYlFD
         SxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wb+xZQOv/zQGpfrwNx/5jsWQjExDJWRvzHkcUhn+8Z0=;
        b=gyJUS8KTRQAEQR9Zt/1LtsS5NqKXqp9y5WHU3+Y+lHn7oyrgZp++WBd5nfRTNfP2rG
         nPkO9R7Pu5OM41Qgsa+DqfQm4Mk+Ah5itC0ZRNLQ4vxgb8E42xSfp6f4DLDKihcTpzk8
         ShUX7dbgMmgX/RGniLxRor9ysBGBYaDA3+5AtaqENeqtojreITfeXNFpiA/hoHNSvvqo
         xor882wWuqgqZ3J/O7Kmh7rtCeeyn4eyH8UG1zo3mfKhcTGYMTCwCY3P9QbOWE041xnU
         SSR0zj8N1WgJ9cw+6FDsYVhlgYwU1N4XlFExC3CL+f71sn9A9TMHLUEy7kZEQ4Ob1RGd
         VQMg==
X-Gm-Message-State: AOAM533G+CQ9vKqeDOevzieEpYFOFkX76J2yX3P2d9v3J2v/aJdBZJYk
        5XplAem1AJDRj3jbzr/qaE7QuH/SVCsHFA==
X-Google-Smtp-Source: ABdhPJwqAuL91OXZr8fOYPfxw6U8KAaOsNBh5zgj9jXxE9Sede55+AsQSnOx4knO3Lk5qyf0XpVSIPrUz3hIWw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:3907:: with SMTP id
 ob7mr16030808pjb.29.1644861872829; Mon, 14 Feb 2022 10:04:32 -0800 (PST)
Date:   Tue, 15 Feb 2022 02:04:30 +0800
In-Reply-To: <20220210225137.688066-1-jonathantanmy@google.com>
Message-Id: <kl6l7d9x72a9.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220210225137.688066-1-jonathantanmy@google.com>
Subject: Re: [PATCH 7/8] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> submodule.c has a seemingly-unrelated change that teaches the "find
>> changed submodules" rev walk to call is_repository_shallow(). This fixes
>> what I believe is a legitimate bug - the rev walk would fail on a
>> shallow repo.
>> 
>> Our test suite did not catch this prior to this commit because we skip
>> the rev walk if .gitmodules is not found, and thus the test suite did
>> not attempt the rev walk on a shallow clone. After this commit,
>> we always attempt to find changed submodules (regardless of whether
>> there is a .gitmodules file), and the test suite noticed the bug.
>
> Is this bug present without the other code introduced in this patch? If
> yes, it's better to put the bugfix in a separate patch with a test that
> would have failed but now passes.

Makes sense, I'll do so.

>> @@ -1273,10 +1277,6 @@ static void calculate_changed_submodule_paths(struct repository *r,
>>  	struct strvec argv = STRVEC_INIT;
>>  	struct string_list_item *name;
>>  
>> -	/* No need to check if there are no submodules configured */
>> -	if (!submodule_from_path(r, NULL, NULL))
>> -		return;
>
> I think this is removed because "no submodules configured" here actually
> means "no submodules configured in the index", but submodules may be
> configured in the superproject commits we're fetching.
>
> I wonder if this should be mentioned in the commit message, but I'm OK
> either way.

Yes, your interpretation is correct. Though, as Junio mentioned in
<xmqqtud6e3r8.fsf@gitster.g>, I think we'd prefer to have _some kind_ of
check, even though this one no longer makes sense.

>
>>  struct submodule_parallel_fetch {
>> -	int count;
>> +	int index_count;
>> +	int changed_count;
>
> Here (and elsewhere) we're checking both the index and the superproject
> commits for .gitmodules. Do we still need to check the index?

Since this is a frequently asked question, I answered this elsewhere,
namely <kl6lczjp7nwj.fsf@chooglen-macbookpro.roam.corp.google.com>.

>> +# Cleans up after tests that checkout branches other than the main ones
>> +# in the tests.
>> +checkout_main_branches() {
>> +	git -C downstream checkout --recurse-submodules super &&
>> +	git -C downstream/submodule checkout --recurse-submodules sub &&
>> +	git -C downstream/submodule/subdir/deepsubmodule checkout --recurse-submodules deep
>> +}
>
> If we need to clean up in this way, I think it's better if we store a
> pristine copy somewhere (e.g. pristine-downstream), delete downstream,
> and copy it over when we need to.

The need for cleanup isn't that big; this just checks out the right
branches after we've checked out _other_ branches. If remove
the checkout, we won't need this any more, and...

>> +	# Fetch the new superproject commit
>> +	(
>> +		cd downstream &&
>> +		git switch --recurse-submodules no-submodules &&
>> +		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err &&
>> +		git checkout --recurse-submodules origin/super 2>../actual-checkout.err
>
> This patch set is about fetching, so the checkout here seems odd. To
> verify that the fetch happened successfully, I think that we should
> obtain the hashes of the commits that we expect to be fetched from
> upstream, and then verify that they are present downstream.

IIUC this feedback correctly, the checkout is just an indirect way of
checking if we have the commit, so it makes more sense to just check if
we have the commit.

But explicitly checking for the commit (with "git cat-file -e" I
assume?) is probably overkill - verify_fetch_result() already checks for
this by grep-ing the output of "git fetch".

So I think it's ok to drop the checkout and not check for the commit
(beyond verify_fetch_result()).

>> +# Test that we can fetch submodules in other branches by running fetch
>> +# in a branch that has no submodules.
>> +test_expect_success 'setup downstream branch without submodules' '
>> +	(
>> +		cd downstream &&
>> +		git checkout --recurse-submodules -b no-submodules &&
>> +		rm .gitmodules &&
>> +		git rm submodule &&
>> +		git add .gitmodules &&
>> +		git commit -m "no submodules" &&
>> +		git checkout --recurse-submodules super
>> +	)
>> +'
>
> The tip of the branch indeed doesn't have any submodules, but when
> fetching this branch, we might end up fetching some of the tip's
> ancestors (depending on the repo we're fetching into), which do have
> submodules. If we need a branch without submodules, I think that all
> ancestors should not have submodules too.
>
> That might be an argument for creating our own downstream and upstream
> repos instead of reusing the existing ones.

I think I just made a silly wording error, I meant a "commit" or
"working tree state" without submodules, not a branch. The behavior I
wanted to test is whether or not changed submodules are fetched in
the absence of submodules and .gitmodules in the index/working tree.

>> +test_expect_success "'--recurse-submodules=on-demand' should fetch submodule commits if the submodule is changed but the index has no submodules" '
>> +	test_when_finished "checkout_main_branches" &&
>> +	git -C downstream fetch --recurse-submodules &&
>> +	# Create new superproject commit with updated submodules
>> +	add_upstream_commit &&
>> +	(
>> +		cd submodule &&
>> +		(
>> +			cd subdir/deepsubmodule &&
>> +			git fetch &&
>
> Hmm...I thought submodule/subdir/deepsubmodule is upstream. Why is it
> fetching?

Ah, deepsubmodule is a submodule in the "submodule/" repo, whose
remote is in "deepsubmodule/":

  test_expect_success setup '
    mkdir deepsubmodule &&
    (
      cd deepsubmodule &&
      git init &&
      echo deepsubcontent > deepsubfile &&
      git add deepsubfile &&
      git commit -m new deepsubfile &&
      git branch -M deep
    ) &&
    mkdir submodule &&
    (
      cd submodule &&
      git init &&
      echo subcontent > subfile &&
      git add subfile &&
      git submodule add "$pwd/deepsubmodule" subdir/deepsubmodule &&
      git commit -a -m new &&
      git branch -M sub
    )

So we fetch in "submodule/subdir/deepsubmodule" to get a new
deepsubmodule and (non-deep) submodule commit. Both of these commits
are then used to construct a new superproject commit.

If this is too confusing, maybe I should try to make the test simpler.

>
>> +	# Assert that we can checkout the superproject commit with --recurse-submodules
>> +	! grep -E "error: Submodule .+ could not be updated" actual-checkout.err
>
> Negative greps are error-prone, since they will also appear to work if
> the message was just misspelled. We should probably check that the
> expected commit is present instead.

That's a good point, I hadn't considered that.

>> +# Test that we properly fetch the submodules in the index as well as
>> +# submodules in other branches.
>> +test_expect_success 'setup downstream branch with other submodule' '
>> +	mkdir submodule2 &&
>> +	(
>> +		cd submodule2 &&
>> +		git init &&
>> +		echo sub2content >sub2file &&
>> +		git add sub2file &&
>> +		git commit -a -m new &&
>> +		git branch -M sub2
>> +	) &&
>> +	git checkout -b super-sub2-only &&
>> +	git submodule add "$pwd/submodule2" submodule2 &&
>> +	git commit -m "add sub2" &&
>> +	git checkout super &&
>> +	(
>> +		cd downstream &&
>> +		git fetch --recurse-submodules origin &&
>> +		git checkout super-sub2-only &&
>> +		# Explicitly run "git submodule update" because sub2 is new
>> +		# and has not been cloned.
>> +		git submodule update --init &&
>> +		git checkout --recurse-submodules super
>> +	)
>> +'
>
> I couldn't see the submodule in the index to be fetched; maybe it's
> there somewhere but it's not obvious to me.

If it helps, I've updated the description to:

  # In downstream, init "submodule2", but do not check it out while
  # fetching. This lets us assert that unpopulated submodules can be
  # fetched.

The 'submodules in the index' are the existing submodules ("submodule"
and "submodule/subdir/deepsubmodule"), and the changed, unpopulated
submodule is "submodule2".

> Also, why do we need to run "git submodule update"? This patch set
> concerns itself with fetching existing submodules, not cloning new
> ones.

In this setup step, 'downstream' clones 'submodule2' using "git
submodule update". So from the perspective of the following tests,
'submodule2' is an existing submodule. We could have cloned 'submodule2'
in an earlier setup step, but it wouldn't have been needed until these
tests.
