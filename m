Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73037C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 23:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiKNXdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 18:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKNXdO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 18:33:14 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA62F65A8
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 15:33:12 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id o7-20020a170902d4c700b001868cdac9adso10056393plg.13
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 15:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTBzXYJgBJw1RfAaGo4YmauYxZ/Og3yxE1L82xHhchU=;
        b=Am0L4+IYMyiJsvYSVpaNlFd6j1exn0VIVnDLyxi2DeHyvz2LSiaNWByFa1KQawIxxk
         TuumDPbSHSxNbm8FuxEbOJjmN1VveIltQshoLdB4mp+Wu0vyW29gPfIGyxXrfh3DHWu3
         7zm0wRLv7JAr9pJwfMirUR9zOC970Httdnss4D2XD0Lhdw9SUaRHJ+xNb//6ksnjpD/h
         +0SEHHbE3czLbs6z/8Zv0dhvz86oUROyvhNsGJL+AQz1AibgrNOlebJQhdWNnmzi2ZKr
         np4jAPWxImdH34PVSekPvCbgHiUf5rryscIuSPUFfTc46c+C1v8j5V35wM63N9f2HV3z
         UrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NTBzXYJgBJw1RfAaGo4YmauYxZ/Og3yxE1L82xHhchU=;
        b=cNje1L7+qB2uRT/Hdt686Wyp6ekvrcgbR9FPNWoHhxveCuB+YH/ez80oI25PpmQvsi
         XAiMsVmRLkXFgUhRmR2OljuSt4JhD+fzTNT2FkuEnVIalSgxNjZvshoqQOLAaxQVNaxj
         1EAshWJlj3LY3+guHASeoj9EP70xyxbCBEITHGSwpZ9V+PSOR5VRIEnG7E3kys0qjULO
         iEC/tmIF1MbvXyDfk2vMr2qYijoYIRCLB1dP7y9rX4uOFr5f5pJTf3nnwiR0lGQwXcmW
         Rt/pg+TrcKotENRXuLVLkhgBcyVTPZ8z5yFvh2DABzeTPdgmzNptsWFM5FNQEU1fpOHN
         5ETA==
X-Gm-Message-State: ANoB5pmsMK5xcMbH+WNqZoPy50NvtnpaShms812yzJ/bf8Sj2uufzERx
        1N6T0Urtcn1SksMVRBjIfLyHphTu8rvdNw==
X-Google-Smtp-Source: AA0mqf42CLnAHOoKUDcB/YTZmLmbSSwq5yB5Vu3OrAppOJQewHoLP0Xb2EJH/eixVu0itXon3QHhSKGX6iWK5Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:82da:0:b0:554:4162:1ec1 with SMTP id
 f26-20020aa782da000000b0055441621ec1mr15920522pfn.64.1668468792301; Mon, 14
 Nov 2022 15:33:12 -0800 (PST)
Date:   Mon, 14 Nov 2022 15:33:10 -0800
In-Reply-To: <221114.86y1sdlq2d.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <20221109004708.97668-1-chooglen@google.com> <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <kl6ltu373ae5.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221110.86zgcznjah.gmgdl@evledraar.gmail.com> <kl6l5yfm2taf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lv8nl1h19.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221111.86fsepmbhe.gmgdl@evledraar.gmail.com> <kl6lsfip0yfx.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221114.86y1sdlq2d.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lmt8tnmbt.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 0/8] Get rid of "git --super-prefix"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> As noted in the CL above I included this because I see you're keen to
> include it, but I'm personally a bit "meh" on it. I.e. it's just
> renaming an existing unrelated option, although being able to use
> OPT__SUPER_PREFIX() makes it slightly nicer.
>
> As post-cleanups go I think removing the "submodule_prefix" from the
> "struct repository" would make more sense, and maybe it's worth peeling
> off the 10/10 to include in such a post-cleanup series? I.e. the below
> on top of all of this works, and reduces allocations and cargo-culting
> around the submodule API.

As a first impression I'm not particularly keen on this, since it makes
perfect sense to me to have a repo->submodule_prefix, especially when
recursing into N-level deep submodules...

>
> -- >8 --
> Subject: [PATCH] repo & submodule API: stop carrying "repo->submodule_pre=
fix"
>
> As this change shows the "submodule_prefix" field to "struct
> repository" added in 96dc883b3cd (repository: enable initialization of
> submodules, 2017-06-22) was only used by "ls-files" and "grep". Let's
> have those two carry forward the "super_prefix" instead.
>
> Having every user of "struct repository" needing to worry about this
> created a mismatch in the API where e.g. "grep" would re-compute a
> "name_base_len" which we knew before. Now we use a "struct strbuf" in
> the "struct grep_opt" there instead, so we'll know the length
> already. This simplifies "grep_cache()" and "grep_tree()".
>
> We're also deleting cargo-culted code that the previous API foisted
> upon us. In 605f0ec1350 (submodule: use submodule repos for object
> lookup, 2018-12-14) the "Mark it as a submodule" code was added to
> "open_submodule()", but the resulting xstrdup()'d "submodule_prefix"
> was never used by anything.

(As an aside, I think open_submodule() should have been replaced by
repo_submodule_init().)

In which case, yes it isn't used by anything in that code path, but
being meticulous about maintaining .super_prefix means that other
callers could use it if they wanted to, which might be crucial once we
start plumb "struct repository" deeper and deeper and...

>
> Still, removing this field might not be a good move, as the
> "super_prefix" might be a common enough case in the future, e.g. when
> eventually migrating the "submodule--helper" users[1] to run
> in-process.
>
> As the "grep" example demonstrates I don't think that's the
> case. There instead of xstrdup()-ing all the way down we're now
> carrying a single "super_prefix" in the form of a "struct strbuf". As
> we recurse we then append to it, and strbuf_setlen() it back when we
> we recurse out of that submodule. This is similar to how e.g. the
> "read_tree_at()" API works.

This technique might no longer be so appealing. We _could_ pass both
"struct repository" and "super_prefix", but that seems odd given that
the super prefix is tied to the repository.

But that's just a first impression anyway. I don't mind taking another
look if this gets a standalone review.

>
> Doing it that way means that we have just one allocation, which in the
> common case we might realloc() if we don't have enough room in the
> "struct strbuf".
>
> 1. https://lore.kernel.org/git/cover-v2-00.10-00000000000-20221114T100803=
Z-avarab@gmail.com/
> 2. https://github.com/avar/git/tree/avar/grep-post-drop-prefix-cleanup
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/grep.c     | 18 ++++++++----------
>  builtin/ls-files.c | 40 +++++++++++++++++++++++++---------------
>  grep.c             |  6 +++---
>  grep.h             |  2 ++
>  repository.c       |  7 -------
>  repository.h       |  7 -------
>  submodule.c        |  3 ---
>  7 files changed, 38 insertions(+), 45 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 5fa927d4e22..69826daba26 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -437,6 +437,7 @@ static int grep_submodule(struct grep_opt *opt,
>  	struct repository *superproject =3D opt->repo;
>  	struct grep_opt subopt;
>  	int hit =3D 0;
> +	size_t oldlen =3D opt->super_prefix.len;
> =20
>  	if (!is_submodule_active(superproject, path))
>  		return 0;
> @@ -497,6 +498,7 @@ static int grep_submodule(struct grep_opt *opt,
>  	add_submodule_odb_by_path(subrepo->objects->odb->path);
>  	obj_read_unlock();
> =20
> +	strbuf_addf(&opt->super_prefix, "%s/", path);
>  	memcpy(&subopt, opt, sizeof(subopt));
>  	subopt.repo =3D subrepo;
> =20
> @@ -527,6 +529,7 @@ static int grep_submodule(struct grep_opt *opt,
>  	} else {
>  		hit =3D grep_cache(&subopt, pathspec, cached);
>  	}
> +	strbuf_setlen(&opt->super_prefix, oldlen);
> =20
>  	return hit;
>  }
> @@ -538,11 +541,8 @@ static int grep_cache(struct grep_opt *opt,
>  	int hit =3D 0;
>  	int nr;
>  	struct strbuf name =3D STRBUF_INIT;
> -	int name_base_len =3D 0;
> -	if (repo->submodule_prefix) {
> -		name_base_len =3D strlen(repo->submodule_prefix);
> -		strbuf_addstr(&name, repo->submodule_prefix);
> -	}
> +	size_t name_base_len =3D opt->super_prefix.len;
> +	strbuf_addbuf(&name, &opt->super_prefix);
> =20
>  	if (repo_read_index(repo) < 0)
>  		die(_("index file corrupt"));
> @@ -618,11 +618,9 @@ static int grep_tree(struct grep_opt *opt, const str=
uct pathspec *pathspec,
>  	struct name_entry entry;
>  	int old_baselen =3D base->len;
>  	struct strbuf name =3D STRBUF_INIT;
> -	int name_base_len =3D 0;
> -	if (repo->submodule_prefix) {
> -		strbuf_addstr(&name, repo->submodule_prefix);
> -		name_base_len =3D name.len;
> -	}
> +	size_t name_base_len =3D opt->super_prefix.len;
> +
> +	strbuf_addbuf(&name, &opt->super_prefix);
> =20
>  	while (tree_entry(tree, &entry)) {
>  		int te_len =3D tree_entry_len(&entry);
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 4cf8a236483..c76a6be2fbe 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -216,10 +216,12 @@ static void show_killed_files(struct index_state *i=
state,
>  	}
>  }
> =20
> -static void show_files(struct repository *repo, struct dir_struct *dir);
> +static void show_files(struct repository *repo, struct dir_struct *dir,
> +		       const char *super_prefix);
> =20
>  static void show_submodule(struct repository *superproject,
> -			   struct dir_struct *dir, const char *path)
> +			   struct dir_struct *dir, const char *path,
> +			   const char *super_prefix)
>  {
>  	struct repository subrepo;
> =20
> @@ -229,7 +231,7 @@ static void show_submodule(struct repository *superpr=
oject,
>  	if (repo_read_index(&subrepo) < 0)
>  		die("index file corrupt");
> =20
> -	show_files(&subrepo, dir);
> +	show_files(&subrepo, dir, super_prefix);
> =20
>  	repo_clear(&subrepo);
>  }
> @@ -303,14 +305,19 @@ static void show_ce_fmt(struct repository *repo, co=
nst struct cache_entry *ce,
> =20
>  static void show_ce(struct repository *repo, struct dir_struct *dir,
>  		    const struct cache_entry *ce, const char *fullname,
> -		    const char *tag)
> +		    const char *tag, const char *super_prefix)
>  {
>  	if (max_prefix_len > strlen(fullname))
>  		die("git ls-files: internal error - cache entry not superset of prefix=
");
> =20
>  	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
>  	    is_submodule_active(repo, ce->name)) {
> -		show_submodule(repo, dir, ce->name);
> +		struct strbuf sp =3D STRBUF_INIT;
> +
> +		strbuf_addf(&sp, "%s%s/", super_prefix ? super_prefix : "",
> +			    ce->name);
> +		show_submodule(repo, dir, ce->name, sp.buf);
> +		strbuf_release(&sp);
>  	} else if (match_pathspec(repo->index, &pathspec, fullname, strlen(full=
name),
>  				  max_prefix_len, ps_matched,
>  				  S_ISDIR(ce->ce_mode) ||
> @@ -374,16 +381,17 @@ static int ce_excluded(struct dir_struct *dir, stru=
ct index_state *istate,
>  	return is_excluded(dir, istate, fullname, &dtype);
>  }
> =20
> -static void construct_fullname(struct strbuf *out, const struct reposito=
ry *repo,
> -			       const struct cache_entry *ce)
> +static void construct_fullname(struct strbuf *out, const struct cache_en=
try *ce,
> +			       const char *super_prefix)
>  {
>  	strbuf_reset(out);
> -	if (repo->submodule_prefix)
> -		strbuf_addstr(out, repo->submodule_prefix);
> +	if (super_prefix)
> +		strbuf_addstr(out, super_prefix);
>  	strbuf_addstr(out, ce->name);
>  }
> =20
> -static void show_files(struct repository *repo, struct dir_struct *dir)
> +static void show_files(struct repository *repo, struct dir_struct *dir,
> +		       const char *super_prefix)
>  {
>  	int i;
>  	struct strbuf fullname =3D STRBUF_INIT;
> @@ -410,7 +418,7 @@ static void show_files(struct repository *repo, struc=
t dir_struct *dir)
>  		struct stat st;
>  		int stat_err;
> =20
> -		construct_fullname(&fullname, repo, ce);
> +		construct_fullname(&fullname, ce, super_prefix);
> =20
>  		if ((dir->flags & DIR_SHOW_IGNORED) &&
>  			!ce_excluded(dir, repo->index, fullname.buf, ce))
> @@ -422,7 +430,7 @@ static void show_files(struct repository *repo, struc=
t dir_struct *dir)
>  			show_ce(repo, dir, ce, fullname.buf,
>  				ce_stage(ce) ? tag_unmerged :
>  				(ce_skip_worktree(ce) ? tag_skip_worktree :
> -				 tag_cached));
> +				 tag_cached), super_prefix);
>  			if (skipping_duplicates)
>  				goto skip_to_next_name;
>  		}
> @@ -435,13 +443,15 @@ static void show_files(struct repository *repo, str=
uct dir_struct *dir)
>  		if (stat_err && (errno !=3D ENOENT && errno !=3D ENOTDIR))
>  			error_errno("cannot lstat '%s'", fullname.buf);
>  		if (stat_err && show_deleted) {
> -			show_ce(repo, dir, ce, fullname.buf, tag_removed);
> +			show_ce(repo, dir, ce, fullname.buf, tag_removed,
> +				super_prefix);
>  			if (skipping_duplicates)
>  				goto skip_to_next_name;
>  		}
>  		if (show_modified &&
>  		    (stat_err || ie_modified(repo->index, ce, &st, 0))) {
> -			show_ce(repo, dir, ce, fullname.buf, tag_modified);
> +			show_ce(repo, dir, ce, fullname.buf, tag_modified,
> +				super_prefix);
>  			if (skipping_duplicates)
>  				goto skip_to_next_name;
>  		}
> @@ -874,7 +884,7 @@ int cmd_ls_files(int argc, const char **argv, const c=
har *cmd_prefix)
>  		overlay_tree_on_index(the_repository->index, with_tree, max_prefix);
>  	}
> =20
> -	show_files(the_repository, &dir);
> +	show_files(the_repository, &dir, NULL);
> =20
>  	if (show_resolve_undo)
>  		show_ru_info(the_repository->index);
> diff --git a/grep.c b/grep.c
> index 06eed694936..10d52219229 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -791,9 +791,9 @@ void free_grep_patterns(struct grep_opt *opt)
>  		free(p);
>  	}
> =20
> -	if (!opt->pattern_expression)
> -		return;
> -	free_pattern_expr(opt->pattern_expression);
> +	if (opt->pattern_expression)
> +		free_pattern_expr(opt->pattern_expression);
> +	strbuf_release(&opt->super_prefix);
>  }
> =20
>  static const char *end_of_line(const char *cp, unsigned long *left)
> diff --git a/grep.h b/grep.h
> index 6075f997e68..d353bfa21ce 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -133,6 +133,7 @@ struct grep_opt {
>  	 * t7814-grep-recurse-submodules.sh for more information.
>  	 */
>  	struct repository *repo;
> +	struct strbuf super_prefix;
> =20
>  	int linenum;
>  	int columnnum;
> @@ -178,6 +179,7 @@ struct grep_opt {
>  };
> =20
>  #define GREP_OPT_INIT { \
> +	.super_prefix =3D STRBUF_INIT, \
>  	.relative =3D 1, \
>  	.pathname =3D 1, \
>  	.max_depth =3D -1, \
> diff --git a/repository.c b/repository.c
> index 5d166b692c8..2f8581c517d 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -228,12 +228,6 @@ int repo_submodule_init(struct repository *subrepo,
>  			goto out;
>  		}
>  	}
> -
> -	subrepo->submodule_prefix =3D xstrfmt("%s%s/",
> -					    superproject->submodule_prefix ?
> -					    superproject->submodule_prefix :
> -					    "", path);
> -
>  out:
>  	strbuf_release(&gitdir);
>  	strbuf_release(&worktree);
> @@ -261,7 +255,6 @@ void repo_clear(struct repository *repo)
>  	FREE_AND_NULL(repo->graft_file);
>  	FREE_AND_NULL(repo->index_file);
>  	FREE_AND_NULL(repo->worktree);
> -	FREE_AND_NULL(repo->submodule_prefix);
> =20
>  	raw_object_store_clear(repo->objects);
>  	FREE_AND_NULL(repo->objects);
> diff --git a/repository.h b/repository.h
> index 6c461c5b9de..a08da26133c 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -120,13 +120,6 @@ struct repository {
>  	 */
>  	char *worktree;
> =20
> -	/*
> -	 * Path from the root of the top-level superproject down to this
> -	 * repository.  This is only non-NULL if the repository is initialized
> -	 * as a submodule of another repository.
> -	 */
> -	char *submodule_prefix;
> -
>  	struct repo_settings settings;
> =20
>  	/* Subsystems */
> diff --git a/submodule.c b/submodule.c
> index 1e4eee3492b..1c5ef904a03 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -528,9 +528,6 @@ static struct repository *open_submodule(const char *=
path)
>  		return NULL;
>  	}
> =20
> -	/* Mark it as a submodule */
> -	out->submodule_prefix =3D xstrdup(path);
> -
>  	strbuf_release(&sb);
>  	return out;
>  }
> --=20
> 2.38.0.1471.ge4d8947e7aa
