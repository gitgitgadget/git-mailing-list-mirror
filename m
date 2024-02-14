Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1454729
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923588; cv=none; b=Q0WlDSuqzocBvjvmnMGv5sgiPygllmyH0a7caT2HK6QcCNHhm/CVoESZE0yVpqO17e2uLv+T//aWgYmrh05gShmeNah0F9otIi7CJ2wjtIe94W92VGIjIwoXNPsqZ9P5AUoAiN9U5dI9TMbq/tlREilx/0itxsfpKLz5Sptge94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923588; c=relaxed/simple;
	bh=DZVPvsrif51NuxD12MRbSRtMOpPvsUdwP3iOHZ2kmqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jl4/tArT2R0vHwUsNrJHV7oIxE7g0f+KMukBQlP57Sv0Vi8moiIcUrNtxRUMEI/bXXpbd/E8GcWlFB6gkbnX/rjjByJONRaBGZHYJ+Ulg+i/u9B5EE/8c85ecHkJByz4HNGugQKaTMK7zi9xwi4SlCj5/3qxMTGThk35HBQ8DPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hafFRlDs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hafFRlDs"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-290fb65531eso1535285a91.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707923586; x=1708528386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w79wKeJG8mYRd8m0r6CB2J1lg+RDREz+y/17LZ+tu28=;
        b=hafFRlDsc8TLk2/jo95SPqzSDTl+kJMGJOfCjFzERolbTxgL4QVUUiRY8RKuorXx41
         CjVORows8GR5suRGHRUoN5i7xGoXNr8nDRwH3PZwPblUvZ865oMDSYLf66wJ9/5wbijb
         Bj0RsuX8fT3VGx8k5odVb53u3mFW7QwhaUjgRkNCpW4cGH8QDeGriPh1nu7xIgVKas8y
         DWuoJe4iWuiUForNLKnCm/uN3ITUaSU8XyaYr0RMT1wvWtExfmE52iMWBbdFWJE+ZopX
         XMA7f7rcimTAyWCoIkMrQAJ5uISvGTWRZZ8BJhgUhkMMoygywFsImeE5UsJ1rT9CVZ4u
         mwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707923586; x=1708528386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w79wKeJG8mYRd8m0r6CB2J1lg+RDREz+y/17LZ+tu28=;
        b=JpyIDemH1QiMv/ZgX7r2Qbw0v9TMI/lBSKu9Xo+lK+zgL7Y59jYrK56wHhjocXpkgk
         n1xma94tsRGVHh8nZSf3B894tZxIoh531jZGVFyk3zu7ZdTqfEnOAv6dP/r8uswGEls3
         PHAAyuIk6xqd7WxrcJzXoOl+6RlxzC15+Vj9pM0p9j5uAEkw3vnC7AfYPDaLLaqqvrnk
         IdMY6x/OEvB+4GiUfiGMnuUfcS+ElE/2rlANQep31kQ/6KV0sUzclLiRTIChLiHIVWin
         eC3RE9RT4eBFhadxcnYu3j8NYM8iE4PpzO4AgQmDnHWJAYjdpRWRhNHrzDJJkH6p8N4r
         ZS6Q==
X-Gm-Message-State: AOJu0YzD1ofiVH54g2W08hrCePcbClcUv8G55FeBNVK4hII108ggz9bN
	uIbXaOrF9H8MUeIiBhpO2XOVIYK1ujzYdCC2C1HoehZEgst5tg40qFTAgi/qRXSEn46ckXSu/F2
	oyHuF1RCQmcGLQVYr+bwiLrKkE+Y=
X-Google-Smtp-Source: AGHT+IGeALb3KytPkp26wHgqEFG9A3jUHztUq33oYzyFr+zIfQbLq7IadxpFsn1xSqHS20vzdtU8bU4ljRgsoZ5Fuv8=
X-Received: by 2002:a17:90a:ea13:b0:298:9dd6:5f3c with SMTP id
 w19-20020a17090aea1300b002989dd65f3cmr2690098pjy.42.1707923585681; Wed, 14
 Feb 2024 07:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703063544.git.ps@pks.im> <cover.1704262787.git.ps@pks.im> <1dc8ddf04a112c38f41d573a48dac3f99b4b51e9.1704262787.git.ps@pks.im>
In-Reply-To: <1dc8ddf04a112c38f41d573a48dac3f99b4b51e9.1704262787.git.ps@pks.im>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Wed, 14 Feb 2024 16:12:54 +0100
Message-ID: <CAOw_e7b72HVQob_hiV0gtRhGWsb=rz40WL=oaV63t7oOmEA-mw@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] reftable/stack: do not overwrite errors when compacting
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good catch!

Sorry for messing this up.

> In the worst case,
> this can lead to a compacted stack that is missing records.

Yeah, that would be an insidious corruption. Have you considered
writing a test to reproduce this (and thus verify that the fix really
fixes the problem?)

I think it wouldn't be too difficult: you could create a custom
blocksource wrapper that returns I/O error on the Nth read, and then
create a reftable with two ref blocks (could just be 2 records if you
use a small blocksize and a large refname) and two log blocks.  Merge
that with an empty table, and see if the compacted result is what you
got in. Loop over N to get coverage for all error paths.

On Wed, Jan 3, 2024 at 7:22=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> In order to compact multiple stacks we iterate through the merged ref
> and log records. When there is any error either when reading the records
> from the old merged table or when writing the records to the new table
> then we break out of the respective loops. When breaking out of the loop
> for the ref records though the error code will be overwritten, which may
> cause us to inadvertently skip over bad ref records. In the worst case,
> this can lead to a compacted stack that is missing records.
>
> Fix the code by using `goto done` instead so that any potential error
> codes are properly returned to the caller.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 16bab82063..8729508dc3 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -801,18 +801,16 @@ static int stack_write_compact(struct reftable_stac=
k *st,
>                         err =3D 0;
>                         break;
>                 }
> -               if (err < 0) {
> -                       break;
> -               }
> +               if (err < 0)
> +                       goto done;
>
>                 if (first =3D=3D 0 && reftable_ref_record_is_deletion(&re=
f)) {
>                         continue;
>                 }
>
>                 err =3D reftable_writer_add_ref(wr, &ref);
> -               if (err < 0) {
> -                       break;
> -               }
> +               if (err < 0)
> +                       goto done;
>                 entries++;
>         }
>         reftable_iterator_destroy(&it);
> @@ -827,9 +825,8 @@ static int stack_write_compact(struct reftable_stack =
*st,
>                         err =3D 0;
>                         break;
>                 }
> -               if (err < 0) {
> -                       break;
> -               }
> +               if (err < 0)
> +                       goto done;
>                 if (first =3D=3D 0 && reftable_log_record_is_deletion(&lo=
g)) {
>                         continue;
>                 }
> @@ -845,9 +842,8 @@ static int stack_write_compact(struct reftable_stack =
*st,
>                 }
>
>                 err =3D reftable_writer_add_log(wr, &log);
> -               if (err < 0) {
> -                       break;
> -               }
> +               if (err < 0)
> +                       goto done;
>                 entries++;
>         }
>
> --
> 2.43.GIT
>


--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
