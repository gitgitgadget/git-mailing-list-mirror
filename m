Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FEAC433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 12:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153306117A
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 12:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhJEMVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 08:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbhJEMVS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 08:21:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D0EC061762
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 05:19:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f9so15244487edx.4
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=GUNWyFs996sG1etuSZtGpEtTSLolo8U5phIWp7fhKe8=;
        b=gSzmGx2fYWFV3IhKeMNt56rQuqE7FlYsK6R2S+95t+Z1eqEWb55z3qTBTyDjJOhTnM
         3EgVaGVcDha6Gn5sAkM1PaB5R3xp0oodvCvn/9nRkWIRwTWg3pW51KuJSZGyDdD28v+x
         1LJjFEECKpfTuw55h7NV2CxSUfgAZAbhhw6J46aAg6XkMQmK+L8lAeviYr+EKjIcRjqc
         9sBBKMed1xRXKeTp8RS0MINbES12MU99AzbwQpSb0xx21kOvqRvjy6F0Hg7OD4VaPHVj
         3lMy8ox9tlhgOgvk48zMJSgVzNC1v4FStu14KLjrjYjJr/NqKfbqEUUMFLBS0t3ELnmZ
         JqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=GUNWyFs996sG1etuSZtGpEtTSLolo8U5phIWp7fhKe8=;
        b=TQwCLiZKxLZ/lOmwp594wYRB1tTXWjhaqgl31Knk5CL+3LYIL0hGDehX5uXn4CRLUM
         X1xpkNMqnp3Ge85j0aNkxALpGky3YF8vUvxLnAj2941gbAARaMLphGK3sNNCnfDH1Xth
         U8BrGGwhcqjhgDtq1/6Dl0NaTMdt2G2XJGTyDDuLQOE2oAyARdtriavOL+1q6NbpicVp
         A8KBivfsiB+uquu1oP06ySITA8PPHvPnMuxhqKEP13p9XIxVqVKaGiNX/YhjHTA8Zbfe
         IuRNcM5nY2+Bi7TJMrhPnqCd/5c7SdaRVokpUqAB8Ouv/vOpbzAQcmYk7kvzzJtZYV88
         IxwA==
X-Gm-Message-State: AOAM533QQf1OMhmDHtf+eoPdQCa+xshYWCD6tk5hfWGGLl/5pg3/schN
        Cw+s2+6fUuFa4pLwkv8NpFA=
X-Google-Smtp-Source: ABdhPJx0q8sYbc+3jbWqeItBz591u6wYChOH4zw+x5joPBbtxCHOEw3+7WT5W4mvNkEmRbnfaN+eHA==
X-Received: by 2002:a50:d945:: with SMTP id u5mr25181465edj.136.1633436364661;
        Tue, 05 Oct 2021 05:19:24 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b2sm7569655ejj.124.2021.10.05.05.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 05:19:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 0/3] Use default values from settings instead of config
Date:   Tue, 05 Oct 2021 13:57:54 +0200
References: <20210917225459.68086-1-chooglen@google.com>
 <20211005001931.13932-1-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20211005001931.13932-1-chooglen@google.com>
Message-ID: <87lf37ll4k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Glen Choo wrote:

> Hi everyone! This patch was created in response to something we observed =
in
> Google, where fsck failed to detect that the commit graph was invalid. We
> initially assumed that fsck never checked the commit graph, but it turns =
out
> that it does so only when core.commitgraph is set, even though we set def=
aults
> for "whether to use the commit graph" in the repository settings.
>
> Instead of using the config, let's use repository settings where
> available. Replace core.commitGraph and core.multiPackIndex with their
> equivalent repository settings in fsck and gc.
>
> I don't anticipate any more business logic changes and the previous comme=
nts
> were focused on testing style, so hopefully this should be good to merge.
>
> Changes since v2:
> * Various small test fixes (thanks Eric!). Most notably, I've used -c ins=
tead of
>   test_config because test_config can affect the values in subsequent tes=
ts.
> * Rewording fix in patch 3 commit message
> * Refactor tests in patch 3 so that we use a single helper function inste=
ad of
>   copy-pasted code
>
> Changes since v1:
> * clean up typo in patch 1 commit message=20
> * document the commits that patches 1 and 2 address
> * use test helpers in patch 1
> * rewrite patch 2's tests so that it's easier to tell that each test
>   does something different
> * reword patch 3 commit message to explain the bug
> * add tests to patch 3
>
> Glen Choo (3):
>   fsck: verify commit graph when implicitly enabled
>   fsck: verify multi-pack-index when implictly enabled
>   gc: perform incremental repack when implictly enabled

I've looked this over carefully, it LGTM. I noticed some bugs in this
area, but they pre-date your commits. I've pushed a
"gc/use-repo-settings" to https://github.com/avar/git.git that you can
check out, consider that branch partially as commentary, but feel free
to pick/squash anything you find there.

The range-diff for that is quoted below. Notes:

 * This is somewhat of a case of throwing rocks from a glass house, but
   I think the commit messages could really be shorter/get to the
   point. I.e. say right away what's being changed and why, instead of
   giving the reader an overview of the whole control flow.

   I just adjusted adusted 1/3 in that direction below, I think 2/3
   could do with being squashed into it & adjusted, it's really the
   exact same bug/improvement, just with a different config key that
   behaves the same.

 * The "test_unconfig" in your 2/3 is redundant, so is the "rm -rf" of
   directories that can't exist by that point in 3/3.

 * I wondered if we could just call prepare_repo_settings() in one place
   earlier in gc/maintenance instead of adding yet another call deeper
   in the control flow. I've got a 4/3 below that tries to do that, and
   (as noted in its commit message) intentionally breaks "gc.c" in a way
   that our tests don't catch, which is perhaps fallout from
   31b1de6a09b?

   So that's very much on the topic of extra improvements, i.e. your
   patches don't break that anymore than it is now, but I for one would
   very much like to see an end-state where we're confident that
   gc/maintenance do the right thing on each of the tri-states of these
   boolean variables.

   It's also a point about how to write reliable tests (again,
   pre-dating your series). I.e. instead of asserting "we do X when Y is
   true" have the test assert all of Y=3D[unset|false|true] in a way that
   breaks if any are different than expected.

   One of the tests you're changing has a "graph_git_two_modes" helper
   does 2/3 of that, maybe it would be easy to extend it?

 * You use corrupting the graph as a shorthand for "did we run this
   command?". See test_region for an approach that might be better,
   i.e. just log with trace2 and grep that to see if we started the
   relevant command. The test_region helper can't be used as-is for that
   (you could manually grep the emitted PERF/EVENT output), but perhaps
   that's easier/more reliable?

 * This is again, something that pre-dates your patches, but I think
   following the "is enabled?" behavior here for these variables in "git
   fsck" is highly questionable. So just some thoughts after having
   looked at that:

   Just because your config doen't say "use the graph" doesn't mean
   another process won't do so, and if the graph is broken they might
   probably encounter an error.

   Although I think we *should* have cleaned up those being fatal a
   while ago). See 43d35618055 (commit-graph write: don't die if the
   existing graph is corrupt, 2019-03-25).

   But in general for these auxiliary files (commit-graph, midix, *.rev
   etc.) I think there's a good argument to be made that fsck should
   *always* check them, and at most use the config to say something
   like:

       Hey, you've got a 100% broken commit-graph/midx/rev in your .git,
       looks like the core.XYZ enabling it is off *right now* though, so
       maybe we won't use it.  I hope you're feeling lucky...

   :)


1:  fd9a58e2c7b ! 1:  c6041f3b633 fsck: verify commit graph when implicitly=
 enabled
    @@ Metadata
      ## Commit message ##
         fsck: verify commit graph when implicitly enabled
=20=20=20=20=20
    -    the_repository->settings is the preferred way to get certain
    -    settings (such as "core.commitGraph") because it gets default valu=
es
    -    from prepare_repo_settings(). However, cmd_fsck() reads the config
    -    directly via git_config_get_bool(), which bypasses these default v=
alues.
    -    This causes fsck to ignore the commit graph if "core.commitgraph" =
is not
    -    explicitly set in the config. This worked fine until commit-graph =
was
    -    enabled by default in 31b1de6a09 (commit-graph: turn on commit-gra=
ph by
    -    default, 2019-08-13).
    +    Change fsck to check the "core_commit_graph" variable set in
    +    "repo-settings.c" instead of reading the "core.commitGraph" variab=
le,
    +    this fixes a bug where we wouldn't start "commit-graph verify" if =
the
    +    config key was missing, which since 31b1de6a09 (commit-graph: turn=
 on
    +    commit-graph by default, 2019-08-13) has meant that it's on by
    +    default.
=20=20=20=20=20
    -    Replace git_config_get_bool("core.commitgraph") in fsck with the
    -    equivalent call to the_repository->settings.core_commit_graph.
    -
    -    The expected behavior is that fsck respects the config value when =
it is
    -    set, but uses the default value when it is unset. For example, for
    -    core.commitGraph, there are three cases:
    -
    -    - Config value is set to true -> enabled
    -    - Config value is set to false -> disabled
    -    - Config value is unset -> enabled
    -
    -    As such, tests cover all three cases.
    +    Add tests to "t5318-commit-graph.sh" to check that this works, usi=
ng
    +    the detection of a corrupt commit-graph as a method of seeing if
    +    "commit-graph verify" was invoked.
=20=20=20=20=20
         Signed-off-by: Glen Choo <chooglen@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
=20=20=20=20=20
      ## builtin/fsck.c ##
     @@ builtin/fsck.c: int cmd_fsck(int argc, const char **argv, const cha=
r *prefix)
2:  9d6813bc280 ! 2:  d11209ebfe1 fsck: verify multi-pack-index when implic=
tly enabled
    @@ Commit message
=20=20=20=20=20
         Signed-off-by: Glen Choo <chooglen@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
=20=20=20=20=20
      ## builtin/fsck.c ##
     @@ builtin/fsck.c: int cmd_fsck(int argc, const char **argv, const cha=
r *prefix)
    @@ t/t5319-multi-pack-index.sh: test_expect_success 'verify incorrect o=
ffset' '
      		"incorrect object offset" \
     -		"git -c core.multipackindex=3Dtrue fsck"
     +		"git -c core.multiPackIndex=3Dtrue fsck" &&
    -+	test_unconfig core.multiPackIndex &&
     +	test_must_fail git fsck &&
     +	git -c core.multiPackIndex=3Dfalse fsck
      '
3:  260f46568c6 ! 3:  017e2003e85 gc: perform incremental repack when impli=
ctly enabled
    @@ Commit message
=20=20=20=20=20
         Signed-off-by: Glen Choo <chooglen@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
=20=20=20=20=20
      ## builtin/gc.c ##
     @@ builtin/gc.c: static int maintenance_task_loose_objects(struct main=
tenance_run_opts *opts)
    @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental=
-repack.auto
     +}
     +
     +test_expect_success 'maintenance.incremental-repack.auto' '
    -+	rm -rf incremental-repack-true &&
     +	git init incremental-repack-true &&
     +	(
     +		cd incremental-repack-true &&
    @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental=
-repack.auto
     +'
     +
     +test_expect_success 'maintenance.incremental-repack.auto (when config=
 is unset)' '
    -+	rm -rf incremental-repack-unset &&
     +	git init incremental-repack-unset &&
     +	(
     +		cd incremental-repack-unset &&
-:  ----------- > 4:  04d1527f180 WIP gc/maintenance: just call prepare_rep=
o_settings() earlier

-- >8 --
Subject: [PATCH] WIP gc/maintenance: just call prepare_repo_settings() earl=
ier

Consolidate the various calls to prepare_repo_settings() to happen at
the start of cmd_maintenance() (TODO: and cmd_gc()). This WIP commit
intentionally breaks things, we seem to be lacking test coverage for
cmd_gc(), perhaps since 31b1de6a09b (commit-graph: turn on
commit-graph by default, 2019-08-13)?

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 builtin/gc.c            | 5 +----
 t/t5318-commit-graph.sh | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 26709311601..f59dbedc1fe 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -695,7 +695,6 @@ int cmd_gc(int argc, const char **argv, const char *pre=
fix)
 		clean_pack_garbage();
 	}
=20
-	prepare_repo_settings(the_repository);
 	if (the_repository->settings.gc_write_commit_graph =3D=3D 1)
 		write_commit_graph_reachable(the_repository->objects->odb,
 					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
@@ -860,7 +859,6 @@ static int run_write_commit_graph(struct maintenance_ru=
n_opts *opts)
=20
 static int maintenance_task_commit_graph(struct maintenance_run_opts *opts)
 {
-	prepare_repo_settings(the_repository);
 	if (!the_repository->settings.core_commit_graph)
 		return 0;
=20
@@ -1052,7 +1050,6 @@ static int incremental_repack_auto_condition(void)
 	int incremental_repack_auto_limit =3D 10;
 	int count =3D 0;
=20
-	prepare_repo_settings(the_repository);
 	if (!the_repository->settings.core_multi_pack_index)
 		return 0;
=20
@@ -1167,7 +1164,6 @@ static int multi_pack_index_repack(struct maintenance=
_run_opts *opts)
=20
 static int maintenance_task_incremental_repack(struct maintenance_run_opts=
 *opts)
 {
-	prepare_repo_settings(the_repository);
 	if (!the_repository->settings.core_multi_pack_index) {
 		warning(_("skipping incremental-repack task because core.multiPackIndex =
is disabled"));
 		return 0;
@@ -2492,6 +2488,7 @@ int cmd_maintenance(int argc, const char **argv, cons=
t char *prefix)
 	    (argc =3D=3D 2 && !strcmp(argv[1], "-h")))
 		usage(builtin_maintenance_usage);
=20
+	prepare_repo_settings(the_repository);
 	if (!strcmp(argv[1], "run"))
 		return maintenance_run(argc - 1, argv + 1, prefix);
 	if (!strcmp(argv[1], "start"))
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4e4450af1ef..98123191e1e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -368,7 +368,7 @@ test_expect_success 'check that gc computes commit-grap=
h' '
 	git commit-graph write --reachable &&
 	cp $objdir/info/commit-graph commit-graph-before-gc &&
 	git reset --hard HEAD~1 &&
-	git config gc.writeCommitGraph true &&
+	# BUG: Due to 31b1de6a09b (commit-graph: turn on commit-graph by default,=
 2019-08-13)?
 	git gc &&
 	cp $objdir/info/commit-graph commit-graph-after-gc &&
 	! test_cmp_bin commit-graph-before-gc commit-graph-after-gc &&
--=20
2.33.0.1441.gbbcdb4c3c66





