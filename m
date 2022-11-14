Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FC6C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 21:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbiKNVXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 16:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiKNVXG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 16:23:06 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4378E14095
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 13:23:05 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 138-20020a630290000000b004708e8a8dcfso6376318pgc.11
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 13:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYzq1CywW1XFOKB7Y3Ipvq6q4JExoWJtJecm+JRskJY=;
        b=MQNt10FMv6JhGr4x5LHoSy+LoGBcAgCfwwBtNVPOKPqTRSjSUdYUdyZ0VLx5RIuqQc
         xg/hztLFhTn6PXCrftJZ+fLbmE0SduQ118OQfZPvOFj9l11rlKiiborWqcrddJftXbaq
         U5nC8RCKhNW4nSA6FT9H4kD99OyHrJ1itXB8LaAwxYl5K0nG4zImszDtxrLPXMQ3uQul
         0NBx9wKFnuP00fpSG8/WtLa8k4Wv6GqrvJYMoNI9OdLthNypmjRg4lgmbfpYcVFdyFmF
         WvAnpi2GjFENebcthvPmiOS00b6CjkI4GZM3Ir0tBL0xO+fiBhjw+UYXKcf+rzFVUNVW
         fAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QYzq1CywW1XFOKB7Y3Ipvq6q4JExoWJtJecm+JRskJY=;
        b=ebHCnolM1y1OcxFO2Kh1N87a+CiPkSIn034fgBaZk2VSU2qBZ+gKErp7y7EKIjvv4q
         uHXtUpZSZu4WwqzniGoSV7Vb9o1UXTmvMPNgIHb5Du8cee6RcKHyM39iNCEqjsdfou55
         jrvEcFVuFQj4yilF3tDF1nJWN/nVINg6EiD0kOYeI8rLX9BMqd9A6Gi5yWtaeAjx/RWE
         J4fiQsISsXx+TXE/Ue3o2F6RJNDYlYXHKb0WgiiUdSyGW2abLsseRgOhXRT6eJg4QV3R
         4BpI9hNcibELDDE36AhzJ2ECkhc2w2aPHEJsHNOWgLi29g0mzmC7+Wc2GMabXnNUtys7
         1UJw==
X-Gm-Message-State: ANoB5pl1EEshFpOjq+781eG5Dmd43pHHFLKsxknjy7kpS6DJjmOETwbp
        0Qi+0yUtzG257PJrNRzlHs4FXkJ08nsKww==
X-Google-Smtp-Source: AA0mqf5Hs7YuzhZAL9THXRyMRyx45m4MeNMYjZTxuxcJJenTP/8aDjzdOB6B6zWWz4W0CJlRks/7+PVVptDZdg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:32d1:b0:185:4e4c:3483 with SMTP
 id i17-20020a17090332d100b001854e4c3483mr927245plr.163.1668460984733; Mon, 14
 Nov 2022 13:23:04 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:22:55 -0800
In-Reply-To: <patch-v2-02.10-5a35f7b75b3-20221114T100803Z-avarab@gmail.com>
Mime-Version: 1.0
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com> <patch-v2-02.10-5a35f7b75b3-20221114T100803Z-avarab@gmail.com>
Message-ID: <kl6la64tp6xc.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 02/10] submodule--helper: don't use global
 --super-prefix in "absorbgitdirs"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Robert Coup <robert@coup.net.nz>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The "--super-prefix" facility was introduced in [1] has always been a
> transitory hack, which is why we've made it an error to supply it as
> an option to "git" to commands that don't know about it.
>
> That's been a good goal, as it has a global effect we haven't wanted
> calls to get_super_prefix() from built-ins we didn't expect.
>
> But it has meant that when we've had chains of different built-ins
> using it all of the processes in that "chain" have needed to support
> it, and worse processes that don't need it have needed to ask for
> "SUPPORT_SUPER_PREFIX" because their parent process needs it.
>
> That's how "fsmonitor--daemon" ended up with it, per [2] it's called
> from (among other things) "submodule--helper absorbgitdirs", but as we
> declared "submodule--helper" as "SUPPORT_SUPER_PREFIX" we needed to
> declare "fsmonitor--daemon" as accepting it too, even though it
> doesn't care about it.
>
> But in the case of "absorbgitdirs" it only needed "--super-prefix" to
> invoke itself recursively, and we'd never have another "in-between"
> process in the chain. So we didn't need the bigger hammer of "git
> --super-prefix", and the "setenv(GIT_SUPER_PREFIX_ENVIRONMENT, ...)"
> that it entails.
>
> Let's instead accept a hidden "--super-prefix" option to
> "submodule--helper absorbgitdirs" itself.
>
> Eventually (as with all other "--super-prefix" users) we'll want to
> clean this code up so that this all happens in-process. I.e. needing
> any variant of "--super-prefix" is itself a hack around our various
> global state, and implicit reliance on "the_repository". This stepping
> stone makes such an eventual change easier, as we'll need to deal with
> less global state at that point.
>
> The "fsmonitor--daemon" test adjusted here was added in [3]. The
> comment added in that commit has been out-of-date from the beginning,
> and the "have_t2_error_event()" was being overly specific in testing
> for a bug that we *don't* have. Let's instead test for the stdout and
> stderr that we *do have*.

I didn't understand this bit initially, because I read this as
"have_t2_error_event() isn't catching bugs", which isn't true. But I see
what you mean after inspecting the test_cmp output:

  @@ -1 +1,2 @@
  Migrating git directory of 'dir_1/dir_2/sub' from 'dir_1/dir_2/sub/.git' =
to '.git/modules/dir_1/dir_2/sub'
  +fatal: fsmonitor--daemon doesn't support --super-prefix

IOW, it doesn't make sense to inspecting the tr2 output for stray
warnings when our stderr is so obviously broken. But at the end of the
series, I don't think we even need this test at all because if we don't
have a global "--super-prefix", there's literally no reason for
fsmonitor--daemon to worry about absorbgitdirs or "supporting" the super
prefix. That's why I removed it in [1].

Wondering aloud, that stderr suggests that the "git submodule absorbgitdirs=
"
invocation failed. I wonder why the test didn't catch a bad exit code
(and resulting in us inspecting stderr unnecessarily). I think it's not
worth looking too closely at right now, but we could revisit this after
we get builtin/submodule.c.

[1] https://lore.kernel.org/git/20221109004708.97668-5-chooglen@google.com

>
> 1. 74866d75793 (git: make super-prefix option, 2016-10-07)
> 2. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument,
>    2022-05-26)
> 3. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument,
>    2022-05-26)
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c  |  8 +++++---
>  git.c                        |  2 +-
>  parse-options.h              |  4 ++++
>  submodule.c                  | 20 ++++++++++++--------
>  submodule.h                  |  7 ++++++-
>  t/t7527-builtin-fsmonitor.sh | 33 ++++++++-------------------------
>  6 files changed, 36 insertions(+), 38 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c75e9e86b06..427e793e204 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2828,7 +2828,9 @@ static int absorb_git_dirs(int argc, const char **a=
rgv, const char *prefix)
>  	int i;
>  	struct pathspec pathspec =3D { 0 };
>  	struct module_list list =3D MODULE_LIST_INIT;
> +	const char *super_prefix =3D NULL;
>  	struct option embed_gitdir_options[] =3D {
> +		OPT__SUPER_PREFIX(&super_prefix),
>  		OPT_END()
>  	};
>  	const char *const git_submodule_helper_usage[] =3D {
> @@ -2844,7 +2846,8 @@ static int absorb_git_dirs(int argc, const char **a=
rgv, const char *prefix)
>  		goto cleanup;
> =20
>  	for (i =3D 0; i < list.nr; i++)
> -		absorb_git_dir_into_superproject(list.entries[i]->name);
> +		absorb_git_dir_into_superproject_sp(list.entries[i]->name,
> +						    super_prefix);
> =20
>  	ret =3D 0;
>  cleanup:
> @@ -3382,8 +3385,7 @@ int cmd_submodule__helper(int argc, const char **ar=
gv, const char *prefix)
> =20
>  	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
>  	    strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
> -	    strcmp(subcmd, "sync") && strcmp(subcmd, "absorbgitdirs") &&
> -	    get_super_prefix())
> +	    strcmp(subcmd, "sync") && get_super_prefix())
>  		/*
>  		 * xstrfmt() rather than "%s %s" to keep the translated
>  		 * string identical to git.c's.
> diff --git a/git.c b/git.c
> index 10202a7f126..b1b7e1a837e 100644
> --- a/git.c
> +++ b/git.c
> @@ -539,7 +539,7 @@ static struct cmd_struct commands[] =3D {
>  	{ "format-patch", cmd_format_patch, RUN_SETUP },
>  	{ "fsck", cmd_fsck, RUN_SETUP },
>  	{ "fsck-objects", cmd_fsck, RUN_SETUP },
> -	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, SUPPORT_SUPER_PREFIX | RU=
N_SETUP },
> +	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
>  	{ "gc", cmd_gc, RUN_SETUP },
>  	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
>  	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
> diff --git a/parse-options.h b/parse-options.h
> index b6ef86e0d15..50d852f2991 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -369,6 +369,10 @@ int parse_opt_tracking_mode(const struct option *, c=
onst char *, int);
>  	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
>  	  N_("use <n> digits to display object names"),	\
>  	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
> +#define OPT__SUPER_PREFIX(var) \
> +	OPT_STRING_F(0, "super-prefix", (var), N_("prefix"), \
> +		N_("prefixed path to initial superproject"), PARSE_OPT_HIDDEN)
> +

Could we default to "" instead of NULL? (possibly via a callback). I
think there's never any good reason to have NULL instead of "", e.g.
since this is internal, we don't care to distinguish between
"--super-prefix=3D''" and not passing "--super-prefix" at all...

>  #define OPT__COLOR(var, h) \
>  	OPT_COLOR_FLAG(0, "color", (var), (h))
>  #define OPT_COLUMN(s, l, v, h) \
> diff --git a/submodule.c b/submodule.c
> index c47358097fd..d9fd0af81b6 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2268,7 +2268,8 @@ int validate_submodule_git_dir(char *git_dir, const=
 char *submodule_name)
>   * Embeds a single submodules git directory into the superprojects git d=
ir,
>   * non recursively.
>   */
> -static void relocate_single_git_dir_into_superproject(const char *path)
> +static void relocate_single_git_dir_into_superproject(const char *path,
> +						      const char *super_prefix)
>  {
>  	char *old_git_dir =3D NULL, *real_old_git_dir =3D NULL, *real_new_git_d=
ir =3D NULL;
>  	struct strbuf new_gitdir =3D STRBUF_INIT;
> @@ -2302,7 +2303,7 @@ static void relocate_single_git_dir_into_superproje=
ct(const char *path)
>  	       real_old_git_dir[off] =3D=3D real_new_git_dir[off])
>  		off++;
>  	fprintf(stderr, _("Migrating git directory of '%s%s' from '%s' to '%s'\=
n"),
> -		get_super_prefix_or_empty(), path,
> +		(super_prefix ? super_prefix : ""), path,
>  		real_old_git_dir + off, real_new_git_dir + off);


Which would make sites like these a bit cleaner.

Tangentially, 'default to "" if NULL' sounds like a common pattern. Is
there a good reason not to have a macro or inline function to do that?
e.g. we think the ternary expression is good enough?)

> =20
>  	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
> @@ -2313,7 +2314,8 @@ static void relocate_single_git_dir_into_superproje=
ct(const char *path)
>  	strbuf_release(&new_gitdir);
>  }
> =20
> -static void absorb_git_dir_into_superproject_recurse(const char *path)
> +static void absorb_git_dir_into_superproject_recurse(const char *path,
> +						     const char *super_prefix)
>  {
> =20
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
> @@ -2321,10 +2323,11 @@ static void absorb_git_dir_into_superproject_recu=
rse(const char *path)
>  	cp.dir =3D path;
>  	cp.git_cmd =3D 1;
>  	cp.no_stdin =3D 1;
> -	strvec_pushf(&cp.args, "--super-prefix=3D%s%s/",
> -		     get_super_prefix_or_empty(), path);
>  	strvec_pushl(&cp.args, "submodule--helper",
>  		     "absorbgitdirs", NULL);
> +	strvec_pushf(&cp.args, "--super-prefix=3D%s%s/", super_prefix ?
> +		     super_prefix : "", path);
> +
>  	prepare_submodule_repo_env(&cp.env);
>  	if (run_command(&cp))
>  		die(_("could not recurse into submodule '%s'"), path);
> @@ -2335,7 +2338,8 @@ static void absorb_git_dir_into_superproject_recurs=
e(const char *path)
>   * having its git directory within the working tree to the git dir neste=
d
>   * in its superprojects git dir under modules/.
>   */
> -void absorb_git_dir_into_superproject(const char *path)
> +void absorb_git_dir_into_superproject_sp(const char *path,
> +					 const char *super_prefix)
>  {
>  	int err_code;
>  	const char *sub_git_dir;
> @@ -2377,14 +2381,14 @@ void absorb_git_dir_into_superproject(const char =
*path)
>  		char *real_common_git_dir =3D real_pathdup(get_git_common_dir(), 1);
> =20
>  		if (!starts_with(real_sub_git_dir, real_common_git_dir))
> -			relocate_single_git_dir_into_superproject(path);
> +			relocate_single_git_dir_into_superproject(path, super_prefix);
> =20
>  		free(real_sub_git_dir);
>  		free(real_common_git_dir);
>  	}
>  	strbuf_release(&gitdir);
> =20
> -	absorb_git_dir_into_superproject_recurse(path);
> +	absorb_git_dir_into_superproject_recurse(path, super_prefix);
>  }
> =20
>  int get_superproject_working_tree(struct strbuf *buf)
> diff --git a/submodule.h b/submodule.h
> index b52a4ff1e73..e5ee13fb06a 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -164,7 +164,12 @@ void submodule_unset_core_worktree(const struct subm=
odule *sub);
>   */
>  void prepare_submodule_repo_env(struct strvec *env);
> =20
> -void absorb_git_dir_into_superproject(const char *path);
> +void absorb_git_dir_into_superproject_sp(const char *path,
> +					 const char *super_prefix);
> +static inline void absorb_git_dir_into_superproject(const char *path)
> +{
> +	absorb_git_dir_into_superproject_sp(path, NULL);
> +}

Is there a reason you chose to go with _sp() instead of changing the
original function signature? I tested out that change, and it seems
rather small (absorb_git_dir_into_superproject() only has 4 call sites).

Crucially, changing the signature catches a "git read-tree" call site:

  diff --git a/submodule.c b/submodule.c
  index d9fd0af81b..e79a04d3e3 100644
  --- a/submodule.c
  +++ b/submodule.c
  @@ -2139,7 +2139,9 @@ int submodule_move_head(const char *path,
          if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
                  if (old_head) {
                          if (!submodule_uses_gitfile(path))
  -                               absorb_git_dir_into_superproject(path);
  +                               /* Pass super_prefix properly later. */
  +                               absorb_git_dir_into_superproject(path,
  +                                                                get_supe=
r_prefix());
                  } else {
                          struct strbuf gitdir =3D STRBUF_INIT;
                          submodule_name_to_gitdir(&gitdir, the_repository,

which would otherwise be broken since we used to read the global super
prefix, but we don't do that in this patch. This has no test coverage
(bleh), but it shouldn't be too hard, something like:

  git init super &&
  cd super &&
  # Create an unabsorbed submodule right in the worktree
  git init sub &&
  test_commit -C sub "foo" &&
  git add sub &&
  git commit -m "Add submodule" &&
  test_commit "bar" &&
  # This should invoke "git read-tree" and absorb the git dir.
  # Or maybe we should invoke "git read-tree" directly?
  git checkout --recurse-submodules HEAD^ 2>err &&
  # Search for the shortened message
  grep "Migrating submodule sub from sub to .git/modules/...." err

>  /*
>   * Return the absolute path of the working tree of the superproject, whi=
ch this
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index 4abc74db2bb..31526937d95 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -866,30 +866,11 @@ test_expect_success 'submodule always visited' '
>  # the submodule, and someone does a `git submodule absorbgitdirs`
>  # in the super, Git will recursively invoke `git submodule--helper`
>  # to do the work and this may try to read the index.  This will
> -# try to start the daemon in the submodule *and* pass (either
> -# directly or via inheritance) the `--super-prefix` arg to the
> -# `git fsmonitor--daemon start` command inside the submodule.
> -# This causes a warning because fsmonitor--daemon does take that
> -# global arg (see the table in git.c)
> -#
> -# This causes a warning when trying to start the daemon that is
> -# somewhat confusing.  It does not seem to hurt anything because
> -# the fsmonitor code maps the query failure into a trivial response
> -# and does the work anyway.
> -#
> -# It would be nice to silence the warning, however.
> -
> -have_t2_error_event () {
> -	log=3D$1
> -	msg=3D"fsmonitor--daemon doesnQt support --super-prefix" &&
> -
> -	tr '\047' Q <$1 | grep -e "$msg"
> -}
> +# try to start the daemon in the submodule.
> =20
>  test_expect_success "stray submodule super-prefix warning" '
>  	test_when_finished "rm -rf super; \
> -			    rm -rf sub;   \
> -			    rm super-sub.trace" &&
> +			    rm -rf sub" &&
> =20
>  	create_super super &&
>  	create_sub sub &&
> @@ -904,10 +885,12 @@ test_expect_success "stray submodule super-prefix w=
arning" '
> =20
>  	test_path_is_dir super/dir_1/dir_2/sub/.git &&
> =20
> -	GIT_TRACE2_EVENT=3D"$PWD/super-sub.trace" \
> -		git -C super submodule absorbgitdirs &&
> -
> -	! have_t2_error_event super-sub.trace
> +	cat >expect <<-\EOF &&
> +	Migrating git directory of '\''dir_1/dir_2/sub'\'' from '\''dir_1/dir_2=
/sub/.git'\'' to '\''.git/modules/dir_1/dir_2/sub'\''
> +	EOF
> +	git -C super submodule absorbgitdirs >out 2>actual &&
> +	test_cmp expect actual &&
> +	test_must_be_empty out
>  '
> =20
>  # On a case-insensitive file system, confirm that the daemon
> --=20
> 2.38.0.1471.ge4d8947e7aa
