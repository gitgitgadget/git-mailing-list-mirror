Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3F221D92
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763622353; cv=none; b=I2XmqMW8ags/G6//HjvBvTgLDQvtOD7MElwqH6ZS71FpAyLFq8r+rdMQsGRckbdCkKsoQIDzFywwfNy7a89iK/ZidH1Hk6mUxOiWGL79STTDufoHSEm1xay7xV3I75g95vWVK8yzVxs/Z0OfbthOc38BKJWBqQI4QMal1avuNb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763622353; c=relaxed/simple;
	bh=LPqb4caHIdAAFe43aebKrDEXPbEOr/OzgIckqwvmnPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRfBLS/z3bIOiCXt8mhZ04UTETz5jBzlVKJ6cfUF6Ubp0FaNu/AOjKaX/9aP871F4CFXmVbgLSUv9NFaNXoc1PJtK5VtpUg+w1ojlognRMFXCkI63rXGOjt/nRHYY88rkBZnaVq2Aq6uCYtwATwDRg2e5nCo/gZseQuknCW1vl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c56pE8j3; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c56pE8j3"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-9490c862fcbso23227839f.2
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763622349; x=1764227149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/XacR1HlgYbKf7tgJ1Rrem4zkxYfRybbV8qUjmEIMs=;
        b=c56pE8j3y91vAs2OmFToMJ+JQRDHGe76iPevQjsR2si0hxB+5aQ99p61TQUCQP3KDv
         6Qu7cPw2qU21YzT7LPW7CrIaEg2hWIUMB7ZPrKVIc0XHW6MH1L24i9C0W1/2y/acFENk
         SajQ1C5YXhsXRAh7aOH0oVcghLkJKoDhMtkSzc1pRf7RWCkTJYao42za730o4ik5sPey
         yFagMGzPTMFDybTrqqAermXQGy/+yiQI74TH5QK5zruiZaGOR5O1v+PbUq2PW2fgIjby
         nVFjBvSOpExBmZOumhILTFhZYTitj71CH6PU832YyicYg2CHQmR1lOQmaQgG0ykIgzxO
         8UEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763622349; x=1764227149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i/XacR1HlgYbKf7tgJ1Rrem4zkxYfRybbV8qUjmEIMs=;
        b=P4oRJ6AXr1FCE2WaWz1EzpKlNYR2VxcTI2iluRat0X3UPKEDa7LVYgGMCeNovyPqpt
         4vESwJ74o4RUTKD+c6FUTyksiQbfI8dhaHRzeTEjii91u3Uo6HigMcTikQmIE5yBHx+y
         gnPC/YN08YwuZ1RV1JNtrGqkLFtNlS8SX6mKh61QR/KcRo/XFPGFXFUKRXyCyneq8ojP
         Q3DIdRzGgPrQN8B986lNPOvwbyzS+i7Pa8sgoBX4zAaCDmTf+EdQZMX8aO8GCY8YUKV/
         FZNfcG6iOb/98zpwXZIJGSnflWsXbyRi8WzsM4WrTnjOFzyl9KOb95AufMcDZh4RvA1m
         4xuw==
X-Gm-Message-State: AOJu0YyFC6ottc7Hdv+2yC1ITIHWag9TDVAXpheA37uwP2vrEHrCw5Ja
	ziMVHr/3tkJZKvftrTPsQ9Jlt409sQJK4RgKC88x42KhMw0uRcc0TFmSCVCv0j3qZ9B3dWawmnQ
	9O3fO50oBpbTUD90PQpmoFjGMYo02XUMJ1A==
X-Gm-Gg: ASbGncvB8m2/4sI5qim6gTL0Hz0xFwvXUMNPUF1Rt9RAdSP38l0uLlyba52mJVva7Tc
	deR+9yG7BdGA086fRD4tfd1WMbYT8KU7oV/PDwuIYnS2wOSpVKJj2Ly2jgSNcdobtoUUlX7xzq3
	hnoxc5rhC7YmRBT9iy+nj6qJf4ZwgbtmoV4Hap1BkYYH2BquV3erK22SYrLcODftSO8CzHpYf0q
	nket+3hfDudni/0x2RFIHZaFXOToq1yssRyqspv9AcNUaUfdr7rI/ZnwO9mpC/656AEo2dpxPXL
	bi3wsIWzYkJMLSCgGTvXMCvyfVrbTIVsosIM5RA=
X-Google-Smtp-Source: AGHT+IHaq9jtPofyBvCmOiHCzNOjMBchXRshBTspnSI4axOLw9i/GYnpGyOgLAXZaEHVNS6WJOH8MNtDSkr+v6dbDvc=
X-Received: by 2002:a05:6638:2415:b0:5b7:bccb:1fe5 with SMTP id
 8926c6da1cb9f-5b953fd4b79mr1806795173.1.1763622348897; Wed, 19 Nov 2025
 23:05:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im> <20251027-b4-pks-history-builtin-v6-11-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-11-407dd3f57ad3@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Nov 2025 23:05:37 -0800
X-Gm-Features: AWmQ_bm7Ev_ELdZTWAWBOZNhU8rrAbGfhA30yKPAUELGD-NcHcN1fGMlEIalR5k
Message-ID: <CABPp-BGP_BecoGf093MTK-FaXTc-B0SGRkH8SHkB39nAT5fb3Q@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] builtin/history: implement "split" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:34=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> It is quite a common use case that one wants to split up one commit into
> multiple commits by moving parts of the changes of the original commit
> out into a separate commit. This is quite an involved operation though:
>
>   1. Identify the commit in question that is to be dropped.
>
>   2. Perform an interactive rebase on top of that commit's parent.
>
>   3. Modify the instruction sheet to "edit" the commit that is to be
>      split up.
>
>   4. Drop the commit via "git reset HEAD~".
>
>   5. Stage changes that should go into the first commit and commit it.
>
>   6. Stage changes that should go into the second commit and commit it.
>
>   7. Finalize the rebase.
>
> This is quite complex, and overall I would claim that most people who
> are not experts in Git would struggle with this flow.
>
> Introduce a new "split" subcommand for git-history(1) to make this way
> easier. All the user needs to do is to say `git history split $COMMIT`.
> From hereon, Git asks the user which parts of the commit shall be moved
> out into a separate commit and, once done, asks the user for the commit
> message. Git then creates that split-out commit and applies the original
> commit on top of it.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-history.adoc |  62 ++++++
>  builtin/history.c              | 218 +++++++++++++++++++++
>  t/meson.build                  |   1 +
>  t/t3452-history-split.sh       | 432 +++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 713 insertions(+)
>
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.a=
doc
> index bd903875120..3d6b2665f8d 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -9,6 +9,7 @@ SYNOPSIS
>  --------
>  [synopsis]
>  git history reword <commit>
> +git history split <commit> [--] [<pathspec>...]
>
>  DESCRIPTION
>  -----------
> @@ -37,6 +38,26 @@ Several commands are available to rewrite history in d=
ifferent ways:
>         details of this commit remain unchanged. This command will spawn =
an
>         editor with the current message of that commit.
>
> +`split <commit> [--] [<pathspec>...]`::
> +       Interactively split up <commit> into two commits by choosing
> +       hunks introduced by it that will be moved into the new split-out
> +       commit. These hunks will then be written into a new commit that
> +       becomes the parent of the previous commit. The original commit
> +       stays intact, except that its parent will be the newly split-out
> +       commit.

Always two?  Should we allow someone to split into three or four?

> ++
> +The commit message of the new commit will be asked for by launching the
> +configured editor. Authorship of the commit will be the same as for the
> +original commit.

Which one is the new one?  Aren't they both?

> ++
> +If passed, _<pathspec>_ can be used to limit which changes shall be spli=
t out
> +of the original commit. Files not matching any of the pathspecs will rem=
ain
> +part of the original commit. For more details, see the 'pathspec' entry =
in
> +linkgit:gitglossary[7].
> ++
> +It is invalid to select either all or no hunks, as that would lead to
> +one of the commits becoming empty.

If the user edits a hunk, what happens then?  Is this function
prepared to deal with that?

> +
>  CONFIGURATION
>  -------------
>
> @@ -44,6 +65,47 @@ include::includes/cmd-config-section-all.adoc[]
>
>  include::config/sequencer.adoc[]
>
> +EXAMPLES
> +--------
> +
> +Split a commit
> +~~~~~~~~~~~~~~
> +
> +----------
> +$ git log --stat --oneline
> +3f81232 (HEAD -> main) original
> + bar | 1 +
> + foo | 1 +
> + 2 files changed, 2 insertions(+)
> +
> +$ git history split HEAD
> +diff --git a/bar b/bar
> +new file mode 100644
> +index 0000000..5716ca5
> +--- /dev/null
> ++++ b/bar
> +@@ -0,0 +1 @@
> ++bar
> +(1/1) Stage addition [y,n,q,a,d,e,p,?]? y
> +
> +diff --git a/foo b/foo
> +new file mode 100644
> +index 0000000..257cc56
> +--- /dev/null
> ++++ b/foo
> +@@ -0,0 +1 @@
> ++foo
> +(1/1) Stage addition [y,n,q,a,d,e,p,?]? n
> +
> +$ git log --stat --oneline
> +7cebe64 (HEAD -> main) original
> + foo | 1 +
> + 1 file changed, 1 insertion(+)
> +d1582f3 split-out commit
> + bar | 1 +
> + 1 file changed, 1 insertion(+)
> +----------
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/builtin/history.c b/builtin/history.c
> index cb251ae2e01..cae841707d0 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -1,6 +1,7 @@
>  #define USE_THE_REPOSITORY_VARIABLE
>
>  #include "builtin.h"
> +#include "cache-tree.h"
>  #include "commit-reach.h"
>  #include "commit.h"
>  #include "config.h"
> @@ -8,17 +9,22 @@
>  #include "environment.h"
>  #include "gettext.h"
>  #include "hex.h"
> +#include "oidmap.h"
>  #include "parse-options.h"
> +#include "path.h"
> +#include "read-cache.h"
>  #include "refs.h"
>  #include "replay.h"
>  #include "reset.h"
>  #include "revision.h"
> +#include "run-command.h"
>  #include "sequencer.h"
>  #include "strvec.h"
>  #include "tree.h"
>  #include "wt-status.h"
>
>  #define GIT_HISTORY_REWORD_USAGE N_("git history reword <commit>")
> +#define GIT_HISTORY_SPLIT_USAGE  N_("git history split <commit> [--] [<p=
athspec>...]")
>
>  static int collect_commits(struct repository *repo,
>                            struct commit *old_commit,
> @@ -323,6 +329,216 @@ static int cmd_history_reword(int argc,
>         return ret;
>  }
>
> +static int split_commit(struct repository *repo,
> +                       struct commit *original_commit,
> +                       struct pathspec *pathspec,
> +                       struct object_id *out)
> +{
> +       struct interactive_options interactive_opts =3D INTERACTIVE_OPTIO=
NS_INIT;
> +       struct strbuf index_file =3D STRBUF_INIT, split_message =3D STRBU=
F_INIT;
> +       struct child_process read_tree_cmd =3D CHILD_PROCESS_INIT;
> +       struct index_state index =3D INDEX_STATE_INIT(repo);
> +       struct object_id original_commit_tree_oid, parent_tree_oid;
> +       const char *original_message, *original_body, *ptr;
> +       char original_commit_oid[GIT_MAX_HEXSZ + 1];
> +       char *original_author =3D NULL;
> +       struct commit_list *parents =3D NULL;
> +       struct commit *first_commit;
> +       struct tree *split_tree;
> +       size_t len;
> +       int ret;
> +
> +       if (original_commit->parents)
> +               parent_tree_oid =3D *get_commit_tree_oid(original_commit-=
>parents->item);
> +       else
> +               oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
> +       original_commit_tree_oid =3D *get_commit_tree_oid(original_commit=
);
> +
> +       /*
> +       * Construct the first commit. This is done by taking the original
> +       * commit parent's tree and selectively patching changes from the =
diff
> +       * between that parent and its child.
> +       */
> +       repo_git_path_replace(repo, &index_file, "%s", "history-split.ind=
ex");
> +
> +       read_tree_cmd.git_cmd =3D 1;
> +       strvec_pushf(&read_tree_cmd.env, "GIT_INDEX_FILE=3D%s", index_fil=
e.buf);
> +       strvec_push(&read_tree_cmd.args, "read-tree");
> +       strvec_push(&read_tree_cmd.args, oid_to_hex(&parent_tree_oid));
> +       ret =3D run_command(&read_tree_cmd);
> +       if (ret < 0)
> +               goto out;
> +
> +       ret =3D read_index_from(&index, index_file.buf, repo->gitdir);
> +       if (ret < 0) {
> +               ret =3D error(_("failed reading temporary index"));
> +               goto out;
> +       }
> +
> +       oid_to_hex_r(original_commit_oid, &original_commit->object.oid);
> +       ret =3D run_add_p_index(repo, &index, index_file.buf, &interactiv=
e_opts,
> +                             original_commit_oid, pathspec);
> +       if (ret < 0)
> +               goto out;
> +
> +       split_tree =3D write_in_core_index_as_tree(repo, &index);
> +       if (!split_tree) {
> +               ret =3D error(_("failed split tree"));
> +               goto out;
> +       }
> +
> +       unlink(index_file.buf);
> +
> +       /*
> +       * We disallow the cases where either the split-out commit or the
> +       * original commit would become empty. Consequently, if we see tha=
t the
> +       * new tree ID matches either of those trees we abort.
> +       */
> +       if (oideq(&split_tree->object.oid, &parent_tree_oid)) {
> +               ret =3D error(_("split commit is empty"));
> +               goto out;
> +       } else if (oideq(&split_tree->object.oid, &original_commit_tree_o=
id)) {
> +               ret =3D error(_("split commit tree matches original commi=
t"));
> +               goto out;
> +       }
> +
> +       /* We retain authorship of the original commit. */
> +       original_message =3D repo_logmsg_reencode(repo, original_commit, =
NULL, NULL);
> +       ptr =3D find_commit_header(original_message, "author", &len);
> +       if (ptr)
> +               original_author =3D xmemdupz(ptr, len);
> +
> +       ret =3D fill_commit_message(repo, &parent_tree_oid, &split_tree->=
object.oid,
> +                                 "", "split-out", &split_message);
> +       if (ret < 0)
> +               goto out;
> +
> +       ret =3D commit_tree(split_message.buf, split_message.len, &split_=
tree->object.oid,
> +                         original_commit->parents, &out[0], original_aut=
hor, NULL);

As with reword, you are discarding all extended headers?

> +       if (ret < 0) {
> +               ret =3D error(_("failed writing split-out commit"));
> +               goto out;
> +       }
> +
> +       /*
> +       * The second commit is much simpler to construct, as we can simpl=
y use
> +       * the original commit details, except that we adjust its parent t=
o be
> +       * the newly split-out commit.
> +       */
> +       find_commit_subject(original_message, &original_body);
> +       first_commit =3D lookup_commit_reference(repo, &out[0]);
> +       commit_list_append(first_commit, &parents);
> +
> +       ret =3D commit_tree(original_body, strlen(original_body), &origin=
al_commit_tree_oid,
> +                         parents, &out[1], original_author, NULL);

I don't understand why the second commit is the one that is to retain
the commit message.  I can see that users would sometimes want that,
but I don't see why it'd be hardcoded.

> +       if (ret < 0) {
> +               ret =3D error(_("failed writing second commit"));
> +               goto out;
> +       }
> +
> +       ret =3D 0;
> +
> +out:
> +       if (index_file.len)
> +               unlink(index_file.buf);
> +       strbuf_release(&split_message);
> +       strbuf_release(&index_file);
> +       free_commit_list(parents);
> +       free(original_author);
> +       release_index(&index);
> +       return ret;
> +}
> +
> +static int cmd_history_split(int argc,
> +                            const char **argv,
> +                            const char *prefix,
> +                            struct repository *repo)
> +{
> +       const char * const usage[] =3D {
> +               GIT_HISTORY_SPLIT_USAGE,
> +               NULL,
> +       };
> +       struct option options[] =3D {
> +               OPT_END(),
> +       };
> +       struct oidmap rewritten_commits =3D OIDMAP_INIT;
> +       struct commit *original_commit, *parent, *head;
> +       struct strvec commits =3D STRVEC_INIT;
> +       struct commit_list *from_list =3D NULL;
> +       struct object_id split_commits[2];
> +       struct pathspec pathspec =3D { 0 };
> +       int ret;
> +
> +       argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> +       if (argc < 1) {
> +               ret =3D error(_("command expects a revision"));
> +               goto out;
> +       }
> +       repo_config(repo, git_default_config, NULL);
> +
> +       original_commit =3D lookup_commit_reference_by_name(argv[0]);
> +       if (!original_commit) {
> +               ret =3D error(_("commit to be split cannot be found: %s")=
, argv[0]);
> +               goto out;
> +       }
> +
> +       parent =3D original_commit->parents ? original_commit->parents->i=
tem : NULL;
> +       if (parent && repo_parse_commit(repo, parent)) {
> +               ret =3D error(_("unable to parse commit %s"),
> +                           oid_to_hex(&parent->object.oid));
> +               goto out;
> +       }
> +
> +       head =3D lookup_commit_reference_by_name("HEAD");
> +       if (!head) {
> +               ret =3D error(_("could not resolve HEAD to a commit"));
> +               goto out;
> +       }
> +
> +       commit_list_append(original_commit, &from_list);
> +       if (!repo_is_descendant_of(repo, head, from_list)) {
> +               ret =3D error(_("split commit must be reachable from curr=
ent HEAD commit"));
> +               goto out;
> +       }

Again, I don't see why the commit to be split needs to be an ancestor
of HEAD; seems like an arbitrary requirement.

> +
> +       parse_pathspec(&pathspec, 0,
> +               PATHSPEC_PREFER_FULL | PATHSPEC_SYMLINK_LEADING_PATH | PA=
THSPEC_PREFIX_ORIGIN,
> +               prefix, argv + 1);
> +
> +       /*
> +        * Collect the list of commits that we'll have to reapply now alr=
eady.
> +        * This ensures that we'll abort early on in case the range of co=
mmits
> +        * contains merges, which we do not yet handle.
> +        */
> +       ret =3D collect_commits(repo, parent, head, &commits);
> +       if (ret < 0)
> +               goto out;
> +
> +       /*
> +        * Then we split up the commit and replace the original commit wi=
th the
> +        * new ones.
> +        */
> +       ret =3D split_commit(repo, original_commit, &pathspec, split_comm=
its);
> +       if (ret < 0)
> +               goto out;
> +
> +       replace_commits(&commits, &original_commit->object.oid,
> +                       split_commits, ARRAY_SIZE(split_commits));
> +
> +       ret =3D apply_commits(repo, &commits, parent, head, "split");
> +       if (ret < 0)
> +               goto out;

Much like with "reword", I think we could drop your auxiliary
functions (collect_commits(), replace_commits(), apply_commits()),
since replay already handles revision walking.

However, unlike with "reword" you've got a slight mess here.  If the
user edits the hunk to be applied, then (1) the rest of the replayed
commits may have conflicts (which replay doesn't handle yet), and (2)
after replaying you'll need to reset your working tree and index to
match the rebased result, which will be tricky if you had either
staged or unstaged modifications.

> +
> +       ret =3D 0;
> +
> +out:
> +       oidmap_clear(&rewritten_commits, 0);
> +       free_commit_list(from_list);
> +       clear_pathspec(&pathspec);
> +       strvec_clear(&commits);
> +       return ret;
> +}
> +
>  int cmd_history(int argc,
>                 const char **argv,
>                 const char *prefix,
> @@ -330,11 +546,13 @@ int cmd_history(int argc,
>  {
>         const char * const usage[] =3D {
>                 GIT_HISTORY_REWORD_USAGE,
> +               GIT_HISTORY_SPLIT_USAGE,
>                 NULL,
>         };
>         parse_opt_subcommand_fn *fn =3D NULL;
>         struct option options[] =3D {
>                 OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
> +               OPT_SUBCOMMAND("split", &fn, cmd_history_split),
>                 OPT_END(),
>         };
>
> diff --git a/t/meson.build b/t/meson.build
> index a3ec9199947..5d3014a768f 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -386,6 +386,7 @@ integration_tests =3D [
>    't3438-rebase-broken-files.sh',
>    't3450-history.sh',
>    't3451-history-reword.sh',
> +  't3452-history-split.sh',
>    't3500-cherry.sh',
>    't3501-revert-cherry-pick.sh',
>    't3502-cherry-pick-merge.sh',
> diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
> new file mode 100755
> index 00000000000..2aac28afdf0
> --- /dev/null
> +++ b/t/t3452-history-split.sh
> @@ -0,0 +1,432 @@
> +#!/bin/sh
> +
> +test_description=3D'tests for git-history split subcommand'
> +
> +. ./test-lib.sh
> +
> +set_fake_editor () {
> +       write_script fake-editor.sh <<-EOF &&
> +       echo "$@" >"\$1"
> +       EOF
> +       test_set_editor "$(pwd)"/fake-editor.sh
> +}
> +
> +expect_log () {
> +       git log --format=3D"%s" >actual &&
> +       cat >expect &&
> +       test_cmp expect actual
> +}
> +
> +expect_tree_entries () {
> +       git ls-tree --name-only "$1" >actual &&
> +       cat >expect &&
> +       test_cmp expect actual
> +}
> +
> +test_expect_success 'refuses to work with merge commits' '
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
> +               test_must_fail git history split HEAD 2>err &&
> +               test_grep "cannot rearrange commit history with merges" e=
rr &&
> +               test_must_fail git history split HEAD~ 2>err &&
> +               test_grep "cannot rearrange commit history with merges" e=
rr
> +       )
> +'
> +
> +test_expect_success 'refuses to work with unrelated commits' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               git branch branch &&
> +               test_commit ours &&
> +               git switch branch &&
> +               test_commit theirs &&
> +               test_must_fail git history split ours 2>err &&
> +               test_grep "split commit must be reachable from current HE=
AD commit" err
> +       )
> +'

I don't understand why this test is desirable.  I guess that's not
surprising given that I called into question why you'd want this to be
an error in the relevant code.

> +test_expect_success 'can split up tip commit' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               git symbolic-ref HEAD >expect &&
> +               set_fake_editor "split-out commit" &&
> +               git history split HEAD <<-EOF &&
> +               y
> +               n
> +               EOF
> +               git symbolic-ref HEAD >actual &&
> +               test_cmp expect actual &&
> +
> +               expect_log <<-EOF &&
> +               split-me
> +               split-out commit
> +               initial
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               bar
> +               initial.t
> +               EOF
> +
> +               expect_tree_entries HEAD <<-EOF
> +               bar
> +               foo
> +               initial.t
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can split up root commit' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m root &&
> +               test_commit tip &&
> +
> +               set_fake_editor "split-out commit" &&
> +               git history split HEAD~ <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               expect_log <<-EOF &&
> +               tip
> +               root
> +               split-out commit
> +               EOF
> +
> +               expect_tree_entries HEAD~2 <<-EOF &&
> +               bar
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               bar
> +               foo
> +               EOF
> +
> +               expect_tree_entries HEAD <<-EOF
> +               bar
> +               foo
> +               tip.t
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can split up in-between commit' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +               test_commit tip &&
> +
> +               set_fake_editor "split-out commit" &&
> +               git history split HEAD~ <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               expect_log <<-EOF &&
> +               tip
> +               split-me
> +               split-out commit
> +               initial
> +               EOF
> +
> +               expect_tree_entries HEAD~2 <<-EOF &&
> +               bar
> +               initial.t
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               bar
> +               foo
> +               initial.t
> +               EOF
> +
> +               expect_tree_entries HEAD <<-EOF
> +               bar
> +               foo
> +               initial.t
> +               tip.t
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can pick multiple hunks' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar baz foo qux &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               set_fake_editor "split-out-commit" &&
> +               git history split HEAD <<-EOF &&
> +               y
> +               n
> +               y
> +               n
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               bar
> +               foo
> +               EOF
> +
> +               expect_tree_entries HEAD <<-EOF
> +               bar
> +               baz
> +               foo
> +               qux
> +               EOF
> +       )
> +'
> +
> +
> +test_expect_success 'can use only last hunk' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               set_fake_editor "split-out commit" &&
> +               git history split HEAD <<-EOF &&
> +               n
> +               y
> +               EOF
> +
> +               expect_log <<-EOF &&
> +               split-me
> +               split-out commit
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               foo
> +               EOF
> +
> +               expect_tree_entries HEAD <<-EOF
> +               bar
> +               foo
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'aborts with empty commit message' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               set_fake_editor "" &&
> +               test_must_fail git history split HEAD <<-EOF 2>err &&
> +               y
> +               n
> +               EOF
> +               test_grep "Aborting commit due to empty commit message." =
err
> +       )
> +'
> +
> +test_expect_success 'commit message editor sees split-out changes' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               write_script fake-editor.sh <<-\EOF &&
> +               cp "$1" . &&
> +               echo "some commit message" >>"$1"
> +               EOF
> +               test_set_editor "$(pwd)"/fake-editor.sh &&
> +
> +               git history split HEAD <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               cat >expect <<-EOF &&
> +
> +               # Please enter the commit message for the split-out chang=
es. Lines starting
> +               # with ${SQ}#${SQ} will be ignored.
> +               # Changes to be committed:
> +               #       new file:   bar
> +               #
> +               EOF
> +               test_cmp expect COMMIT_EDITMSG &&
> +
> +               expect_log <<-EOF
> +               split-me
> +               some commit message
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'can use pathspec to limit what gets split' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               set_fake_editor "split-out commit" &&
> +               git history split HEAD -- foo <<-EOF &&
> +               y
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               foo
> +               EOF
> +
> +               expect_tree_entries HEAD <<-EOF
> +               bar
> +               foo
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'refuses to create empty split-out commit' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit base &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               test_must_fail git history split HEAD 2>err <<-EOF &&
> +               n
> +               n
> +               EOF
> +               test_grep "split commit is empty" err
> +       )
> +'
> +
> +test_expect_success 'hooks are executed for rewritten commits' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +               old_head=3D$(git rev-parse HEAD) &&
> +
> +               write_script .git/hooks/prepare-commit-msg <<-EOF &&
> +               touch "$(pwd)/hooks.log"
> +               EOF
> +               write_script .git/hooks/post-commit <<-EOF &&
> +               touch "$(pwd)/hooks.log"
> +               EOF
> +               write_script .git/hooks/post-rewrite <<-EOF &&
> +               touch "$(pwd)/hooks.log"
> +               EOF
> +
> +               set_fake_editor "split-out commit" &&
> +               git history split HEAD <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               expect_log <<-EOF &&
> +               split-me
> +               split-out commit
> +               EOF
> +
> +               test_path_is_missing hooks.log
> +       )
> +'

`test_path_is_missing hooks.log` suggests the hooks are NOT executed
for rewritten commits; your cover letter and documentation said hooks
wouldn't run either, so I'm guessing the test description is the bug
here left over from an earlier round?

> +test_expect_success 'refuses to create empty original commit' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               touch bar foo &&
> +               git add . &&
> +               git commit -m split-me &&
> +
> +               test_must_fail git history split HEAD 2>err <<-EOF &&
> +               y
> +               y
> +               EOF
> +               test_grep "split commit tree matches original commit" err
> +       )
> +'
> +
> +test_expect_success 'retains changes in the worktree and index' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               echo a >a &&
> +               echo b >b &&
> +               git add . &&
> +               git commit -m "initial commit" &&
> +               echo a-modified >a &&
> +               echo b-modified >b &&
> +               git add b &&
> +               set_fake_editor "a-only" &&
> +               git history split HEAD <<-EOF &&
> +               y
> +               n
> +               EOF
> +
> +               expect_tree_entries HEAD~ <<-EOF &&
> +               a
> +               EOF
> +               expect_tree_entries HEAD <<-EOF &&
> +               a
> +               b
> +               EOF
> +
> +               cat >expect <<-\EOF &&
> +                M a
> +               M  b
> +               ?? actual
> +               ?? expect
> +               ?? fake-editor.sh
> +               EOF
> +               git status --porcelain >actual &&
> +               test_cmp expect actual
> +       )
> +'

...but does this test mean we need to prevent users from editing hunks
when splitting commits?  If we don't, how can we retain changes in the
worktree and index?
