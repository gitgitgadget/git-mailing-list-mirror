Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DFD1A295
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763128446; cv=none; b=Wc4pKN9xMty3c2jJqHK6wLWv6lOf5jV7j3pMfmkdqti0yUzIfjKgnaB87UJ7ixl3zyjukNeQXfr89Imj4HschBdd+g6eHIhZFhwXhvRVcmZD765i0Jks+ZMcLQoc8iFNrFS0CXshQb2XVmOX3b92STKd86p6/+Gea0Rm7AM6WcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763128446; c=relaxed/simple;
	bh=Nc9+W4rOpE9G0FcGDv+uEqpJlcs9cQgEJ8K6oscf6C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNhVvPtjSHJhUZSPSkWRTg6vOfC1FkgunVQvGIzXBNJw6uHRa8w4nI419QwrgOnt1Who65aXhdchhUD7EVH52NU91B5ILhep91ehN6LLBk4aW3gHzt362e0aw/x7SCs6gtb4eCmFciIiL3Hs6B0++t4wwqoKXMcI4RuKYehOm5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com; spf=pass smtp.mailfrom=eficode.com; dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b=Er8jyvM5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eficode.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b="Er8jyvM5"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7277324204so258939566b.0
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 05:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eficode.com; s=google; t=1763128442; x=1763733242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq0sipFWLVX3sSOJwQriap8qMtK5woYsmLvHAWNfN/w=;
        b=Er8jyvM5BoB3cKNPrqMT3FHFjHyU3TVBZoQ63yIQu95Pn/Q/C2dzoqFH+RZSiInRhP
         6ZTpIbTaIPi3LQY3/2+vXk1g+5b1bUJRK4BIAM+i69FXEAqC9E6s8L5pbzqwCs15xFjt
         mHrmPYWXvhj6d3EuwNjFrsyiPtT7Hh0+IkqhEUGl3HlPPjft1ZqRIGgASk/Xuu+oHf8n
         VLwEaTf6S5QJk6naRhXBp4690tA4a1iknYO8hLmoTnQ8DEmAggyFK7mCtqq0GStn5MNP
         LeUmJBGj4sXGseu/yplzczE99hYSRoMk8SQVBeVrhwQM0qqQYtX0W9l2fdf9eZFg7BF9
         pO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763128442; x=1763733242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qq0sipFWLVX3sSOJwQriap8qMtK5woYsmLvHAWNfN/w=;
        b=NIshp6HhUI6SvfzyvlSjAS2vu2QpxTY0DRe1OhqSJhNQcZ40fUjaF12nibXsX1H9ak
         rlrG7KWK+MLrNtypmkOG5ff3hgi3o5D3Xc+hCvcxLMw5pKWBlE4W+IiY0qCABizs+tWE
         GTdhdVvqQwER7C1JTUHvsvtmZj24Bu0z8PazYpS9YRqvxJqGa7wH27C59lDlXSJTyfkG
         34BU/k8qlPJ4E+d0jgKiPiCI4sogNSq+lG2AjNtD2817Maxvo+ugVIGJ+lDNjfYI0GIa
         72u/RFhyG60CnLkY7HMh6k4kp7S2vunylGBOAc9BqQDAe7HZRJ4R8OntbyW468E6Gvxx
         /xUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw/CrV4pVN/Ma2MH4oIKklnmPGPJ9/QymzRhS5DFPQ5KvLBAXQbd1oLHSAfSTisyEPWm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfiKWYyELk3yFFqho7H6pGgpWdvSzK+mUijAv/kjp35X1ahhES
	9+/xlDopwuT2uqil91mGpPE/jVM76BawNZtxr/xe1V7F33Obz/lR3UuOhz/jH52gqKW7JOYfIY/
	qEFArihao32w68qF18ZdvysM8eXo7oSqU/ivNGFFL
X-Gm-Gg: ASbGncsg5ZWhbv6mGjhFIeicsizHpChayI5NZT5lneWbmz1v9b5Egolw9PK0r1NPvkA
	/Iz/qaf0C/kT/BHLiOK92XgIqKPr4RzuNt0qmb2WleqiZeLGanx7i5Kb3ReZ+hgLQqHYai1y1Rb
	XwXON+PSPEzflLcMLGbfpW2I/VRI5mkyo7pKEwx2oC5WH9zj8k7tb4M0YghlgpPJw97jadZuves
	RQsPTvzCrqc5/ohjBux6Lt55Sai+bPM+CexZm08JyNBOFx9WTtCC/bYouk62BqWZaLbcX8baC50
	Uw8X2eW73t+UDFVdD5exmxvRsjE6pBiOCTo0Sn7YbyBixx0vGQTOHEPkKckLSat2bZY2rOs0tAP
	r54xdxgZwcX4UVTHyECNyFoWdnFNOn4bbsA5dFltyTpdt+g==
X-Google-Smtp-Source: AGHT+IHVTZf8LHQt1/D7gKZ/v7qXc6ZcicsvUs7h49zNmikby+Pd874UVQVUT+7Cc4Ep+HSq7rn8hdbTEOuGz9mddSE=
X-Received: by 2002:a17:906:280f:b0:b73:6b24:14ba with SMTP id
 a640c23a62f3a-b736b24b5c7mr145673166b.8.1763128441513; Fri, 14 Nov 2025
 05:54:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
 <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com> <xmqqzf8pln62.fsf@gitster.g>
In-Reply-To: <xmqqzf8pln62.fsf@gitster.g>
From: Claus Schneider <claus.schneider@eficode.com>
Date: Fri, 14 Nov 2025 14:53:50 +0100
X-Gm-Features: AWmQ_bm_kTLoUVLGUSIYzblNQNbDja13SBwrwlGi1QgSRbep-_RNe5kVqcd9nUQ
Message-ID: <CA+GP4bob2A+GsVUo5vy+Mw0qJHDD5g+pyo2Ka1726ouUuS_=Wg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] git-add : Respect submodule ignore=all and only
 add changes with --force
To: Junio C Hamano <gitster@pobox.com>
Cc: Claus Schneider via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Junio - well received and noted. I have updated the PR
description accordingly, but I have not changed the "--force" in the
description even though I have implemented
''--include-ignored-submodules' as Philip had the input not to use
"--force". He suggested using a new option. Philips comment:

> I'm not convinced that the approach of using "--force" is a good idea as
> it conflates ignoring changes to tracked paths (which is what
> submodule.<name>.ignore" does) with ignoring untracked paths (which is
> what ".gitignore" does). If we're happy to break existing uses that rely
> on the current behavior then having a new option to override
> submodule.<name>.ignore strikes me as a better way forward. I don't have
> much experience of using submodules so I can't comment on whether
> changing the behavior is a good idea or not.

I think it will be more simple to use the '--force' option though and
keep the amount of options lower and less to remember. Given your
comments about more usages of bytes for option also becomes obsolete
if we stick to "--force". I am happy to do so.

I am investigating your other comments on the patches in the meantime.

On Thu, Nov 13, 2025 at 8:58=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Claus Schneider via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > The feature of configuring a submodule to "ignore=3Dall" is nicely resp=
ected
> > in commands "status" and "diff".
>
> "nicely respected" is not very informative for those who do not know
> what the setting does.  Saying something like
>
>     "git status" and "git diff" will not report modified submodules
>     with submodule.<name>.ignore set to "all".
>
> would not waste significantly more bytes than what you wrote, and is
> more helpful.
>
> > However the "add" command does not respect
> > the configuration the same way.
>
> Again, "does not respect" and then what?  Running "git add" on a
> submodule with submodule.<name>.ignore set to "all" does what?
> Complains that it has changes but because .ignore is set it won't
> add?  Adds it silently?  Something else?
>
> > The behavior is problematic for the logic
> > between status/diff and add.
>
> After this sentence, "because ..." is missing.  Please help readers
> understand the issue you perceive as problematic more easily.
>
> I am guessing that you are assuming that an "add", after "diff" or
> "status" said there is no change, is expected to be a no-op, but I
> cannot be sure if that is what you are referring to here with the
> reason left unsaid like the above.
>
> > Secondly it makes it problematic to track
> > branches in the submodule configuration as developers unintentionally k=
eeps
> > add submodule updates and get conflicts for no intentional reason. Both=
 adds
> > unnecessary friction to the usage of submodules.
> >
> > The patches implement the same logical behavior for ignore=3Dall submod=
ules as
> > regular ignored files. The status now does not show any diff - nor will=
 the
> > add command update the reference submodule reference. If you add the
> > submodule path which is ignore=3Dall then you are presented with a mess=
age
> > that you need to use the --force option.
>
> I vaguely recall that an earlier discussion between you and Phillip
> were concluding against "--force"?  I personally feel it is in line
> with "git add foo.o" (when '*.o' is in .gitignore) gets rejected and
> "git add -f foo.o" is a way to override it, but in the list of
> patches below, I see --include-ignored-submodules (no, our command
> line option names do not use underscore for inter-word-gaps), so I
> suspect the description in the cover letter around here is stale?
>
>
> > The branch=3D, ignore=3Dall (and
> > update=3Dnone) now works great with update --remote,
>
> Again, "great" is not very informative, and as bad as "nicely
> respected".  Avoid using these adjectives loaded with unnecessary
> value judgements, and instead trust your readers.  They are
> intelligent to judge if the updated behaviour is great or not for
> themselves.  Try to use the same bytes on helping readers understand
> what actually happens.
>
> > but developers does not
>
> "do not".
>
> > have to consider changes in the updates of the submodule sha1. The
> > implementation removes a friction of working with submodules and can be=
 used
> > like the repo tool with branches configured. The submodule status repor=
t
> > could be used for build/release documentation for reproduction of a set=
up.
> >
> > A few tests used the adding of submodules without --force, hence they h=
ave
> > been updated to use the --force option.
> >
> > Claus Schneider(Eficode) (5):
> >   read-cache: update add_files_to_cache take param
> >     include_ignored_submodules
> >   read-cache: add/read-cache respect submodule ignore=3Dall
> >   tests: add new t2206-add-submodule-ignored.sh to test ignore=3Dall
> >     scenario
> >   tests: fix existing tests when add an ignore=3Dall submodule
> >   Documentation: add --include_ignored_submodules + ignore=3Dall config
> >
> >  .devcontainer/Dockerfile            |  70 +++++++++++++++
> >  .devcontainer/Dockerfile.standalone |  76 ++++++++++++++++
> >  .devcontainer/devcontainer.json     |  25 ++++++
> >  Documentation/config/submodule.adoc |  13 +--
> >  Documentation/git-add.adoc          |   5 ++
> >  Documentation/gitmodules.adoc       |   5 +-
> >  builtin/add.c                       |   4 +-
> >  builtin/checkout.c                  |   2 +-
> >  builtin/commit.c                    |   2 +-
> >  read-cache-ll.h                     |   2 +-
> >  read-cache.c                        |  54 ++++++++++-
> >  t/lib-submodule-update.sh           |   6 +-
> >  t/meson.build                       |   1 +
> >  t/t2206-add-submodule-ignored.sh    | 134 ++++++++++++++++++++++++++++
> >  t/t7508-status.sh                   |   2 +-
> >  15 files changed, 384 insertions(+), 17 deletions(-)
> >  create mode 100644 .devcontainer/Dockerfile
> >  create mode 100644 .devcontainer/Dockerfile.standalone
> >  create mode 100644 .devcontainer/devcontainer.json
> >  create mode 100755 t/t2206-add-submodule-ignored.sh
> >
> >
> > base-commit: 81f86aacc4eb74cdb9c2c8082d36d2070c666045
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1987%=
2FPraqma%2Frespect-submodule-ignore-v2
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1987/Pra=
qma/respect-submodule-ignore-v2
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1987
> >
> > Range-diff vs v1:
> >
> >  1:  d98cca698d ! 1:  5796009122 read-cache: update add_files_to_cache =
to take param ignored_too(--force)
> >      @@ Metadata
> >       Author: Claus Schneider(Eficode) <claus.schneider@eficode.com>
> >
> >        ## Commit message ##
> >      -    read-cache: update add_files_to_cache to take param ignored_t=
oo(--force)
> >      +    read-cache: update add_files_to_cache take param include_igno=
red_submodules
> >
> >      -    The ignored_too parameter is added to the function add_files_=
to_cache for
> >      -    usage of explicit updating the index for the updated submodul=
e using the
> >      -    explicit patchspec to the submodule.
> >      +    The include_ignored_submodules parameter is added to the func=
tion
> >      +    add_files_to_cache for usage of explicit updating the index f=
or the updated
> >      +    submodule using the explicit patchspec to the submodule.
> >
> >           Signed-off-by: Claus Schneider(Eficode) <claus.schneider@efic=
ode.com>
> >
> >        ## builtin/add.c ##
> >      +@@ builtin/add.c: N_("The following paths are ignored by one of y=
our .gitignore files:\n");
> >      + static int verbose, show_only, ignored_too, refresh_only;
> >      + static int ignore_add_errors, intent_to_add, ignore_missing;
> >      + static int warn_on_embedded_repo =3D 1;
> >      ++static int include_ignored_submodules;
> >      +
> >      + #define ADDREMOVE_DEFAULT 1
> >      + static int addremove =3D ADDREMOVE_DEFAULT;
> >      +@@ builtin/add.c: static struct option builtin_add_options[] =3D =
{
> >      +        OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("ju=
st skip files which cannot be added because of errors")),
> >      +        OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("chec=
k if - even missing - files are ignored in dry run")),
> >      +        OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating=
 entries outside of the sparse-checkout cone")),
> >      ++    OPT_BOOL(0, "include-ignored-submodules", &include_ignored_s=
ubmodules, N_("add submodules even if they has configuration ignore=3Dall")=
),
> >      +        OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
> >      +                   N_("override the executable bit of the listed =
files")),
> >      +        OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedde=
d_repo,
> >       @@ builtin/add.c: int cmd_add(int argc,
> >               else
> >                       exit_status |=3D add_files_to_cache(repo, prefix,
> >                                                         &pathspec, ps_m=
atched,
> >       -                                                 include_sparse,=
 flags);
> >      -+                                                 include_sparse,=
 flags, ignored_too);
> >      ++                                                 include_sparse,=
 flags, include_ignored_submodules);
> >
> >               if (take_worktree_changes && !add_renormalize && !ignore_=
add_errors &&
> >                   report_path_error(ps_matched, &pathspec))
> >      @@ read-cache.c: void overlay_tree_on_index(struct index_state *is=
tate,
> >               int include_sparse;
> >               int flags;
> >               int add_errors;
> >      -+       int ignored_too;
> >      ++       int include_ignored_submodules;
> >        };
> >
> >        static int fix_unmerged_status(struct diff_filepair *p,
> >       @@ read-cache.c: static void update_callback(struct diff_queue_st=
ruct *q,
> >      +                default:
> >      +                        die(_("unexpected diff status %c"), p->st=
atus);
> >      +                case DIFF_STATUS_MODIFIED:
> >      +-               case DIFF_STATUS_TYPE_CHANGED:
> >      ++               case DIFF_STATUS_TYPE_CHANGED: {
> >      ++                       struct stat st;
> >      ++                       if (!lstat(path, &st) && S_ISDIR(st.st_mo=
de)) { // only consider submodule if it is a directory
> >      ++                               const struct submodule *sub =3D s=
ubmodule_from_path(data->repo, null_oid(the_hash_algo), path);
> >      ++                               if (sub && sub->name && sub->igno=
re && !strcmp(sub->ignore, "all")) {
> >      ++                                       int pathspec_matches =3D =
0;
> >      ++                                       char *norm_pathspec =3D N=
ULL;
> >      ++                                       int ps_i;
> >      ++                                       trace_printf("ignore=3Dal=
l %s\n", path);
> >      ++                                       trace_printf("pathspec %s=
\n",
> >      ++                                                       (data->pa=
thspec && data->pathspec->nr) ? "has pathspec" : "no pathspec");
> >      ++                                       /* Safely scan all pathsp=
ec items (q->nr may exceed pathspec->nr). */
> >      ++                                       if (data->pathspec) {
> >      ++                                               for (ps_i =3D 0; =
ps_i < data->pathspec->nr; ps_i++) {
> >      ++                                                       const cha=
r *m =3D data->pathspec->items[ps_i].match;
> >      ++                                                       if (!m)
> >      ++                                                               c=
ontinue;
> >      ++                                                       norm_path=
spec =3D xstrdup(m);
> >      ++                                                       strip_dir=
_trailing_slashes(norm_pathspec);
> >      ++                                                       if (!strc=
mp(path, norm_pathspec)) {
> >      ++                                                               p=
athspec_matches =3D 1;
> >      ++                                                               F=
REE_AND_NULL(norm_pathspec);
> >      ++                                                               b=
reak;
> >      ++                                                       }
> >      ++                                                       FREE_AND_=
NULL(norm_pathspec);
> >      ++                                               }
> >      ++                                       }
> >      ++                                       if (pathspec_matches) {
> >      ++                                               if (data->include=
_ignored_submodules && data->include_ignored_submodules > 0) {
> >      ++                                                       trace_pri=
ntf("Add ignored=3Dall submodule due to --include_ignored_submodules: %s\n"=
, path);
> >      ++                                               } else {
> >      ++                                                       printf(_(=
"Skipping submodule due to ignore=3Dall: %s"), path);
> >      ++                                                       printf(_(=
"Use --include_ignored_submodules, if you really want to add them.") );
> >      ++                                                       continue;
> >      ++                                               }
> >      ++                                       } else {
> >      ++                                               /* No explicit pa=
thspec match -> skip silently (or with trace). */
> >      ++                                               trace_printf("pat=
hspec does not match %s\n", path);
> >      ++                                               continue;
> >      ++                                       }
> >      ++                               }
> >      ++                       }
> >      +                        if (add_file_to_index(data->index, path, =
data->flags)) {
> >      +                                if (!(data->flags & ADD_CACHE_IGN=
ORE_ERRORS))
> >      +                                        die(_("updating files fai=
led"));
> >      +@@ read-cache.c: static void update_callback(struct diff_queue_st=
ruct *q,
> >
> >        int add_files_to_cache(struct repository *repo, const char *pref=
ix,
> >                              const struct pathspec *pathspec, char *ps_=
matched,
> >       -                      int include_sparse, int flags)
> >      -+                      int include_sparse, int flags, int ignored=
_too )
> >      ++                      int include_sparse, int flags, int include=
_ignored_submodules )
> >        {
> >               struct update_callback_data data;
> >               struct rev_info rev;
> >      @@ read-cache.c: int add_files_to_cache(struct repository *repo, c=
onst char *prefix
> >               data.include_sparse =3D include_sparse;
> >               data.flags =3D flags;
> >       +       data.repo =3D repo;
> >      -+       data.ignored_too =3D ignored_too;
> >      ++       data.include_ignored_submodules =3D include_ignored_submo=
dules;
> >       +       data.pathspec =3D (struct pathspec *)pathspec;
> >
> >               repo_init_revisions(repo, &rev, prefix);
> >  2:  d1b02617e6 ! 2:  9ec79b9a11 read-cache: let read-cache respect sub=
module ignore=3Dall and --force
> >      @@ Metadata
> >       Author: Claus Schneider(Eficode) <claus.schneider@eficode.com>
> >
> >        ## Commit message ##
> >      -    read-cache: let read-cache respect submodule ignore=3Dall and=
 --force
> >      +    read-cache: add/read-cache respect submodule ignore=3Dall
> >
> >      -    Given the submdule configuration is ignore=3Dall then only up=
date the
> >      -    submdule if the --force option is given and the submodule is =
explicit
> >      -    given in the pathspec.
> >      +    Submodules configured with ignore=3Dall are now skipped durin=
g add operations
> >      +    unless overridden by --include-ignored-submodules and the sub=
module path is
> >      +    explicitly specified.
> >
> >           A message is printed (like ignored files) guiding the user to=
 use the
> >      -    --force flag if the user has explicitely want to update the s=
ubmodule
> >      -    reference.
> >      +    --include-ignored-submodules flag if the user has explicitely=
 want to update
> >      +    the submodule reference.
> >
> >           The reason for the change is support submodule branch trackin=
g or
> >           similar and git status state nothing and git add should not a=
dd either.
> >      @@ Commit message
> >           the submodule is already tracked.
> >
> >           The change opens up a lot of possibilities for submodules to =
be used
> >      -    more freely and a like the repo tool. A submodule can be adde=
d for many
> >      +    more freely and simular to the repo tool. A submodule can be =
added for many
> >           more reason and loosely coupled dependencies to the super rep=
o which often
> >           gives the friction of handle the explicit commits and updates=
 without
> >           the need for tracking the submodule sha1 by sha1.
> >      @@ read-cache.c
> >        /* Mask for the name length in ce_flags in the on-disk index */
> >
> >       @@ read-cache.c: static void update_callback(struct diff_queue_st=
ruct *q,
> >      -                default:
> >      -                        die(_("unexpected diff status %c"), p->st=
atus);
> >      -                case DIFF_STATUS_MODIFIED:
> >      --               case DIFF_STATUS_TYPE_CHANGED:
> >      -+               case DIFF_STATUS_TYPE_CHANGED: {
> >      -+                       struct stat st;
> >      -+                       if (!lstat(path, &st) && S_ISDIR(st.st_mo=
de)) { // only consider submodule if it is a directory
> >      -+                               const struct submodule *sub =3D s=
ubmodule_from_path(data->repo, null_oid(the_hash_algo), path);
> >      -+                               if (sub && sub->name && sub->igno=
re && !strcmp(sub->ignore, "all")) {
> >      -+                                       int pathspec_matches =3D =
0;
> >      -+                                       char *norm_pathspec =3D N=
ULL;
> >      -+                                       int ps_i;
> >      -+                                       trace_printf("ignore=3Dal=
l %s\n", path);
> >      -+                                       trace_printf("pathspec %s=
\n",
> >      -+                                                       (data->pa=
thspec && data->pathspec->nr) ? "has pathspec" : "no pathspec");
> >      -+                                       /* Safely scan all pathsp=
ec items (q->nr may exceed pathspec->nr). */
> >      -+                                       if (data->pathspec) {
> >      -+                                               for (ps_i =3D 0; =
ps_i < data->pathspec->nr; ps_i++) {
> >      -+                                                       const cha=
r *m =3D data->pathspec->items[ps_i].match;
> >      -+                                                       if (!m)
> >      -+                                                               c=
ontinue;
> >      -+                                                       norm_path=
spec =3D xstrdup(m);
> >      -+                                                       strip_dir=
_trailing_slashes(norm_pathspec);
> >      -+                                                       if (!strc=
mp(path, norm_pathspec)) {
> >      -+                                                               p=
athspec_matches =3D 1;
> >      -+                                                               F=
REE_AND_NULL(norm_pathspec);
> >      -+                                                               b=
reak;
> >      -+                                                       }
> >      -+                                                       FREE_AND_=
NULL(norm_pathspec);
> >      -+                                               }
> >      -+                                       }
> >      -+                                       if (pathspec_matches) {
> >      -+                                               if (data->ignored=
_too && data->ignored_too > 0) {
> >      -+                                                       trace_pri=
ntf("Forcing add of submodule ignored=3Dall due to --force: %s\n", path);
> >      -+                                               } else {
> >      -+                                                       printf(_(=
"Skipping submodule due to ignore=3Dall: %s"), path);
> >      -+                                                       printf(_(=
"Use -f if you really want to add them.") );
> >      -+                                                       continue;
> >      -+                                               }
> >      -+                                       } else {
> >      -+                                               /* No explicit pa=
thspec match -> skip silently (or with trace). */
> >      -+                                               trace_printf("pat=
hspec does not match %s\n", path);
> >      -+                                               continue;
> >      -+                                       }
> >      -+                               }
> >      -+                       }
> >      -                        if (add_file_to_index(data->index, path, =
data->flags)) {
> >      -                                if (!(data->flags & ADD_CACHE_IGN=
ORE_ERRORS))
> >      -                                        die(_("updating files fai=
led"));
> >      +                                        }
> >      +                                        if (pathspec_matches) {
> >      +                                                if (data->include=
_ignored_submodules && data->include_ignored_submodules > 0) {
> >      +-                                                       trace_pri=
ntf("Add ignored=3Dall submodule due to --include_ignored_submodules: %s\n"=
, path);
> >      ++                                                       trace_pri=
ntf("Add submodule due to --include_ignored_submodules: %s\n", path);
> >      +                                                } else {
> >      +                                                        printf(_(=
"Skipping submodule due to ignore=3Dall: %s"), path);
> >      +                                                        printf(_(=
"Use --include_ignored_submodules, if you really want to add them.") );
> >      +@@ read-cache.c: static void update_callback(struct diff_queue_st=
ruct *q,
> >      +                                                }
> >      +                                        } else {
> >      +                                                /* No explicit pa=
thspec match -> skip silently (or with trace). */
> >      +-                                               trace_printf("pat=
hspec does not match %s\n", path);
> >      ++                                               trace_printf("Pat=
hspec to submodule does not match explicitly: %s\n", path);
> >      +                                                continue;
> >      +                                        }
> >      +                                }
> >      +@@ read-cache.c: static void update_callback(struct diff_queue_st=
ruct *q,
> >                                       data->add_errors++;
> >                               }
> >                               break;
> >  3:  8f3d5f7ec1 ! 3:  399a153b95 tests: add new t2206-add-submodule-ign=
ored.sh to test ignore=3Dall scenario
> >      @@ Commit message
> >           config with ignore=3Dall also behaves as intended with config=
uration in
> >           .gitmodules and configuration given on the command line.
> >
> >      -    Testfile is added to meson.build for execution.
> >      +    The usage of --include_ignored_submodules is showcased and te=
sted in the
> >      +    test suite.
> >      +
> >      +    The test file is added to meson.build for execution.
> >
> >           Signed-off-by: Claus Schneider(Eficode) <claus.schneider@efic=
ode.com>
> >
> >      @@ t/t2206-add-submodule-ignored.sh (new)
> >       +# This test covers the behavior of "git add", "git status" and "=
git log" when
> >       +# dealing with submodules that have the ignore=3Dall setting in
> >       +# .gitmodules. It ensures that changes in such submodules are
> >      -+# ignored by default, but can be staged with "git add --force".
> >      ++# ignored by default, but can be staged with "git add --include-=
ignored-submodules".
> >       +
> >       +# shellcheck disable=3DSC1091
> >       +. ./test-lib.sh
> >      @@ t/t2206-add-submodule-ignored.sh (new)
> >       +'
> >       +
> >       +#6
> >      -+# check that 'git add --force .' does not stage the change in th=
e submodule
> >      ++# check that 'git add --include-ignored-submodules .' does not s=
tage the change in the submodule
> >       +# and that 'git status' does not show it as modified
> >      -+test_expect_success 'main: check --force add . and status'  '
> >      ++test_expect_success 'main: check --include-ignored-submodules ad=
d . and status'  '
> >       +       cd "${base_path}" &&
> >       +       cd main &&
> >      -+       GIT_TRACE=3D1 git add --force . &&
> >      ++       GIT_TRACE=3D1 git add --include-ignored-submodules . &&
> >       +       ! git status --porcelain | grep "^M  sub$" &&
> >       +       echo
> >       +'
> >      @@ t/t2206-add-submodule-ignored.sh (new)
> >       +'
> >       +
> >       +#8
> >      -+# check that 'git add --force sub' does stage the change in the =
submodule
> >      -+# check that 'git add --force ./sub/' does stage the change in t=
he submodule
> >      ++# check that 'git add --include-ignored-submodules sub' does sta=
ge the change in the submodule
> >      ++# check that 'git add --include-ignored-submodules ./sub/' does =
stage the change in the submodule
> >       +# and that 'git status --porcelain' does show it as modified
> >       +# commit it..
> >       +# check that 'git log --ignore-submodules=3Dnone' shows the subm=
odule change
> >      @@ t/t2206-add-submodule-ignored.sh (new)
> >       +test_expect_success 'main: check force add sub and ./sub/ and st=
atus'  '
> >       +       cd "${base_path}" &&
> >       +       cd main &&
> >      -+       echo "Adding with --force should work: git add --force su=
b" &&
> >      -+       GIT_TRACE=3D1 git add --force sub &&
> >      ++       echo "Adding with --include-ignored-submodules should wor=
k: git add --include-ignored-submodules sub" &&
> >      ++       GIT_TRACE=3D1 git add --include-ignored-submodules sub &&
> >       +       git status --porcelain | grep "^M  sub$" &&
> >       +       git restore --staged sub &&
> >       +       ! git status --porcelain | grep "^M  sub$" &&
> >      -+       echo "Adding with --force should work: git add --force ./=
sub/" &&
> >      -+       GIT_TRACE=3D1 git add --force ./sub/ &&
> >      ++       echo "Adding with --include-ignored-submodules should wor=
k: git add --include-ignored-submodules ./sub/" &&
> >      ++       GIT_TRACE=3D1 git add --include-ignored-submodules ./sub/=
 &&
> >       +       git status --porcelain | grep "^M  sub$" &&
> >       +       git commit -m "update submodule pointer" &&
> >       +       ! git status --porcelain | grep "^ M sub$" &&
> >  4:  58563a7b90 ! 4:  93c95954f1 tests: fix existing tests when add an =
ignore=3Dall submodule
> >      @@ Metadata
> >        ## Commit message ##
> >           tests: fix existing tests when add an ignore=3Dall submodule
> >
> >      -    There are tests that rely on "git add <submodule>" also adds =
it. A --force
> >      -    is needed with this enhancement hence they are added accordin=
gly in these
> >      -    tests.
> >      +    There are tests that rely on "git add <submodule>" to add upd=
ates in the
> >      +    parent repository. A new option --include-ignored-submodules =
is introduced
> >      +    as it is now needed with this enhancement.
> >
> >           Updated tests:
> >           - t1013-read-tree-submodule.sh ( fixed in: t/lib-submodule-up=
date.sh )
> >      +    - t2013-checkout-submodule.sh ( fixed in: t/lib-submodule-upd=
ate.sh )
> >           - t7406-submodule-update.sh
> >           - t7508-status.sh
> >
> >      @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
> >                               git push origin modifications
> >                       ) &&
> >       -               git add sub1 &&
> >      -+               git add --force sub1 &&
> >      ++               git add --include-ignored-submodules sub1 &&
> >                       git commit -m "Modify sub1" &&
> >
> >                       git checkout -b add_nested_sub modify_sub1 &&
> >      @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
> >                       git -C sub1 submodule add --branch no_submodule .=
./submodule_update_sub2 sub2 &&
> >                       git -C sub1 commit -a -m "add a nested submodule"=
 &&
> >       -               git add sub1 &&
> >      -+               git add --force sub1 &&
> >      ++               git add --include-ignored-submodules sub1 &&
> >                       git commit -a -m "update submodule, that updates =
a nested submodule" &&
> >                       git checkout -b modify_sub1_recursively &&
> >                       git -C sub1 checkout -b modify_sub1_recursively &=
&
> >      @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
> >                       git -C sub1 add sub2 &&
> >                       git -C sub1 commit -m "update nested sub" &&
> >       -               git add sub1 &&
> >      -+               git add --force sub1 &&
> >      ++               git add --include-ignored-submodules sub1 &&
> >                       git commit -m "update sub1, that updates nested s=
ub" &&
> >                       git -C sub1 push origin modify_sub1_recursively &=
&
> >                       git -C sub1/sub2 push origin modify_sub1_recursiv=
ely &&
> >      @@ t/t7508-status.sh: test_expect_success 'git commit will commit =
a staged but igno
> >        test_expect_success 'git commit --dry-run will show a staged but=
 ignored submodule' '
> >               git reset HEAD^ &&
> >       -       git add sm &&
> >      -+       git add --force sm &&
> >      ++       git add --include-ignored-submodules sm &&
> >               cat >expect << EOF &&
> >        On branch main
> >        Your branch and '\''upstream'\'' have diverged,
> >  5:  416695f439 < -:  ---------- Documentation: update add --force and =
submodule ignore=3Dall config
> >  -:  ---------- > 5:  ee84190cd8 Documentation: add --include_ignored_s=
ubmodules + ignore=3Dall config
