Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25C6C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiF3Xpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiF3Xpb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:45:31 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BED57255
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:45:27 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id gd18-20020a17090b0fd200b001ef193b5452so438708pjb.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=GrRX0r/UxYhcINHqdv+KJzLH6ZoeLeWfCvlF2LuZMu4=;
        b=VCx4z5KFzVZ5oNzQKHa92X+1528YlxR8QT74Q3S/wJOU/apyhLcNszC/kTa1RSj6aJ
         5MFwOPXftVjRD9e2ZnLDS8LR6wpdWOTzoQIZ6JueqC2jgTksq0EiLMBu+gbsZhv/rTjI
         roKnqu/iqFKH61XHLNRxM2JQR+UDxdbAFkSnD7KiRf0U034h7Cl9ZRndEhg72o4ksp6/
         7AZ3mqnzC1IQw3X49HZqy+NwP+vSQh/hpxG4f9nLxn6AwM97ek4D6EwO+9NByYFaGj2v
         4jx35kKFzJT8JeI53QpH3yNm7XmaHqv1hS5n87HXJk0WZ359tICzuHR35e9+Vk8mW+TJ
         YWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=GrRX0r/UxYhcINHqdv+KJzLH6ZoeLeWfCvlF2LuZMu4=;
        b=Aa9pKtLSxGrE68KFFXBY4ZAsIS4zNW5Qw+ohIEK1oGl9Xb2Pw/ASAvD5Yb3O5E2On2
         KyCBl6Rv5M+lYOOh7sDTBVuDarbxZFt0cE+Out8UlxzZZZanpyfBvv30W/64nA+dhASQ
         /ifPM2EBqATolMl4EhTYqRj3uH/BTw8q/xcpydzrl4S6gs71CupRAVaW9ZAM4E4bPEVW
         xJHUQqidWk63fSBIPrGeaWFK8EgCm6RvWGPWILtv9aPgwEMRh4nhmSq6KLW8AyD7bZb1
         KTv+hcxmODiHr985h0LmL9+YR6CWKRk/Tuis5xOnb/Qrzp2hoPjfbw53APLjlLcHCSeI
         zBeA==
X-Gm-Message-State: AJIora8DIEHILiZgcCio0DdhNRn8yH/baNQuDJxxSy9UOc1S674SPLD1
        +0WE9u3EedV/HrbcWKBCzPA5DYtNAZKz6g==
X-Google-Smtp-Source: AGRyM1vSyQv/Iy8FJJMQpb2oPa/vkUajpYmTpNa6laXTXZyQhXOmqcDuwYuafMk4QgzVcaw6Aym/X1Kfcu1ngQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:889:b0:510:91e6:6463 with SMTP
 id q9-20020a056a00088900b0051091e66463mr17015911pfj.58.1656632726657; Thu, 30
 Jun 2022 16:45:26 -0700 (PDT)
Date:   Thu, 30 Jun 2022 16:45:24 -0700
In-Reply-To: <220701.865ykhdboc.gmgdl@evledraar.gmail.com>
Message-Id: <kl6ltu81sokr.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
 <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com> <220701.865ykhdboc.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v2 00/18] submodule: remove "--recursive-prefix"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Jun 30 2022, Glen Choo via GitGitGadget wrote:
>
>> =3D Series history
>>
>> Changes in v2:
>>
>>  * Rebase onto ab/submodule-cleanup (previously master)
>>  * Cherry pick https://github.com/avar/git/commit/f445c57490d into 4/6
>>  * Style fixes in .c and tests
>
> Thanks for the update, Looks like something happened with GGG to send
> the base series + yours, I confirmed that 1-13/18 are the same as my
> series in gitster/ab/submodule-cleanup.

Yes, oops. I resent this as v3 (sans your base), but you can ignore
that :P

> I played around with this a bit, and pushed some amends to
> https://github.com/avar/git/tree/avar/pr-git-1282/chooglen/submodule/remo=
ve-recursive-prefix-v2;
> which you should take more as the results of poking around, I think this
> is fine as-is if Junio would like to pick it up, sans the possible bug
> mentioned below.
>
> A range-diff of the changes I made follows below, changes:
>
>  * Split up the "add tests" to a new commit :) You mentioned
>    "test_expect_failure", I just assumed we'd use test_expect_succes,
>    and then the 2nd commit has this test change:
> =09
> 	diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> 	index 9a076e025f3..6cc07460dd2 100755
> 	--- a/t/t7406-submodule-update.sh
> 	+++ b/t/t7406-submodule-update.sh
> 	@@ -1163 +1163 @@ test_expect_success 'submodule update should skip unme=
rged submodules' '
> 	-       Skipping unmerged submodule middle//bottom
> 	+       Skipping unmerged submodule middle/bottom
> 	@@ -1176 +1176 @@ test_expect_success 'submodule update --recursive skip=
 submodules with strategy=3D
> 	-       Skipping submodule '\''../middle/'\''
> 	+       Skipping submodule '\''middle/bottom'\''
>
>    Which I think makes it much easier to explain the change itself, the
>    first commit basically just says "tests for existing behavior, see
>    the next commit for details".

Ah, I see what you meant now. Makes sense.

>  * Used test_cmp instead of "grep -F", makes for easier to grok output :)
>
>  * I had to squint a bit at the change from strvec_pushl() to
>    strvec_pushf().
>
>    I.e. we're changing both that we're passing "--foo bar"
>    v.s. "--foo=3Dbar" *and* "bar" v.s. "bar/", but as the commit message
>    notes it's just the latter that matters.
>
>    Just a nit, but I think it's a bit easier to reason about just
>    changing the one thing we need to change there, although that means
>    giving the "if" braces. This also leaves the "--super-prefix" code
>    consistent with all the other places where we
>    "strvec.*--super-prefix" at the end.

Both sound good.

>  * We can just declare some of the variables and initialize them at the
>    beginning, but couldn't when they were a strbuf.

I think this is just "char *displaypath" in 2/7 aka d1a47d302e
(submodule--helper update: use display path helper, 2022-06-28)? That
change makes sense.

>  * Your 18/18 has some odd code formatting of "var =3D\n\t\tvalue(..."
>    when we usually do "var =3D value(...\n...".

Thanks for catching that. I could have sworn that came from "make
style".

>  * You appear to have (and I haven't "fixed" it here) in 13/18 mentioned
>    "While we're fixing the display names, also fix inconsistent quoting
>    of the submodule name", but as the test_cmp shows we appear not to
>    have done that part at all? Is this referring to a forgotten change
>    where we should be saying (note the added '-quotes):
>
>        Skipping unmerged submodule 'middle/bottom'
>
>    Either that's what you mean & you forgot, or we're missing a test, or
>    I'm misunderstanding it...

Yes, this is a genuine error. In v2, I dropped this change (as you
suggested) and I neglected to amend the comit message..

> I hope this helps, at least some of it...

Thanks! Yes it helps a lot. If you don't mind, I'll roll your commits +
the commit message fix as v4.

> 1:  64c138df196 ! 1:  3d9977006d3 submodule--helper update: use display p=
ath helper
>     @@ Metadata
>      Author: Glen Choo <chooglen@google.com>
>     =20
>       ## Commit message ##
>     -    submodule--helper update: use display path helper
>     +    submodule--helper tests: add missing "display path" coverage
>     =20
>          There are two locations in prepare_to_clone_next_submodule() tha=
t
>     -    manually calculate the submodule display path, but should just u=
se
>     -    do_get_submodule_displaypath() for consistency.
>     -
>     -    Do this replacement and reorder the code slightly to avoid compu=
ting
>     -    the display path twice.
>     -
>     -    This code was never tested, and adding tests shows that both the=
se sites
>     -    have been computing the display path incorrectly ever since they=
 were
>     -    introduced in 48308681b0 (git submodule update: have a dedicated=
 helper
>     -    for cloning, 2016-02-29) [1]:
>     -
>     -    - The first hunk puts a "/" between recursive_prefix and ce->nam=
e, but
>     -      recursive_prefix already ends with "/".
>     -    - The second hunk calls relative_path() on recursive_prefix and
>     -      ce->name, but relative_path() only makes sense when both paths=
 share
>     -      the same base directory. This is never the case here:
>     -      - recursive_prefix is the path from the topmost superproject t=
o the
>     -        current submodule
>     -      - ce->name is the path from the root of the current submodule =
to its
>     -        submodule.
>     -      so, e.g. recursive_prefix=3D"super" and ce->name=3D"submodule"=
 produces
>     -      displayname=3D"../super" instead of "super/submodule".
>     -
>     -    While we're fixing the display names, also fix inconsistent quot=
ing of
>     -    the submodule name.
>     -
>     -    [1] I verified this by applying the tests to 48308681b0.
>     +    manually calculate the submodule display path, as discussed in t=
he
>     +    next commit the "Skipping" output isn't exactly what we want, bu=
t
>     +    let's test how we behave now, before changing the existing behav=
ior.
>     =20
>          Signed-off-by: Glen Choo <chooglen@google.com>
>     -
>     - ## builtin/submodule--helper.c ##
>     -@@ builtin/submodule--helper.c: static int prepare_to_clone_next_sub=
module(const struct cache_entry *ce,
>     - 	const char *update_string;
>     - 	enum submodule_update_type update_type;
>     - 	char *key;
>     --	struct strbuf displaypath_sb =3D STRBUF_INIT;
>     - 	struct strbuf sb =3D STRBUF_INIT;
>     --	const char *displaypath =3D NULL;
>     -+	char *displaypath;
>     - 	int needs_cloning =3D 0;
>     - 	int need_free_url =3D 0;
>     -=20
>     -+	displaypath =3D do_get_submodule_displaypath(ce->name,
>     -+						   suc->update_data->prefix,
>     -+						   suc->update_data->recursive_prefix);
>     -+
>     - 	if (ce_stage(ce)) {
>     --		if (suc->update_data->recursive_prefix)
>     --			strbuf_addf(&sb, "%s/%s", suc->update_data->recursive_prefix, ce=
->name);
>     --		else
>     --			strbuf_addstr(&sb, ce->name);
>     --		strbuf_addf(out, _("Skipping unmerged submodule %s"), sb.buf);
>     -+		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath=
);
>     - 		strbuf_addch(out, '\n');
>     - 		goto cleanup;
>     - 	}
>     -=20
>     - 	sub =3D submodule_from_path(the_repository, null_oid(), ce->name);
>     -=20
>     --	if (suc->update_data->recursive_prefix)
>     --		displaypath =3D relative_path(suc->update_data->recursive_prefix,
>     --					    ce->name, &displaypath_sb);
>     --	else
>     --		displaypath =3D ce->name;
>     --
>     - 	if (!sub) {
>     - 		next_submodule_warn_missing(suc, out, displaypath);
>     - 		goto cleanup;
>     -@@ builtin/submodule--helper.c: static int prepare_to_clone_next_sub=
module(const struct cache_entry *ce,
>     - 					      "--no-single-branch");
>     -=20
>     - cleanup:
>     --	strbuf_release(&displaypath_sb);
>     -+	free(displaypath);
>     - 	strbuf_release(&sb);
>     - 	if (need_free_url)
>     - 		free((void*)url);
>     +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>     =20
>       ## t/t7406-submodule-update.sh ##
>      @@ t/t7406-submodule-update.sh: test_expect_success 'submodule updat=
e --filter sets partial clone settings' '
>     @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update=
 --filter sets
>      +	# because of its unmerged state
>      +	test_config -C top-cloned submodule.middle.update !true &&
>      +	git -C top-cloned submodule update --recursive 2>actual.err &&
>     -+	grep -F "Skipping unmerged submodule middle/bottom" actual.err
>     ++	cat >expect.err <<-\EOF &&
>     ++	Skipping unmerged submodule middle//bottom
>     ++	EOF
>     ++	test_cmp expect.err actual.err
>      +'
>      +
>      +test_expect_success 'submodule update --recursive skip submodules w=
ith strategy=3Dnone' '
>     @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update=
 --filter sets
>      +	test_commit -C top-cloned/middle/bottom downstream_commit &&
>      +	git -C top-cloned/middle config submodule.bottom.update none &&
>      +	git -C top-cloned submodule update --recursive 2>actual.err &&
>     -+	grep -F "Skipping submodule ${SQ}middle/bottom${SQ}" actual.err
>     ++	cat >expect.err <<-\EOF &&
>     ++	Skipping submodule '\''../middle/'\''
>     ++	EOF
>     ++	test_cmp expect.err actual.err
>      +'
>      +
>       test_done
> -:  ----------- > 2:  d1a47d302ee submodule--helper update: use display p=
ath helper
> 2:  d3e803a4630 ! 3:  a5b30ac94e6 submodule--helper: don't recreate recur=
sive prefix
>     @@ builtin/submodule--helper.c: static void update_data_to_args(struc=
t update_data
>      -	if (update_data->recursive_prefix)
>      -		strvec_pushl(args, "--recursive-prefix",
>      -			     update_data->recursive_prefix, NULL);
>     -+	if (update_data->displaypath)
>     -+		strvec_pushf(args, "--recursive-prefix=3D%s/",
>     -+			     update_data->displaypath);
>     ++	if (update_data->displaypath) {
>     ++		strvec_push(args, "--recursive-prefix");
>     ++		strvec_pushf(args, "%s/", update_data->displaypath);
>     ++	}
>       	if (update_data->quiet)
>       		strvec_push(args, "--quiet");
>       	if (update_data->force)
> 3:  1f7cf6ffaf1 =3D 4:  0ea102882a7 submodule--helper: use correct displa=
y path helper
> 4:  85e65f143b6 =3D 5:  8085bc83a0c submodule--helper: remove unused SUPP=
ORT_SUPER_PREFIX flags
> 5:  1d8b6b244dc ! 6:  4c00a1b496a submodule--helper update: use --super-p=
refix
>     @@ builtin/submodule--helper.c: struct submodule_update_clone {
>       	enum submodule_update_type update_default;
>       	struct object_id suboid;
>      @@ builtin/submodule--helper.c: static int prepare_to_clone_next_sub=
module(const struct cache_entry *ce,
>     -=20
>     - 	displaypath =3D do_get_submodule_displaypath(ce->name,
>     - 						   suc->update_data->prefix,
>     --						   suc->update_data->recursive_prefix);
>     -+						   get_super_prefix());
>     -=20
>     - 	if (ce_stage(ce)) {
>     - 		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath=
);
>     + 	char *key;
>     + 	struct update_data *ud =3D suc->update_data;
>     + 	char *displaypath =3D do_get_submodule_displaypath(ce->name, ud->p=
refix,
>     +-							 ud->recursive_prefix);
>     ++							 get_super_prefix());
>     + 	struct strbuf sb =3D STRBUF_INIT;
>     + 	int needs_cloning =3D 0;
>     + 	int need_free_url =3D 0;
>      @@ builtin/submodule--helper.c: static void update_data_to_args(stru=
ct update_data *update_data, struct strvec *
>       {
>       	enum submodule_update_type update_type =3D update_data->update_def=
ault;
>      =20
>      -	strvec_pushl(args, "submodule--helper", "update", "--recursive", N=
ULL);
>      -	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
>     - 	if (update_data->displaypath)
>     --		strvec_pushf(args, "--recursive-prefix=3D%s/",
>     -+		strvec_pushf(args, "--super-prefix=3D%s/",
>     - 			     update_data->displaypath);
>     + 	if (update_data->displaypath) {
>     +-		strvec_push(args, "--recursive-prefix");
>     ++		strvec_push(args, "--super-prefix");
>     + 		strvec_pushf(args, "%s/", update_data->displaypath);
>     + 	}
>      +	strvec_pushl(args, "submodule--helper", "update", "--recursive", N=
ULL);
>      +	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
>       	if (update_data->quiet)
> 6:  a21e8cd174d ! 7:  639f07e4b84 submodule--helper: remove display path =
helper
>     @@ builtin/submodule--helper.c: static void init_submodule(const char=
 *path, const
>       	sub =3D submodule_from_path(the_repository, null_oid(), path);
>      =20
>      @@ builtin/submodule--helper.c: static int prepare_to_clone_next_sub=
module(const struct cache_entry *ce,
>     + 	enum submodule_update_type update_type;
>     + 	char *key;
>     + 	struct update_data *ud =3D suc->update_data;
>     +-	char *displaypath =3D do_get_submodule_displaypath(ce->name, ud->p=
refix,
>     +-							 get_super_prefix());
>     ++	char *displaypath =3D get_submodule_displaypath(ce->name, ud->pref=
ix);
>     + 	struct strbuf sb =3D STRBUF_INIT;
>       	int needs_cloning =3D 0;
>       	int need_free_url =3D 0;
>     -=20
>     --	displaypath =3D do_get_submodule_displaypath(ce->name,
>     --						   suc->update_data->prefix,
>     --						   get_super_prefix());
>     -+	displaypath =3D
>     -+		get_submodule_displaypath(ce->name, suc->update_data->prefix);
>     -=20
>     - 	if (ce_stage(ce)) {
>     - 		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath=
);
>      @@ builtin/submodule--helper.c: static int update_submodule(struct u=
pdate_data *update_data)
>       {
>       	ensure_core_worktree(update_data->sm_path);
