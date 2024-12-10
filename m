Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD862343B4
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849534; cv=none; b=TWmFt2ZHblOG2xr4R/AOUqmgna1pItQ7GN7Xn5lQROTMUfamCNnnY1J3MTzkM7TxkyPpRwQe2Tty3ROwPc2qghFl5lm28ix2Zf+Y5/9RO1zbORgvvKe4JcoXzPEolxw5GDSXzl4BB5wmeul2PG16bmFyySMIvMeNqAfGrd53UVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849534; c=relaxed/simple;
	bh=2OTSkfRFs+sKcHm+gBxlJDlL8XXbGEEkIYnCzM2z1XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frDZbWN1XQ7S61/Li+o7bcAidPgZ7z3Yk5EXMFxXBhUYAFM4O26df2CFglrVFOvXP5O1oXSUjSE1WSm7PF3/ThYsk57My+Ggcj64W+cdStJSKAJT5TS2gDmA7Cz2FqpasOzE1U5OFFCkSIdJ4ifQlIqWuLDp2DiD0cRBrvXNf7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmHs0Wkm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmHs0Wkm"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so7603920a12.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 08:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733849531; x=1734454331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AehknQitiJv+jtnjmXLh0Om/iGuowvbxuyGbbE7Amw=;
        b=NmHs0Wkmtt/iPHMbfuuLWG6Fb5+wyxf0C4A2VuBemNSUhcFX+nNVqUggQpYzthBHm6
         tTeloB0Au6Bn5wxAGz12yMjMkYyBebKnzCGNlZM04s/fYkEjH3VrfoBclZtNkudr0qgf
         bmbrdVZJlKw4AtLkemXZmRe3VKYGD6z1lUDXomZlJFniyPBtPZJo6kKM1lH22xhlfafa
         vdY6TrYcKfn3NqRpjl/d++4KKEJ9+FvjPb4zd/4XXE13vAG/qFOJiaTmF/wmMRob7P9O
         WHrEiEkmoGY5wMgslqL9VDePR9tLHrYTcOIpYLFfZLp/rvDC+0v6usZOEmO+FI/bKB3u
         oYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733849531; x=1734454331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AehknQitiJv+jtnjmXLh0Om/iGuowvbxuyGbbE7Amw=;
        b=Wzn+PzBVvrnsFtS4wtKqIQlYXPu1Wy4hUzOJ4UfuwLlQtUfvsXXYKLPg59ljEgGp3A
         iNDzAaAQqFBjeIFyoqKvw28ta1Wdh8Cknp7b8vGp0a/AhPi6NjRobq9cZsamKxPJIIDq
         3bVNLCXnKqETB16wJmmejpLXJ0EXYwS9bYSk5dqHd7nna+aUynWIErnWEhjWWq0ZRS04
         et9Lr1CKLkHcO6sdTmjRh+A8/OZ8uqNVPLWnTxWrNGvIctvloTynNrkeA0mTsKyEhQLJ
         LVc0s4HO2irrozBJWZ8XD4RODLGqBhQuOMlKXnGce1nijrWHVoYnvxSLgJ+O5aA6tdfP
         uX5g==
X-Gm-Message-State: AOJu0YyY2YMIQ0qF66PBHOBUo01gZ75CRavIE3PBYus3M4Qxlelv95Dd
	omj3W5BS/VCF55NVLR+jWuL9kF1LwFzTiQX5U5j0Snw4B4FspujMh5B2IaGr9qg0WaW7LXRV43x
	3GimA/Xh8CVjfTbN4+5vnSeINwlM=
X-Gm-Gg: ASbGnctkG7ln4kip6x2I0GB8EWxO6MOtgWQDybfR0micY4ZfDqZKfDnVMiw/Pb5aSUD
	EyDVDL2UcNe7vcm9x+trRkTLCcrTT9WuHGm6IWg==
X-Google-Smtp-Source: AGHT+IHBrWmrHn3M4V5j1iiQYyk3zBHqgsc6yCJCpSQmUR7uvvLOS9AHym9unC1G4pZka5QOJDmeMV/abt0mp5SaRt0=
X-Received: by 2002:a05:6402:3553:b0:5d1:2631:b877 with SMTP id
 4fb4d7f45d1cf-5d3be678015mr15559018a12.9.1733849530522; Tue, 10 Dec 2024
 08:52:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-1-d4bc37ee860f@gmail.com>
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-1-d4bc37ee860f@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 10 Dec 2024 17:51:57 +0100
Message-ID: <CAP8UFD3FXtbuHH1G==rR00_O7MBjqQiw_qzGHPVLK4P13RRtjQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] refs: include committer info in `ref_update` struct
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 12:10=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:


> If there is no `committer_info`
> provided, the reference backends default to using
> `git_committer_info(0)`. The field itself cannot be set to
> `git_committer_info(0)` since the values are dynamic and must be
> obtained right when the reflog is being committed.


> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 64f51f0da905a9a8a1ac4109c6b0a9a85a355db7..13f8539e6caa923cd4834775f=
cb0cd7f90d82014 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1858,6 +1858,9 @@ static int log_ref_write_fd(int fd, const struct ob=
ject_id *old_oid,
>         struct strbuf sb =3D STRBUF_INIT;
>         int ret =3D 0;
>
> +       if (!committer)
> +               committer =3D git_committer_info(0);

It looks like this is where we obtain the value "right when the reflog
is being committed".

> +
>         strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_=
oid), committer);
>         if (msg && *msg) {
>                 strbuf_addch(&sb, '\t');
> @@ -1871,8 +1874,10 @@ static int log_ref_write_fd(int fd, const struct o=
bject_id *old_oid,
>  }
>
>  static int files_log_ref_write(struct files_ref_store *refs,
> -                              const char *refname, const struct object_i=
d *old_oid,
> -                              const struct object_id *new_oid, const cha=
r *msg,
> +                              const char *refname,
> +                              const struct object_id *old_oid,
> +                              const struct object_id *new_oid,
> +                              const char *committer_info, const char *ms=
g,
>                                int flags, struct strbuf *err)
>  {
>         int logfd, result;
> @@ -1889,8 +1894,7 @@ static int files_log_ref_write(struct files_ref_sto=
re *refs,
>
>         if (logfd < 0)
>                 return 0;
> -       result =3D log_ref_write_fd(logfd, old_oid, new_oid,
> -                                 git_committer_info(0), msg);
> +       result =3D log_ref_write_fd(logfd, old_oid, new_oid, committer_in=
fo, msg);

Here we just pass the committer_info to the above function.

>         if (result) {
>                 struct strbuf sb =3D STRBUF_INIT;
>                 int save_errno =3D errno;
> @@ -1974,8 +1978,7 @@ static int commit_ref_update(struct files_ref_store=
 *refs,
>         files_assert_main_repository(refs, "commit_ref_update");
>
>         clear_loose_ref_cache(refs);
> -       if (files_log_ref_write(refs, lock->ref_name,
> -                               &lock->old_oid, oid,
> +       if (files_log_ref_write(refs, lock->ref_name, &lock->old_oid, oid=
, NULL,
>                                 logmsg, flags, err)) {

Here we don't have the info so we pass NULL.

>                 char *old_msg =3D strbuf_detach(err, NULL);
>                 strbuf_addf(err, "cannot update the ref '%s': %s",
> @@ -2007,8 +2010,8 @@ static int commit_ref_update(struct files_ref_store=
 *refs,
>                 if (head_ref && (head_flag & REF_ISSYMREF) &&
>                     !strcmp(head_ref, lock->ref_name)) {
>                         struct strbuf log_err =3D STRBUF_INIT;
> -                       if (files_log_ref_write(refs, "HEAD",
> -                                               &lock->old_oid, oid,
> +                       if (files_log_ref_write(refs, "HEAD", &lock->old_=
oid,
> +                                               oid, git_committer_info(0=
),

Here we don't have the info either, so I think we should also pass
NULL. It would then be computed "right when the reflog is being
committed" in the above function. No?

>                                                 logmsg, flags, &log_err))=
 {
>                                 error("%s", log_err.buf);
>                                 strbuf_release(&log_err);


> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 647ef9b05b1dc9a376ed054330b487f7595c5caa..e882602487c66261d586a9410=
1bb1b4e9a2ed60e 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1379,11 +1379,21 @@ static int write_transaction_table(struct reftabl=
e_writer *writer, void *cb_data

It is not your fault but write_transaction_table() does the following
right at the beginning of the function:

       committer_info =3D git_committer_info(0);
       if (split_ident_line(&committer_ident, committer_info,
strlen(committer_info)))
               BUG("failed splitting committer info");

but then 'committer_ident' is only used in the hunk you are changing:

>                         if (create_reflog) {
> +                               struct ident_split c;
> +
>                                 ALLOC_GROW(logs, logs_nr + 1, logs_alloc)=
;
>                                 log =3D &logs[logs_nr++];
>                                 memset(log, 0, sizeof(*log));
>
> -                               fill_reftable_log_record(log, &committer_=
ident);
> +                               if (u->committer_info) {
> +                                       if (split_ident_line(&c, u->commi=
tter_info,
> +                                                            strlen(u->co=
mmitter_info)))
> +                                               BUG("failed splitting com=
mitter info");
> +                               } else {

I would think it would be more efficient to only compute
'committer_ident' here, right before we use it if needed. Or is there
something I am missing?

> +                                       c =3D committer_ident;
> +                               }
> +
> +                               fill_reftable_log_record(log, &c);
>                                 log->update_index =3D ts;
>                                 log->refname =3D xstrdup(u->refname);
>                                 memcpy(log->value.update.new_hash,
