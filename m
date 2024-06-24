Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881521A0AFE
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267207; cv=none; b=L6/moLPYDo59w79eQJ+MHZpLM2rNuxiM6VjiWJWppBXZNRonCHQYZ+2MDk5MIbfXYx8U8myK01XCBDWaGb1iK0Dc+Nogt9EBuXMMgKudNYhT0EdAmnoDFKZtWI23aTaIrIBdhVfp5NmzRjMNHghoGH3XzYBTSri6fxfqRQF9CgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267207; c=relaxed/simple;
	bh=HnifPvdIqAHJ4KHdbNjY8JGM+kuUTunjXKCSn6b6rJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhTXgonXQDKJH6Ih30IXKF50yevktkD+hyncx47Vr/RU4Xliy8xakIzxXH1qlhdSr3tTFSi9ywYfh/dC3qG6uHdnicZ4+UztLE5i3gh0CnQ6NbZ6axssutZWm/SijOS0fALzjBE9W0G6DZ/7KV/FXHxyAIrErjMznXLG0YVOBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuOlmckN; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuOlmckN"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7eb85e80661so184394139f.1
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719267205; x=1719872005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76LFhxWAz9rsUDfyu0ZAqwdO5Q1o/DxY2U4IiHgYPj4=;
        b=cuOlmckNT0hPgiWUQLJsCWTMJ9K9xZMH439itH3lDfKO2REZEQ8LgAh3SBOZQJOOPn
         jNZF3JD6g1yxpRFS55w+DZ+jgk4TdYmnvGacMosPid4cleZuwv+BxC81VmtY9N1zbges
         GKBQ8DW0xLs8fx6I2LPMvBsyuPJUT5HPhsekvXfDeiuDL+ER5ZuDokuUipKL49dEBixn
         e166LSw4c2O50P0bHYbzh9UmXea0mo927zdS/XLiBZ3Kb3FVS3nx+kFxl/qHa16efIQk
         ypm0c2nwW3D4cViEG1QHv4ceetOaNk1UtguOPF/ibj7WGVzlaNvtCVGSMsMV+bU3RBBr
         aWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267205; x=1719872005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76LFhxWAz9rsUDfyu0ZAqwdO5Q1o/DxY2U4IiHgYPj4=;
        b=MyP2AZche4UwEne0zJhanmoeGo3WufunFAKZzo0hebxIkJGY4dnsH3a4DW8A+aMQFI
         ds5Wz01+UnpZSL6o2pdHiNt60is4mM0SbnQv2iXQmdwBLxyUy8PimDxaT5PgcGbpLPSK
         PcoFqBwslksOhceuHBDOJKOdgUR95fEvDa9WiQsp7tKXrmRpY3fmvbRwncnBTop2N5yH
         RXUub+VE21wI5L39lheNwaSOsn+py2zec5+ymxAo5cZBpw2+6X8K+yT+wsjhLlqg2mW0
         0mWcJOXhPyWgYmy6gDOGraYG3POiWlmta+5+HziH802xclq0W1/2L/ntG8Er9BwWlIwH
         GuCQ==
X-Gm-Message-State: AOJu0YwJAH4zRd1M2csTk65kn1S7q9bjsfBTd3u/0Pi5HcRDONjofC91
	VMGsZNpZLGtgak1FJgKE+H32aWdQEE5E0f7GouX4Io+ME/t/42lKpoZ+CDcm7VchLFOJMJtWsTG
	yriK3pQKm7NA7ZDYp6ADnelRU93s=
X-Google-Smtp-Source: AGHT+IEpzBu2+res5naA7AsYHZN2ZhBaaDuZvb33YSn7EYjlR2SFjfiQJlGirLiFRRMB2ojEG5MV4UxAJBFuCEPL0D4=
X-Received: by 2002:a05:6602:2c82:b0:7eb:f3c8:c59f with SMTP id
 ca18e2360f4ac-7f3a75357e6mr695367939f.11.1719267204674; Mon, 24 Jun 2024
 15:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com> <7c3b545ee5ea3a0e6686594afe582fa1a19929f6.1718899877.git.gitgitgadget@gmail.com>
In-Reply-To: <7c3b545ee5ea3a0e6686594afe582fa1a19929f6.1718899877.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Jun 2024 15:13:13 -0700
Message-ID: <CABPp-BHnUpPgg_wP67q2eSB_j01urbEaPV2Dqk1L+gUfqbZtpA@mail.gmail.com>
Subject: Re: [PATCH 2/5] sparse-index: refactor path_found()
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
> In advance of changing the behavior of path_found(), take all of the
> intermediate data values and group them into a single struct. This
> simplifies the method prototype as well as the initialization. Future
> changes can be made directly to the struct and method without changing
> the callers with this approach.
>
> Note that the clear_path_found_data() method is currently empty, as
> there is nothing to free. However, this will change in the future, so
> place the method and its callers for now.

I can't parse the second half of the final sentence.  What was meant here?

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  sparse-index.c | 45 +++++++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index e0457c87fff..de6e727f5c1 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -439,8 +439,22 @@ void ensure_correct_sparsity(struct index_state *ist=
ate)
>                 ensure_full_index(istate);
>  }
>
> -static int path_found(const char *path, const char **dirname, size_t *di=
r_len,
> -                     int *dir_found)
> +struct path_found_data {
> +       const char *dirname;
> +       size_t dir_len;
> +       int dir_found;
> +};
> +
> +#define PATH_FOUND_DATA_INIT { \
> +       .dir_found =3D 1 \
> +}
> +
> +static void clear_path_found_data(struct path_found_data *data)
> +{
> +       return;
> +}
> +
> +static int path_found(const char *path, struct path_found_data *data)
>  {
>         struct stat st;
>         char *newdir;
> @@ -450,7 +464,7 @@ static int path_found(const char *path, const char **=
dirname, size_t *dir_len,
>          * If dirname corresponds to a directory that doesn't exist, and =
this
>          * path starts with dirname, then path can't exist.
>          */
> -       if (!*dir_found && !memcmp(path, *dirname, *dir_len))
> +       if (!data->dir_found && !memcmp(path, data->dirname, data->dir_le=
n))
>                 return 0;
>
>         /*
> @@ -472,15 +486,16 @@ static int path_found(const char *path, const char =
**dirname, size_t *dir_len,
>          * If path starts with directory (which we already lstat'ed and f=
ound),
>          * then no need to lstat parent directory again.
>          */
> -       if (*dir_found && *dirname && memcmp(path, *dirname, *dir_len))
> +       if (data->dir_found && data->dirname &&
> +           memcmp(path, data->dirname, data->dir_len))
>                 return 0;
>
>         /* Free previous dirname, and cache path's dirname */
> -       *dirname =3D path;
> -       *dir_len =3D newdir - path + 1;
> +       data->dirname =3D path;
> +       data->dir_len =3D newdir - path + 1;
>
> -       tmp =3D xstrndup(path, *dir_len);
> -       *dir_found =3D !lstat(tmp, &st);
> +       tmp =3D xstrndup(path, data->dir_len);
> +       data->dir_found =3D !lstat(tmp, &st);
>         free(tmp);
>
>         return 0;
> @@ -488,9 +503,7 @@ static int path_found(const char *path, const char **=
dirname, size_t *dir_len,
>
>  static int clear_skip_worktree_from_present_files_sparse(struct index_st=
ate *istate)
>  {
> -       const char *last_dirname =3D NULL;
> -       size_t dir_len =3D 0;
> -       int dir_found =3D 1;
> +       struct path_found_data data =3D PATH_FOUND_DATA_INIT;
>
>         int path_count =3D 0;
>         int to_restart =3D 0;
> @@ -502,7 +515,7 @@ static int clear_skip_worktree_from_present_files_spa=
rse(struct index_state *ist
>
>                 if (ce_skip_worktree(ce)) {
>                         path_count++;
> -                       if (path_found(ce->name, &last_dirname, &dir_len,=
 &dir_found)) {
> +                       if (path_found(ce->name, &data)) {
>                                 if (S_ISSPARSEDIR(ce->ce_mode)) {
>                                         to_restart =3D 1;
>                                         break;
> @@ -516,14 +529,13 @@ static int clear_skip_worktree_from_present_files_s=
parse(struct index_state *ist
>                            "sparse_path_count", path_count);
>         trace2_region_leave("index", "clear_skip_worktree_from_present_fi=
les_sparse",
>                             istate->repo);
> +       clear_path_found_data(&data);
>         return to_restart;
>  }
>
>  static void clear_skip_worktree_from_present_files_full(struct index_sta=
te *istate)
>  {
> -       const char *last_dirname =3D NULL;
> -       size_t dir_len =3D 0;
> -       int dir_found =3D 1;
> +       struct path_found_data data =3D PATH_FOUND_DATA_INIT;
>
>         int path_count =3D 0;
>
> @@ -537,7 +549,7 @@ static void clear_skip_worktree_from_present_files_fu=
ll(struct index_state *ista
>
>                 if (ce_skip_worktree(ce)) {
>                         path_count++;
> -                       if (path_found(ce->name, &last_dirname, &dir_len,=
 &dir_found))
> +                       if (path_found(ce->name, &data))
>                                 ce->ce_flags &=3D ~CE_SKIP_WORKTREE;
>                 }
>         }
> @@ -546,6 +558,7 @@ static void clear_skip_worktree_from_present_files_fu=
ll(struct index_state *ista
>                            "full_path_count", path_count);
>         trace2_region_leave("index", "clear_skip_worktree_from_present_fi=
les_full",
>                             istate->repo);
> +       clear_path_found_data(&data);
>  }
>
>  void clear_skip_worktree_from_present_files(struct index_state *istate)
> --
> gitgitgadget

It's surprising how much a simple, straightforward translation of the
code can improve its readability; I should have done it this way all
along.
