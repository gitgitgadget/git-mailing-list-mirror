Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7791494A6
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790903; cv=none; b=efa4SNPD30eabYuHRYeFDvxNlcEYX+4Cp0nRYpj8RJr++1mYMHFeS0XnLNPaU925jKEaPZzN4X11kfP0nF8FepkTstCf2z2hSElNwHURf9KsxoZ0/fRISjjzxK5dTfCQUC1Ms9zB41RPlkGk4O///iLTHJIOOJ2r/lEYXFof4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790903; c=relaxed/simple;
	bh=+NnE+wKdW8EQ0VYLubeXI0gaKFkAYbpJxEX1EOAsDKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feCv2SpLQHrmBSuhX1rCz0N9m1bBZdYZu+1wWhbU95CZrcB1sYBVvK0NNZc5YPQ76rYG6vJyQXmLJECMpuDm2AaogYw/6Tl+gBSeAQG2dCvRXaFnw95N20h3h31VKYN+RMLfRiP8yFflaBjVRJTonUub1NN7Xtv5xaM2KzU0Z4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkyrfaBg; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkyrfaBg"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85da5a3667bso65402539f.1
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 11:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743790901; x=1744395701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI9oGiBYcYakuXMK41Eie2hff7YdfRdHkWTwnprGDpw=;
        b=GkyrfaBgmImWMPq9xbsC3PwhjIZHf4DqytxyWZPnbZSmt1NrZD6eG5Iz46xMo+yc18
         FwyEYnPbJb+B61DFHJkg8XjoCnUFd5xcWIZLaWQzWxJpprqcjUgOlQCnqUAShfEr4vcO
         D4q8N4IlJrI2BuKz9aWs+7uaCzwnr9ERH9+kmmt5MBYgz7Pi5kaE4DwsmFB9sQQ9MvTo
         O3dgz8GGRZvasRD6MxDe8p0Hq0HdFknceEM0WpEciKr1Gyzc/VILgITmWZslBPSvEBJ/
         d31DcBm9Fb6qXe58xQ/T0dx8DOWcAikERny1zwajuivhapK9AHmhKfbEtCzJiUXcC7w8
         C6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743790901; x=1744395701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UI9oGiBYcYakuXMK41Eie2hff7YdfRdHkWTwnprGDpw=;
        b=pyRHIoAVKwBg1uA8nZVAprbRasQwR1OJq95RDtF2pLK7ZCDzGObhk0DwqkeTEN0daZ
         TOVm8uPgeX3PkwO+l+HNlWozb5tsaOIEUQm4XQfSSmT/3V2BoiZpSvhJ5ax7LlNJo3UR
         r5UBQwWchMrzxfVaoDZ8SrPOENAEexSamXXW/W55nifXw1TxFI2Cuv50YOKFWMiXMxpz
         WpNz2BK6bXYTZcww0z2TVD4mKXsEU5nxWTQoQ06Pi7ro4EAmD+yTsUw6omAfp7fq9h82
         8nmYbHdO7/FiiEGQK9ls3IEymBY71yPk6W3VrAOcF9dxTd1k9BwYZ8x3xYA8DD1suE3x
         hAwg==
X-Gm-Message-State: AOJu0Yz1UhSLxWVTMhiixIR4k910wXTvzSmtrKXPsBy5G8y/FQpypZNy
	HxHM5K/7hfHG8l0Jx5Q0WPsSuMWZmCzHyYwHY8xvKc8+0E+7jBY2iMbvYvics7ikMQq35b0tmR9
	1E5InjpdhUrO2oc9qhaxjb2Irfyk=
X-Gm-Gg: ASbGncsA+zYnVhH1wSx4oqWUHqJWFs06Z/TV1LjXG0uc8ImlDJcpvMBKz3IPFWSKAV5
	cotqzWsCGogqBWjf0CVrNg1V7FaeCNiEnqzCrPO1Oh0db0EdyrY0ADnEt38LsmFYDl5uYAcFjNO
	nemrAexobuxgkvbuiHqte0El6DttFtNAoEkM5iLVJHgS1luL2XJHIa4/EhR2g=
X-Google-Smtp-Source: AGHT+IFQO0s5PVnUJ9Yc5sQa0qTnupr4JO2+0i/Ss+qO4Gxwv3xhZrPGX0K1R+26CzgkfDD7O7fV/FuEb9otd6FcLAA=
X-Received: by 2002:a05:6602:3e84:b0:85b:41cc:f709 with SMTP id
 ca18e2360f4ac-8611c3f5521mr538015339f.14.1743790900958; Fri, 04 Apr 2025
 11:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404-b4-pks-packed-backend-seek-with-utf8-v1-1-6ceb694e3bd7@pks.im>
In-Reply-To: <20250404-b4-pks-packed-backend-seek-with-utf8-v1-1-6ceb694e3bd7@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 4 Apr 2025 11:21:28 -0700
X-Gm-Features: ATxdqUErDwDQNrQfhPDOGS_KbWb5e-EKjuaclu4h5DJDg5dA2t2LIZI5cbp4PLo
Message-ID: <CABPp-BEgwBQFgV8-DzuxEA0p7VYjWqnOZ8Aj32gs-Eha9+41ZA@mail.gmail.com>
Subject: Re: [PATCH] refs/packed: fix BUG when seeking refs with UTF-8 characters
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 3:58=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> It was reported that using git-pull(1) in a repository whose remote
> contains branches with emojis leads to the following bug:
>
>     $ git pull
>     remote: Enumerating objects: 161255, done.
>     remote: Counting objects: 100% (55884/55884), done.
>     remote: Compressing objects: 100% (5518/5518), done.
>     remote: Total 161255 (delta 54253), reused 50509 (delta 50364),
>     pack-reused 105371 (from 4)
>     Receiving objects: 100% (161255/161255), 309.90 MiB | 16.87 MiB/s, do=
ne.
>     Resolving deltas: 100% (118048/118048), completed with 13416 local ob=
jects.
>     From github.com:github/github
>        97ab7ae3f3745..8fb2f9fa180ed  master -> origin/master
>     [...snip many screenfuls of updates to origin remotes...]
>     BUG: refs/packed-backend.c:984: packed-refs backend yielded reference
>     preceding its prefix
>     error: fetch died of signal 6
>
> This issue bisects to 22600c04529 (refs/iterator: implement seeking for
> packed-ref iterators, 2025-03-12) where we have implemented seeking for
> the packed-ref iterator. As part of that change we introduced a check
> that verifies that the iterator only returns refnames bigger than the
> prefix. In theory, this check should always hold: when a prefix is set
> we know that we would've seeked that prefix first, so we should never
> see a reference sorting before that prefix.
>
> But in practice the check itself is misbehaving when handling unicode
> characters. The particular issue triggered with a branch that got the
> "shaved ice" unicode character in its name, which is composed of the
> bytes "0xEE 0x90 0xBF". The bug triggers when we compare the refname
> "refs/heads/<shaved-ice>" to something like "refs/heads/z", and it
> specifically hits when comparing the first byte, "0xEE".
>
> The root cause is that the most-significant bit of 0xEE is set. The
> `refname` and `prefix` pointers that we use to compare bytes with one
> another are both pointers to signed characters. As such, when we
> dereference the 0xEE byte the result is a _negative_ value, and this
> value will of course compare smaller than "z".
>
> We can see that this issue is avoided in `cmp_packed_refname()`, where
> we explicitly cast each byte to its unsigned form. Fix the bug by doing
> the same in `packed_ref_iterator_advance()`.
>
> Reported-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> this patch addresses the issue reported by Elijah at [1]. Thanks!

Thanks for the fix!

> Patrick
>
> [1]: <CABPp-BFBqC_t5QSexRQpYsqXBa11WK+OqGt167E=3DK=3Dxod=3DbuQw@mail.gmai=
l.com>
> ---
>  refs/packed-backend.c  |  4 ++--
>  t/t1408-packed-refs.sh | 15 +++++++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index b4289a7d9ce..7e31904bd41 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -980,9 +980,9 @@ static int packed_ref_iterator_advance(struct ref_ite=
rator *ref_iterator)
>                         continue;
>
>                 while (prefix && *prefix) {
> -                       if (*refname < *prefix)
> +                       if ((unsigned char)*refname < (unsigned char)*pre=
fix)
>                                 BUG("packed-refs backend yielded referenc=
e preceding its prefix");
> -                       else if (*refname > *prefix)
> +                       else if ((unsigned char)*refname > (unsigned char=
)*prefix)
>                                 return ITER_DONE;
>                         prefix++;
>                         refname++;

Oh, right, I assumed there was going to be lots of other places that
needed casting outside this function.  If I would have merely checked
the one other line in this function and updated it, I would have had
the fix...

> diff --git a/t/t1408-packed-refs.sh b/t/t1408-packed-refs.sh
> index 41ba1f1d7fc..833477f0fa3 100755
> --- a/t/t1408-packed-refs.sh
> +++ b/t/t1408-packed-refs.sh
> @@ -42,4 +42,19 @@ test_expect_success 'no error from stale entry in pack=
ed-refs' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'list packed refs with unicode characters' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit --no-tag A &&
> +               git update-ref refs/heads/=EE=90=BF HEAD &&
> +               git update-ref refs/heads/z HEAD &&
> +               git pack-refs --all &&
> +               printf "%s commit\trefs/heads/z\n" $(git rev-parse HEAD) =
>expect &&
> +               git for-each-ref refs/heads/z >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
>  test_done
>
> ---
> base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
> change-id: 20250404-b4-pks-packed-backend-seek-with-utf8-668c182ddcf7

I also tested this on my backup of the repo from when I triggered the
error, first making sure that I could still trigger again without this
fix, and then that this fix handled that case.  Works great, thanks!
