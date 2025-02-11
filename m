Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB362641CA
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307580; cv=none; b=EtS/CglJlJdbxnymfeDeR3IBjpD0KLRfi/nAEJudpVe3hTIc/3XsmBAr69f1PVEL6WM3mgYa6aMFjP85rKO3z1BZ9NHZXrCyiD/c/zuI/cXzIUmecqtuEqt2qxcF6eETNd0Do1IcLzXi8PvxCL30y6pcRiHusZZwHoJ7HvlP11w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307580; c=relaxed/simple;
	bh=oxl9VMCPfop3XrbE4X65AUpCzB6nb8k+35GPyYZKH3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNrw5X8tJevJaA08V/wSq+ZA/tDMg3cfd3l0L8aZpHrYAB6tpYHX/S1Cc4D4xCLSCLvJ4GA2w8J7Sr297m+D34FGpP+c8MfoChmJ+sXjBmRMNwHPVP1ajap3NSSYnKzPxHH0Y7/1UIPcbNdMpOo4pyB2U5jnw79LNQCf8v2o2qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpKASPAB; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpKASPAB"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8551c57cb8aso81572339f.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 12:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739307577; x=1739912377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/kZqX78ho9ypYoC9wcXCLnPlqyHB+iCjaq6KdZzn4U=;
        b=FpKASPABMsKUwrabY/6DbOtiE7yA8E8QcGA689kQHWvT9HmDsTJfnBinV2hzYMfYYB
         +yut7kVqvVQQO79yy2OpAdNv08D7TNV7nSFaL+AelIxRyVrpu/858g//zs/krm4JtDSk
         Uz8D7KAeuOcIM4IccAu6bLi3UL8nQZXbLj3SRxXnQiDvMt7PUMmPghmrz6NE+GgJmZJ2
         2NGTsO/X0AY9Lcl0TGGI88mWiE6hbIY8DT03pRsOcWUpmB/VVRlEPswsKTrIgyswwHwV
         CGLcYPRuhy/1yG25pG+7u57u5g9n+KJJ0cqhwGUtHcwpP/tsvrkdkmhBkzX8JRx56KgE
         Sr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739307577; x=1739912377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/kZqX78ho9ypYoC9wcXCLnPlqyHB+iCjaq6KdZzn4U=;
        b=hfCcgfdgj0NYXHmTa1mZKPi0GS4hwnA5Ys2LnAENAqrZkr2lBRZb3+L4SFiEsy6CCz
         r36oxrIfmKGrcuhRx1giBeKrjAwuRs0mO5jzGPzuN/s5UPM8EIJZbXmIwNn9tv2NS8YT
         LHG5XJbk+hv89sHjL79E2y1bvps3wWYZdo6Qs3k2HGjtsyvUzcq5WWJ51vIcB/DI4oQ2
         4G1UNhH7oKwxkLieSREhaKytc65FUl+d4LczmyIMHPR43QSYvMai+ZsQA5V+ZqOyw9GF
         LReDScH+U/kCm9KpcsYacMsr3PvRHreVBkD9T003WBzmLrKVO0EmslZgWbGqx23o0g8T
         1EfA==
X-Gm-Message-State: AOJu0YwoOoiViItio7GSr/SULAnKuC3k5wUghVkWuqrdKTt96MzMy7Fa
	xzuXNwXLXZKdAa40w+t7O8vrl82pZI6wRgGMOKy7yrZeMa44Pl4Y99jaFtx1tCLh0QcXKXsDfE5
	vEyavECg61ptJXbqI80ZFUeCNqyk=
X-Gm-Gg: ASbGnctroxASycKLsfJPD+GveZZAMyzINTwrRHoP0dAGqN30OCXQ7GmGni24Y2Fo3lr
	0Y/Q6v8Thesre/oho7SQj+IgK2vKAO8iCKSvftfBkmsw9n550URXeLFw/+ZoY0CBVlOkSPhuPT4
	llYCR/kCkdEgwHRT1/hvy5KDWoe2kq
X-Google-Smtp-Source: AGHT+IF+OQHudcOmIsly2L9rBLzGIQ9f8eTYWL0ameS6Mf/UUwGJu7sIkOrt4J6POxaShzysepdCt/qSh70Q7VBIPEI=
X-Received: by 2002:a05:6e02:19cb:b0:3d0:2331:f809 with SMTP id
 e9e14a558f8ab-3d17be0ce1amr8699305ab.2.1739307577456; Tue, 11 Feb 2025
 12:59:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211194334.20710-1-meetsoni3017@gmail.com>
In-Reply-To: <20250211194334.20710-1-meetsoni3017@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 11 Feb 2025 12:59:26 -0800
X-Gm-Features: AWEUYZksGkXRFSEZc8092D0Li2VNFl0XEy3Z1N_0qp2hJP5astRLNw8_Otti09M
Message-ID: <CABPp-BHMgTX2J4pRM=DjU-Ye46JtVZJsi95VUqcPHTcrzJgwOg@mail.gmail.com>
Subject: Re: [GSoC][PATCH] merge-recursive: optimize string_list construction
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 11:43=E2=80=AFAM Meet Soni <meetsoni3017@gmail.com>=
 wrote:
>
> Avoid O(n^2) complexity when building a sorted `string_list` by
> constructing it unsorted and sorting it afterward, reducing the
> complexity to O(n log n).

I'm tempted to say merge-recursive.[ch] is nearly dead and planned for
removal, so there's not much value in messing with it, but...it's not
dead yet, so I guess this is worthwhile.

> Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> ---
>  merge-recursive.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 5dfaf32b2c..c43b79e6ef 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2757,24 +2757,18 @@ static int process_renames(struct merge_options *=
opt,
>         struct string_list b_by_dst =3D STRING_LIST_INIT_NODUP;
>         const struct rename *sre;
>
> -       /*
> -        * FIXME: As string-list.h notes, it's O(n^2) to build a sorted
> -        * string_list one-by-one, but O(n log n) to build it unsorted an=
d
> -        * then sort it.  Note that as we build the list, we do not need =
to
> -        * check if the existing destination path is already in the list,
> -        * because the structure of diffcore_rename guarantees we won't
> -        * have duplicates.
> -        */
>         for (i =3D 0; i < a_renames->nr; i++) {
>                 sre =3D a_renames->items[i].util;
> -               string_list_insert(&a_by_dst, sre->pair->two->path)->util
> +               string_list_append(&a_by_dst, sre->pair->two->path)->util
>                         =3D (void *)sre;
>         }
>         for (i =3D 0; i < b_renames->nr; i++) {
>                 sre =3D b_renames->items[i].util;
> -               string_list_insert(&b_by_dst, sre->pair->two->path)->util
> +               string_list_append(&b_by_dst, sre->pair->two->path)->util
>                         =3D (void *)sre;
>         }
> +       string_list_sort(&a_by_dst);
> +       string_list_sort(&b_by_dst);

If the original source had duplicates, this would change behavior (the
insert function checks for duplicates while append does not).
Granted, the comment above the block points out why there aren't
duplicates, but will that be obvious to future readers now that you've
removed the whole comment?

Also, are the sources already sorted?  If so, we can avoid the manual
sort calls at the end, and drop this from O(n log n) to O(n).  Digging
through the code...it appears these are setup in get_renames() and are
sorted but by pair->one->path rather than pair->two->path, so we do
need the sorts here.

Of course, get_renames() itself utilizes string_list_insert() rather
than string_list_append. and there are a number of other
string_list_insert calls in the code (though some of the others might
be hard to restructure) -- perhaps the first line of your commit
message should have a "in process_renames" qualifier, since it's only
addressing one case?

Anyway, other than perhaps tweaking the first line of the commit
message, and not removing the whole comment, the patch looks good to
me.
