Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A81367
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707182009; cv=none; b=BQVTq7PvA0vqglHmNajmbsOSNZW+R++LOEMDr03owCisON55RhTck2qJ+rvjThJ+bPDWMyMH7XjHKzIY/PH6sXs8VP7xe/ZQZgUVwng4JCOazEZdRsgANX27ZuHBEOWKlnand3G1vQQOz/47/dHkXXQ+hZmAl+CeDxVXLyHmr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707182009; c=relaxed/simple;
	bh=ma/eSnllPblpLS06J3n36wwjPJu15iagQg2qwxvEXSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oxp9r8RYwJJlC/6h2pZx9QXxwXnQ0ebxc/hgHHHCu+YnFRq6Dgit92RgIDQaqZ1SWfqTztzOcxQZJUOUC2UGr5jx1wbA6tJ6QNrkb/lU40htyyVVmEfZ1fAC4kMBHsnjaKxxdiIja5xXJCcNX/8w59lq9oF/byUpWUTb12mGAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tD4klDzw; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tD4klDzw"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3810e975aaso29537466b.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 17:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707182005; x=1707786805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zup5nPMjsJIjE+PZPbXyaRvBI0n8SZIuRaJ5afa1EoA=;
        b=tD4klDzwDWYn4aIw8pDDlSfyG/qP7V1xxkiKwS402usMmk7wTytlM2UQstJJmAthqE
         djvQk+AC2+K76SMg281mMaobu3zHMdv3S5jbVvJxgA58r7gnIvINrF9JbFvVdJDCc6M5
         yvqa1/2n6P3t2cCB9Ty21RR/wHA8xzVeFW4qK/ID+xelXHaf88ee50imkEz35UtvcVRI
         hSCjmiaA7eAz+R2rEfhuDihsEw8HZww0GmNwiPRSvXWfvbdGAuE27D9cBh0yJ8pkXMox
         eeVeroBlTaFNUqnucBLlDlVNPbkXz880qmtgBu44reYKlNT3d+Lg9fsFTTvr0Uiw2QlA
         GKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707182005; x=1707786805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zup5nPMjsJIjE+PZPbXyaRvBI0n8SZIuRaJ5afa1EoA=;
        b=PkiLPASRnaf2iKo1o1Ek1Ik9Ze2abCbI+K5MvG7pYT8qQbcpmmYj/79jSYkHNNIP/N
         NU2/51L1ogLiaoayakeDkbtRVaC0WomYr3o7ab4vGRJW1V1m9DSxklaf0RNak6jzUDyM
         1XVSuWSFGvmqV4pq+gQtbMvk9Qok6uoxSBJM+Kmkj270X6mIZSBZNqgiGzDJucIrg/Cd
         yoPFgnQ6L+q7Qh+BnYUla0rNtqk4WBlynnOmJb3H9HGgo5raiHLyqG5E/aRX2CSfxmPe
         tq2sYhqxhTgFLIk+P4m0WXJDvcPFwlbHifyy3dh88sbLzSaLL2/PE8IExjTbkG1tCeI2
         Xt8A==
X-Gm-Message-State: AOJu0YzrTU4RFNr2j/0DBXnp2vZWdRiA3A0Lu3eywAqB098pYCb2vs4M
	pojbfFICMDkur27Ges9xWtSmjqB3Z7p5wTomBVU2mr8EdiJ1Z1dX2SkfxeBtFIQyHL4qFiFEKsk
	nAtMQ5xH864gwwNZCqa+Mip+EcP9Mu78xXj0TUPEa9epSUrU+wA==
X-Google-Smtp-Source: AGHT+IHhnQTT3uc8u0Hqntk+sjD4AkoiR/SV36xaOOpOAHs13MDSce/eJazIrBo5LjQLndTjammGmbWk6wcy6RZqUDI=
X-Received: by 2002:a17:906:e1a:b0:a37:35de:c71f with SMTP id
 l26-20020a1709060e1a00b00a3735dec71fmr509254eji.29.1707182005454; Mon, 05 Feb
 2024 17:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>
In-Reply-To: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 5 Feb 2024 17:13:10 -0800
Message-ID: <CAO_smVhrMn=-uF1B6+RA8A+VLCEN=o57zbQPtr8hpxRKY=qJRQ@mail.gmail.com>
Subject: Re: [PATCH] Always check the return value of `repo_read_object_file()`
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 6:36=E2=80=AFAM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> There are a couple of places in Git's source code where the return value
> is not checked. As a consequence, they are susceptible to segmentation
> faults.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Always check the return value of repo_read_object_file()
>
>     I ran into this today, when I had tried git am -3 to import changes f=
rom
>     a repository into a different repository that has the first repositor=
y's
>     code vendored in. To make this work, I set
>     GIT_ALTERNATE_OBJECT_DIRECTORIES accordingly for the git am -3 call, =
but
>     forgot to set it for a subsequent git diff call, which then segfaulte=
d.
>
>     There are still a couple of places left where there are checks but th=
ey
>     look dubious to me, as they simply continue as if an empty blob had b=
een
>     read, for example in builtin/tag.c. However, there are checks that av=
oid
>     segfaults, so I left them alone.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1650%2F=
dscho%2Fsafer-object-reads-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1650/dscho=
/safer-object-reads-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1650
>
>  bisect.c           |  3 +++
>  builtin/cat-file.c | 10 ++++++++--
>  builtin/grep.c     |  2 ++
>  builtin/notes.c    |  6 ++++--
>  combine-diff.c     |  2 ++
>  rerere.c           |  3 +++
>  6 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index e65cae0bcf7..caf20fd5bdd 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -716,9 +716,11 @@ static int append_edit(int argc, const char **argv, =
const char *prefix)
>                 struct strbuf buf =3D STRBUF_INIT;
>                 char *prev_buf =3D repo_read_object_file(the_repository, =
note, &type, &size);
>
> -               if (prev_buf && size)
> +               if (!prev_buf)
> +                       die(_("unable to read %s"), oid_to_hex(note));

This changes the behavior of this function. Previously, it would not
add prev_buf output, but still succeed. This now dies.

> +               if (size)
>                         strbuf_add(&buf, prev_buf, size);
> -               if (d.buf.len && prev_buf && size)
> +               if (d.buf.len && size)
>                         append_separator(&buf);
>                 strbuf_insert(&d.buf, 0, buf.buf, buf.len);
>
> diff --git a/combine-diff.c b/combine-diff.c
> index db94581f724..d6d6fa16894 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -337,6 +337,8 @@ static char *grab_blob(struct repository *r,
>                 free_filespec(df);
>         } else {
>                 blob =3D repo_read_object_file(r, oid, &type, size);
> +               if (!blob)
> +                       die(_("unable to read %s"), oid_to_hex(oid));

Technically this is changing the output, but I think that's good - I
believe that previously the behavior was undefined, because `type`
wouldn't be modified if the blob didn't exist, and `type` wasn't
assigned a value earlier in the function.

>                 if (type !=3D OBJ_BLOB)
>                         die("object '%s' is not a blob!", oid_to_hex(oid)=
);
>         }
>
> base-commit: 2a540e432fe5dff3cfa9d3bf7ca56db2ad12ebb9
> --
> gitgitgadget
>
