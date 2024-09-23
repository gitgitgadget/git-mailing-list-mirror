Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCFCCA6F
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078685; cv=none; b=XdVgiCjWjxdLHbg4I6XnO41mjj0Ja9T03CfZvnIuvrRUwuY8dyvuggG2Ower/zlfj05tB1uLZP2QCsv7N62ou7NfUVL8eFL0WLLMJ2jdtA86ExPwu7By4HSF6FzJXnfXI+27RzhxAnNSf9E3LpSdRTnhxoa3xMQTdv/Kn4ffHI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078685; c=relaxed/simple;
	bh=oH7rE7kTB3HuWK9/ARlD+G+sKNn+to3ONGy5nx5nAM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1Zg14+SnfJU+9baexIalqLCCIkXit42M4NXLfhs3ggr+xh+AKiZD9nyk7ZK63n0KnGrx1EQqwcyaNK7Q6KAC2msBXdvZ/EGz9UBAc9n1w8ZImZ4rrtporCJKuDiTbVPgf9EfO0oA/nXWPhRn4jkn2DIzJEj8+ucAeAoFQsT3kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c3705a2b21so1940446d6.2
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 01:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727078682; x=1727683482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWOK/PS9SeIhjaR0UDRhyNGyeodFYXDQvB809FK95C8=;
        b=lvfCOuOQFv5saAYbvO/LXV0J1uVzou5lJd4bHraNwxF7wNm0+Gh9rEsk4+qvxC0IYh
         3awBzjslq41Csrwv+FflPZsmQtjiDPd97qkKfPuix0ePmkZyz7yFj8Eghawu217LuQgI
         qYhgsMqrB1+wIjQquc2FoYFDeE/7m3NK+g/c91aOOjGNjD8IvwelONj4H/dxKV5F5qcx
         39KWQCv4TUVnDjXrD2PrzYJHyvheWLZZKr2byuDeXuJyzwz9kNdcfQc00h2ViZAMM/IE
         s94W/cIwxlDyHbj9tgh9V0ngztN1J9aOxBEmyBltiBD3zTs3KWdVFwmrzpQzzCI5RdQF
         JUVQ==
X-Gm-Message-State: AOJu0YzIwfY+fhDr7Fh4G9kRKQZT43vWYOiV3linuZG2EJ5U0GkEhhTN
	tdPdSphHSbNeKQMhM4JOw4RsDJeNS6k5082ldgAubIn9fMTDPf3d4w7levtGbnwyCVjhYpdCgf2
	rlmeV4CKzJMvEh0+KzhUTIKDEYVhXLONHbg8=
X-Google-Smtp-Source: AGHT+IENvUf4Mtah6IhC6PNonH8BXSuDyo9sTF+51YYMX3ZXL3ipdFpGXR90wnk9PZIGziCKKzJbISP9JVkrqcQnluY=
X-Received: by 2002:a05:6214:29c7:b0:6c5:bc1b:e20b with SMTP id
 6a1803df08f44-6c7bc781508mr77767956d6.8.1727078681971; Mon, 23 Sep 2024
 01:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923075416.54289-1-ericsunshine@charter.net>
In-Reply-To: <20240923075416.54289-1-ericsunshine@charter.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 23 Sep 2024 04:04:30 -0400
Message-ID: <CAPig+cTTrR6oHy2EenKUxpS_6QXkYB0A=46Jta0c9vVh8VkpLw@mail.gmail.com>
Subject: Re: [PATCH] worktree: repair copied repository and linked worktrees
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, 
	Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 3:55=E2=80=AFAM Eric Sunshine <ericsunshine@charter=
.net> wrote:
> [...]
> Fix this problem by also checking if a plausible .git/worktrees/<id>
> exists in the *current* repository -- not just in the repository pointed
> at by the worktree's .git file -- and comparing whether they are the
> same. If not, then it is likely because the repository / main-worktree
> and linked worktrees were copied, so prefer the discovered plausible
> pointer rather than the one from the existing .git file.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -698,12 +699,24 @@ void repair_worktree_at_path(const char *path,
> +       inferred_backlink =3D infer_backlink(realdotgit.buf);
>         backlink =3D xstrdup_or_null(read_gitfile_gently(realdotgit.buf, =
&err));
>         if (err =3D=3D READ_GITFILE_ERR_NOT_A_FILE) {
>                 fn(1, realdotgit.buf, _("unable to locate repository; .gi=
t is not a file"), cb_data);
>                 goto done;
>         } else if (err =3D=3D READ_GITFILE_ERR_NOT_A_REPO) {
> -               if (!(backlink =3D infer_backlink(realdotgit.buf))) {
> +               if (inferred_backlink) {
> +                       /*
> +                        * Worktree's .git file does not point at a repos=
itory
> +                        * but we found a .git/worktrees/<id> in this
> +                        * repository with the same <id> as recorded in t=
he
> +                        * worktree's .git file so make the worktree poin=
t at
> +                        * the discovered .git/worktrees/<id>. (Note: bac=
klink
> +                        * is already NULL, so no need to free it first.)
> +                        */
> +                       backlink =3D inferred_backlink;
> +                       inferred_backlink =3D NULL;
> +               } else {
>                         fn(1, realdotgit.buf, _("unable to locate reposit=
ory; .git file does not reference a repository"), cb_data);
>                         goto done;
>                 }

In case it's not obvious at first glance, there is no change of
behavior here. This changes in this hunk:

(1) factor out the call to infer_backlink() since the result is now
consulted in multiple code paths and the code needs to be careful to
ensure that all allocated strings get freed (at the end of the
function)

(2) add a comment explaining the *existing* behavior

The later hunk in this patch contains the actual behavior change.

> @@ -712,6 +725,30 @@ void repair_worktree_at_path(const char *path,
> +       /*
> +        * If we got this far, either the worktree's .git file pointed at=
 a
> +        * valid repository (i.e. read_gitfile_gently() returned success)=
 or
> +        * the .git file did not point at a repository but we were able t=
o
> +        * infer a suitable new value for the .git file by locating a
> +        * .git/worktrees/<id> in *this* repository corresponding to the =
<id>
> +        * recorded in the worktree's .git file.
> +        *
> +        * However, if, at this point, inferred_backlink is non-NULL (i.e=
. we
> +        * found a suitable .git/worktrees/<id> in *this* repository) *an=
d* the
> +        * worktree's .git file points at a valid repository *and* those =
two
> +        * paths differ, then that indicates that the user probably *copi=
ed*
> +        * the main and linked worktrees to a new location as a unit rath=
er
> +        * than *moving* them. Thus, the copied worktree's .git file actu=
ally
> +        * points at the .git/worktrees/<id> in the *original* repository=
, not
> +        * in the "copy" repository. In this case, point the "copy" workt=
ree's
> +        * .git file at the "copy" repository.
> +        */
> +       if (inferred_backlink && fspathcmp(backlink, inferred_backlink)) =
{
> +               free(backlink);
> +               backlink =3D inferred_backlink;
> +               inferred_backlink =3D NULL;
> +       }
> +
