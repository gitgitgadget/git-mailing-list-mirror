Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA18F1684A4
	for <git@vger.kernel.org>; Tue,  6 May 2025 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746519628; cv=none; b=vCC1aPIqRVLUV6k2WSBsB4kQ9kV/Je7HQkp/d4DiM23bHmy3fc6bhhEyKdcSPV+89UDa36c6OrqAz6q7UOf8sRUPF87RASAJtYpIT1/5G0UeyiHchGeOrOCQcRVjGdWGvtiIE9sRrbRkyqlUVyrBmLMsDRk+33sIm2ZmiuCBRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746519628; c=relaxed/simple;
	bh=PUuKDvH17Wh1Tyq9F8oUYU6frQWs4C9JK2FxuzIa+qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0o77U5sJqanJz/CzPgrsY6h/lnDrfrEru4qIvKm4mYHkkCdHTHyBTMJFstU4xBHOGx1M23hGHR9habH5+CGEAxW8JvVNR9i7kSfcCvPARiiOeCZwJ/bHsgbfVN2pUyLmPFkM/5IO0l2JHanJPRpc5x8nT2eIZUAb3C1CgdrGt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efQACu6v; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efQACu6v"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f7ec0e4978so4998016a12.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 01:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746519625; x=1747124425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REnaHBwSr0vQ2u09SKxMZ6oVYbadhNQqg9J+7U1QRzk=;
        b=efQACu6vmEcgnQyrcIRsfvdSzLh8RyxeHe1CNM/8wVJU27Mq9+y4R7QZf3z5MSuZJs
         yfS0ndvfwxQLadvfc+KAqHOkVy9bbxzraat7oVHSmAKyemHn2pbRPTf7yYKJOy10yNdz
         K3Zrkx+OoGXze9KqxVRgGF7FhWTtwj7qvN7jCunCHWj4kbltkVDOfKmF2sgzfFaLlW/8
         x71nUNyaV/IaV0NhItDkneBbek3BglkcrkhciIipEq+i/RRhUzhaW62cxjKpEfm5g1xg
         Gvks/QzlA55rxwOiQURGrWgTT1kYHpXa77YqUXZ60AhtbqqeOHtAmOEbUkJNzxlJy+Z4
         7KEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746519625; x=1747124425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REnaHBwSr0vQ2u09SKxMZ6oVYbadhNQqg9J+7U1QRzk=;
        b=vDRSek/JloJMVAQWGADA6GVUGZAao4cgHkL1P4d69bap5SGFFhoff+NNLaE+BVBP20
         22Y8JJoQchv4KXv16zVcN4nYAzfVDkZw2c5Fx0kz39WvP0v8HEnCL9MkIOj7+aOAUSTJ
         Cm9vxjrV618g1qJ+3LeLYP2hgcDneEhnaHkztMYPupZhJDS835W5J6cIW2SDnt1/+XGY
         pdGG6iF1KtoECz/Y72EYa3Yyp+k49FJ5iMGrOPjuWR+E+GLe1xyl6D4DOMWPl+I3joTz
         GQX4Z0++sMZ7sVraHjn7MYpKLV+nHz6scYp7W4r7VOeKD6w2hbPs6AjntnVyh589w0t2
         vNTg==
X-Gm-Message-State: AOJu0YyXWQ8/B4zCLnNe4DEJkKMWMwU3PKbvha+25mGFvd7Pq6vS8ZSg
	s1Yj5J9oZUYFOy+iuRbxzS+HIQV/OwyHlB//NWzcDv4Wp8+fx15B8N2O5IHlF0kuBaR49ov24HX
	mUbPrC2Atv5NZhKFUvM/aukVrab8=
X-Gm-Gg: ASbGncvxUgojC3jqN8SMtUsBRD7yzlXG2j8a6E/OYHGdcsxs1lkz/mkZrtF3uGbmbU5
	yuGN7pqYWPZYiBHoFCDylQJORp1LqT4H9joeVzQ75GM3Ua60eU3vkm7YPquPz2oFHaWFdw3fDeD
	pzFV+aAOv/KO9wjAHwMwWYu1KxARoq9k61rscEqSnO1dAyAizhcOlfwXY=
X-Google-Smtp-Source: AGHT+IF105SxUvphNIHkSbTON7qt5AqYBqHYosA5u1XsszLRRUf2c2AodCRQCxJgfTZHTZ97/rRGjGh2TZVhlZwwa3o=
X-Received: by 2002:a05:6402:26ce:b0:5e8:bf2a:7e8c with SMTP id
 4fb4d7f45d1cf-5fb6fdad716mr1761234a12.11.1746519624620; Tue, 06 May 2025
 01:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im> <20250505-pks-maintenance-missing-tasks-v4-4-141f4df906a1@pks.im>
In-Reply-To: <20250505-pks-maintenance-missing-tasks-v4-4-141f4df906a1@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 6 May 2025 10:20:12 +0200
X-Gm-Features: ATxdqUENS4Z1OL6F1isBM8wSQFWIKzQZfhJHMh_se0ObTgVh97rm4GwWLc-k7Oo
Message-ID: <CAP8UFD24jwKjP6XdD_SSv7ukgyqewCThMd-wQSRsDk00X7btiQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] worktree: expose function to retrieve worktree names
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 10:52=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Introduce a function that retrieves worktree names as present in
> ".git/worktrees". This function will be used in a subsequent commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/worktree.c | 25 ++++++++++++-------------
>  worktree.c         | 30 ++++++++++++++++++++++++++++++
>  worktree.h         |  8 ++++++++
>  3 files changed, 50 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 87ccd47794c..9b00dbf1265 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -211,27 +211,24 @@ static void prune_dups(struct string_list *l)
>
>  static void prune_worktrees(void)
>  {
> -       struct strbuf reason =3D STRBUF_INIT;
>         struct strbuf main_path =3D STRBUF_INIT;
>         struct string_list kept =3D STRING_LIST_INIT_DUP;
> -       char *path;
> -       DIR *dir;
> -       struct dirent *d;
> +       struct strvec worktrees =3D STRVEC_INIT;
> +       struct strbuf reason =3D STRBUF_INIT;
>
> -       path =3D repo_git_path(the_repository, "worktrees");
> -       dir =3D opendir(path);
> -       free(path);
> -       if (!dir)
> +       if (get_worktree_names(the_repository, &worktrees) < 0 ||
> +           !worktrees.nr)
>                 return;
> -       while ((d =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL) {
> +
> +       for (size_t i =3D 0; i < worktrees.nr; i++) {
>                 char *path;
> +
>                 strbuf_reset(&reason);
> -               if (should_prune_worktree(d->d_name, &reason, &path, expi=
re))
> -                       prune_worktree(d->d_name, reason.buf);
> +               if (should_prune_worktree(worktrees.v[i], &reason, &path,=
 expire))
> +                       prune_worktree(worktrees.v[i], reason.buf);
>                 else if (path)
> -                       string_list_append_nodup(&kept, path)->util =3D x=
strdup(d->d_name);
> +                       string_list_append_nodup(&kept, path)->util =3D x=
strdup(worktrees.v[i]);
>         }
> -       closedir(dir);
>
>         strbuf_add_absolute_path(&main_path, repo_get_common_dir(the_repo=
sitory));
>         /* massage main worktree absolute path to match 'gitdir' content =
*/
> @@ -242,6 +239,8 @@ static void prune_worktrees(void)
>
>         if (!show_only)
>                 delete_worktrees_dir_if_empty();
> +
> +       strvec_clear(&worktrees);
>         strbuf_release(&reason);
>  }
>
> diff --git a/worktree.c b/worktree.c
> index c34b9eb74e5..947b7a82209 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -988,6 +988,36 @@ int should_prune_worktree(const char *id, struct str=
buf *reason, char **wtpath,
>         return rc;
>  }
>
> +int get_worktree_names(struct repository *repo, struct strvec *out)
> +{
> +       char *worktrees_dir;
> +       struct dirent *d;
> +       DIR *dir;
> +       int ret;
> +
> +       worktrees_dir =3D repo_git_path(repo, "worktrees");
> +       dir =3D opendir(worktrees_dir);
> +       if (!dir) {
> +               if (errno =3D=3D ENOENT) {
> +                       ret =3D 0;
> +                       goto out;
> +               }
> +
> +               ret =3D -1;
> +               goto out;
> +       }
> +
> +       while ((d =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL)
> +               strvec_push(out, d->d_name);
> +
> +       ret =3D 0;
> +out:
> +       if (dir)
> +               closedir(dir);
> +       free(worktrees_dir);
> +       return ret;
> +}

Nit: this function seems to use "goto out" a bit too much for me. What
about something like:

int get_worktree_names(struct repository *repo, struct strvec *out)
{
    int ret =3D 0;
    char *worktrees_dir =3D repo_git_path(repo, "worktrees");
    DIR *dir =3D opendir(worktrees_dir);

    if (dir) {
        struct dirent *d;
        while ((d =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL)
            strvec_push(out, d->d_name);
        closedir(dir);
    } else {
        if (errno !=3D ENOENT)
            ret =3D -1;
    }

    free(worktrees_dir);
    return ret;
}

?
