Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C311393DF2
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818535; cv=none; b=oa14S6pLo5vT8I/QaWrUriFPbNsq0QyrKRiO0CgkYUzEgLlgXO2WjoKNxec5sc7RWujySOXrcy00qgV/XXNlgRHLhYK7XpMTAa03DeO7IGgrh3UsOVFVxlBsGKBpKyJTWxd3kF8yLVUxB9wYUlwBo+bmUWTGUVfwIkBMhs3Nbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818535; c=relaxed/simple;
	bh=2BvyIslzIiBfZwtPvHaqs9CYVw4F41ywAL7kfhQZaaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dq/mz36uTCf5njzZUM60n2Bvb83IY0C0apSwIdgQC5xr55oNNofjKjK0lAKbGv/EOh3VeYuddoCYruIEO15E3AYHeJMZVHVy3ATAy8Se9x8xIjzT37G1HeiiIkIZAya3xHxBataH6QXm/feFcrJDI/6lV2lb6kZghH/ZF50Cdj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIAL0TGr; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIAL0TGr"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e56ff1f604so8205285ab.0
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755818533; x=1756423333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAifXgn8sMIwtvZqZXOCDakPEKIV4QKwRsmES8bWRe0=;
        b=ZIAL0TGrTdjsU10oCvUBdaW5PHDUZyd97F3psIXxkimzrOiyeR3gmh8FDrOh/2Fush
         lFOFFF42SrQEPxhNkyo1vD0w1ITmZQ0K+cPROZCWWpM/uPb5Iq6xZijiHHL00bXvOM/M
         oWPk6LSt7j/NMUL3gxvzkH9wxEy7NgFFYe3DHVfom2pj1yN8/Qfqxnlgh2WYfXuENxrr
         YGAWyLB72Rcuc6bhpmh4Cv0qSZC7lJlzofh/MKwZY9fcHhHk75FZ4kjQ0xGXuXtepYcU
         VcHcskPNT15gCyEXVFhF7S8zueBEripaJAgvTXycD4cc/aXfporHvppFgVzEckW+i+va
         VyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755818533; x=1756423333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAifXgn8sMIwtvZqZXOCDakPEKIV4QKwRsmES8bWRe0=;
        b=u6YFMlU7cjobfej7x2i4fTy8Nigd9TiAyYd+5F8glQTATKupWg06XofAbqS8sYz9I1
         4idZG8d52vlIR0BvSibpIF0PNoC7Y8A1IL/of8JkKAXXoVzM/9erSzvquOik859gDxuw
         AepVnOp1xddvWIXCSKjEt1gS7nI/J9ZU9RNafjbiZygZyWiP5JM+aVngUDI+D1atOHHF
         TYj4JjSfOmf/XgWgQezUUuxqA4+PJPxZTx4qYAlt+fsdcJA9Sq773NAVPuXU/XzzX23b
         tpvNo/WqD+62GNNRBECRMAB5v72086v5xEGINO9ZDV4UsNzThfUoGi2H14yfa76YSySO
         pejA==
X-Gm-Message-State: AOJu0YwQm/dlsYIWFrOBprJaivRFj3ilgLaA/O/H1LA4RwzJOHOScMGv
	wr2NlNeV5ybmvwFqnSVsOzC833fVdAsJXfRRLtH4BoVMZPG/3m0hBcs/Q8yHpbf1sSSC35D2JJu
	eF+b4miDXgC8oXroSfJ/fM4g4orHIA24=
X-Gm-Gg: ASbGncu4wmgS0p+NyMMBQL6PPDHwXi8Lem/AjKVL4/v0vWtg9txJFl0c0EBMIuqCWuo
	tmpKJbz/qut6v7FJg26f5BOu2utH3xj7Qu2hwFUqnlZucnNnh18GNE7/yGHZeKSqJnihy9vCaqx
	Ay5e4U+Z19V+bMQGWriQES5sqpfvlwBXyXArDedMPe6P9xlRGeXjNNmW8GTqEjQ2EMXMD8+8anA
	H4P46X0SiEzwZRZFA/u2Bl3Z0cWeUVh2GLNRTq8oRD6kuN1LC4=
X-Google-Smtp-Source: AGHT+IH14qQsGWSrLqOxbuB2kl9tM3Dq4qyGkAYylnI4hNHcVbP/CQySw+1Sj8aE3IRgQXFzVDXxZu2SUpPPqx9aW+k=
X-Received: by 2002:a92:c248:0:b0:3e3:fe52:e576 with SMTP id
 e9e14a558f8ab-3e9203e71edmr22023175ab.9.1755818533142; Thu, 21 Aug 2025
 16:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com> <dd458e043548a8ed33070657cc98128efb606847.1755715196.git.gitgitgadget@gmail.com>
In-Reply-To: <dd458e043548a8ed33070657cc98128efb606847.1755715196.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 21 Aug 2025 16:22:01 -0700
X-Gm-Features: Ac12FXxfyrziZZqe81sUSLD2MjaHOPjcs4ieL-yyrBbSCwtrIKofF949IdwgR-c
Message-ID: <CABPp-BEvFL8WYyn404u09y6UyTmbPbyrj6N=YvpMZZmpui0mvQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] path-walk: create initializer for path lists
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com, 
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, me@ttaylorr.com, 
	peff@peff.net, ps@pks.im, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:40=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> The previous change fixed a bug in 'git repack -adf --path-walk' that
> was due to an update to how path lists are initialized and missing some
> important cases when processing the pending objects.
>
> This change takes the three critical places where path lists are
> initialized and combines them into a static method. This simplifies the
> callers somewhat while also helping to avoid a missed update in the
> future.
>
> The other places where a path list (struct type_and_oid_list) is
> initialized is for the following "fixed" lists:
>
>  * Tag objects.
>  * Commit objects.
>  * Root trees.
>  * Tagged trees.
>  * Tagged blobs.
>
> These lists are created and consumed in different ways, with only the
> root trees being passed into the logic that cares about the
> "maybe_interesting" bit. It is appropriate to keep these uses separate.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  path-walk.c | 57 +++++++++++++++++++++++------------------------------
>  1 file changed, 25 insertions(+), 32 deletions(-)
>
> diff --git a/path-walk.c b/path-walk.c
> index 1215ed398f4f..f1ceed99e94c 100644
> --- a/path-walk.c
> +++ b/path-walk.c
> @@ -105,6 +105,24 @@ static void push_to_stack(struct path_walk_context *=
ctx,
>         prio_queue_put(&ctx->path_stack, xstrdup(path));
>  }
>
> +static void add_path_to_list(struct path_walk_context *ctx,
> +                            const char *path,
> +                            enum object_type type,
> +                            struct object_id *oid,
> +                            int interesting)
> +{
> +       struct type_and_oid_list *list =3D strmap_get(&ctx->paths_to_list=
s, path);
> +
> +       if (!list) {
> +               CALLOC_ARRAY(list, 1);
> +               list->type =3D type;
> +               strmap_put(&ctx->paths_to_lists, path, list);
> +       }
> +
> +       list->maybe_interesting |=3D interesting;
> +       oid_array_append(&list->oids, oid);
> +}
> +
>  static int add_tree_entries(struct path_walk_context *ctx,
>                             const char *base_path,
>                             struct object_id *oid)
> @@ -129,7 +147,6 @@ static int add_tree_entries(struct path_walk_context =
*ctx,
>
>         init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size=
);
>         while (tree_entry(&desc, &entry)) {
> -               struct type_and_oid_list *list;
>                 struct object *o;
>                 /* Not actually true, but we will ignore submodules later=
. */
>                 enum object_type type =3D S_ISDIR(entry.mode) ? OBJ_TREE =
: OBJ_BLOB;
> @@ -190,17 +207,10 @@ static int add_tree_entries(struct path_walk_contex=
t *ctx,
>                                 continue;
>                 }
>
> -               if (!(list =3D strmap_get(&ctx->paths_to_lists, path.buf)=
)) {
> -                       CALLOC_ARRAY(list, 1);
> -                       list->type =3D type;
> -                       strmap_put(&ctx->paths_to_lists, path.buf, list);
> -               }
> -               push_to_stack(ctx, path.buf);
> -
> -               if (!(o->flags & UNINTERESTING))
> -                       list->maybe_interesting =3D 1;
> +               add_path_to_list(ctx, path.buf, type, &entry.oid,
> +                                !(o->flags & UNINTERESTING));
>
> -               oid_array_append(&list->oids, &entry.oid);
> +               push_to_stack(ctx, path.buf);
>         }
>
>         free_tree_buffer(tree);
> @@ -377,16 +387,9 @@ static int setup_pending_objects(struct path_walk_in=
fo *info,
>                         if (!info->trees)
>                                 continue;
>                         if (pending->path) {
> -                               struct type_and_oid_list *list;
>                                 char *path =3D *pending->path ? xstrfmt("=
%s/", pending->path)
>                                                             : xstrdup("")=
;
> -                               if (!(list =3D strmap_get(&ctx->paths_to_=
lists, path))) {
> -                                       CALLOC_ARRAY(list, 1);
> -                                       list->type =3D OBJ_TREE;
> -                                       strmap_put(&ctx->paths_to_lists, =
path, list);
> -                               }
> -                               list->maybe_interesting =3D 1;
> -                               oid_array_append(&list->oids, &obj->oid);
> +                               add_path_to_list(ctx, path, OBJ_TREE, &ob=
j->oid, 1);
>                                 free(path);
>                         } else {
>                                 /* assume a root tree, such as a lightwei=
ght tag. */
> @@ -397,20 +400,10 @@ static int setup_pending_objects(struct path_walk_i=
nfo *info,
>                 case OBJ_BLOB:
>                         if (!info->blobs)
>                                 continue;
> -                       if (pending->path) {
> -                               struct type_and_oid_list *list;
> -                               char *path =3D pending->path;
> -                               if (!(list =3D strmap_get(&ctx->paths_to_=
lists, path))) {
> -                                       CALLOC_ARRAY(list, 1);
> -                                       list->type =3D OBJ_BLOB;
> -                                       strmap_put(&ctx->paths_to_lists, =
path, list);
> -                               }
> -                               list->maybe_interesting =3D 1;
> -                               oid_array_append(&list->oids, &obj->oid);
> -                       } else {
> -                               /* assume a root tree, such as a lightwei=
ght tag. */
> +                       if (pending->path)
> +                               add_path_to_list(ctx, pending->path, OBJ_=
BLOB, &obj->oid, 1);
> +                       else
>                                 oid_array_append(&tagged_blobs->oids, &ob=
j->oid);
> -                       }
>                         break;
>
>                 case OBJ_COMMIT:
> --
> gitgitgadget

Looks like a straightforward collapsing of common code into a new function.
