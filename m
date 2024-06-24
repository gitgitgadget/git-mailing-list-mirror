Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F143A1A256A
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267221; cv=none; b=eYnl92eOwVqL4PRlNz+Vv0eTdHAQNCbZQ25n3UhSJQLrgHDeWMq6WFTiPrpaFk30xtwe7CluNpEoj2EbKKd/o8cpwTTG+JIZBiKsfF7L6isj0Eb7D4cXimdvx2ocavxYH3lU/uuvylbduRngD2fCv9rGvfSVV1D0tNZr3eX8UiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267221; c=relaxed/simple;
	bh=ux4oAgf+A1zo2wStS2VFk827FXC/D/fadovyf+pIdL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtoxKZPMOIzC4YnnooyUX6VohP6D5fEvuo7Dn1XDN4Ee7ouwypG2RZIwhJbSTFQO8hNUjv0eY6np4LkJ/25Aq75WbU5YXNQMdd16ZQSyN37M0Yg+F/ECZJzymKVkJITQtWu7RM2patR2h6Kq0e0zkIdXwFHL602ptWoHDlE3Wkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5aOVuNL; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5aOVuNL"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7eb671a835fso280751739f.2
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 15:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719267219; x=1719872019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9jE+L/ETpfED9P/lYSwutixs/u22brr7koPrJ3xg6o=;
        b=X5aOVuNLxhBUYS5GUppWDE6ZP9QZL5iTmtEz+8puNVAQ4jpnBNv35ROKl4DMPjTih0
         m3EPOK+nSo8Ovl4bwyjZFDViTXH4Rz9/LUiW+fyXOoBosAydenGiIBZKFNznxOV5lc4z
         fnEqe8CjvPeVaeju/C41mBIGbvJISmy8kvU7VHQMi5GG5K96i6N+/E4GQL9ClQ8BHm9V
         pf0d/eqy8p3auaqMRv/1d7LtW0HQr28oLsInojgYzg9G/Hq01tKSfybnOj2UY+zSF6wS
         ixXXAk770AVB0BKqwUOmCBpqYACIZZILY07tl/8vxclzEbfui6XxxhrRwS66BwEIMO37
         1FUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267219; x=1719872019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9jE+L/ETpfED9P/lYSwutixs/u22brr7koPrJ3xg6o=;
        b=OG4i4sbomnj8dn2p0wAL7Ovte6RCwylmsMmXu6bfQ3QWkfkAUZjPMyx0dSM2SsvQqk
         naqm2KuK3jE5wojX6vWGYU4hvV/9OBK1Rd72Kmm+gjJlQYx9P+Alc08S5YGzUeHsef7V
         EhuVlV3b5y96AOuZETMygWFkJx1kgBNU0DuX4T7vAGDn0dOvnRj6X9cEkOwVSTDNmLNC
         sm05rdylqYA71ZVu6MdfuSzNkoR839VY8uKR2sy2src8thxSVc2aBHiUV1pP7HRvX1Ol
         tNo+IrrBocGWrN7FOqcL+ZJmvHJFKWgMWmJPdP2HHICn1RW0yxTiyIUuK2PtNyRd2EnF
         LMgg==
X-Gm-Message-State: AOJu0YzaYy7J24fNgVCYnjEgmlx3omqFTZTUkkPBViaPs/aQ45w34tMe
	jo2AK081GGD0V9V5fNcnxlOS9mzXTj/Rxzrfr2SZAjSckCyC1i04cOiVdUYKkPXByb2wymDnGiX
	Z3+3dl1Y8i0UIs/HiPPKLUTS2U7k=
X-Google-Smtp-Source: AGHT+IFhPWe14fys81tmQ0m8+zpvNi7tAPa2VLr7LtSNtpYdV4zAC8u4qM/leDLH94NJ0VLZAFtwUvcNiocJ2tEKT7k=
X-Received: by 2002:a05:6602:2dc1:b0:7eb:6d0a:613e with SMTP id
 ca18e2360f4ac-7f3a4dcf79fmr735570839f.7.1719267219075; Mon, 24 Jun 2024
 15:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com> <217594ffb103969c1a6debc07a6c7f72f6ee4749.1718899877.git.gitgitgadget@gmail.com>
In-Reply-To: <217594ffb103969c1a6debc07a6c7f72f6ee4749.1718899877.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Jun 2024 15:13:28 -0700
Message-ID: <CABPp-BE4f6_zQmFiH6sxonyVt2nMOjZN4gHrP8_rNv95GpLPpw@mail.gmail.com>
Subject: Re: [PATCH 3/5] sparse-index: use strbuf in path_found()
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
> The path_found() method previously reused strings from the cache entries
> the calling methods were using. This prevents string manipulation in
> place and causes some odd reallocation before the final lstat() call in
> the method.
>
> Refactor the method to use strbufs and copy the path into the strbuf,
> but also only the parent directory and not the whole path. This looks
> like extra copying when assigning the path to the strbuf, but we save an
> allocation by dropping the 'tmp' string, and we are "reusing" the copy
> from 'tmp' to put the data in the strbuf.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  sparse-index.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index de6e727f5c1..fec4f393360 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -440,31 +440,30 @@ void ensure_correct_sparsity(struct index_state *is=
tate)
>  }
>
>  struct path_found_data {
> -       const char *dirname;
> -       size_t dir_len;
> +       struct strbuf dir;
>         int dir_found;
>  };
>
>  #define PATH_FOUND_DATA_INIT { \
> +       .dir =3D STRBUF_INIT, \
>         .dir_found =3D 1 \
>  }
>
>  static void clear_path_found_data(struct path_found_data *data)
>  {
> -       return;
> +       strbuf_release(&data->dir);
>  }
>
>  static int path_found(const char *path, struct path_found_data *data)
>  {
>         struct stat st;
>         char *newdir;
> -       char *tmp;
>
>         /*
>          * If dirname corresponds to a directory that doesn't exist, and =
this
>          * path starts with dirname, then path can't exist.
>          */
> -       if (!data->dir_found && !memcmp(path, data->dirname, data->dir_le=
n))
> +       if (!data->dir_found && !memcmp(path, data->dir.buf, data->dir.le=
n))
>                 return 0;
>
>         /*
> @@ -486,17 +485,15 @@ static int path_found(const char *path, struct path=
_found_data *data)
>          * If path starts with directory (which we already lstat'ed and f=
ound),
>          * then no need to lstat parent directory again.
>          */
> -       if (data->dir_found && data->dirname &&
> -           memcmp(path, data->dirname, data->dir_len))
> +       if (data->dir_found && data->dir.buf &&
> +           memcmp(path, data->dir.buf, data->dir.len))
>                 return 0;
>
>         /* Free previous dirname, and cache path's dirname */
> -       data->dirname =3D path;
> -       data->dir_len =3D newdir - path + 1;
> +       strbuf_reset(&data->dir);
> +       strbuf_add(&data->dir, path, newdir - path + 1);
>
> -       tmp =3D xstrndup(path, data->dir_len);
> -       data->dir_found =3D !lstat(tmp, &st);
> -       free(tmp);
> +       data->dir_found =3D !lstat(data->dir.buf, &st);
>
>         return 0;
>  }
> --
> gitgitgadget

Another simple translation; the series looks good so far...
