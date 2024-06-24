Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2216C1A0B10
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267233; cv=none; b=NPxTnqd4mMK4tgR6T6hHCH5eNGu/bwnBvWZbncIhCpVdh4B60t/XNkY5PkVMOg/woo7ltU/6xXAXlwUBknCGciwcR+v7aP7P5LRQcKItWAIgo6tCCSD/oTHpJWLlmeWqgqy59Yq/rm8uim3u3BGKuQ2gqx8T334h4wUvl/TLIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267233; c=relaxed/simple;
	bh=zG1Aqz+fS4x/50iSDaTX7Ry9BH/MrncBJAT7/YNjuBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhNSBemwK5X3P4v6OMazMgk0fMiCfGqQDn4JQpkn+7TcxyxXjw+Mh9iIWVG7Ku3dqFEtEoxXEXV0Gh6yj1krd4xZzg41s/Cc3nFc/77BsDCxtrz0FwIOdTnWaxpW8gM6DO70/pw8GIVkFhQVajugFxvmkRmsyfjGpf942q9yakU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6BqvOXF; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6BqvOXF"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7ebe019b9cdso180890739f.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 15:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719267231; x=1719872031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0Og6rQf28k9CrgfPuRcg+qA4dwGQncogsg9/LTLb1k=;
        b=T6BqvOXFASGU3bQwTG3eABj3fxuACvOIVxNIxggtigKqfVEGMxyMd7+k5C8sRbkKdB
         kJKi+CiWX1ieSVKcY2KL3M1Dq6jCOswtIbVdlV6RQeQoCSMfd/z+1BSNReURIOSOFnO/
         GdlKsH75UOqdFf4TrvvO23LsqrUR63r14oTL/WGAoZXQrvYn3YfA2lWiJKsEhkXyA251
         sD5sW56emg9EfP0oNDvWOcY3ipGpt2t5AMhJ+BxiEs4f5LsN1HnA2S9WGgsOv6+doJhs
         gl4fV+7ncwlXaLIodK6KxflkdzOIuqabq27ZLqMrKf+oQb+88tY/aujeANH3CRTUnOsD
         KMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267231; x=1719872031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0Og6rQf28k9CrgfPuRcg+qA4dwGQncogsg9/LTLb1k=;
        b=OlzSYGz0/TpPa5MuL8eb7Dg4lT7cuer0hcaD8EydNYHOdRXT0zt75iPDLyox11kR03
         hZxO9AoM3d4SohMn8fsS8uwxEUSj9/WMCrkQLBFEVOEzmh+GMWw4aubWXmAwTWdG46qx
         +O5EqRFjvsGtaBkpc+E2kCkZU47zd+tUQwd5jKfcSAFbbUEC7Fy55eoNysacFK1hmh5l
         vzdUu/GXUQQ+m+rijBG4gsSDfbzcZAK6S3rG2S+60vFJ9sZYImcnjkQ/cYJVfltABIlN
         ekFQkoUJyGzkJvYGSNSrtqfb/Etg8F+gdEO8fbO2qZU00DMvqD6Jb0iBrbIsG7TwbGQZ
         JiTA==
X-Gm-Message-State: AOJu0YweNY+2hx8GsKn7ZJ+bc7/uGb+EnJTZK2B530GiNQPbzyC6Prga
	oXGt9v3XQNrqwwWDNhtAHD3q7BKIhP21eJmHd7/GHseGUMslHLYemXyH9jJxbykGbHFu6TxGG1K
	PC3T5Uf8VcNMnRONJzSpgxa2w+Is=
X-Google-Smtp-Source: AGHT+IHnuwo0eOx5NAaZm+tgR6rFaIxBC1IOkx28w014YmxfDqhSRLoepYN+eYmZPQLFos7BYdol4U6+M0WI1xi95rU=
X-Received: by 2002:a05:6602:3f87:b0:7f3:a7d9:5922 with SMTP id
 ca18e2360f4ac-7f3a7d95ce7mr590335339f.8.1719267231257; Mon, 24 Jun 2024
 15:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com> <88a3145e585169fde8cd7d43a435daa07eb82667.1718899877.git.gitgitgadget@gmail.com>
In-Reply-To: <88a3145e585169fde8cd7d43a435daa07eb82667.1718899877.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Jun 2024 15:13:40 -0700
Message-ID: <CABPp-BH6apqur+zzE12yqL1ZHNP30_2MFgEEeGxYa2K3f7hNRw@mail.gmail.com>
Subject: Re: [PATCH 4/5] sparse-index: count lstat() calls
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, anh@canva.com, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 10:12=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> The clear_skip_worktree.. methods already report some statistics about
> how many cache entries are checked against path_found() due to having
> the skip-worktree bit set. However, due to path_found() performing some
> caching, this isn't the only information that would be helpful to
> report.
>
> Add a new lstat_count member to the path_found_data struct to count the
> number of times path_found() calls lstat(). This will be helpful to help
> explain performance problems in this method as well as to demonstrate
> future changes to the caching algorithm in a more concrete way than
> end-to-end timings.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  sparse-index.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index fec4f393360..8577fa726b8 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -442,6 +442,7 @@ void ensure_correct_sparsity(struct index_state *ista=
te)
>  struct path_found_data {
>         struct strbuf dir;
>         int dir_found;
> +       size_t lstat_count;
>  };
>
>  #define PATH_FOUND_DATA_INIT { \
> @@ -469,6 +470,7 @@ static int path_found(const char *path, struct path_f=
ound_data *data)
>         /*
>          * If path itself exists, return 1.
>          */
> +       data->lstat_count++;
>         if (!lstat(path, &st))
>                 return 1;
>
> @@ -493,6 +495,7 @@ static int path_found(const char *path, struct path_f=
ound_data *data)
>         strbuf_reset(&data->dir);
>         strbuf_add(&data->dir, path, newdir - path + 1);
>
> +       data->lstat_count++;
>         data->dir_found =3D !lstat(data->dir.buf, &st);
>
>         return 0;
> @@ -524,6 +527,8 @@ static int clear_skip_worktree_from_present_files_spa=
rse(struct index_state *ist
>
>         trace2_data_intmax("index", istate->repo,
>                            "sparse_path_count", path_count);
> +       trace2_data_intmax("index", istate->repo,
> +                          "sparse_lstat_count", data.lstat_count);
>         trace2_region_leave("index", "clear_skip_worktree_from_present_fi=
les_sparse",
>                             istate->repo);
>         clear_path_found_data(&data);
> @@ -553,6 +558,8 @@ static void clear_skip_worktree_from_present_files_fu=
ll(struct index_state *ista
>
>         trace2_data_intmax("index", istate->repo,
>                            "full_path_count", path_count);
> +       trace2_data_intmax("index", istate->repo,
> +                          "full_lstat_count", data.lstat_count);
>         trace2_region_leave("index", "clear_skip_worktree_from_present_fi=
les_full",
>                             istate->repo);
>         clear_path_found_data(&data);
> --
> gitgitgadget

Makes sense.  I'm getting really curious to see how this all fits into
the big improvements you made; I guess I'll see that in the next
patch...
