Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6E6256D
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 02:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749004663; cv=none; b=YSH65JUAu89J9zjupOXg681xxysmmT4COYM22OZvizNQcEmAoK9kZB+JUApIrRjVfbhTOBEDLxwkEVwQ3ob85plcBU9/Pp5vRBK8RzJRu+90jC/HL1gEPaDt6dJR05Lu5DldkpDgto8Wtfa/AHDjU5QTbJrKa86HPUMt1ZbPF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749004663; c=relaxed/simple;
	bh=3SvxlHLXVjyFsFA4Sv+ys7jkqv7zmuyM8nF+W3m6HyQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=SUlVAVc1t9BzQBMJeIGAgQSj3+0IWy6QHi8Zk2utwKb8oosZgaY8miupgMw8b7kpZvNgyB56Rc4HozSYuCOkrnZD2EAqSNN/W73HfXL38Cr5LHeQZUSpaVmYI5JTGP15BsIjkhV4/hcoBAH0AvyPq7b9WEZNfg3FdRDS7jaddFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lccZgzyj; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lccZgzyj"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e2b601a6bso58745817b3.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 19:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749004660; x=1749609460; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fX2OnEQl6O6qp3O8bKRFVZrUyy6hOhWY3Rk0bijPr8=;
        b=lccZgzyjLR6Ou19JjBkZUWMUkLyYtgXat+LSX0T+o8mUrlEFYwhp2GWBxZH8a3qVOY
         gPNDHhnRxqydCiR0L1H7HTvJ2OojiIEMWT8iKPw8DMukSarrzN5jNaFW6MW3PYdS//Aw
         4bZDlP8r7jzwErsUP820g4yk1tDO4rKySmTGact6UNpI27F37A8u4KMM+32k0pRJ0Eba
         A1cbFo9QG5FT9Hl5jxA5mQ+iGhmfTDX+KWEVIkSh0nHIwv9gnrxrRABP4tlfI+AqmKm0
         +7+2kycdvRjL6vW7Zc+n2IhqXkcdGiSSMwDB+HjWWo7sbcrfTcYTtTDzkLM4MLbjSmnj
         W7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749004660; x=1749609460;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4fX2OnEQl6O6qp3O8bKRFVZrUyy6hOhWY3Rk0bijPr8=;
        b=lyel57WH533xwCaSeFERJGdCbx6NsQAmVhHUciYPH1i22Nf4rNGG5zFp2YlzzfAkgW
         a/TFH5jrrPSk0B+qco78W8vmLHkwR14kgKFU9JvsqWLII40xHFFR3AaxrFkm6awqvD/k
         4+qoXbEWm4trzhOoGCtUhchfSxK3MIn8wBVyTVKwBxszf2ty2a2W+GXM70Tte8lQKaI+
         Awh0XeMsS7/SmoAr9GzM/LM38IJUZIpo8M3TKEZRhrawIdM5GIcQNcjR9UsVgsVPk9L1
         KCLVJUm7MEfN2CwmLcZ1NxThjQ322Vi36gDL5zp+4+6icrleKqVeEnrCFwz45N1F8uU9
         fPTA==
X-Gm-Message-State: AOJu0Yzc0D5ANT8qWUzK0S5Nv4IoDmYGXs9xujOVw1lzBmAiXH+Xh8No
	f05IGf8rP2oP7rFF6eMDKlQkKKyHBPYoG8phqVzhYFSMqBVy86P18FvAuqH/RqJv
X-Gm-Gg: ASbGncv83/xBiF/NsMCzwZMaLWwTVpXMex+51SgFcmH5d383kC8dcA7Ju2Brudui6xN
	ILAw6ZHWEGl8IEf62r1JzzKhZIKLx+qF48IaA3uTouRe9eDYqgA/VLXj+tiO/okGMnDmyVRyHFR
	wJ7rKoJ6FxTdg0J0N3Wlhy5bfTOBZO+B8h1DhhebZorzDSKQ/UZQso4qo88tFDTnpOC+mSCx8xm
	1TMoxUx1bCEGO5QvtgkwmKfcBuoUZFaXYOC8MnEkuZupJWh0UrnJ2834VogPJMidXljLing4PVs
	YslCorVPxerSMo54mLFQ81rwzHI/srDig7KfLkEXbKV9DsgXOs9gOmay3+8OKuWt8CQ0kh8P5F8
	PBb84
X-Google-Smtp-Source: AGHT+IGRwxTu3OrZq3erIyPjPhWW7WbynYA1doAWdAQe4RH+URQ02onlasp2awrGF71NXa8bB3aj2Q==
X-Received: by 2002:a05:690c:62c7:b0:703:b47a:72f9 with SMTP id 00721157ae682-710d99a1ad4mr14233017b3.3.1749004659673;
        Tue, 03 Jun 2025 19:37:39 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a6:1600:9ca7:9478:f3c6:e1eb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-710de73be23sm120297b3.43.2025.06.03.19.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 19:37:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <20250521232917.2333291-4-jacob.e.keller@intel.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jacob Keller <jacob.keller@gmail.com>
Date: Tue, 3 Jun 2025 22:37:28 -0400
Message-Id: <374BC043-8FB8-4052-BDE7-6BAE7F182994@gmail.com>
References: <20250521232917.2333291-4-jacob.e.keller@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: iPhone Mail (21F90)

Actually, one comment :)

> Le 21 mai 2025 =C3=A0 19:29, Jacob Keller <jacob.e.keller@intel.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFFrom: Jacob Keller <jacob.keller@gmail.com>
>=20
> The --no-index option of git-diff enables using the diff machinery from
> git while operating outside of a repository. This mode of git diff is
> able to compare directories and produce a diff of their contents.
>=20
> When operating git diff in a repository, git has the notion of
> "pathspecs" which can specify which files to compare. In particular,
> when using git to diff two trees, you might invoke:
>=20
> $ git diff-tree -r <treeish1> <treeish2>.

I do find it slightly confusing that this series and in particular this patc=
h is all about git-diff(1), but the only example is about git-diff-tree(1). I=
t=E2=80=99s not the best example to me, esp. since it doesn=E2=80=99t actual=
ly use the pathspec machinery (deferring that to prose only). But I get the g=
ist, so not really an issue.

Rereading a bit, it seems this message goes to lengths to teach readers abou=
t pathspecs for git-diff here; perhaps we can simplify those parts and assum=
e the reader is familiar enough with the details to understand the implicati=
ons of =C2=AB no-index mode doesn=E2=80=99t support pathspecs to limit compa=
rison =C2=BB?

Nit: Should the diff-tree command end with a period?

> where the treeish could point to a subdirectory of the repository.
>=20
> When invoked this way, users can limit the selected paths of the tree by
> using a pathspec. Either by providing some list of paths to accept, or
> by removing paths via a negative refspec.
>=20
> The git diff --no-index mode does not support pathspecs, and cannot
> limit the diff output in this way. Other diff programs such as GNU
> difftools have options for excluding paths based on a pattern match.
> However, using git diff as a diff replacement has several advantages
> over many popular diff tools, including coloring moved lines, rename
> detections, and similar.
>=20
> Teach git diff --no-index how to handle pathspecs to limit the
> comparisons. This will only be supported if both provided paths are
> directories.
>=20
> For comparisons where one path isn't a directory, the --no-index mode
> already has some DWIM shortcuts implemented in the fixup_paths()
> function.
>=20
> Modify the fixup_paths function to return 1 if both paths are
> directories. If this is the case, interpret any extra arguments to git
> diff as pathspecs via parse_pathspec.
>=20
> Use parse_pathspec to load the remaining arguments (if any) to git diff
> --no-index as pathspec items. Disable PATHSPEC_ATTR support since we do
> not have a repository to do attribute lookup. Disable PATHSPEC_FROMTOP
> since we do not have a repository root. All pathspecs are treated as
> rooted at the provided comparison paths.
>=20
> After loading the pathspec data, calculate skip offsets for skipping
> past the root portion of the paths. This is required to ensure that
> pathspecs start matching from the provided path, rather than matching
> from the absolute path. We could instead pass the paths as prefix values
> to parse_pathspec. This is slightly problematic because the paths come
> from the command line and don't necessarily have the proper trailing
> slash. Additionally, that would require parsing pathspecs multiple
> times.
>=20
> Pass the pathspec object and the skip offsets into queue_diff, which
> in-turn must pass them along to read_directory_contents.
>=20
> Modify read_directory_contents to check against the pathspecs when
> scanning the directory. Use the skip offset to skip past the initial
> root of the path, and only match against portions that are below the
> intended directory structure being compared.
>=20
> The search algorithm for finding paths is recursive with read_dir. To
> make pathspec matching work properly, we must set both
> DO_MATCH_DIRECTORY and DO_MATCH_LEADING_PATHSPEC.
>=20
> Without DO_MATCH_DIRECTORY, paths like "a/b/c/d" will not match against
> pathspecs like "a/b/c". This is usually achieved by setting the is_dir
> parameter of match_pathspec.
>=20
> Without DO_MATCH_LEADING_PATHSPEC, paths like "a/b/c" would not match
> against pathspecs like "a/b/c/d". This is crucial because we recursively
> iterate down the directories. We could simply avoid checking pathspecs
> at subdirectories, but this would force recursion down directories
> which would simply be skipped.
>=20
> If we always passed DO_MATCH_LEADING_PATHSPEC, then we will
> incorrectly match in certain cases such as matching 'a/c' against
> ':(glob)**/d'. The match logic will see that a matches the leading part
> of the **/ and accept this even tho c doesn't match.
>=20
> To avoid this, use the match_leading_pathspec() variant recently
> introduced. This sets both flags when is_dir is set, but leaves them
> both cleared when is_dir is 0.
>=20
> Add test cases and documentation covering the new functionality. Note
> for the documentation I opted not to move the placement of '--' which is
> sometimes used to disambiguate arguments. The diff --no-index mode
> requires exactly 2 arguments determining what to compare. Any additional
> arguments are interpreted as pathspecs and must come afterwards. Use of
> '--' would not actually disambiguate anything, since there will never be
> ambiguity over which arguments represent paths or pathspecs.
>=20
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> builtin/diff.c              |  2 +-
> diff-no-index.c             | 85 +++++++++++++++++++++++++++++--------
> Documentation/git-diff.adoc | 10 +++--
> t/t4053-diff-no-index.sh    | 75 ++++++++++++++++++++++++++++++++
> 4 files changed, 151 insertions(+), 21 deletions(-)
>=20
> diff --git a/builtin/diff.c b/builtin/diff.c
> index fa963808c318..c6231edce4e8 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -35,7 +35,7 @@ static const char builtin_diff_usage[] =3D
> "   or: git diff [<options>] [--merge-base] <commit> [<commit>...] <commit=
> [--] [<path>...]\n"
> "   or: git diff [<options>] <commit>...<commit> [--] [<path>...]\n"
> "   or: git diff [<options>] <blob> <blob>\n"
> -"   or: git diff [<options>] --no-index [--] <path> <path>"
> +"   or: git diff [<options>] --no-index [--] <path> <path> [<pathspec>...=
]"
> "\n"
> COMMON_DIFF_OPTIONS_HELP;
>=20
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 9739b2b268b9..4aeeb98cfa8f 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -15,20 +15,45 @@
> #include "gettext.h"
> #include "revision.h"
> #include "parse-options.h"
> +#include "pathspec.h"
> #include "string-list.h"
> #include "dir.h"
>=20
> -static int read_directory_contents(const char *path, struct string_list *=
list)
> +static int read_directory_contents(const char *path, struct string_list *=
list,
> +                   const struct pathspec *pathspec,
> +                   int skip)
> {
> +    struct strbuf match =3D STRBUF_INIT;
> +    int len;
>   DIR *dir;
>   struct dirent *e;
>=20
>   if (!(dir =3D opendir(path)))
>       return error("Could not open directory %s", path);
>=20
> -    while ((e =3D readdir_skip_dot_and_dotdot(dir)))
> -        string_list_insert(list, e->d_name);
> +    if (pathspec) {
> +        strbuf_addstr(&match, path);
> +        strbuf_complete(&match, '/');
> +        strbuf_remove(&match, 0, skip);
>=20
> +        len =3D match.len;
> +    }
> +
> +    while ((e =3D readdir_skip_dot_and_dotdot(dir))) {
> +        if (pathspec) {
> +            strbuf_setlen(&match, len);
> +            strbuf_addstr(&match, e->d_name);
> +
> +            if (!match_leading_pathspec(NULL, pathspec,
> +                            match.buf, match.len,
> +                            0, NULL, e->d_type =3D=3D DT_DIR ? 1 : 0))
> +                continue;
> +        }
> +
> +        string_list_insert(list, e->d_name);
> +    }
> +
> +    strbuf_release(&match);
>   closedir(dir);
>   return 0;
> }
> @@ -131,7 +156,8 @@ static struct diff_filespec *noindex_filespec(const st=
ruct git_hash_algo *algop,
> }
>=20
> static int queue_diff(struct diff_options *o, const struct git_hash_algo *=
algop,
> -              const char *name1, const char *name2, int recursing)
> +              const char *name1, const char *name2, int recursing,
> +              const struct pathspec *ps, int skip1, int skip2)
> {
>   int mode1 =3D 0, mode2 =3D 0;
>   enum special special1 =3D SPECIAL_NONE, special2 =3D SPECIAL_NONE;
> @@ -171,9 +197,9 @@ static int queue_diff(struct diff_options *o, const st=
ruct git_hash_algo *algop,
>       int i1, i2, ret =3D 0;
>       size_t len1 =3D 0, len2 =3D 0;
>=20
> -        if (name1 && read_directory_contents(name1, &p1))
> +        if (name1 && read_directory_contents(name1, &p1, ps, skip1))
>           return -1;
> -        if (name2 && read_directory_contents(name2, &p2)) {
> +        if (name2 && read_directory_contents(name2, &p2, ps, skip2)) {
>           string_list_clear(&p1, 0);
>           return -1;
>       }
> @@ -218,7 +244,7 @@ static int queue_diff(struct diff_options *o, const st=
ruct git_hash_algo *algop,
>               n2 =3D buffer2.buf;
>           }
>=20
> -            ret =3D queue_diff(o, algop, n1, n2, 1);
> +            ret =3D queue_diff(o, algop, n1, n2, 1, ps, skip1, skip2);
>       }
>       string_list_clear(&p1, 0);
>       string_list_clear(&p2, 0);
> @@ -258,8 +284,10 @@ static void append_basename(struct strbuf *path, cons=
t char *dir, const char *fi
> * DWIM "diff D F" into "diff D/F F" and "diff F D" into "diff F D/F"
> * Note that we append the basename of F to D/, so "diff a/b/file D"
> * becomes "diff a/b/file D/file", not "diff a/b/file D/a/b/file".
> + *
> + * Return 1 if both paths are directories, 0 otherwise.
> */
> -static void fixup_paths(const char **path, struct strbuf *replacement)
> +static int fixup_paths(const char **path, struct strbuf *replacement)
> {
>   struct stat st;
>   unsigned int isdir0 =3D 0, isdir1 =3D 0;
> @@ -282,26 +310,31 @@ static void fixup_paths(const char **path, struct st=
rbuf *replacement)
>   if ((isdir0 && ispipe1) || (ispipe0 && isdir1))
>       die(_("cannot compare a named pipe to a directory"));
>=20
> -    if (isdir0 =3D=3D isdir1)
> -        return;
> +    /* if both paths are directories, we will enable pathspecs */
> +    if (isdir0 && isdir1)
> +        return 1;
> +
>   if (isdir0) {
>       append_basename(replacement, path[0], path[1]);
>       path[0] =3D replacement->buf;
> -    } else {
> +    } else if (isdir1) {
>       append_basename(replacement, path[1], path[0]);
>       path[1] =3D replacement->buf;
>   }
> +
> +    return 0;
> }
>=20
> static const char * const diff_no_index_usage[] =3D {
> -    N_("git diff --no-index [<options>] <path> <path>"),
> +    N_("git diff --no-index [<options>] <path> <path> [<pathspec>...]"),
>   NULL
> };
>=20
> int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop=
,
>         int implicit_no_index, int argc, const char **argv)
> {
> -    int i, no_index;
> +    struct pathspec pathspec, *ps =3D NULL;
> +    int i, no_index, skip1 =3D 0, skip2 =3D 0;
>   int ret =3D 1;
>   const char *paths[2];
>   char *to_free[ARRAY_SIZE(paths)] =3D { 0 };
> @@ -317,13 +350,12 @@ int diff_no_index(struct rev_info *revs, const struc=
t git_hash_algo *algop,
>   options =3D add_diff_options(no_index_options, &revs->diffopt);
>   argc =3D parse_options(argc, argv, revs->prefix, options,
>                diff_no_index_usage, 0);
> -    if (argc !=3D 2) {
> +    if (argc < 2) {
>       if (implicit_no_index)
>           warning(_("Not a git repository. Use --no-index to "
>                 "compare two paths outside a working tree"));
>       usage_with_options(diff_no_index_usage, options);
>   }
> -    FREE_AND_NULL(options);
>   for (i =3D 0; i < 2; i++) {
>       const char *p =3D argv[i];
>       if (!strcmp(p, "-"))
> @@ -337,7 +369,23 @@ int diff_no_index(struct rev_info *revs, const struct=
 git_hash_algo *algop,
>       paths[i] =3D p;
>   }
>=20
> -    fixup_paths(paths, &replacement);
> +    if (fixup_paths(paths, &replacement)) {
> +        parse_pathspec(&pathspec, PATHSPEC_FROMTOP | PATHSPEC_ATTR,
> +                   PATHSPEC_PREFER_FULL | PATHSPEC_NO_REPOSITORY,
> +                   NULL, &argv[2]);
> +        if (pathspec.nr)
> +            ps =3D &pathspec;
> +
> +        skip1 =3D strlen(paths[0]);
> +        skip1 +=3D paths[0][skip1] =3D=3D '/' ? 0 : 1;
> +        skip2 =3D strlen(paths[1]);
> +        skip2 +=3D paths[1][skip2] =3D=3D '/' ? 0 : 1;
> +    } else if (argc > 2) {
> +        warning(_("Limiting comparison with pathspecs is only "
> +              "supported if both paths are directories."));
> +        usage_with_options(diff_no_index_usage, options);
> +    }
> +    FREE_AND_NULL(options);
>=20
>   revs->diffopt.skip_stat_unmatch =3D 1;
>   if (!revs->diffopt.output_format)
> @@ -354,7 +402,8 @@ int diff_no_index(struct rev_info *revs, const struct g=
it_hash_algo *algop,
>   setup_diff_pager(&revs->diffopt);
>   revs->diffopt.flags.exit_with_status =3D 1;
>=20
> -    if (queue_diff(&revs->diffopt, algop, paths[0], paths[1], 0))
> +    if (queue_diff(&revs->diffopt, algop, paths[0], paths[1], 0, ps,
> +               skip1, skip2))
>       goto out;
>   diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
>   diffcore_std(&revs->diffopt);
> @@ -370,5 +419,7 @@ int diff_no_index(struct rev_info *revs, const struct g=
it_hash_algo *algop,
>   for (i =3D 0; i < ARRAY_SIZE(to_free); i++)
>       free(to_free[i]);
>   strbuf_release(&replacement);
> +    if (ps)
> +        clear_pathspec(ps);
>   return ret;
> }
> diff --git a/Documentation/git-diff.adoc b/Documentation/git-diff.adoc
> index dec173a34517..272331afbaec 100644
> --- a/Documentation/git-diff.adoc
> +++ b/Documentation/git-diff.adoc
> @@ -14,7 +14,7 @@ git diff [<options>] --cached [--merge-base] [<commit>] [=
--] [<path>...]
> git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [=
<path>...]
> git diff [<options>] <commit>...<commit> [--] [<path>...]
> git diff [<options>] <blob> <blob>
> -git diff [<options>] --no-index [--] <path> <path>
> +git diff [<options>] --no-index [--] <path> <path> [<pathspec>...]
>=20
> DESCRIPTION
> -----------
> @@ -31,14 +31,18 @@ files on disk.
>   further add to the index but you still haven't.  You can
>   stage these changes by using linkgit:git-add[1].
>=20
> -`git diff [<options>] --no-index [--] <path> <path>`::
> +`git diff [<options>] --no-index [--] <path> <path> [<pathspec>...]`::
>=20
>   This form is to compare the given two paths on the
>   filesystem.  You can omit the `--no-index` option when
>   running the command in a working tree controlled by Git and
>   at least one of the paths points outside the working tree,
>   or when running the command outside a working tree
> -    controlled by Git. This form implies `--exit-code`.
> +    controlled by Git. This form implies `--exit-code`. If both
> +    paths point to directories, additional pathspecs may be
> +    provided. These will limit the files included in the
> +    difference. All such pathspecs must be relative as they
> +    apply to both sides of the diff.
>=20
> `git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]`=
::
>=20
> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 5e5bad61ca1e..01db9243abfe 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -295,4 +295,79 @@ test_expect_success PIPE,SYMLINKS 'diff --no-index re=
ads from pipes' '
>   test_cmp expect actual
> '
>=20
> +test_expect_success 'diff --no-index F F rejects pathspecs' '
> +    test_must_fail git diff --no-index -- a/1 a/2 a 2>actual.err &&
> +    test_grep "usage: git diff --no-index" actual.err
> +'
> +
> +test_expect_success 'diff --no-index D F rejects pathspecs' '
> +    test_must_fail git diff --no-index -- a a/2 a 2>actual.err &&
> +    test_grep "usage: git diff --no-index" actual.err
> +'
> +
> +test_expect_success 'diff --no-index F D rejects pathspecs' '
> +    test_must_fail git diff --no-index -- a/1 b b 2>actual.err &&
> +    test_grep "usage: git diff --no-index" actual.err
> +'
> +
> +test_expect_success 'diff --no-index rejects absolute pathspec' '
> +    test_must_fail git diff --no-index -- a b $(pwd)/a/1
> +'
> +
> +test_expect_success 'diff --no-index with pathspec' '
> +    test_expect_code 1 git diff --name-status --no-index a b 1 >actual &&=

> +    cat >expect <<-EOF &&
> +    D    a/1
> +    EOF
> +    test_cmp expect actual
> +'
> +
> +test_expect_success 'diff --no-index with pathspec no matches' '
> +    test_expect_code 0 git diff --name-status --no-index a b missing
> +'
> +
> +test_expect_success 'diff --no-index with negative pathspec' '
> +    test_expect_code 1 git diff --name-status --no-index a b ":!2" >actua=
l &&
> +    cat >expect <<-EOF &&
> +    D    a/1
> +    EOF
> +    test_cmp expect actual
> +'
> +
> +test_expect_success 'setup nested' '
> +    mkdir -p c/1/2 &&
> +    mkdir -p d/1/2 &&
> +    echo 1 >c/1/2/a &&
> +    echo 2 >c/1/2/b
> +'
> +
> +test_expect_success 'diff --no-index with pathspec nested negative pathsp=
ec' '
> +    test_expect_code 0 git diff --no-index c d ":!1"
> +'
> +
> +test_expect_success 'diff --no-index with pathspec nested pathspec' '
> +    test_expect_code 1 git diff --name-status --no-index c d 1/2 >actual &=
&
> +    cat >expect <<-EOF &&
> +    D    c/1/2/a
> +    D    c/1/2/b
> +    EOF
> +    test_cmp expect actual
> +'
> +
> +test_expect_success 'diff --no-index with pathspec glob' '
> +    test_expect_code 1 git diff --name-status --no-index c d ":(glob)**/a=
" >actual &&
> +    cat >expect <<-EOF &&
> +    D    c/1/2/a
> +    EOF
> +    test_cmp expect actual
> +'
> +
> +test_expect_success 'diff --no-index with pathspec glob and exclude' '
> +    test_expect_code 1 git diff --name-status --no-index c d ":(glob,excl=
ude)**/a" >actual &&
> +    cat >expect <<-EOF &&
> +    D    c/1/2/b
> +    EOF
> +    test_cmp expect actual
> +'
> +
> test_done
> --
> 2.48.1.397.gec9d649cc640
