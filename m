Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5467AC433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 18:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243850AbhKXSWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242520AbhKXSV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 13:21:58 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA69C061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 10:18:48 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x18-20020a17090a789200b001a7317f995cso3660646pjk.4
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 10:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B0G6KBSRLRiCqzhQIWpFcfdb1pOTXqPYs8DKdhfLLF8=;
        b=Q3BK3OIxJj0B4WBh7KPM6BdBZbHmbsAxiMfoilnU5LUj2IzteqBkL9EaIqlNKrTGVY
         ZSd39BHbtnAksE1gAQowttIOCxr44sLFOFD9qI1o5mUd5xWGCguQE/NBm2G47NZmlNwZ
         tpjttPWpBRaxayBnWGVeduyBZ98AiYDBKMtFsc6tOkyMTWZFXXIkmtJa18v2Mt3g+ypo
         i0+tBzh9gcHVItqH3YY57UUALgSHLbEApcZ4cS4bqdLD/ce6/3ydbvmTQq4k1dpE57wj
         nv5R76/frwlW7hfCiJVS8kBQCUY4BlaWJ3dT7m/OK6UxjGPjSd6jJMDX1ZwSISvgr/8+
         DVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B0G6KBSRLRiCqzhQIWpFcfdb1pOTXqPYs8DKdhfLLF8=;
        b=Yk8dhNOx+Wez7owmJr6fuG5VYsVGc1/A805CrPceuYTqxmRqFIgh1o9rqoyJZ6mxLz
         FRgDH8k7hb7ZvVi8hFeT2TW1R9Cag5XHuDJewwIP7afceKmKlF4ULJEgwwoFx/0QQkFH
         tzz0/0gyKWu84/ys/Y1dPSoMxxaQN0KaBxVACtj60j6FN+1KUlfLISfgGzfvsACLham+
         RMay5cvQOjYdPALgu1gCTAKhEBrhBhBHOQJ4irYMZku6qIBQCiyd+QAO8ADhF/3WPkgu
         +Obtp2QqazcXpK8IW4BF/5bmaJ3XG+ylAZZsYyM87IMAokhV3+CjxpsvH0zCVD/6BAwf
         l+Jg==
X-Gm-Message-State: AOAM531FKrDe/k9zFWsq6iVK7kaWkAN5Xr0utzGVraCeNO5o6EvpxWEQ
        1asWNvfoP1IkZkCU+Ll9sPjOUlocLawv4Q==
X-Google-Smtp-Source: ABdhPJwSs3yqls+dsUk1jx+NaSWZFFfTTe2r3xoqrbRbQ902EasifzSJGpgL70MOGs3LuxvcFXL4gyCEtpjXCg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7d8b:b0:144:e29b:4f2b with SMTP
 id a11-20020a1709027d8b00b00144e29b4f2bmr21430651plm.57.1637777927944; Wed,
 24 Nov 2021 10:18:47 -0800 (PST)
Date:   Wed, 24 Nov 2021 10:18:46 -0800
In-Reply-To: <20211124013153.3619998-1-jonathantanmy@google.com>
Message-Id: <kl6lmtltto1l.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211122223252.19922-5-chooglen@google.com> <20211124013153.3619998-1-jonathantanmy@google.com>
Subject: Re: [PATCH 4/4] branch: add --recurse-submodules option for branch creation
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks! The feedback is really useful.

Jonathan Tan <jonathantanmy@google.com> writes:

>> +static int submodule_create_branch(struct repository *r, const char *name,
>> +				   const char *start_oid,
>> +				   const char *start_name, int force,
>> +				   int reflog, int quiet,
>> +				   enum branch_track track, char **err_msg)
>> +{
>> +	int ret = 0;
>> +	struct child_process child = CHILD_PROCESS_INIT;
>> +	struct strbuf child_err = STRBUF_INIT;
>> +	child.git_cmd = 1;
>> +	child.err = -1;
>> +
>> +	prepare_other_repo_env(&child.env_array, r->gitdir);
>> +	strvec_pushl(&child.args, "submodule--helper", "create-branch", NULL);
>
> Before this function is a function that calls "git branch" directly -
> couldn't this function do the same? (And then you can make both of them
> into one function.) The functionality should be exactly the same except
> that one has "--dry-run" and the other doesn't.

I see two somewhat valid interpretations, so I will address both.

If you are suggesting that I should call "git branch" instead of a new
"git submodule--helper create-branch", that unfortunately does not work.
Because of how we've defined the semantics, we want the submodule to
branch off the commit in the superproject tree (which is a bare object
id), but we want to set up tracking based off the ref that the user gave
(evaluating it in the context of the submodule). This is why
submodule--helper.c:module_create_branch() makes two calls like so:

	create_branch(the_repository, "<branch name>", "<object id>", force, 0, reflog, quiet,
		      BRANCH_TRACK_NEVER);
	setup_tracking("<branch name>", "<tracking name>", track, quiet, 0);

On the other hand, you might be suggesting that I should just add
--dry-run to "git submodule--helper create-branch". That way, the
dry-run form of the command is validating the non dry-run form (instead
of using "git branch --dry-run" to validate "git submodule--helper
create-branch"). That's a reasonable suggestion that avoids
bikeshedding around "git branch --dry-run".

>> @@ -874,6 +894,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>  			FREE_AND_NULL(unused_full_ref);
>>  			return 0;
>>  		}
>> +		if (recurse_submodules) {
>> +			create_submodule_branches(the_repository, branch_name,
>> +						  start_name, force, reflog,
>> +						  quiet, track);
>> +			return 0;
>> +		}
>>  		create_branch(the_repository, branch_name, start_name, force, 0,
>>  			      reflog, quiet, track);
>>  	} else
>
> create_submodule_branches() here is a bit misleading since it also
> creates branches in the_repository. Might be better to write explicitly
> check in submodules -> create in main repository -> create in
> submodules. Or, if you want to combine all the submodule code in one
> function, (check in submodules -> create in submodules) -> create in
> main repository.

Philippe had a similar comment, I will rename it.

>> +test_expect_success 'setup superproject and submodule' '
>> +	git init super &&
>> +	test_commit foo &&
>> +	git init sub-upstream &&
>> +	test_commit -C sub-upstream foo &&
>> +	git -C super submodule add ../sub-upstream sub &&
>> +	git -C super commit -m "add submodule" &&
>> +	git -C super config submodule.propagateBranches true
>> +'
>
> If making each test independent is important (which seems like a good
> goal to me, although I know that the Git tests are inconsistent on
> that), we could make this into a bash function (with test_when_finished)
> that gets called in every test. It doesn't violate the t/README request
> to put all test code inside test_expect_success assertions (since the
> function is still being run inside an assertion).

That's an interesting idea and it's more likely to be correct than my
approach. I think it lines up better with testing best practices.
However...

> In the general case, it will make test code slower to run, but if you're
> going to have to cleanup branches, I think it's better to just recreate
> the repo. In any case, for the general case, I can start a separate
> email thread for this discussion.

I'm concerned about the same thing and I suspect that recreating the
repo won't be kindly received by some reviewers, even if they might be
able to stomach cleanup_branches(). I think your suggestion is a better
long-term direction, but I'd like to see discussion on the general case
before changing the tests. A separate thread sounds good.

>> +test_expect_success '--recurse-submodules should be ignored if submodule.propagateBranches is false' '
>> +	test_when_finished "cleanup_branches super branch-a" &&
>> +	(
>> +		cd super &&
>> +		git -c submodule.propagateBranches=false branch --recurse-submodules branch-a &&
>> +		git rev-parse branch-a &&
>> +		test_must_fail git -C sub rev-parse branch-a
>> +	)
>> +'
>
> This doesn't sound like the right behavior to me - I think it's fine if
> it was the config "submodule.recurse" instead of "--recurse-submodules",
> but if the argument is given on CLI, it should be a fatal error.

Philippe mentioned the same thing, which sounds right to me.

>> +test_expect_success 'should create branch when submodule is in .git/modules but not .gitmodules' '
>> +	test_when_finished "cleanup_branches super branch-a branch-b branch-c" &&
>> +	(
>> +		cd super &&
>> +		git branch branch-a &&
>> +		git checkout -b branch-b &&
>> +		git submodule add ../sub-upstream sub2 &&
>> +		# branch-b now has a committed submodule not in branch-a
>> +		git commit -m "add second submodule" &&
>> +		git checkout branch-a &&
>> +		git branch --recurse-submodules branch-c branch-b &&
>> +		git rev-parse branch-c &&
>> +		git -C sub rev-parse branch-c &&
>> +		git checkout --recurse-submodules branch-c &&
>> +		git -C sub2 rev-parse branch-c
>> +	)
>> +'
>
> Hmm...how is this submodule in .git/modules but not .gitmodules? It
> looks like a normal submodule to me.

The test title is probably too terse - the submodule is not in the
working tree's .gitmodules, but it is in branch-b's .gitmodules. I'll
reword the title.

>> +test_expect_success 'should not create branch when submodule is not in .git/modules' '
>
> The title of this test contradicts the title of the test that I quoted
> previously.

I'm not sure how this is a contradiction, from before..

  should create branch when submodule is in .git/modules but not
  [the working tree's] .gitmodules

meaning "we should create the branch if we can find the submodule in
.git/modules", i.e. the implication is: presence in .git/modules => can
create branch.

Whereas

  should not create branch when submodule is not in .git/modules

meaning "we should not create the branch if we cannot find the submodule
in .git/modules", i.e. the implication is: absence in .git/modules =>
cannot create branch.

Taken together, they assert that presence in .git/modules is a necessary
condition for the subodule branch to be created.

>> +test_expect_success 'should not fail when unable to set up tracking in submodule' '
>> +	test_when_finished "cleanup_branches super-clone branch-b" &&
>> +	(
>> +		cd super-clone &&
>> +		git branch --recurse-submodules branch-b origin/branch-b
>> +	)
>> +'
>
> Is there a warning printed that we can check?

"git branch" does not warn if tracking is not set up when it is not
explicitly required, so this does not warn. However, I can imagine that
if the superproject branch has tracking set up, a user might expect that
all submodules would also have tracking set up, and thus a warning might
be useful. I don't think it will be _that_ useful for most users, but at
least some users would probably appreciate it.

For slightly unrelated reasons, I tried to get the tracking info of a
newly created branch and it is tedious. For this reason and the fact
that I'm not sure if the benefit is that great, I'm tempted *not* to add
the warning, but perhaps you feel more strongly than I do?

> Also, this patch set doesn't discuss the case in which the branch in a
> submodule already exists, but it points to the exact commit that we
> want. What is the functionality in that case?

The behavior is identical to the general case where the branch already
exists - branch validation (git branch --dry-run) fails.

> I would say that the user should be able to recursively create the
> branch in this case, but am open to other opinions.

I'm inclined to disagree. To illustrate this in the real world, say a
user wants to create a 'new-feature' branch recursively, but there is
already a 'new-feature in a submodule. Here are two possible sets of
events that could lead to this situation:

1) the 'new-feature' branch was intended for the same work as the new
   branch but the user just happened to create the 'new-feature'
   subomdule branch first
2) the existing 'new-feature' branch doesn't actually contain the same
   work (maybe it's an overloaded term, or maybe the user used a branch
   to bookmark a commit before starting work on it)

What would happen if we allowed the branch to be created? In case 1,
the user would be more than happy (because we read their mind! woohoo!)
But in case 2, the user might not realize that their bookmark is getting
clobbered by the new recursive branch - they might try revisiting their
bookmark only to realize that they've accidentally committed on top of
it.

I think the incidence of case 2 is far lower than case 1's, but I think
it's reasonable to be defensive by default. In any case, we can change
the default after more user testing.

> In any case, that case should be tested.

Testing this case would make the intended behavior clearer, so I will
add this test.
