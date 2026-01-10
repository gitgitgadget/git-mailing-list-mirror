Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3850E218AB9
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768007816; cv=none; b=jjMC7GOHYUVjRFNiGIIqOkG/Z0pNa3NJs/vf0A3zMA7kUcPqjrjKTwGP8Xi8XSQ+iBtzuu/cM1kCq70xld7DZLNQ0nx4CpsHwnHtXu6vwJYEsI+RcUzxwuipAH/FNPiUqMx3EKP9qJhctP+I3pCuy2kgQ52I+1IdFgt5phRIen0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768007816; c=relaxed/simple;
	bh=MWfEvSYPKsjS1CxxJCOjujOLoxVOggYWbd2yhCjaxjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d98OhezuIeSvngUDeivsKVwdwQMC/XGitCYPXlQ9toVZ5sQ7uu1aqSC8+XlYagZSppbjfkw7HQ55YTQOhFT3f27OFpclS0m6qjuSoP8xbfYePej4qqMs3dhDvetzcnIP1LTcX4ROP4NuTr9ZDJD77lNNC8BRUgYPjYxFBCYm7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETYSQLXC; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETYSQLXC"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-65cf3d51c95so2649724eaf.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 17:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768007813; x=1768612613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HOFCjkURqH3X3mTJrQm/Lw8jytFLoJjeMqjanJi/+w=;
        b=ETYSQLXCdpj79+JAbNvNpnM1uirphs7F9QBaaKDN1V0+PbFMnUzQosdspjm8H+uo5H
         bEVZJUz64WJMC8y/f/MIub7wyKXvKIW1bFvDDjzPRPEg8ZZo+9i+UuiWQNP27eu7TgPc
         S1X2Hlgu2TFCWTfKq+oSIIYG2juwEYZU0vAJ0R6itUreWsamT/M145kOOUbEzM/PpDoZ
         qLE7C5YOXbGDKm2ewAfrLro8SXwvwjLjwQfOahOaCQb/WdsZkAzQ1m5fOsOFWb0WZ8zV
         Ve6MY2HNKVvLRtBsB46537Wyeh6Q3/hjXgU7120MiTg/3vWFpZI+9D36RHLGW4qrybd5
         KWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768007813; x=1768612613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1HOFCjkURqH3X3mTJrQm/Lw8jytFLoJjeMqjanJi/+w=;
        b=h4ys4DWUBAKSmneDdB/xptAVF6NpoEoKED3oOodFDuCQaU7RskTb8peM4ZHH92b9o+
         ANKs68VmSMz8s9KZFh8eToAWCQ6aGkzQcSQN5hmkST/1iVZtdw+jEtWvba3kVEAg4hIj
         kqwZnTWExhcOC2az6Be1/qWR/KlYgbwlfD0sIfVkqTippQy0MS84kksU+RwlbMCe+eSp
         BLRnDCDwG5lYAeP/TAlNBc9aUJR0V3voUHrxtSLw7BRvrdYWbXt0UfgnlB/dYVDw6jtU
         sPordDTStc4BfBj+MrBFEftLTxPl2WYPtyFx5pGMLwGuTkqOTJl8a+YVFHQXMgg3YF3B
         5jvw==
X-Gm-Message-State: AOJu0Yw3mlqGQkikIqZ0p2qQhAnY19daiAXd5cHrCjYHd4O3LYGJwInr
	Ot+n8p7tXO3viehuhyrIXnRQFkWjizAGwZ6aKMg2UrVW+IO4BQS7vT6K7TSAIcC/NnQe/7NGNVu
	5pTVFf9VoL5Lflf/k1wn9nkl4WaSRJYs=
X-Gm-Gg: AY/fxX7UlTG5b3z7kxlgu+xRboVWt1DULE/6HUeTFIlN03F0LhdcE26cS3WnSAVFSvK
	+fiy3RJmJTDpsr50MWbzHcZnzUy9soGfB7n+TgunYVGTc1vyNDmMNus0H4JOds36D3bv/FmF++r
	qKCb0XNImvrLDY9WJ7bDxLFwBaEJOnUqiSsu0lAnNHQikwH0uNsi5s0RL9kQF2r0l11GIQZv/Nd
	xHfoxO3EuP+8wuYx8kYVGCY3lXkhniKA98KJ3YXM/QN79gp+zoEB2azvtpKaTULskOP82qD/jJp
	kk97m1ReJYhABwQj4ylg11qrvq8=
X-Google-Smtp-Source: AGHT+IF8WDUvgn3SW449Qfd+cm75CI6hfXOpl86NDhjn7niZWHRBizaFCquTL2/rjBmY0rMWXAFzxfIYvntG7zaZbTc=
X-Received: by 2002:a05:6820:1691:b0:65f:546c:fb01 with SMTP id
 006d021491bc7-65f54f072e2mr6248586eaf.3.1768007812723; Fri, 09 Jan 2026
 17:16:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im> <20260109-b4-pks-history-builtin-v9-2-8766101814c6@pks.im>
In-Reply-To: <20260109-b4-pks-history-builtin-v9-2-8766101814c6@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 9 Jan 2026 17:16:41 -0800
X-Gm-Features: AQt7F2qOU3DhGkomlvyzvMKMrYgsdFQysBt0L1MMrhS32fjGzQGPm9zWJEI39wM
Message-ID: <CABPp-BEo5jGBgJBkCdu_GHstsbEm4mCpKO3NWvNfcjDVC+SbLQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] builtin/replay: move core logic into "libgit.a"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 12:35=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Move the core logic used to replay commits into "libgit.a" so that it
> can be easily reused by other commands. It will be used in a subsequent
> commit where we're about to introduce a new git-history(1) command.
>
> Note that with this change we have no sign-comparison warnings anymore,
> and neither do we depend on `the_repository`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Makefile         |   1 +
>  builtin/replay.c | 368 +------------------------------------------------=
------
>  meson.build      |   1 +
>  replay.c         | 355 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
>  replay.h         |  64 ++++++++++
>  5 files changed, 422 insertions(+), 367 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index b7eba509c6..1c64a5d2ae 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1285,6 +1285,7 @@ LIB_OBJS +=3D repack-geometry.o
>  LIB_OBJS +=3D repack-midx.o
>  LIB_OBJS +=3D repack-promisor.o
>  LIB_OBJS +=3D replace-object.o
> +LIB_OBJS +=3D replay.o
>  LIB_OBJS +=3D repo-settings.o
>  LIB_OBJS +=3D repository.o
>  LIB_OBJS +=3D rerere.o
> diff --git a/builtin/replay.c b/builtin/replay.c
> index df3b32a52d..da8b7202f6 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -2,257 +2,22 @@
>   * "git replay" builtin command
>   */
>
> -#define USE_THE_REPOSITORY_VARIABLE
> -#define DISABLE_SIGN_COMPARE_WARNINGS
> -
>  #include "git-compat-util.h"
>
>  #include "builtin.h"
>  #include "config.h"
> -#include "environment.h"
>  #include "hex.h"
> -#include "lockfile.h"
> -#include "merge-ort.h"
>  #include "object-name.h"
>  #include "parse-options.h"
>  #include "refs.h"
> +#include "replay.h"
>  #include "revision.h"
> -#include "strmap.h"
> -#include <oidset.h>
> -#include <tree.h>
>
>  enum ref_action_mode {
>         REF_ACTION_UPDATE,
>         REF_ACTION_PRINT,
>  };
>
> -static const char *short_commit_name(struct repository *repo,
> -                                    struct commit *commit)
> -{
> -       return repo_find_unique_abbrev(repo, &commit->object.oid,
> -                                      DEFAULT_ABBREV);
> -}
> -
> -static struct commit *peel_committish(struct repository *repo,
> -                                     const char *name,
> -                                     const char *mode)
> -{
> -       struct object *obj;
> -       struct object_id oid;
> -
> -       if (repo_get_oid(repo, name, &oid))
> -               die(_("'%s' is not a valid commit-ish for %s"), name, mod=
e);
> -       obj =3D parse_object_or_die(repo, &oid, name);
> -       return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
> -                                                 OBJ_COMMIT);
> -}
> -
> -static char *get_author(const char *message)
> -{
> -       size_t len;
> -       const char *a;
> -
> -       a =3D find_commit_header(message, "author", &len);
> -       if (a)
> -               return xmemdupz(a, len);
> -
> -       return NULL;
> -}
> -
> -static struct commit *create_commit(struct repository *repo,
> -                                   struct tree *tree,
> -                                   struct commit *based_on,
> -                                   struct commit *parent)
> -{
> -       struct object_id ret;
> -       struct object *obj =3D NULL;
> -       struct commit_list *parents =3D NULL;
> -       char *author;
> -       char *sign_commit =3D NULL; /* FIXME: cli users might want to sig=
n again */
> -       struct commit_extra_header *extra =3D NULL;
> -       struct strbuf msg =3D STRBUF_INIT;
> -       const char *out_enc =3D get_commit_output_encoding();
> -       const char *message =3D repo_logmsg_reencode(repo, based_on,
> -                                                  NULL, out_enc);
> -       const char *orig_message =3D NULL;
> -       const char *exclude_gpgsig[] =3D { "gpgsig", "gpgsig-sha256", NUL=
L };
> -
> -       commit_list_insert(parent, &parents);
> -       extra =3D read_commit_extra_headers(based_on, exclude_gpgsig);
> -       find_commit_subject(message, &orig_message);
> -       strbuf_addstr(&msg, orig_message);
> -       author =3D get_author(message);
> -       reset_ident_date();
> -       if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, par=
ents,
> -                                &ret, author, NULL, sign_commit, extra))=
 {
> -               error(_("failed to write commit object"));
> -               goto out;
> -       }
> -
> -       obj =3D parse_object(repo, &ret);
> -
> -out:
> -       repo_unuse_commit_buffer(the_repository, based_on, message);
> -       free_commit_extra_headers(extra);
> -       free_commit_list(parents);
> -       strbuf_release(&msg);
> -       free(author);
> -       return (struct commit *)obj;
> -}
> -
> -struct ref_info {
> -       struct commit *onto;
> -       struct strset positive_refs;
> -       struct strset negative_refs;
> -       int positive_refexprs;
> -       int negative_refexprs;
> -};
> -
> -static void get_ref_information(struct repository *repo,
> -                               struct rev_cmdline_info *cmd_info,
> -                               struct ref_info *ref_info)
> -{
> -       int i;
> -
> -       ref_info->onto =3D NULL;
> -       strset_init(&ref_info->positive_refs);
> -       strset_init(&ref_info->negative_refs);
> -       ref_info->positive_refexprs =3D 0;
> -       ref_info->negative_refexprs =3D 0;
> -
> -       /*
> -        * When the user specifies e.g.
> -        *   git replay origin/main..mybranch
> -        *   git replay ^origin/next mybranch1 mybranch2
> -        * we want to be able to determine where to replay the commits.  =
In
> -        * these examples, the branches are probably based on an old vers=
ion
> -        * of either origin/main or origin/next, so we want to replay on =
the
> -        * newest version of that branch.  In contrast we would want to e=
rror
> -        * out if they ran
> -        *   git replay ^origin/master ^origin/next mybranch
> -        *   git replay mybranch~2..mybranch
> -        * the first of those because there's no unique base to choose, a=
nd
> -        * the second because they'd likely just be replaying commits on =
top
> -        * of the same commit and not making any difference.
> -        */
> -       for (i =3D 0; i < cmd_info->nr; i++) {
> -               struct rev_cmdline_entry *e =3D cmd_info->rev + i;
> -               struct object_id oid;
> -               const char *refexpr =3D e->name;
> -               char *fullname =3D NULL;
> -               int can_uniquely_dwim =3D 1;
> -
> -               if (*refexpr =3D=3D '^')
> -                       refexpr++;
> -               if (repo_dwim_ref(repo, refexpr, strlen(refexpr), &oid, &=
fullname, 0) !=3D 1)
> -                       can_uniquely_dwim =3D 0;
> -
> -               if (e->flags & BOTTOM) {
> -                       if (can_uniquely_dwim)
> -                               strset_add(&ref_info->negative_refs, full=
name);
> -                       if (!ref_info->negative_refexprs)
> -                               ref_info->onto =3D lookup_commit_referenc=
e_gently(repo,
> -                                                                        =
       &e->item->oid, 1);
> -                       ref_info->negative_refexprs++;
> -               } else {
> -                       if (can_uniquely_dwim)
> -                               strset_add(&ref_info->positive_refs, full=
name);
> -                       ref_info->positive_refexprs++;
> -               }
> -
> -               free(fullname);
> -       }
> -}
> -
> -static void set_up_replay_mode(struct repository *repo,
> -                              struct rev_cmdline_info *cmd_info,
> -                              const char *onto_name,
> -                              char **advance_name,
> -                              struct commit **onto,
> -                              struct strset **update_refs)
> -{
> -       struct ref_info rinfo;
> -
> -       get_ref_information(repo, cmd_info, &rinfo);
> -       if (!rinfo.positive_refexprs)
> -               die(_("need some commits to replay"));
> -
> -       die_for_incompatible_opt2(!!onto_name, "--onto",
> -                                 !!*advance_name, "--advance");
> -       if (onto_name) {
> -               *onto =3D peel_committish(repo, onto_name, "--onto");
> -               if (rinfo.positive_refexprs <
> -                   strset_get_size(&rinfo.positive_refs))
> -                       die(_("all positive revisions given must be refer=
ences"));
> -               *update_refs =3D xcalloc(1, sizeof(**update_refs));
> -               **update_refs =3D rinfo.positive_refs;
> -               memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
> -       } else {
> -               struct object_id oid;
> -               char *fullname =3D NULL;
> -
> -               if (!*advance_name)
> -                       BUG("expected either onto_name or *advance_name i=
n this function");
> -
> -               if (repo_dwim_ref(repo, *advance_name, strlen(*advance_na=
me),
> -                            &oid, &fullname, 0) =3D=3D 1) {
> -                       free(*advance_name);
> -                       *advance_name =3D fullname;
> -               } else {
> -                       die(_("argument to --advance must be a reference"=
));
> -               }
> -               *onto =3D peel_committish(repo, *advance_name, "--advance=
");
> -               if (rinfo.positive_refexprs > 1)
> -                       die(_("cannot advance target with multiple source=
s because ordering would be ill-defined"));
> -       }
> -       strset_clear(&rinfo.negative_refs);
> -       strset_clear(&rinfo.positive_refs);
> -}
> -
> -static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
> -                                   struct commit *commit,
> -                                   struct commit *fallback)
> -{
> -       khint_t pos =3D kh_get_oid_map(replayed_commits, commit->object.o=
id);
> -       if (pos =3D=3D kh_end(replayed_commits))
> -               return fallback;
> -       return kh_value(replayed_commits, pos);
> -}
> -
> -static struct commit *pick_regular_commit(struct repository *repo,
> -                                         struct commit *pickme,
> -                                         kh_oid_map_t *replayed_commits,
> -                                         struct commit *onto,
> -                                         struct merge_options *merge_opt=
,
> -                                         struct merge_result *result)
> -{
> -       struct commit *base, *replayed_base;
> -       struct tree *pickme_tree, *base_tree;
> -
> -       base =3D pickme->parents->item;
> -       replayed_base =3D mapped_commit(replayed_commits, base, onto);
> -
> -       result->tree =3D repo_get_commit_tree(repo, replayed_base);
> -       pickme_tree =3D repo_get_commit_tree(repo, pickme);
> -       base_tree =3D repo_get_commit_tree(repo, base);
> -
> -       merge_opt->branch1 =3D short_commit_name(repo, replayed_base);
> -       merge_opt->branch2 =3D short_commit_name(repo, pickme);
> -       merge_opt->ancestor =3D xstrfmt("parent of %s", merge_opt->branch=
2);
> -
> -       merge_incore_nonrecursive(merge_opt,
> -                                 base_tree,
> -                                 result->tree,
> -                                 pickme_tree,
> -                                 result);
> -
> -       free((char*)merge_opt->ancestor);
> -       merge_opt->ancestor =3D NULL;
> -       if (!result->clean)
> -               return NULL;
> -       return create_commit(repo, result->tree, pickme, replayed_base);
> -}
> -
>  static enum ref_action_mode parse_ref_action_mode(const char *ref_action=
, const char *source)
>  {
>         if (!ref_action || !strcmp(ref_action, "update"))
> @@ -278,137 +43,6 @@ static enum ref_action_mode get_ref_action_mode(stru=
ct repository *repo, const c
>         return REF_ACTION_UPDATE;
>  }
>
> -struct replay_revisions_options {
> -       const char *advance;
> -       const char *onto;
> -       int contained;
> -};
> -
> -struct replay_result {
> -       struct replay_ref_update {
> -               char *refname;
> -               struct object_id old_oid;
> -               struct object_id new_oid;
> -       } *updates;
> -       size_t updates_nr, updates_alloc;
> -
> -       bool merge_conflict;
> -};
> -
> -static void replay_result_release(struct replay_result *result)
> -{
> -       for (size_t i =3D 0; i < result->updates_nr; i++)
> -               free(result->updates[i].refname);
> -       free(result->updates);
> -}
> -
> -static void replay_result_queue_update(struct replay_result *result,
> -                                      const char *refname,
> -                                      const struct object_id *old_oid,
> -                                      const struct object_id *new_oid)
> -{
> -       ALLOC_GROW(result->updates, result->updates_nr + 1, result->updat=
es_alloc);
> -       result->updates[result->updates_nr].refname =3D xstrdup(refname);
> -       result->updates[result->updates_nr].old_oid =3D *old_oid;
> -       result->updates[result->updates_nr].new_oid =3D *new_oid;
> -       result->updates_nr++;
> -}
> -
> -static int replay_revisions(struct repository *repo, struct rev_info *re=
vs,
> -                           struct replay_revisions_options *opts,
> -                           struct replay_result *out)
> -{
> -       kh_oid_map_t *replayed_commits =3D NULL;
> -       struct strset *update_refs =3D NULL;
> -       struct commit *last_commit =3D NULL;
> -       struct commit *commit;
> -       struct commit *onto =3D NULL;
> -       struct merge_options merge_opt;
> -       struct merge_result result;
> -       char *advance;
> -       int ret;
> -
> -       advance =3D xstrdup_or_null(opts->advance);
> -       set_up_replay_mode(repo, &revs->cmdline, opts->onto, &advance,
> -                          &onto, &update_refs);
> -
> -       /* FIXME: Should allow replaying commits with the first as a root=
 commit */
> -
> -       if (prepare_revision_walk(revs) < 0) {
> -               ret =3D error(_("error preparing revisions"));
> -               goto out;
> -       }
> -
> -       init_basic_merge_options(&merge_opt, repo);
> -       memset(&result, 0, sizeof(result));
> -       merge_opt.show_rename_progress =3D 0;
> -       last_commit =3D onto;
> -       replayed_commits =3D kh_init_oid_map();
> -       while ((commit =3D get_revision(revs))) {
> -               const struct name_decoration *decoration;
> -               khint_t pos;
> -               int hr;
> -
> -               if (!commit->parents)
> -                       die(_("replaying down from root commit is not sup=
ported yet!"));
> -               if (commit->parents->next)
> -                       die(_("replaying merge commits is not supported y=
et!"));
> -
> -               last_commit =3D pick_regular_commit(repo, commit, replaye=
d_commits,
> -                                                 onto, &merge_opt, &resu=
lt);
> -               if (!last_commit)
> -                       break;
> -
> -               /* Record commit -> last_commit mapping */
> -               pos =3D kh_put_oid_map(replayed_commits, commit->object.o=
id, &hr);
> -               if (hr =3D=3D 0)
> -                       BUG("Duplicate rewritten commit: %s\n",
> -                           oid_to_hex(&commit->object.oid));
> -               kh_value(replayed_commits, pos) =3D last_commit;
> -
> -               /* Update any necessary branches */
> -               if (advance)
> -                       continue;
> -               decoration =3D get_name_decoration(&commit->object);
> -               if (!decoration)
> -                       continue;
> -               while (decoration) {
> -                       if (decoration->type =3D=3D DECORATION_REF_LOCAL =
&&
> -                           (opts->contained || strset_contains(update_re=
fs,
> -                                                               decoratio=
n->name))) {
> -                               replay_result_queue_update(out, decoratio=
n->name,
> -                                                          &commit->objec=
t.oid,
> -                                                          &last_commit->=
object.oid);
> -                       }
> -                       decoration =3D decoration->next;
> -               }
> -       }
> -
> -       if (!result.clean) {
> -               out->merge_conflict =3D true;
> -               ret =3D -1;
> -               goto out;
> -       }
> -
> -       /* In --advance mode, advance the target ref */
> -       if (advance)
> -               replay_result_queue_update(out, advance,
> -                                          &onto->object.oid,
> -                                          &last_commit->object.oid);
> -
> -       ret =3D 0;
> -
> -out:
> -       if (update_refs) {
> -               strset_clear(update_refs);
> -               free(update_refs);
> -       }
> -       kh_destroy_oid_map(replayed_commits);
> -       merge_finalize(&merge_opt, &result);
> -       free(advance);
> -       return ret;
> -}
> -
>  static int handle_ref_update(enum ref_action_mode mode,
>                              struct ref_transaction *transaction,
>                              const char *refname,
> diff --git a/meson.build b/meson.build
> index dd52efd1c8..a5a4e99b25 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -471,6 +471,7 @@ libgit_sources =3D [
>    'repack-midx.c',
>    'repack-promisor.c',
>    'replace-object.c',
> +  'replay.c',
>    'repo-settings.c',
>    'repository.c',
>    'rerere.c',
> diff --git a/replay.c b/replay.c
> new file mode 100644
> index 0000000000..fc7186ef09
> --- /dev/null
> +++ b/replay.c
> @@ -0,0 +1,355 @@
> +#define USE_THE_REPOSITORY_VARIABLE
> +#define DISABLE_SIGN_COMPARE_WARNINGS
> +
> +#include "git-compat-util.h"
> +#include "environment.h"
> +#include "hex.h"
> +#include "merge-ort.h"
> +#include "object-name.h"
> +#include "oidset.h"

I don't think oidset is used here?   Although, come to think of it,
I'm not sure it was used in replay to begin with.  Looks like I added
this include during the switch from t/helper/test-fast-rebase, but
never used it even then.  I must have thought I was going to use it,
and added it, but never did.  Anyway, maybe this is a good time to get
rid of it?

> +#include "parse-options.h"

Why would parse-options be included here?  Oh,
die_for_incompatible_opt2()?  Feels a little weird that we have option
parsing logic outside of builtin/, but...maybe it's all fine?

> +#include "refs.h"
> +#include "replay.h"
> +#include "revision.h"

Shouldn't strmap.h (for strset) also be included?  I think we get it
as a side-effect of something else, but since we use it directly, it'd
make sense to include directly.

> +#include "tree.h"
> +
> +static const char *short_commit_name(struct repository *repo,
> +                                    struct commit *commit)
> +{
> +       return repo_find_unique_abbrev(repo, &commit->object.oid,
> +                                      DEFAULT_ABBREV);
> +}
> +
> +static struct commit *peel_committish(struct repository *repo,
> +                                     const char *name,
> +                                     const char *mode)
> +{
> +       struct object *obj;
> +       struct object_id oid;
> +
> +       if (repo_get_oid(repo, name, &oid))
> +               die(_("'%s' is not a valid commit-ish for %s"), name, mod=
e);
> +       obj =3D parse_object_or_die(repo, &oid, name);
> +       return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
> +                                                 OBJ_COMMIT);
> +}
> +
> +static char *get_author(const char *message)
> +{
> +       size_t len;
> +       const char *a;
> +
> +       a =3D find_commit_header(message, "author", &len);
> +       if (a)
> +               return xmemdupz(a, len);
> +
> +       return NULL;
> +}
> +
> +static struct commit *create_commit(struct repository *repo,
> +                                   struct tree *tree,
> +                                   struct commit *based_on,
> +                                   struct commit *parent)
> +{
> +       struct object_id ret;
> +       struct object *obj =3D NULL;
> +       struct commit_list *parents =3D NULL;
> +       char *author;
> +       char *sign_commit =3D NULL; /* FIXME: cli users might want to sig=
n again */
> +       struct commit_extra_header *extra =3D NULL;
> +       struct strbuf msg =3D STRBUF_INIT;
> +       const char *out_enc =3D get_commit_output_encoding();
> +       const char *message =3D repo_logmsg_reencode(repo, based_on,
> +                                                  NULL, out_enc);
> +       const char *orig_message =3D NULL;
> +       const char *exclude_gpgsig[] =3D { "gpgsig", "gpgsig-sha256", NUL=
L };
> +
> +       commit_list_insert(parent, &parents);
> +       extra =3D read_commit_extra_headers(based_on, exclude_gpgsig);
> +       find_commit_subject(message, &orig_message);
> +       strbuf_addstr(&msg, orig_message);
> +       author =3D get_author(message);
> +       reset_ident_date();
> +       if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, par=
ents,
> +                                &ret, author, NULL, sign_commit, extra))=
 {
> +               error(_("failed to write commit object"));
> +               goto out;
> +       }
> +
> +       obj =3D parse_object(repo, &ret);
> +
> +out:
> +       repo_unuse_commit_buffer(the_repository, based_on, message);
> +       free_commit_extra_headers(extra);
> +       free_commit_list(parents);
> +       strbuf_release(&msg);
> +       free(author);
> +       return (struct commit *)obj;
> +}
> +
> +struct ref_info {
> +       struct commit *onto;
> +       struct strset positive_refs;
> +       struct strset negative_refs;
> +       int positive_refexprs;
> +       int negative_refexprs;
> +};
> +
> +static void get_ref_information(struct repository *repo,
> +                               struct rev_cmdline_info *cmd_info,
> +                               struct ref_info *ref_info)
> +{
> +       int i;
> +
> +       ref_info->onto =3D NULL;
> +       strset_init(&ref_info->positive_refs);
> +       strset_init(&ref_info->negative_refs);
> +       ref_info->positive_refexprs =3D 0;
> +       ref_info->negative_refexprs =3D 0;
> +
> +       /*
> +        * When the user specifies e.g.
> +        *   git replay origin/main..mybranch
> +        *   git replay ^origin/next mybranch1 mybranch2
> +        * we want to be able to determine where to replay the commits.  =
In
> +        * these examples, the branches are probably based on an old vers=
ion
> +        * of either origin/main or origin/next, so we want to replay on =
the
> +        * newest version of that branch.  In contrast we would want to e=
rror
> +        * out if they ran
> +        *   git replay ^origin/master ^origin/next mybranch
> +        *   git replay mybranch~2..mybranch
> +        * the first of those because there's no unique base to choose, a=
nd
> +        * the second because they'd likely just be replaying commits on =
top
> +        * of the same commit and not making any difference.
> +        */
> +       for (i =3D 0; i < cmd_info->nr; i++) {
> +               struct rev_cmdline_entry *e =3D cmd_info->rev + i;
> +               struct object_id oid;
> +               const char *refexpr =3D e->name;
> +               char *fullname =3D NULL;
> +               int can_uniquely_dwim =3D 1;
> +
> +               if (*refexpr =3D=3D '^')
> +                       refexpr++;
> +               if (repo_dwim_ref(repo, refexpr, strlen(refexpr), &oid, &=
fullname, 0) !=3D 1)
> +                       can_uniquely_dwim =3D 0;
> +
> +               if (e->flags & BOTTOM) {
> +                       if (can_uniquely_dwim)
> +                               strset_add(&ref_info->negative_refs, full=
name);
> +                       if (!ref_info->negative_refexprs)
> +                               ref_info->onto =3D lookup_commit_referenc=
e_gently(repo,
> +                                                                        =
       &e->item->oid, 1);
> +                       ref_info->negative_refexprs++;
> +               } else {
> +                       if (can_uniquely_dwim)
> +                               strset_add(&ref_info->positive_refs, full=
name);
> +                       ref_info->positive_refexprs++;
> +               }
> +
> +               free(fullname);
> +       }
> +}
> +
> +static void set_up_replay_mode(struct repository *repo,
> +                              struct rev_cmdline_info *cmd_info,
> +                              const char *onto_name,
> +                              char **advance_name,
> +                              struct commit **onto,
> +                              struct strset **update_refs)
> +{
> +       struct ref_info rinfo;
> +
> +       get_ref_information(repo, cmd_info, &rinfo);
> +       if (!rinfo.positive_refexprs)
> +               die(_("need some commits to replay"));
> +
> +       die_for_incompatible_opt2(!!onto_name, "--onto",
> +                                 !!*advance_name, "--advance");
> +       if (onto_name) {
> +               *onto =3D peel_committish(repo, onto_name, "--onto");
> +               if (rinfo.positive_refexprs <
> +                   strset_get_size(&rinfo.positive_refs))
> +                       die(_("all positive revisions given must be refer=
ences"));
> +               *update_refs =3D xcalloc(1, sizeof(**update_refs));
> +               **update_refs =3D rinfo.positive_refs;
> +               memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
> +       } else {
> +               struct object_id oid;
> +               char *fullname =3D NULL;
> +
> +               if (!*advance_name)
> +                       BUG("expected either onto_name or *advance_name i=
n this function");
> +
> +               if (repo_dwim_ref(repo, *advance_name, strlen(*advance_na=
me),
> +                            &oid, &fullname, 0) =3D=3D 1) {
> +                       free(*advance_name);
> +                       *advance_name =3D fullname;
> +               } else {
> +                       die(_("argument to --advance must be a reference"=
));
> +               }
> +               *onto =3D peel_committish(repo, *advance_name, "--advance=
");
> +               if (rinfo.positive_refexprs > 1)
> +                       die(_("cannot advance target with multiple source=
s because ordering would be ill-defined"));
> +       }
> +       strset_clear(&rinfo.negative_refs);
> +       strset_clear(&rinfo.positive_refs);
> +}
> +
> +static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
> +                                   struct commit *commit,
> +                                   struct commit *fallback)
> +{
> +       khint_t pos =3D kh_get_oid_map(replayed_commits, commit->object.o=
id);
> +       if (pos =3D=3D kh_end(replayed_commits))
> +               return fallback;
> +       return kh_value(replayed_commits, pos);
> +}
> +
> +static struct commit *pick_regular_commit(struct repository *repo,
> +                                         struct commit *pickme,
> +                                         kh_oid_map_t *replayed_commits,
> +                                         struct commit *onto,
> +                                         struct merge_options *merge_opt=
,
> +                                         struct merge_result *result)
> +{
> +       struct commit *base, *replayed_base;
> +       struct tree *pickme_tree, *base_tree;
> +
> +       base =3D pickme->parents->item;
> +       replayed_base =3D mapped_commit(replayed_commits, base, onto);
> +
> +       result->tree =3D repo_get_commit_tree(repo, replayed_base);
> +       pickme_tree =3D repo_get_commit_tree(repo, pickme);
> +       base_tree =3D repo_get_commit_tree(repo, base);
> +
> +       merge_opt->branch1 =3D short_commit_name(repo, replayed_base);
> +       merge_opt->branch2 =3D short_commit_name(repo, pickme);
> +       merge_opt->ancestor =3D xstrfmt("parent of %s", merge_opt->branch=
2);
> +
> +       merge_incore_nonrecursive(merge_opt,
> +                                 base_tree,
> +                                 result->tree,
> +                                 pickme_tree,
> +                                 result);
> +
> +       free((char*)merge_opt->ancestor);
> +       merge_opt->ancestor =3D NULL;
> +       if (!result->clean)
> +               return NULL;
> +       return create_commit(repo, result->tree, pickme, replayed_base);
> +}
> +
> +void replay_result_release(struct replay_result *result)
> +{
> +       for (size_t i =3D 0; i < result->updates_nr; i++)
> +               free(result->updates[i].refname);
> +       free(result->updates);
> +}
> +
> +static void replay_result_queue_update(struct replay_result *result,
> +                                      const char *refname,
> +                                      const struct object_id *old_oid,
> +                                      const struct object_id *new_oid)
> +{
> +       ALLOC_GROW(result->updates, result->updates_nr + 1, result->updat=
es_alloc);
> +       result->updates[result->updates_nr].refname =3D xstrdup(refname);
> +       result->updates[result->updates_nr].old_oid =3D *old_oid;
> +       result->updates[result->updates_nr].new_oid =3D *new_oid;
> +       result->updates_nr++;
> +}
> +
> +int replay_revisions(struct repository *repo, struct rev_info *revs,
> +                    struct replay_revisions_options *opts,
> +                    struct replay_result *out)
> +{
> +       kh_oid_map_t *replayed_commits =3D NULL;
> +       struct strset *update_refs =3D NULL;
> +       struct commit *last_commit =3D NULL;
> +       struct commit *commit;
> +       struct commit *onto =3D NULL;
> +       struct merge_options merge_opt;
> +       struct merge_result result;
> +       char *advance;
> +       int ret;
> +
> +       advance =3D xstrdup_or_null(opts->advance);
> +       set_up_replay_mode(repo, &revs->cmdline, opts->onto, &advance,
> +                          &onto, &update_refs);
> +
> +       /* FIXME: Should allow replaying commits with the first as a root=
 commit */
> +
> +       if (prepare_revision_walk(revs) < 0) {
> +               ret =3D error(_("error preparing revisions"));
> +               goto out;
> +       }
> +
> +       init_basic_merge_options(&merge_opt, repo);
> +       memset(&result, 0, sizeof(result));
> +       merge_opt.show_rename_progress =3D 0;
> +       last_commit =3D onto;
> +       replayed_commits =3D kh_init_oid_map();
> +       while ((commit =3D get_revision(revs))) {
> +               const struct name_decoration *decoration;
> +               khint_t pos;
> +               int hr;
> +
> +               if (!commit->parents)
> +                       die(_("replaying down from root commit is not sup=
ported yet!"));
> +               if (commit->parents->next)
> +                       die(_("replaying merge commits is not supported y=
et!"));
> +
> +               last_commit =3D pick_regular_commit(repo, commit, replaye=
d_commits,
> +                                                 onto, &merge_opt, &resu=
lt);
> +               if (!last_commit)
> +                       break;
> +
> +               /* Record commit -> last_commit mapping */
> +               pos =3D kh_put_oid_map(replayed_commits, commit->object.o=
id, &hr);
> +               if (hr =3D=3D 0)
> +                       BUG("Duplicate rewritten commit: %s\n",
> +                           oid_to_hex(&commit->object.oid));
> +               kh_value(replayed_commits, pos) =3D last_commit;
> +
> +               /* Update any necessary branches */
> +               if (advance)
> +                       continue;
> +               decoration =3D get_name_decoration(&commit->object);
> +               if (!decoration)
> +                       continue;
> +               while (decoration) {
> +                       if (decoration->type =3D=3D DECORATION_REF_LOCAL =
&&
> +                           (opts->contained || strset_contains(update_re=
fs,
> +                                                               decoratio=
n->name))) {
> +                               replay_result_queue_update(out, decoratio=
n->name,
> +                                                          &commit->objec=
t.oid,
> +                                                          &last_commit->=
object.oid);
> +                       }
> +                       decoration =3D decoration->next;
> +               }
> +       }
> +
> +       if (!result.clean) {
> +               out->merge_conflict =3D true;
> +               ret =3D -1;
> +               goto out;
> +       }
> +
> +       /* In --advance mode, advance the target ref */
> +       if (advance)
> +               replay_result_queue_update(out, advance,
> +                                          &onto->object.oid,
> +                                          &last_commit->object.oid);
> +
> +       ret =3D 0;
> +
> +out:
> +       if (update_refs) {
> +               strset_clear(update_refs);
> +               free(update_refs);
> +       }
> +       kh_destroy_oid_map(replayed_commits);
> +       merge_finalize(&merge_opt, &result);
> +       free(advance);
> +       return ret;
> +}
> diff --git a/replay.h b/replay.h
> new file mode 100644
> index 0000000000..84bc8a7a5b
> --- /dev/null
> +++ b/replay.h
> @@ -0,0 +1,64 @@
> +#ifndef REPLAY_H
> +#define REPLAY_H
> +
> +#include "hash.h"
> +
> +struct repository;
> +struct rev_info;
> +
> +/*
> + * A set of options that can be passed to `replay_revisions()`.
> + */
> +struct replay_revisions_options {
> +       /*
> +        * Starting point at which to create the new commits; must be a b=
ranch
> +        * name. The branch will be updated to point to the rewritten com=
mits.
> +        * This option is mutually exclusive with `onto`.
> +        */
> +       const char *advance;
> +
> +       /*
> +        * Starting point at which to create the new commits; must be a
> +        * committish. References pointing at decendants of `onto` will b=
e
> +        * updated to point to the new commits.
> +        */
> +        const char *onto;
> +
> +       /*
> +        * Update branches that point at commits in the given revision ra=
nge.
> +        * Requires `onto` to be set.
> +        */
> +       int contained;
> +};
> +
> +/* This struct is used as an out-parameter by `replay_revisions()`. */
> +struct replay_result {
> +       /*
> +        * The set of reference updates that are caused by replaying the
> +        * commits.
> +        */
> +       struct replay_ref_update {
> +               char *refname;
> +               struct object_id old_oid;
> +               struct object_id new_oid;
> +       } *updates;
> +       size_t updates_nr, updates_alloc;
> +
> +       /* Set to true in case the replay failed with a merge conflict. *=
/
> +       bool merge_conflict;
> +};
> +
> +void replay_result_release(struct replay_result *result);
> +
> +/*
> + * Replay a set of commits onto a new location. Leaves both the working =
tree,
> + * index and references untouched. Reference updates caused by the repla=
y will
> + * be recorded in the `updates` out pointer.
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +int replay_revisions(struct repository *repo, struct rev_info *revs,
> +                    struct replay_revisions_options *opts,
> +                    struct replay_result *out);
> +

stray extra line?

> +#endif

It feels duplicative to have replay_result include a merge_conflict
field and to have replay_revisions() return an int which signifies
whether there's a conflict.  Can we remove one of the two?  (Perhaps
the merge_conflict field was only a workaround to the weird ret
setting from the previous patch?)
