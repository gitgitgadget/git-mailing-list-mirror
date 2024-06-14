Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936A1C27
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718393561; cv=none; b=lLDpbzEzNqim7+KGOlYo4vZwqAc51GX8eCZ2TsNY5B0TP+LRUm9Sj5DDVLgFSJUtjRwQFd/QXMHQISvZrKNKTvZIuj+AwwBPc4p0POmP9VI56vt2tc3Q/tnRdLNVm8Idx/18i/Wy4nzHNVartRV682A2Mip8dNfUCrTxlwGdFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718393561; c=relaxed/simple;
	bh=h2kWfi4GFT0m1L/+lDNQQ4qMl5bG+uzeB+seZbq7TqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hohTqJwC1L/+dOflnEBL7RZzEFARd4CAI19tIcMJ/jn4jhFyy/sxwlOvT9Vf2KeJIEB/eW5j1MJ9D9/OPmF5a6XiaEI2ZpgkGyNVLZvxr6Siq625Me6sM6eOZeRs2Fdc7GpfGCOdQWk1aqE3CvYqJ9GqUYUBHRiRXVunO1RHcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KS4eHJXI; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS4eHJXI"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7eb699def37so79156039f.1
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 12:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718393559; x=1718998359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcZ09wLxC7J4Fvwo5r6nwKIHMd47VTH73jcMFgpzXVY=;
        b=KS4eHJXI8kYBByonfVA/Ohqzkrc4gZqwqiuJ9M8vZOO1Raa3oMWjyeUIm2o+Ogqauf
         sCBd4QBKtvGS9xWqpqWxKLLb1TaS648f8CjDlPMDDTMCkK7V07a/kDH73GIVvpdx5Ol5
         5Mpsn9I+KtMqqaRpb5qmN4bo8fNRgOd866oE41cgEcwmB0/92ixYbmP4a2GEkifcUf+q
         4OGMpVIm9dDFPDNxTt478wk/W5AYlb9wS9qOOkrT0tv/nU38Gt/mxE2sqNCrOC7WAxN4
         aIIcZfOd+nonmoorUfrRMdI2gjHxbXXhi9JI8CGBKj4FkV+zIvX08RuAamKl+eD5MTQE
         o2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718393559; x=1718998359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcZ09wLxC7J4Fvwo5r6nwKIHMd47VTH73jcMFgpzXVY=;
        b=cvPdpbnMtIk6/ruw5ucYS9XN9M5lYb8KadmcO3u1uOyFudcrWuQVfIi9ZnCm3zINi6
         1njP1Pe4lserKNdbZ3BYHw7dwA1xvSkvymPlCvpAUIQ4d+i2ybuceGrXrOsAbZGhDKPM
         tDhTY6A9yV5Di2X6NmlBuJB7yfsbRVe3FKeOf2Uk7VtlW78/eNuYDc90QTfl9ybI4FQC
         lhWC5y7tTcWv6uTl6vLX26t7xwbWhAGhOkGoYQfunhhFDgy562I9TVBaN6mnJ9nbNijV
         Aff1NodUiaEkC2ZeN752PxQffgD2DtReGYqfkb2NB+3nMzk0dpjpu7J/i70SWWB+dAwW
         lvaw==
X-Gm-Message-State: AOJu0YwFIsPUoOZnX5Vxk178W4uI2f02poY9vG50myi4xbesQps5vyZT
	ttUctMYUPj8JRhnf0Nn9lbdBSTQXRj/+xakaCE8KkCeo/k/bXoBMv46zt9MZ6bgIqrYAQpdhvOw
	BW7b193JyXFvgVFD1FXVGmIHx1FQ=
X-Google-Smtp-Source: AGHT+IEkYUMFfSyYFLriT8dOEit/ZYTy0d1dxgEyQuL8fqOZ4NTWGn/O8+xFCR3SAFItD+U+A6ROr6XIB0xnkVrdecM=
X-Received: by 2002:a05:6602:80c:b0:7eb:71bb:6f6b with SMTP id
 ca18e2360f4ac-7ebd8de85f0mr399549439f.3.1718393558981; Fri, 14 Jun 2024
 12:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603200539.1473345-1-gitster@pobox.com> <20240604220145.3260714-1-gitster@pobox.com>
 <20240604220145.3260714-4-gitster@pobox.com>
In-Reply-To: <20240604220145.3260714-4-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 14 Jun 2024 19:32:27 +0000
Message-ID: <CABPp-BH3ZozGnDueK=J4QvZMYZkS13Gk+0rhe+Dywqbx1F30DA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] show-ref: introduce --branches and deprecate --heads
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 10:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> We call the tips of branches "heads", but this command calls the
> option to show only branches "--heads", which confuses the branches
> themselves and the tips of branches.
>
> Straighten the terminology by introducing "--branches" option that
> limits the output to branches, and deprecate "--heads" option used
> that way.
>
> We do not plan to remove "--heads" or "-h" yet; we may want to do so
> at Git 3.0, in which case, we may need to start advertising upcoming
> removal with an extra warning when they are used.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-show-ref.txt | 18 ++++++++++--------
>  builtin/show-ref.c             | 16 +++++++++-------
>  t/t1403-show-ref.sh            | 24 ++++++++++++++++--------
>  3 files changed, 35 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.=
txt
> index ba75747005..616d919655 100644
> --- a/Documentation/git-show-ref.txt
> +++ b/Documentation/git-show-ref.txt
> @@ -9,8 +9,8 @@ SYNOPSIS
>  --------
>  [verse]
>  'git show-ref' [--head] [-d | --dereference]
> -            [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]
> -            [--heads] [--] [<pattern>...]
> +            [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--branches] [--tag=
s]
> +            [--] [<pattern>...]
>  'git show-ref' --verify [-q | --quiet] [-d | --dereference]
>              [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]
>              [--] [<ref>...]
> @@ -45,12 +45,14 @@ OPTIONS
>
>         Show the HEAD reference, even if it would normally be filtered ou=
t.
>
> ---heads::
> +--branches::
>  --tags::
>
> -       Limit to "refs/heads" and "refs/tags", respectively.  These optio=
ns
> +       Limit to local branches and local tags, respectively.  These opti=
ons
>         are not mutually exclusive; when given both, references stored in
> -       "refs/heads" and "refs/tags" are displayed.
> +       "refs/heads" and "refs/tags" are displayed.  Note that `--heads`
> +       is a deprecated synonym for `--branches` and may be removed
> +       in the future.
>
>  -d::
>  --dereference::
> @@ -139,7 +141,7 @@ When using `--hash` (and not `--dereference`), the ou=
tput is in the format:
>  For example,
>
>  ------------------------------------------------------------------------=
-----
> -$ git show-ref --heads --hash
> +$ git show-ref --branches --hash
>  2e3ba0114a1f52b47df29743d6915d056be13278
>  185008ae97960c8d551adcd9e23565194651b5d1
>  03adf42c988195b50e1a1935ba5fcbc39b2b029b
> @@ -183,8 +185,8 @@ to check whether a particular branch exists or not (n=
otice how we don't
>  actually want to show any results, and we want to use the full refname f=
or it
>  in order to not trigger the problem with ambiguous partial matches).
>
> -To show only tags, or only proper branch heads, use `--tags` and/or `--h=
eads`
> -respectively (using both means that it shows tags and heads, but not oth=
er
> +To show only tags, or only proper branch heads, use `--tags` and/or `--b=
ranches`
> +respectively (using both means that it shows tags and branches, but not =
other
>  random references under the refs/ subdirectory).
>
>  To do automatic tag object dereferencing, use the `-d` or `--dereference=
`
> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> index 1c15421e60..f634bc3e44 100644
> --- a/builtin/show-ref.c
> +++ b/builtin/show-ref.c
> @@ -11,8 +11,8 @@
>
>  static const char * const show_ref_usage[] =3D {
>         N_("git show-ref [--head] [-d | --dereference]\n"
> -          "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags=
]\n"
> -          "             [--heads] [--] [<pattern>...]"),
> +          "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--bran=
ches] [--tags]\n"
> +          "             [--] [<pattern>...]"),
>         N_("git show-ref --verify [-q | --quiet] [-d | --dereference]\n"
>            "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]\n"
>            "             [--] [<ref>...]"),
> @@ -188,7 +188,7 @@ static int cmd_show_ref__verify(const struct show_one=
_options *show_one_opts,
>
>  struct patterns_options {
>         int show_head;
> -       int heads_only;
> +       int branches_only;
>         int tags_only;
>  };
>
> @@ -206,8 +206,8 @@ static int cmd_show_ref__patterns(const struct patter=
ns_options *opts,
>
>         if (opts->show_head)
>                 head_ref(show_ref, &show_ref_data);
> -       if (opts->heads_only || opts->tags_only) {
> -               if (opts->heads_only)
> +       if (opts->branches_only || opts->tags_only) {
> +               if (opts->branches_only)
>                         for_each_fullref_in("refs/heads/", show_ref, &sho=
w_ref_data);
>                 if (opts->tags_only)
>                         for_each_fullref_in("refs/tags/", show_ref, &show=
_ref_data);
> @@ -286,8 +286,10 @@ int cmd_show_ref(int argc, const char **argv, const =
char *prefix)
>         struct show_one_options show_one_opts =3D {0};
>         int verify =3D 0, exists =3D 0;
>         const struct option show_ref_options[] =3D {
> -               OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only sh=
ow tags (can be combined with heads)")),
> -               OPT_BOOL(0, "heads", &patterns_opts.heads_only, N_("only =
show heads (can be combined with tags)")),
> +               OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only sh=
ow tags (can be combined with branches)")),
> +               OPT_BOOL(0, "branches", &patterns_opts.branches_only, N_(=
"only show branches (can be combined with tags)")),
> +               OPT_HIDDEN_BOOL(0, "heads", &patterns_opts.branches_only,
> +                               N_("deprecated synonym for --branches")),
>                 OPT_BOOL(0, "exists", &exists, N_("check for reference ex=
istence without resolving")),
>                 OPT_BOOL(0, "verify", &verify, N_("stricter reference che=
cking, "
>                             "requires exact ref path")),
> diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> index 33fb7a38ff..403f6b8f7d 100755
> --- a/t/t1403-show-ref.sh
> +++ b/t/t1403-show-ref.sh
> @@ -121,13 +121,13 @@ test_expect_success 'show-ref -d' '
>
>  '
>
> -test_expect_success 'show-ref --heads, --tags, --head, pattern' '
> +test_expect_success 'show-ref --branches, --tags, --head, pattern' '
>         for branch in B main side
>         do
>                 echo $(git rev-parse refs/heads/$branch) refs/heads/$bran=
ch || return 1
> -       done >expect.heads &&
> -       git show-ref --heads >actual &&
> -       test_cmp expect.heads actual &&
> +       done >expect.branches &&
> +       git show-ref --branches >actual &&
> +       test_cmp expect.branches actual &&
>
>         for tag in A B C
>         do
> @@ -136,15 +136,15 @@ test_expect_success 'show-ref --heads, --tags, --he=
ad, pattern' '
>         git show-ref --tags >actual &&
>         test_cmp expect.tags actual &&
>
> -       cat expect.heads expect.tags >expect &&
> -       git show-ref --heads --tags >actual &&
> +       cat expect.branches expect.tags >expect &&
> +       git show-ref --branches --tags >actual &&
>         test_cmp expect actual &&
>
>         {
>                 echo $(git rev-parse HEAD) HEAD &&
> -               cat expect.heads expect.tags
> +               cat expect.branches expect.tags
>         } >expect &&
> -       git show-ref --heads --tags --head >actual &&
> +       git show-ref --branches --tags --head >actual &&
>         test_cmp expect actual &&
>
>         {
> @@ -165,6 +165,14 @@ test_expect_success 'show-ref --heads, --tags, --hea=
d, pattern' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'show-ref --heads is deprecated and hidden' '
> +       test_expect_code 129 git show-ref -h >short-help &&
> +       test_grep ! -e --heads short-help &&
> +       git show-ref --heads >actual 2>warning &&
> +       test_grep ! deprecated warning &&
> +       test_cmp expect.branches actual
> +'
> +
>  test_expect_success 'show-ref --verify HEAD' '
>         echo $(git rev-parse HEAD) HEAD >expect &&
>         git show-ref --verify HEAD >actual &&
> --
> 2.45.2-409-g7b0defb391

If we are renaming --heads to --branches, should --head also be renamed?

Other than that question, this patch and series looks good to me.
