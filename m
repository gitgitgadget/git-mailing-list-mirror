Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B1B1A8406
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911817; cv=none; b=eFKN0RmM+IbUDm8eJNX/KbajOK7iF6IQ0oXdteRtKtWyiWLId+/X95N/z0l+D/e2NYQBdeOr1MB+to1GAcncYH6mRKRsCxOy6PlKioGGPMDZQ6sqEd7M0KS5oPhSaB1mWgmQPCz8Ddy3hvKzOtdAquVPxNfwg8L7R1oXR1npzrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911817; c=relaxed/simple;
	bh=w5Ejbb77G04jZn0MkKR6k8o+T6nJdu/Xk8Yh0adZzhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maKgjmUbOYJ6DuzGyq2bd/Hx+D5Nm5/Jeo1HSIXN4ysc0z9N0diVqPlwXm5GKXdO1imW8V/pTqsoxSGQA1cLP3f1rdU1wPc6TLGdLE0DhnDTRaV2WF4AMDsjEgsRPq3uODlUEbJOTTngGN1FuK+QbUm8kfdmpcSP7BMLx7SK6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQT+5Tid; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQT+5Tid"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so968371466b.3
        for <git@vger.kernel.org>; Wed, 11 Dec 2024 02:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733911814; x=1734516614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rgIpexpI3zP1YCHXJauQbDA+BCsVwYhSQcwSWD0CHE=;
        b=gQT+5TidtROPqM8W7Jd/e0shsLpvA1rIJcvOGlACj/99ctw40ILs2RcA2A6Lx+jkMp
         Y80fMy61Xcjy38xf+3IzvHC4RerHA/Z7qVXuc3hIMq1ybJayXPF6Dm6VCle7R3NB9tXD
         hGMRrHskcB6/U/hrWpzHudAv1vzOLoethPj56UqCMJp72duxDNyZ2XqoLApmLwGERzDq
         KRthNj9sJ+1FZKrU2VmYbQs7x6EYUTCcMkkK6J6CR5d2FBSWjAjg4WQiTczQJXoTVdaL
         KsBj18HJyBRgF0qK6SdQxJ2CWUkihoTvqAB3MFfvZPxcCRcifFEMOFetxf1kMcpUX/+O
         WfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911814; x=1734516614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rgIpexpI3zP1YCHXJauQbDA+BCsVwYhSQcwSWD0CHE=;
        b=MxWhg/m+h4BZSX6Mhl/uhBwVx7D7HHXRV5KIAtggsU0yHV4rqNoTcmKM1gR7y6NsrH
         Nf4urAQBUvBcSNzkbT435jgNISQ8LE1uQXT+0u6o+Mc9UeXkRM0ocvPXnYed2tTlLptK
         0tOG5X8Wh44GWCFxGwP0Nzd4XHNxVjoSve50dweaBqYJlPM+GOqXQwwoCZFHd712gApi
         gCrTb77bXhspFz2c2vyCofA5BOJnEpdB8t0youMuJIoa3LQjnL1hCcWw+RE+qQoBjSkR
         xH4dUDPzuVmS4dgq2/DDq1FRBkbC2Y5QSV6K6LSPBmdQSO2tsin3BnmCypfNxxr+Ua8S
         +NiQ==
X-Gm-Message-State: AOJu0YxlECMTQXCga9zDAOtpomqO8wot+9nK+kdBSwjXC7YdIPvIjOiJ
	Ky3ZSa+7QT8j6hilPamJjLR7JbPJWjnlaa2+dki/DrCDmaKd0faRSkQZ+tKl7Hr1SBZBjbXLNu1
	9tfKJ4HmjewMnm9KGj0vKfnEJymaG/cCh
X-Gm-Gg: ASbGnct49OkAUqRM/aFGgC8bxcMMK6LWk4as3Puq/s1WRhyDGjKlaffBV+cdoEGRsA6
	NeEIj27Lw/6MX49UIJM9QChr0oja7ZLRs4AW+Qg==
X-Google-Smtp-Source: AGHT+IHTsqkEnSJyCE2DBZyAGeLiQXI4vGlTqG/z4we3OjPI5EQGqM5w0XfeferMz0mvQdqfcKJoqGhljaThAq2q1QU=
X-Received: by 2002:a05:6402:2105:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d43316510amr4707378a12.32.1733911813430; Wed, 11 Dec 2024
 02:10:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-5-d4bc37ee860f@gmail.com>
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-5-d4bc37ee860f@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 11 Dec 2024 11:10:01 +0100
Message-ID: <CAP8UFD1vTEH=7HBX1sudwkv7now9VUkFR3Y347EVNGfToZt8fA@mail.gmail.com>
Subject: Re: [PATCH 5/7] refs: introduce the `ref_transaction_update_reflog` function
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 12:11=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Introduce a new function `ref_transaction_update_reflog`, for clients to
> add a reflog update to a transaction. While the existing function
> `ref_transaction_update` also allows clients to add a reflog entry, this
> function does a few things more, It:
>   - Enforces that only a reflog entry is added and does not update the
>   ref itself.
>   - Allows the users to also provide the committer information. This
>   means clients can add reflog entries with custom committer
>   information.



> A follow up commit will utilize this function to add reflog support to
> `git refs migrate`.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c                  | 89 +++++++++++++++++++++++++++++++++++++------=
------
>  refs.h                  | 12 +++++++
>  refs/files-backend.c    | 48 +++++++++++++++-----------
>  refs/refs-internal.h    | 16 +++++----
>  refs/reftable-backend.c |  6 ++--
>  5 files changed, 122 insertions(+), 49 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 732c236a3fd0cf324cc172b48d3d54f6dbadf4a4..602a65873181a90751def5256=
08a7fa7bea59562 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1160,13 +1160,15 @@ void ref_transaction_free(struct ref_transaction =
*transaction)
>         free(transaction);
>  }
>
> -struct ref_update *ref_transaction_add_update(
> -               struct ref_transaction *transaction,
> -               const char *refname, unsigned int flags,
> -               const struct object_id *new_oid,
> -               const struct object_id *old_oid,
> -               const char *new_target, const char *old_target,
> -               const char *msg)
> +struct ref_update *ref_transaction_add_update(struct ref_transaction *tr=
ansaction,
> +                                             const char *refname,
> +                                             unsigned int flags,
> +                                             const struct object_id *new=
_oid,
> +                                             const struct object_id *old=
_oid,
> +                                             const char *new_target,
> +                                             const char *old_target,
> +                                             const char *committer_info,

This change (adding a 'const char *committer_info' argument to
ref_transaction_add_update()) is not described in the commit message
and it requires a number of changes to the callers of this function,
so I think it might want to be in its own preparatory commit before
this one.

> +                                             const char *msg)
>  {
>         struct ref_update *update;
>
> @@ -1190,8 +1192,15 @@ struct ref_update *ref_transaction_add_update(
>                 oidcpy(&update->new_oid, new_oid);
>         if ((flags & REF_HAVE_OLD) && old_oid)
>                 oidcpy(&update->old_oid, old_oid);
> -       if (!(flags & REF_SKIP_CREATE_REFLOG))
> +       if (!(flags & REF_SKIP_CREATE_REFLOG)) {
> +               if (committer_info) {
> +                       struct strbuf sb =3D STRBUF_INIT;
> +                       strbuf_addstr(&sb, committer_info);
> +                       update->committer_info =3D strbuf_detach(&sb, NUL=
L);

Maybe:
                      update->committer_info =3D xstrdup(committer_info);

> +               }
> +
>                 update->msg =3D normalize_reflog_message(msg);
> +       }
>
>         return update;
>  }
> @@ -1199,20 +1208,29 @@ struct ref_update *ref_transaction_add_update(
>  static int transaction_refname_verification(const char *refname,
>                                             const struct object_id *new_o=
id,
>                                             unsigned int flags,
> +                                           unsigned int reflog,
>                                             struct strbuf *err)
>  {
>         if (flags & REF_SKIP_REFNAME_VERIFICATION)
>                 return 0;
>
>         if (is_pseudo_ref(refname)) {
> -               strbuf_addf(err, _("refusing to update pseudoref '%s'"),
> -                           refname);
> +               if (reflog)
> +                       strbuf_addf(err, _("refusing to update reflog for=
 pseudoref '%s'"),
> +                                   refname);
> +               else
> +                       strbuf_addf(err, _("refusing to update pseudoref =
'%s'"),
> +                                   refname);

Maybe:

              const char *what =3D reflog ? "reflog for pseudoref" : "pseud=
oref";
              strbuf_addf(err, _("refusing to update %s '%s'"), what, refna=
me);

>                 return -1;
>         } else if ((new_oid && !is_null_oid(new_oid)) ?
>                  check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
>                  !refname_is_safe(refname)) {
> -               strbuf_addf(err, _("refusing to update ref with bad name =
'%s'"),
> -                           refname);
> +               if (reflog)
> +                       strbuf_addf(err, _("refusing to update reflog wit=
h bad name '%s'"),
> +                                   refname);
> +               else
> +                       strbuf_addf(err, _("refusing to update ref with b=
ad name '%s'"),
> +                                   refname);

Maybe:

              const char *what =3D reflog ? "reflog with bad name" :
"ref with bad name";
              strbuf_addf(err, _("refusing to update %s '%s'"), what, refna=
me);

>                 return -1;
>         }

[...]

>  int ref_transaction_create(struct ref_transaction *transaction,
> -                          const char *refname,
> -                          const struct object_id *new_oid,
> -                          const char *new_target,
> -                          unsigned int flags, const char *msg,
> -                          struct strbuf *err)
> +                          const char *refname, const struct object_id *n=
ew_oid,
> +                          const char *new_target, unsigned int flags,
> +                          const char *msg, struct strbuf *err)

This looks like a wrapping or indenting only change. If you really
want to do it, it should probably be in its own preparatory commit.

> index a5bedf48cf6de91005a7e8d0bf58ca98350397a6..b86d2cd87be33f7bb1b31fce7=
11d6c7c8d9491c9 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -727,6 +727,18 @@ int ref_transaction_update(struct ref_transaction *t=
ransaction,
>                            unsigned int flags, const char *msg,
>                            struct strbuf *err);
>
> +/*
> + * Similar to `ref_transaction_update`, but this function is only for ad=
ding
> + * a reflog updates.

"a reflog update" or "reflog updates".
