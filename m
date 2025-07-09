Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477B73208
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029450; cv=none; b=g6pKMymnF3qw34iSN5FHz61MMNvxwKO9twfD+ejobA7epy1xiXPSOOi63eh0HkSAXnPc0GvwyLjhkJ/tdai+vgpk2OECBPUi0nxk330Me78iYJnO0q5dYTv0R0oWGzBxCzIvoEBsN6jfdK8Q+ObZ53Fr0eQ8VpMUXgZcypfMAlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029450; c=relaxed/simple;
	bh=lfoaqkF3+2aE2GQLemtnJd8Y6/Av2H0GmsBcpQJFGdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpOwXzTLr8ay0kDHu6zUeOrH8RszFy/+FriIRynFaXntA9dVzbkPc+ZT6Ia3eWYDxsPE0BX+rJrq3j+dWS3ehWs97WFNPp3qCArFjD70oS/1bkym5lzjF6bBTL+tSKDYyQeGYqz7gGEoiamoZHm/CSJH/wemZxTIUd7DrapC80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXjD6efY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXjD6efY"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0dad3a179so875535366b.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 19:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752029446; x=1752634246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAZcGW8Q6u4+UhNk/X/W+PGdwgfcL8ocdF1c3ppWp/Y=;
        b=kXjD6efYoJhv7/gO2KhJvKhEOGb+2LR/tL+1EkC7qopKRGfu8FaH5RKg60Bv6tZNyE
         5Z7zwyiiYRg1rnnNQOvobRnRAeLa7Xs3rFJIK2RbKcw4/l47rQGvmD4QV/TdxAV8mLUR
         8GBdeOLC2gyHepW9SPhK5apSTF1jwgReh6pFbgJC5wxXZm9vwms5aKI90/spu8H61ziT
         iwojoVQg4/NwXN5J9rp/09bWFet13pIZl2tCzZ2qohorn2AdSmTza2OpBfeVpCVBMyFl
         BCx8SOM8PfvE4Y9fnG9OM//8i2m0uDs88MlagHVb8bXA+ODgQqzBGrM3cB2IflBLtCh9
         NAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029446; x=1752634246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAZcGW8Q6u4+UhNk/X/W+PGdwgfcL8ocdF1c3ppWp/Y=;
        b=fQUzXU51uYW4TZlO8sjcJBp8PN48eMWRzl48Ai46tUvdIEsXhweWR7CKk0Tx+vinGv
         qlu6dQjfULKfA9U9AEPvcK4+AjgPHzI+54YUvA/Gmai3M0l/T8EEElrokYrbxL/6ckUi
         2ISd6nP3TJOEKwrwwOBbVr+o5ZDGZO3PNNieBWiZ2tUF8OVcEip8Z1uZh4zG639Pux4F
         CfJ8szH9PtAKLEz7KCfQ4u3/vCXkK7O9tWOZN8t2FjFEZxblSc3TDLcXNMXdjXh61SGu
         +foSSYfZ3fTIO6vWr506s7bWbrSkxfMPMdGz8qlA0Nz0YW/Fhulc4rjyEbFOFX8cv8Xl
         yz4A==
X-Gm-Message-State: AOJu0YwbCfH5p3+by84aKImpY5Ox6l+IKSiNyNmONWaGJnyrgi7ptUSa
	tyFS1TBYGfGWBfez2h6D0DXUNWx6JZh+hBaIoe3bM7yS0lxW1qn6wMTwjV16QEY475MnLs5L3KJ
	uMZDylAkR5sFvPXEqHuzx30EWhKPD7MNVnw==
X-Gm-Gg: ASbGncu/hlCsqArBtrxGtvqC4NDQ0ujCHCLqleM4OVQMBRaDg+3G92G8+GYaIT+URPC
	U6Y4IjtYYsV27LobOwtp0JJnkpWO8ja33GiA6u+Kuab0v1GbmxzKF0bq8o6Vl27pivF88ZggF8b
	fLpKxu6IS6Nzg2y7RWTEeYlK5XesQlyDscxmr+Cko1HUvQAqoN4mEtfn9wRyGurnUN8P74E+tMW
	VKF1A==
X-Google-Smtp-Source: AGHT+IH2EXA/HMj+gjgjYcXUcC7alAPfICpRsw2Uqa2pK6AX7vQCm3/k+h5thte3zQs5xKcfJWCruE3RInl0caeUVZ8=
X-Received: by 2002:a17:907:a42:b0:ae0:a1c2:262e with SMTP id
 a640c23a62f3a-ae6cf798c72mr70711666b.50.1752029446429; Tue, 08 Jul 2025
 19:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLdTT3kdELUyHdZLWyy8e6AbfRU7kDFcVUdCmVtDi11hMw@mail.gmail.com>
 <20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com> <20250608032705.11990-2-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20250608032705.11990-2-jayatheerthkulkarni2005@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 8 Jul 2025 22:50:34 -0400
X-Gm-Features: Ac12FXya5zSxiVPpvkMRsaFxnGY_HBoDLarlG_i6dHPn5ET_GBy7V5wMgmZOyGc
Message-ID: <CALnO6CB5VezYHtp22RNihNtzLXQkP9Ly=hf0V=3A1EsTvKcFgg@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] submodule: prevent overwriting .gitmodules entry
 on path reuse
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 11:28=E2=80=AFPM K Jayatheerth
<jayatheerthkulkarni2005@gmail.com> wrote:
>
> Adding a submodule at a path that previously hosted another submodule
> (e.g., 'child') reuses the submodule name derived from the path. If the
> original submodule was only moved (e.g., to 'child_old') and not renamed,
> this silently overwrites its configuration in .gitmodules.
>
> This behavior loses user configuration and causes confusion when the
> original submodule is expected to remain intact. It assumes that the
> path-derived name is always safe to reuse, even though the name might
> still be in use elsewhere in the repository.
>
> Teach `module_add()` to check if the computed submodule name already
> exists in the repository's submodule config, and if so, refuse the
> operation unless the user explicitly renames or uses force to auto increm=
ent.

I had to read the patch to figure out what "auto increment"
meant=E2=80=94perhaps some accompanying docs in `git help submodule`?

>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  builtin/submodule--helper.c | 28 ++++++++++++++++++++++++++++
>  t/t7400-submodule-basic.sh  | 23 +++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 53da2116dd..9f6df833f0 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -3444,6 +3444,10 @@ static int module_add(int argc, const char **argv,=
 const char *prefix,
>         struct add_data add_data =3D ADD_DATA_INIT;
>         const char *ref_storage_format =3D NULL;
>         char *to_free =3D NULL;
> +       const struct submodule *existing;
> +       struct strbuf buf =3D STRBUF_INIT;
> +       int i;
> +       char *sm_name_to_free =3D NULL;
>         struct option options[] =3D {
>                 OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
>                            N_("branch of repository to add as submodule")=
),
> @@ -3546,6 +3550,29 @@ static int module_add(int argc, const char **argv,=
 const char *prefix,
>         if(!add_data.sm_name)
>                 add_data.sm_name =3D add_data.sm_path;
>
> +       existing =3D submodule_from_name(the_repository,
> +                                       null_oid(the_hash_algo),
> +                                       add_data.sm_name);
> +
> +       if (existing && strcmp(existing->path, add_data.sm_path)) {
> +               if (!force) {
> +                       die(_("submodule name '%s' already used for path =
'%s'"),
> +                       add_data.sm_name, existing->path);
> +               }
> +
> +               /* --force: build <name><n> until unique */
> +               for (i =3D 1; ; i++) {
> +                       strbuf_reset(&buf);
> +                       strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
> +                       if (!submodule_from_name(the_repository,
> +                                               null_oid(the_hash_algo),
> +                                               buf.buf)) {
> +                               break;
> +                       }
> +               }

This isn't typically what I'd expect --force to do, personally, though
in this case it allows me to proceed with an operation that wasn't
allowed otherwise.

Still, I wonder if a user might be confused by "I said 'child' and got
'child2'?"

> +
> +               add_data.sm_name =3D sm_name_to_free =3D strbuf_detach(&b=
uf, NULL);
> +       }
>         if (check_submodule_name(add_data.sm_name))
>                 die(_("'%s' is not a valid submodule name"), add_data.sm_=
name);
>
> @@ -3561,6 +3588,7 @@ static int module_add(int argc, const char **argv, =
const char *prefix,
>
>         ret =3D 0;
>  cleanup:
> +       free(sm_name_to_free);
>         free(add_data.sm_path);
>         free(to_free);
>         strbuf_release(&sb);
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index d6a501d453..f5514decab 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1482,4 +1482,27 @@ test_expect_success '`submodule init` and `init.te=
mplateDir`' '
>         )
>  '
>
> +test_expect_success 'submodule add fails when name is reused' '
> +       git init test-submodule &&
> +       (
> +               cd test-submodule &&
> +               git commit --allow-empty -m init &&
> +
> +               git init ../child-origin &&
> +               git -C ../child-origin commit --allow-empty -m init &&
> +
> +               git submodule add ../child-origin child &&
> +               git commit -m "Add submodule child" &&
> +
> +               git mv child child_old &&
> +               git commit -m "Move child to child_old" &&
> +
> +               # Now adding a *new* repo at the old name must fail
> +               git init ../child2-origin &&
> +               git -C ../child2-origin commit --allow-empty -m init &&
> +               test_must_fail git submodule add ../child2-origin child

This makes sense, though I was hoping (when I'd only skimmed the
message and not seen "refuse") that this would be permitted by some
clever trick. Oh well.


> +       )
> +'
> +
> +
>  test_done
> --
> 2.49.GIT
>
>


--
D. Ben Knoble
