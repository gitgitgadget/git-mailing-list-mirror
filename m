Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343073208
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029439; cv=none; b=QvaZfdbG6SnBW75IGhc1G7ddcPLpS/oGzE8+vlfqFaZ+NGCfN2t/WRC/4b2ko1GHk5LwYBcFu8WfhwsyHRsmcj/IUt+vbpy7L4GWYvbOUX2f7zryYSajVqAi3o4DjKHaJwYzQBZ8iyuYZRODR6JQo35pcR02Y9tsq08KD5w/Ha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029439; c=relaxed/simple;
	bh=UpQNzqhVEkr/N89D4JbDhmLndcpKjzCPxrl8SvlT3c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKZUFzjEpvnMms+HvEXV/QNnvCmRzY4EImEMnzgqZEJCCZiTIoF66b15cNVsqx/C3i771/ezsBRHm6UWuMpalx6n6r+5L5DimMbyvMp3ObTxlP2cjbT2HtZIeA2gGkrTzA7OruQlCw4p1qAqHuVpdB/UNBgOLHT+ANSooYSBcLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVZLIFSg; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVZLIFSg"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so114542766b.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 19:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752029435; x=1752634235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzbIW+nBKk/AeuYCo255zB/OnRf+Xua14tl1fq9ydwE=;
        b=CVZLIFSgnyLlpqu/P6/rT5sSN2Ndsttaur6nezmaBeLgJzxM5iFT3sZlzBmN0iPExZ
         I3QPL7F2rycnZI7+85zaAiq+gpli1PS97iERLGV4Y57dBHaYvMkYtHCeGc0O+8YHEgqb
         Q1qZgUpOinD5TSh0BeS8a1ypPtxOEeAFn2SBr8xqmylkbaTz0qFe6RYDrmu7UZAAV3YT
         ANQd1Z1+Yl7U+Y7W/UEpxXKZWr/lsNuifTD1Tqs1uVavtbqc9PzCiDHQlIJEbWe4YVCl
         MRFpdTPMf045zXtSsVjjigUUFrmb5/zNNtFeO3h2MFS33C9HCChGGW49pBp/b0oRfFL/
         vPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029435; x=1752634235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzbIW+nBKk/AeuYCo255zB/OnRf+Xua14tl1fq9ydwE=;
        b=dTb5phy80Ob+6IHgLDw7B0YSyIl7ftdqctu6N7ZH08RDLao5SMfYSWbKWMVyI0DaFS
         MlBXxk3nXAqTEAgcOAib3hqg/fZactE0opJXOYiPA4C5m2Jksaxae600NsEDNzz2APUx
         kOsXOWLEabhfTOFF6EUWnVWWvTKLLVDqTdhnU6lj4eFCBwv0w13uPdq2hDG3noCUJoNy
         oplbqAPVM2yE4C+9mVnJlaBlR2TY4UzLs50hei4foCT9VpZd3IysAW1JfYwjGSmSDHrF
         TX6uWtPVDXLQlCWYJGatye8F+YlijbQmLfUsIxguX8ltjyNC+e22zZ9FB/q/xxqQVZ8F
         dsuw==
X-Gm-Message-State: AOJu0YxoQRp0pw9YOk8Fj61QhtkQG/xTcBUxNhhXsMacceut0hRpNSEo
	Eeijkm96OxCVlKDnsbWEr6DFw7Q57rblb5wFqHEMaLWwlLiV9BXQrHoUy0vJlc+U9mKXy58L1I6
	yOy25OX2PoIH2DxIB2sQSypO80yftx/SudJHz
X-Gm-Gg: ASbGnctk/LmcIlBLJW2nk/efStPwQdP8qAMAJl69K1TdZ8ngifCJEQok2cnh0dJREvP
	k0Jc6/M7us1pq5OHTx72BQ+pryr8c3YZNCxm9t0d7ByifoIalbk3xztn+uK/PGXSvIR+L0yH4BT
	TiEInEUqnc4TdbFNqzycQun5WNdbUBVFPnFzNluWF2rVI3+yS1l3JPAtu9q0sciNiCqnRTMyaDn
	Uuj3A==
X-Google-Smtp-Source: AGHT+IEkvR/Dgu3RSI9rphGTR7n1NpRAjb36c31HQy1yycaPGJ62ZBnZWmlX2k3DNwTkqwGAVaGOj2D/SfrmYZHFebQ=
X-Received: by 2002:a17:907:7f86:b0:ae3:d0fe:a35e with SMTP id
 a640c23a62f3a-ae6d12d4a89mr64934166b.11.1752029435220; Tue, 08 Jul 2025
 19:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLdTT3kdELUyHdZLWyy8e6AbfRU7kDFcVUdCmVtDi11hMw@mail.gmail.com>
 <20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com> <20250608032705.11990-3-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20250608032705.11990-3-jayatheerthkulkarni2005@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 8 Jul 2025 22:50:23 -0400
X-Gm-Features: Ac12FXw3nfpnbNPVvVt7e-WzN0AjEP-Z8AOQkmgOyBZuexfPTPpoo4UBqh9uM0c
Message-ID: <CALnO6CAXermmya0UjTHU2gPoEAb1m32fOt7Uzf6CL2mSJ=RkTg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] submodule: skip redundant active entries when
 pattern covers path
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 11:28=E2=80=AFPM K Jayatheerth
<jayatheerthkulkarni2005@gmail.com> wrote:
>
> configure_added_submodule always writes an explicit submodule.<name>.acti=
ve
> entry, even when the new path is already matched by submodule.active
> patterns. This leads to unnecessary and cluttered configuration.
>
> change the logic to centralize wildmatch-based pattern lookup,
> in configure_added_submodule. Wrap the active-entry write in a conditiona=
l
> that only fires when that helper reports no existing pattern covers the
> submodule=E2=80=99s path.

I use submodules, but am not too familiar with their internals, so I
find it hard to follow the details here. Perhaps some examples showing
when the configuration becomes cluttered and what about it is
cluttered would help?

When I check a repo of mine that has ~50 submodules:

    git config get submodule.active
    .
    git config get --show-names --regexp 'submodule.*active'
    submodule.active .

So I'm not seeing this in practice, though I didn't try with the test
case in the patch.

[Nit: s/change/Change]

>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  builtin/submodule--helper.c    | 32 +++++++++++++++++++++-----------
>  t/t7413-submodule-is-active.sh | 15 +++++++++++++++
>  2 files changed, 36 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 9f6df833f0..514abe480e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -32,6 +32,8 @@
>  #include "advice.h"
>  #include "branch.h"
>  #include "list-objects-filter-options.h"
> +#include "wildmatch.h"
> +#include "strbuf.h"
>
>  #define OPT_QUIET (1 << 0)
>  #define OPT_CACHED (1 << 1)
> @@ -3328,6 +3330,9 @@ static void configure_added_submodule(struct add_da=
ta *add_data)
>         char *key;
>         struct child_process add_submod =3D CHILD_PROCESS_INIT;
>         struct child_process add_gitmodules =3D CHILD_PROCESS_INIT;
> +       const struct string_list *values;
> +       size_t i;
> +       int matched =3D 0;
>
>         key =3D xstrfmt("submodule.%s.url", add_data->sm_name);
>         git_config_set_gently(key, add_data->realrepo);
> @@ -3370,20 +3375,25 @@ static void configure_added_submodule(struct add_=
data *add_data)
>          * is_submodule_active(), since that function needs to find
>          * out the value of "submodule.active" again anyway.
>          */
> -       if (!git_config_get("submodule.active")) {
> -               /*
> -                * If the submodule being added isn't already covered by =
the
> -                * current configured pathspec, set the submodule's activ=
e flag
> -                */

Do we want to lose this comment? The replacement below ("=E2=80=A6 ->
force-enable") is a bit terse for me and rather loses some
information.

> -               if (!is_submodule_active(the_repository, add_data->sm_pat=
h)) {
> -                       key =3D xstrfmt("submodule.%s.active", add_data->=
sm_name);
> -                       git_config_set_gently(key, "true");
> -                       free(key);
> -               }
> -       } else {
> +       if (git_config_get("submodule.active") || /* key absent */
> +           git_config_get_string_multi("submodule.active", &values)) {
> +               /* submodule.active is missing -> force-enable */
>                 key =3D xstrfmt("submodule.%s.active", add_data->sm_name)=
;
>                 git_config_set_gently(key, "true");
>                 free(key);
> +       } else {
> +               for (i =3D 0; i < values->nr; i++) {
> +                       const char *pat =3D values->items[i].string;
> +                       if (!wildmatch(pat, add_data->sm_path, 0)) { /* m=
atch found */
> +                               matched =3D 1;
> +                               break;
> +                       }
> +               }
> +               if (!matched) { /* no pattern matched -> force-enable */
> +                       key =3D xstrfmt("submodule.%s.active", add_data->=
sm_name);
> +                       git_config_set_gently(key, "true");
> +                       free(key);
> +               }
>         }
>  }
>
> diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active=
.sh
> index 9509dc18fd..a42060cac9 100755
> --- a/t/t7413-submodule-is-active.sh
> +++ b/t/t7413-submodule-is-active.sh
> @@ -124,4 +124,19 @@ test_expect_success 'is-active, submodule.active and=
 submodule add' '
>         git -C super2 config --get submodule.mod.active
>  '
>
> +test_expect_success 'submodule add skips redundant active entry' '
> +       git init repo &&
> +       (
> +               cd repo &&
> +               git config submodule.active "lib/*" &&
> +               git commit --allow-empty -m init &&
> +
> +               git init ../lib-origin &&
> +               git -C ../lib-origin commit --allow-empty -m init &&
> +
> +               git submodule add ../lib-origin lib/foo &&
> +               ! git config --get submodule.lib/foo.active

(Not my area of expertise) Should this be test_must_fail?

> +       )
> +'
> +
>  test_done
> --
> 2.49.GIT
>
>


--=20
D. Ben Knoble
