Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3711A01B4
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267294; cv=none; b=bfrXnh2JcRJ+Z9a1F8IBfFGPGbUNCJ8NH71ukbZ3Vidy+Nquf5r8t380iXg+GEDvOIa7IaDbMlg6lrvgPT+3ADXqgtkRD9pob5b6H7hGuIoLMJ/KShLwC1F6WVmTmsMUBV9pvCPwRanD8LVgZIcOGMB+eiKFaYFjB2hDKUY6sxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267294; c=relaxed/simple;
	bh=MvmLRIbDCo6d25YqUV04qfeA1dHf5h/TD7zCibsY1m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEAJR6qwvulNMYgyJvqytVwoU5R4YkLB05WBPpTyFAa5QmMd2jnl35P/JAnSLEh8hOXF5CtLA9EEsaW8BN201/DOrCRs07Kj5JZd3s/lzuUhtdYcg/WOfZ2gRTXwWQ8H1Z9GYMkluA49CM0v2yYXoEH5QjIRzdCKfsAz5ZW868E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjD6D7ad; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjD6D7ad"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7eee7728b00so181635739f.3
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 15:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719267292; x=1719872092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYcVTgwN0/gqu7K3gu5qAVO1IV2BCoDwLboSEFWq/UA=;
        b=kjD6D7adWCmEsLAeXJL+Ijv4RwrQ6qNc/QNnOjuwaPsFpGxn/i1+VCS8yBhlDS1cRG
         s3fX/aGnsa0m13f7hI/UY5rW77ijxnAjO0pyszqKX/P5391VgLQvCRHodi1GdV18q29Z
         FjVWCsq2okq8g4YFSMvSt1g3Rnl1u0qTnv+itVlgGJwqcmDFGUtzZIoQmeCDo01bnI7o
         CQ2QPLs9j0ZyEuf1xI/QnkxwicBOmAbXQv0NP6MgJ0XnwE8O8dnusOll9ucKqUTa9Qm8
         3M3mpYdrD1U9VgWKlBUUJd+JIW0Mm8kY8qOlInvF/jglYi0HeUMF6ny4VQfAcG+cPr3h
         Mk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267292; x=1719872092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYcVTgwN0/gqu7K3gu5qAVO1IV2BCoDwLboSEFWq/UA=;
        b=jTsao6GcoCuxhWxxZWrqvFlaRHuTBy8FuYTlNpT5RzLRkGgFk125fDWLSTbkiUmcEn
         vcAIrURPJdrqaCFK1l0LEqDtWe/t6obRC2Q2XAQr+0NGnnMwdoqYrxdfj1mOE6x7DLWk
         0lHot+GA/arcEAfTHUnccjbw45+3SVEHsxOb7FS47cuiKKwNX7eWVU7eh45JzKnI7OVE
         U6adXPGDz0UJH4i+hEHGN8dmqGncAaYc/eZ2RHWD2ANkPq7Tb8T7tPiPnng/wTQHxeig
         gcq3kqzy3hhKHCrqbBnpMeXrzXfusx5D1dw1YG7+Pg+9x2zgrsrXr/cYKttQR9QmfczC
         TzhQ==
X-Gm-Message-State: AOJu0YzbhIJgwwEOJdg73p2ns43RJ4RqPgsUzF6YbkFMw1Ln5dKulFJT
	JZomZdNhHb3gaVgVAEDPj5dVPsfIHHlVwV2KZyP211cIFVycTZX1Y0adqXfdFINx4qSvHt3EnvH
	CHmhNP4qrc4NiEb2eCIY3vGGZSBix6Q==
X-Google-Smtp-Source: AGHT+IFqtpqNysbiHYdF4r1OXlWVHm6D8sX7Dy+K0NhWfirQVhfM3HqW1pKvbZCoS/NVjcCDqvapopFtVzKJHY5VbGg=
X-Received: by 2002:a05:6602:6b86:b0:7e1:e022:9e46 with SMTP id
 ca18e2360f4ac-7f3a75faec7mr600581639f.21.1719267291660; Mon, 24 Jun 2024
 15:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com> <2654fcb7142a606c5684c762ed28bb5e8d9b4712.1718899877.git.gitgitgadget@gmail.com>
In-Reply-To: <2654fcb7142a606c5684c762ed28bb5e8d9b4712.1718899877.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Jun 2024 15:14:40 -0700
Message-ID: <CABPp-BFgg8DOy-SUUsXLyfsWr0DOUUc1vQKnPpihy-h+NAj_zg@mail.gmail.com>
Subject: Re: [PATCH 5/5] sparse-index: improve lstat caching of sparse paths
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, anh@canva.com, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 10:11=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> The clear_skip_worktree_from_present_files() method was first introduced
> in af6a51875a (repo_read_index: clear SKIP_WORKTREE bit from files
> present in worktree, 2022-01-14) to allow better interaction with the
> working directory in the presence of paths outside of the
> sparse-checkout cone.

s/cone//

> The initial implementation would lstat() every
> single sparse tree to see if it existed, and if one did, then the sparse
> index would expand and every sparse file would be checked.

This sounds like the algorithm only lstat()ed the sparse directories,
which feels misleading.  Perhaps

The initial implementation would lstat() every SKIP_WORKTREE path to
see if it existed; if it ran across a sparse directory that existed
(when a sparse-index was in use), then it would expand the index and
then check every SKIP_WORKTREE path.

> Since these lstat() calls were very expensive, this was improved in
> d79d299352 (Accelerate clear_skip_worktree_from_present_files() by
> caching, 2022-01-14) by caching directories that do not exist. However,
> there are some inefficiencies in that caching mechanism.

Maybe this is obvious, but I thought a few extra words to end the
second-to-last sentence would be helpful, such as "so it could avoid
lstat()ing any files under such directories".

> The caching mechanism stored only the parent directory as not existing,
> even if a higher parent directory also does not exist. This means that
> wasted lstat() calls would occur when the sparse files change immediate
> parent directories but within the same root directory that does not
> exist.

This is the crucial insight that makes this patch improve things so much.

> To set up a scenario that triggers this code in an interesting way, we
> need a sparse-checkout in cone mode and a sparse index. To trigger the

I think you state this too strongly.  While trying to duplicate, I
first went with a cone mode & sparse index at first, but out of
curiosity tried it without either of these modes set and still saw
dramatic improvement from your patch.  What is needed is that the
sparsity is such that entire directories are missing, and not just one
level above the files of interest.  That is more likely to occur when
cone mode and perhaps sparse index are in use, but perhaps consider
changing "we need" to "it is easiest to consider"

> full index expansion and a call to the
> clear_skip_worktree_from_present_files_full() method, we need one of the
> sparse trees to actually exist on disk. The performance test script
> p2000-sparse-operations.sh takes the sample repository and copies its
> HEAD to several copies nested in directories of the form f<i>/f<j>/f<k>
> where i, j, and k are numbers from 1 to 4. The sparse-checkout cone is
> then selected as "f2/f4/". Creating "f1/f1/" will trigger the behavior
> and also lead to some interesting cases for the caching algorithm since
> "f1/f1/" exists but "f1/f2/" and "f3/" do not.

For some reason I had difficulty triggering a case using this guide.
I might have made an error, but I decided I wanted a deeper directory
tree to test with anyway.  After some playing around to come up with
an interesting testcase, I eventually came up with the following steps
to reproduce in case anyone else wants to try:

    git clone https://github.com/newren/gvfs-like-git-bomb
    cd gvfs-like-git-bomb
    ./runme.sh
    git sparse-checkout set bomb/b/c            # incidentally cone mode
    mkdir -p bomb/d/e/f/a/a
    git ls-files -t | colrm 2 | sort | uniq -c  # optional, but interesting
    GIT_TRACE2_PERF=3D$(pwd)/trace git ls-files -t >/dev/null
    grep lstat_count trace

Further, you can recompile the git version in use in another window,
then come back to this one and run 'rm trace' followed by the last two
commands to retest.

The commands above create a 'gvfs-like-git-bomb' git directory that
has 1,000,001 files in HEAD.

With this test directory, before applying this patch, I see:
    ..sparse_lstat_count:722011
After applying this patch I see
    ..sparse_lstat_count:135
and with a slight tweak to your patch I see
    ..sparse_lstat_count:125
I'll comment on the slight tweak at the end of the patch.

> This is difficult to notice when running performance tests using the Git
> repository (or a blow-up of the Git repository, as in
> p2000-sparse-operations.sh) because Git has a very shallow directory
> structure.
>
> This change reorganizes the caching algorithm to focus on storing both
> the deepest _existing_ directory and the next-level non-existing
> directory.

This was slightly hard to parse for me, and misled me into thinking
you were tracking two directories.  Maybe:

This change reorganizes the caching algorithm to focus on storing the
highest level leading directory that does not exist (i.e. we are
restricting to the leading directory whose parent directory does
exist).

> By doing a little extra work on the first sparse file, we can
> short-circuit all of the sparse files that exist in that non-existing
> directory.

Here you use "exist" as "tracked by git" in one case, and "appears in
the working tree" in another.  That's a problem, because the files in
question are tracked by git but do not appear in the working tree,
making it impossible for people to understand unless they guess the
correct definition for each use.  I think we want "exist" to just mean
"appears in the working tree" here, so we'd need to s/sparse files
that exist in/sparse files underneath/ (or something similar) to fix
this sentence.

Also, you've used the phrase "sparse file(s)" a number of times in
this commit message; I think I know what you mean, but it is not
defined in the vocabulary section of
Documentation/technical/sparse-checkout.txt.  Together with the above
problem, it made me question what was meant, re-read all the
definitions, etc.  Perhaps "sparse file(s)" should be added to that
vocabulary section, though...especially if we are going to use it and
since we never fixed "sparse directory" despite mentioning that we
wanted to?

> When in a repository where the first sparse file is likely to
> have a much deeper path than the first non-existing directory, this can
> realize significant gains.
>
> The details of this algorithm require careful attention, so the new
> implementation of path_found() has detailed comments, including the use
> of a new max_common_dir_prefix() method that may be of independent
> interest.

These comments are well written and very helpful; thanks for including them=
.

> It's worth noting that this is not universally positive, since we are
> doing extra lstat() calls to establish the exact path to cache. In the
> blow-up of the Git repository, we can see that the lstat count
> _increases_ from 28 to 31. However, these numbers were already
> artificially low.

Yeah, I spent a while thinking about whether there were funny cases
where your algorithm might significantly increase the number of
lstat() calls for non-sparse-index, non-cone mode cases and came up
kind of empty handed.  It seems you only ever add a modest number of
lstat() calls, and in common scenarios (entire non-leaf directories
missing) you remove a dramatic number of lstat() calls.

> Using an internal monorepo with over two million paths at HEAD and a
> typical sparse-checkout cone such that the index contains ~190,000
> entries (including over two thousand sparse trees), I was able to
> measure these lstat counts when one sparse directory actually exists on
> disk:
>
>   Sparse files in expanded index: 1,841,997
>        full_lstat_count (before):   173,259
>        full_lstat_count  (after):     6,521
>
> This resulted in this absolute time change, on a warm disk:
>
>       Time in full loop (before): 2.527 s
>       Time in full loop  (after): 0.071 s

Very nice.  :-)

> (These times were calculated on a Windows machine, where lstat() is
> slower than a similar Linux machine.)
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  sparse-index.c | 118 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 93 insertions(+), 25 deletions(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index 8577fa726b8..cccd8550dfe 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -440,14 +440,21 @@ void ensure_correct_sparsity(struct index_state *is=
tate)
>  }
>
>  struct path_found_data {
> +       /**
> +        * The path stored in 'dir', if non-empty, corresponds to the mos=
t-
> +        * recent path that we checked where:
> +        *
> +        *   1. The path should be a directory, according to the index.
> +        *   2. The path does not exist.
> +        *   3. The parent path _does_ exist. (This may be the root of th=
e
> +        *      working directory.)
> +        */
>         struct strbuf dir;
> -       int dir_found;
>         size_t lstat_count;
>  };
>
>  #define PATH_FOUND_DATA_INIT { \
> -       .dir =3D STRBUF_INIT, \
> -       .dir_found =3D 1 \
> +       .dir =3D STRBUF_INIT \
>  }
>
>  static void clear_path_found_data(struct path_found_data *data)
> @@ -455,50 +462,111 @@ static void clear_path_found_data(struct path_foun=
d_data *data)
>         strbuf_release(&data->dir);
>  }
>
> +/**
> + * Return the length of the largest common substring that ends in a
> + * slash ('/') to indicate the largest common parent directory. Returns
> + * zero if no common directory exists.
> + */
> +static size_t max_common_dir_prefix(const char *path1, const char *path2=
)
> +{
> +       size_t common_prefix =3D 0;
> +       for (size_t i =3D 0; path1[i] && path2[i]; i++) {
> +               if (path1[i] !=3D path2[i])
> +                       break;
> +
> +               /*
> +                * If they agree at a directory separator, then add one
> +                * to make sure it is included in the common prefix strin=
g.
> +                */
> +               if (path1[i] =3D=3D '/')
> +                       common_prefix =3D i + 1;
> +       }
> +
> +       return common_prefix;
> +}
> +
>  static int path_found(const char *path, struct path_found_data *data)
>  {
>         struct stat st;
> -       char *newdir;
> +       size_t common_prefix;
>
>         /*
> -        * If dirname corresponds to a directory that doesn't exist, and =
this
> -        * path starts with dirname, then path can't exist.
> +        * If data->dir is non-empty, then it contains a path that doesn'=
t
> +        * exist, including an ending slash ('/'). If it is a prefix of '=
path',
> +        * then we can return 0.
>          */
> -       if (!data->dir_found && !memcmp(path, data->dir.buf, data->dir.le=
n))
> +       if (data->dir.len && !memcmp(path, data->dir.buf, data->dir.len))
>                 return 0;
>
>         /*
> -        * If path itself exists, return 1.
> +        * Otherwise, we must check if the current path exists. If it doe=
s, then
> +        * return 1. The cached directory will be skipped until we come a=
cross
> +        * a missing path again.
>          */
>         data->lstat_count++;
>         if (!lstat(path, &st))
>                 return 1;
>
>         /*
> -        * Otherwise, path does not exist so we'll return 0...but we'll f=
irst
> -        * determine some info about its parent directory so we can avoid
> -        * lstat calls for future cache entries.
> +        * At this point, we know that 'path' doesn't exist, and we know =
that
> +        * the parent directory of 'data->dir' does exist. Let's set 'dat=
a->dir'
> +        * to be the top-most non-existing directory of 'path'. If the fi=
rst
> +        * parent of 'path' exists, then we will act ast though 'path'

s/ast/as/

> +        * corresponds to a directory (by adding a slash).
>          */
> -       newdir =3D strrchr(path, '/');
> -       if (!newdir)
> -               return 0; /* Didn't find a parent dir; just return 0 now.=
 */
> +       common_prefix =3D max_common_dir_prefix(path, data->dir.buf);
>
>         /*
> -        * If path starts with directory (which we already lstat'ed and f=
ound),
> -        * then no need to lstat parent directory again.
> +        * At this point, 'path' and 'data->dir' have a common existing p=
arent
> +        * directory given by path[0..common_prefix] (which could have le=
ngth 0).
> +        * We "grow" the data->dir buffer by checking for existing direct=
ories
> +        * along 'path'.
>          */
> -       if (data->dir_found && data->dir.buf &&
> -           memcmp(path, data->dir.buf, data->dir.len))
> -               return 0;
>
> -       /* Free previous dirname, and cache path's dirname */
> -       strbuf_reset(&data->dir);
> -       strbuf_add(&data->dir, path, newdir - path + 1);
> +       strbuf_setlen(&data->dir, common_prefix);
> +       while (1) {
> +               /* Find the next directory in 'path'. */
> +               const char *next_slash =3D strchr(path + data->dir.len, '=
/');
>
> -       data->lstat_count++;
> -       data->dir_found =3D !lstat(data->dir.buf, &st);
> +               /*
> +                * If there are no more slashes, then 'path' doesn't cont=
ain a
> +                * non-existent _parent_ directory. Set 'data->dir' to be=
 equal
> +                * to 'path' plus an additional slash, so it can be used =
for
> +                * caching in the future. The filename of 'path' is consi=
dered
> +                * a non-existent directory.
> +                *
> +                * Note: if "{path}/" exists as a directory, then it will=
 never
> +                * appear as a prefix of other callers to this method, as=
suming
> +                * the context from the clear_skip_worktree... methods. I=
f this
> +                * method is reused, then this must be reconsidered.
> +                */
> +               if (!next_slash) {
> +                       strbuf_addstr(&data->dir, path + data->dir.len);
> +                       strbuf_addch(&data->dir, '/');
> +                       break;
> +               }
>
> -       return 0;
> +               /*
> +                * Now that we have a slash, let's grow 'data->dir' to in=
clude
> +                * this slash, then test if we should stop.
> +                */
> +               strbuf_add(&data->dir, path + data->dir.len,
> +                          (next_slash - path) - data->dir.len + 1);

I had to re-read this multiple times and was confused by it.  I
eventually realized it was simple -- you use "path + data->dir.len"
3-4 times in this loop.  Could we reduce the cognitive overhead by
setting some variable to this value at the beginning within the loop
and then just use it?  It'd simplify this particular call to

    strbuf_add(&data->dir, rest, next_slash - rest + 1);

or substitute any other variable name for "rest" there.  Maybe it
shouldn't be a big deal, but the rest of the method was complex enough
that I just blew my local stack space at this point.  I think this
simple substitution would have made it easier for me.

> +
> +               /* If the path doesn't exist, then stop here. */
> +               data->lstat_count++;
> +               if (lstat(data->dir.buf, &st))
> +                       return 0;
> +       }
> +
> +       /*
> +        * At this point, 'data->dir' is equal to 'path' plus a slash cha=
racter,
> +        * and the parent directory of 'path' definitely exists. Let's re=
turn
> +        * the case of whether 'path' exists.
> +        */

Can I suggest adding the following to this comment?
  " path does not exist at this point or we would have already
returned 1 above when we lstat()ed it before the above loop. "

> +
> +       data->lstat_count++;
> +       return !lstat(path, &st);

...and, as long as I didn't missing something with my above comment
suggestion, these two lines can be replaced by

    return 0;

Or did I miss something here?


Anyway, despite the many small comments I made, well done!  I think
the method is not only much more performant, but more readable than my
original.  With a few small tweaks, it should be good to merge.
