Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2C62222DD
	for <git@vger.kernel.org>; Wed, 21 May 2025 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747858042; cv=none; b=ngERj+Wro4SkM54rdd22MX1BBd47eiOou1Av49KT7/0gF0pU84MwV4ztbYEtkN8HC7L0j6O9uR3X275w6JfihplF7Ud9wiDOGS1WpCn9qpUqW63Hp8BZqJUA2KdLg1jz89PxSPUIdE8aRrumFyd2ypgvYk7rI770N5qSZkNCIdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747858042; c=relaxed/simple;
	bh=jTtO2+UQre3pJEsLHatlK7EBQbDCVpd9ekI4DZ+3xrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6LDC6GooOuQJZGIkPaXdHz5PFWn6TTYKlGpy1xFVi39CqDM4QLUAAo12+GU9P6sjiGTa8xhDsByj2BVpzaI/u2RXyjVnhyu9KPYLvYnf1JhLdLDh42l9J3JuyxXg/it56yJlUo5aTCXL/HM6DCCAfb7qzQrCXB6Tr70Cc2Yfmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFcDc2g5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFcDc2g5"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-551fe46934eso2417511e87.1
        for <git@vger.kernel.org>; Wed, 21 May 2025 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747858038; x=1748462838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1JGDBXjIpxn23cDWHjleWX8dtL0oi9AMhlBMLYrMbM=;
        b=GFcDc2g52v+FtNtNZiH2LiEmxiyIHVNxkvVxXFxLaWKazURX8shxNP+wI2WDgWYgns
         DFnYs5voovO634ak4c2JWYbcYjtZwCmmx7Y8x2szCslw9v0Ygt7pMU85N5XA6Po5Nhvb
         BXrGkp0tFeqGSK+4481Uh+ah/XxsReYejoBQV7XlbEQqAHUALB7t3JDmHjVrmP7fhiIE
         BOe68U4/h85nKPQjD5ZtZl2L43u/knh0/Q4bKQ1BCbK8uS3yA+zu6CGBKmRkUWn4x97V
         5YLlmDWRacYdafjV1VqeVgRRHYJhGGzui/iBRH+hoKVDSAgbXSH6Ml9wuQGw8psF7Yp8
         pvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747858038; x=1748462838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1JGDBXjIpxn23cDWHjleWX8dtL0oi9AMhlBMLYrMbM=;
        b=rw/PhYBzoGRMLbyRXx69TH+Hw/TMI0TOqLo1yvGNh+14cZDwV/daGlNpM+zhCARxMc
         lex7YBrLmENF1f148q67BPulbtozR/PqIcK7yVqj4kzklCF+fVLV2/HCdm0QEwWIlnnx
         PLu3FzDgP/pUSqa8TUrdBdwgNJn78dOhFj+k0eQv6aA09vfwbVk8rVpMFFjpz1uK7kfe
         tcWJ3IgC+Qsa+Wmf0Z4pjag8NhA0qvJta/ouPAu23ojCrGu89dPBX0F+HaIX8g1SweBw
         MZptv8xpgK2AW7F4Im/EwgV7qWuCbnpC+Qu9XleUYAYfCQnqzjIze86NrgjtD4s+mprn
         TJPw==
X-Forwarded-Encrypted: i=1; AJvYcCVlyT5xQBZ5iBU51arjJcBa5n5P7jba28Pica1LkDASiCpAAVL0RmTjZ2xgJqk3sr2sYTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGE3LYStz1tCX9r3HKueYxlkEHmvBBjxXGKYzpqpYdf+CuzP+
	YDgdROTd163KHXZZHs5T7DEbJ50/IsM59Y1WounNXhFisI10oR64V2nSItwLtck5n9R1tdROq+N
	6Gq7uZYbRPxJ4WTcDcLHaPn7fOPSx1uyhFq/BqYs=
X-Gm-Gg: ASbGncuWQ8HHPDS2EPtMFhmpg6fmwpp2TJTzqwYIVsaaCrRVmPEGnxOaqNkNPXc6mwA
	41XpdKuFRx2bhMwI3N4ZBaeCoDnMBN7WYMGA7BVAcR7d9e9Jykebr3cYwTOZWoRngFO3Ax+5Ee4
	xUegdMXXjYR9fthG6nFRNpPLSxBVYAXz2Epr03zyOm/H2Sz3dZG7N3/352+i4HyOc=
X-Google-Smtp-Source: AGHT+IHFOCv48GUFE+roQYqNvXcjIvlXYmhc3zPq7cP71Wnf654eoAMvrEb8zKGpEC7kFQCCFG2bzmf/KgTdPYv4UTI=
X-Received: by 2002:a05:6512:460c:b0:549:88b8:ccad with SMTP id
 2adb3069b0e04-550e750aeb4mr6605427e87.20.1747858038200; Wed, 21 May 2025
 13:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1970.git.git.1747827645129.gitgitgadget@gmail.com> <9c26d844-6ac5-449b-a5ff-a842ed6ba8b9@gmail.com>
In-Reply-To: <9c26d844-6ac5-449b-a5ff-a842ed6ba8b9@gmail.com>
From: Alex Mironov <alexandrfox@gmail.com>
Date: Wed, 21 May 2025 22:07:04 +0200
X-Gm-Features: AX0GCFsutBTlRIvA6TUFaRCYlKS5nqsvw-aWCAQ5Yo6yeFEXuLaF8X-f3Sc-Mpk
Message-ID: <CAC97EbwMKB5MUD==-6dHuj18OGa--p_UzWw+CsbGTM0iQ8Mw0A@mail.gmail.com>
Subject: Re: [PATCH] name-hash: don't add sparse directories in threaded lazy init
To: Derrick Stolee <stolee@gmail.com>
Cc: Alex Mironov via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Derrick,

Appreciate your quick response! I addressed the nits, and will submit
the new patch shortly.

> This seems to be a performance-only fix

Indeed, and it's more impactful for the specific setup we have inside
our org. In short, we have a custom implementation of the sparse
checkout logic that makes sure to leave files outside of sparse cones
present on disk. Because of this, git with sparse index enabled
frequently resorted to a full index expansion despite
'sparse.expectFilesOutsideOfPatterns=3Dtrue' config set which, I assume,
was only made working with the full index. This problem specifically
was tricky to catch since multithreaded lazy load logic applies only
after a certain limit of objects present in the index.

I hope I will be able to send more patches soon to fix-up bits and
pieces of the 'sparse.expectFilesOutsideOfPatterns' flag with respect
to other expansions. I'm planning to guard those under the same
configuration option, let me know if you think it'd be better to
introduce a new option.


On Wed, May 21, 2025 at 7:17=E2=80=AFPM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> On 5/21/2025 7:40 AM, Alex Mironov via GitGitGadget wrote:
> > From: Alex Mironov <alexandrfox@gmail.com>
> >
> > Similarly to 5f116695864788d1fe45ff06bfad7a71a8d98d0a
>
> nit: we typically use the "reference" style to refer to other
> commits, use 'git log -1 --pretty=3Dreference <oid>' to get output
> like this:
>
>   5f116695864 (name-hash: don't add directories to name_hash, 2021-04-12)
>
> > make sure to avoid placing sparse directories into the name_hash
> > hashtable whenever multithreaded initialization is performed.
> >
> > Sparse directory entries represent a directory that is outside the
> > sparse-checkout definition. These are not paths to blobs, so should not
> > be added to the name_hash table as they must never be queried.
> >
> > Signed-off-by: Alex Mironov <alexandrfox@gmail.com>
> > ---
> >     name-hash: don't add sparse directories in threaded lazy init
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1=
970%2Falexandrfox%2Ffix-threaded-hash-name-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1970=
/alexandrfox/fix-threaded-hash-name-v1
> > Pull-Request: https://github.com/git/git/pull/1970
> >
> >  name-hash.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/name-hash.c b/name-hash.c
> > index d66de1cdfd5..03123a8779a 100644
> > --- a/name-hash.c
> > +++ b/name-hash.c
> > @@ -492,6 +492,9 @@ static void *lazy_name_thread_proc(void *_data)
> >       for (k =3D 0; k < d->istate->cache_nr; k++) {
> >               struct cache_entry *ce_k =3D d->istate->cache[k];
> >               ce_k->ce_flags |=3D CE_HASHED;
> > +             if (S_ISSPARSEDIR(ce_k->ce_mode)) {
> > +                     continue;
> > +             }
>
> nit: for one-line blocks, we usually skip the braces. But I think
> that it might be better to reverse the logic to get something like:
>
>         if (!S_ISSPARSEDIR(ce_k->ce_mode) {
>                 hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_na=
me);
>                 hashmap_add(&d->istate->name_hash, &ce_k->ent);
>         }
>
> This seems to be a performance-only fix, and it might be interesting
> to see if there is any impact on p2000-sparse-operations.sh. Those
> tests don't focus on many sparse-directory entries, so that may not
> demonstrate any meaningful difference.
>
> Thanks,
> -Stolee
>


--=20
Best,
Alex Mironov
