Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754CA2459CF
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439851; cv=none; b=AcX1B4CpW42GugB25lHYiB3xO6Pkhbx/UoFpa2lnAL2E6sxFciZ5tkjbXJrxrPcBqjOxEsW7IQUlhgvYDT42u9HomAoD7JBuaI0w2eMHgGOme6LvH7yqn6tYBSWTAyzQktE/s2NOkeTtErzv0M7aDz7tErDPLbpvJ7LexWJY5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439851; c=relaxed/simple;
	bh=AnFjUFghFeqkXQfeZ9OLrukcWjUaf5b/VEtB2R05pXc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsZn2w+099xH8hBlTzQ4qdeFAxSck4/Vc0wcKlhvRtReIGVJchxfQBlsT7dQdTGYk4j70aUPtxZKgg9Tc7aAEDz8lVjxOsqCwSJ2uLZdwYkPSRu/7HZngHY82BuAssuQMOHuqJscbxlhb1AbIe2W0WRTi1wYC4BCL3593tDYVeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqSWuixq; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqSWuixq"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54aa30f4093so1706535e0c.3
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760439847; x=1761044647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=r+0zJh6TnoxjgkBDb1RAw/7FtofTCf7uEJR5kPsgjBU=;
        b=BqSWuixqye+2aTfnHUHNZ3CuaOiPxO17NWYwVz+wpgcGrTldAmXxl8H7wYqgGlHL8Z
         eWw2HHCi1fmJK73OR0E5wBNAaBYrYmqtdk8QeQQ+BxEZc2q5kV2i/aMJHehJlg3luOrA
         +6OgoxKStCnKOdkYZS3VSTZGE7eD3UEMISnWU/U5asBN+N4TTl7t9vrBsEQYKC/TAR/A
         KSJbWRbERWp5Lfbpznu2UyncIphPNGbAjsbMh+o1mka1f0QeguLRX/456lQj91dIJQOa
         WitoxcfrJIFjm+at7igagrilTNxW8fyV4iVdFTfkXfoo5qhcySpF/nP3RRgWf2B/y9ZP
         rjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760439847; x=1761044647;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+0zJh6TnoxjgkBDb1RAw/7FtofTCf7uEJR5kPsgjBU=;
        b=K1oOew4tfIjpRdzxXN6Bgmw/66mIGbvAEcY9D+EFIac5sXEThwNjpyqijEp5NK114U
         OqZUV3ZAOa7LMFVHZ6HWJ4HQDI8bVMYNUV9w4zymetUJv86Li/xEERCfPM1424fh5ynR
         MfNxS8tgy0my+nj8GrOzGJVaOuWuo3wwPc20DjZGTyu9M232T54yC9+nvkwBw2fpUIWj
         QC+dhmevLs4Rqd9WSdzVJLNngYwbitsYqJKuIl0C5j1v6MByMOYJyRGAB1Wi/0HwyG8F
         t0urUrhfbUJ4WAbjUbvLilF26XVD23dMHSlJBqaE5vKY/IuRLWJH880qPYoDHTePadOx
         p2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXVgG6QwTQT4aPmC8BH7lf/kXN9Vu5mfj5IpMlbvBRbUwZVsZr/3zyqhqarMpsrBR1cNOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiMBlcUfVWHTg58BCOUfctzksxPozC4zBkgGfxYKAsXgJPqDkh
	LazbHH1EQa09/Eggv4yhSks4mTRsF8DwBkObYOIk19+/FiH8pcIHCX+v+TYrSQEvYnKcgKN8kd/
	K5HWNObhGZBA7CFldy7qlcRvG2fyysH0=
X-Gm-Gg: ASbGncuYsfnl9pgqzEFlROOb8E0W7cKMYgsariSZ58YZemC4vNlmg5a+7JsdeYTo6xp
	kFq0BDAlotHMype5u13JIVN85/Hqg/pi6V3WAnVHC6q3+K6Fc2sP5gu4Ti+OwomUCEV5eopC/mi
	pU0fRk0ti5LlCF1I1tXDyNemPuNCv3Qrp8KQciZewCpJeYdsP15xDTp8PWlSibMW5V1rxN2/j1K
	LIadoMyy0tyEhkk/KgOoz4+8mnqhGN4SuLgioTt/wc7El3LY1Hmf31/5OKbBfe7aGMrsI0abTSS
	2eAlgQ==
X-Google-Smtp-Source: AGHT+IE5/Mq/kASCQGSfLB2R/B9ioK/76LlBHNvJKsznZthVulWN7jt622sHrKZrD0XyO+LMa2lBZ102UdQpBZYjBIA=
X-Received: by 2002:a05:6122:8c6:b0:54a:99e2:47db with SMTP id
 71dfb90a1353d-554b8bba313mr8335596e0c.13.1760439847126; Tue, 14 Oct 2025
 04:04:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 07:04:06 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 07:04:06 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-6-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im> <20251001-b4-pks-history-builtin-v4-6-8e61ddb86317@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Oct 2025 07:04:06 -0400
X-Gm-Features: AS18NWAOnoE6IOQ0svgPGlnbeAD15W1TbxXGqU5URkJCcKCBCnoGzu7WGiIOHEU
Message-ID: <CAOLa=ZSU8yr9Gn0EZ7x705qPyVM-qiMjgMCNCb8p8SMGTToxqQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/12] builtin/history: implement "reword" subcommand
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000bcb6ad06411c574f"

--000000000000bcb6ad06411c574f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> Implement a new "reword" subcommand for git-history(1). This subcommand
> is essentially the same as if a user performed an interactive rebase
> with a single commit changed to use the "reword" verb.
>

[snip]

> diff --git a/builtin/history.c b/builtin/history.c
> index f6fe32610b..7b2a0023e8 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -1,22 +1,389 @@
> +#define USE_THE_REPOSITORY_VARIABLE
> +
>  #include "builtin.h"
> +#include "commit-reach.h"
> +#include "commit.h"
> +#include "config.h"
> +#include "editor.h"
> +#include "environment.h"
>  #include "gettext.h"
> +#include "hex.h"
> +#include "oidmap.h"

Nit: This can be dropped, perhaps needed in a future patch?

>  #include "parse-options.h"
> +#include "refs.h"
> +#include "replay.h"
> +#include "reset.h"
> +#include "revision.h"
> +#include "sequencer.h"
> +#include "strvec.h"
> +#include "tree.h"
> +#include "wt-status.h"
> +
> +static int collect_commits(struct repository *repo,
> +			   struct commit *old_commit,
> +			   struct commit *new_commit,
> +			   struct strvec *out)
> +{
> +	struct setup_revision_opt revision_opts =3D {
> +		.assume_dashdash =3D 1,
> +	};
> +	struct strvec revisions =3D STRVEC_INIT;
> +	struct commit_list *from_list =3D NULL;
> +	struct commit *child;
> +	struct rev_info rev =3D { 0 };
> +	int ret;
> +
> +	/*
> +	 * Check that the old commit actually is an ancestor of HEAD. If not
> +	 * the whole request becomes nonsensical.
> +	*/

Missing space here

> +	if (old_commit) {
> +		commit_list_insert(old_commit, &from_list);
> +		if (!repo_is_descendant_of(repo, new_commit, from_list)) {
> +			ret =3D error(_("commit must be reachable from current HEAD commit"))=
;
> +			goto out;
> +		}
> +	}

Makes sense. There is an inherent assumption using the 'git history'
command that you want to modify the history of the current reference.

One question, wouldn't it make sense to parse and check that the commit
to be reworded should be checked to be a descendant of HEAD earlier on
in `cmd_history_reword()`?

This would ensure this function `collect_commits()` doesn't worry about
how it is meant to be used, and simply worries about collecting commits.


> +	repo_init_revisions(repo, &rev, NULL);
> +	strvec_push(&revisions, "");
> +	strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
> +	if (old_commit)
> +		strvec_pushf(&revisions, "^%s", oid_to_hex(&old_commit->object.oid));
> +
> +	setup_revisions_from_strvec(&revisions, &rev, &revision_opts);
> +	if (revisions.nr !=3D 1 || prepare_revision_walk(&rev)) {
> +		ret =3D error(_("revision walk setup failed"));
> +		goto out;
> +	}
> +
> +	while ((child =3D get_revision(&rev))) {
> +		if (old_commit && !child->parents)
> +			BUG("revision walk did not find child commit");
> +		if (child->parents && child->parents->next) {
> +			ret =3D error(_("cannot rearrange commit history with merges"));
> +			goto out;
> +		}
> +
> +		strvec_push(out, oid_to_hex(&child->object.oid));
> +
> +		if (child->parents && old_commit &&
> +		    commit_list_contains(old_commit, child->parents))
> +			break;
> +	}
> +

Okay makes sense here, we collect all the commits we break as soon as we
reach old_commit. Since we check for merges at the start of the loop,
the history should be linear.

[snip]

> +static void replace_commits(struct strvec *commits,
> +			    const struct object_id *commit_to_replace,
> +			    const struct object_id *replacements,
> +			    size_t replacements_nr)
> +{
> +	char commit_to_replace_oid[GIT_MAX_HEXSZ + 1];
> +	struct strvec replacement_oids =3D STRVEC_INIT;
> +	bool found =3D false;
> +
> +	oid_to_hex_r(commit_to_replace_oid, commit_to_replace);
> +	for (size_t i =3D 0; i < replacements_nr; i++)
> +		strvec_push(&replacement_oids, oid_to_hex(&replacements[i]));
> +
> +	for (size_t i =3D 0; i < commits->nr; i++) {
> +		if (strcmp(commits->v[i], commit_to_replace_oid))
> +			continue;
> +		strvec_splice(commits, i, 1, replacement_oids.v, replacement_oids.nr);
> +		found =3D true;
> +		break;
> +	}
> +	if (!found)
> +		BUG("could not find commit to replace");
> +
> +	strvec_clear(&replacement_oids);
> +}

So this basically goes over the commits that we pass and replaces a
single commit with a set of commits. In our case that would be

  C0 C1 C2 ...  CN
   =E2=94=94=E2=94=80(reword)    =E2=94=94=E2=94=80(HEAD)

     =E2=86=93 (rewrites to)

  R0 R1 R2 ... RN C1 C2 ... CN
   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98            =E2=94=94=
=E2=94=80(HEAD)
    (new commits)

Makes sense. I assume we use a list of replacements here for future
commands.

> +static int apply_commits(struct repository *repo,
> +			 const struct strvec *commits,
> +			 struct commit *onto,
> +			 struct commit *orig_head,
> +			 const char *action)
> +{
> +	struct reset_head_opts reset_opts =3D { 0 };
> +	struct merge_options merge_opts =3D { 0 };
> +	struct merge_result result =3D { 0 };
> +	struct strbuf buf =3D STRBUF_INIT;
> +	kh_oid_map_t *replayed_commits;
> +	int ret;
> +
> +	replayed_commits =3D kh_init_oid_map();
> +

So this is used to the pass the replayed_commits list to the replay
mechanism so that the appropriate base commit is selected.

> +	init_basic_merge_options(&merge_opts, repo);
> +	merge_opts.show_rename_progress =3D 0;
> +
> +	for (size_t i =3D 0; i < commits->nr; i++) {
> +		struct object_id commit_id;
> +		struct commit *commit;
> +		const char *end;
> +		int hash_result;
> +		khint_t pos;
> +
> +		if (parse_oid_hex_algop(commits->v[i], &commit_id, &end,
> +					repo->hash_algo)) {
> +			ret =3D error(_("invalid object ID: %s"), commits->v[i]);
> +			goto out;
> +		}
> +
> +		commit =3D lookup_commit(repo, &commit_id);
> +		if (!commit || repo_parse_commit(repo, commit)) {
> +			ret =3D error(_("failed to look up commit: %s"), oid_to_hex(&commit_i=
d));
> +			goto out;
> +		}
> +
> +		if (!onto) {
> +			onto =3D commit;
> +			result.clean =3D 1;
> +			result.tree =3D repo_get_commit_tree(repo, commit);

So if there is no onto, we're starting at the root commit and expect a
clean merge.

> +		} else {
> +			onto =3D replay_pick_regular_commit(repo, commit, replayed_commits,
> +							  onto, &merge_opts, &result);
> +			if (!onto)
> +				break;

Else we will replay the current commit onto the prev 'onto' commit.

> +		}
> +
> +		pos =3D kh_put_oid_map(replayed_commits, commit->object.oid, &hash_res=
ult);
> +		if (hash_result =3D=3D 0) {
> +			ret =3D error(_("duplicate rewritten commit: %s\n"),
> +				    oid_to_hex(&commit->object.oid));
> +			goto out;
> +		}
> +		kh_value(replayed_commits, pos) =3D onto;
> +	}
> +
> +	if (!result.clean) {
> +		ret =3D error(_("could not merge"));
> +		goto out;
> +	}
> +
> +	reset_opts.oid =3D &onto->object.oid;
> +	strbuf_addf(&buf, "%s: switch to rewritten %s", action, oid_to_hex(rese=
t_opts.oid));
> +	reset_opts.flags =3D RESET_HEAD_REFS_ONLY | RESET_ORIG_HEAD;
> +	reset_opts.orig_head =3D &orig_head->object.oid;
> +	reset_opts.default_reflog_action =3D action;
> +	if (reset_head(repo, &reset_opts) < 0) {
> +		ret =3D error(_("could not switch to %s"), oid_to_hex(reset_opts.oid))=
;
> +		goto out;
> +	}
> +

We finally update the HEAD reference also.

> +	ret =3D 0;
> +
> +out:
> +	kh_destroy_oid_map(replayed_commits);
> +	merge_finalize(&merge_opts, &result);
> +	strbuf_release(&buf);
> +	return ret;
> +}
> +
> +static void change_data_free(void *util, const char *str UNUSED)
> +{
> +	struct wt_status_change_data *d =3D util;
> +	free(d->rename_source);
> +	free(d);
> +}
> +
> +static int fill_commit_message(struct repository *repo,
> +			       const struct object_id *old_tree,
> +			       const struct object_id *new_tree,
> +			       const char *default_message,
> +			       const char *provided_message,
> +			       const char *action,
> +			       struct strbuf *out)
> +{
> +	if (!provided_message) {
> +		const char *path =3D git_path_commit_editmsg();
> +		const char *hint =3D
> +			_("Please enter the commit message for the %s changes. Lines starting=
\n"
> +     "with '%s' will be kept; you may remove them yourself if you want t=
o.\n");

Shouldn't this be s/kept/removed? Also this line needs to be aligned.

> +		struct wt_status s;
> +
> +		strbuf_addstr(out, default_message);
> +		strbuf_addch(out, '\n');
> +		strbuf_commented_addf(out, comment_line_str, hint, action, comment_lin=
e_str);
> +		write_file_buf(path, out->buf, out->len);
> +
> +		wt_status_prepare(repo, &s);
> +		FREE_AND_NULL(s.branch);
> +		s.ahead_behind_flags =3D AHEAD_BEHIND_QUICK;
> +		s.commit_template =3D 1;
> +		s.colopts =3D 0;
> +		s.display_comment_prefix =3D 1;
> +		s.hints =3D 0;
> +		s.use_color =3D 0;
> +		s.whence =3D FROM_COMMIT;
> +		s.committable =3D 1;
> +
> +		s.fp =3D fopen(git_path_commit_editmsg(), "a");
> +		if (!s.fp)
> +			return error_errno(_("could not open '%s'"), git_path_commit_editmsg(=
));
> +
> +		wt_status_collect_changes_trees(&s, old_tree, new_tree);
> +		wt_status_print(&s);
> +		wt_status_collect_free_buffers(&s);
> +		string_list_clear_func(&s.change, change_data_free);
> +

Nice, so we show the user the diff tree and then ask them to modify the
existing message as they want.

> +		strbuf_reset(out);
> +		if (launch_editor(path, out, NULL)) {
> +			fprintf(stderr, _("Please supply the message using the -m option.\n")=
);
> +			return -1;
> +		}
> +		strbuf_stripspace(out, comment_line_str);
> +	} else {
> +		strbuf_addstr(out, provided_message);
> +	}
> +
> +	cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, 0);
> +
> +	if (!out->len) {
> +		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cmd_history_reword(int argc,
> +			      const char **argv,
> +			      const char *prefix,
> +			      struct repository *repo)
> +{
> +	const char * const usage[] =3D {

Same as the prev commit, this should be '*const'.

> +		N_("git history reword [<options>] <commit>"),
> +		NULL,
> +	};
> +	const char *commit_message =3D NULL;
> +	struct option options[] =3D {
> +		OPT_STRING('m', "message", &commit_message, N_("message"), N_("commit =
message")),
> +		OPT_END(),
> +	};
> +	struct strbuf final_message =3D STRBUF_INIT;
> +	struct commit *original_commit, *parent, *head;
> +	struct strvec commits =3D STRVEC_INIT;
> +	struct object_id parent_tree_oid, original_commit_tree_oid;
> +	struct object_id rewritten_commit;
> +	const char *original_message, *original_body, *ptr;
> +	char *original_author =3D NULL;
> +	size_t len;
> +	int ret;
> +
> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> +	if (argc !=3D 1) {
> +		ret =3D error(_("command expects a single revision"));
> +		goto out;
> +	}
> +	repo_config(repo, git_default_config, NULL);
> +

Right. We only expect something like 'git history reword @~10', so we
allow only one commit to be re-worded at a given time.

> +	original_commit =3D lookup_commit_reference_by_name(argv[0]);
> +	if (!original_commit) {
> +		ret =3D error(_("commit to be reworded cannot be found: %s"), argv[0])=
;
> +		goto out;
> +	}

So here we want to parse the commit-ish name to find the commit.

> +	if (repo_parse_commit(repo, original_commit)) {
> +		ret =3D error(_("unable to parse commit %s"),
> +			    oid_to_hex(&original_commit->object.oid));
> +		goto out;
> +	}

Isn't this already done as part of
`lookup_commit_reference_by_name_gently()` which is called by
`lookup_commit_reference_by_name()` ?

> +	original_commit_tree_oid =3D repo_get_commit_tree(repo, original_commit=
)->object.oid;
> +

Okay we get the tree of the commit, I assume this is used to create the
new commit and replay the children on top of it.

> +	parent =3D original_commit->parents ? original_commit->parents->item : =
NULL;
> +	if (parent) {
> +		if (repo_parse_commit(repo, parent)) {
> +			ret =3D error(_("unable to parse commit %s"),
> +				    oid_to_hex(&parent->object.oid));
> +			goto out;
> +		}
> +		parent_tree_oid =3D repo_get_commit_tree(repo, parent)->object.oid;
> +	} else {
> +		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
> +	}
> +
> +	head =3D lookup_commit_reference_by_name("HEAD");
> +	if (!head) {
> +		ret =3D error(_("could not resolve HEAD to a commit"));
> +		goto out;
> +	}
> +
> +	/*
> +	 * Collect the list of commits that we'll have to reapply now already.
> +	 * This ensures that we'll abort early on in case the range of commits
> +	 * contains merges, which we do not yet handle.
> +	 */
> +	ret =3D collect_commits(repo, parent, head, &commits);
> +	if (ret < 0)
> +		goto out;
> +

The user is currently at HEAD and wishes to reword a commit.

  PN ... P2 P1 C0 C1 ... CN
               =E2=94=94=E2=94=80(reword) =E2=94=94=E2=94=80(HEAD)

So we want to re-word C0, so we need to collect P1..CN.

> +	/* We retain authorship of the original commit. */
> +	original_message =3D repo_logmsg_reencode(repo, original_commit, NULL, =
NULL);
> +	ptr =3D find_commit_header(original_message, "author", &len);
> +	if (ptr)
> +		original_author =3D xmemdupz(ptr, len);
> +	find_commit_subject(original_message, &original_body);
> +
> +	ret =3D fill_commit_message(repo, &parent_tree_oid, &original_commit_tr=
ee_oid,
> +				  original_body, commit_message, "reworded", &final_message);
> +	if (ret < 0)
> +		goto out;

We obtain the new message from the user.

> +
> +	ret =3D commit_tree(final_message.buf, final_message.len,
> +			  &repo_get_commit_tree(repo, original_commit)->object.oid,

Can't we use original_commit_tree_oid here?

> +			  original_commit->parents, &rewritten_commit, original_author, NULL)=
;
> +	if (ret < 0) {
> +		ret =3D error(_("failed writing reworded commit"));
> +		goto out;
> +	}
> +
> +	replace_commits(&commits, &original_commit->object.oid, &rewritten_comm=
it, 1);
> +

Okay we replace the commits we obtained with the new rewritten commit.

> +	ret =3D apply_commits(repo, &commits, parent, head, "reword");
> +	if (ret < 0)
> +		goto out;
> +
> +	ret =3D 0;
> +

So we're now asking to replay the commits onto parent and update HEAD.
Looks good.

> +out:
> +	strbuf_release(&final_message);
> +	strvec_clear(&commits);
> +	free(original_author);
> +	return ret;
> +}
>
>  int cmd_history(int argc,
>  		const char **argv,
>  		const char *prefix,
> -		struct repository *repo UNUSED)
> +		struct repository *repo)
>  {
>  	const char * const usage[] =3D {
>  		N_("git history [<options>]"),
> +		N_("git history reword [<options>] <commit>"),

This string is used twice, perhaps we move it to a macro?

[snip]

The tests looked good too!

--000000000000bcb6ad06411c574f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fc29508b0fe2bd5c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdUxpUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMXpqQy80MzdOQjByOGlDWlVlbEdVVXd5Vmt3OGFNRwpaclAycUt5ZC9t
bkFzWUIzVTlOeUhZb3pqR3BrTitUSjIzd1hIdWt1d1BRQStsYnFjUHdGTjIzcnBiTVdPLzRICkNS
N1RwVGkyTnNmVWdxQ3pISlB5d21WY3BMWGl6KzhwTlRyR002UHJvZ0R2UnFXVDNzenY0bUhXOERK
ZjhseHgKN0tiTEFyelNLL25FbzNwdTV1L01Lb1ZDMFE5N3J6eU1lNmdtVG1QR29XcGt4OHNGNzRh
ZThNdTlZY1ZMaDdmbgpFVVVTeUZjODRreGxqUXVmS2Q5aU1vc3RLcFZYTGV6aHlnREtDZDJJMkpG
SE41Q2VpS2QxWE9Xb0tzMDA5S3FCCkc0L0JBZkUxVXg1TzFEcEtkQStoak1ncW93c0k5MWdDbzBC
M1A1U2ZCN2hPQ3VrOWQ0cHJwazkvcHFEYnJ6ejkKWXVMb2V1cXBxVlZxM240YjZIbHdpQk9wKzlt
MHVmY0cvZk0wSzB1Z25OWjB1eDhibVNWTi9CbXF2SE1jUGRMdQptby9sQkFGdTlXZUtpT1o2Wncz
bXNPSFIvQWFZdktMaUxpS0pPUVFoQ29NYzAvUmJYcFJJYjcxZGhoUGtxaHZhCmx0MUlWc2pEZEVn
alU3RUwycnhrS0NvbE5qVk1Od29iR2hYb3ZFRT0KPU1XdHQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bcb6ad06411c574f--
