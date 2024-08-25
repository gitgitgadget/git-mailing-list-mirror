Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29CE33CD2
	for <git@vger.kernel.org>; Sun, 25 Aug 2024 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724567919; cv=none; b=ZPdFiu+ROHWonPTBjTRPwEyYQgFU4VKRh5fJJ4ZPPv4YYjQYxKS9tO0gOC0ShcGU+DMzK1wQZgh6DN4qPjGPKXsKXzKy/T2J+Hjk60na55xZ+d9iTR+VfTXT92iq/XQsrCxh/wt1vOKjrNZa9BWwSY+lMESK39Vn3FnVqZBFFP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724567919; c=relaxed/simple;
	bh=NZbfdZPomWZYnB2BJB4zFVAPtEAuD3NyPxk3t7AZHCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXSAK3dXU3KMf0+YLTHwPkPGsVVh6sp02ede1dVD+J7mQDd9KxRr5SpnckRxnrFSCG70jcj6GklcWE50yfDxY0jcWCzc0h4wfpu+SgXN5bNa84tNGs3QZBAO9hSW8jO7Aae65hhagNLPurUyYuAb7Wb2NTsPKNDtqOSiRQHianc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vo7cNfQ/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo7cNfQ/"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f3cb747fafso35688431fa.3
        for <git@vger.kernel.org>; Sat, 24 Aug 2024 23:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724567916; x=1725172716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bSeJRYjerop2S+IHUbZj+Mq50183V7guMC7AsL3MZY=;
        b=Vo7cNfQ/YKUiEFco3G/j3I0YTLZ6Iw2rxAzzj7TA9UyHs1QOT8cDQ/oEwpRZiLSv6H
         c89dsG5nq+OrGK84tRKAATlYQU/PZuzely69i9hGC5/kw38fLbaoCv0mXaa1b5+hdA1i
         QVFr+zF/ZnuPNsPQ5IlvoHPPU3kZu6rAvlkYaw/ppA8SUjX/XgiaI/ediUfFe6fg7e82
         ghp9Blf9J5W9/v1+xSmck7fH+cYP4GlGfaoKsuxdOnO3dPwAtj52hHba4lwz3h309R7u
         ffEHP6PqfiNYsbMfVeMbYPci5avXMdOqol0qR7In7gwXrwgXN3iCx0+wGMw1x850Jqsu
         uZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724567916; x=1725172716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bSeJRYjerop2S+IHUbZj+Mq50183V7guMC7AsL3MZY=;
        b=YNpAPhEkuQtFarfrSKTMaOvwhmmZAzQbUVneC8zfGoe6f0pXLLeIuixYNioPfWBlNf
         PHunmQbtfI/mn+Bz688l+ZWmoiom4H1wlcWtuYBx5jU4aL54OsXqrGDtcy/F8atMF6qD
         zp8y2W1OtOT5WcYNAO75Y/4Rzh9vvUzQoqlHn2wax65ntenEiW7WSzeLuLpV7RCCRiKW
         ySQuBQHa+QakC/dPV4R4Ly75rgUAcq6KP3ZEabjdQ7o6j6Q7udF0Cntg0D11smtOK3Bf
         63goCwysUGwuc4zF2O3NPuqTWKpZCv0cyEJ8I6z5TYwsSjktyaceE1PSsy38mywUDVjW
         AXWw==
X-Gm-Message-State: AOJu0Yy1DdfMSVNgGoDx9HZgP/4NMsY1Nfh00C63s3QSkx0ew9BanoWp
	ZRcPnkzz86eP/qpw3O3TZoQHY4sIwdYCabtaH94dEzwvrAjkOkP6kmYoEqinW3BRbEVUrrwChj1
	31WqBsD83M2ezXr99jPhQIb1ms9s=
X-Google-Smtp-Source: AGHT+IHaOdcUPgac+BtcXXkhwHANonKhQqg+KJvuMQWCjU8/3R7CQP5hEsJmNIv+4crXt5Fnc7Fexnzcmp7NMUbTvYU=
X-Received: by 2002:a05:651c:545:b0:2f1:6cd6:c880 with SMTP id
 38308e7fff4ca-2f4f493872dmr50923111fa.37.1724567914840; Sat, 24 Aug 2024
 23:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803132206.72166-1-shyamthakkar001@gmail.com> <20240824170223.36080-1-shyamthakkar001@gmail.com>
In-Reply-To: <20240824170223.36080-1-shyamthakkar001@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 25 Aug 2024 08:38:22 +0200
Message-ID: <CAP8UFD3mq+k8QXDrFAp5bfoCN+sNgm3vJvuhryxVYDaj-SZU0g@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3] t: port helper/test-oid-array.c to unit-tests/t-oid-array.c
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 7:02=E2=80=AFPM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> helper/test-oid-array.c along with t0064-oid-array.sh test the
> oid-array.h API, which provides storage and processing
> efficiency over large lists of object identifiers.
>
> Migrate them to the unit testing framework for better runtime
> performance and efficiency. Also 'the_hash_algo' is used internally in
> oid_array_lookup(), but we do not initialize a repository directory,
> therefore initialize the_hash_algo manually.

Even if 'the_hash_algo' is used internally in oid_array_lookup()
through oid_pos(), this patch initializes the hash algo for the repo
using repo_set_hash_algo(), which contains the following single
instruction:

    repo->hash_algo =3D &hash_algos[hash_algo];

So "therefore initialize the_hash_algo manually" is not quite true, as
it doesn't look like 'the_hash_algo' is even used.

Also I think it's not clear how initializing a repository directory is
related to the hash algo.

So maybe something like the following would be better:

"As we don't initialize a repository in these tests, the hash algo
that functions like oid_array_lookup() use is not initialized,
therefore call repo_set_hash_algo() to initialize it."

> And
> init_hash_algo():lib-oid.c can aid in this process, so make it public.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
> Changes in v3:
>  - changed commmit message and comments for more accurate description
>  - removed test_min() and return early when actual.nr and expect.nr
>    don't match
>  - rename result to expect for more accurate description
>  - removed a redundant check in t_enumeration()
>  - add check_int() around one of calls of get_oid_arbitrary_hex()

This looks good.

>  - rebased to latest master

It's nice to say it was rebased, but it's better to tell the reason
why it was rebased.

> diff --git a/t/unit-tests/lib-oid.h b/t/unit-tests/lib-oid.h
> index 8d2acca768..c949af082c 100644
> --- a/t/unit-tests/lib-oid.h
> +++ b/t/unit-tests/lib-oid.h
> @@ -13,5 +13,13 @@
>   * environment variable.
>   */
>  int get_oid_arbitrary_hex(const char *s, struct object_id *oid);
> +/*
> + * Returns one of GIT_HASH_{SHA1, SHA256, UNKNOWN} based on the value of
> + * GIT_TEST_DEFAULT_HASH environment variable. The fallback value in cas=
e
> + * of absence of GIT_TEST_DEFAULT_HASH is GIT_HASH_SHA1. It also uses

Nit: maybe: s/in case of absence/in the absence/

> + * check(algo !=3D GIT_HASH_UNKNOWN) before returning to verify if the
> + * GIT_TEST_DEFAULT_HASH's value is valid or not.
> + */
> +int init_hash_algo(void);

[...]

> +static void t_enumeration(const char **input_args, size_t input_sz,
> +                         const char **expect_args, size_t expect_sz)
> +{
> +       struct oid_array input =3D OID_ARRAY_INIT, expect =3D OID_ARRAY_I=
NIT,
> +                        actual =3D OID_ARRAY_INIT;
> +       size_t i;
> +
> +       if (fill_array(&input, input_args, input_sz))
> +               return;
> +       if (fill_array(&expect, expect_args, expect_sz))
> +               return;
> +
> +       oid_array_for_each_unique(&input, add_to_oid_array, &actual);
> +       if(!check_uint(actual.nr, =3D=3D, expect.nr))

Missing space between 'if' and '('.

> +               return;

The rest of the patch looks good to me. Thanks.
