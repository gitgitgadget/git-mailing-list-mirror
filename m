Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A973239BA3
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913873; cv=none; b=auqltoum8nWipG9RfqnSxqYIqGPBvWKHnREcNX71VNmOyRShKCAKdCOY3aybXgRHMDnQJQjS/cuGTnwKittsTOrYkJ2AOibk3XOXQDU8Ma24j66m/Qzle3Yxdzz3EfxkvVGORX58v/Ir/psifxuvIMuDquz/um5NAslPbfxxue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913873; c=relaxed/simple;
	bh=7pwhJd4ifaNnzBc3f2zVsk/i+lTeoA6e7Vsq+2+VMJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qV7SPqc+nSt1SwJmoSqm+RwJPQ3Gp7hJwXz8cm9z35nuF/gK9RtBKca3OFNWSUmVxHX1jWAG8BeB7O456UTjnm7ixxgDcpERTmyBa1D4S7DXu7TyRNWzThB9Y9hxwq5DMVYhoyNKZvBSorbeLGB6bjdhViiPQd8WtcCCmO9+xNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icU+UXBo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icU+UXBo"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso1103068a12.1
        for <git@vger.kernel.org>; Wed, 11 Dec 2024 02:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733913870; x=1734518670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rj4+/DACIpjSeTg9MdILDT/uc3SfCIdNJ7zHJVBVUPs=;
        b=icU+UXBo7jHOdaBblFGa7gefH6adzCILHBBxYjUyCsUcORvPji1XZomgYWWaXktvn/
         x51L35JeaGR26sL+rIso3cFUvqQsw5xaokG+5oRLwBxDqfRD25cE+F9Fq0k91IufrYrg
         dAkzmAOTXYRqbCEEOh1CdAZMAcrcCBx0hRifQC2JnDSlrQ7ZtBOOdmukhD09xDxYPM51
         cuEl8wi7aRlSGoHUy1mC4XWD708kIX9R2FxJHNemJRIb1h51Fry8TQu4LpvRA6NQupOY
         lhQmv5JW46TGtDFazwgyTOJJnVcHGwSaE5WqfqtDIkQWMS1/sSOV5DmEl3rPYpewKaO0
         +shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913870; x=1734518670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rj4+/DACIpjSeTg9MdILDT/uc3SfCIdNJ7zHJVBVUPs=;
        b=sEcDPtc+kulWYObPGpVKNzRkCFe0okvvZBiiX169FL0q8zCifgKCNqe9R6kIRr+9ZH
         s8zaNLHSP4ZJolZx3i8zogD51/IxnhmOAKIm5CQFa2vh9Mx+z80TO3H2+eW2kP91wj9O
         0WjzIKlyu8a77FvYSpo6xMfOBi4ZsNlbaYFrFFiAIFrp57FFhgbub5YaeK+kCzt//s+T
         EPi8kvsLFtqkPWV4sKorQW8CwzIZYU7+eLc9ZhExhjJG7iARyo1jUPvCVwJaPscFXLaS
         bXr2F7+wEu7B246cND4+leoV4zsxslZrFzAXZFeKHcjLrpuB6pX1A5qFG9v1khK0UiFe
         YX1Q==
X-Gm-Message-State: AOJu0YwKxaHzSbNPgub/AvQwLzdziAqsxiHcD/JzyEgDX45rBPSgt7OP
	CK3c9m4J2FP3AJsT+NtCod0L1HZqLGaDM86l7schMzNv5W3SiFHdUVQKDqil51uoHchuNPN6SEX
	03j5yEUlkbCYMMJkmLCJpSNpQ7hE=
X-Gm-Gg: ASbGncuCClky/4ByHgfZiwSAfOr4XfCUp2QgQZU03ZJqAAQ0VxeqWNkdNERul6vp472
	q23VBRsL2qMUvH8GFWt/O++9UVtc+edDWkNrN7nnO
X-Google-Smtp-Source: AGHT+IGaaxxI1jkKd/IKHjrpkHac6rzRPrC7TMJk7HEA7XIxLHUtw3EcIzq46W1sCjYBBLgtdUi1PcTkgTVGdEhWglw=
X-Received: by 2002:a05:6402:26cf:b0:5d0:d06b:cdc4 with SMTP id
 4fb4d7f45d1cf-5d43329c486mr2084666a12.15.1733913870326; Wed, 11 Dec 2024
 02:44:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-6-d4bc37ee860f@gmail.com>
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-6-d4bc37ee860f@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 11 Dec 2024 11:44:18 +0100
Message-ID: <CAP8UFD2zogHD_g5FOVNFvBswPJF749wd4f2s9Pzgef-pv=U0Gg@mail.gmail.com>
Subject: Re: [PATCH 6/7] refs: allow multiple reflog entries for the same refname
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 12:11=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> The reference transaction only allows a update for a given reference to

s/a update/an update/

or: s/a update/a single update/

> avoid conflicts. This, however, isn't an issue for reflogs. There are no
> conflicts to be resolved in reflogs and when migrating reflogs between
> backends we'd have multiple reflog entries for the same refname.


> @@ -1302,6 +1303,7 @@ static int write_transaction_table(struct reftable_=
writer *writer, void *cb_data
>         struct ident_split committer_ident =3D {0};
>         size_t logs_nr =3D 0, logs_alloc =3D 0, i;
>         const char *committer_info;
> +       struct strintmap logs_ts;

Here a comment might help explain what logs_ts is used for.

>         int ret =3D 0;
>
>         committer_info =3D git_committer_info(0);
> @@ -1310,6 +1312,8 @@ static int write_transaction_table(struct reftable_=
writer *writer, void *cb_data
>
>         QSORT(arg->updates, arg->updates_nr, transaction_update_cmp);
>
> +       strintmap_init(&logs_ts, ts);

I am not sure I understand what logs_ts is used for and why its
default value is set to ts.

Also ts is an uint64_t while the second argument to strintmap_init()
is an int. I wonder if it could be an issue especially on 32 bits
platforms.

>         reftable_writer_set_limits(writer, ts, ts);
>
>         for (i =3D 0; i < arg->updates_nr; i++) {
> @@ -1391,6 +1395,7 @@ static int write_transaction_table(struct reftable_=
writer *writer, void *cb_data
>
>                         if (create_reflog) {
>                                 struct ident_split c;
> +                               uint64_t update_index;
>
>                                 ALLOC_GROW(logs, logs_nr + 1, logs_alloc)=
;
>                                 log =3D &logs[logs_nr++];
> @@ -1405,7 +1410,11 @@ static int write_transaction_table(struct reftable=
_writer *writer, void *cb_data
>                                 }
>
>                                 fill_reftable_log_record(log, &c);
> -                               log->update_index =3D ts;
> +
> +                               update_index =3D strintmap_get(&logs_ts, =
u->refname);
> +                               log->update_index =3D update_index;
> +                               strintmap_set(&logs_ts, u->refname, updat=
e_index+1);

s/update_index+1/update_index + 1/

Also is the 'update_index' var really needed or could we just do:

                               log->update_index =3D
strintmap_get(&logs_ts, u->refname);
                               strintmap_set(&logs_ts, u->refname,
log->update_index + 1);

?

>                                 log->refname =3D xstrdup(u->refname);
>                                 memcpy(log->value.update.new_hash,
>                                        u->new_oid.hash, GIT_MAX_RAWSZ);
