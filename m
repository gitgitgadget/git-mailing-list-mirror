Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37091F1534
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768008019; cv=none; b=RMzUjE157Vd1u1HrWSH9/X4/VlKL8Ffe1Rt+V1fI2e+OIc6m2dBbDrbQHcGl7Mn6cKNTJjJfA5Z+mqgfyV0uuTmqv/YhNljibMW3BuCq52Cu/h39wly44NdlJI9cgJCnf6U3X/IStrL6SeukCor3qQmeWTDOt0mlShF9UnF0lBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768008019; c=relaxed/simple;
	bh=/w7DUH8Oy3auh0HrcjuSOtPXr711AWjukf7fpF5Lb6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxSvw9gAJweG97SJO9PdsYb4FsfAJq4L29L5NWhQCDtGxElXHuVYqlnSUFCuM7kbWda/kZEkUnbOCGVzTmCPtGy2KbTdKI/6bl1tkgretf306bYymAlN2P2SftGk16qBMvBaKqIWoe7xAWFtkeayMvdqknoDGn/2nMcmTxRgieI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBQz+twC; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBQz+twC"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-65e94e128beso2009043eaf.0
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 17:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768008015; x=1768612815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dug9zyu4oHHUuyS8HhOtAo6HruYznGB4fdxF/BZDSUA=;
        b=DBQz+twC6svFNn7m8PBvmdQ50GD6qPZInExKdADl1MNneRV9OTX+p4CXXsXJ5G+lz8
         0Zb/drKTRCg/Tx1bzLhxkk37AZeMv9KQCDK8IeyALC7mUfX5Zf32REMC1yxhoVQbavGc
         a9rB7dDSuHnG4o41kUTd2RpTFcH2wx/EiMvflbFhHNqRHEW1Z+y64yWeQhqGZYmxwK+r
         ym7mQCM9jpPy2nVFSGHTg3EQW9Q+7ZQ6VPZ7tPyY4XkgW6Ve0CsvI1mlycUxcvlO2JZv
         PtGG7UmQG5Ddo3boVkU2p0hWuKbqvLCERmieBwYgzIiA3uBVYvN0KNr1y1TagkpQXks1
         0LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768008015; x=1768612815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dug9zyu4oHHUuyS8HhOtAo6HruYznGB4fdxF/BZDSUA=;
        b=cvn8rqW7lbvJg9ne9wdLCiOLNPoeWmheBqs4p5Nih8RyFLCdyhoNfIKzM8wpllH4yE
         oK1G+rDy5XFKTpl77kWPKpstNWt8zpGQgGaPstP+8HNODr/1TC8xh8aVzOpZLIvnR5dD
         trRAQdNj7k+A7ElNJZxxMGpJsMQw0GWp64W7XgRR0lALQ5t6Mw2GTzaDdKQuMoniM7GZ
         sjsevkWA0EQ3U40JdKxiyqdIksYhYIUPsQr+dB37HjFbR+AartMXqEElSoQoc4T6eYig
         slMXKTZhNBH9RBOl+upXw/q4dWTk1Yy4Lm6HFTBKD+EYfLgaWaaqWibH3rWACV9/FvNZ
         d29Q==
X-Gm-Message-State: AOJu0YxhoPeBTaFzZ0HMwzs5rp1RNIrcTOvxMNAwfxclLYfmI9r4N5Ai
	SMPkRzpkVFSCPBLKiFYkd8jAnxW7sPjPjXz4BDvWau6PMA+HQYqdG4P5aheAK8RyEL8Q7WOdsh+
	o//n4J8baDMC6jo+js585DtDh2vvW3As=
X-Gm-Gg: AY/fxX7qKmlHpH+ZLoWvpXtoeW/RQN6kilOTbB2y3iFLugn4wukwBudZpFDQ6KVPnyd
	cwjP8dOZqT//8ws/mo/hPGSUK/mz+ILqtk3tuexqZUWsjIWHo0pxDyR8q/Pram5dcRDnazwQRZC
	xyJ/azVHmawFsmV8o3fpe/xZIbkPQbrlP0CF/KJQo7QygDb5g4b6NeXb99K6RdO1HLp1j4nR2t/
	7i2kp0OPyfaXam4Q3xr0dBRcKDgL7y1IR9WuloZYDjymknljbrR6DYPmbO70fftfsqTM3ZuyE0X
	+BQOuhFXXiMhDqAyjeZRrEPM7ZdseKRe1corwQ==
X-Google-Smtp-Source: AGHT+IGR16dB+J+DklEigpoSdT951Z/2S/AgeVVKv6mE70TKSlLK/H2ez3yZWGDf9gdohLRLujIG0B0mLT5NpjfDpE4=
X-Received: by 2002:a4a:b349:0:b0:65d:1636:5439 with SMTP id
 006d021491bc7-65f483056a8mr7344311eaf.40.1768008015422; Fri, 09 Jan 2026
 17:20:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im> <20260107-b4-pks-history-builtin-v8-7-18e9779e3a26@pks.im>
In-Reply-To: <20260107-b4-pks-history-builtin-v8-7-18e9779e3a26@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 9 Jan 2026 17:20:04 -0800
X-Gm-Features: AQt7F2qWwlDA9djAkNVLiWzlUHmKOuPUyRBoRXiYRiHNaea0zWRjo1RdDAu0JwQ
Message-ID: <CABPp-BHFwvg5A295kXkc_axoibNhGDn4ZUkm0uE1u+358xSZzw@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] builtin/history: implement "reword" subcommand
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

On Wed, Jan 7, 2026 at 2:10=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Implement a new "reword" subcommand for git-history(1). This subcommand
> is similar to the user performing an interactive rebase with a single
> commit changed to use the "reword" instruction.
>
> The "reword" subcommand is built on top of the replay subsystem
> instead of the sequencer. This leads to some major differences compared
> to git-rebase(1):
>
>   - We do not check out the commit that is to be reworded and instead
>     perform the operation in-memory. This has the obvious benefit of
>     being significantly faster compared to git-rebase(1), but even more
>     importantly it allows the user to rewrite history even if there are
>     local changes in the working tree or in the index.
>
>   - We do not execute any hooks, even though we leave some room for
>     changing this in the future.
>
>   - By default, all local branches that contain the commit will be
>     rewritten. This especially helps with workflows that use stacked
>     branches.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-history.adoc |  23 ++-
>  builtin/history.c              | 392 +++++++++++++++++++++++++++++++++++=
+++++-
>  replay.c                       |   5 +-
>  t/meson.build                  |   1 +
>  t/t3450-history.sh             |   6 +-
>  t/t3451-history-reword.sh      | 344 +++++++++++++++++++++++++++++++++++=
+
>  6 files changed, 758 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.a=
doc
> index 5a9d931efc..4eea317e5c 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -8,7 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history
>  SYNOPSIS
>  --------
>  [synopsis]
> -git history [<options>]
> +git history reword <commit> [--ref-action=3D(branches|head|print)]
>
>  DESCRIPTION
>  -----------
> @@ -32,8 +32,9 @@ Overall, linkgit:git-history[1] aims to provide a more =
opinionated way to modify
>  your commit history that is simpler to use compared to linkgit:git-rebas=
e[1] in
>  general.
>
> -If you want to reapply a range of commits onto a different base, or inte=
ractive
> -rebases if you want to edit a range of commits.
> +Use linkgit:git-rebase[1] if you want to reapply a range of commits onto=
 a
> +different base, or interactive rebases if you want to edit a range of co=
mmits
> +at once.

Ah, was the previous sentence here from the former patch just a bad
splitting when you were rewriting?

>  LIMITATIONS
>  -----------
> @@ -51,6 +52,22 @@ COMMANDS
>
>  Several commands are available to rewrite history in different ways:
>
> +`reword <commit>`::
> +       Rewrite the commit message of the specified commit. All the other
> +       details of this commit remain unchanged. This command will spawn =
an
> +       editor with the current message of that commit.

One isn't exactly "several"; I know you'll add more later, but since
this series ends here, should that word be changed?

> +
> +OPTIONS
> +-------
> +
> +`--ref-action=3D(branches|head|print)`::
> +       Control which references will be updated by the command, if any. =
With
> +       `branches`, all local branches that point to commits which are
> +       decendants of the original commit will be rewritten. With `head`,=
 only

decendants -> descendants .   Or maybe double down on the typo and
extend it a bit into either 'decedent' or 'decadent'.  That could be
fun.

> +       the current `HEAD` reference will be rewritten. With `print`, all
> +       updates as they would be performed with `branches` are printed in=
 a
> +       format that can be consumed by linkgit:git-update-ref[1].
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/builtin/history.c b/builtin/history.c
> index f6fe32610b..59011ea517 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -1,22 +1,404 @@
> +#define USE_THE_REPOSITORY_VARIABLE
> +
>  #include "builtin.h"
> +#include "commit.h"
> +#include "commit-reach.h"
> +#include "config.h"
> +#include "editor.h"
> +#include "environment.h"
>  #include "gettext.h"
> +#include "hex.h"
>  #include "parse-options.h"
> +#include "refs.h"
> +#include "replay.h"
> +#include "revision.h"
> +#include "sequencer.h"
> +#include "strvec.h"
> +#include "tree.h"
> +#include "wt-status.h"
> +
> +#define GIT_HISTORY_REWORD_USAGE \
> +       N_("git history reword <commit> [--ref-action=3D(branches|head|pr=
int)]")
> +
> +static void change_data_free(void *util, const char *str UNUSED)
> +{
> +       struct wt_status_change_data *d =3D util;
> +       free(d->rename_source);
> +       free(d);
> +}
> +
> +static int fill_commit_message(struct repository *repo,
> +                              const struct object_id *old_tree,
> +                              const struct object_id *new_tree,
> +                              const char *default_message,
> +                              const char *action,
> +                              struct strbuf *out)
> +{
> +       const char *path =3D git_path_commit_editmsg();
> +       const char *hint =3D
> +               _("Please enter the commit message for the %s changes."
> +                 " Lines starting\nwith '%s' will be ignored, and an"
> +                 " empty message aborts the commit.\n");
> +       struct wt_status s;
> +
> +       strbuf_addstr(out, default_message);
> +       strbuf_addch(out, '\n');
> +       strbuf_commented_addf(out, comment_line_str, hint, action, commen=
t_line_str);
> +       write_file_buf(path, out->buf, out->len);
> +
> +       wt_status_prepare(repo, &s);
> +       FREE_AND_NULL(s.branch);
> +       s.ahead_behind_flags =3D AHEAD_BEHIND_QUICK;
> +       s.commit_template =3D 1;
> +       s.colopts =3D 0;
> +       s.display_comment_prefix =3D 1;
> +       s.hints =3D 0;
> +       s.use_color =3D 0;
> +       s.whence =3D FROM_COMMIT;
> +       s.committable =3D 1;
> +
> +       s.fp =3D fopen(git_path_commit_editmsg(), "a");
> +       if (!s.fp)
> +               return error_errno(_("could not open '%s'"), git_path_com=
mit_editmsg());
> +
> +       wt_status_collect_changes_trees(&s, old_tree, new_tree);
> +       wt_status_print(&s);
> +       wt_status_collect_free_buffers(&s);
> +       string_list_clear_func(&s.change, change_data_free);
> +
> +       strbuf_reset(out);
> +       if (launch_editor(path, out, NULL)) {
> +               fprintf(stderr, _("Aborting commit as launching the edito=
r failed.\n"));
> +               return -1;
> +       }
> +       strbuf_stripspace(out, comment_line_str);
> +
> +       cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, 0);
> +
> +       if (!out->len) {
> +               fprintf(stderr, _("Aborting commit due to empty commit me=
ssage.\n"));
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int commit_tree_with_edited_message(struct repository *repo,
> +                                          const char *action,
> +                                          struct commit *original,
> +                                          struct commit **out)
> +{
> +       const char *exclude_gpgsig[] =3D { "gpgsig", "gpgsig-sha256", NUL=
L };
> +       const char *original_message, *original_body, *ptr;
> +       struct commit_extra_header *original_extra_headers =3D NULL;
> +       struct strbuf commit_message =3D STRBUF_INIT;
> +       struct object_id rewritten_commit_oid;
> +       struct object_id original_tree_oid;
> +       struct object_id parent_tree_oid;
> +       char *original_author =3D NULL;
> +       struct commit *parent;
> +       size_t len;
> +       int ret;
> +
> +       original_tree_oid =3D repo_get_commit_tree(repo, original)->objec=
t.oid;
> +
> +       parent =3D original->parents ? original->parents->item : NULL;
> +       if (parent) {
> +               if (repo_parse_commit(repo, parent)) {
> +                       ret =3D error(_("unable to parse parent commit %s=
"),
> +                                   oid_to_hex(&parent->object.oid));
> +                       goto out;
> +               }
> +
> +               parent_tree_oid =3D repo_get_commit_tree(repo, parent)->o=
bject.oid;
> +       } else {
> +               oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
> +       }
> +
> +       /* We retain authorship of the original commit. */
> +       original_message =3D repo_logmsg_reencode(repo, original, NULL, N=
ULL);
> +       ptr =3D find_commit_header(original_message, "author", &len);
> +       if (ptr)
> +               original_author =3D xmemdupz(ptr, len);
> +       find_commit_subject(original_message, &original_body);
> +
> +       ret =3D fill_commit_message(repo, &parent_tree_oid, &original_tre=
e_oid,
> +                                 original_body, action, &commit_message)=
;
> +       if (ret < 0)
> +               goto out;
> +
> +       original_extra_headers =3D read_commit_extra_headers(original, ex=
clude_gpgsig);

Does this grab encoding?  If so, should it be excluded as well given
the repo_logmsg_reencode() call?

> +
> +       ret =3D commit_tree_extended(commit_message.buf, commit_message.l=
en, &original_tree_oid,
> +                                  original->parents, &rewritten_commit_o=
id, original_author,
> +                                  NULL, NULL, original_extra_headers);
> +       if (ret < 0)
> +               goto out;
> +
> +       *out =3D lookup_commit_or_die(&rewritten_commit_oid, "rewritten c=
ommit");
> +
> +out:
> +       free_commit_extra_headers(original_extra_headers);
> +       strbuf_release(&commit_message);
> +       free(original_author);
> +       return ret;
> +}
> +
> +enum ref_action {
> +       REF_ACTION_DEFAULT,
> +       REF_ACTION_BRANCHES,
> +       REF_ACTION_HEAD,
> +       REF_ACTION_PRINT,
> +};
> +
> +static int parse_ref_action(const struct option *opt, const char *value,=
 int unset)
> +{
> +       enum ref_action *action =3D opt->value;
> +
> +       BUG_ON_OPT_NEG_NOARG(unset, value);
> +       if (!strcmp(value, "branches")) {
> +               *action =3D REF_ACTION_BRANCHES;
> +       } else if (!strcmp(value, "head")) {
> +               *action =3D REF_ACTION_HEAD;
> +       } else if (!strcmp(value, "print")) {
> +               *action =3D REF_ACTION_PRINT;
> +       } else {
> +               return error(_("%s expects one of 'branches', 'head' or '=
print'"),
> +                            opt->long_name);
> +       }
> +
> +       return 0;
> +}
> +
> +static int handle_reference_updates(enum ref_action action,
> +                                   struct repository *repo,
> +                                   struct commit *original,
> +                                   struct commit *rewritten,
> +                                   const char *reflog_msg)
> +{
> +       const struct name_decoration *decoration;
> +       struct replay_revisions_options opts =3D { 0 };
> +       struct replay_ref_updates updates =3D {
> +               .final_oid =3D rewritten->object.oid,
> +       };
> +       struct ref_transaction *transaction =3D NULL;
> +       struct strvec args =3D STRVEC_INIT;
> +       struct strbuf err =3D STRBUF_INIT;
> +       struct commit *head =3D NULL;
> +       struct rev_info revs;
> +       char hex[GIT_MAX_HEXSZ + 1];
> +       int ret;
> +
> +       repo_init_revisions(repo, &revs, NULL);
> +       strvec_push(&args, "ignored");
> +       strvec_push(&args, "--reverse");
> +       strvec_push(&args, "--topo-order");
> +       strvec_push(&args, "--full-history");
> +
> +       /* We only want to see commits that are descendants of the old co=
mmit. */
> +       strvec_pushf(&args, "--ancestry-path=3D%s",
> +                    oid_to_hex(&original->object.oid));
> +
> +       /*
> +        * Ancestry path may also show ancestors of the old commit, but w=
e
> +        * don't want to see those, either.
> +        */
> +       strvec_pushf(&args, "^%s", oid_to_hex(&original->object.oid));
> +
> +       /*
> +        * When we're asked to update HEAD we need to verify that the com=
mit
> +        * that we want to rewrite is actually an ancestor of it and, if =
so,
> +        * update it. Otherwise we'll update (or print) all descendant
> +        * branches.
> +        */
> +       if (action =3D=3D REF_ACTION_HEAD) {
> +               struct commit_list *from_list =3D NULL;
> +
> +               head =3D lookup_commit_reference_by_name("HEAD");
> +               if (!head) {
> +                       ret =3D error(_("cannot look up HEAD"));
> +                       goto out;
> +               }
> +
> +               commit_list_insert(original, &from_list);
> +               ret =3D repo_is_descendant_of(repo, head, from_list);
> +               free_commit_list(from_list);
> +
> +               if (ret < 0) {
> +                       ret =3D error(_("cannot determine descendance"));
> +                       goto out;
> +               } else if (!ret) {
> +                       ret =3D error(_("rewritten commit must be an ance=
stor "
> +                                     "of HEAD when using --ref-action=3D=
head"));
> +                       goto out;
> +               }
> +
> +               strvec_push(&args, oid_to_hex(&head->object.oid));

If you used "HEAD" here instead of its oid, then you wouldn't need a
separate codepath for REF_ACTION_HEAD in your "switch(action)" block
below.

> +       } else {
> +               strvec_push(&args, "--branches");
> +       }
> +
> +       setup_revisions_from_strvec(&args, &revs, NULL);
> +       if (revs.nr)
> +               BUG("revisions were set up with invalid argument '%s'", a=
rgs.v[0]);
> +
> +       opts.onto =3D oid_to_hex_r(hex, &rewritten->object.oid);
> +
> +       ret =3D replay_revisions(repo, &revs, &opts, &updates);
> +       if (ret)
> +               goto out;
> +
> +       switch (action) {
> +       case REF_ACTION_DEFAULT:
> +       case REF_ACTION_BRANCHES:
> +               transaction =3D ref_store_transaction_begin(get_main_ref_=
store(repo), 0, &err);
> +               if (!transaction) {
> +                       ret =3D error(_("failed to begin ref transaction:=
 %s"), err.buf);
> +                       goto out;
> +               }
> +
> +               for (size_t i =3D 0; i < updates.nr; i++) {
> +                       ret =3D ref_transaction_update(transaction,
> +                                                    updates.items[i].ref=
name,
> +                                                    &updates.items[i].ne=
w_oid,
> +                                                    &updates.items[i].ol=
d_oid,
> +                                                    NULL, NULL, 0, reflo=
g_msg, &err);
> +                       if (ret) {
> +                               ret =3D error(_("failed to update ref '%s=
': %s"),
> +                                           updates.items[i].refname, err=
.buf);
> +                               goto out;
> +                       }
> +               }
> +
> +               /*
> +                * `replay_revisions()` only updates references that are
> +                * ancestors of `rewritten`, so we need to manually
> +                * handle updating references that point to `original`.
> +                */

This is a good catch; I was wondering if there was a way to put this
logic into replay_revisions() so that other callers need not duplicate
it, but since it just takes the revisions to walk over and that list
is empty, it'd somehow need to know about original->object.oid; it
doesn't have that info.  Hmmm...

> +               for (decoration =3D get_name_decoration(&original->object=
);
> +                    decoration;
> +                    decoration =3D decoration->next)
> +               {
> +                       if (decoration->type !=3D DECORATION_REF_LOCAL)
> +                               continue;
> +
> +                       ret =3D ref_transaction_update(transaction,
> +                                                    decoration->name,
> +                                                    &rewritten->object.o=
id,
> +                                                    &original->object.oi=
d,
> +                                                    NULL, NULL, 0, reflo=
g_msg, &err);
> +                       if (ret) {
> +                               ret =3D error(_("failed to update ref '%s=
': %s"),
> +                                           decoration->name, err.buf);
> +                               goto out;
> +                       }
> +               }
> +
> +               if (ref_transaction_commit(transaction, &err)) {
> +                       ret =3D error(_("failed to commit ref transaction=
: %s"), err.buf);
> +                       goto out;
> +               }
> +
> +               break;
> +       case REF_ACTION_HEAD:
> +               ret =3D refs_update_ref(get_main_ref_store(repo), reflog_=
msg, "HEAD",
> +                                     &updates.final_oid, &head->object.o=
id, 0,
> +                                     UPDATE_REFS_MSG_ON_ERR);
> +               if (ret)
> +                       goto out;
> +               break;

As noted above, you wouldn't need this separate REF_ACTION_HEAD block
if you passed either "HEAD" or the refname it resolved to instead of
passing its oid to the revision range.

> +       case REF_ACTION_PRINT:
> +               for (size_t i =3D 0; i < updates.nr; i++)
> +                       printf("update %s %s %s\n",
> +                              updates.items[i].refname,
> +                              oid_to_hex(&updates.items[i].new_oid),
> +                              oid_to_hex(&updates.items[i].old_oid));
> +               break;
> +       default:
> +               BUG("unsupported ref action %d", action);
> +       }
> +
> +       ret =3D 0;
> +
> +out:
> +       replay_ref_updates_release(&updates);
> +       ref_transaction_free(transaction);
> +       release_revisions(&revs);
> +       strbuf_release(&err);
> +       strvec_clear(&args);
> +       return ret;
> +}
> +
> +static int cmd_history_reword(int argc,
> +                             const char **argv,
> +                             const char *prefix,
> +                             struct repository *repo)
> +{
> +       const char * const usage[] =3D {
> +               GIT_HISTORY_REWORD_USAGE,
> +               NULL,
> +       };
> +       enum ref_action action =3D REF_ACTION_DEFAULT;
> +       struct option options[] =3D {
> +               OPT_CALLBACK_F(0, "ref-action", &action, N_("<action>"),
> +                              N_("control ref update behavior (branches|=
head|print)"),
> +                              PARSE_OPT_NONEG, parse_ref_action),
> +               OPT_END(),
> +       };
> +       struct strbuf reflog_msg =3D STRBUF_INIT;
> +       struct commit *original, *rewritten;
> +       int ret;
> +
> +       argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> +       if (argc !=3D 1) {
> +               ret =3D error(_("command expects a single revision"));
> +               goto out;
> +       }
> +       repo_config(repo, git_default_config, NULL);
> +
> +       original =3D lookup_commit_reference_by_name(argv[0]);
> +       if (!original) {
> +               ret =3D error(_("commit cannot be found: %s"), argv[0]);
> +               goto out;
> +       }
> +
> +       ret =3D commit_tree_with_edited_message(repo, "reworded", origina=
l, &rewritten);
> +       if (ret < 0) {
> +               ret =3D error(_("failed writing reworded commit"));
> +               goto out;
> +       }
> +
> +       strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
> +
> +       ret =3D handle_reference_updates(action, repo, original, rewritte=
n,
> +                                      reflog_msg.buf);
> +       if (ret < 0) {
> +               ret =3D error(_("failed replaying descendants"));
> +               goto out;
> +       }
> +
> +       ret =3D 0;
> +
> +out:
> +       strbuf_release(&reflog_msg);
> +       return ret;
> +}
>
>  int cmd_history(int argc,
>                 const char **argv,
>                 const char *prefix,
> -               struct repository *repo UNUSED)
> +               struct repository *repo)
>  {
>         const char * const usage[] =3D {
> -               N_("git history [<options>]"),
> +               GIT_HISTORY_REWORD_USAGE,
>                 NULL,
>         };
> +       parse_opt_subcommand_fn *fn =3D NULL;
>         struct option options[] =3D {
> +               OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
>                 OPT_END(),
>         };
>
>         argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> -       if (argc)
> -               usagef("unrecognized argument: %s", argv[0]);
> -       return 0;
> +       return fn(argc, argv, prefix, repo);
>  }
> diff --git a/replay.c b/replay.c
> index 8c2f2d3710..5203f9db4c 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -254,7 +254,9 @@ int replay_revisions(struct repository *repo, struct =
rev_info *revs,
>         struct commit *commit;
>         struct commit *onto =3D NULL;
>         struct merge_options merge_opt;
> -       struct merge_result result;
> +       struct merge_result result =3D {
> +               .clean =3D 1,
> +       };

Wait, what?  Why is this being initialized this way?

Same as I said over in
https://lore.kernel.org/git/CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7=
Mkcg@mail.gmail.com/,
why is this change here?  Was this due to hitting an empty range?
Actually, while supporting empty ranges didn't make sense back when I
mentioned it to Siddharth (because users always specified the ranges),
I think it actually does make sense now that ranges are implicit.
Someone could use "git history reword HEAD" (even if "git commit
--amend" already exists), and that'd result in an empty range.  So, I
think the change makes sense now, but I think this particular change
really ought to be documented and motivated in a separate commit
message rather than lumped in with the other changes in this commit.

>         char *advance;
>         int ret;
>
> @@ -270,7 +272,6 @@ int replay_revisions(struct repository *repo, struct =
rev_info *revs,
>         }
>
>         init_basic_merge_options(&merge_opt, repo);
> -       memset(&result, 0, sizeof(result));

And this is related to the new initialization of result, so this
change would be part of that separate patch.


>         merge_opt.show_rename_progress =3D 0;
>         last_commit =3D onto;
>         replayed_commits =3D kh_init_oid_map();
> diff --git a/t/meson.build b/t/meson.build
> index 73006b095a..c9f92450dc 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -388,6 +388,7 @@ integration_tests =3D [
>    't3437-rebase-fixup-options.sh',
>    't3438-rebase-broken-files.sh',
>    't3450-history.sh',
> +  't3451-history-reword.sh',
>    't3500-cherry.sh',
>    't3501-revert-cherry-pick.sh',
>    't3502-cherry-pick-merge.sh',
> diff --git a/t/t3450-history.sh b/t/t3450-history.sh
> index 417c343d43..f513463b92 100755
> --- a/t/t3450-history.sh
> +++ b/t/t3450-history.sh
> @@ -5,13 +5,13 @@ test_description=3D'tests for git-history command'
>  . ./test-lib.sh
>
>  test_expect_success 'does nothing without any arguments' '
> -       git history >out 2>&1 &&
> -       test_must_be_empty out
> +       test_must_fail git history 2>err &&
> +       test_grep "need a subcommand" err
>  '
>
>  test_expect_success 'raises an error with unknown argument' '
>         test_must_fail git history garbage 2>err &&
> -       test_grep "unrecognized argument: garbage" err
> +       test_grep "unknown subcommand: .garbage." err
>  '
>
>  test_done
> diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> new file mode 100755
> index 0000000000..cd5883051d
> --- /dev/null
> +++ b/t/t3451-history-reword.sh
> @@ -0,0 +1,344 @@
> +#!/bin/sh
> +
> +test_description=3D'tests for git-history reword subcommand'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-log-graph.sh"
> +
> +reword_with_message () {
> +       cat >message &&
> +       write_script fake-editor.sh <<-\EOF &&
> +       cp message "$1"
> +       EOF
> +       test_set_editor "$(pwd)"/fake-editor.sh &&
> +       git history reword "$@" &&
> +       rm fake-editor.sh message
> +}
> +
> +expect_graph () {
> +       cat >expect &&
> +       lib_test_cmp_graph --graph --format=3D%s "$@"
> +}
> +
> +expect_log () {
> +       git log --format=3D"%s" "$@" >actual &&
> +       cat >expect &&
> +       test_cmp expect actual
> +}
> +
> +test_expect_success 'can reword tip of a branch' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit first &&
> +               test_commit second &&
> +               test_commit third &&
> +
> +               git symbolic-ref HEAD >expect &&
> +               reword_with_message HEAD <<-EOF &&
> +               third reworded
> +               EOF
> +               git symbolic-ref HEAD >actual &&
> +               test_cmp expect actual &&
> +
> +               expect_log <<-\EOF &&
> +               third reworded
> +               second
> +               first
> +               EOF
> +
> +               git reflog >reflog &&
> +               test_grep "reword: updating HEAD" reflog
> +       )
> +'
> +
> +test_expect_success 'can reword commit in the middle' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit first &&
> +               test_commit second &&
> +               test_commit third &&
> +
> +               git symbolic-ref HEAD >expect &&
> +               reword_with_message HEAD~ <<-EOF &&
> +               second reworded
> +               EOF
> +               git symbolic-ref HEAD >actual &&
> +               test_cmp expect actual &&
> +
> +               expect_log <<-\EOF
> +               third
> +               second reworded
> +               first
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can reword root commit' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit first &&
> +               test_commit second &&
> +               test_commit third &&
> +               reword_with_message HEAD~2 <<-EOF &&
> +               first reworded
> +               EOF
> +
> +               expect_log <<-\EOF
> +               third
> +               second
> +               first reworded
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can reword in a bare repo' '
> +       test_when_finished "rm -rf repo repo.git" &&
> +       git init repo &&
> +       test_commit -C repo first &&
> +       git clone --bare repo repo.git &&
> +       (
> +               cd repo.git &&
> +               reword_with_message HEAD <<-EOF &&
> +               reworded
> +               EOF
> +
> +               expect_log <<-\EOF
> +               reworded
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can reword a commit on a different branch' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               git branch theirs &&
> +               test_commit ours &&
> +               git switch theirs &&
> +               test_commit theirs &&
> +
> +               git rev-parse ours >ours-before &&
> +               reword_with_message theirs <<-EOF &&
> +               Reworded theirs
> +               EOF
> +               git rev-parse ours >ours-after &&
> +               test_cmp ours-before ours-after &&
> +
> +               expect_graph --branches <<-\EOF
> +               * Reworded theirs
> +               | * ours
> +               |/
> +               * base
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can reword a merge commit' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               git branch branch &&
> +               test_commit ours &&
> +               git switch branch &&
> +               test_commit theirs &&
> +               git switch - &&
> +               git merge theirs &&
> +
> +               # It is not possible to replay merge commits embedded in =
the
> +               # history (yet).
> +               test_must_fail git history reword HEAD~ 2>err &&
> +               test_grep "replaying merge commits is not supported yet" =
err &&
> +
> +               # But it is possible to reword a merge commit directly.
> +               reword_with_message HEAD <<-EOF &&
> +               Reworded merge commit
> +               EOF
> +               expect_graph <<-\EOF
> +               *   Reworded merge commit
> +               |\
> +               | * theirs
> +               * | ours
> +               |/
> +               * base
> +               EOF
> +       )
> +'
> +
> +test_expect_success '--ref-action=3Dprint prints ref updates without mod=
ifying repo' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo --initial-branch=3Dmain &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               git branch branch &&
> +               test_commit ours &&
> +               git switch branch &&
> +               test_commit theirs &&
> +
> +               git refs list >refs-expect &&
> +               reword_with_message --ref-action=3Dprint base >updates <<=
-\EOF &&
> +               reworded commit
> +               EOF
> +               git refs list >refs-actual &&
> +               test_cmp refs-expect refs-actual &&
> +
> +               test_grep "update refs/heads/branch" updates &&
> +               test_grep "update refs/heads/main" updates &&
> +               git update-ref --stdin <updates &&
> +               expect_log --branches <<-\EOF
> +               theirs
> +               ours
> +               reworded commit
> +               EOF
> +       )
> +'
> +
> +test_expect_success '--ref-action=3Dhead updates only HEAD' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo --initial-branch=3Dmain &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               git branch branch &&
> +               test_commit theirs &&
> +               git switch branch &&
> +               test_commit ours &&
> +
> +               # When told to update HEAD, only, the command will refuse=
 to
> +               # rewrite commits that are not an ancestor of HEAD.
> +               test_must_fail git history reword --ref-action=3Dhead the=
irs 2>err &&
> +               test_grep "rewritten commit must be an ancestor of HEAD" =
err &&
> +
> +               reword_with_message --ref-action=3Dhead base >updates <<-=
\EOF &&
> +               reworded base
> +               EOF
> +               expect_log HEAD <<-\EOF &&
> +               ours
> +               reworded base
> +               EOF
> +               expect_log main <<-\EOF
> +               theirs
> +               base
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'editor shows proper status' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit first &&
> +
> +               write_script fake-editor.sh <<-\EOF &&
> +               cp "$1" . &&
> +               printf "\namend a comment\n" >>"$1"
> +               EOF
> +               test_set_editor "$(pwd)"/fake-editor.sh &&
> +               git history reword HEAD &&
> +
> +               cat >expect <<-EOF &&
> +               first
> +
> +               # Please enter the commit message for the reworded change=
s. Lines starting
> +               # with ${SQ}#${SQ} will be ignored, and an empty message =
aborts the commit.
> +               # Changes to be committed:
> +               #       new file:   first.t
> +               #
> +               EOF
> +               test_cmp expect COMMIT_EDITMSG &&
> +
> +               test_commit_message HEAD <<-\EOF
> +               first
> +
> +               amend a comment
> +               EOF
> +       )
> +'
> +
> +# For now, git-history(1) does not yet execute any hooks. This is subjec=
t to
> +# change in the future, and if it does this test here is expected to sta=
rt
> +# failing. In other words, this test is not an endorsement of the curren=
t
> +# status quo.
> +test_expect_success 'hooks are not executed for rewritten commits' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit first &&
> +               test_commit second &&
> +               test_commit third &&
> +
> +               ORIG_PATH=3D"$(pwd)" &&
> +               export ORIG_PATH &&
> +               for hook in prepare-commit-msg pre-commit post-commit pos=
t-rewrite commit-msg
> +               do
> +                       write_script .git/hooks/$hook <<-\EOF || exit 1
> +                       touch "$ORIG_PATH/hooks.log
> +                       EOF
> +               done &&
> +
> +               reword_with_message HEAD~ <<-EOF &&
> +               second reworded
> +               EOF
> +
> +               cat >expect <<-EOF &&
> +               third
> +               second reworded
> +               first
> +               EOF
> +               git log --format=3D%s >actual &&
> +               test_cmp expect actual &&
> +
> +               test_path_is_missing hooks.log
> +       )
> +'
> +
> +test_expect_success 'aborts with empty commit message' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit first &&
> +
> +               ! reword_with_message HEAD 2>err </dev/null &&
> +               test_grep "Aborting commit due to empty commit message." =
err
> +       )
> +'
> +
> +test_expect_success 'retains changes in the worktree and index' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch a b &&
> +               git add . &&
> +               git commit -m "initial commit" &&
> +               echo foo >a &&
> +               echo bar >b &&
> +               git add b &&
> +               reword_with_message HEAD <<-EOF &&
> +               message
> +               EOF
> +               cat >expect <<-\EOF &&
> +                M a
> +               M  b
> +               ?? actual
> +               ?? expect
> +               EOF
> +               git status --porcelain >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_done
>
> --
> 2.52.0.542.g9473a8513b.dirty
