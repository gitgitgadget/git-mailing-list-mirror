Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3C187346
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284041; cv=none; b=hNa8fhT7SGCyFCZTvQFasnEx+TdFuHNUqJEBvLOAVcqaVm4vTxNIOz59FsVquNFWTYHghFWIjHhQofOfxBioAu7T1RJauqNEtc9/79GUB5xB3sEhxxjDBi5f9xIUfcrc+/xnax9er1HmZ3tyhEfLc/9NtbDzT//SjLRfYKU76nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284041; c=relaxed/simple;
	bh=mXwrWEuozPUZQOljYY8NdWcoBgprk+8HAcY5yaGC20Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRR4o51/KpJFZ/IpTYcsPteuj2WuVGVaTaPlzbZsHOfcmO9vBI9UABfukn1kp4Tn9Lgc4gJl9qq0fMYvEQLbafqwtA5jxnhuq4034Z7yHJVnEvqFXObJI6QG3cL4+AL3npp+IocB0NZM7spj1C+4By3SiuP5w8kzy+NqmOTjTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKfdSwua; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKfdSwua"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-65e94e128beso3215465eaf.0
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 22:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768284039; x=1768888839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+zC7UghtAEZAaqVBHzqVDNkG+yJ6e3bfB2FjVJCBVY=;
        b=EKfdSwuaYjNXzigSM1dRdHIVaxQnjpQy03IGXTOp7OiO9E9WvtWeyzy+bEbNtvjnXe
         yKP969tlmqr5LFhIs48diY36g16bR8vZXdsy/ngV2lU2dEVpTumEtX6c3eXiKtKcF3l8
         2zUIbzPTId/158HCDm5V9c/Qv6cT8MKIF6cbKXVuQsY/1Z2K7+/A9ESqx2uaYDMSOzFP
         9rxSxwfCJSdJ4hx1ajhZ2TAqdrzLi7QW89DL13XKa8r+hlmwd+tiSgbzDFHWY3kf70/B
         wi1Oa78kbfSwxOm1BmSKFxx0iyGjKrOtue7oNrsPg6A19ud/jcOxtBHo7HszfOyuZcBe
         mLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768284039; x=1768888839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+zC7UghtAEZAaqVBHzqVDNkG+yJ6e3bfB2FjVJCBVY=;
        b=KMazVcOhoGq1tgFSnhgss4XQ5Lu5gJvdGJlnS3Ha5mhILlx9zjcqKG0T0fmk+RYNP4
         f7h2m20HJUZlsvJ/WKVa9cF4FKWGDIcP+9EN/6hyZuo0xnxiYVeRQXYImidOd48ox1aY
         d/HHjvhI1y2RhfWNBGP3iUGFwnWraGk3S5Wn5NFA63ycNbycv9nWEAjcRyY8Zqd8Kzgu
         3D0KqkGqDcOf5ySjfNHSJEYDbUjmAfNVEW+7BeQVeT2N8s7m4jEkD+5BWm0HoVvLMCh6
         tmAU90qD6i4wzBZur7yf9HL6vAmg8rxXu6YuTXyAtBkIxlfhcdq4YHxdZ9bF4rC/jFNJ
         XTKA==
X-Gm-Message-State: AOJu0Yxursw7J13JbYgmROPMZVGf8REO1heAcJBhYgIL2Jsz4yoyLwke
	QzwR9K/IlMDbA2SLpWKT9YoaKiL/QI7y8GrBtIulCCjpykFpaLcYpZHhmH+uC7Knssrvany4pd6
	D9YsRXKyhrXvpYYHsuBd8hcjp7Vo1xlM=
X-Gm-Gg: AY/fxX4rzN4nlpO3cPqmP6SAooyfqYMh6v2E5SLgojv/gBuN5Oz5iAJljAVeqtsZ6Cr
	BrQWNVcnc38ZhMi0DkIsJwkEwypX0P6xTSEMz7tpDoJo1QT+rGbqZROM7/yjI91cR4/4vB4sH0I
	iVS8rD6ZIVQzEXFYH1w+M+P73gnkObgSINnyqjIrZsRLW4FxGcP47YLA6zo27WgdXOFCTgpRPoz
	SKWFhBrK6wSsHp/SOf20iwl//ad+NpEprhuHxvzfJ2xE5YJnQtcV1BVQ6Bguf2XxC4kIlYs8sva
	ncQr4h8rNlFIswgEeR+teghNG7tH
X-Google-Smtp-Source: AGHT+IGWJEkWsBd4d48spBEmoyxG5fnJFEoloJFXPP92k3+gOzUPRWDx/ECqvYDVKtgZcuYKKkBtgbtt2sUpPwEZCjA=
X-Received: by 2002:a05:6820:160f:b0:659:9a49:8ee9 with SMTP id
 006d021491bc7-660f29f3663mr861816eaf.29.1768284039371; Mon, 12 Jan 2026
 22:00:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im> <20260112-b4-pks-history-builtin-v10-4-e3c6aa5b4cec@pks.im>
In-Reply-To: <20260112-b4-pks-history-builtin-v10-4-e3c6aa5b4cec@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 Jan 2026 22:00:27 -0800
X-Gm-Features: AZwV_QjXCgrbFyGjnh8O-mWxN3lk5zftdxjXr7O0nq11wJW5dJKZifwWR5dsQ1M
Message-ID: <CABPp-BGhtPyiVT=32NXz3k8m=+ZgPziXueM4Y8+g4dAUtN9osw@mail.gmail.com>
Subject: Re: [PATCH v10 4/8] replay: support empty commit ranges
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 6:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> In a subsequent commit we're about to introduce a new user of the replay
> subsystem. With that new user, the range of commits that we'll want to
> replay will be identified implicitly via "HEAD". With such implicit
> ranges it becomes likely that the range of revisions that we're asked to
> replay becomes empty. This case does not make sense with git-replay(1),
> but with the new command it will.

I think I know what you were trying to say, but this feels misleading;
it could be the commit at the tip of any branch, not just HEAD.
Perhaps:

In a subsequent commit we're about to introduce a new user of the replay
subsystem. With that new user, the range of commits that we'll want to
replay will be identified implicitly via a single commit, and will
include all descendants of that commit to any branch. If that commit has
no descendants (because it's the tip of some branch), then the range of
revisions that we're asked to replay becomes empty. This case does not
make sense with git-replay(1), but with the new command it will.

> This case is not currently supported by `replay_revisions()` though
> because we zero-initialize `struct merge_result`. This includes its
> `.clean` member, which indicates whether the merge ran into a conflict
> or not. But given that we don't have any revision to replay, we won't
> ever perform any merge at all, and consequently that member will never
> be set to `1`. We thus later think that there's been a merge conflict
> and return an error from `replay_commits()`.
>
> Address this issue by initializing the `.clean` member to `1`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  replay.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/replay.c b/replay.c
> index 1e660171d2..a8e6d5b30b 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -266,7 +266,9 @@ int replay_revisions(struct rev_info *revs,
>         struct commit *commit;
>         struct commit *onto =3D NULL;
>         struct merge_options merge_opt;
> -       struct merge_result result;
> +       struct merge_result result =3D {
> +               .clean =3D 1,
> +       };
>         char *advance;
>         int ret;
>
> @@ -282,7 +284,6 @@ int replay_revisions(struct rev_info *revs,
>         }
>
>         init_basic_merge_options(&merge_opt, revs->repo);
> -       memset(&result, 0, sizeof(result));
>         merge_opt.show_rename_progress =3D 0;
>         last_commit =3D onto;
>         replayed_commits =3D kh_init_oid_map();
>
> --
> 2.52.0.590.g1f87b77810.dirty

Looks good otherwise; thanks for splitting this out.
