Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D2D1FF7DD
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466409; cv=none; b=somyGjPMxm521p4MxWRSpJhyXrtkc99NjIHqDoTL9P32pRUHE0J4ixDNUk6hip0v/KDgHT2PXLeW0Ud1KCcnFZD0qsU9A+aqJ74wPgINt7TzPATLKcv+3ZsuZsvET+BrL9EAM5YFP7PbFqq79KLVfjTjFrYb7zG1hwScgikJs0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466409; c=relaxed/simple;
	bh=vtQyj/w2gMgPeLAQefxj1n/XCaFhVPdu8+bgZr52smQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7x4rEXiHqS0P7p9uEcNVTv1+7b7r8Mq0pKvoX0oNrshmwaA6vFvc95fdyBz5cu02zvaeNePxCaepaOB/hIs7L+aOS1WChrmw/lo2ExK975eF7ISsj2QYpSdx6k8HcqxsviG+tpDwINyTALOhNY6il8j7eTsxWmcqau0CCNhhew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3DF3HQN; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3DF3HQN"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-855183fdcafso61983139f.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 09:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739466407; x=1740071207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jfpz7wGJe5bzuqMwgf4ZOy6t5XYyNTbKzgm5+gjSFYQ=;
        b=g3DF3HQNyaTu2xgrHHzQ4bFnhPMzj/qrglNk3+FdT1g+Jk3sBZ5PkLWshyKgVpIBFU
         bj/wConPX4TrOOa2hyFLhmVa7/DZvQ3U6v1tlKzRr7QmUrnz2Rcpc1n5RQ5kBwGayvwY
         wPcYVeyOQTtgU7Zo6WkjlVkS0KlCRoIGNEiLuL95Hm5cC7kd8vfQPu/Wxzp/0lzxIPgg
         X/xMiMChIu+kW1GODyt8PpOHA5epOvsT0pI/91vhBTjxzGcdm0GsT8cDbyng4kNS41Xd
         HONwaUny/c+YhqziF8jlFtPi8XGn3U2Ml3jNiQJ4kw45z3B+fTCR6jfF8dMWV5HJiGR0
         5t1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466407; x=1740071207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jfpz7wGJe5bzuqMwgf4ZOy6t5XYyNTbKzgm5+gjSFYQ=;
        b=OmR46hYdTKFFwn2xeZAHl67V2GZ+kvrLkDi4DKM613RH/QHrA1OSjIt8TcNBUQzzeZ
         t0nivIgGPzT3FiSboz66n3gtdqbRdKHmZmwUCNff6fX7gKNg6Wdm7p3wyzthnDKqV6P6
         haiKhA2rzhXbVJbfLaxqXHSBqQZWmMzHOlPOaa+8MyYCXQajSvIbsXZXHCx8U97W7PnJ
         GEuzQdyU9q542xuCIxI4lU9aln4JVIk7Zm8gaKumuZLY7wTNDojwjmmpxN/QvG3fdT/0
         MdPZvGSWHMuYaRrUpvuw/82IVLoV3V48DDqsgxZvvwLoWpZbBPWCE1QIyZlVZg4chHw9
         RevA==
X-Gm-Message-State: AOJu0YzicAq+EQk83pJ27GnzBs3feGafnHhiXfrTGXgy3Qin74EmJqba
	1lHSB/1oxO8BzlPWgbrIbsDOZqkeUFixxCsu/4Kroh/Kak5gdsJG9RmlJi5nCJARzEa04iS+l5z
	/pTR/SkbnNJBkabwAfqXlyCvnzQK1Sg==
X-Gm-Gg: ASbGncuJzz6U85bNFPDikF4mROP4z5jqZw8d0TpwEXFxSZtYtOPDW4SekzY0sCNyh7w
	UlzvCo0B6DD7v4KhN319P5YeWMQAjFjOwn/QLQOM1ZePLikBd8eBxzuOMPP6IrMqM3u85xpzvwU
	jRWTG3B2UslKL/q3S11008n5qSYHq7/w==
X-Google-Smtp-Source: AGHT+IEjl5lSNSirG3Kl2aWig+QC5SBIcBfj004OB2wQO0u1eZx+1ER7jNoGKPka0ITpVq8aM+Tg7MsiE9PEWTk/OFI=
X-Received: by 2002:a05:6e02:1c0b:b0:3d1:5840:1333 with SMTP id
 e9e14a558f8ab-3d18cc3f9d3mr29960275ab.1.1739466407072; Thu, 13 Feb 2025
 09:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211194334.20710-1-meetsoni3017@gmail.com>
 <20250213090040.16133-1-meetsoni3017@gmail.com> <20250213090040.16133-2-meetsoni3017@gmail.com>
In-Reply-To: <20250213090040.16133-2-meetsoni3017@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 13 Feb 2025 09:06:35 -0800
X-Gm-Features: AWEUYZkUujMYqLI2IEky2uXELRJ_5WBlhDb7KAq-qYHe-vOVP0Nufjei1FVRgNg
Message-ID: <CABPp-BHrbvxGsiS_XHswyP5qPRBa39y38bue3CFGb7R7k4xVBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] merge-recursive: optimize time complexity for process_renames
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 1:00=E2=80=AFAM Meet Soni <meetsoni3017@gmail.com> =
wrote:
>
> Avoid O(n^2) complexity in `process_renames()` when building a sorted
> `string_list` by constructing it unsorted and sorting it afterward,
> reducing the complexity to O(n log n).
>
> Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> ---
>  merge-recursive.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 5dfaf32b2c..884ccf99a5 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2758,23 +2758,22 @@ static int process_renames(struct merge_options *=
opt,
>         const struct rename *sre;
>
>         /*
> -        * FIXME: As string-list.h notes, it's O(n^2) to build a sorted
> -        * string_list one-by-one, but O(n log n) to build it unsorted an=
d
> -        * then sort it.  Note that as we build the list, we do not need =
to
> -        * check if the existing destination path is already in the list,
> -        * because the structure of diffcore_rename guarantees we won't
> -        * have duplicates.
> +        * Note that as we build the list, we do not need to check if the
> +        * existing destination path is already in the list, because the
> +        * structure of diffcore_rename guarantees we won't have duplicat=
es.
>          */
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
>
>         for (i =3D 0, j =3D 0; i < a_renames->nr || j < b_renames->nr;) {
>                 struct string_list *renames1, *renames2Dst;
> --
> 2.34.1

This version looks good to me.
