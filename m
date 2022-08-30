Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03BFECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 22:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiH3Wyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 18:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiH3Wyk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 18:54:40 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C6786C9
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 15:54:38 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id m34-20020a634c62000000b0042aff6dff12so6105840pgl.14
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 15:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date;
        bh=oJempy6aNuIduku0HZcpGtFZNcofN3jM2JtAlHeen3U=;
        b=UDuu+AOehwGH3N8cDrKdpehtZ3Gp2IEPhI9RawPgB9Yhjs+FCDzuKxoMHgIrp92nAd
         fE8XsiUOshxD0PKyfpK7TLuvlTE2dFaHM7Yy7qpyqUs37lnHuk74zkAVyYmhho6377Yc
         glC0v3rg3AYIq4RlpVTuF9twvrRbd6M+pwCRpiN17lqkl4In54tXkiL3jSR/NUkaC48y
         hTsM1zfiAC0TlqCsjzI9dKPAtuuBetL3xME+iZ3jAKJrFRq+Mr2tzIiSWYcDBQDQYGC9
         gInx1hCT6qpfA6wFMqpBvFKU4Uxa4iosXFWw1OvScMkne6jeH0B9smYY4683fv4bL6MT
         ztpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date;
        bh=oJempy6aNuIduku0HZcpGtFZNcofN3jM2JtAlHeen3U=;
        b=eMznHJfw4lSlL5p7bubAck085wq2kfuajFanscOc4pRhCE6aD5chohTE7MKC+8yzOF
         uWCIXpA2cjRKm8deRX2mLnMPnAHS/pNmM5bJVfjrZc6pV27Yq3AVXUQP1IBO+DgLhMG9
         JmuILS799Fm0eIwE+EB2PbU158LNq5bSzVYQ+3kJfV4zoyxpgClyvs2GfRA3A2sP20le
         YQuvKP3aIeIwNi9vpJIB7TWioImYOXXdLS8NcddHJ4HussUXEqgUvfWiNCUWmRcwtzgC
         Yp/+92iWVqjbA/qYoFlbhXPHtKt5oXiICswGdOk5OkNzT2iDknioRv7a1g2dsn/IZuSB
         FS9A==
X-Gm-Message-State: ACgBeo2cWpTGHJ5Llf7EYgOnw0pfvRi+G4DRZCnW790ok4UEfrdUGimk
        Dy7UXpHof2TsBJKHcqqZusf9MxMTRiBp8A==
X-Google-Smtp-Source: AA6agR69haVY/kl7nOdSOIoO2svxRcH65L2WLNfAy4N3l3DAeM7cIerTbHc8QaCA6ByIwQlke3m3D4kNSi7GrQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:c82:b0:538:3868:b4a6 with SMTP
 id a2-20020a056a000c8200b005383868b4a6mr12121063pfv.74.1661900078432; Tue, 30
 Aug 2022 15:54:38 -0700 (PDT)
Date:   Tue, 30 Aug 2022 15:54:36 -0700
In-Reply-To: <4e63e180-d275-83c2-d498-47bb0cfd160d@gmail.com>
Mime-Version: 1.0
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
 <6f7f2f9a3f19b6d874d644b7fb7feb3a72fc6227.1661806456.git.gitgitgadget@gmail.com>
 <4e63e180-d275-83c2-d498-47bb0cfd160d@gmail.com>
Message-ID: <kl6l8rn5cpg3.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 6/6] clone, submodule update: check out branches
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Glen,
>
> Le 2022-08-29 =C3=A0 16:54, Glen Choo via GitGitGadget a =C3=A9crit=C2=A0=
:
>> From: Glen Choo <chooglen@google.com>
>>=20
>> Teach "git submodule update" to update submodules by creating and
>> checking out the current superproject branch when
>> "submodule.propagateBranches=3Dtrue". "git clone --recurse-submodules"
>> also learns this trick because it is implemented with "git submodule
>> update --recursive".
>
> OK. Maybe a more descriptive title would then be:
>
> clone, submodule update: create and check out submodule branches
>
> ?

Ah, thanks. Your other wording suggestions upthread are also very
helpful.

>
> Another thing, 'git pull --recurse-submodules' is also implemented using
> 'git submodule update --recursive'. But I don't think we want 'git pull'
> to start creating new branches in submodules, even with submodule.propaga=
teBranches=3Dtrue
> (though I haven't thought about it very hard). So maybe adding a word abo=
ut
> that would be nice.

Good point. I thought that `git pull --recurse-submodules` used the
`--merge` strategy (in which case, it wouldn't matter), but looks like
it uses the `--checkout` strategy.

I'm quite certain we want to replace this `git pull
--recurse-submodules` implementation, aka non recursive `git merge` +
`git submodule update`, with a recursive `git merge` (and possibly
updating the worktrees with `git checkout --recurse-submodules`). Since
this flag is still experimental and incomplete, I think we have the
freedom to say that we won't care about this for now, but either way
I'll mention this somewhere.

>> "git submodule update" tries to create the branch as long as it is not
>> currently checked out, thus it will fail if the submodule has the
>> branch, but it is not checked out. This is fine because the main purpose
>> of "git submodule update" is to clone new submodules (which have no
>> branches, and will never have this problem). "git checkout" with
>> "submodule.propagateBranches" will cover the use case of recursively
>> checking out an existing branch.
>
> I guess you mean "in a future series" for the last sentence ? FWIW I stil=
l have
> your RFC from last Febryary about that [1] in my "unread Git mailing list=
" folder,
> I always seem to lack the time to sit down and read it through, sorry!
> Incidentally, I notice you did not link to it in the cover letter,=20
> any reasoon why?
>
> [1] https://lore.kernel.org/git/20220209065236.36494-1-chooglen@google.co=
m/

Ah, yes, I meant "in a future series". I didn't think that the RFC would
be very useful to reviewers since the non-RFC version is likely change a
lot (I've done a lot of tinkering between then and now), and it didn't
gain much traction in the first place anyway.

>
> Stepping back a bit, you write "thus it will fail if the submodule has th=
e
> branch, but it is not checked out." If I read your patch correctly, this =
is
> implicit in that 'git checkout -b super-branch' that is ran by 'run_updat=
e_command'
> will error out if the branch already exists, right ?=20
>
> Is there anything more we should do in that case ?=20
> Should we remind the user, something like
> "you have submodule.propagateBranches set, but the branch 'super-branch' =
already
> exists in submodule 'that-sub'" ?=20
>
> I'm trying to think of a scenario in which this could happen...
>
> Say a user:
> 1. clones a superproject with --recurse-submodules, but without 'submodul=
e.propagateBranches'
> 2. runs 'git checkout -b topic' in the superproject
> 3. runs 'git branch topic' in the submodule
> 4. runs 'git submodule update' with 'submodule.propagateBranches' in the =
superproject
>
> This fails:
>
> fatal: a branch named 'topic' already exists
> fatal: Unable to checkout 'deadbeef' in submodule path 'sub'
>
> Do we need a more specific message ? I'm not sure.

Hm, you're right, this does seem quite opaque to end users; this means
nothing if they don't know that `git submodule update` uses `git checkout
-b` under the hood, which they obviously shouldn't need to know.

The main simplifying assumption behind `submodule.propagateBranches` (or
at least, this early version of it) is that users won't interact with
branches on the submodules directly outside of very specific scenarios,
e.g. setting submodule-specific tracking info. So maybe the more
comprehensive solution would be to block users from creating branches if
the submodule's superproject uses `submodule.propagateBranches`.

>>=20
>> Signed-off-by: Glen Choo <chooglen@google.com>
>> ---
>>  builtin/submodule--helper.c | 28 ++++++++++++++++++++++++++--
>>  t/t5617-clone-submodules.sh | 34 ++++++++++++++++++++++++++++++++++
>>  t/t7406-submodule-update.sh | 22 ++++++++++++++++++++++
>>  3 files changed, 82 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index cbf6bda4850..7eb2c45900e 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -1695,6 +1695,9 @@ static int clone_submodule(struct module_clone_dat=
a *clone_data)
>>  			strvec_push(&cp.args, clone_data->single_branch ?
>>  				    "--single-branch" :
>>  				    "--no-single-branch");
>> +		if (the_repository->settings.submodule_propagate_branches)
>> +			strvec_push(&cp.args, "--detach");
>> +
>> =20
>>  		strvec_push(&cp.args, "--");
>>  		strvec_push(&cp.args, clone_data->url);
>> @@ -1733,6 +1736,9 @@ static int clone_submodule(struct module_clone_dat=
a *clone_data)
>>  	if (error_strategy)
>>  		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
>>  				       error_strategy);
>> +	if (the_repository->settings.submodule_propagate_branches)
>> +		git_config_set_in_file(p, "submodule.propagateBranches",
>> +				       "true");
>
> Why do we need to set that in the config of the submodule ? I'm guessing =
this=20
> is so that the new code also works for nested submodules, right ?=20

As long as the value is set in the superproject, the new code still
works. This is meant as a way of setting the user's preferred value in
the submodule. Although.. `git clone` doesn't automatically set this
value in the superproject - it would have to be read off
system/global/cli config, so maybe it's more coherent to acknowledge
that the user's preferred value probably isn't in the repo anyway, and
maybe I should just drop this.

>
> I'm thinking about a user that would alternate between 'submodule.propaga=
teBranches=3Dtrue' and 'false'.
> Maybe they sometimes have to work on the superproject and the submodule(s=
), sometimes=20
> only in the superproject. If they want to deactivate submodule.propagateB=
ranches, would they have to
> remember to also deactivate it in all submodules, in case of nested submo=
dules ?...  if so,
> this is a little unfortunate. But I _think_ they wouldn't have to, becaus=
e as long as=20
> it's false in the superproject config, then we won't get into the new cod=
e at all when running
> in the top level superproject...

Hm, would a user want to alternate in the first place? Maybe? e.g. with
`git checkout topic`, "true" would check out the submodule worktree at
the branch (including any WIP you have) but "false" would give you the
worktree specified by the superproject. Both are useful.

The way it's written now, "submodule.propagateBranches" is only passed
to submodule processes if it is "true", so it can be overrided by
submodule config if superproject says "false" but submodule says "true".
I should fix that..

>>  	free(sm_alternate);
>>  	free(error_strategy);
>> @@ -1792,6 +1798,7 @@ static int module_clone(int argc, const char **arg=
v, const char *prefix)
>>  	memset(&filter_options, 0, sizeof(filter_options));
>>  	argc =3D parse_options(argc, argv, prefix, module_clone_options,
>>  			     git_submodule_helper_usage, 0);
>> +	prepare_repo_settings(the_repository);
>> =20
>>  	clone_data.dissociate =3D !!dissociate;
>>  	clone_data.quiet =3D !!quiet;
>> @@ -1872,6 +1879,7 @@ struct submodule_update_clone {
>>  struct update_data {
>>  	const char *prefix;
>>  	const char *displaypath;
>> +	const char *super_branch;
>>  	enum submodule_update_type update_default;
>>  	struct object_id suboid;
>>  	struct string_list references;
>> @@ -2206,6 +2214,8 @@ static int run_update_command(struct update_data *=
ud, int subforce)
>>  		strvec_pushl(&cp.args, "checkout", "-q", NULL);
>>  		if (subforce)
>>  			strvec_push(&cp.args, "-f");
>> +		if (ud->super_branch)
>> +			strvec_pushl(&cp.args, "-b", ud->super_branch, NULL);
>>  		break;
>>  	case SM_UPDATE_REBASE:
>>  		cp.git_cmd =3D 1;
>> @@ -2456,6 +2466,7 @@ static void update_data_to_args(struct update_data=
 *update_data, struct strvec *
>>  static int update_submodule(struct update_data *update_data)
>>  {
>>  	int submodule_up_to_date;
>> +	const char *submodule_head =3D NULL;
>> =20
>>  	ensure_core_worktree(update_data->sm_path);
>> =20
>> @@ -2469,7 +2480,7 @@ static int update_submodule(struct update_data *up=
date_data)
>>  	if (update_data->just_cloned)
>>  		oidcpy(&update_data->suboid, null_oid());
>>  	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD",
>> -				     &update_data->suboid, NULL))
>> +				     &update_data->suboid, &submodule_head))
>>  		die(_("Unable to find current revision in submodule path '%s'"),
>>  			update_data->displaypath);
>> =20
>> @@ -2493,7 +2504,13 @@ static int update_submodule(struct update_data *u=
pdate_data)
>>  		free(remote_ref);
>>  	}
>> =20
>> -	submodule_up_to_date =3D oideq(&update_data->oid, &update_data->suboid=
);
>> +	if (update_data->super_branch &&
>> +	    submodule_head &&
>> +	    !skip_prefix(submodule_head, "refs/heads/", &submodule_head))
>> +		submodule_up_to_date =3D !strcmp(update_data->super_branch, submodule=
_head);
>
> I'm not sure I understand this logic. We want to change the 'submodule_up=
_to_date' boolean,
> so that we compare branch names instead of oid's, and we do that only if:
>
> 1. we are running with 'propagateBranches=3Dtrue' (so update_data->super_=
branch will be set to the superproject's branch)
> 2. a ref is checked out in the submodule (so submodule_head will hold its=
 name)
> 3. it's not a branch (so skip_prefix will return 0, and !skip_prefix will=
 be 1).=20
>    In that case it must be simply "HEAD", i.e. the submodule's HEAD is de=
tached.
>
> Why do we need (2. + 3.) ?=20

Oops I got skip_prefix() backwards, 3. should read "if a branch is
checked out". I'll add a test case for this (I could've sworn I had one
at some point).

>
> If branch 'foo' is currently checked out in the superproject, and
> branch 'bar' is currently checked out in the submodule, and someone
> runs 'git -c propagateBranches=3Dtrue submodule update', wouldn't they ex=
pect
> that 'bar' be checked out in the submodule ? Maybe not, but the commit me=
ssage
> and the tests should be more explicit about the expected behaviour in thi=
s case, I think.

Yeah, I'll call it out. I think this case is better addressed by having
`git checkout topic --recurse-submodules` automatically create "topic"
in the submodules that don't have it. This is one of the reasons why the
`git checkout` RFC isn't so relevant any more ;).

>> +	else
>> +		submodule_up_to_date =3D oideq(&update_data->oid, &update_data->suboi=
d);
>> +
>>  	if (!submodule_up_to_date || update_data->force)
>>  		if (run_update_procedure(update_data))
>>  			return 1;
>> @@ -2551,6 +2568,12 @@ static int update_submodules(struct update_data *=
update_data)
>>  		goto cleanup;
>>  	}
>> =20
>> +	if (the_repository->settings.submodule_propagate_branches) {
>> +		struct branch *current_branch =3D branch_get(NULL);
>> +		if (current_branch)
>> +			update_data->super_branch =3D current_branch->name;
>
> OK, so this condition means that super_branch won't get set if we are not
> currently on a branch, i.e. we are in detached HEAD. This makes sense as =
there
> would be no branch to propagate. Do we need a test for this ? maybe a cas=
e where
> we clone with '--recurse-submodules --branch some-tag' ?

Good point, I'll add a test for this.

>> +	}
>> +
>>  	for (i =3D 0; i < suc.update_clone_nr; i++) {
>>  		struct update_clone_data ucd =3D suc.update_clone[i];
>> =20
>> @@ -2634,6 +2657,7 @@ static int module_update(int argc, const char **ar=
gv, const char *prefix)
>>  	memset(&filter_options, 0, sizeof(filter_options));
>>  	argc =3D parse_options(argc, argv, prefix, module_update_options,
>>  			     git_submodule_helper_usage, 0);
>> +	prepare_repo_settings(the_repository);
>> =20
>>  	if (opt.require_init)
>>  		opt.init =3D 1;
>> diff --git a/t/t5617-clone-submodules.sh b/t/t5617-clone-submodules.sh
>> index b5c66cb18cb..215fb02e9fb 100755
>> --- a/t/t5617-clone-submodules.sh
>> +++ b/t/t5617-clone-submodules.sh
>> @@ -12,10 +12,17 @@ pwd=3D$(pwd)
>>  test_expect_success 'setup' '
>>  	git checkout -b main &&
>>  	test_commit commit1 &&
>> +	mkdir subsub &&
>> +	(
>> +		cd subsub &&
>> +		git init &&
>> +		test_commit subsubcommit1
>> +	) &&
>>  	mkdir sub &&
>>  	(
>>  		cd sub &&
>>  		git init &&
>> +		git submodule add "file://$pwd/subsub" subsub &&
>>  		test_commit subcommit1 &&
>>  		git tag sub_when_added_to_super &&
>>  		git branch other
>> @@ -106,4 +113,31 @@ test_expect_success '--no-also-filter-submodules ov=
errides clone.filterSubmodule
>>  	test_cmp_config -C super_clone3/sub false --default false remote.origi=
n.promisor
>>  '
>> =20
>> +test_expect_success 'submodule.propagateBranches checks out branches at=
 correct commits' '
>> +	git -C sub checkout -b not-main &&
>> +	git -C subsub checkout -b not-main &&
>> +	git clone --recurse-submodules \
>> +		-c submodule.propagateBranches=3Dtrue \
>> +		"file://$pwd/." super_clone4 &&
>> +
>> +	# Assert that each repo is pointing to "main"
>> +	for REPO in "super_clone4" "super_clone4/sub" "super_clone4/sub/subsub=
"
>> +	do
>> +	    HEAD_BRANCH=3D$(git -C $REPO symbolic-ref HEAD) &&
>> +	    test $HEAD_BRANCH =3D "refs/heads/main" || return 1
>> +	done &&
>> +
>> +	# Assert that the submodule branches are pointing to the right revs
>> +	EXPECT_SUB_OID=3D"$(git -C super_clone4 rev-parse :sub)" &&
>> +	ACTUAL_SUB_OID=3D"$(git -C super_clone4/sub rev-parse refs/heads/main)=
" &&
>> +	test $EXPECT_SUB_OID =3D $ACTUAL_SUB_OID &&
>> +	EXPECT_SUBSUB_OID=3D"$(git -C super_clone4/sub rev-parse :subsub)" &&
>> +	ACTUAL_SUBSUB_OID=3D"$(git -C super_clone4/sub/subsub rev-parse refs/h=
eads/main)" &&
>> +	test $EXPECT_SUBSUB_OID =3D $ACTUAL_SUBSUB_OID &&
>> +
>> +	# Assert that the submodules do not have branches from their upstream
>> +	test_must_fail git -C super_clone4/sub rev-parse not-main &&
>> +	test_must_fail git -C super_clone4/sub/subsub rev-parse not-main
>> +'
>> +
>>  test_done
>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>> index 6cc07460dd2..00a6fec8912 100755
>> --- a/t/t7406-submodule-update.sh
>> +++ b/t/t7406-submodule-update.sh
>> @@ -1178,4 +1178,26 @@ test_expect_success 'submodule update --recursive=
 skip submodules with strategy=3D
>>  	test_cmp expect.err actual.err
>>  '
>> =20
>> +test_expect_success 'submodule update with submodule.propagateBranches =
checks out branches' '
>> +	test_when_finished "rm -fr top-cloned" &&
>> +	cp -r top-clean top-cloned &&
>> +
>> +	# Create a new upstream submodule
>> +	git init middle2 &&
>> +	test_commit -C middle2 "middle2" &&
>> +	git -C top submodule add ../middle2 middle2 &&
>> +	git -C top commit -m "add middle2" &&
>> +
>> +	git -C top-cloned checkout -b "new-branch" &&
>> +	git -C top-cloned pull origin main &&
>> +	test_config -C top-cloned submodule.propagateBranches true &&
>> +	git -C top-cloned submodule update --recursive &&
>> +
>> +	for REPO in "top-cloned/middle2" "top-cloned/middle" "top-cloned/middl=
e/bottom"
>> +	do
>> +	    HEAD_BRANCH=3D$(git -C $REPO symbolic-ref HEAD) &&
>> +	    test $HEAD_BRANCH =3D "refs/heads/new-branch" || return 1
>> +	done
>> +'
>> +
>>  test_done
>>=20
>
> These tests look good, but maybe more tests would be needed in=20
> the light of my comments above...=20
>
> Thanks again for working on improving submodules!

Thanks for lending your time and attention :)
>
> Cheers,
>
> Philippe.
